using System.Linq;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using Models;

namespace BarsWeb.Infrastructure.Repository.DI.Implementation
{
    public class CustomersRepository : ICustomersRepository
    {
        EntitiesBars _entities;
        public CustomersRepository(IAppModel model)
        {
		    _entities = model.Entities;
        }

        public IQueryable<V_TOBO_CUST> GetCustomers(CustomerType custType)
        {
            var customer = _entities.V_TOBO_CUST.OrderBy(i => i.RNK);
            if (custType != CustomerType.All)
            {
                short type = 0;
                switch (custType)
                {
                    case CustomerType.Bank:
                        type = 1;
                        break;
                    case CustomerType.Corp:
                        type = 2;
                        break;
                    case CustomerType.Person:
                        type = 3;
                        break;
                }
                return customer.Where(i => i.CUSTTYPE == type);
            }

            return customer;
        }

        public CUSTOMER Customer(decimal id)
        {
            var customer = _entities.CUSTOMERs.FirstOrDefault(i => i.RNK == id);
            return customer;
        }
    }
}