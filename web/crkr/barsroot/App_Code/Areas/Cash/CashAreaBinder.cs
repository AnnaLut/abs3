using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using BarsWeb.Areas.Cash.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cash.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.Cash.Infrastucture.DI.Implementation.Center;
using Ninject;

namespace BarsWeb.Areas.Cash
{
    /// <summary>
    /// Класс устанавливает Ninject привязки для CashArea
    /// </summary>
    public class CashAreaBinder
    {
        /// <summary>
        /// Установить все привязки
        /// </summary>
        /// <param name="kernel"></param>
        public static void Bind(IKernel kernel)
        {
            kernel.Bind<ICashModel>().To<CashModel>();
            kernel.Bind<ISyncRepository>().To<SyncRepository>();
            kernel.Bind<IRequestRepository>().To<RequestRepository>();
            kernel.Bind<ILimitRepository>().To<LimitRepository>();
            kernel.Bind<IMfoRepository>().To<MfoRepository>();
            kernel.Bind<ICenterAccountRepository>().To<CenterAccountRepository>();
            kernel.Bind<Infrastructure.DI.Abstract.Region.IRegionAccountRepository>()
                .To<Infrastucture.DI.Implementation.Region.RegionAccountRepository>();
            kernel.Bind<ITresholdRepository>().To<TresholdRepository>();
            kernel.Bind<ILimitsDistributionAccRepository>().To<LimitsDistributionAccRepository>();
            kernel.Bind<ILimitsDistributionAtmRepository>().To<LimitsDistributionAtmRepository>();
            kernel.Bind<ILimitsDistributionMfoRepository>().To<LimitsDistributionMfoRepository>();
        }
    }
}