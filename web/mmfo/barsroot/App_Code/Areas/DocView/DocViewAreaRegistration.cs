using System.Web.Mvc;
using BarsWeb.Areas.DocView.Infrastructure.DI.Abstract;
using BarsWeb.Areas.DocView.Infrastructure.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace  BarsWeb.Areas.DocView
{
    public class DocViewAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get { return "DocView"; }
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
            
            BindAreaDI();
        }
        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IDocumentsRepository>().To<DocumentsRepository>();
        }
    }
}