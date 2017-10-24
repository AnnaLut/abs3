using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using BarsWeb.Areas.ValuePapers.Infrastructure.DI.Abstract;
using BarsWeb.Areas.ValuePapers.Infrastructure.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.ValuePapers
{
    public class ValuePapersAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get { return "ValuePapers"; }
        }
        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.IgnoreRoute("ValuePapers/dialog.aspx/{*pathInfo}");


            context.Routes.MapHttpRoute(
                name: AreaName + "_api_action",
                routeTemplate: "api/" + AreaName + "/{controller}/{action}/{id}",
                defaults: new { id = RouteParameter.Optional });

            //context.Routes.MapHttpRoute(
            //    name: AreaName + "_api",
            //    routeTemplate: "api/" + AreaName + "/{controller}/{id}",
            //    defaults: new { id = RouteParameter.Optional }
            //);

            context.MapRoute(
                AreaName + "_default",
                AreaName + "/{controller}/{action}/{id}",
                new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

            // dependencies : 
            BindAreaDI();
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IGeneralFolderRepository>().To<GeneralFolderRepository>();
            ninjectKernel.Bind<ICPToAnotherBagRepository>().To<CPToAnotherBagRepository>();
            ninjectKernel.Bind<IPayTicketRepository>().To<PayTicketRepository>();
        }
    }
}