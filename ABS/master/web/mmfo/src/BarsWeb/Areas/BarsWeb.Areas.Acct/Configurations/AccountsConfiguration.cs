using System.Data.Entity.ModelConfiguration;
using BarsWeb.Areas.Acct.Models;

namespace BarsWeb.Areas.Acct.Configurations
{
    public class AccountsConfiguration : EntityTypeConfiguration<Account>
    {
        /// <summary>
        ///     Constructor AccountConfiguration
        /// </summary>
        public AccountsConfiguration(string schemaName)
        {
            ToTable("V_ACCOUNTS", schemaName);

            Property(i => i.Id).HasColumnName("ACC");
            Property(i => i.ClientId).HasColumnName("RNK");
            Property(i => i.UserId).HasColumnName("ISP");
            Property(i => i.BankId).HasColumnName("KF");
            Property(i => i.Branch).HasColumnName("BRANCH");
 
            Property(i => i.Number).HasColumnName("NLS");
            Property(i => i.Name).HasColumnName("NMS");
            Property(i => i.CurrencyId).HasColumnName("KV");
            Property(i => i.CurrencyCode).HasColumnName("LCV");
            Property(i => i.Type).HasColumnName("TIP");
            Property(i => i.Balance).HasColumnName("OSTC");
            Property(i => i.PlannedBalance).HasColumnName("OSTB");

            Property(i => i.LastActiveDate).HasColumnName("DAPP");
        }
    }
}
