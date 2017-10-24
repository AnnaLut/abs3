using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Globalization;
using System.Linq;
using System.Text;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;
using System.Data.SqlClient;
using System.Activities.Statements;
 


namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation
{
    public class SepTechAccountsRepository : ISepTechAccountsRepository
    {
        private readonly SepFiles _entities;
        private bool _isWhereAdded = false;
        private readonly IKendoSqlTransformer _sqlTransformer;     
        private readonly IBankDatesRepository _bankDateRepository;
        private BarsSql _baseSepDocsSql;
        private readonly IKendoSqlCounter _kendoSqlCounter;

        public SepTechAccountsRepository(IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter, IBankDatesRepository bankDateRepository)
        {
            var connectionStr = EntitiesConnection.ConnectionString("SepFiles", "Sep");
            _entities = new SepFiles(connectionStr);
            _sqlTransformer = kendoSqlTransformer;        
            _bankDateRepository = bankDateRepository;
            _kendoSqlCounter = kendoSqlCounter;
        }

        public IQueryable<SEPTECHACCOUNT_V1> GetSEPTECHACCOUNTV1(SepTechAccountsFilterParams fp, DataSourceRequest request)
        { 
            var result = _entities.SEPTECHACCOUNT_V1.AsQueryable();
            if (fp.SortWithoutKR.HasValue)
            {
                request.Sorts.Clear();
                var resultList = result.ToList();
                var orderedNLS =
                     fp.SortWithoutKR.Value
                     ?
                     from o in resultList
                     orderby (GetSubstr(o.NLS)) // if true then sort by asc
                     select o
                     :
                     from o in resultList
                     orderby (GetSubstr(o.NLS)) descending // else sort by desc
                     select o;
                return orderedNLS.AsQueryable();
            }
            
            return result;
        }

        public IQueryable<SEPTECHACCOUNT_V2> GetSEPTECHACCOUNTV2(SepTechAccountsFilterParams fp, DataSourceRequest request)
        {
            var result = _entities.SEPTECHACCOUNT_V2.AsQueryable();
            if (fp.SortWithoutKR.HasValue)
            {
                request.Sorts.Clear();
                var resultList = result.ToList();
                var orderedNLS =
                     fp.SortWithoutKR.Value
                     ?
                     from o in resultList
                     orderby (GetSubstr(o.NLS)) // if true then sort by asc
                     select o
                     :
                     from o in resultList
                     orderby (GetSubstr(o.NLS)) descending // else sort by desc
                     select o;

                return orderedNLS.AsQueryable();
            }    
            return result;
        }

        public IQueryable<SEPTECHACCOUNT_VQF> GetSEPTECHACCOUNTVQF(SepTechAccountsFilterParams fp, DataSourceRequest request)
        {
            var result = _entities.SEPTECHACCOUNT_VQF.AsQueryable();            
            return result;
        }

        public IEnumerable<SEPTECHACCOUNT_V2> GetCashFlowPeriod(SepTechAccountsFilterParams fp, DataSourceRequest request)
        {
            InitSepTechCashFlowPeriodSql(fp);
            var sql = _sqlTransformer.TransformSql(_baseSepDocsSql, request);
            return _entities.ExecuteStoreQuery<SEPTECHACCOUNT_V2>(sql.SqlText, sql.SqlParams);
        }

        public decimal GetCashFlowPeriodCount(SepTechAccountsFilterParams fp, DataSourceRequest request)
        {
            InitSepTechCashFlowPeriodSql(fp);
            var count = _kendoSqlCounter.TransformSql(_baseSepDocsSql, request);
            var total = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return total;
        }

        /// <summary>
        /// Получить Банковскую дату
        /// </summary>
        /// <returns>Дата установленного банковского дня</returns>
        public DateTime ? GetBankDate()
        { 
            return _bankDateRepository.GetBankDate();
        }

        public IQueryable<BankDates> GetAllBankDates(int year, int? month)
        {
            return _bankDateRepository.GetAllBankDates(year, month);
        }

        /// <summary>
        /// Создание строки для сортировки по полю NLS
        /// </summary>
        /// <param name="p">Значение NLS</param>
        /// <remarks>substr(nls,1,4)||substr(nls,6,length(nls)-5)</remarks>
        /// <returns>Обработанное значение</returns>
        string GetSubstr(string strItem)
        {                    
            string result = string.Empty;
            string s1 = strItem.Substring(1, 4);
            int iS2 = strItem.Length - 5 - 6;
            string s2 = strItem.Substring(6, iS2);
            result = s1 + s2;
            return result;
        }

        public IQueryable<SEPTECHACCOUNT_V2> GetLinkedAcc(SepTechAccountsFilterParams fp, DataSourceRequest request)
        {
            InitLinkedAcc(fp);
            var sql = _sqlTransformer.TransformSql(_baseSepDocsSql, request);
            return _entities.ExecuteStoreQuery<SEPTECHACCOUNT_V2>(sql.SqlText, sql.SqlParams).AsQueryable();
        }

        public List<SepHistoryAccDoc> GetGridHistoryAccList(SepTechAccountsFilterParams fp, DataSourceRequest request)
        {
            // Подсчет коэффициента  
            InitHistoryAccKKCountSql(fp);
            var sql2 = _sqlTransformer.TransformSql(_baseSepDocsSql, request);
         
            var totalDays = (fp.dat22.Value - fp.dat11.Value).TotalDays +1; // (+1) - текущий день к разнице          
            // Если введено значение - возврат нулевого списка
            if (totalDays < 0)
            {
                List<SepHistoryAccDoc> result0 = new List<SepHistoryAccDoc>();
                totalDays = 0;
                result0.Add(new SepHistoryAccDoc
                {
                    NN = "Итог",
                    FDAT = null,
                    SV = 0,
                    SVQ = 0,
                    OD =0,
                    ODQ = 0
                });
                return result0;
            }

            var bankDays = 
                _bankDateRepository.GetAllBankDates(DateTime.Now.Year, null)
                .Select(x => new { x.Date })
                .Where(x=>x.Date >= fp.dat11.Value && x.Date <= fp.dat22.Value)
                .OrderByDescending(x => x.Date).Take((int)totalDays).ToList();

            var list1 = bankDays.Select(x => x.Date).ToList();
 
          //  List<DateTime> listDateTime= bankDays.;
       
            // Подготовка результирующего набора
            InitHistoryAccSql(fp);
            var sql = _sqlTransformer.TransformSql(_baseSepDocsSql, request);
            var result = 
                _entities.ExecuteStoreQuery<SepHistoryAccDoc>(sql.SqlText, sql.SqlParams).ToList();

            var ИтоговыйСписок = _entities.ExecuteStoreQuery<SepHistoryAccDoc>(sql.SqlText, sql.SqlParams).ToList();
            var ИтоговыйСписок31 = _entities.ExecuteStoreQuery<SepHistoryAccDoc>(sql.SqlText, sql.SqlParams).ToList();
            var ИтоговыйСписокБД = _entities.ExecuteStoreQuery<SepHistoryAccDoc>(sql.SqlText, sql.SqlParams).ToList();

            ИтоговыйСписокБД = 
                      (from d in ИтоговыйСписокБД
                       where list1.Contains(d.FDAT.Value)
                       select d).ToList(); 

            // Итог
           result.Add(new SepHistoryAccDoc
            {
                NN = "Итог",
                FDAT = null,
                SV = ИтоговыйСписок.LastOrDefault().SV,
                SVQ = ИтоговыйСписок.Sum(x => x.SVQ),
                OD = ИтоговыйСписок.Sum(x => x.OD),
                ODQ = ИтоговыйСписок.FirstOrDefault().ODQ
            });

           // Ср-Календ/totalDays
           var SV31 = ИтоговыйСписок31.Sum(x => x.SV) / totalDays;
           var SVQ31 = ИтоговыйСписок31.Sum(x => x.SVQ) / totalDays;
           var OD31 = ИтоговыйСписок31.Sum(x => x.OD) / totalDays;
           var ODQ31 = ИтоговыйСписок31.Sum(x => x.ODQ) / totalDays; 

            result.Add(new SepHistoryAccDoc
            {
                NN = "Ср-Календ/" + totalDays.ToString(),
                FDAT = null,
                SV = SV31,
                SVQ = SVQ31,
                OD = OD31,
                ODQ = ODQ31
            });

            // Ср-Банк/totalDays по банковским дням
            var ср_Банк = ИтоговыйСписокБД.Count();
            
            var SV_БД = ИтоговыйСписокБД.Sum(x => x.SV) / ср_Банк;
            var SVQ_БД = ИтоговыйСписокБД.Sum(x => x.SVQ) / ср_Банк;
            var OD_БД = ИтоговыйСписокБД.Sum(x => x.OD) / ср_Банк;
            var ODQ_БД = ИтоговыйСписокБД.Sum(x => x.ODQ) / ср_Банк;

            result.Add(new SepHistoryAccDoc
            {
                NN = "Ср-Банк/" + ср_Банк.ToString(),
                FDAT = null,
                SV = SV_БД,
                SVQ = SVQ_БД,
                OD = OD_БД,
                ODQ = ODQ_БД
            });

            result = result.Where(x => x.SV != x.ODQ).ToList();
            return result;
        }

        public ObjectResult<SepHistoryAccChangeParamDoc> GetGridHistoryAccChangeParamList
            (SepTechAccountsFilterParams fp, DataSourceRequest request)
        {
            ObjectResult<SepHistoryAccChangeParamDoc> result = null;
            _entities.Connection.Open();
            var trans = _entities.Connection.BeginTransaction();
            try
            {
                _entities.ExecuteStoreCommand(String.Format(@"
                                                   begin 
                                                   p_acchist(1,30644,
                                                   TO_DATE('{0}','dd/mm/rr'),
                                                   TO_DATE('{1}','dd/mm/rr')); END;",
                                                   fp.dat11.Value.ToString("dd.MM.yyyy"), 
                                                   fp.dat22.Value.ToString("dd.MM.yyyy")));
                var resultQuery = new BarsSql()
                { 
                    SqlParams = new object[] {
                         new OracleParameter("nAcc", OracleDbType.Int32) {Value =  fp.NACC.Value}
                    },
                    SqlText = String.Format(@"
                      SELECT
                      upper(t.tabname) as tabname,
                      t.semantic,
                      TMP_ACCHIST.parname,
                      TMP_ACCHIST.valold,
                      TMP_ACCHIST.valnew,
                      TMP_ACCHIST.dat,
                      TMP_ACCHIST.isp, 
                      s.fio
                      FROM meta_tables t,
                      meta_columns c,
                      TMP_ACCHIST,
                      staff$base s 
                      WHERE TMP_ACCHIST.iduser=user_id AND TMP_ACCHIST.acc=:nAcc 
                      AND TMP_ACCHIST.tabid=t.tabid AND t.tabid=c.tabid  
                      AND TMP_ACCHIST.colid=c.colid AND TMP_ACCHIST.isp=s.logname " +
	                  (fp.TABID > 0 ? " AND t.tabid={0}" : "") +
                      (fp.COLID > 0 ? " AND c.colid={1}" : "") +	                  
	                  " ORDER BY TMP_ACCHIST.idupd desc, TMP_ACCHIST.dat desc, t.tabid",
                      fp.TABID, fp.COLID)
                };
                try
                {
                    result =
                   _entities.ExecuteStoreQuery<SepHistoryAccChangeParamDoc>(resultQuery.SqlText, resultQuery.SqlParams);
                }
                catch (Exception ex)
                {
                    throw new Exception("Ошибка.", ex.InnerException);
                }
            }
            catch (Exception ex)
            {
                trans.Rollback();
                throw (ex);
            }
            finally
            {
                trans.Commit();
            }
            return result;
        }
      
        public ObjectResult<SepFileDoc> GetSepReplyTechDocsData(SepTechAccountsFilterParams fp, DataSourceRequest request)
        {
            InitSepReplyTechDocSql(fp); 
            var sql = _sqlTransformer.TransformSql(_baseSepDocsSql, request);         
            return _entities.ExecuteStoreQuery<SepFileDoc>(sql.SqlText, sql.SqlParams);
        }

        public ObjectResult<SepInternInitModel> GetSepInternInitDocsData(SepTechAccountsFilterParams fp, DataSourceRequest request)
        {
            InitSepInternInitDocSql(fp); 
            var sql = _sqlTransformer.TransformSql(_baseSepDocsSql, request);
            var result = _entities.ExecuteStoreQuery<SepInternInitModel>(sql.SqlText, sql.SqlParams);
            return result;
        }

        public decimal GetSepInternInitDocsCount(SepTechAccountsFilterParams fp, DataSourceRequest request)
        {
            InitSepInternInitDocSql(fp);
            var sql = _sqlTransformer.TransformSql(_baseSepDocsSql, request);
            var result = _entities.ExecuteStoreQuery<SepInternInitModel>(sql.SqlText, sql.SqlParams).Count();
            return result;
        }

        /// <summary>
        /// Сформировать итоги по валютам
        /// </summary>
        /// <param name="fp"></param>
        /// <param name="request"></param>
        /// <returns></returns>
        public List<SepCurrencySum> GetCurrencySummaryList(SepTechAccountsFilterParams fp, DataSourceRequest request)
        {
            InitCurrencySummaryListDocSql(fp);
            var sql = _sqlTransformer.TransformSql(_baseSepDocsSql, request);
            var result =  _entities.ExecuteStoreQuery<SepCurrencySum>(sql.SqlText, sql.SqlParams).ToList();
            result.Add(
                new SepCurrencySum()
                {
                    LCV = "Экв",
                    ISDF = result.Sum(x => x.ISDQ),
                    ISKF = result.Sum(y => y.ISKQ),
                    DOS = result.Sum(x => x.DOSQ),
                    KOS = result.Sum(y => y.KOSQ),
                    OSTCD = result.Sum(x => x.OSTCDQ),
                    OSTCK = result.Sum(x => x.OSTCKQ),
                    RATQ = result.Sum(y => y.RATQ)
                }
                );
            return result;
        }

        public ObjectResult<SepTechAccountsSelectItem> GetHistoryParamSelect(SepTechAccountsFilterParams fp, DataSourceRequest request)
        {
            InitHistoryParamSelectSql(fp);
            
            var sql = _sqlTransformer.TransformSql(_baseSepDocsSql, request);
            var result =  _entities.ExecuteStoreQuery<SepTechAccountsSelectItem>(sql.SqlText, sql.SqlParams);
            return result;
        }

        public ObjectResult<SepTechAccountsSelectItem> GetHistoryParamSelectFromSelect1(SepTechAccountsFilterParams fp, DataSourceRequest request)
        {
            InitHistoryParamSelectSql2(fp);
             
            var sql = _sqlTransformer.TransformSql(_baseSepDocsSql, request);
            var result = _entities.ExecuteStoreQuery<SepTechAccountsSelectItem>(sql.SqlText, sql.SqlParams);
            return result;
        }

       
        private void InitHistoryParamSelectSql(SepTechAccountsFilterParams fp)
        {
            _baseSepDocsSql = new BarsSql()
            {
                SqlParams = new object[] 
                {            
                },
                #region SqlText
                SqlText = @" 
                SELECT DISTINCT
                TABID,
                SEMANTIC
                FROM META_TABLES
                WHERE tabid in 
                (SELECT tabid FROM acc_par WHERE pr=1)
                ORDER BY semantic"
                #endregion
            };
        }

        private void InitHistoryParamSelectSql2(SepTechAccountsFilterParams fp)
        {
            _baseSepDocsSql = new BarsSql()
            {
                SqlParams = new object[] 
                {       
                    new OracleParameter("nTABID", OracleDbType.Int32) {Value =  fp.TABID}   
                },
                #region SqlText
                SqlText = @" 
                SELECT 
                colid, 
                semantic
                FROM meta_columns 
                WHERE tabid=:nTABID AND colid in (select colid from acc_par where tabid=:nTABID) 
                ORDER BY semantic"
                #endregion
            };
        }
            
        /// <summary>
        /// Инициализация запроса для "Показывать связанные счета"
        /// </summary>
        /// <param name="p"></param>
        private void InitLinkedAcc(SepTechAccountsFilterParams p)
        {
            _baseSepDocsSql = new BarsSql()
            {
                SqlParams = new object[] 
                { 
                    new OracleParameter("nAcc", OracleDbType.Int32) {Value =  p.NACC.Value}              
                },
                #region SqlText
                SqlText = @" 
                SELECT
                a.acc,
                a.nls,
                a.nbs,
                a.kv,
                t.lcv,
                a.nms,
                a.nlsalt, 
                a.pap,
                a.tip,
                a.isp,
                f.fio,
                a.daos,
                a.dazs,
                a.rnk,
                t.dig,
                a.blkd,
                a.blkk,
                a.tobo, 
                (a.ostc
                +decode(greatest(a.dapp,nvl(a.dapp,a.dappq)),bankdate,a.dos,0)
                -decode(greatest(a.dapp,nvl(a.dapp,a.dappq)),bankdate,a.kos,0))/power(10,t.dig) as ISf, 
                decode(greatest(a.dapp,nvl(a.dapp,a.dappq)),bankdate,a.dos,0)/power(10,t.dig) as DOSf, 
                decode(greatest(a.dapp,nvl(a.dapp,a.dappq)),bankdate,a.kos,0)/power(10,t.dig) as KOSf, 
                a.ostc/power(10,t.dig) as OSTCf, 
                a.ostb/power(10,t.dig) as OSTBf, 
                (a.ostc+a.ostf)/power(10,t.dig) as OSTFf, 
                a.dapp,
                a.ob22,
                1  as AccCount
                FROM Accounts a, Tabval t, Staff f 
                WHERE t.kv=a.kv AND a.isp=f.id (+)   
                AND a.accc = :nACC   
                AND a.dazs IS NULL  
                ORDER BY a.nls "
                #endregion
            };
        }
      
        private void InitHistoryAccSql(SepTechAccountsFilterParams p)
        { 
            _baseSepDocsSql = new BarsSql()
            {
                SqlParams = new object[] 
                { 
                    new OracleParameter(":nAcc", OracleDbType.Int32) { Value =  p.NACC.Value }                  
                },
                //    --INTO :KDAT, :BDAT, :SV, :OD, :OK, :SI
                 SqlText =
                 String.Format(@" 
                 SELECT  
                 s.acc,   
                 K.FDAT as FDAT,                 
                 decode(s.fdat,K.fdat,s.ostf,s.ostf-s.dos+s.kos)/100 as SV,
                 decode(s.fdat,K.fdat,s.dos,0)/100 as SVQ,
                 decode(s.fdat,K.fdat,s.kos,0)/100 as OD,
                 (s.ostf-s.dos+s.kos)/100 as ODQ 
                 FROM 
                 saldoa s, 
                 fdat B,
                 (select TO_DATE('{0}','dd/mm/rr') + (num - 1) FDAT
                  from conductor 
                  where  num <= (TO_DATE('{2}','dd/mm/rr')) - (TO_DATE('{1}','dd/mm/rr')) + 1) K
                  WHERE s.acc=:nAcc AND K.fdat=B.fdat(+) AND (s.acc,s.fdat) = 
                  (SELECT c.acc,max(c.fdat)  FROM saldoa c
                   WHERE s.acc=c.acc AND c.fdat<=K.fdat
                   GROUP BY c.acc)
                   ORDER BY FDAT DESC", 
                   p.dat11.Value.ToString("dd.MM.yyyy"), 
                   p.dat11.Value.ToString("dd.MM.yyyy"), 
                   p.dat22.Value.ToString("dd.MM.yyyy"))                
            };
        }

        private void InitHistoryAccKKCountSql(SepTechAccountsFilterParams p)
        {
            _baseSepDocsSql = new BarsSql()
            {
                SqlParams = new object[] 
                { 
                    new OracleParameter(":nAcc", OracleDbType.Int32) { Value =  p.NACC.Value }                  
                },
                //    --INTO :KDAT, :BDAT, :SV, :OD, :OK, :SI
                SqlText =
                String.Format(@" 
                   SELECT              
                   B.FDAT as BFDAT,
                   K.FDAT as KFDAT,              
                 decode(s.fdat,K.fdat,s.ostf,s.ostf-s.dos+s.kos)/100 as SV,
                 decode(s.fdat,K.fdat,s.dos,0)/100 as SVQ,
                 decode(s.fdat,K.fdat,s.kos,0)/100 as OD,
                 (s.ostf-s.dos+s.kos)/100 as ODQ 
                 FROM 
                 saldoa s, 
                 fdat B,
                 (select TO_DATE('{0}','dd/mm/rr') + (num - 1) FDAT
                  from conductor 
                  where  num <= (TO_DATE('{2}','dd/mm/rr')) - (TO_DATE('{1}','dd/mm/rr')) + 1) K
                  WHERE s.acc=:nAcc AND K.fdat=B.fdat(+) AND (s.acc,s.fdat) = 
                  (SELECT c.acc,max(c.fdat)  FROM saldoa c
                   WHERE s.acc=c.acc AND c.fdat<=K.fdat
                   GROUP BY c.acc)
                   ORDER BY 2 DESC",
                  p.dat11.Value.ToString("dd.MM.yyyy"),
                  p.dat11.Value.ToString("dd.MM.yyyy"),
                  p.dat22.Value.ToString("dd.MM.yyyy"))
            };
        }
         


         
        private void InitSepTechCashFlowPeriodSql(SepTechAccountsFilterParams p)
        {
            _baseSepDocsSql = new BarsSql()
            {
                SqlParams = new object[] {},
                SqlText = String.Format(@"               
                    SELECT
                    a.acc, 
                    a.nls, 
                    a.nbs, 
                    a.kv, 
                    t.lcv, 
                    a.nms, 
                    a.nlsalt, 
                    a.pap, 
                    a.tip, 
                    a.isp, 
                    f.fio, 
                    a.daos, 
                    a.dazs, 
                    a.rnk, 
                    t.dig, 
                    a.blkd, 
                    a.blkk, 
                    a.tobo, 
                    (fost_h(a.acc, TO_DATE('{0}','dd/mm/rr'))+fdos(a.acc,TO_DATE('{0}','dd/mm/rr'),TO_DATE('{0}','dd/mm/rr'))-fkos(a.acc,TO_DATE('{0}','dd/mm/rr'),TO_DATE('{0}','dd/mm/rr')))/power(10,t.dig) ISF, 
                    fdos(a.acc, TO_DATE('{0}','dd/mm/rr'),TO_DATE('{1}','dd/mm/rr'))/power(10,t.dig) DOSF, 
                    fkos(a.acc, TO_DATE('{0}','dd/mm/rr'),TO_DATE('{1}','dd/mm/rr'))/power(10,t.dig) KOSF,
                    fost_h(a.acc, TO_DATE('{1}','dd/mm/rr'))/power(10,t.dig) OSTCF, 
                    a.ostb/power(10,t.dig) OSTBF, 
                    (a.ostc+a.ostf)/power(10,t.dig) OSTFF, 
                    a.dapp, 
                    a.ob22, 
                    1 as AccCount
                    FROM Accounts a, Tabval t, Staff f WHERE t.kv=a.kv AND a.isp=f.id (+)
                    AND a.tip in ('N99','L99','N00','T00','T0D','TNB','TND','TUR','TUD','L00','N77','902','90D')  
                    AND a.acc IN ( SELECT acc FROM Bank_acc  
                    WHERE mfo in (select mfo from lkl_rrp) )  
                    AND a.dazs IS NULL",
                    p.DateCashFlowPeriod1.Value.ToString("dd.MM.yyyy"), p.DateCashFlowPeriod2.Value.ToString("dd.MM.yyyy"))                    
            };
        }

        /// <summary>
        /// Технологические счета
        /// </summary>
        /// <remarks>Вариант запроса для "Технологические счета - 
        /// Документы по счету ответный СЕП".
        /// Инициализация строки запроса</remarks>
        /// <param name="sepDocParams">параметры формирования запроса</param>
        private void InitSepReplyTechDocSql(SepTechAccountsFilterParams fp)
        {
            _baseSepDocsSql = new BarsSql()
            {
                SqlParams = new object[] { },
                SqlText = 
                String.Format( 
                @"
                SELECT a.mfoa, a.mfob, a.nlsa, a.nlsb, a.s, a.kv, v.lcv, v.dig, a.dk, a.vob, a.datp, 
                a.rec, a.fn_a, a.dat_a, a.rec_a, a.fn_b, a.dat_b, a.rec_b, a.ref, a.sos,
                substr(a.nd,1,10) nd, substr(a.nazn,1,160) nazn, 
                substr(decode(mod(a.dk,2),0,a.nam_b,a.nam_a),1,38) NamA, b1.nb NbA, 
                substr(decode(mod(a.dk,2),0,a.nam_a,a.nam_b),1,38) NamB, b2.nb NBb
                FROM ARC_RRP a, tabval$global v, banks$base b1, banks$base b2
                WHERE
                a.kv=v.kv ( + )
                and  ( a.ref in ( SELECT ref FROM opldok WHERE tt in  ( 'R01','D01' )  
                and acc={0}
                AND  fdat= TO_DATE ('{1}', 'MM/dd/yyyy')) 
                AND  a.bis<=1  AND decode ( mod ( a.dk,2 ) ,0,a.mfob,a.mfoa ) =b1.mfo
                AND decode ( mod ( a.dk,2 ) ,0,a.mfoa,a.mfob ) =b2.mfo   )                 
                ORDER BY a.rec DESC", fp.NACC, fp.bankdate )
            };
        }

        /// <summary>
        /// Документы по счету ВНУТРЕННИЕ И НАЧАЛЬНЫЙ МЕЖБАНК
        /// </summary>       
        /// <param name="sepDocParams">параметры формирования запроса</param>
        private void InitSepInternInitDocSql(SepTechAccountsFilterParams fp)
        {
            _baseSepDocsSql = new BarsSql()
            {
                SqlParams = new object[] { },
                SqlText =
                String.Format(@"
                SELECT 
                a.mfoa,
                a.mfob,
                a.nlsa,
                a.nlsb,
                a.s,    
                a.kv,
                v.lcv,
                v.dig,  
                a.s2,
                a.kv2,
                v2.lcv lcv2, 
                v2.dig dig2,  a.sk,   
                 a.dk,   a.vob, 
                  a.datd, a.vdat,  
                  a.tt, a.ref id, 
                  a.ref, a.sos, 
                  a.userid, a.nd, 
                    a.nazn, 
                     a.id_a, a.nam_a,
                      a.id_b, a.nam_b , 
                      a.tobo        
                     FROM OPER a, tabval$global v, tabval$global v2 
                     WHERE a.kv=v.kv ( + )  and a.kv2=v2.kv ( + )  and  
                     ( a.ref in ( SELECT ref FROM opldok WHERE tt not in  ( 'R01','D01' )  and    
                        acc={0} AND      
                         fdat= TO_DATE ('{1}', 'MM/dd/yyyy')))          
                      ORDER BY 19 DESC
                    ", fp.NACC, fp.bankdate)
            };
        }

        private void InitCurrencySummaryListDocSql(SepTechAccountsFilterParams fp)
        {
            _baseSepDocsSql = new BarsSql()
            {
                SqlParams = new object[] { },
                SqlText =
                @"
                 SELECT
                   t.kv, t.lcv, t.dig, 
                   decode(t.kv, t.dig, 0, 1) as tkv, 
                   nvl(c.isdf,0)/power(10,t.dig) isdf, 
                   nvl(c.iskf,0)/power(10,t.dig) iskf, 
                   nvl(c.dos,0)/power(10,t.dig) dos, 
                   nvl(c.kos,0)/power(10,t.dig) kos, 
                   c.ostcd/power(10,t.dig) ostcd, 
                   c.ostck/power(10,t.dig) ostck, 
                   c.rat/power(10,t.dig) rat, 
                   nvl(c.isdq,0)/100 isdq, 
                   nvl(c.iskq,0)/100 iskq, 
                   nvl(c.dosq,0)/100 dosq, 
                   nvl(c.kosq,0)/100 kosq, 
                   c.ostcdq/100 ostcdq, 
                   c.ostckq/100 ostckq, 
                   c.ratq/100 ratq
              FROM tabval t, 
                   ( SELECT a.kv,
                sum(decode(sign(decode(s.fdat, bankdate, s.ostf, s.ostf - s.dos + s.kos)), 1,0,decode(s.fdat, bankdate, s.ostf, s.ostf - s.dos + s.kos))) isdf,
                sum(decode(sign(decode(s.fdat, bankdate, s.ostf, s.ostf - s.dos + s.kos)),-1,0,decode(s.fdat, bankdate, s.ostf, s.ostf - s.dos + s.kos))) iskf,
                sum(decode(sign(decode(s.fdat, bankdate, s.ostf, s.ostf - s.dos + s.kos)), 1,0,decode(s.fdat, bankdate, 
                  gl.p_icurval(a.kv, s.ostf, bankdate), 
                  gl.p_icurval(a.kv, (s.ostf - s.dos + s.kos), bankdate)))) isdq,
                sum(decode(sign(decode(s.fdat, bankdate, s.ostf, s.ostf - s.dos + s.kos)),-1,0,decode(s.fdat, bankdate, 
                  gl.p_icurval(a.kv, s.ostf, bankdate), 
                  gl.p_icurval(a.kv, (s.ostf - s.dos + s.kos), bankdate)))) iskq,
                sum(decode(s.fdat, bankdate, s.dos, 0)) dos, 
                sum(decode(s.fdat, bankdate, s.kos, 0)) kos,
                sum(decode(s.fdat, bankdate, gl.p_icurval(a.kv, s.dos,s.fdat), 0)) dosq, 
                sum(decode(s.fdat, bankdate, gl.p_icurval(a.kv, s.kos,s.fdat), 0)) kosq,
                sum(decode(sign(s.ostf - s.dos + s.kos), 1,0,s.ostf - s.dos + s.kos)) ostcd,
                sum(decode(sign(s.ostf - s.dos + s.kos),-1,0,s.ostf - s.dos + s.kos)) ostck,
                sum((s.ostf - s.dos + s.kos)*acrn.fprocn(a.acc,null,s.fdat)) rat,
                sum(decode(sign(s.ostf - s.dos + s.kos), 1,0,
                  gl.p_icurval(a.kv, s.ostf - s.dos + s.kos, bankdate))) ostcdq,
                sum(decode(sign(s.ostf - s.dos + s.kos),-1,0,
                  gl.p_icurval(a.kv, s.ostf - s.dos + s.kos,bankdate))) ostckq,
                sum((gl.p_icurval(a.kv, s.ostf - s.dos + s.kos,s.fdat))*acrn.fprocn(a.acc,null,s.fdat)) ratq
              FROM saldoa s, accounts a
             WHERE s.acc = a.acc
               AND (a.acc,s.fdat) = (SELECT acc, max(fdat) 
                                       FROM saldoa 
                                      WHERE acc=a.acc AND fdat<=bankdate 
                                      GROUP BY acc )
               AND a.tip IN ('N99', 'L99', 'N00', 'T00', 'T0D', 'TNB', 'TND', 'TUR', 'TUD', 'L00', 'N77', '902', '90D')
               AND a.acc IN (SELECT acc
                               FROM Bank_acc
                              WHERE mfo IN (SELECT mfo FROM lkl_rrp))
               AND a.dazs IS NULL
             GROUP BY a.kv ) c
            WHERE t.kv = c.kv
            ORDER BY 2, 1"
            };
        }
    }
}