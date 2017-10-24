using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using Bars.Classes;
using BarsWeb.Models;
using Models;
using Oracle.DataAccess.Client;

namespace barsroot
{
    /// <summary>
    /// клас дополнительных статических функцый
    /// </summary>
    public class ServicesClass
    {
        /// <summary>
        /// вичитуємо версію веба з файла
        /// </summary>
        /// <returns></returns>
        public static string GetVersionWeb()
        {
            object parValue = AppDomain.CurrentDomain.GetData("WPARAM_WERSIONWEB");
            if (parValue == null)
            {
                string rootPath = HttpContext.Current.Server.MapPath("~");
                string version;
                try
                {
                    version = File.ReadAllText(rootPath + "\\version.abs");
                }
                catch (FileNotFoundException)
                {
                    version = "0.0.0" + new Random().Next(1000) ;
                }
                parValue =  version;              
                AppDomain.CurrentDomain.SetData("WPARAM_WERSIONWEB", parValue);
            }
            return Convert.ToString(parValue);
        }
        /// <summary>
        /// Взять глобальный параметр из таблицы Params
        /// </summary>
        /// <param name="parName"></param>
        /// <returns></returns>
        public static string GetGlobalParam(string parName)
        {
            object parValue = AppDomain.CurrentDomain.GetData("WPARAM_" + parName);
            if (parValue == null)
            {
                var connection = OraConnector.Handler.IOraConnection.GetUserConnection();
                var command = new OracleCommand("select val from params where par=:par", connection);
                try
                {
                    command.Parameters.Add("par", OracleDbType.Varchar2, parName, ParameterDirection.Input);
                    parValue = command.ExecuteScalar();
                }
                finally
                {
                    connection.Close();
                    connection.Dispose();
                }
                AppDomain.CurrentDomain.SetData("WPARAM_" + parName, parValue);
            }
            return Convert.ToString(parValue);
        }
        /// <summary>
        /// Возвращает подходящий нам формат числа
        /// </summary>
        /// <param name="digCount">К-во знаков после запятой</param>
        public static string GetNFormat(object digCount)
        {
            string res = "### ### ### ### ### ### ##0.";
            for (int i = 0; i < Convert.ToInt32(digCount); i++) res += "0";

            return res;
        }
        /// <summary>
        /// Возвращает месяц прописью 
        /// </summary>
        /// <param name="mounth">задает номер месяца (1-12)</param>
        /// <returns>месяц прописью или пустую строку если Mounth 
        /// выходит из допустимого диапазона</returns>
        public static string GetMonthPr(int mounth)
        {
            string[] mon = {   "січня", 
                               "лютого", 
                               "березня", 
                               "квітня", 
                               "травня", 
                               "червня", 
                               "липня", 
                               "серпня",
                               "вересня",
                               "жовтня",
                               "листопада", 
                               "грудня" };
            if (mounth >= 1 && mounth <= 12) return (mon[mounth - 1]);
            return "";
        }

        /// <summary>
        /// функція формування SQL запроса
        /// </summary>
        /// <param name="entities">конттекст підключення до бази для вичитки фільтрівкористувача і системного</param>
        /// <param name="typeSeach">имя таблички або вьюшки</param>
        /// <param name="filterSysId">id системго фільтру</param>
        /// <param name="filterUserId">id фільтра користувача</param>
        /// <param name="filterTable">додакові таблички для вибірки (повязуються в filterString)</param>
        /// <param name="filterString"> строка для WHERE в запиті</param>
        /// <param name="sort">назва колонки для сортування</param>
        /// <param name="sortDir">тип сортування ASC/DESC</param>
        /// <param name="rowName">список стовпців в запросі</param>
        /// <param name="pageNum">номер сторінки</param>
        /// <param name="pageSize">кількість рядків на сторінці (0-всі)</param>
        /// <returns></returns>
        public static string GetSelectStryng(EntitiesBars entities=null,
                                            string typeSeach="",
                                            int? filterSysId=null,
                                            int? filterUserId=null,
                                            string filterTable="",
                                            string filterString="",
                                            string sort="",
                                            string sortDir="ASC",
                                            string rowName="a.*",
                                            int? pageNum=null,
                                            int? pageSize=null) 
        {
            if (string.IsNullOrWhiteSpace(filterString))
            {
                filterString = "";
            }
            entities = entities ?? new EntitiesBarsCore().NewEntity();
            if (filterSysId != null)
            {
                var fs = entities.DYN_FILTER.FirstOrDefault(i => i.FILTER_ID == filterSysId);
                if (fs != null)
                {
                    if (filterString != "")
                    {
                        filterString += " and " + fs.WHERE_CLAUSE + " ";
                    }
                    else
                    {
                        filterString += fs.WHERE_CLAUSE + " ";
                    }
                    if (!string.IsNullOrWhiteSpace(fs.FROM_CLAUSE)) filterTable += " , " + fs.FROM_CLAUSE;
                }
            }
            if (filterUserId != null)
            {
                var fs = entities.DYN_FILTER.FirstOrDefault(i => i.FILTER_ID == filterUserId);
                if (fs != null)
                {
                    if (!string.IsNullOrWhiteSpace(filterString))
                    {
                        filterString += " and " + fs.WHERE_CLAUSE + " ";
                    }
                    else
                    {
                        filterString += fs.WHERE_CLAUSE + " ";
                    }
                    if (!string.IsNullOrWhiteSpace(fs.FROM_CLAUSE)) filterTable += " , " + fs.FROM_CLAUSE;
                }
            }

            string select = @"SELECT "+rowName+@"
                                    FROM " + typeSeach + " a " + filterTable;
            if (!string.IsNullOrWhiteSpace(filterString)) select += " WHERE " + filterString.Replace("$~~ALIAS~~$", "a")+" ";
            if (!string.IsNullOrWhiteSpace(sort)) select += " ORDER BY "+ sort + @" " + sortDir+" ";
            if (pageNum!=null)
            {
                pageSize=pageSize ?? 10;
                pageSize = pageSize == 0 ? 1000:pageSize; 
                string rowon=Convert.ToString((pageNum * pageSize) + 1);
                string rowwith=Convert.ToString((pageNum * pageSize) - pageSize);
                select = @"SELECT * FROM 
                            (SELECT myquery.*, ROWNUM rnum
                                FROM ( "+ select + @") myquery
                                WHERE ROWNUM <=" + rowon + @")
                            WHERE rnum >"+rowwith ;
            }
            return select;
        }

        /// <summary>
        /// метод возвращяющий справочник с двумя параметрами
        /// </summary>
        /// <param name="entities">контекст подключения</param>
        /// <param name="tableName">имя таблицы</param>
        /// <param name="idRow">название поля для параметра ID</param>
        /// <param name="valueRow">название поля для параметра VALUE</param>
        /// <param name="dataRow">название поля для параметра DATA</param>
        /// <param name="whereString">строка для фильтра по справочнику (без where)</param>
        /// <param name="sort">імя стовбця сортування</param>
        /// <param name="sortDir">напрямок сортування</param>
        /// <param name="pageNum">номер сторінки</param>
        /// <param name="pageSize">кількість рядків на сторінці</param>
        /// <returns>возвращяет сущьность Handbook</returns>
        public static IEnumerable<Handbook> GetHandbookList (EntitiesBars entities=null,
                                                      string tableName="",
                                                      string idRow="",
                                                      string valueRow="",
                                                      string whereString="",
                                                      string dataRow="null",
                                                      string sort = "",
                                                      string sortDir = "ASC",
                                                      int? pageNum = null,
                                                      int? pageSize = null)
        {
            string select = "select to_char(" + idRow + ") ID, " + valueRow + " NAME, to_char("+dataRow+") DATA from " + tableName;
            if (!string.IsNullOrWhiteSpace(whereString))
            {
                select += " where " + whereString;
            }
            if (pageNum != null)
            {
                pageSize = pageSize ?? 20;
                string rowon = Convert.ToString((pageNum * pageSize) + 1);
                string rowwith = Convert.ToString((pageNum * pageSize) - pageSize);
                select = @"SELECT * FROM 
                            (SELECT myquery.*, ROWNUM rnum
                                FROM ( " + select + @") myquery
                                WHERE ROWNUM <=" + rowon + @")
                            WHERE rnum >" + rowwith;
            }
            if (entities == null)
            {
                entities = new EntitiesBarsCore().NewEntity();
            }
            List<Handbook> newHandbook = entities.ExecuteStoreQuery<Handbook>(select).ToList();
            return newHandbook;
        }

    }
}