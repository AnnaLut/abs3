using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.Admin
{
    public class AdminAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Admin";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.IgnoreRoute("admin/dialog.aspx/{*pathInfo}");

            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/"+AreaName+"/{controller}/{action}/{id}",
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
                AreaName+"/{controller}/{action}/{id}",
                new {controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
            //все несистемные привязки
            BindAreaDI();
            RegisterBundles(BundleTable.Bundles);
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IAdminModel>().To<AdminModel>();
            ninjectKernel.Bind<IADMRepository>().To<ADMRepository>();
            ninjectKernel.Bind<IADMURepository>().To<ADMURepository>();
            ninjectKernel.Bind<IConfirmRepository>().To<ConfirmRepository>();
            ninjectKernel.Bind<IOperRepository>().To<OperRepository>();
            ninjectKernel.Bind<IListSetRepository>().To<ListSetRepository>();
            ninjectKernel.Bind<IBaxRepository>().To<BaxRepository>();
            ninjectKernel.Bind<IHandbookRepository>().To<HandbookRepository>();
            ninjectKernel.Bind<IRolesRepository>().To<RolesRepository>();
            ninjectKernel.Bind<IRecordsRepository>().To<RecordsRepository>();
            ninjectKernel.Bind<ISecAuditRepository>().To<SecAuditRepository>();
            ninjectKernel.Bind<ICommunicationObjectRepository>().To<CommunicationObjectRepository>();
            ninjectKernel.Bind<IAssignmentSpecParamsRepository>().To<AssignmentSpecParamsRepository>();
        }

        private void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/bax")
                .Include("~/Areas/" + AreaName + "/Scripts/bax.js"));

            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/admu")
                .Include(
                    "~/Areas/" + AreaName + "/Scripts/admu/admuCtrl.js",
                    "~/Areas/" + AreaName + "/Scripts/admu/admuToolbarFunctionsCtrl.js",
                    "~/Areas/" + AreaName + "/Scripts/admu/branchLookups.js",
                    "~/Areas/" + AreaName + "/Scripts/admu/roleLookups.js",
                    "~/Areas/" + AreaName + "/Scripts/admu/saveUserCtrl.js"
                ));

            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/roles")
                .Include(
                    "~/Areas/" + AreaName + "/Scripts/roles/rolesCtrl.js",
                    "~/Areas/" + AreaName + "/Scripts/roles/rolesToolbarCtrl.js",
                    "~/Areas/" + AreaName + "/Scripts/roles/saveRoleCtrl.js",
                    "~/Areas/" + AreaName + "/Scripts/utils/tabs.js"
                ));

            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/adm")
                .Include(
                    "~/Areas/" + AreaName + "/Scripts/adm/admCtrl.js",
                    "~/Areas/" + AreaName + "/Scripts/adm/admToolbarCtrl.js",
                    "~/Areas/" + AreaName + "/Scripts/adm/saveAdmCtrl.js",
                    "~/Areas/" + AreaName + "/Scripts/utils/tabs.js"
                ));

            bundles.Add(new StyleBundle("~/bundles/" + AreaName + "/styles")
                .Include("~/Areas/" + AreaName + "/Css/roles.css"));

            bundles.Add(new StyleBundle("~/bundles/" + AreaName + "/admStyles")
                .Include("~/Areas/" + AreaName + "/Css/adm.css"));
        }
    }
}