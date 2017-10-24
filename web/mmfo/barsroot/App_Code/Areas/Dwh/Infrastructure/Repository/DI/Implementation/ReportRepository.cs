using System.Activities.Validation;
using System.Collections.Generic;
using System.Linq;
using Oracle.DataAccess.Client;
using BarsWeb.Areas.Dwh.Infrastructure.Repository.DI.Abstract;
using Areas.Dwh.Models;
using BarsWeb.Models;
using BarsWeb.Areas.Dwh.Models;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using System.Data;
using System;

namespace barsapp.Areas.Dwh.Infrastructure.DI.Implementation
{
    public class ReportRepository : IReportRepository
    {
        private readonly DwhModel _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        public ReportRepository(IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter)
        {
            var connectionStr = EntitiesConnection.ConnectionString("DwhModel", "Dwh");
            this._entities = new DwhModel(connectionStr);
            _sqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }

        public BarsSql _reportDataQuery;
        public IEnumerable<V_DWH_REPORTS> ReportData(DataSourceRequest request, string moduleId)
        {
            InitReportDataQuery(moduleId);
            var query = _sqlTransformer.TransformSql(_reportDataQuery, request);
            var result = _entities.ExecuteStoreQuery<V_DWH_REPORTS>(query.SqlText, query.SqlParams);
            return result;
        }

        public decimal ReportDataCount(DataSourceRequest request, string moduleId)
        {
            InitReportDataQuery(moduleId);
            var count = _kendoSqlCounter.TransformSql(_reportDataQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }
        private void InitReportDataQuery(string moduleId)
        {
            _reportDataQuery = new BarsSql()
            {
                SqlText = string.Format(@"Select * from BARS.V_DWH_REPORTS where MODULE_ID=:p_moduleId"),
                SqlParams = new object[] { new OracleParameter("p_moduleId", OracleDbType.Varchar2) { Value = moduleId } }
            };
        }

        public BarsSql _reportResultDataQuery;
        public IEnumerable<V_DWH_CBIREP_QUERIES> ReportResultData(DataSourceRequest request, string moduleId)
        {
            InitReportResultQuery(moduleId);
            var query = _sqlTransformer.TransformSql(_reportResultDataQuery, request);
            var result = _entities.ExecuteStoreQuery<V_DWH_CBIREP_QUERIES>(query.SqlText, query.SqlParams);
            return result;
        }
        public decimal ReportResultDataCount(DataSourceRequest request, string moduleId)
        {
            InitReportResultQuery(moduleId);
            var count = _kendoSqlCounter.TransformSql(_reportResultDataQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }
        private void InitReportResultQuery(string moduleId)
        {
            _reportResultDataQuery = new BarsSql()
            {
                SqlText = string.Format(@"select RES.ID, RES.FILE_NAMES, 
                            RES.STATUS_NAME, RES.CREATION_TIME, RES.JOB_ID, 
                            RES.KEY_PARAMS, RES.REP_ID, RES.REPORT_NAME, 
                            RES.SESSION_ID, RES.STATUS_DATE, RES.STATUS_ID, RES.USERID
                          from BARS.V_DWH_REPORTS r, BARS.V_DWH_CBIREP_QUERIES res
                          where R.ID = RES.REP_ID and R.MODULE_ID = :p_moduleId order by res.id desc"),
                SqlParams = new object[] { new OracleParameter("p_moduleId", OracleDbType.Varchar2) { Value = moduleId } }
            };
        }

        public V_DWH_REPORTS ReportItem(decimal id, string moduleId)
        {
            const string query = @"Select * from BARS.V_DWH_REPORTS where ID=:p_Id and module_id=:p_mId";
            var param = new object[]
            {
                new OracleParameter("p_Id", OracleDbType.Decimal) { Value = id },
                new OracleParameter("p_mId", OracleDbType.Varchar2) { Value = moduleId } 
            };
            var result = _entities.ExecuteStoreQuery<V_DWH_REPORTS>(query, param).SingleOrDefault();
            return result;
        }

        public int EnqueueReport(decimal reportId, string xmlParameters)
        {
            const string sql = @"
                        begin
                          BARS.DWH_CBIREP.CREATE_REPORT_QUERY(:p_rep_id, :p_xml_params);
                        end;";
            object[] parameters =
            {
                //new OracleParameter("l_id", OracleDbType.Decimal) {Direction = ParameterDirection.Output},
                new OracleParameter("p_rep_id", OracleDbType.Decimal) {Value = reportId},
                new OracleParameter("p_xml_params", OracleDbType.Varchar2) {Value = xmlParameters}

            };
            return _entities.ExecuteStoreCommand(sql, parameters);
            //return Convert.ToInt32(((OracleParameter)parameters[0]).Value);
        }

        public int DropReport(decimal reportId)
        {
            const string sql = @"
                        begin
                          BARS.DWH_CBIREP.clear_report_data(:p_cbirepq_id);
                        end;";
            object[] parameter =
            {
                new OracleParameter("p_cbirepq_id", OracleDbType.Decimal) {Value = reportId}
            };
            return _entities.ExecuteStoreCommand(sql, parameter);
        }

        public IEnumerable<DWH_CBIREP_QUERIES_DATA> GetReportResults(decimal id)
        {
            const string sql = @"select * from DWH_CBIREP_QUERIES_DATA where CBIREP_QUERIES_ID = :p_id";
            object[] parameter =
            {
                new OracleParameter("p_id", OracleDbType.Decimal) {Value = id}
            };
            var result = _entities.ExecuteStoreQuery<DWH_CBIREP_QUERIES_DATA>(sql, parameter);
            return result;
        }
        public IQueryable<V_DWH_CBIREP_QUERIES> GetAllReportResults(string moduleId)
        {
            const string sql = @"select V.REP_ID, V.CREATION_TIME, V.FILE_NAMES, 
                V.ID, V.JOB_ID, V.KEY_PARAMS, V.REPORT_NAME, 
                V.SESSION_ID, V.STATUS_DATE, V.STATUS_ID, V.STATUS_NAME, V.USERID 
            from V_DWH_CBIREP_QUERIES v, DWH_REPORT_LINKS d
            where V.REP_ID=D.REPORT_ID and D.MODULE_ID = :p_mId";
            object[] param =
            {
                new OracleParameter("p_mId", OracleDbType.Varchar2) { Value = moduleId } 
            };
            return _entities.ExecuteStoreQuery<V_DWH_CBIREP_QUERIES>(sql, param).AsQueryable();
        }
        public List<V_REGIONS> GetRegions()
        {
            return _entities.ExecuteStoreQuery<V_REGIONS>("select * from v_regions").ToList();
        }

        public string GetResultFileName(decimal id, string param)
        {
            var parameters = new[]
            {
                new OracleParameter("p_id",OracleDbType.Decimal).Value = id,
                new OracleParameter("p_param",OracleDbType.Varchar2).Value = param
            };
            var name = _entities.ExecuteStoreQuery<string>(
                "select dwh_cbirep.filenames(:p_id,:p_param) from dual",
                parameters).FirstOrDefault();
            return name;
        }


        /*         
        public IQueryable<V_DWH_REPORTS> GetNotModuleReports(string moduleId)
        {
            const string query = @"
                select r.id, r.name, r.typeid, r.params, r.template_name, r.result_file_name,
                   r.sqlprepare, r.description, r.form_proc, r.stmt, r.file_name, r.encoding,
                   t.name TYPE_NAME, t.description TYPE_DESC, t.VALUE TYPE_VALUE,
                   :p_mId MODULE_ID,
                   (select NAME from core.core_modules where MODULE_ID = :p_mId) MODULE_NAME
                from core.dwh_reports r
                   join core.dwh_report_type t on t.ID = r.TYPEID
                where not exists (select 1 from core.dwh_report_links l where l.REPORT_ID = r.ID and l.MODULE_ID = :p_mId)
                order by ID
            ";
            object[] param = { 
                new OracleParameter("p_mId",OracleDbType.Decimal).Value = moduleId             
            };

            var res = _dwhEntities.ExecuteStoreQuery<V_DWH_REPORTS>(query, param);

            return res.AsQueryable();
        }
        public void ReportToModuleFunc(string moduleId, string reportId)
        {
            const string command = @"
            begin
                CORE.utl_reftables_fill.refill_report_links (:p_repID, :p_modID);
            end;";
            object[] commParams = { 
                new OracleParameter("p_repID",OracleDbType.Decimal).Value = reportId,
                new OracleParameter("p_modID",OracleDbType.Decimal).Value = moduleId
            };
            _dwhEntities.ExecuteStoreCommand(command, commParams);
        }*/
    }
}