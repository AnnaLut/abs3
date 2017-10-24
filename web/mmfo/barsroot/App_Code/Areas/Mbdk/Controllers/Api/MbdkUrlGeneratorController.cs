using System;
using System.Data;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using Bars.Classes;
using BarsWeb.Areas.Mbdk.Models;
using Dapper;
using System.Globalization;

namespace BarsWeb.Areas.Mbdk.Controllers.Api
{

    /// <summary>
    /// Summary description for MbdkUrlGeneratorController
    /// </summary>
    /// 
    public class Data
    {
        public int id { get; set; }
        public string date { get; set; }
        public decimal sum { get; set; }
        public string text { get; set; }

    }
    public class MbdkUrlGeneratorController : ApiController
    {
        [HttpPost]
        [POST("/api/mbdk/MbdkUrlGenerator/GetGeneneratedUrl")]
        public HttpResponseMessage GetGeneneratedUrl(Data item)
        {
            System.Threading.Thread.CurrentThread.CurrentCulture = new CultureInfo("en-CA");
            var sdate = DateTime.ParseExact(item.date, "dd.MM.yyyy", CultureInfo.InvariantCulture);
            try
            {
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var sql = @"mbk.make_kv1";
                    var p = new DynamicParameters();
                    p.Add("p_url", dbType: DbType.String, size:4000, direction: ParameterDirection.ReturnValue);

                    p.Add("p_deal_id ", dbType: DbType.Decimal, value: item.id, direction: ParameterDirection.Input);
                    p.Add("p_value_date", dbType: DbType.Date, value: sdate, direction: ParameterDirection.Input);
                    p.Add("p_amount", dbType: DbType.Decimal, value: item.sum, direction: ParameterDirection.Input);
                    p.Add("p_purpose", dbType: DbType.String, value: item.text, direction: ParameterDirection.Input);

                    connection.Execute(sql, p, commandType: CommandType.StoredProcedure);

                    var res = p.Get<string>("p_url");

                    return Request.CreateResponse(HttpStatusCode.OK, res);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
            return null;
        }
    }
}