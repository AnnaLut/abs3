using System.Linq;
using System.Collections.Generic;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System;
using Dapper;
using System.IO;
using System.Text;
using System.Data;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation
{
    public class SepLockDocViewRepository : ISepLockDocViewRepository
    {
        public IQueryable<SepLockView> GetLockDoc(decimal rec)
        {
            List<SepLockView> rList = new List<SepLockView>();

            //OracleConnection connection = OraConnector.Handler.UserConnection;
            //OracleCommand cmd = connection.CreateCommand();
            //try
            //{
            //    cmd.CommandType = System.Data.CommandType.Text;
            //    cmd.CommandText = @"select  r.rec,
            //                               r.mfoa,
            //                               r.mfob,
            //                               r.nlsa,
            //                               r.nlsb,
            //                               r.nam_a,
            //                               r.nam_b,
            //                               r.s/100,
            //                               BARS.f_sumpr (r.s,r.kv,'F') as sprop,
            //                               t.lcv,
            //                               r.nazn,
            //                               r.dat_a,
            //                               r.datp,
            //                               r.fn_a,
            //                               r.id_a,
            //                               r.id_b,
            //                               f_dat_lit(r.dat_a) as dat_prop,
            //                               (select nb from banks where mfo = r.mfoa) as bank_a,
            //                               (select nb from banks where mfo = r.mfob) as bank_b,
            //                               upper(v.name) as vob_name,
            //                               a.DAT_2, a.DATK
            //                               --a.*,
            //                               --b.*

            //                          from arc_rrp r,
            //                               rec_que q,
            //                               tabval t,
            //                               vob v,
            //                               zag_a a,
            //                               zag_b b
            //                         where r.kv = t.kv
            //                           and r.s > 0
            //                           and r.blk > 0
            //                           and r.fn_b IS NULL
            //                           and r.rec = q.rec(+)
            //                           and r.vob = v.vob
            //                           and r.ref is null
            //                           and r.rec = :p_rec
            //                           and r.fn_a = A.FN(+) and R.DAT_A = a.dat(+)
            //                           and r.fn_b = b.FN(+) and R.DAT_B = b.dat(+) ";
            //    cmd.Parameters.Add("p_rec", OracleDbType.Decimal, rec, System.Data.ParameterDirection.Input);
            //    OracleDataReader reader = cmd.ExecuteReader();

            //    while (reader.Read())
            //    {
            //        SepLockView r = new SepLockView();
            //        r.recid = String.IsNullOrEmpty(reader.GetValue(0).ToString()) ? (decimal?)null : reader.GetDecimal(0);
            //        r.mfoa = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : reader.GetString(1);
            //        r.mfob = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? String.Empty : reader.GetString(2);
            //        r.nlsa = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? String.Empty : reader.GetString(3);
            //        r.nlsb = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? String.Empty : reader.GetString(4);
            //        r.nama = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? String.Empty : reader.GetString(5);
            //        r.namb = String.IsNullOrEmpty(reader.GetValue(6).ToString()) ? String.Empty : reader.GetString(6);
            //        r.s = String.IsNullOrEmpty(reader.GetValue(7).ToString()) ? (decimal?)null : reader.GetDecimal(7);
            //        r.sprop = String.IsNullOrEmpty(reader.GetValue(8).ToString()) ? String.Empty : reader.GetString(8);
            //        r.lcv = String.IsNullOrEmpty(reader.GetValue(9).ToString()) ? String.Empty : reader.GetString(9);
            //        r.nazn = String.IsNullOrEmpty(reader.GetValue(10).ToString()) ? String.Empty : reader.GetString(10);
            //        r.data = String.IsNullOrEmpty(reader.GetValue(11).ToString()) ? (DateTime?)null : reader.GetDateTime(11);
            //        r.datp = String.IsNullOrEmpty(reader.GetValue(12).ToString()) ? (DateTime?)null : reader.GetDateTime(12);
            //        r.fna = String.IsNullOrEmpty(reader.GetValue(13).ToString()) ? String.Empty : reader.GetString(13);
            //        r.ida = String.IsNullOrEmpty(reader.GetValue(14).ToString()) ? String.Empty : reader.GetString(14);
            //        r.idb = String.IsNullOrEmpty(reader.GetValue(15).ToString()) ? String.Empty : reader.GetString(15);
            //        r.datprop = String.IsNullOrEmpty(reader.GetValue(16).ToString()) ? String.Empty : reader.GetString(16);
            //        r.banka = String.IsNullOrEmpty(reader.GetValue(17).ToString()) ? String.Empty : reader.GetString(17);
            //        r.bankb = String.IsNullOrEmpty(reader.GetValue(18).ToString()) ? String.Empty : reader.GetString(18);
            //        r.vobname = String.IsNullOrEmpty(reader.GetValue(19).ToString()) ? String.Empty : reader.GetString(19);
            //        r.dat_2 = String.IsNullOrEmpty(reader.GetValue(20).ToString()) ? (DateTime?)null : reader.GetDateTime(11);
            //        r.datk = String.IsNullOrEmpty(reader.GetValue(21).ToString()) ? (DateTime?)null : reader.GetDateTime(12);
            //        rList.Add(r);
            //    }
            //    }
            //        finally
            //        {
            //            cmd.Dispose();
            //            connection.Dispose();
            //            connection.Close();
            //        }
            //var data = new List<SepParticipantsModel>();

            try
            {
                var sql = @"select  r.rec,
                                    r.mfoa,
                                    r.mfob,
                                    r.nlsa,
                                    r.nlsb,
                                    r.nam_a,
                                    r.nam_b,
                                    r.s/100 as s,
                                    BARS.f_sumpr (r.s,r.kv,'F') as sprop,
                                    t.lcv,
                                    r.nazn,
                                    r.dat_a,
                                    r.datp,
                                    r.fn_a,
                                    r.id_a,
                                    r.id_b,
                                    f_dat_lit(r.dat_a) as dat_prop,
                                    (select nb from banks where mfo = r.mfoa) as bank_a,
                                    (select nb from banks where mfo = r.mfob) as bank_b,
                                    upper(v.name) as vob_name,
                                    a.DAT_2, a.DATK
                                    --a.*,
                                    --b.*     
                                from arc_rrp r,
                                    rec_que q,
                                    tabval t,
                                    vob v,
                                    zag_a a,
                                    zag_b b
                                where r.kv = t.kv
                                and r.s > 0
                                and r.blk > 0
                                and r.fn_b IS NULL
                                and r.rec = q.rec(+)
                                and r.vob = v.vob
                                and r.ref is null
                                and r.rec = :p_rec
                                and r.fn_a = A.FN(+) and R.DAT_A = a.dat(+)
                                and r.fn_b = b.FN(+) and R.DAT_B = b.dat(+) ";
                var p = new DynamicParameters();
                p.Add("p_rec", dbType: DbType.Decimal, value: rec, direction: ParameterDirection.Input);
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    rList = connection.Query<SepLockView>(sql, p).ToList();
                }
            }
            catch (Exception ex)
            {

            }



            return rList.AsQueryable();
        }
    }
}