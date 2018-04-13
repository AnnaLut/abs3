using System.Linq;
using Models;

namespace BarsWeb.Infrastructure.Repository.DI.Abstract
{
    public interface ICustomersRepository
    {
        /// <summary>
        /// Cписик кліентів
        /// </summary>
        /// <param name="custType">тип клієнта</param>
        /// <returns></returns>
        IQueryable<V_TOBO_CUST> GetCustomers(CustomerType custType);
        /// <summary>
        /// клієнт
        /// </summary>
        /// <param name="rnk">рнк</param>
        /// <returns></returns>
        CUSTOMER Customer(decimal rnk);
    }

    /// <summary>
    /// тип клієнта
    /// </summary>
    public enum CustomerType
    {
        All, Bank, Corp, Person 
    }
}