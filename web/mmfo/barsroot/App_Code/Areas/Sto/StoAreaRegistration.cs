using BarsWeb.Areas.Sto.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sto.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;
using System;
using System.Web.Mvc;

namespace BarsWeb.Areas.Sto
{
    public class StoAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get 
            { 
                return "Sto"; 
            }
        }
        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                AreaName + "_default",
                AreaName + "/{controller}/{action}",
                Constants.DefaultRoute
            );
            BindAreaDI();
        }
        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;

            ninjectKernel.Bind<IContractRepository>().To<ContractRepository>();
        }
    }
}

