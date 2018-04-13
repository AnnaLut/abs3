using System;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.Async.Models;

namespace BarsWeb.Areas.Async.Infrastructure.Repository.DI.Abstract
{
    public interface ISchedulersRepository
    {
        IQueryable<Scheduler> GetAll();
        Scheduler Get(int id);
        Scheduler GetByCode(string code);
        Scheduler Add(Scheduler scheduler);
        Scheduler Update(Scheduler scheduler);
        bool Delete(int id);
        bool DeleteByCode(string code);

        /// <summary>
        /// Get scheduling parameters
        /// </summary>
        /// <param name="schedulerCode">Code of scheduler</param>
        /// <returns></returns>
        List<TaskParameter> GetParameters(string schedulerCode);
    }
}
