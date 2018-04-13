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
                                    a.code_sort as sort   
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

        public DataSet GetReportData(string code, string date)
        {
            var sql = new Utils().CreateReportQuery(code, date, GetReportStructure(code));

            //StartCreateReport(code, date);

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            var dataSet = new DataSet();
            var adapter = new OracleDataAdapter(sql,con);
            adapter.Fill(dataSet);
            return dataSet;
        }

        public string StartCreateReport(string code, string date)
        {
            string schedulerCode = "NBU_REP_" + code.ToUpper();
            var param = _tasksRepository.GetSсhedulerParameters(schedulerCode);

            var paramDate =  param.FirstOrDefault(i => i.Name == "P_DATE");
            if(paramDate != null)
            {
                paramDate.Value = Convert.ToDateTime(date);
            }
            var task = _tasksRepository.StartTask(schedulerCode,param);
            return task;
        }

        public string GetReportFile(string code, DateTime date)
        {
            const string sql = @"select nbu_rep.get_report_file(:p_code,:p_date) from dual";
            object[] parameters =         
            { 
                new OracleParameter("p_code",OracleDbType.Varchar2){Value = code},
                new OracleParameter("p_code",OracleDbType.Date){Value = date}
            };

            var result = _entities.ExecuteStoreQuery<string>(sql, parameters).FirstOrDefault();
            return result;
        }
    }  
}