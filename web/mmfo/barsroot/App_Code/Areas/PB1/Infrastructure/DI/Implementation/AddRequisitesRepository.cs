using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using BarsWeb.Areas.PB1.Models;
using BarsWeb.Areas.PB1.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using Bars.Classes;
using Dapper;
using System.Data;
using System.IO;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.PB1.Infrastructure.Repository.DI.Implementation
{
    public class AddRequisitesRepository : IAddRequisitesRepository
    {
        public AddRequisitesRepository()
        {
        }

        public string GetBankDate()
        {
            string sql_query = @"select gl.bd from dual";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<string>(sql_query).FirstOrDefault();
            }
        }

        public List<RequisitesGrid> GetGridData(string dc, string date)
        {
            List<RequisitesGrid> list = new List<RequisitesGrid>();
            string sql_query = @"SELECT aa.NLS as NLS, aa.KV as KV, DECODE(aa.DK,1,'D','C') as DC, Substr(TO_CHAR(aa.S/ POWER(10,tv.DIG),'999,999,999,990'||rpad('.',1+tv.DIG,'9')),1,20) as S,
                                        o.nd as ND,o.tt as TT, t.name as STT, o.ref as REF, 0 as REC, o.kv as KVA,o.kv2 as KVB, o.dk as DK,
                                        o.nlsa as NLSA,o.nam_a as NAMA,o.nlsb as NLSB,o.nam_b as NAMB,o.nazn as NAZN
                                 FROM oper o, tts t, tabval tv,
                                (select p.ref REF, a.nls NLS, a.kv KV, p.dk DK, p.s S
                                 from accounts a, opldok p
                                 where a.acc=p.acc and 
                                       p.sos=5     and 
                                       p.fdat= to_date(:pdate, 'dd.mm.yyyy')  and 
                                       p.s>0   and
                                       (a.nbs in ('1001','1002','1003','1007') and a.kv<>980 OR 
                                        a.nbs in ('1500','1505','1600','1605') and a.acc in 
                                          (select cu.acc 
                                           from cust_acc cu,customer c 
                                           where cu.rnk=c.rnk and c.CODCAGENT=2))
                                 group by p.ref, a.nls, a.kv, p.dk,p.s) aa 
                                 WHERE o.ref = aa.REF and t.tt=o.tt and tv.kv = aa.Kv ";

            string sql_add_query = " and DECODE(aa.DK,1,'D','C') = ";

            if (dc != "DC")
                sql_query += sql_add_query + "'" + dc + "'";

            sql_query += " ORDER BY 1,2,3,4";

            var p = new DynamicParameters();
            p.Add("pdate", dbType: DbType.String, size: 100, value: date, direction: ParameterDirection.Input);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                list = connection.Query<RequisitesGrid>(sql_query, p).ToList();
                list = GetFetchRowData(connection, list, date);
            }
            return list;
        }

        public List<RequisitesGrid> GetFetchRowData(OracleConnection connection, List<RequisitesGrid> list, string bdate)
        {
            FetchRowModel model = new FetchRowModel();
            string sql_query = String.Empty;
            var p = new DynamicParameters();

            for (int i = 0; i < list.Count; i++)
            {
                sql_query = @"SELECT gl.p_icurval(:KV,:SUM,to_date(:BDATE, 'dd/mm/yyyy')) as SQ, Substr(a.NBS,1,2) as NBSK
                                FROM accounts a, opldok o, TABVAL t
                                WHERE  t.kv = a.Kv and o.ref=:REF and o.ref not in (select ref
                                                                                        from operw
                                                                                        where ref>= o.ref and tag = 'NOS_R') and
                                          o.dk = DECODE(:DC, 'D', 0, 1) and o.acc = a.acc and rownum = 1
                                UNION ALL
                                    SELECT gl.p_icurval(:KV,:SUM,to_date(:BDATE, 'dd/mm/yyyy')), Substr(a.NBS, 1, 2)
                                      FROM   accounts a, opldok o, TABVAL t
                                      WHERE  t.kv = a.Kv and o.ref in (select to_number(trim(value))
                                                                    from operw
                                                                    where  ref=:REF and tag = 'NOS_R') and o.dk = DECODE(:DC, 'D', 0, 1) and o.acc = a.acc and
                                                                                                    rownum = 1";

                p = new DynamicParameters();
                p.Add("SUM", dbType: DbType.Decimal, value: list[i].SUM, direction: ParameterDirection.Input);
                p.Add("KV", dbType: DbType.Decimal, value: list[i].KV, direction: ParameterDirection.Input);
                p.Add("BDATE", dbType: DbType.String, size: 100, value: bdate, direction: ParameterDirection.Input);
                p.Add("DC", dbType: DbType.String, size: 100, value: list[i].DC, direction: ParameterDirection.Input);
                p.Add("REF", dbType: DbType.String, size: 100, value: list[i].REF, direction: ParameterDirection.Input);

                model = connection.Query<FetchRowModel>(sql_query, p).FirstOrDefault();

                if (model != null)
                {
                    list[i].SQ = model.SQ;
                    list[i].NBSK = model.NBSK;
                }

                sql_query = @"SELECT w.value as KOD_B, decode(w.value, '999', '999/інше', b.knb) as TEX_B
                           FROM   operw w, rcukru b 
                           WHERE  w.ref=:REF AND w.tag='KOD_B' AND ltrim(rtrim(w.value))=ltrim(rtrim(b.glb(+)))";

                p = new DynamicParameters();
                p.Add("REF", dbType: DbType.String, size: 100, value: list[i].REF, direction: ParameterDirection.Input);

                model = connection.Query<FetchRowModel>(sql_query, p).FirstOrDefault();

                if (model != null)
                {
                    list[i].KOD_B = model.KOD_B;
                    list[i].TEX_B = model.TEX_B;
                }

                sql_query = @"SELECT lpad(w.value,3,'0') as KOD_G, b.txt as TEX_G
                           FROM   operw w, kl_k040 b
                           WHERE  w.ref=:REF AND w.tag='KOD_G' AND lpad(w.value,3,'0')=b.K040";

                p = new DynamicParameters();
                p.Add("REF", dbType: DbType.String, size: 100, value: list[i].REF, direction: ParameterDirection.Input);

                model = connection.Query<FetchRowModel>(sql_query, p).FirstOrDefault();

                if (model == null)
                {
                    sql_query = @"SELECT b.K040 as KOD_G, b.txt as TEX_G
                               FROM   operw w, kl_k040 b
                               WHERE  w.ref=:REF AND w.tag='KOD_G' AND w.value=b.KOD_LIT";
                    model = connection.Query<FetchRowModel>(sql_query, p).FirstOrDefault();
                }

                if (model != null)
                {
                    list[i].KOD_G = model.KOD_G;
                    list[i].TEX_G = model.TEX_G;
                }

                sql_query = @"SELECT w.value as KOD_N, b.transdesc as TEX_N, b.KIND as DC1
                           FROM   operw w, bopcode b
                           WHERE  w.ref=:REF AND w.tag='KOD_N' AND ltrim(rtrim(w.value))=ltrim(rtrim(b.transcode(+)))";

                p = new DynamicParameters();
                p.Add("REF", dbType: DbType.String, size: 100, value: list[i].REF, direction: ParameterDirection.Input);

                model = connection.Query<FetchRowModel>(sql_query, p).FirstOrDefault();

                if (model != null)
                {
                    list[i].KOD_N = model.KOD_N;
                    list[i].TEX_N = model.TEX_N;
                    list[i].DC1 = model.DC1;
                }
            }
            return list;
        }

        public object GetParams(string date)
        {
            string sql_query = @"SELECT nvl((SELECT val FROM params WHERE par='NBUBANK' and val='1'), 0) as NBU,
                                        gl.p_icurval(840,5000000, to_date(:pDATE, 'dd.mm.yyyy')) as Porog
                                 FROM dual";

            var p = new DynamicParameters();
            p.Add("pDATE", dbType: DbType.String, size: 100, value: date, direction: ParameterDirection.Input);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<object>(sql_query, p).FirstOrDefault();
            }
        }

        public List<object> GetText(string name)
        {
            string sql_query = String.Empty;

            if (name == "TEX_N")
                sql_query = @"SELECT transcode as VALUE, transcode||'/'||transdesc as TEXT
                               FROM   bopcode
                               ORDER by transcode";
            else if (name == "TEX_G")
                sql_query = @"SELECT K040 as VALUE, K040||'/'||txt as TEXT
                               FROM   kl_k040
                               ORDER by txt";
            else if (name == "TEX_B")
                sql_query = @"SELECT glb as VALUE, glb||'/'||knb as TEXT
                                   FROM   rcukru
                                   WHERE  glb>0
                                   union all
                                   select 999 as VALUE, '999/інше' as TEXT
                                   from   dual
                                   ORDER by 2";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<object>(sql_query).ToList();
            }
        }

        public void SaveData(List<RequisitesGrid> data)
        {
            string sql_query = String.Empty;
            var p = new DynamicParameters();
            using (var connection = OraConnector.Handler.UserConnection)
            {
                for (int i = 0; i < data.Count; i++)
                {
                    string error = String.Empty;
                    sql_query = @"F_FILL_OPERW_1PB";

                    p = new DynamicParameters();
                    p.Add("p_ref", dbType: DbType.Decimal, value: data[i].REF, direction: ParameterDirection.Input);
                    p.Add("p_typ", dbType: DbType.Int16, value: 1, direction: ParameterDirection.Input);
                    p.Add("p_val", dbType: DbType.String, size: 100, value: data[i].KOD_B, direction: ParameterDirection.Input);
                    p.Add("o_err_mes", dbType: DbType.String, size: 4000, direction: ParameterDirection.Output);
                    p.Add("number", dbType: DbType.String, size: 4000, direction: ParameterDirection.ReturnValue);

                    connection.Execute(sql_query, p, commandType: System.Data.CommandType.StoredProcedure);

                    error = p.Get<String>("o_err_mes");

                    if (!string.IsNullOrEmpty(error))
                        throw new Exception(error);

                    p = new DynamicParameters();
                    p.Add("p_ref", dbType: DbType.Decimal, value: data[i].REF, direction: ParameterDirection.Input);
                    p.Add("p_typ", dbType: DbType.Int16, value: 2, direction: ParameterDirection.Input);
                    p.Add("p_val", dbType: DbType.String, size: 100, value: data[i].KOD_N, direction: ParameterDirection.Input);
                    p.Add("o_err_mes", dbType: DbType.String, size: 4000, direction: ParameterDirection.Output);
                    p.Add("number", dbType: DbType.String, size: 4000, direction: ParameterDirection.ReturnValue);

                    connection.Execute(sql_query, p, commandType: System.Data.CommandType.StoredProcedure);

                    error = p.Get<String>("o_err_mes");

                    if (!string.IsNullOrEmpty(error))
                        throw new Exception(error);

                    p = new DynamicParameters();
                    p.Add("p_ref", dbType: DbType.Decimal, value: data[i].REF, direction: ParameterDirection.Input);
                    p.Add("p_typ", dbType: DbType.Int16, value: 3, direction: ParameterDirection.Input);
                    p.Add("p_val", dbType: DbType.String, size: 100, value: data[i].KOD_G, direction: ParameterDirection.Input);
                    p.Add("o_err_mes", dbType: DbType.String, size: 4000, direction: ParameterDirection.Output);
                    p.Add("number", dbType: DbType.String, size: 4000, direction: ParameterDirection.ReturnValue);

                    connection.Execute(sql_query, p, commandType: System.Data.CommandType.StoredProcedure);

                    error = p.Get<String>("o_err_mes");

                    if (!string.IsNullOrEmpty(error))
                        throw new Exception(error);
                }
            }
        }

        public string CheckIfExist(string sql, DynamicParameters p)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<string>(sql, p).FirstOrDefault();
            }
        }

        public List<LoroBank> GetLoroBanks()
        {
            List<LoroBank> list = new List<LoroBank>();
            string sql_query = @"SELECT asp_loro.OKPO as OKPO, asp_loro.NAME as NAME, asp_loro.STAT as STATUS, asp_loro.MFO as MFO, b.nb as NB, asp_loro.rowid as IDROW
                                 FROM  asp_loro, banks b
                                 WHERE asp_loro.mfo=b.mfo (+) 
                                 ORDER BY asp_loro.MFO, asp_loro.NAME";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                list = connection.Query<LoroBank>(sql_query).ToList();
            }

            return list;
        }

        public LoroBank GetLoroParams(decimal refer)
        {
            string sql_query = @"SELECT min(decode(tag,'ASP_N',value,NULL)) as NAME, 
                                          min(decode(tag,'ASP_K',value,NULL)) as OKPO,
                                          min(decode(tag,'ASP_S',value,NULL)) as STATUS
                                 FROM operw WHERE ref=:REF";

            var p = new DynamicParameters();
            p.Add("REF", dbType: DbType.Decimal, value: refer, direction: ParameterDirection.Input);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<LoroBank>(sql_query, p).FirstOrDefault();
            }
        }

        public void SaveLoroData(List<LoroBank> data)
        {
            string sql_query = @String.Empty;
            var p = new DynamicParameters();
            using (var connection = OraConnector.Handler.UserConnection)
            {
                foreach (var element in data)
                {
                    if (string.IsNullOrEmpty(element.IDROW))
                        sql_query = @"INSERT INTO asp_loro (OKPO,NAME,STAT,MFO) values (:OKPO, :NAME, :STAT, :MFO)";
                    else
                        sql_query = @"UPDATE asp_loro SET NAME=:NAME, STAT= :STAT, MFO=:MFO 
                                    WHERE OKPO=:OKPO";

                    p = new DynamicParameters();
                    p.Add("OKPO", dbType: DbType.String, value: element.OKPO, direction: ParameterDirection.Input);
                    p.Add("NAME", dbType: DbType.String, value: element.NAME, direction: ParameterDirection.Input);
                    p.Add("STAT", dbType: DbType.String, value: element.STATUS, direction: ParameterDirection.Input);
                    p.Add("MFO", dbType: DbType.String, value: element.MFO, direction: ParameterDirection.Input);

                    connection.Execute(sql_query, p);
                }
            }
        }

        public void DeleteLoroData(string okpo)
        {
            string sql_query = @"DELETE FROM asp_loro WHERE OKPO=:OKPO";

            var p = new DynamicParameters();
            p.Add("OKPO", dbType: DbType.String, value: okpo, direction: ParameterDirection.Input);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql_query, p);
            }
        }

        public string V_OKPO(string okpo)
        {
            string okp = String.Empty;
            string sql_query = @"SELECT V_OKPO(:OKPO) FROM dual";
            var p = new DynamicParameters();
            p.Add("OKPO", dbType: DbType.String, value: okpo, direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                okp = connection.Query<string>(sql_query, p).FirstOrDefault();
            }
            return okp;
        }


        public void OK(LoroBank data, decimal refer)
        {
            string sql_query = String.Empty;
            var p = new DynamicParameters();

            using (var connection = OraConnector.Handler.UserConnection)
            {
                sql_query = @"DELETE FROM OPERW where ref=:REF and tag in ('ASP_N','ASP_K','ASP_S')";
                p.Add("REF", dbType: DbType.String, value: refer, direction: ParameterDirection.Input);

                connection.Execute(sql_query, p);

                sql_query = @"INSERT INTO OPERW (REF, TAG, VALUE) values(:REF,'ASP_N',:NAME ) ";

                p = new DynamicParameters();
                p.Add("REF", dbType: DbType.Decimal, value: refer, direction: ParameterDirection.Input);
                p.Add("NAME", dbType: DbType.String, value: data.NAME, direction: ParameterDirection.Input);

                connection.Execute(sql_query, p);


                sql_query = @"INSERT INTO OPERW (REF, TAG, VALUE) values(:REF,'ASP_K',:OKPO ) ";

                p = new DynamicParameters();
                p.Add("REF", dbType: DbType.Decimal, value: refer, direction: ParameterDirection.Input);
                p.Add("OKPO", dbType: DbType.String, value: data.OKPO, direction: ParameterDirection.Input);

                connection.Execute(sql_query, p);


                sql_query = @"INSERT INTO OPERW (REF, TAG, VALUE) values(:REF,'ASP_S',:STAT ) ";

                p = new DynamicParameters();
                p.Add("REF", dbType: DbType.Decimal, value: refer, direction: ParameterDirection.Input);
                p.Add("STAT", dbType: DbType.String, value: data.STATUS, direction: ParameterDirection.Input);

                connection.Execute(sql_query, p);
            }
        }
    }
}