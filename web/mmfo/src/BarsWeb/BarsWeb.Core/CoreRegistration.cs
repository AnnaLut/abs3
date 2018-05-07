using System;
using System.Web.Mvc;
using BarsWeb.Core.Infrastructure;
using BarsWeb.Core.Infrastructure.Helpers;
using BarsWeb.Core.Infrastructure.Repository;
using BarsWeb.Core.Logger;
using MvcContrib.PortableAreas;
using System.Web.Http;
using BarsWeb.Core.Infrastructure.Kernel.DI.Abstract;
using BarsWeb.Core.Infrastructure.Kernel.DI.Implementation;

namespace BarsWeb.Core
{
    public class ClientsAreaRegistration : PortableAreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Core";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context, IApplicationBus bus)
        {
            //register routes
            RegisterRoutes(context);
            //все несистемные привязки
            BindAreaDi();

            RegisterAreaEmbeddedResources();
        }

        private void RegisterRoutes(AreaRegistrationContext context)
        {
            if (context == null)
            {
                throw new ArgumentNullException("context");
            }

        }

        private void BindAreaDi()
        {
            var ninjectKernel = (INinjectDependencyResolver)GlobalConfiguration.Configuration.DependencyResolver;
            var kernel = ninjectKernel.GetKernel();
            kernel.Bind<ICoreModel>().To<CoreModel>();
            kernel.Bind<IUserInfoRepository>().To<UserInfoRepository>();
            kernel.Bind<IEncryptionHelper>().To<EncryptionHelper>();
            kernel.Bind<IDbLogger>().To<DbLogger>();
            kernel.Bind<IKendoSqlCounter>().To<KendoSqlCounter>();
        }

    }

}