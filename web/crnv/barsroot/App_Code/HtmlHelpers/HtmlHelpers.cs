using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using barsroot.Models;


namespace barsroot
{
    /// <summary>
    /// Сводное описание для HtmlHelpers
    /// </summary>
    public class HtmlHelpers
    {
        /// <summary>
        /// хелпер таблички jungGridView
        /// </summary>
        /// <param name="columnName">двухмірний масив з назвами колонок і параметром для сортування</param>
        /// <param name="capTableBtn">масив з набором стандартних кнопок і назвою функції для onclick якщо потрібно
        /// (rfr - кнопка рефреш, xls-вигрузка в xls, prn - друк)</param>
        /// <param name="preTableDivClass">ім"я класа для DIV в який буде обгорнута таблиця</param>
        /// <param name="preTableDivId">id для DIV в який буде обгорнута таблиця</param>
        /// <param name="tableClass">ім"я класа для таблиці</param>
        /// <param name="capTableDivClass">ім"я класа для шапки таблиці</param>
        /// <param name="captionName"></param>
        /// <param name="theadRowClass">ім"я класа для строки з назвами колонок</param>
        /// <param name="funcOrderBy"></param>
        /// <param name="tableContent">HTML код строк таблиці (позмовчуванню таблиця пуста)</param>
        /// <param name="capTableCotrolBtn">рваний масив додаткових кнопок в шапкі таблиці,
        /// передаються всі потрібні параметри для тега img</param>
        /// <returns>побудована HTML таблиця</returns>
        public static MvcHtmlString CreateTable(string[,] columnName,
                                         string[,] capTableBtn,
                                         string preTableDivClass = "preTableDiv",
                                         string preTableDivId = "table",
                                         string tableId = "",
                                         string tableClass = "gridView",
                                         string capTableDivClass = "captionBody",
                                         string captionName = "",
                                         string theadRowClass = "headerRow",
                                         string funcOrderBy = "orderByTable(this);",
                                         string tableContent = "",
                                         string[][,] capTableCotrolBtn=null)
        {
            TagBuilder preDivBild = new TagBuilder("div"); //div в який буде поміщено таблицю
            preDivBild.AddCssClass(preTableDivClass);    //додаємо css клас для div
            preDivBild.MergeAttribute("id", preTableDivId);//додаємо ід головному діву
            //TagBuilder capTabte = new TagBuilder("div"); 
            //capTabte.AddCssClass(capTableDivClass);      

            TagBuilder caption = new TagBuilder("caption");//div шапки для таблиці
            caption.AddCssClass(capTableDivClass);         //додаємо css клас для div
            
            for (int i = 0; i < capTableBtn.GetLength(0); i++)
            {
                TagBuilder img = new TagBuilder("img");
                TagBuilder a =new TagBuilder("a");
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
                    TagBuilder img = new TagBuilder("img");
                    for (int i = 0; i < item.GetLength(0); i++)
                    {
                        img.MergeAttribute(item[i,0], item[i,1]);
                    }
                    caption.InnerHtml += img.ToString();
                }
            }

            TagBuilder captionText = new TagBuilder("div");

            captionText.SetInnerText(captionName);
            caption.InnerHtml += captionText.ToString();

            TagBuilder table = new TagBuilder("table");  //головна таблиця
            table.MergeAttribute("id", tableId);
            table.AddCssClass(tableClass);               //css головної таблиці
            table.MergeAttribute("cellpadding", "0");    //
            table.MergeAttribute("cellspacing", "0");    //додаткові атрибути для таблиці
            table.MergeAttribute("border", "0");         //
            TagBuilder thead = new TagBuilder("thead");  //шапка таблиці з назвами колонок
            TagBuilder tbody = new TagBuilder("tbody");  //тіло таблиці
            TagBuilder theadRow = new TagBuilder("tr");  //рядок з назвами колонок
            theadRow.AddCssClass(theadRowClass);         //сласс рядка з назвами колонок
            for (int i = 0; i < columnName.GetLength(0); i++)
            {
                TagBuilder th = new TagBuilder("th");
                TagBuilder thDiv = new TagBuilder("div");
                TagBuilder thDivSpan = new TagBuilder("span");
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
            TagBuilder tfoot = new TagBuilder("tfoot");
            tfoot.InnerHtml = "<tr><td></td></tr>";
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
            TagBuilder select = new TagBuilder("select");
            if (attr != null)
            {
                for (int i = 0; i < attr.GetLength(0); i++)
                {
                    select.MergeAttribute(attr[i,0],attr[i,1]);
                }
            }
            if (nullFirstRow)
            {
                TagBuilder option = new TagBuilder("option");
                option.MergeAttribute("value", "");
                select.InnerHtml += option.ToString();
            }
            for (int i = 0; i < optionList.GetLength(0); i++)
            {
                TagBuilder option = new TagBuilder("option");
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
            TagBuilder select = new TagBuilder("select");
            if (attr != null)
            {
                for (int i = 0; i < attr.GetLength(0); i++)
                {
                    select.MergeAttribute(attr[i,0],attr[i,1]);
                }
            }
            if (nullFirstRow)
            {
                TagBuilder option = new TagBuilder("option");
                select.InnerHtml += option.ToString();
            }
            foreach (var item in optionList)
            {
                TagBuilder option = new TagBuilder("option");
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
            TagBuilder select = new TagBuilder("select");
            if (attr != null)
            {
                for (int i = 0; i < attr.GetLength(0); i++)
                {
                    select.MergeAttribute(attr[i, 0], attr[i, 1]);
                }
            }
            if (nullFirstRow) { 
                TagBuilder option = new TagBuilder("option");
                option.MergeAttribute("value", "");
                select.InnerHtml += option.ToString();
            }
            if (optionList != null)
            {
                foreach (var item in optionList)
                {
                    TagBuilder option = new TagBuilder("option");
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
    }

}