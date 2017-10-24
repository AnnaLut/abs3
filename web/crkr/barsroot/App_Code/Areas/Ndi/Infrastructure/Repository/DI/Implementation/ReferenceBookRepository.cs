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
using System.Web;
using System.Data;
using ExcelLibrary;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.Ndi.Infrastructure.Repository.DI.Implementation
{
    public class ReferenceBookRepository : IReferenceBookRepository
    {
        private readonly NdiModel _entities;
        [Inject]
        public IDbLogger Logger { get; set; }
        private bool IsDebug = true;
        private string LoggerPrefix = "ReferenceBookRepository.";
        public ReferenceBookRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("Ndi", "Ndi");
            _entities = new NdiModel(connectionStr);
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
        public MemoryStream ExportToExcel(int tableId, string tableName, string sort, string gridFilter, string startFilter, string dynamicFilter, string externalFilter, string columnsVisible,
            int start = 0, int limit = 10, int? nativeTabelId = null, int? codeOper = null, int? sParColumn = null, int? nsiTableId = null, int? nsiFuncId = null,
            string jsonSqlProcParams = "", string base64jsonSqlProcParams = "", string executeBeforFunc = "")
        {
            var result = new MemoryStream();
            GetDataResultInfo dataResult = GetData(tableId, tableName, gridFilter, externalFilter, startFilter, dynamicFilter, sort, limit, start,
                    nativeTabelId, codeOper, sParColumn, nsiTableId, nsiFuncId, jsonSqlProcParams, base64jsonSqlProcParams, executeBeforFunc);

            IEnumerable<Dictionary<string, object>> dataRecords = dataResult.DataRecords;
            try
            {
                // вычитка метаданных колонок, метаданные по таблице приходят с клиента   
                var columnsInfo = _entities.META_COLUMNS
                    .Where(c => c.TABID == tableId).OrderBy(x => x.SHOWPOS).ToList();

                //вычитаем инфу о внешних колонках
                List<ColumnMetaInfo> extColumnsList = GetExternalColumnsMeta(tableId).ToList();
                extColumnsList = SelectBuilder.BuildExternalColumnsToColumns(extColumnsList);
                var allColumnsInfo = SelectBuilder.MetaColumnsToColumnInfo(columnsInfo);

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
                    TableName = tableName,
                    TableId = tableId,
                    StartRecord = start,
                    RecordsCount = limit,
                    GetAllRecords = NeedToGetAllRecords(start, limit),
                    GridFilter = FormatConverter.JsonToObject<GridFilter[]>(gridFilter),
                    // StartFilter = startFilter,
                    //OrderParams = sort,
                    NativeMetaColumns = SelectBuilder.MetaColumnsToColumnInfo(columnsInfo),
                    ExternalMetaColumns = extColumnsList,
                    // ExtFilters = externalFilter,
                    AdditionalColumns = ConditionalPainting.GetColumns(tableId)
                };

                //OracleConnection connection = OraConnector.Handler.UserConnection;
                // OracleCommand getDataCmd = selectBuilder.GetDataSelectCommand(connection);

                // using (var dataReader = getDataCmd.ExecuteReader())
                // {
                // создадим и наполним книгу Excel                   
                using (var package = new ExcelPackage())
                {
                    // добавим новый лист в пустую книгу
                    var tableSemantic = _entities.META_TABLES.First(t => t.TABID == tableId).SEMANTIC;
                    ExcelWorksheet worksheet = package.Workbook.Worksheets.Add(tableSemantic);
                    worksheet.Cells[1, 1].Value = tableSemantic;
                    //Where(x=>x.NOT_TO_SHOW==0)
                    // List<ColumnMetaInfo> allColumnsInfo = SelectBuilder.MetaColumnsToColumnInfo(columnsInfo);
                    //var allColumns = selectBuilder.NativeMetaColumns.Select(ci => new
                    //{
                    //    ci.COLID,
                    //    ci.COLNAME,
                    //    ci.SEMANTIC,
                    //    ci.SHOWWIDTH,
                    //    ci.COLTYPE,
                    //    ci.SHOWFORMAT
                    //}).ToList();


                    //foreach (var fColId in extColumnsList.Select(fc => fc.COLID).Distinct())
                    //{
                    //    int idx = allColumns.IndexOf(allColumns.Single(ci => ci.COLID == fColId));
                    //    allColumns.InsertRange(++idx,
                    //        extColumnsList.Where(ec => ec.COLID == fColId).Select(ec => new
                    //        {
                    //            COLID = Convert.ToDecimal(ec.COLID),
                    //            COLNAME = ec.ColumnAlias,
                    //            SEMANTIC = ec.SEMANTIC,
                    //            SHOWWIDTH = ec.SHOWWIDTH,
                    //            COLTYPE = ec.COLTYPE,
                    //            SHOWFORMAT = ec.SHOWFORMAT
                    //        }));
                    //}
                    string[] values = columnsVisible.Split(',');
                    List<ColumnMetaInfo> allShowColumns = new List<ColumnMetaInfo>();
                    // СКРЫТЬ НЕОТОБРАЖАЕМЫЕ КОЛОНКИ:
                    foreach (var item in allColumnsInfo)
                    {
                        if (item.NOT_TO_SHOW != 1 && !values.Contains(item.COLNAME))
                        {
                            allShowColumns.Add(item);
                        }
                    }


                    // убрать колонки для выгрузки если сняты отметки для отображения
                    //if (!string.IsNullOrEmpty(columnsVisible))
                    //{
                    //    string[] values = columnsVisible.Split(',');
                    //    foreach (var item in values)
                    //    {
                    //        allColumnsInfo.RemoveAt
                    //            (allColumnsInfo.IndexOf(allColumnsInfo.Where(x => x.COLNAME == item).First()));
                    //    }
                    //}

                    // добавим данные 
                    const int dataStartsFromRow = 3;
                    int curRow = dataStartsFromRow;
                    int curCol;
                    int startColumn = 2;
                    bool hasFontPainter = true;
                    bool hasBackgrouondPainter = true;

                    //while (dataReader.Read())
                    // {
                    foreach (var item in dataRecords)
                    {

                        // заполнить значения всех столбцов строки
                        curCol = 1;
                        foreach (var colTitle in allShowColumns)
                        {
                            worksheet.Cells[curRow, curCol++].Value = item[colTitle.COLNAME.ToUpper()];
                        }
                        //Array sheetArray = worksheet.Cells.Value as Array;
                        if (hasFontPainter)
                        {
                            // если форматирование не задано - для следующих строк не выполняем раскраску
                            hasFontPainter = ConditionalPainting.PaintFont(item, worksheet, curRow, allShowColumns);
                        }
                        if (hasBackgrouondPainter)
                        {
                            // если форматирование не задано - для следующих строк не выполняем раскраску
                            hasBackgrouondPainter = ConditionalPainting.PaintBackground(item, worksheet, curRow, allShowColumns);
                        }
                        curRow++;

                    }
                    //}

                    bool hasData = curRow != dataStartsFromRow;
                    // последняя строка на листе
                    int lastRow = (hasData ? curRow : dataStartsFromRow) - 1;
                    // формат границ таблицы
                    using (var range = worksheet.Cells[2, 1, lastRow, allShowColumns.Count()])
                    {
                        range.Style.Border.BorderAround(ExcelBorderStyle.Thin);
                        range.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                        range.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    }
                    // формат заголовка
                    using (var range = worksheet.Cells[2, 1, 2, allShowColumns.Count()])
                    {
                        range.Style.Font.Bold = true;
                        range.Style.Fill.PatternType = ExcelFillStyle.Solid;
                        range.Style.Fill.BackgroundColor.SetColor(Color.CadetBlue);
                        range.Style.Border.BorderAround(ExcelBorderStyle.Thick);
                        range.Style.WrapText = true;
                    }
                    //Process Columns
                    curCol = 1;
                    foreach (var colTitle in allShowColumns)
                    {
                        string lineBreak = "" + (char)13 + (char)10;
                        //Add the headers
                        worksheet.Cells[2, curCol].RichText.Add(colTitle.SEMANTIC != null ? colTitle.SEMANTIC.Replace("~", lineBreak) : "");
                        double widthInInches = 1.5;
                        if (colTitle.SHOWWIDTH != null && colTitle.SHOWWIDTH.Value > 1)
                        {
                            widthInInches = (double)colTitle.SHOWWIDTH.Value;
                        }
                        worksheet.Column(curCol).Width = widthInInches * 10;
                        //Mark filtered and sorted columns --sorting not supported now in EPPlus
                        if (selectBuilder.GetFilterParams() != null &&
                            selectBuilder.GetFilterParams().Any(p => p.Field == colTitle.COLNAME))
                        {
                            worksheet.Cells[2, curCol].Style.Font.Bold = true;
                            worksheet.Cells[2, curCol].Style.Font.Italic = true;
                        }
                        if (hasData)
                        {
                            //Formatting columns
                            switch (colTitle.COLTYPE)
                            {
                                case "N":
                                case "B":
                                    //worksheet.Cells[dataStartsFromRow, curCol, lastRow, curCol].Style.Numberformat.Format =
                                    //!String.IsNullOrEmpty(colTitle.SHOWFORMAT) ? colTitle.SHOWFORMAT : "#";
                                    worksheet.Cells[dataStartsFromRow, curCol, lastRow, curCol].Style.Numberformat.Format =
                                   !String.IsNullOrEmpty(colTitle.SHOWFORMAT) &&
                                   worksheet.Cells[dataStartsFromRow, curCol, lastRow, curCol].Value.ToString() != "0" ? colTitle.SHOWFORMAT : "@";
                                    break;
                                case "D":
                                    worksheet.Cells[dataStartsFromRow, curCol, lastRow, curCol].Style.Numberformat.Format =
                                    !String.IsNullOrEmpty(colTitle.SHOWFORMAT) ? colTitle.SHOWFORMAT : @"dd/mm/yyyy";
                                    break;
                            }
                        }
                        curCol++;
                        Debug.WriteLine(curCol.ToString());
                    }
                    // save our new workbook and we are done!                       
                    package.SaveAs(result);
                    return result;
                }
                //}
            }
            catch (Exception ex)
            {
                Debug.WriteLine("Error! - " + ex.ToString());
            }
            return result;
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
        public bool UpdateData(int tableId, string tableName, List<FieldProperties> updatableRowKeys, List<FieldProperties> updatableRowData)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                // выполнить sql-процедуру, которая подменяет выполенение прямого запроса к таблице
                List<FieldProperties> RowDataForProsedur = DataRecordExtensions.Clone<FieldProperties>(updatableRowKeys);
                bool substituationProcedureExecuted = TryExecuteSubstituationProcedure(tableId, SqlOperation.Update, RowDataForProsedur, updatableRowData);
                int updRowsCount = 0;
                if (!substituationProcedureExecuted)
                {
                    List<string> pKColumns = _entities.META_COLUMNS.Where(mc => mc.TABID == tableId && mc.SHOWRETVAL == 1).Select(x => x.COLNAME).ToList();
                    if (pKColumns != null && pKColumns.Count > 0)
                        updatableRowKeys = updatableRowKeys.Where(cl => pKColumns.Contains(cl.Name)).ToList();
                    else
                        updatableRowKeys.RemoveAll(x => updatableRowData.All(u => u.Name == x.Name));
                    // выполнить прямой запрос к таблице
                    //
                    Logger.Debug(string.Format("begin update with sql c#   updatableRowKeys count: ", updatableRowKeys.Count(), LoggerPrefix + "UpdateData"), LoggerPrefix + "UpdateData");
                    OracleCommand sqlUpdateCommand = connection.CreateCommand();
                    sqlUpdateCommand.BindByName = true;
                    var updateCmdText = new StringBuilder();
                    updateCmdText.AppendFormat("update {0} set ", tableName);

                    foreach (var data in updatableRowData)
                    {
                        updateCmdText.AppendFormat("{0}=:p_{0},", data.Name);
                        if (data.Type != "C" && string.IsNullOrEmpty(data.Value))
                            data.Value = null;
                        sqlUpdateCommand.Parameters.Add("p_" + data.Name, data.Value == null ? null : Convert.ChangeType(data.Value, GetCsTypeCode(data.Type)));
                    }
                    if (updateCmdText.Length > 0)
                    {
                        //убрать последнюю запятую
                        updateCmdText.Length = updateCmdText.Length - 1;
                    }

                    string whereSqlStr = "";
                    foreach (var key in updatableRowKeys)
                    {
                        if (!string.IsNullOrWhiteSpace(whereSqlStr))
                        {
                            whereSqlStr += " and ";
                        }
                        whereSqlStr += string.Format("(( :p_key_{0} is null and {0} is null) or ( {0}=:p_key_{0}))  ", key.Name);

                        var paramName = "p_key_" + key.Name;
                        if (key.Type != "C" && string.IsNullOrEmpty(key.Value))
                            key.Value = null;
                        var paramValue = key.Value == null ? null : Convert.ChangeType(key.Value, GetCsTypeCode(key.Type));

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
                connection.Close();
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
        public bool InsertData(int tableId, string tableName, List<FieldProperties> insertableRow)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                // выполнить sql-процедуру, которая подменяет выполенение прямого запроса к таблице
                bool substituationProcedureExecuted = TryExecuteSubstituationProcedure(tableId, SqlOperation.Insert,
                    insertableRow);
                int insRowsCount = 0;
                if (!substituationProcedureExecuted)
                {
                    // выполнить прямой запрос к таблице
                    OracleCommand sqlInsertCommand = connection.CreateCommand();
                    sqlInsertCommand.BindByName = true;

                    var insertFieldNames = new StringBuilder();
                    var insertFieldValues = new StringBuilder();

                    foreach (var data in insertableRow)
                    {
                        insertFieldNames.AppendFormat("{0},", data.Name);
                        insertFieldValues.AppendFormat(":p_{0},", data.Name);
                        if (data.Type != "C" && string.IsNullOrEmpty(data.Value))
                            data.Value = null;
                        sqlInsertCommand.Parameters.Add("p_" + data.Name,
                            data.Value == null ? null : Convert.ChangeType(data.Value, GetCsTypeCode(data.Type)));
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
                connection.Close();
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
        public bool DeleteData(int tableId, string tableName, List<FieldProperties> deletableRow)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                // выполнить sql-процедуру, которая подменяет выполенение прямого запроса к таблице
                bool substituationProcedureExecuted = TryExecuteSubstituationProcedure(tableId, SqlOperation.Delete, deletableRow);
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
                        var paramValue = field.Value == null ? null : Convert.ChangeType(field.Value, GetCsTypeCode(field.Type));

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
        public string CallRefFunction(int? tableId, int? funcId, int? codeOper, List<FieldProperties> funcParams, string funcText = "", string msg = "", string web_form_name = "", string jsonSqlProcParams = "")
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            CallFunctionsMetaInfo callFunction = null;
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
                    return "input funcid or text prodedure";
                OracleCommand callFunctionCmd = connection.CreateCommand();
                callFunctionCmd.BindByName = true;
                //строка вызова sql-процедуры находится задана в PROC_NAME
                string procText = !string.IsNullOrEmpty(funcText) ? funcText : callFunction.PROC_NAME;
                if (string.IsNullOrEmpty(procText))
                    return "немає назви процедури";
                procText = SqlStatementParamsParser.ReplaceCenturaNullConstants(procText);
                callFunctionCmd.CommandText = procText;
                foreach (var par in funcParams)
                {
                    if (procText.Contains(":" + par.Name))
                    {
                        var paramName = par.Name;
                        if (par.Type != "C" && string.IsNullOrEmpty(par.Value))
                            par.Value = null;
                        var paramValue = par.Value == null
                            ? null
                            : Convert.ChangeType(par.Value, GetCsTypeCode(par.Type));
                        Logger.Info("add parameter in: " + callFunctionCmd.CommandText + "parameter name:  " + paramName + "Value:  " + paramValue);
                        var param = new OracleParameter(paramName, paramValue);
                        callFunctionCmd.Parameters.Add(param);
                        callFunctionCmd.BindByName = true;
                    }
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
                if (callFunction != null)
                    successMessage = callFunction.MSG;

                if (nsiParams != null && !string.IsNullOrEmpty(nsiParams.MSG))
                    successMessage = nsiParams.MSG;

                return successMessage;
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


        public GetFileResult CallFunctionWithFileResult(int? tableId, int? funcId, int? codeOper, List<FieldProperties> funcParams, string funcText = "", string msg = "", string web_form_name = "", string jsonSqlProcParams = "")
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            CallFunctionsMetaInfo callFunction = null;
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
                                : Convert.ChangeType(par.Value, GetCsTypeCode(par.Type));
                            Logger.Info("add parameter in: " + callFunctionCmd.CommandText + "parameter name:  " + paramName + "Value:  " + paramValue);
                            var param = new OracleParameter(paramName, paramValue);
                            callFunctionCmd.Parameters.Add(param);
                        }
                    }
                OracleClob clob = null;
                string name = null;
                GetFileResult result = null;
                OracleParameter clobParam = null;
                OracleParameter nameParam = null;
                List<ParamMetaInfo> outParameters = null;
                string clobParamName = null;
                string fileNameParam = null;

                if (callFunction != null && !string.IsNullOrEmpty(callFunction.OutParams))
                {
                    outParameters = SqlStatementParamsParser.GetSqlFuncCallParamsDescription(callFunction.PROC_NAME, callFunction.OutParams);
                    clobParamName = outParameters.FirstOrDefault(x => x.ColType.ToUpper() == "CLOB").ColName;
                    fileNameParam = outParameters.FirstOrDefault(x => x.ColType == "fileName").ColName;
                    clobParam = new OracleParameter(clobParamName, OracleDbType.Clob, 4000, null, ParameterDirection.Output);
                    callFunctionCmd.Parameters.Add(clobParam);
                    nameParam = new OracleParameter(fileNameParam, OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                    callFunctionCmd.Parameters.Add(nameParam);
                }

                //вызвать процедуру
                callFunctionCmd.CommandText = string.Format(
                    "begin " +
                    "{0};" +
                    " end;",
                    procText);

                Logger.Info("ptocedure comand text: " + callFunctionCmd.CommandText);
                callFunctionCmd.ExecuteNonQuery();
                if (clobParam != null && clobParam.Value != null && nameParam != null && nameParam.Value != null)
                {
                    clob = clobParam.Value as OracleClob;
                    name = nameParam.Value.ToString();
                }


                if (clob != null && clob.Value != null)
                {
                    result = new GetFileResult() { FileBody = clob.Value, FileName = !string.IsNullOrEmpty(name) ? name : "file", Result = "ok" };

                }
                clob.Dispose();
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
                        href = "/barsroot/ndi/referencebook/referencegrid?tableId=" + tableId + "&mode=" + mode
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
        public List<Dictionary<string, object>> GetRelatedReferenceData(string tableName, string fieldForId,
            string fieldForName, string query, int start = 0, int limit = 10)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand getDataCommand = connection.CreateCommand();
                getDataCommand.CommandText = string.Format(
                    @"select * from (select rownum rn, {0} as id, {1} as name 
                                    from {2} where (UPPER({0}) like UPPER('{5}%') or UPPER({1}) like UPPER('{5}%')) and rownum <= {4}) where rn > {3}",
                    fieldForId, fieldForName, tableName, start, start + limit + 1, query);

                var getDataReader = getDataCommand.ExecuteReader();
                var allData = AllRecordReader.ReadAll(getDataReader).ToList();
                return allData;
            }
            finally
            {
                connection.Close();
            }
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
        public GetDataResultInfo GetData(int tableId, string tableName, string gridFilter, string externalFilter, string startFilter, string dynamicFilter, string sort, int limit = 10, int start = 0,
            int? nativeTabelId = null, int? codeOper = null, int? sParColumn = null, int? nsiTableId = null, int? nsiFuncId = null, string jsonSqlProcParams = "",
            string base64jsonSqlProcParams = "", string executeBeforFunc = "", int? filterTblId = null, string kindOfFilter = "", string filterCode = "", bool isReserPages = false)
        {

            UserMap user = ConfigurationSettings.GetCurrentUserInfo;
            var bytesJsonSqlProcParams = Convert.FromBase64String(base64jsonSqlProcParams);
            string stringJsonSqlProcParams = Encoding.UTF8.GetString(bytesJsonSqlProcParams);
            string SelectConditions = null;
            string FunNSIEditFParamsString = null;
            FunNSIEditFParams nsiEditParams = null;
            META_TABLES nativTableForFilter = null;
            FunNSIEditFParamsString = GetFunNSIEditFParamsString(null, codeOper, sParColumn, nativeTabelId, nsiTableId, nsiFuncId);
            if (!string.IsNullOrEmpty(FunNSIEditFParamsString))
                nsiEditParams = new FunNSIEditFParams(FunNSIEditFParamsString);
            startFilter = startFilter == "undefined" ? "" : startFilter;
            dynamicFilter = dynamicFilter == "undefined" ? "" : dynamicFilter;
            List<FieldProperties> sqlParamerties = string.IsNullOrEmpty(jsonSqlProcParams) || jsonSqlProcParams == "undefined" ? new List<FieldProperties>() : JsonConvert.DeserializeObject<List<FieldProperties>>(jsonSqlProcParams) as List<FieldProperties>;
            List<FieldProperties> sqlSelectRowParams = string.IsNullOrEmpty(stringJsonSqlProcParams) || stringJsonSqlProcParams == "undefined" ? new List<FieldProperties>() : JsonConvert.DeserializeObject<List<FieldProperties>>(stringJsonSqlProcParams) as List<FieldProperties>;
            if (nsiEditParams != null)
                SelectConditions = nsiEditParams.Conditions;

            if (!string.IsNullOrEmpty(kindOfFilter) && filterTblId != null)
            {
                if (kindOfFilter == KindsOfFilters.CustomFilter.ToString())
                    SelectConditions = FilterInfo.BuildFilterConditions(filterTblId.Value, Convert.ToInt32(user.user_id));
                if (kindOfFilter == KindsOfFilters.SystemFilter.ToString())
                    SelectConditions = FilterInfo.BuildFilterConditions(filterTblId.Value);
                if (filterTblId.HasValue)
                    nativTableForFilter = GetMetaTableById(filterTblId.Value);
            }

            string TableName = nsiEditParams == null || string.IsNullOrEmpty(nsiEditParams.TableName) ? tableName : nsiEditParams.TableName;

            var TABLE = string.IsNullOrEmpty(tableName) || tableName.ToLower() == "undefined" ? GetMetaTableById(tableId) : GetMetaTableByName(TableName);
            if (TABLE.TABNAME == "DYN_FILTER")
            {
                sort = "";
            }
            int TableId = TABLE != null ? Convert.ToInt32(TABLE.TABID) : tableId;
            sqlSelectRowParams.AddRange(sqlParamerties);

            var startInfo = new GetDataStartInfo
            {
                TableId = TableId,
                TableName = TABLE != null ? TABLE.TABNAME : TableName,
                Sort = FormatConverter.JsonToObject<SortParam[]>(sort),
                GridFilter = FormatConverter.JsonToObject<GridFilter[]>(gridFilter),
                StartFilter = FormatConverter.JsonToObject<FilterInfo[]>(startFilter),
                ExtFilters = FormatConverter.JsonToObject<ExtFilter[]>(externalFilter),
                DynamicFilter = FormatConverter.JsonToObject<DynamicFilterInfo[]>(dynamicFilter),
                nativTableNameForFilter = nativTableForFilter != null ? nativTableForFilter.TABNAME : "",
                // на клиенте нет информации о условии фильтра проваливания, есть код и значения переменных, которые фигурируют в условии
                // добавим условие фильтра проваливания
                FallDownFilter = !string.IsNullOrEmpty(filterCode) ? GetFilterByCode(filterCode) : null,// AddFilterCondition(FormatConverter.JsonToObject<FallDownFilterInfo>(fallDownFilter), tableName),
                StartRecord = isReserPages == true ? 0 : start,
                RecordsCount = limit,
                GetAllRecords = NeedToGetAllRecords(start, limit),
                NativeMetaColumns = _entities.META_COLUMNS.Where(mc => mc.TABID == TableId).OrderBy(mc => mc.SHOWPOS).ToList(),
                ExternalMetaColumns = GetExternalColumnsMeta(TableId).ToList(),
                SelectConditions = SelectConditions,
                ProcedureText = nsiEditParams == null || (nsiEditParams.EXEC != "BEFORE" && nsiEditParams.EXEC != "BEFORE_THIS") || executeBeforFunc == "no" ? null : nsiEditParams.PROC,
                SelectFieldProperties = sqlSelectRowParams,
                SummaryForRecordsOnScrean = nsiEditParams != null && !string.IsNullOrEmpty(nsiEditParams.SummVisibleRows) && nsiEditParams.SummVisibleRows.ToUpper() == "TRUE"
            };

            if (startInfo.StartFilter != null && startInfo.StartFilter.Count() > 0)
            {
                IEnumerable<FilterInfo> customFiltersFromDb = GetAllDynFilteFilters(startInfo.TableId);
                startInfo.StartFilter = SelectBuilder.CustomFilterBuild(startInfo.StartFilter, startInfo.TableName, customFiltersFromDb);
            }
            if (startInfo.FallDownFilter != null && !string.IsNullOrEmpty(startInfo.FallDownFilter.Condition))
            {
                startInfo.FallDownFilter = SelectBuilder.BuildFallDownConditions(sqlParamerties, startInfo.TableName, startInfo.FallDownFilter);
                startInfo.FallDownFilter.FilterParams = sqlSelectRowParams.Where(x => startInfo.FallDownFilter.Condition.Contains(x.Name)).ToList();

            }

            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                var selectBuilder = new SelectBuilder
                {
                    TableName = startInfo.TableName,
                    TableId = startInfo.TableId,
                    StartRecord = startInfo.StartRecord,
                    NativeTableNameForFilter = startInfo.nativTableNameForFilter,
                    // делаем попытку вычитки на одну строку больше для определения наличия строк кроме запрошенных
                    RecordsCount = startInfo.RecordsCount + 1,
                    GetAllRecords = startInfo.GetAllRecords,
                    GridFilter = startInfo.GridFilter,
                    StartFilter = startInfo.StartFilter,
                    ExtFilters = startInfo.ExtFilters,
                    FallDownFilter = startInfo.FallDownFilter,
                    DynamicFilter = startInfo.DynamicFilter,
                    OrderParams = startInfo.Sort,
                    NativeMetaColumns = SelectBuilder.MetaColumnsToColumnInfo(_entities.META_COLUMNS.Where(mc => mc.TABID == startInfo.TableId).OrderBy(mc => mc.SHOWPOS).ToList()),
                    ExternalMetaColumns = SelectBuilder.ReplaseDivisionColumnNames(startInfo.ExternalMetaColumns),
                    //учтем колонки чувствительные к регистру при фильтрации
                    AdditionalColumns = ConditionalPainting.GetColumns(startInfo.TableId),
                    SelectConditions = startInfo.SelectConditions,
                    SqlParams = startInfo.SelectFieldProperties,
                    SummaryForRecordsOnScrean = startInfo.SummaryForRecordsOnScrean
                };
                HttpContext context = HttpContext.Current;
                string sesstionLastActionKey = "lastActionForTable" + TableId;
                string lactAction = context.Session[sesstionLastActionKey] as string;
                context.Session[sesstionLastActionKey] = "GetData";
                if (!string.IsNullOrEmpty(startInfo.ProcedureText) && lactAction != "GetData")
                {
                    CallFunctionBeforeSelectTable(connection, startInfo.SelectFieldProperties, startInfo.ProcedureText);
                }

                // получим основной набор данных
                OracleCommand getDataCmd = selectBuilder.GetDataSelectCommand(connection);
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
                result = AllRecordReader.GetComplexResult(getDataReader, selectBuilder, hasDivision, startInfo);
                Dictionary<string, object> summaryData = new Dictionary<string, object>();
                if (selectBuilder.TotalColumns.Any())
                {
                    // для подсчета итоговых значений берем запрошенное количество строк
                    selectBuilder.RecordsCount = startInfo.RecordsCount;

                    OracleCommand getSummaryDataCmd = selectBuilder.GetTotalSelectCommand(connection);
                    var getSummaryDataReader = getSummaryDataCmd.ExecuteReader();
                    summaryData = AllRecordReader.ReadAll(getSummaryDataReader).FirstOrDefault();
                    result.TotalRecord = summaryData;
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
                string msg = ex.Message.ToUpper();
                if (msg.Contains("SPECIFIED CAST IS NOT VALID"))
                {
                    msg += "       можливо Помилка виникла в результаті некоректного типу даних в представлені." +
                        "Перегляньте числові поля на предмет значень, що містять більше 8-ми знаків після мантиси ";
                    Logger.Error("ReferenceBookRepository. GetData. " + msg);
                    throw new Exception(msg);
                }

                //return new GetDataResultInfo();
                throw;
            }
            finally
            {
                connection.Close();
            }
        }

        FallDownFilterInfo GetFilterByCode(string filterCode)
        {
            FallDownFilterInfo filter = null;
            if (string.IsNullOrEmpty(filterCode))
                return filter;
            filter = new FallDownFilterInfo();
            filter.Condition = GetFallDownCondition(filterCode);
            filter.FilterCode = filterCode;
            return filter;
        }
        /// <summary>
        /// Получить метаданные справочников
        /// </summary>
        /// <param name="tableId">Id таблицы</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        public object GetMetaData(int tableId, int? codeOper, int? sParColumn, int? nativeTabelId, int? nsiTableId, int? nsiFuncId, string base64jsonSqlProcParams = "")
        {
            try
            {

                Logger.Debug(string.Format(" begin GetMetaData for: tableid: {0},codeOper: {1}, sParColumn: {2},nativeTabelId: {3},nsiTableId: {4},nsiFuncId: {5}, base64jsonSqlProcParams: {6} ", tableId.ToString(), codeOper.HasValue ? codeOper.Value.ToString() : "", sParColumn.HasValue ? sParColumn.Value.ToString() : "", nativeTabelId.HasValue ? nativeTabelId.Value.ToString() : "", nsiTableId.HasValue ? nsiTableId.Value.ToString() : "", nsiFuncId.HasValue ? nsiFuncId.Value.ToString() : "", base64jsonSqlProcParams), LoggerPrefix + "GetMetaData");
                var tableInfo = _entities.META_TABLES.Where(mt => mt.TABID == tableId).Select(mt =>
                    new
                    {
                        mt.TABID,
                        mt.TABNAME,
                        mt.SEMANTIC,
                        mt.LINESDEF
                    }).Single();
                UserMap user = ConfigurationSettings.GetCurrentUserInfo;
                FunNSIEditFParams nsiPar = null;
                string FunNSIEditFParamsString = GetFunNSIEditFParamsString(tableId, codeOper, sParColumn, nativeTabelId, nsiTableId, nsiFuncId);
                if (!string.IsNullOrEmpty(FunNSIEditFParamsString))
                    nsiPar = new FunNSIEditFParams(FunNSIEditFParamsString);
                List<CallFunctionsMetaInfo> callFunctions = new List<CallFunctionsMetaInfo>();
                var bytesJsonSqlProcParams = Convert.FromBase64String(base64jsonSqlProcParams);
                string stringJsonSqlProcParams = Encoding.UTF8.GetString(bytesJsonSqlProcParams);
                List<FieldProperties> RowParams = string.IsNullOrEmpty(stringJsonSqlProcParams) || stringJsonSqlProcParams == "undefined" ? new List<FieldProperties>() : JsonConvert.DeserializeObject<List<FieldProperties>>(stringJsonSqlProcParams) as List<FieldProperties>;
                HttpContext context = HttpContext.Current;
                string sesstionKey = "lastActionForTable" + tableId;
                context.Session[sesstionKey] = "MetaData";
                //получим информацию о "родных" колонках
                var nativeColumnsInfo = _entities.META_COLUMNS.Where(c => c.TABID == tableId).OrderBy(c => c.SHOWPOS).ToList();

                //сформируем также информацию о дефолтной сортировке
                var sorters =
                    _entities.ExecuteStoreQuery<META_SORTORDER>("select * from META_SORTORDER")
                        .Where(so => so.TABID == tableId)
                        .OrderBy(so => so.SORTORDER)
                        .Select(so => new
                        {
                            direction = so.SORTWAY != null ? so.SORTWAY.Trim() : "ASC",
                            property = nativeColumnsInfo.Single(ci => ci.COLID == so.COLID).COLNAME.Trim()
                        }).ToList();

                //string getCustomFiltersSqlString = string.Format("select * from DYN_FILTER where USERID = {0} and TABID = {1}", user.user_id, tableId);


                //формат даты и числовых полей в описании справочников не совпадает с форматом даты extjs, поэтому делаем переконвертацию
                foreach (var column in nativeColumnsInfo)
                {
                    if (!string.IsNullOrEmpty(column.SHOWFORMAT))
                    {
                        if (column.COLTYPE == "N" || column.COLTYPE == "E")
                        {
                            column.SHOWFORMAT = FormatConverter.ConvertToExtJsDecimalFormat(column.SHOWFORMAT);
                        }
                        if (column.COLTYPE == "D")
                        {
                            column.SHOWFORMAT = FormatConverter.ConvertToExtJsDateFormat(column.SHOWFORMAT);
                        }
                    }
                }

                //сформируем итоговый список колонок по основному набору колонок
                List<ColumnMetaInfo> columnsInfo = nativeColumnsInfo.Select(ci => new ColumnMetaInfo
                {
                    COLID = ci.COLID,
                    COLNAME = string.IsNullOrEmpty(ci.COLNAME) ? ci.COLNAME : ci.COLNAME.Replace("/100", "").Trim(),
                    COLTYPE = string.IsNullOrEmpty(ci.COLTYPE) ? ci.COLTYPE : ci.COLTYPE.Trim(),
                    SEMANTIC = string.IsNullOrEmpty(ci.SEMANTIC) ? ci.SEMANTIC : ci.SEMANTIC.Trim(),
                    SHOWWIDTH = ci.SHOWWIDTH,
                    SHOWMAXCHAR = ci.SHOWMAXCHAR,
                    SHOWFORMAT = string.IsNullOrEmpty(ci.SHOWFORMAT) ? ci.SHOWFORMAT : ci.SHOWFORMAT.Trim(),
                    SHOWIN_FLTR = ci.SHOWIN_FLTR,
                    NOT_TO_EDIT = ci.NOT_TO_EDIT,
                    NOT_TO_SHOW = ci.NOT_TO_SHOW,
                    EXTRNVAL = ci.EXTRNVAL,
                    SHOWPOS = ci.SHOWPOS,
                    TABID = ci.TABID,
                    WEB_FORM_NAME = ReplaceParameter(ci.WEB_FORM_NAME, "sPar=", "sParColumn", ci.COLID.ToString(), "nativeTabelId", ci.TABID.ToString())
                }).ToList();

                IEnumerable<FilterInfo> CustomFilters = GetDynFilterFilters(tableId, user.user_id);
                IEnumerable<FilterInfo> SystemFilters = GetDynFilterFilters(tableId);

                var filerTbl = GetMetaTableByName("DYN_FILTER");
                FiltersMetaInfo filtersMetainfo = new FiltersMetaInfo(filerTbl, user);
                List<META_COLUMNS> CustomfilterMetaColumns;
                List<ColumnMetaInfo> filtersColumns = new List<ColumnMetaInfo>();
                filtersMetainfo.ComboboxColumnModelBuild(columnsInfo);
                if (nsiPar != null && !string.IsNullOrEmpty(nsiPar.ShowDialogWindow))
                    filtersMetainfo.ShowFilterWindow = nsiPar.ShowDialogWindow;

                if (filerTbl != null && (CustomFilters != null || SystemFilters != null))
                {
                    CustomfilterMetaColumns = _entities.META_COLUMNS.Where(c => c.TABID == filerTbl.TABID).OrderBy(c => c.SHOWPOS).ToList();
                    filtersMetainfo.FiltersMetaColumns = SelectBuilder.MetaColumnsToColumnInfo(CustomfilterMetaColumns);
                    filtersColumns = SelectBuilder.MetaColumnsToColumnInfo(CustomfilterMetaColumns);
                    filtersMetainfo.BuildFilters();
                    filtersMetainfo.HasFilter = true;
                }

                foreach (var item in CustomFilters)
                    item.BuildFilterParams();

                foreach (var item in SystemFilters)
                    item.BuildFilterParams();

                if (CustomFilters.Count() > 0)
                    CustomFilters = CustomFilters.OrderBy(u => u.IsUserFilter).ToList();

                if (SystemFilters.Count() > 0)
                    SystemFilters = SystemFilters.OrderBy(u => u.IsUserFilter).ToList();
                filtersMetainfo.CustomFilters = CustomFilters;
                filtersMetainfo.SystemFilters = SystemFilters;
                // добавить информацию о проваливании
                //AppendFallDownFilterInfo(columnsInfo, tableId);

                //получим также инфу о внешних колонках из таблицы META_EXTRNVAL
                var extColumnsInfo = GetExternalColumnsMeta(tableId).ToList();

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
                        columnsInfo[idx].DYN_TABNAME = firstExtCol.DYN_TABNAME;
                    }
                }
                var extcolums = extColumnsInfo.Where(ex => string.IsNullOrEmpty(ex.DYN_TABNAME));
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
                List<ExtFilterMeta>  extFilters = GetExtFilterMeta(tableId).ToList(); //new List<ExtFilterMeta>(); //
                if (nsiPar != null)
                {
                    if (RowParams != null && RowParams.Count > 0 && nsiPar != null)
                        nsiPar.ReplaceParams(RowParams);
                    //информация о функциях которые могут быть вызваны
                    if (nsiPar.IsInMeta_NSIFUNCTION)
                    {
                        IEnumerable<CallFunctionsMetaInfo> funcs = GetAllCallFunctions(tableId).ToList();
                        funcs = SqlStatementParamsParser.BuildFunctions(funcs);

                        callFunctions.AddRange(funcs);
                    }
                    if (!string.IsNullOrEmpty(nsiPar.PROC))
                        callFunctions.Add(nsiPar.BuildToCallFunctionMetaInfo(new CallFunctionsMetaInfo()));
                    foreach (var func in callFunctions)
                    {
                        // парсим строку вызова sql-функции и заполняем информацию о параметрах
                        List<ParamMetaInfo> paramsInfo = SqlStatementParamsParser.GetSqlFuncCallParamsDescription(func.PROC_NAME, func.PROC_PAR);
                        // преобразуем список информации о параметрах к формату, который ожидает клиент
                        func.ParamsInfo = paramsInfo.Select(x => new
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
                        //func.PROC_EXEC = "BEFORE";
                    }
                }
                //получить признак добавления итоговой строки
                var selectBuilder = new SelectBuilder
                {
                    TableName = tableInfo.TABNAME,
                    TableId = tableId,
                    NativeMetaColumns = SelectBuilder.MetaColumnsToColumnInfo(nativeColumnsInfo)
                };

                bool addSummaryRow = selectBuilder.TotalColumns.Count > 0;

                //добавляем дополнительные свойства на клиент для упрощения жизни
                var additionalProperties = new { addSummaryRow };
                var metadata = new { tableInfo, columnsInfo, sorters, filtersColumns, filtersMetainfo, CustomFilters, extFilters, callFunctions, additionalProperties };
                Logger.Debug(string.Format(" end GetMetaData for: tableid: {0},columnsInfo count: {1}, table name: {2},CustomFilters count: {3},SystemFilters count: {4},callFunctions coount : {5} ", tableInfo.TABID.ToString(), columnsInfo.Count.ToString(), tableInfo.TABNAME, filtersMetainfo.CustomFilters != null ? filtersMetainfo.CustomFilters.Count().ToString() : "", filtersMetainfo.SystemFilters != null ? filtersMetainfo.SystemFilters.Count().ToString() : "", callFunctions.Count().ToString()), LoggerPrefix + "GetMetaData");

                return metadata;

            }
            catch (Exception e)
            {

                throw e;
            }
        }

        public byte[] GetCustomImage()
        {
            byte[] img = GetButtonImg();
            return img;
        }

       
        public string ReplaceParameter(string url, string searchParam, string param1Name, string param1Value, string param2Name, string param2Value)
        {
            FunNSIEditFParams parameters = null;
            if (string.IsNullOrEmpty(url) || url.IndexOf(searchParam) != 0)
                return url;
            string res = SqlParamTextBuilder.mainRefBookDataUrl + "?" + param1Name + "=" + param1Value + "&" + param2Name + "=" + param2Value;
            if (url.IndexOf(":") != 0)
            {
                string searchparamValue = url.Substring(url.IndexOf(searchParam) + searchParam.Length);
                parameters = new FunNSIEditFParams(searchparamValue);
                if (!string.IsNullOrEmpty(parameters.RowParamsNames))
                    res += "&RowParamsNames=" + parameters.RowParamsNames;
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
                                   ev.DYN_TABNAME,
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

        public string GetFunNSIEditFParamsString(int? tabid, int? codeOper, int? metacolumnId, int? nativeTabelId, int? nsiTableId, int? nsiFuncId = null)
        {
            string FunNSIEditFParamsString = null;
            try
            {
                if (metacolumnId != null && metacolumnId.HasValue && nativeTabelId != null && nativeTabelId.HasValue)
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
                    FunNSIEditFParamsString = url.Substring(url.IndexOf("sPar=") + "sPar=".Length);
                }
                if (codeOper != null && codeOper.HasValue)
                {
                    var pCodeOper = new OracleParameter("codeoper", OracleDbType.Decimal).Value = codeOper.Value;
                    string url = _entities.ExecuteStoreQuery<string>("select  funcname from operlist where codeoper = :codeoper", pCodeOper).FirstOrDefault();
                    url = url.Trim();
                    FunNSIEditFParamsString = url.Substring(url.IndexOf("&sPar=") + "&sPar=".Length);
                }
                if (nsiTableId != null && nsiFuncId != null)
                {
                    CallFunctionsMetaInfo func = GetCallFunction(nsiTableId.Value, nsiFuncId.Value);
                    if (func != null && !string.IsNullOrEmpty(func.WEB_FORM_NAME) && func.WEB_FORM_NAME.Contains("sPar"))
                        FunNSIEditFParamsString = func.WEB_FORM_NAME.Substring(func.WEB_FORM_NAME.IndexOf("sPar=") + "sPar=".Length);
                }
            }
            catch (Exception)
            {
                return null;
                throw;
            }
            return FunNSIEditFParamsString;

        }
        private OracleConnection CallFunctionBeforeSelectTable(OracleConnection connection, List<FieldProperties> fields, string procedureText)
        {
            try
            {
                if (connection == null || string.IsNullOrEmpty(procedureText))
                    return null;
                procedureText = SqlStatementParamsParser.ReplaceCenturaNullConstants(procedureText);
                OracleCommand sqlCommand = connection.CreateCommand();
                sqlCommand.BindByName = true;
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
                    FieldProperties field = fields.Find(i => i.Name.Equals(par, StringComparison.OrdinalIgnoreCase));
                    if (field != null)
                    {
                        var paramName = field.Name;
                        var paramValue = field.Value == null ? null : Convert.ChangeType(field.Value, GetCsTypeCode(field.Type));
                        var param = new OracleParameter(paramName, paramValue);
                        sqlCommand.Parameters.Add(param);
                    }
                }
                sqlCommand.BindByName = true;
                sqlCommand.ExecuteNonQuery();
                return connection;
            }
            catch (Exception e)
            {
                connection.Close();
                throw e;
                //return null;
            }
        }
        /// <summary>
        /// Получить список sql-процедур для вызова из справочника (из META_NSIFUNCTION)
        /// </summary>
        /// <param name="tableId"></param>
        /// <returns></returns>
        private IEnumerable<CallFunctionsMetaInfo> GetAllCallFunctions(decimal tableId)
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
            return _entities.ExecuteStoreQuery<CallFunctionsMetaInfo>(sql, pTabId);
        }

        /// <summary>
        /// Получить параметры sql-процедуры для вызова из справочника (из META_NSIFUNCTION)
        /// </summary>
        /// <param name="tableId"></param>
        /// <param name="funcid">Код процедуры</param>
        /// <returns></returns>
        private CallFunctionsMetaInfo GetCallFunction(int tableId, int funcid)
        {
            const string sql = @"select tabid, funcid, descr, proc_name, proc_par, proc_exec, qst, msg, check_func, web_form_name 
                                 from META_NSIFUNCTION 
                                 where tabid = :tabid and funcid = :funcid";
            var pTabId = new OracleParameter("tabid", OracleDbType.Decimal).Value = tableId;
            var pFuncId = new OracleParameter("funcid", OracleDbType.Int32).Value = funcid;
            return _entities.ExecuteStoreQuery<CallFunctionsMetaInfo>(sql, pTabId, pFuncId).First();
        }

        /// <summary>
        /// Выполнить процедуру, которая подменяет операцию изменения данных для таблицы
        /// </summary>
        /// <param name="tableId">ID таблицы</param>
        /// <param name="operation">Тип операции (Update/Delete/Insert)</param>
        /// <param name="fields">Список полей, которые передать в процедуру</param>
        /// <exception cref="Exception"></exception>
        /// <returns>true - процедура выполнена успешно, false - нет процедуры, которая подменяет операцию</returns>
        private bool TryExecuteSubstituationProcedure(int tableId, SqlOperation operation, List<FieldProperties> fields, List<FieldProperties> updatableRowData = null, string procedureString = "")
        {
            Logger.Debug(string.Format("begin TryExecuteSubstituationProcedure  procedureString: {0}", procedureString), LoggerPrefix + "TryExecuteSubstituationProcedure");

            if (updatableRowData != null)
                foreach (var item in updatableRowData)
                {
                    fields.FirstOrDefault(u => u.Name == item.Name).Value = item.Value;
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
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand sqlCommand = connection.CreateCommand();
                sqlCommand.BindByName = true;
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
                        var paramValue = field.Value == null ? null : Convert.ChangeType(field.Value.Trim(), GetCsTypeCode(field.Type));
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
                connection.Close();
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
        private bool NeedToGetAllRecords(int start, int limit)
        {
            // если клиент запросил больше 1000 строк - будем вычитаем все
            return limit >= 1000;
        }

        public META_TABLES GetMetaTableByName(string name)
        {
            return _entities.META_TABLES.FirstOrDefault(mt => mt.TABNAME == name);
        }

        public META_TABLES GetMetaTableById(int id)
        {
            return _entities.META_TABLES.FirstOrDefault(mt => mt.TABID == id);
        }


        public CallFunctionsMetaInfo GetFunctionsMetaInfo(int? codeOper)
        {
            CallFunctionsMetaInfo funcInfo = null;
            string FunNSIEditFParamsString = GetFunNSIEditFParamsString(null, codeOper, null, null, null);
            if (!string.IsNullOrEmpty(FunNSIEditFParamsString))
            {
                FunNSIEditFParams par = new FunNSIEditFParams(FunNSIEditFParamsString);
                par.CodeOper = codeOper;
                if (!string.IsNullOrEmpty(par.PROC))
                    funcInfo = par.BuildToCallFunctionMetaInfo(new CallFunctionsMetaInfo());

                // парсим строку вызова sql-функции и заполняем информацию о параметрах
                List<ParamMetaInfo> paramsInfo = SqlStatementParamsParser.GetSqlFuncCallParamsDescription(funcInfo.PROC_NAME, funcInfo.PROC_PAR);
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
            string getCustomFiltersSqlString;
            if (!string.IsNullOrEmpty(userid))
                getCustomFiltersSqlString = string.Format("select * from DYN_FILTER where USERID = {0}  and TABID = {1} ", userid, tableId);
            else
                getCustomFiltersSqlString = string.Format("select * from DYN_FILTER where  USERID IS NULL and TABID = {0} ", tableId);

            IEnumerable<FilterInfo> CustomFilters =
                _entities.ExecuteStoreQuery<FilterInfo>(getCustomFiltersSqlString).ToList();

            return CustomFilters;
        }
        public IEnumerable<FilterInfo> GetAllDynFilteFilters(int tableId)
        {
            string getCustomFiltersSqlString;
            getCustomFiltersSqlString = string.Format("SELECT * from DYN_FILTER WHERE  TABID = {0} ", tableId);

            IEnumerable<FilterInfo> CustomFilters =
                _entities.ExecuteStoreQuery<FilterInfo>(getCustomFiltersSqlString).ToList();

            return CustomFilters;
        }

        public string InsertFilter(List<FilterRowInfo> filterRows, int tableid, string filterName, int saveFilter = 1, string whereClause = null)
        {
            try
            {
                List<META_COLUMNS> nativeColumnsInfo = _entities.META_COLUMNS.Where(c => c.TABID == tableid).OrderBy(c => c.SHOWPOS).ToList();
                foreach (var item in filterRows)
                {

                    var it = nativeColumnsInfo.FirstOrDefault(u => u.SEMANTIC.Trim() == item.Colname.Trim());
                    if (it != null)
                    {
                        item.Colname = it.COLNAME;
                    }

                }
                string clause = GetFilterDbInfo.PushRowsFilterList(filterRows, tableid, filterName, saveFilter, whereClause);
                string tableName;
                META_TABLES table = GetMetaTableById(tableid);
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

        public string InsertFilters(List<CreateFilterModel> filterModels)
        {
            return null;
        }
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

        public FunNSIEditFParams nsiPar { get; set; }
    }
}