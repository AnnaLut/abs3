using System.Collections.Generic;
using System.Linq;
using Areas.Payreg.Models;
using BarsWeb.Areas.Payreg.Models;


namespace BarsWeb.Areas.Payreg.Infrastructure.Repository.DI.Abstract
{
    public interface IPayRegularRepository
    {
        IQueryable<V_STO_SBON_PROVIDER> GetSbonProviders();
        IQueryable<CustomerInfo> CustomerSearch(CustomerSearchParams sp);
        IQueryable<V_STO_ORDER> GetCustSbonOrders(decimal customerId);
        int AddNewSepOrder(RegularSepPaymentOrder order);
        int AddNewSbonOrder(RegularSbonWithContractOrder order);
        int AddNewSbonOrder(RegularSbonWithoutContractOrder order);
        int AddNewSbonOrder(RegularSbonFreeOrder order);
        IQueryable<V_STO_ACCOUNTS> GetCustAcounts(decimal customerId);
        IQueryable<V_STO_FREQ> GetFreqs();
        int ShiftPriority(decimal orderId, decimal direction);
        int CloseOrder(decimal orderId);
        IEnumerable<ExtraAttrMeta> GetProviderExtraFiledsMeta(int providerId);
        V_STO_ORDER_SEP GetSepOrder(int orderId);
        V_STO_ORDER_SBON_FREE GetSbonFreeOrder(int orderId);
        V_STO_ORDER_SBON_NO_CONTR GetSbonWithoutContractOrder(int orderId);
        V_STO_ORDER_SBON_CONTR GetSbonWithContractOrder(int orderId);
    }
}