using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Bars.Classes;
using BarsWeb.Areas.Crkr.Models;
using Dapper;
using BarsWeb.Areas.Crkr.Infrastructure.Helper;
using System.Collections.Generic;
using System.Dynamic;

namespace BarsWeb.Areas.Crkr.Controllers.Api
{
    /// <summary>
    /// Return the list of user accounts in ABS BARS
    /// for bind to CRKR user
    /// </summary>
    [AuthorizeApi]
    public class GetAccountController : ApiController
    {

        private void AddProperty(ExpandoObject expando, string propertyName, object propertyValue)
        {
            var expandoDict = expando as IDictionary<string, object>;
            if (expandoDict.ContainsKey(propertyName))
            {
                expandoDict[propertyName] = propertyValue;
            }
            else
            {
                expandoDict.Add(propertyName, propertyValue);
            }
        }
        public object GetParamsFromModel<T>(T t)
        {
            dynamic dynamParams = new ExpandoObject();
            foreach (var property in t.GetType().GetProperties())
            {
                var propVal = property.GetValue(t, null);
                if (propVal != null && property.Name != "mfo" && property.Name != "doctype")
                {
                    AddProperty(dynamParams, property.Name, propVal);
                }
            }

            if (((IDictionary<string, object>)dynamParams).Any())
            {
                return (object)dynamParams;
            }
            return null;
        }

        private string BuildSqlQuery(AccountInfo info)
        {
            string query = @"select a.nls,
                                    replace(rpad(a.nls,15,' '),' ', '  ') ||' ' || c.nmk NMS
                                from accounts a, 
                                     customer c, 
                                     person p
                                where a.rnk=c.rnk and 
                                      c.rnk=p.rnk and
                                      a.KV = 980 and 
                                      (a.nls like '2625%' or (a.nls like '2620%' and a.tip like 'W4%')) and
                                      a.tip like 'W%' and
                                      a.dazs is null and";

            if (!string.IsNullOrEmpty(info.icod))
            {
                //query = query.Insert(query.Length, " ((c.okpo like '000000000%' or c.okpo like '99999999%' or okpo is null) or");
                query = query.Insert(query.Length, "((c.okpo = :icod) or");

            }
            //else
            //{
            //    query = query.Insert(query.Length, "(c.okpo = :icod or");
            //}

            if (info.doctype == "7")
            {
                if (!string.IsNullOrEmpty(info.eddr_id))
                    query = query.Insert(query.Length, " (p.eddr_id = :eddr_id and p.numdoc = :numdoc)");
            }
            else
            {
                if (!string.IsNullOrEmpty(info.ser))
                    query = query.Insert(query.Length, " (p.ser = :ser and p.numdoc = :numdoc)");
            }
            if (!string.IsNullOrEmpty(info.icod))
            {
                query = query.Insert(query.Length, ")");
            }

            return query;
        }

        [HttpPost]
        public HttpResponseMessage Get(AccountInfo info)
        {
            var connection = OraConnector.Handler.UserConnection;
            try
            {
                var accountList = connection.Query(BuildSqlQuery(info), GetParamsFromModel(info)).ToList();
                return Request.CreateResponse(HttpStatusCode.OK, accountList);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }
        }
    }
}
