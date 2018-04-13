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

namespace BarsWeb.Areas.Ndi.Infrastructure.Repository.DI.Implementation
{
    public class ReferenceBookRepository : IReferenceBookRepository
    {
        private readonly NdiModel _entities;

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
        /// <param name="limit"></param>
        /// <param name="getAllRecords">Экспорт всех строк. Если указано, то игнорируются параметры <see cref="start"/>, <see cref="limit"/></param>
        /// <returns></returns>
        public MemoryStream ExportToExcel(int tableId, string tableName, SortParam[] sort, GridFilter[] gridFilter, ExtFilter[] externalFilter, FallDownFilterInfo fallDownFilter, int start = 0, int limit = 10, bool getAllRecords = false)
        {
            // вычитка метаданных колонок, метаданные по таблице приходят с клиента
            var columnsInfo = _entities.META_COLUMNS.Where(c => c.TABID == tableId).OrderBy(c => c.SHOWPOS).ToList();

            //вычитаем инфу о внешних колонках
            List<ColumnMetaInfo> extColumnsList = GetExternalColumnsMeta(tableId).ToList();

            var selectBuilder = new SelectBuilder
            {
                TableName = tableName,
                TableId = tableId,
                StartRecord = start,
                RecordsCount = limit,
                GetAllRecords = getAllRecords,
                GridFilter = gridFilter,
                OrderParams = sort,
                NativeMetaColumns = SelectBuilder.MetaColumnsToColumnInfo(columnsInfo),
                ExternalMetaColumns = extColumnsList,
                ExtFilters = externalFilter,
                FallDownFilter = fallDownFilter,
                AdditionalColumns = ConditionalPainting.GetColumns(tableId)
            };

            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand getDataCmd = selectBuilder.GetDataSelectCommand(connection);
            using (var dataReader = getDataCmd.ExecuteReader())
            {
                // создадим и наполним книгу Excel
                //
                using (var package = new ExcelPackage())
                {
                    // добавим новый лист в пустую книгу
                    var tableSemantic = _entities.META_TABLES.First(t => t.TABID == tableId).SEMANTIC;
                    ExcelWorksheet worksheet = package.Workbook.Worksheets.Add(tableSemantic);
                    worksheet.Cells[1, 1].Value = tableSemantic;

                    var allColumns = columnsInfo.Select(ci => new
                    {
                        ci.COLID,
                        ci.COLNAME,
                        ci.SEMANTIC,
                        ci.SHOWWIDTH,
                        ci.COLTYPE,
                        ci.SHOWFORMAT
                    }).ToList();

                    foreach (var fColId in extColumnsList.Select(fc => fc.COLID).Distinct())
                    {
                        int idx = allColumns.IndexOf(allColumns.Single(ci => ci.COLID == fColId));
                        allColumns.InsertRange(++idx,
                            extColumnsList.Where(ec => ec.COLID == fColId).Select(ec => new
                            {
                                COLID = Convert.ToDecimal(ec.COLID),
                                COLNAME = ec.ColumnAlias,
                                SEMANTIC = ec.SEMANTIC,
                                SHOWWIDTH = ec.SHOWWIDTH,
                                COLTYPE = ec.COLTYPE,
                                SHOWFORMAT = ec.SHOWFORMAT
                            }));
                    }

                    // добавим данные
                    //
                    const int dataStartsFromRow = 3;
                    int curRow = dataStartsFromRow;
                    int curCol;
                    bool hasFontPainter = true;
                    bool hasBackgrouondPainter = true;

                    try
                    {
                        while (dataReader.Read())
                        {
                            // заполнить значения всех столбцов строки
                            curCol = 1;
                            foreach (var colTitle in allColumns)
                            {
                                worksheet.Cells[curRow, curCol++].Value = dataReader[colTitle.COLNAME];
                            }

                              if (hasFontPainter)
                              {
                                  // если форматирование не задано - для следующих строк не выполняем раскаску
                                  hasFontPainter = ConditionalPainting.PaintFont(dataReader, worksheet, curRow, allColumns.Count());
                              }
                              if (hasBackgrouondPainter)
                              {
                                  // если форматирование не задано - для следующих строк не выполняем раскаску
                                  hasBackgrouondPainter = ConditionalPainting.PaintBackground(dataReader, worksheet, curRow, allColumns.Count());
                              }
                            curRow++;
                        }
                    }
                    catch(Exception exc)
                    {
                        Debug.WriteLine(exc.ToString());
                    }

                    bool hasData = curRow != dataStartsFromRow;
                    // последняя строка на листе
                    int lastRow = (hasData ? curRow : dataStartsFromRow) - 1;

                    // формат границ таблицы
                    using (var range = worksheet.Cells[2, 1, lastRow, allColumns.Count()])
                    {
                        range.Style.Border.BorderAround(ExcelBorderStyle.Thin);
                        range.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                        range.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    }

                    // формат заголовка
                    using (var range = worksheet.Cells[2, 1, 2, allColumns.Count()])
                    {
                        range.Style.Font.Bold = true;
                        range.Style.Fill.PatternType = ExcelFillStyle.Solid;
                        range.Style.Fill.BackgroundColor.SetColor(Color.CadetBlue);
                        range.Style.Border.BorderAround(ExcelBorderStyle.Thick);
                        range.Style.WrapText = true;
                    }

                    //Process Columns
                    curCol = 1;
                    foreach (var colTitle in allColumns)
                    {
                        string lineBreak = "" + (char)13 + (char)10;
                        //Add the headers
                        worksheet.Cells[2, curCol].RichText.Add(colTitle.SEMANTIC.Replace("~", lineBreak));
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
                                    worksheet.Cells[dataStartsFromRow, curCol, lastRow, curCol].Style.Numberformat.Format =
                                    !String.IsNullOrEmpty(colTitle.SHOWFORMAT) ? colTitle.SHOWFORMAT : "#";
                                    break;
                                case "D":
                                    worksheet.Cells[dataStartsFromRow, curCol, lastRow, curCol].Style.Numberformat.Format =
                                    !String.IsNullOrEmpty(colTitle.SHOWFORMAT) ? colTitle.SHOWFORMAT : @"dd/mm/yyyy";
                                    break;
                            }
                        }
                        curCol++;
                    }
                    // save our new workbook and we are done!
                    var result = new MemoryStream();
                    package.SaveAs(result);
                    return result;
                }
            }
        }

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
                bool substituationProcedureExecuted = TryExecuteSubstituationProcedure(tableId, SqlOperation.Update, updatableRowKeys);
                int updRowsCount = 0;
                if (!substituationProcedureExecuted)
                {
                    // выполнить прямой запрос к таблице
                    //
                    OracleCommand sqlUpdateCommand = connection.CreateCommand();
                    sqlUpdateCommand.BindByName = true;
                    var updateCmdText = new StringBuilder();
                    updateCmdText.AppendFormat("update {0} set ", tableName);

                    foreach (var data in updatableRowData)
                    {
                        updateCmdText.AppendFormat("{0}=:p_{0},", data.Name);
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
                        var paramValue = key.Value == null ? null : Convert.ChangeType(key.Value, GetCsTypeCode(key.Type));

                        var param = new OracleParameter(paramName, paramValue);
                        sqlUpdateCommand.Parameters.Add(param);
                    }
                    updateCmdText.AppendFormat(" where {0}", whereSqlStr);

                    sqlUpdateCommand.CommandText = updateCmdText.ToString();
                    updRowsCount = sqlUpdateCommand.ExecuteNonQuery();
                }
                return substituationProcedureExecuted || updRowsCount > 0;
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
                    string deleteCmdText = string.Format("delete from {0} where ", tableName);

                    string whereSqlStr = "";
                    foreach (var field in deletableRow)
                    {
                        if (!string.IsNullOrWhiteSpace(whereSqlStr))
                        {
                            whereSqlStr += " and ";
                        }
                        whereSqlStr += string.Format("(( :p_key_{0} is null and {0} is null) or ( {0}=:p_key_{0}))  ", field.Name);

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
        public string CallRefFunction(int tableId, int funcId, List<FieldProperties> funcParams)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                CallFunctionsMetaInfo callFunction = GetCallFunction(tableId, funcId);
                OracleCommand callFunctionCmd = connection.CreateCommand();
                callFunctionCmd.BindByName = true;
                //строка вызова sql-процедуры находится задана в PROC_NAME
                callFunctionCmd.CommandText = callFunction.PROC_NAME;

                foreach (var par in funcParams)
                {
                    var paramName = par.Name;
                    var paramValue = par.Value == null
                        ? null
                        : Convert.ChangeType(par.Value, GetCsTypeCode(par.Type));
                    var param = new OracleParameter(paramName, paramValue);
                    callFunctionCmd.Parameters.Add(param);
                }

                //вызвать процедуру
                callFunctionCmd.CommandText = string.Format(
                    "begin " +
                    "{0};" +
                    " end;",
                    callFunction.PROC_NAME);

                callFunctionCmd.ExecuteNonQuery();

                string successMessage = !string.IsNullOrEmpty(callFunction.MSG)
                    ? callFunction.MSG
                    : "Процедура виконана";
                return successMessage;
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
                                    from {2} where (UPPER({0}) like UPPER('%{5}%') or UPPER({1}) like UPPER('%{5}%')) and rownum <= {4}) where rn > {3}",
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
        public GetDataResultInfo GetData(GetDataStartInfo startInfo)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                var selectBuilder = new SelectBuilder
                {
                    TableName = startInfo.TableName,
                    TableId = startInfo.TableId,
                    StartRecord = startInfo.StartRecord,
                    // делаем попытку вычитки на одну строку больше для определения наличия строк кроме запрошенных
                    RecordsCount = startInfo.RecordsCount + 1,
                    GetAllRecords = startInfo.GetAllRecords,
                    GridFilter = startInfo.GridFilter,
                    StartFilter = startInfo.StartFilter,
                    ExtFilters = startInfo.ExtFilters,
                    FallDownFilter = startInfo.FallDownFilter,
                    OrderParams = startInfo.Sort,
                    NativeMetaColumns = SelectBuilder.MetaColumnsToColumnInfo(_entities.META_COLUMNS.Where(mc => mc.TABID == startInfo.TableId).OrderBy(mc => mc.SHOWPOS).ToList()),
                    ExternalMetaColumns = GetExternalColumnsMeta(startInfo.TableId).ToList(),
                    //учтем колонки чувствительные к регистру при фильтрации
                    AdditionalColumns = ConditionalPainting.GetColumns(startInfo.TableId)
                };


                // НБУ-23/R.Перегляд/ заповнення параметров рах. 2605,2625
                // НБУ-23/R.Перегляд/ заповнення параметров угод КП ФО
                if (selectBuilder.TableId == 6266 || selectBuilder.TableId==6055) 
                     selectBuilder.StartFilter = null;
                
                // получим основной набор данных
                OracleCommand getDataCmd = selectBuilder.GetDataSelectCommand(connection);
                OracleDataReader getDataReader = getDataCmd.ExecuteReader();
                var allData = AllRecordReader.ReadAll(getDataReader).ToList();

                // добавим итоговую строку
                Dictionary<string, object> summaryData = null;
                if (selectBuilder.TotalColumns.Any())
                {
                    // для подсчета итоговых значений берем запрошенное количество строк
                    selectBuilder.RecordsCount = startInfo.RecordsCount;
                    OracleCommand getSummaryDataCmd = selectBuilder.GetTotalSelectCommand(connection);
                    var getSummaryDataReader = getSummaryDataCmd.ExecuteReader();
                    summaryData = AllRecordReader.ReadAll(getSummaryDataReader).FirstOrDefault();
                }
                var result = new GetDataResultInfo
                {
                    DataRecords = allData.Take(startInfo.RecordsCount),
                    RecordsCount = allData.Count(),
                    TotalRecord = summaryData
                };
                return result;
            }            
            finally
            {
                connection.Close();
            }
        }

        /// <summary>
        /// Получить метаданные справочников
        /// </summary>
        /// <param name="tableId">Id таблицы</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        public object GetMetaData(int tableId)
        {
            var tableInfo = _entities.META_TABLES.Where(mt => mt.TABID == tableId).Select(mt =>
                new
                {
                    mt.TABID,
                    mt.TABNAME,
                    mt.SEMANTIC
                }).Single();

            //получим информацию о "родных" колонках
            var nativeColumnsInfo = _entities.META_COLUMNS.Where(c => c.TABID == tableId).OrderBy(c => c.SHOWPOS).ToList();
            string st = tableId.ToString();
                         
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

            var intlFilters =
                _entities.ExecuteStoreQuery<META_COL_INTL_FILTERS>("select * from META_COL_INTL_FILTERS")
                    .Where(f => f.TABID == tableId);

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
                COLNAME = ci.COLNAME,
                COLTYPE = ci.COLTYPE,
                SEMANTIC = string.IsNullOrEmpty(ci.SEMANTIC) ? ci.COLNAME : ci.SEMANTIC,
                SHOWWIDTH = ci.SHOWWIDTH,
                SHOWMAXCHAR = ci.SHOWMAXCHAR,
                SHOWFORMAT = ci.SHOWFORMAT,
                SHOWIN_FLTR = ci.SHOWIN_FLTR,
                NOT_TO_EDIT = ci.NOT_TO_EDIT,
                NOT_TO_SHOW = ci.NOT_TO_SHOW,
                EXTRNVAL = ci.EXTRNVAL,
                SHOWPOS = ci.SHOWPOS
            }).ToList();

            // добавить информацию о проваливании
            AppendFallDownFilterInfo(columnsInfo, tableId);

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
                }
            }
            //очистим внешние колони от ненужной информации об их связях
            foreach (var extCol in extColumnsInfo)
            {
                extCol.COLNAME = extCol.ColumnAlias;
                extCol.SrcTableName = String.Empty;
                extCol.SrcColName = String.Empty;
                extCol.SrcTextColName = String.Empty;
                extCol.IsForeignColumn = true;
            }

            //добавим внешние колонки в нужном порядке
            foreach (var extColId in extColumnsInfo.Select(ec => ec.COLID).Distinct())
            {
                int idx = columnsInfo.IndexOf(columnsInfo.Single(ci => ci.COLID == extColId));
                columnsInfo.InsertRange(++idx, extColumnsInfo.Where(ec => ec.COLID == extColId).ToList());
            }

            //получим метаинформацию о фильтрах по внешних справочниках
            var extFilters = GetExtFilterMeta(tableId);

            //информация о функциях которые могут быть вызваны
            List<CallFunctionsMetaInfo> callFunctions = GetAllCallFunctions(tableId).ToList();
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
            var metadata = new { tableInfo, columnsInfo, sorters, intlFilters, extFilters, callFunctions, additionalProperties };
            return metadata;
        }

        /// <summary>
        /// Добавить информацию о проваливании для колонок
        /// </summary>
        /// <param name="columnsInfo">Инфо о колонках таблицы</param>
        /// <param name="tableId">ID таблицы</param>
        private void AppendFallDownFilterInfo(List<ColumnMetaInfo> columnsInfo, int tableId)
        {
            // получим все фильтры для таблицы
            IEnumerable<FallDownFilter> allFilters = GetFallDownFilters(tableId);
            if (allFilters != null)
            {
                // для каждого фильтра...
                foreach (FallDownFilter filter in allFilters)
                {
                    // находим колонку, по которой проваливаемся
                    ColumnMetaInfo columnToFilter = columnsInfo.Find(x => x.COLNAME.Equals(filter.FromColumn, StringComparison.OrdinalIgnoreCase));
                    if (columnToFilter != null)
                    {
                        // привязываем фильтр к найденной колонке
                        columnToFilter.FallDownInfo = new FallDownColumnInfo
                        {
                            TableId = filter.ToTable,
                            FilterCode = filter.Code,
                            Columns = SqlStatementParamsParser.GetSqlStatementParams(filter.Condition)
                        };
                    }
                }
            }
        }

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
            catch(Exception ex)
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
                                   ev.tab_alias,
                                   ev.tab_cond,
                                   ev.src_cond,
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

        /// <summary>
        /// Получить список sql-процедур для вызова из справочника (из META_NSIFUNCTION)
        /// </summary>
        /// <param name="tableId"></param>
        /// <returns></returns>
        private IEnumerable<CallFunctionsMetaInfo> GetAllCallFunctions(decimal tableId)
        {
            const string sql = @"select tabid, funcid, descr, proc_name, proc_par, proc_exec, qst, msg, check_func 
                                 from META_NSIFUNCTION 
                                 where tabid = :tabid and PROC_NAME is not null order by funcid";
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
            const string sql = @"select tabid, funcid, descr, proc_name, proc_par, proc_exec, qst, msg, check_func 
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
        private bool TryExecuteSubstituationProcedure(int tableId, SqlOperation operation, List<FieldProperties> fields)
        {
            // получим текст процедуры
            string procedureText = GetSubstituationProcedureText(tableId, operation);

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
                    FieldProperties field = fields.Find(i => i.Name.Equals(par, StringComparison.OrdinalIgnoreCase));
                    if (field != null)
                    {
                        var paramName = field.Name;
                        var paramValue = field.Value == null ? null : Convert.ChangeType(field.Value, GetCsTypeCode(field.Type));
                        var param = new OracleParameter(paramName, paramValue);
                        sqlCommand.Parameters.Add(param);
                    }
                }
                sqlCommand.ExecuteNonQuery();
                return true;
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
            Delete
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
    }
}