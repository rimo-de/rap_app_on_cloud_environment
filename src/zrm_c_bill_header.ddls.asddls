@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection for Billing Document Header'
@Metadata.ignorePropagatedAnnotations: false
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'BillId']

define root view entity ZRM_C_BILL_HEADER
  provider contract transactional_query
  as projection on ZRM_I_BILL_HEADER
{

  key BillId,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZRM_I_BILL_TYPE_VH', element: 'text' } }]
      @ObjectModel.text.element: ['BillTypeText']
      BillType,
      @Semantics.text: true
      _BillType.text      as BillTypeText,
      BillDate,
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Customer', element: 'CustomerID' } }]
      @ObjectModel.text.element: ['CustomerName' ]
      CustomerId,
      _Customer.FirstName as CustomerName,
      @Semantics.amount.currencyCode: 'Currency'
      NetAmount,
      @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
      Currency,
      SalesOrg,
      Createdby,
      Createdat,
      Lastchangedby,
      Lastchangedat,
      Locallastchangedat,
      _Billitem : redirected to composition child ZRM_C_BILL_ITEM
}
