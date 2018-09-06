using System;
using System.Data;
using System.Linq;
using System.Text;
using System.Net;
using System.Net.Http;
using System.Collections.Generic;
using System.IO;
using System.Runtime.Serialization.Json;
using BarsWeb.Areas.InsUi.Infrastructure;
using BarsWeb.Areas.InsUi.Infrastructure.DI.Abstract;
using BarsWeb.Areas.InsUi.Models;
using Areas.InsUi.Models;

using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

using Oracle.DataAccess.Client;
using Bars.Classes;
using BarsWeb.Areas.InsUi.Models.Transport;
using System.Xml;

namespace BarsWeb.Areas.InsUi.Infrastructure.DI.Implementation
{
    public class InsRepository : IInsRepository
    {
        readonly InsuranceEntities _entities;
        public InsRepository(IInsModel model)
        {
            _entities = model.InsuranceEntities;
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3 | SecurityProtocolType.Tls | (SecurityProtocolType)768 | (SecurityProtocolType)3072;
        }

        public IQueryable<INS_PARAMS_INTG> GetParams()
        {
            return _entities.INS_PARAMS_INTG.OrderByDescending(i => i.ID);
        }

        public IQueryable<INS_PARAMS_INTG> GetParamMfo(string kf)
        {
            return _entities.INS_PARAMS_INTG.Where(i => i.KF == kf);
        }

        public int CheckUrlApi(string url)
        {
            if (_entities.INS_PARAMS_INTG.Where(i => i.URLAPI == url).Count() > 0)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }

        public void CreateSyncParams(CreateParams param)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            var isActive = param.IS_ACTIVE ? "1" : "0";
            var status = "SUCCESS";
            var statusMsg = String.Empty;
            var id = String.Empty;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select bars.s_ins_params_intg_id.nextval as id from dual";

                OracleDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    if (rdr.Read())
                    {
                        id = rdr["id"] == DBNull.Value ? String.Empty : rdr["id"].ToString();
                    }
                }
            }
            finally
            {
                connection.Dispose();
                connection.Close();
            }
            param.ID = Convert.ToDecimal(id);
            param.STATUS = status;
            param.STATUS_MESSAGE = statusMsg;
            INS_PARAMS_INTG newObj = new INS_PARAMS_INTG();
            newObj.ID = (decimal)param.ID;
            newObj.KF = param.KF;
            newObj.NB = param.NB;
            newObj.URLAPI = param.URLAPI;
            newObj.USERNAME = param.USERNAME;
            newObj.HPASSWORD = param.HPASSWORD;
            newObj.IS_ACTIVE = Convert.ToDecimal(isActive);
            newObj.STATUS = param.STATUS;
            newObj.STATUS_MESSAGE = param.STATUS_MESSAGE;
            _entities.INS_PARAMS_INTG.AddObject(newObj);
            _entities.SaveChanges();
        }

        public void UpdateSyncParams(CreateParams param)
        {
            var rowToUpdate = _entities.INS_PARAMS_INTG.FirstOrDefault(i => i.ID == param.ID);
            if (rowToUpdate != null)
            {
                rowToUpdate.KF = param.KF;
                rowToUpdate.NB = param.NB;
                rowToUpdate.URLAPI = param.URLAPI;
                rowToUpdate.USERNAME = param.USERNAME;
                rowToUpdate.IS_ACTIVE = param.IS_ACTIVE ? 1 : 0;
                _entities.SaveChanges();
            }
        }

        public void DeleteSyncParams(CreateParams param)
        {
            var rowToDelete = _entities.INS_PARAMS_INTG.FirstOrDefault(i => i.ID == param.ID);
            if (rowToDelete != null)
            {
                _entities.INS_PARAMS_INTG.DeleteObject(rowToDelete);
                _entities.SaveChanges();
            }
        }

        public IEnumerable<CardInsurance> GetCardsInsur(SearchModel par)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"select dw.nd, -- Номер договору 0
                                          dw.branch, -- Відділення 1
                                          dw.acc_nls, -- Картковій рахунок 2
                                          dw.acc_lcv, -- Валюта 3
                                          dw.acc_ob22, -- ОБ22 4
                                          dw.acc_tipname, -- Субпродукт 5
                                          dw.card_code, -- Тип карти 6
                                          dw.card_idat, -- Дата видачі карти 7
                                          dw.acc_ost, -- Залишок 8
                                          dw.cust_rnk, -- РНК 9
                                          dw.cust_okpo, -- ЗКПО 10
                                          dw.cust_name, -- ПІБ 11
                                          dw.acc_daos, -- Дата відкриття 12
                                          dw.acc_dazs, -- Дата закриття 13
                                          wd.state, -- Статус 14
                                          wd.err_msg, -- 15
                                          wd.ins_ext_id, -- 16
                                          wd.ins_ext_tmp, -- 17
                                          wd.deal_id, -- 18
                                          wd.date_from, -- 19
                                          wd.date_to -- 20
                                     from W4_DEAL_WEB dw,
                                          ins_w4_deals wd
                                    where dw.nd = wd.nd";
                /*if (!String.IsNullOrEmpty(par.dateFrom) && par.dateFrom != "null")
                {
                    cmd.CommandText += " and wd.date_from = to_date('" + par.dateFrom + "','dd.mm.yyyy')";
                }*/
                if (!String.IsNullOrEmpty(par.inn) && par.inn != "null")
                {
                    cmd.CommandText += " and dw.cust_okpo like '" + par.inn + "%'";
                }
                if (!String.IsNullOrEmpty(par.account) && par.account != "null")
                {
                    cmd.CommandText += " and dw.acc_nls like '" + par.account + "%'";
                }
                if (!String.IsNullOrEmpty(par.fio) && par.fio != "null")
                {
                    cmd.CommandText += " and upper(dw.cust_name) like upper('" + par.fio + "%')";
                }
                cmd.CommandText += " order by dw.nd desc";

                OracleDataReader reader = cmd.ExecuteReader();
                List<CardInsurance> card = new List<CardInsurance>();
                while (reader.Read())
                {
                    CardInsurance c = new CardInsurance();
                    c.ND = String.IsNullOrEmpty(reader.GetValue(0).ToString()) ? (decimal?)null : reader.GetDecimal(0);
                    c.BRANCH = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : reader.GetString(1);
                    c.ACC_NLS = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? String.Empty : reader.GetString(2);
                    c.ACC_LCV = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? String.Empty : reader.GetString(3);
                    c.ACC_OB22 = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? String.Empty : reader.GetString(4);
                    c.ACC_TIPNAME = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? String.Empty : reader.GetString(5);
                    c.CARD_CODE = String.IsNullOrEmpty(reader.GetValue(6).ToString()) ? String.Empty : reader.GetString(6);
                    c.CARD_IDAT = String.IsNullOrEmpty(reader.GetValue(7).ToString()) ? (DateTime?)null : reader.GetDateTime(7);
                    c.ACC_OST = String.IsNullOrEmpty(reader.GetValue(8).ToString()) ? (decimal?)null : reader.GetDecimal(8);
                    c.CUST_RNK = String.IsNullOrEmpty(reader.GetValue(9).ToString()) ? (decimal?)null : reader.GetDecimal(9);
                    c.CUST_OKPO = String.IsNullOrEmpty(reader.GetValue(10).ToString()) ? String.Empty : reader.GetString(10);
                    c.CUST_NAME = String.IsNullOrEmpty(reader.GetValue(11).ToString()) ? String.Empty : reader.GetString(11);
                    c.ACC_DAOS = String.IsNullOrEmpty(reader.GetValue(12).ToString()) ? (DateTime?)null : reader.GetDateTime(12);
                    c.ACC_DAZS = String.IsNullOrEmpty(reader.GetValue(13).ToString()) ? (DateTime?)null : reader.GetDateTime(13);
                    c.STATE = String.IsNullOrEmpty(reader.GetValue(14).ToString()) ? String.Empty : reader.GetString(14);
                    c.ERR_MSG = String.IsNullOrEmpty(reader.GetValue(15).ToString()) ? String.Empty : reader.GetString(15);
                    c.INS_EXT_ID = String.IsNullOrEmpty(reader.GetValue(16).ToString()) ? (decimal?)null : reader.GetDecimal(16);
                    c.INS_EXT_TMP = String.IsNullOrEmpty(reader.GetValue(17).ToString()) ? (decimal?)null : reader.GetDecimal(17);
                    c.DEAL_ID = String.IsNullOrEmpty(reader.GetValue(18).ToString()) ? String.Empty : reader.GetString(18);
                    c.DATE_FROM = String.IsNullOrEmpty(reader.GetValue(19).ToString()) ? (DateTime?)null : reader.GetDateTime(19);
                    c.DATE_TO = String.IsNullOrEmpty(reader.GetValue(20).ToString()) ? (DateTime?)null : reader.GetDateTime(20);
                    card.Add(c);
                }

                return card;

            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }

            /*const string query = @"select dw.nd, -- Номер договору
                                          dw.branch, -- Відділення
                                          dw.acc_nls, -- Картковій рахунок
                                          dw.acc_lcv, -- Валюта
                                          dw.acc_ob22, -- ОБ22
                                          dw.acc_tipname, -- Субпродукт
                                          dw.card_code, -- Тип карти
                                          dw.card_idat, -- Дата видачі карти
                                          dw.acc_ost, -- Залишок
                                          dw.cust_rnk, -- РНК
                                          dw.cust_okpo, -- ЗКПО
                                          dw.cust_name, -- ПІБ
                                          dw.acc_daos, -- Дата відкриття
                                          dw.acc_dazs, -- Дата закриття
                                          wd.state, -- Статус
                                          wd.err_msg,
                                          wd.ins_ext_id,
                                          wd.ins_ext_tmp,
                                          wd.deal_id,
                                          wd.date_from,
                                          wd.date_to
                                     from W4_DEAL_WEB dw,
                                          ins_w4_deals wd
                                    where dw.nd = wd.nd";
            return _entities.ExecuteStoreQuery<CardInsurance>(query).AsQueryable();*/
        }

        public IEnumerable<CardInsurance> GetCardsInsurArc(decimal par)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"select nd, -- Номер договору 0
                                   branch, -- Відділення 1
                                   acc_nls, -- Картковій рахунок 2
                                   acc_lcv, -- Валюта 3
                                   acc_ob22, -- ОБ22 4
                                   acc_tipname, -- Субпродукт 5
                                   card_code, -- Тип карти 6
                                   card_idat, -- Дата видачі карти 7
                                   acc_ost, -- Залишок 8
                                   cust_rnk, -- РНК 9
                                   cust_okpo, -- ЗКПО 10
                                   cust_name, -- ПІБ 11
                                   acc_daos, -- Дата відкриття 12
                                   acc_dazs, -- Дата закриття 13
                                   state, -- Статус 14
                                   err_msg, -- 15
                                   ins_ext_id, -- 16
                                   ins_ext_tmp, -- 17
                                   deal_id, -- 18
                                   date_from, -- 19
                                   date_to -- 20,
                              from (select dw.nd, -- Номер договору 0
                                           dw.branch, -- Відділення 1
                                           dw.acc_nls, -- Картковій рахунок 2
                                           dw.acc_lcv, -- Валюта 3
                                           dw.acc_ob22, -- ОБ22 4
                                           dw.acc_tipname, -- Субпродукт 5
                                           nvl(t.card_code, dw.card_code) card_code, -- Тип карти 6
                                           dw.card_idat, -- Дата видачі карти 7
                                           dw.acc_ost, -- Залишок 8
                                           dw.cust_rnk, -- РНК 9
                                           dw.cust_okpo, -- ЗКПО 10
                                           dw.cust_name, -- ПІБ 11
                                           dw.acc_daos, -- Дата відкриття 12
                                           dw.acc_dazs, -- Дата закриття 13
                                           wd.state, -- Статус 14
                                           wd.err_msg, -- 15
                                           wd.ins_ext_id, -- 16
                                           wd.ins_ext_tmp, -- 17
                                           wd.deal_id, -- 18
                                           wd.date_from, -- 19
                                           wd.date_to, -- 20
                                           row_number() over(order by t.idupd desc) rn
                                      from W4_DEAL_WEB dw
                                      join Ins_W4_Deals_Arc wd
                                        on dw.nd = wd.nd
                                       and wd.nd = " + par.ToString() + @"
                                      left join w4_acc_update t
                                        on t.nd = wd.nd
                                       and t.chgdate <= wd.set_date)
                             where rn = 1";
                cmd.CommandText += " order by nd desc";
                OracleDataReader reader = cmd.ExecuteReader();
                List<CardInsurance> card = new List<CardInsurance>();
                while (reader.Read())
                {
                    CardInsurance c = new CardInsurance();
                    c.ND = String.IsNullOrEmpty(reader.GetValue(0).ToString()) ? (decimal?)null : reader.GetDecimal(0);
                    c.BRANCH = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : reader.GetString(1);
                    c.ACC_NLS = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? String.Empty : reader.GetString(2);
                    c.ACC_LCV = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? String.Empty : reader.GetString(3);
                    c.ACC_OB22 = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? String.Empty : reader.GetString(4);
                    c.ACC_TIPNAME = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? String.Empty : reader.GetString(5);
                    c.CARD_CODE = String.IsNullOrEmpty(reader.GetValue(6).ToString()) ? String.Empty : reader.GetString(6);
                    c.CARD_IDAT = String.IsNullOrEmpty(reader.GetValue(7).ToString()) ? (DateTime?)null : reader.GetDateTime(7);
                    c.ACC_OST = String.IsNullOrEmpty(reader.GetValue(8).ToString()) ? (decimal?)null : reader.GetDecimal(8);
                    c.CUST_RNK = String.IsNullOrEmpty(reader.GetValue(9).ToString()) ? (decimal?)null : reader.GetDecimal(9);
                    c.CUST_OKPO = String.IsNullOrEmpty(reader.GetValue(10).ToString()) ? String.Empty : reader.GetString(10);
                    c.CUST_NAME = String.IsNullOrEmpty(reader.GetValue(11).ToString()) ? String.Empty : reader.GetString(11);
                    c.ACC_DAOS = String.IsNullOrEmpty(reader.GetValue(12).ToString()) ? (DateTime?)null : reader.GetDateTime(12);
                    c.ACC_DAZS = String.IsNullOrEmpty(reader.GetValue(13).ToString()) ? (DateTime?)null : reader.GetDateTime(13);
                    c.STATE = String.IsNullOrEmpty(reader.GetValue(14).ToString()) ? String.Empty : reader.GetString(14);
                    c.ERR_MSG = String.IsNullOrEmpty(reader.GetValue(15).ToString()) ? String.Empty : reader.GetString(15);
                    c.INS_EXT_ID = String.IsNullOrEmpty(reader.GetValue(16).ToString()) ? (decimal?)null : reader.GetDecimal(16);
                    c.INS_EXT_TMP = String.IsNullOrEmpty(reader.GetValue(17).ToString()) ? (decimal?)null : reader.GetDecimal(17);
                    c.DEAL_ID = String.IsNullOrEmpty(reader.GetValue(18).ToString()) ? String.Empty : reader.GetString(18);
                    c.DATE_FROM = String.IsNullOrEmpty(reader.GetValue(19).ToString()) ? (DateTime?)null : reader.GetDateTime(19);
                    c.DATE_TO = String.IsNullOrEmpty(reader.GetValue(20).ToString()) ? (DateTime?)null : reader.GetDateTime(20);
                    card.Add(c);
                }

                return card;

            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        public class Login
        {
            public string email { get; set; }
            public string password { get; set; }
        }

        public class Point
        {
            public string code { get; set; }
            public string date { get; set; }
        }

        public string cookie;

        public string CreateDealEWA(ParamsEwa parameters, OracleConnection connection)
        {
            Login login = new Login();
            login.email = GetParameter("EWAEMAIL"); //"43@ewa.ua";
            login.password = GetParameter("EWAHASH");

            var param = parameters.param;
            string errorMessage = String.Empty;
            try
            {
                var response = RemoteLogin(login, "POST", "user/login");

                Point point = new Point();
                point.code = parameters.branch;
                point.date = String.Format("{0:yyyy-MM-dd}", DateTime.Today);
                var salepoint = String.Empty;
                try
                {
                    salepoint = Send(null, "GET", "salepoint/getByCode?code=" + point.code + "&date=" + point.date);
                }
                catch (Exception e)
                {
                    SetState(parameters.nd, "ERROR", "Не знайдено точку продажу в системі EWA!", connection);
                    return "Не знайдено точку продажу в системі EWA!";
                }
                JObject pointres = JObject.Parse(salepoint);
                decimal id = pointres.SelectToken(@"id").Value<decimal>();
                decimal cmpid = pointres.SelectToken(@"company.id").Value<decimal>();
                string cmptype = pointres.SelectToken(@"company.type").Value<string>();

                SalePointsEwa salePoint = new SalePointsEwa();
                salePoint.id = id;
                CompanyEwa company = new CompanyEwa();
                company.id = cmpid;
                company.type = cmptype;
                salePoint.company = company;
                param.salePoint = salePoint;

                parameters.param = param;
                string jsonReq = JsonConvert.SerializeObject(parameters);
                SetRquRes(parameters.nd, jsonReq, 0, String.Empty, null, null, connection);

                var result = Send(parameters.param, "POST", "contract/save");
                JObject resultres = JObject.Parse(result);

                var state = Send(null, "POST", "contract/" + resultres.SelectToken(@"id").Value<decimal>() + "/state/SIGNED");
                SetState(parameters.nd, "DONE", null, connection);

                var doc = JsonConvert.DeserializeXmlNode(result, "root");

                string code = resultres.SelectToken(@"code").Value<string>();
                DateTime dateFrom = resultres.SelectToken(@"dateFrom").Value<DateTime>();
                DateTime dateTo = resultres.SelectToken(@"dateTo").Value<DateTime>();
                SetRquRes(parameters.nd, doc.OuterXml, 1, code, dateFrom, dateTo, connection);

                return "Ok";
            }
            catch (WebException ex)
            {
                if (ex.Response != null)
                {
                    using (var rdr = new StreamReader(ex.Response.GetResponseStream()))
                    {
                        try
                        {
                            XmlDocument doc = JsonConvert.DeserializeXmlNode(rdr.ReadToEnd(), "root");
                            errorMessage = doc.OuterXml;
                        }
                        //answer is not an xml, for example, forbidden access
                        catch (Exception xmlParseEx)
                        {
                            errorMessage = "ERROR: " + ex.Message;
                            SetState(parameters.nd, "ERROR", errorMessage, connection);
                        }
                    }
                }
                else
                {
                    errorMessage = "ERROR: " + ex.Message;
                }
                SetState(parameters.nd, "ERROR", errorMessage, connection);
                throw new Exception(errorMessage);
            }
            catch (Exception e)
            {
                errorMessage = "ERROR: " + e.Message + "\n" + e.StackTrace;
                SetState(parameters.nd, "ERROR", errorMessage, connection);
                throw;
            }
            finally
            {
                var logout = Send(null, "PUT", "user/logout");
            }
        }

        public byte[] GetReport(decimal insextid, decimal insexttmp, bool? draft)
        {
            Login login = new Login();
            login.email = GetParameter("EWAEMAIL");
            login.password = GetParameter("EWAHASH");

            var response = RemoteLogin(login, "POST", "user/login");

            var result = Report("GET", "binary/report/" + insexttmp + "?contractId=" + insextid + "&draft=" + draft);

            var logout = Send(null, "PUT", "user/logout");
            return result;
        }

        public string RemoteLogin(Login register, string method, string func)
        {
            var result = "";
            HttpWebResponse response;
            string body = "email=" + register.email + "&password=" + register.password;
            byte[] arrStream = Encoding.UTF8.GetBytes(body);

            var serviceUrl = GetParameter("EWAURL");

            var request = (HttpWebRequest)WebRequest.Create(serviceUrl + func);
            request.Method = method;
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = arrStream.Length;
            Stream dataStream = request.GetRequestStream();
            dataStream.Write(arrStream, 0, arrStream.Length);
            dataStream.Close();
            response = (HttpWebResponse)request.GetResponse();
            WebHeaderCollection header = response.Headers;

            using (var rdr = new StreamReader(response.GetResponseStream()))
            {
                result = rdr.ReadToEnd();
                JObject pointres = JObject.Parse(result);
                cookie = pointres.SelectToken(@"sessionId").Value<string>();
            }

            return result;
        }

        public string Send(object register, string method, string func)
        {
            var result = "";
            HttpWebResponse response;
            MemoryStream stream = new MemoryStream();
            byte[] arrStream = { };
            if (register != null)
            {
                DataContractJsonSerializer ser = new DataContractJsonSerializer(register.GetType());
                ser.WriteObject(stream, register);
                stream.Position = 0;
                StreamReader reader = new StreamReader(stream);
                arrStream = Encoding.UTF8.GetBytes(reader.ReadToEnd());
                stream.Close();
            }
            var test = System.Text.Encoding.UTF8.GetString(arrStream); ;
            var serviceUrl = GetParameter("EWAURL");

            var request = (HttpWebRequest)WebRequest.Create(serviceUrl + func);
            request.Method = method;
            request.ContentType = "application/json";
            request.ContentLength = arrStream.Length;
            request.Headers.Add("Cookie", "JSESSIONID=" + cookie);

            if (register != null)
            {
                Stream dataStream = request.GetRequestStream();
                dataStream.Write(arrStream, 0, arrStream.Length);
                dataStream.Close();
            }
            response = (HttpWebResponse)request.GetResponse();
            WebHeaderCollection header = response.Headers;
            using (var rdr = new StreamReader(response.GetResponseStream()))
            {
                result = rdr.ReadToEnd();
            }

            return result;
        }

        public byte[] Report(string method, string func)
        {
            HttpWebResponse response;
            MemoryStream stream = new MemoryStream();

            var serviceUrl = GetParameter("EWAURL");

            var request = (HttpWebRequest)WebRequest.Create(serviceUrl + func);
            request.Method = method;
            request.ContentType = "application/json";
            request.Headers.Add("Cookie", "JSESSIONID=" + cookie);

            Byte[] lnByte;
            using (response = (HttpWebResponse)request.GetResponse())
            {
                using (BinaryReader reader = new BinaryReader(response.GetResponseStream()))
                {
                    lnByte = reader.ReadBytes(1 * 1024 * 1024 * 10);
                }
            }

            return lnByte;
        }

        public void SetState(decimal nd, string state, string message, OracleConnection connection)
        {
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "bars.ins_pack.set_w4_state";
                cmd.Parameters.Add(new OracleParameter("p_nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_state_id", OracleDbType.Varchar2, state, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_msg", OracleDbType.Varchar2, message, System.Data.ParameterDirection.Input));

                cmd.ExecuteNonQuery();

            }
            finally
            {
                cmd.Dispose();
            }
        }

        public void SetRquRes(decimal nd, string value, decimal key, string dealId, DateTime? dateFrom, DateTime? dateTo, OracleConnection connection)
        {
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "bars.ins_pack.set_w4_req_res";
                cmd.Parameters.Add(new OracleParameter("p_nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_value", OracleDbType.Clob, value, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_key", OracleDbType.Decimal, key, System.Data.ParameterDirection.Input));
                if (!String.IsNullOrEmpty(dealId))
                    cmd.Parameters.Add(new OracleParameter("p_deal_id", OracleDbType.Varchar2, dealId, System.Data.ParameterDirection.Input));
                if (dateFrom != null)
                    cmd.Parameters.Add(new OracleParameter("p_date_from", OracleDbType.Date, dateFrom, System.Data.ParameterDirection.Input));
                if (dateTo != null)
                    cmd.Parameters.Add(new OracleParameter("p_date_to", OracleDbType.Date, dateTo, System.Data.ParameterDirection.Input));

                cmd.ExecuteNonQuery();

            }
            finally
            {
                cmd.Dispose();
            }
        }

        public string GetParameter(string par)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            string res = String.Empty;
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select GetGlobalOption(:Par_) from dual";
                cmd.Parameters.Add(new OracleParameter("Par_", OracleDbType.Varchar2, par, System.Data.ParameterDirection.Input));

                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    res = reader.GetString(0);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }

            return res;
        }
    }
}