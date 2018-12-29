using System;
using System.Collections.Generic;
using System.Linq;
using Bars.Classes;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Crkr.Infrastructure.Helper;
using BarsWeb.Areas.Crkr.Models;
using Dapper;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Crkr.Infrastructure.DI.Implementation
{
    public class CrkrProfileRepository : MultipleSearch, ICrkrProfileRepository
    {
        private string ConditionBuilder(CrkrBag model)
        {
            var sql = @"select ID, FIO, CLIENTBDATE, DOCTYPE, DOCSERIAL, DOCNUMBER, DOCDATE, 
                               FULLADDRESS, ICOD, BRANCH, IDA, REGISTRYDATE, OB22,
                               NSC, OST, KV, KV_SHORT, DATO, STATUS, STATE_ID, ACTUAL_STATE
                        from v_crca_portfolio where";

            string condition = "";

            if (!model.load)
            {
                if (!string.IsNullOrEmpty(model.icod))
                    condition = condition.Insert(condition.Length, " icod = '" + model.icod + "'");

                if (!string.IsNullOrEmpty(model.doctype) && !string.IsNullOrEmpty(model.docserial) && !string.IsNullOrEmpty(model.docnumber))
                    condition = condition.Insert(condition.Length, " and dbcode = crkr_compen_web.f_dbcode('" + model.doctype + "', '" + model.docserial + "', '" + model.docnumber + "')");

                if (!string.IsNullOrEmpty(model.fio))
                {
                    condition = condition.Insert(condition.Length, " and (l_fio like lower('" + model.fio + "%'))");
                }

                if (!string.IsNullOrEmpty(model.branch))
                    condition = condition.Insert(condition.Length, " and ( branch like '" + model.branch + "%')");

                if (!string.IsNullOrEmpty(model.nsc))
                    condition = condition.Insert(condition.Length, " and (nsc = '" + model.nsc + "')");

                if (!string.IsNullOrEmpty(model.ob22))
                    condition = condition.Insert(condition.Length, " and (ob22 = '" + model.ob22 + "')");

                if (!string.IsNullOrEmpty(model.clientbdate) && model.clientbdate.Length == 4)
                    condition = condition.Insert(condition.Length, " and (extract(year from clientbdate) = '" + model.clientbdate + "')");

                if (!string.IsNullOrEmpty(model.clientbdate) && model.clientbdate.Length > 4)
                    condition = condition.Insert(condition.Length, " and (trunc(clientbdate) = to_date('" + model.clientbdate + "', 'DD.MM.YYYY'))"); //where clientbdate = to_date('01.01.1970', 'DD.MM.YYYY');

                sql = sql.Insert(sql.Length, condition);
            }
            else
            {
                sql = sql.Insert(sql.Length, " rownum < 201");
            }
            if (!string.IsNullOrEmpty(model.doctype) && !string.IsNullOrEmpty(model.docserial) && !string.IsNullOrEmpty(model.docnumber))
            {
                sql = sql.Insert(sql.Length, @"UNION select ID, FIO, CLIENTBDATE, DOCTYPE, DOCSERIAL, DOCNUMBER, DOCDATE, 
                                               FULLADDRESS, ICOD, BRANCH, IDA, REGISTRYDATE, OB22,
                                               NSC, OST, KV, KV_SHORT, DATO, STATUS, STATE_ID, ACTUAL_STATE
                                               from v_crca_portfolio where ID in (select COMPEN_ID from compen_portfolio_dbcode_old where" + condition + ")");

            }
            sql = sql.Replace("where and ", "where ");

            //if user press "search" without parameters
            var lastPart = sql.Split(' ').Last();
            
            if (lastPart == "where")
                sql = sql.Insert(sql.Length, " rownum < 201");

            if (sql.Contains("extract"))
                sql = sql.Insert(sql.Length, " and rownum < 201");

            return sql;

        }

        public List<CrcaProfile> GetProfiles(CrkrBag model, [DataSourceRequest] DataSourceRequest request)
        {
            //check what input param
            if (!String.IsNullOrEmpty (model.fio) && model.fio.Trim(new char[]{' '}) == "%")
                throw new Exception("Неможливо здійснити пошук лише для %. Введіть ПІБ вкладу або частину данних з % чи _ символами.");
            if (!string.IsNullOrEmpty(model.branch) && model.branch[0].ToString() != "/")
                model.branch = "/" + model.branch;
            if (!string.IsNullOrEmpty(model.fio) && model.fio.Contains("'"))
                model.fio = model.fio.Replace("\'", "\'\'");


            List<CrcaProfile> profiles = null;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                profiles = connection.Query<CrcaProfile>(ConditionBuilder(model)).ToList();
            }
            return profiles;
        }

        private string BuildSqlQueryForClients(ClientSearch model)
        {
            var sql = @"select * from v_customer_crkr where";

            if (!string.IsNullOrEmpty(model.icod))
                sql = sql.Insert(sql.Length, " and inn = '" + model.icod + "'");

            if (!string.IsNullOrEmpty(model.docserial))
                sql = sql.Insert(sql.Length, " and ser = '" + model.docserial + "'");

            if (!string.IsNullOrEmpty(model.docnumber))

                sql = sql.Insert(sql.Length, " and numdoc = '" + model.docnumber + "'");

            if (!string.IsNullOrEmpty(model.doctype))
                sql = sql.Insert(sql.Length, " and id_doc_type = '" + model.doctype + "'");

            if (!string.IsNullOrEmpty(model.fio))
                sql = sql.Insert(sql.Length, " and (name like '" + model.fio + "%')");

            if (!string.IsNullOrEmpty(model.eddrid))
                sql = sql.Insert(sql.Length, " and eddr_id = '" + model.eddrid + "'");

            if (!string.IsNullOrEmpty(model.rnk))
                sql = sql.Insert(sql.Length, " and (rnk = '" + model.rnk + "')");


            sql = sql.Replace("where and ", "where ");

            //if user press "search" without parameters
            var lastPart = sql.Split(' ').Last();
            if (lastPart == "where")
                sql = sql.Insert(sql.Length, " rownum < 201");
            return sql;
        }

        public List<object> GetClients(ClientSearch model)
        {
            List<object> clients = null;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                clients = connection.Query(BuildSqlQueryForClients(model)).ToList();
            }
            return clients;
        }
    }
}
