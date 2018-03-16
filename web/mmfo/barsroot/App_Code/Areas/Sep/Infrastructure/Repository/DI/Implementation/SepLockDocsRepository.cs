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
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Objects;
using System.Linq;
using System.Text.RegularExpressions;
using BarsWeb.Core.Logger;
using Microsoft.Ajax.Utilities;
using Ninject;
using Dapper;

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
    private BarsSql InitSepLockDocSql(int DefCode, int byCode, DataSourceRequest request, string parameters, string fixedBlk = null, string swt = null)
    {
        /*string query = "SELECT arc_rrp.mfoa, arc_rrp.mfob, arc_rrp.nlsa, arc_rrp.nlsb, arc_rrp.nam_a, arc_rrp.nam_b, arc_rrp.s, " +
        "    arc_rrp.kv, arc_rrp.dk, arc_rrp.nazn, arc_rrp.rec, arc_rrp.blk, 1 n, arc_rrp.ref, arc_rrp.fn_a, arc_rrp.datd, " +
        "    arc_rrp.rec_a, arc_rrp.bis, arc_rrp.vob, arc_rrp.nd, arc_rrp.ref_a, arc_rrp.id_a, arc_rrp.id_b, NVL(arc_rrp.prty,0) prty, " +
        "    rec_que.otm " +
        "FROM   rec_que, arc_rrp WHERE ";*/

        string query = "SELECT V_RECQUE_ARCRRP_DATA.mfoa, V_RECQUE_ARCRRP_DATA.mfob, V_RECQUE_ARCRRP_DATA.nlsa, V_RECQUE_ARCRRP_DATA.nlsb, V_RECQUE_ARCRRP_DATA.nam_a, V_RECQUE_ARCRRP_DATA.nam_b, V_RECQUE_ARCRRP_DATA.s, " +
        "    V_RECQUE_ARCRRP_DATA.kv, V_RECQUE_ARCRRP_DATA.dk, V_RECQUE_ARCRRP_DATA.nazn, V_RECQUE_ARCRRP_DATA.rec, V_RECQUE_ARCRRP_DATA.blk, 1 n, V_RECQUE_ARCRRP_DATA.ref, V_RECQUE_ARCRRP_DATA.fn_a, V_RECQUE_ARCRRP_DATA.datd," +
        "    V_RECQUE_ARCRRP_DATA.rec_a, V_RECQUE_ARCRRP_DATA.bis, V_RECQUE_ARCRRP_DATA.vob, V_RECQUE_ARCRRP_DATA.nd, V_RECQUE_ARCRRP_DATA.ref_a, V_RECQUE_ARCRRP_DATA.id_a, V_RECQUE_ARCRRP_DATA.id_b, NVL(V_RECQUE_ARCRRP_DATA.prty,0) prty, " +
        "    V_RECQUE_ARCRRP_DATA.otm, V_RECQUE_ARCRRP_DATA.dat_a, nvl(bp_rrp.name, S_ER.N_ER) blkName FROM V_RECQUE_ARCRRP_DATA, bp_rrp, s_er WHERE V_RECQUE_ARCRRP_DATA.blk = bp_rrp.rule(+) and V_RECQUE_ARCRRP_DATA.blk = S_ER.K_ER(+) ";

        if (DefCode == 1)
        {
            query += "and V_RECQUE_ARCRRP_DATA.blk not between 9701 and 9704 ";
        }

        if (byCode != 0)
            query += string.Format("and blk = {0} ", byCode.ToString());

        if (swt == "swt")
            query += " and V_RECQUE_ARCRRP_DATA.blk in (8,55,56,62,64,67,72,22) and not (V_RECQUE_ARCRRP_DATA.blk=9999 or (V_RECQUE_ARCRRP_DATA.blk=5122 and V_RECQUE_ARCRRP_DATA.sign is null))";

        if (!fixedBlk.IsNullOrWhiteSpace())
        {
            query += " and V_RECQUE_ARCRRP_DATA.blk in " + fixedBlk + " ";
        }

        //query += "arc_rrp.s>0 and arc_rrp.blk>0 and arc_rrp.fn_b is null and arc_rrp.rec = rec_que.rec order by arc_rrp.blk";
        if (!parameters.IsNullOrWhiteSpace())
        {
            // parameters - по умолчанию, расчитан на получение кодов блокировки fixed_blk
            query += " and " + parameters;
        }

        BarsSql sqlQuery = new BarsSql()
        {
            SqlParams = new object[0],
            SqlText = query
        };

        return sqlQuery;
    }
    public List<SepBis> GetBIS(decimal rec)
    {
        var lockQuery = new BarsSql()
        {
            SqlParams = new object[] {
                            new OracleParameter("Rec", OracleDbType.Decimal).Value = rec
                        },
            SqlText = @"SELECT b.nazn||decode(b.nazns,33,b.d_rec,'') as bis
                         FROM arc_rrp a, arc_rrp b 
                         WHERE a.rec= :Rec
                               and (b.ref = a.ref or (a.fn_a = b.fn_a  and (a.rec_a-a.bis) = (b.rec_a-b.bis) )   ) 
                               and a.bis=1 
                               and (   a.fn_a is not null AND a.fn_a=b.fn_a AND a.dat_a=b.dat_a 
                                     OR a.fn_a is null AND a.dat_a=b.dat_a 
                                     OR a.fn_a is null AND a.dat_a is null AND a.fn_b=b.fn_b AND a.dat_b=b.dat_b
                                   )
                               and a.rec<>b.rec AND a.bis<b.bis AND b.bis>0 
                         ORDER BY b.bis"
        };
        var data = _entities.ExecuteStoreQuery<SepBis>(lockQuery.SqlText, lockQuery.SqlParams).ToList();
        return data;
    }

    public decimal GetSepLockDocCount(int DefCode, int Code, DataSourceRequest request, string parameters, string fixedBlk = null, string swt = null)
    {
        BarsSql sqlQuery = InitSepLockDocSql(DefCode, Code, request, parameters, fixedBlk, swt);
        var sql = _kendoSqlCounter.TransformSql(sqlQuery, request);
        var total = _entities.ExecuteStoreQuery<decimal>(sql.SqlText, sql.SqlParams).Single();
        return total;
    }

    public IQueryable<SepLockDoc> GetSepLockDoc(int DefCode, int Code, DataSourceRequest request, string parameters, string fixedBlk = null, string swt = null)
    {
        BarsSql sqlQuery = InitSepLockDocSql(DefCode, Code, request, parameters, fixedBlk, swt);

        var sql = _sqlTransformer.TransformSql(sqlQuery, request);
        IQueryable<SepLockDoc> tmp = _entities.ExecuteStoreQuery<SepLockDoc>(sql.SqlText, sql.SqlParams).AsQueryable();

        return tmp;
    }

    public decimal GetSepLockDocResource(DataSourceRequest request)
    {
        string query = "SELECT sum(decode(tip,'TNB',-ostc-lim,-ostc)) FROM v_accounts_proc " +
        "    WHERE kv=980 and kf = sys_context('bars_context','user_mfo') and p_tip in ('N00', " +
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

                    if (Doc.bis > 0)
                    {
                        var updateQuery = new BarsSql()
                        {
                            SqlParams = new object[] {
                            new OracleParameter("Rec", OracleDbType.Decimal).Value = Doc.rec
                        },
                            SqlText = "UPDATE arc_rrp SET blk=-1 WHERE fn_b IS NULL AND bis > 0 AND rec IN " +
                            "(SELECT rec FROM rec_que WHERE rec_g=:Rec and rec_g IS NOT NULL)"
                        };

                        try
                        {
                            _entities.ExecuteStoreCommand(updateQuery.SqlText, updateQuery.SqlParams);
                        }
                        catch (Exception ex)
                        {
                            throw new Exception("Невозможно отметить в arc_rrp (BIS).", ex.InnerException);
                        }
                        //-----
                        var delRecQuery = new BarsSql()
                        {
                            SqlParams = new object[] {
                            new OracleParameter("Rec", OracleDbType.Decimal).Value = Doc.rec
                        },
                            SqlText = "DELETE FROM rec_que WHERE rec_g=:Rec and rec_g IS NOT NULL"
                        };

                        try
                        {
                            _entities.ExecuteStoreCommand(delRecQuery.SqlText, delRecQuery.SqlParams);
                        }
                        catch (Exception ex)
                        {
                            throw new Exception("Невозможно удалить из rec_que (BIS).", ex.InnerException);
                        }
                        //-----
                        var delTzaprosQuery = new BarsSql()
                        {
                            SqlParams = new object[] {
                            new OracleParameter("Rec", OracleDbType.Decimal).Value = Doc.rec
                        },
                            SqlText = "DELETE FROM tzapros WHERE rec_g=:Rec and rec_g IS NOT NULL"
                        };

                        try
                        {
                            _entities.ExecuteStoreCommand(delTzaprosQuery.SqlText, delTzaprosQuery.SqlParams);
                        }
                        catch (Exception ex)
                        {
                            throw new Exception("Невозможно удалить из tzapros (BIS)", ex.InnerException);
                        }
                    }
                    else
                    {

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

    public bool DeleteSepLockDocsByCode(int DefCode, int Code, string parameters, DataSourceRequest request)
    {
        return DeleteSepLockDocs(GetSepLockDoc(DefCode, Code, request, parameters).ToList(), request);
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
                    throw new Exception("Помилка при виклику pay_bck!", ex.InnerException);
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

                _entities.Connection.Close();
            }
        }
        return isOk;
    }
    public bool ReturnSepLockDocsByCode(string Reason, int DefCode, int Code, string parameters, DataSourceRequest request)
    {
        return ReturnSepLockDocs(Reason, GetSepLockDoc(DefCode, Code, request, parameters).ToList(), request);
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
        _entities.Connection.Close();
        return isOk;
    }

    public bool UnLockSepLockDocsByCode(int DefCode, int Code, string parameters, DataSourceRequest request)
    {
        return UnlockSepLockDocs(GetSepLockDoc(DefCode, Code, request, parameters).ToList(), request);
    }

    public bool UnlockSepDocsTo902(List<SepLockDoc> Docs, DataSourceRequest request)
    {
        bool isOk = false;
        decimal? cRef = null;
        String sql_query = String.Empty;
        DynamicParameters par = new DynamicParameters();
        using (var connection = OraConnector.Handler.UserConnection)
        {
            try
            {
                foreach (var Doc in Docs)
                {
                    var trans = connection.BeginTransaction();
                    try
                    {
                        sql_query = "SELECT rec FROM arc_rrp WHERE rec=:Rec and blk=:Blk FOR UPDATE OF blk NOWAIT";
                        par = new DynamicParameters();
                        par.Add("Rec", dbType: DbType.Decimal, value: Doc.rec, direction: ParameterDirection.Input);
                        par.Add("Blk", dbType: DbType.Int16, value: Doc.blk, direction: ParameterDirection.Input);

                        try
                        {
                            connection.Query(sql_query, par);
                        }
                        catch (Exception ex)
                        {
                            throw new Exception("Неможливо отримати доступ до REC.", ex.InnerException);
                        }

                        sql_query = "select sys_context('bars_context','user_mfo') from dual";
                        String kf = connection.Query<string>(sql_query).FirstOrDefault();

                        sql_query = @"BEGIN
                                         sep_utl.getT00_902(:p_mfoa,
                                                    :p_dk,
                                                    :p_kv,
                                                    :p_blk,
                                                    :p_strNlsT00,
                                                    :p_strNls902,
                                                    :p_strTTadd);
                                      END;";
                        par = new DynamicParameters();
                        par.Add("p_mfoa", dbType: DbType.String, value: Doc.mfoa, direction: ParameterDirection.Input);
                        par.Add("p_dk", dbType: DbType.Int32, value: Doc.dk, direction: ParameterDirection.Input);
                        par.Add("p_kv", dbType: DbType.Int32, value: Doc.kv, direction: ParameterDirection.Input);
                        par.Add("p_blk", dbType: DbType.Int32, value: Doc.blk, direction: ParameterDirection.Input);
                        par.Add("p_strNlsT00", dbType: DbType.String, size: 100, direction: ParameterDirection.Output);
                        par.Add("p_strNls902", dbType: DbType.String, size: 100, direction: ParameterDirection.Output);
                        par.Add("p_strTTadd", dbType: DbType.String, size: 100, direction: ParameterDirection.Output);

                        connection.Execute(sql_query, par);

                        string nlsT = par.Get<string>("p_strNlsT00");
                        string nls902 = par.Get<string>("p_strNls902");

                        var dDat = _datesRepository.GetBankDate();
                        var operId = _homeRepository.GetUserParam().IDOPER;

                        long ref_ = 0;

                        var clrtrn = _kernelParams.GetParam("CLRTRN");
                        short nSos = 0;
                        if (clrtrn != null && Doc.kv == 980)
                        {
                            nSos = 8;
                        }
                        else
                        {
                            nSos = 5;
                        }

                        var dRec = (from arcRrp in _entities.ARC_RRP
                            where arcRrp.REC == Doc.rec
                            select arcRrp).First().D_REC;

                        cDoc creatorDoc = new cDoc(
                            connection,
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
                        if (Regex.IsMatch(dRec, @"^#B(\d){2}#fMT (\w){3} *?"))
                        {
                            var ot = _entities.T902.Count(t => t.REC == Doc.rec && t.OTM == 0);
                            if (0 == ot)
                            {
                                creatorDoc.DrecS.Add(new cDoc.Tags("NOS_A", "0"));
                            }
                        }
                        if (creatorDoc.oDocument())
                        {

                            cRef = creatorDoc.Ref;

                            sql_query = "UPDATE arc_rrp SET ref=:p_ref, dat_b=to_date(:p_dat_b, 'dd.mm.yyyy HH24:MI:SS'), sos=:p_sos, blk=0 WHERE rec in (select rec from rec_que where rec_g=:p_rec) and fn_b IS NULL";
                            par = new DynamicParameters();
                            par.Add("p_ref", dbType: DbType.Decimal, value: cRef, direction: ParameterDirection.Input);
                            par.Add("p_dat_b", dbType: DbType.String, value: dDat.ToString(@"dd.MM.yyyy HH:mm:ss"), direction: ParameterDirection.Input);
                            par.Add("p_sos", dbType: DbType.Int32, value: nSos, direction: ParameterDirection.Input);
                            par.Add("p_rec", dbType: DbType.Decimal, value: Doc.rec, direction: ParameterDirection.Input);
                            connection.Execute(sql_query, par);

                            try
                            {
                                sql_query = @"begin sep.bis2ref(:p_rec, :p_ref); end;";
                                par=new DynamicParameters();
                                par.Add("p_rec", dbType: DbType.Decimal, value: Doc.rec, direction: ParameterDirection.Input);
                                par.Add("p_ref", dbType: DbType.Decimal, value: cRef, direction: ParameterDirection.Input);
                                connection.Execute(sql_query, par);
                            }
                            catch (Exception ex)
                            {
                                throw new Exception("Не вдалося перенести додаткові реквізити");
                            }

                            try
                            {
                                sql_query = "DELETE FROM rec_que WHERE rec_g=:p_rec";
                                par = new DynamicParameters();
                                par.Add("p_rec", dbType: DbType.Decimal, value: Doc.rec, direction: ParameterDirection.Input);
                                connection.Execute(sql_query, par);
                            }
                            catch (Exception ex)
                            {
                                throw new Exception("Документ REC=" + Doc.rec + " оброблено. Оновіть дані на формі.", ex.InnerException);
                            }

                            try
                            {
                                sql_query = "INSERT INTO t902 (ref, rec, blk, kf) VALUES (:p_ref, :p_rec, :p_blk, :p_kf)";
                                par = new DynamicParameters();
                                par.Add("p_ref", dbType: DbType.Decimal, value: cRef, direction: ParameterDirection.Input);
                                par.Add("p_rec", dbType: DbType.Decimal, value: Doc.rec, direction: ParameterDirection.Input);
                                par.Add("p_blk", dbType: DbType.Int32, value: Doc.blk, direction: ParameterDirection.Input);
                                par.Add("p_kf", dbType: DbType.String, value: kf, direction: ParameterDirection.Input);
                                connection.Execute(sql_query, par);
                            }
                            catch 
                            {
                                throw new Exception("Документ REC=" + Doc.rec + " оброблено. Оновіть дані на формі.");
                            }

                            Logger.Financial(string.Format("Док #{0}({1}) - до ВЫЯСНЕНИЯ", cRef.ToString(), Doc.rec.ToString()));
                        }
                        else
                        {
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
                        {
                            UpdateOper(connection, cRef, Doc.rec);
                            trans.Commit();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        return isOk;
    }
    
    private void UpdateOper(OracleConnection connection, decimal? nRef, decimal nRec)
    {
        String sql_query = String.Empty;
        DynamicParameters par = new DynamicParameters();

        sql_query = "SELECT nlsa, nlsb, d_rec, id_o, sign FROM arc_rrp WHERE rec=:p_rec";
        par.Add("p_rec", dbType: DbType.Decimal, value: nRec, direction: ParameterDirection.Input);
        ARC_RRP arc_r = connection.Query<ARC_RRP>(sql_query, par).FirstOrDefault();

        sql_query = "UPDATE oper SET nlsa = :p_nlsa, nlsb = :p_nlsb, d_rec = :p_d_rec, id_o = :p_id_o, sign = :p_sign WHERE ref=:p_ref";
        par = new DynamicParameters();
        par.Add("p_ref", dbType: DbType.Decimal, value: nRef, direction: ParameterDirection.Input);
        par.Add("p_nlsa", dbType: DbType.String, value: arc_r.NLSA, direction: ParameterDirection.Input);
        par.Add("p_nlsb", dbType: DbType.String, value: arc_r.NLSB, direction: ParameterDirection.Input);
        par.Add("p_d_rec", dbType: DbType.String, value: arc_r.D_REC == null ? "": arc_r.D_REC, direction: ParameterDirection.Input);
        par.Add("p_id_o", dbType: DbType.String, value: arc_r.ID_O, direction: ParameterDirection.Input);
        par.Add("p_sign", dbType: DbType.Binary, value: arc_r.SIGN, direction: ParameterDirection.Input);

        connection.Execute(sql_query, par);
    }

    public bool UnlockSepDocsTo902ByCode(int DefCode, int Code, string parameters, DataSourceRequest request)
    {
        return UnlockSepDocsTo902(GetSepLockDoc(DefCode, Code, request, parameters).ToList(), request);
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
        catch (Exception)
        {

        }
        return true;
    }
    public void UpdateDocPrty(decimal rec, decimal blk, decimal prty)
    {
        const string query = @"UPDATE arc_rrp SET prty=:tbl_PRTY WHERE rec=:tbl_ID and blk=:tbl_BLK";
        var parameters = new object[]
        {
            new OracleParameter("tbl_PRTY", OracleDbType.Decimal, prty, ParameterDirection.Input),
            new OracleParameter("tbl_ID", OracleDbType.Decimal, rec, ParameterDirection.Input),
            new OracleParameter("tbl_BLK", OracleDbType.Decimal, blk, ParameterDirection.Input)
        };
        _entities.ExecuteStoreCommand(query, parameters);
    }

}