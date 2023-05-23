
select UPPER( Title) Title , count(*) FROM TRRTOUT ---REPLACE (Title, '*','')
group by UPPER( Title)
Order by Title asc
Go


select * from BMSubType a 
          join TRRTOuT  t on t.Title = a.Title
		  Where SubTypeID in (

		  Select SubTypeID from BMComptaDocDetails
		  UNION
		  Select SubTypeID from BMExpense
		  )
Go

select * from BMSubType
where title like '%FRAFT%'

--INSERT INTO TRRTOUT (Title)
-- select F1 from TRRConserver
-- UNION
-- select F1 from TRRListefournieDPMGS
--Go
--select * from TRRRetirer
--Go

--- Detection de doublons simple
select Title , count(title), Min(subtypeID), Max(subtypeID) from BMSubType
group by Title
having  count(title) > 1

--- Les originaux
select * from BMSubType a
where a.SubTypeID in (1501,
209,1348,363,1260,11762,779,1055,1057, 1154, 1155, 1156)