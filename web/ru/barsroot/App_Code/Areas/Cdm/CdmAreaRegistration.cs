using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.Legal;
using BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.PrivateEn;
using BarsWeb.Areas.Cdm.Infrastructure.DI.Implementation.PrivateEn;
using BarsWeb.Areas.Cdm.Infrastructure.DI.Implementation.Legal;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.Kernel.Infrastructure;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;
using BarsWeb.Areas.Cdm.Models.Transport;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract.Individual;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Implementation.Individual;

namespace BarsWeb.Areas.Cdm
{
    public class CdmAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Cdm";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {

            #region V2 routes
            context.Routes.MapHttpRoute(
                name: AreaName + "_api_CDMService_IndividualPersonV2",
                routeTemplate: "v2/CDMService/IndividualPerson/{id}",
                defaults: new { id = RouteParameter.Optional, controller = "IndividualPersonV2" }
            ).RouteHandler = new SessionStateRouteHandler();
            context.Routes.MapHttpRoute(
                name: AreaName + "_api_CDMService_LegallPersonV2",
                routeTemplate: "v2/CDMService/LegalPerson/{id}",
                defaults: new { id = RouteParameter.Optional, controller = "LegalPersonV2" }
            ).RouteHandler = new SessionStateRouteHandler();
            context.Routes.MapHttpRoute(
                name: AreaName + "_api_CDMService_PrivateEntrepreneurV2",
                routeTemplate: "v2/CDMService/PrivateEntrepreneur/{id}",
                defaults: new { id = RouteParameter.Optional, controller = "PrivateEntrepreneurV2" }
            ).RouteHandler = new SessionStateRouteHandler();
            #endregion // V2 routes

            #region V1 routes
            // for outer ebk calls
            context.Routes.MapHttpRoute(
                name: AreaName + "_api_CDMService",
                routeTemplate: "CDMService/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            ).RouteHandler = new SessionStateRouteHandler();


            // for internal javascript calls
            context.Routes.MapHttpRoute(
                name: AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );
            #endregion // V1 routes


            #region Default route
            context.MapRoute(
                AreaName + "_default",
                AreaName + "/{controller}/{action}/{id}",
                Constants.DefaultRoute
            );
            #endregion // Default route
            //все несистемные привязки


            BindAreaDI();
            RegisterBundles(BundleTable.Bundles);
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            //ninjectKernel.Bind<ICdmRepository>().To<CdmRepository>();
            //ninjectKernel.Bind<ICdmLegalRepository>().To<CdmLegalRepository>();
            //ninjectKernel.Bind<ICdmPrivateEnRepository>().To<CdmPrivateEnRepository>();
            //ninjectKernel.Bind<IEbkFindRepository>().To<EbkFindRepository>();
            ninjectKernel.Bind<ICdmRepository>().To<CdmRepositoryV2>();
            ninjectKernel.Bind<ICdmLegalRepository>().To<CdmLegalRepositoryV2>();
            ninjectKernel.Bind<ICdmPrivateEnRepository>().To<CdmPrivateEnRepositoryV2>();
            ninjectKernel.Bind<IEbkFindRepository>().To<EbkFindRepositoryV2>();
            ninjectKernel.Bind<IQualityRepository>().To<QualityRepository>();
            ninjectKernel.Bind<IBanksRepository>().To<BanksRepository>();
            ninjectKernel.Bind<IDeduplicateRepository>().To<DeduplicateRepository>();
            ninjectKernel.Bind<IQueueToUnloadingRepository>().To<QueueToUnloadingRepository>();
        }

        private void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/scripts")
                .Include("~/Areas/" + AreaName + "/Scripts/quality.js",
                    "~/Areas/" + AreaName + "/Scripts/dupes.js"));

            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/queueToUnloadingScripts")
                .Include("~/Areas/" + AreaName + "/Scripts/queueToUnloadingCtrl.js"));

            bundles.Add(new StyleBundle("~/bundles/" + AreaName + "/styles")
                .Include("~/Areas/" + AreaName + "/Css/quality.css",
                "~/Areas/" + AreaName + "/Css/queueToUnloading.css"));

            bundles.Add(new StyleBundle("~/bundles/" + AreaName + "/queueToUnloadingStyles")
                .Include("~/Areas/" + AreaName + "/Css/queueToUnloading.css"));
        }
    }
}