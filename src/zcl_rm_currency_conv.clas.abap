CLASS zcl_rm_currency_conv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.
    INTERFACES if_oo_adt_classrun.

    CLASS-METHODS convert_currency AMDP OPTIONS CDS SESSION CLIENT DEPENDENT
      IMPORTING VALUE(iv_amount)               TYPE /dmo/total_price
                VALUE(iv_currency_code_source) TYPE /dmo/currency_code
                VALUE(iv_currency_code_target) TYPE /dmo/currency_code
                VALUE(iv_exchange_rate_date)   TYPE d
      EXPORTING VALUE(ev_amount)               TYPE /dmo/total_price.
ENDCLASS.



CLASS zcl_rm_currency_conv IMPLEMENTATION.


  METHOD convert_currency  BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY.
    tab = SELECT CONVERT_CURRENCY( amount         => :iv_amount,
                                   source_unit    => :iv_currency_code_source,
                                   target_unit    => :iv_currency_code_target,
                                   reference_date => :iv_exchange_rate_date,
                                   schema         => CURRENT_SCHEMA,
                                   error_handling => 'set to null',
                                   steps          => 'shift,convert,shift_back',
                                   client         => SESSION_CONTEXT( 'CLIENT' )
                                ) AS target_value
              FROM dummy ;
    ev_amount = :tab.target_value[1];
  ENDMETHOD.
  METHOD if_oo_adt_classrun~main.

    zcl_rm_currency_conv=>convert_currency( EXPORTING iv_amount = 100
                                                      iv_currency_code_source = 'USD'
                                                      iv_currency_code_target = 'USD'
                                                      iv_exchange_rate_date   = cl_abap_context_info=>get_system_date( )
                                            IMPORTING ev_amount = DATA(lv_converted_amount)  ).

    out->write( EXPORTING data = |Currency Conversion from USD to EUR is | && lv_converted_amount ).


  ENDMETHOD.

ENDCLASS.
