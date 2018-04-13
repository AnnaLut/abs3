using System.Linq;
using Areas.Kernel.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Models;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation
{
    public class CurrencyDict : ICurrencyDict
    {
        private readonly KernelContext _entities;
        public CurrencyDict()
        {
            var connectionStr = EntitiesConnection.ConnectionString("Kernel", "Kernel");
            _entities = new KernelContext(connectionStr); 
        }

        public CurrencyDict(IKernelModel model)
        {
            _entities = model.KernelEntities;
        }
        public IQueryable<TabvalViewModel> GetTabvals()
        {
            return
            from val in _entities.TABVAL
            select new TabvalViewModel
            {
                COIN = val.COIN,
                KV = val.KV,
                GRP = val.GRP,
                NAME = val.NAME,
                LCV = val.LCV,
                NOMINAL = val.NOMINAL,
                SV = val.SV,
                DIG = val.DIG,
                DENOM = val.DENOM,
                UNIT = val.UNIT,
                COUNTRY = val.COUNTRY,
                BASEY = val.BASEY,
                GENDER = val.GENDER,
                PRV = val.PRV,
                D_CLOSE = val.D_CLOSE,
                SKV = val.SKV,
                S0000 = val.S0000,
                S3800 = val.S3800,
                S3801 = val.S3801,
                S3802 = val.S3802,
                S6201 = val.S6201,
                S7201 = val.S7201,
                S9280 = val.S9280,
                S9281 = val.S9281,
                S0009 = val.S0009,
                G0000 = val.G0000,
                IsUaHrivna = (val.KV == 980 ? 1 : 0)
            };
            
        }

        public IQueryable<Currency> GetAllCurrencies()
        {
            return _entities.TABVAL.Select(i => new Currency
            {
                Code = i.KV,
                GroupCode = i.GRP,
                CharCode = i.LCV,
                SepCharCode = i.SV,
                Name = i.NAME,
                Country = i.COUNTRY,
                DateClosed = i.D_CLOSE,
                IsMetal = (i.PRV == 1)
            });
        }
    }
}