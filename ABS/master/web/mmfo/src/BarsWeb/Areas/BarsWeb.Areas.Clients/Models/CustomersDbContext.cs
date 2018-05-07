using System.Data.Entity;
using BarsWeb.Areas.Clients.Configurations;
using BarsWeb.Core;

namespace BarsWeb.Areas.Clients.Models
{

    public class ClientsDbContext : DbContext
    {
        private readonly string _schemaName = Constants.SchemaName;
        public ClientsDbContext(string connectionString) : base(connectionString)
        {
            Configuration.LazyLoadingEnabled = false;
            //Configuration.ProxyCreationEnabled = true;
        }
        public DbSet<Customer> Customers { get; set; }
        public DbSet<Address> Addresses { get; set; }
        public DbSet<CustomerDetail> CustomerDetails { get; set; }
        public DbSet<ClearAddress> ClearAddresses { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new CustomersConfiguration(_schemaName));
            modelBuilder.Configurations.Add(new AddressesConfiguration(_schemaName));
            modelBuilder.Configurations.Add(new CustomerDetailsConfiguration(_schemaName));
            modelBuilder.Configurations.Add(new ClearAddressConfiguration(_schemaName));

        }
    }
}
