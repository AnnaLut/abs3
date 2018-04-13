using System;
using System.Data;
using Areas.Messages.Models;
using BarsWeb.Areas.Messages.Infrastructure.Repository.DI.Abstract;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Messages.Infrastructure.Repository.DI.Implementation
{
    public class TalkerRepository : ITalkerRepository , IDisposable
    {
        readonly MessagesEntities _entities;
        public TalkerRepository(IMessagesModel model)
        {
            _entities = model.MessagesEntities;
        }

        public int SetUserMessage(string userName, string message, int type = 1)
        {
            object[] parameters =         
            { 
                new OracleParameter("p_username",OracleDbType.Varchar2){Value=userName},
                new OracleParameter("p_message",OracleDbType.Varchar2){Value=message},
                new OracleParameter("p_type",OracleDbType.Decimal){Value=type}
            };
            const string sql = @"begin bms.push_msg_web(:p_username,:p_message,:p_type);end;";

            return _entities.ExecuteStoreCommand(sql, parameters);
        }

        public void Dispose()
        {
            if (_entities.Connection.State == ConnectionState.Open)
                _entities.Connection.Close();
            _entities.Dispose();
        }
    }
}