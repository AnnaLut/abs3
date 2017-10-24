using Areas.Sep.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Models;
using System;
using System.Linq;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation
{
    public class SepFutureDocsRepository : ISepFutureDocsRepository
    {
        private readonly SepFiles _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;

        public SepFutureDocsRepository(IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter)
        {
            var connectionStr = EntitiesConnection.ConnectionString("SepFiles", "Sep");
            _entities = new SepFiles(connectionStr);
            _sqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }

        public SepFutureDocAccount GetSepFutureDocAccount(decimal? ref_)
        {
            /*
                SELECT nls,nms 
                    FROM accounts a,opldok o
                    WHERE 
                    o.acc=a.acc AND 
                    o.tt='R01' AND 
                    o.ref= 38398006 AND 
                    o.sos=3 AND 
                    o.dk=0
            */
            var ret = (from accounts in _entities.ACCOUNTS
                from opldok in _entities.OPLDOK
                where (
                            opldok.ACC == accounts.ACC &&
                            opldok.TT == "R01" &&
                            opldok.REF == ref_ &&
                            opldok.SOS == 3 &&
                            opldok.DK == 0)

                select new SepFutureDocAccount()
                {
                    nls = accounts.NLS,
                    nms = accounts.NMS,
                    ostc = accounts.OSTC
                }).FirstOrDefault();
            return ret;
        }

        /// <summary>
        /// документ на інший рахунок
        /// </summary>
        /// <param name="ref_">Референція</param>
        /// <param name="datd">Дата док</param>
        /// <returns></returns>
        public void SetSepFutureDoc(decimal? ref_, DateTime? datd)
        {
            //UPDATE opldok SET fdat=:dDat WHERE ref=:tbl.REF and sos in (0,3);
            var opl = (from opldok in _entities.OPLDOK
                        where opldok.REF == ref_ && new[] { 0, 3 }.Contains(opldok.SOS)
                        select opldok).First();
            opl.FDAT = datd ?? default(DateTime);

            _entities.GL_PAY(2, ref_, null, null, null, null, null, null, null, null);

            
            //DELETE FROM tdval WHERE ref=:tbl.REF
            var val = (from tdval in _entities.TDVAL
                       where tdval.REF == ref_
                       select tdval).First();
            
            _entities.DeleteObject(val);
            _entities.SaveChanges();
        }

        public void RemoveSepFutureDoc(decimal? ref_)
        {
            //'gl.pay_bck('||Str(tbl.REF)||',3)')
            _entities.GL_PAY_BCK(ref_, 3);
            _entities.GL_PAY(2, ref_, null, null, null, null, null, null, null, null);


            //DELETE FROM tdval WHERE ref=:tbl.REF
            var val = (from tdval in _entities.TDVAL
                       where tdval.REF == ref_
                       select tdval).First();

            _entities.DeleteObject(val);
            _entities.SaveChanges();
        }

        public IQueryable<SepFutureDoc> GetSepFutureDoc()
        {
            return
                from tdval in _entities.TDVAL
                join arc_rrp in _entities.ARC_RRP on tdval.REF equals arc_rrp.REF
                join accounts in _entities.ACCOUNTS on arc_rrp.NLSB equals accounts.NLS
                join custumer in _entities.CUSTOMER on accounts.RNK equals custumer.RNK
                orderby arc_rrp.REF descending
                where (arc_rrp.KV == accounts.KV)
                    let Ref = from opldok in _entities.OPLDOK
                        where (
                            opldok.TT == "R01" &&
                            tdval.REF == opldok.REF &&
                            opldok.SOS == 3 &&
                            opldok.DK == 0)
                        select opldok.REF 
                    where Ref.Contains(tdval.REF)
                select new SepFutureDoc
                {
                    dk = arc_rrp.DK,
                    ref_ = arc_rrp.REF,
                    mfoa = arc_rrp.MFOA,
                    mfob = arc_rrp.MFOB,
                    nlsa = arc_rrp.NLSA,
                    s = arc_rrp.S / 100,
                    nlsb = arc_rrp.NLSB,
                    nam_b = arc_rrp.NAM_B,
                    nazn = arc_rrp.NAZN,
                    rec = arc_rrp.REC,
                    dat_a = arc_rrp.DAT_A,
                    nd = arc_rrp.ND,
                    nam_a = arc_rrp.NAM_A,
                    vob = arc_rrp.VOB,
                    datd = arc_rrp.DATD,
                    id_a = arc_rrp.ID_A,
                    id_b = arc_rrp.ID_B,
                    okpo = custumer.OKPO,
                    nms = accounts.NMS,

                    otm = accounts.PAP == null ? 1 : 0,

                    kv = arc_rrp.KV,
                    nlsalt = accounts.NLSALT,
                    dazs = accounts.DAZS,
                    datval = arc_rrp.D_REC.Remove(8).Substring(2)
                };
        }
    }
}