using BarsWeb.Areas.Kernel.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation;
using BarsWeb.Infrastructure.Repository;
using BarsWeb.Infrastructure;
using System.Web.Http;
using System.Web.Mvc;

namespace BarsWeb.Areas.Kernel
{
    public class KernelAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Kernel";
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
            ninjectKernel.Bind<IKernelModel>().To<KernelModel>();
            ninjectKernel.Bind<ICurrencyDict>().To<CurrencyDict>();
            ninjectKernel.Bind<IParamsRepository>().To<ParamsRepository>();
            ninjectKernel.Bind<IErrorsRepository>().To<ErrorsRepository>();
            ninjectKernel.Bind<IBranchesRepository>().To<BranchesRepository>();
            ninjectKernel.Bind<IBankDatesRepository>().To<BankDatesRepository>();
            ninjectKernel.Bind<IKendoSqlTransformer>().To<KendoSqlTransformer>();
            ninjectKernel.Bind<IKendoSqlFilter>().To<KendoSqlFilter>();
            ninjectKernel.Bind<IKendoSqlCounter>().To<KendoSqlCounterTotal>();
            ninjectKernel.Bind<IUpdateHistoryRepository>().To<UpdateHistoryRepository>();
            ninjectKernel.Bind<IKrnModuleRepository>().To<KrnModuleRepository>();
            ninjectKernel.Bind<IKrnModuleVersionsRepository>().To<KrnModuleVersionsRepository>();
            ninjectKernel.Bind<IKendoRequestTransformer>().To<KendoRequestTransformer>();
        }
    }
}