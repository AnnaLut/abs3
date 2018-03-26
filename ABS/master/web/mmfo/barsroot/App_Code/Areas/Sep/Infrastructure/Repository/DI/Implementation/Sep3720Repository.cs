using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;
using CUSTOMER = Areas.Sep.Models.CUSTOMER;
using Bars.Doc;
using BarsWeb.Models;
using Newtonsoft.Json;
using Bars.Areas.Sep.Models;
using Bars.Classes;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation
{
    public class Sep3720Repository : ISep3720Repository
    {
        private readonly SepFiles _entities;
        public BarsSql _baseSep3720Sql;
        public BarsSql _getSumT902Sql;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        private readonly IParamsRepository _paramRepo;


        public Sep3720Repository(IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter, IParamsRepository paramRepo)
        {
            var connectionStr = EntitiesConnection.ConnectionString("SepFiles", "Sep");
            this._entities = new SepFiles(connectionStr);
            _sqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _paramRepo = paramRepo;
        }
        public IQueryable<Sep3720> GetSep3720List(DataSourceRequest request, AccessType accessType)
        {
            InitSep3720Sql(accessType);
            string[] dateFields = new string[] { "STMP" };
            var sql = _sqlTransformer.TransformSql(_baseSep3720Sql, request, dateFields);
            ObjectResult<Sep3720> tmpResult = _entities.ExecuteStoreQuery<Sep3720>(sql.SqlText, sql.SqlParams);

            return tmpResult.AsQueryable();
        }

        public List<Sep3720Register> GetSep3720RegisterList(Int32 register_tp, String register_dt_from, String register_dt_to)
        {
            String sql_query = @"SELECT dat_a DAT, mfoa MFOA, nlsa NLSA, mfob MFOB, nlsb NLSB, dk DK,
                                        s S, vob VOB, nd ND, kv KV, datd DATD, nam_a NAMA, nam_b NAMB,
                                        nazn NAZN, d_rec DREC, id_a ID_A, id_b ID_B, rec REC
                                 FROM arc_rrp
                                 WHERE {0} AND trunc(dat_a) between to_date(:p_register_dt_from, 'dd/MM/yyyy') AND to_date(:p_register_dt_to, 'dd/MM/yyyy')
                                 ORDER BY nlsb";
            String add_query = String.Empty;

            if (register_tp == 0)
                add_query = "mfob=(select f_ourmfo() from dual) AND SUBSTR(d_rec,1,2) IN ('#!','#+','#-','#*')";
            else
                add_query = "mfoa=(select f_ourmfo() from dual) AND SUBSTR(d_rec,1,2)='#?'";

            sql_query = String.Format(sql_query, add_query);

            object[] sql_params = new object[] {
                                                new OracleParameter("p_register_dt_from", OracleDbType.Varchar2) { Value = register_dt_from.Substring(0, 10) },
                                                new OracleParameter("p_register_dt_to", OracleDbType.Varchar2) { Value = register_dt_to.Substring(0, 10) }
                                              };
            List<Sep3720Register> list = _entities.ExecuteStoreQuery<Sep3720Register>(sql_query, sql_params).ToList();
            return list;
        }

        public decimal GetSep3720Count(AccessType accessType, DataSourceRequest request)
        {
            InitSep3720Sql(accessType);
            string[] dateFields = new string[] { "STMP" };
            var a = _kendoSqlCounter.TransformSql(_baseSep3720Sql, request, dateFields);
            var total = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return total;
        }
        public void DeleteSep3720Record(decimal reference)
        {
            var delSep = _entities.T902.Where(del => del.REF == reference).Select(del => del).SingleOrDefault();

            _entities.DeleteObject(delSep);
            _entities.SaveChanges();
        }
        public IQueryable<ACCOUNTS> GetAccount()
        {
            var accounts = _entities.ACCOUNTS;
            return accounts;
        }
        public IQueryable<CUSTOMER> GetCustomer()
        {
            var customers = _entities.CUSTOMER;
            return customers;
        }
        private void InitSep3720Sql(AccessType accessType)
        {
            var kv = _paramRepo.GetParam("BASEVAL");

            _baseSep3720Sql = new BarsSql()
            {
                SqlText = string.Format(
                //@"select * from (SELECT o.dk DK,o.ref REF,a.mfoa MFOA,a.nlsa NLSA,a.s/100 S,a.nlsb NLSB,a.nam_b NAMB,a.nazn NAZN,a.d_rec DREC,
                //a.rec REC,o.fdat FDAT,a.nd ND,a.nam_a NAMA,a.vob VOB,a.datd DATD, a.datp DATP, a.id_a OKPOA,a.id_b OKPOB,k.okpo OKPOB2,s.nms NAMB2,
                //NVL(s.pap/s.pap,0) OTM,a.kv KV, s.nlsalt NLSALT, s.dazs DAZS,
                //t.blk BLK, 
                //t.otm SOS, t.rec_o RECO, t.stmp STMP, s.blkk BLKK, a.mfob MFOB, o.acc ACC, a.fa_name FA_NAME, a.fa_ln FA_LN
                //FROM arc_rrp a, opldok o, t902 t, accounts s, customer k
                //WHERE o.acc in (SELECT acc FROM accounts WHERE tip IN ('902', '90D')) and
                //o.tt in ('R01','D01') and a.rec=t.rec and o.ref=t.ref and a.nlsb=s.nls (+) and
                //a.kv=s.kv (+) and s.rnk=k.rnk (+) {0} {1} ) base_query where 1=1 ORDER BY FDAT 
                //",
                    @"SELECT *
                    FROM (SELECT o.dk DK,
                                 o.REF REF,
                                 a.mfoa MFOA,
                                 a.nlsa NLSA,
                                 a.s / 100 S,
                                nvl((SELECT nlsb
                                               FROM arc_rrp
                                              WHERE rec = t.rec_o), a.nlsb) NLSB,
                                 a.nam_b NAMB,
                                 a.nazn NAZN,
                                 a.d_rec DREC,
                                 a.rec REC,
                                 o.fdat FDAT,
                                 a.nd ND,
                                 a.nam_a NAMA,
                                 a.vob VOB,
                                 a.datd DATD,
                                 a.datp DATP,
                                 a.id_a OKPOA,
                                 case when t.rec_o is not null then nvl(k.okpo,a.id_b )
                                 else a.id_b 
                                 end OKPOB,
                                 k.okpo OKPOB2,
                                 s.nms NAMB2,
                                 CASE
                                    WHEN    s.nls IS NOT NULL
                                         OR nvl((SELECT nlsb
                                               FROM arc_rrp
                                              WHERE rec = t.rec_o), a.nlsb) <> a.nlsb                                               
                                    THEN
                                       1
                                    ELSE
                                       0
                                 END
                                    OTM,
                                 a.kv KV,
                                 s.nlsalt NLSALT,
                                 s.dazs DAZS,
                                 t.blk BLK,
                                 t.otm SOS,
                                 t.rec_o RECO,
                                 t.stmp STMP,
                                 s.blkk BLKK,
                                 a.mfob MFOB,
                                 o.acc ACC,
                                 a.fa_name FA_NAME,
                                 a.fa_ln FA_LN
                            FROM arc_rrp a,
                                 opldok o,
                                 t902 t,
                                 accounts s,
                                 customer k
                           WHERE     o.acc IN (SELECT acc
                                                 FROM accounts
                                                WHERE tip IN ('902', '90D'))
                                 AND o.tt IN ('R01', 'D01')
                                 AND a.rec = t.rec
                                 AND o.REF = t.REF
                                 AND a.nlsb = s.nls(+)
                                 AND a.kv = s.kv(+)
                                 AND s.rnk = k.rnk(+)
                                 {0} {1}) base_query
                   WHERE 1 = 1
                ORDER BY FDAT",
                accessType.Mode == "hrivna" ? "and a.kv=980" : "and a.kv<>980",
                accessType.AccessFlags.Contains("V") ? "and a.kv=" + kv.Value : ""
                ),
                SqlParams = new object[] { }
            };
        }
        public List<SetRequestResult> SetRequest(List<Sep3720> extAttributes)
        {
            var result = 0;
            List<SetRequestResult> error_nds = new List<SetRequestResult>();
            using (var connection = OraConnector.Handler.UserConnection)
            {
                try
                {
                    _entities.Connection.Open();
                    foreach (Sep3720 item in extAttributes)
                    {
                        bool isOk = false;
                        var trans = connection.BeginTransaction();
                        var trans_entity = _entities.Connection.BeginTransaction();
                        try
                        {
                            var arcrrp = _entities.ARC_RRP.Where(r => r.REC == item.REC).Where(name => name.FA_NAME != null).Select(x => new { x.FA_NAME, x.FA_LN, x.D_REC }).SingleOrDefault();
                            if (arcrrp != null)
                            {
                                cDoc cDocRequest = new cDoc(connection,
                                        0,
                                        "014", // в Центурі sTT = '014'
                                        2,
                                        (short)item.VOB,
                                        item.ND,
                                        item.DATD ?? DateTime.Now,
                                        item.DATP ?? DateTime.Now,
                                        DateTime.Now,
                                        DateTime.Now,
                                        item.NLSB,
                                        item.NAMB,
                                        item.MFOB, // sAMFO use item.MFOB, but Centura like: sAMFO = GetBankMfo()
                                        string.Empty,
                                        (short)item.KV,
                                        item.S * 100 ?? 0 * 100,
                                        item.OKPOB,
                                        item.NLSA,
                                        item.NAMA,
                                        item.MFOA,
                                        string.Empty,
                                        (short)item.KV,
                                        item.S * 100 ?? 0 * 100,
                                        item.OKPOA,
                                        "Запит на уточнення реквізитів документа",
                                        string.Empty,
                                        string.Empty,
                                        new byte[0],
                                        0,
                                        0,
                                        0,
                                        string.Empty,
                                        string.Empty,
                                        string.Empty,
                                        string.Empty
                                    );
                                cDocRequest.Drec = "#?" + arcrrp.FA_NAME + arcrrp.FA_LN.ToString().PadLeft(6, ' ') + "#";
                                if (item.OKPOB == "0000000000")
                                {
                                    cDocRequest.Drec = cDocRequest.Drec + "ФКлієнтом не надано#";
                                }
                                cDocRequest.Nazns = "11";
                                cDocRequest.DatP = DateTime.Now;

                                if (cDocRequest.oDocument())
                                {
                                    var addRow = _entities.T902.Where(t => t.REC == item.REC).SingleOrDefault();
                                    addRow.OTM = 1;
                                    addRow.DAT = item.DATD;
                                    result = _entities.SaveChanges();
                                }
                                if (item.OKPOA == "0000000000")
                                {
                                    cDocRequest.Drec = cDocRequest.Drec + "ФКлієнтом не надано#";
                                }
                            }
                            isOk = true;
                        }
                        catch (Exception ex)
                        {
                            trans.Rollback();
                            SetRequestResult model = new SetRequestResult(item.ND, ex.Message);
                            error_nds.Add(model);
                        }
                        finally
                        {
                            if (isOk)
                            {
                                trans.Commit();
                                trans_entity.Commit();
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    _entities.Connection.Close();
                }
            }
            return error_nds;
        }
        public Sep3720AltAccount GetAltAccount(string nls, decimal? kv)
        {
            var customers = GetCustomer();
            var accounts = GetAccount();
            var altAccount =
                           (from cust in customers
                            join acc in accounts on cust.RNK equals acc.RNK
                            where nls == acc.NLS && kv == acc.KV
                            select new Sep3720AltAccount() { sNlsAlt = acc.NLS, sNamAlt = acc.NMS, sOKPOAlt = cust.OKPO }).SingleOrDefault();
            // add if/else для додання повідомлення "Рахунок " || tbl.NLSALT || " (альтернативний) НЕ знайдено !"
            return altAccount;
        }
        public int SetToAltAccounts(string docList)
        {
            List<Sep3720> extAttributes = JsonConvert.DeserializeObject<List<Sep3720>>(docList);
            Sep3720AltAccount altAcc;
            var successCounter = 0;

            foreach (Sep3720 item in extAttributes)
            {
                altAcc = GetAltAccount(item.NLSALT, item.KV);
                var account = _entities.ACCOUNTS.Where(a => a.ACC == item.ACC).Select(a => new { a.NLS, a.NMS }).SingleOrDefault();
                if (account != null)
                {
                    cDoc cDocAlt = new cDoc(Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection(),
                             0,
                             "901",
                             (byte)item.DK,
                             6,
                             string.Empty,
                             item.DATD ?? DateTime.Now,
                             item.DATD ?? DateTime.Now,
                             item.DATD ?? DateTime.Now,
                             item.DATD ?? DateTime.Now,
                             account.NLS,
                             item.NAMA == "Y" ? account.NMS : item.NAMA,
                             item.MFOA,
                             string.Empty,
                             (short)item.KV,
                             item.S ?? 0 * 100,
                             item.OKPOA,
                             altAcc.sNlsAlt,
                             altAcc.sNamAlt,
                             item.MFOB,
                             string.Empty,
                             (short)item.KV,
                             item.S ?? 0 * 100,
                             altAcc.sOKPOAlt,
                             "Док " + item.ND + " від " + String.Format("{0:dd/MM/yy}", item.DATD.Value) + " " + item.NAZN,
                             "#C" + item.MFOA + "," + item.NLSA + "," + item.NAMA + "#",
                             string.Empty,
                             new byte[0], //GetBytes(""),              
                             0,
                             0,
                             0,
                             string.Empty,
                             string.Empty,
                             string.Empty,
                             string.Empty
                        );
                    //по цетурі має бути ще виконано : cDocAlt.nRefDoc = item.REF, де змінна nRefDoc типу Number 
                    try
                    {
                        cDocAlt.oDoc();
                        successCounter++;
                    }
                    catch (OracleException e) { }
                }
            }
            return successCounter;
        }
        public decimal GetSumT902()
        {
            var sumT902 = from sum in _entities.ACCOUNTS
                          where sum.KV == 980 && sum.TIP == "902"
                          select sum.OSTC / 100;

            return sumT902.AsQueryable().Sum();
        }

        public decimal SumT902Docs3720()
        {
            string sql = @"SELECT SUM (s/100)
                              FROM opldok
                             WHERE     REF IN (SELECT REF FROM t902)
                                   AND acc IN (SELECT acc
                                                 FROM accounts
                                        WHERE nbs = '3720' AND kv = 980 AND tip = '902')";
            return _entities.ExecuteStoreQuery<decimal>(sql).SingleOrDefault();
        }

        // для конвертації string to byte[] 
        private byte[] GetBytes(string str)
        {
            byte[] bytes = new byte[str.Length * sizeof(char)];
            System.Buffer.BlockCopy(str.ToCharArray(), 0, bytes, 0, bytes.Length);
            return bytes;
        }
    }
}




