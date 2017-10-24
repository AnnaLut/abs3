using System;
using System.Linq;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using Areas.Cash.Models;

namespace BarsWeb.Areas.Cash.Infrastucture.DI.Implementation.Center
{
    /// <summary>
    /// Функции с перечнем МФО
    /// </summary>
    public class MfoRepository : IMfoRepository
    {
        readonly CashEntities _entities;

        public MfoRepository(ICashModel model)
        {
            _entities = model.CashEntities;
        }

        /// <summary>
        /// Получить список МФО
        /// </summary>
        /// <exception cref="Exception"></exception>
        public IQueryable<CLIM_MFO> GetMfos()
        {
            return _entities.CLIM_MFO;
        }
    }
}