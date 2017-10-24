using Areas.RequestsProcessing.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.RequestsProcessing.Infrastructure.DI.Abstract;
using BarsWeb.Core.Models;
using BarsWeb.Models;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Text;

namespace BarsWeb.Areas.RequestsProcessing.Infrastructure.DI.Implementation
{
    public class RequestsProcessingRepository : IRequestsProcessingRepository
    {
        readonly RequestsProcessingModel _RequestsProcessing;
        readonly IKendoSqlTransformer _sqlTransformer;
        readonly IKendoSqlCounter _kendoSqlCounter;
        readonly IParamsRepository _globalData;
        public RequestsProcessingRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter, IParamsRepository globalData)
        {
            _RequestsProcessing = new RequestsProcessingModel(EntitiesConnection.ConnectionString("RequestsProcessingModel", "RequestsProcessing"));

            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _globalData = globalData;
        }

        #region Global search & Count
        public IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _RequestsProcessing.ExecuteStoreQuery<T>(query.SqlText, query.SqlParams);
            return item;
        }
        public decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _kendoSqlCounter.TransformSql(searchQuery, request);
            ObjectResult<decimal> res = _RequestsProcessing.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams);
            decimal count = res.Single();
            return count;
        }
        public IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery)
        {
            return _RequestsProcessing.ExecuteStoreQuery<T>(searchQuery.SqlText, searchQuery.SqlParams);
        }

        public int ExecuteStoreCommand(string commandText, params object[] parameters)
        {
            return _RequestsProcessing.ExecuteStoreCommand(commandText, parameters);
        }

        public Params GetParam(string id)
        {
            return _globalData.GetParam(id);
        }
        #endregion

        /// <summary>
        /// Get Main Data
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public List<Dictionary<string, object>> GetDynamic(DynamicRequestData obj)
        {
            RequestsProcessingMainParam mainParams = MainParam(obj.KODZ);

            // get form_proc
            if (!string.IsNullOrEmpty(mainParams.FORM_PROC))
            {
                string formProcSql = string.Format(@"begin {0}; end;", mainParams.FORM_PROC);
                // insert params into form_proc
                if (obj.PARAMS.Count > 0) { FillParams(ref formProcSql, obj.PARAMS); }
                try
                {
                    ExecuteStoreCommand(formProcSql, new object[] { });
                }
                catch (Exception e)
                {
                    string eText = string.Format("SQL:{0} {1}", formProcSql, e.Message);
                    throw new Exception(eText);
                }                
            }          
            // main SQL
            string sqlStr = mainParams.TXT;     

            // insert params into main SQL
            if (obj.PARAMS.Count > 0) { FillParams(ref sqlStr, obj.PARAMS); }
            return DynamicCreator.GetObject(sqlStr);
        }

        /// <summary>
        /// Get dictionary object for KODZ
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public List<DynamicDictResult> GetDynamicDict(DynamicRequestData obj)
        {
            List<DynamicDictResult> result = new List<DynamicDictResult>();

            RequestsProcessingMainParam mainParams = MainParam(obj.KODZ);
            string bindSqlStr = mainParams.BIND_SQL;

            if (!string.IsNullOrEmpty(bindSqlStr))
            {
                bindSqlStr = bindSqlStr.Replace("'", "");
                List<string> sList = Parse(bindSqlStr);

                foreach (string paramS in sList)
                {
                    if (!string.IsNullOrEmpty(paramS))
                    {
                        string[] paramArr = paramS.Split('|');
                        string[] firstParam = paramArr[0].Split('=');
                        string ID = firstParam[0];
                        string tabName = firstParam[1];

                        List<string> fieldsList = new List<string>();
                        fieldsList.AddRange(paramArr[1].Split(','));
                        if(paramArr.Length > 2)
                        {
                            fieldsList.AddRange(paramArr[2].Split(','));
                        }
                        fieldsList = fieldsList.Distinct().ToList();
                        string sqlPrefix = paramArr.Length > 3 ? string.Format(" {0}", paramArr[3]) : "";

                        BarsSql tableSemanticSql = SqlCreator.TableSemanticSql(tabName);
                        TableSemantic tableSemantic = ExecuteStoreQuery<TableSemantic>(tableSemanticSql).FirstOrDefault();

                        BarsSql tableColumnsSql = SqlCreator.TableColumnsSql(tableSemantic.tabid);
                        List<TableColumns> tableColumns = ExecuteStoreQuery<TableColumns>(tableColumnsSql).ToList();

                        List<TableColumns> tableColumns4Client = new List<TableColumns>();
                        StringBuilder sqlFinal = new StringBuilder("select ");
                        for (int i = 0; i < fieldsList.Count; i++)
                        {
                            foreach(TableColumns tc in tableColumns)
                            {
                                if(tc.colname == fieldsList[i])
                                {
                                    tableColumns4Client.Add(tc);
                                    break;
                                }
                            }
                            sqlFinal.Append(fieldsList[i]);
                            if (i < fieldsList.Count - 1) { sqlFinal.Append(","); }
                        }
                        sqlFinal.Append(string.Format(" from {0} {1}", tabName, sqlPrefix));

                        List<Dictionary<string, object>> data = DynamicCreator.GetObject(sqlFinal.ToString());

                        result.Add(new DynamicDictResult
                        {
                            ID = ID,
                            data = data,
                            tableColumns = tableColumns4Client,
                            tableSemantic = tableSemantic
                        });
                    }
                }
            }
            return result;
        }

        /// <summary>
        /// Replace parameters in SQL expression
        /// Example: p.ID = ":sFdat1"       p.VALUE = "'01/01/2016'"
        /// </summary>
        /// <param name="sqlStr"></param>
        /// <param name="PARAMS"></param>
        void FillParams(ref string sqlStr, List<DynamicRequestParams> PARAMS)
        {
            foreach (DynamicRequestParams p in PARAMS)
            {
                if (sqlStr.IndexOf(p.ID) != -1)
                {
                    sqlStr = sqlStr.Replace(p.ID, string.IsNullOrEmpty(p.VALUE) ? "'' " : p.VALUE);
                }
            }
        }

        RequestsProcessingMainParam MainParam(decimal KODZ)
        {
            BarsSql sqlParams = SqlCreator.SearchMainByKodz(KODZ);
            IEnumerable<RequestsProcessingMainParam> paramsEnum = ExecuteStoreQuery<RequestsProcessingMainParam>(sqlParams);
            return paramsEnum.FirstOrDefault();
        }

        /// <summary>
        /// Parse string like ":sFdat1='',:T='Код папки (0-всі)',:I='Код викон(0=всi)'"
        /// Result: ["sFdat1=''",    "T='Код папки (0-всі)'",    "I='Код викон(0=всi)'"]
        /// </summary>
        /// <param name="parseString"></param>
        /// <returns></returns>
        List<string> Parse(string parseString)
        {
            string newS = string.Empty;
            List<string> sList = new List<string>();
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < parseString.Length; i++)
            {
                char curS = parseString[i];
                if (curS == ',' && i < parseString.Length + 1 && parseString[i + 1] == ':')
                {
                    continue;
                }
                if (curS == ':')
                {
                    newS = sb.ToString();
                    if (!string.IsNullOrEmpty(newS))
                    {
                        sList.Add(newS);
                        sb.Clear();
                    }
                }
                else
                {
                    sb.Append(curS);
                }
            }
            // put last item
            newS = sb.ToString();
            if (!string.IsNullOrEmpty(newS))
            {
                sList.Add(newS);
                sb.Clear();
            }
            return sList;
        }
    }
}
