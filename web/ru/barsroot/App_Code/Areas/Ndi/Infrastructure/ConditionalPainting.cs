using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Bars.Classes;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using Oracle.DataAccess.Client;
using BarsWeb.Areas.Ndi.Models;

namespace BarsWeb.Areas.Ndi.Infrastructure
{
    public class TBLCOLOR
    {
        public string CONDITION { get; set; }
        public int ORD { get; set; }
        public string COLOR_NAME { get; set; }
        public decimal COLID { get; set; }
        public short COLOR_INDEX { get; set; }
    }


    /// <summary>
    /// Формирование sql-выражения условной раскраски (данные берем из таблицы meta_tblcolor)
    /// </summary>
    internal class ConditionalPainting
    {
        const string COL_ALL_ALIAS = "COL_ALL_ALIAS";

        /// <summary>
        /// Алиас рядка "цвет шрифта"
        /// </summary>
        const string FontRowColorNameAlias = "font_row_color_name";

        /// <summary>
        /// Алиас рядка "цвет фона"
        /// </summary>
        const string BackgroundRowColorNameAlias = "bg_row_color_name";

        /// <summary>
        /// Получить перечень sql-выражений для условного цветового форматирования (ключ - алиас выражения, значение - "(case when ... else null end)") из таблицы meta_tblcolor
        /// </summary>
        /// <param name="tableId">ID таблицы</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        public static Dictionary<string, string> GetColumns(decimal tableId)
        {
            var colorColumns = new Dictionary<string, string>
            {
                {COL_ALL_ALIAS, new ColorRowNameSelector(tableId, ColorType.All).GetSqlExpressionColumn()},
                {FontRowColorNameAlias, new ColorRowNameSelector(tableId, ColorType.FontColor).GetSqlExpression()},
                {BackgroundRowColorNameAlias,new ColorRowNameSelector(tableId, ColorType.BackgroundColor).GetSqlExpression()},
            };

            Dictionary<string, string> notEmptyColorColumns = colorColumns.Where(x => x.Value != null).ToDictionary(x => x.Key, x => x.Value);
            return notEmptyColorColumns;
        }

        /// <summary>
        /// Тип цвета
        /// </summary>
        private enum ColorType
        {
            /// <summary>
            /// Цвет шрифта
            /// </summary>
            FontColor = 1,

            /// <summary>
            /// Цвет фона
            /// </summary>
            BackgroundColor = 2,

            All = 3
        }

        private abstract class ColorSelectorBase
        {
            protected ColorSelectorBase(decimal tableId, ColorType colorType)
            {
                _tableId = tableId;
                _сolorType = colorType;
            }

            private readonly decimal _tableId;
            private readonly ColorType _сolorType;

            protected abstract string SelectCommand { get; }

            /// <summary>
            /// Получить выражение вида условной раскраски "(case when ... else null end)"
            /// </summary>
            /// <exception cref="Exception"></exception>
            /// <returns>Выражение или null, если условная раскраска не описана</returns>
            public string GetSqlExpression()
            {
                var result = new StringBuilder();
                OracleConnection connection = OraConnector.Handler.UserConnection;
                try
                {
                    OracleCommand cmd = connection.CreateCommand();
                    cmd.CommandText = SelectCommand;
                    cmd.Parameters.Add("tabid", _tableId);
                    cmd.Parameters.Add("coloridx", (int)_сolorType);
                    var reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        result.Append(reader[0]);
                    }
                    if (result.ToString() != "")
                    {
                        return string.Format("(case {0} else null end)", result);
                    }
                    return null;
                }
                finally
                {
                    connection.Close();
                }
            }

            public string GetSqlExpressionColumn()
            {
                OracleConnection connection = OraConnector.Handler.UserConnection;
                try
                {
                    List<TBLCOLOR> tblcolors = new List<TBLCOLOR>();

                    OracleCommand cmd = connection.CreateCommand();
                    cmd.CommandText = @"select CONDITION, ORD, COLOR_NAME, COLID, COLOR_INDEX
                                        from meta_tblcolor
                                        where tabid = :tabid AND 
                                        colid is not null";
                    cmd.Parameters.Add("tabid", _tableId);
                    OracleDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        tblcolors.Add(new TBLCOLOR {
                            CONDITION = reader.GetString(0),
                            ORD = reader.GetInt32(1),
                            COLOR_NAME = reader.GetString(2),
                            COLID = reader.GetDecimal(3),
                            COLOR_INDEX = reader.GetInt16(4)
                        });
                    }
                    ////
                    if (tblcolors.Count == 0) { return null; }

                    StringBuilder sbResult = new StringBuilder();
                    for (int i = 0; i < tblcolors.Count; i++)
                    {                        
                        TBLCOLOR c = tblcolors[i];
                        string cond = c.CONDITION.Replace(":", "");
                        string s = string.Format(@"(case when {0} then '{1}' else null end) as {2}__{3}__{4}__{5}", 
                            cond, 
                            c.COLOR_NAME,
                            COL_ALL_ALIAS,
                            c.COLID,
                            c.ORD,
                            c.COLOR_INDEX
                            );
                        sbResult.Append(s);
                        if (i < tblcolors.Count-1) { sbResult.Append(","); }
                    }
                    return sbResult.ToString();
                }
                finally { connection.Close(); }
            }
        }

        /// <summary>
        /// Формирует sql-выражение цвета условной раскраски
        /// </summary>
        class ColorRowNameSelector : ColorSelectorBase
        {
            /// <summary>
            /// Формирует sql-выражение цвета условной раскраски
            /// </summary>
            public ColorRowNameSelector(decimal tableId, ColorType colorType) : base(tableId, colorType) { }

            protected override string SelectCommand
            {
                get { return "SELECT ' when ' || REPLACE (condition, ':', '') || ' then '''|| lower(color_name) ||'''' FROM meta_tblcolor WHERE tabid = :tabid AND COLOR_INDEX = :coloridx AND colid is null ORDER BY META_TBLCOLOR.ORD desc"; }
            }
        }

        /// <summary>
        /// Установить цвет шрифта для строки листа Excel
        /// </summary>
        /// <param name="datadictionary">Источник данных</param>
        /// <param name="worksheet">Лист Excel</param>
        /// <param name="curRow">Номер текущей строки</param>
        /// <param name="columnsTotal">Общее количество колонок</param>
        /// <returns>Есть ли форматирование</returns>
        public static bool PaintFont(Dictionary<string, object> datadictionary, ExcelWorksheet worksheet, int curRow, List<ColumnMetaInfo> Columns)
        {
            //paint rows
            FillPaintRow(datadictionary, worksheet, curRow, Columns, ColorType.FontColor);

            //paint columns
            Dictionary<int, string> colorsColumns = GetColumnColors(datadictionary, ColorType.FontColor);
            FillPaintColumn(worksheet, curRow, ColorType.FontColor, colorsColumns, Columns);

            return true;
        }        

        /// <summary>
        /// Установить цвет фона для строки листа Excel
        /// </summary>
        /// <param name="datadictionary">Источник данных</param>
        /// <param name="worksheet">Лист Excel</param>
        /// <param name="curRow">Номер текущей строки</param>
        /// <param name="columnsTotal">Общее количество колонок</param>
        /// <returns>Есть ли форматирование</returns>
        public static bool PaintBackground(Dictionary<string, object> datadictionary, ExcelWorksheet worksheet, int curRow, List<ColumnMetaInfo> Columns)
        {
            //paint rows
            FillPaintRow(datadictionary, worksheet, curRow, Columns, ColorType.BackgroundColor);

            //paint columns
            Dictionary<int, string> colorsColumns = GetColumnColors(datadictionary, ColorType.BackgroundColor);
            FillPaintColumn(worksheet, curRow, ColorType.BackgroundColor, colorsColumns, Columns);

            return true;
        }

        static void FillPaintColumn(ExcelWorksheet worksheet, int curRow, ColorType typeColor, Dictionary<int, string> colorsColumns, List<ColumnMetaInfo> Columns)
        {
            foreach (KeyValuePair<int, string> colorColumn in colorsColumns)
            {
                if (!string.IsNullOrEmpty(colorColumn.Value))
                {
                    int columnIndex = Columns.FindIndex(item => item.COLID == colorColumn.Key);
                    if(columnIndex != -1)
                    {
                        columnIndex++;      // 1 - start index in xls ,not 0 !
                        using (var range = worksheet.Cells[curRow, columnIndex, curRow, columnIndex])
                        {
                            if (typeColor == ColorType.BackgroundColor)
                            {
                                range.Style.Fill.PatternType = ExcelFillStyle.Solid;
                                range.Style.Fill.BackgroundColor.SetColor(FormatConverter.CenturaColorToExcelColor(colorColumn.Value));
                            }
                            else
                            {
                                range.Style.Font.Color.SetColor(FormatConverter.CenturaColorToExcelColor(colorColumn.Value));
                            }
                        }
                    }
                }
            }
        }

        static void FillPaintRow(Dictionary<string, object> datadictionary, ExcelWorksheet worksheet, int curRow, List<ColumnMetaInfo> Columns, ColorType typeColor)
        {
            string alias = typeColor == ColorType.BackgroundColor ? BackgroundRowColorNameAlias : FontRowColorNameAlias;

            bool hasColorRow = datadictionary.Keys.Contains(alias.ToUpper());
            if (hasColorRow)
            {
                object dbBackgruondColor = datadictionary[alias.ToUpper()];
                if (!DBNull.Value.Equals(dbBackgruondColor))
                {
                    string bgColor = (string)dbBackgruondColor;
                    if (!string.IsNullOrEmpty(bgColor))
                    {
                        int columnsTotal = Columns.Count();
                        using (var range = worksheet.Cells[curRow, 1, curRow, columnsTotal])
                        {
                            if (typeColor == ColorType.BackgroundColor)
                            {
                                range.Style.Fill.PatternType = ExcelFillStyle.Solid;
                                range.Style.Fill.BackgroundColor.SetColor(FormatConverter.CenturaColorToExcelColor(bgColor));
                            }
                            else
                            {
                                range.Style.Font.Color.SetColor(FormatConverter.CenturaColorToExcelColor(bgColor));
                            }
                        }
                    }
                }
            }
        }

        static Dictionary<int, string> GetColumnColors(Dictionary<string, object> datadictionary, ColorType typeColor)
        {
            Dictionary<int, string> color = new Dictionary<int, string>();
            Dictionary<int, List<TBLCOLOR>> colors = new Dictionary<int, List<TBLCOLOR>>();     // with all orders
            string[] sep = { "__" };
            foreach (KeyValuePair<string, object> d in datadictionary)
            {
                if (d.Key.IndexOf(COL_ALL_ALIAS) != -1)
                {
                    string[] elems = d.Key.Split(sep, StringSplitOptions.None);

                    ColorType ColorType = (ColorType)Convert.ToInt32(elems[3]);
                    if (ColorType == typeColor)
                    {
                        int colid = Convert.ToInt32(elems[1]);
                        if (!colors.ContainsKey(colid))
                        {
                            colors[colid] = new List<TBLCOLOR>();
                        }
                        string colorName = d.Value.ToString();
                        if (!string.IsNullOrEmpty(colorName))
                        {
                            int order = Convert.ToInt32(elems[2]);
                            colors[colid].Add(new TBLCOLOR { ORD = order, COLOR_NAME = colorName });
                        }
                    }
                }
            }
            foreach (KeyValuePair<int, List<TBLCOLOR>> c in colors)
            {
                var sorted = c.Value.OrderByDescending(item => item.ORD);
                TBLCOLOR elem = sorted.FirstOrDefault();
                color.Add(c.Key, elem != null ? elem.COLOR_NAME : null);
            }

            return color;
        }
    }
}