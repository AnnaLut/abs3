using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using Bars.Classes;
using BarsWeb.Areas.OpenCloseDay.Infrastructure.DI.Abstract;
using BarsWeb.Areas.OpenCloseDay.Models;
using Dapper;
using Oracle.DataAccess.Client;
using CommandType = System.Data.CommandType;

namespace BarsWeb.Areas.OpenCloseDay.Infrastructure.DI.Implementation
{
    public class DateOperation : IDateOperation
    {
        public string GetCurrentDate()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var getDate = connection.Query<CurrentDate>("select GL_UI.get_current_bank_date() CurDate from dual").SingleOrDefault();
                var date = getDate.CurDate;
                if (!string.IsNullOrEmpty(date))
                {
                    if (date.Contains("0:00:00"))
                    {
                        date = date.Replace("0:00:00", "");
                    }
                    return date;
                }
                else
                {
                    throw new NullReferenceException("Банківський день не відкрито");
                }
            }
        }

        public void CloseBankDay()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute("gl_ui.close_bank_date", null, commandType: CommandType.StoredProcedure);
            }
        }

        public void CreateDay(DateTime p_next_bank_date)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute("gl_ui.open_bank_date", new { p_next_bank_date }, commandType: CommandType.StoredProcedure);
            }
        }

        public string GetNetDate()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("date", dbType: DbType.Date, direction: ParameterDirection.ReturnValue);
                connection.Execute("gl_ui.get_next_bank_date", p, commandType: CommandType.StoredProcedure);
                var nextDate = p.Get<DateTime?>("date");
                if (nextDate != null)
                {
                    return nextDate.ToString().Replace("0:00:00","");
                }
                else
                {
                    return DateTime.Now.ToShortDateString();
                }
            }
        }

        public bool CheckPass(string pass)
        {
            string currentDate = "";
            var today = DateTime.Now;

            if (today.Month.ToString().Length < 2)
            {
                currentDate = "0" + today.Month.ToString();
            }
            else
            {
                currentDate = today.Month.ToString();
            }
            if (today.Day.ToString().Length < 2)
            {
                currentDate += '0' + today.Day.ToString();
            }
            else
            {
                currentDate += today.Day.ToString();
            }
            if (pass == currentDate)
                return true;
            return false;
        }

    }
}