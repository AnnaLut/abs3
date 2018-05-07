using System.Data.Entity.ModelConfiguration;
using BarsWeb.Areas.Acct.Models;

namespace BarsWeb.Areas.Acct.Configurations
{
    public class ReservedAccountsConfiguration : EntityTypeConfiguration<ReservedAccount>
    {
        /// <summary>
        ///     Constructor AccountConfiguration
        /// </summary>
        public ReservedAccountsConfiguration(string schemaName)
        {
            ToTable("V_RESERVED_ACC", schemaName);

            Property(i => i.Id).HasColumnName("ACC");
            Property(i => i.Number).HasColumnName("NLS");
            Property(i => i.CurrencyId).HasColumnName("KV");
            Property(i => i.Name).HasColumnName("NMS");
            Property(i => i.IsOpen).HasColumnName("FLAG_OPEN");
            Property(i => i.CustomerId).HasColumnName("RNK");
            Property(i => i.CustomerCode).HasColumnName("OKPO");
            Property(i => i.CustomerName).HasColumnName("NMK"); 
        }
    }
}
