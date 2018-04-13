using System.Collections.Generic;
using System.Linq;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Infrastructure.Repository.DI.Implementation
{
    public class HomeRepository : IHomeRepository
    {
        private EntitiesBars _entities;

        public HomeRepository(IAppModel model)
        {
            _entities = model.Entities;
        }

        public List<V_OPERAPP_UI> GetOperList()
        {
            return _entities.ExecuteStoreQuery<V_OPERAPP_UI>("select * from v_operapp_ui").ToList();
        }

        public USER_PARAM GetUserParam()
        {
            string sql = @"select
                                bars.user_id, 
                                web_utl.get_user_fullname as user_fullname,  
                                TO_CHAR(web_utl.get_bankdate,'dd/MM/yyyy') as bankdate,
                                tobopack.gettobo as tobo,
                                tobopack.gettoboname as toboname, 
                                docsign.GetIdOper as idoper
                          from dual";
            return _entities.ExecuteStoreQuery<USER_PARAM>(sql).FirstOrDefault();
        }

        public string DbName()
        {
            return _entities.Connection.DataSource;
        }

        public List<BRANCHES> GetBranches()
        {
            const string canSelBrSql = @"select count(column_name) 
                                   from all_tab_cols 
                                   where owner = 'BARS' 
                                         and table_name = 'STAFF$BASE' 
                                         and column_name = 'CAN_SELECT_BRANCH'";
            var branch = new List<BRANCHES>();
            decimal countCanSelBr = _entities.ExecuteStoreQuery<decimal>(canSelBrSql).FirstOrDefault();
            if (countCanSelBr > 0)
            {
                const string canUserSelBrSql = @"select can_select_branch from staff$base where id=user_id";
                string canUserSelBr = _entities.ExecuteStoreQuery<string>(canUserSelBrSql).FirstOrDefault();
                if (canUserSelBr == "Y")
                {
                    branch = _entities.ExecuteStoreQuery<BRANCHES>("select branch, name from v_user_branches").ToList();
                }
            }
            return branch;
        }

        public void ChangeBranch(string branch)
        {
            object[] parameters =
                    { 
                        new OracleParameter("p_branch",OracleDbType.Varchar2).Value=branch
                    };
            _entities.ExecuteStoreCommand("begin bc.select_branch(:p_branch);end;", parameters);
        }
    }
}