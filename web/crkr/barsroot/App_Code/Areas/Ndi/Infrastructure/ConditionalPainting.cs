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
    /// <summary>
    /// Формирование sql-выражения условной раскраски (данные берем из таблицы meta_tblcolor)
    /// </summary>
    internal class ConditionalPainting
    {
        /// <summary>
        /// Алиас колонки "цвет шрифта"
        /// </summary>
        private const string FontColorNameAlias = "font_color_name";

        /// <summary>
        /// Алиас колонки "цвет фона"
        /// </summary>
        private const string BackgroundColorNameAlias = "bg_color_name";

        /// <summary>
        /// Алиас колонки "границы закраски шрифта"
        /// </summary>
        private const string FontColorBoundsAlias = "font_color_colidx";

        /// <summary>
        /// Алиас колонки "границы закраски фона"
        /// </summary>
        private const string BackgroundColorBoundsAlias = "bg_color_colidx";

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
                {FontColorNameAlias, (new ColorNameSelector(tableId, ColorType.FontColor)).GetSqlExpression()},
                {BackgroundColorNameAlias,(new ColorNameSelector(tableId, ColorType.BackgroundColor)).GetSqlExpression()},
                {FontColorBoundsAlias,(new ColorBoundsSelector(tableId, ColorType.FontColor)).GetSqlExpression()},
                {BackgroundColorBoundsAlias,(new ColorBoundsSelector(tableId, ColorType.BackgroundColor)).GetSqlExpression()}
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
            BackgroundColor = 2
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
        }

        /// <summary>
        /// Формирует sql-выражение цвета условной раскраски
        /// </summary>
        private class ColorNameSelector : ColorSelectorBase
        {
            /// <summary>
            /// Формирует sql-выражение цвета условной раскраски
            /// </summary>
            public ColorNameSelector(decimal tableId, ColorType colorType) : base(tableId, colorType) { }

            protected override string SelectCommand
            {
                get { return "SELECT ' when ' || REPLACE (condition, ':', '') || ' then '''|| lower(color_name) ||'''' FROM meta_tblcolor WHERE tabid = :tabid AND COLOR_INDEX = :coloridx ORDER BY META_TBLCOLOR.ORD"; }
            }
        }

        /// <summary>
        /// Формирует sql-выражение границ условной раскраски
        /// </summary>
        private class ColorBoundsSelector : ColorSelectorBase
        {
            /// <summary>
            /// Формирует sql-выражение границ условной раскраски
            /// </summary>
            public ColorBoundsSelector(decimal tableId, ColorType colorType) : base(tableId, colorType) { }

            protected override string SelectCommand
            {
                get { return "SELECT ' when ' || REPLACE (condition, ':', '') || ' then ' || colid  FROM meta_tblcolor WHERE tabid = :tabid AND COLOR_INDEX = :coloridx and colid is not null ORDER BY META_TBLCOLOR.ORD"; }
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
            int columnsTotal;
            Dictionary<string, object> tempDict;
            bool hasColorColumn = datadictionary.Keys.Contains(FontColorNameAlias.ToUpper());
            if (hasColorColumn)
            {
                tempDict = new Dictionary<string, object>();
                columnsTotal = Columns.Count();
                tempDict = Columns.Select(x => x.COLNAME).ToDictionary(col => col, col => datadictionary[col]);
                object dbFontColor = datadictionary[FontColorNameAlias.ToUpper()];
                if (!DBNull.Value.Equals(dbFontColor))
                {
                    var fontColor = (string)dbFontColor;

                    if (!string.IsNullOrEmpty(fontColor))
                    {
                        int fromColumn;
                        int toColumn;
                        int ColorColumnId = 0;
                        int columnPosition = 0;
                        if (datadictionary.Keys.Contains(FontColorBoundsAlias.ToUpper()))
                        {
                            object FontColorIndex = datadictionary[FontColorBoundsAlias.ToUpper()];

                            if (!DBNull.Value.Equals(FontColorIndex))
                            {
                                ColorColumnId = Convert.ToInt32(FontColorIndex);
                                string columnName = Columns.FirstOrDefault(x => x.COLID == ColorColumnId).COLNAME;
                                for (int i = 0; i < tempDict.Keys.Count; i++)
                                {
                                    if (tempDict.Keys.ToArray()[i] == columnName)
                                        columnPosition = i + 1;
                                }
                            }

                        }

                        if (ColorColumnId <= 0)
                        {
                            fromColumn = 1;
                            toColumn = columnsTotal;
                        }
                        else
                        {
                            fromColumn = columnPosition;
                            toColumn = columnPosition;
                        }
                        using (var range = worksheet.Cells[curRow, fromColumn, curRow, toColumn])
                        {
                            //Style.Font.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Red);
                            range.Style.Font.Color.SetColor(FormatConverter.CenturaColorToExcelColor(fontColor));
                        }
                    }
                }
            }
            return hasColorColumn;
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
            int columnsTotal;
            Dictionary<string, object> tempDict;
            bool hasColorColumn = datadictionary.Keys.Contains(BackgroundColorNameAlias.ToUpper());
            if (hasColorColumn)
            {
                tempDict = new Dictionary<string, object>();
                columnsTotal = Columns.Count();
                tempDict = Columns.Select(x => x.COLNAME).ToDictionary(col => col, col => datadictionary[col]);
                object dbBackgruondColor = datadictionary[BackgroundColorNameAlias.ToUpper()];
                if (!DBNull.Value.Equals(dbBackgruondColor))
                {
                    var bgColor = (string)dbBackgruondColor;

                    if (!string.IsNullOrEmpty(bgColor))
                    {
                        int fromColumn;
                        int toColumn;
                        int ColorColumnId = 0;
                        int columnPosition = 0;
                        if (datadictionary.Keys.Contains(BackgroundColorBoundsAlias.ToUpper()))
                        {
                            object dbBackgroundColorIndex = datadictionary[BackgroundColorBoundsAlias.ToUpper()];

                            if (!DBNull.Value.Equals(dbBackgroundColorIndex))
                            {
                                ColorColumnId = Convert.ToInt32(dbBackgroundColorIndex);
                                string columnName = Columns.FirstOrDefault(x => x.COLID == ColorColumnId).COLNAME;
                                for (int i = 0; i < tempDict.Keys.Count; i++)
                                {
                                    if (tempDict.Keys.ToArray()[i] == columnName)
                                        columnPosition = i + 1;
                                }
                            }

                        }

                        if (ColorColumnId <= 0)
                        {
                            fromColumn = 1;
                            toColumn = columnsTotal;
                        }
                        else
                        {
                            fromColumn = columnPosition;
                            toColumn = columnPosition;
                        }

                        using (var range = worksheet.Cells[curRow, fromColumn, curRow, toColumn])
                        {
                            range.Style.Fill.PatternType = ExcelFillStyle.Solid;
                            range.Style.Fill.BackgroundColor.SetColor(FormatConverter.CenturaColorToExcelColor(bgColor));
                        }
                    }
                }
            }
            return hasColorColumn;
        }
    }
}