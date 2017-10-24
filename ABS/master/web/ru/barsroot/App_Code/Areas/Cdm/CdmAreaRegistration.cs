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
            context.Routes.MapHttpRoute(
                name: AreaName + "_api_CDMService",
                routeTemplate: "CDMService/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            ).RouteHandler = new SessionStateRouteHandler();

            context.Routes.MapHttpRoute(
                name: AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            context.MapRoute(
                            AreaName + "_default",
                            AreaName + "/{controller}/{action}/{id}",
                            Constants.DefaultRoute
            );
            //все несистемные привязки
            BindAreaDI();
            RegisterBundles(BundleTable.Bundles);
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<ICdmRepository>().To<CdmRepository>();
            ninjectKernel.Bind<IQualityRepository>().To<QualityRepository>();
            ninjectKernel.Bind<IBanksRepository>().To<BanksRepository>();
            ninjectKernel.Bind<IDeduplicateRepository>().To<DeduplicateRepository>();
            ninjectKernel.Bind<IEbkFindRepository>().To<EbkFindRepository>();
            ninjectKernel.Bind<ICdmPrivateEnRepository>().To<CdmPrivateEnRepository>();
            ninjectKernel.Bind<IQueueToUnloadingRepository>().To<QueueToUnloadingRepository>();
            ninjectKernel.Bind<ICdmLegalRepository>().To<CdmLegalRepository>();
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