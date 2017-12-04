using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Mvc;
using System.Xml;
using System.Text;
using System.IO;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.BpkW4.Models;
using BarsWeb.Controllers;
using BarsWeb.Areas.InsUi.Models.Transport;
using BarsWeb.Areas.InsUi.Infrastructure.DI.Abstract;
using System.Web.Script.Serialization;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Oracle.DataAccess.Client;
using Bars.Classes;

namespace BarsWeb.Areas.BpkW4.Controllers
{

    [AuthorizeUser]
    public class RegisteringNewCardController : ApplicationController
    {
        private readonly IRegNewCardRepository _cardRepository;
        private readonly IInsRepository _insRepository;

        public RegisteringNewCardController(IRegNewCardRepository cardRepository, IInsRepository insRepository)
        {
            _cardRepository = cardRepository;
            _insRepository = insRepository;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetCardValue(decimal rnk, decimal proectId, string cardCode, bool isIns)
        {
            RegNewValue session = _cardRepository.GetCardValue(rnk, proectId, cardCode, isIns);
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetExternal(decimal rnk)
        {
            RegExternal session = _cardRepository.GetExternal(rnk);
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult OpenCard(RegNewValue par)
        {
            RespOpenCard session = _cardRepository.OpenCard(par);
            return Json(session, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetIsIns(string cardCode)
        {
            var session = _cardRepository.GetIsIns(cardCode);
            return Json(session, JsonRequestBehavior.AllowGet);
        }
        public void SetInsId(decimal nd, decimal ins_id, decimal tmp_id)
        {
            _cardRepository.SetInsId(nd, ins_id, tmp_id);
        }

        public ActionResult CreateDealsEWA(decimal nd, decimal type)
        {
            ParamsBpkIns param = _cardRepository.GetBpkInsParams(nd, "", "ins_w4_deals");
            JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            ParamsEwa objCustomer = _cardRepository.GetParamsEwa(nd, type, cmd);//jsonSerializer.Deserialize<ParamsEwa>(param.request);
            try
            {
                var result = _insRepository.CreateDealEWA(objCustomer, connection);
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            finally
            {
                connection.Dispose();
                connection.Close();
            }
        }

        public ActionResult GetDealReport(decimal nd, string deal_id, string param_page)
        {
            var orderId = new Random();
            ParamsBpkIns param = new ParamsBpkIns();
            if (param_page != "arc")
                param = _cardRepository.GetBpkInsParams(nd, deal_id, "ins_w4_deals");
            else
                param = _cardRepository.GetBpkInsParams(nd, deal_id, "ins_w4_deals_arc");
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(param.response);
            string jsonText = JsonConvert.SerializeXmlNode(doc);
            JObject json = JObject.Parse(jsonText);
            var id = json.SelectToken(@"root.id").Value<decimal>();
            byte[] result = _insRepository.GetReport(id, (decimal)param.insexttmp, false);

            return File(result.ToArray(), "application/pdf", string.Format("deal{1}_{0}.pdf", nd, orderId.Next()));
        }

    }
}
