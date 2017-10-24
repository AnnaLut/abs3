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

        public IQueryable<ProvideList> GetProvideList(decimal refID, decimal? tip)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            OracleCommand cmd1 = connection.CreateCommand();

            List<ProvideList> provideList = new List<ProvideList>();
            var pooling_query = (tip == null)? @"begin p_set_pawn_acc_list(deal_id => " + refID + "); end;" : @"begin pul.set_mas_ini('ACC_LIST', " + refID + ", NULL); end;";
            var select_sql = @"select RNK, NMK, NMS, NLS, KV, OST,ACC,PAWN, NAME, OB22 from v_zal_nd_not_new ";
            try
            {
                cmd1.CommandType = System.Data.CommandType.Text;
                cmd1.CommandText = pooling_query;
                cmd1.ExecuteNonQuery();

                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = select_sql;
                cmd.Parameters.Clear();

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                   
                    ProvideList r = new ProvideList();
                    r.RNK = Convert.ToDecimal(reader.GetValue(0).ToString());
                    r.NMK = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : reader.GetString(1);
                    r.NMS = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? String.Empty : reader.GetString(2);
                    r.NLS = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? String.Empty : reader.GetString(3);
                    r.KV = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? 0 : reader.GetInt32(4);
                    r.OST = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? 0: reader.GetDecimal(5);
                    r.ACC = String.IsNullOrEmpty(reader.GetValue(6).ToString()) ? 0 : reader.GetDecimal(6);
                    r.PAWN = String.IsNullOrEmpty(reader.GetValue(7).ToString()) ? 0 : reader.GetInt32(7);
                    r.NAME = String.IsNullOrEmpty(reader.GetValue(8).ToString()) ? String.Empty : reader.GetString(8);
                    r.OB22 = String.IsNullOrEmpty(reader.GetValue(9).ToString()) ? String.Empty : reader.GetString(9);
                    provideList.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                cmd1.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return provideList.AsQueryable();
        }

        public IQueryable<ExistProvide> GetProvidePerRef(decimal refID, decimal? tip)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            OracleCommand cmd1 = connection.CreateCommand();

            List<ExistProvide> provideList = new List<ExistProvide>();
            var pooling_query = (tip == null) ? @"begin p_set_pawn_acc_list(deal_id => " + refID + "); end;" : @"begin pul.set_mas_ini('ACC_LIST', " + refID + ", NULL); end;";
            var sql1 = @"select RNK,PAWN,ACC,NLS,KV,OB22,OSTB,OSTC, CC_IDZ,SDATZ,MPAWN,DEL, DEPID,PR_12,NREE,SV,MDATE,DAZS,NAZN,NMK,NAME  from v_Zal_Nd_New";
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = pooling_query;
                cmd.ExecuteNonQuery();

                cmd1.CommandType = System.Data.CommandType.Text;
                cmd1.CommandText = sql1;
                OracleDataReader reader = cmd1.ExecuteReader();

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

                    provideList.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                cmd1.Dispose();
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

        public void CreateOrEditGroupProvide(List<UpdateProvide> list_provide, decimal? id, decimal? accs)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            string sdatz, mdate, nree, depid, pr12, nazn,sv, del, cc_idz, ob22, r103,acc,id_str,accs_str,mpawn;
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                foreach (UpdateProvide provide in list_provide)
                {
                    sdatz = (provide.SDATZ == null) ? "null" : "TO_DATE('" + (Convert.ToDateTime(provide.SDATZ)).ToString("yyyy/MM/dd", ci) + "', 'yyyy/mm/dd')";
                    mdate = (provide.MDATE == null) ? "null" : "TO_DATE('" + (Convert.ToDateTime(provide.MDATE)).ToString("yyyy/MM/dd", ci) + "', 'yyyy/mm/dd')";
                    nree = (provide.NREE == "") ? "null" : "'" + provide.NREE + "'";
                    del = (provide.DEL == null) ? "null" : provide.DEL.ToString().Replace(',', '.');
                    cc_idz = (provide.CC_IDZ == "") ? "null" : "'" + provide.CC_IDZ + "'";
                    depid = (provide.DEPID == null) ? "null" : provide.DEPID.ToString();
                    pr12 = (provide.PR_12 == null) ? "null" : provide.PR_12.ToString();
                    nazn = (provide.NAZN == "") ? "null" : "'" + provide.NAZN + "'";
                    ob22 = (provide.OB22 == null) ? "null" : "'" + provide.OB22 + "'";
                    r103 = (provide.R013 == null) ? "null" : "'" + provide.R013 + "'";
                    sv = (provide.SV == null) ? "null" : provide.SV.ToString().Replace(',', '.');
                    acc = (provide.ACC == null) ? "null" : provide.ACC.ToString();
                    mpawn = (provide.MPAWN == null) ? "null" : provide.MPAWN.ToString();
                    id_str = (id == null) ? "null" : id.ToString();
                    accs_str = (accs == null) ? "null" : accs.ToString();

                    var sql = @"begin bars.P_ADD_ZAl(" + id_str + "," + accs_str + "," + provide.RNK + "," +
                        provide.PAWN + "," + acc + "," + provide.KV + "," + sv + "," + del + "," + cc_idz + "," + sdatz + "," + mdate +
                        "," + nree + "," + depid + "," + mpawn + "," + pr12 + "," + nazn + "," + ob22+ "," + r103+ "); end;";

                    //original: P_ADD_ZAl(:ND,null,:RNK,:PAWN,:ACC,:KV,:SV,:DEL,:CC_IDZ,:SDATZ,:MDATE,:NREE,:DEPID,:MPAWN,:PR_12,:NAZN);

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

        public List<PAWNList> GetPawn(string nls)
        {
            List<PAWNList> lst = new List<PAWNList>();

            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();

            var sql = "select PAWN, NAME from cc_pawn c where c.d_Close IS NULL ";
            if (nls != null)
                sql += "AND NBSZ = trim(substr('"+nls+"',1,4))";
            sql+= " order by pawn";
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = sql;
                cmd.Parameters.Clear();

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    PAWNList p = new PAWNList();
                    p.PAWN = reader.GetInt32(0);
                    p.NAME = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : "[ " + p.PAWN + " ] " + reader.GetString(1);
                    lst.Add(p);
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

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    KVList k = new KVList();
                    k.KV = reader.GetInt32(0);
                    k.NAME = k.KV.ToString() + " " + reader.GetString(1);
                    lst.Add(k);
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

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    MPAWNList m = new MPAWNList();
                    m.MPAWN = reader.GetInt32(0);
                    m.NAME = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : reader.GetString(1);
                    lst.Add(m);
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

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    RNKList r = new RNKList();
                    r.RNK = reader.GetDecimal(0);
                    r.NMK = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : reader.GetString(1);
                    lst.Add(r);
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

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    data.RNK = reader.GetDecimal(0);
                    data.CC_ID = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : reader.GetString(1);
                    data.NMK = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? String.Empty : reader.GetString(2);
                    data.ND = refID;
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

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    data.RNK = reader.GetDecimal(0);
                    data.ACCS = reader.GetDecimal(1);
                    data.NMK = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? String.Empty : reader.GetString(2);
                    data.ND = (decimal)data.ACCS;
                    data.CC_ID = refID.ToString();
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

    }
        
}