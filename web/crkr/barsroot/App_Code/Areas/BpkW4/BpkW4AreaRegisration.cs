﻿using System.Web.Mvc;
using System.Web.Optimization;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

/// <summary>
/// Summary description for BpkW4AreaRegisration
/// </summary>
namespace BarsWeb.Areas.BpkW4
{
    public class BpkW4AreaRegisration : AreaRegistration 
    {
        public override string AreaName
        {
            get
            {
                return "BpkW4";
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
            ninjectKernel.Bind<IKievCardRepository>().To<KievCardRepository>();
        }

        private void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/scripts/import")
                .Include("~/Areas/" + AreaName + "/Scripts/importKK.js"));
        }
    }
}