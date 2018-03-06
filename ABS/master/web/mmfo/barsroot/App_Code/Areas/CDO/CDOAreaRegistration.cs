using System;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using AttributeRouting.Web.Http.WebHost;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;
using CorpLight.Users;
using BarsWeb.Areas.CDO.Common.DataContexts;
using BarsWeb.Areas.CDO.Common.Repository;
using BarsWeb.Areas.CDO.Common.Services;
using BarsWeb.Areas.CDO.CorpLight.Repository;
using BarsWeb.Areas.CDO.CorpLight.Services;
using BarsWeb.Areas.CDO.Corp2.Repository;
using BarsWeb.Areas.CDO.Corp2.Services;

namespace BarsWeb.Areas.CDO
{

    /// <summary>
    /// Управление кассой
    /// </summary>
    public class CDORegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "CDO";
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

            context.Routes.MapHttpRoute(
                name: AreaName + "Action_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/" + AreaName + "/{controller}/{action}/{id}",
                defaults: Constants.DefaultRoute, 
                constraints: new { lang = Constants.RouteLang }
            );

            #region MVC Common
            context.MapRoute(
                AreaName + "_version_COMMON",
                AreaName + "/common/version",
                new { controller = "Home", action = "Version", id = UrlParameter.Optional }
            );
            context.MapRoute(
                AreaName + "_default_COMMON",
                AreaName + "/common/{controller}/{action}/{id}",
                Constants.DefaultRoute
            );
            #endregion

            #region MVC CorpLight
            context.MapRoute(
                AreaName + "_version_CL",
                AreaName + "/corplight/version",
                new { controller = "Home", action = "Version", id = UrlParameter.Optional }
            );
            context.MapRoute(
                AreaName + "_default_CL",
                AreaName + "/corplight/{controller}/{action}/{id}",
                Constants.DefaultRoute
            );
            #endregion

            #region MVC Corp2
            context.MapRoute(
                AreaName + "_version_CORP2",
                AreaName + "/corp2/version",
                new { controller = "Home", action = "Version", id = UrlParameter.Optional }
            );
            context.MapRoute(
                AreaName + "_default_CORP2",
                AreaName + "/corp2/{controller}/{action}/{id}",
                Constants.DefaultRoute
            );
            #endregion
            

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

            #region Common
            kernel.Bind<IHttpDataContext>().To<HttpDataContext>();
            kernel.Bind<ICDOModel>().To<CDOModel>();
            kernel.Bind<INbsAccTypesRepository>().To<NbsAccTypesRepository>();
            kernel.Bind<IParametersRepository>().To<ParametersRepository>();
            kernel.Bind<IRelatedCustomersRepository>().To<RelatedCustomersRepository>();
            kernel.Bind<IAcskLogger>().To<AcskLogger>();
            kernel.Bind<INokkService>().To<NokkService>();
            kernel.Bind<IUserCertificateService>().To<UserCertificateService>();
            #endregion

            #region CorpLight
            kernel.Bind<IUsersManage<string, string>>().To<UsersManage<string, string>>();
            kernel.Bind<ICLAcskRepository>().To<CLAcskRepository>();
            kernel.Bind<ICLRelatedCustomersRepository>().To<CLRelatedCustomersRepository>();
            kernel.Bind<IProfileSignRepository>().To<ProfileSignRepository>();
            kernel.Bind<ICLRelatedCustomerValidator>().To<CLRelatedCustomerValidator>();
            kernel.Bind<ICorpLightUserManageService>().To<CorpLightUserManageService>();
            kernel.Bind<ICLCustomersRepository>().To<CustomersRepository>();

            #endregion

            #region Corp2
            kernel.Bind<IC2AcskRepository>().To<C2AcskRepository>();
            kernel.Bind<ICorp2ProfileSignRepository>().To<Corp2ProfileSignRepository>();
            kernel.Bind<ICorp2RelatedCustomersRepository>().To<Corp2RelatedCustomersRepository>();
            kernel.Bind<ICorp2RelatedCustomerValidator>().To<Corp2RelatedCustomerValidator>();
            kernel.Bind<ICorp2Services>().To<Corp2Services>();
            #endregion


        }
    }
}