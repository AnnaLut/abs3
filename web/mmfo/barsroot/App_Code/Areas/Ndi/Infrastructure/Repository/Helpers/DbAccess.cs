using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Bars.Classes;
using Oracle.DataAccess.Client;

/// <summary>
/// Summary description for DbAccess
/// </summary>
namespace BarsWeb.Areas.Ndi.Infrastructure.Repository.Helpers
{
    public class DbAccess : IDisposable
    {

        OracleConnection _connection;
        public OracleCommand CreateCommand(string sql, CommandType type, params OracleParameter[] parameters)
        {
            _connection = OraConnector.Handler.UserConnection;
            var command = new OracleCommand(sql, _connection);
            command.CommandType = type;
            if (parameters != null && parameters.Length > 0)
            {
                OracleParameterCollection cmdParams = command.Parameters;
                for (var i = 0; i < parameters.Length; i++) { cmdParams.Add(parameters[i]); }
            }
            return command;
        }

        public OracleDataReader GetDataReader(string storedProcedure, params OracleParameter[] parameters)
        {
            return CreateCommand(storedProcedure, CommandType.StoredProcedure, parameters).ExecuteReader();
        }

        public static OracleParameter CreateCursorParameter(string name)
        {
            OracleParameter prm = new OracleParameter(name, OracleDbType.RefCursor);
            prm.Direction = ParameterDirection.Output;
            return prm;
        }

        /*
         * Create this parameter when you want to pass Oracle User-Defined Type (Custom Type) which is table of Oracle User-Defined Types.                  
         * This way you can pass mutiple records at once.
         * 
         * Parameters:
         * name - Name of the UDT Parameter name in the Stored Procedure.
         * oracleUDTName - Name of the Oracle User Defined Type with Schema Name. (Make sure this is all caps. For ex: DESTINY.COMPANYINFOLIST)
         * 
         * */
        public static OracleParameter CreateCustomTypeArrayInputParameter(string name, string oracleUDTName, FilterRowInfo[] value)
        {
            OracleParameter parameter = new OracleParameter();
            parameter.ParameterName = name;
            parameter.OracleDbType = OracleDbType.Array;
            parameter.Direction = ParameterDirection.Input;
            parameter.UdtTypeName = oracleUDTName;
            parameter.Value = value;
            return parameter;
        }

        #region IDisposable Members

        public void Dispose()
        {
            if (_connection != null)
            {
                _connection.Close();
                _connection = null;
            }


        }

        #endregion
    }
}
