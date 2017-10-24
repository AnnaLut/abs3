using System.Web.Mvc;
using System.Web.Optimization;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;
using BarsWeb.Areas.Cdnt.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Cdnt.Infrastructure.DI.Implementation;

// ReSharper disable once CheckNamespace
namespace BarsWeb.Areas.Cdnt
{
    public class CdntAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Cdnt";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                            AreaName + "_default",
                            AreaName + "/{controller}/{action}",
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
            ninjectKernel.Bind<ICdntRepository>().To<CdntRepository>();
        }

        private void RegisterBundles(BundleCollection bundles)
        {
            
            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/scripts")
                .Include("~/Areas/" + AreaName + "/Scripts/Notary.js"));
            
            bundles.Add(new StyleBundle("~/bundles/" + AreaName + "/styles")
                .Include("~/Areas/" + AreaName + "/Content/Notary.css"));
        }
    }
}