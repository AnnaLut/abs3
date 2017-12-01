using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Areas.Ndi.Models;
using BarsWeb.Areas.Ndi.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.Ndi.Models;
using Oracle.DataAccess.Client;
using BarsWeb.Areas.Ndi.Models.FilterModels;

namespace BarsWeb.Areas.Ndi.Infrastructure
{
    /// <summary>
    /// Класс для построения запросов на вычитку данных из справочников с применением различных условий фильтрации, сортировки и т.д.
    /// </summary>
    public class SelectBuilder
    {
        List<string> SKIP_KEYS = new List<string> { "COL_ALL_ALIAS" };

        /// <summary>
        /// Конструктор построителя запросов
        /// </summary>
        public SelectBuilder()
        {
            TableName = "";
            StartRecord = 1;
            RecordsCount = 10;
            ExternalMetaColumns = new List<ColumnMetaInfo>();
        }
        public static readonly string ClauseAlias = "$~~ALIAS~~$";
        /// <summary>
        /// Код справочника
        /// </summary>
        public decimal TableId { get; set; }

        /// <summary>
        /// Название таблицы справочника
        /// </summary>
        public string TableName { get; set; }

        /// <summary>
        /// Вычитать данные таблицы начиная с текущей строки (нумерация с 0). По умолчанию - 0
        /// </summary>
        public int StartRecord { get; set; }

        /// <summary>
        /// Количество строк для вычитки. По умолчанию - 10
        /// </summary>
        public int RecordsCount { get; set; }

        /// <summary>
        /// Признак того, что нужно вычитать все строки (если указано, то игнорируется <see cref="StartRecord"/> и <see cref="RecordsCount"/>. По умолчанию - false
        /// </summary>
        public bool GetAllRecords { get; set; }

        /// <summary>
        /// условия запроса выборки
        /// </summary>
        public string SelectConditions { get; set; }

        /// <summary>
        /// параметры для процедуры и выборки
        /// </summary>
        public List<FieldProperties> SqlParams { get; set; }

        public string NativeTableNameForFilter { get; set; }

        public bool SummaryForRecordsOnScrean { get; set; }

        public string SelectStatement { get; set; }
        /// <summary>
        /// Перечень дополнительных колонок-выражений над полями текущей строки (ключ - имя колонки, значение - sql-выражение)
        /// </summary>
        public Dictionary<string, string> AdditionalColumns
        {
            get
            {
                // если формируем итоговую строку, то не добавляем дополнительные колонки
                return _getTotalRow ? null : _additionalColumns;
            }
            set { _additionalColumns = value; }
        }
        private Dictionary<string, string> _additionalColumns;


        public static IEnumerable<FilterInfo> CustomFilterBuild(IEnumerable<FilterInfo> filters, string tableName, IEnumerable<FilterInfo> filtersFromDb)
        {
            if (filters == null || filtersFromDb == null) return new List<FilterInfo>();

            IEnumerable<FilterInfo> resultFilters = filtersFromDb.Where(u => filters.FirstOrDefault(x => x.FILTER_ID == u.FILTER_ID) != null).ToList();
            foreach (var item in resultFilters)
            {
                item.Where_clause = item.Where_clause.Replace(ClauseAlias, tableName);
            }
            return resultFilters;
        }

        public static FallDownFilterInfo BuildFallDownConditions(List<FieldProperties> sqlParams, string tableName, FallDownFilterInfo filter)
        {
            if (filter == null)
            {
                return null;
            }
            string condition = filter.Condition;
            if (!string.IsNullOrEmpty(condition))
            {
                if (sqlParams != null)
                    filter.FilterParams = sqlParams.Where(x => filter.Condition.Contains(x.Name)).ToList();
                filter.Condition = condition.Replace(ClauseAlias, tableName);
            }

            return filter;
        }
        /// <summary>
        /// Преобразовать список <see cref="META_COLUMNS"/> в список <see cref="ColumnMetaInfo"/>
        /// </summary>
        /// <param name="columnList"></param>
        /// <returns></returns>
        public static List<ColumnMetaInfo> MetaColumnsToColumnInfo(IEnumerable<MetaColumnsDbModel> columnList)
        {
            //    List<ColumnMetaInfo> allColumnsInfo = columnList.Select(ci => new ColumnMetaInfo
            //    {
            //        COLID = ci.COLID,
            //        COLNAME = string.IsNullOrEmpty(ci.COLNAME) ? ci.COLNAME : ci.COLNAME.Replace("/100", "").Trim(),
            //        COLTYPE = string.IsNullOrEmpty(ci.COLTYPE) ? ci.COLTYPE : ci.COLTYPE.Trim(),
            //        SEMANTIC = string.IsNullOrEmpty(ci.SEMANTIC) ? ci.SEMANTIC : ci.SEMANTIC.Trim(),
            //        SHOWWIDTH = ci.SHOWWIDTH,
            //        SHOWMAXCHAR = ci.SHOWMAXCHAR,
            //        SHOWFORMAT = string.IsNullOrEmpty(ci.SHOWFORMAT) ? ci.SHOWFORMAT : ci.SHOWFORMAT.Trim(),
            //        SHOWIN_FLTR = ci.SHOWIN_FLTR,
            //        NOT_TO_EDIT = ci.NOT_TO_EDIT,
            //        NOT_TO_SHOW = ci.NOT_TO_SHOW,
            //        EXTRNVAL = ci.EXTRNVAL,
            //        SHOWPOS = ci.SHOWPOS,
            //        TABID = ci.TABID,
            //        SHOWRESULT = ci.SHOWRESULT,
            //        IsPk = ci.SHOWRETVAL
            //    }).ToList();
            //    return allColumnsInfo;
            bool isFuncOnly;
            CallFunctionMetaInfo functionMetaInfo;
            List<string> paramNames = new List<string>();

            List<ColumnMetaInfo> columnsInfo = new List<ColumnMetaInfo>();
            foreach (var item in columnList)
            {
                var col = new ColumnMetaInfo();

                col.COLID = Convert.ToInt32(item.COLID);
                col.COLNAME = string.IsNullOrEmpty(item.COLNAME) ? item.COLNAME : item.COLNAME.Replace("/100", "").Trim();
                col.COLTYPE = string.IsNullOrEmpty(item.COLTYPE) ? item.COLTYPE : item.COLTYPE.Trim();
                col.SEMANTIC = string.IsNullOrEmpty(item.SEMANTIC) ? item.SEMANTIC : item.SEMANTIC.Trim();
                col.SHOWWIDTH = Convert.ToInt32(item.SHOWWIDTH);
                col.SHOWMAXCHAR = Convert.ToInt32( item.SHOWMAXCHAR);
                col.SHOWFORMAT = string.IsNullOrEmpty(item.SHOWFORMAT) ? item.SHOWFORMAT : item.SHOWFORMAT.Trim();
                col.SHOWIN_FLTR = item.SHOWIN_FLTR;
                col.NOT_TO_EDIT = item.NOT_TO_EDIT;
                col.NOT_TO_SHOW = item.NOT_TO_SHOW;
                col.EXTRNVAL = item.EXTRNVAL;
                col.SHOWPOS = item.SHOWPOS;
                col.TABID = Convert.ToInt32(item.TABID);
                col.IsPk = item.SHOWRETVAL;
                col.InputInNewRecord = item.INPUT_IN_NEW_RECORD;
                col.WEB_FORM_NAME = ReplaceParameter(item.WEB_FORM_NAME, "sPar=", Convert.ToInt32(item.COLID),Convert.ToInt32(item.TABID),
                    out isFuncOnly, out functionMetaInfo, out paramNames);
                col.IsFuncOnly = isFuncOnly;
                col.FunctionMetaInfo = functionMetaInfo;
                col.ParamsNames = paramNames.ToList();
                columnsInfo.Add(col);
            }


            return columnsInfo;
        }

        public static string ReplaceParameter(string url, string searchParam, int? sParColumn, int? nativeTabelId, out bool isFuncOnly, out CallFunctionMetaInfo function, out List<string> paramNames)
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
                function.PROC_EXEC = "ON_ROW_CLICK";
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

        public static List<ColumnMetaInfo> ReplaseDivisionColumnNames(List<ColumnMetaInfo> columns)
        {
            if (columns.Select(x => x.COLNAME.IndexOf("/") > 0).Any())
                foreach (var item in columns)
                {
                    if (item.COLNAME.IndexOf("/") > 0)
                        item.COLNAME = item.COLNAME.Replace(item.COLNAME.Substring(item.COLNAME.IndexOf("/")), "");
                }
            return columns;
        }

        /// <summary>
        /// Метаданные "родных" колонок справочника (описанных непосредственно в самом справочнике)
        /// </summary>
        public List<ColumnMetaInfo> NativeMetaColumns
        {
            get { return _nativeMetaColumns; }
            set
            {
                _nativeMetaColumns = value;
                _processFilterAttributes = true;
            }
        }

        /// <summary>
        /// Метаданные внешних колонок справочника
        /// </summary>
        public List<ColumnMetaInfo> ExternalMetaColumns
        {
            get { return _externalMetaColumns; }
            set
            {
                _externalMetaColumns = value;
                _processFilterAttributes = true;
            }
        }

        /// <summary>
        /// Параметры текущей сортировки таблицы
        /// </summary>
        public SortParam[] OrderParams { get; set; }

        /// <summary>
        /// Параметры фильтров при фильтрации справочников на заголовках колонок
        /// </summary>
        public GridFilter[] GridFilter
        {
            get { return _gridFilter; }
            set
            {
                _gridFilter = value;
                _processFilterAttributes = true;
            }
        }

        public bool SelectNulebl { get; set; }
        /// <summary>
        /// Начальный диалоговый фильтр перед населением таблицы
        /// </summary>
        public IEnumerable<FilterInfo> StartFilter { get; set; }

        /// <summary>
        /// Информация о дополнительных фильтрах для справочника (описываются в META_BROWSETBL и применяются в отдельной форме фильтрации)
        /// </summary>
        public ExtFilter[] ExtFilters
        {
            get { return _extFilters; }
            set
            {
                _extFilters = value;
                _processFilterAttributes = true;
            }
        }

        /// <summary>
        /// Параметры фильтра для внешних приложений
        /// </summary>
        public FallDownFilterInfo FallDownFilter { get; set; }

        public IEnumerable<DynamicFilterInfo> DynamicFilter { get; set; }

        private string FromTables
        {
            get
            {
                string result = string.IsNullOrEmpty(this.SelectStatement) ? TableName : GetMainTableSelectTemplate;
                if (!ExternalMetaColumns.IsNullOrEmpty())
                {
                    result += "," + string.Join(",", ExternalMetaColumns.Select(ecp => string.IsNullOrEmpty(ecp.Tab_Alias) ? ecp.SrcTableName : ecp.SrcTableName + " " + ecp.Tab_Alias).Distinct());
                }
                if (StartFilter != null && StartFilter.Any() && StartFilter.FirstOrDefault(u => !string.IsNullOrEmpty(u.FROM_CLAUSE)) != null)
                {
                    result += "," + string.Join(",", StartFilter.Where(u => !string.IsNullOrEmpty(u.FROM_CLAUSE)).Select(x => x.FROM_CLAUSE).Distinct());
                }
                return result;
            }
        }

        public string GetMainTableSelectTemplate
        {
            get
            {
                return string.Format("( {0} ) {1}", this.SelectStatement, this.TableName);
            }
         
        }
        public static List<ColumnMetaInfo> BuildExternalColumnsToColumns(List<ColumnMetaInfo> extCols)
        {
            // var cols  = new List<ColumnMetaInfo>();
            extCols.ForEach(x => x.COLNAME = x.ColumnAlias);
            return extCols;
            //    foreach (var item in extCols)
            //    {
            //        cols.Add(new ColumnMetaInfo() { COLNAME = item.ColumnAlias });
            //    }
            //    return cols;
        }
        private int EndRecord
        {
            get { return StartRecord + RecordsCount; }
        }

        /// <summary>
        /// Добавить к команде отбора условие отбора
        /// </summary>
        /// <param name="selectCmd"></param>
        private void SetWhere(OracleCommand selectCmd)
        {
            bool hasGridFilter = !GridFilter.IsNullOrEmpty();
            bool hasStartFilter = !StartFilter.IsNullOrEmpty();
            bool hasExternalColumns = !ExternalMetaColumns.IsNullOrEmpty();
            bool hasExtFilters = !ExtFilters.IsNullOrEmpty();
            bool hasFallDownFilter = FallDownFilter != null && !string.IsNullOrEmpty(FallDownFilter.Condition);
            bool hasSelectConditions = !string.IsNullOrEmpty(SelectConditions);
            bool hasDynamicFilter = !DynamicFilter.IsNullOrEmpty();

            if (!hasGridFilter && !hasStartFilter && !hasExternalColumns && !hasExtFilters && !hasSelectConditions && !hasDynamicFilter && !hasFallDownFilter)
            {
                return;
            }
            var fullFilter = new StringBuilder();

            // условия соеднинения таблиц
            //
            if (hasExternalColumns)
            {
                string joinTablesWhere =
                    string.Join(" and ", ExternalMetaColumns.Select(ecp => TableName + "." + ecp.LookupNativeColName(NativeMetaColumns) + "=" + ecp.SrcColFullName + "(+)").Distinct());
                fullFilter.Append(joinTablesWhere);
            }


            // условия фильтрации по колонкам в гриде
            //
            if (hasGridFilter)
            {
                var filterWhere = new StringBuilder("");
                AdaptFilterList();
                if (!string.IsNullOrEmpty(fullFilter.ToString()))
                {
                    fullFilter.Append(" and ");
                }

                filterWhere.Append(string.Join(" and ", GridFilter.Select(f => f.ExtFilter(ExternalMetaColumns))));
                foreach (GridFilter param in GridFilter)
                {
                    // if (param.Type == "boolean" && param.Value == "0")
                    //  BuildGridParameter(param);
                    selectCmd.Parameters.Add(param.ParamName, param.ParamValue);

                    //fullFilter.Append(" OR " + param.ParamName + "IS NULL");
                }
                fullFilter.Append(filterWhere);
            }

            if (hasSelectConditions)
            {
                if (SqlParams != null && SqlParams.Count > 0)
                    foreach (var data in SqlParams)
                    {
                        //временный кастыль. На днях сделать нормально.
                        if (SelectConditions.Contains(":" + data.Name) && (System.Text.RegularExpressions.Regex.IsMatch(SelectConditions, ":" + data.Name + "[\\W]{1}") || SelectConditions.IndexOf(":" + data.Name) + data.Name.Length + 1 == SelectConditions.Length))
                        {

                            //SelectConditions =  SelectConditions.Replace(":" + data.Name, ":p_" + data.Name);
                            var parValue = Convert.ChangeType(data.Value, SqlStatementParamsParser.GetCsTypeCode(data.Type));
                            var param = new OracleParameter(data.Name, parValue);
                            selectCmd.Parameters.Add(param);
                            selectCmd.BindByName = true;
                        }

                    }
                // SelectConditions = SqlStatementParamsParser.ReplaceParamsToValuesInSqlString(SelectConditions, SqlParams);
                if (!string.IsNullOrEmpty(fullFilter.ToString()))
                    fullFilter.Append(" and ");
                fullFilter.Append("(" + SelectConditions + ")");
            }

            // условия фильтрации по заполнению диалога фильтра перед населением таблицы
            if (hasStartFilter)
            {
                if (!string.IsNullOrEmpty(fullFilter.ToString()))
                {
                    fullFilter.Append(" and ");
                }
                IEnumerable<string> startFilters = StartFilter.Select(u => u.Where_clause);
                fullFilter.Append("(");
                //foreach (CustomFilterInfo filter in StartFilter)
                //{
                //    //имя параметра, делаем replace так как имя параметра типа :TABLE.FIELD выдаст ошибку
                //    var paramName = "start_p_" + filter.Name.Replace(".", "_");
                //    startFilters.Add(string.Format("{0} <= :{1}", filter.Name, paramName));
                //    selectCmd.Parameters.Add(paramName, filter.Value == null ? null : Convert.ChangeType(filter.Value, ReferenceBookRepository.GetCsTypeCode(filter.Type)));
                //}
                fullFilter.Append(string.Join(" and ", startFilters));
                fullFilter.Append(")");
            }

            if (hasDynamicFilter)
            {
                if (!string.IsNullOrEmpty(fullFilter.ToString()))
                {
                    fullFilter.Append(" and ");
                }
                IEnumerable<string> dynamicFilters = DynamicFilter.Select(u => u.WHERE_CLAUSE);
                fullFilter.Append("(");
                fullFilter.Append(string.Join(" and ", dynamicFilters));
                fullFilter.Append(")");
            }
            // условия расширенного (внешнего) фильтра
            //
            if (hasExtFilters)
            {
                var extFilterWhere = new StringBuilder("");
                if (!string.IsNullOrEmpty(fullFilter.ToString()))
                {
                    fullFilter.Append(" and ");
                }
                //получим список уникальных пар таблица.поле, потому как могут быть дубли в случае фильтрации по диапазону дат или числел
                //для таких пар нужно строить один EXISTS для лучшего плана выполнения запроса
                var uniqExFilters = ExtFilters.Select(ef =>
                    new
                    {
                        ef.ExtFilterMeta.HostColName,
                        ef.ExtFilterMeta.FullAddColName,
                        ef.ExtFilterMeta.FullVarColName
                    }).Distinct().ToList();

                var exFiltersList = new List<string>();

                //заполним список условий внешней фильтрации 
                foreach (var exFilter in uniqExFilters)
                {
                    var filterItems =
                        ExtFilters.Where(
                            ef =>
                                ef.ExtFilterMeta.HostColName == exFilter.HostColName &&
                                ef.ExtFilterMeta.FullAddColName == exFilter.FullAddColName &&
                                ef.ExtFilterMeta.FullVarColName == exFilter.FullVarColName).ToList();
                    if (filterItems.Any())
                    {
                        string secondСlause = "";
                        if (filterItems.Count() > 1)
                        {
                            secondСlause = filterItems[1].ExtFilterMeta.Filter();
                        }
                        exFiltersList.Add(string.Format(" exists (select * from {0} where {1} = {2} {3} {4})",
                            filterItems[0].ExtFilterMeta.AddTabName,
                            TableName + "." + filterItems[0].ExtFilterMeta.HostColName,
                            filterItems[0].ExtFilterMeta.FullAddColName,
                            filterItems[0].ExtFilterMeta.Filter(),
                            secondСlause
                            ));
                    }
                }

                extFilterWhere.Append(string.Join(" and ", exFiltersList));

                foreach (var extFilter in ExtFilters)
                {
                    if (extFilter.ExtFilterMeta.VarColType == "D")
                    {
                        selectCmd.Parameters.Add(extFilter.ExtFilterMeta.ParamName,
                        DateTime.Parse(extFilter.Value));
                    }
                    else
                    {
                        selectCmd.Parameters.Add(extFilter.ExtFilterMeta.ParamName, extFilter.Value);
                    }
                }
                fullFilter.Append(extFilterWhere);
            }

            // условие проваливания из другого справочника
            //
            if (hasFallDownFilter)
            {
                foreach (var par in FallDownFilter.FilterParams)
                {
                    if (par.Type == "D")
                    {
                        selectCmd.Parameters.Add(par.Name,
                            DateTime.Parse(par.Value));
                    }
                    else
                    {
                        selectCmd.Parameters.Add(par.Name,
                            Convert.ChangeType(par.Value, SqlStatementParamsParser.GetCsTypeCode(par.Type)));
                    }
                }

                if (!string.IsNullOrEmpty(fullFilter.ToString()))
                {
                    fullFilter.Append(" and ");
                }
                fullFilter.Append(FallDownFilter.Condition);
            }
            //if(!string.IsNullOrEmpty(Clause))
            //{
            //    if (!string.IsNullOrEmpty(fullFilter.ToString()))
            //    {
            //        fullFilter.Append(" and ");
            //    }
            //    fullFilter.Append(Clause);

            //}
            selectCmd.CommandText += " where " + fullFilter;
        }
        //private GridFilter BuildGridParameter(GridFilter parameter)
        //{
        //    StringBuilder str;
        //    if (parameter.Value.FirstOrDefault() == '*')
        //    {
        //        str = new StringBuilder(parameter.Value);
        //        str[0] = '%';
        //        parameter.Value = str.ToString();
        //    }
        //    return parameter;

        //}
        string GetOrderBy(bool isAllowEmpty)
        {
            StringBuilder result = new StringBuilder("order by ");
            if (OrderParams != null && OrderParams.Any())
            {
                var combinedOrders = (from order in OrderParams
                                      join extCol in ExternalMetaColumns on order.Property equals extCol.ColumnAlias into extGroup
                                      from extOrder in extGroup.DefaultIfEmpty(null)
                                      select new SortParam
                                      {
                                          Property = extOrder != null ? extOrder.ResultColFullName : TableName + "." + order.Property,
                                          Direction = order.Direction
                                      });
                result.Append(string.Join(",", combinedOrders.Select(o => o.Property + " " + o.Direction)));
                return result.ToString();
            }
            return isAllowEmpty ? result.Append("0").ToString() : "";
        }
        private void AdaptFilterList()
        {
            if (!GridFilter.Any())
            {
                return;
            }
            int i = 0;
            //добавим к родным колонкам префикс - имя таблицы
            foreach (var filter in GridFilter)
            {
                var nativeColumn = NativeMetaColumns.FirstOrDefault(nci => nci.COLNAME == filter.Field);
                if (nativeColumn != null)
                {
                    filter.Field = TableName + "." + nativeColumn.COLNAME;
                }
                filter.ParamOrder = ++i;
            }
            //добавим к внешним колонкам префикс - имя таблицы
            foreach (var filter in GridFilter)
            {
                var extColumn = ExternalMetaColumns.FirstOrDefault(nci => nci.ColumnAlias == filter.Field);
                if (extColumn != null)
                {
                    filter.Field = string.IsNullOrEmpty(extColumn.Tab_Alias) ? extColumn.SrcTableName + "." + extColumn.COLNAME : extColumn.Tab_Alias + "." + extColumn.COLNAME;
                }
            }
        }

        /// <summary>
        /// Итоговые колонки
        /// </summary>
        public List<ColumnMetaInfo> TotalColumns
        {
            get { return NativeMetaColumns.Where(column => !string.IsNullOrEmpty(column.SHOWRESULT)).ToList(); }
        }

        public GridFilter[] GetFilterParams()
        {
            if (GridFilter == null)
            {
                return null;
            }
            AdaptFilterList();
            return GridFilter;
        }

        /// <summary>
        /// Получить команду отбора данных
        /// </summary>
        /// <returns></returns>
        public OracleCommand GetDataSelectCommand(OracleConnection connection)
        {
            _connection = connection;
            _getTotalRow = false;
            return GetSelectCommand();
        }

        /// <summary>
        /// Получить команду отбора строки итоговых значений
        /// </summary>
        /// <returns></returns>
        public OracleCommand GetTotalSelectCommand(OracleConnection connection)
        {
            _connection = connection;
            _getTotalRow = true;
            // получим команду отбора данных
            OracleCommand cmd = GetTotalSelectCommand();
            // перечень итоговых функций
            string totalFunctions = string.Join(",", TotalColumns.Select(column => column.SHOWRESULT + " AS " + column.COLNAME));
            // обернем эту команду командой получения итоговых значений
            cmd.CommandText = string.Format("select {0} from ({1}) {2}", totalFunctions, cmd.CommandText, TableName);
            return cmd;
        }

        /// <summary>
        /// Сформировать команду отбора данных
        /// </summary>
        /// <returns></returns>
        private OracleCommand GetSelectCommand()
        {
            if (_processFilterAttributes)
            {
                SetCaseSensitiveAttribute();
            }

            OracleCommand internalCommand = GetInternalCommand();
            return WrapByExternalCommand(internalCommand);
        }

        private OracleCommand GetTotalSelectCommand()
        {
            if (_processFilterAttributes)
            {
                SetCaseSensitiveAttribute();
            }

            OracleCommand internalCommand = GetInternalCommand();
            if (SummaryForRecordsOnScrean)
                return WrapByExternalCommand(internalCommand);
            else
                return internalCommand;
        }

        public OracleCommand GetSystemProcCommand(string systemProcName)
        {
            OracleCommand cmd = GetInternalCommand();
            cmd.CommandText = string.Format("select {0} from ({1}) {2}", systemProcName, cmd.CommandText, TableName);
            return cmd;
        }
        /// <summary>
        /// Формировать запрос получения итоговой строки
        /// </summary>
        private bool _getTotalRow;

        /// <summary>
        /// Признак необходимости обновить атрибуты фильтров перед формирование команды
        /// </summary>
        private bool _processFilterAttributes;

        private OracleConnection _connection;
        private List<ColumnMetaInfo> _nativeMetaColumns;
        private List<ColumnMetaInfo> _externalMetaColumns;
        private GridFilter[] _gridFilter;
        private ExtFilter[] _extFilters;

        /// <summary>
        /// Получить внутренний запрос. Запрос отбора данных имеет вид: "select EXTERNALCOLUMNNS from (select row_number() OVER (...) rn, INTERNALCOLUMNS)"
        /// </summary>
        /// <returns></returns>
        private OracleCommand GetInternalCommand()
        {
            OracleCommand cmd = _connection.CreateCommand();
            //строим внутренний запрос
            cmd.CommandText = string.Format("select ROW_NUMBER() OVER ({0}) rn, {1} from {2} ", GetOrderBy(true), GetInternalStatementColumns(), FromTables);
            //применяем параметеры фильтрации
            SetWhere(cmd);
            return cmd;
        }

        /// <summary>
        /// Обернуть внутренний запрос внешним. Запрос отбора данных имеет вид: "select EXTERNALCOLUMNNS from (select row_number() OVER (...) rn, INTERNALCOLUMNS)"
        /// </summary>
        /// <param name="internalCommand"></param>
        /// <returns></returns>
        private OracleCommand WrapByExternalCommand(OracleCommand internalCommand)
        {
            // если нужно добавить условие "со строки - по строку" или выражения над полями таблицы
            if (AdditionalColumns != null || !GetAllRecords)
            {
                internalCommand.CommandText = string.Format("select {0} from ({1} {2})", GetExternalStatementColumns(),
                    internalCommand.CommandText, GetOrderBy(false));
                if (!GetAllRecords)
                {
                    internalCommand.CommandText += " where rn > :firstRecord and rn <= :lastRecord";
                    internalCommand.Parameters.Add("firstRecord", StartRecord);
                    internalCommand.Parameters.Add("lastRecord", EndRecord);
                }
            }
            return internalCommand;
        }

        /// <summary>
        /// Получить перечень EXTERNALCOLUMNNS для внешнего запроса. Запрос отбора данных имеет вид: "select EXTERNALCOLUMNNS from (select row_number() OVER (...) rn, INTERNALCOLUMNS)"
        /// </summary>
        /// <returns></returns>
        private string GetExternalStatementColumns()
        {
            var result = new StringBuilder();
            result.Append(string.Join(",", NativeMetaColumns.Select(column => column.COLNAME)));
            if (!ExternalMetaColumns.IsNullOrEmpty())
            {
                result.Append(",");
                result.Append(string.Join(",", ExternalMetaColumns.Select(column => column.ColumnAlias)));
            }
            if (!AdditionalColumns.IsNullOrEmpty())
            {
                result.Append(",");
                result.Append(string.Join(",", AdditionalColumns.Select(pair =>
                (SKIP_KEYS.FindIndex(item => item == pair.Key) == -1) ?
                string.Format("{0} as {1}", pair.Value, pair.Key) :
                pair.Value
                )));
            }
            //if (!TotalColumns.IsNullOrEmpty() && )
            //{
            //    result.Append(",");
            //    result.Append(string.Join(",", TotalColumns.Select(column => column.SHOWRESULT + " over (order by 0)" + " AS " + column.COLNAME + "_SUMMARY")));
            //}
            //result.Append(",COUNT_ROWS");
            return result.ToString();
        }

        /// <summary>
        /// Сформировать перечень INTERNALCOLUMNS для внутреннего запроса. Запрос отбора данных имеет вид: "select EXTERNALCOLUMNNS from (select row_number() OVER (...) rn, INTERNALCOLUMNS)"
        /// </summary>
        /// <returns></returns>
        private string GetInternalStatementColumns()
        {
            var result = new StringBuilder();
            if (NativeMetaColumns != null)
            {
                result.Append(string.Join(",", NativeMetaColumns.Select(column => TableName + "." + column.COLNAME)));
                if (!ExternalMetaColumns.IsNullOrEmpty())
                {
                    result.Append(",");
                    result.Append(string.Join(",", ExternalMetaColumns.Select(column => column.ResultColFullName + column.ColumnAliasWithAs)));
                }
                //result.Append(",COUNT(*) OVER (ORDER BY 0) AS COUNT_ROWS");
            }
            return result.ToString();
        }

        /// <summary>
        /// Для всех параметров всех фильтров определить признак чувствительности к регистру
        /// </summary>
        private void SetCaseSensitiveAttribute()
        {
            if (NativeMetaColumns.IsNullOrEmpty() && ExternalMetaColumns.IsNullOrEmpty() || GridFilter == null && ExtFilters == null)
            {
                return;
            }

            // получим перечень имен чувствительных к регистру колонок
            //
            // используем множество для обеспечения уникальности элементов (вдруг в родных и внешних колонках есть одинаковые поля)
            var sensitiveColumns = new HashSet<string>();
            foreach (string columnName in NativeMetaColumns.Where(column => column.COLTYPE == "A").Select(column => column.COLNAME))
            {
                sensitiveColumns.Add(columnName);
            }
            foreach (string columnName in ExternalMetaColumns.Where(column => column.COLTYPE == "A").Select(column => column.COLNAME))
            {
                sensitiveColumns.Add(columnName);
            }

            // расставим по всем фильтрам признак чувствительности к регистру
            //
            if (GridFilter != null)
            {
                foreach (var filter in GridFilter)
                {
                    filter.CaseSensitive = sensitiveColumns.Any(c => c == filter.Field);
                }
            }
            if (ExtFilters != null)
            {
                foreach (var extFilter in ExtFilters)
                {
                    extFilter.ExtFilterMeta.CaseSensitive = sensitiveColumns.Any(ec => ec == extFilter.ExtFilterMeta.HostColName);
                }
            }
            // для FallDownFilter не нужен признак чувствительности к регистру
        }




    }
}
