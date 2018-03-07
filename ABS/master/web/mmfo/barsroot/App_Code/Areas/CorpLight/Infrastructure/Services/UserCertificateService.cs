using System;
using System.Text;
using BarsWeb.Areas.CorpLight.Infrastructure.Repository;
using BarsWeb.Areas.CorpLight.Models;
using System.Collections.Generic;
using System.Xml;
using Newtonsoft.Json;
using BarsWeb.Areas.CorpLight.Models.Acsk;
using System.Globalization;

namespace BarsWeb.Areas.CorpLight.Infrastructure.Services
{
    /// <summary>
    /// Class for parse and format user xml 
    /// </summary>
    public class UserCertificateService : IUserCertificateService
    {
        private IRelatedCustomersRepository _relatedCustomersRepository;
        public UserCertificateService(IRelatedCustomersRepository relatedCustomersRepository)
        {
            _relatedCustomersRepository = relatedCustomersRepository;
        }
        #region format user xml
        public string CreateUserProfileRequest(RelatedCustomer userProfile)
        {
            var request = ConvertUserProfileToXml(userProfile);
            return ToBase64String(request);
        }

        public string CreateRulesRequest(string registrationId)
        {
            var message = string.Format("<rules registrationId=\"{0}\"></rules>", registrationId);
            return ToBase64String(message);
        }

        public string CreateStateRequest(string registrationId, string serialNumber, string newState)
        {
            var message = string.Format("<state registrationId=\"{0}\" serialNumber=\"{1}\" newState=\"{2}\"></state>",
                registrationId, serialNumber, newState);
            return ToBase64String(message);
        }

        public string CreateRequestsRequest(string registrationId)
        {
            var message = string.Format("<requests registrationId=\"{0}\"></requests>", registrationId);
            return ToBase64String(message);
        }

        public string CreateEnrollRequest(string registrationId, string templateId)
        {
            var message = string.Format("<enroll registrationId=\"{0}\" templateId=\"{1}\"></enroll>",
                registrationId, templateId);
            return ToBase64String(message);
        }

        public string CreateSubjectRequest(string registrationId, string templateId, string providerId)
        {
            var message = string.Format("<subject registrationId=\"{0}\" templateId=\"{1}\" providerId=\"{2}\"></subject>",
                registrationId, templateId, providerId);
            return ToBase64String(message);
        }
        #endregion
        public AcskRequest GenerateRequestXml(string messageString)
        {
            var result = new AcskRequest();

            var resultString = new StringBuilder();
            resultString.Append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
            resultString.Append(
                string.Format(
                    "<operation date=\"{0}\" nonce=\"{1}\" total=\"{2}\" version=\"1\" >",
                    result.Date.ToString("yyyy-MM-dd HH:mm:ss"),
                    result.Id,
                    1));
            resultString.Append("<message>");
            resultString.Append(messageString);
            resultString.Append("</message>");

            resultString.Append("</operation>");

            result.Base64RequestData = ToBase64String(resultString.ToString());
            return result;
        }

        private string ToBase64String(string inputString)
        {
            var bytes = Encoding.UTF8.GetBytes(inputString);
            return Convert.ToBase64String(bytes);
        }
        /// <summary>
        /// Convert user xml
        /// </summary>
        /// <param name="userProfile"></param>
        /// <returns></returns>
        public string ConvertUserProfileToXml(RelatedCustomer userProfile)
        {
            var result = new StringBuilder();

            //add data tag
            result.Append("<user>");

            result.Append("<id>");
            var id = userProfile.AcskRegistrationId == null ? "0" : userProfile.AcskRegistrationId.ToString();
            result.Append(id.PadLeft(8, '0'));
            result.Append("</id>");

            result.Append("<taxCode>");
            result.Append(userProfile.TaxCode);
            result.Append("</taxCode>");

            result.Append("<firstName>");
            result.Append(userProfile.FirstName);
            result.Append("</firstName>");

            result.Append("<lastName>");
            result.Append(userProfile.LastName);
            result.Append("</lastName>");

            result.Append("<secondName>");
            result.Append(userProfile.SecondName);
            result.Append("</secondName>");

            result.Append("<birthDate>");
            if (userProfile.BirthDate != null) result.Append(userProfile.BirthDate.Value.ToString("yyyy-MM-dd"));
            result.Append("</birthDate>");

            result.Append("<documentType>");
            var documentType = userProfile.DocType == "PASSPORT" ? 1 : 5;
            result.Append(documentType);
            result.Append("</documentType>");

            result.Append("<documentSeries>");
            result.Append(userProfile.DocSeries);
            result.Append("</documentSeries>");

            result.Append("<documentNumber>");
            result.Append(userProfile.DocNumber);
            result.Append("</documentNumber>");

            result.Append("<documentOrganization>");
            result.Append(userProfile.DocOrganization);
            result.Append("</documentOrganization>");

            result.Append("<documentDate>");
            if (userProfile.DocDate != null) result.Append(userProfile.DocDate.Value.ToString("yyyy-MM-dd"));
            result.Append("</documentDate>");

            result.Append("<cellPhone>");
            result.Append(userProfile.CellPhone);
            result.Append("</cellPhone>");

            result.Append("<email>");
            result.Append(userProfile.Email);
            result.Append("</email>");

            result.Append("<address>");

            result.Append("<region>");
            result.Append(userProfile.AddressRegionName);
            result.Append("</region>");

            result.Append("<city>");
            result.Append(userProfile.AddressCity);
            result.Append("</city>");

            result.Append("<street>");
            result.Append(userProfile.AddressStreet);
            result.Append("</street>");

            result.Append("<houseNumber>");
            result.Append(userProfile.AddressHouseNumber);
            result.Append("</houseNumber>");

            result.Append("<addition>");
            result.Append(userProfile.AddressAddition);
            result.Append("</addition>");

            result.Append("</address>");

            result.Append("</user>");
            return result.ToString();
        }


        #region parser
        /// <summary>
        /// Parsing rules
        /// </summary>
        /// <param name="xmlString"></param>
        /// <returns></returns>
        public List<AcskRuleTemplate> ParseRules(string xmlString)
        {
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(xmlString);
            XmlNodeList templates = doc.DocumentElement.SelectNodes("/rules/templates/template");
            var result = new List<AcskRuleTemplate>();
            foreach (XmlNode node in templates)
            {
                var rule = JsonConvert.DeserializeObject<AcskRuleTemplate>(node.InnerText);
                result.Add(rule);
            }
            return result;
        }

        /// <summary>
        /// Parse enroll
        /// </summary>
        /// <param name="xmlString"></param>
        /// <returns></returns>
        public AcskEnrollResponse ParseEnroll(string xmlString)
        {
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(xmlString);
            XmlNodeList nodesList = doc.DocumentElement.SelectNodes("/enroll");

            if (nodesList != null)
            {
                var result = new AcskEnrollResponse();
                var node = nodesList[0];

                var requestIdAttr = node.Attributes["requestId"];
                if (requestIdAttr != null)
                {
                    result.RequestId = Convert.ToDecimal(requestIdAttr.Value);
                }

                var statusAttr = node.Attributes["status"];
                if (statusAttr != null)
                {
                    result.Status = Convert.ToInt32(statusAttr.Value);
                }

                var createTimeAttr = node.Attributes["createTime"];
                if (createTimeAttr != null)
                {
                    result.CreateTime = 
                        DateTime.ParseExact(createTimeAttr.Value, "yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture);
                }
                return result;
            }
            return null;
        }
        /// <summary>
        /// ParseSubject
        /// </summary>
        /// <param name="xmlString"></param>
        /// <returns></returns>
        public AcskSubjectInfo ParseSubject(string xmlString)
        {
            if (string.IsNullOrEmpty(xmlString))
            {
                return null;
            }
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(xmlString);
            XmlNodeList nodesList = doc.DocumentElement.SelectNodes("/subject");

            if (nodesList != null)
            {
                var node = nodesList[0];

                var result = new AcskSubjectInfo();
                var templateIdAttr = node.Attributes["templateId"];
                if (templateIdAttr != null)
                {
                    result.TemplateId = templateIdAttr.Value;
                }

                var registrationIdAttr = node.Attributes["registrationId"];
                if (templateIdAttr != null)
                {
                    result.RegistrationId = registrationIdAttr.Value;
                }

                result.Subject = node.InnerText;
                return result;
            }

            return null;
        }
        /// <summary>
        /// ParseSendProfileInfo
        /// </summary>
        /// <param name="xmlString"></param>
        /// <returns></returns>
        public AcskSendProfileInfo ParseSendProfileInfo(string xmlString)
        {
            if (string.IsNullOrEmpty(xmlString))
            {
                return null;
            }
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(xmlString);
            XmlNodeList userNodes = doc.DocumentElement.SelectNodes("/user");

            if (userNodes != null)
            {
                var node = userNodes[0];

                var result = new AcskSendProfileInfo();
                var registrationIdAttr = node.Attributes["registrationId"];
                if (registrationIdAttr != null)
                {
                    result.RegistrationId = Convert.ToInt32(registrationIdAttr.Value);
                }

                var userIdAttr = node.Attributes["userId"];
                if (userIdAttr != null)
                {
                    result.UserId = userIdAttr.Value;
                }
                return result;
            }

            return null;
        }

        public List<AcskCertificate> ParseCertificate(string xmlString)
        {
            var result = new List<AcskCertificate>();
            if (string.IsNullOrEmpty(xmlString))
            {
                return result;
            }
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(xmlString);
            XmlNodeList requests = doc.DocumentElement.SelectNodes("/requests/request");
            foreach (XmlNode node in requests)
            {
                var cert = JsonConvert.DeserializeObject<AcskCertificate>(node.InnerText);
                result.Add(cert);
            }
            return result;
        }
        #endregion
    }

    public interface IUserCertificateService
    {
        string CreateUserProfileRequest(RelatedCustomer userProfile);
        string CreateRulesRequest(string registrationId);
        string CreateStateRequest(string registrationId, string serialNumber, string newState);
        string CreateRequestsRequest(string registrationId);
        string CreateEnrollRequest(string registrationId, string templateId);
        string CreateSubjectRequest(string registrationId, string templateId, string providerId);


        List<AcskRuleTemplate> ParseRules(string xmlString);

        AcskSendProfileInfo ParseSendProfileInfo(string xmlString);
        string ConvertUserProfileToXml(RelatedCustomer userProfile);
        AcskRequest GenerateRequestXml(string xmlString);
        AcskSubjectInfo ParseSubject(string xmlString);

        AcskEnrollResponse ParseEnroll(string xmlString);
        List<AcskCertificate> ParseCertificate(string xmlString);
    }
}
