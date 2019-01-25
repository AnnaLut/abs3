using BarsWeb.Areas.Teller.Infrastructure.DI.Abstract;
using System;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Collections.Generic;
using System.Xml.Serialization;
using BarsWeb.Areas.Teller.Model;
using BarsWeb.Areas.Teller.Enums;

namespace BarsWeb.Areas.Teller.Controllers.Api
{
    [AuthorizeApi]
    public class TellerController : ApiController
    {
        readonly ITellerRepository _repo;
        public TellerController(ITellerRepository repo) { _repo = repo; }

        /// <summary>
        /// Активація обо деактивація теллера
        /// </summary>
        /// <param name="o"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage SetTeller(TellerData o)
        {
            _repo.SetTeller(o.IsTeller);
            HttpContext.Current.Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", ""));
            return Request.CreateResponse(HttpStatusCode.OK, new { });
        }

        [HttpPost]
        public HttpResponseMessage CheckTellerProcesses()
        {
            TellerResponseModel model = _repo.CheckTellerStatus();
            if (model.Result == 1)
                model.P_errtxt = _repo.GetBankDate();
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }

        /// <summary>
        /// Перевірка суми
        /// </summary>
        /// <param name="sum"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage CheckSmall(string sum)
        {
            decimal _sum = Convert.ToDecimal(sum);
            var data = _repo.CheckSmall(_sum);
            return Request.CreateResponse(HttpStatusCode.OK, data);
        }

        /// <summary>
        /// Виконання операцій з вікном теллера
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage ATMRequest(ATMModel data)
        {
            TellerWindowStatusModel model = _repo.ExecuteGetStatus(data);
            String method = data.Method.ToLower();
            if (method == "cancelatmwindowoperation" || method == "makerequest" || method == "endrequest")
                model = InitializeStatusModel(model, data);
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }

        /// <summary>
        /// Отримання статусу після проведення операції
        /// </summary>
        /// <param name="model"></param>
        /// <param name="data"></param>
        /// <returns></returns>
        private TellerWindowStatusModel InitializeStatusModel(TellerWindowStatusModel model, ATMModel data)
        {
            String method = data.Method.ToLower();
            if (method == "cancelatmwindowoperation")
                data.RJ = true;
            data.Method = "getwindowstatus";
            TellerWindowStatusModel tmpModel = _repo.ExecuteGetStatus(data);
            switch (method)
            {
                case "cancelatmwindowoperation":
                    model.Status = tmpModel.Status;
                    break;
                case "makerequest":
                    model.Message = tmpModel.Message;
                    model.Status = tmpModel.Status;
                    break;
                case "endrequest":
                    tmpModel.Message = model.Message;
                    if (model.Status == "ERR" && !String.IsNullOrEmpty(model.Message))
                        tmpModel.Status = "ERR";
                    model = tmpModel;
                    break;
            }
            return model;
        }

        /// <summary>
        /// Получение суммы в темпокассе
        /// </summary>
        /// <param name="currency"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage GetNonAtmAmount(string currency)
        {
            String nonAtmAmount = _repo.GetEncashmentNonAmount(currency);
            return Request.CreateResponse(HttpStatusCode.OK, nonAtmAmount);
        }

        /// <summary>
        /// Проверка на незавершенные операции, перед инкассацией
        /// </summary>
        /// <param name="operation"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage IfEncashmentAlowed(String operation)
        {
            Boolean alowed = _repo.IfAllowedEncashment(operation);
            return Request.CreateResponse(HttpStatusCode.OK, alowed);
        }

        /// <summary>
        /// обработка события технических кнопок, CheckVisaDocs,  CheckStornoDocs
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage DocsAndTechnicalSubmit(TellerRequestModel data)
        {
            TellerCurrentRole role = _repo.GetRole();
            if (data.Method == "CheckStornoDocs" && role == TellerCurrentRole.Tempockassa)
            {
                String errText = "";
                foreach(Decimal Ref in data.Ref)
                {
                    TellerResponseModel resp = _repo.Storno(Ref);
                    if (resp.Result == 1 && !String.IsNullOrEmpty(resp.P_errtxt))
                        errText += resp.P_errtxt + "\n";
                }
                if(!String.IsNullOrEmpty(errText))
                    return Request.CreateResponse(HttpStatusCode.OK, new TellerResponseModel { P_errtxt = errText, Result = 0 });
            }
            TellerResponseModel model = _repo.DocsAndTechnical(data);
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }

        /// <summary>
        /// Отримання статусу операції
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage TellerStatus()
        {
            TellerStatus status = _repo.GetTellerStatus();
            return Request.CreateResponse(HttpStatusCode.OK, status);
        }

        /// <summary>
        /// Перевірка зміни статусу АТМ для виведення повідомлення про
        /// необхідність забрати решту з АТМ
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage GetATMStatus(Boolean http)
        {
            TellerStatusModel status = _repo.TellerStatus(http);
            return Request.CreateResponse(HttpStatusCode.OK, status);
        }

        /// <summary>
        /// обработка запросов инкассирования
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage Encashment(EncashmentModel data)
        {
            return Request.CreateResponse(HttpStatusCode.OK, _repo.Encashment(data));
        }

        /// <summary>
        /// Видача решти
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage ChangeRequest(TellerWindowStatusModel data)
        {
            TellerResponseModel model = _repo.ChangeRequest(data);
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }

        /// <summary>
        /// Часткова інкассація
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage CollectPartial(PartialCashinModel data)
        {
            String xml = Serialize<List<ATMCurrencyListModel>>(data.List);
            TellerResponseModel model = _repo.CollectPartial(xml, data.Currency);
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }

        /// <summary>
        /// Серіалізація об'єкту
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="obj"></param>
        /// <returns></returns>
        private String Serialize<T>(T obj)
        {
            var stringwriter = new StringWriter();
            var serializer = new XmlSerializer(typeof(T));
            serializer.Serialize(stringwriter, obj);
            return stringwriter.ToString();
        }

        /// <summary>
        /// Підтвердження проведення операції інкасайії через ТОХ
        /// </summary>
        /// <param name="docRef"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage ConfirmTox(ConfirmTox tox)
        {
            var model = new { result = _repo.ConfirmTox(tox) };
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }

        /// <summary>
        /// Видалення операції інкассації зі списку проведення через ТОХ
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage RemoveOper(Int32 id)
        {
            TellerResponseModel model = _repo.RemoveOper(id);
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }
    }
}
