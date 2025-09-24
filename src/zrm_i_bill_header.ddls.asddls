@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Entity of Billing Header'
@Metadata.ignorePropagatedAnnotations: true
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity ZRM_I_BILL_HEADER
  as select from zrm_bill_header

  composition [0..*] of ZRM_I_BILL_ITEM    as _Billitem

  association [0..1] to ZRM_I_BILL_TYPE_VH as _BillType on $projection.BillType = _BillType.value_low
  association [0..1] to /DMO/I_Customer    as _Customer on $projection.CustomerId = _Customer.CustomerID
  association [0..1] to I_Currency         as _Currency on $projection.Currency = _Currency.Currency

{
  key bill_id            as BillId,
      bill_type          as BillType,
      bill_date          as BillDate,
      customer_id        as CustomerId,
      @Semantics.amount.currencyCode: 'currency'
      net_amount         as NetAmount,
      currency           as Currency,
      sales_org          as SalesOrg,
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

      _Billitem,
      _BillType,
      _Customer,
      _Currency
}
