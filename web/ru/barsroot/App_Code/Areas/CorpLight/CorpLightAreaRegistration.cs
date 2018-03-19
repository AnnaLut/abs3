using System;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using AttributeRouting.Web.Http.WebHost;
using BarsWeb.Areas.CorpLight.Infrastructure.Repository;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;
using CorpLight.Users;
using BarsWeb.Areas.CorpLight.Infrastructure.Services;

namespace BarsWeb.Areas.CorpLight
{

    /// <summary>
    /// Управление кассой
    /// </summary>
    public class CorpLightRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "CorpLight";
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
                routeTemplate: "api/" + AreaName + "/{controller}/{action}/{id}",
                defaults: Constants.DefaultRoute
            );

            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/" + AreaName + "/{controller}/{action}/{id}",
                defaults: Constants.DefaultRoute, //new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                constraints: new { lang = Constants.RouteLang }
            );
            context.MapRoute(
                AreaName + "_version",
                AreaName + "/version",
                new {controller = "Home", action = "Version", id = UrlParameter.Optional }
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


        private void BindAreaDI()
        {
            var controllerFactory = (NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory();
            var kernel = controllerFactory.NinjectKernel;
            kernel.Bind<ICorpLightModel>().To<CorpLightModel>();
            kernel.Bind<IUsersManage<string,decimal>>().To<UsersManage<string, decimal>>();
            kernel.Bind<INbsAccTypesRepository>().To<NbsAccTypesRepository>();
            kernel.Bind<IRelatedCustomersRepository>().To<RelatedCustomersRepository>();
            kernel.Bind<IRelatedCustomerValidator>().To<RelatedCustomerValidator>();
            kernel.Bind<IUserCertificateService>().To<UserCertificateService>();
            kernel.Bind<IParametersRepository>().To<ParametersRepository>();
            kernel.Bind<ICorpLightUserManageService>().To<CorpLightUserManageService>();
            kernel.Bind<IProfileSignRepository>().To<ProfileSignRepository>();
            kernel.Bind<IAcskLogger>().To<AcskLogger>();
            kernel.Bind<INokkService>().To<NokkService>();
            kernel.Bind<IAcskRepository>().To<AcskRepository>();
            
        }
    }
}