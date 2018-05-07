using BarsWeb.Areas.Clients.Models;
using BarsWeb.Core.Infrastructure.Kernel.DI.Abstract;
using BarsWeb.Core.Models.Kernel;
using Kendo.Mvc.UI;
using System.Collections.Generic;
using System.Linq;


namespace BarsWeb.Areas.Clients.Infrastructure.Repository
{
    public class ClientAddressRepository : IClientAddressRepository
    {
        public BarsSql _getSql;
        readonly ClientsDbContext _dbContext;
        private readonly IKendoSqlTransformer _sqlTransformer;

        public ClientAddressRepository(IKendoSqlTransformer sqlTransformer, IClientsModel model)
        {
            _sqlTransformer = sqlTransformer;
            _dbContext = model.GetDbContext();
        }

        public List<V_ADR_REGIONS> GetRegions(string columnName, DataSourceRequest request)
        {
            InitRegions();
            var sql = _sqlTransformer.TransformSqlForSearchAddress(columnName, _getSql, request);
            var result = _dbContext.Database.SqlQuery<V_ADR_REGIONS>(sql.SqlText, sql.SqlParams).ToList();
            return result;
        }
        public List<V_ADR_AREAS> GetAreas(string columnName, decimal? regionId, DataSourceRequest request)
        {
            InitAreas(regionId);
            var sql = _sqlTransformer.TransformSqlForSearchAddress(columnName, _getSql, request);
            var result = _dbContext.Database.SqlQuery<V_ADR_AREAS>(sql.SqlText, sql.SqlParams).ToList();
            return result;
        }

        public List<V_ADR_SETTLEMENTS> GetSettlement(string columnName, decimal? regionId, decimal? areaId, DataSourceRequest request)
        {
            InitSettlement(regionId, areaId);
            var sql = _sqlTransformer.TransformSqlForSearchAddress(columnName, _getSql, request);
            var result = _dbContext.Database.SqlQuery<V_ADR_SETTLEMENTS>(sql.SqlText, sql.SqlParams).ToList();
            return result;
        }

        public List<V_ADR_STREETS> GetStreet(string columnName, decimal? settlementId, [DataSourceRequest] DataSourceRequest request)
        {
            if (settlementId == null)
            {
                List<V_ADR_STREETS> streets = new List<V_ADR_STREETS>() {};
                return streets; 
            }
            else
            {
                InitStreet(settlementId);
                var sql = _sqlTransformer.TransformSqlForSearchAddress(columnName, _getSql, request);
                var result = _dbContext.Database.SqlQuery<V_ADR_STREETS>(sql.SqlText, sql.SqlParams).ToList();
                return result;
            }          
        }

        public List<V_ADR_HOUSES> GetHouse(string columnName, decimal? streetId, [DataSourceRequest] DataSourceRequest request)
        {
            if (streetId == null)
            {
                List<V_ADR_HOUSES> housess = new List<V_ADR_HOUSES>() { };
                return housess;
            }
            else
            {
                InitHouse(streetId);
                var sql = _sqlTransformer.TransformSqlForSearchAddress(columnName, _getSql, request);
                var result = _dbContext.Database.SqlQuery<V_ADR_HOUSES>(sql.SqlText, sql.SqlParams).ToList();
                return result;
            }

        }

        public List<V_ADR_SETTLEMENT_TYPES> GetDropDownSettlement()
        {
            InitDropDownSettlement();
            var result = _dbContext.Database.SqlQuery<V_ADR_SETTLEMENT_TYPES>(_getSql.SqlText, _getSql.SqlParams).ToList();
            return result;
        }

        public List<V_ADR_STREET_TYPES> GetDropDownStreet()
        {
            InitDropDownStreet();
            var result = _dbContext.Database.SqlQuery<V_ADR_STREET_TYPES>(_getSql.SqlText, _getSql.SqlParams).ToList();
            return result;
        }

        public List<HouseType> GetDropDownHouse()
        {
            InitDropDownHouse();
            var result = _dbContext.Database.SqlQuery<HouseType>(_getSql.SqlText, _getSql.SqlParams).ToList();
            return result;
        }

        public List<SectionType> GetDropDownSection()
        {
            InitDropDownSection();
            var result = _dbContext.Database.SqlQuery<SectionType>(_getSql.SqlText, _getSql.SqlParams).ToList();
            return result;
        }

        public List<RoomType> GetDropDownRoom()
        {
            InitDropDownRoom();
            var result = _dbContext.Database.SqlQuery<RoomType>(_getSql.SqlText, _getSql.SqlParams).ToList();
            return result;
        }

        private void InitDropDownRoom()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@" select id as ROOM_TP_ID, value as ROOM_TP_NM from address_room_type where value IS NOT NULL  order by id "),
                SqlParams = new object[] { }
            };

        }

        private void InitDropDownSection()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@" select id as SECTION_TP_ID, value as SECTION_TP_NM  from address_homepart_type where value IS NOT NULL order by id "),
                SqlParams = new object[] { }
            };

        }
        private void InitDropDownHouse()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@" select id as HOUSE_TP_ID, value as HOUSE_TP_NM from address_home_type where value IS NOT NULL order by id "),
                SqlParams = new object[] { }
            };

        }
        private void InitDropDownStreet()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@" select * from V_ADR_STREET_TYPES  "),
                SqlParams = new object[] { }
            };

        }

        private void InitDropDownSettlement()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@" select * from V_ADR_SETTLEMENT_TYPES "),
                SqlParams = new object[] { }
            };

        }


        private void InitAreas(decimal? regionId)
        {
            if (regionId == null)
            {
                _getSql = new BarsSql()
                {
                    SqlText = string.Format(@" select * from V_ADR_AREAS "),
                    SqlParams = new object[] { }
                };
            }
            else
            {
                _getSql = new BarsSql()
                {
                    SqlText = string.Format(@" select * from V_ADR_AREAS v where V.REGION_ID = {0}", regionId),
                    SqlParams = new object[] { }
                };
            }

        }

        private void InitSettlement(decimal? regionId, decimal? areaId)
        {
            if (regionId != null && areaId != null)
            {
                _getSql = new BarsSql()
                {
                    SqlText = string.Format(@" select * from V_ADR_SETTLEMENTS v where V.REGION_ID = {0} and V.AREA_ID = {1}", regionId, areaId)
                };
            }
            else if (regionId == null && areaId != null)
            {
                _getSql = new BarsSql()
                {
                    SqlText = string.Format(@" select * from V_ADR_SETTLEMENTS v where  V.AREA_ID = {0}", areaId)
                };
            }
            else if (regionId != null && areaId == null)
            {
                _getSql = new BarsSql()
                {
                    SqlText = string.Format(@" select * from V_ADR_SETTLEMENTS v where V.REGION_ID = {0}", regionId)
                };
            }
            else
            {
                _getSql = new BarsSql()
                {
                    SqlText = string.Format(@" select * from V_ADR_SETTLEMENTS ")
                };
            }

        }

        private void InitStreet(decimal? settlementId)
        {

            _getSql = new BarsSql()
            {
                SqlText = string.Format(@" select * from V_ADR_STREETS v where V.SETL_ID = {0}", settlementId)
            };

        }

        private void InitHouse(decimal? streetId)
        {

            _getSql = new BarsSql()
            {
                SqlText = string.Format(@" SELECT * FROM V_ADR_HOUSES T WHERE T.STREET_ID = {0} ORDER BY TO_NUMBER(T.HOUSE_NUM), T.HOUSE_NUM_ADD ", streetId)
            };

        }

        private void InitRegions()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@" select * from V_ADR_REGIONS "),
                SqlParams = new object[] { }
            };
        }
    }

    public interface IClientAddressRepository
    {
        List<V_ADR_REGIONS> GetRegions(string columnName, DataSourceRequest request);
        List<V_ADR_AREAS> GetAreas(string columnName, decimal? regionId, [DataSourceRequest] DataSourceRequest request);
        List<V_ADR_SETTLEMENT_TYPES> GetDropDownSettlement();
        List<V_ADR_STREET_TYPES> GetDropDownStreet();
        List<V_ADR_SETTLEMENTS> GetSettlement(string columnName, decimal? regionId, decimal? areaId, [DataSourceRequest] DataSourceRequest request);
        List<V_ADR_STREETS> GetStreet(string columnName, decimal? settlementId, [DataSourceRequest] DataSourceRequest request);
        List<V_ADR_HOUSES> GetHouse(string columnName, decimal? streetId, [DataSourceRequest] DataSourceRequest request);
        List<HouseType> GetDropDownHouse();
        List<SectionType> GetDropDownSection();
        List<RoomType> GetDropDownRoom();

    }
}