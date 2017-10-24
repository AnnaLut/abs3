using System;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using BarsWeb.Areas.Security.Infrastructure.Repository.Abstract;
using BarsWeb.Areas.Security.Infrastructure.Repository.Implementation;
using BarsWeb.Areas.Security.Models.Abstract;
using BarsWeb.Areas.Security.Models.Implementation;
using MvcContrib.PortableAreas;
using Ninject;

namespace BarsWeb.Areas.Security
{
    public class SecurityAreaRegistration : PortableAreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Security";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context, IApplicationBus bus)
        {
            //register routes
            RegisterRoutes(context);
            // register all bundles
            RegisterBundles(BundleTable.Bundles);
            //все несистемные привязки
            BindAreaDi();

            RegisterAreaEmbeddedResources();
        }

        private void RegisterRoutes(AreaRegistrationContext context)
        {
            if (context == null)
            {
                throw new ArgumentNullException("context");
            }

            context.MapRoute(
                AreaName + "_scripts",
                AreaName + "/Scripts/{resourceName}",
                new { controller = "EmbeddedResource", action = "Index", resourcePath = "scripts" },
                new[] { "MvcContrib.PortableAreas" }
            );

            context.MapRoute(
                AreaName + "_images",
                AreaName + "/images/{resourceName}",
                new { controller = "EmbeddedResource", action = "Index", resourcePath = "images" },
                new[] { "MvcContrib.PortableAreas" }
            );

            context.Routes.MapHttpRoute(
                name: AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            context.Routes.MapHttpRoute(
                name: AreaName + "_api_v1",
                routeTemplate: "api/v1/" + AreaName + "/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );
            
            context.MapRoute(
                AreaName + "_default",
                AreaName + "/{controller}/{action}/{id}",
                new {controller = "Home", action = "Index", id = UrlParameter.Optional },
                new[] { "BarsWeb.Areas." + AreaName + ".Controllers", "MvcContrib" }
            );
        }
        private void RegisterBundles(BundleCollection bundles)
        {
            if (bundles == null)
            {
                throw new ArgumentNullException("bundles");
            }

            bundles.Add(new ScriptBundle("~/" + AreaName + "/bundles/PaymentsCtrl")
                .Include("~/" + AreaName + "/Scripts/PaymentsCtrl.js"));
        }

        private void BindAreaDi()
        {
            var controllerFactory = (ControllerBuilder.Current.GetControllerFactory());

            const string nameOfProperty = "NinjectKernel";
            var propertyInfo = controllerFactory.GetType().GetProperty(nameOfProperty);
            var value = propertyInfo.GetValue(controllerFactory, null);

            var ninjectKernel = (IKernel)value;
            ninjectKernel.Bind<ISecurityModel>().To<SecurityModel>();
            //ninjectKernel.Bind<IAccountRepository>().To<AccountRepository>();
            ninjectKernel.Bind<IAuditRepository>().To<AuditRepository>();
        }

    }

}