using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;

namespace BarsWeb.Areas.Sep
{
    public class SepAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Sep";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.MapHttpRoute(
                name:  AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/"+AreaName+"/{controller}/{action}/{id}",
                defaults: Constants.DefaultRoute,
                constraints: new { lang = Constants.RouteLang }
            );

            context.MapRoute(
                            AreaName + "_default",
                            AreaName + "/{controller}/{action}/{id}",
                            Constants.DefaultRoute
            );
            
            //все несистемные привязки
            BindAreaDi();
            RegisterBundles(BundleTable.Bundles);
        }

        private void BindAreaDi()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<ISepFilesRepository>().To<SepFilesRepository>();
            ninjectKernel.Bind<ISep3720Repository>().To<Sep3720Repository>();
            ninjectKernel.Bind<ISepParams>().To<SepParamsRepository>();
            ninjectKernel.Bind<ISepPaymentStateRepository>().To<SepPaymentStateRepository>();
			ninjectKernel.Bind<ISepTechAccountsRepository>().To<SepTechAccountsRepository>();
            ninjectKernel.Bind<ISepFutureDocsRepository>().To<SepFutureDocsRepository>();
            ninjectKernel.Bind<ISepLockDocsRepository>().To<SepLockDocsRepository>();
            ninjectKernel.Bind<ISepDirectionRepository>().To<SepDirectionRepository>();
            ninjectKernel.Bind<ISepRequestipsRepository>().To<SepRequestipsRepository>();
            ninjectKernel.Bind<ISepTZRepository>().To<SepTZRepository>();
            ninjectKernel.Bind<ISepTechFlagRepository>().To<SepTechFlagRepository>();
            ninjectKernel.Bind<ISepLockDocViewRepository>().To<SepLockDocViewRepository>();
            ninjectKernel.Bind<ILimitsDirParticipants>().To<LimitsDirParticipants>();
        }

        private void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/scripts/allsep")
                .Include(
                    "~/Areas/" + AreaName + "/Scripts/sep.files.js",
                    "~/Areas/" + AreaName + "/Scripts/sep.utils.js",
                    "~/Areas/" + AreaName + "/Scripts/sep.documents.js",
                    "~/Areas/" + AreaName + "/Scripts/sep.jquery.cookie.js"));
        }

    }
}
