using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;
using BarsWeb.Areas.ExternalServices.Repository;
using CorpLight.Users;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Implementation;

namespace BarsWeb.Areas.ExternalServices
{
    public class ExternalServicesAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "ExternalServices";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.MapHttpRoute(
                name: AreaName + "_api_CL",
                routeTemplate: "api/" + AreaName + "/{controller}/{action}"
            );

            //все несистемные привязки
            BindAreaDI();
            //RegisterBundles(BundleTable.Bundles);
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<Services.IExternalServices>().To<Services.ExternalServices>();
            ninjectKernel.Bind<Services.CorpLight.ICorpLightServices>().To<Services.CorpLight.CorpLightServices>();
            ninjectKernel.Bind<Services.Corp2.ICorp2Services>().To<Services.Corp2.Corp2Services>();
            ninjectKernel.Bind<IParametersRepository>().To<ParametersRepository>();
            ninjectKernel.Bind<ISupportDocumentsManage>().To<SupportDocumentsManage>();
            ninjectKernel.Bind<IPrintFilesManage> ().To<PrintFilesManage>();
        }

        private void RegisterBundles(BundleCollection bundles)
        {
        }
    }
}