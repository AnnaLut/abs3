using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Areas.Reporting.Models;
using BarsWeb.Areas.Reporting.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Reporting.Models;
using Oracle.DataAccess.Client;
using System.Text;
using System.Globalization;
using BarsWeb.Core.Logger;
using Ninject;
using Oracle.DataAccess.Types;
using System.Web;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;
using BarsWeb.Infrastructure.Helpers;
using Bars.Oracle.Factories;

namespace BarsWeb.Areas.Reporting.Infrastructure.Repository.DI.Implementation
{
    public class NbuRepository : INbuRepository
    {
        readonly IKendoSqlTransformer _sqlTransformer;
        OracleConnectFactory _oracleCommandFactory = null;
        private readonly string CurrentVersionId = "CurrentVersionId";
        readonly ReportingEntities _entities;
        [Inject]
        public IDbLogger Logger { get; set; }
        public NbuRepository(IReportingModel model, IKendoSqlTransformer sqlTransformer)
        {
            _sqlTransformer = sqlTransformer;

            _entities = model.ReportingEntities;
        }

        public OracleConnectFactory GetOracleConnector
        {
            get
            {
                if (_oracleCommandFactory == null)
                    _oracleCommandFactory = new OracleConnectFactory();
                return _oracleCommandFactory;
            }

        }

        public IEnumerable<FileInitialInfo> GetFileInitialInfo(int id, string kf)
        {
            const string sql = @"select FILE_ID, FILE_NAME, SCHEME_CODE, FILE_CODE, PERIOD, KF, FILE_TYPE, FILE_FMT_LIST
                                    from V_NBUR_LIST_FILES_USER t 
                                    where T.FILE_ID = :P_FILE_ID 
                                    and T.KF = :P_KF";
            object[] parameters =
            {
                new OracleParameter("P_FILE_ID", OracleDbType.Int32).Value = id,
                new OracleParameter("P_KF", OracleDbType.Char).Value = kf
            };
            IEnumerable<FileInitialInfo> structure = _entities.ExecuteStoreQuery<FileInitialInfo>(sql, parameters);
            return structure;
        }

        public IEnumerable<RepStructure> GetReportStructure(string  fileCode, string schemeCode)
        {
            const string sql = @"select 
                                    a.FILE_ID as FILE_ID,
                                    a.FILE_CODE as FILE_CODE,
                                    a.SCHEME_CODE as SCHEME_CODE,
                                    a.SEGMENT_NUMBER as SEGMENT_NUMBER,
                                    a.SEGMENT_NAME as SEGMENT_NAME,
                                    a.SEGMENT_RULE as SEGMENT_RULE,
                                    a.SORT_ATTRIBUTE as SORT_ATTRIBUTE,
                                    a.KEY_ATTRIBUTE as KEY_ATTRIBUTE
                                from 
                                    V_NBUR_FORM_STRU a
                                where 
                                    FILE_CODE = :p_file_code 
                                    and SCHEME_CODE = :p_schemeCode";
            object[] parameters =         
            { 
                new OracleParameter("p_file_code",OracleDbType.Varchar2).Value = fileCode,
                new OracleParameter("p_schemeCode",OracleDbType.Varchar2).Value = schemeCode
            };
            var structure = _entities.ExecuteStoreQuery<RepStructure>(sql, parameters).OrderBy(i => i.SORT_ATTRIBUTE).ToList();
            return structure.OrderBy(i => i.SEGMENT_NUMBER);
        }
        public NburListFromFinished GetNburListFromFinished(string  fileCode,string reportDate, string kf, decimal? versionId = null)
        {
            CultureInfo cultureinfo = new CultureInfo("uk-UA");
            DateTime reportDateTime = DateTime.Parse(reportDate, cultureinfo);

            string sql = @"select 
                                FILE_CODE, 
                                FILE_ID, 
                                KF, 
                                VERSION_ID , 
                                FINISH_TIME, 
                                FILE_NAME, 
                                FILE_TYPE, 
                                FIO, 
                                PERIOD, 
                                REPORT_DATE, 
                                START_TIME,
                                STATUS,
                                STATUS_CODE,
                                FILE_FMT
                            from 
                                V_NBUR_LIST_FORM_FINISHED a
                            where
                                FILE_CODE = :p_file_code and 
                                REPORT_DATE = :p_report_date and 
                                KF = :p_kf ";

            List<object> p = new List<object>();
            p.Add(new OracleParameter("p_file_code", OracleDbType.Varchar2) { Value = fileCode });
            p.Add(new OracleParameter("p_report_date", OracleDbType.Date) { Value = reportDateTime });
            p.Add(new OracleParameter("p_kf", OracleDbType.Varchar2) { Value = kf });

            if (versionId != null)
            {
                p.Add(new OracleParameter("p_VERSION_ID", OracleDbType.Decimal) { Value = versionId });
                sql += " and VERSION_ID = :p_VERSION_ID ";
            }
            sql += " order by VERSION_ID desc";

            var listFromFinished = _entities.ExecuteStoreQuery<NburListFromFinished>(sql, p.ToArray()).ToList();
            var res = listFromFinished.FirstOrDefault();
            return res;
        }

        public string GetChkLog(string fileCode, string reportDate, string kf, string schemeCode, decimal? versionId = null)
        {
            DateTime reportDateTime = DateTime.Parse(reportDate, new CultureInfo("uk-UA"));

            string sql = @"select a.chk_log from NBUR_LST_FILES a where
                                REPORT_DATE = :p_report_date and 
                                KF = :p_kf
                                and a.file_id in (
                                        select Distinct(FILE_ID) 
                                        from V_NBUR_FORM_STRU 
                                        where FILE_CODE = :p_file_code and SCHEME_CODE = :P_SCHEME_CODE)";

            List<OracleParameter> p = new List<OracleParameter>();
            p.Add(new OracleParameter("p_report_date", OracleDbType.Date) { Value = reportDateTime });
            p.Add(new OracleParameter("p_kf", OracleDbType.Varchar2) { Value = kf });
            p.Add(new OracleParameter("p_file_code", OracleDbType.Varchar2) { Value = fileCode });
            p.Add(new OracleParameter("P_SCHEME_CODE", OracleDbType.Varchar2) { Value = schemeCode });
            if (versionId != null)
            {
                p.Add(new OracleParameter("p_VERSION_ID", OracleDbType.Decimal) { Value = versionId });
                sql += " and VERSION_ID = :p_VERSION_ID ";
            }
            return _entities.ExecuteStoreQuery<string>(sql, p.ToArray()).SingleOrDefault();
        }

        public DataSet GetReportData(string fileCode,string schemeCode, string kf, string date, string isCon, decimal? verId = null)
        {
            var fromFinished = GetNburListFromFinished(fileCode, date, kf, verId);
            if (fromFinished == null)
            {
                return new DataSet();
            }
            var versionId = fromFinished.VERSION_ID;
            string vn = GetViewName(fileCode, false);

            string fileFmt = GetFileFmt(fileCode, false);

            var sql = new Utils().CreateReportQuery(isCon, GetReportStructure(fileCode,schemeCode).ToList(), vn, fileFmt);
            //StartCreateReport(code, date);

            using (OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            using (OracleCommand oracleCommand = con.CreateCommand())
            {
                oracleCommand.CommandText = sql;

                if (isCon == "1" || string.IsNullOrEmpty(vn))
                {
                    oracleCommand.Parameters.Add("p_REPORT_CODE", OracleDbType.Varchar2, fileCode,
                        ParameterDirection.Input);
                }
                oracleCommand.Parameters.Add("p_REPORT_DATE", OracleDbType.Varchar2, date, ParameterDirection.Input);
                oracleCommand.Parameters.Add("p_KF", OracleDbType.Varchar2, kf, ParameterDirection.Input);
                oracleCommand.Parameters.Add("p_VERSION_ID", OracleDbType.Decimal, versionId, ParameterDirection.Input);

                var adapter = new OracleDataAdapter(oracleCommand);

                var dataSet = new DataSet();
                adapter.Fill(dataSet);
                return dataSet;
            }
        }

        public IEnumerable<Accessed> GetVersion(string reportDate, string kf, string fileCode)
        {
            CultureInfo cultureinfo = new CultureInfo("uk-UA");
            DateTime date = DateTime.Parse(reportDate, cultureinfo);
            Logger.Debug("report date: " + date + "kf: " + kf + " fileCode:  " + fileCode);

            string sql = @"select 
                                FILE_CODE, 
                                FILE_ID, 
                                KF, 
                                VERSION_ID , 
                                FINISH_TIME, 
                                FILE_NAME, 
                                FILE_TYPE, 
                                FIO, 
                                PERIOD, 
                                REPORT_DATE, 
                                START_TIME,
                                STATUS,
                                STATUS_CODE
                            from 
                                V_NBUR_LIST_FORM_ACCESSED  a
                            where
                                FILE_CODE = :p_file_code and 
                                REPORT_DATE = :p_report_date and 
                                KF = :p_kf";
            object[] parameters =         
            { 
                new OracleParameter("p_file_code",OracleDbType.Varchar2).Value = fileCode,
                new OracleParameter("p_report_date",OracleDbType.Date).Value = date,
                new OracleParameter("p_kf",OracleDbType.Varchar2).Value = kf
            };
            var listFromAccessed = _entities.ExecuteStoreQuery<Accessed>(sql, parameters).ToList();
           // var res = listFromAccessed.FirstOrDefault();
            Logger.Debug("count of versions: " + listFromAccessed.Count); 
            return listFromAccessed;
        }

        public string kodfСheck(string code)
        {
            const string sql = @"select kod from rnbu_1 where kodf = :p_kodf";
            object[] parameters = 
            { 
                new OracleParameter("p_kodf", OracleDbType.Varchar2).Value = code                      
            };
            var kod = _entities.ExecuteStoreQuery<string>(sql, parameters).FirstOrDefault();
            return kod;
        }
        public string StartCreateReport(string reportDate, string fileCode, string schemeCode, string fileType, string kf)
        {
            //string schedulerCode = "NBU_REP_" + code.ToUpper();
            
            //const string execProcedure = @"select nbur_queue.f_put_queue_form(:p_report_date, :p_file_code, :p_scheme, :p_type, :p_kf) from dual";
            string result = "";
            CultureInfo cultureinfo = new CultureInfo("uk-UA");
            DateTime date = DateTime.Parse(reportDate, cultureinfo);
            //var param = _tasksRepository.GetSсhedulerParameters(schedulerCode);

            using (OracleConnection conn = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            using (OracleCommand cmd = new OracleCommand("nbur_queue.f_put_queue_form", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                OracleParameter resultObject = new OracleParameter("p_result_object", OracleDbType.Varchar2, 4000, null,
                    ParameterDirection.ReturnValue);
                cmd.Parameters.Add(resultObject);
                object[] parameters =
                {
                    new OracleParameter("p_report_date", OracleDbType.Date) {Value = date},
                    new OracleParameter("p_file_code", OracleDbType.Varchar2) {Value = fileCode},
                    new OracleParameter("p_scheme", OracleDbType.Varchar2) {Value = schemeCode},
                    new OracleParameter("p_type", OracleDbType.Varchar2) {Value = fileType},
                    new OracleParameter("p_kf", OracleDbType.Varchar2) {Value = kf}
                };
                cmd.Parameters.AddRange(parameters);

                cmd.ExecuteNonQuery();
                if (resultObject.Value != null)
                {
                    result = resultObject.Value.ToString();
                }
            }
            return result;
        }

        public string GenerateReportFromClob(string reportDate, string fileCode, string kf, string schemeCode, decimal? versionId)
        {
            if (versionId == null)
            {
                var formFinished = GetNburListFromFinished(fileCode, reportDate, kf);
                versionId = formFinished.VERSION_ID;
            }
         
            string result = "";
            CultureInfo cultureinfo = new CultureInfo("uk-UA");
            DateTime date = DateTime.Parse(reportDate, cultureinfo);

            using (OracleConnection conn = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            using (OracleCommand cmd = new OracleCommand("nbur_files.f_get_file_clob", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                var resultObject = new OracleParameter("p_result_object", OracleDbType.Clob, 4000, null,
                    ParameterDirection.ReturnValue);

                cmd.Parameters.Add(resultObject);
                object[] parameters =
                {
                    new OracleParameter("p_report_date", OracleDbType.Date) {Value = date},
                    new OracleParameter("p_kf", OracleDbType.Varchar2) {Value = kf},
                    new OracleParameter("p_version_id", OracleDbType.Decimal) {Value = versionId},
                    new OracleParameter("p_file_code", OracleDbType.Varchar2) {Value = fileCode},
                    new OracleParameter("p_scheme_code", OracleDbType.Varchar2) {Value = schemeCode}
                };
                cmd.Parameters.AddRange(parameters);
                cmd.ExecuteNonQuery();
                using (OracleClob clob = resultObject.Value as OracleClob)
                {
                    if (clob != null)
                    {
                        result = clob.Value;
                    }
                }
                return result;
            }
        }

        public string GenerateReportFiltName(string fileCode, 
                                            string reportDate, 
                                            string kf, 
                                            string schemeCode, 
                                            decimal? versionId)
        {
            CultureInfo cultureinfo = new CultureInfo("uk-UA");
            DateTime date = DateTime.Parse(reportDate, cultureinfo);

            using (OracleConnection conn = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            using (OracleCommand cmd = new OracleCommand("nbur_files.f_get_file_name", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                var resultObject = new OracleParameter("p_result_object", OracleDbType.Varchar2, 4000, null,
                    ParameterDirection.ReturnValue);

                cmd.Parameters.Add(resultObject);
                object[] parameters =
                {
                    new OracleParameter("p_report_date", OracleDbType.Date) {Value = date},
                    new OracleParameter("p_kf", OracleDbType.Varchar2) {Value = kf},
                    new OracleParameter("p_version_id", OracleDbType.Int32) {Value = versionId},
                    new OracleParameter("p_file_code", OracleDbType.Varchar2) {Value = fileCode},
                    new OracleParameter("p_scheme_code", OracleDbType.Varchar2) {Value = schemeCode}
                };
                cmd.Parameters.AddRange(parameters);
                cmd.ExecuteNonQuery();
                string fileName = resultObject.Value.ToString();
                return fileName;
            }
        }

        public string GetReportFile(string code, string date)
        {
            CultureInfo cultureinfo = new CultureInfo("uk-UA");
            DateTime nDate = DateTime.Parse(date, cultureinfo);

            //select nbu_rep.get_report_file(:p_code,:p_date) from dual
            const string sql = @"select kodp, znap, nbuc
                                    from tmp_nbu
                                    where kodf=:p_code and DATF=:p_date
                                    order by nbuc, kodp
                                    ";
            object[] parameters =         
            { 
                new OracleParameter("p_code",OracleDbType.Varchar2) { Value = code },
                new OracleParameter("p_date",OracleDbType.Date) { Value = nDate }
            };
            var tmpReport = _entities.ExecuteStoreQuery<ReportFileModel>(sql, parameters).ToList();

            var currentA017 = _entities.FORM_STRU.Where(a => a.KODF == code).FirstOrDefault();

            OracleConnection conn = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = new OracleCommand("BARS.F_CREATEFILENAME_WEB", conn) { CommandType = System.Data.CommandType.StoredProcedure };

            object[] rNameFuncParameters =         
            { 
                new OracleParameter("p_result", OracleDbType.Varchar2, 13, "", ParameterDirection.ReturnValue),
                new OracleParameter("p_sNumFile",OracleDbType.Varchar2) { Value = code },
                new OracleParameter("p_sGCode",OracleDbType.Varchar2) { Value = currentA017.A017 },
                new OracleParameter("p_dtRepDate",OracleDbType.Date) { Value = nDate }
            };
            cmd.Parameters.AddRange(rNameFuncParameters);

            cmd.ExecuteNonQuery();

            var repName = Convert.ToString(cmd.Parameters["p_result"].Value);

            cmd.Dispose();
            conn.Close();
            conn.Dispose();

            const string rHeadlineFunc = @"select BARS.f_CREATEHEADLINE(:p_sNumFile, :p_sGCode, :p_dtRepDate, :p_sFileName, :p_nCnt) from dual";
            object[] rHeadlineFuncParameters =         
            { 
                new OracleParameter("p_sNumFile",OracleDbType.Varchar2) { Value = code },
                new OracleParameter("p_sGCode",OracleDbType.Varchar2) { Value = currentA017.A017 },
                new OracleParameter("p_dtRepDate",OracleDbType.Date) { Value = nDate },
                new OracleParameter("p_sFileName",OracleDbType.Varchar2) { Value = repName },
                new OracleParameter("p_nCnt",OracleDbType.Decimal) { Value = tmpReport.Count() }
            };
            var rHeadline = _entities.ExecuteStoreQuery<string>(rHeadlineFunc, rHeadlineFuncParameters).FirstOrDefault(); // *

            var currentNBUC = _entities.TMP_NBU.Where(n => n.KODF == code).FirstOrDefault();
            const string rHeadlineExFunc = @"select BARS.f_CREATEHEADLINEEX(:p_sNumFile, :p_sGCode, :p_sNBUC) from dual";
            object[] rHeadlineExFuncParameters = 
            { 
                new OracleParameter("p_sNumFile",OracleDbType.Varchar2) { Value = code },
                new OracleParameter("p_sGCode",OracleDbType.Varchar2) { Value = currentA017.A017 },
                new OracleParameter("p_sNBUC",OracleDbType.Varchar2) { Value = currentNBUC.NBUC }
            };
            var rHeadlineEx = _entities.ExecuteStoreQuery<string>(rHeadlineExFunc, rHeadlineExFuncParameters).FirstOrDefault(); // *

            StringBuilder result = new StringBuilder();
            result.Append(repName + "\r\n");
            result.Append(rHeadline + "\r\n");
            result.Append(rHeadlineEx + "\r\n");

            var nbuc = currentNBUC.NBUC;
            foreach (ReportFileModel item in tmpReport)
            {
                if (item.NBUC == nbuc)
                {
                    result.AppendFormat("{0}={1}\r\n", item.KODP, item.ZNAP);
                }
                else
                {
                    nbuc = item.NBUC;
                    object[] newHLExParams = 
                    { 
                        new OracleParameter("p_sNumFile",OracleDbType.Varchar2) { Value = code },
                        new OracleParameter("p_sGCode",OracleDbType.Varchar2) { Value = currentA017.A017 },
                        new OracleParameter("p_sNBUC",OracleDbType.Varchar2) { Value = nbuc }
                    };
                    var newHeadlineEX = _entities.ExecuteStoreQuery<string>(rHeadlineExFunc, newHLExParams).FirstOrDefault(); // *
                    result.AppendFormat("{0}\r\n{1}={2}\r\n", newHeadlineEX, item.KODP, item.ZNAP);
                }
            }

            return result.ToString();
        }
        public void InsertRow(string datf, string kodf, string kodp, string znap, string nbuc)
        {
            CultureInfo cultureinfo = new CultureInfo("uk-UA");
            DateTime date = DateTime.Parse(datf, cultureinfo);

            const string insertRowStr = @"
                            begin OTCN_WEB.p_insert_row(:p_type, :p_datf, :p_kodf, :p_kodp, :p_znap, :p_nbuc); 
                            end;
                        ";
            object[] inserRowParameters =         
            { 
                new OracleParameter("p_type",OracleDbType.Decimal) { Value = 1 },
                new OracleParameter("p_datf",OracleDbType.Date) { Value = date },
                new OracleParameter("p_kodf",OracleDbType.Varchar2) { Value = kodf },
                new OracleParameter("p_kodp",OracleDbType.Varchar2) { Value = kodp },
                new OracleParameter("p_znap",OracleDbType.Varchar2) { Value = znap },
                new OracleParameter("p_nbuc",OracleDbType.Varchar2) { Value = nbuc }
            };

            _entities.ExecuteStoreCommand(insertRowStr, inserRowParameters);
        }
        public void UpdateRow(string datf, string kodf, string oldKodp, string kodp, string znap, string nbuc)
        {
            CultureInfo cultureInfo = new CultureInfo("uk-UA");
            DateTime date = DateTime.Parse(datf, cultureInfo);

            const string updateRowStr = @"
                            begin OTCN_WEB.p_update_row(:p_type, :p_datf, :p_kodf, :p_oldKodp, :p_kodp, :p_znap, :p_nbuc); 
                            end;
                        ";
            object[] updateRowParameters =         
            { 
                new OracleParameter("p_type",OracleDbType.Decimal) { Value = 1 },
                new OracleParameter("p_datf",OracleDbType.Date) { Value = date },
                new OracleParameter("p_kodf",OracleDbType.Varchar2) { Value = kodf },
                new OracleParameter("p_oldKodp",OracleDbType.Varchar2) { Value = oldKodp },
                new OracleParameter("p_kodp",OracleDbType.Varchar2) { Value = kodp },
                new OracleParameter("p_znap",OracleDbType.Varchar2) { Value = znap },
                new OracleParameter("p_nbuc",OracleDbType.Varchar2) { Value = nbuc }
            };

            _entities.ExecuteStoreCommand(updateRowStr, updateRowParameters);
        }
        public void DeleteRow(string datf, string kodf, string kodp, string nbuc)
        {
            CultureInfo cultureinfo = new CultureInfo("uk-UA");
            DateTime date = DateTime.Parse(datf, cultureinfo);

            const string deleteRowStr = @"
                            begin OTCN_WEB.p_delete_row(:p_type, :p_datf, :p_kodf, :p_kodp, :p_nbuc); 
                            end;
                        ";
            object[] deleteRowParameters =         
            { 
                new OracleParameter("p_type",OracleDbType.Decimal) { Value = 1 },
                new OracleParameter("p_datf",OracleDbType.Date) { Value = date },
                new OracleParameter("p_kodf",OracleDbType.Varchar2) { Value = kodf },
                new OracleParameter("p_kodp",OracleDbType.Varchar2) { Value = kodp },
                new OracleParameter("p_nbuc",OracleDbType.Varchar2) { Value = nbuc }
            };

            _entities.ExecuteStoreCommand(deleteRowStr, deleteRowParameters);
        }
        public IEnumerable<Archive> ArchiveGrid(string FileCode,string kf,string reportDate )
        {
            // НБУ
            Logger.Debug(" getArchiveGrid report date: " + reportDate + "kf: " + kf + " fileCode:  " + FileCode);
            CultureInfo cultureinfo = new CultureInfo("uk-UA");
            DateTime date = DateTime.Parse(reportDate, cultureinfo);

            const string arc = @"
                select FILE_CODE, FILE_ID,FILE_TYPE, FIO, KF, PERIOD,REPORT_DATE,TIME
                from V_NBUR_QUEUE_FORM_ALL
                where REPORT_DATE = :p_reportDate
                    and KF = :p_kf 
                    and FILE_CODE = :p_FileCode
                order by REPORT_DATE desc
            ";
            object[] arcParams = { 
                new OracleParameter("p_p_reportDate",OracleDbType.Date) { Value = date },
                new OracleParameter("p_kf",OracleDbType.Varchar2) { Value = kf },
                new OracleParameter("p_FileCode",OracleDbType.Varchar2) { Value = FileCode }     
            };
            var result = _entities.ExecuteStoreQuery<Archive>(arc, arcParams).ToList();
            Logger.Debug(" getArchiveGrid count result:    " + result.Count);
            return result;
        }
        
        public List<DetailedReport> GetDetailedReport(DataSourceRequest request, string  fileCode, string reportDate, string kf, string fieldCode, string schemeCode)
        {
            var formFinished = GetNburListFromFinished(fileCode, reportDate, kf);
            decimal versionId = formFinished.VERSION_ID;
            HttpContext context = HttpContext.Current;
            context.Session[CurrentVersionId] = versionId;
            CultureInfo cultureinfo = new CultureInfo("uk-UA");
            DateTime date = DateTime.Parse(reportDate, cultureinfo).Date;
            
            object[] arrayParams = {
                    new OracleParameter("p_versionId ", OracleDbType.Decimal) {Value = versionId},
                    new OracleParameter("p_kf", OracleDbType.Varchar2) {Value = kf},
                    new OracleParameter("p_reportDate", OracleDbType.Date) {Value = date},
                    new OracleParameter("p_fileCode ", OracleDbType.Varchar2) {Value = fileCode}
                };
            string sql = @"select 
                            BRANCH,
                            FIELD_CODE,
                            FIELD_VALUE,
                            ACC_ID,
                            ACC_NUM,
                            KV,
                            MATURITY_DATE,
                            CUST_ID,
                            CUST_CODE,
                            CUST_NMK,
                            ND,
                            AGRM_NUM,
                            BEG_DT,
                            END_DT,
                            REF,
                            DESCRIPTION
                        FROM 
                            V_NBUR_DETAIL_PROTOCOLS 
                        where 
                            VERSION_ID = :p_versionId 
                            and KF = :p_kf 
                            and REPORT_DATE = :p_reportDate
                            and REPORT_CODE = :p_fileCode ";
            if (!string.IsNullOrEmpty(fieldCode))
            {
                sql += " and FIELD_CODE = :p_fieldCode ";
                var list = arrayParams.ToList();
                list.Add(new OracleParameter("p_fieldCode ", OracleDbType.Varchar2){
                    Value = fieldCode
                });
                arrayParams = list.ToArray();
            }

            var reportStructure = GetReportStructure(fileCode, schemeCode).ToList();
            var reportStructureToSort = reportStructure.Where(i => i.SORT_ATTRIBUTE != null)
                .OrderBy(i => i.SORT_ATTRIBUTE).ToList();
            if (reportStructureToSort.Any())
            {
                var orderSql = new StringBuilder(" order by ");
                var lastField = reportStructureToSort.Last();
                foreach (var item in reportStructureToSort.Where(i=>i.SORT_ATTRIBUTE != null)
                    .OrderBy(i=>i.SORT_ATTRIBUTE).ToList())
                {
                    orderSql.Append(item.SEGMENT_RULE);
                    if (!item.Equals(lastField))
                    {
                        orderSql.Append(",");
                    }
                }
                sql += orderSql.ToString();
            }

            BarsSql bSql = new BarsSql {
                 SqlText = sql,
                 SqlParams = arrayParams
            };
            var query = _sqlTransformer.TransformSql(bSql, request);
            var result = _entities.ExecuteStoreQuery<DetailedReport>(query.SqlText, query.SqlParams);
            return result.ToList();
        }

        public List<DetailedReport> GetDetailedReportList(string fileCode, string reportDate, string kf, string fieldCode, string schemeCode)
        {
            var formFinished = GetNburListFromFinished(fileCode, reportDate, kf);
            decimal versionId = formFinished.VERSION_ID;
            HttpContext context = HttpContext.Current;
            context.Session[CurrentVersionId] = versionId;
            CultureInfo cultureinfo = new CultureInfo("uk-UA");
            DateTime date = DateTime.Parse(reportDate, cultureinfo).Date;

            object[] arrayParams = {
                    new OracleParameter("p_versionId ", OracleDbType.Decimal) {Value = versionId},
                    new OracleParameter("p_kf", OracleDbType.Varchar2) {Value = kf},
                    new OracleParameter("p_reportDate", OracleDbType.Date) {Value = date},
                    new OracleParameter("p_fileCode ", OracleDbType.Varchar2) {Value = fileCode}
                };
            string sql = @"select 
                            BRANCH,
                            FIELD_CODE,
                            FIELD_VALUE,
                            ACC_ID,
                            ACC_NUM,
                            KV,
                            MATURITY_DATE,
                            CUST_ID,
                            CUST_CODE,
                            CUST_NMK,
                            ND,
                            AGRM_NUM,
                            BEG_DT,
                            END_DT,
                            REF,
                            DESCRIPTION
                        FROM 
                            V_NBUR_DETAIL_PROTOCOLS 
                        where 
                            VERSION_ID = :p_versionId 
                            and KF = :p_kf 
                            and REPORT_DATE = :p_reportDate
                            and REPORT_CODE = :p_fileCode ";
            if (!string.IsNullOrEmpty(fieldCode))
            {
                sql += " and FIELD_CODE = :p_fieldCode ";
                var list = arrayParams.ToList();
                list.Add(new OracleParameter("p_fieldCode ", OracleDbType.Varchar2)
                {
                    Value = fieldCode
                });
                arrayParams = list.ToArray();
            }

            var reportStructure = GetReportStructure(fileCode, schemeCode).ToList();
            var reportStructureToSort = reportStructure.Where(i => i.SORT_ATTRIBUTE != null)
                .OrderBy(i => i.SORT_ATTRIBUTE).ToList();
            if (reportStructureToSort.Any())
            {
                var orderSql = new StringBuilder(" order by ");
                var lastField = reportStructureToSort.Last();
                foreach (var item in reportStructureToSort.Where(i => i.SORT_ATTRIBUTE != null)
                    .OrderBy(i => i.SORT_ATTRIBUTE).ToList())
                {
                    orderSql.Append(item.SEGMENT_RULE);
                    if (!item.Equals(lastField))
                    {
                        orderSql.Append(",");
                    }
                }
                sql += orderSql.ToString();
            }

            return _entities.ExecuteStoreQuery<DetailedReport>(sql, arrayParams).ToList();
        }

        public void BlockFile(string reportDate, decimal fileId, string kf, decimal versionId)
        {
            var sql = @"begin 
                            nbur_files.p_block_file(
                                to_date(:p_report_date, 'dd/mm/yyyy'),
                                :p_kf,
                                :p_version_id,
                                :p_file_id,
                                :p_status_code,
                                :p_status_mes); 
                        end;";


            var oraStatusCode = new OracleParameter("p_status_code", OracleDbType.Varchar2, 200)
            {
                Direction = ParameterDirection.ReturnValue
            };
            var oraStatusMessage = new OracleParameter("p_status_mes", OracleDbType.Varchar2, 3500)
            {
                Direction = ParameterDirection.ReturnValue
            };
            _entities.ExecuteStoreCommand(sql,
                new OracleParameter("p_report_date", OracleDbType.Varchar2) { Value = reportDate},
                new OracleParameter("p_kf", OracleDbType.Varchar2) { Value = kf },
                new OracleParameter("p_version_id", OracleDbType.Decimal) { Value = versionId},
                new OracleParameter("p_file_id ", OracleDbType.Decimal) { Value = fileId }, oraStatusCode, oraStatusMessage);
            var resultStatus = oraStatusCode.Value.ToString();
            var resultMessage = oraStatusMessage.Value.ToString();

            if (resultStatus.ToUpper() != "OK")
            {
                throw new Exception(resultMessage);
            }
        }

        public decimal? GetCustType(decimal rnk)
        {
            var sql = "select custtype from customer where rnk = :p_rnk";
            var custType = _entities.ExecuteStoreQuery<decimal?>(sql, rnk).FirstOrDefault();
            return custType;
        }

        #region detailed report data 'Dynamic'
        public List<AllColComments> GetTableComments(string tableName)
        {
            string sql = @"SELECT T.COLUMN_NAME, T.COMMENTS
                          FROM all_col_comments t
                         WHERE T.OWNER = 'BARS' AND T.TABLE_NAME = :P_TABLE_NAME";
            List<AllColComments> tc = _entities.ExecuteStoreQuery<AllColComments>(sql, tableName).ToList();
            return tc;
        }

        public string GetViewName(string fileCode, bool isDtl)
        {
            string sql = @"select T.VIEW_NM 
                            from NBUR_REF_FILES t 
                           where T.FILE_CODE = :P_FILE_CODE";
            string vn = _entities.ExecuteStoreQuery<string>(sql, fileCode).FirstOrDefault();
            if (string.IsNullOrEmpty(vn))
            {
                throw new Exception(string.Format("Не знайдено даних деталізованих для файлу:{0}", fileCode));
            }
            return isDtl ? string.Format("{0}_DTL", vn) : vn;
        }

        public string GetFileFmt(string fileCode, bool isDtl)
        {
            string sql = @"select T.FILE_FMT 
                            from NBUR_REF_FILES t 
                           where T.FILE_CODE = :P_FILE_CODE";
            string vn = _entities.ExecuteStoreQuery<string>(sql, fileCode).FirstOrDefault();
            if (string.IsNullOrEmpty(vn))
            {
                throw new Exception(string.Format("Не знайдено даних деталізованих для файлу:{0}", fileCode));
            }
            return isDtl ? string.Format("{0}_DTL", vn) : vn;
        }

        public IEnumerable<Dictionary<string, object>> GetDetailedReportDyn(DataSourceRequest request, string vn,
            string fileCode, string reportDate, string kf, string fieldCode, string schemeCode, string nbuc,bool isDtl = false)
        {
            try
            {

            var formFinished = GetNburListFromFinished(fileCode, reportDate, kf);
            decimal versionId = formFinished.VERSION_ID;
            HttpContext context = HttpContext.Current;
            context.Session[CurrentVersionId] = versionId;
            CultureInfo cultureinfo = new CultureInfo("uk-UA");
            DateTime date = DateTime.Parse(reportDate, cultureinfo).Date;

            List<OracleParameter> listParams = new List<OracleParameter>
            {
                new OracleParameter("p_versionId ", OracleDbType.Decimal) {Value = versionId},
                new OracleParameter("p_kf", OracleDbType.Varchar2) {Value = kf},
                new OracleParameter("p_reportDate", OracleDbType.Date) {Value = date},
            };
            StringBuilder sql = new StringBuilder(string.Format(@"select *
                        FROM 
                            {0} 
                        where 
                            VERSION_ID = :p_versionId 
                            and KF = :p_kf 
                            and REPORT_DATE = :p_reportDate
                             ", vn));
            if (!string.IsNullOrEmpty(fieldCode))
            {
                sql.Append(" and FIELD_CODE = :p_fieldCode ");
                listParams.Add(new OracleParameter("p_fieldCode ", OracleDbType.Varchar2) {Value = fieldCode});
            }
            if (!string.IsNullOrEmpty(nbuc))
            {
                sql.Append(" and NBUC = :p_nbuc ");
                listParams.Add(new OracleParameter("p_nbuc ", OracleDbType.Varchar2) {Value = nbuc});
            }

            var reportStructure = GetReportStructure(fileCode, schemeCode).ToList();
            var reportStructureToSort = reportStructure.Where(i => i.SORT_ATTRIBUTE != null)
                .OrderBy(i => i.SORT_ATTRIBUTE).ToList();
            if (reportStructureToSort.Any())
            {
                var orderSql = new StringBuilder(" order by ");
                var lastField = reportStructureToSort.Last();
                foreach (var item in reportStructureToSort.Where(i => i.SORT_ATTRIBUTE != null)
                    .OrderBy(i => i.SORT_ATTRIBUTE).ToList())
                {
                    orderSql.Append(item.SEGMENT_RULE);
                    if (!item.Equals(lastField))
                    {
                        orderSql.Append(",");
                    }
                }
                sql.Append(orderSql.ToString());
            }

            BarsSql bSql = new BarsSql
            {
                SqlText = sql.ToString(),
                SqlParams = listParams.ToArray()
            };
            var query = _sqlTransformer.TransformSql(bSql, request);
            
            List<Dictionary<string, object>> data = new List<Dictionary<string, object>>();
                if (isDtl)
                    return GetOracleConnector.ReadDataLazy(query.SqlText, listParams.ToArray());
            using (OracleConnection connection = Bars.Classes.OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = connection.CreateCommand())
            {
                cmd.Parameters.AddRange(query.SqlParams);
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = query.SqlText;
                using (OracleDataReader reader = cmd.ExecuteReader())
                {
                   
                    while (reader.Read())
                    {
                        Dictionary<string, object> row = new Dictionary<string, object>();
                        for (int i = 0; i < reader.FieldCount; i++)
                        {
                            string key = reader.GetName(i);
                            var value = reader[i];
                            row[key] = value;
                        }
                        data.Add(row);
                    }
                }
            }
            return data;

            }
            catch (Exception ex)
            {
                Logger.Error("NbuRepository.GetDetailedReportDyn " + ex.Message);
                throw;
            }
        }

        public List<TableInfo> GetTableInfo(string tableName)
        {
            List<TableInfo> tsi = new List<TableInfo>();

            using (OracleConnection connection = Bars.Classes.OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = connection.CreateCommand())
            {
                cmd.CommandText = string.Format(@"select * from {0} where 1=0", tableName);
                using (var reader = cmd.ExecuteReader())
                {
                    DataTable dt = reader.GetSchemaTable();

                    foreach (DataRow myField in dt.Rows)
                    {
                        DataColumn ColumnName = dt.Columns["ColumnName"];
                        DataColumn ColumnSize = dt.Columns["ColumnSize"];
                        DataColumn DataType = dt.Columns["DataType"];
                        DataColumn AllowDBNull = dt.Columns["AllowDBNull"];

                        tsi.Add(new TableInfo(
                            myField[ColumnName].ToString(),
                            Convert.ToInt32(myField[ColumnSize].ToString()),
                            myField[DataType].ToString(),
                            Convert.ToBoolean(myField[AllowDBNull].ToString())
                        ));
                    }
                }
            }

            return tsi;
        }

        #endregion
    }
}