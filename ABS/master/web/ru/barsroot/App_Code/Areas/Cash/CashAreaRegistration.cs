using System;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using AttributeRouting.Web.Http.WebHost;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.Cash
{

    /// <summary>
    /// Управление кассой
    /// </summary>
    public class CashAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Cash";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            //register routes
            RegisterRoutes(context);
            // register all bundles
            RegisterBundles(BundleTable.Bundles);
            //все несистемные привязки
            BindAreaDI();
        }

        private void RegisterRoutes(AreaRegistrationContext context)
        {
            if (context == null)
            {
                throw new ArgumentNullException("context");
            }
            GlobalConfiguration.Configuration.Routes.MapHttpAttributeRoutes();
            /*context.Routes.MapHttpRoute(
                name: AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );*/

            context.Routes.MapHttpRoute(
                name: AreaName + "Action_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{id}",
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

            // Bookings Bundles
            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/scripts/LimitsDistributionAccCtrl")
                .Include("~/Areas/" + AreaName + "/Scripts/LimitsDistributionAccCtrl.js"));
            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/scripts/LimitsDistributionAtmCtrl")
                .Include("~/Areas/" + AreaName + "/Scripts/LimitsDistributionAtmCtrl.js"));
            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/scripts/LimitsDistributionMfoCtrl")
                .Include("~/Areas/" + AreaName + "/Scripts/LimitsDistributionMfoCtrl.js"));
            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/scripts/TresholdCtrl")
                .Include("~/Areas/" + AreaName + "/Scripts/TresholdCtrl.js"));
        }


        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var kernel = controllerFactory.NinjectKernel;
            CashAreaBinder.Bind(kernel);
        }
    }
}