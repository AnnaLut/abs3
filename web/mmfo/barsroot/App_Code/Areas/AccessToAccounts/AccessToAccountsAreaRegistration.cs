using System.Web.Mvc;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;
using System.Web.Optimization;
using System;
using BarsWeb.Areas.AccessToAccounts.Infrastructure.DI.Abstract;
using BarsWeb.Areas.AccessToAccounts.Infrastucture.DI.Implementation;

namespace BarsWeb.Areas.AccessToAccounts
{
    public class AccessToAccountsAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "AccessToAccounts";
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

            //все несистемные привязки
            BindAreaDI();
            RegisterBundles(BundleTable.Bundles);
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IAccessToAccountsUsersRepository>().To<AccessToAccountsUsersRepository>();
            ninjectKernel.Bind<IAccessToAccountsRepository>().To<AccessToAccountsRepository>();
            ninjectKernel.Bind<IAccGroupsRepository>().To<AccGroupsRepository>();
            ninjectKernel.Bind<IAccessToAccountsMainRepository>().To<AccessToAccountsMainRepository>();
            ninjectKernel.Bind<IAccRoleGroupsRepository>().To<AccRoleGroupsRepository>();
        }

        private void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/scripts")
                .Include("~/Areas/" + AreaName + "/Scripts/Services/ChangeGroupsService.js",
                         "~/Areas/" + AreaName + "/Scripts/Controllers/MainAccessToAccountsCtrl.js"));

            bundles.Add(new StyleBundle("~/bundles/" + AreaName + "/styles")
                .Include("~/Areas/" + AreaName + "/CSS/MainAccessToAccounts.css"));

            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/scriptsAccounts")
                .Include("~/Areas/" + AreaName + "/Scripts/Services/accountsService.js",
                        "~/Areas/" + AreaName + "/Scripts/Controllers/AccountsCtrl.js"));

            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/scriptsMain")
                .Include("~/Areas/" + AreaName + "/Scripts/Services/mainService.js",
                        "~/Areas/" + AreaName + "/Scripts/Controllers/MainCtrl.js",
                        "~/Areas/" + AreaName + "/Scripts/Controllers/AddGroupCtrl.js"));

            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/AccGroups")
                .Include("~/Areas/" + AreaName + "/Scripts/Services/accGroupsService.js",
             "~/Areas/" + AreaName + "/Scripts/Controllers/AccGroupsCtrl.js"));

           /* bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/AccRoleGroups")
            .Include("~/Areas/" + AreaName + "/Scripts/Controllers/AccRoleGroupsCtrl.js"));*/


        }
    }
}
