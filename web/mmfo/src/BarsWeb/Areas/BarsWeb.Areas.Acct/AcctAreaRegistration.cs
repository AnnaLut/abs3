using System;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using BarsWeb.Areas.Acct.Infrastructure.Repository;
using BarsWeb.Core.Infrastructure;
using MvcContrib.PortableAreas;

namespace BarsWeb.Areas.Acct
{
    public class AcctAreaRegistration : PortableAreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Acct";
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
            /*GlobalConfiguration.Configuration.Routes.MapHttpAttributeRoutes();*/

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

            // Bookings Bundles
            bundles.Add(new ScriptBundle("~/" + AreaName + "/bundles/PaymentsCtrl")
                .Include("~/" + AreaName + "/Scripts/PaymentsCtrl.js"));

            /*var bundle = new Bundle("~/Test").Include("~/Content/Site.css");
            bundle.Transforms.Add(new EmbeddedResourceTransformer());

            BundleTable.VirtualPathProvider = new EmbeddedVirtualPathProvider(HostingEnvironment.VirtualPathProvider);
            BundleTable.Bundles.Add(new ScriptBundle("~/ImranB/Embedded/Js")
                .Include("~/ImranB/Embedded/NewTextBox1.js")
                .Include("~/ImranB/Embedded/NewTextBox2.js"));*/

        }

        private void BindAreaDi()
        {
            var ninjectKernel = (INinjectDependencyResolver)GlobalConfiguration.Configuration.DependencyResolver;
            var kernel = ninjectKernel.GetKernel();

            kernel.Bind<IAcctModel>().To<AcctModel>();
            kernel.Bind<IAccountsRepository>().To<AccountsRepository>();

            kernel.Bind<IReservedAccountsRepository>().To<ReservedAccountsRepository>();
            kernel.Bind<IValidateAcctRepository>().To<ValidateAcctRepository>();
            kernel.Bind<IParametersRepository>().To<ParametersRepository>();
            kernel.Bind<IModuleConfiguration>().To<ModuleConfiguration>();
            kernel.Bind<IStatemantRepository>().To<StatemantRepository>();
        }
    }
}