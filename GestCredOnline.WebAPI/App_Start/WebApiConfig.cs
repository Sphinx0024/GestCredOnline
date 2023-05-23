using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNet.OData.Builder;
using Microsoft.AspNet.OData.Extensions;
using System.Web.Http;
using System.Web.Http.Cors;
using C = GestCredOnline.CoreCalcul;
using H = GestCredOnline.Helpers;
using M = GestCredOnline.WebAPI.Models;
using GestCredOnline.WebAPI.Models;

namespace GestCredOnline.WebAPI
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            // Configuration et services API Web 
            // Itinéraires de l'API Web
            config.MapHttpAttributeRoutes();

            var cors = new EnableCorsAttribute(Helpers.h_config.CORS_Allow, "*", "*", "DataServiceVersion, MaxDataServiceVersion");
            config.EnableCors(cors);

            config.SetTimeZoneInfo(TimeZoneInfo.Utc);
            config.Count().Filter().OrderBy().Expand().Select().MaxTop(null);

            TableRoutage(ref config);
        }

        private static void TableRoutage (ref HttpConfiguration config)
        {
            config.Routes.MapHttpRoute(
            name: "IDApi",
            routeTemplate: "api/{controller}/{Action}/{id}",
            defaults: new { id = RouteParameter.Optional }
            );

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            ///Route oData
            Microsoft.AspNet.OData.Batch.ODataBatchHandler odataBatchHandler = new Microsoft.AspNet.OData.Batch.DefaultODataBatchHandler(GlobalConfiguration.DefaultServer);
            odataBatchHandler.MessageQuotas.MaxOperationsPerChangeset = 10;
            odataBatchHandler.MessageQuotas.MaxPartsPerBatch = 10;
            config.MapODataServiceRoute("odata", "odata/v1", model: GetModel(), batchHandler: odataBatchHandler);

        }
 
        public static Microsoft.OData.Edm.IEdmModel GetModel()
        {
            Microsoft.AspNet.OData.Builder.ODataConventionModelBuilder builder = new Microsoft.AspNet.OData.Builder.ODataConventionModelBuilder();
            builder.Namespace = "F";

            builder.EntitySet<M.Client>("Clients");
            builder.EntitySet<M.Request>("Request");
            builder.EntitySet<M.EntreprisesAgrees>("EntreprisesAgrees");
            builder.EntitySet<M.RegimeMatrimonial>("RegimeMatrimonial");
            builder.EntitySet<M.EmployeurContrat>("EmployeurContrat");
            builder.EntitySet<M.Fichier>("Fichier");
            builder.EntitySet<M.PieceType>("PieceType");
            builder.EntitySet<M.Prospects>("Prospect");
            builder.EntitySet<M.ProductProgram>("ProductProgram");
            builder.EntitySet<M.ProductProgramCheckList>("ProductProgramCheckList");
             

            Microsoft.AspNet.OData.Builder.EntitySetConfiguration<M.EntreprisesAgrees> EntreprisesAgrees = builder.EntitySet<M.EntreprisesAgrees>("EntreprisesAgrees");
            EntreprisesAgrees.EntityType.HasKey(c => c.EntrepriseID);
            FunctionConfiguration EntreprisesAgreesFunction = EntreprisesAgrees.EntityType.Collection.Function("EntreprisesAgreesFunction");
            EntreprisesAgreesFunction.ReturnsCollectionFromEntitySet<M.EntreprisesAgrees>("EntreprisesAgrees");

            Microsoft.AspNet.OData.Builder.EntitySetConfiguration<M.ProductProgramCheckList> ProductProgramCheckList = builder.EntitySet<M.ProductProgramCheckList>("ProductProgramCheckList");
            ProductProgramCheckList.EntityType.HasKey(c => c.CheckListID);
            FunctionConfiguration ProductProgramCheckListFunction = ProductProgramCheckList.EntityType.Collection.Function("ProductProgramCheckListFunction");
            ProductProgramCheckListFunction.ReturnsCollectionFromEntitySet<M.ProductProgramCheckList>("ProductProgramCheckList");

            Microsoft.AspNet.OData.Builder.EntitySetConfiguration<M.ProductProgram> ProductProgram = builder.EntitySet<M.ProductProgram>("ProductProgram");
            ProductProgram.EntityType.HasKey(c => c.ProductID);
            FunctionConfiguration ProductProgramFunction = ProductProgram.EntityType.Collection.Function("ProductProgramFunction");
            ProductProgramFunction.ReturnsCollectionFromEntitySet<M.ProductProgram>("ProductProgram");

            Microsoft.AspNet.OData.Builder.EntitySetConfiguration<M.PieceType> PieceType = builder.EntitySet<M.PieceType>("PieceType");
            PieceType.EntityType.HasKey(c => c.PieceTypeID);
            FunctionConfiguration PieceTypeFunction = PieceType.EntityType.Collection.Function("PieceTypeFunction");
            PieceTypeFunction.ReturnsCollectionFromEntitySet<M.PieceType>("PieceType");

            Microsoft.AspNet.OData.Builder.EntitySetConfiguration<M.Fichier> Fichier = builder.EntitySet<M.Fichier>("Fichier");
            Fichier.EntityType.HasKey(c => c.FileID);
            FunctionConfiguration FichierFunction = Fichier.EntityType.Collection.Function("FichierFunction");
            FichierFunction.ReturnsCollectionFromEntitySet<M.Fichier>("Fichier");

            Microsoft.AspNet.OData.Builder.EntitySetConfiguration<M.EmployeurContrat> EmployeurContrat = builder.EntitySet<M.EmployeurContrat>("EmployeurContrat");
            EmployeurContrat.EntityType.HasKey(c => c.EmployeurContratID);
            FunctionConfiguration EmployeurContratFunction = EmployeurContrat.EntityType.Collection.Function("EmployeurContratFunction");
            EmployeurContratFunction.ReturnsCollectionFromEntitySet<M.EmployeurContrat>("EmployeurContrat");

            Microsoft.AspNet.OData.Builder.EntitySetConfiguration<M.RegimeMatrimonial> RegimeMatrimonial = builder.EntitySet<M.RegimeMatrimonial>("RegimeMatrimonial");
            RegimeMatrimonial.EntityType.HasKey(c => c.RegimeMatrimonialID);
            FunctionConfiguration RegimeMatrimonialFunction = RegimeMatrimonial.EntityType.Collection.Function("RegimeMatrimonialFunction");
            RegimeMatrimonialFunction.ReturnsCollectionFromEntitySet<M.RegimeMatrimonial>("RegimeMatrimonial");

            Microsoft.AspNet.OData.Builder.EntitySetConfiguration<M.Client> Client = builder.EntitySet<M.Client>("Clients");
            Client.EntityType.HasKey(c => c.PersonID);
            FunctionConfiguration ClientFunction = Client.EntityType.Collection.Function("ClientsFunction");
            ClientFunction.ReturnsCollectionFromEntitySet<M.Client>("Clients");

            Microsoft.AspNet.OData.Builder.EntitySetConfiguration<M.Prospects> Prospect = builder.EntitySet<M.Prospects>("Prospect");
            Prospect.EntityType.HasKey(c => c.ID);
            FunctionConfiguration ProspectFunction = Prospect.EntityType.Collection.Function("ProspectFunction");
            ProspectFunction.ReturnsCollectionFromEntitySet<M.Prospects>("Prospect");

            Microsoft.AspNet.OData.Builder.EntitySetConfiguration<M.Request> Request = builder.EntitySet<M.Request>("Request");
            Request.EntityType.HasKey(c => c.RequestID);
            FunctionConfiguration RequestFunction = Request.EntityType.Collection.Function("RequestFunction");
            RequestFunction.ReturnsCollectionFromEntitySet<M.Request>("Request");

            ////*** Odata entity function
            BuildFunctions(builder);
            ////*** Odata entity Actions
            BuildActions(builder);
            return builder.GetEdmModel();
        }

        private static void BuildFunctions(Microsoft.AspNet.OData.Builder.ODataModelBuilder builder)
        {

        }

        private static void BuildActions(Microsoft.AspNet.OData.Builder.ODataModelBuilder builder)
        {

        }
  
    }
}
