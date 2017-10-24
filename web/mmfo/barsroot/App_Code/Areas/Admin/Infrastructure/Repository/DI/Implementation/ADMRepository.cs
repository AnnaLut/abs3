using System;
using System.Data;
using System.Data.Objects;
using System.Linq;
using Areas.Admin.Models;
using Bars.Classes;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Kendo.Mvc.UI;
using CommandType = System.Data.CommandType;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Implementation
{
    public class ADMRepository : IADMRepository
    {
        Entities _entities;

        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        public ADMRepository(IAdminModel model, IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter)
        {
            _entities = model.Entities;
            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }

        public IQueryable<V_APPLIST_ADM> GetADMList()
        {
            return _entities.V_APPLIST_ADM;
        }

        public decimal CreateAdmItem(string admCode, string admName, string appType)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.USER_MENU_ADM_UI.create_arm", connection);
                command.CommandType = CommandType.StoredProcedure;

                OracleParameter result = new OracleParameter("result", OracleDbType.Int32,
                    ParameterDirection.ReturnValue);
                command.Parameters.Add(result);

                command.Parameters.Add("p_arm_code", OracleDbType.Varchar2, admCode, ParameterDirection.Input);
                command.Parameters.Add("p_arm_name", OracleDbType.Varchar2, admName, ParameterDirection.Input);

                var appTypeValue = Decimal.Parse(appType);
                command.Parameters.Add("p_application_type_id", OracleDbType.Decimal, appTypeValue, ParameterDirection.Input);

                command.ExecuteNonQuery();

                return ((OracleDecimal)result.Value).Value;
            }
            finally
            {
                connection.Close();
            }
        }

        public void EditAdmItem(string admCode, string admName, string appType)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.USER_MENU_ADM_UI.edit_arm", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_arm_code", OracleDbType.Varchar2, admCode, ParameterDirection.Input);
                command.Parameters.Add("p_arm_name", OracleDbType.Varchar2, admName, ParameterDirection.Input);

                var appTypeValue = Decimal.Parse(appType);
                command.Parameters.Add("p_application_type_id", OracleDbType.Decimal, appTypeValue, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }

        public IQueryable<V_ARM_RESOURCE> GetAdmResources(string id, string code)
        {
            //return _entities.V_ARM_RESOURCE;
            var parameters = new object[]
            {
                new OracleParameter("p_id", OracleDbType.Decimal) {Value = id},
                new OracleParameter("p_code", OracleDbType.Decimal) {Value = code}
            };

            const string query = @"select * from V_ARM_RESOURCE where ARM_ID = :p_id and RESOURCE_TYPE_ID = :p_code";

            //var sql = _sqlTransformer.TransformSql(new BarsSql() {SqlText = query}, request);  sql.SqlText

            return _entities.ExecuteStoreQuery<V_ARM_RESOURCE>(query, parameters).AsQueryable();
        }

        public IQueryable<V_ARM_RESOURCE_TYPE_LOOKUP> GetAdmResourceTypeLookups()
        {
            return _entities.V_ARM_RESOURCE_TYPE_LOOKUP;
        }

        public IQueryable<V_ARM_RESOURCE_ACCESS_MODE> GetAdmAccessModes(string id, string code)
        {
            var typeId = Decimal.Parse(id);
            return _entities.V_ARM_RESOURCE_ACCESS_MODE.Where(x => x.ID == typeId && x.ARM_CODE == code);
        }

        public void SetAdmResourceAccessMode(string armCode, string resourceTypeId, string resourceId, string accessModeId)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.USER_MENU_ADM_UI.set_resource_access_mode", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_arm_code", OracleDbType.Varchar2, armCode, ParameterDirection.Input);
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


        public decimal CheckAdmHasResources(string code)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.user_menu_adm_ui.check_if_arm_has_resources", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("result", OracleDbType.Decimal, ParameterDirection.ReturnValue);
                command.Parameters.Add("p_arm_code", OracleDbType.Varchar2, code, ParameterDirection.Input);

                command.ExecuteNonQuery();

                var result = ((OracleDecimal)command.Parameters["result"].Value).Value; 

                return result;
            }
            finally
            {
                connection.Close();
            }
        }

        public void RemoveAdm(string code)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.user_menu_adm_ui.remove_arm", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_arm_code", OracleDbType.Varchar2, code, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }
    }
}
