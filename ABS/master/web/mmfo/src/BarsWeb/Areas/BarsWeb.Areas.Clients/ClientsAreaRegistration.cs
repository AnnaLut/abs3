using AttributeRouting.Web.Http.WebHost;
using System;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using BarsWeb.Areas.Clients.Infrastructure;
using BarsWeb.Areas.Clients.Infrastructure.Repository;
using BarsWeb.Core.Infrastructure;
using MvcContrib.PortableAreas;
using BarsWeb.Core.Infrastructure.Kernel.DI.Abstract;
using BarsWeb.Core.Infrastructure.Kernel.DI.Implementation;

namespace BarsWeb.Areas.Clients
{
    public class ClientsAreaRegistration : PortableAreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Clients";
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
            GlobalConfiguration.Configuration.Routes.MapHttpAttributeRoutes();

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
                defaults: new { id = RouteParameter.Optional }//,
                //namespaces: new[] { "BarsWeb.Areas.Clients.Controllers", "MvcContrib" }
            );

            context.Routes.MapHttpRoute(
                name: AreaName + "_api_v1",
                routeTemplate: "api/v1/" + AreaName + "/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }//,
                //namespaces: new[] { "BarsWeb.Areas.Clients.Controllers", "MvcContrib" }
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

            // Bookings Bundles
            //bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/scripts/CustomersCtrl")
                //.Include("~/Areas/" + AreaName + "/Scripts/CustomersCtrl.js"));
        }

        private void BindAreaDi()
        {
            var ninjectKernel = (INinjectDependencyResolver)GlobalConfiguration.Configuration.DependencyResolver;
            var kernel = ninjectKernel.GetKernel();

            kernel.Bind<IClientsModel>().To<ClientsModel>();
            kernel.Bind<ICustomersRepository>().To<CustomersRepository>();
            kernel.Bind<IValidateCustomerRepository>().To<ValidateCustomerRepository>();
            kernel.Bind<IUtils>().To<Utils>();
            kernel.Bind<IClientAddressRepository>().To<ClientAddressRepository>();
            kernel.Bind<IKendoSqlTransformer>().To<KendoSqlTransformer>();
            kernel.Bind<IKendoSqlFilter>().To<KendoSqlFilter>();
            kernel.Bind<IClearAddressRepository>().To<ClearAddressRepository>();
            kernel.Bind<IGeneralClearAddressRepository>().To<GeneralClearAddressRepository>();
        }

    }

}