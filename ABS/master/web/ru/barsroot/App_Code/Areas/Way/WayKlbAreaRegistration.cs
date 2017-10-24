using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using BarsWeb.Areas.WayKlb.Infrastructure.DI.Abstract;
using BarsWeb.Areas.WayKlb.Infrastructure.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;


namespace BarsWeb.Areas.WayKlb
{
    public class WayAreaRegistration : AreaRegistration
    {
        public override string AreaName 
        {
            get { return "WayKlb"; }
        }
        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.Routes.IgnoreRoute("admin/dialog.aspx/{*pathInfo}");
            context.Routes.MapHttpRoute(
               name: AreaName + "_api",
               routeTemplate: "api/" + AreaName + "/{controller}/{action}/{abs_id}/products/{id}",
               defaults: new { id = "null" }
            );

            BindAreaDI();
        }
        private void BindAreaDI() {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IIntgKlbRepository>().To<IntgKlbRepository>();
        }
    }    
}