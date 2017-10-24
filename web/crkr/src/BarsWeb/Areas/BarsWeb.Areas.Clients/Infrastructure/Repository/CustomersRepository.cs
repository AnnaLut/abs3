using System;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.Clients.Models;
using System.Data.Entity;
using BarsWeb.Areas.Clients.Models.Enums;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Enums;

namespace BarsWeb.Areas.Clients.Infrastructure.Repository
{
    public class CustomersRepository : ICustomersRepository
    {
        private string _customersSql =
                        @"SELECT 
                            a.RNK AS Id, 
                            a.BRANCH AS Branch, 
                            a.ND AS ContractNumber, 
                            a.CUSTTYPE AS TypeId, 
                            a.CUSTTYPENAME AS TypeName, 
                            a.DATE_OFF AS DateClosed, 
                            a.DATE_ON AS DateOpen, 
                            a.NMK AS Name, 
                            a.NMKV AS NameInternational, 
                            a.NMKK AS NameShort, 
                            a.OKPO AS Code, 
                            a.REQ_STATUS AS RequestStatus, 
                            a.REQ_TYPE AS RequestType, 
                            a.SED AS Sed,                             
                            a.rnk || a.nmk || a.nd || a.okpo || a.branch as SearchColumn
                        FROM V_CUSTOMER a";

        readonly ClientsDbContext _dbContext;
        private readonly IValidateCustomerRepository _validateCustRepo;
        private readonly IUtils _utils;
        public CustomersRepository(
            IClientsModel model, 
            IValidateCustomerRepository validateCustRepo,
            IUtils utils)
        {
            _dbContext = model.GetDbContext();
            _validateCustRepo = validateCustRepo;
            _utils = utils;
        }

        public IQueryable<Customer> GetAll()
        {
            return _dbContext.Customers;
        }
        public IQueryable<Customer> GetAllByType(CustomerType type)
        {
            var customers = GetAll();
            short typeId = 0;
            if (type != CustomerType.All)
            {
                switch (type)
                {
                    case CustomerType.Bank:
                        typeId = 1;
                        break;
                    case CustomerType.Corp:
                        typeId = 2;
                        break;
                    case CustomerType.Person:
                    case CustomerType.PersonSpd:
                        typeId = 3;
                        break;
                }
                customers = customers.Where(i => i.TypeId == typeId);
                if (type == CustomerType.PersonSpd)
                {
                    customers = customers.Where(i => i.Sed == "91");
                }
            }

            return customers;
        }
        public Customer Get(int id)
        {
            var customer = _dbContext.Customers
                .Include(i => i.AddressList)
                .Include(i => i.DetailsList)
                .FirstOrDefault(i => i.Id == id);
            /*if (customer != null)
            {
                customer.AddressList = GetAdderessList(id).ToList();
                customer.DetailsList = GetDetailsList(id).ToList();
            }*/

            return customer;
        }

        public List<Customer> Search(SearchParams parameters)
        {
            var sql = _utils.CreateSearchSql(parameters, _customersSql);

            var result = _dbContext.Database.SqlQuery<Customer>(sql.SqlText, sql.SqlParams).ToList();
            return result;
        }


        public Customer Update(Customer customer)
        {
            throw new NotImplementedException();
        }

        public Customer Create(Customer customer)
        {
            throw new NotImplementedException();
        }

        public ActionStatus Delete(int id)
        {
            var validate = _validateCustRepo.CloseCustomerValidation(id);
            if (validate.Status != ActionStatusCode.Ok)
            {
                return validate;
            }
            const string sql = "UPDATE customer SET date_off=(SELECT bankdate FROM dual) WHERE rnk=:rnk";
            _dbContext.Database.ExecuteSqlCommand(sql, id);

            return validate;
        }

        public ActionStatus RestoreCustomer(int id)
        {
            var validate = _validateCustRepo.RestoreCustomerValidation(id);
            if (validate.Status != ActionStatusCode.Ok)
            {
                return validate;
            }
            const string sql = "UPDATE customer SET date_off=NULL WHERE rnk=:rnk";
            _dbContext.Database.ExecuteSqlCommand(sql, id);

            return validate;
        }
        public IQueryable<Address> GetAdderessList(int customerId)
        {
            return _dbContext.Addresses.Where(i => i.CustomerId == customerId);
        }

        public IQueryable<CustomerDetail> GetDetailsList(int customerId)
        {
            return _dbContext.CustomerDetails.Where(i => i.CustomerId == customerId);
        }
    }

    public interface ICustomersRepository
    {
        IQueryable<Customer> GetAll();
        IQueryable<Customer> GetAllByType(CustomerType type);
        List<Customer> Search(SearchParams parameters);
        Customer Get(int id);
        Customer Update(Customer customer);
        ActionStatus RestoreCustomer(int id);
        Customer Create(Customer customer);
        ActionStatus Delete(int id);
        IQueryable<Address> GetAdderessList(int customerId);
        IQueryable<CustomerDetail> GetDetailsList(int customerId);
    }
}