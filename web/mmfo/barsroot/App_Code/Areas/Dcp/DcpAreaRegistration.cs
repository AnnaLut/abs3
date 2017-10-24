using System;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using BarsWeb.Areas.Dcp.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Dcp.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.Dcp
{
    public class DcpAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Dcp";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/" + AreaName + "/{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                constraints: new { lang = Constants.RouteLang }
            );
            context.MapRoute(
                AreaName + "_default",
                AreaName + "/{controller}/{action}/{id}",
                new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

            context.Routes.MapHttpRoute(
                name: AreaName + "Action_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{action}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );
            //все несистемные привязки
            BindAreaDi();
            //RegisterBundles(BundleTable.Bundles);
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
            ninjectKernel.Bind<IDepositaryRepository>().To<DepositaryRepository>();
        }
    }
}