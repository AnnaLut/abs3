using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using Areas.Ndi.Models;
using Bars.Classes;
using BarsWeb.Areas.Ndi.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Ndi.Models;
using BarsWeb.Models;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using Oracle.DataAccess.Client;
using System.Diagnostics;
using BarsWeb.Core.Logger;
using Ninject;
using System.Web;
using Newtonsoft.Json;
using barsroot.core;
using Bars.Configuration;
using System.Data;
using barsroot.Areas.Ndi.Infrastructure.Helpers;
using ExcelLibrary;
using Oracle.DataAccess.Types;
using BarsWeb.Areas.Ndi.Models.FilterModels;
using BarsWeb.Areas.Ndi.Models.ViewModels;
using MvcContrib.EnumerableExtensions;
using WebGrease.Css.Extensions;
using Bars.Oracle;
using BarsWeb.Areas.Ndi.Models.DbModels;
using BarsWeb.Areas.Ndi.Infrastructure.Repository.Helpers;
using BarsWeb.Areas.Ndi.Infrastructure.Helpers;
using BarsWeb.Areas.Ndi.Infrastructure.Constants;
using BarsWeb.Areas.Ndi.Infrastructure.Helpers.ViewModels;

namespace BarsWeb.Areas.Ndi.Infrastructure.Repository.DI.Implementation
{
    public class ReferenceBookRepository : IReferenceBookRepository
    {
        private readonly NdiModel _entities;
        [Inject]
        public IDbLogger Logger { get; set; }
        private bool IsDebug = true;
        private string LoggerPrefix = "ReferenceBookRepository.";
        private OracleDbModel oracleConnector = null;
        private UserMap _user;// = ConfigurationSettings.GetCurrentUserInfo;


        public OracleDbModel GetOracleConnector
        {
            get
            {
                if (oracleConnector == null)
                    oracleConnector = new OracleDbModel();
                return oracleConnector;
            }

        }


        public ReferenceBookRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("Ndi", "Ndi");
            _entities = new NdiModel(connectionStr);
            _user = ConfigurationSettings.GetCurrentUserInfo;
        }

        /// <summary>
        /// Получить тип данных C#, по переданному коду типа данных (описываются в META_COLTYPES)
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public static TypeCode GetCsTypeCode(string code)
        {
            switch (code)
            {
                case "N":
                    return TypeCode.Decimal;
                case "C":
                    return TypeCode.String;
                case "D":
                    return TypeCode.DateTime;
                case "B":
                    return TypeCode.Decimal;
                default:
                    return TypeCode.String;
            }
        }


        public static OracleDbType GetOutParam(string code)
        {
            switch (code)
            {
                case "S":
                    return OracleDbType.Varchar2;
                case "clob":
                    return OracleDbType.Clob;
                default:
                    return OracleDbType.Varchar2;
            }
        }
        /// <summary>
        /// Выполнить экспорт данных в Excel
        /// </summary>
        /// <param name="tableId"></param>
        /// <param name="tableName"></param>
        /// <param name="sort"></param>
        /// <param name="gridFilter"></param>
        /// <param name="externalFilter"></param>
        /// <param name="fallDownFilter"></param>
        /// <param name="start"></param>
        /// <param name="limit"></param>yf 
        /// <param name="getAllRecords">Экспорт всех строк. Если указано, то игнорируются параметры <see cref="start"/>, <see cref="limit"/></param>
        /// <returns></returns>
        public ExcelResulModel ExportToExcel(ExcelDataModel excelDataModel)
        {

            try
            {
                // вычитка метаданных колонок, метаданные по таблице приходят с клиента   
                var columnsInfo = GetNativeColumnsMetaInfo(excelDataModel.TableId);

                //вычитаем инфу о внешних колонках
                List<ColumnMetaInfo> extColumnsList = GetExternalColumnsMeta(excelDataModel.TableId).ToList();
                extColumnsList = SelectBuilder.BuildExternalColumnsToColumns(extColumnsList);
                var allColumnsInfo = columnsInfo;

                //////добавим внешние колонки в нужном порядке
                foreach (var extColId in extColumnsList.Select(ec => ec.COLID).Distinct())
                {
                    int idx = allColumnsInfo.IndexOf(allColumnsInfo.Single(ci => ci.COLID == extColId));
                    allColumnsInfo.InsertRange(++idx, extColumnsList.Where(ec => ec.COLID == extColId).ToList());
                }

                //allColumnsInfo.AddRange(extColumnsList);
                allColumnsInfo = allColumnsInfo.ToList();
                var selectBuilder = new SelectBuilder
                {
                    TableName = excelDataModel.TableName,
                    TableId = excelDataModel.TableId,
                    StartRecord = excelDataModel.Start,
                    RecordsCount = excelDataModel.Limit,
                    GridFilter = FormatConverter.JsonToObject<GridFilter[]>(excelDataModel.GridFilter),
                    // StartFilter = startFilter,
                    //OrderParams = sort,
                    NativeMetaColumns = columnsInfo,
                    ExternalMetaColumns = extColumnsList,
                    // ExtFilters = externalFilter,
                    AdditionalColumns = ConditionalPainting.GetColumns(excelDataModel.TableId)
                };
                var tableSemantic = _entities.META_TABLES.First(t => t.TABID == excelDataModel.TableId).SEMANTIC;
                Logger.Info(string.Format("begin get data for excel export table: {0} ", excelDataModel.TableName), LoggerPrefix);
                GetDataResultInfo dataResult = GetData(excelDataModel);
                //Logger.Info(string.Format("begin excel export table: {0} dataCount: {1} ", excelDataModel.TableName, dataResult.DataRecords.Count()), LoggerPrefix);
                return ExcelHelper.ExcelExport(tableSemantic, dataResult, allColumnsInfo, excelDataModel, selectBuilder.GetFilterParams());



            }
            finally
            {
                this.GetOracleConnector.Dispose();
            }
            // return result;
        }

        public byte[] GetButtonImg()
        {
            IconsMetainfo result = _entities.ExecuteStoreQuery<IconsMetainfo>("SELECT * FROM META_ICONS WHERE ICON_ID = 2").FirstOrDefault();
            return result.IMAGE;
        }

        //public IEnumerable<Dictionary<string,object>> BindDataResult(IEnumerable<Dictionary<string,object>> resultForBind,List<ColumnMetaInfo> columns)
        //{
        //    List<Dictionary<string, object>> resList = new List<Dictionary<string, object>>();
        //    Dictionary<string, object> dict;
        //    foreach (var item in resultForBind.ToList())
        //    {
        //        columns.Select( x => x.COLNAME).ToDictionary( item, item.FirstOrDefault(e => e.Key == ))
        //    }
        //}
        /// <summary>
        /// Обновить данные справочника
        /// </summary>
        /// <param name="tableId">Код справочника</param>
        /// <param name="tableName">Название таблицы таблицы</param>
        /// <param name="updatableRowKeys">Значениями ключевых полей по которым выполнять update (используется оптимистическая блокировка)</param>
        /// <param name="updatableRowData">Новые значения полей, которые были изменены</param>
        /// <exception cref="Exception"></exception>
        /// <returns>Признак успешной операции</returns>
        public bool EditData(int tableId, string tableName, EditRowModel editDataModel, bool multipleUse = false)
        {
            // OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                // выполнить sql-процедуру, которая подменяет выполенение прямого запроса к таблице
                List<FieldProperties> RowDataForProsedur = DataRecordExtensions.Clone<FieldProperties>(editDataModel.OldRow);
                bool substituationProcedureExecuted = TryExecuteSubstituationProcedure(tableId, SqlOperation.Update, RowDataForProsedur, editDataModel.Modified, string.Empty, multipleUse);
                int updRowsCount = 0;
                if (!substituationProcedureExecuted)
                {
                    List<string> pKColumns = _entities.META_COLUMNS.Where(mc => mc.TABID == tableId && mc.SHOWRETVAL == 1).Select(x => x.COLNAME).ToList();
                    if (pKColumns != null && pKColumns.Count > 0)
                        editDataModel.OldRow = editDataModel.OldRow.Where(cl => pKColumns.Contains(cl.Name)).ToList();
                    else
                        editDataModel.OldRow.RemoveAll(x => editDataModel.Modified.All(u => u.Name == x.Name));
                    // выполнить прямой запрос к таблице
                    //
                    //Logger.Debug(string.Format("begin update with sql c#   updatableRowKeys count: ", editDataModel.RowKeysToEdit.Count, LoggerPrefix + "UpdateData"), LoggerPrefix + "UpdateData");
                    OracleCommand sqlUpdateCommand = GetOracleConnector.CreateCommand;
                    sqlUpdateCommand.BindByName = true;
                    var updateCmdText = new StringBuilder();
                    updateCmdText.AppendFormat("update {0} set ", tableName);

                    foreach (var data in editDataModel.Modified)
                    {
                        updateCmdText.AppendFormat("{0}=:p_{0},", data.Name);
                        if (data.Type != "C" && string.IsNullOrEmpty(data.Value))
                            data.Value = null;
                        if (data.Type == "N" && !string.IsNullOrEmpty(data.Value) && data.Value.Contains("E"))
                            data.Value = Decimal.Parse(data.Value, System.Globalization.NumberStyles.Float).ToString();
                        sqlUpdateCommand.Parameters.Add("p_" + data.Name, data.Value == null ? null : Convert.ChangeType(data.Value, SqlStatementParamsParser.GetCsTypeCode(data.Type)));
                    }
                    if (updateCmdText.Length > 0)
                    {
                        //убрать последнюю запятую
                        updateCmdText.Length = updateCmdText.Length - 1;
                    }

                    string whereSqlStr = "";
                    foreach (var key in editDataModel.OldRow)
                    {
                        if (!string.IsNullOrWhiteSpace(whereSqlStr))
                        {
                            whereSqlStr += " and ";
                        }
                        whereSqlStr += string.Format("(( :p_key_{0} is null and {0} is null) or ( {0}=:p_key_{0}))  ", key.Name);

                        var paramName = "p_key_" + key.Name;
                        if (key.Type != "C" && string.IsNullOrEmpty(key.Value))
                            key.Value = null;
                        var paramValue = key.Value == null ? null : Convert.ChangeType(key.Value, SqlStatementParamsParser.GetCsTypeCode(key.Type));

                        var param = new OracleParameter(paramName, paramValue);
                        sqlUpdateCommand.Parameters.Add(param);
                    }
                    updateCmdText.AppendFormat(" where {0}", whereSqlStr);

                    sqlUpdateCommand.CommandText = updateCmdText.ToString();
                    Logger.Debug(string.Format("execure sql command: {0}", sqlUpdateCommand.CommandText), LoggerPrefix + "UpdateData");
                    updRowsCount = sqlUpdateCommand.ExecuteNonQuery();
                }
                Logger.Debug(string.Format("count updated rows: {0}", updRowsCount), LoggerPrefix + "UpdateData");
                return substituationProcedureExecuted || updRowsCount > 0;
            }
            catch (Exception e)
            {
                throw;
            }
            finally
            {
                if (!multipleUse)
                    GetOracleConnector.Dispose();
                //connection.Close();
            }
        }

        public bool InsertUpdateRows(int tableId, string tableName, List<EditRowModel> editingRowsModels, List<AddRowModel> addingRowsModels)
        {
            bool res = false;

            try
            {
                OracleConnection conn = GetOracleConnector.GetConnectionWithBeginTransaction;

                if (addingRowsModels != null && addingRowsModels.Count > 0)
                {
                    foreach (var item in addingRowsModels)
                    {
                        res = InsertData(tableId, tableName, item.RowToAddFielsdArray, true);
                        if (!res)
                        {
                            this.GetOracleConnector.MyTransaction.Rollback();
                            return res;
                        }
                    }
                }


                foreach (var item in editingRowsModels)
                {
                    res = EditData(tableId, tableName, item, true);
                    if (!res)
                    {
                        this.GetOracleConnector.DisposeWithTransaction(false);
                        return false;
                    }

                }
                //command.Transaction.Commit();
                this.GetOracleConnector.CommitTransaction();
                return res;
            }
            catch (Exception e)
            {
                this.GetOracleConnector.DisposeWithTransaction(false);
                throw;
            }
            finally
            {
                this.GetOracleConnector.Dispose();
                this.oracleConnector = null;
            }

        }

        public bool DeleteRows(int tableId, string tableName, List<DeleteRowModel> deleteRowsModels)
        {
            bool res = false;
            try
            {
                OracleConnection conn = this.GetOracleConnector.GetConnectionWithBeginTransaction;
                foreach (var item in deleteRowsModels)
                {
                    res = DeleteData(tableId, tableName, item.RowToDelete, true);
                    if (!res)
                    {
                        this.GetOracleConnector.MyTransaction.Rollback();
                        return false;
                    }
                }
                this.GetOracleConnector.MyTransaction.Commit();
                return res;
            }
            catch (Exception e)
            {
                this.GetOracleConnector.MyTransaction.Rollback();
                throw;
            }
            finally
            {
                this.GetOracleConnector.Dispose();
                this.oracleConnector = null;
            }

        }
        /// <summary>
        /// Вставить данные в справочник
        /// </summary>
        /// <param name="tableId">Код справочника</param>
        /// <param name="tableName">Название таблицы таблицы</param>
        /// <param name="insertableRow">Данные для вставки для вставки</param>
        /// <exception cref="Exception"></exception>
        /// <returns>Признак успешной операции</returns>
        public bool InsertData(int tableId, string tableName, List<FieldProperties> insertableRow, bool isMultipleProcedure = false)
        {
            //OracleConnection connection = OraConnector.Handler.UserConnection;

            try
            {
                // выполнить sql-процедуру, которая подменяет выполенение прямого запроса к таблице
                bool substituationProcedureExecuted = TryExecuteSubstituationProcedure(tableId, SqlOperation.Insert,
                    insertableRow, null, "", isMultipleProcedure);
                int insRowsCount = 0;
                if (!substituationProcedureExecuted)
                {
                    // выполнить прямой запрос к таблице
                    OracleCommand sqlInsertCommand = this.GetOracleConnector.GetCommandOrCreate;// connection.CreateCommand();
                    if (sqlInsertCommand.Parameters != null && sqlInsertCommand.Parameters.Count > 0)
                        sqlInsertCommand.Parameters.Clear();
                    sqlInsertCommand.BindByName = true;

                    var insertFieldNames = new StringBuilder();
                    var insertFieldValues = new StringBuilder();

                    foreach (var data in insertableRow)
                    {
                        insertFieldNames.AppendFormat("{0},", data.Name);
                        insertFieldValues.AppendFormat(":p_{0},", data.Name);
                        if (data.Type != "C" && string.IsNullOrEmpty(data.Value))
                            data.Value = null;
                        if (sqlInsertCommand.Parameters != null)
                            sqlInsertCommand.Parameters.Add("p_" + data.Name,
                                data.Value == null ? null : Convert.ChangeType(data.Value, SqlStatementParamsParser.GetCsTypeCode(data.Type)));
                    }
                    //убрать последнюю запятую
                    if (insertFieldNames.Length > 0)
                    {
                        insertFieldNames.Length = insertFieldNames.Length - 1;
                    }
                    if (insertFieldValues.Length > 0)
                    {
                        insertFieldValues.Length = insertFieldValues.Length - 1;
                    }

                    sqlInsertCommand.CommandText = string.Format("insert into {0}({1}) values ({2})", tableName,
                        insertFieldNames, insertFieldValues);
                    insRowsCount = sqlInsertCommand.ExecuteNonQuery();
                }
                return substituationProcedureExecuted || insRowsCount > 0;
            }
            catch (Exception e)
            {
                throw;
            }
            finally
            {
                if (!isMultipleProcedure)
                    this.GetOracleConnector.Dispose();
                //connection.Close();
            }
        }

        /// <summary>
        /// Удалить данные из справочника
        /// </summary>
        /// <param name="tableId">Код справочника</param>
        /// <param name="tableName">Название таблицы таблицы</param>
        /// <param name="deletableRow">Данные для удаления</param>
        /// <exception cref="Exception"></exception>
        /// <returns>Признак успешной операции</returns>
        public bool DeleteData(int tableId, string tableName, List<FieldProperties> deletableRow, bool isMultipleProcedure = false)
        {
            OracleConnection connection = this.GetOracleConnector.GetConnOrCreate;
            try
            {
                // выполнить sql-процедуру, которая подменяет выполенение прямого запроса к таблице
                bool substituationProcedureExecuted = TryExecuteSubstituationProcedure(tableId, SqlOperation.Delete, deletableRow, null, null, isMultipleProcedure);
                int delRowsCount = 0;
                if (!substituationProcedureExecuted)
                {
                    // выполнить прямой запрос к таблице
                    //
                    OracleCommand sqlDeleteCommand = connection.CreateCommand();
                    sqlDeleteCommand.BindByName = true;
                    List<string> pKColumns = _entities.META_COLUMNS.Where(mc => mc.TABID == tableId && mc.SHOWRETVAL == 1).Select(x => x.COLNAME).ToList();
                    if (string.IsNullOrEmpty(tableName))
                        tableName = _entities.META_TABLES.First(t => t.TABID == tableId).TABNAME;
                    string deleteCmdText = string.Format("delete from {0} where ", tableName);
                    if (pKColumns != null && pKColumns.Count > 0)
                        deletableRow = deletableRow.Where(cl => pKColumns.Contains(cl.Name)).ToList();
                    string whereSqlStr = "";
                    foreach (var field in deletableRow)
                    {
                        if (!string.IsNullOrWhiteSpace(whereSqlStr))
                        {
                            whereSqlStr += " and ";
                        }
                        whereSqlStr += string.Format("(( :p_key_{0} is null and {0} is null) or ( {0}=:p_key_{0}))  ", field.Name);
                        if (field.Type != "C" && string.IsNullOrEmpty(field.Value))
                            field.Value = null;
                        var paramName = "p_key_" + field.Name;
                        var paramValue = field.Value == null ? null : Convert.ChangeType(field.Value, SqlStatementParamsParser.GetCsTypeCode(field.Type));

                        var param = new OracleParameter(paramName, paramValue);

                        sqlDeleteCommand.Parameters.Add(param);
                    }
                    deleteCmdText += whereSqlStr;

                    sqlDeleteCommand.CommandText = deleteCmdText;
                    delRowsCount = sqlDeleteCommand.ExecuteNonQuery();
                }

                return substituationProcedureExecuted || delRowsCount > 0;
            }
            finally
            {
                if (!isMultipleProcedure)
                    connection.Close();
            }
        }

        /// <summary>
        /// Вызвать произвольную процедуру описанную в таблице META_NSIFUNCTION
        /// </summary>
        /// <param name="tableId">ID таблицы</param>
        /// <param name="funcId">ID функции</param>
        /// <param name="funcParams">Параметры процедуры и их значения</param>
        /// <exception cref="Exception"></exception>
        /// <returns>Сообщение о выполнении</returns>
        public string CallRefFunction(int? tableId, int? funcId, int? codeOper, int? columnId, List<FieldProperties> funcParams,
             string funcText = "", string msg = "", string web_form_name = "", string jsonSqlProcParams = "", List<FieldProperties> addParams = null)
        {
            OracleConnection connection = GetOracleConnector.GetConnOrCreate;
            CallFunctionMetaInfo callFunction = null;
            try
            {
                //List<FieldProperties> sqlSelectRowParams = string.IsNullOrEmpty(stringJsonSqlProcParams) || stringJsonSqlProcParams == "undefined" ? new List<FieldProperties>() : JsonConvert.DeserializeObject<List<FieldProperties>>(stringJsonSqlProcParams) as List<FieldProperties>;
                string nsiString = "";
                FunNSIEditFParams nsiParams = null;
                if (funcId.HasValue && tableId.HasValue)
                    callFunction = GetCallFunction(tableId.Value, funcId.Value);
                if (callFunction != null)
                    SqlStatementParamsParser.BuildFunction(callFunction);
                else if (codeOper.HasValue)
                {
                    nsiString = GetFunNSIEditFParamsString(null, codeOper, null, null, null);
                    nsiParams = new FunNSIEditFParams(nsiString);
                    callFunction = nsiParams.BuildNsiWebFormName(new CallFunctionMetaInfo());
                }
                else if (columnId.HasValue && tableId.HasValue)
                {
                    nsiString = GetFunNSIEditFParamsString(null, null, columnId.Value, tableId.Value, null);
                    nsiParams = new FunNSIEditFParams(nsiString);
                    callFunction = nsiParams.BuildNsiWebFormName(new CallFunctionMetaInfo());
                }
                else if (string.IsNullOrEmpty(funcText))
                    return "input funcid or text prodedure";
                OracleCommand callFunctionCmd = GetOracleConnector.GetCommandOrCreate;
                callFunctionCmd.BindByName = true;
                //строка вызова sql-процедуры находится задана в PROC_NAME
                string procText = !string.IsNullOrEmpty(funcText) ? funcText : callFunction.PROC_NAME;
                if (string.IsNullOrEmpty(procText))
                    return "немає назви процедури";
                procText = SqlStatementParamsParser.ReplaceCenturaNullConstants(procText);
                //callFunctionCmd.CommandText = procText;
                string logAddParamsMessage = "add parameters in: " + procText + " ";
                foreach (var par in funcParams.Where(x => x.Type != "CLOB" && x.Type != "BLOB"))
                {
                    if (procText.Contains(":" + par.Name))
                    {
                        var paramName = par.Name;
                        if (par.Type != "C" && string.IsNullOrEmpty(par.Value))
                            par.Value = null;
                        var paramValue = par.Value == null
                            ? null
                            : Convert.ChangeType(par.Value, SqlStatementParamsParser.GetCsTypeCode(par.Type));
                        logAddParamsMessage += "parameter name:  " + paramName + "Value:  " + paramValue;

                        var param = new OracleParameter(paramName, paramValue);
                        callFunctionCmd.Parameters.Add(param);
                        callFunctionCmd.BindByName = true;
                    }
                }
                Logger.Info(logAddParamsMessage);
                List<ParamMetaInfo> outParameters = null;
                ParamMetaInfo outMessageParam = null;
                string funcOutMessage = string.Empty;
                if (callFunction != null && !string.IsNullOrEmpty(callFunction.OutParams))
                {
                    outParameters = SqlStatementParamsParser.GetSqlFuncCallParamsDescription<ParamMetaInfo>(callFunction.PROC_NAME, callFunction.OutParams);
                    outMessageParam = outParameters.FirstOrDefault(x => x.ColType == "MESSAGE");
                    if (outMessageParam != null)
                        callFunctionCmd.Parameters.Add(outMessageParam.ColName, OracleDbType.Varchar2, 4000, funcOutMessage, ParameterDirection.Output);
                }

                List<UploadParamsInfo> uploadParams = null;
                if (callFunction != null && !string.IsNullOrEmpty(callFunction.UploadParams))
                {
                    SqlStatementParamsParser.AddUploadParameters(callFunction, GetOracleConnector, funcParams, addParams);

                }
                //вызвать процедуру
                callFunctionCmd.CommandText = string.Format(
                    "begin " +
                    "{0};" +
                    " end;",
                    procText);

                Logger.Info("ptocedure comand text: " + callFunctionCmd.CommandText);
                callFunctionCmd.ExecuteNonQuery();
                string successMessage = "Процедура виконана";
                if (callFunction != null && !string.IsNullOrEmpty(callFunction.MSG))
                    successMessage = callFunction.MSG;
                else
                    if (nsiParams != null && !string.IsNullOrEmpty(nsiParams.MSG))
                    successMessage = nsiParams.MSG;

                if (outMessageParam != null && !string.IsNullOrEmpty(outMessageParam.ColName))
                {
                    try
                    {
                        var res = callFunctionCmd.Parameters[outMessageParam.ColName].Value;
                        funcOutMessage = Convert.ToString(res) == "null" ? "" : Convert.ToString(res);
                        successMessage += "</br>" + funcOutMessage;
                    }
                    catch (Exception e) { throw e; }
                }

                return successMessage;
            }
            catch (Exception e)
            {
                Logger.Error(string.Format("message: {0},  trace: {1}", e.Message, e.StackTrace), LoggerPrefix +"ERROR");
                throw e;
            }
            finally
            {
                GetOracleConnector.Dispose();
            }
        }

        public string CallEachFuncWithMultypleRows(int? tableId, int? funcId, int? codeOper, int? columnId, MultiRowParamsDataModel dataModel,
            string funcText = "", string msg = "", string web_form_name = "", string ListjsonSqlProcParams = "")
        {

            string errorMessages = string.Empty;
            try
            {
                CallFunctionMetaInfo callFunction = CreateCallFunctionCommand(tableId, funcId, codeOper, columnId, funcText);
                if (callFunction.PROC_EXEC == "BATCH" || (callFunction.MultiParams != null && callFunction.MultiParams.Count() > 0))
                    return CallBatchFuncWithMultypleRowsParams(callFunction, dataModel, msg);
                List<FieldProperties> inputParams = dataModel.InputParams ?? new List<FieldProperties>();
                OracleCommand callFunctionCmd = GetOracleConnector.GetCommandOrCreate;
                int successCount = 0;
                int failCount = 0;
                if (dataModel != null && dataModel.RowsData.Count > 0)
                    foreach (var rowPar in dataModel.RowsData)
                    {
                        rowPar.RowParams.AddRange(inputParams);
                        if (callFunctionCmd.Parameters.Count > 0)
                            callFunctionCmd.Parameters.Clear();
                        foreach (var par in rowPar.RowParams)
                        {
                            if (callFunctionCmd.CommandText.Contains(":" + par.Name))
                            {
                                var paramName = par.Name;
                                if (par.Type != "C" && string.IsNullOrEmpty(par.Value))
                                    par.Value = null;
                                var paramValue = par.Value == null
                                    ? null
                                    : Convert.ChangeType(par.Value, SqlStatementParamsParser.GetCsTypeCode(par.Type));
                                Logger.Info("add parameter in: " + callFunctionCmd.CommandText + "parameter name:  " + paramName + "Value:  " + paramValue);
                                var param = new OracleParameter(paramName, paramValue);
                                callFunctionCmd.Parameters.Add(param);
                            }
                        }
                        try
                        {
                            callFunctionCmd.ExecuteNonQuery();
                            successCount++;
                        }
                        catch (Exception ex)
                        {
                            failCount++;
                            string errMsg = string.Format("поцедура рядка {0} виконана з помилкою: </br> {1} </br>", rowPar.RowIndex, ex.Message);
                            Logger.Error(errMsg);
                            if (failCount < 11)
                                errorMessages += errMsg;
                        }
                    }
                string resMessages = string.Format("виконані процедури: {0} з {1} </br> ", successCount, dataModel.RowsData.Count);
                if (!string.IsNullOrEmpty(errorMessages))
                    throw new Exception(resMessages += string.Format("помилки:  {0} ", errorMessages));

                return resMessages;
            }
            finally
            {
                GetOracleConnector.Dispose();
            }
        }

        public string CallBatchFuncWithMultypleRowsParams(CallFunctionMetaInfo callFunction, MultiRowParamsDataModel dataModel, string msg = "")
        {
            if ((callFunction.MultiRowsParams == null || callFunction.MultiRowsParams.Count() < 1) &&
                (callFunction.ConvertParamsInfo == null || callFunction.ConvertParamsInfo.Count() < 1))
                throw new Exception("немає багаторядкових параметрів");
            try
            {

                List<OutMessageParInfo> outParameters = null;
                string successMessage = "Процедура виконана";
                OutMessageParInfo outMessageParam = null;
                string funcOutMessage = string.Empty;

                OracleCommand callFunctionCmd = GetOracleConnector.GetCommandOrCreate;
                callFunctionCmd.BindByName = true;

                OraTypesHelper.AddMoltiParamsToProc(callFunction, dataModel, GetOracleConnector);


                if (dataModel.InputParams != null && dataModel.InputParams.Count() > 0)
                    OraTypesHelper.AddParamsToCommand(dataModel.InputParams, callFunctionCmd);
                if (callFunction != null && !string.IsNullOrEmpty(callFunction.OutParams))
                {
                    outParameters = SqlStatementParamsParser.GetSqlFuncCallParamsDescription<OutMessageParInfo>(callFunction.PROC_NAME, callFunction.OutParams);
                    outMessageParam = outParameters.FirstOrDefault(x => x.Kind.ToUpper() == "MESSAGE");
                    if (outMessageParam != null)
                        callFunctionCmd.Parameters.Add(outMessageParam.ColName, OracleDbType.Varchar2, 4000, funcOutMessage, ParameterDirection.Output);
                }
                callFunctionCmd.ExecuteNonQuery();
                if (outMessageParam != null && !string.IsNullOrEmpty(outMessageParam.ColName))
                {
                    funcOutMessage = Convert.ToString(callFunctionCmd.Parameters[outMessageParam.ColName].Value);
                    funcOutMessage = funcOutMessage == "null" ? "" : funcOutMessage;
                    successMessage += "</br>" + funcOutMessage;
                }
                return successMessage;
            }
            finally
            {
                GetOracleConnector.Dispose();
            }
        }

        public GetFileResult CallFunctionWithFileResult(int? tableId, int? funcId, int? codeOper, List<FieldProperties> funcParams,
          string funcText = "", string msg = "", string web_form_name = "", string jsonSqlProcParams = "")
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            CallFunctionMetaInfo callFunction = null;
            OracleClob clob = null;
            Encoding windows = Encoding.GetEncoding("windows-1251");
            Encoding unicode = Encoding.Unicode;
            byte[] unicodeBytes;
            byte[] asciiBytes;
            try
            {
                //List<FieldProperties> sqlSelectRowParams = string.IsNullOrEmpty(stringJsonSqlProcParams) || stringJsonSqlProcParams == "undefined" ? new List<FieldProperties>() : JsonConvert.DeserializeObject<List<FieldProperties>>(stringJsonSqlProcParams) as List<FieldProperties>;
                string nsiString = "";
                FunNSIEditFParams nsiParams = null;
                if (funcId.HasValue && tableId.HasValue)
                    callFunction = GetCallFunction(tableId.Value, funcId.Value);
                if (callFunction != null)
                    SqlStatementParamsParser.BuildFunction(callFunction);
                else if (codeOper.HasValue)
                {
                    nsiString = GetFunNSIEditFParamsString(null, codeOper, null, null, null);
                    nsiParams = new FunNSIEditFParams(nsiString);
                }
                else if (string.IsNullOrEmpty(funcText))
                    return new GetFileResult() { Result = "input funcid or text prodedure" };
                OracleCommand callFunctionCmd = connection.CreateCommand();

                //строка вызова sql-процедуры находится задана в PROC_NAME
                string procText = !string.IsNullOrEmpty(funcText) ? funcText : callFunction.PROC_NAME;
                if (string.IsNullOrEmpty(procText))
                    return new GetFileResult() { Result = "немає назви процедури" };
                procText = SqlStatementParamsParser.ReplaceCenturaNullConstants(procText);
                callFunctionCmd.CommandText = procText;

                if (funcParams != null && funcParams.Count > 0)
                    foreach (var par in funcParams)
                    {
                        if (procText.Contains(":" + par.Name))
                        {
                            var paramName = par.Name;
                            var paramValue = par.Value == null
                                ? null
                                : Convert.ChangeType(par.Value, SqlStatementParamsParser.GetCsTypeCode(par.Type));
                            Logger.Info("add parameter in: " + callFunctionCmd.CommandText + "parameter name:  " + paramName + "Value:  " + paramValue);
                            var param = new OracleParameter(paramName, paramValue);
                            callFunctionCmd.Parameters.Add(param);
                        }
                    }

                string name = null;
                GetFileResult result = null;
                OracleParameter clobParam = null;
                OracleParameter nameParam = null;
                List<OutParamsInfo> outParameters = null;
                List<ParamMetaInfo> systemParams = null;
                string clobParamName = null;
                string fileNameParam = null;

                if (callFunction != null && !string.IsNullOrEmpty(callFunction.OutParams))
                {
                    outParameters = SqlStatementParamsParser.GetSqlFuncCallParamsDescription<OutParamsInfo>(callFunction.PROC_NAME, callFunction.OutParams).Where(x => x.ColType != null).ToList();
                    OutParamsInfo param = outParameters.FirstOrDefault(x => x.ColType.ToUpper() == "CLOB" || x.ColType.ToUpper() == "BLOB");
                    if (param == null)
                        return null;
                    clobParamName = param.ColName;
                    OracleDbType paramType = param.ColType == "CLOB" ? OracleDbType.Clob : OracleDbType.Blob;
                    clobParam = new OracleParameter(clobParamName, paramType, null, ParameterDirection.Output);
                    callFunctionCmd.Parameters.Add(clobParam);
                    var firstFileNameInParams = outParameters.FirstOrDefault(x => x.Kind == "OUT_FILE_NAME");
                    if (firstFileNameInParams != null)
                    {
                        fileNameParam = firstFileNameInParams.ColName;
                        nameParam = new OracleParameter(fileNameParam, OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                        callFunctionCmd.Parameters.Add(nameParam);
                    }
                    else
                    {
                        name = SqlStatementParamsParser.GetFileNameParam(outParameters, funcParams, true);
                    }
                }

                callFunctionCmd.BindByName = true;
                //вызвать процедуру
                callFunctionCmd.CommandText = string.Format(
                    "begin " +
                    "{0};" +
                    " end;",
                    procText);

                Logger.Info("ptocedure comand text: " + callFunctionCmd.CommandText);
                callFunctionCmd.ExecuteNonQuery();
                if (nameParam != null && nameParam.Value != null)
                    fileNameParam = nameParam.Value.ToString();

                if (clobParam != null && clobParam.Value != null)
                {
                    //string retVal = ((OracleClob)callFunctionCmd.Parameters[clobParamName].Value).IsNull ? string.Empty : ((OracleClob)callFunctionCmd.Parameters[clobParamName].Value).Value;
                    clob = clobParam.Value as OracleClob;
                    name = fileNameParam ?? name;
                }


                if (clob != null)
                {
                    string clobRes = clob.IsNull ? string.Empty : clob.Value;
                    unicodeBytes = unicode.GetBytes(clobRes.ToString());
                    asciiBytes = Encoding.Convert(unicode, windows, unicodeBytes);


                    result = new GetFileResult() { FileBytesBody = asciiBytes, FileName = !string.IsNullOrEmpty(name) ? name : "file.txt", Result = "ok" };

                }

                string successMessage = "Процедура виконана";
                if (callFunction != null)
                    successMessage = callFunction.MSG;

                if (nsiParams != null && !string.IsNullOrEmpty(nsiParams.MSG))
                    successMessage = nsiParams.MSG;

                return result;
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                if (clob != null)
                {
                    clob.Close();
                    clob.Dispose();
                    clob = null;
                }

                connection.Close();
            }
        }
        /// <summary>
        /// Получить дерево справочников в формате необходимом для клиентского extjs дерева
        /// </summary>
        /// <param name="appId">Код приложения (REFAPP.CODEAPP)</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        public List<ReferenceTreeGroupNode> GetReferenceTree(string appId)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandText = "SELECT r.tabid, t.NAME, m.tabname, m.semantic, TRIM(p.acode) as acode "
                                  + "FROM REFERENCES r, refapp p, typeref t, meta_tables m "
                                  + "WHERE r.tabid = m.tabid "
                                  + "	AND r.TYPE = t.TYPE "
                                  + "	AND p.tabid = r.tabid "
                                  + "	AND TRIM(p.codeapp) = :app "
                                  + "ORDER BY 2, 4 ";
                cmd.Parameters.Add("app", appId);
                OracleDataReader rdr = cmd.ExecuteReader();

                string strLastGroup = string.Empty;
                ReferenceTreeGroupNode currentGroup = null;
                var referenceGroups = new List<ReferenceTreeGroupNode>();
                while (rdr.Read())
                {
                    string strGroup = rdr.GetOracleString(1).Value;
                    if (strGroup != strLastGroup) // новая группа справочников
                    {
                        currentGroup = new ReferenceTreeGroupNode
                        {
                            name = rdr["NAME"].ToString(),
                            expanded = false,
                            children = new List<ReferenceTreeNode>()
                        };
                        referenceGroups.Add(currentGroup);
                        strLastGroup = strGroup;
                    }

                    //параметры для url - id таблицы и режим доступа
                    var tableId = rdr["TABID"];
                    var mode = rdr["ACODE"];
                    string accessCode = mode as string == "RW" ? AccessParams.FullUpdate.ToString() : AccessParams.WithoutUpdate.ToString();
                    //справочник данной группы справочников
                    var reference = new ReferenceTreeNode
                    {
                        name = rdr["SEMANTIC"].ToString(),
                        leaf = true,
                        href = "/barsroot/ndi/referencebook/referencegrid?tableId=" + tableId + "&mode=" + mode + "&codeApp=" + appId
                    };
                    //для редактируемых справочников добавляем другую картинку
                    if (mode.ToString() == "RW")
                    {
                        reference.iconCls = "table-edit";
                    }
                    //добавляем справочник в текущую группу справочников
                    if (currentGroup != null)
                    {
                        currentGroup.children.Add(reference);
                    }
                }
                rdr.Close();
                return referenceGroups;
            }
            finally
            {
                connection.Close();
            }
        }

        /// <summary>
        /// Получить данные для выбора из связанного справочника
        /// </summary>
        /// <param name="tableName">Таблица из которой нужно выбрать данные</param>
        /// <param name="fieldForId">Поле таблицы с кодом</param>
        /// <param name="fieldForName">Поле таблицы с наименованием</param>
        /// <param name="query">Строка для поиска по код+наименование</param>
        /// <param name="start">Начальная позиция (для пэйджинга)</param>
        /// <param name="limit">Количество записей для выбора (для пэйджинга)</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        public List<Dictionary<string, object>> GetRelatedReferenceData(int? nativeTableId, string tableName, string fieldForId,
            string fieldForName, string query, string colName2 = null, int start = 0, int limit = 10)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                string srcCond = string.Empty;
                string queryValue = FilterHelper.BuildValueForLike(query);
                if (nativeTableId != null)
                {

                    //var metaTalbeInfo = GetMetaTableById(nativeTableId.Value);
                    IEnumerable<ColumnMetaInfo> nativeColumns = GetNativeColumnsMetaInfo(nativeTableId.Value);
                    var extInfo = GetExternalColumnsMeta(nativeTableId.Value).ToList();
                    ColumnMetaInfo column = nativeColumns.FirstOrDefault(e => e.COLNAME == fieldForId);
                    if (column != null)
                    {
                        var nativeColId = column.COLID;
                        var colInfo = extInfo.FirstOrDefault(x => x.COLID == nativeColId);
                        if (colInfo != null)
                            srcCond = colInfo.Src_Cond;
                    }

                }

                string condition = string.IsNullOrEmpty(srcCond) ? "" : "(" + srcCond + ") and";

                OracleCommand getDataCommand = connection.CreateCommand();

                if (!string.IsNullOrEmpty(colName2))
                    getDataCommand.CommandText = string.Format(
                @"select * from (select rownum rn, {0} as id, {1} as name , {2} as name2
                                                from {3} where {7}  (UPPER({0}) like UPPER('{6}') or UPPER({1}) like UPPER('{6}') 
                                                or UPPER({2}) like UPPER('{6}')) and rownum <= {5}) where rn > {4}",
                fieldForId, fieldForName, colName2, tableName, start, start + limit + 1, queryValue, condition);
                else
                    getDataCommand.CommandText = string.Format(
                        @"select * from (select rownum rn, {0} as id, {1} as name 
                                    from {2} where {6} (UPPER({0}) like UPPER('{5}') or UPPER({1}) like UPPER('{5}')) and rownum <= {4}) where rn > {3}",
                        fieldForId, fieldForName, tableName, start, start + limit + 1, queryValue, condition);

                var getDataReader = getDataCommand.ExecuteReader();
                var allData = AllRecordReader.ReadAll(getDataReader).ToList();
                return allData;
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                connection.Close();
            }
        }

        public ParamMetaInfo GetDefaultRelatedData(MetaTable srcTable)
        {
            // string sourcTabName = srcTabName;
            ParamMetaInfo refParam = new ParamMetaInfo();
            string nameColumn = string.Empty;
            string name2 = string.Empty;
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                // получить tabId
                //

                //OracleCommand selectTabId = connection.CreateCommand();
                //selectTabId.BindByName = true;
                //selectTabId.CommandText = "select tabid from meta_tables where tabname=:tabName";
                //selectTabId.Parameters.Add(new OracleParameter("tabName", sourcTabName));
                //var tabId = (decimal)selectTabId.ExecuteScalar();

                // получить имя первой колонки-первичного ключа
                //
                OracleCommand selectPkColumn = connection.CreateCommand();
                selectPkColumn.BindByName = true;
                selectPkColumn.CommandText = "select colname from meta_columns where tabid=:tabid and showretval=:showretval";
                selectPkColumn.Parameters.Add(new OracleParameter("tabid", Convert.ToDecimal(srcTable.TABID)));
                selectPkColumn.Parameters.Add(new OracleParameter("showretval", 1));
                var pkColumn = (string)selectPkColumn.ExecuteScalar();

                // pkColumn = FilterHelper.BuildValueForLike(pkColumn);

                // получить имя колонки-наименования
                //
                OracleCommand selectNameColumn = connection.CreateCommand();
                selectNameColumn.BindByName = true;
                selectNameColumn.CommandText = "select colname from meta_columns where tabid=:tabid and instnssemantic=:instnssemantic";
                selectNameColumn.Parameters.Add(new OracleParameter("tabid", Convert.ToDecimal(srcTable.TABID)));
                selectNameColumn.Parameters.Add(new OracleParameter("instnssemantic", 1));
                OracleDataReader reader = selectNameColumn.ExecuteReader();
                if (reader.Read())
                    nameColumn = reader.GetValue(0).ToString();
                // var nameColumn = (string)selectNameColumn.ExecuteScalar();
                if (reader.Read())
                    name2 = reader.GetValue(0).ToString();

                //nameColumn = FilterHelper.BuildValueForLike(nameColumn);

                refParam.SrcTableName = srcTable.TABNAME;
                refParam.SrcColName = pkColumn;
                refParam.SrcTextColName = nameColumn;
                refParam.SrcTextColName2 = name2;
                return refParam;

            }
            finally
            {
                connection.Close();
            }
        }
        public List<Dictionary<string, object>> GetSrcQueryResult(SrcQueryModel srcQueryModel, string query, int start, int limit)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                string queryValue = FilterHelper.BuildValueForLike(query);
                OracleCommand getSrcCondCommand = connection.CreateCommand();
                string queryString = GetSrcCondByMetaExtrnVal(srcQueryModel.Tabid, srcQueryModel.ColId);
                string resultQuery = string.Format(
                        @"select * from (select rownum rn, {0} as id, {1} as name 
                                    from ( {2}) where  (UPPER({0}) like UPPER('{5}') or UPPER({1}) like UPPER('{5}')) and rownum <= {4}) where rn > {3}",
                        srcQueryModel.IdColName, srcQueryModel.SemanticColName, queryString, start, start + limit + 1, queryValue);
                getSrcCondCommand.CommandText = resultQuery;
                foreach (var item in srcQueryModel.QueryParams)
                {
                    OracleParameter param = SqlStatementParamsParser.GetOracleParamByField(item);
                    getSrcCondCommand.Parameters.Add(param);
                }
                var getDataReader = getSrcCondCommand.ExecuteReader();
                var allData = AllRecordReader.ReadAll(getDataReader).ToList();
                return allData;
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                connection.Close();
            }
        }


        public string GetSrcCondByMetaExtrnVal(int tabId, int ColId)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand getSrcCondCommand = connection.CreateCommand();
            getSrcCondCommand.CommandText = "SELECT EX.SRC_COND FROM  META_EXTRNVAL EX WHERE TABID = :tabid and COLID = :colid";
            getSrcCondCommand.Parameters.Add(new OracleParameter("tabid", tabId));
            getSrcCondCommand.Parameters.Add(new OracleParameter("colid", ColId));
            var srcCondString = getSrcCondCommand.ExecuteScalar() as string;
            return srcCondString;
        }


        public SrcQueryModel GetSrcQueryModel(int tabId, int colId, IList<ColumnMetaInfo> columnsInfo)
        {
            string srcQuery = GetSrcCondByMetaExtrnVal(tabId, colId);
            List<string> paramNames = SqlStatementParamsParser.GetSqlStatementParams(srcQuery);
            List<ColumnMetaInfo> paramsInfo = columnsInfo.Where(x => paramNames.Contains(x.COLNAME)).ToList();
            SrcQueryModel srcQueryModel = new SrcQueryModel(tabId, colId, paramsInfo);
            return srcQueryModel;
        }

        /// <summary>
        /// Получить условие фильтра из таблицы meta_filtercodes
        /// </summary>
        /// <param name="filterCode">Код фильтра</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        public string GetFallDownCondition(string filterCode)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand selectFallDownCondition = connection.CreateCommand();
                selectFallDownCondition.BindByName = true;
                selectFallDownCondition.CommandText = "select condition from meta_filtercodes where code=:code";
                selectFallDownCondition.Parameters.Add(new OracleParameter("code", filterCode));
                var condition = (string)selectFallDownCondition.ExecuteScalar();
                return condition;
            }
            finally
            {
                connection.Close();
            }
        }

        /// <summary>
        /// Получить данные справочника, которые будут загружены в грид
        /// </summary>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        public GetDataResultInfo GetData(DataModel dataModel)
        {

            OracleConnection connection = GetOracleConnector.GetConnOrCreate;
            UserMap user = ConfigurationSettings.GetCurrentUserInfo;
            // var bytesJsonSqlProcParams =  Convert.FromBase64String(dataModel.Base64jsonSqlProcParams);
            string stringJsonSqlProcParams = FormatConverter.ConvertFromUrlBase64UTF8(dataModel.Base64jsonSqlProcParams);// Encoding.UTF8.GetString(bytesJsonSqlProcParams);
            string SelectConditions = null;
            FunNSIEditFParams nsiEditParams = null;
            MetaTable nativTableForFilter = null;
            string funNsiEditFParamsString = GetFunNSIEditFParamsString(null, dataModel.CodeOper, dataModel.SParColumn, dataModel.NativeTabelId, dataModel.NsiTableId, dataModel.NsiFuncId, dataModel.Code);
            List<FieldProperties> sqlParamerties = FormatConverter.JsonToObject<List<FieldProperties>>(dataModel.JsonSqlProcParams);//  string.IsNullOrEmpty(dataModel.JsonSqlProcParams)  ? new List<FieldProperties>() : JsonConvert.DeserializeObject<List<FieldProperties>>(dataModel.JsonSqlProcParams) as List<FieldProperties>;
            List<FieldProperties> sqlSelectRowParams = FormatConverter.JsonToObject<List<FieldProperties>>(stringJsonSqlProcParams); // string.IsNullOrEmpty(stringJsonSqlProcParams) ? new List<FieldProperties>() : JsonConvert.DeserializeObject<List<FieldProperties>>(stringJsonSqlProcParams) as List<FieldProperties>;
            List<FieldProperties> allParams = new List<FieldProperties>();
            if (!string.IsNullOrEmpty(funNsiEditFParamsString))
                nsiEditParams = new FunNSIEditFParams(funNsiEditFParamsString);
            if (nsiEditParams != null && sqlSelectRowParams != null)
                nsiEditParams.ReplaceParams(sqlSelectRowParams);

            if (nsiEditParams != null)
                SelectConditions = nsiEditParams.Conditions;

            if (!string.IsNullOrEmpty(dataModel.KindOfFilter) && dataModel.FilterTblId != null)
            {
                if (dataModel.KindOfFilter == KindsOfFilters.CustomFilter.ToString())
                    SelectConditions = FilterInfo.BuildFilterConditions(dataModel.FilterTblId.Value, Convert.ToInt32(user.user_id));
                if (dataModel.KindOfFilter == KindsOfFilters.SystemFilter.ToString())
                    SelectConditions = FilterInfo.BuildFilterConditions(dataModel.FilterTblId.Value);
                if (dataModel.FilterTblId.HasValue)
                    nativTableForFilter = GetMetaTableById(dataModel.FilterTblId.Value);
            }

            string tableName = nsiEditParams == null || string.IsNullOrEmpty(nsiEditParams.TableName) ? dataModel.TableName : nsiEditParams.TableName;

            var table = string.IsNullOrEmpty(dataModel.TableName) ? GetMetaTableById(dataModel.TableId) : GetMetaTableByName(tableName);
            if (table.TABNAME == "DYN_FILTER")
            {
                dataModel.Sort = "[{\"property\":\"SEMANTIC\",\"direction\":\"ASC\"}]";
            }

            int TableId = table != null ? Convert.ToInt32(table.TABID) : dataModel.TableId;
            if (sqlParamerties != null && sqlParamerties.Count > 0)
                allParams.AddRange(sqlParamerties);
            if (sqlSelectRowParams != null && sqlSelectRowParams.Count > 0)
                allParams.AddRange(sqlSelectRowParams);

            var dbMetaColumns = GetDbNativeColumnsMetaInfo(TableId);
            var nativeMetaColumns = DbColumnsToMetaColumnsForGetData(dbMetaColumns);

            var startInfo = new GetDataStartInfo
            {
                TableId = TableId,
                TableName = table != null ? table.TABNAME : tableName,
                Sort = FormatConverter.JsonToObject<SortParam[]>(dataModel.Sort),
                GridFilter = FormatConverter.JsonToObject<GridFilter[]>(dataModel.GridFilter),
                StartFilter = FormatConverter.JsonToObject<FilterInfo[]>(dataModel.StartFilter), //   dataModel.StartFilter != null && dataModel.StartFilter.Length > 0 ?   dataModel.StartFilter.Select(x => new FilterInfo(x)).ToList() : new List<FilterInfo>()
                ExtFilters = FormatConverter.JsonToObject<ExtFilter[]>(dataModel.ExternalFilter),
                DynamicFilter = FormatConverter.JsonToObject<DynamicFilterInfo[]>(dataModel.DynamicFilter),
                NativTableNameForFilter = nativTableForFilter != null ? nativTableForFilter.TABNAME : "",
                // на клиенте нет информации о условии фильтра проваливания, есть код и значения переменных, которые фигурируют в условии
                // добавим условие фильтра проваливания
                FallDownFilter = !string.IsNullOrEmpty(dataModel.FilterCode) ? GetFilterByCode(dataModel.FilterCode) : null,// AddFilterCondition(FormatConverter.JsonToObject<FallDownFilterInfo>(fallDownFilter), tableName),
                StartRecord = dataModel.IsResetPages == true ? 0 : dataModel.Start,
                RecordsCount = dataModel.Limit,
                GetAllRecords = false,
                DbMetaColumns = dbMetaColumns,
                NativeMetaColumns = nativeMetaColumns,// NeedToGetAllRecords(dataModel.Start, dataModel.Limit),
                NativeMetaColumnsForeSelect = SelectBuilder.MetaColumnsToColumnsForSelect(nativeMetaColumns),// _entities.META_COLUMNS.Where(mc => mc.TABID == TableId).OrderBy(mc => mc.SHOWPOS).ToList(),
                ExternalMetaColumns = GetExternalColumnsMeta(TableId).ToList(),
                SelectConditions = SelectConditions,
                ProcedureText = nsiEditParams == null || (nsiEditParams.EXEC != "BEFORE" && nsiEditParams.EXEC != "BEFORE_THIS") || dataModel.ExecuteBeforFunc == "no" ? null : nsiEditParams.PROC,
                AllFieldProperties = allParams,
                SummaryForRecordsOnScrean = nsiEditParams != null && !string.IsNullOrEmpty(nsiEditParams.SummVisibleRows) && nsiEditParams.SummVisibleRows.ToUpper() == "TRUE",
                SelectStatement = table.SELECT_STATEMENT
            };

            if (startInfo.StartFilter != null && startInfo.StartFilter.Any())
            {
                IEnumerable<FilterInfo> customFiltersFromDb = GetAllDynFilteFilters(startInfo.TableId);
                startInfo.StartFilter = SelectBuilder.CustomFilterBuild(startInfo.StartFilter, startInfo.TableName, customFiltersFromDb);
            }
            if (startInfo.FallDownFilter != null && !string.IsNullOrEmpty(startInfo.FallDownFilter.Condition))
            {
                startInfo.FallDownFilter = SelectBuilder.BuildFallDownConditions(sqlParamerties, startInfo.TableName, startInfo.FallDownFilter);
                startInfo.FallDownFilter.FilterParams = sqlSelectRowParams.Where(x => startInfo.FallDownFilter.Condition.Contains(x.Name)).ToList();

            }
            bool lazyLoad = dataModel is ExcelDataModel && dataModel.Limit > 80000 && nsiEditParams != null && nsiEditParams.ExcelParam == "ALL_CSV";
            try
            {
                var selectBuilder = new SelectBuilder
                {
                    TableName = startInfo.TableName,
                    TableId = startInfo.TableId,
                    StartRecord = startInfo.StartRecord,
                    NativeTableNameForFilter = startInfo.NativTableNameForFilter,
                    // делаем попытку вычитки на одну строку больше для определения наличия строк кроме запрошенных
                    RecordsCount = startInfo.RecordsCount + 1,
                    GetAllRecords = startInfo.GetAllRecords,
                    GridFilter = startInfo.GridFilter,
                    StartFilter = startInfo.StartFilter,
                    ExtFilters = startInfo.ExtFilters,
                    FallDownFilter = startInfo.FallDownFilter,
                    DynamicFilter = startInfo.DynamicFilter,
                    OrderParams = startInfo.Sort,
                    NativeMetaColumns = startInfo.NativeMetaColumnsForeSelect,
                    ExternalMetaColumns = SelectBuilder.ReplaseDivisionColumnNames(startInfo.ExternalMetaColumns),
                    //учтем колонки чувствительные к регистру при фильтрации
                    AdditionalColumns = ConditionalPainting.GetColumns(startInfo.TableId),
                    SelectConditions = startInfo.SelectConditions,
                    SqlParams = startInfo.AllFieldProperties,
                    SummaryForRecordsOnScrean = startInfo.SummaryForRecordsOnScrean,
                    SelectStatement = startInfo.SelectStatement
                };
                HttpContext context = HttpContext.Current;
                string sesstionLastActionKey = "lastActionForTable" + TableId;
                string lactAction = context.Session[sesstionLastActionKey] as string;
                context.Session[sesstionLastActionKey] = "GetData";
                if (!string.IsNullOrEmpty(startInfo.ProcedureText) && lactAction != "GetData")
                {
                    CallFunctionBeforeSelectTable(startInfo.AllFieldProperties, startInfo.ProcedureText);
                }

                // получим основной набор данных
                OracleCommand getDataCmd = selectBuilder.GetDataSelectCommand(connection);
                getDataCmd.BindByName = true;
                Logger.Info("begin execute select data  command: " + getDataCmd.CommandText, LoggerPrefix + "GetData");
                OracleDataReader getDataReader = getDataCmd.ExecuteReader();
                //IEnumerable<Dictionary<string,object>> allData;
                bool hasDivision = startInfo.NativeMetaColumns.FirstOrDefault(x => x.COLNAME.IndexOf("/") > 0) != null;

                //    allData = AllRecordReader.ReadAllWithDivesion(getDataReader, startInfo.NativeMetaColumns).ToList();
                //else
                // allData = AllRecordReader.ReadAll(getDataReader).ToList();

                GetDataResultInfo result;
                // добавим итоговую строку
                //Dictionary<string, object> summaryData = null;
                //if (selectBuilder.TotalColumns.Any())
                // {
                // для подсчета итоговых значений берем запрошенное количество строк
                if (lazyLoad && !string.IsNullOrEmpty(nsiEditParams.ExcelParam) && nsiEditParams.ExcelParam == "ALL_CSV")
                {
                    result = AllRecordReader.GetDataForExcelCsv(getDataReader, nsiEditParams.ExcelParam);
                    return result;
                }
                result = AllRecordReader.GetComplexResult(getDataReader, selectBuilder, hasDivision, startInfo);
                if (selectBuilder.TotalColumns.Any())
                {
                    // для подсчета итоговых значений берем запрошенное количество строк
                    selectBuilder.RecordsCount = startInfo.RecordsCount;

                    OracleCommand getSummaryDataCmd = selectBuilder.GetTotalSelectCommand(connection);
                    var getSummaryDataReader = getSummaryDataCmd.ExecuteReader();
                    var summaryData = AllRecordReader.ReadAll(getSummaryDataReader).FirstOrDefault();
                    result.TotalRecord = summaryData;
                }

                if (nsiEditParams != null && nsiEditParams.ShowRecordsCount)
                {
                    OracleCommand cmd = selectBuilder.GetSystemProcCommand("Count(*) as RecordsCount");
                    var getCountReader = cmd.ExecuteReader();
                    var getCountResult = AllRecordReader.ReadAll(getCountReader).FirstOrDefault();
                    if (getCountResult != null && getCountResult.Count > 0)
                        result.RecordsCount = Convert.ToInt32(getCountResult["RECORDSCOUNT"]);

                }
                //selectBuilder.RecordsCount = startInfo.RecordsCount;
                //OracleCommand getSummaryDataCmd = selectBuilder.GetTotalSelectCommand(connection);
                //var getSummaryDataReader = getSummaryDataCmd.ExecuteReader();
                //summaryData = AllRecordReader.ReadAll(getSummaryDataReader).FirstOrDefault();
                // }
                //else
                // result = new GetDataResultInfo
                //{
                //    DataRecords = allData.Take(startInfo.RecordsCount),
                //    RecordsCount = allData.Count(),
                //    TotalRecord = null
                //};
                return result;
            }
            catch (Exception ex)
            {
                GetOracleConnector.Dispose();
                string msg = ex.Message.ToUpper();
                if (msg.Contains("SPECIFIED CAST IS NOT VALID"))
                {
                    msg += "       можливо Помилка виникла в результаті некоректного типу даних в представлені." +
                        "Перегляньте числові поля на предмет значень, що містять більше 8-ми знаків після мантиси ";
                    Logger.Error("ReferenceBookRepository.GetData. " + msg);
                    throw new Exception(msg);
                }

                //return new GetDataResultInfo();
                throw;
            }
            finally
            {
                if (!lazyLoad)
                    this.GetOracleConnector.Dispose();
            }
        }

        public List<ColumnMetaInfo> DbColumnsToMetaColumnsForMetaData(List<MetaColumnsDbModel> columnList)
        {
            List<ColumnMetaInfo> columnsInfo = new List<ColumnMetaInfo>();
            foreach (var item in columnList)
            {
                ColumnMetaInfo col = new ColumnMetaInfo();
                col.BuildFromDbColumn(item);
                col.WEB_FORM_NAME = col.BuildWebFormName(item.WEB_FORM_NAME, "sPar=", Convert.ToInt32(item.COLID),
                    Convert.ToInt32(item.TABID), UrlTamplates.MainUrlTemplate);
                if (col.COLTYPE == "N" || col.COLTYPE == "E")
                {
                    col.SHOWFORMAT = FormatConverter.ConvertToExtJsDecimalFormat(col.SHOWFORMAT);
                }
                if (col.COLTYPE == "D")
                {
                    col.SHOWFORMAT = FormatConverter.ConvertToExtJsDateFormat(col.SHOWFORMAT);
                }

                if (!string.IsNullOrEmpty(col.WEB_FORM_NAME))
                {
                    FunNSIEditFParams par = new FunNSIEditFParams(col.WEB_FORM_NAME);

                    if (col.FunctionMetaInfo != null && !string.IsNullOrEmpty(col.FunctionMetaInfo.TableName) && !col.FunctionMetaInfo.TableName.Contains("|:"))
                    {

                        MetaTable tableInfo = GetMetaTableByName(col.FunctionMetaInfo.TableName);
                        if (tableInfo == null)
                            throw new Exception(string.Format("Не знайдена таблиця {0}, посилання на неї в колонці  {1}", col.FunctionMetaInfo.TableName, col.COLNAME));
                        if (!string.IsNullOrEmpty(tableInfo.SEMANTIC) && tableInfo.SEMANTIC.Contains("|:"))
                        {
                            col.FunctionMetaInfo.TableSemantic = tableInfo.SEMANTIC;
                            par.AddItemToParamsNames(tableInfo.SEMANTIC);
                            col.FunctionMetaInfo.RowParamsNames.AddRange(par.ParamsNames);
                            col.FunctionMetaInfo.RowParamsNames = col.FunctionMetaInfo.RowParamsNames.Distinct().ToList();
                        }
                    }
                }
                columnsInfo.Add(col);

            }
            return columnsInfo;
        }

        public static List<ColumnMetaInfo> DbColumnsToMetaColumnsForGetData(List<MetaColumnsDbModel> columnList)
        {
            List<ColumnMetaInfo> columnsInfo = new List<ColumnMetaInfo>();
            foreach (var item in columnList)
            {
                ColumnMetaInfo col = new ColumnMetaInfo();
                col.BuildFromDbColumn(item);
                col.WEB_FORM_NAME = col.BuildWebFormName(item.WEB_FORM_NAME, "sPar=", Convert.ToInt32(item.COLID),
    Convert.ToInt32(item.TABID), UrlTamplates.MainUrlTemplate);
                columnsInfo.Add(col);
            }
            return columnsInfo;
        }

        FallDownFilterInfo GetFilterByCode(string filterCode)
        {

            FallDownFilterInfo filter = null;
            if (string.IsNullOrEmpty(filterCode))
                return filter;
            filter = new FallDownFilterInfo();
            filter.Condition = GetFallDownCondition(filterCode);
            if (string.IsNullOrEmpty(filter.Condition))
                throw new Exception(string.Format("фільтра з кодом {0} в таблиці  meta_filtercodes намає ", filterCode));
            filter.FilterCode = filterCode;
            return filter;
        }

        public MetaCallSettings GetMetaCallSettingsByCode(string code)
        {
            string sql = "SELECT * FROM META_CALL_SETTINGS WHERE CODE = :code";
            OracleParameter oraParam = new OracleParameter("code", OracleDbType.Varchar2);
            oraParam.Value = code;
            return _entities.ExecuteStoreQuery<MetaCallSettings>(sql, oraParam).FirstOrDefault();
        }

        public MetaCallSettings GetMetaCallSettingsByAppCodeAndTabid(string appCode, int tabId)
        {
            try
            {
                decimal? tabidForSearth = Convert.ToDecimal(tabId);
                MetaCallSettings result = null;
                string sql = "SELECT * FROM META_CALL_SETTINGS WHERE CODEAPP = :appCode";
                var parameters = new OracleParameter[1];
                //parameters[0] = DbAccess.CreateCustomTypeArrayInputParameter("P_DYN_FILTER_COND_LIST", "BARS.T_DYN_FILTER_COND_LINE", filterRowList.ToArray());
                parameters[0] = new OracleParameter("appCode", OracleDbType.Varchar2, appCode, ParameterDirection.Input);
                //parameters[1] = new OracleParameter("tabId", OracleDbType.Decimal, tabidForSearth, ParameterDirection.Input);

                IEnumerable<MetaCallSettings> listSettings = _entities.ExecuteStoreQuery<MetaCallSettings>(sql, parameters).ToList();
                if (listSettings.Count() > 0)
                {
                    result = listSettings.FirstOrDefault(x => x.TABID == tabidForSearth && x.CODEAPP == appCode) ?? listSettings.FirstOrDefault(x => x.TABID == null && x.CODEAPP == appCode);
                }

                return result;

            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return null;
            }
        }
        /// <summary>
        /// Получить метаданные справочников
        /// </summary>
        /// <param name="tableId">Id таблицы</param>
        /// <param name="data">Модель для получения метаданных</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        public object GetMetaData(GetMetadataModel data)// int tableId, int? codeOper, int? sParColumn, int? nativeTabelId, int? nsiTableId, int? nsiFuncId, string base64jsonSqlProcParams = "")
        {
            try
            {

                Logger.Debug(string.Format(" begin GetMetaData for: tableid: {0},codeOper: {1}, sParColumn: {2},nativeTabelId: {3},nsiTableId: {4},nsiFuncId: {5}, base64jsonSqlProcParams: {6} ",
                    data.TableId, data.CodeOper.HasValue ? data.CodeOper.Value.ToString() : "", data.SparColumn.HasValue ? data.SparColumn.Value.ToString() : "",
                    data.NativeTabelId.HasValue ? data.NativeTabelId.Value.ToString() : "", data.NsiTableId.HasValue ? data.NsiTableId.Value.ToString() : "", data.NsiFuncId.HasValue ? data.NsiFuncId.Value.ToString() : "", data.Base64JsonSqlProcParams), LoggerPrefix + "GetMetaData");
                MetaTable tableInfo = GetMetaTable(data.TableId);

                List<CallFunctionMetaInfo> callFunctions = new List<CallFunctionMetaInfo>();
                List<CallFunctionMetaInfo> onlineFunctions = new List<CallFunctionMetaInfo>();

                BarsWeb.Areas.Ndi.Models.Params.SaveInPageParams saveInPageParams = new BarsWeb.Areas.Ndi.Models.Params.SaveInPageParams();

                string defInsertString = FormatConverter.ConvertFromUrlBase64UTF8(data.Base64InsertDefParamsString);
                List<FieldProperties> defInsertParams = string.IsNullOrEmpty(defInsertString) ? new List<FieldProperties>() : JsonConvert.DeserializeObject<List<FieldProperties>>(defInsertString) as List<FieldProperties>;
                // string.IsNullOrEmpty(stringJsonSqlProcParams) ? new List<FieldProperties>() : JsonConvert.DeserializeObject<List<FieldProperties>>(stringJsonSqlProcParams) as List<FieldProperties>;
                string excelParam = string.Empty;
                string saveColumnsParam = string.Empty;

                //string funNsiEditFParamsString = GetFunNSIEditFParamsString(data.TableId, data.CodeOper, data.SparColumn, data.NativeTabelId, data.NsiTableId, data.NsiFuncId);
                //if (!string.IsNullOrEmpty(funNsiEditFParamsString))
                FunNSIEditFParams nsiPar = GetNsiParamsByMetadataModel(data, tableInfo);// new FunNSIEditFParams(FunNSIEditFParamsString);
                //if (!string.IsNullOrEmpty(data.Code))
                //    nsiPar = new FunNSIEditFParams(GetMetaCallSettingsByCode(data.Code));
                HttpContext context = HttpContext.Current;
                string sesstionKey = "lastActionForTable" + data.TableId;
                context.Session[sesstionKey] = "MetaData";
                //получим информацию о "родных" колонках
                var nativeColumnsInfo = GetNativeColumnsMetaInfo(data.TableId);// _entities.META_COLUMNS.Where(c => c.TABID == data.TableId).OrderBy(c => c.SHOWPOS).ToList();

                //сформируем также информацию о дефолтной сортировке
                var sorters =
                    _entities.ExecuteStoreQuery<META_SORTORDER>("select * from META_SORTORDER")
                        .Where(so => so.TABID == data.TableId)
                        .OrderBy(so => so.SORTORDER)
                        .Select(so => new
                        {
                            direction = so.SORTWAY != null ? so.SORTWAY.Trim() : "ASC",
                            property = nativeColumnsInfo.Single(ci => ci.COLID == so.COLID).COLNAME.Trim()
                        }).ToList();

                //string getCustomFiltersSqlString = string.Format("select * from DYN_FILTER where USERID = {0} and TABID = {1}", user.user_id, tableId);


                ////формат даты и числовых полей в описании справочников не совпадает с форматом даты extjs, поэтому делаем переконвертацию
                //foreach (var column in nativeColumnsInfo)
                //{
                //    if (!string.IsNullOrEmpty(column.SHOWFORMAT))
                //    {
                //        if (column.COLTYPE == "N" || column.COLTYPE == "E")
                //        {
                //            column.SHOWFORMAT = FormatConverter.ConvertToExtJsDecimalFormat(column.SHOWFORMAT);
                //        }
                //        if (column.COLTYPE == "D")
                //        {
                //            column.SHOWFORMAT = FormatConverter.ConvertToExtJsDateFormat(column.SHOWFORMAT);
                //        }
                //    }
                //}

                //CallFunctionMetaInfo functionMetaInfo = null;
                //bool isFuncOnly;
                List<string> paramNames = new List<string>();
                //сформируем итоговый список колонок по основному набору колонок
                List<ColumnMetaInfo> columnsInfo = GetNativeColumnsMetaInfo(data.TableId);


                List<ColumnMetaInfo> nativeMetaColumns = new List<ColumnMetaInfo>();
                columnsInfo.ForEach(u => nativeMetaColumns.Add(u));


                var deps = GetDependenciesByTabid(data.TableId, nativeMetaColumns);
                AddDependenciesToColumns(columnsInfo, deps);

                FiltersMetaInfo filtersMetainfo = GetFiltersInfo(data.TableId, columnsInfo);// new FiltersMetaInfo(filerTbl, user);
                //List<META_COLUMNS> CustomfilterMetaColumns;
                List<string> baseOptionsNames = new List<string>();
                if (nsiPar != null && !string.IsNullOrEmpty(nsiPar.ShowDialogWindow))
                    filtersMetainfo.ShowFilterWindow = nsiPar.ShowDialogWindow;
                if (nsiPar != null && nsiPar.BaseOptionsNames != null && nsiPar.BaseOptionsNames.Count > 0)
                {
                    baseOptionsNames = nsiPar.BaseOptionsNames;
                }

                AddEditRowsInform addEditRowsInform = new AddEditRowsInform();

                //получим также инфу о внешних колонках из таблицы META_EXTRNVAL
                var extColumnsInfo = GetExternalColumnsMeta(data.TableId).ToList();
                List<ColumnMetaInfo> colsWithSrcCondOnly = extColumnsInfo.Count() > 0 ? extColumnsInfo.Where(x => !string.IsNullOrEmpty(x.Src_Cond) && x.Src_Cond.ToUpper().Contains("SELECT")).ToList() : new List<ColumnMetaInfo>();
                if (colsWithSrcCondOnly.Count() > 0)
                    extColumnsInfo = extColumnsInfo.Where(x => colsWithSrcCondOnly.FirstOrDefault(c => c.COLID == x.COLID) == null).ToList();

                //перенесем метаинформацию о связях с внешними таблицами из первой внешней связи
                foreach (var extColId in extColumnsInfo.Select(ec => ec.COLID).Distinct())
                {
                    int idx = columnsInfo.IndexOf(columnsInfo.Single(ci => ci.COLID == extColId));
                    var firstExtCol = extColumnsInfo.FirstOrDefault(eci => eci.COLID == extColId);
                    if (firstExtCol != null)
                    {
                        columnsInfo[idx].SrcColName = firstExtCol.SrcColName;
                        columnsInfo[idx].SrcTableName = firstExtCol.SrcTableName;
                        columnsInfo[idx].SrcTextColName = firstExtCol.COLNAME;
                        columnsInfo[idx].SrcTab_Alias = firstExtCol.Tab_Alias;
                        columnsInfo[idx].COL_DYN_TABNAME = firstExtCol.COL_DYN_TABNAME;
                    }
                }
                if (colsWithSrcCondOnly != null & colsWithSrcCondOnly.Count() > 0)
                {
                    foreach (var colWidSrcId in colsWithSrcCondOnly.GroupBy(x => x.COLID).Select(gr => gr.First()))
                    {
                        int idx = columnsInfo.IndexOf(columnsInfo.Single(ex => ex.COLID == colWidSrcId.COLID));
                        SrcQueryModel quereModel = GetSrcQueryModel(data.TableId, Convert.ToInt32(colWidSrcId.COLID), columnsInfo);
                        if (idx > -1 && quereModel != null)
                        {
                            columnsInfo[idx].HasSrcCond = true;
                            columnsInfo[idx].srcQueryModel = quereModel;
                        }
                    }
                }

                var extcolums = extColumnsInfo.Where(ex => string.IsNullOrEmpty(ex.COL_DYN_TABNAME));
                ////очистим внешние колони от ненужной информации об их связях
                foreach (var extCol in extcolums)
                {
                    extCol.COLNAME = extCol.ColumnAlias;
                    extCol.SrcTableName = String.Empty;
                    extCol.SrcColName = String.Empty;
                    extCol.SrcTextColName = String.Empty;
                    extCol.IsForeignColumn = true;
                }

                //////добавим внешние колонки в нужном порядке
                foreach (var extColId in extcolums.Select(ec => ec.COLID).Distinct())
                {
                    int idx = columnsInfo.IndexOf(columnsInfo.Single(ci => ci.COLID == extColId));
                    columnsInfo.InsertRange(++idx, extcolums.Where(ec => ec.COLID == extColId).ToList());
                }

                //получим метаинформацию о фильтрах по внешних справочниках
                List<ExtFilterMeta> extFilters = GetExtFilterMeta(data.TableId).ToList(); //new List<ExtFilterMeta>(); //
                if (nsiPar != null)
                {
                    addEditRowsInform = nsiPar.addEditRowsInform;
                    excelParam = nsiPar.ExcelParam;
                    saveColumnsParam = nsiPar.SaveColumns;
                    //if (rowParams != null && rowParams.Count > 0)
                    //    nsiPar.ReplaceParams(rowParams);
                    //информация о функциях которые могут быть вызваны
                    if (nsiPar.IsInMeta_NSIFUNCTION)
                    {
                        IEnumerable<CallFunctionMetaInfo> funcs = GetAllCallFunctions(data.TableId).ToList();
                        funcs = SqlStatementParamsParser.BuildFunctions(funcs);
                        foreach (var item in funcs)
                        {
                            switch (item.PROC_EXEC)
                            {
                                case "ONLINE":
                                    onlineFunctions.Add(item);
                                    break;
                                case "INFORM":
                                    break;
                                default:
                                    callFunctions.Add(item);
                                    break;
                            }


                        }

                    }
                    if (!string.IsNullOrEmpty(nsiPar.PROC))
                        callFunctions.Add(nsiPar.BuildToCallFunctionMetaInfo(new CallFunctionMetaInfo()));
                    SqlStatementParamsParser.BuilFunctionParams(callFunctions, tableInfo);

                }

                UserInfo userModel = new UserInfo();
                userModel.UserId = _user.user_id;

                //получить признак добавления итоговой строки
                var selectBuilder = new SelectBuilder
                {
                    TableName = tableInfo.TABNAME,
                    TableId = data.TableId,
                    NativeMetaColumns = nativeColumnsInfo.ToList()
                };

                bool addSummaryRow = selectBuilder.TotalColumns.Count > 0;
                LocalStorageModel localStorageModel = new LocalStorageModel();
                localStorageModel.FiltersStorageKey = _user.user_id + "_" + tableInfo.TABID;
                localStorageModel.HiddenColumnsKey = LocalStorageModel.HiddenColumnsKeyPrefix + "_" + _user.user_id + "_" + tableInfo.TABID;

                bool showRecordsCount = nsiPar != null && nsiPar.ShowRecordsCount;


                if (defInsertParams != null && defInsertParams.Count > 0)
                {
                    saveInPageParams.DefaultModels.InsertDefParams = defInsertParams;
                }


                IEnumerable<MetaTblColor> colorsForGrid = GetTblColors(tableInfo.TABID);
                //добавляем дополнительные свойства на клиент для упрощения жизни
                var additionalProperties = new { addSummaryRow };
                var metadata = new
                {
                    saveInPageParams,
                    tableInfo,
                    columnsInfo,
                    nativeMetaColumns,
                    localStorageModel,
                    sorters,
                    filtersMetainfo,
                    // CustomFilters = customFilters,
                    extFilters,
                    callFunctions,
                    onlineFunctions,
                    additionalProperties,
                    addEditRowsInform,
                    baseOptionsNames,
                    excelParam,
                    showRecordsCount,
                    saveColumnsParam,
                    colorsForGrid
                };
                Logger.Debug(string.Format(" end GetMetaData for: tableid: {0},columnsInfo count: {1}, table name: {2},CustomFilters count:" +
                "{3},SystemFilters count: {4},callFunctions coount : {5} ",
                    tableInfo.TABID, columnsInfo.Count, tableInfo.TABNAME,
                    filtersMetainfo.CustomFilters != null ? filtersMetainfo.CustomFilters.Count().ToString() : "",
                    filtersMetainfo.SystemFilters != null ? filtersMetainfo.SystemFilters.Count().ToString() : "",
                    callFunctions.Count), LoggerPrefix + "GetMetaData");

                return metadata;

            }
            catch (Exception e)
            {

                throw e;
            }
        }

        public MetaTable GetMetaTable(int tableId)
        {
            MetaTable tableInfo = _entities.META_TABLES.Where(mt => mt.TABID == tableId).Select(mt =>
                    new MetaTable
                    {
                        TABID = (int)mt.TABID,
                        TABNAME = mt.TABNAME,
                        SEMANTIC = mt.SEMANTIC,
                        LINESDEF = mt.LINESDEF,
                    }).Single();

            if (tableInfo != null && tableInfo.SEMANTIC.Contains("|:"))
                tableInfo.SemanticParamNames = SqlStatementParamsParser.GetParamNames(tableInfo.SEMANTIC);

            return tableInfo;
        }

        public List<MetaColumnsDbModel> GetDbNativeColumnsMetaInfo(int tableId)
        {
            const string sql = @"SELECT *
                FROM meta_columns  WHERE tabid = :tabid";
            var pTabId = new OracleParameter("tabid", OracleDbType.Decimal).Value = tableId;
            return _entities.ExecuteStoreQuery<MetaColumnsDbModel>(sql, pTabId).OrderBy(x => x.SHOWPOS).ToList();

        }

        public List<ColumnMetaInfo> GetNativeColumnsMetaInfo(int tableId)
        {
            List<MetaColumnsDbModel> dbColumns = GetDbNativeColumnsMetaInfo(tableId).ToList();
            List<ColumnMetaInfo> metaColumns = DbColumnsToMetaColumnsForMetaData(dbColumns);

            return SelectBuilder.MetaColumnsToColumnsForSelect(metaColumns);
        }
        public FiltersMetaInfo GetFiltersInfo(int tableId, IEnumerable<ColumnMetaInfo> columnsInfo = null)
        {
            var filterTbl = GetMetaTableByName("DYN_FILTER");
            FiltersMetaInfo filtersMetainfo = new FiltersMetaInfo(filterTbl, _user);
            if (columnsInfo == null)
                columnsInfo = GetNativeColumnsMetaInfo(tableId);
            filtersMetainfo.ComboboxColumnModelBuild(columnsInfo);
            //todo вставить логи
            IEnumerable<FilterInfo> customFilters = GetDynFilterFilters(tableId, _user.user_id);
            IEnumerable<FilterInfo> systemFilters = GetDynFilterFilters(tableId);
            if (customFilters != null || systemFilters != null)
            {
                IEnumerable<ColumnMetaInfo> CustomfilterMetaColumns = GetNativeColumnsMetaInfo(filterTbl.TABID);
                filtersMetainfo.FiltersMetaColumns = CustomfilterMetaColumns.ToList();// SelectBuilder.MetaColumnsToColumnInfo(CustomfilterMetaColumns);
                filtersMetainfo.BuildFilters();
                filtersMetainfo.HasFilter = true;
            }


            foreach (var item in customFilters)
                item.BuildFilterParams();

            foreach (var item in systemFilters)
                item.BuildFilterParams();

            if (customFilters.Count() > 0)
                customFilters = customFilters.OrderBy(u => u.IsUserFilter).ToList();

            if (systemFilters.Count() > 0)
                systemFilters = systemFilters.OrderBy(u => u.IsUserFilter).ToList();
            filtersMetainfo.CustomFilters = customFilters;
            filtersMetainfo.SystemFilters = systemFilters;
            return filtersMetainfo;
        }


        //public FunNSIEditFParams GetNsiParams(string nsiParamString, int? baseCodeOper = null, List<FieldProperties> rowParams = null)
        public FunNSIEditFParams GetNsiParamsByMetadataModel(GetMetadataModel data, MetaTable tableInfo = null)
        {
            FunNSIEditFParams nsiEditParams = null;
            if (!string.IsNullOrEmpty(data.Code))
            {
                MetaCallSettings metasettings = GetMetaCallSettingsByCode(data.Code);
                if (!string.IsNullOrEmpty(metasettings.WEB_FORM_NAME))
                    return new FunNSIEditFParams(metasettings.WEB_FORM_NAME);
                nsiEditParams = new FunNSIEditFParams(GetMetaCallSettingsByCode(data.Code));
            }
            else
            {

                string nsiParamString = GetFunNSIEditFParamsString(data.TableId, data.CodeOper, data.SparColumn, data.NativeTabelId, data.NsiTableId, data.NsiFuncId);
                if (string.IsNullOrEmpty(nsiParamString))
                    return null;
                nsiEditParams = new FunNSIEditFParams(nsiParamString);
                if (data.BaseCodeOper != null && data.BaseCodeOper.HasValue)
                {
                    string FunNSIEditParamsStringBase = GetFunNSIEditFParamsString(null, data.BaseCodeOper, null, null, null, null);
                    FunNSIEditFParams nsiEditParamsBase = new FunNSIEditFParams(FunNSIEditParamsStringBase);
                    HierarchyHelper.BuildFromBaseOptions(nsiEditParamsBase, nsiEditParams);
                }
            }

            string stringJsonSqlProcParams = FormatConverter.ConvertFromUrlBase64UTF8(data.Base64JsonSqlProcParams);
            List<FieldProperties> rowParams = FormatConverter.JsonToObject<List<FieldProperties>>(stringJsonSqlProcParams);
            if (rowParams != null && rowParams.Count > 0)
            {
                nsiEditParams.TableSemantic = tableInfo.SEMANTIC;
                nsiEditParams.ReplaceParams(rowParams.Distinct().ToList());
                tableInfo.SEMANTIC = nsiEditParams.TableSemantic;
            }


            return nsiEditParams;
        }

        public FunNSIEditFParams GetNsiParams(string nsiParamString, int? baseCodeOper = null, List<FieldProperties> rowParams = null)
        {
            FunNSIEditFParams nsiEditParams = new FunNSIEditFParams(nsiParamString);
            if (baseCodeOper != null && baseCodeOper.HasValue)
            {
                string FunNSIEditParamsStringBase = GetFunNSIEditFParamsString(null, baseCodeOper, null, null, null, null);
                FunNSIEditFParams nsiEditParamsBase = new FunNSIEditFParams(FunNSIEditParamsStringBase);
                HierarchyHelper.BuildFromBaseOptions(nsiEditParamsBase, nsiEditParams);
            }
            if (rowParams != null && rowParams.Count > 0)
                nsiEditParams.ReplaceParams(rowParams);

            return nsiEditParams;
        }
        public byte[] GetCustomImage()
        {
            byte[] img = GetButtonImg();
            return img;
        }

        public List<DependencyModel> GetDependenciesByTabid(int tabid, List<ColumnMetaInfo> nativeColumnsInfo)
        {
            var dependenciesModels = new List<DependencyModel>();
            var pTabId = new OracleParameter("tabid", OracleDbType.Decimal).Value = tabid;
            var dependencies = _entities.ExecuteStoreQuery<Dependency>("select * from META_DEPENDENCY_COLS where TABID = :tabid", pTabId).ToList();
            if (dependencies.Count > 0)
                dependencies.ForEach(u =>
                    dependenciesModels.Add(new DependencyModel().BuildFromDbModel(u, nativeColumnsInfo))
                    );
            return dependenciesModels;
        }

        public void AddDependenciesToColumns(IEnumerable<ColumnMetaInfo> metaCols, List<DependencyModel> deps)
        {
            if (deps == null || deps.Count < 1)
                return;
            deps.ForEach(u =>
            {
                var firstOrDefault = metaCols.FirstOrDefault(x => x.COLID == u.ColId && x.TABID == u.TabId);
                if (firstOrDefault != null)
                    firstOrDefault.Dependencies.Add(u);
            });
            //return metaCols;
        }


        private IEnumerable<MetaTblColor> GetTblColors(int tabid)
        {
            var pTabId = new OracleParameter("tabid", OracleDbType.Decimal).Value = tabid;
            IEnumerable<MetaTblColor> colors = _entities.ExecuteStoreQuery<MetaTblColor>("SELECT * FROM META_TBLCOLOR WHERE TABID = :tabid", pTabId).ToList();
            return colors.Where<MetaTblColor>(x => !string.IsNullOrEmpty(x.COLOR_SEMANTIC)).GroupBy(col => col.COLOR_NAME).Select(g => g.First(x => !string.IsNullOrEmpty(x.COLOR_SEMANTIC)));
        }


        //public ColumnMetaInfo GetMetaInfoByTabId(int tabid)
        //{
        //    var pTabId = new OracleParameter("tabid", OracleDbType.Decimal).Value = tabid;
        //    var metacols = _entities.ExecuteStoreQuery<META_COLUMNS>("select * from META_COLUMNS where tabid = :tabid",pTabId).ToList();

        //}

        public string ReplaceParameter(string url, string searchParam, decimal sParColumn, decimal nativeTabelId, out bool isFuncOnly, out CallFunctionMetaInfo function, out List<string> paramNames)
        {
            isFuncOnly = false;
            FunNSIEditFParams parameters = null;
            function = null;
            string res;
            paramNames = new List<string>();
            if (string.IsNullOrEmpty(url) || url.IndexOf(searchParam) != 0)
                return url;
            string searchparamValue = url.Substring(url.IndexOf(searchParam) + searchParam.Length);
            if (url.Contains("sPar=["))
            {
                isFuncOnly = true;
                function = new FunNSIEditFParams(searchparamValue).BuildToCallFunctionMetaInfo(function);
                function.TABID = nativeTabelId;
                function.PROC_EXEC = "SELECTED_ONE";
                function.ColumnId = Convert.ToInt32(sParColumn);
            }
            res = UrlTamplates.MainUrlTemplate + "?" + "sParColumn" + "=" + sParColumn + "&" + "nativeTabelId" + "=" + nativeTabelId;

            if (url.IndexOf(":") != 0)
            {
                parameters = new FunNSIEditFParams(searchparamValue);
                paramNames = parameters.ParamsNames;
            }
            //string paramvalue = url.Substring(url.LastIndexOf(firstParamName) + firstParamName.Length);
            //string addParam = string.IsNullOrEmpty(additionParameterName) && string.IsNullOrEmpty(additionParameterValue) ? "" : "&" + additionParameterName + "=" + additionParameterValue;
            //string resWebName = url.Replace(paramvalue, firstPramValue) + addParam;
            return res.Trim();
        }
        /// <summary>
        /// Добавить информацию о проваливании для колонок
        /// </summary>
        /// <param name="columnsInfo">Инфо о колонках таблицы</param>
        /// <param name="tableId">ID таблицы</param>
        //private void AppendFallDownFilterInfo(List<ColumnMetaInfo> columnsInfo, int tableId)
        //{
        //    // получим все фильтры для таблицы
        //    IEnumerable<FallDownFilter> allFilters = GetFallDownFilters(tableId);
        //    if (allFilters != null)
        //    {
        //        // для каждого фильтра...
        //        foreach (FallDownFilter filter in allFilters)
        //        {
        //            // находим колонку, по которой проваливаемся
        //            ColumnMetaInfo columnToFilter = columnsInfo.Find(x => x.COLNAME.Equals(filter.FromColumn, StringComparison.OrdinalIgnoreCase));
        //            if (columnToFilter != null)
        //            {
        //                // привязываем фильтр к найденной колонке
        //                columnToFilter.FallDownInfo = new FallDownColumnInfo
        //                {
        //                    TableId = filter.ToTable,
        //                    FilterCode = filter.Code,
        //                    Columns = SqlStatementParamsParser.GetSqlStatementParams(filter.Condition)
        //                };
        //            }
        //        }
        //    }
        //}

        /// <summary>
        /// Получить фильтры проваливания для всех колонок таблицы
        /// </summary>
        /// <param name="tableId">ID таблицы</param>
        /// <returns></returns>
        private IEnumerable<FallDownFilter> GetFallDownFilters(int tableId)
        {
            var filters = new List<FallDownFilter>();

            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmdGetAllFilters = connection.CreateCommand();
                cmdGetAllFilters.BindByName = true;
                cmdGetAllFilters.CommandText =
                    "select cols.colname, cols.colid, cols.tabid, filtertbl.filter_tabid, filtertbl.filter_code, filters.condition from meta_columns cols, meta_filtertbl filtertbl, meta_filtercodes filters " +
                    "where " +
                    "cols.tabid=:tabid and cols.colid=filtertbl.colid and cols.tabid=filtertbl.tabid " +
                    "and filters.code=filtertbl.filter_code";
                var param = new OracleParameter("tabid", tableId);
                string s1 = tableId.ToString();
                cmdGetAllFilters.Parameters.Add(param);
                using (var reader = cmdGetAllFilters.ExecuteReader())
                {
                    if (reader != null)
                    {
                        while (reader.Read())
                        {
                            var colName = reader.GetString(reader.GetOrdinal("colname"));
                            var filterTabid = (int)reader.GetDecimal(reader.GetOrdinal("filter_tabid"));
                            var filterCode = reader.GetString(reader.GetOrdinal("filter_code"));
                            var condition = reader.GetString(reader.GetOrdinal("condition"));
                            filters.Add(new FallDownFilter
                            {
                                FromColumn = colName,
                                ToTable = filterTabid,
                                Code = filterCode,
                                Condition = condition
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {

            }
            finally
            {
                connection.Close();
            }
            return filters;
        }

        /// <summary>
        /// Получить метаданные дополнительных колонок справочника (например наименований для кодов)
        /// </summary>
        /// <param name="tableId"></param>
        /// <returns></returns>
        private IEnumerable<ColumnMetaInfo> GetExternalColumnsMeta(decimal tableId)
        {
            const string sql = @"SELECT ev.colid,
                                   ev.srctabid,
                                   T_SRC.TABNAME AS SrcTableName,
                                   ev.srccolid,
                                   COL_SRC.COLNAME AS srccolname,
                                   UPPER(ev.tab_alias) as tab_alias,
                                   ev.tab_cond,
                                   ev.src_cond,
                                   ev.COL_DYN_TABNAME,
                                   COL_EXT.COLNAME,
                                   COL_EXT.COLTYPE,
                                   COL_EXT.SEMANTIC,
                                   COL_EXT.SHOWWIDTH,
                                   COL_EXT.SHOWFORMAT,
                                   COL_EXT.NOT_TO_EDIT,
                                   COL_EXT.NOT_TO_SHOW,
                                   COL_EXT.SHOWMAXCHAR,
                                   COL_EXT.SHOWPOS,
                                   COL_EXT.SHOWRESULT,
                                   cast (0 as number(1)) EXTRNVAL  
                              FROM meta_columns col,
                                   meta_extrnval ev,
                                   meta_columns col_ext,
                                   meta_columns col_src,
                                   meta_tables t_src
                             WHERE     col.COLID = ev.COLID
                                   AND col.TABID = ev.TABID
                                   AND COL_EXT.INSTNSSEMANTIC = 1
                                   AND EV.SRCTABID = COL_EXT.TABID
                                   AND EV.SRCCOLID = COL_SRC.COLID
                                   AND EV.SRCTABID = COL_SRC.TABID
                                   AND EV.SRCTABID = T_SRC.TABID       
                                   AND COL.EXTRNVAL = 1
                                   AND ev.tabid = :tabid";
            var pTabId = new OracleParameter("tabid", OracleDbType.Decimal).Value = tableId;
            return _entities.ExecuteStoreQuery<ColumnMetaInfo>(sql, pTabId);
        }


        /// <summary>
        /// Получить информацию о дополнительных фильтрах, которые можно будет задать в отдельной формочке над гридом
        /// описываются в таблице META_BROWSETBL
        /// </summary>
        /// <param name="tableId"></param>
        /// <returns></returns>
        private IEnumerable<ExtFilterMeta> GetExtFilterMeta(decimal tableId)
        {
            const string sql = @"SELECT MC_HOST.COLNAME AS hostColname,
                                   MT.TABNAME AS addTabName,
                                   MC_add.COLNAME AS addColName,
                                   MC_VAR.COLNAME AS varColName,
                                   MC_VAR.COLTYPE as varColType,
                                   b.COND_TAG AS Caption
                              FROM META_BROWSETBL b
                                   JOIN meta_columns mc_host
                                      ON B.HOSTCOLKEYID = MC_HOST.COLID AND B.HOSTTABID = MC_host.TABID
                                   JOIN meta_tables mt ON B.ADDTABID = MT.TABID
                                   JOIN meta_columns mc_add
                                      ON B.ADDCOLKEYID = MC_add.COLID AND B.ADDTABID = MC_add.TABID
                                   JOIN meta_columns mc_var
                                      ON B.VAR_COLID = MC_VAR.COLID AND B.ADDTABID = MC_var.TABID
                             WHERE B.HOSTTABID = :tabid";
            var pTabId = new OracleParameter("tabid", OracleDbType.Decimal).Value = tableId;
            return _entities.ExecuteStoreQuery<ExtFilterMeta>(sql, pTabId);
        }

        public string GetFunNSIEditFParamsString(int? tabid, int? codeOper, int? metacolumnId, int? nativeTabelId, int? nsiTableId, int? nsiFuncId = null, string code = null)
        {
            string funNsiEditFParamsString = null;
            try
            {
                if (!string.IsNullOrEmpty(code))
                {
                    MetaCallSettings colSettings = GetMetaCallSettingsByCode(code);
                    if (!string.IsNullOrEmpty(colSettings.WEB_FORM_NAME))
                        return colSettings.WEB_FORM_NAME;
                }
                if (metacolumnId != null && nativeTabelId != null)
                {
                    var pCOLID = new OracleParameter("COLID", OracleDbType.Decimal);
                    pCOLID.Value = metacolumnId.Value;
                    var pTABID = new OracleParameter("TABID", OracleDbType.Decimal);
                    pTABID.Value = nativeTabelId.Value;
                    object[] parameters = {
                        pTABID,pCOLID
                    };

                    string url = _entities.ExecuteStoreQuery<string>("select  WEB_FORM_NAME from META_COLUMNS where TABID = :TABID AND COLID = :COLID ", parameters).FirstOrDefault();
                    if (string.IsNullOrEmpty(url) || url.IndexOf("sPar=") != 0)
                        return url;
                    funNsiEditFParamsString = url.Substring(url.IndexOf("sPar=") + "sPar=".Length);
                }
                if (codeOper != null)
                {
                    var pCodeOper = new OracleParameter("codeoper", OracleDbType.Decimal).Value = codeOper.Value;
                    string url = _entities.ExecuteStoreQuery<string>("select  funcname from operlist where codeoper = :codeoper", pCodeOper).FirstOrDefault();
                    if (url != null)
                    {
                        url = url.Trim();
                        funNsiEditFParamsString = url.Substring(url.IndexOf("&sPar=") + "&sPar=".Length);
                    }
                }
                if (nsiTableId != null && nsiFuncId != null)
                {
                    CallFunctionMetaInfo func = GetCallFunction(nsiTableId.Value, nsiFuncId.Value);
                    if (func != null && !string.IsNullOrEmpty(func.WEB_FORM_NAME) && func.WEB_FORM_NAME.Contains("sPar"))
                        if (func.WEB_FORM_NAME.Length > func.WEB_FORM_NAME.IndexOf("sPar=") + "sPar=".Length)
                            funNsiEditFParamsString = func.WEB_FORM_NAME.Substring(func.WEB_FORM_NAME.IndexOf("sPar=") + "sPar=".Length);
                }
            }
            catch (Exception)
            {
                throw;
            }
            return funNsiEditFParamsString;

        }

        public CallFunctionMetaInfo CreateCallFunctionCommand(int? tableId, int? funcId, int? codeOper, int? columnId, string funcText = "")
        {
            CallFunctionMetaInfo callFunction = null;
            string nsiString = "";
            FunNSIEditFParams nsiParams = null;
            if (funcId.HasValue && tableId.HasValue)
                callFunction = GetCallFunction(tableId.Value, funcId.Value);
            if (callFunction != null)
                SqlStatementParamsParser.BuildFunction(callFunction);
            else if (codeOper.HasValue)
            {
                nsiString = GetFunNSIEditFParamsString(null, codeOper, null, null, null);
                nsiParams = new FunNSIEditFParams(nsiString);
                callFunction = nsiParams.BuildNsiWebFormName(new CallFunctionMetaInfo());
            }
            else if (columnId.HasValue && tableId.HasValue)
            {
                nsiString = GetFunNSIEditFParamsString(null, null, columnId.Value, tableId.Value, null);
                nsiParams = new FunNSIEditFParams(nsiString);
                callFunction = nsiParams.BuildNsiWebFormName(new CallFunctionMetaInfo());
            }
            else if (string.IsNullOrEmpty(funcText))
                throw new Exception("немає назви процедури");
            List<CallFunctionMetaInfo> funcs = new List<CallFunctionMetaInfo>();
            funcs.Add(callFunction);
            SqlStatementParamsParser.BuilFunctionParams(funcs);
            OracleCommand callFunctionCmd = GetOracleConnector.CreateCommand;
            callFunctionCmd.BindByName = true;
            //строка вызова sql-процедуры находится задана в PROC_NAME
            string procText = !string.IsNullOrEmpty(funcText) ? funcText : callFunction.PROC_NAME;
            if (string.IsNullOrEmpty(procText))
                throw new Exception("немає назви процедури");
            string procTextRes = SqlStatementParamsParser.ReplaceCenturaNullConstants(procText);
            callFunctionCmd.CommandText = string.Format(
                    "begin " +
                    "{0};" +
                    " end;",
                    procTextRes);
            return callFunction;
        }
        private void CallFunctionBeforeSelectTable(List<FieldProperties> fields, string procedureText)
        {
            try
            {
                if (string.IsNullOrEmpty(procedureText))
                    return;
                procedureText = SqlStatementParamsParser.ReplaceCenturaNullConstants(procedureText);
                OracleCommand sqlCommand = GetOracleConnector.CreateCommand;
                sqlCommand.BindByName = true;
                if (procedureText != null)
                {
                    sqlCommand.CommandText = string.Format(
                        "begin " +
                        "{0};" +
                        " end;",
                        procedureText);

                    // получим список параметров процедуры
                    List<string> paramNames = SqlStatementParamsParser.GetSqlStatementParams(procedureText);
                    if (fields != null && fields.Count > 0 && paramNames != null && paramNames.Count > 0)
                        // добавляем параметры процедуры и их значения
                        foreach (string par in paramNames)
                        {
                            FieldProperties field = fields.Find(i => i.Name.Equals(par, StringComparison.OrdinalIgnoreCase));
                            if (field != null)
                            {
                                string paramName = field.Name;

                                if (field.Value == null)
                                {
                                    var param = new OracleParameter(paramName, SqlStatementParamsParser.GetOracleDbType(field.Type));
                                    param.Value = null;
                                    sqlCommand.Parameters.Add(param);
                                }
                                else
                                {
                                    var paramValue = Convert.ChangeType(field.Value, SqlStatementParamsParser.GetCsTypeCode(field.Type));
                                    var param = new OracleParameter(paramName, paramValue);
                                    param.Value = paramValue;
                                    sqlCommand.Parameters.Add(param);
                                }

                            }
                        }
                }
                sqlCommand.BindByName = true;
                sqlCommand.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                GetOracleConnector.Dispose();
                throw;
                //return null;
            }
        }

        /// <summary>
        /// Получить список sql-процедур для вызова из справочника (из META_NSIFUNCTION)
        /// </summary>
        /// <param name="tableId"></param>
        /// <returns></returns>
        private IEnumerable<CallFunctionMetaInfo> GetAllCallFunctions(decimal tableId)
        {
            const string sql = @"SELECT tabid,
                     funcid,
                     descr,
                     proc_name,
                     proc_par,
                     proc_exec,
                     qst,
                     msg,
                     check_func,
                     web_form_name,
                     mnsi.icon_id,
                     mi.icon_path as IconClassName,
                     mi.icon_desc as BtnDysplayName
                FROM META_NSIFUNCTION mnsi left join  META_ICONS mi on mnsi.icon_id = MI.ICON_ID
               WHERE tabid = :tabid
                     AND (PROC_NAME IS NOT NULL OR web_form_name IS NOT NULL)
            ORDER BY funcid";
            var pTabId = new OracleParameter("tabid", OracleDbType.Decimal).Value = tableId;
            return _entities.ExecuteStoreQuery<CallFunctionMetaInfo>(sql, pTabId);
        }

        /// <summary>
        /// Получить параметры sql-процедуры для вызова из справочника (из META_NSIFUNCTION)
        /// </summary>
        /// <param name="tableId"></param>
        /// <param name="funcid">Код процедуры</param>
        /// <returns></returns>
        public CallFunctionMetaInfo GetCallFunction(int tableId, int funcid)
        {
            try
            {
                const string sql = @"select tabid, funcid, descr, proc_name, proc_par, proc_exec, qst, msg, check_func, web_form_name,CUSTOM_OPTIONS
                                 from META_NSIFUNCTION 
                                 where tabid = :tabid and funcid = :funcid";
                var pTabId = new OracleParameter("tabid", OracleDbType.Decimal).Value = tableId;
                var pFuncId = new OracleParameter("funcid", OracleDbType.Int32).Value = funcid;
                return _entities.ExecuteStoreQuery<CallFunctionMetaInfo>(sql, pTabId, pFuncId).FirstOrDefault();
            }
            catch (Exception e)
            {
                throw new Exception(string.Format(e.Message + "запрос до б.д по таблиці id = {0}, funcId = {1} ", tableId, funcid));
            }

        }

        /// <summary>
        /// Выполнить процедуру, которая подменяет операцию изменения данных для таблицы
        /// </summary>
        /// <param name="tableId">ID таблицы</param>
        /// <param name="operation">Тип операции (Update/Delete/Insert)</param>
        /// <param name="fields">Список полей, которые передать в процедуру</param>
        /// <exception cref="Exception"></exception>
        /// <returns>true - процедура выполнена успешно, false - нет процедуры, которая подменяет операцию</returns>
        private bool TryExecuteSubstituationProcedure(int tableId, SqlOperation operation, List<FieldProperties> fields, List<FieldProperties> updatableRowData = null, string procedureString = "", bool isMultipleProcedure = false)
        {
            Logger.Debug(string.Format("begin TryExecuteSubstituationProcedure  procedureString: {0}", procedureString), LoggerPrefix + "TryExecuteSubstituationProcedure");

            if (updatableRowData != null)
                foreach (var item in updatableRowData)
                {
                    var firstOrDefault = fields.FirstOrDefault(u => u.Name == item.Name);
                    if (firstOrDefault != null)
                        firstOrDefault.Value = item.Value;
                }

            //если не null - получим текст процедуры
            string procedureText = operation == SqlOperation.Defoult ? procedureString : GetSubstituationProcedureText(tableId, operation);
            Logger.Debug(string.Format("begin TryExecuteSubstituationProcedure  procedureText: {0}", procedureText), LoggerPrefix + "TryExecuteSubstituationProcedure");
            //Logger.Debug(string.Format("tableid: {0}, operration: {1}, fields count: {2}, updatableRowData: {3}, procedureText: {4}", tableId, operation, fields.Count, updatableRowData.Count, procedureText), LoggerPrefix + "TryExecuteSubstituationProcedure");
            // нет процедуры
            if (string.IsNullOrEmpty(procedureText))
            {
                return false;
            }

            // пустая процедура
            if (procedureText.Equals("null", StringComparison.OrdinalIgnoreCase))
            {
                // ничего не делаем
                return true;
            }

            // выполняем процедуру
            //
            procedureText = SqlStatementParamsParser.ReplaceCenturaNullConstants(procedureText);
            //OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand sqlCommand;
            try
            {

                if (isMultipleProcedure)
                    sqlCommand = this.oracleConnector.GetCommandWithBeginTransaction;
                else
                    sqlCommand = this.GetOracleConnector.GetCommandOrCreate;
                sqlCommand.BindByName = true;
                if (sqlCommand.Parameters != null)
                    sqlCommand.Parameters.Clear();
                sqlCommand.CommandText = string.Format(
                    "begin " +
                    "{0};" +
                    " end;",
                    procedureText);

                // получим список параметров процедуры
                List<string> paramNames = SqlStatementParamsParser.GetSqlStatementParams(procedureText);

                // добавляем параметры процедуры и их значения
                foreach (string par in paramNames)
                {
                    FieldProperties field = fields.Find(i => i.Name.Trim().Equals(par.Trim(), StringComparison.OrdinalIgnoreCase));
                    if (field != null)
                    {
                        var paramName = field.Name.Trim();
                        if (field.Type != "C" && string.IsNullOrEmpty(field.Value))
                            field.Value = null;
                        var paramValue = field.Value == null ? null : Convert.ChangeType(field.Value.Trim(), SqlStatementParamsParser.GetCsTypeCode(field.Type));
                        var param = new OracleParameter(paramName, paramValue);
                        sqlCommand.Parameters.Add(param);
                    }
                }
                Logger.Debug(string.Format("begin execure procedure procedure command: {0}", sqlCommand.CommandText), LoggerPrefix + "TryExecuteSubstituationProcedure");
                sqlCommand.ExecuteNonQuery();
                return true;
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                if (!isMultipleProcedure)
                    this.GetOracleConnector.Dispose();
            }
        }


        /// <summary>
        /// Получить текст процедуры, которая подменяет операцию изменения данных для таблицы
        /// </summary>
        /// <param name="tableId">ID таблицы</param>
        /// <param name="operation">Тип операции (Update/Delete/Insert)</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        private string GetSubstituationProcedureText(int tableId, SqlOperation operation)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand selectCmd = connection.CreateCommand();
                selectCmd.BindByName = true;
                selectCmd.CommandText = "select action_proc from meta_actiontbl where tabid=:tabid and action_code=:actionCode";
                selectCmd.Parameters.Add(new OracleParameter("tabid", tableId));
                selectCmd.Parameters.Add(new OracleParameter("actionCode", operation.ToString().ToUpper()));
                var result = (string)selectCmd.ExecuteScalar();
                return result;
            }
            finally
            {
                connection.Close();
            }
        }

        /// <summary>
        /// Тип операции изменения данных таблицы
        /// </summary>
        private enum SqlOperation
        {
            Insert,
            Update,
            Delete,
            Defoult
        }

        /// <summary>
        /// Фильтр проваливания (провались из другого справочника и должны применить это фильтр к текущему справочнику)
        /// </summary>
        private class FallDownFilter
        {
            /// <summary>
            /// Имя колонки, в которой можно провалиться
            /// </summary>
            public string FromColumn { get; set; }

            /// <summary>
            /// ID таблицы, куда можно провалиться
            /// </summary>
            public int ToTable { get; set; }

            /// <summary>
            /// Код фильтра (META_FILTERCODES.CODE)
            /// </summary>
            public string Code { get; set; }

            /// <summary>
            /// Условие фильтра
            /// </summary>
            public string Condition { get; set; }
        }


        /// <summary>
        /// Определить нужно ли вычитывать все строки для заданных параметров 
        /// </summary>
        /// <param name="start">Начиная со строки</param>
        /// <param name="limit">Количество строк</param>
        /// <returns>Отбирать все строки</returns>
        //private bool NeedToGetAllRecords(int start, int limit)
        //{
        //    // если клиент запросил больше 1000 строк - будем вычитаем все
        //    return limit >= 1000;
        //}

        public MetaTable GetMetaTableByName(string name)
        {
            string sql = "SELECT TABID,TABNAME,SEMANTIC,TABRELATION,TABLDEL,BRANCH,LINESDEF,SELECT_STATEMENT FROM META_TABLES WHERE TABNAME = :name";
            OracleParameter oraParam = new OracleParameter("name", OracleDbType.Varchar2);
            oraParam.Value = name;
            return _entities.ExecuteStoreQuery<MetaTable>(sql, oraParam).FirstOrDefault();
        }

        public MetaTable GetMetaTableById(int id)
        {
            string sql = "SELECT TABID,TABNAME,SEMANTIC,TABRELATION,TABLDEL,BRANCH,LINESDEF,SELECT_STATEMENT FROM META_TABLES WHERE TABID = :tableId";
            OracleParameter oraParam = new OracleParameter("tableId", OracleDbType.Decimal);
            oraParam.Value = id;
            return _entities.ExecuteStoreQuery<MetaTable>(sql, oraParam).FirstOrDefault();
        }


        public CallFunctionMetaInfo GetFunctionsMetaInfo(int? codeOper, string code = "")
        {
            CallFunctionMetaInfo funcInfo = null;
            string funNsiEditFParamsString = string.Empty;
            if (!string.IsNullOrEmpty(code))
            {
                MetaCallSettings settings = GetMetaCallSettingsByCode(code);
                if (settings == null)
                    throw new Exception(string.Format("в таблиці meta_call_settings відсутній запис з ідентифікатором   {0}", code));
                funNsiEditFParamsString = settings.WEB_FORM_NAME;
            }
            else
                funNsiEditFParamsString = GetFunNSIEditFParamsString(null, codeOper, null, null, null);
            if (!string.IsNullOrEmpty(funNsiEditFParamsString))
            {
                FunNSIEditFParams par = new FunNSIEditFParams(funNsiEditFParamsString);
                par.CodeOper = codeOper;
                if (!string.IsNullOrEmpty(par.PROC))
                    funcInfo = par.BuildToCallFunctionMetaInfo(new CallFunctionMetaInfo());

                // парсим строку вызова sql-функции и заполняем информацию о параметрах
                List<ParamMetaInfo> paramsInfo = SqlStatementParamsParser.GetSqlFuncCallParamsDescription<ParamMetaInfo>(funcInfo.PROC_NAME, funcInfo.PROC_PAR);


                // преобразуем список информации о параметрах к формату, который ожидает клиент
                funcInfo.ParamsInfo = paramsInfo.Select(x => new
                {
                    IsInput = x.IsInput,
                    DefaultValue = x.DefaultValue,
                    ColumnInfo = new
                    {
                        COLNAME = x.ColName,
                        COLTYPE = x.ColType,
                        SEMANTIC = x.Semantic,
                        SrcColName = x.SrcColName,
                        SrcTableName = x.SrcTableName,
                        SrcTextColName = x.SrcTextColName
                    }
                });

            }
            return funcInfo;
        }

        public IEnumerable<FilterInfo> GetDynFilterFilters(int tableId, string userid = "")
        {
            List<FilterInfo> filters;
            string getCustomFiltersSqlString;
            if (!string.IsNullOrEmpty(userid))
            {
                getCustomFiltersSqlString = string.Format("select * from DYN_FILTER where USERID = {0}  and TABID = {1} ".ToUpper(), userid, tableId);
                // todo залогировать
                filters = _entities.ExecuteStoreQuery<FilterInfo>(getCustomFiltersSqlString).ToList();
            }
            else
            {
                getCustomFiltersSqlString =
                    string.Format("select * from DYN_FILTER where  USERID IS NULL and TABID = {0} ".ToUpper(), tableId);
                // todo залогировать
                filters = _entities.ExecuteStoreQuery<FilterInfo>(getCustomFiltersSqlString).ToList();
            }
            return filters;
        }
        public IEnumerable<FilterInfo> GetAllDynFilteFilters(int tableId)
        {
            string getCustomFiltersSqlString;
            getCustomFiltersSqlString = string.Format("SELECT * from DYN_FILTER WHERE  TABID = {0} ", tableId);

            IEnumerable<FilterInfo> CustomFilters =
                _entities.ExecuteStoreQuery<FilterInfo>(getCustomFiltersSqlString).ToList();

            return CustomFilters;
        }

        public string InsertFilter(List<FilterRowInfo> filterRows, string filterStructure, int tableid, string filterName, int saveFilter = 1, string whereClause = null)
        {
            try
            {

                List<META_COLUMNS> nativeColumnsInfo = _entities.META_COLUMNS.Where(c => c.TABID == tableid).OrderBy(c => c.SHOWPOS).ToList();
                foreach (var item in filterRows)
                {

                    var it = nativeColumnsInfo.FirstOrDefault(u => u.SEMANTIC != null && u.SEMANTIC.Trim() == item.Colname.Trim());
                    if (it != null)
                    {
                        item.Colname = it.COLNAME;
                    }

                }
                string clause = GetFilterDbInfo.PushRowsFilterList(filterRows, filterStructure, tableid, filterName, saveFilter, whereClause);

                string tableName;
                var table = GetMetaTableById(tableid);
                if (table != null)
                {
                    tableName = table.TABNAME;
                    clause = clause.Replace(SelectBuilder.ClauseAlias, tableName);
                }


                return clause;
            }
            catch (Exception e)
            {

                throw;
            }


        }

        public string UpdateFilter(EditFilterModel editFilterModel)
        {

            List<META_COLUMNS> nativeColumnsInfo = _entities.META_COLUMNS.Where(c => c.TABID == editFilterModel.TableId).OrderBy(c => c.SHOWPOS).ToList();
            foreach (var item in editFilterModel.FilterRows)
            {

                var it = nativeColumnsInfo.FirstOrDefault(u => u.SEMANTIC != null && u.SEMANTIC.Trim() == item.Colname.Trim());
                if (it != null)
                {
                    item.Colname = it.COLNAME;
                }

            }

            string filterDbInfo = GetFilterDbInfo.UpdateFilter(editFilterModel);
            return filterDbInfo;
        }

        public string InsertFilters(List<CreateFilterModel> filterModels)
        {
            return null;
        }

        public string CallParsExcelFunction(HttpPostedFileBase excelFile, string fileName, string date, int? tabid, int? funcid)
        {
            var callFunction = GetCallFunction(tabid.Value, funcid.Value);
            if (callFunction == null)
                throw new Exception(string.Format("процедура з tabid: {0}, та funcid: {1} не знайдена", tabid, funcid));
            SqlStatementParamsParser.BuildFunction(callFunction);
            List<CallFunctionMetaInfo> callFuncs = new List<CallFunctionMetaInfo>();
            callFuncs.Add(callFunction);
            SqlStatementParamsParser.BuilFunctionParams(callFuncs);
            List<FieldProperties> inputParams = new List<FieldProperties>();
            inputParams.Add(new FieldProperties() { Name = "p_file_name", Type = "C", Value = fileName });
            inputParams.Add(new FieldProperties() { Name = "p_ddate", Type = "C", Value = date });
            string convertParams = callFunction.CUSTOM_OPTIONS;
            ExcelHelper excelHelper = new ExcelHelper();
            List<CallFuncRowParam> RowsData = new List<CallFuncRowParam>();// excelHelper.ParseExcelFile(excelFile, callFunction);


            MultiRowParamsDataModel dataModel = new MultiRowParamsDataModel()
            {
                RowsData = RowsData,
                InputParams = inputParams,
                UploadedFile = excelFile
            };

            return CallEachFuncWithMultypleRows(tabid, funcid, null, null, dataModel);

        }

        //public string GetFilterStructure(int dynFilterId)
        //{
        //    OracleCommand sqlfilterCommand = this.GetOracleConnector.GetCommandOrCreate;
        //    string getFilterStructureString = string.Format("SELECT condition_list from dyn_filter WHERE  filter_id = {0} ", dynFilterId);
        //    sqlfilterCommand.CommandText = getFilterStructureString;
        //    //String OutXmlData = String.Empty;
        //    //OracleDataReader rdr = sqlfilterCommand.ExecuteReader();
        //    //while (rdr.Read())
        //    //{
        //    //    OutXmlData += rdr["condition_list"] as string; 
        //    //}
        //    //rdr.Close();
        //    object filterStructure = _entities.ExecuteStoreQuery<OracleClob>(getFilterStructureString).FirstOrDefault();
        //    Oracle.DataAccess.Types.OracleClob clob = filterStructure as Oracle.DataAccess.Types.OracleClob;
        //    string structureString = string.Empty;
        //    if (clob != null)
        //    {
        //        structureString = clob.Value;
        //        clob.Close();
        //        clob.Dispose();
        //    }
        //    return structureString;
        //}


        //public DataSet ArchiveGrid(string kodf)
        //{
        //    // НБУ
        //    const decimal rMode = 0;

        //    const string sql = "select Column1 as \"Column1\",Column2 as \"Column2\",Column3 as \"Column3\",Column4 as \"Column4\",Column5 as \"Column5\",Column6 as \"Column6\",Column7 as \"Column7\"\r\n                                    from                                     (select                                            substr(kodp, 1, 2) as Column1,substr(kodp, 3, 4) as Column2,substr(kodp, 7, 3) as Column3,substr(kodp, 10, 1) as Column4,znap as Column5,NBUC as Column6,KODP as Column7 \r\n                                        from \r\n                                            tmp_nbu\r\n                                        where\r\n                                            kodf = '01'\r\n                                            and datf = to_date('08/02/2015','dd/mm/yyyy')\r\n                                        )";
        //    OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        //    var dataSet = new DataSet();
        //    var adapter = new OracleDataAdapter(sql, con);
        //    adapter.Fill(dataSet);
        //    return dataSet;
        //}

        public FunNSIEditFParams NsiPar { get; set; }
    }
}