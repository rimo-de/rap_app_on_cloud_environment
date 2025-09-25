CLASS lhc_billitem DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS calculate_net_amount FOR DETERMINE ON SAVE
      IMPORTING keys FOR BillItem~calculate_net_amount.

    METHODS check_currency FOR VALIDATE ON SAVE
      IMPORTING keys FOR BillItem~check_currency.

ENDCLASS.

CLASS lhc_billitem IMPLEMENTATION.

  METHOD calculate_net_amount.

    DATA: billing_ids TYPE STANDARD TABLE OF zrm_i_bill_header WITH UNIQUE HASHED KEY key COMPONENTS BillId.

    billing_ids = CORRESPONDING #( keys DISCARDING DUPLICATES MAPPING BillId = BillId ).

    MODIFY ENTITIES OF zrm_i_bill_header IN LOCAL MODE
      ENTITY BillHeader
        EXECUTE recalculate_net_amount
        FROM CORRESPONDING #( billing_ids ).

  ENDMETHOD.

  METHOD check_currency.

    READ ENTITIES OF zrm_i_bill_header IN LOCAL MODE
      ENTITY Billitem
       ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT DATA(lt_billing_items).

    LOOP AT lt_billing_items ASSIGNING FIELD-SYMBOL(<fs_billing_items>).

      IF <fs_billing_items>-Currency NE 'EUR'.
        APPEND VALUE #(  %tky = <fs_billing_items>-%tky ) TO failed-billitem.

        APPEND VALUE #(  %tky              = <fs_billing_items>-%tky
                         %element-Currency = if_abap_behv=>mk-on
                         %msg              = NEW zcl_rm_billing_exceptions( currency_code = <fs_billing_items>-Currency
                                                                            textid        = zcl_rm_billing_exceptions=>currency_not_valid
                                                                            severity      = if_abap_behv_message=>severity-error )
                      ) TO reported-billitem.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZRM_I_BILL_HEADER DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR BillHeader RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR BillHeader RESULT result.

    METHODS recalculate_net_amount FOR MODIFY
      IMPORTING keys FOR ACTION BillHeader~recalculate_net_amount.

    METHODS earlynumbering_cba_Billitem FOR NUMBERING
      IMPORTING entities FOR CREATE BillHeader\_Billitem.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE BillHeader.

ENDCLASS.

CLASS lhc_ZRM_I_BILL_HEADER IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD recalculate_net_amount.

    TYPES : BEGIN OF ty_amounts,
              amount   TYPE zrm_net_amount,
              currency TYPE waers,
            END OF ty_amounts,
            ty_t_amounts TYPE STANDARD TABLE OF ty_amounts.

    DATA: lt_amounts TYPE ty_t_amounts.

    READ ENTITIES OF zrm_i_bill_header IN LOCAL MODE
         ENTITY BillHeader
            FIELDS ( NetAmount )
            WITH CORRESPONDING #( keys )
         RESULT DATA(lt_bill_header).

    READ ENTITIES OF zrm_i_bill_header IN LOCAL MODE
      ENTITY BillHeader BY \_Billitem
        FIELDS ( ItemAmount Currency )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_item_data).
    CHECK lt_item_data IS NOT INITIAL.

    LOOP AT lt_item_data ASSIGNING FIELD-SYMBOL(<fs_item_data>).

      IF <fs_item_data>-Currency NE 'EUR'.
        zcl_rm_currency_conv=>convert_currency( EXPORTING iv_amount               = CONV #( <fs_item_data>-ItemAmount )
                                                          iv_currency_code_source = <fs_item_data>-Currency
                                                          iv_currency_code_target = 'EUR'
                                                          iv_exchange_rate_date   = cl_abap_context_info=>get_system_date( )
                                                IMPORTING ev_amount               = DATA(amount_in_target_currency) ).
      ELSE.
        amount_in_target_currency = <fs_item_data>-ItemAmount.
      ENDIF.

      COLLECT VALUE ty_amounts( amount = amount_in_target_currency   currency = 'EUR' ) INTO lt_amounts.
    ENDLOOP.

    READ TABLE lt_bill_header ASSIGNING FIELD-SYMBOL(<fs_bill_header>) INDEX 1.
    IF <fs_bill_header> IS ASSIGNED.
      <fs_bill_header>-NetAmount = lt_amounts[ 1 ]-amount.
      <fs_bill_header>-Currency  = lt_amounts[ 1 ]-currency.
    ENDIF.

    MODIFY ENTITIES OF zrm_i_bill_header IN LOCAL MODE
      ENTITY BillHeader
        UPDATE FIELDS ( NetAmount Currency )
        WITH CORRESPONDING #( lt_bill_header ).

  ENDMETHOD.

  METHOD earlynumbering_create.

    SELECT MAX( bill_id ) FROM zrm_bill_header INTO @DATA(lv_billing_id).

    LOOP AT entities INTO DATA(ls_billing_header).

      IF ls_billing_header-BillId IS INITIAL AND ls_billing_header-%is_draft EQ if_abap_behv=>mk-on.
        ls_billing_header-BillId = lv_billing_id + 1.
        APPEND CORRESPONDING #( ls_billing_header ) TO mapped-billheader.
      ELSE.
        APPEND CORRESPONDING #( ls_billing_header ) TO mapped-billheader.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.

  METHOD earlynumbering_cba_Billitem.

    LOOP AT entities INTO DATA(ls_billing).
      LOOP AT ls_billing-%target INTO DATA(ls_billing_item).
        IF ls_billing_item-ItemNo IS INITIAL AND ls_billing_item-%is_draft EQ if_abap_behv=>mk-on.

          SELECT MAX( item_no ) FROM zrm_bill_item WHERE bill_id EQ @ls_billing_item-BillId INTO @DATA(lv_billing_item_id).
          ls_billing_item-ItemNo = lv_billing_item_id + 1.
          APPEND CORRESPONDING #( ls_billing_item ) TO mapped-billitem.
        ELSE.
          APPEND CORRESPONDING #( ls_billing_item ) TO mapped-billitem.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
