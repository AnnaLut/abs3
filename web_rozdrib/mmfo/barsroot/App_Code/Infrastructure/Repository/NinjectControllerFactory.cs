using System;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Routing;
using BarsWeb.Areas.Security.Infrastructure.Repository.Abstract;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Infrastructure.Repository.DI.Implementation;
using Ninject;

//using Ninject.Web.WebApi;

namespace BarsWeb.Infrastructure.Repository
{
    public class NinjectControllerFactory : DefaultControllerFactory
    {
        //делаем public для того чтобы при регистрации areas сделать дополнительные bind-инги
        public IKernel NinjectKernel { get; private set; }

        public NinjectControllerFactory()
        {
            NinjectKernel = new StandardKernel();

            GlobalConfiguration.Configuration.DependencyResolver = new NinjectDependencyResolver(NinjectKernel);
            AddBindings();
        }

        protected override IController GetControllerInstance(RequestContext requestContext, Type controllerType)
        {
            return controllerType == null
                ? null
                : (IController)NinjectKernel.Get(controllerType);
        }

        //добавляем все системные привязки
        private void AddBindings()
        {
            NinjectKernel.Bind<IAppModel>().To<AppModel>();
            NinjectKernel.Bind<IAccountRepository>().To<AccountRepository>();
            NinjectKernel.Bind<IHomeRepository>().To<HomeRepository>();
        }
    }
}