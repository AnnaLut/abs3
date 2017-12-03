using System;
using System.Data;
using Bars.Classes;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Ndi.Models
{
    /// <summary>
    /// Summary description for OracleDbModel
    /// </summary>
    public class OracleDbModel// : IDisposable
    {
        public OracleDbModel()
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