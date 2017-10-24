using System.Collections.Generic;
using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Implementation
{
    public class HandbookRepository : IHandbookRepository
    {
        Entities _entities;
        public HandbookRepository(IAdminModel model)
        {
            _entities = model.Entities;
        }

        public IEnumerable<STAFF_TIPS> GroupsData()
        {
            const string query = @"select * from STAFF_TIPS";
            var result = _entities.ExecuteStoreQuery<STAFF_TIPS>(query);
            return result;
        }

        public IEnumerable<STAFF_CLASS> ClassesData()
        {
            const string query = @"select * from STAFF_CLASS";
            var result = _entities.ExecuteStoreQuery<STAFF_CLASS>(query);
            return result;
        }
    }
}