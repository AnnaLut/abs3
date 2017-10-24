using System;
using System.Data;
using System.Linq;
using Bars.Classes;
using Oracle.DataAccess.Client;
using Areas.AdmSecurity.Models;
using BarsWeb.Areas.AdmSecurity.Infrastructure.Repository.DI.Abstract;
using Bars.Oracle;

namespace BarsWeb.Areas.AdmSecurity.Infrastructure.Repository.DI.Implementation
{
    public class SecurityConfirmRepository : ISecurityConfirmRepository
    {
        Entities _entities;
        public SecurityConfirmRepository(ISecurityModel model)
        {
            _entities = model.Entities;
        }

        public IQueryable<V_APPROVABLE_RESOURCE_GROUP> ResourceConfirmTabsData()
        {
            return _entities.V_APPROVABLE_RESOURCE_GROUP;
        }

        public IQueryable<V_APPROVABLE_RESOURCE> ResourceConfirmData()
        {
            return _entities.V_APPROVABLE_RESOURCE;
        }

        public void ApproveResourceAccess(string id, string approveList, string comment)
        {
            decimal[] approve = String.IsNullOrEmpty(approveList) ? new decimal[0] : approveList.Split(',').Select(decimal.Parse).ToArray();

            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.security_ui.approve_resource_access", connection);
                command.CommandType = CommandType.StoredProcedure;

                OracleParameter approveListParam = new OracleParameter("p_activities_list", OracleDbType.Array, approve.Length, (NumberList)approve, ParameterDirection.Input);
                approveListParam.UdtTypeName = "BARS.NUMBER_LIST";
                command.Parameters.Add(approveListParam);
                command.Parameters.Add("p_approvement_comment", OracleDbType.Varchar2, comment, ParameterDirection.Input);
                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }

        public void RejectResourceAccess(string id, string rejectList, string comment)
        {
            decimal[] reject = String.IsNullOrEmpty(rejectList) ? new decimal[0] : rejectList.Split(',').Select(decimal.Parse).ToArray();

            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.security_ui.reject_resource_access", connection);
                command.CommandType = CommandType.StoredProcedure;

                OracleParameter rejectListParam = new OracleParameter("p_activities_list", OracleDbType.Array, reject.Length, (NumberList)reject, ParameterDirection.Input);
                rejectListParam.UdtTypeName = "BARS.NUMBER_LIST";
                command.Parameters.Add(rejectListParam);
                command.Parameters.Add("p_rejection_comment", OracleDbType.Varchar2, comment, ParameterDirection.Input);
                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }
    }
}