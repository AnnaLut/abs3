using System.Data.Entity;
using BarsWeb.Areas.Acct.Configurations;
using BarsWeb.Core;

namespace BarsWeb.Areas.Acct.Models
{

    public class AcctDbContext : DbContext
    {
        private readonly string _schemaName = Constants.SchemaName;

        public AcctDbContext(string connectionString) : base(connectionString)
        {
            Configuration.LazyLoadingEnabled = false;
            //Configuration.ProxyCreationEnabled = true;
        }

        public DbSet<Account> Accounts { get; set; }
        public DbSet<AccountSaldo> AccountsSaldo { get; set; }
        public DbSet<ReservedAccount> ReservedAccounts { get; set; }
        public DbSet<StatementPayment> StatementPayments { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new AccountsConfiguration(_schemaName));
            modelBuilder.Configurations.Add(new ReservedAccountsConfiguration(_schemaName));
            modelBuilder.Configurations.Add(new StatementPaymentConfiguration(_schemaName));
            modelBuilder.Configurations.Add(new AccountsSaldoConfiguration(_schemaName));
        }
    }
}
