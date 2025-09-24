@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Billing Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZRM_I_BILL_ITEM
  as select from zrm_bill_item
  association to parent ZRM_I_BILL_HEADER as _BillHeader on $projection.BillId = _BillHeader.BillId
{
  key bill_id            as BillId,
  key item_no            as ItemNo,
      material_id        as MaterialId,
      description        as Description,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      quantity           as Quantity,
      @Semantics.amount.currencyCode: 'Currency'
      item_amount        as ItemAmount,
      currency           as Currency,
      uom                as Uom,
      @Semantics.user.createdBy: true
      createdby          as Createdby,
      @Semantics.systemDateTime.createdAt: true
      createdat          as Createdat,
      @Semantics.user.lastChangedBy: true
      lastchangedby      as Lastchangedby,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat      as Lastchangedat,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchangedat as Locallastchangedat,
      _BillHeader // Make association public
}
