using System;
using System.Collections.Generic;
using System.Linq;
using Bars.Classes;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Crkr.Infrastructure.Helper;
using BarsWeb.Areas.Crkr.Models;
using Dapper;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Crkr.Infrastructure.DI.Implementation
{
    public class UserRepository : MultipleSearch, IUserRepository
    {
        private string BuildSqlQuery(ActualUser model)
        {
            var sql = @"select RNK, NAME, INN, SEX, BIRTH_DATE, SER, NUMDOC, BRANCH  
                        from v_customer_crkr where";

            if (!string.IsNullOrEmpty(model.name))
                sql = sql.Insert(sql.Length, " and (lower(name) like lower('%'||:name||'%') or :name is null)");

            if (!string.IsNullOrEmpty(model.inn))
                sql = sql.Insert(sql.Length, " and (inn = :inn or :inn is null)");
            
            if (!string.IsNullOrEmpty(model.ser))
                sql = sql.Insert(sql.Length, " and (ser = :ser or :ser is null)");

            if (!string.IsNullOrEmpty(model.numdoc))
                sql = sql.Insert(sql.Length, " and (numdoc = :numdoc or :numdoc is null)");

            if (!string.IsNullOrEmpty(model.eddr_id))
                sql = sql.Insert(sql.Length, " and (eddr_id = :eddr_id or :eddr_id is null)");

            sql = sql.Replace("where and ", "where ");
            return sql;
        }

        public List<ActualUsersProfiles> GetProfiles(ActualUser model, [DataSourceRequest] DataSourceRequest request)
        {
            List<ActualUsersProfiles> profiles = null;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                profiles = connection.Query<ActualUsersProfiles>(BuildSqlQuery(model), GetParamsFromModel(model)).ToList();
            }
            return profiles;
        }

        public ListUsersResponse ImportUsers(ListUsersParams param)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            ListUsersResponse result = new ListUsersResponse();
            List<ImportUsersResponse> userList = new List<ImportUsersResponse>();

            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = @"bars.crkr_compen.compen_user_create";
                for (int i = 0; i < param.user.Count; i++)
                {
                    ImportUsersResponse user = new ImportUsersResponse();
                    try
                    {
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("p_logname", OracleDbType.Varchar2, param.user[i].logname, System.Data.ParameterDirection.Input);
                        cmd.Parameters.Add("p_fio", OracleDbType.Varchar2, param.user[i].fio, System.Data.ParameterDirection.Input);
                        cmd.Parameters.Add("p_branch", OracleDbType.Varchar2, param.user[i].branch, System.Data.ParameterDirection.Input);
                        cmd.Parameters.Add("p_canselectbranch", OracleDbType.Varchar2, param.user[i].canselectbranch, System.Data.ParameterDirection.Input);
                        cmd.Parameters.Add("p_method", OracleDbType.Varchar2, param.user[i].method, System.Data.ParameterDirection.Input);
                        cmd.Parameters.Add("p_dateprivstart", OracleDbType.Date, param.user[i].dateprivstart, System.Data.ParameterDirection.Input);
                        cmd.Parameters.Add("p_dateprivend", OracleDbType.Date, param.user[i].dateprivend, System.Data.ParameterDirection.Input);
                        cmd.ExecuteNonQuery();
                        user.logname = param.user[i].logname;
                        user.success = 1;
                        user.message = "success";
                        //result += "[username = " + param.user[i].logname + "]" + " success \n";
                    }
                    catch (Exception e)
                    {
                        user.logname = param.user[i].logname;
                        user.success = 0;
                        user.message = e.Message;
                        //result += "[username = " + param.user[i].logname + "]" + e.Message + " \n";
                    }
                    userList.Add(user);
                }
                result.user = userList;
                return result;
            }
            finally 
            {
                connection.Dispose();
                connection.Close();
                cmd.Dispose();
            }
            //if (String.IsNullOrEmpty(result)) result = "success";
        }
    }
}