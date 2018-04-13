using System.Linq;
using BarsWeb.Areas.Arcs.Infrastructure.Repository.DI.Abstract;
using Areas.Arcs.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Arcs.Infrastructure.Repository.DI.Implementation
{
    public class ArchivesRepository : IArchivesRepository
    {
        readonly ArcsEntities _entities;
        public ArchivesRepository(IArcsModel model)
        {
		    _entities = model.ArcsEntities;
        }

        public IQueryable<ARCS_META> GetTableState()
        {
            //_entities.Connection.Open();
            return _entities.ARCS_META;
        }

        public IQueryable<V_ARCS_TAB_REP> GetDeatilOnTable(string tableName)
        {
            /*return
                _entities.ExecuteStoreQuery<V_ARCS_TAB_REP>("select * from V_ARCS_TAB_REP where table_name = 'OPER'")
                    .AsQueryable();*/
            return _entities.V_ARCS_TAB_REP.Where(i => i.TABLE_NAME == tableName);
        }

        public int RemoveYear(string table, int year, bool rebuildIndex)
        {
            object[] parameters =         
            { 
                new OracleParameter("p_table",OracleDbType.Varchar2).Value=table,
                new OracleParameter("p_year",OracleDbType.Int32).Value=year
            };
            return ExecuteStoreProcedure("bars_arcs.remove_year_job", parameters);
        }

        public int RestoreYear(string table, int year, bool rebuildIndex)
        {
            object[] parameters =         
            { 
                new OracleParameter("p_table",OracleDbType.Varchar2).Value=table,
                new OracleParameter("p_year",OracleDbType.Int32).Value=year
            };
            return ExecuteStoreProcedure("bars_arcs.restore_year_job", parameters);
        }

        public int TakeArcdataOffline(string table, int year)
        {
            object[] parameters =         
            { 
                new OracleParameter("p_table",OracleDbType.Varchar2).Value=table,
                new OracleParameter("p_year",OracleDbType.Int32).Value=year
            };
            return ExecuteStoreProcedure("bars_arcs.take_arcdata_offline", parameters);
        }

        public int ExecuteStoreProcedure(string procedureName, object[] parameters)
        {
            return _entities.ExecuteStoreCommand(string.Format("begin {0}(:p_table,:p_year) ;end;", procedureName), parameters);
        }
    }
}