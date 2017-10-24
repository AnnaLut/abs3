using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.PaymentVerification.Infrastructure.DI.Abstract;
using BarsWeb.Areas.PaymentVerification.Infrastructure.DI.Implementation;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Oracle.DataAccess.Client;
using System.Linq;
using Areas.PaymentVerification.Models;

namespace BarsWeb.Areas.PaymentVerification.Controllers.Api
{
    public class PaymentVerificationController: ApiController
    {
        readonly IPaymentVerificationRepository _repo;
        public PaymentVerificationController(IPaymentVerificationRepository repo) { _repo = repo; }

        [HttpPost]
        public HttpResponseMessage CellPhone(CellPhone obj)
        {
            if (string.IsNullOrEmpty(obj.phone))
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Status = "ERROR", Message = "Невказано телефон." });
            }
            if (!obj.skipcode && string.IsNullOrEmpty(obj.code))
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Status = "ERROR", Message = "Невказано код підтвердження." });
            }
            try
            {
                BarsSql sql = SqlCreator.Sms(obj);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                int startIndex = obj.skipcode ? 2 : 3;

                decimal p_result = 0;
                string p_msg = "";
                try {
                    p_result = decimal.Parse(((OracleParameter)sql.SqlParams[startIndex]).Value.ToString());
                }
                catch (Exception e) { }
                try
                {
                    p_msg = ((OracleParameter)sql.SqlParams[++startIndex]).Value.ToString();
                }
                catch (Exception e) { }

                return Request.CreateResponse(HttpStatusCode.OK, new {
                    Status = p_result != 0 ? "ERROR" : "OK",
                    Message = p_msg
                });
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        public HttpResponseMessage GetPhone(CellPhone obj)
        {
            try
            {
                BarsSql sql = SqlCreator.GetPhone(obj);
                System.Collections.Generic.IEnumerable<CellPhoneResult> res = _repo.ExecuteStoreQuery<CellPhoneResult>(sql);
                CellPhoneResult result = res.FirstOrDefault();

                return Request.CreateResponse(HttpStatusCode.OK, new { PHONE = result.PHONE, NMK = result.NMK });
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        public HttpResponseMessage GetPhoto(CellPhone obj)
        {
            try
            {
                if (string.IsNullOrEmpty(obj.rnk) || string.IsNullOrEmpty(obj.image_type))
                {
                    return Request.CreateResponse(HttpStatusCode.InternalServerError, "РНК клієнта, або тип фото пусте.");
                }
                decimal rnk = decimal.Parse(obj.rnk);
                string data = GetPhotoFromDb(rnk, obj.image_type);
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        string GetPhotoFromDb(decimal rnk, string image_type)
        {
            var currentPhoto = Tools.get_cliet_picture(rnk, image_type);
            if (currentPhoto.Length > 0)
            {
                return "data:image/jpg;base64," + Convert.ToBase64String(currentPhoto);
            }
            return "";
        }
    }
}
