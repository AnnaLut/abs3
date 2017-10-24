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
        public decimal GetSep3720Count(AccessType accessType, DataSourceRequest request)
        {
            InitSep3720Sql(accessType);
            string[] dateFields = new string[] { "STMP" };
            var a = _kendoSqlCounter.TransformSql(_baseSep3720Sql, request, dateFields);
            var total = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return total;
        }
        public void DeleteSep3720Record(int delSepREFnumber)
        {
            var delSep = _entities.T902.Where(del => del.REF == delSepREFnumber).Select(del => del).SingleOrDefault();
                                  
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
                @"select * from (SELECT o.dk DK,o.ref REF,a.mfoa MFOA,a.nlsa NLSA,a.s/100 S,a.nlsb NLSB,a.nam_b NAMB,a.nazn NAZN,a.d_rec DREC,
                a.rec REC,o.fdat FDAT,a.nd ND,a.nam_a NAMA,a.vob VOB,a.datd DATD,a.id_a OKPOA,a.id_b OKPOB,k.okpo OKPOB2,s.nms NAMB2,
                NVL(s.pap/s.pap,0) OTM,a.kv KV, s.nlsalt NLSALT, s.dazs DAZS,
                t.blk BLK, 
                t.otm SOS, t.rec_o RECO, t.stmp STMP, s.blkk BLKK, a.mfob MFOB, o.acc ACC
                FROM arc_rrp a, opldok o, t902 t, accounts s, customer k
                WHERE o.acc in (SELECT acc FROM accounts WHERE tip IN ('902','90D')) and
                o.tt in ('R01','D01') and a.rec=t.rec and o.ref=t.ref and a.nlsb=s.nls (+) and
                a.kv=s.kv (+) and s.rnk=k.rnk (+) {0} {1} ) base_query where 1=1 
                ",  
                accessType.Mode == "hrivna" ? "and a.kv=980" : "and a.kv<>980",
                accessType.AccessFlags.Contains("V") ? "and a.kv=" + kv.Value : ""
                ),
                SqlParams = new object[] {}
            };
        }
        public int SetRequest(string requestList)
        {
            List<Sep3720> extAttributes = JsonConvert.DeserializeObject<List<Sep3720>>(requestList);  
            var result = 0;

            foreach (Sep3720 item in extAttributes)
            {
                var arcrrp = _entities.ARC_RRP.Where(r => r.REC == item.REC).Where(name => name.FA_NAME != null).Select(x => new { x.FA_NAME, x.FA_LN, x.D_REC }).SingleOrDefault();
                if (arcrrp != null)
                {
                    cDoc cDocRequest = new cDoc(Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection(),
                            0,
                            "014", // в Центурі sTT = '014'
                            2,
                            (short)item.VOB,
                            item.ND,
                            item.DATD ?? DateTime.Now,
                            item.DATD ?? DateTime.Now,
                            item.DATD ?? DateTime.Now,
                            item.DATD ?? DateTime.Now,
                            item.NLSB, 
                            item.NAMB,
                            item.MFOB, // sAMFO use item.MFOB, but Centura like: sAMFO = GetBankMfo()
                            string.Empty,
                            (short)item.KV,
                            item.S ?? 0 * 100,
                            item.OKPOB,
                            item.NLSA,
                            item.NAMA,
                            item.MFOA,
                            string.Empty,
                            (short)item.KV,
                            item.S ?? 0 * 100,
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
                    cDocRequest.Drec = "#?" + arcrrp.FA_NAME + arcrrp.FA_LN + "#";
                    if (item.OKPOB == "0000000000")
                    {
                        cDocRequest.Drec = cDocRequest.Drec + "ФКлієнтом не надано#";
                    }
                    cDocRequest.Nazns = "11";
                    cDocRequest.DatP = DateTime.Now;

                    if (cDocRequest.oDoc())
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
            }
            return result;
        }
        public Sep3720AltAccount GetAltAccount(string nls, int? kv)
        {
            var customers = GetCustomer();
            var accounts = GetAccount();
            var altAccount =
                           (from cust in customers
                            join acc in accounts on cust.RNK equals acc.RNK
                            where nls==acc.NLS && kv==acc.KV
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
                var account = _entities.ACCOUNTS.Where(a => a.ACC == item.ACC).Select(a => new {a.NLS, a.NMS}).SingleOrDefault();
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
                             item.S ?? 0 * 100 ,
                             altAcc.sOKPOAlt,  
                             "Док " + item.ND + " від " + String.Format("{0:dd/MM/yy}", item.DATD.Value) + " " + item.NAZN,
					         "#C" + item.MFOA + "," + item.NLSA + "," + item.NAMA + "#",
                             string.Empty,                        
                             new byte[0], //GetBytes(""),              
                             0,          
                             0 ,
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
                  catch (OracleException e) {  }
                } 
            }
            return successCounter;
        }
        public decimal GetSumT902()
        {
            var sumT902 = from sum in _entities.ACCOUNTS
                          where sum.KV == 980 && sum.TIP == "902"
                          select sum.OSTC/100;
            
            return sumT902.AsQueryable().Sum();
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
 



