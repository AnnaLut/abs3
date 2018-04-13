using System.Linq;
using BarsWeb.Models;
using Models;

namespace BarsWeb.Infrastructure.Repository.DI.Implementation
{
    /// <summary>
    /// Summary description for FilterRepository
    /// </summary>
    public class FilterRepository
    {
        EntitiesBars _entities;
        public FilterRepository()
        {
            _entities = new EntitiesBarsCore().NewEntity();
        }

        public META_TABLES GetMetaTable(int? id, string tableName)
        {
            META_TABLES metaTables;
            if (id != null)
            {
                metaTables = _entities.META_TABLES.FirstOrDefault(i => i.TABID == id);
            }
            else
            {
                metaTables = _entities.META_TABLES.FirstOrDefault(i => i.TABNAME == tableName.ToUpper());
            }
            return metaTables;
        }

        public decimal UserId()
        {
            return _entities.ExecuteStoreQuery<decimal>("select getcurrentuserid from dual").FirstOrDefault();
        }

        public void AddFilter(string name, int tableId, string where, string tables)
        {
            decimal userid = UserId();

            var newDynFilter = new DYN_FILTER
            {
                TABID = tableId,
                USERID = userid,
                SEMANTIC = name,
                FROM_CLAUSE = tables,
                WHERE_CLAUSE = where
            };
            _entities.DYN_FILTER.AddObject(newDynFilter);
            _entities.SaveChanges();
        }

        public bool DeleteFilter(int id)
        {
            decimal userid = UserId();

            var dynFilter = _entities.DYN_FILTER.FirstOrDefault(i => i.FILTER_ID == id);
            if (dynFilter != null && dynFilter.USERID == userid)
            {
                _entities.DeleteObject(dynFilter);
                _entities.SaveChanges();
                return true;
            }
            return false;
        }
    }

}
