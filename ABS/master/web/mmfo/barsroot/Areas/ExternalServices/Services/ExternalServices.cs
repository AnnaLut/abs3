namespace BarsWeb.Areas.ExternalServices.Services
{
    using BarsWeb.Areas.ExternalServices.Services.CorpLight;
    using BarsWeb.Areas.ExternalServices.Services.Corp2;
    using System.Collections.Generic;
    using System.Linq.Expressions;
    using System.Reflection;
    using System;

    public class ExternalServices : IExternalServices
    {
        public ExternalServices(ICorpLightServices corpLightServices, ICorp2Services corp2Services, Zay.Infrastructure.Repository.DI.Abstract.ICurrencyOperations zayRepo)
        {
            CorpLightServices = corpLightServices;
            Corp2Services = corp2Services;
        }
        public ICorpLightServices CorpLightServices { get; private set; }
        public ICorp2Services Corp2Services { get; private set; }
    }

    public interface IExternalServices
    {
        ICorpLightServices CorpLightServices { get; }
        ICorp2Services Corp2Services { get; }
    }
}