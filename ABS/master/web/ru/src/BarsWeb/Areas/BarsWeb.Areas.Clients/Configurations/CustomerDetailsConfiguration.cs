using System.Data.Entity.ModelConfiguration;
using BarsWeb.Areas.Clients.Models;

namespace BarsWeb.Areas.Clients.Configurations
{
    public class CustomerDetailsConfiguration : EntityTypeConfiguration<CustomerDetail>
    {
        /// <summary>
        ///     Constructor CustomerDetailsConfiguration
        /// </summary>
        public CustomerDetailsConfiguration(string schemaName)
        {
            ToTable("V_CUSTOMERW", schemaName);

            Property(i => i.CustomerId).HasColumnName("RNK");
            Property(i => i.Code).HasColumnName("TAG");
            Property(i => i.Value).HasColumnName("VALUE");
            //Property(i => i.UserId).HasColumnName("ISP");
        }
    }
}
