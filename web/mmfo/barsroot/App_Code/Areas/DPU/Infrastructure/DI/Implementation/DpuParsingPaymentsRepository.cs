using Bars.Classes;
using BarsWeb.Areas.DPU.Infrastructure.DI.Abstract;
using BarsWeb.Areas.DPU.Models;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

/// <summary>
/// Summary description for EditFinesDFORepository
/// </summary>
namespace BarsWeb.Areas.DPU.Infrastructure.DI.Implementation
{
    public class DpuParsingPaymentsRepository : IDpuParsingPaymentsRepository
    {
        public DpuParsingPaymentsRepository()
        {
        }
        public List<T> GetDataForDocGrid<T>()
        {
            var sql = @"SELECT a.acc as ACC, a.kv as KV, a.nls as NLS, a.nms as NMS, a.ostc/100 as OSTC, a.ostb/100 as OSTB, n.ref1 as REF1, o.vdat as VDAT, o.s/100 as S_100
                         , o.s as S
                         , o.nazn as NAZN
                         , ( SELECT sum(ostc)/100  
                               FROM accounts
                               join V_DPU_RELATION_ACC
                                 on ( dep_acc = acc ) 
                              WHERE GEN_ACC = a.ACC 
                           ) as BAL
                      FROM ACCOUNTS a
                      join NLK_REF  n
                        on ( a.acc = n.acc )
                      join OPER o
                        on ( o.ref = n.ref1 )
                     WHERE a.tip = 'NL8'
                       AND a.branch like sys_context('bars_context','user_branch_mask')
                       AND o.sos = 5  
                       AND n.ref2 IS NULL   
                       AND a.acc IN ( select distinct GEN_ACC from V_DPU_RELATION_ACC )   
                     ORDER BY a.kv DESC, o.vdat, o.s";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<T>(sql).ToList();
            }
        }
        public List<T> GetDataForGrid<T>(dynamic id)
        {
            var p = new DynamicParameters();
            p.Add("NLK_8", dbType: DbType.Decimal, size: 50, value: id, direction: ParameterDirection.Input);

            var sql = @"SELECT a.acc, a.nls, a.kv, a.ostc/100 as OSTC, a.ostb/100 as OSTB, a.nms, d.nd, d.sum/100 as SUM
                            FROM accounts a
                                JOIN dpu_deal d on ( d.acc = a.acc )
                                WHERE a.acc IN ( select DEP_ACC from V_DPU_RELATION_ACC where GEN_ACC = :NLK_8)
                                    AND a.dazs IS NULL
                                    AND a.mdate > bankdate
                                    AND a.ostb = decode(dpu.deposit_replenishment(a.acc), 1, a.ostb, 0)
                                    AND SubStr(a.nls,1,1) = '8'
                                ORDER BY a.nls";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<T>(sql, p).ToList();
            }
        }

        public void BeforeStart()
        {
            var sql = @"UPDATE nlk_ref n
                        SET ref2 = ref1
                        WHERE n.ref2 is null
                        AND exists (SELECT 1 FROM dpu_deal WHERE acc = n.acc)
                        AND exists (SELECT 1 FROM opldok WHERE ref = n.ref1 AND tt = 'DU8')";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql);
            }
        }

        public void DeleteRow(dynamic acc, dynamic ref1)
        {
            //    for (int i = 0; i < row.Count; i++)
            //    {
            var p = new DynamicParameters();

            p.Add("ACC", dbType: DbType.Decimal, size: 100, value: Convert.ToDecimal(acc.ACC), direction: ParameterDirection.Input);
            p.Add("REF", dbType: DbType.Decimal, size: 100, value: Convert.ToDecimal(ref1.REF1), direction: ParameterDirection.Input);

            var sql = @"DELETE FROM nlk_ref WHERE acc=:ACC AND ref1=:REF";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p);
            }

        }

        public void PayBack(dynamic row)
        {

            var p = new DynamicParameters();

            p.Add("REF", dbType: DbType.Decimal, size: 100, value: Convert.ToDecimal(row.REF1), direction: ParameterDirection.Input);

            var sql = @"begin dpu.pay_back(:REF); end;";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p);
            }

        }

        public void CreditedAmount(dynamic acc, dynamic row)
        {
            var p = new DynamicParameters();

            p.Add("nREF", dbType: DbType.Decimal, size: 100, value: Convert.ToDecimal(row.REF1), direction: ParameterDirection.Input);
            p.Add("VDAT", dbType: DbType.DateTime, size: 100, value: Convert.ToDateTime(row.VDAT), direction: ParameterDirection.Input);
            p.Add("S100", dbType: DbType.Decimal, size: 100, value: Convert.ToDecimal(row.S_100)*100, direction: ParameterDirection.Input);
            p.Add("nACC", dbType: DbType.Decimal, size: 100, value: Convert.ToDecimal(row.ACC), direction: ParameterDirection.Input);
            p.Add("ACC", dbType: DbType.Decimal, size: 100, value: Convert.ToDecimal(acc.ACC), direction: ParameterDirection.Input);

            var sql = @"begin bars.dpu.p_genacc_receipt( :nREF, :VDAT, :S100, :nACC, :ACC); end;";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p);
            }

        }


    }
}