using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace BarsWeb.Areas.CustomerList.Infrastructure.DI.Implementation
{
    public class SqlCreator
    {
        public static BarsSql SearchMain()
        {
            return new BarsSql()
            {
                SqlText = @"select * from V_ACCOUNTS",
                SqlParams = new object[] { }
            };

        }

        public static BarsSql SearchTotalCurrencies(string bankdate, string accList)
        {
            var sb = new System.Text.StringBuilder()
                .Append(@"WITH t
                AS ( SELECT t.kv,
                t.lcv,
                NVL(c.isdf,0)/POWER(10,t.dig) isdf, 
                NVL(c.iskf,0)/POWER(10,t.dig) iskf, 
                NVL(b.dos,0)/POWER(10,t.dig) dos, 
                NVL(b.kos,0)/POWER(10,t.dig) kos, 
                d.ostcd/POWER(10,t.dig) ostcd, 
                d.ostck/POWER(10,t.dig) ostck, 
                d.rat/POWER(10,t.dig) rat,
                NVL(c.isdq,0)/POWER(10,2) isdq, 
                NVL(c.iskq,0)/POWER(10,2) iskq, 
                NVL(b.dosq,0)/POWER(10,2) dosq, 
                NVL(b.kosq,0)/POWER(10,2) kosq, 
                d.ostcdq/POWER(10,2) ostcdq, 
                d.ostckq/POWER(10,2) ostckq, 
                d.ratq/100 ratq 
                FROM tabval t,
                ( SELECT a.kv,
                SUM ( DECODE ( SIGN ( DECODE ( s.fdat, TO_DATE(:BANK_DATE,'dd.mm.yyyy' ), s.ostf, s.ostf - s.dos + s.kos)), 1, 0,
                DECODE ( s.fdat, TO_DATE (:BANK_DATE,'dd.mm.yyyy' ), s.ostf, s.ostf - s.dos + s.kos))) isdf,
                SUM ( DECODE ( SIGN ( DECODE ( s.fdat, TO_DATE (:BANK_DATE,'dd.mm.yyyy'), s.ostf, s.ostf - s.dos + s.kos)), -1, 0,
                DECODE ( s.fdat, TO_DATE (:BANK_DATE,'dd.mm.yyyy'), s.ostf, s.ostf - s.dos + s.kos))) iskf,
                SUM ( DECODE ( SIGN ( DECODE ( s.fdat, TO_DATE (:BANK_DATE,'dd.mm.yyyy'), s.ostf, s.ostf - s.dos + s.kos)), 1, 0,
                DECODE ( s.fdat, TO_DATE (:BANK_DATE,'dd.mm.yyyy'), gl.p_icurval ( a.kv, s.ostf, TO_DATE( :BANK_DATE, 'dd.mm.yyyy')),
                gl.p_icurval ( a.kv, (s.ostf - s.dos + s.kos), TO_DATE (:BANK_DATE,'dd.mm.yyyy'))))) isdq, 
                SUM ( DECODE ( SIGN ( DECODE ( s.fdat, TO_DATE (:BANK_DATE,'dd.mm.yyyy'), s.ostf, s.ostf - s.dos + s.kos)), -1, 0,
                DECODE ( s.fdat, TO_DATE (:BANK_DATE,'dd.mm.yyyy'), gl.p_icurval ( a.kv, s.ostf, TO_DATE( :BANK_DATE, 'dd.mm.yyyy')),
                gl.p_icurval (a.kv, (s.ostf - s.dos + s.kos), TO_DATE (:BANK_DATE,'dd.mm.yyyy'))))) iskq
                FROM saldoa s, (")
                .Append(accList)
                .Append(@") a
                WHERE s.acc = a.acc AND (a.acc,s.fdat) = (SELECT acc, max(fdat)
                FROM saldoa WHERE acc=a.acc AND fdat<=TO_DATE(:BANK_DATE,'dd.mm.yyyy') GROUP BY acc ) GROUP BY a.kv) c,
                (SELECT a.kv,
                SUM(DECODE(SIGN(s.ostf - s.dos + s.kos), 1,0,s.ostf - s.dos + s.kos)) ostcd,
                SUM(DECODE(SIGN(s.ostf - s.dos + s.kos),-1,0,s.ostf - s.dos + s.kos)) ostck,
                SUM((s.ostf - s.dos + s.kos)*acrn.fprocn(a.acc,null,s.fdat)) rat,
                SUM(DECODE(SIGN(s.ostf - s.dos + s.kos), 1,0, gl.p_icurval(a.kv, s.ostf - s.dos + s.kos, TO_DATE(:BANK_DATE,'dd.mm.yyyy')))) ostcdq,
                SUM(DECODE(SIGN(s.ostf - s.dos + s.kos),-1,0, gl.p_icurval(a.kv, s.ostf - s.dos + s.kos, TO_DATE(:BANK_DATE,'dd.mm.yyyy')))) ostckq,
                SUM((gl.p_icurval(a.kv, s.ostf - s.dos + s.kos,s.fdat))*acrn.fprocn(a.acc,null,s.fdat)) ratq
                FROM saldoa s, (")
                .Append(accList)
                .Append(@") a
                WHERE s.acc = a.acc AND 
                (a.acc,s.fdat) = (SELECT acc, max(fdat) 
                FROM saldoa 
                WHERE acc = a.acc AND fdat <= TO_DATE(:BANK_DATE,'dd.mm.yyyy') 
                GROUP BY acc ) 
                GROUP BY a.kv) d, 
                (SELECT a.kv, 
                SUM(DECODE(s.fdat, B.fdat, s.dos, 0)) dos, 
                SUM(DECODE(s.fdat, B.fdat, s.kos, 0)) kos,
                SUM(DECODE(s.fdat, B.fdat, gl.p_icurval(a.kv, s.dos,s.fdat), 0)) dosq, 
                SUM(DECODE(s.fdat, B.fdat, gl.p_icurval(a.kv, s.kos,s.fdat), 0)) kosq
                FROM saldoa s, fdat B , (")
                .Append(accList)
                .Append(@") a
                WHERE a.acc=s.acc AND 
                (a.acc,s.fdat) = (SELECT c.acc, max(c.fdat) 
                FROM saldoa c 
                WHERE a.acc=c.acc AND c.fdat<= B.fdat 
                GROUP BY c.acc) AND 
                b.fdat >= TO_DATE(:BANK_DATE,'dd.mm.yyyy') AND b.fdat <= TO_DATE(:BANK_DATE,'dd.mm.yyyy') 
                GROUP BY a.kv) b
                WHERE t.kv=c.kv(+) AND t.kv=d.kv AND t.kv=b.kv(+) 
                ORDER BY 2, 1")
                .Append(@" ) select kv, lcv,   isdf,       iskf,      dos,     kos,       ostcd, ostck, rat from t 
                union all
                select null, 'Екв:', SUM(isdq),  SUM(iskq), SUM(dosq), SUM(kosq), SUM(ostcdq), SUM(ostckq), 0 from t ");

            BarsSql barsSql = new BarsSql
            {
                SqlText = sb.ToString(),
                SqlParams = new object[]
                {
                    new OracleParameter("BANK_DATE", OracleDbType.Varchar2){ Value=bankdate },
                    new OracleParameter("BANK_DATE", OracleDbType.Varchar2){ Value=bankdate },
                    new OracleParameter("BANK_DATE", OracleDbType.Varchar2){ Value=bankdate },
                    new OracleParameter("BANK_DATE", OracleDbType.Varchar2){ Value=bankdate },
                    new OracleParameter("BANK_DATE", OracleDbType.Varchar2){ Value=bankdate },
                    new OracleParameter("BANK_DATE", OracleDbType.Varchar2){ Value=bankdate },
                    new OracleParameter("BANK_DATE", OracleDbType.Varchar2){ Value=bankdate },
                    new OracleParameter("BANK_DATE", OracleDbType.Varchar2){ Value=bankdate },
                    new OracleParameter("BANK_DATE", OracleDbType.Varchar2){ Value=bankdate },
                    new OracleParameter("BANK_DATE", OracleDbType.Varchar2){ Value=bankdate },
                    new OracleParameter("BANK_DATE", OracleDbType.Varchar2){ Value=bankdate },
                    new OracleParameter("BANK_DATE", OracleDbType.Varchar2){ Value=bankdate },
                    new OracleParameter("BANK_DATE", OracleDbType.Varchar2){ Value=bankdate },
                    new OracleParameter("BANK_DATE", OracleDbType.Varchar2){ Value=bankdate },
                    new OracleParameter("BANK_DATE", OracleDbType.Varchar2){ Value=bankdate },
                    new OracleParameter("BANK_DATE", OracleDbType.Varchar2){ Value=bankdate },
                    new OracleParameter("BANK_DATE", OracleDbType.Varchar2){ Value=bankdate },
                    new OracleParameter("BANK_DATE", OracleDbType.Varchar2){ Value=bankdate }
                }
            };
            return barsSql;
        }
    }
}
