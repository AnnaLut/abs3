using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Collections.Generic;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.WayKlb.Infrastructure.DI.Abstract;
using BarsWeb.Areas.WayKlb.Infrastructure.DI.Implementation;
using BarsWeb.Areas.WayKlb.Models;
using Newtonsoft.Json.Linq;
using Oracle.DataAccess.Client;
using Bars.Classes;
using System.Data;
using System.Web;
using barsroot.core;
using Bars.WebServices;

namespace BarsWeb.Areas.WayKlb.Controllers.Api
{
    public class IntgKlbController : ApiController
    {
        private readonly IIntgKlbRepository _repo;

        public IntgKlbController()
        {
            _repo = new IntgKlbRepository();
        }


        private Dictionary<string, string> IdToMfo;
        public string MapIdToMfo(OracleConnection con, string absId)
        {
            if (IdToMfo == null)
                IdToMfo = new Dictionary<string, string>();

            if (IdToMfo.Count == 0)
            {
                OracleCommand command = con.CreateCommand();
                command.CommandText = "select appcode, mfo from BARS.MWAY_MAPPING_BRANCH";
                using (OracleDataReader reader = command.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        int _absId = reader.GetOrdinal("appcode");
                        int _mfo = reader.GetOrdinal("mfo");

                        while (reader.Read())
                        {
                            IdToMfo[reader.GetString(_absId)] = reader.GetString(_mfo);
                        }
                    }
                }
            }

            if (IdToMfo.ContainsKey(absId))
                return IdToMfo[absId];

            return "300465";
        }


        [HttpGet]
        [GET("/api/WayKlb/IntgKlb/deposits")]
        public HttpResponseMessage deposits(string abs_id, decimal? id)
        {
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                string mfo = MapIdToMfo(connection, abs_id);
                LoginUserIntSingleCon(connection, "TECH_BPK", mfo, true);

                List<Product> product = new List<Product>();
                product = _repo.GetProductList(connection, id);

                if (product.Count > 1)
                {
                    JArray arrJson = new JArray();
                    for (var i = 0; i < product.Count; i++)
                    {
                        JObject json = JObject.Parse(product[i].JSON);
                        arrJson.Add(json);
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, arrJson);
                }
                else if (product.Count == 1)
                {
                    JObject json = JObject.Parse(product[0].JSON);
                    return Request.CreateResponse(HttpStatusCode.OK, json);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound);
                }
            }
        }

        #region new login and bc.go, using single connection
        private void LoginUserIntSingleCon(OracleConnection con, string userName, string mfo, bool bcGo = true)
        {
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);
            string ipAddress = RequestHelpers.GetClientIpAddress(HttpContext.Current.Request);

            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.Connection = con;
                cmd.CommandText = "bars.bars_login.login_user";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new OracleParameter("p_session_id", OracleDbType.Varchar2, HttpContext.Current.Session.SessionID, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_user_id", OracleDbType.Varchar2, userMap.user_id, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_hostname", OracleDbType.Varchar2, ipAddress, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_appname", OracleDbType.Varchar2, "barsroot", ParameterDirection.Input));
                cmd.ExecuteNonQuery();

                if (bcGo)
                    ExecBcGo(con, mfo);

                WriteMsgToAudit(con, string.Format("INTG_WB integration: авторизація. хост {0}, користувач {1} ", ipAddress, userName));
            }
        }

        private void ExecBcGo(OracleConnection con, string branch)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "bc.go";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new OracleParameter("p_branch", OracleDbType.Varchar2, branch, ParameterDirection.Input));
                cmd.ExecuteNonQuery();
            }
        }

        private void WriteMsgToAudit(OracleConnection con, string msg)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "bars_audit.info";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new OracleParameter("p_info", OracleDbType.Varchar2, msg, ParameterDirection.Input));
                cmd.ExecuteNonQuery();
            }
        }
        #endregion

    }
}