using System.Collections.Generic;
using System.Linq;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using Models;
using Oracle.DataAccess.Client;
using System.Web;
using System.Text;
using System;
using Bars.Classes;

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
            List<V_OPERAPP_UI> operAppUiList = _entities.ExecuteStoreQuery<V_OPERAPP_UI>("select * from v_operapp_ui").ToList();
            return EncodUrlParam(operAppUiList);
        }

        public List<V_OPERAPP_UI> EncodUrlParam(List<V_OPERAPP_UI> operAppList, string paramName = "&sPar=")
        {
            foreach (V_OPERAPP_UI item in operAppList)
            {
                if (string.IsNullOrEmpty(item.FUNCNAME) || !item.FUNCNAME.Contains(paramName))
                    continue;
                string paramvalue = item.FUNCNAME.Substring(item.FUNCNAME.LastIndexOf(paramName) + paramName.Length);
                item.FUNCNAME = item.FUNCNAME.Replace(paramvalue, item.CODEOPER.ToString());
            }
            return operAppList;
        }
        public USER_PARAM GetUserParam()
        {
            string sql = @"select
                                bars.user_id, 
                                bars.web_utl.get_user_fullname as user_fullname,  
                                TO_CHAR(bars.web_utl.get_bankdate,'dd/MM/yyyy') as bankdate,
                                bars.tobopack.gettobo as tobo,
                                bars.tobopack.gettoboname as toboname, 
                                bars.docsign.GetIdOper as idoper,                                                               
                                (select listagg(column_value, ',') within group (order by column_value) role_list 
                                    from table(user_adm_ui.get_user_role_codes(user_id))) as ROLES
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

        public UserBranch CurrentBranch()
        {
            UserBranch branch = new UserBranch();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"select * from v_user_branches_tree b where B.BRANCH = (select SYS_CONTEXT ('bars_context', 'user_branch') from dual)";
                
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    branch.BRANCH = String.IsNullOrEmpty(reader.GetValue(0).ToString()) ? String.Empty : reader.GetString(0);
                    branch.NAME = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : reader.GetString(1);
                    branch.CAN_SELECT = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? (decimal?)null : reader.GetDecimal(2);
                    branch.BRANCH_PATH = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? String.Empty : reader.GetString(3);
                    branch.PARENT_BRANCH = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? String.Empty : reader.GetString(4);
                    branch.HAS_CHILD = reader.GetDecimal(5) == 1 ? true : false;
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return branch;
        }

        public List<UserBranch> UsersBranches(string branchId)
        {
            List<UserBranch> list = new List<UserBranch>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                if (branchId != null && branchId != "" && branchId != "null")
                {
                    cmd.CommandText = @"select B.BRANCH, B.NAME, B.CAN_SELECT, B.BRANCH_PATH, B.PARENT_BRANCH, b.HAS_CHILD from v_user_branches_tree b where B.PARENT_BRANCH = :p_branch";
                    cmd.Parameters.Add("p_branch", OracleDbType.Varchar2, branchId, System.Data.ParameterDirection.Input);
                } else
                {
                    cmd.CommandText = @"select B.BRANCH, B.NAME, B.CAN_SELECT, B.BRANCH_PATH, B.PARENT_BRANCH, b.HAS_CHILD from v_user_branches_tree b where B.PARENT_BRANCH is null";
                }

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    var branch = new UserBranch();

                    branch.BRANCH = String.IsNullOrEmpty(reader.GetValue(0).ToString()) ? String.Empty : reader.GetString(0);
                    branch.NAME = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : reader.GetString(1);
                    branch.CAN_SELECT = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? (decimal?)null : reader.GetDecimal(2);
                    branch.BRANCH_PATH = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? String.Empty : reader.GetString(3);
                    branch.PARENT_BRANCH = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? String.Empty : reader.GetString(4);
                    branch.HAS_CHILD = reader.GetDecimal(5) == 1 ? true : false;

                    list.Add(branch);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return list;
        }       

    }
}