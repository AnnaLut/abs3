using BarsWeb.Areas.Clients.Models;
using BarsWeb.Core.Infrastructure.Kernel.DI.Abstract;
using BarsWeb.Core.Models.Kernel;
using Kendo.Mvc.UI;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.Clients.Models.Enums;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Clients.Infrastructure.Repository
{
    public class GeneralClearAddressRepository : IGeneralClearAddressRepository
    {
        public BarsSql _getSql;
        private readonly ClientsDbContext _dbContext;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        const string SelectStatement = "select NCOUNT as Ncount,";
        private Dictionary<GeneralClearAddressType, string> _saveConfirmSqlText =
            new Dictionary<GeneralClearAddressType, string>
            {
                {GeneralClearAddressType.Region,        "BARS.PKG_ADR_COMPARE.SET_REGION_FULL_MATCH()" },
                {GeneralClearAddressType.Area,          "BARS.PKG_ADR_COMPARE.SET_AREA_FULL_MATCH()" },
                {GeneralClearAddressType.Settlement,    "BARS.PKG_ADR_COMPARE.SET_SETTLEMENTS_FULL_MATCH()" },
                {GeneralClearAddressType.Street,        "BARS.PKG_ADR_COMPARE.SET_STREETS_FULL_MATCH()" }
            };
        public GeneralClearAddressRepository(IKendoSqlTransformer sqlTransformer, IClientsModel model, IKendoSqlCounter kendoSqlCounter)
        {
            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _dbContext = model.GetDbContext();
        }


        public List<GeneralClearAddress> GetRegion([DataSourceRequest] DataSourceRequest request)
        {
            InitRegion();
            BarsSql sql = _sqlTransformer.TransformSql(_getSql, request);
            List<GeneralClearAddress> result = _dbContext.Database.SqlQuery<GeneralClearAddress>(sql.SqlText, sql.SqlParams).ToList();
            return result;
        }


        public List<GeneralClearAddress> GetArea([DataSourceRequest] DataSourceRequest request)
        {
            InitArea();
            BarsSql sql = _sqlTransformer.TransformSql(_getSql, request);
            List<GeneralClearAddress> result = _dbContext.Database.SqlQuery<GeneralClearAddress>(sql.SqlText, sql.SqlParams).ToList();
            return result;
        }

        public List<GeneralClearAddress> GetLocality([DataSourceRequest] DataSourceRequest request)
        {
            InitLocality();
            BarsSql sql = _sqlTransformer.TransformSql(_getSql, request);
            List<GeneralClearAddress> result = _dbContext.Database.SqlQuery<GeneralClearAddress>(sql.SqlText, sql.SqlParams).ToList();
            return result;
        }

        public List<GeneralClearAddress> GetStreet([DataSourceRequest] DataSourceRequest request)
        {
            InitStreet();
            BarsSql sql = _sqlTransformer.TransformSql(_getSql, request);
            List<GeneralClearAddress> result = _dbContext.Database.SqlQuery<GeneralClearAddress>(sql.SqlText, sql.SqlParams).ToList();
            return result;
        }


        public List<GeneralClearAddress> GetInstallConformityGrid([DataSourceRequest] DataSourceRequest request, GeneralClearAddressType type, decimal? regionId, decimal? areaId, decimal? settlementId)
        {
            InitToInstallConformityGrid(type, regionId, areaId, settlementId);
            BarsSql sql = _sqlTransformer.TransformSql(_getSql, request);
            List<GeneralClearAddress> result = _dbContext.Database.SqlQuery<GeneralClearAddress>(sql.SqlText, sql.SqlParams).ToList();
            return result;
        }

        public decimal GetRegionCount([DataSourceRequest] DataSourceRequest request)
        {
            InitRegion();
            BarsSql sql = _kendoSqlCounter.TransformSql(_getSql, request);
            decimal result = _dbContext.Database.SqlQuery<decimal>(sql.SqlText, sql.SqlParams).Single();
            return result;
        }

        public decimal GetAreaCount([DataSourceRequest] DataSourceRequest request)
        {
            InitArea();
            BarsSql sql = _kendoSqlCounter.TransformSql(_getSql, request);
            decimal result = _dbContext.Database.SqlQuery<decimal>(sql.SqlText, sql.SqlParams).Single();
            return result;
        }


        public decimal GetLocalityCount([DataSourceRequest] DataSourceRequest request)
        {
            InitLocality();
            BarsSql sql = _kendoSqlCounter.TransformSql(_getSql, request);
            decimal result = _dbContext.Database.SqlQuery<decimal>(sql.SqlText, sql.SqlParams).Single();
            return result;
        }

        public decimal GetStreetCount([DataSourceRequest] DataSourceRequest request)
        {
            InitStreet();
            BarsSql sql = _kendoSqlCounter.TransformSql(_getSql, request);
            decimal result = _dbContext.Database.SqlQuery<decimal>(sql.SqlText, sql.SqlParams).Single();
            return result;
        }

        public decimal GetInstallConformityGridCount([DataSourceRequest] DataSourceRequest request, GeneralClearAddressType type, decimal? regionId, decimal? areaId, decimal? settlementId)
        {
            InitToInstallConformityGrid(type, regionId, areaId, settlementId);
            BarsSql sql = _kendoSqlCounter.TransformSql(_getSql, request);
            decimal result = _dbContext.Database.SqlQuery<decimal>(sql.SqlText, sql.SqlParams).Single();
            return result;
        }

        private void InitRegion()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format("{0} DOMAIN as Domain, REGION_NAME as RegionName from v_region_by_domain ", SelectStatement),
                SqlParams = new object[] { }
            };

        }


        private void InitArea()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format("{0} REGION_NAME as RegionName, REGION as Region, AREA_NAME as AreaName, REGION_ID as RegionId from v_region_by_region ", SelectStatement),
                SqlParams = new object[] { }
            };

        }

        private void InitLocality()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(" {0} LOCALITY as Locality, SETTLEMENT_NAME as SettlementName, REGION_NAME as RegionName, AREA_NAME	as AreaName, REGION_ID as RegionId, AREA_ID as AreaId from V_SETTLEMENT_BY_LOCALITY", SelectStatement),
                SqlParams = new object[] { }
            };

        }

        private void InitStreet()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(" {0} STREET as Street, STREET_NAME as StreetName, SETTLEMENT_NAME as SettlementName, REGION_NAME as RegionName, AREA_NAME	as AreaName, REGION_ID as RegionId, AREA_ID as AreaId, SETTLEMENT_ID as SettlementId from v_street_by_street", SelectStatement),
                SqlParams = new object[] { }
            };

        }

        private void InitToInstallConformityGrid(GeneralClearAddressType type, decimal? regionId, decimal? areaId, decimal? settlementId)
        {
            switch (type)
            {
                case GeneralClearAddressType.Region:
                    _getSql = new BarsSql()
                    {
                        SqlText = string.Format("SELECT REGION_ID as RegionId, REGION_NM  as RegionName FROM V_ADR_REGIONS"),
                        SqlParams = new object[] { }
                    };
                    break;
                case GeneralClearAddressType.Area:
                    _getSql = new BarsSql()
                    {
                        SqlText = string.Format("SELECT AREA_NM as AreaName, AREA_ID as AreaId FROM V_ADR_AREAS W WHERE W.REGION_ID = :p_region_id"),
                        SqlParams = new object[] { new OracleParameter("p_region_id", OracleDbType.Decimal) { Value = regionId } }
                    };
                    break;
                case GeneralClearAddressType.Settlement:
                    _getSql = new BarsSql()
                    {
                        SqlText = string.Format(@"SELECT SETL_NM as SettlementName, SETL_ID as SettlementId, SETL_TP_NM as SettlementTypeName 
                                                  FROM V_ADR_SETTLEMENTS W 
                                                  WHERE W.REGION_ID  = :p_region_id AND (W.AREA_ID = :p_area_id_1 OR :p_area_id_2 IS NULL)"),
                        SqlParams = new object[]
                        {
                                                            new OracleParameter("p_region_id", OracleDbType.Decimal) { Value = regionId },
                                                            new OracleParameter("p_area_id_1", OracleDbType.Decimal) { Value = areaId },
                                                            new OracleParameter("p_area_id_2", OracleDbType.Decimal) { Value = areaId }
                        }
                    };
                    break;
                case GeneralClearAddressType.Street:
                    _getSql = new BarsSql()
                    {
                        SqlText = string.Format("SELECT STR_NM as StreetName, STR_ID as StreetId, STR_TP_NM as StreetTypeName FROM V_ADR_STREETS W WHERE  W.SETL_ID = :p_settlement_id"),
                        SqlParams = new object[]
                       {
                                                            new OracleParameter("p_settlement_id", OracleDbType.Decimal) { Value = settlementId }
                       }
                    };
                    break;
            }
        }

        private void InitInstallConformity(GeneralClearAddress generalClearAddress)
        {
            _getSql = new BarsSql();
            switch (generalClearAddress.Type)
            {
                case GeneralClearAddressType.Region:

                    _getSql.SqlText = @"
                                                                        begin   
                                                                            PKG_ADR_COMPARE.ins_regions_match( :p_domain, 
                                                                                                               :p_region_id);
                                                                        end; ";


                    _getSql.SqlParams = new object[]
                    {
                                                        new OracleParameter("p_domain", OracleDbType.Varchar2) { Value = generalClearAddress.Domain },
                                                        new OracleParameter("p_region_id", OracleDbType.Decimal) { Value = generalClearAddress.RegionId }

                    };

                    break;
                case GeneralClearAddressType.Area:
                    _getSql.SqlText = @"
                                                                        begin   
                                                                            PKG_ADR_COMPARE.ins_areas_match( p_domain => :p_domain,
                                                                                                             p_region => :p_region,
                                                                                                             p_area_id => :p_area_id);
                                                                        end; ";


                    _getSql.SqlParams = new object[]
                    {
                                                        new OracleParameter("p_domain", OracleDbType.Decimal) { Value = generalClearAddress.RegionId },
                                                        new OracleParameter("p_region", OracleDbType.Varchar2) { Value = generalClearAddress.Region },
                                                        new OracleParameter("p_area_id", OracleDbType.Decimal) { Value = generalClearAddress.AreaId }

                    };

                    break;
                case GeneralClearAddressType.Settlement:
                    _getSql.SqlText = @"
                                                                        begin   
                                                                            PKG_ADR_COMPARE.ins_settlements_match( p_domain => :p_region_id,
                                                                                                                   p_region => :p_area_id,
                                                                                                                   p_locality => :p_locality,
                                                                                                                   p_settlements_id => :p_settlements_id);
                                                                        end; ";


                    _getSql.SqlParams = new object[]
                    {
                                                        new OracleParameter("p_region_id", OracleDbType.Decimal) { Value = generalClearAddress.RegionId },
                                                        new OracleParameter("p_area_id", OracleDbType.Decimal) { Value = generalClearAddress.AreaId },
                                                        new OracleParameter("p_locality", OracleDbType.Varchar2) { Value = generalClearAddress.Locality },
                                                        new OracleParameter("p_settlements_id", OracleDbType.Decimal) { Value = generalClearAddress.SettlementId }

                    };

                    break;
                case GeneralClearAddressType.Street:
                    _getSql.SqlText = @"
                                                                        begin   
                                                                           PKG_ADR_COMPARE.ins_streets_match( p_domain => :p_region_id,
                                                                                                              p_region => :p_area_id,
                                                                                                              p_locality => :p_settlement_id,
                                                                                                              p_street => :p_street,
                                                                                                              p_street_id => :p_street_id);
                                                                        end; ";


                    _getSql.SqlParams = new object[]
                    {
                                                        new OracleParameter("p_region_id", OracleDbType.Decimal) { Value = generalClearAddress.RegionId },
                                                        new OracleParameter("p_area_id", OracleDbType.Decimal) { Value = generalClearAddress.AreaId },
                                                        new OracleParameter("p_settlement_id", OracleDbType.Decimal) { Value = generalClearAddress.SettlementId },
                                                        new OracleParameter("p_street", OracleDbType.Varchar2) { Value = generalClearAddress.Street },
                                                        new OracleParameter("p_street_id", OracleDbType.Decimal) { Value = generalClearAddress.StreetId }

                    };
                    break;
            }

        }

        private void InitDeleteConformity(GeneralClearAddress generalClearAddress)
        {
            _getSql = new BarsSql();
            switch (generalClearAddress.Type)
            {
                case GeneralClearAddressType.Region:

                    _getSql.SqlText = @"
                                                                    begin   
                                                                        PKG_ADR_COMPARE.del_regions_match( :p_domain);
                                                                    end; ";


                    _getSql.SqlParams = new object[]
                    {
                                                        new OracleParameter("p_domain", OracleDbType.Varchar2) { Value = generalClearAddress.Domain }

                    };

                    break;
                case GeneralClearAddressType.Area:
                    _getSql.SqlText = @"
                                                                    begin   
                                                                          PKG_ADR_COMPARE.del_areas_match(p_domain => :p_domain,
                                                                                                          p_region => :p_region);
                                                                    end; ";


                    _getSql.SqlParams = new object[]
                    {
                                                        new OracleParameter("p_domain", OracleDbType.Decimal) { Value = generalClearAddress.RegionId },
                                                        new OracleParameter("p_region", OracleDbType.Varchar2) { Value = generalClearAddress.Region }

                    };
                    break;
                case GeneralClearAddressType.Settlement:
                    _getSql.SqlText = @"
                                                                    begin   
                                                                            PKG_ADR_COMPARE.del_settlements_match( p_domain => :p_region_id,
                                                                                                                   p_region => :p_area_id,
                                                                                                                   p_locality => :p_locality);
                                                                    end; ";


                    _getSql.SqlParams = new object[]
                    {
                                                        new OracleParameter("p_region_id", OracleDbType.Decimal) { Value = generalClearAddress.RegionId },
                                                        new OracleParameter("p_area_id", OracleDbType.Decimal) { Value = generalClearAddress.AreaId },
                                                        new OracleParameter("p_locality", OracleDbType.Varchar2) { Value = generalClearAddress.Locality }

                    };
                    break;
                case GeneralClearAddressType.Street:
                    _getSql.SqlText = @"
                                                                    begin   
                                                                          PKG_ADR_COMPARE.del_streets_match( p_domain => :p_region_id,
                                                                                                             p_region => :p_area_id,
                                                                                                             p_locality => :p_settlement_id,
                                                                                                             p_street => :p_street);
                                                                    end; ";

                    _getSql.SqlParams = new object[]
                    {
                                                        new OracleParameter("p_region_id", OracleDbType.Decimal) { Value = generalClearAddress.RegionId},
                                                        new OracleParameter("p_area_id", OracleDbType.Decimal) { Value = generalClearAddress.AreaId },
                                                        new OracleParameter("p_settlement_id", OracleDbType.Decimal) { Value = generalClearAddress.SettlementId },
                                                        new OracleParameter("p_street", OracleDbType.Varchar2) { Value = generalClearAddress.Street }

                    };
                    break;
            }

        }

        public void InitConfirmSave(GeneralClearAddressType type)
        {
            _getSql = new BarsSql
            {
                SqlParams = new object[] { },
                SqlText = string.Format(@"
                                        begin   
                                            {0};
                                        end;", _saveConfirmSqlText[type])
            };
        }

        public void InstallConformity(GeneralClearAddress generalClearAddress)
        {
            InitInstallConformity(generalClearAddress);
            ExecuteSqlCommand();
        }

        public void DeleteConformity(GeneralClearAddress generalClearAddress)
        {
            InitDeleteConformity(generalClearAddress);
            ExecuteSqlCommand();
        }


        public void ConfirmSave(GeneralClearAddressType type)
        {
            InitConfirmSave(type);
            ExecuteSqlCommand();
        }


        private void ExecuteSqlCommand()
        {
            try
            {
                _dbContext.Database.ExecuteSqlCommand(_getSql.SqlText, _getSql.SqlParams);
            }
            finally
            {
                _dbContext.Dispose();
            }
        }
    }

    public interface IGeneralClearAddressRepository
    {
        List<GeneralClearAddress> GetRegion([DataSourceRequest] DataSourceRequest request);
        List<GeneralClearAddress> GetArea([DataSourceRequest] DataSourceRequest request);
        List<GeneralClearAddress> GetLocality([DataSourceRequest] DataSourceRequest request);
        List<GeneralClearAddress> GetStreet([DataSourceRequest] DataSourceRequest request);
        List<GeneralClearAddress> GetInstallConformityGrid([DataSourceRequest] DataSourceRequest request, GeneralClearAddressType type, decimal? regionId, decimal? areaId, decimal? settlementId);
        decimal GetRegionCount([DataSourceRequest] DataSourceRequest request);
        decimal GetAreaCount([DataSourceRequest] DataSourceRequest request);
        decimal GetLocalityCount([DataSourceRequest] DataSourceRequest request);
        decimal GetStreetCount([DataSourceRequest] DataSourceRequest request);
        decimal GetInstallConformityGridCount([DataSourceRequest] DataSourceRequest request, GeneralClearAddressType type, decimal? regionId, decimal? areaId, decimal? settlementId);
        void InstallConformity(GeneralClearAddress generalClearAddress);
        void DeleteConformity(GeneralClearAddress generalClearAddress);
        void ConfirmSave(GeneralClearAddressType type);
    }
}