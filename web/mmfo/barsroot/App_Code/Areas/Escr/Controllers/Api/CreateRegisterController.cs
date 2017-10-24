﻿using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using AttributeRouting.Web.Http;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Text;
using BarsWeb;
using System.Globalization;
using BarsWeb.Areas.Escr.Models;
using BarsWeb.Areas.Escr.Infrastructure.DI.Abstract;
using System.Runtime.Serialization.Json;
using Newtonsoft.Json;
using barsroot.core;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;
using System.Web.Script.Serialization;
using BarsWeb.Core.Logger;

namespace Areas.Escr.Controllers.Api
{
    //[AuthorizeApi]
    public class CreateRegisterController : ApiController
    {
        private readonly IEscrRepository _escrRegister;
        private readonly IDbLogger _dbLogger;
       
        public CreateRegisterController(IEscrRepository escrRegister, IDbLogger dbLogger)
        {
            _escrRegister = escrRegister;
            _dbLogger = dbLogger;
        }
        //public CreateRegisterController(IEscrRepository escrRegister)
        //{
        //    _escrRegister = escrRegister;
        //}
        private void LoginUser(String userName, OracleCommand cmd)
        {
            // информация о текущем пользователе
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "bars.bars_login.login_user";

                cmd.Parameters.Add(new OracleParameter("p_session_id", OracleDbType.Varchar2, HttpContext.Current.Session.SessionID, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_user_id", OracleDbType.Varchar2, userMap.user_id, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_hostname", OracleDbType.Varchar2, String.Empty, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_appname", OracleDbType.Varchar2, "barsroot", System.Data.ParameterDirection.Input));
                cmd.ExecuteNonQuery();
            }
            finally
            {
                
            }
        }
        // POST api/<controller>
        [HttpPost]
        [POST("/api/createregister/create")]
        public HttpResponseMessage Create(List<EscrParam> register)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            MemoryStream stream = new MemoryStream();
            try
            {
                LoginUser("tech_escr", cmd);
                System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(register.GetType());
                var tmp = register.GetType();
                x.Serialize(stream, register);
                stream.Position = 0;
                StreamReader reader = new StreamReader(stream);
                string text = reader.ReadToEnd();
                /*for test
                FileStream fileStream = File.Create("h:\\text" + register[0].register.ID + ".xml", (int)stream.Length);
                byte[] bytesInStream = Encoding.UTF8.GetBytes(text);
                fileStream.Write(bytesInStream, 0, bytesInStream.Length);
                fileStream.Close();
                /*end for test*/
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "bars.pkg_escr_reg_utl.p_received_xml";
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new OracleParameter("in_reg_xml", OracleDbType.Clob, text, System.Data.ParameterDirection.Input));
                cmd.ExecuteNonQuery();
            }
            catch (OracleException oe)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, oe.Message);
            }
            catch (Exception e)
            {
                _dbLogger.Error("ESCR. ERROR create:[ " + e.Message + ": " + e.StackTrace + " ]");
                return Request.CreateResponse(HttpStatusCode.InternalServerError, e.StackTrace);
            }
            finally
            {
                stream.Close();
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            
            return Request.CreateResponse(HttpStatusCode.OK, "Ok");
        }

        [HttpPost]
        [POST("/api/createregister/checkstate")]
        public HttpResponseMessage CheckState(EscrGetStateParam deals)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            List<decimal> errDeals = new List<decimal>();
            try
            {
                LoginUser("tech_escr", cmd);
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select r.credit_status_id, r.credit_comment, r.MONEY_DATE from vw_escr_reg_header r where r.deal_id = :p_deal_id and r.mfo = :p_mfo";
                for (var i = 0; i < deals.deals.deal.Count; i++)
                {
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add(new OracleParameter("p_deal_id", OracleDbType.Decimal, deals.deals.deal[i].deal_id, System.Data.ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("p_mfo", OracleDbType.Decimal, deals.mfo, System.Data.ParameterDirection.Input));
                    OracleDataReader readerDeals = cmd.ExecuteReader();
                    if (readerDeals.Read())
                    {
                        if (!deals.deals.deal[i].is_set)
                        {
                            deals.deals.deal[i].state_id = String.IsNullOrEmpty(readerDeals.GetValue(0).ToString()) ? (int?)null : readerDeals.GetInt32(0);
                            deals.deals.deal[i].comment = String.IsNullOrEmpty(readerDeals.GetValue(1).ToString()) ? String.Empty : readerDeals.GetString(1);
                            deals.deals.deal[i].money_date = String.IsNullOrEmpty(readerDeals.GetValue(2).ToString()) ? (DateTime?)null : readerDeals.GetDateTime(2);
                            if (deals.deals.deal[i].state_id == 5 || deals.deals.deal[i].state_id == 8 || deals.deals.deal[i].state_id == 9)
                            {
                                errDeals.Add(deals.deals.deal[i].deal_id);
                            }
                        }
                        else
                        {
                            var status_code = _escrRegister.GetStatusCode((decimal)deals.deals.deal[i].state_id, cmd);
                            _escrRegister.SetComment(deals.deals.deal[i].deal_id, String.Empty, status_code, 0, 1, cmd);
                        }
                    }
                }
            }
            catch (Exception e)
            {
                _dbLogger.Error("ESCR. ERROR CheckState:[ " + e.Message + ": " + e.StackTrace + " ]");
                return Request.CreateResponse(HttpStatusCode.InternalServerError, e.StackTrace);
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }

            if (errDeals.Count > 0)
            {
                _escrRegister.DelDealRegister(errDeals, cmd);
            }
            //var resp = Request.CreateResponse(HttpStatusCode.OK/*, deals, Encoding.UTF8*);
            //var content = new JavaScriptSerializer().Serialize(deals);
            //resp.Content = new StringContent(content, Encoding.Unicode, "application/json");
            //return resp;
            return Request.CreateResponse(HttpStatusCode.OK, deals);
        }

        [HttpPost]
        [POST("/api/createregister/syncstate")]
        public HttpResponseMessage SyncState(EscrGetStateParam root)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                //LoginUser("absadm", cmd);
                EscrChkStateResult session = _escrRegister.CheckState(root);
                if (session.state == "success")
                {
                    return Request.CreateResponse(HttpStatusCode.OK, session.message);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest, session.message);
                }
            }
            catch (Exception e)
            {
                _dbLogger.Error("ESCR. ERROR syncstate:[ " + e.Message + ": " + e.StackTrace + " ]");
              return Request.CreateResponse(HttpStatusCode.BadRequest, e.Message);

            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }
    }
}