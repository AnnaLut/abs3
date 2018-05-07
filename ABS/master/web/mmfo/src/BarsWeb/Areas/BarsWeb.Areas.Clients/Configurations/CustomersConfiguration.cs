using System.Data.Entity.ModelConfiguration;
using BarsWeb.Areas.Clients.Models;

namespace BarsWeb.Areas.Clients.Configurations
{
    public class CustomersConfiguration : EntityTypeConfiguration<Customer>
    {
        /// <summary>
        ///     Constructor AccountConfiguration
        /// </summary>
        public CustomersConfiguration(string schemaName)
        {

            ToTable("V_CUSTOMER", schemaName);

            Property(i => i.Id).HasColumnName("RNK");
            Property(i => i.TypeId).HasColumnName("CUSTTYPE");
            Property(i => i.TypeName).HasColumnName("CUSTTYPENAME");
            Property(i => i.DateOpen).HasColumnName("DATE_ON");
            Property(i => i.DateClosed).HasColumnName("DATE_OFF");
            Property(i => i.ContractNumber).HasColumnName("ND");
            Property(i => i.Name).HasColumnName("NMK");
            Property(i => i.NameShort).HasColumnName("NMKK");
            Property(i => i.NameInternational).HasColumnName("NMKV");
            Property(i => i.Code).HasColumnName("OKPO");
            Property(i => i.Branch).HasColumnName("BRANCH");
            Property(i => i.Sed).HasColumnName("SED");

            Property(i => i.RequestType).HasColumnName("REQ_TYPE");
            Property(i => i.RequestStatus).HasColumnName("REQ_STATUS");

            //Property(i => i.SearchColumn).HasColumnName("SEARCH_COLUMN");
        }
    }
}
