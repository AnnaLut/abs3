using System;
using System.Collections.Generic;
using System.Data;
using Bars.Classes;
using BarsWeb.Areas.Mbdk.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Mbdk.Models;
using Oracle.DataAccess.Client;
using System.Linq;

namespace BarsWeb.Areas.Mbdk.Infrastructure.DI.Implementation
{
    public class NostroRepository : INostroRepository
    {
        public List<NostroPortfolioRow> GetNostroList()
        {
            List<NostroPortfolioRow> rows = new List<NostroPortfolioRow>();
            using (OracleConnection conn = OraConnector.Handler.UserConnection)
            using(OracleCommand cmd = conn.CreateCommand())
            {
                try
                {
                    cmd.CommandText = @"select t.nd, t.ndi, t.rnk, c.nmk, t.kv, tb.name, t.nls, t.acc, t.mfo, t.bic, t.cc_id, t.sdate, 
                    t.wdate, t.limit, t.fin23, fin.name, t.obs23, ob23.name, t.kat23, k23.name, t.k23, t.sos, t.ir, t.sdog, t.branch, t.prod, t.fin_351, t.pd  
                    from NOSTRO_DEAL t, tabval tb, customer c, stan_kat23 k23, stan_fin fin, stan_obs23 ob23
                    where t.kv = tb.kv and t.rnk = c.rnk and t.kat23 = k23.kat(+) and t.fin23 = fin.fin and t.obs23 = ob23.obs(+)";
                    using(OracleDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            NostroPortfolioRow nostro = new NostroPortfolioRow();
                            nostro.ND = (ulong)reader.GetInt64(0);
                            nostro.NDI = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? (ulong?)null : (ulong)reader.GetInt64(1);
                            nostro.RNK = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? (ulong?)null : (ulong)reader.GetInt64(2);
                            nostro.NMK = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? String.Empty : reader.GetString(3);
                            nostro.KV = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? (short?)null : reader.GetInt16(4);
                            nostro.KV_NAME = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? String.Empty : reader.GetString(5);
                            nostro.NLS = String.IsNullOrEmpty(reader.GetValue(6).ToString()) ? String.Empty : reader.GetString(6);
                            nostro.ACC = (ulong)reader.GetInt64(7);
                            nostro.MFO = String.IsNullOrEmpty(reader.GetValue(8).ToString()) ? String.Empty : reader.GetString(8);
                            nostro.BIC = String.IsNullOrEmpty(reader.GetValue(9).ToString()) ? String.Empty : reader.GetString(9);
                            nostro.CC_ID = String.IsNullOrEmpty(reader.GetValue(10).ToString()) ? String.Empty : reader.GetString(10);
                            nostro.SDATE = String.IsNullOrEmpty(reader.GetValue(11).ToString()) ? (DateTime?)null : reader.GetDateTime(11);
                            nostro.WDATE = String.IsNullOrEmpty(reader.GetValue(12).ToString()) ? (DateTime?)null : reader.GetDateTime(12);
                            nostro.LIMIT = String.IsNullOrEmpty(reader.GetValue(13).ToString()) ? (decimal?)null : reader.GetDecimal(13);
                            nostro.FIN23 = String.IsNullOrEmpty(reader.GetValue(14).ToString()) ? (byte?)null : reader.GetByte(14);
                            nostro.FIN_NAME = String.IsNullOrEmpty(reader.GetValue(15).ToString()) ? String.Empty : reader.GetString(15);
                            nostro.OBS23 = String.IsNullOrEmpty(reader.GetValue(16).ToString()) ? (byte?)null : reader.GetByte(16);
                            nostro.OBS_NAME = String.IsNullOrEmpty(reader.GetValue(17).ToString()) ? String.Empty : reader.GetString(17);
                            nostro.KAT23 = String.IsNullOrEmpty(reader.GetValue(18).ToString()) ? (byte?)null : reader.GetByte(18);
                            nostro.KAT_NAME = String.IsNullOrEmpty(reader.GetValue(19).ToString()) ? String.Empty : reader.GetString(19);
                            nostro.K23 = String.IsNullOrEmpty(reader.GetValue(20).ToString()) ? (float?)null : reader.GetFloat(20);
                            nostro.SOS = String.IsNullOrEmpty(reader.GetValue(21).ToString()) ? (byte?)null : reader.GetByte(21);
                            nostro.IR = String.IsNullOrEmpty(reader.GetValue(22).ToString()) ? (float?)null : reader.GetFloat(22);
                            nostro.SDOG = String.IsNullOrEmpty(reader.GetValue(23).ToString()) ? (decimal?)null : reader.GetDecimal(23);
                            nostro.BRANCH = String.IsNullOrEmpty(reader.GetValue(24).ToString()) ? String.Empty : reader.GetString(24);
                            nostro.PROD = String.IsNullOrEmpty(reader.GetValue(25).ToString()) ? String.Empty : reader.GetString(25);
                            nostro.FIN_351 = String.IsNullOrEmpty(reader.GetValue(26).ToString()) ? (byte?)null : reader.GetByte(26);
                            nostro.PD = String.IsNullOrEmpty(reader.GetValue(27).ToString()) ? (decimal?)null : reader.GetDecimal(27);
                            if (nostro.NLS.StartsWith("1500"))
                            {
                                using (OracleCommand command = conn.CreateCommand())
                                {
                                    command.CommandText = @"select s.nkd, f_acc_tag(p_acc => :acc, p_tag  => 'DKD') from specparam s where s.acc = :acc";
                                    command.Parameters.Add("acc", OracleDbType.Int64, nostro.ACC, ParameterDirection.Input);
                                    using (OracleDataReader rdr = command.ExecuteReader())
                                    {
                                        if (rdr.Read())
                                        {
                                            nostro.NKD = (rdr.GetValue(0) ?? String.Empty).ToString();
                                            nostro.DKD = (rdr.GetValue(1) ?? String.Empty).ToString();
                                        }
                                    }
                                }
                            }

                            rows.Add(nostro);
                        }
                    }
                    return rows;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }

        public void PulSetMasIni(string nd)
        {
            QueryTemplate(@"bars.PUL.Set_Mas_Ini", new OracleParameter[]{
                new OracleParameter("tag_", OracleDbType.Varchar2, "ND", ParameterDirection.Input),
                new OracleParameter("tag_", OracleDbType.Varchar2, nd, ParameterDirection.Input),
                new OracleParameter("comm_", OracleDbType.Varchar2, String.Empty, ParameterDirection.Input)
            });
        }

        public void InsertNostro(InsertNostroPortfolioRow row)
        {
            QueryTemplate(@"bars.prvn_flow.nos_ins", new OracleParameter[]{
                new OracleParameter("p_kv", OracleDbType.Int32, row.KV, ParameterDirection.Input),
                new OracleParameter("p_nls", OracleDbType.Varchar2, row.NLS, ParameterDirection.Input)
            });
        }

        public void UpdateNostro(UpdateNostroPortfolioRow row)
        {
            QueryTemplate(@"bars.prvn_flow.nos_upd", new OracleParameter[]{
                new OracleParameter("p_nd", OracleDbType.Int64, row.ND, ParameterDirection.Input),
                new OracleParameter("p_sos", OracleDbType.Int32, row.SOS, ParameterDirection.Input),
                new OracleParameter("p_CC_ID", OracleDbType.Varchar2, row.CC_ID, ParameterDirection.Input),
                new OracleParameter("p_SDATE", OracleDbType.Date, row.SDATE, ParameterDirection.Input),
                new OracleParameter("p_WDATE", OracleDbType.Date, row.WDATE, ParameterDirection.Input),
                new OracleParameter("p_LIMIT", OracleDbType.Decimal, row.LIMIT, ParameterDirection.Input),
                new OracleParameter("p_FIN23", OracleDbType.Int32, row.FIN23, ParameterDirection.Input),
                new OracleParameter("p_OBS23", OracleDbType.Int32, row.OBS23, ParameterDirection.Input),
                new OracleParameter("p_KAT23", OracleDbType.Int32, row.KAT23, ParameterDirection.Input),
                new OracleParameter("p_pd", OracleDbType.Decimal, row.PD, ParameterDirection.Input),
                new OracleParameter("p_FIN_351", OracleDbType.Int32, row.FIN_351, ParameterDirection.Input)
            });
        }

        public void DeleteNostro(decimal nd)
        {
            QueryTemplate(@"bars.prvn_flow.nos_del", new OracleParameter[]{
                new OracleParameter("p_nd", OracleDbType.Decimal, nd, ParameterDirection.Input)
            });
        }

        public NostroDataList GetDataList()
        {
            NostroDataList lst = new NostroDataList();
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                lst.FIN = GetList(connection, @"select fin, name from STAN_FIN order by fin");
                lst.OBS23 = GetList(connection, @"select obs, name from STAN_OBS23 order by obs");
                lst.KAT23 = GetList(connection, @"select kat, name from STAN_KAT23 order by kat");
                lst.KV = GetList(connection, @"select kv, kv||' '||name as lcv from tabval where d_close is null order by kv desc"); 
            }
            return lst;
        }

        private List<KeyValuePair<int, string>> GetList(OracleConnection _conn, string query)
        {
            Dictionary<int, string> tmp = new Dictionary<int, string>();
            using (OracleCommand cmd = _conn.CreateCommand())
            {
                cmd.CommandText = query;
                using (OracleDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                        tmp.Add(reader.GetInt16(0), reader.GetString(1));
                }
                return tmp.ToList();
            }
        }

        private void QueryTemplate(string proc_name, OracleParameter[] param = null)
        {
            using (OracleConnection conn = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = conn.CreateCommand())
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = proc_name;
                if (param != null)
                    cmd.Parameters.AddRange(param);

                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch(Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }
    }
}
