using BarsWeb.Areas.Kernel.Models;
using System.Collections.Generic;
using BarsWeb.Areas.Forex.Infrastructure.DI.Abstract;
using Areas.Forex.Models;
using BarsWeb.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Kendo.Mvc.UI;
using System.Linq;
using Oracle.DataAccess.Client;
using BarsWeb.Areas.Forex.Models;
using System.Data;
using System;
using System.Globalization;
using System.Text;
using Bars.Classes;

namespace BarsWeb.Areas.Forex.Infrastucture.DI.Implementation
{
    public class RegularDealsRepository : IRegularDealsRepository
    {
        public BarsSql _getSql;
        readonly ForexEntities _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        public RegularDealsRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter)
        {
            var connectionStr = EntitiesConnection.ConnectionString("Forex", "Forex");
            _entities = new ForexEntities(connectionStr);
            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }

        public DateTime GetBankDate()
        {
            DateTime bdate = _entities.ExecuteStoreQuery<DateTime>("SELECT bankdate FROM dual").FirstOrDefault();
            return bdate;
        }

        public decimal? GetCrossCourse(decimal KVA, decimal KVB, DateTime BankDate)
        {
            string query = string.Format(@"SELECT round(gl.p_icurval(:KVB,100,(SELECT bankdate FROM dual))/gl.p_icurval(:KVA,100,(SELECT bankdate FROM dual)), 9)  FROM dual");
            object[] paramsQuery = new object[] {
                 new OracleParameter("KVB", OracleDbType.Decimal) { Value = KVB },
                 new OracleParameter("KVA", OracleDbType.Decimal) { Value = KVA }
                    //new OracleParameter("bankdate", OracleDbType.Date) { Value = BankDate },
                };
            return (decimal)_entities.ExecuteStoreQuery<decimal?>(query, paramsQuery).FirstOrDefault();
        }

        public decimal? GetFinResult(decimal KVA, decimal NSA, decimal KVB, decimal NSB)
        {
            CultureInfo cultureInfo = new CultureInfo("uk-UA");

            string query = string.Format(@"SELECT ( gl.p_icurval(:KVA,:nSa,(SELECT bankdate FROM dual))-gl.p_icurval(:KVB,:nSb, (SELECT bankdate FROM dual)) ) /100 FROM dual");
            object[] paramsQuery = new object[] {
                    new OracleParameter("KVA", OracleDbType.Decimal) { Value = KVA },
                    new OracleParameter("nSa", OracleDbType.Decimal) { Value = NSA },
                    new OracleParameter("KVB", OracleDbType.Decimal) { Value = KVB },
                     new OracleParameter("nSb", OracleDbType.Decimal) { Value = NSB }
                };
            return (decimal)_entities.ExecuteStoreQuery<decimal?>(query, paramsQuery).FirstOrDefault();
        }
        public IQueryable<BOPCODE> GetCodePurposeOfPayment(string KOD)
        {
            StringBuilder query = new StringBuilder();
            query.Append(@"select * from BOPCODE ");
            _getSql = new BarsSql()
            {
                SqlParams = new object[] { }
            };
            if (KOD != null)
            {
                query.Append("where TRANSCODE=:P_TRANSCODE");
                _getSql.SqlText = query.ToString();
                _getSql.SqlParams = new object[] {
                    new OracleParameter("P_TRANSCODE", OracleDbType.Varchar2) { Value = KOD }
                };
            }
            else
            {
                query.Append("where ROWNUM <= 1");
                _getSql.SqlText = query.ToString();
            }

            return _entities.ExecuteStoreQuery<BOPCODE>(_getSql.SqlText, _getSql.SqlParams).AsQueryable(); ;
        }

        public IQueryable<SW_BANKS> GetBanksSWIFTParticipants(string BICK)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"select * from SW_BANKS where BIC = :BIC"),
                SqlParams = new object[] {
                    new OracleParameter("BIC", OracleDbType.Varchar2) { Value = BICK }
                }
            };
            //var sql = _sqlTransformer.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<SW_BANKS>(_getSql.SqlText, _getSql.SqlParams).AsQueryable();
            return result;
        }

        public IQueryable<Prepare> GetDefSettings()
        {
            string query = string.Format(@"select GetGlobalOption('MFO')  as MFOA
                    , GetGlobalOption('BICCODE') as BiCA                    
                    , GetGlobalOption('1_PB') as KOD_BA
                    , GetGlobalOption('NAME') as NBA
                    , GetGlobalOption('OKPO') as OKPOA                        
                    , GetGlobalOption('SWIFT') as Swift  
                    , GetGlobalOption('FX_1819') as T_1819       
                    , GetGlobalOption('FX_1819S') as T_1819S 
                    , GetGlobalOption('FX_3540') as B_1819
                    ,  GetGlobalOption('FX_3540N') as B_1819N
                    ,  GetGlobalOption('FX_3640') as B_1919
                    , GetGlobalOption('FX_3640N') as B_1919N
                    , GetGlobalOption('FXREZID') as FxRezid
                    ,  GetGlobalOption('FX_1PBA_R') as FX_1PBA_R
                    , GetGlobalOption('FX_1PBB_R') as FX_1PBB_R
                    , GetGlobalOption('FX_1PBA_NR') as FX_1PBA_NR
                    , GetGlobalOption('FX_1PBB_NR') as FX_1PBB_NR
                    , GetGlobalOption('SWIFT') as strUseSwift
                    , GetGlobalOption('TELEX') as strUseTelex
                    , GetGlobalOption('SWIFT_MB') as FL_SWIFT
                    , GetGlobalOption('FX_MO') as nParamNoPrintMO
                    , kodc    as KOD_GA
                    , country as NGA       
                    from dual,  bopcount where kodc = GetGlobalOption('KOD_G')
                    ");
            return _entities.ExecuteStoreQuery<Prepare>(query).AsQueryable();
        }



        public ForexPartner GetPartnersForexDeals(string KVB, string KEY, string VALUE)
        {
            //StringBuilder query = new StringBuilder();
            var sql = @"select * from CUST_FX_AL where ({0}) and kv= :KVB";
            //var sql = @"SELECT x1.rnk as RNK, x1.mfo as MFO,  x1.bic as BIC, x1.COUNTRY as KOD_G, x1.KOD_B as KOD_B, x1.OKPO as OKPO,
            //         x1.nmk as NMK,  x1.codcagent as CODCAGENT,
            //               x2.NLS as NLS, x2.BICK as BICK, x2.NLSK as NLSK,
            //                x2.name as NAME, x2.txt as TXT, x2.agrmnt_num AS AGRMNT_NUM, x2.agrmnt_date as AGRMNT_DATE, 
            //                x2.telexnum as TELEXNUM,
            //               x2.alt_partyb as ALT_PARTYB, x2.interm_b as  INTERM_B, x2.field_58d as FIELD_58D
            //        FROM
            //        (SELECT c.rnk, b.mfo, b.bic, c.COUNTRY, b.KOD_B, c.OKPO, substr(c.nmk,1,35) nmk,  c.codcagent
            //           FROM customer c, custbank b
            //          WHERE c.rnk = b.rnk  and c.date_off is null
            //          and ({0})
            //        ) x1,    
            //         (SELECT  f.mfo, f.bic, f.NLS,  f.BICK, f.NLSK, s.name, f.txt, f.agrmnt_num, f.agrmnt_date, f.telexnum,
            //                  f.alt_partyb, f.interm_b, f.field_58d
            //           FROM forex_alien f, sw_banks s
            //           WHERE f.kv=:KVB AND UPPER(f.bick)=UPPER(s.bic (+))
            //           ) x2
            //        where (x1.mfo = x2.mfo(+) and x1.bic = x2.bic(+))";


            object[] SqlParams = new object[] { };
            _getSql = new BarsSql() { };

            switch (KEY)
            {
                case "rnk":
                    _getSql.SqlText = string.Format(sql, "RNK =:RNK");
                    _getSql.SqlParams = new object[] {
                        new OracleParameter("RNK", OracleDbType.Decimal, ParameterDirection.Input) { Value = Int64.Parse(VALUE)},
                        new OracleParameter("KVB", OracleDbType.Decimal, ParameterDirection.Input) { Value = Int64.Parse(KVB) }
                    };
                    break;
                case "mfo":
                    _getSql.SqlText = string.Format(sql, "mfo =:MFO");
                    _getSql.SqlParams = new object[] {
                        new OracleParameter("MFO", OracleDbType.Varchar2, ParameterDirection.Input) { Value = VALUE },
                        new OracleParameter("KVB", OracleDbType.Decimal, ParameterDirection.Input) { Value = Int64.Parse(KVB) }
                    };
                    break;
                case "KOD_B":
                    _getSql.SqlText = string.Format(sql, "KOD_B =:KODB");
                    _getSql.SqlParams = new object[] {
                        new OracleParameter("KODB", OracleDbType.Decimal, ParameterDirection.Input) { Value = Int64.Parse(VALUE.Trim()) },
                         new OracleParameter("KVB", OracleDbType.Decimal, ParameterDirection.Input) { Value = Int64.Parse(KVB) }
                    };
                    break;
                case "bic":
                    _getSql.SqlText = string.Format(sql, "bic=:BIC");
                    _getSql.SqlParams = new object[] {
                        new OracleParameter("BIC", OracleDbType.Varchar2, ParameterDirection.Input) { Value = VALUE },
                         new OracleParameter("KVB", OracleDbType.Decimal, ParameterDirection.Input) { Value = Int64.Parse(KVB) }
                    };
                    break;
                case "OKPO":
                    _getSql.SqlText = string.Format(sql, "okpo =:OKPO");
                    _getSql.SqlParams = new object[] {
                        new OracleParameter("OKPO", OracleDbType.Varchar2, ParameterDirection.Input) { Value =  VALUE },
                         new OracleParameter("KVB", OracleDbType.Decimal, ParameterDirection.Input) { Value = Int64.Parse(KVB) }
                    };
                    break;
            };

            return _entities.ExecuteStoreQuery<ForexPartner>(_getSql.SqlText, _getSql.SqlParams).AsQueryable().FirstOrDefault();
        }



        private void InitBanksSWIFTParticipants()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"select * from SW_BANKS"),
                SqlParams = new object[] { }
            };
        }

        private void InitCurrencyProp(decimal kv)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT lcv as ISO, name as NAME, dig as nDig, Nvl(fx_base, kv) as Ves FROM tabval WHERE kv= :KV"),
                SqlParams = new object[] { new OracleParameter("KV", OracleDbType.Decimal) { Value = kv } }
            };
        }

        private void InitRevenue(decimal? kv)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"select a.NLS, SUBSTR(a.NMS,1,38) as ACC_NAME, B.BIC as BICKA, B.THEIR_ACC as SSLA
                    from ACCOUNTS a INNER JOIN BIC_ACC b ON a.acc = b.acc WHERE a.KV= :KVA AND a.DAZS IS NULL 
                    AND a.ACC IN (SELECT ACC FROM BIC_ACC) ORDER BY a.NLS"),
                SqlParams = new object[] { new OracleParameter("KVA", OracleDbType.Decimal) { Value = kv } }
            };
        }

        private void InitPartnerRevenue(string KVB, string KEY, string VALUE)
        {
            var sql = @"SELECT  f.BICK, f.NLSK, s.name
                       FROM forex_alien f, sw_banks s
                       WHERE f.kv=:KVB AND UPPER(f.bick)=UPPER(s.bic (+)) and (f.bick is not null) and ({0})";

            object[] SqlParams = new object[] { };
            _getSql = new BarsSql() { };

            switch (KEY)
            {
                case "mfo":
                    _getSql.SqlText = string.Format(sql, "b.mfo =:MFO");
                    _getSql.SqlParams = new object[] {
                        new OracleParameter("MFO", OracleDbType.Varchar2, ParameterDirection.Input) { Value = VALUE },
                        new OracleParameter("KVB", OracleDbType.Decimal, ParameterDirection.Input) { Value = Int64.Parse(KVB) }
                    };
                    break;
                case "KOD_B":
                    _getSql.SqlText = string.Format(sql, "b.KOD_B =:KODB");
                    _getSql.SqlParams = new object[] {
                        new OracleParameter("KODB", OracleDbType.Decimal, ParameterDirection.Input) { Value = Int64.Parse(VALUE.Trim()) },
                         new OracleParameter("KVB", OracleDbType.Decimal, ParameterDirection.Input) { Value = Int64.Parse(KVB) }
                    };
                    break;
                case "bic":
                    _getSql.SqlText = string.Format(sql, "b.bic=:BIC");
                    _getSql.SqlParams = new object[] {
                        new OracleParameter("BIC", OracleDbType.Varchar2, ParameterDirection.Input) { Value = VALUE },
                         new OracleParameter("KVB", OracleDbType.Decimal, ParameterDirection.Input) { Value = Int64.Parse(KVB) }
                    };
                    break;
            };
        }

        private void InitInic()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"select CODE, TXT from CP_OB_INITIATOR ORDER BY code"),
                SqlParams = new object[] { }
            };
        }

        public IQueryable<Models.Currency> GetCurrencyProp(decimal kv)
        {
            InitCurrencyProp(kv);
            var result = _entities.ExecuteStoreQuery<Models.Currency>(_getSql.SqlText, _getSql.SqlParams).AsQueryable();
            return result;
        }

        public string GetTransactionLength(CalcTransactionLengthModel calcModel)
        {

            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = new OracleCommand("forex.get_forextype", connection))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                var resultObject = new OracleParameter("p_result", OracleDbType.Varchar2, 4000, null,
                    ParameterDirection.ReturnValue);

                cmd.Parameters.Add(resultObject);
                object[] parameters =
                {
                    new OracleParameter("p_dat", OracleDbType.Date) {Value = calcModel.CurrentDate},
                    new OracleParameter("p_data", OracleDbType.Date) {Value = calcModel.DateA},
                    new OracleParameter("p_datb", OracleDbType.Date) {Value = calcModel.DateB}
            };
                cmd.Parameters.AddRange(parameters);
                cmd.ExecuteNonQuery();
                return resultObject.Value.ToString();
            }

                
        }

        public List<Revenue> GetRevenueDropDown(decimal? kv)
        {
            InitRevenue(kv);
            var result = _entities.ExecuteStoreQuery<Revenue>(_getSql.SqlText, _getSql.SqlParams).ToList();
            return result;
        }



        public List<INIC> GetINICDropDown()
        {
            InitInic();
            var result = _entities.ExecuteStoreQuery<INIC>(_getSql.SqlText, _getSql.SqlParams).ToList();
            return result;
        }

        public IEnumerable<FOREX_OB22> GetForexType()
        {
            InitForexType(10);
            var result = _entities.ExecuteStoreQuery<FOREX_OB22>(_getSql.SqlText, _getSql.SqlParams);
            return result;
        }

        private void InitForexType(int maxId)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"select ID, KOD from FOREX_OB22 where ID <= :ID ORDER BY ID"),
                SqlParams = new object[] { new OracleParameter("ID", OracleDbType.Int32).Value = maxId }
            };
        }

        public OutDealTag SaveGhanges(Agreement agreement)
        {
            OutDealTag out_deal_tag = new OutDealTag();

            try
            {
                InitSaveChanges(agreement);
                _entities.ExecuteStoreCommand(_getSql.SqlText, _getSql.SqlParams);
                out_deal_tag.Out_Deal_Tag = int.Parse(((OracleParameter)_getSql.SqlParams[2]).Value.ToString());
            }
            catch (Exception e)
            {
                out_deal_tag.ErrorMessaage = e.Message;
            }
            //return out_deal_tag = int.Parse(((OracleParameter)_getSql.SqlParams[2]).Value.ToString());
            return out_deal_tag;
        }


        private void InitRNKB(string MFOB, string BICB, string KOD_B)
        {
            string addSqlText = "";
            if (MFOB != null)
            {
                addSqlText = "and b.mfo =" + MFOB;
            }
            else if (BICB != null)
            {
                addSqlText = " and b.bic =" + "'" + BICB + "'";
            }
            else
            {
                addSqlText = "and b.kod_b =" + KOD_B;
            }
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT c.rnk as RNKB FROM customer c, custbank b
								          WHERE c.rnk = b.rnk
								          AND c.date_off is null
                                          AND c.KF = sys_context('bars_context','user_mfo'){0}", addSqlText),
                SqlParams = new object[] { }
            };
        }

        public decimal GetRNKB(string MFOB, string BICB, string KOD_B)
        {
            InitRNKB(MFOB, BICB, KOD_B);
            decimal result = _entities.ExecuteStoreQuery<decimal>(_getSql.SqlText, _getSql.SqlParams).Single();
            return result;
        }

        public string GetNLSA(decimal? codeAgent)
        {
            InitNLSA(codeAgent);
            string result = _entities.ExecuteStoreQuery<string>(_getSql.SqlText, _getSql.SqlParams).Single();
            return result;
        }

        public List<AccountModels> getAccModelList(decimal ND, DataSourceRequest request)
        {
            IntiAccMode(ND);
            var sql = _sqlTransformer.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<AccountModels>(sql.SqlText, sql.SqlParams).ToList();
            return result;
        }

        public decimal getAccModelListDataCount(decimal ND, DataSourceRequest request)
        {
            IntiAccMode(ND);
            var count = _kendoSqlCounter.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }

        private void IntiAccMode(decimal ND)
        {
            StringBuilder query = new StringBuilder();
            query.Append(@"SELECT o.ref, o.fdat, o.tt, decode(o.dk, 0, o.s, 0) / power(10, t.dig) as SDn,
                decode(o.dk, 1, o.s, 0) / power(10, t.dig) as SKn,
                o.sos, ACCOUNTS.nms, ACCOUNTS.nls, ACCOUNTS.kv, t.dig FROM opldok o, ACCOUNTS, tabval t  WHERE ACCOUNTS.acc = o.acc
                AND ACCOUNTS.kv = t.kv AND o.ref in ");
            query.AppendLine("(select ref from fx_deal_ref where deal_tag = :nND)");
            query.AppendLine(" ORDER BY o.fdat, o.ref, o.stmt, o.dk");
            _getSql = new BarsSql()
            {
                SqlText = string.Format(query.ToString()),
                SqlParams = new object[] { new OracleParameter("nND", OracleDbType.Decimal) { Value = ND } }
            };
        }


        public void SWIFTCreateMsg(decimal DealTag)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"begin SWIFT.Gen3xxMsg(300,:nDealTag); end; "),
                SqlParams = new object[] { new OracleParameter("nDealTag", OracleDbType.Decimal) { Value = DealTag } }
            };

            _entities.ExecuteStoreCommand(_getSql.SqlText, _getSql.SqlParams);
        }

        private void InitNLSA(decimal? codeAgent)
        {
            if (codeAgent == 1)
            {
                _getSql = new BarsSql()
                {
                    SqlText = string.Format(@"select val from PARAMS$BASE where par in ('FX_3540')"),
                    SqlParams = new object[] { }
                };
            }
            else
            {
                _getSql = new BarsSql()
                {
                    SqlText = string.Format(@"select val from PARAMS$BASE where par in ('FX_3540N')"),
                    SqlParams = new object[] { }
                };
            }

        }

        private void DeleteForexCreteria(FOREX_ALIEN partner)
        {
            StringBuilder query = new StringBuilder();
            object[] paramsQuery = new object[] {

            };
            if (partner.MFO != null)
            {
                query.Append(@"DELETE FROM forex_alien WHERE mfo=:MFOB and kv=:KVB");
                paramsQuery = new object[] {
                    new OracleParameter("MFOB", OracleDbType.Decimal) { Value = partner.MFO },
                    new OracleParameter("KVB", OracleDbType.Decimal) { Value = partner.KV }
                };
            }
            else
            {
                query.Append(@"DELETE FROM forex_alien WHERE bic=:BICB and kv=:KVB");
                paramsQuery = new object[] {
                    new OracleParameter("BICB", OracleDbType.Decimal) { Value = partner.BIC },
                    new OracleParameter("KVB", OracleDbType.Decimal) { Value = partner.KV }
                };
            }
            _entities.ExecuteStoreCommand(query.ToString(), paramsQuery);
        }


        public void InsertOperw(decimal pInic, decimal nND)
        {
            InitInsertOperw(pInic, nND);
        }

        private void InitInsertOperw(decimal pInic, decimal nND)
        {
            StringBuilder query = new StringBuilder();
            query.Append(@"INSERT INTO operw (ref,tag,value) select ref, 'CP_IN', :pInic from fx_deal_ref where deal_tag = :nND");

            object[] paramsQuery = new object[]
                {
                    new OracleParameter("pInic", OracleDbType.Decimal) { Value = pInic },
                    new OracleParameter("nND", OracleDbType.Decimal) { Value = nND }
                };
            _entities.ExecuteStoreCommand(query.ToString(), paramsQuery);
        }

        private void InitSavePartner(FOREX_ALIEN partner)
        {
            CultureInfo cultureInfo = new CultureInfo("uk-UA");

            StringBuilder query = new StringBuilder();
            query.Append(@"INSERT INTO forex_alien (MFO, BIC, NAME, NLS, KOD_G, KOD_B, OKPO, KV, BICK, NLSK, ID, TXT, AGRMNT_NUM, 
            AGRMNT_DATE, INTERM_B, CODCAGENT, TELEXNUM, ALT_PARTYB, FIELD_58D ) VALUES (:MFOB,:BICB,:NBB,:NLSB,:KOD_GB,:KOD_BB,:OKPOB,:KVB,
            :BICKB, :SSB, :id, :TXT, :dfAgrNum, :dfAgrDate, :dfB57A, :codcagent, :TELEXNUM, :dfB56A, :s58D)");

            object[] paramsQuery = new object[]
                {
                    new OracleParameter("MFOB", OracleDbType.Varchar2) { Value = partner.MFO },
                    new OracleParameter("BICB", OracleDbType.Varchar2) { Value = partner.BIC },
                    new OracleParameter("NBB", OracleDbType.Varchar2) { Value = partner.NAME},
                    new OracleParameter("NLSB", OracleDbType.Varchar2) { Value = partner.NLS },
                    new OracleParameter("KOD_GB", OracleDbType.Varchar2) { Value = partner.KOD_G },
                    new OracleParameter("KOD_BB", OracleDbType.Varchar2) { Value = partner.KOD_B },
                    new OracleParameter("OKPOB", OracleDbType.Varchar2) { Value = partner.OKPO },
                    new OracleParameter("KVB", OracleDbType.Decimal) { Value = partner.KV },
                    new OracleParameter("BICKB", OracleDbType.Varchar2) { Value = partner.BICK },
                    new OracleParameter("SSB", OracleDbType.Varchar2) { Value = partner.NLSK },
                    new OracleParameter("ID", OracleDbType.Decimal) { Value = 0},
                    new OracleParameter("TXT", OracleDbType.Varchar2) { Value = partner.TXT},
                    new OracleParameter("dfAgrNum", OracleDbType.Varchar2) { Value = partner.AGRMNT_NUM},
                    new OracleParameter("dfAgrDate", OracleDbType.Date) { Value = partner.AGRMNT_DATE != null ? DateTime.Parse(partner.AGRMNT_DATE, cultureInfo) : (DateTime?)null },
                    new OracleParameter("dfB57A", OracleDbType.Varchar2) { Value = partner.ALT_PARTYB },
                    new OracleParameter("codcagent", OracleDbType.Decimal) { Value = partner.KOD_B == "804" ? 1 : 2},
                    new OracleParameter("TELEXNUM", OracleDbType.Varchar2) { Value = partner.TELEXNUM },
                    new OracleParameter("dfB56A", OracleDbType.Varchar2) { Value = partner.INTERM_B},
                    new OracleParameter("s58D", OracleDbType.Varchar2) { Value = partner.FIELD_58D}
                };

            _entities.ExecuteStoreCommand(query.ToString(), paramsQuery);
        }



        public void SaveGhangesPartners(FOREX_ALIEN partner)
        {
            DeleteForexCreteria(partner);
            InitSavePartner(partner);
        }

        private void InitSaveChanges(Agreement agreement)
        {
            CultureInfo cultureInfo = new CultureInfo("uk-UA");

            int out_deal_tag = 0;
            _getSql = new BarsSql()
            {
                SqlText = @" declare
                                p_deal_tag fx_deal.deal_tag%type;
                             begin
                                  bars.forex.create_deal_EX
                                  ( :p_dealtype , :p_mode , :p_deal_tag, :p_swap_tag, :p_ntik, :p_dat, :p_kva, :p_data, 
                                    :p_suma, :p_sumc, :p_kvb , :p_datb, :p_sumb, :p_sumb1, :p_sumb2, :p_rnk , :p_nb, :p_skb, 
                                    :p_swi_ref, :p_swi_bic, :p_swi_acc, :p_nlsa, :p_swo_bic, :p_swo_acc, :p_nlsb, :p_b_payflag, 
                                    :p_agrmnt_num, :p_agrmnt_date, :p_interm_b, :p_alt_partyb, :p_bicb, :p_curr_base, 
                                    :p_telexnum, :p_kod_na, :p_kod_nb, :p_field_58d, :p_vn_flag, :p_nazn,:p_f092,:p_forex
                                  );
                              end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_dealtype", OracleDbType.Decimal) { Value = agreement.DealType },
                    new OracleParameter("p_mode", OracleDbType.Decimal) { Value = agreement.Mode },
                    new OracleParameter("p_deal_tag", OracleDbType.Decimal, out_deal_tag, ParameterDirection.Output),
                    new OracleParameter("p_swap_tag", OracleDbType.Decimal) { Value = agreement.SwapTag },
                    new OracleParameter("p_ntik", OracleDbType.Varchar2) { Value = agreement.NTIK },
                    new OracleParameter("p_dat", OracleDbType.Date) { Value = agreement.DAT != null ? DateTime.Parse(agreement.DAT, cultureInfo) : (DateTime?)null },
                    new OracleParameter("p_kva", OracleDbType.Decimal) { Value = agreement.KVA },
                    new OracleParameter("p_data", OracleDbType.Date) { Value = agreement.DAT_A != null ? DateTime.Parse(agreement.DAT_A, cultureInfo) : (DateTime?)null },
                    new OracleParameter("p_suma", OracleDbType.Decimal) { Value = agreement.SUMA},
                    new OracleParameter("p_sumc", OracleDbType.Decimal) { Value = agreement.SUMC},
                    new OracleParameter("p_kvb", OracleDbType.Decimal) { Value = agreement.KVB},
                    new OracleParameter("p_datb", OracleDbType.Date) { Value = agreement.DAT_B != null ? DateTime.Parse(agreement.DAT_B, cultureInfo) : (DateTime?)null },
                    new OracleParameter("p_sumb", OracleDbType.Decimal) { Value = agreement.SUMB},
                    new OracleParameter("p_sumb1", OracleDbType.Decimal) { Value = 0},
                    new OracleParameter("p_sumb2", OracleDbType.Decimal) { Value = 0},
                    new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = agreement.RNK},
                    new OracleParameter("p_nb", OracleDbType.Varchar2) { Value = agreement.NB},
                    new OracleParameter("p_skb", OracleDbType.Varchar2) { Value = agreement.SKB},
                    new OracleParameter("p_swi_ref", OracleDbType.Decimal) { Value = agreement.SWI_REF},
                    new OracleParameter("p_swi_bic", OracleDbType.Varchar2, ParameterDirection.Input) { Value = agreement.SWI_BIC.Trim()},
                    new OracleParameter("p_swi_acc", OracleDbType.Varchar2) { Value = agreement.SWI_ACC},
                    new OracleParameter("p_nlsa", OracleDbType.Varchar2) { Value = agreement.NLSA},
                    new OracleParameter("p_swo_bic", OracleDbType.Char) { Value = agreement.SWO_BIC},
                    new OracleParameter("p_swo_acc", OracleDbType.Varchar2) { Value = agreement.SWO_ACC},
                    new OracleParameter("p_nlsb", OracleDbType.Varchar2) { Value = agreement.NLSB},
                    new OracleParameter("p_b_payflag", OracleDbType.Decimal) { Value = agreement.B_PAYFLAG},
                    new OracleParameter("p_agrmnt_num", OracleDbType.Varchar2) { Value = agreement.ACRMNT_NUM},
                    new OracleParameter("p_agrmnt_date", OracleDbType.Date) { Value = agreement.ACRMNT_DATE != null ? DateTime.Parse(agreement.ACRMNT_DATE, cultureInfo) : (DateTime?)null },
                    new OracleParameter("p_interm_b", OracleDbType.Varchar2) { Value = agreement.INTERM_B},
                    new OracleParameter("p_alt_partyb", OracleDbType.Varchar2) { Value = agreement.ALT_PARTYB},
                    new OracleParameter("p_bicb", OracleDbType.Char) { Value = agreement.BICB},
                    new OracleParameter("p_curr_base", OracleDbType.Char) { Value = agreement.CURR_BASE},
                    new OracleParameter("p_telexnum", OracleDbType.Varchar2) { Value = agreement.TELEXNUM},
                    new OracleParameter("p_kod_na", OracleDbType.Varchar2) { Value = agreement.KOD_NA},
                    new OracleParameter("p_kod_nb", OracleDbType.Varchar2) { Value = agreement.KOD_NB },
                    new OracleParameter("p_field_58d", OracleDbType.Varchar2) { Value = agreement.FIELD_58D },
                    new OracleParameter("p_vn_flag", OracleDbType.Decimal) { Value = agreement.VN_FLAG == true ? 1 : 0},
                    new OracleParameter("p_nazn", OracleDbType.Varchar2) {  Value = agreement.NAZN},
                    new OracleParameter("p_f092", OracleDbType.Varchar2) {  Value = agreement.F092_CODE},
                    new OracleParameter("p_forex", OracleDbType.Varchar2) {  Value = agreement.FOREX }
                }
            };
        }

        public IQueryable<RefDetail> getSwapTag(decimal dealTag)
        {
            string query = string.Format(@"select swap_tag as nSwapTag, ref as nRef, refa as nRef1, refb as nRef2, refb2 as nRef22 from fx_deal where deal_tag = :nDealTag");
            object[] paramsQuery = new object[] {
                    new OracleParameter("nDealTag", OracleDbType.Decimal) { Value = dealTag }
                };
            return _entities.ExecuteStoreQuery<RefDetail>(query, paramsQuery).AsQueryable();
        }

        public decimal GetCheckPS(string MFO, decimal KV)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"Select pul.MVPS_FIL(:p_mfo, :p_kv) l_ret from dual"),
                SqlParams = new object[] {
                    new OracleParameter("p_mfo", OracleDbType.Varchar2) { Value = MFO },
                    new OracleParameter("p_kv", OracleDbType.Decimal) { Value = KV }
                }
            };
            return _entities.ExecuteStoreQuery<decimal>(_getSql.SqlText, _getSql.SqlParams).FirstOrDefault();
        }

        public decimal? GetSWRef(decimal DealTag)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT swo_ref FROM fx_deal WHERE deal_tag = :nDealTag"),
                SqlParams = new object[] {
                    new OracleParameter("nDealTag", OracleDbType.Varchar2) { Value = DealTag }
                }
            };
            return _entities.ExecuteStoreQuery<decimal?>(_getSql.SqlText, _getSql.SqlParams).FirstOrDefault();
        }

        public IQueryable<CustLims> GetCustLimits(decimal OKPOB)
        {
            string query = string.Format(@"SELECT nvl(a.lim,0)/100 as colLim, rnk_ostb(a.rnk)/100 as colOstBQ, 
                                          nvl(a.lim,0)/100 - rnk_ostb(a.rnk)/100  as colPLBQ   
                                          FROM customer a WHERE a.okpo=:OKPOB");
            object[] paramsQuery = new object[] {
                    new OracleParameter("OKPOB", OracleDbType.Decimal) { Value = OKPOB }
                };
            return _entities.ExecuteStoreQuery<CustLims>(query, paramsQuery).AsQueryable();
        }


        public void PutDepo(decimal DealTag)
        {
            string query = string.Format(@"begin pul.put('DSW',:Deal_tag); end;");
            object[] paramsQuery = new object[] {
                    new OracleParameter("Deal_tag", OracleDbType.Decimal) { Value = DealTag }
                };
            _entities.ExecuteStoreCommand(query, paramsQuery);
        }

        public string GetDealType(string DealTag)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"select pul.get('PAR_SWAP') from dual"),
                SqlParams = new object[] {
                    new OracleParameter("nDealTag", OracleDbType.Varchar2) { Value = DealTag }
                }
            };
            return _entities.ExecuteStoreQuery<string>(_getSql.SqlText, _getSql.SqlParams).FirstOrDefault();
        }

        public string GetDealTag()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"select pul.get('DEAL_TAG') from dual"),
                SqlParams = new object[] { }
            };
            return _entities.ExecuteStoreQuery<string>(_getSql.SqlText, _getSql.SqlParams).FirstOrDefault();
        }

        public IQueryable<FX_DEAL> GetFXDeal(decimal DealTag)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"select * from fx_deal where deal_tag = :deal_Tag"),
                SqlParams = new object[] {
                    new OracleParameter("deal_Tag", OracleDbType.Decimal) { Value = DealTag }
                }
            };
            return _entities.ExecuteStoreQuery<FX_DEAL>(_getSql.SqlText, _getSql.SqlParams).AsQueryable();
        }

        public IQueryable<FXUPD> GetFXUPDeal(decimal DealTag)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT f.deal_tag, f.dat, 
                    f.kva, ta.name as NameVA, f.dat_a, f.suma,
                    f.kvb, tb.name as NameVB, f.dat_b, f.sumb, f.bicb,
                    f.swi_bic, f.swi_acc, f.swo_bic, f.swo_acc, f.interm_b, f.alt_partyb
                       FROM fx_deal f, tabval ta, tabval tb 
                    WHERE f.deal_tag = :deal_Tag
                          AND f.kva = ta.kv
                          AND f.kvb = tb.kv"),
                SqlParams = new object[] {
                    new OracleParameter("deal_Tag", OracleDbType.Decimal) { Value = DealTag }
                }
            };
            return _entities.ExecuteStoreQuery<FXUPD>(_getSql.SqlText, _getSql.SqlParams).AsQueryable();
        }

        public FXUPD GetFXUPDealAllFields(FXUPD _fxupd)
        {
            string SqlText = "";
            object[] SqlParams = new object[] { };

            //----NBA
            SqlText = string.Format(@"select GetGlobalOption('NAME') as NBA from dual");
            _fxupd.NBA = _entities.ExecuteStoreQuery<string>(SqlText, null).FirstOrDefault();
            //----BICA
            SqlText = string.Format(@"SELECT val  FROM params WHERE par='BICCODE'");
            _fxupd.BICA = _entities.ExecuteStoreQuery<string>(SqlText, null).FirstOrDefault();
            //----NBB 
            SqlText = string.Format(@"SELECT name FROM sw_banks WHERE bic=:BICB");
            SqlParams = new object[] {
                    new OracleParameter("BICB", OracleDbType.Varchar2) { Value = _fxupd.BICB }
               };
            _fxupd.NBB = _entities.ExecuteStoreQuery<string>(SqlText, SqlParams).FirstOrDefault();
            //----NBKB            
            SqlText = string.Format(@"SELECT name FROM sw_banks WHERE bic=:BICKB");
            SqlParams = new object[] {
                    new OracleParameter("BICKB", OracleDbType.Varchar2) { Value = _fxupd.SWO_BIC }
               };
            _fxupd.NBKB = _entities.ExecuteStoreQuery<string>(SqlText, SqlParams).FirstOrDefault();
            return _fxupd;
        }

        public void UpdateChanges(FXUPD fxupd)
        {

            InitUpdateChanges(fxupd);
            _entities.ExecuteStoreCommand(_getSql.SqlText, _getSql.SqlParams);
        }

        private void InitUpdateChanges(FXUPD fxupd)
        {
            _getSql = new BarsSql()
            {
                SqlText = @" begin
                                  bars.fx_update
                                  ( :p_dealRef, :p_swiBic,
                                    :p_swiAcc, :p_swoBic, :p_swoAcc, 
                                    :p_swoInterm, :p_swoAltPartyB
                                  );
                              end;",
                SqlParams = new object[]
               {
                    new OracleParameter("p_dealRef", OracleDbType.Decimal) { Value = fxupd.DEAL_TAG },
                    new OracleParameter("p_swiBic", OracleDbType.Varchar2) { Value = fxupd.SWI_BIC },
                    new OracleParameter("p_swiAcc", OracleDbType.Varchar2) { Value = fxupd.SWI_ACC },
                    new OracleParameter("p_swoBic", OracleDbType.Varchar2) { Value = fxupd.SWO_BIC },
                    new OracleParameter("p_swoAcc", OracleDbType.Varchar2) { Value = fxupd.SWO_ACC },
                    new OracleParameter("p_swoInterm", OracleDbType.Varchar2) { Value = fxupd.INTERM_B },
                    new OracleParameter("p_swoAltPartyB", OracleDbType.Varchar2) { Value = fxupd.ALT_PARTYB }
               }
            };
        }
    }
}