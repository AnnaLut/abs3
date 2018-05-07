using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BarsWeb.Areas.Clients.Models;
using System.Data.Entity.ModelConfiguration;

namespace BarsWeb.Areas.Clients.Configurations
{
    public class ClearAddressConfiguration : EntityTypeConfiguration<ClearAddress>
    {

        /// <summary>
        ///     Constructor ClearAddressesConfiguration
        /// </summary>
        public ClearAddressConfiguration(string schemaName)
        {
            ToTable("V_CUSTOMER_ADDRESS_IMPORT", schemaName);

            Property(i => i.Rnk).HasColumnName("RNK");
            Property(i => i.TypeId).HasColumnName("TYPE_ID");
            Property(i => i.TypeName).HasColumnName("TYPE_NAME");
            Property(i => i.AddressIndex).HasColumnName("ZIP");
            Property(i => i.Address).HasColumnName("ADDRESS");
            Property(i => i.CountryName).HasColumnName("COUNTRY_NAME");
            Property(i => i.FirstName).HasColumnName("FIRSTNAME");
            Property(i => i.SurName).HasColumnName("SURNAME");
            Property(i => i.ParentName).HasColumnName("PARENTNAME");
            Property(i => i.Comm).HasColumnName("COMM");
            Property(i => i.CountryId).HasColumnName("COUNTRY");

            //////////////////////////////////////////////////////////

            Property(i => i.Domain).HasColumnName("DOMAIN");
            Property(i => i.Region).HasColumnName("REGION");
            Property(i => i.Locality).HasColumnName("LOCALITY");
            Property(i => i.Street).HasColumnName("STREET");
            Property(i => i.Home).HasColumnName("HOME");
            Property(i => i.HomePart).HasColumnName("HOMEPART");
            Property(i => i.Room).HasColumnName("ROOM");

            //////////////////////////////////////////////////////////

            Property(i => i.RegionId).HasColumnName("REGION_ID");
            Property(i => i.RegionName).HasColumnName("REGION_NAME");
            Property(i => i.AreaId).HasColumnName("AREA_ID");
            Property(i => i.AreaName).HasColumnName("AREA_NAME");
            Property(i => i.SettlementId).HasColumnName("SETTLEMENT_ID");
            Property(i => i.SettlementName).HasColumnName("SETTLEMENT_NAME");
            Property(i => i.StreetId).HasColumnName("STREET_ID");
            Property(i => i.StreetName).HasColumnName("STREET_NAME");
            Property(i => i.HouseId).HasColumnName("HOUSE_ID");
            Property(i => i.HouseNum).HasColumnName("HOUSE_NUM");

            //////////////////////////////////////////////////////////

            Property(i => i.LocalityType).HasColumnName("LOCALITY_TYPE");
            Property(i => i.LocalityTypeName).HasColumnName("LOCALITY_TYPE_NAME");

            Property(i => i.StreetType).HasColumnName("STREET_TYPE");
            Property(i => i.StreetTypeName).HasColumnName("STREET_TYPE_NAME");

            Property(i => i.HomeType).HasColumnName("HOME_TYPE");
            Property(i => i.HomeTypeName).HasColumnName("HOME_TYPE_NAME");

            Property(i => i.HomePartType).HasColumnName("HOMEPART_TYPE");
            Property(i => i.HomePartTypeName).HasColumnName("HOMEPART_TYPE_NAME");

            Property(i => i.RoomType).HasColumnName("ROOM_TYPE");
            Property(i => i.RoomTypeName).HasColumnName("ROOM_TYPE_NAME");

            //////////////////////////////////////////////////////////

            Property(i => i.SettlementTypeId).HasColumnName("SETTLEMENT_TP_ID");
            Property(i => i.SettlementTypeName).HasColumnName("SETTLEMENT_TP_NM");

            Property(i => i.StreetTypeId).HasColumnName("STR_TP_ID");
            Property(i => i.StreetTypeNm).HasColumnName("STR_TP_NM");

            Property(i => i.HomeTypeId).HasColumnName("AHT_TP_ID");
            Property(i => i.HomeTypeNm).HasColumnName("AHT_TP_VALUE");

            Property(i => i.HomePartTypeId).HasColumnName("AHPT_TP_ID");
            Property(i => i.HomePartTypeNm).HasColumnName("AHPT_TP_VALUE");

            Property(i => i.RoomTypeId).HasColumnName("ART_TP_ID");
            Property(i => i.RoomTypeNm).HasColumnName("ART_TP_VALUE");
        }
    }
}