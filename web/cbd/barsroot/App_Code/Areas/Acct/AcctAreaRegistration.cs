using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Areas.Acct.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Acct.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.Acct
{
    public class AcctAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Acct";
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
                name: AreaName + "_lang",
                url: "{lang}/"+AreaName+"/{controller}/{action}/{id}",
                defaults: Constants.DefaultRoute, //new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                constraints: new { lang = Constants.RouteLang }
            );
            context.MapRoute(
                AreaName + "_default",
                AreaName+"/{controller}/{action}/{id}",
                Constants.DefaultRoute// new {controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
            
            //все несистемные привязки
            BindAreaDI();
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IAcctModel>().To<AcctModel>();
            ninjectKernel.Bind<IAccountsRepository>().To<AccountsRepository>();
            //ninjectKernel.Bind<DataSourceRequest>().To<WebApiDataSourceRequestModelBinder>();
            //System.Web.Http.ModelBinding.ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request

            /*ninjectKernel.Bind<IAttributesRepository>().To<AttributesRepository>();
            ninjectKernel.Bind<IFoldersRepository>().To<FoldersRepository>();
            ninjectKernel.Bind<ILoadFileRepository>().To<LoadFileRepository>();
            ninjectKernel.Bind<IFilesRepository>().To<FilesRepository>();
            ninjectKernel.Bind<IFileTypesRepository>().To<FileTypesRepository>();
            ninjectKernel.Bind<IPackagesRepository>().To<PackagesRepository>();
            ninjectKernel.Bind<IAccountsRepository>().To<AccountsRepository>();
            ninjectKernel.Bind<IStatusesRepository>().To<StatusesRepository>();
            ninjectKernel.Bind<IPackageTypes>().To<PackageTypes>();
            ninjectKernel.Bind<IOperations>().To<Operations>();
            ninjectKernel.Bind<IWorkflowRepository>().To<WorkflowRepository>();*/
        }
    }
}