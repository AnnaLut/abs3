using BarsWeb.Areas.CreditUi.Infrastructure.DI.Abstract;
using BarsWeb.Areas.CreditUi.Infrastructure.DI.Implementation;
using BarsWeb.Infrastructure.Repository;
using BarsWeb.Infrastructure;
using System.Web.Http;
using System.Web.Mvc;

namespace BarsWeb.Areas.CreditUi
{
    public class CreditAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "CreditUi";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.MapHttpRoute(
                name:  AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            context.MapRoute(
                AreaName + "_default",
                AreaName + "/{controller}/{action}/{id}",
                Constants.DefaultRoute
            );
            
            //все несистемные привязки
            BindAreaDi();
        }

        private void BindAreaDi()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<INewCreditRepository>().To<NewCreditRepository>();
            ninjectKernel.Bind<IAnalysisBalanceRepository>().To<AnalysisBalanceRepository>();
            ninjectKernel.Bind<IProvideRepository>().To<ProvideRepository>();
            ninjectKernel.Bind<IAccountsRepository>().To<AccountsRepository>();
            ninjectKernel.Bind<IglkRepository>().To<glkRepository>();
        }
    }
}