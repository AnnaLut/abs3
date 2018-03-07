using BarsWeb.Areas.CorpLight.DataContexts;
using BarsWeb.Areas.CorpLight.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Xml;

namespace BarsWeb.Areas.CorpLight.Infrastructure.Services
{
    /// <summary>
    /// Nokk service
    /// </summary>
    public class NokkService : INokkService
    {

        private IUserCertificateService _userCertificateService;
        private IAcskLogger _acskLogger;
        private string _baseServiceUrl = ConfigurationManager.AppSettings["Acsk.BaseServiceUrl"];

        public string BaseServiceUrl
        {
            get { return _baseServiceUrl; }
            set { _baseServiceUrl = value; }
        }

        public NokkService(IUserCertificateService userCertificateService, IAcskLogger acskLogger)
        {
            _userCertificateService = userCertificateService;
            _acskLogger = acskLogger;
        }
        /// <summary>
        /// Make request for sending profile
        /// </summary>
        /// <param name="profileData"></param>
        /// <returns></returns>
        public AcskResponse SendProfile(string profileData)
        {
            var result = MakeRequest(profileData);
            return result;
        }
        /// <summary>
        /// Make request for sending rules and get get rules
        /// </summary>
        /// <param name="rulesData"></param>
        /// <returns></returns>
        public List<AcskRuleTemplate> GetRules(string rulesData)
        {
            var resultStr = MakeRequest(rulesData);
            var rules = _userCertificateService.ParseRules((resultStr.Data as string));
            return rules;          
        }
        /// <summary>
        /// Make request for sending state
        /// </summary>
        /// <param name="stateData"></param>
        /// <returns></returns>
        public AcskResponse ChangeState(string stateData)
        {
            var result = MakeRequest(stateData);
            return result;
        }
        /// <summary>
        /// Get request data
        /// </summary>
        /// <param name="requestsData"></param>
        /// <returns></returns>
        public AcskResponse GetRequests(string requestsData)
        {
            var result = MakeRequest(requestsData);
            var data = _userCertificateService.ParseCertificate(result.Data as string);
            result.Data = data;
            return result;
        }
        /// <summary>
        /// Enroll
        /// </summary>
        /// <param name="requestsData"></param>
        /// <returns></returns>
        public AcskResponse Enroll(string requestsData)
        {
            var result = MakeRequest(requestsData);

            result.Data = _userCertificateService.ParseEnroll((result.Data as string));
            return result;
        }
        /// <summary>
        /// Get subject
        /// </summary>
        /// <param name="subjectData"></param>
        /// <returns></returns>
        public AcskResponse Subject(string subjectData)
        {
            var result = MakeRequest(subjectData);

            result.Data = _userCertificateService.ParseSubject((result.Data as string));
            return result;
        }
        /// <summary>
        /// Make request using xml format
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public AcskResponse MakeRequest(string data)
        {
            var acskRequest = _userCertificateService.GenerateRequestXml(data);
            _acskLogger.LogRequest(acskRequest);
            try
            {
                using (var httpContext = new HttpDataContext(_baseServiceUrl))
                {
                    var client = httpContext.GetProvider(GetAuthenticationHeaderValue());
                    var content = new StringContent(acskRequest.Base64RequestData);

                    HttpResponseMessage clientResponse = client.PostAsync("", content).Result;
                    if (clientResponse.IsSuccessStatusCode)
                    {
                        var result = clientResponse.Content.ReadAsStringAsync().Result;

                        var response = ParseResponse(result);
                        _acskLogger.LogResponse(response);
                        return response;
                    }

                    var message = clientResponse.Content.ReadAsStringAsync().Result;
                    var res = new AcskResponse
                    {
                        Id = acskRequest.Id,
                        Message = message,
                        Date = DateTime.Now,
                        Code = "ERROR"
                    };
                    _acskLogger.LogResponse(res);
                    throw new Exception(client.BaseAddress + " : " + message);
                }
            }
            catch (Exception e)
            {
                var message = e.InnerException == null ? e.Message : e.InnerException.Message;
                var res = new AcskResponse
                {
                    Id = acskRequest.Id,
                    Message = message,
                    Date = DateTime.Now,
                    Code = "ERROR"
                };
                _acskLogger.LogResponse(res);
                throw e;
            }
        }

        private string ConvertToStringFromBase64(string base64)
        {
            var data = Convert.FromBase64String(base64);
            var str = Encoding.UTF8.GetString(data);
            return str;
        } 
        /// <summary>
        /// Parce responce
        /// </summary>
        /// <param name="base64Response"></param>
        /// <returns></returns>
        private AcskResponse ParseResponse(string base64Response)
        {
            var response = ConvertToStringFromBase64(base64Response);

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(response);

            XmlNode answer = doc.DocumentElement.SelectSingleNode("/answer");
            var result = new AcskResponse();
            if (answer != null)
            {
                var idAttr = answer.Attributes["nonce"];
                if (idAttr != null)
                {
                    result.Id = idAttr.Value;
                }
                var dateAttr = answer.Attributes["date"];
                if (dateAttr != null)
                {
                    result.Date = DateTime.ParseExact(dateAttr.Value, "yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture);
                }
                result.Data = answer.InnerText;

                XmlNode resultNode = answer.SelectSingleNode("result");
                if (resultNode != null)
                {
                    var codeAttr = resultNode.Attributes["code"];
                    if (codeAttr != null)
                    {
                        result.Code = codeAttr.Value;
                    }
                    var messageAttr = resultNode.Attributes["message"];
                    if (messageAttr != null)
                    {
                        result.Message = messageAttr.Value;
                    }
                }
            }

            return result;
        }
        private AuthenticationHeaderValue GetAuthenticationHeaderValue()
        {
            return null;
        }
    }

    public interface INokkService
    {
        string BaseServiceUrl { get; set; }

        AcskResponse SendProfile(string profileData);
        List<AcskRuleTemplate> GetRules(string rulesData);
        AcskResponse ChangeState(string stateData);
        AcskResponse GetRequests(string requestsData);

        AcskResponse Enroll(string requestsData);
        AcskResponse Subject(string subjectData);

        AcskResponse MakeRequest(string data);
    }
}