USE [BudgetManagement2]
GO

/****** Object:  View [dbo].[V_ExpenseMissionPrimeData]    Script Date: 14/02/2022 12:45:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[V_ReportBCDetails]
AS
SELECT    cd.PeriodID,  CS.ComptaDocDetailsID, CD.Created,
                             (SELECT        MAX(EffectiveDate) AS Expr1
                               FROM            dbo.BMTaches AS Tchs
                               WHERE        (ParentID = CD.ComptaDocsID) AND (Parent = 'BC') AND (Status IN (4, 3))) AS LastTaskValidation, PS.FullName AS CreatedBy, CD.NOOPER, CD.Title, CD.ProjetID, CD.ProviderID, 
                         CD.CentreBudgetaireEntityID AS CentreBudgetaireID, CD.CentreBudgetaireEntityLibelle AS CentreBudgetaire, CD.ServiceDemandeurLibelle AS ServiceDemandeur, BP.Title AS Provider, CD.Reference AS bc_REF, 
                        CONVERT(varchar(5), CD.Status) AS Status,
                             (SELECT        Title
                               FROM            dbo.BMProject
                               WHERE        (ProjetID = CD.ProjetID)) AS Project, CD.Description AS Commentaire, Ty.TypeID AS art_LignebudgId, Ty.Title AS art_Lignebudg, ST.Title AS articles, ST.Account AS art_Compte, CS.Designation AS art_designation, 
                         CS.Quantity AS art_Qte, CS.UnitCost AS art_PU, CS.TotalCost AS art_total, CS.Remise AS art_remise, CD.ComptaDocsID, ma.Title as 'modeachat', cd.DelaisLivraisonSouhaite
            , (select Title from OrganisationalEntities _o where _o.EntityID = CD.ServiceDemandeurID ) 'ServiceDemandeur'
FROM            dbo.BMComptaDocs AS CD INNER JOIN
                         dbo.Person AS PS ON PS.PersonID = CD.CreatedBy INNER JOIN
                         dbo.BMProvider AS BP ON BP.ProviderID = CD.ProviderID INNER JOIN
                         dbo.BMComptaDocDetails AS CS ON CS.ComptaDocsID = CD.ComptaDocsID INNER JOIN
                         dbo.BMSubType AS ST ON ST.SubTypeID = CS.SubTypeID INNER JOIN
                         dbo.BMType AS Ty ON ST.TypeID = Ty.TypeID INNER JOIN
						 BMModeAchat ma on ma.ModeAchatID = cd.ModeAchatID

WHERE        (CD.Type = 'BC') AND (CD.ContratPaiementID IS NULL)
GO

ALTER view [dbo].[V_ExpenseMissionPrimeData]
AS
SELECT c.SpentID, c.Title, c.Created, c.CreatedBy, js.montant as EvaluatedCost,  c.Status, c.ProjetID, c.ProviderID, c.PeriodID, c.SubTypeID,s.TypeID, s.Title as 'Article' , s.Account 'Article_Compte',  tp.Title 'LigneBudg',  js.centreBudg, p.Title 'Fournisseur', pr.Title 'projet',
c.RetenuID, c.RetenueFiscaleID, c.RetenueFiscaleMontant, c.RetenuMontant, c.NOOPER, js.EntityID, js.catPersID, js.catPersAccount, js.catPersLib, ag.agenceID , ag.Title 'Agence', c.ServiceDemandeurID
FROM BMExpense c join BMSubType s on s.SubTypeID= c.SubTypeID 
   LEFT     join BMType tp on s.TypeID = tp.TypeID
   LEFT     join BMProvider p on p.ProviderID = c.ProviderID
   LEFT   	join BMProject pr on pr.ProjetID = c.ProjetID
   LEFT   	join BMAgence ag on ag.agenceID = c.agenceID
CROSS APPLY OPENJSON(c.Details)
WITH (
catPersAccount nvarchar(255) '$.catPersAccount',
catPersID nvarchar(255) '$.catPersID',
catPersLib nvarchar(255) '$.catPersLib',
EntityID nvarchar(255) '$.centrebudgeID',
centreBudg nvarchar(255) '$.centrebudgeLib',
montant nvarchar(255) '$.montant'
) as js
where c.Status not in (2,4,34)
GO

ALTER view [dbo].[V_ExpenseNoMissionPrimeData]
as 

select c.SpentID, c.Title, c.Created, c.CreatedBy, c.EvaluatedCost, c.Status, c.ProjetID, c.ProviderID, c.PeriodID, c.SubTypeID, s.TypeID, s.Title as 'Article', s.Account 'Article_Compte' , tp.Title 'LigneBudg', o.Title 'centreBudg', p.Title 'Fournisseur', pr.Title 'projet',
c.RetenuID, c.RetenueFiscaleID, c.RetenueFiscaleMontant, c.RetenuMontant, c.NOOPER,  c.EntityID, null as catPersID, null as catPersAccount,  null as catPersLib , ag.agenceID , ag.Title 'Agence', c.ServiceDemandeurID
FROM BMExpense c join BMSubType s on s.SubTypeID= c.SubTypeID 
                 LEFT join BMType tp on s.TypeID = tp.TypeID
				 LEFT join OrganisationalEntities o on o.EntityID = c.EntityID
				 LEFT   join BMProvider p on p.ProviderID = c.ProviderID
				LEFT	join BMProject pr on pr.ProjetID = c.ProjetID
				 LEFT   	join BMAgence ag on ag.agenceID = c.agenceID
where Details = '[]' and c.Status not in (2,4,34)
GO

 ALTER  view [dbo].[V_DepenseDetails_2] 
 as 
  
 --select ROW_NUMBER() OVER( ORDER BY SpentID ) , * 
 --from
 --(
    select SpentID,	Title,	Created,	CreatedBy,  REPLACE( CONVERT(varchar, EvaluatedCost), N' ', '' ) EvaluatedCost ,	Status,  TypeID,  Article, Article_Compte, LigneBudg, centreBudg, Fournisseur, projet, SubTypeID,	ProjetID,	ProviderID,	PeriodID,	RetenuID,	RetenueFiscaleID,	CONVERT(varchar, RetenueFiscaleMontant) RetenueFiscaleMontant, CONVERT(varchar, RetenuMontant) RetenuMontant,	NOOPER,	EntityID,  CONVERT(varchar,	catPersID) catPersID, CONVERT(varchar,	catPersAccount)	catPersAccount, CONVERT(varchar,	catPersLib)	catPersLib	 , agenceID , Agence, ServiceDemandeurID
      from V_ExpenseMissionPrimeData 
    union
     select SpentID,	Title,	Created,	CreatedBy, REPLACE( CONVERT(varchar, EvaluatedCost) , N' ', '' )  EvaluatedCost ,	Status,  TypeID,  Article, Article_Compte , LigneBudg, centreBudg, Fournisseur,projet,  SubTypeID,	ProjetID,	ProviderID,	PeriodID,	RetenuID,	RetenueFiscaleID,	CONVERT(varchar, RetenueFiscaleMontant) RetenueFiscaleMontant, CONVERT(varchar, RetenuMontant) RetenuMontant,	NOOPER,	EntityID,	CONVERT(varchar,	catPersID) catPersID,	CONVERT(varchar,	catPersAccount)	catPersAccount,	CONVERT(varchar,	catPersLib) catPersLib	 , agenceID , Agence, ServiceDemandeurID
      from V_ExpenseNoMissionPrimeData
 --)

GO

 ALTER  view [dbo].[V_DepenseDetails] 
 as 
    select ROW_NUMBER() OVER ( ORDER BY x.SpentID ) as SpentID , x.spentID as depID , x.ProviderID,   x.Title , x.Created, x.CreatedBy, x.EvaluatedCost, x.Status, x.TypeID, x.Article, x.Article_Compte, x.LigneBudg, x.centreBudg, x.Fournisseur, x.projet, x.SubTypeID, x.ProjetID, x.PeriodID, x.RetenuID, x.RetenueFiscaleID, x.RetenueFiscaleMontant, x.RetenuMontant, x.NOOPER, x.EntityID,x.catPersID, x.catPersAccount, x.catPersLib, CONVERT(varchar(50) , IsNULL(x.agenceID,0)) as agenceID , ISNULL( x.Agence, '') Agence
	,ISNULL( (select _o.Title from OrganisationalEntities _o where _o.EntityID = x.ServiceDemandeurID), '') 'ServiceDemandeur'
  from  V_DepenseDetails_2 x
GO

ALTER VIEW [dbo].[V_BudgetCalcule]
AS
select BudgetID , TypeID, EntityID , PeriodID ,   MontantPlanifie , MontantDepense as depense , MontantEngage as enagage
 ,(select isnull( d.Montant, 0) from V_Budget_depense d where d.TypeID = b.TypeID and d.EntityID = b.EntityID and d.periodid = b.PeriodID ) as MontantDepense
 ,(select isnull( x.Montant, 0) from V_Budget_engage x where x.TypeID = b.TypeID and x.EntityID = b.EntityID and x.periodid = b.PeriodID ) as MontantEngage
 from BMBudget B 
GO

ALTER VIEW [dbo].[V_BonCommandeDetailsVentiles]
AS
SELECT        dbo.BMComptaDocDetailsVentile.EntityID, dbo.BMComptaDocDetailsVentile.SubTypeID, dbo.BMComptaDocDetailsVentile.ComptaDocDetailsVentID, dbo.BMComptaDocDetailsVentile.ComptaDocDetailsID, 
                        CAST( dbo.BMComptaDocDetailsVentile.UnitCost  AS int) AS UnitCost, dbo.BMComptaDocDetailsVentile.TotalCost, dbo.BMComptaDocDetailsVentile.Quantity,
                             (SELECT        MontantPlanifie AS Expr1
                               FROM            dbo.V_BudgetCalcule
                               WHERE        (TypeID = dbo.BMType.TypeID) AND (EntityID = dbo.BMComptaDocDetailsVentile.EntityID)) AS MontantPlanifie,
                             (SELECT      ISNULL(  MontantDepense , 0) AS Expr1
                               FROM            dbo.V_BudgetCalcule AS BMBudget_2
                               WHERE        (TypeID = dbo.BMType.TypeID) AND (EntityID = dbo.BMComptaDocDetailsVentile.EntityID)) AS MontantDepense,
                             (SELECT        MontantEngage AS Expr1
                               FROM            dbo.V_BudgetCalcule AS BMBudget_1
                               WHERE        (TypeID = dbo.BMType.TypeID) AND (EntityID = dbo.BMComptaDocDetailsVentile.EntityID)) AS MontantEngage, dbo.OrganisationalEntities.Code, dbo.OrganisationalEntities.Title
FROM            dbo.BMSubType INNER JOIN
                         dbo.BMType ON dbo.BMSubType.TypeID = dbo.BMType.TypeID INNER JOIN
                         dbo.BMComptaDocDetailsVentile ON dbo.BMSubType.SubTypeID = dbo.BMComptaDocDetailsVentile.SubTypeID INNER JOIN
                         dbo.OrganisationalEntities ON dbo.BMComptaDocDetailsVentile.EntityID = dbo.OrganisationalEntities.EntityID
GO

CREATE VIEW [dbo].[V_ConsumerValidation]
AS
SELECT        dbo.BMTaches.TachesID, dbo.BMTaches.PredictedDate, dbo.BMTaches.EffectiveDate, dbo.BMTaches.AssignTo, dbo.BMTaches.Status, dbo.BMTaches.Parent, dbo.BMTaches.ParentID, 
dbo.BMTaches.Title, dbo.BMTaches.Description,  dbo.BMTaches.Ordre,   dbo.BMConsumerDemand.Created, dbo.BMConsumerDemand.CreatedBy, 
						 dbo.BMConsumerDemand.ConsumerDemandID, dbo.BMConsumerDemand.Title AS Intitule, dbo.Person.FullName,

		 dbo.Person.PersonID, dbo.BMConsumerDemand.Status AS Statutcontrat    
FROM            dbo.BMTaches INNER JOIN
                         dbo.BMConsumerDemand ON dbo.BMTaches.ParentID = dbo.BMConsumerDemand.ConsumerDemandID INNER JOIN
                         dbo.Person ON dbo.BMConsumerDemand.CreatedBy = dbo.Person.PersonID 
WHERE        (dbo.BMTaches.Parent = 'CONSUMER')
GO


ALTER TABLE BMComptaDocs
ADD IsToBeDelivered  Bit
Go

ALTER TABLE BMComptaDocs
ADD DateTransmission  Datetime
Go

ALTER VIEW V_ListBonCommande 
AS
   Select C.ComptaDocsID, C.Created , c.NOOPER, c.Reference, c.Status, c.Type, c.createdby , F.title 'Fournisseur', c.title, c.montantTTc,  
     ISNULL(  (select Sum(Fc.MontantTTC) from BMComptaDocs Fc where Fc.ParentID = c.ComptaDocsID and Fc.Type = 'FAC'), 0) MontantFacture,
	  ma.Title 'ModeAchat', c.DateTransmission, 
	  (select top 1 s.TypeID from BMComptaDocDetails cd join BMSubType s on s.SubTypeID = cd.SubTypeID where cd.ComptaDocsID = c.ComptaDocsID) 'CodeLigneBudgetaire',
	  ISNULL( pr.Title , '') 'Projet' , c.CentreBudgetaireEntityLibelle
              from BMComptaDocs c 
				 left join BMModeAchat ma on ma.ModeAchatID = c.ModeAchatID
				 left join BMProject pr on pr.ProjetID = c.ProjetID
				 left join BMProvider f on f.ProviderID = c.ProviderID
   where c.Type = 'BC'



GO
 