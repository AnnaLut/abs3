using System;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web.Script.Serialization;
using Bars.Classes;
using BarsWeb.Areas.Crkr.Controllers.Api;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Crkr.Models;
using Dapper;

namespace BarsWeb.Areas.Crkr.Infrastructure.DI.Implementation
{
    public class SaveClientRepository : ISaveClientRepository
    {
        private ConnectInfo GetInfo(string mfo)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<ConnectInfo>("select URL, USER_NAME, USER_PASS from compen_recipients where MFO = :mfo", new { mfo }).SingleOrDefault();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="user"></param>
        /// <param name="pass"></param>
        /// <returns>Return login and pass in base64 in format: "login:pass"</returns>
        private string Base64UserPass(string user, string pass)
        {
            var data = Convert.FromBase64String(user);
            var username = Encoding.UTF8.GetString(data);
            data = Convert.FromBase64String(pass);
            var password = Encoding.UTF8.GetString(data);
            var userpass = string.Format("{0}:{1}", username, password);
            var plainTextBytes = Encoding.UTF8.GetBytes(userpass);
            return Convert.ToBase64String(plainTextBytes);
        }

        /// <summary>
        /// Create request to remote API (GetAccount) with base64 authorization
        /// </summary>
        /// <param name="model">params for get remote URL and list of accounts</param>
        /// <returns>List of user accounts</returns>
        public string ClientAccounts(AccountInfo model)
        {
            var info = GetInfo(model.mfo);
            var json = new JavaScriptSerializer().Serialize(model);
            var requestData = Encoding.UTF8.GetBytes(json);
            
            var serveRequest = (HttpWebRequest)WebRequest.Create(info.URL);
            serveRequest.ContentType = "application/json";
            serveRequest.Method = "POST";
            serveRequest.ContentLength = requestData.Length;
            serveRequest.Headers[HttpRequestHeader.Authorization] = string.Format("Basic " + Base64UserPass(info.USER_NAME, info.USER_PASS));
            serveRequest.GetRequestStream().Write(requestData, 0, requestData.Length);
            serveRequest.GetRequestStream().Close();
            
            string respon = "";
            
            using (HttpWebResponse serveResponse = (HttpWebResponse)serveRequest.GetResponse())
            {
                var responseStream = serveResponse.GetResponseStream();
                StreamReader readStream = new StreamReader(responseStream, Encoding.UTF8);
                respon = readStream.ReadToEnd();
                serveResponse.Close();
                readStream.Close();
            }
           
            return respon;
            
        }

        public long CreateClient(ClientProfile megamodel)
        {
            DateTime birthday;
            DateTime issueDate;
            DateTime valDate;
            DateTime actualDate;
            if (!DateTime.TryParseExact(megamodel.StrBirthday, "dd.MM.yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out birthday))
                throw new Exception("Невірний формат дати!");
            if (!DateTime.TryParseExact(megamodel.StrIssueDate, "dd.MM.yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out issueDate))
                throw new Exception("Невірний формат дати!");
            if (!DateTime.TryParseExact(megamodel.StrRegisterDate, "dd.MM.yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out valDate))
                throw new Exception("Невірний формат дати!");
            
            var p = new DynamicParameters();
            #region DONT OPEN
            p.Add("p_name", megamodel.FullName, DbType.String, ParameterDirection.Input);
            p.Add("p_inn", megamodel.INN, DbType.String, ParameterDirection.Input);
            p.Add("p_sex", megamodel.Sex, DbType.String, ParameterDirection.Input);
            p.Add("p_birth_date", birthday, DbType.DateTime, ParameterDirection.Input);
            p.Add("p_rezid", megamodel.SignResidency, DbType.Decimal, ParameterDirection.Input);
            p.Add("p_doc_type", megamodel.DocumentType, DbType.Decimal, ParameterDirection.Input);
            p.Add("p_ser", megamodel.Ser, DbType.String, ParameterDirection.Input);
            p.Add("p_numdoc", megamodel.NumDoc, DbType.String, ParameterDirection.Input);
            p.Add("p_date_of_issue", issueDate, DbType.DateTime, ParameterDirection.Input);
            p.Add("p_organ", megamodel.Organ, DbType.String, ParameterDirection.Input);
            p.Add("p_eddr_id", megamodel.EddrId, DbType.String, ParameterDirection.Input);

            if (megamodel.ActualDate != null)
            {
                if (!DateTime.TryParseExact(megamodel.ActualDate, "dd.MM.yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out actualDate))
                    throw new Exception("Невірний формат дати!");

                p.Add("p_actual_date", actualDate, DbType.DateTime, ParameterDirection.Input);
            }
            else
            {
                p.Add("p_actual_date", null, DbType.DateTime, ParameterDirection.Input);
            }
                        
            p.Add("p_country_id", megamodel.CountryId, DbType.String, ParameterDirection.Input);
            p.Add("p_bplace", megamodel.Bplace, DbType.String, ParameterDirection.Input);
            p.Add("p_tel", megamodel.PhoneNumber, DbType.String, ParameterDirection.Input);
            p.Add("p_tel_mob", megamodel.MobileNumber, DbType.String, ParameterDirection.Input);
            p.Add("p_branch", megamodel.DepartmentCode, DbType.String, ParameterDirection.Input);
            p.Add("p_notes", megamodel.SourceDownload, DbType.String, ParameterDirection.Input);
            p.Add("p_date_val", valDate, DbType.DateTime, ParameterDirection.Input);
            p.Add("p_zip", megamodel.Postindex, DbType.String, ParameterDirection.Input);
            p.Add("p_domain", megamodel.Area, DbType.String, ParameterDirection.Input);
            p.Add("p_region", megamodel.Region, DbType.String, ParameterDirection.Input);
            p.Add("p_locality", megamodel.City, DbType.String, ParameterDirection.Input);
            p.Add("p_address", megamodel.Address, DbType.String, ParameterDirection.Input);
            p.Add("p_mfo", megamodel.Mfo, DbType.String, ParameterDirection.Input);
            p.Add("p_nls", megamodel.Nls, DbType.String, ParameterDirection.Input);
            p.Add("p_secondary", megamodel.Secondary, DbType.Decimal, ParameterDirection.Input);
            p.Add("p_okpo", megamodel.Okpo, DbType.String, ParameterDirection.Input);
            p.Add("p_rnk", megamodel.RNK, DbType.Int64, ParameterDirection.InputOutput);
            #endregion

            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute("crkr_compen_web.create_customer", p, commandType: CommandType.StoredProcedure);
                var rnk = p.Get<Int64?>("p_rnk");
                return (long)rnk;
            }
        }

        public long CreateBenef(BenefProfile model)
        {
            DateTime docdate;
            DateTime birthday;

            var docdateFlag = DateTime.TryParseExact(model.Docdate, "dd.MM.yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out docdate);
            var birthdayFlag = DateTime.TryParseExact(model.Birth, "dd.MM.yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out birthday);

            var p = new DynamicParameters();
            #region DONT OPEN
            p.Add("p_id_compen", model.CompenId, DbType.Decimal, ParameterDirection.Input);
            p.Add("p_code", model.Code, DbType.String, ParameterDirection.Input);
            p.Add("p_fio", model.FullName, DbType.String, ParameterDirection.Input);
            p.Add("p_country", model.Country, DbType.Decimal, ParameterDirection.Input);
            p.Add("p_fulladdress", model.Address, DbType.String, ParameterDirection.Input);
            p.Add("p_icod", model.Icod, DbType.String, ParameterDirection.Input);
            p.Add("p_doctype", model.Doctype, DbType.Decimal, ParameterDirection.Input);
            p.Add("p_docserial", model.DocSerial, DbType.String, ParameterDirection.Input);
            p.Add("p_docnumber", model.DocNumber, DbType.String, ParameterDirection.Input);
            p.Add("p_eddr_id", model.EddrId, DbType.String, ParameterDirection.Input);
            p.Add("p_docorgb", model.DocOrg, DbType.String, ParameterDirection.Input);
            if (docdateFlag)
                p.Add("p_docdate", docdate, DbType.DateTime, ParameterDirection.Input);
            else
                p.Add("p_docdate", null, DbType.DateTime, ParameterDirection.Input);

            if (birthdayFlag)
                p.Add("p_cliebtbdate", birthday, DbType.DateTime, ParameterDirection.Input);
            else
                p.Add("p_cliebtbdate", null, DbType.DateTime, ParameterDirection.Input);
            p.Add("p_clientsex", model.Sex, DbType.String, ParameterDirection.Input);
            p.Add("p_clientphone", model.Phone, DbType.String, ParameterDirection.Input);
            p.Add("p_percent", model.Percent, DbType.Decimal, ParameterDirection.Input);
            p.Add("p_idb", model.Idb, DbType.Int64, ParameterDirection.InputOutput);
            #endregion

            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute("crkr_compen_web.registr_benef", p, commandType: CommandType.StoredProcedure);
                var idb = p.Get<Int64?>("p_idb");
                return (long) idb;
            }
        }
    }
}
