using System.Linq;
using System.Collections.Generic;
using BarsWeb.Areas.CreditUi.Models;
using BarsWeb.Areas.CreditUi.Infrastructure.DI.Abstract;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using System.Globalization;
using System.Data;

namespace BarsWeb.Areas.CreditUi.Infrastructure.DI.Implementation
{
    public class AccountsRepository : IAccountsRepository
    {
        CultureInfo ci = CultureInfo.CreateSpecificCulture("en-GB");
        private readonly IHomeRepository _homeRepository;

        public AccountsRepository(IHomeRepository homeRepository)
        {
            _homeRepository = homeRepository;
        }
        public IQueryable<Account> GetAccounts(decimal refID)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();

            List<Account> accountList = new List<Account>();
            var sql = @"select ORD,ND,RNK,OPN,ACC,TIP,OB22,NMS,KV,OSTC,OSTB,OSTF,DOS,KOS,DAPP,DAOS,DAZS,MDATE,ISP,IR,BASEY,TT,NLS from V_CCK_ND_ACCOUNT";
            try
            {
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = sql;

                using (OracleDataReader reader = cmd.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        string tt_name, tt_href; tt_name = tt_href = "";
                        Account a = new Account();
                        a.ORD = String.IsNullOrEmpty(reader.GetValue(0).ToString()) ? (decimal?)null : reader.GetDecimal(0);
                        a.ND = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? (decimal?)null : reader.GetDecimal(1);
                        a.RNK = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? (decimal?)null : reader.GetDecimal(2);
                        a.OPN = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? (decimal?)null : reader.GetDecimal(3);
                        a.ACC = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? (decimal?)null : reader.GetDecimal(4);
                        a.TIP = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? String.Empty : reader.GetString(5);
                        a.OB22 = String.IsNullOrEmpty(reader.GetValue(6).ToString()) ? String.Empty : reader.GetString(6);
                        a.NMS = String.IsNullOrEmpty(reader.GetValue(7).ToString()) ? String.Empty : reader.GetString(7);
                        a.KV = String.IsNullOrEmpty(reader.GetValue(8).ToString()) ? (int?)null : reader.GetInt32(8);
                        a.OSTC = String.IsNullOrEmpty(reader.GetValue(9).ToString()) ? (decimal?)null : reader.GetDecimal(9);
                        a.OSTB = String.IsNullOrEmpty(reader.GetValue(10).ToString()) ? (decimal?)null : reader.GetDecimal(10);
                        a.OSTF = String.IsNullOrEmpty(reader.GetValue(11).ToString()) ? (decimal?)null : reader.GetDecimal(11);
                        a.DOS = String.IsNullOrEmpty(reader.GetValue(12).ToString()) ? (decimal?)null : reader.GetDecimal(12);
                        a.KOS = String.IsNullOrEmpty(reader.GetValue(13).ToString()) ? (decimal?)null : reader.GetDecimal(13);
                        a.DAPP = String.IsNullOrEmpty(reader.GetValue(14).ToString()) ? String.Empty : Convert.ToDateTime(reader.GetValue(14).ToString()).ToString("dd/MM/yyyy");
                        a.DAOS = String.IsNullOrEmpty(reader.GetValue(15).ToString()) ? String.Empty : Convert.ToDateTime(reader.GetValue(15).ToString()).ToString("dd/MM/yyyy");
                        a.DAZS = String.IsNullOrEmpty(reader.GetValue(16).ToString()) ? String.Empty : Convert.ToDateTime(reader.GetValue(16).ToString()).ToString("dd/MM/yyyy");
                        a.MDATE = String.IsNullOrEmpty(reader.GetValue(17).ToString()) ? String.Empty : Convert.ToDateTime(reader.GetValue(17).ToString()).ToString("dd/MM/yyyy");
                        a.ISP = String.IsNullOrEmpty(reader.GetValue(18).ToString()) ? (decimal?)null : reader.GetDecimal(18);
                        a.IR = String.IsNullOrEmpty(reader.GetValue(19).ToString()) ? String.Empty : reader.GetString(19);
                        a.BASEY = String.IsNullOrEmpty(reader.GetValue(20).ToString()) ? (decimal?)null : reader.GetDecimal(20);
                        string temp_link = String.IsNullOrEmpty(reader.GetValue(21).ToString()) ? String.Empty : reader.GetString(21);
                        a.NLS = String.IsNullOrEmpty(reader.GetValue(22).ToString()) ? String.Empty : reader.GetString(22);
                        if (temp_link != String.Empty)
                        {
                            int index = temp_link.IndexOf('>');
                            tt_href = temp_link.Substring(8, index - 8); //9 : 8th first chars and 2 href " char
                            tt_name = temp_link.Substring(index + 1, temp_link.Length - index - 5); //5 : last </a> chars and > char before name
                        }
                        a.TT_NAME = tt_name;
                        a.TT_HREF = tt_href;
                        accountList.Add(a);
                    }
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return accountList.AsQueryable();
        }

        public AccountStaticData GetStaticData(decimal nd)
        {
            AccountStaticData data = new AccountStaticData();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();

            var sql = @"SELECT t.cc_id
                          ,t.rnk
                          ,-a.ostx/100--втсановлений мак ліміт
                          ,-a.ostc/100--викор ліміт
                          ,(a.ostc-a.ostx)/100 --невикор ліміт     
                          ,t.sdate --дата відкриття
                          ,t.wdate -- дата видачі
                          ,c.nmk
                          ,v.name
                          ,a.ostc / 100 AS ostc
                          ,d.wdate
                          ,c.custtype
                          ,t.ndg
                          ,t.sos
                      FROM cc_deal t, customer c, cc_vidd v, accounts a, cc_add d,nd_acc na
                    WHERE c.rnk = t.rnk
                       AND t.vidd = v.vidd
                       AND t.nd = :nd
                       AND na.nd=d.nd
                       and a.acc=na.acc
                       and a.tip='LIM'
                       and d.nd=t.nd";
            try
            {
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = sql;
                cmd.Parameters.Clear();
                cmd.Parameters.Add("nd", OracleDbType.Decimal, nd, ParameterDirection.Input);

                using (OracleDataReader reader = cmd.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        data.CC_ID = String.IsNullOrEmpty(reader.GetValue(0).ToString()) ? String.Empty : reader.GetString(0);
                        data.RNK = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? 0 : reader.GetDecimal(1);
                        data.S = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? 0 : reader.GetDecimal(2);
                        data.SDOG = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? 0 : reader.GetDecimal(3);
                        data.DIFF = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? 0 : reader.GetDecimal(4);
                        data.SDATE = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? String.Empty : Convert.ToDateTime(reader.GetValue(5).ToString()).ToString("dd/MM/yyyy");
                        data.WDATE = String.IsNullOrEmpty(reader.GetValue(6).ToString()) ? String.Empty : Convert.ToDateTime(reader.GetValue(6).ToString()).ToString("dd/MM/yyyy");
                        data.NAMK = String.IsNullOrEmpty(reader.GetValue(7).ToString()) ? String.Empty : reader.GetString(7);
                        data.VNAME = String.IsNullOrEmpty(reader.GetValue(8).ToString()) ? String.Empty : reader.GetString(8);
                        data.OSTB_9129 = String.IsNullOrEmpty(reader.GetValue(9).ToString()) ? 0 : reader.GetDecimal(9);
                        data.Date_issuance = String.IsNullOrEmpty(reader.GetValue(10).ToString()) ? String.Empty : Convert.ToDateTime(reader.GetValue(10).ToString()).ToString("dd/MM/yyyy");
                        data.CUSTYPE = String.IsNullOrEmpty(reader.GetValue(11).ToString()) ? 0 : reader.GetInt32(11);
                        data.NDR = String.IsNullOrEmpty(reader.GetValue(12).ToString()) ? (decimal?)null : reader.GetDecimal(12);
                        data.SOS = String.IsNullOrEmpty(reader.GetValue(13).ToString()) ? (byte?)null : reader.GetByte(13); 
                        data.Avalible_provide = !data.NDR.HasValue || nd == data.NDR;
                    }
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return data;

        }

        public void CloseKD(decimal nd)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = @"bars.cck_ui.CLS";
                cmd.Parameters.Add("p_nd", OracleDbType.Decimal, nd, ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }

        }

        public void Lim9129(decimal nd)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = @"bars.cck_ui.p9129";
                cmd.Parameters.Add("p_nd", OracleDbType.Decimal, nd, ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }

        }

        public void DelAccountWithoutClose(decimal nd, decimal acc, string tip)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = @"bars.cck_ui.acc_del";
                cmd.Parameters.Add("p_nd", OracleDbType.Decimal, nd, ParameterDirection.Input);
                cmd.Parameters.Add("p_acc", OracleDbType.Decimal, acc, ParameterDirection.Input);
                cmd.Parameters.Add("p_tip", OracleDbType.Varchar2, tip, ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }

        }

        public void ConnectAccountWithKD(decimal nd, string nls, int kv)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = @"bars.cck_ui.REL_NLS";
                cmd.Parameters.Add("p_nd", OracleDbType.Decimal, nd, ParameterDirection.Input);
                cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, nls, ParameterDirection.Input);
                cmd.Parameters.Add("p_kv", OracleDbType.Int32, kv, ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }

        }

        public void UpdateAccount(UpdateAccount data)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = @"bars.cck_ui.acc_add";
                cmd.Parameters.Add("p_nd", OracleDbType.Decimal, data.ND, ParameterDirection.Input);
                cmd.Parameters.Add("p_acc", OracleDbType.Decimal, data.ACC, ParameterDirection.Input);
                cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, data.NLS, ParameterDirection.Input);
                cmd.Parameters.Add("p_tip", OracleDbType.Varchar2, data.TIP, ParameterDirection.Input);
                cmd.Parameters.Add("p_kv", OracleDbType.Int32, data.KV, ParameterDirection.Input);
                cmd.Parameters.Add("p_opn", OracleDbType.Decimal, 1, ParameterDirection.Input);
                cmd.Parameters.Add("p_ob22", OracleDbType.Varchar2, data.OB22, ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }

        }

        public void Remain8999(decimal nd)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = @"bars.CCK.cc_START";
                cmd.Parameters.Add("ND_", OracleDbType.Decimal, nd, ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }

        }

        public void AutoSG(decimal nd)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = @"bars.CCK.CC_ASG";
                cmd.Parameters.Add("nREGIM_", OracleDbType.Decimal, nd*(-1), ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }

        }

        public List<KVList> GetKV()
        {
            List<KVList> lst = new List<KVList>();

            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();

            var sql = @"Select KV, NAME From tabval where d_close is null";
            try
            {
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = sql;
                cmd.Parameters.Clear();

                using (OracleDataReader reader = cmd.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        KVList k = new KVList();
                        k.KV = reader.GetInt32(0);
                        k.NAME = k.KV.ToString() + " " + reader.GetString(1);
                        lst.Add(k);
                    }
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return lst;
        }

        public void setMasIni(decimal nd)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            var sql = @"select n.acc, a8.rnk from nd_acc n, accounts a8 where n.acc = a8.acc  AND a8.tip = 'LIM' AND nd = "+nd ;
            decimal acc8 = 0, rnk = 0;
             try
            {

                cmd.CommandType = CommandType.Text;
                cmd.CommandText = sql;
                cmd.Parameters.Clear();

                using (OracleDataReader reader = cmd.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        acc8 = reader.GetDecimal(0);
                        rnk = reader.GetDecimal(1);

                    }
                }

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = @"bars.PUL.put";
                cmd.Parameters.Add("tag_", OracleDbType.Varchar2, "ND", ParameterDirection.Input);
                cmd.Parameters.Add("val_", OracleDbType.Decimal, nd, ParameterDirection.Input);
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();
                cmd.Parameters.Add("tag_", OracleDbType.Varchar2, "ACCC", ParameterDirection.Input);
                cmd.Parameters.Add("val_", OracleDbType.Decimal, acc8, ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        public void FinDebit(decimal acc)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = @"bars.CCK_UI.OP_OFR";
                cmd.Parameters.Add("p_acc", OracleDbType.Decimal, acc, ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }

        }

        public string GetTabId()
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandText = @"select tabid from meta_tables where tabname = 'V_CCK_RU'";
                return cmd.ExecuteScalar().ToString();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }
    }
}