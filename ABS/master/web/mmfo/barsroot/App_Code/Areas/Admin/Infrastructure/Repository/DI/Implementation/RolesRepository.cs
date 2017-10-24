using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Areas.Admin.Models;
using Bars.Classes;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models.Roles;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using CommandType = System.Data.CommandType;
using System.Collections;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Implementation
{
    public class RolesRepository : IRolesRepository
    {
        private Entities _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        public RolesRepository(IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter, IAdminModel model)
        {
            _entities = model.Entities;
            _sqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter; 
        }

        #region Roles Adm
        public IQueryable<V_STAFF_ROLE_ADM> GetRoles(string parameter)
        {
            //return _entities.V_STAFF_ROLE_ADM;
           
            string query = string.Format(@"
                    select * from V_STAFF_ROLE_ADM
                    {0}", String.IsNullOrEmpty(parameter) ? "" : " where " + parameter);

            return _entities.ExecuteStoreQuery<V_STAFF_ROLE_ADM>(query).AsQueryable();
        }

        #endregion

        #region Roles Functions

        public decimal CreateRole(string code, string name)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.user_role_adm_ui.create_role", connection);
                command.CommandType = CommandType.StoredProcedure;
                OracleParameter roleId = new OracleParameter("role_id", OracleDbType.Int32,
                    ParameterDirection.ReturnValue);
                command.Parameters.Add(roleId);

                command.Parameters.Add("p_role_code", OracleDbType.Varchar2, code, ParameterDirection.Input);
                command.Parameters.Add("p_role_name", OracleDbType.Varchar2, name, ParameterDirection.Input);

                command.ExecuteNonQuery();

                return ((OracleDecimal)roleId.Value).Value;
            }
            finally
            {
                connection.Close();
            }
        }

        public void EditRole(string code, string name)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.user_role_adm_ui.edit_role", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_role_code", OracleDbType.Varchar2, code, ParameterDirection.Input);
                command.Parameters.Add("p_role_name", OracleDbType.Varchar2, name, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }

        public void LockRole(string code)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.user_role_adm_ui.lock_role", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_role_code", OracleDbType.Varchar2, code, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }

        public void DeleteRole(string code)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.user_role_adm_ui.close_role", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_role_code", OracleDbType.Varchar2, code, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }
        

        public void UnlockRole(string code)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.user_role_adm_ui.unlock_role", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_role_code", OracleDbType.Varchar2, code, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }

        #endregion

        public IQueryable<V_ROLE_RESOURCE> GetRoleResources(string id, string code)
        {
            //return _entities.V_ROLE_RESOURCE;
            const string query = @"select * from V_ROLE_RESOURCE where ROLE_ID = :p_id and RESOURCE_TYPE_ID = :p_code";
            var parameters = new object[]
            {
                new OracleParameter("p_id", OracleDbType.Decimal) {Value = id},
                new OracleParameter("p_code", OracleDbType.Decimal) {Value = code}
            };

            return _entities.ExecuteStoreQuery<V_ROLE_RESOURCE>(query, parameters).AsQueryable();
        }

        public IQueryable<V_ROLE_RESOURCE_TYPE_LOOKUP> GetResourceTypeLookups()
        {
            return _entities.V_ROLE_RESOURCE_TYPE_LOOKUP;
        }

        public IQueryable<V_ROLE_RESOURCE_ACCESS_MODE> GetResourceAccessModes()
        {
            return _entities.V_ROLE_RESOURCE_ACCESS_MODE;
        }

        public void SetResourceAccessMode(string roleCode, string resourceTypeId, string resourceId, string accessModeId)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.USER_ROLE_ADM_UI.set_resource_access_mode", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_role_code", OracleDbType.Varchar2, roleCode, ParameterDirection.Input);
                command.Parameters.Add("p_resource_type_id", OracleDbType.Decimal, resourceTypeId, ParameterDirection.Input);
                command.Parameters.Add("p_resource_id", OracleDbType.Decimal, resourceId, ParameterDirection.Input);
                command.Parameters.Add("p_access_mode_id", OracleDbType.Decimal, accessModeId, ParameterDirection.Input);
                
                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }

    }
}