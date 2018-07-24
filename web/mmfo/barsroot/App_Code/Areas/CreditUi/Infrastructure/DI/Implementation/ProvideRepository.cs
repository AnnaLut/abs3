using System.Linq;
using System.Collections.Generic;
using BarsWeb.Areas.CreditUi.Models;
using BarsWeb.Areas.CreditUi.Infrastructure.DI.Abstract;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using System.Globalization;
using System.Data;
using Bars;
using System.Web.Services;

namespace BarsWeb.Areas.CreditUi.Infrastructure.DI.Implementation
{
    public class ProvideRepository : IProvideRepository
    {
        CultureInfo ci = CultureInfo.CreateSpecificCulture("en-GB");
        private readonly IHomeRepository _homeRepository;

        public ProvideRepository(IHomeRepository homeRepository)
        {
            _homeRepository = homeRepository;
        }

        public IQueryable<ProvideList> GetProvideList(decimal refID, decimal? tip, byte? balance)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();

            List<ProvideList> provideList = new List<ProvideList>();
            var pooling_query = (tip == null || tip == 2)? @"begin p_set_pawn_acc_list(deal_id => " + refID + "); end;" : @"begin pul.set_mas_ini('ACC_LIST', " + refID + ", NULL); end;";
            var select_sql = @"select RNK, NMK, NMS, NLS, KV, OST,ACC,PAWN, NAME, OB22 from v_zal_nd_not_new ";
            if (tip == 2)
                select_sql += " where nls "+ ((balance == 1)? "not" : "") + " like '9510%'";
            try
            {
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = pooling_query;
                cmd.ExecuteNonQuery();

                cmd.CommandText = select_sql;
                using (OracleDataReader reader = cmd.ExecuteReader())
                {

                    while (reader.Read())
                    {

                        ProvideList r = new ProvideList();
                        r.RNK = Convert.ToDecimal(reader.GetValue(0).ToString());
                        r.NMK = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : reader.GetString(1);
                        r.NMS = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? String.Empty : reader.GetString(2);
                        r.NLS = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? String.Empty : reader.GetString(3);
                        r.KV = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? 0 : reader.GetInt32(4);
                        r.OST = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? 0 : reader.GetDecimal(5);
                        r.ACC = String.IsNullOrEmpty(reader.GetValue(6).ToString()) ? 0 : reader.GetDecimal(6);
                        r.PAWN = String.IsNullOrEmpty(reader.GetValue(7).ToString()) ? 0 : reader.GetInt32(7);
                        r.NAME = String.IsNullOrEmpty(reader.GetValue(8).ToString()) ? String.Empty : reader.GetString(8);
                        r.OB22 = String.IsNullOrEmpty(reader.GetValue(9).ToString()) ? String.Empty : reader.GetString(9);
                        provideList.Add(r);
                    }
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return provideList.AsQueryable();
        }

        public IQueryable<ExistProvide> GetProvidePerRef(decimal refID, decimal? tip, byte? balance)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();

            List<ExistProvide> provideList = new List<ExistProvide>();
            var pooling_query = (tip == null || tip == 2) ? @"begin p_set_pawn_acc_list(deal_id => " + refID + "); end;" : @"begin pul.set_mas_ini('ACC_LIST', " + refID + ", NULL); end;";
            var sql1 = @"select RNK,PAWN,ACC,NLS,KV,OB22,OSTB,OSTC, CC_IDZ,SDATZ,MPAWN,DEL, DEPID,PR_12,NREE,SV,MDATE,DAZS,NAZN,NMK,NAME,Z_POLIS,R013  from v_Zal_Nd_New";
            if (tip == 2)
                sql1 += " where nls " + ((balance == 1) ? "not" : "") + " like '9510%'";
            try
            {
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = pooling_query;
                cmd.ExecuteNonQuery();

                cmd.CommandText = sql1;
                using (OracleDataReader reader = cmd.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        ExistProvide r = new ExistProvide();

                        r.RNK = Convert.ToDecimal(reader.GetValue(0).ToString());
                        r.PAWN = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? 0 : reader.GetInt32(1);
                        r.ACC = Convert.ToDecimal(reader.GetValue(2).ToString());
                        r.NLS = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? String.Empty : reader.GetString(3);
                        r.KV = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? 0 : reader.GetInt32(4);
                        r.OB22 = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? String.Empty : reader.GetString(5);
                        r.OSTB = String.IsNullOrEmpty(reader.GetValue(6).ToString()) ? 0 : reader.GetDecimal(6);
                        r.OSTC = String.IsNullOrEmpty(reader.GetValue(7).ToString()) ? 0 : reader.GetDecimal(7);
                        r.CC_IDZ = String.IsNullOrEmpty(reader.GetValue(8).ToString()) ? String.Empty : reader.GetString(8);
                        r.SDATZ = String.IsNullOrEmpty(reader.GetValue(9).ToString()) ? (DateTime?)null : Convert.ToDateTime(reader.GetValue(9).ToString());
                        r.MPAWN = String.IsNullOrEmpty(reader.GetValue(10).ToString()) ? (int?)null : reader.GetInt32(10);
                        r.DEL = String.IsNullOrEmpty(reader.GetValue(11).ToString()) ? (int?)null : reader.GetInt32(11);
                        r.DEPID = String.IsNullOrEmpty(reader.GetValue(12).ToString()) ? (decimal?)null : reader.GetDecimal(12);
                        r.PR_12 = String.IsNullOrEmpty(reader.GetValue(13).ToString()) ? (int?)null : reader.GetInt32(13);
                        r.NREE = String.IsNullOrEmpty(reader.GetValue(14).ToString()) ? String.Empty : reader.GetString(14);
                        r.SV = String.IsNullOrEmpty(reader.GetValue(15).ToString()) ? (decimal?)null : reader.GetDecimal(15);
                        r.MDATE = String.IsNullOrEmpty(reader.GetValue(16).ToString()) ? (DateTime?)null : Convert.ToDateTime(reader.GetValue(16).ToString());
                        r.DAZS = String.IsNullOrEmpty(reader.GetValue(17).ToString()) ? (DateTime?)null : Convert.ToDateTime(reader.GetValue(17).ToString());
                        r.NAZN = String.IsNullOrEmpty(reader.GetValue(18).ToString()) ? String.Empty : reader.GetString(18);
                        r.NMK = String.IsNullOrEmpty(reader.GetValue(19).ToString()) ? String.Empty : reader.GetString(19);
                        r.NAME = String.IsNullOrEmpty(reader.GetValue(20).ToString()) ? String.Empty : reader.GetString(20);
                        r.Z_POLIS = String.IsNullOrEmpty(reader.GetValue(21).ToString()) ? String.Empty : reader.GetString(21);
                        r.R013 = String.IsNullOrEmpty(reader.GetValue(22).ToString()) ? String.Empty : reader.GetString(22);
                        provideList.Add(r);
                    }
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return provideList.AsQueryable();
        }

        public void BindProvideGroup(decimal refID, List<decimal> ACC_list, int mode, int tip)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            //бпк tip = 3, кредит tip = 1
            //add mode = 1, delete mode = 0
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                foreach (decimal acc in ACC_list)
                {
                    var sql = @"begin bars.m_accp(mod_ => " + mode + ", nd_ =>" + refID + ",  accz_ => " + acc + ", tip_ => " + tip + "); end;";
                    cmd.CommandText = sql;
                    cmd.ExecuteNonQuery();
                }

            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }

        }
        public void CreateOrEditGroupProvide(List<UpdateProvide> list_provide, decimal? id, decimal? accs, int? tip)
        {
            using (OracleConnection connect = OraConnector.Handler.UserConnection)
            using(OracleCommand cmd = connect.CreateCommand())
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = (tip == 2) ? @"bars.p_add_zal_mbdk" : @"bars.P_ADD_ZAl";
                try
                {
                    foreach(UpdateProvide provide  in list_provide)
                    {
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("p_nd", OracleDbType.Decimal, id, ParameterDirection.Input);
                        cmd.Parameters.Add("p_accs", OracleDbType.Decimal, accs, ParameterDirection.Input);
                        cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, provide.RNK, ParameterDirection.Input);
                        cmd.Parameters.Add("p_pawn", OracleDbType.Decimal, provide.PAWN, ParameterDirection.Input);
                        cmd.Parameters.Add("p_acc", OracleDbType.Decimal, provide.ACC, ParameterDirection.Input);
                        cmd.Parameters.Add("p_kv", OracleDbType.Int32, provide.KV, ParameterDirection.Input);
                        cmd.Parameters.Add("p_sv", OracleDbType.Decimal, provide.SV, ParameterDirection.Input);
                        cmd.Parameters.Add("p_del", OracleDbType.Decimal, provide.DEL, ParameterDirection.Input);
                        cmd.Parameters.Add("p_cc_idz", OracleDbType.Varchar2, provide.CC_IDZ != "" ? provide.CC_IDZ : null, ParameterDirection.Input);
                        cmd.Parameters.Add("p_sdatz", OracleDbType.Date, provide.SDATZ != null ? DateTime.ParseExact(provide.SDATZ,"dd/MM/yyyy", CultureInfo.InvariantCulture) : (DateTime?)null, ParameterDirection.Input);
                        cmd.Parameters.Add("p_mdate", OracleDbType.Date, provide.MDATE != null ? DateTime.ParseExact(provide.MDATE, "dd/MM/yyyy", CultureInfo.InvariantCulture) : (DateTime?)null, ParameterDirection.Input);
                        cmd.Parameters.Add("p_nree", OracleDbType.Varchar2, provide.NREE != "" ? provide.NREE : null, ParameterDirection.Input);
                        cmd.Parameters.Add("p_depid", OracleDbType.Decimal, provide.DEPID, ParameterDirection.Input);
                        cmd.Parameters.Add("p_mpawn", OracleDbType.Int32, provide.MPAWN, ParameterDirection.Input);
                        cmd.Parameters.Add("p_pr_12", OracleDbType.Int32, provide.PR_12, ParameterDirection.Input);
                        cmd.Parameters.Add("p_nazn", OracleDbType.Varchar2, provide.NAZN != "" ? provide.NAZN : null, ParameterDirection.Input);
                        cmd.Parameters.Add("p_ob22", OracleDbType.Varchar2, provide.OB22 != "" ? provide.OB22 : null, ParameterDirection.Input);
                        cmd.Parameters.Add("p_R013", OracleDbType.Varchar2, provide.R013 != "" ? provide.R013 : null, ParameterDirection.Input);
                        if( tip != 2)
                            cmd.Parameters.Add("p_strahz", OracleDbType.Int32, provide.Z_POLIS, ParameterDirection.Input);

                        cmd.ExecuteNonQuery();
                    }
                }
                catch(Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }

        public List<PAWNList> GetPawn(string nls, byte? tip, byte? balance)
        {
            List<PAWNList> lst = new List<PAWNList>();

            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();

            var sql = "select PAWN, NAME from cc_pawn c where c.d_Close IS NULL ";
            if (tip == 2)
                sql += " AND NBSZ "+ ( (balance == 1)? "<>" : "=" ) +" 9510 "; 
            else if (nls != null) 
                sql += " AND NBSZ = trim(substr('"+nls+"',1,4))";
            sql+= " order by pawn";
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = sql;
                cmd.Parameters.Clear();

                using (OracleDataReader reader = cmd.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        PAWNList p = new PAWNList();
                        p.PAWN = reader.GetInt32(0);
                        p.NAME = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : "[ " + p.PAWN + " ] " + reader.GetString(1);
                        lst.Add(p);
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

        public List<KVList> GetKV()
        {
            List<KVList> lst = new List<KVList>();

            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();

            var sql = @"Select KV, NAME From tabval where d_close is null";
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
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

        public List<MPAWNList> GetMPAWN()
        {
            List<MPAWNList> lst = new List<MPAWNList>();

            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();

            var sql = @"Select MPAWN,NAME From CC_MPAWN";
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = sql;
                cmd.Parameters.Clear();

                using (OracleDataReader reader = cmd.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        MPAWNList m = new MPAWNList();
                        m.MPAWN = reader.GetInt32(0);
                        m.NAME = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : reader.GetString(1);
                        lst.Add(m);
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

        public List<RNKList> GetRNK()
        {
            List<RNKList> lst = new List<RNKList>();

            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();

            var sql = @"Select RNK, NMK From customer where date_off is null";
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = sql;
                cmd.Parameters.Clear();

                using (OracleDataReader reader = cmd.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        RNKList r = new RNKList();
                        r.RNK = reader.GetDecimal(0);
                        r.NMK = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : reader.GetString(1);
                        lst.Add(r);
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

        public ProvideStaticData GetStaticDataKredit(decimal refID)
        {
            ProvideStaticData data = new ProvideStaticData();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();

            var sql = @"select t.rnk,t.cc_id,c.nmk from cc_deal t, customer c where  c.rnk = t.rnk AND t.nd=" + refID;
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = sql;
                cmd.Parameters.Clear();

                using (OracleDataReader reader = cmd.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        data.RNK = reader.GetDecimal(0);
                        data.CC_ID = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : reader.GetString(1);
                        data.NMK = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? String.Empty : reader.GetString(2);
                        data.ND = refID;
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

        public ProvideStaticData GetStaticDataBPK(decimal refID)
        {
            ProvideStaticData data = new ProvideStaticData();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();

            var sql = @"select a.rnk, a.acc, c.nmk from accounts a, w4_acc b, customer c where a.acc=b.acc_pk and c.rnk = a.rnk and b.nd = " + refID;
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = sql;
                cmd.Parameters.Clear();

                using (OracleDataReader reader = cmd.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        data.RNK = reader.GetDecimal(0);
                        data.ACCS = reader.GetDecimal(1);
                        data.NMK = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? String.Empty : reader.GetString(2);
                        data.ND = (decimal)data.ACCS;
                        data.CC_ID = refID.ToString();
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

        public string SendProvidesToND(decimal old_nd, decimal new_nd)
        {
            using(OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = connection.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = @"bars.cck_ui.p_update_new_acc_zastav";
                    cmd.Parameters.Add("p_nd_old", OracleDbType.Decimal, old_nd, ParameterDirection.Input);
                    cmd.Parameters.Add("p_nd_new", OracleDbType.Decimal, new_nd, ParameterDirection.Input);
                    try
                    {
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception e)
                    {
                        return e.Message;
                    }
                }
            }
            return "ok";
        }

    }
        
}