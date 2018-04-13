using System;
using System.Collections.Generic;
using System.Web.Mvc;
using BarsWeb.Models;

namespace BarsWeb.HtmlHelpers
{
    /// <summary>
    /// Сводное описание для HtmlHelpers
    /// </summary>
    public class HtmlHelpers
    {
        public class TableColumn
        {
            public string ColumnName { get; set; }
            public string ColumnDb { get; set; }
            public TypeCode ColumnType { get; set; }
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
        /// <param name="capTableDivClass">ім"я класа для шапки таблиці</param>
        /// <param name="captionName"></param>
        /// <param name="theadRowClass">ім"я класа для строки з назвами колонок</param>
        /// <param name="funcOrderBy"></param>
        /// <param name="tableContent">HTML код строк таблиці (позмовчуванню таблиця пуста)</param>
        /// <param name="capTableCotrolBtn">рваний масив додаткових кнопок в шапкі таблиці,
        /// передаються всі потрібні параметри для тега img</param>
        /// <param name="columns">список колонок для побулови таблиці</param>
        /// <returns>побудована HTML таблиця</returns>
        [Obsolete]
        public static MvcHtmlString CreateTable(string[,] columnName = null,
                                         string[,] capTableBtn = null,
                                         string preTableDivClass = "jung-grid",
                                         string preTableDivId = "table",
                                         string tableId = "",
                                         string tableClass = "jungGridView",
                                         string capTableDivClass = "captionBody",
                                         string captionName = "",
                                         string theadRowClass = "headerRow",
                                         string funcOrderBy = "orderByTable(this);",
                                         string tableContent = "",
                                         string[][,] capTableCotrolBtn=null,
                                         List<TableColumn> columns=null)
        {
            var preDivBild = new TagBuilder("div"); //div в який буде поміщено таблицю
            preDivBild.AddCssClass(preTableDivClass);    //додаємо css клас для div
            preDivBild.MergeAttribute("id", preTableDivId);//додаємо ід головному діву
            //TagBuilder capTabte = new TagBuilder("div"); 
            //capTabte.AddCssClass(capTableDivClass);      

            var caption = new TagBuilder("caption");//div шапки для таблиці
            caption.AddCssClass(capTableDivClass);         //додаємо css клас для div
            
            for (int i = 0; i < capTableBtn.GetLength(0); i++)
            {
                var img = new TagBuilder("img");
                var a =new TagBuilder("a");
                switch (capTableBtn[i, 0].ToString())
                {
                    case "rfr":                                        //якщо текст назви = checkbox вставляємо input
                        a.MergeAttribute("herf","#");
                        a.MergeAttribute("title","Перечитати данні");
                        a.MergeAttribute("name","btRefresh");
                        a.MergeAttribute("onclick","return false;");
                        a.AddCssClass("button");
                        a.InnerHtml="<span class=\"icon navigateRefresh\"></span>";
                        if (columnName[i, 1].ToString() != "") {
                            a.MergeAttribute("onclick", capTableBtn[i, 1].ToString()+"return false;");
                        }
                        caption.InnerHtml += a.ToString();
                        /*
                        img.MergeAttribute("src", "/common/images/default/16/refresh.png");
                        img.MergeAttribute("alt", "Перечитати данi");
                        img.MergeAttribute("name", "refresh");
                        if (columnName[i, 1].ToString() != "") {
                            img.MergeAttribute("onclick", capTableBtn[i, 1].ToString());
                        }*/
                        break;
                    case "xls":                                        //якщо текст назви = checkbox вставляємо input
                        img.MergeAttribute("src", "/common/images/default/16/export_excel.png");
                        img.MergeAttribute("alt", "Експорт в Excel");
                        if (columnName[i, 1].ToString() != "") {
                            img.MergeAttribute("onclick", capTableBtn[i, 1].ToString());
                        }
                        else {
                            img.MergeAttribute("onclick", "exportToExcel();");                            
                        }
                        caption.InnerHtml += img.ToString();
                        break;
                    case "prn":                                        
                        img.MergeAttribute("src", "/common/images/default/16/print.png");
                        img.MergeAttribute("alt", "Друк відмічених документів");
                        if (columnName[i, 1].ToString() != "") {
                            img.MergeAttribute("onclick", capTableBtn[i, 1].ToString());
                        }
                        else {
                            img.MergeAttribute("onclick", "print();");                            
                        }
                        caption.InnerHtml += img.ToString();
                        break;
                    default:
                        caption.SetInnerText(columnName[i, 0]);                   
                        break;
                }
                
                
            }

            if (capTableCotrolBtn != null) {
                foreach (var item in capTableCotrolBtn)
                {
                    var img = new TagBuilder("img");
                    for (int i = 0; i < item.GetLength(0); i++)
                    {
                        img.MergeAttribute(item[i,0], item[i,1]);
                    }
                    caption.InnerHtml += img.ToString();
                }
            }

            var captionText = new TagBuilder("div");

            captionText.SetInnerText(captionName);
            caption.InnerHtml += captionText.ToString();

            var table = new TagBuilder("table");  //головна таблиця
            table.MergeAttribute("id", tableId);
            table.AddCssClass(tableClass);               //css головної таблиці
            table.MergeAttribute("cellpadding", "0");    //
            table.MergeAttribute("cellspacing", "0");    //додаткові атрибути для таблиці
            table.MergeAttribute("border", "0");         //
            var thead = new TagBuilder("thead");  //шапка таблиці з назвами колонок
            var tbody = new TagBuilder("tbody");  //тіло таблиці
            var theadRow = new TagBuilder("tr");  //рядок з назвами колонок
            theadRow.AddCssClass(theadRowClass);         //сласс рядка з назвами колонок
            for (int i = 0; i < columnName.GetLength(0); i++)
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
            }


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
        /// <summary>
        /// построение нового html-тега SELECT 
        /// </summary>
        /// <param name="option">список для option</param>
        /// <returns></returns>
        public static MvcHtmlString CreateDropDownList(string[,] optionList=null ,
                                                       string optionSelected="",
                                                       string[,] attr=null,
                                                       bool nullFirstRow = false)
        {
            var select = new TagBuilder("select");
            if (attr != null)
            {
                for (int i = 0; i < attr.GetLength(0); i++)
                {
                    select.MergeAttribute(attr[i,0],attr[i,1]);
                }
            }
            if (nullFirstRow)
            {
                var option = new TagBuilder("option");
                option.MergeAttribute("value", "");
                select.InnerHtml += option.ToString();
            }
            for (int i = 0; i < optionList.GetLength(0); i++)
            {
                var option = new TagBuilder("option");
                if (optionList[i,0]==optionSelected)
                {
                    option.MergeAttribute("selected", "selected");
                }
                option.InnerHtml=optionList[i,1];
                select.InnerHtml += option.ToString();
            }
            return new MvcHtmlString(select.ToString());
        }        
        /// <summary>
        /// построение нового html-тега SELECT 
        /// </summary>
        /// <param name="option">список для option</param>
        /// <returns></returns>
        public static MvcHtmlString CreateDropDownList(List<string> optionList ,
                                                       string optionSelected="",
                                                       string[,] attr=null,
                                                       bool nullFirstRow = false)

        {
            var select = new TagBuilder("select");
            if (attr != null)
            {
                for (int i = 0; i < attr.GetLength(0); i++)
                {
                    select.MergeAttribute(attr[i,0],attr[i,1]);
                }
            }
            if (nullFirstRow)
            {
                var option = new TagBuilder("option");
                select.InnerHtml += option.ToString();
            }
            foreach (var item in optionList)
            {
                var option = new TagBuilder("option");
                if (item==optionSelected)
                {
                    option.MergeAttribute("selected", "selected");
                }
                option.InnerHtml=item;
                select.InnerHtml += option.ToString();
            }
            return new MvcHtmlString(select.ToString());
        }
        /// <summary>
        /// построение нового html-тега SELECT по сущьности Handbook
        /// </summary>
        /// <param name="option">список для option</param>
        /// <returns></returns>
        public static MvcHtmlString CreateDropDownList(List<Handbook> optionList=null, 
                                                       string optionSelected=null,
                                                       string[,] attr = null,
                                                       bool nullFirstRow=false)
        {
            var select = new TagBuilder("select");
            if (attr != null)
            {
                for (int i = 0; i < attr.GetLength(0); i++)
                {
                    select.MergeAttribute(attr[i, 0], attr[i, 1]);
                }
            }
            if (nullFirstRow) { 
                var option = new TagBuilder("option");
                option.MergeAttribute("value", "");
                select.InnerHtml += option.ToString();
            }
            if (optionList != null)
            {
                foreach (var item in optionList)
                {
                    var option = new TagBuilder("option");
                    if (optionSelected != null)
                    {
                        if (item.ID == optionSelected)
                        {
                            option.MergeAttribute("selected", "selected");
                        }
                    }
                    option.MergeAttribute("value", Convert.ToString(item.ID));
                    option.InnerHtml = item.NAME;
                    select.InnerHtml += option.ToString();
                }
            }
            return new MvcHtmlString(select.ToString());
        }

        public static MvcHtmlString Pager(decimal count, 
                                          decimal pageNum = 1,
                                          decimal pageSize = 20,
                                          decimal displaedPager = 5,
                                          string funcOnClick="")
        {

            if (count > pageSize)
            {
                decimal pageCount = decimal.Floor(count/pageSize);
                if (count/pageSize != decimal.Floor(count/pageSize))
                {
                    pageCount++;
                }
                decimal dislayPageDelta = decimal.Floor(displaedPager/2);
                decimal startDisplayPage = (pageNum - dislayPageDelta) < 1 ? 1 : (pageNum - dislayPageDelta);
                decimal endDisplayPage = (startDisplayPage + displaedPager - 1) < pageCount?(startDisplayPage + displaedPager-1):pageCount;

                var navigatePager = new TagBuilder("div");
                navigatePager.AddCssClass("navigate-pager");
                if (pageNum > 1)
                {
                    string pagePrevNum = Convert.ToString(pageNum - 1);
                    var navPrev = new TagBuilder("div");
                    navPrev.AddCssClass("pager nav-prev");
                    var lincNavPrev = new TagBuilder("a");
                    lincNavPrev.MergeAttribute("href", "?pagenum=" + pagePrevNum);
                    lincNavPrev.MergeAttribute("data-pagenum", pagePrevNum);
                    lincNavPrev.MergeAttribute("onclick", funcOnClick);
                    lincNavPrev.SetInnerText("<");
                    navPrev.InnerHtml += lincNavPrev.ToString();
                    navigatePager.InnerHtml += navPrev.ToString();
                }
                if (startDisplayPage > 1)
                {
                    var navPage = new TagBuilder("div");
                    navPage.AddCssClass("pager nav-page");
                    var lincNavPage = new TagBuilder("a");
                    lincNavPage.MergeAttribute("href", "?pagenum=" + 1);
                    lincNavPage.MergeAttribute("data-pagenum", Convert.ToString(1));
                    lincNavPage.MergeAttribute("onclick", funcOnClick);
                    lincNavPage.SetInnerText(Convert.ToString(1));
                    navPage.InnerHtml += lincNavPage.ToString();
                    navigatePager.InnerHtml += navPage.ToString();
                    if (startDisplayPage > 2)
                    {
                        var navPagePoint = new TagBuilder("div");
                        navPagePoint.AddCssClass("pager nav-page");
                        var lincNavPagePoint = new TagBuilder("a");
                        lincNavPagePoint.MergeAttribute("href", "?pagenum=" + (startDisplayPage - 1));
                        lincNavPagePoint.MergeAttribute("title", Convert.ToString(startDisplayPage - 1));
                        lincNavPagePoint.MergeAttribute("data-pagenum", Convert.ToString(startDisplayPage - 1));
                        lincNavPagePoint.MergeAttribute("onclick", funcOnClick);
                        lincNavPagePoint.SetInnerText("...");
                        navPagePoint.InnerHtml += lincNavPagePoint.ToString();
                        navigatePager.InnerHtml += navPagePoint.ToString();
                    }
                }
                for (decimal i = (startDisplayPage); i <= endDisplayPage; i++)
                {
                    var navPage = new TagBuilder("div");
                    if (i == pageNum)
                    {
                        navPage.AddCssClass("pager nav-curent");
                        navPage.SetInnerText(Convert.ToString(i));
                    }
                    else
                    {
                        navPage.AddCssClass("pager nav-page");
                        var lincNavPage = new TagBuilder("a");
                        lincNavPage.MergeAttribute("href", "?pagenum=" + i);
                        lincNavPage.MergeAttribute("data-pagenum", Convert.ToString(i));
                        lincNavPage.MergeAttribute("onclick", funcOnClick);
                        lincNavPage.SetInnerText(Convert.ToString(i));
                        navPage.InnerHtml += lincNavPage.ToString();
                    }
                    navigatePager.InnerHtml += navPage.ToString();
                }
                if (endDisplayPage < pageCount)
                {
                    if (endDisplayPage < pageCount - 1)
                    {
                        var navPagePoint = new TagBuilder("div");
                        navPagePoint.AddCssClass("pager nav-page");
                        var lincNavPagePoint = new TagBuilder("a");
                        lincNavPagePoint.MergeAttribute("href", "?pagenum=" + (endDisplayPage + 1));
                        lincNavPagePoint.MergeAttribute("title", Convert.ToString(endDisplayPage + 1));
                        lincNavPagePoint.MergeAttribute("data-pagenum", Convert.ToString(endDisplayPage + 1));
                        lincNavPagePoint.MergeAttribute("onclick", funcOnClick);
                        lincNavPagePoint.SetInnerText("...");
                        navPagePoint.InnerHtml += lincNavPagePoint.ToString();
                        navigatePager.InnerHtml += navPagePoint.ToString();
                    }
                    var navPage = new TagBuilder("div");
                    navPage.AddCssClass("pager nav-page");
                    var lincNavPage = new TagBuilder("a");
                    lincNavPage.MergeAttribute("href", "?pagenum=" + pageCount);
                    lincNavPage.MergeAttribute("data-pagenum", Convert.ToString(pageCount));
                    lincNavPage.MergeAttribute("onclick", funcOnClick);
                    lincNavPage.SetInnerText(Convert.ToString(pageCount));
                    navPage.InnerHtml += lincNavPage.ToString();
                    navigatePager.InnerHtml += navPage.ToString();
                }
                if (pageNum < pageCount)
                {
                    string pageNextNum = Convert.ToString(pageNum + 1);
                    var navNext = new TagBuilder("div");
                    navNext.AddCssClass("pager nav-next");
                    var lincNavNext = new TagBuilder("a");
                    lincNavNext.MergeAttribute("href", "?pagenum=" + pageNextNum);
                    lincNavNext.MergeAttribute("data-pagenum", pageNextNum);
                    lincNavNext.MergeAttribute("onclick", funcOnClick);
                    lincNavNext.SetInnerText(">");
                    navNext.InnerHtml += lincNavNext.ToString();
                    navigatePager.InnerHtml += navNext.ToString();
                }
                return new MvcHtmlString(navigatePager.ToString());
            }
            return new MvcHtmlString("");
        }
    }

}