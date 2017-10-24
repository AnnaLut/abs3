using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using Dapper;
using System.Data;
using Oracle.DataAccess.Client;
using Bars.Classes;
using System.IO;
using System.Text;

/// <summary>
/// Summary description for LimitsDirParticipants
/// </summary>
namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation
{
    public class LimitsDirParticipants : ILimitsDirParticipants
    {
        public List<SepParticipantsModel> GetAllParticipantLock()
        {
            var data = new List<SepParticipantsModel>();

            var sql = @"select o.acc,
                               o.mfo,
                               o.kv,
                               o.nms,
                               o.ostc,
                               o.dos,
                               o.kos,
                               o.lim,
                               o.lno,
                               o.mfop,
                               o.lcv,
                               o.nb, 
                               o.ostc + o.res clOstN, 
                               o.ostc + o.res - o.lim clOstNL
                          from (SELECT a.acc,
                                       lkl_rrp.mfo,
                                       lkl_rrp.kv,
                                       a.nms,
                                       a.ostc,
                                       a.dos,
                                       a.kos,
                                       DECODE(c.mfop,
                                              (SELECT F_OURMFO() FROM DUAL),
                                              -a.lim,
                                              lkl_rrp.lim) as LIM,
                                       lkl_rrp.lno,
                                       c.mfop,
                                       v.lcv,
                                       c.nb,
                                       (SELECT sum(a1.ostc)
                                          FROM accounts a1, bank_acc b1
                                         WHERE a1.tip in ('TUR', 'TUD')
                                           and a1.acc = b1.acc
                                           and b1.mfo = b.mfo) res
                                  FROM lkl_rrp, bank_acc b, accounts a, banks c, tabval v
                                 WHERE lkl_rrp.mfo = b.mfo
                                   AND a.kv = lkl_rrp.kv
                                   AND c.mfo = lkl_rrp.mfo
                                   AND a.acc = b.acc
                                   AND a.tip = 'L00'
                                   AND v.kv = lkl_rrp.kv
                                 ORDER BY lkl_rrp.mfo, lkl_rrp.kv) o";
            var p = new DynamicParameters();
            using (var connection = OraConnector.Handler.UserConnection)
            {
                data = connection.Query<SepParticipantsModel>(sql, p).ToList();
            }
       
            return data;
        }
        public List<SepParticipantsHistoryModel> GetAllParticipantLockHistory(string mfo)
        {
            var data = new List<SepParticipantsHistoryModel>();

            var sql = @"SELECT l.DAT,l.USERID,l.LIM,l.LNO,l.DAT_SYS,s.fio
                           FROM lkl_rrp_update l, staff s
                           WHERE l.mfo=:p_mfo and l.USERID =s.id
                           ORDER BY 5 desc";
            var p = new DynamicParameters();
            p.Add("p_mfo", dbType: DbType.Decimal, value: Convert.ToDecimal(mfo), direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                data = connection.Query<SepParticipantsHistoryModel>(sql, p).ToList();
            }

            return data;
        }
        public void SaveAllParticipantChanges(List<SepParticipantsModel> changedData)
        {
            foreach (var item in changedData)
            {               
                var sql_arch = String.Format("UPDATE accounts SET lim=-{0} WHERE acc={1}", item.LIM, item.ACC);
                var sql_update = String.Format("INSERT INTO lkl_rrp_update (mfo,dat,lim,lno,userid,dat_sys) " +
                                                "VALUES({0}, (select GL_UI.get_current_bank_date() CurDate from dual), {1}, {2}, " +
                                                "(select USER_ID from dual), (select SYSDATE from dual)) ", item.MFO, item.LIM, item.LNO);
                var sql_rrp = String.Format("UPDATE lkl_rrp SET lim = {0},  lno= {1} " +
                                            "WHERE mfo = {2} AND kv = {3} ", item.LIM, item.LNO, item.MFO, item.KV);

                OracleTransaction trans = null;
                using (OracleConnection conn = Bars.Classes.OraConnector.Handler.UserConnection)
                {
                    try
                    {
                        trans = conn.BeginTransaction();
                        using (OracleCommand cmd = conn.CreateCommand())
                        {
                            cmd.Transaction = trans;

                            cmd.CommandText = sql_arch;
                            cmd.ExecuteNonQuery();

                            cmd.CommandText = sql_rrp;
                            cmd.ExecuteNonQuery();

                            cmd.CommandText = sql_update;

                            cmd.ExecuteReader();
                            trans.Commit();
                        }
                           
                    }
                    catch (Exception ex)
                    {
                        trans.Rollback();
                        var err = string.Format(" Невідома помилка читання даних з БД:  {0}", (ex.InnerException != null ? ex.InnerException.Message : ex.Message));
                        throw new Exception(err + ex.StackTrace);
                    }
                }
            }
        }

        public void CreateFlagFIle()
        {
            var sql = @"select par_value from sep_params where par_name = 'INFORMATIONAL_FLAGS_DIR'";
            var p = new DynamicParameters();
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var path = connection.Query<string>(sql, p).SingleOrDefault();
                path += @"\K";         
                try
                {

                    // Delete the file if it exists.
                    if (File.Exists(path))
                    {
                        // Note that no lock is put on the
                        // file and the possibility exists
                        // that another process could do
                        // something with it between
                        // the calls to Exists and Delete.
                        File.Delete(path);
                    }

                    // Create the file.
                    using (FileStream fs = File.Create(path))
                    {
                        Byte[] info = new UTF8Encoding(true).GetBytes("");
                        // Add some information to the file.
                        fs.Write(info, 0, info.Length);
                    }
                    
                }

                catch (Exception ex)
                {
                    Console.WriteLine(ex.ToString());
                    var err = string.Format("Невдалося створити файл, або файл вже існує {0}", (ex.InnerException != null ? ex.InnerException.Message : ex.Message));
                    throw new Exception(err + ex.StackTrace);
                }
            }
        }
    }
}
