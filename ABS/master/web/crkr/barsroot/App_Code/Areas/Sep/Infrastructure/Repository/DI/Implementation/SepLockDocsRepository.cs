using Areas.Sep.Models;
using Bars.Classes;
using Bars.Doc;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using BarsWeb.Core.Logger;
using Ninject;

/// <summary>
/// Summary description for SepLockDocsRepository
/// </summary>
public class SepLockDocsRepository : ISepLockDocsRepository
{

    private readonly SepFiles _entities;
    private readonly IKendoSqlTransformer _sqlTransformer;
    private readonly IKendoSqlCounter _kendoSqlCounter;
    private IParamsRepository _kernelParams;
    private readonly IBankDatesRepository _datesRepository;
    private readonly IHomeRepository _homeRepository;
    [Inject]
    public IDbLogger Logger { get; set; }
    public SepLockDocsRepository(IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter,
        IBankDatesRepository datesRepository, IHomeRepository homeRepository, IParamsRepository kernelParams)
	{
        var connectionStr = EntitiesConnection.ConnectionString("SepFiles", "Sep");
        _entities = new SepFiles(connectionStr);
        _sqlTransformer = kendoSqlTransformer;
        _kendoSqlCounter = kendoSqlCounter;
        _datesRepository = datesRepository;
        _homeRepository = homeRepository;
        _kernelParams = kernelParams;
	}

    //DefCode Без контролю ВПС
    //byCount построение запроса с учетом кода блокировки
    private BarsSql InitSepLockDocSql(int DefCode, int byCode, DataSourceRequest request)
    {
        string query = "SELECT arc_rrp.mfoa, arc_rrp.mfob, arc_rrp.nlsa, arc_rrp.nlsb, arc_rrp.nam_a, arc_rrp.nam_b, arc_rrp.s, " +
        "    arc_rrp.kv, arc_rrp.dk, arc_rrp.nazn, arc_rrp.rec, arc_rrp.blk, 1 n, arc_rrp.ref, arc_rrp.fn_a, arc_rrp.datd, " +
        "    arc_rrp.rec_a, arc_rrp.bis, arc_rrp.vob, arc_rrp.nd, arc_rrp.ref_a, arc_rrp.id_a, arc_rrp.id_b, NVL(arc_rrp.prty,0) prty, " +
        "    rec_que.otm " +
        "FROM   rec_que, arc_rrp WHERE ";

        if (DefCode == 1)
        {
            query += "arc_rrp.blk not between 9701 and 9704 and ";
        }

        if (byCode != 0)
            query += string.Format("blk = {0} and ", byCode.ToString());



        query += "arc_rrp.s>0 and arc_rrp.blk>0 and arc_rrp.fn_b is null and arc_rrp.rec = rec_que.rec order by arc_rrp.blk";

        BarsSql sqlQuery = new BarsSql()
        {
            SqlParams = new object[0],
            SqlText = query
        };

        return sqlQuery;
    }

    public decimal GetSepLockDocCount(int DefCode, int Code, DataSourceRequest request)
    {
        BarsSql sqlQuery = InitSepLockDocSql(DefCode, Code, request);
        var sql = _kendoSqlCounter.TransformSql(sqlQuery, request);
        var total = _entities.ExecuteStoreQuery<decimal>(sql.SqlText, sql.SqlParams).Single();
        return total;
    }

    public IQueryable<SepLockDoc> GetSepLockDoc(int DefCode, int Code, DataSourceRequest request)
    {
        BarsSql sqlQuery = InitSepLockDocSql(DefCode, Code, request);

        var sql = _sqlTransformer.TransformSql(sqlQuery, request);
        ObjectResult<SepLockDoc> tmp = _entities.ExecuteStoreQuery<SepLockDoc>(sql.SqlText, sql.SqlParams);
        var result = tmp.ToList();

        return (from docs in result
                select new SepLockDoc()
                {
                    Ref = docs.Ref,
                    blk = docs.blk,
                    mfoa = docs.mfoa,
                    nlsa = docs.nlsa,
                    nam_a = docs.nam_a,
                    kv = docs.kv,
                    dk = docs.dk,
                    s = docs.s,
                    mfob = docs.mfob,
                    nlsb = docs.nlsb,
                    nam_b = docs.nam_b,
                    nazn = docs.nazn,
                    rec = docs.rec,
                    prty = docs.prty,

                    bis = docs.bis,

                    vob = docs.vob,
                    nd = docs.nd,
                    datd = docs.datd,

                    id_a = docs.id_a,
                    id_b = docs.id_b

                }).AsQueryable();
    }

    public decimal GetSepLockDocResource(DataSourceRequest request)
    {
        string query = "SELECT sum(decode(tip,'TNB',-ostc-lim,-ostc)) FROM v_accounts_proc " +
        "    WHERE kv=980 and p_tip in ('N00', " +
        "        NVL2((SELECT VAL from PARAMS where PAR = 'CLRTRN'),'','TNB'), " +
        "        NVL2((SELECT VAL from PARAMS where PAR = 'NUMMODEL'),'','L00'), " +
        "        NVL2((SELECT VAL from PARAMS where PAR = 'NUMMODEL'),'','TUR'))";

        BarsSql sqlQuery = new BarsSql()
        {
            SqlParams = new object[0],
            SqlText = query
        };

        var sql = _sqlTransformer.TransformSql(sqlQuery, request);
        return _entities.ExecuteStoreQuery<decimal>(sql.SqlText, sql.SqlParams).Single();
    }

    public bool DeleteSepLockDocs(List<SepLockDoc> Docs, DataSourceRequest request)
    {
         bool isOk = false;
         foreach (var Doc in Docs)
         {
             _entities.Connection.Open();
             var trans = _entities.Connection.BeginTransaction();

             try
             {
                if (Doc.dk == 2 || Doc.dk == 3)
                {
                    var lockQuery = new BarsSql() 
                    {
                        SqlParams = new object[] {
                            new OracleParameter("Rec", OracleDbType.Decimal).Value = Doc.rec,
                            new OracleParameter("Blk", OracleDbType.Int16).Value = Doc.blk
                        },
                        SqlText = "SELECT rec FROM arc_rrp WHERE rec=:Rec and blk=:Blk FOR UPDATE OF blk NOWAIT"
                    };

                    try
                    {
                        _entities.ExecuteStoreQuery<decimal>(lockQuery.SqlText, lockQuery.SqlParams);
                    }
                    catch (Exception ex)
                    {
                        throw new Exception("Неможливо отримати доступ до REC.", ex.InnerException);
                    }

                    if(Doc.bis > 0) {
                        var updateQuery = new BarsSql() {
                            SqlParams = new object[] {
                            new OracleParameter("Rec", OracleDbType.Decimal).Value = Doc.rec
                        },
                            SqlText = "UPDATE arc_rrp SET blk=-1 WHERE fn_b IS NULL AND bis > 0 AND rec IN " +
                            "(SELECT rec FROM rec_que WHERE rec_g=:Rec and rec_g IS NOT NULL)"
                        };

                        try {
                            _entities.ExecuteStoreCommand(updateQuery.SqlText, updateQuery.SqlParams);
                        }
                        catch (Exception ex) {
                            throw new Exception("Невозможно отметить в arc_rrp (BIS).", ex.InnerException);
                        }
                        //-----
                        var delRecQuery = new BarsSql() {
                            SqlParams = new object[] {
                            new OracleParameter("Rec", OracleDbType.Decimal).Value = Doc.rec
                        },
                            SqlText = "DELETE FROM rec_que WHERE rec_g=:Rec and rec_g IS NOT NULL"
                        };

                        try {
                            _entities.ExecuteStoreCommand(delRecQuery.SqlText, delRecQuery.SqlParams);
                        }
                        catch (Exception ex) {
                            throw new Exception("Невозможно удалить из rec_que (BIS).", ex.InnerException);
                        }
                        //-----
                        var delTzaprosQuery = new BarsSql() {
                            SqlParams = new object[] {
                            new OracleParameter("Rec", OracleDbType.Decimal).Value = Doc.rec
                        },
                            SqlText = "DELETE FROM tzapros WHERE rec_g=:Rec and rec_g IS NOT NULL"
                        };

                        try {
                            _entities.ExecuteStoreCommand(delTzaprosQuery.SqlText, delTzaprosQuery.SqlParams);
                        }
                        catch (Exception ex) {
                            throw new Exception("Невозможно удалить из tzapros (BIS)", ex.InnerException);
                        }
                    } else {

                        var updateQuery = new BarsSql()
                        {
                            SqlParams = new object[] {
                            new OracleParameter("Rec", OracleDbType.Decimal).Value = Doc.rec
                        },
                            SqlText = "UPDATE arc_rrp SET blk=-1 WHERE rec=:Rec and fn_b IS NULL"
                        };

                        try
                        {
                            _entities.ExecuteStoreCommand(updateQuery.SqlText, updateQuery.SqlParams);
                        }
                        catch (Exception ex)
                        {
                            throw new Exception("Невозможно отметить в arc_rrp", ex.InnerException);
                        }
                        //-----
                        var delRecQuery = new BarsSql()
                        {
                            SqlParams = new object[] {
                            new OracleParameter("Rec", OracleDbType.Decimal).Value = Doc.rec
                        },
                            SqlText = "DELETE FROM rec_que WHERE rec=:Rec"
                        };

                        try
                        {
                            _entities.ExecuteStoreCommand(delRecQuery.SqlText, delRecQuery.SqlParams);
                        }
                        catch (Exception ex)
                        {
                            throw new Exception("Невозможно удалить из rec_que", ex.InnerException);
                        }
                        //-----
                        var delTzaprosQuery = new BarsSql()
                        {
                            SqlParams = new object[] {
                            new OracleParameter("Rec", OracleDbType.Decimal).Value = Doc.rec
                        },
                            SqlText = "DELETE FROM tzapros WHERE rec=:Rec"
                        };

                        try
                        {
                            _entities.ExecuteStoreCommand(delTzaprosQuery.SqlText, delTzaprosQuery.SqlParams);
                        }
                        catch (Exception ex)
                        {
                            throw new Exception("Невозможно удалить из tzapros", ex.InnerException);
                        }
                    }

                    Logger.Financial(string.Format("Док #{0}({1}) Вилучено. (BLK={2})",
                        Doc.Ref.ToString(),
                        Doc.rec.ToString(),
                        Doc.blk.ToString()));

                    try
                    {
                        _entities.SaveChanges();
                    }
                    catch (Exception ex)
                    {
                        throw new Exception("Помилка при виклику SaveChanges!", ex.InnerException);
                    }

                    //put internal digital sign
                    isOk = true;

                }
             }
             catch (Exception ex)
             {
                 trans.Rollback();
                 throw (ex);
             }
             finally
             {
                 if (isOk)
                     trans.Commit();
             }
         }
         return isOk;
    }

    public bool DeleteSepLockDocsByCode(int DefCode, int Code, DataSourceRequest request)
    {
        return DeleteSepLockDocs(GetSepLockDoc(DefCode, Code, request).ToList(), request);
    }    
    //Вернуть документы СЭП
    public bool ReturnSepLockDocs(string Reason, List<SepLockDoc> Docs, DataSourceRequest request)
    {
        bool isOk = false;
        foreach (var Doc in Docs)
        {
            _entities.Connection.Open();
            var trans = _entities.Connection.BeginTransaction();
            
            try
            {
                var lockQuery = new BarsSql()
                {
                    SqlParams = new object[]{
                    new OracleParameter("Rec", OracleDbType.Decimal).Value = Doc.rec,
                    new OracleParameter("Blk", OracleDbType.Int16).Value = Doc.blk
                },
                    SqlText = "SELECT rec FROM arc_rrp WHERE rec=:Rec and blk=:Blk FOR UPDATE OF blk NOWAIT"
                };
                try
                {
                    _entities.ExecuteStoreQuery<decimal>(lockQuery.SqlText, lockQuery.SqlParams);
                }
                catch (Exception ex)
                {
                    throw new Exception("Неможливо отримати доступ до REC.", ex.InnerException);
                }

                var operwQuery = new BarsSql()
                {
                    SqlParams = new object[]{
                    new OracleParameter("Ref", OracleDbType.Decimal).Value = Doc.Ref,
                    new OracleParameter("Reason", OracleDbType.Varchar2).Value = "Повернено." + Reason
                },
                    SqlText = "INSERT INTO operw (ref, tag, value) VALUES (:Ref, 'BACKR', :Reason)"
                };

                try
                {
                    _entities.ExecuteStoreCommand(operwQuery.SqlText, operwQuery.SqlParams);
                }
                catch (Exception ex)
                {
                    throw new Exception("Неможливо зберегти запис у таблиці OPERW!", ex.InnerException);
                }

                try 
                {
                    _entities.GL_PAY_BCK(Doc.Ref, 5); 
                }
                catch (Exception ex)
                {
                    throw new Exception( "Помилка при виклику pay_bck!", ex.InnerException);
                }

                // UPDATE arc_rrp SET    blk=-1  WHERE  rec=:tbl.ID and fn_b IS NULL
                var arc = (from arc_rrp in _entities.ARC_RRP
                           where arc_rrp.REC == Doc.rec && arc_rrp.FN_B == null
                           select arc_rrp).First();
                arc.BLK = -1;

                //DELETE FROM rec_que WHERE rec=:tbl.ID
                var val = (from rec_que in _entities.REC_QUE
                           where rec_que.REC == Doc.rec
                           select rec_que).First();
                _entities.DeleteObject(val);

                Logger.Financial(string.Format("Док #{0}({1}) ВОЗВРАЩЕН. (BLK={2})", 
                    Doc.Ref.ToString(),
                    Doc.rec.ToString(), 
                    Doc.blk.ToString()));

                try
                {
                    _entities.SaveChanges();
                }
                catch (Exception ex)
                {
                    throw new Exception("Помилка при виклику SaveChanges!", ex.InnerException);
                }

                //put internal digital sign
                isOk = true;
            }
            catch (Exception ex)
            {
                trans.Rollback();
                throw (ex);
            }
            finally
            {
                if (isOk)
                    trans.Commit();
            }
        }
        return isOk;
    }
    public bool ReturnSepLockDocsByCode(string Reason, int DefCode, int Code, DataSourceRequest request)
    {
        return ReturnSepLockDocs(Reason, GetSepLockDoc(DefCode, Code, request).ToList(), request);
    } 
    
    public bool UnlockSepLockDocs(List<SepLockDoc> Docs, DataSourceRequest request)
    {
        bool isOk = false;
        _entities.Connection.Open();

        foreach (var Doc in Docs)
        {
            
            var trans = _entities.Connection.BeginTransaction();

            try
            {
                //put internal digital sign

                var lockQuery = new BarsSql()
                {
                    SqlParams = new object[]{
                    new OracleParameter("Rec", OracleDbType.Decimal).Value = Doc.rec,
                    new OracleParameter("Blk", OracleDbType.Int16).Value = Doc.blk
                },
                    SqlText = "SELECT rec FROM arc_rrp WHERE rec=:Rec and blk=:Blk FOR UPDATE OF blk NOWAIT"
                };

                try
                {
                    _entities.ExecuteStoreQuery<decimal>(lockQuery.SqlText, lockQuery.SqlParams);
                }
                catch (Exception ex)
                {
                    throw new Exception("Неможливо отримати доступ до REC.", ex.InnerException);
                }

                //UPDATE arc_rrp SET blk=0 WHERE fn_b IS NULL AND  rec=:tbl.ID
                var arc = (from arc_rrp in _entities.ARC_RRP
                           where arc_rrp.REC == Doc.rec && arc_rrp.FN_B == null
                           select arc_rrp).First();
                arc.BLK = 0;


                Logger.Financial(string.Format("Док # ( {0} ) - РАЗБЛОКИРОВАН", Doc.rec.ToString()));
                try
                {
                    _entities.SaveChanges();
                }
                catch (Exception ex)
                {
                    throw new Exception("Помилка при виклику SaveChanges!", ex.InnerException);
                }

                isOk = true;
            }
            catch(Exception ex)
            {
                trans.Rollback();
                throw (ex);
            }
            finally
            {
                if (isOk)
                    trans.Commit();
            }
        }
        _entities.Connection.Close();
        return isOk;
    }

    public bool UnLockSepLockDocsByCode(int DefCode, int Code, DataSourceRequest request)
    {
        return UnlockSepLockDocs(GetSepLockDoc(DefCode, Code, request).ToList(), request);
    }

    public bool UnlockSepDocsTo902(List<SepLockDoc> Docs, DataSourceRequest request)
    {
        bool isOk = false;
        foreach (var Doc in Docs)
        {
            _entities.Connection.Open();
            var trans = _entities.Connection.BeginTransaction();

            try
            {
                var lockQuery = new BarsSql()
                {
                    SqlParams = new object[]{
                    new OracleParameter("Rec", OracleDbType.Decimal).Value = Doc.rec,
                    new OracleParameter("Blk", OracleDbType.Int16).Value = Doc.blk
                },
                    SqlText = "SELECT rec FROM arc_rrp WHERE rec=:Rec and blk=:Blk FOR UPDATE OF blk NOWAIT"
                };

                try
                {
                    _entities.ExecuteStoreCommand(lockQuery.SqlText, lockQuery.SqlParams);
                }
                catch (Exception ex)
                {
                    throw new Exception("Неможливо отримати доступ до REC.", ex.InnerException);
                }

                ObjectParameter strNlsT00 = new ObjectParameter("strNlsT00", typeof(string));
                ObjectParameter strNls902 = new ObjectParameter("strNls902", typeof(string));
                ObjectParameter strTTadd = new ObjectParameter("strTTadd", typeof(string));
                string kf = _entities.ExecuteStoreQuery<string>("select sys_context('bars_context','user_mfo') from dual").FirstOrDefault();
                _entities.SEP_UTL_GETT00_902(Doc.mfoa, Doc.dk, Doc.kv, Doc.blk, strNlsT00, strNls902, strTTadd);



                var dDat = _datesRepository.GetBankDate();
                var operId = _homeRepository.GetUserParam().IDOPER;
                string nlsT = strNlsT00.Value.ToString();
                string nls902 = strNls902.Value.ToString();
                long ref_ = 0;
                //if (Doc.Ref.HasValue)
                //{
                //    ref_ = (long)Doc.Ref;
                //}

                var clrtrn = _kernelParams.GetParam("CLRTRN");
                short nSos = 0;
                if(clrtrn != null && Doc.kv == 980) {
                    nSos = 8;
                } else {
                    nSos = 5;
                }
                
                cDoc creatorDoc = new cDoc(OraConnector.Handler.IOraConnection.GetUserConnection(),
                    ref_, 
                    "R01", 
                    Doc.dk, 
                    Doc.vob, 
                    Doc.nd, 
                    Doc.datd, 
                    dDat, 
                    dDat, 
                    dDat, 
                    nlsT,
                    Doc.nam_a, 
                    Doc.mfoa, 
                    string.Empty, 
                    Doc.kv, 
                    Doc.s, 
                    Doc.id_a, 
                    nls902, 
                    Doc.nam_b, 
                    Doc.mfob, 
                    "",
                    Doc.kv, 
                    Doc.s, 
                    Doc.id_b, 
                    Doc.nazn, 
                    string.Empty, 
                    operId,
                    new byte[0],  
                    0, 
                    0, 
                    0, 
                    string.Empty, 
                    string.Empty, 
                    string.Empty, 
                    string.Empty);

                if (creatorDoc.oDoc()) 
                {

                    var cRef = creatorDoc.Ref;

                    //UPDATE arc_rrp SET ref=:cDoc.m_nRef, dat_b=:dDat, sos=:nSos, blk=0 WHERE rec=:tbl.ID and fn_b IS NULL
                    var arc = (from arc_rrp in _entities.ARC_RRP
                               where arc_rrp.REC == Doc.rec && arc_rrp.FN_B == null
                               select arc_rrp).First();
                    arc.BLK = 0;
                    arc.REF = cRef;
                    arc.DAT_B = dDat;
                    arc.SOS = nSos;

                    //DELETE FROM rec_que WHERE rec=:tbl.ID
                    var rec_q = (from rec_que in _entities.REC_QUE
                               where rec_que.REC == Doc.rec
                               select rec_que).First();
                    _entities.DeleteObject(rec_q);

                    

                    //INSERT INTO t902 (ref,rec) VALUES (:cDoc.m_nRef,:tbl.ID)
                    var t902 = new T902 { 
                        REF = (decimal)cRef,
                        REC = Doc.rec,
                        BLK = Doc.blk,
                        KF = kf
                    };
                    _entities.T902.AddObject(t902);

                    //SELECT nlsa,nlsb,d_rec,id_o,sign FROM arc_rrp WHERE rec=:tbl.ID
                    var arc_r = (from arc_rrp in _entities.ARC_RRP where arc_rrp.REC == Doc.rec select arc_rrp).First();
                    //UPDATE oper SET (nlsa,nlsb,d_rec,id_o,sign)= WHERE ref=:cDoc.m_nRef' 
                    var op = (from oper in _entities.OPER where oper.REF == cRef select oper).First();
                    op.NLSA = arc_r.NLSA;
                    op.NLSB = arc_r.NLSB;
                    op.D_REC = arc_r.D_REC;
                    op.ID_O = arc_r.ID_O;
                    op.SIGN = arc_r.SIGN;

                    //Call SaveFInfoToLog('Док #' || Str(cDoc.m_nRef) || '(' || strRec || ') - до ВЫЯСНЕНИЯ')
                    Logger.Financial(string.Format("Док #{0}({1}) - до ВЫЯСНЕНИЯ", cRef.ToString(), Doc.rec.ToString()));

                    try
                    {
                        _entities.SaveChanges();
                    }
                    catch (Exception ex)
                    {
                        throw new Exception("Помилка при виклику SaveChanges!", ex.InnerException);
                    }

                } else {
                    throw new Exception("Помилка cDoc!");
                }

                isOk = true;
            }
            catch (Exception ex)
            {
                trans.Rollback();
                throw (ex);
            }
            finally
            {
                if (isOk)
                    trans.Commit();
            }
        }

        return isOk;
    }

    public bool UnlockSepDocsTo902ByCode(int DefCode, int Code, DataSourceRequest request)
    {
        return UnlockSepDocsTo902(GetSepLockDoc(DefCode, Code, request).ToList(), request);
    }    
    public bool isValidUserBankDate()
    {
        try
        {
            var bank_date = _kernelParams.GetParam("BANKDATE").Value;
            string query = "select sys_context('bars_global', 'user_bankdate') from dual";
            var user_date = _entities.ExecuteStoreQuery<string>(query, new object[0]).Single();
            return string.Equals(bank_date, user_date);
        }
        catch(Exception) {
            
        }
        return true;
    }
}