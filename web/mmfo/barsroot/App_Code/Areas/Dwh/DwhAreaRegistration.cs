using BarsWeb.Infrastructure;
using System.Web.Mvc;

using BarsWeb.Infrastructure.Repository;
using BarsWeb.Areas.Dwh.Infrastructure.Repository.DI.Abstract;
using barsapp.Areas.Dwh.Infrastructure.DI.Implementation;

namespace BarsWeb.Areas.Dwh
{
    public class DwhAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get { return "Dwh"; }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/" + AreaName + "/{controller}/{action}/{id}",
                defaults: Constants.DefaultRoute,
                constraints: new { lang = Constants.RouteLang }
            );

            context.MapRoute(
                            AreaName + "_default",
                            AreaName + "/{controller}/{action}/{id}",
                            Constants.DefaultRoute
            );
            BindAreaDi();
        }

        private void BindAreaDi()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IReportRepository>().To<ReportRepository>();
        }
    }
}