using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.Clients.Models;
using BarsWeb.Core.Infrastructure.Kernel.DI.Abstract;
using BarsWeb.Core.Models.Kernel;
using Oracle.DataAccess.Client;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Clients.Infrastructure.Repository
{
    public class ClearAddressRepository : IClearAddressRepository
    {

        private readonly ClientsDbContext _dbContext;
        private readonly BarsSql _sqlRequest;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private const string SelectColumns = @" RNK as Rnk,
                                                TYPE_NAME as TypeName,
                                                ADDRESS as Address,
                                                AREA_NAME as AreaName,
                                                COUNTRY_NAME as CountryName,
                                                DOMAIN as Domain,
                                                FIRSTNAME as FirstName,
                                                HOUSE_NUM as HouseNum, 
                                                REGION as Region,
                                                SURNAME as SurName,
                                                PARENTNAME as ParentName,
                                                REGION_NAME as RegionName,
                                                LOCALITY as Locality,
                                                SETTLEMENT_NAME as SettlementName,
                                                STREET_NAME as StreetName,
                                                REGION_ID as RegionId,
                                                AREA_ID as AreaId,
                                                SETTLEMENT_ID as SettlementId,
                                                COUNTRY as CountryId,
                                                TYPE_ID as TypeId,
                                                LOCALITY_TYPE as LocalityType,
                                                HOME_TYPE as HomeType,
                                                ZIP as AddressIndex,
                                                STREET_TYPE as StreetType,
                                                STR_TP_ID as StreetTypeId,
                                                STR_TP_NM as StreetTypeNm,
                                                STREET as Street,
                                                HOME as Home,
                                                HOMEPART as HomePart,
                                                ROOM as Room,
                                                COMM as Comm,
                                                SETTLEMENT_TP_NM as SettlementTypeName,
                                                HOMEPART_TYPE as HomePartType,
                                                ROOM_TYPE as RoomType,
                                                SETTLEMENT_TP_ID as SettlementTypeId,
                                                STREET_ID as StreetId,
                                                LOCALITY_TYPE_NAME as LocalityTypeName,
                                                STREET_TYPE_NAME as StreetTypeName,
                                                HOME_TYPE_NAME as HomeTypeName,
                                                HOMEPART_TYPE_NAME as HomePartTypeName,
                                                ROOM_TYPE_NAME as RoomTypeName,
                                                HOUSE_ID as HouseId, 
                                                AHT_TP_ID as HomeTypeId, 
                                                AHT_TP_VALUE as HomeTypeNm, 
                                                AHPT_TP_ID as HomePartTypeId, 
                                                AHPT_TP_VALUE as HomePartTypeNm, 
                                                ART_TP_ID as RoomTypeId, 
                                                ART_TP_VALUE as RoomTypeNm ";
        public ClearAddressRepository(IClientsModel model, IKendoSqlTransformer sqlTransformer)
        {
            _dbContext = model.GetDbContext();
            _sqlRequest = new BarsSql();
            _sqlTransformer = sqlTransformer;
        }

        public IQueryable<ClearAddress> GetClearCustomerAddresses(string domain, string region, string street, decimal? regionId, decimal? areaId, decimal? settlementId, string locality, decimal all, string mode, DataSourceRequest request)
        {
            InitClearAddress(domain, region, street, regionId, areaId, settlementId, locality, all, mode);
            var sql = _sqlTransformer.TransformSql(_sqlRequest, request);
            var result = _dbContext.Database.SqlQuery<ClearAddress>(sql.SqlText, sql.SqlParams).AsQueryable();
            return result;

        }

        private void InitClearAddress(string domain, string region, string street, decimal? regionId, decimal? areaId, decimal? settlementId, string locality, decimal all, string mode)
        {
            switch (mode)
            {
                case "fromRegion":

                    _sqlRequest.SqlText = string.Format(@"  select 
                                                                {0} 
                                                            from 
                                                                v_customer_address_import w 
                                                            where 
                                                                (w.domain = :p_domain_1) and 
                                                                ((w.REGION_ID is null and {1} = 0) or ( {1} = 1)) and 
                                                                w.country=804 
                                                            union all
                                                            select
                                                                {0} 
                                                            from 
                                                                v_customer_address_import w 
                                                            where 
                                                                (w.domain is null and :p_domain_2 is null) and 
                                                                ((w.REGION_ID is null and {1} = 0) or ( {1} = 1)) and 
                                                                w.country=804", SelectColumns, all);
                    _sqlRequest.SqlParams = new object[]
                    {
                        new OracleParameter("p_domain_1", OracleDbType.Varchar2) {Value = domain},
                        new OracleParameter("p_domain_2", OracleDbType.Varchar2) {Value = domain}
                    };

                    break;

                case "fromArea":

                    _sqlRequest.SqlText = string.Format(@"SELECT
                                                                {0}
                                                              FROM v_customer_address_import w
                                                              WHERE (w.REGION_ID = :p_regionId_1 OR :p_regionId_2 IS NULL)
                                                                    AND ( (w.region IS NULL AND :p_region_1 IS NULL))
                                                                    AND ( (w.AREA_ID IS NULL AND {1} = 0) OR ( {1} = 1))
                                                                    AND w.country = 804
                                                             UNION ALL
                                                             SELECT 
                                                                {0}
                                                              FROM v_customer_address_import w
                                                             WHERE  (w.REGION_ID = :p_regionId_3 OR :p_regionId_4 IS NULL)
                                                                   AND ( (w.region = :p_region_2))
                                                                   AND ( (w.AREA_ID IS NULL AND {1} = 0) OR ({1} = 1))
                                                                   AND w.country = 804", SelectColumns, all);

                    _sqlRequest.SqlParams = new object[]
                    {
                        new OracleParameter("p_regionId_1", OracleDbType.Decimal) {Value = regionId},
                        new OracleParameter("p_regionId_2", OracleDbType.Decimal) {Value = regionId},
                        new OracleParameter("p_region_1", OracleDbType.Varchar2) {Value = region},
                        new OracleParameter("p_regionId_3", OracleDbType.Decimal) {Value = regionId},
                        new OracleParameter("p_regionId_4", OracleDbType.Decimal) {Value = regionId},
                        new OracleParameter("p_region_2", OracleDbType.Varchar2) {Value = region}
                    };

                    break;

                case "fromLocality":

                    _sqlRequest.SqlText = string.Format(@"SELECT
                                                                {0}
                                                              FROM v_customer_address_import w
                                                             WHERE     (w.REGION_ID = :p_regionId_1 OR :p_regionId_2 IS NULL)
                                                                   AND (w.AREA_ID = :p_areaId_1 OR :p_areaId_2 IS NULL)
                                                                   AND ( (w.locality = :p_locality_1))
                                                                   AND ( (w.settlement_id IS NULL AND {1} = 0) OR ( {1} = 1))
                                                                   AND w.country = 804
                                                             UNION ALL
                                                             SELECT 
                                                                {0}
                                                              FROM v_customer_address_import w
                                                             WHERE     (w.REGION_ID = :p_regionId_3 OR :p_regionId_4 IS NULL)
                                                                   AND (w.AREA_ID = :p_areaId_3 OR :p_areaId_4 IS NULL)
                                                                   AND ( (w.locality IS NULL AND :p_locality_2 IS NULL))
                                                                   AND ( (w.settlement_id IS NULL AND {1} = 0) OR ( {1} = 1))
                                                                   AND w.country = 804", SelectColumns, all);

                    _sqlRequest.SqlParams = new object[]
                    {
                        new OracleParameter("p_regionId_1", OracleDbType.Decimal) {Value = regionId},
                        new OracleParameter("p_regionId_2", OracleDbType.Decimal) {Value = regionId},
                        new OracleParameter("p_areaId_1", OracleDbType.Decimal) {Value = areaId},
                        new OracleParameter("p_areaId_2", OracleDbType.Decimal) {Value = areaId},
                        new OracleParameter("p_locality_1", OracleDbType.Varchar2) {Value = locality},
                        new OracleParameter("p_regionId_3", OracleDbType.Decimal) {Value = regionId},
                        new OracleParameter("p_regionId_4", OracleDbType.Decimal) {Value = regionId},
                        new OracleParameter("p_areaId_3", OracleDbType.Decimal) {Value = areaId},
                        new OracleParameter("p_areaId_4", OracleDbType.Decimal) {Value = areaId},
                        new OracleParameter("p_locality_2", OracleDbType.Varchar2) {Value = locality}
                    };

                    break;

                case "fromStreet":

                    _sqlRequest.SqlText = string.Format(@"select                                                 
                                                                {0}
                                                                from bars.v_customer_address_import w 
                                                                where (w.REGION_ID = :p_regionId_1 or :p_regionId_2 is null)
                                                                and (w.AREA_ID = :p_areaId_1 or :p_areaId_2 is null)
                                                                and (w.SETTLEMENT_ID = :p_settlementId_1 or :p_settlementId_2 is null)
                                                                and (((TRANSLATE(TRIM( REGEXP_REPLACE ( REGEXP_REPLACE (UPPER(bars.STRTOK(w.ADDRESS,',',1)),'^(\,|\.|ПЛ |ПЛ\.|ПР |ПР\.|ПРОВ |ПРОВ\.|ПЕР |ПЕР\.|\ПР-К |\ПР-К.|ПРОВУЛОК |ПРОВУЛОК\.|ПЕРЕУЛОК |ПЕРЕУЛОК\.|ВУЛ\.|ВУЛ |УЛ |УЛ\.|ВУЛИЦЯ |ПРОСПЕКТ |ПРОСП |ПРОСПЕКТ\.|ПРОСП\.|ПР-Т |ПР-Т\.|ПРТ |ПРТ\.)',''),'(\,|\.|\*|\""|\\|\/| Б | Б\.| БУД | БУДИНОК |\d)','',3)),'ETYUIOPAHKXCBM','ЕТУИІОРАНКХСВМ')) = :p_street_1))
                                                                and((w.street_id is null and {1} = 0) or({1} = 1))
                                                                and w.country=804      
                                                            UNION
                                                           select                                                
                                                                {0}
                                                            from bars.v_customer_address_import w
                                                            where (w.REGION_ID = :p_regionId_3 or :p_regionId_4 is null)
                                                                and(w.AREA_ID = :p_areaId_3 or :p_areaId_4 is null)
                                                                and(w.SETTLEMENT_ID = :p_settlementId_3 or :p_settlementId_4 is null)
                                                                and(((TRANSLATE(TRIM(REGEXP_REPLACE(REGEXP_REPLACE(UPPER(bars.STRTOK(w.ADDRESS, ',', 1)), '^(\,|\.|ПЛ |ПЛ\.|ПР |ПР\.|ПРОВ |ПРОВ\.|ПЕР |ПЕР\.|\ПР-К |\ПР-К.|ПРОВУЛОК |ПРОВУЛОК\.|ПЕРЕУЛОК |ПЕРЕУЛОК\.|ВУЛ\.|ВУЛ |УЛ |УЛ\.|ВУЛИЦЯ |ПРОСПЕКТ |ПРОСП |ПРОСПЕКТ\.|ПРОСП\.|ПР-Т |ПР-Т\.|ПРТ |ПРТ\.)', ''), '(\,|\.|\*|\""|\\|\/| Б | Б\.| БУД | БУДИНОК |\d)', '', 3)), 'ETYUIOPAHKXCBM', 'ЕТУИІОРАНКХСВМ')) is null and :p_street_2 is null))
                                                                and((w.street_id is null and {1} = 0) or({1} = 1))
                                                                and w.country=804", SelectColumns, all);



                    _sqlRequest.SqlParams = new object[]
                    {
                        new OracleParameter("p_regionId_1", OracleDbType.Decimal) {Value = regionId},
                        new OracleParameter("p_regionId_2", OracleDbType.Decimal) {Value = regionId},
                        new OracleParameter("p_areaId_1", OracleDbType.Decimal) {Value = areaId},
                        new OracleParameter("p_areaId_2", OracleDbType.Decimal) {Value = areaId},
                        new OracleParameter("p_settlementId_1", OracleDbType.Decimal) {Value = settlementId},
                        new OracleParameter("p_settlementId_2", OracleDbType.Decimal) {Value = settlementId},
                        new OracleParameter("p_street_1", OracleDbType.Varchar2) {Value = street},
                        new OracleParameter("p_regionId_3", OracleDbType.Decimal) {Value = regionId},
                        new OracleParameter("p_regionId_4", OracleDbType.Decimal) {Value = regionId},
                        new OracleParameter("p_areaId_3", OracleDbType.Decimal) {Value = areaId},
                        new OracleParameter("p_areaId_4", OracleDbType.Decimal) {Value = areaId},
                        new OracleParameter("p_settlementId_3", OracleDbType.Decimal) {Value = settlementId},
                        new OracleParameter("p_settlementId_4", OracleDbType.Decimal) {Value = settlementId},
                        new OracleParameter("p_street_2", OracleDbType.Varchar2) {Value = street}
                    };

                    break;

                default:

                    _sqlRequest.SqlText = string.Format(@"  select 
                                                                {0} 
                                                            from 
                                                                v_customer_address_import w 
                                                            where 
                                                                w.country = 804", SelectColumns);
                    _sqlRequest.SqlParams = new object[] { };
                    break;
            }
        }

        public List<ClearAddress> GetClearAddressByRnk(decimal rnk)
        {
            _sqlRequest.SqlText = string.Format(@"  select 
                                                        {0} 
                                                    from 
                                                        v_customer_address_import w 
                                                    where 
                                                        w.country = 804 and w.rnk = :p_rnk", SelectColumns);

            _sqlRequest.SqlParams = new object[] { new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = rnk } };

            return _dbContext.Database.SqlQuery<ClearAddress>(_sqlRequest.SqlText, _sqlRequest.SqlParams).ToList();
        }

        public void SaveClearAddress(List<ClearAddress> clearAddress)
        {

            try
            {
                _sqlRequest.SqlText = @"
                                        begin   
                                            kl.setFullCustomerAddress(  :p_rnk, 
                                                                        :p_typeId,   
                                                                        :p_country,   
                                                                        :p_zip,   
                                                                        :p_domain,   
                                                                        :p_region,   
                                                                        :p_locality,   
                                                                        :p_address,   
                                                                        :p_territoryId,   
                                                                        :p_locality_type,   
                                                                        :p_street_type,   
                                                                        :p_street,   
                                                                        :p_home_type,   
                                                                        :p_home,   
                                                                        :p_homepart_type,   
                                                                        :p_homepart,   
                                                                        :p_room_type,   
                                                                        :p_room,   
                                                                        :p_comment,   
                                                                        :p_region_id,   
                                                                        :p_area_id,   
                                                                        :p_settlement_id,   
                                                                        :p_street_id,   
                                                                        :p_house_id, 
                                                                        :p_flag_visa 
                                                                                );
                                        end; ";

                foreach (var address in clearAddress)
                {
                    _sqlRequest.SqlParams = new object[]
                    {
                        new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = address.Rnk },
                        new OracleParameter("p_typeId", OracleDbType.Decimal) { Value = address.TypeId },
                        new OracleParameter("p_country", OracleDbType.Decimal) { Value = address.CountryId },
                        new OracleParameter("p_zip", OracleDbType.Varchar2) { Value = address.AddressIndex },
                        new OracleParameter("p_domain", OracleDbType.Varchar2) { Value = address.RegionName },
                        new OracleParameter("p_region", OracleDbType.Varchar2) { Value = address.AreaName },
                        new OracleParameter("p_locality", OracleDbType.Varchar2) { Value = address.SettlementName },
                        new OracleParameter("p_address", OracleDbType.Varchar2) { Value = address.Address },
                        new OracleParameter("p_territoryId", OracleDbType.Decimal) { Value = null },
                        new OracleParameter("p_locality_type", OracleDbType.Decimal) { Value = address.SettlementTypeId == 0 ? null : address.SettlementTypeId},
                        new OracleParameter("p_street_type", OracleDbType.Decimal) { Value = address.StreetTypeId == 0 ? null : address.StreetTypeId},
                        new OracleParameter("p_street", OracleDbType.Varchar2) { Value = address.StreetName },
                        new OracleParameter("p_home_type", OracleDbType.Decimal) { Value = address.HomeTypeId == 0 ? null : address.HomeTypeId},
                        new OracleParameter("p_home", OracleDbType.Varchar2) { Value = address.Home },
                        new OracleParameter("p_homepart_type", OracleDbType.Decimal) { Value = address.HomePartTypeId == 0 ? null : address.HomePartTypeId},
                        new OracleParameter("p_homepart", OracleDbType.Varchar2) { Value = address.HomePart },
                        new OracleParameter("p_room_type", OracleDbType.Decimal) { Value = address.RoomTypeId == 0 ? null : address.RoomTypeId},
                        new OracleParameter("p_room", OracleDbType.Varchar2) { Value = address.Room },
                        new OracleParameter("p_comment", OracleDbType.Varchar2) { Value = address.Comm },
                        new OracleParameter("p_region_id", OracleDbType.Decimal) { Value = address.RegionId },
                        new OracleParameter("p_area_id", OracleDbType.Decimal) { Value = address.AreaId },
                        new OracleParameter("p_settlement_id", OracleDbType.Decimal) { Value = address.SettlementId },
                        new OracleParameter("p_street_id", OracleDbType.Decimal) { Value = address.StreetId },
                        new OracleParameter("p_house_id", OracleDbType.Decimal) { Value = address.HouseId },
                        new OracleParameter("p_flag_visa", OracleDbType.Decimal) { Value = 0 }
                    };

                    _dbContext.Database.ExecuteSqlCommand(_sqlRequest.SqlText, _sqlRequest.SqlParams);
                }
            }
            finally
            {
                _dbContext.Dispose();
            }


        }
    }


    public interface IClearAddressRepository
    {
        List<ClearAddress> GetClearAddressByRnk(decimal rnk);
        IQueryable<ClearAddress> GetClearCustomerAddresses(string domain, string region, string street, decimal? regionId, decimal? areaId, decimal? settlementId, string locality, decimal all, string mode, [DataSourceRequest] DataSourceRequest request);
        void SaveClearAddress(List<ClearAddress> clearAddress);
    }

}