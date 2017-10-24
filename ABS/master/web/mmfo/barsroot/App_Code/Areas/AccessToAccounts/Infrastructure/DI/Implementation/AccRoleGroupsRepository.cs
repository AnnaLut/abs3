using System;
using System.Data;
using System.Linq;
using AttributeRouting.Helpers;
using Oracle.DataAccess.Client;
using ibank.core;
using BarsWeb.Areas.Kernel.Models;
using System.Collections.Generic;
using BarsWeb.Areas.AccessToAccounts.Infrastructure.DI.Abstract;
using Bars.Classes;
using Areas.AccessToAccounts.Models;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using Dapper;
using Kendo.Mvc.Infrastructure.Implementation;
using System.Text.RegularExpressions;

namespace BarsWeb.Areas.AccessToAccounts.Infrastucture.DI.Implementation
{
    public class AccRoleGroupsRepository : IAccRoleGroupsRepository
    {
        public BarsSql _getSql;
        readonly AccessToAccountsEntities _entities;
        public AccRoleGroupsRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("AccessToAccounts", "AccessToAccounts");
            _entities = new AccessToAccountsEntities(connectionStr);
        }

        public List<AccGroups> GetAccRoleGroups()
        {
            InitGetAccRoleGroups();
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<AccGroups>(_getSql.SqlText).ToList();
            }
        }

        private void InitGetAccRoleGroups()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@" select g.id as ID,g.name as NAME from groups g order by 1"),
                SqlParams = new object[] { }
            };
        }

        public List<Roles> GetRoles(decimal? grpId)
        {
            InitGetRoles(grpId);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<Roles>(_getSql.SqlText, new { grpId }).ToList();
            }

        }
        private void InitGetRoles(decimal? grpId)
        {

            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"select role_code, role_state_id
                                            from v_role_staffgroups
                                            where staff_group_id = :grpId
                                            order by 1"),

                SqlParams = new object[] { }
            };

        }

        public List<Users> GetUsers(decimal? grpId)
        {
            InitGetGetUsers(grpId);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<Users>(_getSql.SqlText, new { grpId }).ToList();
            }
        }
        private void InitGetGetUsers(decimal? grpId)
        {

            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"select unique user_id Id, user_name, branch 
                                            from v_role_staff rs, v_role_staffgroups rsg
                                            where rsg.role_id = rs.role_id
                                            and rsg.staff_group_id = :grpId"),

                SqlParams = new object[] { new OracleParameter("grpId", OracleDbType.Decimal) { Value = grpId }
                }
            };
        }

        public List<GrpAccounts> GetGrpAccounts(decimal? grpId, string filter)
        {
            string value = "";
            var p = new DynamicParameters();
            var sql = @"select kv, nls, branch
                                            from v_groupstaff_nls t where
                                            groupstaff_id = :grpId 
                                            and nls like :filter";
            string[] stringSeparators = new string[] { "~" };
            string[] Filter = filter.Split(stringSeparators, StringSplitOptions.None);
            if (Filter.Length > 1)
            {
                value = Filter[2] + "%";
                value = Regex.Replace(value, "[^0-9.]", "");
                value = value + "%";
            }
            else
            {
                value = filter + "%";
            }
            p.Add("grpId", dbType: DbType.Decimal, size: 10, value: grpId, direction: ParameterDirection.Input);
            p.Add("filter", dbType: DbType.String, size: 50, value: value, direction: ParameterDirection.Input);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<GrpAccounts>(sql, p).ToList();
            }
        }
        public string GetFilterValue(decimal? grpId)
        {
            var p = new DynamicParameters();
            var sql = @"select nvl(max(gn.nbs), '1001') defaut_nbs
                          from  groups_nbs gn, groups_acc ga, groups_staff_acc guga
                         where gn.id = ga.id
                           and ga.id = guga.ida
                           and guga.idg = :grpId
                           and rownum = 1
                         order by gn.nbs";

            p.Add("grpId", dbType: DbType.Decimal, size: 10, value: grpId, direction: ParameterDirection.Input);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<string>(sql, p).SingleOrDefault();
            }
        }
        public List<AccGroups> GetAccounts(decimal? grpId)
        {
            InitGetAccounts(grpId);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<AccGroups>(_getSql.SqlText, new { grpId }).ToList();
            }
        }
        private void InitGetAccounts(decimal? grpId)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@" select ga.id, ga.name  
                                         from groups_acc ga, groups_staff_acc gua, groups gu
                                        where gu.id = gua.idg 
                                          and ga.id = gua.ida
                                          and gu.id = :grpId
                                        order by id  "),

                SqlParams = new object[] { new OracleParameter("grpId", OracleDbType.Decimal) { Value = grpId }
                }
            };
        }


    }
}