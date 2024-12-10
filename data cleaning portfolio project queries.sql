
--cleaning data in squel queries[nashvile housing]


select *
from dbo.NashvilleHousing



--populate property address data

select propertyaddress
from dbo.NashvilleHousing
where propertyaddress is null


select a.parcelid, a.propertyaddress, b.parcelid, b.propertyaddress, isnull(a.propertyaddress,b.propertyaddress)
from [dbo].[NashvilleHousing] a
join  [dbo].[NashvilleHousing] b
on a. parcelid = b.parcelid
and a.uniqueid <> b.uniqueid
where a.propertyaddress is null

update a
set propertyaddress = isnull(a.propertyaddress,b.propertyaddress)
from [dbo].[NashvilleHousing] a
join  [dbo].[NashvilleHousing] b
on a. parcelid = b.parcelid
and a.uniqueid <> b.uniqueid
where a.propertyaddress is null


--breaking out address into individual column (address,city, state)


select propertyaddress
from [dbo].[NashvilleHousing]


select
substring(propertyaddress, 1, charindex(',', propertyaddress)-1) as address,
substring(propertyaddress, charindex(',', propertyaddress) +1, len(propertyaddress)) as address
from [dbo].[NashvilleHousing]


alter table nashvillehousing
add propertysplitaddress nvarchar(255)

update nashvillehousing
set propertysplitaddress = substring(propertyaddress, 1, charindex(',', propertyaddress)-1)


alter table nashvillehousing
add propertysplitcity nvarchar(255)

update nashvillehousing
set propertysplitcity = substring(propertyaddress, charindex(',', propertyaddress) +1, len(propertyaddress)) 



select *
from dbo.NashvilleHousing


select owneraddress
from dbo.NashvilleHousing

select
alter table nashvillehousing
add propertysplitaddress nvarchar(255)

update nashvillehousing
set propertysplitaddress = substring(propertyaddress, 1, charindex(',', propertyaddress)-1)


alter table nashvillehousing
add propertysplitcity nvarchar(255)

update nashvillehousing
set propertysplitcity = substring(propertyaddress, charindex(',', propertyaddress) +1, len(propertyaddress)) 


select
parsename(replace(owneraddress, ',', '.'), 3)
,parsename(replace(owneraddress, ',', '.') ,2)
,parsename(replace(owneraddress, ',', '.') , 1)
from nashvillehousing


alter table nashvillehousing
add ownersplitaddress nvarchar(255)

update nashvillehousing
set ownersplitaddress = parsename(replace(owneraddress, ',', '.'), 3)


alter table nashvillehousing
add ownersplitcity  nvarchar(255)

update nashvillehousing
set ownersplitcity = parsename(replace(owneraddress, ',', '.') ,2)


alter table nashvillehousing
add ownersplitstate nvarchar(255)

update nashvillehousing
set ownersplitstate = parsename(replace(owneraddress, ',', '.') , 1)



select *
from dbo.NashvilleHousing



select distinct(soldasvacant),count(soldasvacant)
from dbo.NashvilleHousing
group by soldasvacant


--remove duplicates

with rownumcte As(
select*,
       row_number() over(
	   partition by parcelid,
	                propertyaddress,
	                legalreference,
	                saledate,
					saleprice
					order by
					uniqueid
					) row_num
from dbo.nashvillehousing
)
select*
from rownumCTE
where row_num > 1
ORDER BY propertyaddress


--delete unused columns

select*
from dbo.nashvillehousing

alter table dbo.nashvillehousing
drop column owneraddress,taxdistrict,propertyaddress

alter table dbo.nashvillehousing
drop column saledate