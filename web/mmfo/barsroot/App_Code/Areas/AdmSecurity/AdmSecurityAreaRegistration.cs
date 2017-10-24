using BarsWeb.Infrastructure;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using BarsWeb.Areas.AdmSecurity.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.AdmSecurity.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.AdmSecurity
{
    public class AdmSecurityAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get { return "AdmSecurity"; }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.IgnoreRoute("admsecurity/dialog.aspx/{*pathInfo}");

            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/" + AreaName + "/{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                constraints: new { lang = Constants.RouteLang }
            );

            context.Routes.MapHttpRoute(
                name: AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            context.MapRoute(
                AreaName + "_default",
                AreaName + "/{controller}/{action}/{id}",
                new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

            BindAreaDI();
            RegisterBundles(BundleTable.Bundles);
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<ISecurityModel>().To<SecurityModel>();
            ninjectKernel.Bind<ISecurityConfirmRepository>().To<SecurityConfirmRepository>();
            ninjectKernel.Bind<ISecAuditRepository>().To<SecAuditRepository>();
        }

        private void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/SecAudit")
                .Include(
                    "~/Areas/" + AreaName + "/Scripts/SecAudit/secAuditCtrl.js",
                    "~/Areas/" + AreaName + "/Scripts/Utils/tabs.js"
                ));
        }
    }

}