using Bars.Classes;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for OracleDbModel
/// </summary>
public class OracleDbModel : IDisposable
{
    public OracleDbModel()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    private OracleConnection conn = null;

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
    public OracleConnection GetConn
    {
        get
        {
            if (conn == null)
                conn = OraConnector.Handler.UserConnection;
            return conn;
        }

    }
    private OracleCommand command = null;

    public OracleCommand GetCommandOrCreate
    {
        get
        {
            if (command == null)
            {
                if (conn == null)
                    conn = OraConnector.Handler.UserConnection;
                command = conn.CreateCommand();
            }
            return command;
        }

    }
    public OracleCommand CreateCommand
    {
        get
        {
            if (conn == null)
                conn = OraConnector.Handler.UserConnection;
            OracleCommand command = conn.CreateCommand();
            return command;
        }

    }
    public OracleCommand GetCommand
    {
        get
        {
            return command;
        }

    }
    public OracleCommand GetCommandWithBeginTransaction
    {
        get
        {
            if (command == null)
            {
                if (conn == null)
                    conn = OraConnector.Handler.UserConnection;
                command = conn.CreateCommand();
            }
            if (myTransaction == null)
                myTransaction = conn.BeginTransaction();
            //if (command.Transaction == null)
            //    command.Transaction = myTransaction;
            //command.Transaction = myTransaction;
            return command;
        }

    }
    public OracleConnection GetConnectionWithBeginTransaction
    {
        get
        {
            if (conn == null)
            {
                conn = OraConnector.Handler.UserConnection;
                myTransaction = conn.BeginTransaction();
            }

            //command.Transaction = myTransaction;
            return conn;
        }
    }

    private OracleTransaction myTransaction;

    public OracleTransaction MyTransaction
    {
        get { return myTransaction; }
        set { myTransaction = value; }
    }
    public void Dispose()
    {
        if (command != null)
        {
            if (command.Connection.State == ConnectionState.Open)
                command.Dispose();
            command = null;
        }
        if (conn != null && conn.State == ConnectionState.Open)
        {
            conn.Close();
            conn.Dispose();
            conn = null;
        }
        if (myTransaction != null)
        {
            myTransaction.Dispose();
            myTransaction = null;
        }

    }

    public void DisposeWithTransaction(bool result)
    {
        if (myTransaction != null)
        {
            if (result)
                myTransaction.Commit();
            else
                myTransaction.Rollback();
        }
        this.Dispose();
    }
}