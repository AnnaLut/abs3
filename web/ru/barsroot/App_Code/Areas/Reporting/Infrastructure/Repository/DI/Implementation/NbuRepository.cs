using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using Areas.Reporting.Models;
using BarsWeb.Areas.Async.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Reporting.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Reporting.Models;
using Oracle.DataAccess.Client;
using System.Text;
using System.Globalization;

namespace BarsWeb.Areas.Reporting.Infrastructure.Repository.DI.Implementation
{
    public class NbuRepository : INbuRepository
    {
        readonly ReportingEntities _entities;
        private readonly ITasksRepository _tasksRepository;
        public NbuRepository(IReportingModel model,ITasksRepository tasksRepository)
        {
		    _entities = model.ReportingEntities;
            _tasksRepository = tasksRepository;
        }

        public IEnumerable<ReportStructure> GetReportStructure(string code)
        {
            const string sql = @"select 
                                    a.kodf as kod,
                                    a.natr as AttrNum,
                                    a.name as AttrName,
                                    a.val as value,
                                    a.iscode as iscode,
                                    a.a017 as a017,
                                    a.code_sort as sort,
                                    decode(substr(lower(trim(val)), 1, 11), 'substr(kodp', 
                                        substr(val, instr(val, ',', 1, 2)+1, instr(val, ')') - instr(val, ',', 1, 2) - 1), 
                                        255) len
                                from 
                                    form_stru a
                                where 
                                    kodf = :p_kodf
                                order by 
                                    a.natr";
            object[] parameters =         
            { 
                new OracleParameter("p_kodf",OracleDbType.Varchar2).Value = code
            };
            var structure = _entities.ExecuteStoreQuery<ReportStructure>(sql, parameters).OrderBy(i => i.Sort);
            return structure.OrderBy(i=>i.AttrNum);
        }

        public DataSet GetReportData(string code, string date, string isCon)
        {
            var viewKod = kodfСheck(code) == null ? "0" : kodfСheck(code);
            var sql = new Utils().CreateReportQuery(code, date, isCon, viewKod, GetReportStructure(code));
            //StartCreateReport(code, date);

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            var dataSet = new DataSet();
            var adapter = new OracleDataAdapter(sql,con);
            adapter.Fill(dataSet);
            return dataSet;
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
        public string StartCreateReport(string code, string date)
        {
            string schedulerCode = "NBU_REP_" + code.ToUpper();
            var param = _tasksRepository.GetSсhedulerParameters(schedulerCode);

            var paramDate =  param.FirstOrDefault(i => i.Name == "P_DATE");
            if(paramDate != null)
            {
                CultureInfo cultureinfo = new CultureInfo("uk-UA");
                DateTime nDate = DateTime.Parse(date, cultureinfo);
                paramDate.Value = nDate;//Convert.ToDateTime(date);
            }
            var task = _tasksRepository.StartTask(schedulerCode,param);
            return task;
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
            OracleCommand cmd = new OracleCommand("BARS.F_CREATEFILENAME_WEB", conn) { CommandType = CommandType.StoredProcedure };

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
            conn.Dispose();
            conn.Clone(); 

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
        public IEnumerable<Archive> ArchiveGrid(string kodf)
        {
            // НБУ
            const decimal rMode = 0; 

            const string arc = @"
                select kodf, datf, fio, dat_blk
                from v_otcn_flag_blk
                where kodf = :p_Rep_Code
                    and tp = :p_nRMode
                order by datf desc
            ";
            object[] arcParams = { 
                new OracleParameter("p_Rep_Code",OracleDbType.Varchar2) { Value = kodf },
                new OracleParameter("p_nRMode",OracleDbType.Decimal) { Value = rMode }                  
            };
            var result = _entities.ExecuteStoreQuery<Archive>(arc, arcParams);
            return result;
        }
    }  
}