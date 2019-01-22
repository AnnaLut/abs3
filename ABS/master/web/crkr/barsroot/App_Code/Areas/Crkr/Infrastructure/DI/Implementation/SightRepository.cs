using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Bars.Classes;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Crkr.Models;
using Dapper;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Crkr.Infrastructure.DI.Implementation
{
    public class SightRepository : ISightRepository
    {
        public void VisaDbProc(PaymentsList item)
        {
            string procName = "";
            if (item.UserType == UserType.Oper)
                procName = "crkr_compen_web.apply_act_visa_self";
            if (item.UserType == UserType.Control)
                procName = "crkr_compen_web.apply_act_visa";
            if (item.UserType == UserType.Back)
                procName = "crkr_compen_web.apply_act_visa_bk";
            var connection = OraConnector.Handler.UserConnection;
            try
            {
                var command = new OracleCommand(procName, connection);
                command.CommandType = CommandType.StoredProcedure;

                var approveListParam = new OracleParameter("p_oper_list", OracleDbType.Array, item.id.Length, item.id, ParameterDirection.Input);
                approveListParam.UdtTypeName = "NUMBER_LIST";
                command.Parameters.Add(approveListParam);
                command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }
        }
        public void StornoDbProc(PaymentsList item)
        {
            string procName = "";
            if (item.UserType == UserType.Oper)
                procName = "crkr_compen_web.refuse_act_visa_self";
            if (item.UserType == UserType.Control)
                procName = "crkr_compen_web.refuse_act_visa";
            if (item.UserType == UserType.Back)
                procName = "crkr_compen_web.refuse_act_visa_bk";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                using (var command = new OracleCommand(procName, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    var approveListParam = new OracleParameter("p_oper_list", OracleDbType.Array, item.id.Length, item.id, ParameterDirection.Input);
                    approveListParam.UdtTypeName = "NUMBER_LIST";
                    command.Parameters.Add(approveListParam);
                    command.Parameters.Add("p_reason", OracleDbType.Varchar2, item.Reason, ParameterDirection.Input);
                    command.ExecuteNonQuery();
                }
            }
        }

        public void StornoAllDbProc(PaymentsList item)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                using (var command = new OracleCommand("crkr_compen_web.refuse_act_visa_all_bk", connection))
                {
                        command.CommandType = CommandType.StoredProcedure;

                        var approveListParam = new OracleParameter("p_oper_list", OracleDbType.Array, item.id.Length, item.id, ParameterDirection.Input);
                        approveListParam.UdtTypeName = "NUMBER_LIST";
                        command.Parameters.Add(approveListParam);
                        command.Parameters.Add("p_reason", OracleDbType.Varchar2, item.Reason, ParameterDirection.Input);
                        command.ExecuteNonQuery();
                }
            }
        }

        public void ErrorDbProc(PaymentsList item)
        {
            var connection = OraConnector.Handler.UserConnection;
            try
            {
                var command = new OracleCommand("crkr_compen_web.error_act_visa", connection);
                command.CommandType = CommandType.StoredProcedure;

                var approveListParam = new OracleParameter("p_oper_list", OracleDbType.Array, item.id.Length, item.id, ParameterDirection.Input);
                approveListParam.UdtTypeName = "NUMBER_LIST";
                command.Parameters.Add(approveListParam);
                command.Parameters.Add("p_reason", OracleDbType.Varchar2, item.Reason, ParameterDirection.Input);
                command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }
        }
        public List<dynamic> Deposit(TabIndex tabIndex, UserType userType)
        {
            string query = "select * from ";

            switch (userType)
            {
                case UserType.Oper:
                    if(tabIndex == TabIndex.ActDep)
                        query = query.Insert(query.Length, "v_compen_actoper_for_visa_self where oper_type = 5");
                    else if (tabIndex == TabIndex.ActFun)
                        query = query.Insert(query.Length, "v_compen_actoper_for_visa_self where oper_type = 6");
                    else if (tabIndex == TabIndex.ActHer)
                        query = query.Insert(query.Length, "v_compen_actoper_for_visa_self where oper_type = 17");
                    else if (tabIndex == TabIndex.Replen)
                        query = query.Insert(query.Length, "v_compen_wdioper_for_visa_self");                  
                    else if (tabIndex == TabIndex.Canceled)
                        query = query.Insert(query.Length, "v_compen_reqdea_for_visa_self");
                    else if (tabIndex == TabIndex.Benef)
                        query = query.Insert(query.Length, "v_compen_benef_for_visa_self");
                    else if (tabIndex == TabIndex.Document)
                        query = query.Insert(query.Length, "V_COMPEN_CHOPER_FOR_VISA_SELF");
                    break;
                case UserType.Control:
                    if (tabIndex == TabIndex.ActDep)
                        query = query.Insert(query.Length, "v_compen_actoper_for_visa where oper_type = 5");
                    else if (tabIndex == TabIndex.ActFun)
                        query = query.Insert(query.Length, "v_compen_actoper_for_visa where oper_type = 6");
                    else if (tabIndex == TabIndex.ActHer)
                        query = query.Insert(query.Length, "v_compen_actoper_for_visa where oper_type = 17");
                    else if (tabIndex == TabIndex.Replen)
                        query = query.Insert(query.Length, "V_COMPEN_WDIOPER_FOR_VISA");                   
                    else if (tabIndex == TabIndex.Canceled)
                        query = query.Insert(query.Length, "v_compen_reqdeact_for_visa");
                    else if (tabIndex == TabIndex.Benef)
                        query = query.Insert(query.Length, "v_compen_benef_for_visa");
                    else if (tabIndex == TabIndex.Document)
                        query = query.Insert(query.Length, "V_COMPEN_CHOPER_FOR_VISA");
                    break;
            }
            
            List<dynamic> list = null;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                list = connection.Query(query).ToList();
            }
            return list;
        }

        public List<string> Count(UserType userType)
        {
            string query = "select count(*) from ";
            var views = new List<string>();
            var result = new List<string>();
            switch (userType)
            {
                case UserType.Oper:
                    views.Add(query.Insert(query.Length, "v_compen_actoper_for_visa_self where oper_type = 5"));
                    views.Add(query.Insert(query.Length, "v_compen_actoper_for_visa_self where oper_type = 6"));
                    views.Add(query.Insert(query.Length, "v_compen_actoper_for_visa_self where oper_type = 17"));
                    views.Add(query.Insert(query.Length, "v_compen_wdioper_for_visa_self"));
                    views.Add(query.Insert(query.Length, "v_compen_reqdea_for_visa_self"));
                    views.Add(query.Insert(query.Length, "v_compen_benef_for_visa_self"));
                    views.Add(query.Insert(query.Length, "V_COMPEN_CHOPER_FOR_VISA_SELF"));
                    break;
                case UserType.Control:
                    views.Add(query.Insert(query.Length, "v_compen_actoper_for_visa where oper_type = 5"));
                    views.Add(query.Insert(query.Length, "v_compen_actoper_for_visa where oper_type = 6"));
                    views.Add(query.Insert(query.Length, "v_compen_actoper_for_visa where oper_type = 17"));
                    views.Add(query.Insert(query.Length, "V_COMPEN_WDIOPER_FOR_VISA"));
                    views.Add(query.Insert(query.Length, "v_compen_reqdeact_for_visa"));
                    views.Add(query.Insert(query.Length, "v_compen_benef_for_visa"));
                    views.Add(query.Insert(query.Length, "V_COMPEN_CHOPER_FOR_VISA"));
                    break;
               
            }

            List<dynamic> list = null;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                foreach (var item in views)
                {
                    result.Add(connection.Query<string>(item).SingleOrDefault());
                }
            }
            return result;
        }
    }
}
