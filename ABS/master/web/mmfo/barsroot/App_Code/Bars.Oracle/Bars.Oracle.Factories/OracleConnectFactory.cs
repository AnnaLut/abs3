using Bars.Classes;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for OracleCommandFactory
/// </summary>
namespace Bars.Oracle.Factories
{

    public class OracleConnectFactory
    {
        public OracleConnectFactory()
        {
            //
            // TODO: Add constructor logic here
            //
        }


        private OracleConnection _conn = null;

        //private static OracleDbModel thisInstance;
        //public static OracleDbModel OracleDbModelFactory
        //{
        //    get
        //    {
        //        if (thisInstance == null)
        //            thisInstance = new OracleDbModel();
        //        return thisInstance;
        //    }
        //}
        public void CreateAndSetConn()
        {
            if (_conn == null || _conn.State != ConnectionState.Open)
                _conn = OraConnector.Handler.UserConnection;
        }

        public OracleConnection GetConnOrCreate
        {
            get { return _conn ?? (_conn = OraConnector.Handler.UserConnection); }
        }
        private OracleCommand _command = null;

        public bool IsOpenConnection { get { return _conn != null && _conn.State == ConnectionState.Open; } }
        public OracleCommand GetCommandOrCreate
        {
            get
            {
                if (_command == null)
                {
                    if (_conn == null)
                        _conn = OraConnector.Handler.UserConnection;
                    _command = _conn.CreateCommand();
                    //_command.CommandType = CommandType.StoredProcedure;
                }
                return _command;
            }

        }
        public OracleCommand CreateCommandWithParams(string sql, CommandType type, params OracleParameter[] parameters)
        {
            if (_conn == null)
                _conn = OraConnector.Handler.UserConnection;
            var command = new OracleCommand(sql, _conn);
            command.CommandType = type;
            if (parameters != null && parameters.Length > 0)
            {
                OracleParameterCollection cmdParams = command.Parameters;
                for (var i = 0; i < parameters.Length; i++) { cmdParams.Add(parameters[i]); }
            }
            return command;
        }

        public OracleCommand CreateCommandWithParams(string sql, CommandType type, params object[] parameters)
        {
            if (_conn == null)
                _conn = OraConnector.Handler.UserConnection;
            var command = new OracleCommand(sql, _conn);
            command.CommandType = type;
            if (parameters != null && parameters.Length > 0)
                command.Parameters.AddRange(parameters);
            return command;
        }

        public void ClearParametersFromProc()
        {
            if(_command != null & _command.Parameters !=null)
            _command.Parameters.Clear();
        }
        public OracleDataReader GetDataReader(string storedProcedure, params OracleParameter[] parameters)
        {
            return CreateCommandWithParams(storedProcedure, CommandType.StoredProcedure, parameters).ExecuteReader();
        }

        public OracleDataReader GetDataReader(string storedProcedure,CommandType type, params object[] parameters)
        {
            return CreateCommandWithParams(storedProcedure, type, parameters).ExecuteReader();
        }

        public OracleCommand CreateCommand
        {
            get
            {
                if (_conn == null)
                    _conn = OraConnector.Handler.UserConnection;
                _command = _conn.CreateCommand();
                return _command;
            }

        }
        public OracleCommand GetCommand
        {
            get
            {
                return _command;
            }

        }
        public OracleCommand GetCommandWithBeginTransaction
        {
            get
            {
                if (_command == null)
                {
                    if (_conn == null)
                        _conn = OraConnector.Handler.UserConnection;
                    _command = _conn.CreateCommand();

                    if (_myTransaction == null)
                        _myTransaction = _conn.BeginTransaction();
                    _command.Transaction = _myTransaction;
                }
                //if (command.Transaction == null)
                //    command.Transaction = myTransaction;
                //command.Transaction = myTransaction;
                return _command;
            }

        }
        public OracleConnection GetConnectionWithBeginTransaction
        {
            get
            {
                if (_conn == null)
                {
                    _conn = OraConnector.Handler.UserConnection;
                    _myTransaction = _conn.BeginTransaction();
                }

                //command.Transaction = myTransaction;
                return _conn;
            }
        }

        private OracleTransaction _myTransaction;

        public OracleTransaction MyTransaction
        {
            get { return _myTransaction; }
            set { _myTransaction = value; }
        }

        public bool CommitTransaction()
        {
            this._myTransaction.Commit();
            return true;
        }
        public void Dispose()
        {
            if (_command != null)
            {
                if (_command.Connection.State == ConnectionState.Open)
                    _command.Dispose();
                _command = null;
            }
            if (_conn != null && _conn.State == ConnectionState.Open)
            {
                _conn.Close();
                _conn.Dispose();
                _conn = null;
            }
            if (_myTransaction != null)
            {
                _myTransaction.Dispose();
                _myTransaction = null;
            }

        }

        public void DisposeWithTransaction(bool result)
        {
            if (_myTransaction != null)
            {
                if (result)
                    _myTransaction.Commit();
                else
                    _myTransaction.Rollback();
            }
            this.Dispose();
        }
    }
}