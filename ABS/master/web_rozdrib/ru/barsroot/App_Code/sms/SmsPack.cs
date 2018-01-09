using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;

namespace Bars.SMS
{
    /// <summary>
    /// клас для роботи з СМС повідомленнями
    /// </summary>
    public class SmsPack : BbPackage
    {
        public SmsPack(BbConnection Connection, AutoCommit AutoCommitMode) : base(Connection, AutoCommitMode) { }
        public SmsPack(BbConnection Connection) : base(Connection, AutoCommit.Enabled) { }

        /// <summary>
        /// проставлення статусу повідомленя та референсу після відпрвки
        /// </summary>
        /// <param name='P_MESSAGE_ID'>внутрішній ідентифікатор СМС</param>
        /// <param name='P_MESSAGE_REF'>ідентифікатор СМС в системі розсилки для проставлення стутусу доставки</param>
        /// <param name='P_MESSAGE_STATUS'>статус СМС</param>
        public void MSG_SET_REF(Decimal P_MESSAGE_ID, String P_MESSAGE_REF, String P_MESSAGE_STATUS)
        {
            try
            {
                List<OracleParameter> parameters = new List<OracleParameter>();
                parameters.Add(new OracleParameter("P_MSG_ID", OracleDbType.Decimal, P_MESSAGE_ID, ParameterDirection.Input));
                parameters.Add(new OracleParameter("P_MSG_REF", OracleDbType.Varchar2, P_MESSAGE_REF, ParameterDirection.Input));
                parameters.Add(new OracleParameter("P_STATUS", OracleDbType.Varchar2, P_MESSAGE_STATUS, ParameterDirection.Input));
                object ReturnValue = null;
                ExecuteNonQuery("bars.bars_sms_smpp.set_msg_ref", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// проставлення статусу доставки повідомленя
        /// </summary>
        /// <param name='P_MESSAGE_REF'>ідентифікатор СМС в системі розсилки для проставлення стутусу доставки</param>
        /// <param name='P_MESSAGE_STATUS'>статус СМС</param>
        public void MSG_SET_STATUS(String P_MESSAGE_REF, String P_MESSAGE_STATUS)
        {
            try
            {
                List<OracleParameter> parameters = new List<OracleParameter>();
                parameters.Add(new OracleParameter("P_MSG_REF", OracleDbType.Varchar2, P_MESSAGE_REF, ParameterDirection.Input));
                parameters.Add(new OracleParameter("P_STATUS", OracleDbType.Varchar2, P_MESSAGE_STATUS, ParameterDirection.Input));
                object ReturnValue = null;
                ExecuteNonQuery("bars.bars_sms_smpp.set_msg_status", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// протокол помилок при передачі/підтвердженні повідомленя
        /// </summary>
        /// <param name='P_EXCEPTION_TXT'> текст помилки/протоколу</param>
        public void MSG_SAVE_EXCEPTION(String P_EXCEPTION_TXT)
        {
            try
            {
                List<OracleParameter> parameters = new List<OracleParameter>();
                parameters.Add(new OracleParameter("P_LOG_TXT", OracleDbType.Varchar2, P_EXCEPTION_TXT, ParameterDirection.Input));
                object ReturnValue = null;
                ExecuteNonQuery("bars.bars_sms_smpp.save_log", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
        }

    }
}