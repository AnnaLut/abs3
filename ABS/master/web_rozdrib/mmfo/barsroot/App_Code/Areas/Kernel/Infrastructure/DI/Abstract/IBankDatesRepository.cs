using System;
using System.Linq;
using BarsWeb.Areas.Kernel.Models;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract
{
    public interface IBankDatesRepository
    {
        IQueryable<BankDates> GetAllBankDates(int year, int? month);
        DateTime GetBankDate();
    }
}