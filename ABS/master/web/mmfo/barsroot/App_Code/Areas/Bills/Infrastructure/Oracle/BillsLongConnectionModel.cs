using Bars.Oracle;
using Oracle.DataAccess.Client;
using System;
using System.Data;
using System.Web;

namespace BarsWeb.Areas.Bills.Infrastructure
{
    /// <summary>
    /// Вспомогательный класс хранящий объекты для открытого соединения к БД!
    /// </summary>
    public class BillsLongConnectionModel: IDisposable
    {
        public OracleConnection connection;
        public OracleCommand command;
        public OracleTransaction transaction;

        public void OpenConnection(IOraConnection connect, Boolean isProcedure)
        {
            if (connection == null)
            {
                connection = connect.GetUserConnection(HttpContext.Current);
                if(connection.State != ConnectionState.Open)
                    connection.Open();
                command = connection.CreateCommand();
                transaction = connection.BeginTransaction(IsolationLevel.ReadCommitted);
                command.Transaction = transaction;
            }
            if (connection.State == ConnectionState.Closed)
                connection.Open();
            if (isProcedure)
                command.CommandType = CommandType.StoredProcedure;
            else
                command.CommandType = CommandType.Text;
            command.BindByName = true;
        }

        public void RollbackTransaction()
        {
            if (transaction != null)
                transaction.Rollback();
        }

        public void CloseConnection()
        {
            if (connection != null)
            {
                connection.Close();
                connection.Dispose();
            }
            connection = null;
            if (command != null)
                command.Dispose();
            command = null;
            transaction = null;
        }

        public void Dispose()
        {            
            CloseConnection();
            this.Dispose();
        }
    }
}