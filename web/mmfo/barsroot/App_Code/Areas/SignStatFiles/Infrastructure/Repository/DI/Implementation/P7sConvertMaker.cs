using System;
using System.IO;
using System.Net;
using System.Text;
//using EUSignCP;
using Newtonsoft.Json;

namespace BarsWeb.Areas.SignStatFiles.Infrastructure.DI.Implementation
{
    public class P7SEnvelopeMaker
    {
        private string _baseUrl = string.Empty;
        public P7SEnvelopeMaker(string url)
        {
            _baseUrl = url;
        }

        private byte[] _P7SEnvelope;
        private byte[] P7SEnvelope
        {
            get
            {
                if (null == _P7SEnvelope || _P7SEnvelope.Length <= 0) throw new Exception("P7SEnvelope is null or empty");
                return _P7SEnvelope;
            }
            set
            {
                _P7SEnvelope = value;
            }
        }

        #region API
        public byte[] Make(byte[] CadesBesSign, byte[] file)
        {
            // D:\Work\StatFiles\else\crypto\TestDocument\TestDocument.pdf.p7s
            // byte[] CadesBesSign = File.ReadAllBytes(@"D:\Work\StatFiles\else\crypto\TestDocument\TestDocument.pdf.p7s");

            //File.WriteAllBytes(@"D:\Work\StatFiles\else\crypto\TestDocument\TestDocument2.xml.p7s", CadesBesSign);
            //File.WriteAllBytes(@"D:\Work\StatFiles\else\crypto\TestDocument\TestDocument2.xml", file);

            //get the session
            var session = GetSession();
            //upload detached signFilePath (CAdES-BES sign byte array)
            UploadFile(CadesBesSign, string.Format("{0}{1}/ds/data", _baseUrl, session.TicketUuid));
            //UploadFile(signFilePath, $"{_baseUrl}{session.TicketUuid}/ds/data");

            //upload originalFilePath (file bytes array)
            UploadFile(file, string.Format("{0}{1}/data", _baseUrl, session.TicketUuid));
            //UploadFile(originalFilePath, $"{_baseUrl}{session.TicketUuid}/data");

            //set options
            SetOptions(string.Format("{0}{1}/option", _baseUrl, session.TicketUuid));
            //SetOptions($"{_baseUrl}{session.TicketUuid}/option");

            //set modifier
            SetModifier(string.Format("{0}{1}/ds/modifier", _baseUrl, session.TicketUuid));
            //SetModifier($"{_baseUrl}{session.TicketUuid}/ds/modifier");

            //download convert
            P7SEnvelope = DownloadConvert(string.Format("{0}{1}/ds/modifiedData", _baseUrl, session.TicketUuid));
            //DownloadConvert($"{_baseUrl}{session.TicketUuid}/ds/modifiedData", convertFilePath);

            //close session
            CloseSession(string.Format("{0}{1}", _baseUrl, session.TicketUuid));
            //CloseSession($"{_baseUrl}{session.TicketUuid}");

            return P7SEnvelope;
        }

        private void CloseSession(string url)
        {
            WebRequest request = WebRequest.Create(url);
            request.Method = "DELETE";
            using (WebResponse resp = request.GetResponse()) { }
        }

        private byte[] DownloadConvert(string url)
        {
            WebRequest request = WebRequest.Create(url);
            request.Method = "GET";
            request.ContentType = "text/plain";
            using (WebResponse resp = request.GetResponse())
            using (Stream input = resp.GetResponseStream())
            using (MemoryStream ms = new MemoryStream())
            {
                input.CopyTo(ms);
                return ms.ToArray();
            }
        }

        private void SetModifier(string url)
        {
            WebRequest request = WebRequest.Create(url);
            request.Method = "POST";
            request.ContentType = "text/plain";

            SendRequest(request);
        }

        private TicketMessage GetSession()
        {
            WebRequest request = WebRequest.Create(_baseUrl);
            request.Method = "POST";
            TicketMessage session;
            using (WebResponse resp = request.GetResponse())
            using (Stream stream = resp.GetResponseStream())
            using (StreamReader reader = new StreamReader(stream))
            {
                session = JsonConvert.DeserializeObject<TicketMessage>(reader.ReadToEnd());
            }

            return session;
        }

        private void UploadFile(byte[] fileContent, string Url)
        {
            WebRequest request = WebRequest.Create(Url);
            request.Method = "POST";
            request.ContentType = "application/octet-stream";
            request.ContentLength = fileContent.Length;
            using (Stream requestStream = request.GetRequestStream())
            {
                requestStream.Write(fileContent, 0, fileContent.Length);
                requestStream.Close();
            }

            SendRequest(request);
        }

        private void SetOptions(string Url)
        {
            string options = @"{
                                  ""cadesType"" : ""CAdESXLong"",
                                  ""signatureType"": ""attached"",
                                  ""embedCertificateType"": ""nothing"",
                                  ""embedSignatureTs"": ""false"",
                                  ""embedDataTs"": ""true"",
                                  ""signatureTsVerifyOption"": ""ignore"",
                                  ""dataTsVerifyOption"": ""ignore""
                               }";


            WebRequest request = WebRequest.Create(Url);
            request.Method = "PUT";
            request.ContentType = "application/json";
            request.ContentLength = options.Length;
            using (Stream requestStream = request.GetRequestStream())
            {
                requestStream.Write(Encoding.ASCII.GetBytes(options), 0, Encoding.ASCII.GetBytes(options).Length);
                requestStream.Close();
            }

            SendRequest(request);
        }

        private void SendRequest(WebRequest request)
        {
            using (WebResponse response = request.GetResponse())
            using (Stream stream = response.GetResponseStream())
            using (StreamReader reader = new StreamReader(stream))
            {
                TicketMessage result = JsonConvert.DeserializeObject<TicketMessage>(reader.ReadToEnd());
                if (!string.IsNullOrEmpty(result.FailureCause))
                {
                    throw new InvalidOperationException(result.FailureCause);
                }
            }
        }

        public class TicketMessage
        {
            public string Message { get; set; }
            public string TicketUuid { get; set; }
            public string FailureCause { get; set; }
        }
        #endregion

        #region Libs
        //public byte[] Make2()
        //{
        //    String DataFilePath = @"D:\Work\StatFiles\else\crypto\TestDocument\TestDocument.pdf";
        //    String DataSignPath = @"D:\Work\StatFiles\else\crypto\TestDocument\TestDocument.pdf.p7s";
        //    String NewSignPath = @"D:\Work\StatFiles\else\crypto\TestDocument\TestDocument_full.pdf.p7s";

        //    Byte[] DataFileBytes = System.IO.File.ReadAllBytes(DataFilePath);

        //    Byte[] DataSignBytes = System.IO.File.ReadAllBytes(DataSignPath);

        //    IEUSignCP.SetUIMode(false);
        //    int resInitialize = IEUSignCP.Initialize();
        //    IEUSignCP.SetUIMode(false);
        //    Console.WriteLine("resInitialize = " + resInitialize);
        //    if (resInitialize != 0) throw new Exception("not initialized");

        //    Byte[] EmptySign;
        //    // создали конверт только с данными файла
        //    int resCreateEmptySign = EUSignCP.IEUSignCP.CreateEmptySign(DataFileBytes, out EmptySign);
        //    Console.WriteLine("resCreateEmptySign = " + resCreateEmptySign + " EmptySign.Length = " + EmptySign.Length);

        //    Byte[] Signer;
        //    // Из конверта а котором лежит подпись получили информацию о подписанте
        //    int resGetSigner = EUSignCP.IEUSignCP.GetSigner(0, DataSignBytes, out Signer);

        //    IEUSignCP.EU_CERT_INFO_EX CertInfo;
        //    Byte[] Certificate = new Byte[0];
        //    // Из конверта а котором лежит подпись получили расширенную информацию о подписанте, а именно: 
        //    // CertInfo - информация о подписанте, Certificate - сертификат
        //    int resGetSignerInfo = EUSignCP.IEUSignCP.GetSignerInfo(0, DataSignBytes, out CertInfo, ref Certificate);
        //    Console.WriteLine("CertInfo = " + CertInfo.subjFullName + ", email:" + CertInfo.subjEMail);
        //    Console.WriteLine("resGetSignerInfo = " + resGetSignerInfo + " Certificate.Length = " + Certificate.Length);


        //    Byte[] NewSign;
        //    int resAppendSigner = EUSignCP.IEUSignCP.AppendSigner(Signer, Certificate, EmptySign, out NewSign);
        //    Console.WriteLine("resAppendSigner = " + resAppendSigner + " NewSign.Length = " + NewSign.Length);

        //    System.IO.File.WriteAllBytes(NewSignPath, NewSign);
        //    Console.WriteLine("AppFinish");
        //    return null;
        //}
        #endregion
    }
}

