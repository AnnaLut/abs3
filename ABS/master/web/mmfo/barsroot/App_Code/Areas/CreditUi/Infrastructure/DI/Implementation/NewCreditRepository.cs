﻿using System.Linq;
using System.Collections.Generic;
using BarsWeb.Areas.CreditUi.Models;
using BarsWeb.Areas.CreditUi.Infrastructure.DI.Abstract;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;

namespace BarsWeb.Areas.CreditUi.Infrastructure.DI.Implementation
{
    public class NewCreditRepository : INewCreditRepository
    {
        private readonly IHomeRepository _homeRepository;

        public NewCreditRepository(IHomeRepository homeRepository)
        {
            _homeRepository = homeRepository;
        }

        public IQueryable<CurrencyList> getCurrency()
        {
            List<CurrencyList> curr = new List<CurrencyList>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select kv, lcv||' '||name as lcv from tabval where d_close is null order by skv";
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    CurrencyList r = new CurrencyList();
                    r.KV = reader.GetInt16(0);
                    r.LCV = reader.GetString(1);
                    curr.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return curr.AsQueryable();
        }

        public IQueryable<StanFinList> getStanFin()
        {
            List<StanFinList> stan = new List<StanFinList>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select fin, name from stan_fin order by fin";
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    StanFinList r = new StanFinList();
                    r.FIN = reader.GetInt16(0);
                    r.NAME = reader.GetString(1);
                    stan.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return stan.AsQueryable();
        }

        public IQueryable<StanObsList> getStanObs()
        {
            List<StanObsList> stan = new List<StanObsList>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select obs, name from stan_obs order by obs";
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    StanObsList r = new StanObsList();
                    r.OBS = reader.GetInt16(0);
                    r.NAME = reader.GetString(1);
                    stan.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return stan.AsQueryable();
        }

        public IQueryable<CRiskList> getCRisk(decimal fin, decimal obs)
        {
            List<CRiskList> risk = new List<CRiskList>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select c.crisk, c.name from FIN_OBS_S080 f, crisk c where f.fin=:p_fin and f.obs=:p_obs and f.s080=c.crisk";
                cmd.Parameters.Add("p_fin", OracleDbType.Decimal, fin, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_obs", OracleDbType.Decimal, obs, System.Data.ParameterDirection.Input);
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    CRiskList r = new CRiskList();
                    r.CRISK = reader.GetString(0);
                    r.NAME = reader.GetString(1);
                    risk.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return risk.AsQueryable();
        }

        public IQueryable<ViddList> getVidd(decimal rnk)
        {
            List<ViddList> vidd = new List<ViddList>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"select cv.vidd, cv.name
                                      from cc_vidd cv
                                     where cv.vidd in (1, 2, 3, 11, 12, 13)
                                       and cv.tipd = 1
                                       and cv.custtype = (select custtype from customer where rnk = :p_rnk and date_off is null)
                                     order by cv.vidd";
                cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, System.Data.ParameterDirection.Input);
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    ViddList r = new ViddList();
                    r.VIDD = reader.GetInt32(0);
                    r.NAME = reader.GetString(1);
                    vidd.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return vidd.AsQueryable();
        }

        public IQueryable<SourList> getSour()
        {
            List<SourList> sour = new List<SourList>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select sour, name from cc_source order by name desc";
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    SourList r = new SourList();
                    r.SOUR = reader.GetInt32(0);
                    r.NAME = reader.GetString(1);
                    sour.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return sour.AsQueryable();
        }

        public IQueryable<AimList> getAim(decimal? rnk, string dealDate)
        {
            List<AimList> aim = new List<AimList>();
            if (rnk != null)
            {
                OracleConnection connection = OraConnector.Handler.UserConnection;
                OracleCommand cmd = connection.CreateCommand();
                try
                {
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.CommandText = @"select aim, name
                                      from cc_aim
                                     where (case
                                              when (select custtype from customer where rnk = :p_rnk) = 3 then
                                              nbsf
                                              else
                                              nbs
                                           end) is not null
                                       and (d_close is null or d_close > to_date(:p_deal_date, 'dd.mm.yyyy'))";
                    cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, System.Data.ParameterDirection.Input);
                    cmd.Parameters.Add("p_deal_date", OracleDbType.Varchar2, String.Format("{0:dd.MM.yyyy}", dealDate), System.Data.ParameterDirection.Input);
                    OracleDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        AimList r = new AimList();
                        r.AIM = reader.GetInt32(0);
                        r.NAME = reader.GetString(1);
                        aim.Add(r);
                    }
                }
                finally
                {
                    cmd.Dispose();
                    connection.Dispose();
                    connection.Close();
                }
            }
            return aim.AsQueryable();
        }

        public NlsParam getAimBal(decimal? rnk, decimal? aim, bool yearDiff)
        {
            NlsParam nls = new NlsParam();
            if (rnk != null)
            {
                OracleConnection connection = OraConnector.Handler.UserConnection;
                OracleCommand cmd = connection.CreateCommand();
                try
                {
                    cmd.CommandType = System.Data.CommandType.Text;
                    if (yearDiff)
                    {
                        cmd.CommandText = @"select (case 
                                                     when (select custtype from customer where rnk = :rnk) = 3 then 
                                                                    nbsf 
                                                        else 
                                                                    nbs 
                                                                end) as nbs
                                                from cc_aim 
                                            where aim = :aim";
                    }
                    else
                    {
                        cmd.CommandText = @"select (case 
                                                     when (select custtype from customer where rnk = :rnk) = 3 then 
                                                                    nbsf2 
                                                        else 
                                                                    nbs2
                                                                end) as nbs
                                                from cc_aim 
                                            where aim = :aim";
                    }
                    cmd.Parameters.Add("rnk", OracleDbType.Decimal, rnk, System.Data.ParameterDirection.Input);
                    cmd.Parameters.Add("aim", OracleDbType.Decimal, aim, System.Data.ParameterDirection.Input);
                    OracleDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        nls.NLS = reader.GetString(0);
                    }
                }
                finally
                {
                    cmd.Dispose();
                    connection.Dispose();
                    connection.Close();
                }
            }
            return nls;
        }

        public void setMasIni(string nbs)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            decimal result = -1;
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = @"bars.PUL.Set_Mas_Ini";
                cmd.Parameters.Add("tag_", OracleDbType.Varchar2, "NBS_AIM", System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("val_", OracleDbType.Varchar2, nbs, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("comm_", OracleDbType.Varchar2, "Бал.рах по цілі кредиту", System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        public IQueryable<BaseyList> getBasey()
        {
            List<BaseyList> basey = new List<BaseyList>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select basey, name from basey order by basey";
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    BaseyList r = new BaseyList();
                    r.BASEY = reader.GetInt32(0);
                    r.NAME = reader.GetString(1);
                    basey.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return basey.AsQueryable();
        }

        public IQueryable<RangList> getRang(decimal? custtype)
        {
            List<RangList> rang = new List<RangList>();
            if (custtype != null)
            {
                OracleConnection connection = OraConnector.Handler.UserConnection;
                OracleCommand cmd = connection.CreateCommand();
                try
                {
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.CommandText = @"select rang, name
                                      from cc_rang_name
                                     where (d_close < gl.bd or d_close is null)
                                       and (custtype is null or
                                           custtype = :custtype)
                                     order by rang";
                    cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, custtype, System.Data.ParameterDirection.Input);
                    OracleDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        RangList r = new RangList();
                        r.RANG = reader.GetInt32(0);
                        r.NAME = reader.GetString(1);
                        rang.Add(r);
                    }
                }
                finally
                {
                    cmd.Dispose();
                    connection.Dispose();
                    connection.Close();
                }
            }
            return rang.AsQueryable();
        }

        public IQueryable<FreqList> getFreq()
        {
            List<FreqList> freq = new List<FreqList>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"select freq, name from freq order by freq desc";
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    FreqList r = new FreqList();
                    r.FREQ = reader.GetInt32(0);
                    r.NAME = reader.GetString(1);
                    freq.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return freq.AsQueryable();
        }

        public IQueryable<MetrList> getMetr()
        {
            List<MetrList> metr = new List<MetrList>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                /*cmd.CommandText = @"select m.metr, m.name
                                      from params p, int_metr m
                                     where p.par = 'CC_KOM'
                                       and to_char(m.metr) = p.val";*/
                cmd.CommandText = @"select m.metr, m.name
                                      from  int_metr m";
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    MetrList r = new MetrList();
                    r.METR = reader.GetInt32(0);
                    r.NAME = reader.GetString(1);
                    metr.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return metr.AsQueryable();
        }

        public IQueryable<ParamsList> getTabList()
        {
            List<ParamsList> par = new List<ParamsList>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"select code, name from cc_tag_codes order by ord";
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    ParamsList r = new ParamsList();
                    r.CODE = reader.GetString(0);
                    r.NAME = reader.GetString(1);
                    par.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return par.AsQueryable();
        }

        public IQueryable<NdTxtList> getNdTxt(string code)
        {
            List<NdTxtList> txt = new List<NdTxtList>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"select * from (select tag,
                                           name,
                                           substr(txt, 1, 250) TXT,
                                           '' SEM,
                                           (case
                                             when table_name is not null then
                                              'R'
                                             when table_name is null and type is null then
                                              'S'
                                             else
                                              type
                                           end) as type,
                                           code,
                                           table_name,
                                           (select listagg(mc.colname, ',') within group(order by mc.colid)
                                              from meta_columns mc, meta_tables mt
                                             where mt.tabid = mc.tabid
                                               and mt.tabname = table_name) as col_name
                                      from (SELECT t.code,
                                                   t.tag,
                                                   t.name,
                                                   null as ND,
                                                   null as txt,
                                                   t.table_name,
                                                   t.nsisqlwhere,
                                                   t.type,
                                                   (select min(colname)
                                                      from meta_tables mt, meta_columns mc
                                                     where mt.tabid = mc.tabid
                                                       and showretval = 1
                                                       and mt.tabname = t.table_name) sk,
                                                   (select min(colname)
                                                      from meta_tables mt, meta_columns mc
                                                     where mt.tabid = mc.tabid
                                                       and INSTNSSEMANTIC = 1
                                                       and mt.tabname = t.table_name) fk
                                              FROM CC_TAG t
                                             WHERE t.TAGTYPE = 'CCK')
                                     where code = :code) order by tag";
                cmd.Parameters.Add("code", OracleDbType.Varchar2, code, System.Data.ParameterDirection.Input);
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    NdTxtList r = new NdTxtList();
                    r.TAG = reader.GetString(0);
                    r.NAME = reader.GetString(1);
                    r.TXT = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? String.Empty : reader.GetString(2);
                    r.SEM = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? String.Empty : reader.GetString(3);
                    r.TYPE = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? String.Empty : reader.GetString(4);
                    r.CODE = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? String.Empty : reader.GetString(5);
                    r.TABLE_NAME = String.IsNullOrEmpty(reader.GetValue(6).ToString()) ? String.Empty : reader.GetString(6);
                    r.COL_NAME = String.IsNullOrEmpty(reader.GetValue(7).ToString()) ? String.Empty : reader.GetString(7);
                    txt.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return txt.AsQueryable();
        }

        public IQueryable<NdTxtList> getNdTxtDeal(decimal nd, string code)
        {
            List<NdTxtList> txt = new List<NdTxtList>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"select * from (select t.tag,
                                           t.name,
                                           (case when nd.TXT is not null
                                             then nd.txt else
                                              '' end) txt,
                                           '' SEM,
                                           (case
                                             when table_name is not null then
                                              'R'
                                             when table_name is null and type is null then
                                              'S'
                                             else
                                              type
                                           end) as type,
                                           code,
                                           table_name,
                                           (select listagg(mc.colname, ',') within group(order by mc.colid)
                                              from meta_columns mc, meta_tables mt
                                             where mt.tabid = mc.tabid
                                               and mt.tabname = table_name) as col_name
                                      from (SELECT t.code,
                                                   t.tag,
                                                   t.name,
                                                   null as ND,
                                                   null as txt,
                                                   t.table_name,
                                                   t.nsisqlwhere,
                                                   t.type,
                                                   (select min(colname)
                                                      from meta_tables mt, meta_columns mc
                                                     where mt.tabid = mc.tabid
                                                       and showretval = 1
                                                       and mt.tabname = t.table_name) sk,
                                                   (select min(colname)
                                                      from meta_tables mt, meta_columns mc
                                                     where mt.tabid = mc.tabid
                                                       and INSTNSSEMANTIC = 1
                                                       and mt.tabname = t.table_name) fk
                                              FROM CC_TAG t
                                             WHERE t.TAGTYPE = 'CCK') t
                                             left join nd_txt nd
                                         on t.tag = nd.tag and nd.nd = :nd
                                     where code = :code) order by tag";
                cmd.Parameters.Add("nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("code", OracleDbType.Varchar2, code, System.Data.ParameterDirection.Input);
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    NdTxtList r = new NdTxtList();
                    r.TAG = reader.GetString(0);
                    r.NAME = reader.GetString(1);
                    r.TXT = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? String.Empty : reader.GetString(2);
                    r.SEM = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? String.Empty : reader.GetString(3);
                    r.TYPE = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? String.Empty : reader.GetString(4);
                    r.CODE = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? String.Empty : reader.GetString(5);
                    r.TABLE_NAME = String.IsNullOrEmpty(reader.GetValue(6).ToString()) ? String.Empty : reader.GetString(6);
                    r.COL_NAME = String.IsNullOrEmpty(reader.GetValue(7).ToString()) ? String.Empty : reader.GetString(7);
                    txt.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return txt.AsQueryable();
        }

        public decimal createDeal(CreateDeal credit)
        {
            USER_PARAM user = _homeRepository.GetUserParam();
            credit.ID = user.USER_ID;
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            decimal result = -1;
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = @"bars.cck.cc_open";
                cmd.Parameters.Add("ND_", OracleDbType.Decimal, System.Data.ParameterDirection.Output);
                cmd.Parameters.Add("nRNK", OracleDbType.Decimal, credit.nRNK, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("CC_ID_", OracleDbType.Varchar2, credit.CC_ID, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("Dat1", OracleDbType.Date, credit.Dat1, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("Dat4", OracleDbType.Date, credit.Dat4, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("Dat2", OracleDbType.Date, credit.Dat2, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("Dat3", OracleDbType.Date, credit.Dat3, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nKV", OracleDbType.Decimal, credit.nKV, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nS", OracleDbType.Decimal, credit.nS, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nVID", OracleDbType.Decimal, credit.nVID, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nISTO", OracleDbType.Decimal, credit.nISTRO, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nCEL", OracleDbType.Decimal, credit.nCEL, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("MS_NX", OracleDbType.Varchar2, credit.MS_NX, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nFIN", OracleDbType.Decimal, credit.nFIN, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nOBS", OracleDbType.Decimal, credit.nOBS, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("sAIM", OracleDbType.Varchar2, credit.sAIM, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("ID_", OracleDbType.Decimal, credit.ID, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("NLS", OracleDbType.Varchar2, credit.NLS, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nBANK", OracleDbType.Decimal, credit.nBANK, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nFREQ", OracleDbType.Decimal, credit.nFREQ, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("dfPROC", OracleDbType.Decimal, credit.dfPROC, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nBasey", OracleDbType.Decimal, credit.nBasey, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("dfDen", OracleDbType.Decimal, credit.dfDen, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("DATNP", OracleDbType.Date, credit.DATNP, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nFREQP", OracleDbType.Decimal, credit.nFREQP, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nKom", OracleDbType.Decimal, credit.nKom, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
                result = Convert.ToDecimal(cmd.Parameters["ND_"].Value.ToString());
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
            return result;
        }

        public decimal updateDeal(CreateDeal credit)
        {
            /*USER_PARAM user = _homeRepository.GetUserParam();
            credit.ID = user.USER_ID;*/
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            decimal result = -1;

            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = @"bars.cck.cc_kor";
                cmd.Parameters.Add("ACC_", OracleDbType.Decimal, credit.ACC8, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("ND_", OracleDbType.Decimal, credit.ND, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nRNK", OracleDbType.Decimal, credit.nRNK, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("CC_ID_", OracleDbType.Varchar2, credit.CC_ID, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("DatZak_", OracleDbType.Date, credit.Dat1, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("DatEnd_", OracleDbType.Date, credit.Dat4, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("DatBeg_", OracleDbType.Date, credit.Dat2, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("DatWid_", OracleDbType.Date, credit.Dat3, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nKV_", OracleDbType.Decimal, credit.nKV, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nS_", OracleDbType.Decimal, credit.nS, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nVID_", OracleDbType.Decimal, credit.nVID, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nISTO_", OracleDbType.Decimal, credit.nISTRO, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nCEL_", OracleDbType.Decimal, credit.nCEL, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("MS_NX", OracleDbType.Varchar2, credit.MS_NX, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nFIN_", OracleDbType.Decimal, credit.nFIN, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nOBS_", OracleDbType.Decimal, credit.nOBS, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("sAIM_", OracleDbType.Varchar2, credit.sAIM, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("sPAWN_", OracleDbType.Varchar2, String.Empty, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nKOM_", OracleDbType.Decimal, credit.nKom, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("NLS_", OracleDbType.Varchar2, credit.NLS, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nBANK_", OracleDbType.Decimal, credit.nBANK, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nFREQ_", OracleDbType.Decimal, credit.nFREQ, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("dfPROC_", OracleDbType.Decimal, credit.dfPROC, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nBasey_", OracleDbType.Decimal, credit.nBasey, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("dfDen_", OracleDbType.Decimal, credit.dfDen, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("DATNP_", OracleDbType.Date, credit.DATNP, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("nFREQP_", OracleDbType.Decimal, credit.nFREQP, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
                result = (decimal)credit.ND;
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Parameters.Clear();
                cmd.CommandText = "declare " +
                                  "  l_max_date date;" +
                                  "begin" +
                                  "  select max(fdat) into l_max_date from cc_lim where nd = :p_nd;" +
                                  "  update cc_lim set fdat = :p_date where nd = :p_nd and fdat = l_max_date;" +
                                  "end;";
                cmd.Parameters.Add("p_nd", OracleDbType.Decimal, credit.ND, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_date", OracleDbType.Date, credit.Dat4, System.Data.ParameterDirection.Input);
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
            return result;
        }

        public void setNdTxt(decimal? nd, List<NdTxt> txt)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            if (nd != null && txt != null)
            {
                var count = txt.Count;
                try
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = @"bars.cck_app.set_nd_txt";
                    for (var i = 0; i < count; i++)
                    {
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("p_ND", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);
                        cmd.Parameters.Add("p_TAG", OracleDbType.Varchar2, txt[i].TAG, System.Data.ParameterDirection.Input);
                        cmd.Parameters.Add("p_TXT", OracleDbType.Varchar2, txt[i].TXT, System.Data.ParameterDirection.Input);
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
        }

        public void afterSaveDeal(AfterParams param)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "Begin" +
                                  "   update cc_deal set PROD='" + param.prod + "' ,fin=" + param.fin + " where nd=" + param.nd + ";" +
                                  "   CCK_APP.SET_ND_TXT(" + param.nd + ", 'INIC', '" + param.inic + "');" +
                                  "   CCK_APP.SET_ND_TXT(" + param.nd + ", 'FLAGS', '" + param.flags + "');" +
                                  //"   CCK_APP.SET_ND_TXT(" + nd + ", 'EMAIL', '" + email + "');" +
                                  "   CCK_APP.SET_ND_TXT(" + param.nd + ", 'CCRNG', '" + param.rang + "');" +
                                  "End;";
                cmd.ExecuteNonQuery();
                cmd.CommandText = "Begin" +
                                  "   update nd_txt set txt = (select s260 from cc_potra where id = '" + param.prod + "' )  where tag = 'S260' and nd = " + param.nd + ";" +
                                  "   if SQL%rowcount = 0 then" +
                                  "      INSERT INTO nd_txt (ND, TAG, TXT) values(" + param.nd + ", 'S260', (select s260 from cc_potra where id = '" + param.prod + "' ) ) ;" +
                                  "   end if;" +
                                  "End;";
                cmd.ExecuteNonQuery();
                if (param.sdi != null)
                {
                    cmd.CommandText = "Begin" +
                        "   CCK_APP.SET_ND_TXT(" + param.nd + ", 'S_SDI', '" + param.sdi + "');" +

                                      //"   update nd_txt set txt = " + param.sdi + " where tag = 'S_SDI' and nd = " + param.nd + ";" +
                                      //"   if SQL%rowcount = 0 then" +
                                      //"      INSERT INTO nd_txt (ND, TAG, TXT) values(" + param.nd + ", 'S_SDI', " + param.sdi + " ) ;" +
                                      //"   end if;" +
                                      "End;";
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    cmd.CommandText = "Begin" +
                                      "   delete from nd_txt where tag = 'S_SDI' and nd = " + param.nd + ";" +
                                      "End;";
                    cmd.ExecuteNonQuery();
                }

                cmd.CommandText = "select a.acc from accounts a, nd_acc n where a.acc = n.acc and n.nd = :p_nd and a.tip = 'LIM'";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_nd", OracleDbType.Decimal, param.nd, System.Data.ParameterDirection.Input);
                OracleDataReader reader = cmd.ExecuteReader();
                long acc = -1;
                while (reader.Read())
                {
                    acc = reader.GetInt64(0);
                }

                if (param.metr != null)
                {
                    cmd.CommandText = @"Begin" +
                                       "  update int_accn set metr = trunc(" + param.metr + "), basem = 0, basey = " + param.basey + " where acc = " + acc + " and id = 2; " +
                                       "  if SQL%rowcount = 0 then " +
                                       "    insert into int_accn (acc,id,metr,basem,basey,freq,tt) values (" + acc + ", 2, trunc(" + param.metr + "), 0, " + param.basey + ", 5, '%%1');" +
                                       "  end if;" +
                                       "  update int_ratn set bdat = to_date('" + param.sdate + "','dd.mm.yyyy'), ir = :metr_r where acc = " + acc + " and id = 2;" +
                                       "  if SQL%rowcount = 0 then " +
                                       "    insert into int_ratn (acc,id,bdat,ir) values (" + acc + ", 2, to_date('" + param.sdate + "','dd.mm.yyyy'), :metr_r);" +
                                       "  end if;" +
                                       "End;";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("metr_r", OracleDbType.Decimal, param.metr_r, System.Data.ParameterDirection.Input);
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    cmd.CommandText = "Begin" +
                        "   DELETE from int_ratn where acc=" + acc + " and id=2    log errors  INTO err$_int_ratn ('DELETE') reject LIMIT unlimited; " +
                        "   DELETE from int_accn where acc=" + acc + " and id=2    log errors   INTO err$_int_accn ('DELETE') reject LIMIT unlimited; " +
                                      "End;";
                    cmd.ExecuteNonQuery();
                }
                if (param.sn8 != null)
                {
                    cmd.CommandText = "Begin" +
                                      "   update nd_txt set txt = " + param.sn8 + " where tag = 'SN8_R' and nd = " + param.nd + " ;" +
                                      "   if SQL%rowcount = 0 then" +
                                      "      INSERT INTO nd_txt (ND, TAG, TXT) values(" + param.nd + ", 'SN8_R', " + param.sn8 + " ) ;" +
                                      "   end if;" +
                                      "End;";
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    cmd.CommandText = "Begin" +
                                      "   delete from nd_txt where tag = 'SN8_R' and nd = " + param.nd + ";" +
                                      "End;";
                    cmd.ExecuteNonQuery();
                }
                // if (param.sk4 != null && param.sk4 >= 0)
                //{

                //todO: HARD CODE!!! FIX IT!!!
                cmd.CommandText = @"Begin
                                            cck.p_after_open_deal
                                             (
                                               p_tbl_name_1=> 'INT_RATN'
                                              ,p_acc =>       :p_acc
                                              ,p_id  =>       4
                                              ,p_bdat =>     :p_bdat
                                              ,p_ir    =>     :p_ir
                                              ,p_br  =>       null
                                              ,p_op   =>      null
                                             ) ;
                                        End;";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_acc", OracleDbType.Int64, acc, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_bdat", OracleDbType.Date, param.dat3, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_ir", OracleDbType.Decimal, param.sk4, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
                // }
                //else
                // {
                //cmd.CommandText = "Begin" +
                // "   DELETE from int_ratn where acc=" + acc + " and id=5; " +
                //"End;";
                // cmd.ExecuteNonQuery();
                //}
                if (param.cr9 != null && param.cr9 != 0)
                {
                    cmd.CommandText = "Begin" +
                                      "   update nd_txt set txt = :CR9 where tag = 'R_CR9' and nd = " + param.nd + ";" +
                                      "   if SQL%rowcount = 0 then" +
                                      "      INSERT INTO nd_txt (ND, TAG, TXT) values(" + param.nd + ", 'R_CR9', :CR9 ) ;" +
                                      "   end if;" +
                                      "End;";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("CR9", OracleDbType.Decimal, param.cr9, System.Data.ParameterDirection.Input);
                    //cmd.Parameters.Add("DAT3", OracleDbType.Date, param.dat3, System.Data.ParameterDirection.Input);
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = "Begin" +
                                      "   update nd_txt set txt = " + param.icr9 + " where tag = 'I_CR9' and nd = " + param.nd + ";" +
                                      "   if SQL%rowcount = 0 then" +
                                      "      INSERT INTO nd_txt (ND, TAG, TXT) values(" + param.nd + ", 'I_CR9', " + param.icr9 + " ) ;" +
                                      "   end if;" +
                                      "End;";
                    cmd.Parameters.Clear();
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    cmd.CommandText = "Begin" +
                                      "   delete from nd_txt where tag = 'R_CR9' and nd = " + param.nd + ";" +
                                      "   delete from nd_txt where tag = 'I_CR9' and nd = " + param.nd + ";" +
                                      "End;";
                    cmd.ExecuteNonQuery();
                }
                if (param.daysn != null)
                {
                    cmd.CommandText = "Begin" +
                                      "   update nd_txt set txt = " + param.daysn + " where tag = 'DAYSN' and nd = " + param.nd + ";" +
                                      "   if SQL%rowcount = 0 then" +
                                      "      INSERT INTO nd_txt (ND, TAG, TXT) values(" + param.nd + ", 'DAYSN', " + param.daysn + " ) ;" +
                                      "   end if;" +
                                      "End;";
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    cmd.CommandText = "Begin" +
                                      "   delete from nd_txt where tag = 'DAYSN' and nd = " + param.nd + ";" +
                                      "End;";
                    cmd.ExecuteNonQuery();
                }
                if (param.datsn != null)
                {
                    cmd.CommandText = "Begin" +
                                      "   update nd_txt set txt = '" + param.datsn + "' where tag = 'DATSN' and nd = " + param.nd + ";" +
                                      "   if SQL%rowcount = 0 then" +
                                      "      INSERT INTO nd_txt (ND, TAG, TXT) values(" + param.nd + ", 'DATSN', '" + param.datsn + "' ) ;" +
                                      "   end if;" +
                                      "End;";
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    cmd.CommandText = "Begin" +
                                      "   delete from nd_txt where tag = 'DATSN' and nd = " + param.nd + ";" +
                                      "End;";
                    cmd.ExecuteNonQuery();
                }
                if (param.daynp != null)
                {
                    cmd.CommandText = "Begin" +
                                      "   update nd_txt set txt = " + param.daynp + " where tag = 'DAYNP' and nd = " + param.nd + ";" +
                                      "   if SQL%rowcount = 0 then" +
                                      "      INSERT INTO nd_txt (ND, TAG, TXT) values(" + param.nd + ", 'DAYNP', " + param.daynp + " ) ;" +
                                      "   end if;" +
                                      "End;";
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    cmd.CommandText = "Begin" +
                                      "   delete from nd_txt where tag = 'DAYNP' and nd = " + param.nd + ";" +
                                      "End;";
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

        public void setMultiExtInt(MultiExtIntParams param)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                /*cmd.CommandText = "BARS.CCK.MULTI_INT";
                cmd.Parameters.Add("ND_", OracleDbType.Decimal, param.ND, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("K1_", OracleDbType.Decimal, param.KV1, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P1_", OracleDbType.Decimal, param.PROC1, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("K2_", OracleDbType.Decimal, param.KV2, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P2_", OracleDbType.Decimal, param.PROC2, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("K3_", OracleDbType.Decimal, param.KV3, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P3_", OracleDbType.Decimal, param.PROC3, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("K4_", OracleDbType.Decimal, param.KV4, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P4_", OracleDbType.Decimal, param.PROC4, System.Data.ParameterDirection.Input);*/
                cmd.CommandText = "BARS.CCK.MULTI_INT_EX";
                cmd.Parameters.Add("ND_", OracleDbType.Decimal, param.ND, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("BR_", OracleDbType.Decimal, param.BRID, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("AN_", OracleDbType.Decimal, param.CBA, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("K1_", OracleDbType.Decimal, param.KV1, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P1_", OracleDbType.Decimal, param.PROC1, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("K2_", OracleDbType.Decimal, param.KV2, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P2_", OracleDbType.Decimal, param.PROC2, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("K3_", OracleDbType.Decimal, param.KV3, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P3_", OracleDbType.Decimal, param.PROC3, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("K4_", OracleDbType.Decimal, param.KV4, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P4_", OracleDbType.Decimal, param.PROC4, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }

        }

        public CreateDeal getDeal(decimal nd)
        {
            CreateDeal credit = new CreateDeal();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                //Нужно подумать на счет вьюшки
                cmd.CommandText = @"select cc.nd,--0
                                           cc.cc_id,--1
                                           cc.dsdate,--2
                                           cc.dwdate,--3
                                           cc.abdate,--4
                                           cc.awdate,--5
                                           cc.kv,--6
                                           cc.s,--7
                                           cc.vidd,--8
                                           cc.sour,--9
                                           cc.aim,--10
                                           cc.prod,--11
                                           (select crisk
                                              from customer
                                             where rnk = cc.rnk
                                               and date_off is null) as nfin,--12
                                           cc.obs,--13
                                           cck_app.Get_ND_TXT(cc.nd, 'AIM') as saim,--14
                                           cc.acckred,--15
                                           cc.mfokred,--16
                                           cc.freq,--17
                                           (case
                                             when cc.pr = 0 then
                                              acrN.FPROCN(cc.acc8, 0, '')
                                             else
                                              cc.pr
                                           end) pr,--18
                                           ia.basey,--19
                                           cc.day,--20
                                           (select apl_dat
                                              from int_accn
                                             where acc = cc.acc8
                                               and id = 0) as apdate,--21
                                           cck_app.Get_ND_TXT(cc.nd, 'FREQP') as FREQP,--22
                                           trim(cck_app.Get_ND_TXT(cc.nd, 'R_CR9')) as nkom,--23
                                           cc.rnk,--24
                                           c.okpo,--25
                                           c.nmk,--26
                                           cck_app.Get_ND_TXT(cc.nd, 'INIC') as inic,--27
                                           cp.txt prod_name,--28
                                           ca.name as aim_name,--29
                                           cc.acc8,--30
                                           cc.basem,--31
                                           cck_app.Get_ND_TXT(cc.nd, 'S_SDI') as sdi,--32
                                           (select lcv||' '||name as lcv from tabval where kv = cc.kv) as kv_name,--33
                                           (select name from cc_vidd where vidd = cc.vidd) as vidd_name,--34
                                           (select name from cc_source where sour = cc.sour) as sour_name,--35
                                           (select name from stan_fin where fin in (select crisk
                                              from customer
                                             where rnk = cc.rnk
                                               and date_off is null)) as nfin_name,--36
                                           (select name from stan_obs where obs = cc.obs) as obs_name,--37
                                           (select name from freq where freq = cc.freq) as freq_name,--38
                                           (select name from basey where basey = cc.basem) as basey_name,--39
                                           (select name from freq where freq = cck_app.Get_ND_TXT(cc.nd, 'FREQP')) as freqp_name,--40
                                           cck_app.Get_ND_TXT(cc.nd, 'CCRNG') as rang,--41
                                           (select name from cc_rang_name where rang = cck_app.Get_ND_TXT(cc.nd, 'CCRNG')) as rang_name,--42
                                           (select metr from int_accn where acc = cc.acc8 and id = 2) as metr,--43
                                           (select name from  int_metr where metr in (select metr from int_accn where acc = cc.acc8 and id = 2)) as metr_name, --44
                                           (select ir from int_ratn where acc = cc.acc8 and id = 2) as metr_r,--45
                                           cck_app.Get_ND_TXT(cc.nd, 'SN8_R') as sn8,--46
                                           (SELECT r.ir FROM int_ratn r, int_accn i
                                             WHERE r.acc=i.acc and r.id=i.id and r.acc=cc.acc8 and r.id=4 
                                               and r.bdat=(select max(bdat) from int_ratn WHERE acc=r.ACC and id=r.id and bdat<=gl.bd)) as sk4,--47
                                           cck_app.Get_ND_TXT(cc.nd, 'I_CR9') as icr9,--48
                                           decode(cck_app.Get_ND_TXT(cc.nd, 'I_CR9'),'0','Відновлюваний','Невідновлюваний') as icr9name,--49
                                           cck_app.Get_ND_TXT(cc.nd, 'DAYSN') as daysn,--50
                                           cck_app.Get_ND_TXT(cc.nd, 'DATSN') as datsn,--51
                                           cck_app.Get_ND_TXT(cc.nd, 'DAYNP') as daynp,--52
                                           decode(cck_app.Get_ND_TXT(cc.nd, 'DAYNP'),'0','День','1','Місяць','Інше') as daynp_name, --53
                                           (select nb from banks where mfo = cc.mfokred) as bank_name, --54
                                            cck_app.Get_ND_TXT(cc.nd, 'FLAGS') as FLAGS --55
                                      from cc_v cc, customer c, sb_ob22 cp, cc_aim ca, int_accn ia
                                     where cc.rnk = c.rnk
                                       and cc.prod = cp.r020||cp.ob22
                                       and cc.aim = ca.aim
                                       and cc.acc8 = ia.acc
                                       and ia.id = 0
                                       and cc.nd = :nd";
                cmd.Parameters.Add("nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);
                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    credit.CC_ID = reader.GetString(1);
                    credit.Dat1 = reader.GetDateTime(2);
                    credit.Dat4 = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? (DateTime?)null : reader.GetDateTime(3);
                    credit.Dat2 = reader.GetDateTime(4);
                    credit.Dat3 = reader.GetDateTime(5);
                    credit.nKV = reader.GetInt32(6);
                    credit.nS = reader.GetDecimal(7);
                    credit.nVID = reader.GetInt32(8);
                    credit.nISTRO = reader.GetInt32(9);
                    credit.nCEL = reader.GetInt32(10);
                    credit.MS_NX = reader.GetString(11);
                    credit.nFIN = String.IsNullOrEmpty(reader.GetValue(12).ToString()) ? (decimal?)null : reader.GetInt32(12);
                    credit.nOBS = String.IsNullOrEmpty(reader.GetValue(13).ToString()) ? (decimal?)null : reader.GetInt32(13);
                    credit.sAIM = String.IsNullOrEmpty(reader.GetValue(14).ToString()) ? String.Empty : reader.GetString(14);
                    credit.NLS = String.IsNullOrEmpty(reader.GetValue(15).ToString()) ? String.Empty : reader.GetString(15);
                    credit.nBANK = String.IsNullOrEmpty(reader.GetValue(16).ToString()) ? String.Empty : reader.GetString(16);
                    credit.nFREQ = reader.GetInt32(17);
                    credit.dfPROC = reader.GetDecimal(18);
                    credit.nBasey = String.IsNullOrEmpty(reader.GetValue(19).ToString()) ? (decimal?)null : reader.GetInt32(19);
                    credit.dfDen = reader.GetInt32(20);
                    credit.DATNP = String.IsNullOrEmpty(reader.GetValue(21).ToString()) ? (DateTime?)null : reader.GetDateTime(21);
                    credit.nFREQP = String.IsNullOrEmpty(reader.GetValue(22).ToString()) ? String.Empty : reader.GetString(22);
                    credit.nKom = String.IsNullOrEmpty(reader.GetValue(23).ToString()) ? (decimal?)null : Convert.ToDecimal(reader.GetValue(23).ToString().Replace(".", ","));
                    credit.nRNK = reader.GetInt32(24);
                    credit.OKPO = reader.GetString(25);
                    credit.NMK = reader.GetString(26);
                    credit.INIC = String.IsNullOrEmpty(reader.GetValue(27).ToString()) ? String.Empty : reader.GetString(27);
                    credit.PRODNAME = String.IsNullOrEmpty(reader.GetValue(28).ToString()) ? String.Empty : reader.GetString(28);
                    credit.AIMNAME = String.IsNullOrEmpty(reader.GetValue(29).ToString()) ? String.Empty : reader.GetString(29);
                    credit.ACC8 = String.IsNullOrEmpty(reader.GetValue(30).ToString()) ? (Int64?)null : reader.GetInt64(30);
                    credit.BASEM = String.IsNullOrEmpty(reader.GetValue(31).ToString()) ? (Int32?)null : reader.GetInt32(31);
                    credit.S_SDI = String.IsNullOrEmpty(reader.GetValue(32).ToString()) ? (decimal?)null : Convert.ToDecimal(reader.GetString(32).Replace(".", ","));
                    credit.nKVNAME = String.IsNullOrEmpty(reader.GetValue(33).ToString()) ? String.Empty : reader.GetString(33);
                    credit.nVIDNAME = String.IsNullOrEmpty(reader.GetValue(34).ToString()) ? String.Empty : reader.GetString(34);
                    credit.nISTRONAME = String.IsNullOrEmpty(reader.GetValue(35).ToString()) ? String.Empty : reader.GetString(35);
                    credit.nFINNAME = String.IsNullOrEmpty(reader.GetValue(36).ToString()) ? String.Empty : reader.GetString(36);
                    credit.nOBSNAME = String.IsNullOrEmpty(reader.GetValue(37).ToString()) ? String.Empty : reader.GetString(37);
                    credit.nFREQNAME = String.IsNullOrEmpty(reader.GetValue(38).ToString()) ? String.Empty : reader.GetString(38);
                    credit.nBaseyNAME = String.IsNullOrEmpty(reader.GetValue(39).ToString()) ? String.Empty : reader.GetString(39);
                    credit.nFREQPNAME = String.IsNullOrEmpty(reader.GetValue(40).ToString()) ? String.Empty : reader.GetString(40);
                    credit.RANG = String.IsNullOrEmpty(reader.GetValue(41).ToString()) ? (decimal?)null : Convert.ToDecimal(reader.GetString(41).Replace(".", ","));
                    credit.RANGNAME = String.IsNullOrEmpty(reader.GetValue(42).ToString()) ? String.Empty : reader.GetString(42);
                    credit.METR = String.IsNullOrEmpty(reader.GetValue(43).ToString()) ? (decimal?)null : reader.GetDecimal(43);
                    credit.METRNAME = String.IsNullOrEmpty(reader.GetValue(44).ToString()) ? String.Empty : reader.GetString(44);
                    credit.METR_R = String.IsNullOrEmpty(reader.GetValue(45).ToString()) ? (decimal?)null : reader.GetDecimal(45);
                    credit.SN8 = String.IsNullOrEmpty(reader.GetValue(46).ToString()) ? (decimal?)null : Convert.ToDecimal(reader.GetString(46).Replace(".", ","));
                    credit.SK4 = String.IsNullOrEmpty(reader.GetValue(47).ToString()) ? (decimal?)null : reader.GetDecimal(47);
                    credit.I_CR9 = String.IsNullOrEmpty(reader.GetValue(48).ToString()) ? (decimal?)null : Convert.ToDecimal(reader.GetString(48).Replace(".", ","));
                    credit.I_CR9NAME = String.IsNullOrEmpty(reader.GetValue(49).ToString()) ? String.Empty : reader.GetString(49);
                    credit.DAYSN = String.IsNullOrEmpty(reader.GetValue(50).ToString()) ? String.Empty : reader.GetString(50);
                    credit.DATSN = String.IsNullOrEmpty(reader.GetValue(51).ToString()) ? (DateTime?)null : Convert.ToDateTime(reader.GetString(51));
                    credit.DAYNP = String.IsNullOrEmpty(reader.GetValue(52).ToString()) ? String.Empty : reader.GetString(52);
                    credit.DAYNPNAME = String.IsNullOrEmpty(reader.GetValue(53).ToString()) ? String.Empty : reader.GetString(53);
                    credit.nBANKNAME = String.IsNullOrEmpty(reader.GetValue(54).ToString()) ? String.Empty : reader.GetString(54);
                    credit.FLAGS = String.IsNullOrEmpty(reader.GetValue(55).ToString()) ? String.Empty : reader.GetString(55);                    
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return credit;
        }

        public PrologParam GetProlog(decimal nd)
        {
            PrologParam prolog = new PrologParam();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                //Нужно подумать на счет вьюшки
                cmd.CommandText = @"select NVL(kprolog,0) + 1, sos from cc_deal where nd = :nd";
                cmd.Parameters.Add("nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);
                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    prolog.KPROLOG = String.IsNullOrEmpty(reader.GetValue(0).ToString()) ? (decimal?)null : reader.GetDecimal(0);
                    prolog.SOS = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? (decimal?)null : reader.GetDecimal(1);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return prolog;
        }

        public IQueryable<MultiExtInt> getMultiExtInt(decimal nd)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            List<MultiExtInt> multiInts = new List<MultiExtInt>();
            string tag = String.Empty;
            decimal? val = null;
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"select tag, txt from nd_txt where nd = :p_nd and substr(tag,1,1) = 'P'";
                cmd.Parameters.Add("nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);

                OracleDataReader readerTag = cmd.ExecuteReader();
                cmd.CommandText = @"SELECT kv FROM tabval WHERE to_char(kv)=:sKv";

                while (readerTag.Read())
                {
                    MultiExtInt multi = new MultiExtInt();
                    tag = readerTag.GetString(0);
                    var tmpTag = tag.Substring(1, 3);
                    val = String.IsNullOrEmpty(readerTag.GetValue(1).ToString()) ? (decimal?)null : Convert.ToDecimal(readerTag.GetString(1).Replace(".", ","));
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("sKv", OracleDbType.Varchar2, tmpTag, System.Data.ParameterDirection.Input);

                    OracleDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        multi.KV = Convert.ToDecimal(reader.GetValue(0).ToString());
                        multi.PROC = val;
                        multiInts.Add(multi);
                    }
                }

                return multiInts.AsQueryable();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        public string SetProlog(decimal nd, DateTime bnkDate, decimal kprolog, decimal sos, DateTime dateStart, DateTime dateEnd)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                //Нужно подумать на счет вьюшки
                cmd.CommandText = @"insert into cc_prol(nd, fdat, npp, mdate, txt, acc, dmdat) values(:nd, :bnkdate, :kprolog, :date_start, null, null, :date_end)";
                cmd.Parameters.Add("nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("bnkdate", OracleDbType.Date, bnkDate, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("kprolog", OracleDbType.Decimal, kprolog, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("date_start", OracleDbType.Date, dateStart, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("date_end", OracleDbType.Date, dateEnd, System.Data.ParameterDirection.Input);

                cmd.ExecuteNonQuery();

                /*if (bnkDate == dateEnd)
                {*/
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.CommandText = @"cck.CC_PROLONG";
                cmd.Parameters.Add("nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("date_end", OracleDbType.Date, dateEnd, System.Data.ParameterDirection.Input);

                cmd.ExecuteNonQuery();
                //}

                cmd.Parameters.Clear();
                cmd.CommandText = @"cck.cc_lim_null";
                cmd.Parameters.Add("p_nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                return e.Message;
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return "Ok";
        }
    }
}