using System;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using BarsWeb.Areas.DepoFiles.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.DepoFiles.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;
using BarsWeb.Areas.DepoFiles.Infrastructure.DI.Abstract;

namespace BarsWeb.Areas.DepoFiles
{
    public class DepoFilesAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "DepoFiles";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            //register routes
            RegisterRoutes(context);
            // register all bundles
            RegisterBundles(BundleTable.Bundles);
            //все несистемные привязки
            BindAreaDi();
        }

        private void RegisterRoutes(AreaRegistrationContext context)
        {
            if (context == null)
            {
                throw new ArgumentNullException("context");
            }

            context.Routes.MapHttpRoute(
                name: AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{action}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/" + AreaName + "/{controller}/{action}/{id}",
                defaults: Constants.DefaultRoute, //new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                constraints: new { lang = Constants.RouteLang }
            );
            context.MapRoute(
                AreaName + "_default",
                AreaName + "/{controller}/{action}/{id}",
                Constants.DefaultRoute// new {controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
        private void RegisterBundles(BundleCollection bundles)
        {
            if (bundles == null)
            {
                throw new ArgumentNullException("bundles");
            }
        }

        private void BindAreaDi()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IDepoFilesRepository>().To<DepoFilesRepository>();
            ninjectKernel.Bind<IModel>().To<Model>();
        }
    }
}