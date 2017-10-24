using BarsWeb.Areas.Clients.Models;
using BarsWeb.Areas.Clients.Models.Enums;
using BarsWeb.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.Clients.Infrastructure.Repository
{
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
        List<Customer> GetCustomers(DataSourceRequest request, CustomerType type, bool showClosed);
        decimal GetCustomersCount(DataSourceRequest request, CustomerType type, bool showClosed);
        string GetCustomerImage(decimal? CustomerID, string TypePicture);
    }
}