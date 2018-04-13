using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Areas.Ndi.Models;
using BarsWeb.Areas.Ndi.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.Ndi.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Ndi.Infrastructure
{
    /// <summary>
    /// Класс для построения запросов на вычитку данных из справочников с применением различных условий фильтрации, сортировки и т.д.
    /// </summary>
    public class SelectBuilder
    {
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

        /// <summary>
        /// Преобразовать список <see cref="META_COLUMNS"/> в список <see cref="ColumnMetaInfo"/>
        /// </summary>
        /// <param name="columnList"></param>
        /// <returns></returns>
        public static List<ColumnMetaInfo> MetaColumnsToColumnInfo(List<META_COLUMNS> columnList)  
        {
            return columnList.Select(column => new ColumnMetaInfo
            {
                COLID = column.COLID,
                COLNAME = column.COLNAME,
                COLTYPE = column.COLTYPE,
                SEMANTIC = string.IsNullOrEmpty(column.SEMANTIC) ? column.COLNAME : column.SEMANTIC,
                SHOWWIDTH = column.SHOWWIDTH,
                SHOWMAXCHAR = column.SHOWMAXCHAR,
                SHOWFORMAT = column.SHOWFORMAT,
                NOT_TO_EDIT = column.NOT_TO_EDIT,
                NOT_TO_SHOW = column.NOT_TO_SHOW,
                SHOWPOS = column.SHOWPOS,
                SHOWRESULT = column.SHOWRESULT
            }).ToList();
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
        /// <summary>
        /// Начальный диалоговый фильтр перед населением таблицы
        /// </summary>
        public FieldProperties[] StartFilter { get; set; }

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
        /// Параметры фильтра для проваливания в другие справочники
        /// </summary>
        public FallDownFilterInfo FallDownFilter { get; set; }

        private string FromTables
        {
            get
            {
                string result = TableName;
                if (!ExternalMetaColumns.IsNullOrEmpty())
                {
                    result += "," + string.Join(",", ExternalMetaColumns.Select(ecp => ecp.SrcTableName).Distinct());
                }
                return result;
            }
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

            if (!hasGridFilter && !hasStartFilter && !hasExternalColumns && !hasExtFilters && !hasFallDownFilter)
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
                    selectCmd.Parameters.Add(param.ParamName, param.ParamValue);
                }
                fullFilter.Append(filterWhere);
            }

            // условия фильтрации по заполнению диалога фильтра перед населением таблицы
            if (hasStartFilter)
            {
                if (!string.IsNullOrEmpty(fullFilter.ToString()))
                {
                    fullFilter.Append(" and ");
                }

                var startFilters = new List<string>();
                foreach (FieldProperties filter in StartFilter)
                {
                    //имя параметра, делаем replace так как имя параметра типа :TABLE.FIELD выдаст ошибку
                    var paramName = "start_p_" + filter.Name.Replace(".", "_");
                    startFilters.Add(string.Format("{0} = :{1}", filter.Name, paramName));
                    selectCmd.Parameters.Add(paramName, filter.Value == null ? null : Convert.ChangeType(filter.Value, ReferenceBookRepository.GetCsTypeCode(filter.Type)));
                }
                fullFilter.Append(string.Join(" and ", startFilters));
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
                            Convert.ChangeType(par.Value, ReferenceBookRepository.GetCsTypeCode(par.Type)));
                    }
                }

                if (!string.IsNullOrEmpty(fullFilter.ToString()))
                {
                    fullFilter.Append(" and ");
                }
                fullFilter.Append(FallDownFilter.Condition);
            }
            selectCmd.CommandText += " where " + fullFilter;
        }

        private string GetOrderBy
        {
            get
            {
                var result = new StringBuilder("order by ");
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
                }
                else
                {
                    result.Append("0");
                }
                return result.ToString();
            }
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
                    filter.Field = extColumn.SrcTableName + "." + extColumn.COLNAME;
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
            OracleCommand cmd = GetSelectCommand();
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
            cmd.CommandText = string.Format("select ROW_NUMBER() OVER ({0}) rn, {1} from {2}", GetOrderBy, GetInternalStatementColumns(), FromTables);
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
                internalCommand.CommandText = string.Format("select {0} from ({1})", GetExternalStatementColumns(),
                    internalCommand.CommandText);
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
                result.Append(string.Join(",", AdditionalColumns.Select(pair => string.Format("{0} as {1}", pair.Value, pair.Key))));
            }
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
