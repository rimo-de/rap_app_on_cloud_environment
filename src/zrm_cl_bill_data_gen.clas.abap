CLASS zrm_cl_bill_data_gen DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS generate_hdr.
    METHODS generate_item.
ENDCLASS.

CLASS zrm_cl_bill_data_gen IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    generate_hdr( ).
    out->write( 'Billing data is inserted' ).

    generate_item( ).
    out->write( 'Billing item data is inserted' ).

  ENDMETHOD.
  METHOD generate_hdr.
    DATA lt_bill_header TYPE STANDARD TABLE OF zrm_bill_header.

    DELETE FROM zrm_bill_header.

    GET TIME STAMP FIELD DATA(lv_timestampl).

    lt_bill_header = VALUE #(
      ( client = sy-mandt bill_id = '1000000001' bill_type = 'F2' bill_date = '20250401' customer_id = '100001' net_amount = '1500.00' currency = 'INR' sales_org = '1000' createdby = sy-uname createdat = lv_timestampl lastchangedby = sy-uname
        lastchangedat = lv_timestampl locallastchangedat = lv_timestampl )
      ( client = sy-mandt bill_id = '1000000002' bill_type = 'F2' bill_date = '20250402' customer_id = '100002' net_amount = '2500.00' currency = 'INR' sales_org = '1000' createdby = sy-uname createdat = lv_timestampl lastchangedby = sy-uname
        lastchangedat = lv_timestampl locallastchangedat = lv_timestampl )
      ( client = sy-mandt bill_id = '1000000003' bill_type = 'F8' bill_date = '20250403' customer_id = '100003' net_amount = '1800.00' currency = 'USD' sales_org = '2000' createdby = sy-uname createdat = lv_timestampl lastchangedby = sy-uname
        lastchangedat = lv_timestampl locallastchangedat = lv_timestampl )
      ( client = sy-mandt bill_id = '1000000004' bill_type = 'F2' bill_date = '20250404' customer_id = '100004' net_amount = '3000.00' currency = 'EUR' sales_org = '3000' createdby = sy-uname createdat = lv_timestampl lastchangedby = sy-uname
        lastchangedat = lv_timestampl locallastchangedat = lv_timestampl )
      ( client = sy-mandt bill_id = '1000000005' bill_type = 'F2' bill_date = '20250405' customer_id = '100005' net_amount = '2200.00' currency = 'INR' sales_org = '1000' createdby = sy-uname createdat = lv_timestampl lastchangedby = sy-uname
        lastchangedat = lv_timestampl locallastchangedat = lv_timestampl )
    ).

    INSERT zrm_bill_header FROM TABLE @lt_bill_header.
  ENDMETHOD.

  METHOD generate_item.

    DATA lt_bill_item TYPE STANDARD TABLE OF zrm_bill_item.

    DELETE FROM zrm_bill_item.

    GET TIME STAMP FIELD DATA(lv_timestampl).

    lt_bill_item = VALUE #(
      ( client = sy-mandt bill_id = '1000000001' item_no = '000001' material_id = 'MAT001' description = 'USB Cable'      quantity = '2.000' item_amount = '500.00'  currency = 'INR' uom = 'EA' createdby = sy-uname createdat = lv_timestampl
      lastchangedby = sy-uname lastchangedat = lv_timestampl locallastchangedat = lv_timestampl )
      ( client = sy-mandt bill_id = '1000000001' item_no = '000002' material_id = 'MAT002' description = 'Charger'        quantity = '1.000' item_amount = '1000.00' currency = 'INR' uom = 'EA' createdby = sy-uname createdat = lv_timestampl
      lastchangedby = sy-uname lastchangedat = lv_timestampl locallastchangedat = lv_timestampl )

      ( client = sy-mandt bill_id = '1000000002' item_no = '000001' material_id = 'MAT003' description = 'Headphones'     quantity = '1.000' item_amount = '2500.00' currency = 'INR' uom = 'EA' createdby = sy-uname createdat = lv_timestampl
      lastchangedby = sy-uname lastchangedat = lv_timestampl locallastchangedat = lv_timestampl )

      ( client = sy-mandt bill_id = '1000000003' item_no = '000001' material_id = 'MAT004' description = 'Keyboard'       quantity = '1.000' item_amount = '800.00'  currency = 'USD' uom = 'EA' createdby = sy-uname createdat = lv_timestampl
      lastchangedby = sy-uname lastchangedat = lv_timestampl locallastchangedat = lv_timestampl )
      ( client = sy-mandt bill_id = '1000000003' item_no = '000002' material_id = 'MAT005' description = 'Mouse'          quantity = '2.000' item_amount = '1000.00' currency = 'USD' uom = 'EA' createdby = sy-uname createdat = lv_timestampl
      lastchangedby = sy-uname lastchangedat = lv_timestampl locallastchangedat = lv_timestampl )

      ( client = sy-mandt bill_id = '1000000004' item_no = '000001' material_id = 'MAT006' description = 'Monitor'        quantity = '1.000' item_amount = '3000.00' currency = 'EUR' uom = 'EA' createdby = sy-uname createdat = lv_timestampl
      lastchangedby = sy-uname lastchangedat = lv_timestampl locallastchangedat = lv_timestampl )

      ( client = sy-mandt bill_id = '1000000005' item_no = '000001' material_id = 'MAT007' description = 'Webcam'         quantity = '1.000' item_amount = '2200.00' currency = 'INR' uom = 'EA' createdby = sy-uname createdat = lv_timestampl
      lastchangedby = sy-uname lastchangedat = lv_timestampl locallastchangedat = lv_timestampl )
    ).

    INSERT zrm_bill_item FROM TABLE @lt_bill_item.

  ENDMETHOD.

ENDCLASS.
