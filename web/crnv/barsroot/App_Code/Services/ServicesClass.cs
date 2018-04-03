using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Models;
using barsroot.Models;

namespace barsroot
{
    /// <summary>
    /// клас дополнительных статических функцый
    /// </summary>
    public class ServicesClass
    {
        public ServicesClass()
        {

        }
        /// <summary>
        /// Возвращает подходящий нам формат числа
        /// </summary>
        /// <param name="DigCount">К-во знаков после запятой</param>
        public static string GetNFormat(object DigCount)
        {
            string res = "### ### ### ### ### ### ##0.";
            for (int i = 0; i < Convert.ToInt32(DigCount); i++) res += "0";

            return res;
        }
        /// <summary>
        /// Возвращает месяц прописью 
        /// </summary>
        /// <param name="Mounth">задает номер месяца (1-12)</param>
        /// <returns>месяц прописью или пустую строку если Mounth 
        /// выходит из допустимого диапазона</returns>
        public static string GetMonthPr(int Mounth)
        {
            string[] Mon = { "січня", "лютого", "березня", "квітня", "травня", "червня", "липня", "серпня", "вересня", "жовтня", "листопада", "грудня" };
            if (Mounth >= 1 && Mounth <= 12) return (Mon[Mounth - 1]);
            else return "";
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
        /// <param name="pageNum">номер сторінки</param>
        /// <param name="pageSize">кількість рядків на сторінці</param>
        /// <returns></returns>
        public static string GetSelectStryng(EntitiesBars entities=null,
                                            string typeSeach="",
                                            int? filterSysId=null,
                                            int? filterUserId=null,
                                            string filterTable="",
                                            string filterString="",
                                            string sort="",
                                            string sortDir="ASC",
                                            int? pageNum=null,
                                            int? pageSize=null) 
        {
            if (filterString == string.Empty || filterString == null)
            {
                filterString = "";
            }
            if (filterSysId != null)
            {
                var fs = entities.DYN_FILTER.Where(i => i.FILTER_ID == filterSysId).FirstOrDefault();
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
                var fs = entities.DYN_FILTER.Where(i => i.FILTER_ID == filterUserId).FirstOrDefault();
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

            string select = @"SELECT a.*
                                    FROM " + typeSeach + " a " + filterTable;
            if (!string.IsNullOrWhiteSpace(filterString)) select += " WHERE " + filterString.Replace("$~~ALIAS~~$", "a")+" ";
            if (!string.IsNullOrWhiteSpace(sort)) select += " ORDER BY a."+ sort + @" " + sortDir+" ";
            if (pageNum!=null)
            {
                pageSize=pageSize==null? 10:pageSize;
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
        /// <param name="IdRow">название поля для параметра ID</param>
        /// <param name="ValueRow">название поля для параметра VALUE</param>
        /// <param name="DataRow">название поля для параметра DATA</param>
        /// <param name="whereString">строка для фильтра по справочнику (без where)</param>
        /// <param name="pageNum">номер сторінки</param>
        /// <param name="PageSiza">кількість рядків на сторінці</param>
        /// <returns>возвращяет сущьность Handbook</returns>
        public static IEnumerable<Handbook> GetHandbookList (EntitiesBars entities=null,
                                                      string tableName="",
                                                      string IdRow="",
                                                      string ValueRow="",
                                                      string whereString="",
                                                      string DataRow="null",
                                                      string sort = "",
                                                      string sortDir = "ASC",
                                                      int? pageNum = null,
                                                      int? pageSize = null)
        {
            List<Handbook> newHandbook = new List<Handbook>();
            string select = "select to_char(" + IdRow + ") ID, " + ValueRow + " NAME, to_char("+DataRow+") DATA from " + tableName;
            if (!string.IsNullOrWhiteSpace(whereString))
            {
                select += " where " + whereString;
            }
            if (pageNum != null)
            {
                pageSize = pageSize == null ? 20 : pageSize;
                string rowon = Convert.ToString((pageNum * pageSize) + 1);
                string rowwith = Convert.ToString((pageNum * pageSize) - pageSize);
                select = @"SELECT * FROM 
                            (SELECT myquery.*, ROWNUM rnum
                                FROM ( " + select + @") myquery
                                WHERE ROWNUM <=" + rowon + @")
                            WHERE rnum >" + rowwith;
            }
            //entities = entities == null ? new EntitiesBarsCore().GetEntitiesBars() : entities; 
            if (entities == null)
            {
                using (entities = new EntitiesBarsCore().GetEntitiesBars())
                {
                    newHandbook = entities.ExecuteStoreQuery<Handbook>(select).ToList();
                }
            }
            else
            {
                try
                {
                    newHandbook = entities.ExecuteStoreQuery<Handbook>(select).ToList();
                }
                catch (Exception e)
                {
                    var t = e;
                }

            }
            return newHandbook;
        }
    }
}