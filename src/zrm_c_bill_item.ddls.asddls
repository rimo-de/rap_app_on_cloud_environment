@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection for Billing Document Item'
@Metadata.ignorePropagatedAnnotations: false
@Metadata.allowExtensions: true
define view entity ZRM_C_BILL_ITEM
  as projection on ZRM_I_BILL_ITEM
{
  key BillId,
  key ItemNo,
      MaterialId,
      Description,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      Quantity,
      @Semantics.amount.currencyCode: 'Currency'
      ItemAmount,
      Currency,
      Uom,
      Createdby,
      Createdat,
      Lastchangedby,
      Lastchangedat,
      Locallastchangedat,
      /* Associations */
      _BillHeader : redirected to parent ZRM_C_BILL_HEADER
}
