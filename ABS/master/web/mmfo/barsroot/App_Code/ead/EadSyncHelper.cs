using System;
using Oracle.DataAccess.Client;
using System.Data;
using Bars.EAD.Models;
using Dapper;
using System.Collections.Generic;
using System.Linq;

namespace Bars.EAD
{
    /// <summary>
    /// В даному класі конекшн, щo передається у конструктор НЕ закривається, тому обов'язково завернути його в using
    /// </summary>
    public class EadSyncHelper
    {
        OracleConnection _con;
        public EadSyncHelper(OracleConnection Connection)
        {
            _con = Connection;
        }

        public void UpdateQueueItem(SyncQueueRow row)
        {
            using (OracleCommand cmd = _con.CreateCommand())
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "BARS.EAD_PACK.MSG_SET_MESSAGE";

                cmd.Parameters.Add(new OracleParameter("P_SYNC_ID", OracleDbType.Decimal, row.Id, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("P_STATUS_ID", OracleDbType.Varchar2, row.StatusId, ParameterDirection.Input));

                cmd.Parameters.Add(new OracleParameter("P_MESSAGE_ID", OracleDbType.Varchar2, row.MessageId, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("P_MESSAGE_DATE", OracleDbType.Date, row.MessageDate, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("P_MESSAGE", OracleDbType.Clob, row.Message, ParameterDirection.Input));

                cmd.Parameters.Add(new OracleParameter("P_RESPONCE", OracleDbType.Clob, row.Response, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("P_RESPONCE_ID", OracleDbType.Varchar2, row.ResponseId, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("P_RESPONCE_DATE", OracleDbType.Date, row.ResponseDate, ParameterDirection.Input));

                cmd.Parameters.Add(new OracleParameter("P_ERR_TEXT", OracleDbType.Varchar2, row.ErrorText, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("P_ERR_COUNT", OracleDbType.Decimal, row.ErrorCount, ParameterDirection.Input));

                cmd.ExecuteNonQuery();
            }
        }

        public void MsgDelete(Decimal? syncId, String kf)
        {
            using (OracleCommand cmd = _con.CreateCommand())
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "BARS.BARS.EAD_PACK.MSG_DELETE";

                cmd.Parameters.Add(new OracleParameter("P_SYNC_ID", OracleDbType.Decimal, syncId, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("P_KF", OracleDbType.Varchar2, kf, ParameterDirection.Input));

                cmd.ExecuteNonQuery();
            }
        }

        /// <summary>
        /// Метод отримання системної дати оракла
        /// </summary>
        public DateTime GetSysDate()
        {
            return _con.Query<DateTime>("select sysdate from dual").FirstOrDefault();
        }
        /// <summary>
        /// Метод повертає розмір "пачки" для синхронізації
        /// </summary>
        public int GetMaxCount()
        {
            using (OracleCommand cmd = _con.CreateCommand())
            {
                cmd.CommandText = "select nvl(val, 500) from PARAMS$GLOBAL where par = 'EAD_ROWS'";

                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        public bool ThreadInProcessExists(string kf)
        {
            using (OracleCommand cmd = _con.CreateCommand())
            {
                cmd.CommandText = "select  * from ead_sync_log l where l.crt_date > sysdate - 1/24 and l.finish_date is null and l.kf = :p_kf";
                cmd.Parameters.Add("p_kf", OracleDbType.Varchar2, kf, ParameterDirection.Input);

                object res = cmd.ExecuteScalar();
                if (null == res) return false;

                return Convert.ToInt32(res) != 0;
            }
        }

        public decimal SetSyncStarted(string typeId, string kf)
        {
            using (OracleCommand cmd = _con.CreateCommand())
            {
                cmd.CommandText = "select bars.S_EADSYNCLOG.nextval from dual";
                decimal id = Convert.ToDecimal(cmd.ExecuteScalar());

                cmd.CommandText = "insert into bars.ead_sync_log (id, crt_date, type_id, kf) values(:p_id, :p_crt_date, :p_type_id, :p_kf)";
                cmd.Parameters.Add("p_id", OracleDbType.Decimal, id, ParameterDirection.Input);
                cmd.Parameters.Add("p_crt_date", OracleDbType.Date, DateTime.Now, ParameterDirection.Input);
                cmd.Parameters.Add("p_type_id", OracleDbType.Varchar2, typeId, ParameterDirection.Input);
                cmd.Parameters.Add("p_kf", OracleDbType.Varchar2, kf, ParameterDirection.Input);
                cmd.ExecuteNonQuery();

                return id;
            }
        }

        public List<EadType> GetTypes()
        {
            string sql = @" select 
                                    t.id Id
                                   ,t.name Name
                                   ,t.method Method
                                   ,t.msg_lifetime MsgLifeTime
                                   ,t.msg_retry_interval MsgRetryInterval
                                   ,t.isuo IsUo
                                   ,t.ord ""Order""
                            from bars.ead_types t";
            return _con.Query<EadType>(sql).ToList();
        }
        public List<EadCfg> GetConfigs()
        {
            string sql = @" select kf, modes ""Mode"" from bars.ead_cfg";
            return _con.Query<EadCfg>(sql).ToList();
        }

        public string GetWebConfigProperty(string prop)
        {
            DynamicParameters pars = new DynamicParameters();
            pars.Add("p_prop_name", prop.ToUpper(), DbType.String, ParameterDirection.Input);
            return _con.Query<string>("select val from web_barsconfig where upper(key) = :p_prop_name", pars).FirstOrDefault();
        }

        public void UpdateLogSelect(decimal id, int count, int countError, long execTime)
        {
            using (OracleCommand cmd = _con.CreateCommand())
            {
                cmd.CommandText = "update bars.ead_sync_log set cntrows = :p_count, cntrows_err = :p_count_errors, cntrows_duration = :p_duration where id = :p_id";
                cmd.Parameters.Add("p_count", OracleDbType.Decimal, count, ParameterDirection.Input);
                cmd.Parameters.Add("p_count_errors", OracleDbType.Decimal, countError, ParameterDirection.Input);
                cmd.Parameters.Add("p_duration", OracleDbType.Decimal, RoundExecuteTime(execTime), ParameterDirection.Input);
                cmd.Parameters.Add("p_id", OracleDbType.Decimal, id, ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
        }
        public void UpdateLogFinish(decimal id, int count, int countError, long execTime)
        {
            using (OracleCommand cmd = _con.CreateCommand())
            {
                cmd.CommandText = @"update bars.ead_sync_log set cntrows_done =:p_count, cntrows_responce_err = :p_count_errors, 
                                    cntrows_service_run = :p_duration, finish_date = :p_finish_date where id = :p_id";
                cmd.Parameters.Add("p_count", OracleDbType.Decimal, count, ParameterDirection.Input);
                cmd.Parameters.Add("p_count_errors", OracleDbType.Decimal, countError, ParameterDirection.Input);
                cmd.Parameters.Add("p_duration", OracleDbType.Decimal, RoundExecuteTime(execTime), ParameterDirection.Input);
                cmd.Parameters.Add("p_finish_date", OracleDbType.Date, DateTime.Now, ParameterDirection.Input);
                cmd.Parameters.Add("p_id", OracleDbType.Decimal, id, ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
        }
        private decimal RoundExecuteTime(long execTime)
        {
            return Math.Round((decimal)execTime / 1000, 1);
        }

        public static void DbLoggerInfo(OracleConnection con, string msg)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "bars.bars_audit.info";
                cmd.CommandType = CommandType.StoredProcedure;

                msg = msg.Length > 4000 ? msg.Substring(0, 4000) : msg;
                cmd.Parameters.Add("p_msg", OracleDbType.Varchar2, msg, ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
        }

        public void UpdateSyncSessions(string typeId, DateTime start, DateTime end)
        {
            using (OracleCommand cmd = _con.CreateCommand())
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "BARS.EAD_PACK.UPDATE_SYNC_SESSIONS";

                cmd.Parameters.Add(new OracleParameter("p_type_id", OracleDbType.Varchar2, typeId, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_sync_start", OracleDbType.Date, start, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_sync_end", OracleDbType.Date, end, ParameterDirection.Input));

                cmd.ExecuteNonQuery();
            }
        }
    }
}