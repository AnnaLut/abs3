using System.Web.Mvc;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.Admin
{
    public class AdminAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Admin";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.IgnoreRoute("admin/dialog.aspx/{*pathInfo}");

            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/"+AreaName+"/{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                constraints: new { lang = Constants.RouteLang }
            );
            context.MapRoute(
                AreaName + "_default",
                AreaName+"/{controller}/{action}/{id}",
                new {controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
            //все несистемные привязки
            BindAreaDI();
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IAdminModel>().To<AdminModel>();
            /*ninjectKernel.Bind<IModulesRepository>().To<ModulesRepository>();*/
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
            ninjectKernel.Bind<IADMRepository>().To<ADMRepository>();
            ninjectKernel.Bind<IADMURepository>().To<ADMURepository>();
        }
    }
}