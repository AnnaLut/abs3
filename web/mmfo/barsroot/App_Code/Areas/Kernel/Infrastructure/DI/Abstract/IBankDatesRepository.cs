using System;
using System.Linq;
using BarsWeb.Areas.Kernel.Models;
using System.Collections.Generic;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract
{
    public interface IBankDatesRepository
    {
        IQueryable<BankDates> GetAllBankDates(int year, int? month);
        DateTime GetBankDate();
        List<Holiday> GetHolidays(string year, int? kv);
        void InitHolidays(string year, int? kv); 
        void SaveCalendar(string year, int? kv, List<DateTime> holiday); 
    }
}