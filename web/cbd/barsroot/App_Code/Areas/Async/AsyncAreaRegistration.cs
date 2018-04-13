using System;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using BarsWeb.Areas.Async.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Async.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.Doc.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Doc.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.Async
{
    public class AsyncAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Async";
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

            context.Routes.MapHttpRoute(
                name: AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

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
        }
        private void RegisterBundles(BundleCollection bundles)
        {
            if (bundles == null)
            {
                throw new ArgumentNullException("bundles");
            }

            // Bookings Bundles
            bundles.Add(new ScriptBundle("~/" + AreaName + "/bundles/schedulersCtrl")
                .Include("~/Areas/" + AreaName + "/Scripts/schedulersCtrl.js"));
            bundles.Add(new ScriptBundle("~/" + AreaName + "/bundles/tasksCtrl")
                .Include("~/Areas/" + AreaName + "/Scripts/tasksCtrl.js"));
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IAsyncModel>().To<AsyncModel>();
            ninjectKernel.Bind<ITasksRepository>().To<TasksRepository>();
            ninjectKernel.Bind<ISchedulersRepository>().To<SchedulersRepository>();
            ninjectKernel.Bind<IUtils>().To<Utils>();
        }
    }
}