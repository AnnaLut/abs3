using System.Web.Mvc;
using BarsWeb.Areas.KFiles.Infrastructure.DI.Abstract;
using BarsWeb.Areas.KFiles.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.KFiles.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.KFiles.Infrastucture.DI.Implementation;

using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;
using System.Web.Optimization;
using System.Web.Http;

namespace BarsWeb.Areas.KFiles
{
    public class KFilesAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "KFiles";
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

            //все несистемные привязки
            BindAreaDI();
            RegisterBundles(BundleTable.Bundles);
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IKFilesModel>().To<KFilesModel>();
            ninjectKernel.Bind<IKFilesRepository>().To<KFilesRepository>();
            ninjectKernel.Bind<IKFilesAccountCorpRepository>().To<KFilesAccountCorpRepository>();
        }

        private void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/scripts")
                .Include("~/Areas/" + AreaName + "/Scripts/mainKFilesCtrl.js",
                        "~/Areas/" + AreaName + "/Scripts/changeHierarchyCorporation.js",
                        "~/Areas/" + AreaName + "/Scripts/filesCorporationCtrl.js"));

            bundles.Add(new StyleBundle("~/bundles/" + AreaName + "/styles")
                .Include("~/Areas/" + AreaName + "/CSS/mainKFiles.css"));
        }
    }
}