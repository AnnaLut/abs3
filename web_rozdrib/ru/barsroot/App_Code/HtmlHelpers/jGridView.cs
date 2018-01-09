using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace BarsWeb.HtmlHelpers
{
    public class myTest
    {
        public void trst()
        {
            //var t1 = new JGridView();
            //t1.Columns.Add(new JGridView.Column{Name = "test",NameInDb = "test",Type = TypeCode.String});
        }
    }
    /// <summary>
    /// Сводное описание для JGrigView
    /// </summary>
    public class JGridView
    {
        static List<Column> _columns;
        public JGridView(List<Column> columns = null )
        {
            _columns = columns ?? new List<Column>();
        }

        public static class Columns
        {
            public static Column Add(string name,string nameInDb,TypeCode type)
            {
                var test = new Column {Name = name, NameInDb = nameInDb, Type = type};
                return test;
            }
            //return new List<Column>();
        }

        private static string ConvertTypeToString(TypeCode type)
        {
            string result = "string";
            switch (type)
            {
                case TypeCode.String:
                    result = "string";
                    break;
                case TypeCode.Decimal:
                    result = "decimal";
                    break;
                case TypeCode.DateTime:
                    result= "date";
                    break;
            }
            return result;
        }

        /// <summary>
        /// Конвертуємо інт в умову 
        /// </summary>
        /// <param name="operand">інтовське значення від 1 до 14</param>
        /// <returns></returns>
        public static string ConvertIntToClause(int operand)
        {
            string result;
            switch (operand)
            {
                case 1:
                    result = "=";
                    break;
                case 2:
                    result = "<";
                    break;
                case 3:
                    result = ">";
                    break;
                case 4:
                    result = "<=";
                    break;
                case 5:
                    result = ">=";
                    break;
                case 6:
                    result = "<>";
                    break;
                case 7:
                    result = "IS NULL";
                    break;
                case 8:
                    result = "IS NOT NULL";
                    break;
                case 9:
                    result = "LIKE";
                    break;
                case 10:
                    result = "NOT LIKE";
                    break;
                case 11:
                    result = "IN";
                    break;
                case 12:
                    result = "NOT IN";
                    break;
                default:
                    result = "";
                    break;
            }
            return result;
        }
        /// <summary>
        /// Функція конвертує фільтр з URL в строку WHERE для запроса в БД
        /// </summary>
        /// <param name="urlFilter">строка в форматі "NAME-coL-N-coL-value-roW-" (де NAME-ім"я колонки;N-тип порівняння;value-строка порівняння)</param>
        /// <returns>повертає строку для підстановки в WHERE прим запросі в БД</returns>
        public static string ConvertJgFilterToBaseFilter(string urlFilter)
        {
            string result = "";
            if (!string.IsNullOrWhiteSpace(urlFilter))
            {
                string[] count = urlFilter.Split(new[] { "-roW-" }, StringSplitOptions.RemoveEmptyEntries);
                foreach (var s in count)
                {
                    string[] row = s.Split(new[] { "-coL-" }, StringSplitOptions.None/*.RemoveEmptyEntries*/);

                    if (row[1] == "7" || row[1] == "8")
                    {
                        row[2] = "";
                    }
                    if (row[1] == "9" || row[1] == "10")
                    {
                        row[0] = "upper(" + row[0] + ")"; 
                        row[2] = "'" + row[2].Replace("*", "%").ToUpper() + "'";
                    }
                    if (row[1] == "11" || row[1] == "12")
                    {
                        row[2] = (row[2].Substring(0, 1) != "(" ? "(" : "") + row[2];
                        row[2] = row[2] + (row[2].Substring(row[2].Length - 1, 1) != ")" ? ")" : "");
                    }
                    if (row[1] != "7" && row[1] != "8" && row[1] != "9" && row[1] != "10")
                    {
                        switch (row[3])
                        {
                            case "string":
                                row[2] = "'" + row[2] + "'";
                                break;
                            case "date":
                                row[2] = "to_date('" + row[2] + "','dd/mm/yyyy')";
                                break;
                            case "decimal":
                                row[2] = row[2].Replace(" ", "").Replace(",","").Replace(".","");
                                break;
                        }
                    }
                    result += string.IsNullOrWhiteSpace(result) ? "" : " and ";
                    result += " " + row[0] + " " + ConvertIntToClause(Convert.ToInt32(row[1])) + " " + row[2] + " ";
                }
            }
            else
            {
                result = "";
            }
            return result;
        }

        /// <summary>
        /// хелпер таблички jungGridView
        /// </summary>
        /// <param name="columnName">двухмірний масив з назвами колонок і параметром для сортування</param>
        /// <param name="capTableBtn">масив з набором стандартних кнопок і назвою функції для onclick якщо потрібно
        /// (rfr - кнопка рефреш, xls-вигрузка в xls, prn - друк)</param>
        /// <param name="preTableDivClass">ім"я класа для DIV в який буде обгорнута таблиця</param>
        /// <param name="preTableDivId">id для DIV в який буде обгорнута таблиця</param>
        /// <param name="tableId">id таблиці</param>
        /// <param name="tableClass">ім"я класа для таблиці</param>
        /// <param name="tableCssStyle">Css стиль для таблиці</param>
        /// <param name="capTableDivClass">ім"я класа для шапки таблиці</param>
        /// <param name="captionName"></param>
        /// <param name="theadRowClass">ім"я класа для строки з назвами колонок</param>
        /// <param name="funcOrderBy"></param>
        /// <param name="tableContent">HTML код строк таблиці (позмовчуванню таблиця пуста)</param>
        /// <param name="capTableCotrolBtn">рваний масив додаткових кнопок в шапкі таблиці,
        /// передаються всі потрібні параметри для тега img</param>
        /// <param name="columns">список колонок для побулови таблиці</param>
        /// <param name="defaultFilter">фільтр позмовчуванню </param> //todo:використовується лише в напрямках фінансування, ПЕРЕРОБИТЬ на параметр для кожного стовпця.
        /// <returns>побудована HTML таблиця</returns>
        public static MvcHtmlString Create(List<Column> columns=null,
                                         string[,] capTableBtn = null,
                                         string preTableDivClass = "jung-grid",
                                         //string preTableDivId = "table",
                                         string tableId = "",
                                         string tableClass = "jungGridView",
                                         string tableCssStyle = "",
                                         string capTableDivClass = "captionBody",
                                         string captionName = "",
                                         string theadRowClass = "headerRow",
                                         string funcOrderBy = "orderByTable(this);",
                                         string tableContent = "",
                                         string[][,] capTableCotrolBtn=null,
                                         string defaultFilter=""
                                         )
        {
            columns = columns ?? _columns;
            var preDivBild = new TagBuilder("div"); //div в який буде поміщено таблицю
            preDivBild.AddCssClass(preTableDivClass);    //додаємо css клас для div
            //preDivBild.AddCssClass(preTableDivClass);//додаємо клас головному діву
            //TagBuilder capTabte = new TagBuilder("div"); 
            //capTabte.AddCssClass(capTableDivClass);      

            var caption = new TagBuilder("caption");//div шапки для таблиці
            caption.AddCssClass(capTableDivClass);         //додаємо css клас для div
            
            var captionText = new TagBuilder("div");

            captionText.SetInnerText(captionName);
            caption.InnerHtml += captionText.ToString();

            var table = new TagBuilder("table");  //головна таблиця
            //todo: переробить для кожного стовпця
            table.MergeAttribute("data-defaultfilter", defaultFilter);

            table.MergeAttribute("style", tableCssStyle); //додаткові стилі для таблиці, наприклад width 
            table.MergeAttribute("id", tableId);
            table.AddCssClass(tableClass);               //css головної таблиці
            table.MergeAttribute("cellpadding", "0");    //
            table.MergeAttribute("cellspacing", "0");    //додаткові атрибути для таблиці
            table.MergeAttribute("border", "0");         //
            var thead = new TagBuilder("thead");  //шапка таблиці з назвами колонок
            var tbody = new TagBuilder("tbody");  //тіло таблиці
            var theadRow = new TagBuilder("tr");  //рядок з назвами колонок
            theadRow.AddCssClass(theadRowClass);         //сласс рядка з назвами колонок
            foreach (var i in columns)
            {
                var th = new TagBuilder("th");
                var thDiv = new TagBuilder("div");
                var thDivSpan = new TagBuilder("span");
                if (i.Name == "checkbox")
                {
                    th.InnerHtml += "<input type=\"checkbox\" />";
                }
                else
                {
                        thDivSpan.SetInnerText(i.Name+"  ");            //в thDivSpan вставляємо текст назви стовбця
                        thDiv.InnerHtml+=thDivSpan.ToString();
                        if (!string.IsNullOrWhiteSpace(i.NameInDb))
                        {
                            thDiv.MergeAttribute("data-sort", i.NameInDb);
                            thDiv.MergeAttribute("data-sortdir", "ASC");
                            thDiv.MergeAttribute("data-type", ConvertTypeToString(i.Type));
                        }                        
                        th.InnerHtml+=thDiv.ToString();  
                }
                theadRow.InnerHtml += th.ToString();
            }

            /*for (int i = 0; i < columnName.GetLength(0); i++)
            {
                var th = new TagBuilder("th");
                var thDiv = new TagBuilder("div");
                var thDivSpan = new TagBuilder("span");
                switch (columnName[i, 0].ToString())
                {
                    case "checkbox":                                        //якщо текст назви = checkbox вставляємо input
                        th.InnerHtml += "<input type=\"checkbox\" />";
                        break;
                    default:
                        thDivSpan.SetInnerText(columnName[i, 0]+"  ");            //в thDivSpan вставляємо текст назви стовбця
                        thDiv.InnerHtml+=thDivSpan.ToString();
                        if (columnName[i, 1].ToString() != "")
                        {
                            thDiv.MergeAttribute("data-sort", columnName[i, 1].ToString());
                            thDiv.MergeAttribute("data-sortdir", "ASC");
                            //thDiv.MergeAttribute("onclick", funcOrderBy);
                        }                        
                        th.InnerHtml+=thDiv.ToString();                   
                        break;
                }

                theadRow.InnerHtml += th.ToString();                        //вставляемо th в рядок з назвами колонок 
            }*/


            thead.InnerHtml += theadRow.ToString();        //в шапку таблиці вставляемо заголовки стовбців
            table.InnerHtml += caption.ToString();
            table.InnerHtml += thead.ToString();           //вставляемо шапку в таблицю
            tbody.InnerHtml += tableContent;               //вставить вхідний контент в тіло таблиці
            table.InnerHtml += tbody.ToString();         //вставляємо тіло таблиці
            var tfoot = new TagBuilder("tfoot") {InnerHtml = "<tr><td></td></tr>"};
            table.InnerHtml += tfoot.ToString();
            //preDivBild.InnerHtml += capTabte.ToString(); //вставляемо шапку таблиці в головний div
            preDivBild.InnerHtml += table.ToString();    //вставляємо головну таблицю в головний дів

            return new MvcHtmlString(preDivBild.ToString());
        }  

        #region Классы

        public class Column
        {
            public string Name { get; set; }
            public string NameInDb { get; set; }
            public TypeCode Type { get; set; }
        }

        public class QueryParam
        {
            private string _gridFilter;
            private int? _pageNum = 1;
            private int? _pageSize = 10;
            private string _sort = "1";
            private string _sortDir = "ASC";

            public int? PageNum
            {
                get { return _pageNum; }
                set { _pageNum = value??_pageNum; }
            }
            public int? PageSize
            {
                get { return _pageSize; }
                set { _pageSize = value ?? _pageSize; }
            }

            public string Sort
            {
                get { return _sort; }
                set { _sort = value ?? _sort; }
            }

            public string SortDir
            {
                get { return _sortDir; }
                set { _sortDir = value ?? _sortDir; }
            }

            public string Filter
            {
                get
                {
                    return ConvertJgFilterToBaseFilter(_gridFilter);
                }
                set
                {
                    _gridFilter = value;
                }
            }
        }

        public class Param
        {
            public string ColumnName { get; set; }
            public decimal Clause { get; set; }
            public string Value { get; set; }
            public string Type { get; set; }
        }
        #endregion
    }

}