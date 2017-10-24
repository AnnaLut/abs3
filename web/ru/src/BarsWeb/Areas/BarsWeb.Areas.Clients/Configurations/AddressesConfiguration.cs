using System.Data.Entity.ModelConfiguration;
using BarsWeb.Areas.Clients.Models;

namespace BarsWeb.Areas.Clients.Configurations
{
    public class AddressesConfiguration : EntityTypeConfiguration<Address>
    {
        /// <summary>
        ///     Constructor AddressesConfiguration
        /// </summary>
        public AddressesConfiguration(string schemaName)
        {
            ToTable("V_CUSTOMER_ADDRESS", schemaName);

            Property(i => i.CustomerId).HasColumnName("RNK");
            Property(i => i.TypeId).HasColumnName("TYPE_ID");
            Property(i => i.CountryId).HasColumnName("COUNTRY");
            Property(i => i.Zip).HasColumnName("ZIP");
            Property(i => i.Domain).HasColumnName("DOMAIN");
            Property(i => i.Region).HasColumnName("REGION");
            Property(i => i.TerritoryId).HasColumnName("TERRITORY_ID");
            //Property(i => i.AddressStr).HasColumnName("ADDRESS");
            Property(i => i.LocalityType).HasColumnName("LOCALITY_TYPE");
            Property(i => i.Locality).HasColumnName("LOCALITY");
            Property(i => i.StreetType).HasColumnName("STREET_TYPE");
            Property(i => i.Street).HasColumnName("STREET");
            Property(i => i.HomeType).HasColumnName("HOME_TYPE");
            Property(i => i.Home).HasColumnName("HOME");
            Property(i => i.HomepartType).HasColumnName("HOMEPART_TYPE");
            Property(i => i.Homepart).HasColumnName("HOMEPART");
            Property(i => i.RoomType).HasColumnName("ROOM_TYPE");
            Property(i => i.Room).HasColumnName("ROOM");
        }
    }
}
