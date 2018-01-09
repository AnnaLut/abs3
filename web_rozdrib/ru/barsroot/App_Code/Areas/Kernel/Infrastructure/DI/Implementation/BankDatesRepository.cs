using System;
using System.Linq;
using Areas.Kernel.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;

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
                .Where(i=> i.FDAT1 >= dateStart && i.FDAT1 <= dateEnd )
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
    }
}