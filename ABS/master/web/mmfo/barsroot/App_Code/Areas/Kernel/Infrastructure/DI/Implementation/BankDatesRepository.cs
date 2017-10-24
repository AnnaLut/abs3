using System;
using System.Linq;
using Areas.Kernel.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using System.Collections.Generic;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation
{
    public class BankDatesRepository : IBankDatesRepository
    {
        private readonly KernelContext _entities;

        public BankDatesRepository(IKernelModel model)
        {
            _entities = model.KernelEntities;
        }
        public IQueryable<BankDates> GetAllBankDates(int year, int? month)
        {
            DateTime dateStart;
            DateTime dateEnd;
            if (month == null)
            {
                dateStart = new DateTime(year, 1, 1);
                dateEnd = new DateTime(year, 12, DateTime.DaysInMonth(year, 12));
            }
            else
            {
                var intMonth = Convert.ToInt32(month);
                dateStart = new DateTime(year, intMonth, 1);
                dateEnd = new DateTime(year, intMonth, DateTime.DaysInMonth(year, intMonth));
            }
            var datesList = _entities.FDATs
                .Where(i => i.FDAT1 >= dateStart && i.FDAT1 <= dateEnd)
                .Select(i => new BankDates
                {
                    Date = i.FDAT1,
                    IsOpen = (i.STAT != 9)
                });

            return datesList;
        }
        public DateTime GetBankDate()
        {
            var date = _entities.ExecuteStoreQuery<DateTime>("SELECT bankdate FROM dual").FirstOrDefault();
            return date;
        }

        #region holiday

        /// <summary>
        /// Возвращает все виходние дні
        /// </summary>
        /// <param name="year"></param>
        /// <param name="kv"></param>
        /// <returns></returns>
        public List<Holiday> GetHolidays(string year, int? kv)
        {
            string sql = @"select * from holiday h where extract(year from TO_DATE(h.holiday, 'DD-MON-RR'))=:year";
            object[] parameters =
                {
                new OracleParameter("year",OracleDbType.Varchar2).Value= year
            };

            string add_sql = kv != null ? " and kv =" + Convert.ToString(kv) : "";

            return _entities.ExecuteStoreQuery<Holiday>(sql + add_sql, parameters).ToList();
        }
        /// <summary>
        /// Инициализирует любой год выходними процедурой init_holidays
        /// </summary>
        /// <param name="year"></param>
        /// <param name="kv"></param>
        public void InitHolidays(string year, int? kv)
        {
            string sql = @"begin init_holidays(:l_curr, :l_year); end;";
            object[] parameters =
                {
                 new OracleParameter("l_curr",OracleDbType.Varchar2).Value= Convert.ToString(kv),
                new OracleParameter("l_year",OracleDbType.Int32).Value=  Convert.ToInt32(year)
            };

            _entities.ExecuteStoreCommand(sql, parameters);
        }

        private List<int> GetKVs() {
            string sql = @"select distinct(kv) from holiday";
            return _entities.ExecuteStoreQuery<int>(sql).ToList();
        }

        /// <summary>
        /// Принимает все дни которые были изменены и удаляет его с таблицы выходных или добавляет
        /// </summary>
        /// <param name="year"></param>
        /// <param name="kv"></param>
        /// <param name="holiday"></param>
        public void SaveCalendar(string year, int? kv, List<DateTime> holiday)
        {
            List<Holiday> daysOff = GetHolidays(year, kv);
            List<DateTime> days = new List<DateTime>();
            for (int i = 0; i < daysOff.Count; i++)
            {
                days.Add(daysOff[i].holiday);
            }
            string sql = "";
            List<int> _kvlist = new List<int>(); 
            string delete_qwery = @"DELETE FROM holiday
                                    WHERE kv =:nCurrCode and holiday = to_date(:dTemp, 'dd.mm.yyyy')";

            string insert_qwery = @"INSERT INTO holiday(kv, holiday)
                                    VALUES (:nCurrCode,to_date(:dTemp, 'dd.mm.yyyy'))";
            if (kv == -1)
                _kvlist = GetKVs();
            else
                _kvlist.Add((int)kv);

            bool contain = false;
            for (int i = 0; i < holiday.Count; i++)
            {
                for (var j = 0; j < days.Count; j++)
                {
                    if (days[j].Equals(holiday[i]))
                    {
                        contain = true;
                        break;
                    }
                }
                for (int k = 0; k < _kvlist.Count(); k++)
                {
                    object[] parameters =
                    {
                    new OracleParameter("nCurrCode",OracleDbType.Int32).Value = Convert.ToInt32(_kvlist[k]),
                    new OracleParameter("dTemp",OracleDbType.Varchar2).Value =  holiday[i].ToString(@"dd\/MM\/yyyy")
                };

                    if (contain)
                    {
                        sql = delete_qwery;
                        _entities.ExecuteStoreCommand(sql, parameters);
                    }
                    else
                    {
                        sql = insert_qwery;
                        _entities.ExecuteStoreCommand(sql, parameters);
                    }
                }
            }
        }
        #endregion

    }
}