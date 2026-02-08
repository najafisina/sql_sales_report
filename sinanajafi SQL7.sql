select top 20 *
from sepidar01.FMk.[User]
go


select top 20 *
from sepidar01.fmk.ExtraData
go

select top 50 *
from sepidar01.sls.Invoice
go

select top 20 *
from sepidar01.sls.InvoiceItem
go


select top 20 *
from sepidar01.sls.SaleType
go

select top 20 *
from sepidar01.INV.Unit
go

select top 50 *
from sepidar01.INV.Item
go



with
cte01
as
(select 
si.[Date] as invoiceDate,
i.Quantity as quantity,
i.NetPrice as netprice, 
s.SaleTypeId as SaleTypeId, 
s.Title as salesTypeName, 
ii.ItemID as prodid,
ii.Title as productName ,
iu.UnitID as unitId ,
iu.Title as unitName,
u.[Name] as sellerName ,
u.UserID as sellerId
from sepidar01.sls.InvoiceItem as i
join
sepidar01.sls.invoice as si
on i.InvoiceRef = si.InvoiceId
left join
sepidar01.sls.SaleType as s
on s.SaleTypeId = si.SaleTypeRef
left join
sepidar01.FMK.[User] as u
on u.UserID = si.Creator
left join
sepidar01.INV.Item as ii 
on ii.ItemID = i.ItemRef
left join
sepidar01.inv.Unit as iu
on iu.UnitID = ii.UnitRef)
select
invoiceDate,sellerId,sellerName,prodid,productName,max(unitId) as UnitId ,max(unitName) as UnitName ,SaleTypeId,salesTypeName
, sum(quantity) as TotalQuantity , sum(netprice) as TotalNetSales
from cte01
group by 
invoiceDate,sellerId,sellerName,productName,prodid,salesTypeName,SaleTypeId
go
