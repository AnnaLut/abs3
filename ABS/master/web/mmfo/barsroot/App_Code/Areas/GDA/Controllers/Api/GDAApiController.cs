using BarsWeb.Areas.GDA.Infrastructure.DI.Abstract;
using BarsWeb.Areas.GDA.Infrastructure.DI.Implementation;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Areas.GDA.Models;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Net.Http.Headers;
using System.Xml;
using System.Xml.Serialization;
using Xml2CSharp;
using System.Xml.Linq;
using Kendo.Mvc.Extensions;
using System.Text;
using BarsWeb.Areas.GDA.Models;
using Oracle.DataAccess.Client;
using System.Web;
using Bars.EAD;
using ibank.core;

namespace BarsWeb.Areas.GDA.Controllers.Api
{
    [AuthorizeApi]
    public class GDAController : ApiController
    {
        readonly IGDARepository _repo;

        ///// <summary>
        ///// Кода документов в ЕА
        ///// </summary>
        //private readonly String[] structCodes = new String[] { "0930001", "0940001", "0930002", "0930003", "0940002" };

        public GDAController(IGDARepository repo) { _repo = repo; }

        //Контроллеры для справочников ММСБ (начало блока)

        //Контроллер для заполнения грида опций Базова ставка по депозиту ММСБ
        [HttpGet]
        public HttpResponseMessage GetGeneralInfo([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.GetList();
                decimal dataCount = data.Count;


                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //Контроллер для заполнения грида опций Акційна ставка по депозиту ММСБ
        [HttpGet]
        public HttpResponseMessage GetActionInfo([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.GetActionList();
                decimal dataCount = data.Count;


                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //Контроллер для заполнения грида опций Виплата по депозиту ММСБ
        [HttpGet]
        public HttpResponseMessage GetPaymentInfo([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.GetPaymentList();
                decimal dataCount = data.Count;


                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //Контроллер для заполнения грида опций Капіталізація по депозиту ММСБ
        [HttpGet]
        public HttpResponseMessage GetCapitalizationInfo([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.GetCapitalizationList();
                decimal dataCount = data.Count;


                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //Контроллер для заполнения грида опций Пролонгація по депозиту ММСБ
        [HttpGet]
        public HttpResponseMessage GetProlongationInfo([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.GetProlongationList();
                decimal dataCount = data.Count;


                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //Контроллер для заполнения грида опций Шкала % ставок при достроковому поверненню траншів
        [HttpGet]
        public HttpResponseMessage GetPenaltyInfo([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.GetPenaltyList();
                decimal dataCount = data.Count;


                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //Контроллер для заполнения грида опций Суми траншів
        [HttpGet]
        public HttpResponseMessage GetSumTranchesInfo([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.GetSumTrancheList();
                decimal dataCount = data.Count;


                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //Контроллер для заполнения грида опций опций Строки поповнення траншів
        [HttpGet]
        public HttpResponseMessage GetTimeAddTranchesInfo([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.GetTimeAddTrancheList();
                decimal dataCount = data.Count;


                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //Контроллер для заполнения грида опций Пополнения по депозиту ММСБ!!!
        [HttpGet]
        public HttpResponseMessage GetReplenishmentInfo([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.GetReplenishmentList();
                decimal dataCount = data.Count;


                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //Контроллер для заполнения грида опций Базова ставка по депозиту ММСБ!!!
        [HttpGet]
        public HttpResponseMessage GetDepositDemandInfo([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.GetDepositDemandList();
                decimal dataCount = data.Count;


                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //Контроллер для заполнения грида опций Ставка заблокованого траншу
        [HttpGet]
        public HttpResponseMessage GetBlockRateInfo([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.GetBlockRateList();
                decimal dataCount = data.Count;


                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        //Контроллер для заполнения грида опций бонусна ставка при пролонгации
        [HttpGet]
        public HttpResponseMessage GetBonusProlongationInfo([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.GetBonusProlongationList();
                decimal dataCount = data.Count;


                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //Контроллер для получения Способ начисление по депозиту ММСБ
        [HttpGet]
        public HttpResponseMessage GetDepositDemandTypeInfo([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.GetDepositOnDemandCalcTypeList();
                decimal dataCount = data.Count;


                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //Контроллеры для добавления новой опции и кондишина(который связан с опцией) вкладки Акційна ставка по депозиту ММСБ
        [HttpPost]
        public HttpResponseMessage SetActionOption(ActionOption opt)
        {

            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetActionOption(opt) }, Total = 1 });

            }
            catch (Exception ex)
            {
                //return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        [HttpPost]
        public HttpResponseMessage SetActionCondition(CONDITION condition)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetActionCondition(condition) }, Total = 1 });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        //

        //Контроллеры для добавления новой опции и кондишина(который связан с опцией) вкладки Виплата по депозиту ММСБ
        [HttpPost]
        public HttpResponseMessage SetPaymentOption(PaymentOption opt)
        {

            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetPaymentOption(opt) }, Total = 1 });

            }
            catch (Exception ex)
            {
                //return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        [HttpPost]
        public HttpResponseMessage SetPaymentCondition(CONDITION condition)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetPaymentCondition(condition) }, Total = 1 });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        //

        //Контроллеры для добавления новой опции и кондишина(который связан с опцией) вкладки Капіталізація по депозиту ММСБ
        [HttpPost]
        public HttpResponseMessage SetCapitalizationOption(CapitalizationOption opt)
        {

            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetCapitalizationOption(opt) }, Total = 1 });

            }
            catch (Exception ex)
            {
                //return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        [HttpPost]
        public HttpResponseMessage SetCapitalizationCondition(CONDITION condition)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetCapitalizationCondition(condition) }, Total = 1 });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        //

        //Контроллеры для добавления новой опции и кондишина(который связан с опцией) вкладки Пролонгація по депозиту ММСБ
        [HttpPost]
        public HttpResponseMessage SetProlongationOption(ProlongationOption opt)
        {

            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetProlongationOption(opt) }, Total = 1 });

            }
            catch (Exception ex)
            {
                //return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        [HttpPost]
        public HttpResponseMessage SetProlongationCondition(CONDITION condition)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetProlongationCondition(condition) }, Total = 1 });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        //

        //Контроллеры для добавления новой опции и кондишина(который связан с опцией) вкладки Шкала % ставок при достроковому поверненню траншів
        [HttpPost]
        public HttpResponseMessage SetPenaltyOption(PenaltyOption opt)
        {

            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetPenaltyOption(opt) }, Total = 1 });

            }
            catch (Exception ex)
            {
                //return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        [HttpPost]
        public HttpResponseMessage SetPenaltyCondition(CONDITION condition)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetPenaltyCondition(condition) }, Total = 1 });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        //

        //Контроллеры для добавления новой опции вкладки Суми траншів
        public HttpResponseMessage SetSumTracheOption(SumOption option)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetSumTrancheOption(option) }, Total = 1 });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        //

        [HttpPost]
        public HttpResponseMessage SetSumTrancheCondition(CONDITION condition)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetSumTrancheCondition(condition) }, Total = 1 });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }

        //Контроллеры для добавления новой опции Строки поповнення траншів
        public HttpResponseMessage SetTimeAddTranche(TimeAddTranchesOption option)
        {
            try
            {

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetTimeAddTrancheOption(option) }, Total = 1 });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        //
        public HttpResponseMessage SetTimeAddTrancheCondition(CONDITION condition)
        {
            try
            {

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetTimeAddTrancheCondition(condition) }, Total = 1 });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }


        [HttpPost]
        public HttpResponseMessage SetDepositDemand(DepositDemandOption option)
        {
            try
            {

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetDepositDemandOption(option) }, Total = 1 });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }

        [HttpPost]
        public HttpResponseMessage SetDepositCondition(CONDITION condition)
        {
            try
            {

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetDepositDemandCondition(condition) }, Total = 1 });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        //
        [HttpPost]
        public HttpResponseMessage SetDepositDemandCalcType(DepositOnDemandType option)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetDepositOnDemandCalcType(option) }, Total = 1 });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }

        //[HttpPost]
        //public HttpResponseMessage SetDepositDemandCalcTypeCondition(CONDITION condition)
        //{
        //    try
        //    {

        //        return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetDepositDemandCalcCondition(condition) }, Total = 1 });

        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

        //    }
        //}
        //Контроллер для добавления новой опции и условия для справочника Пополнения
        public HttpResponseMessage SetReplenishmentOption(ReplenishmentOption option)
        {
            try
            {

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetReplenishmentOption(option) }, Total = 1 });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        //
        public HttpResponseMessage SetReplenishmentCondition(CONDITION condition)
        {
            try
            {

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetReplenishmentCondition(condition) }, Total = 1 });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        //

        private static string ExeptionProcessing(Exception ex)
        {
            string txt = "";
            var ErrorText = ex.Message.ToString();

            byte[] strBytes = Encoding.UTF8.GetBytes(ErrorText);
            ErrorText = Encoding.UTF8.GetString(strBytes);

            var x = ErrorText.IndexOf("ORA");
            var ora = ErrorText.Substring(x + 4, 5); //-20001

            if (x < 0)
                return ErrorText;

            decimal oraErrNumber;
            if (!decimal.TryParse(ora, out oraErrNumber))
                return ErrorText;

            if (oraErrNumber >= 20000)
            {
                var ora1 = ErrorText.Substring(x + 11);
                var y = ora1.IndexOf("ORA");
                if (x > -1 && y > 0)
                {
                    txt = ErrorText.Substring(x + 11, y - 1);
                }
                else
                {
                    txt = ErrorText;
                }

                string tmpResult = txt.Replace('ы', 'і');
                return tmpResult;
            }
            else
                return ErrorText;
        }


        //Контроллеры для добавления новой опции и кондишина(который связан с опцией) вкладки Базова ставка по депозиту ММСБ
        [HttpPost]
        public HttpResponseMessage SetGeneralOption(Option genopt)
        {

            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetOption(genopt) }, Total = 1 });

            }
            catch (Exception ex)
            {

                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        [HttpPost]
        public HttpResponseMessage SetGeneralCondition(CONDITION condition)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetCondition(condition) }, Total = 1 });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }

        //Контроллеры для добавления новой опции и кондишина(который связан с опцией) вкладки Ставка заблокованого траншу
        [HttpPost]
        public HttpResponseMessage SetBlockRateOption(Option opt)
        {

            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetBlockRateOption(opt) }, Total = 1 });

            }
            catch (Exception ex)
            {
                //return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        [HttpPost]
        public HttpResponseMessage SetBlockRateCondition(CONDITION condition)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetBlockRateCondition(condition) }, Total = 1 });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }

        //Контроллеры для добавления новой опции и кондишина(который связан с опцией) вкладки бонусна ставка при пролонгации
        [HttpPost]
        public HttpResponseMessage SetBonusProlongationOption(Option opt)
        {

            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetBonusProlongationOption(opt) }, Total = 1 });

            }
            catch (Exception ex)
            {
                //return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        [HttpPost]
        public HttpResponseMessage SetBonusProlongationCondition(CONDITION condition)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = new[] { _repo.SetBonusProlongationCondition(condition) }, Total = 1 });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));

            }
        }
        //

        // Контроллеры для справочников ММСБ (конец блока)



        //Контроллеры для реализации Строковых траншей ММСБ (начало блока)
        [HttpGet]
        public HttpResponseMessage GetCurrency([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var sql = SqlCreator.GetCurrencyList();
                var data = _repo.SearchGlobal<Currency>(request, sql);


                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetCalcType([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var sql = SqlCreator.GetDepositOnDemandCalcType();
                var data = _repo.SearchGlobal<DepositOnDemandCalcType>(request, sql);


                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetDebitAcc([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string currencyId, string customerId)
        {
            try
            {
                var sql = SqlCreator.GetDebitAccountList(currencyId, customerId);
                var data = _repo.SearchGlobal<DebitAcc>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetPaymentTerm([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var sql = SqlCreator.GetPaymentList();
                var data = _repo.SearchGlobal<PaymentTerm>(request, sql);
                //decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetCapitalizationTerm([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var sql = SqlCreator.GetCapitalizationList();
                var data = _repo.SearchGlobal<PaymentTerm>(request, sql);
                //decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetPaymentTermTranche([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var sql = SqlCreator.GetPaymentListTranche();
                var data = _repo.SearchGlobal<PaymentTermTranche>(request, sql);
                //decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage GetProlongationList([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var sql = SqlCreator.GetProlongationList();
                var data = _repo.SearchGlobal<ProlongationList>(request, sql);
                //decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage GetProlongatioTrancheList([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var sql = SqlCreator.GetProlongationTrancheList();
                var data = _repo.SearchGlobal<ProlongationTrancheList>(request, sql);
                //decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //Контроллер для получение спареного выпадающего списка в форме размещения транша фронт офиса ММСБ
        [HttpGet]
        public HttpResponseMessage GetNumberProlongationList([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string startDate, string currencyId)
        {
            try
            {

                var sql = SqlCreator.GetNumberProlongationList(startDate, currencyId);
                var data = _repo.SearchGlobal<NumProlongation>(request, sql);
                //decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetCapitalizationTrancheList([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var sql = SqlCreator.GetCapitalizationTrancheList();
                var data = _repo.SearchGlobal<CapitalizationTrancheList>(request, sql);
                //decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchRequireDeposits([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string rnk)
        {
            try
            {

                var sql = SqlCreator.GetRequireDeposits(rnk);
                var data = _repo.SearchGlobal<RequireDeposits>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }


        [HttpGet]
        public HttpResponseMessage SearchAccounts([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string rnk)
        {
            try
            {
                var sql = SqlCreator.GetDepositAccount(rnk);
                var data = _repo.SearchGlobal<DepositAccountModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //[HttpGet]
        //public HttpResponseMessage SearchAccounts([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, ulong nd)
        //{
        //    try
        //    {
        //        //var sql = SqlCreator.SearchMain();
        //        //var data = _repo.SearchGlobal<Tranches>(request, sql);
        //        //decimal dataCount = _repo.CountGlobal(request, sql);

        //        List<AccData> data = new List<AccData>();
        //        for (int i = 0; i < 50; i++)
        //        {
        //            data.Add(new AccData { Acc = (ulong)(100000 * i), DateOpen = DateTime.Now, Balance = i * 100, Kv = "UAN" });
        //        }
        //        decimal dataCount = data.Count;

        //        return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
        //    }
        //}


        //Контроллер для заполнения грида Портфель ДБО
        [HttpGet]
        public HttpResponseMessage SearchDBO([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var sql = SqlCreator.GetDboPortfolio();
                var data = _repo.SearchGlobal<DboData>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        //Получить дату для отображения в окне Вклада на требования когда заходим через вкладку операциониста
        //    [HttpGet]
        //    public HttpResponseMessage countLastReplenishmentDate(string startDate, string expiryDate)
        //    {
        //        try
        //        {
        //            var sql = SqlCreator.CountLastReplenishmentDate(startDate, expiryDate);
        //            var data = _repo.ExecuteStoreQuery<DateTime?>(sql);

        //            return Request.CreateResponse(HttpStatusCode.OK, data);
        //        }

        //        catch (Exception ex)
        //        {
        //            return Request.CreateResponse(HttpStatusCode.OK, ex);
        //        }
        //    }

        //}
        //}
        [HttpGet]
        public HttpResponseMessage GetDateDBOOperationist(string contract_number)
        {
            try
            {
                var sql = SqlCreator.GetDateDBODemand(contract_number);
                var data = _repo.ExecuteStoreQuery<DboData>(sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //Контроллер для заполнения грида Строковые транши
        [HttpGet]
        public HttpResponseMessage SearchTimeTranshes([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string rnk)
        {
            try
            {

                var sql = SqlCreator.GetTimeTranches(rnk);
                var data = _repo.SearchGlobal<TimeTranshes>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchTranches([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, ulong nd, bool isShowClosedTranches, ulong? acc)
        {
            try
            {
                //var sql = SqlCreator.SearchMain();
                //var data = _repo.SearchGlobal<Tranches>(request, sql);
                //decimal dataCount = _repo.CountGlobal(request, sql);

                List<Tranches> data = new List<Tranches>();
                if (!acc.HasValue)
                {
                    return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = 0 });
                }

                int count = isShowClosedTranches ? 5 : 4;
                for (int i = 0; i < count; i++)
                {
                    data.Add(new Tranches
                    {
                        ControllerName = "Іванов І.І.",
                        OperatorName = "Петров П.П.",
                        OperatorDate = DateTime.Now,
                        ControllerDate = DateTime.Now,
                        DateKontr = DateTime.Now,
                        DateReturn = DateTime.Now,
                        Number = (ulong)(100000 + i),
                        SumValue = 100 * i,
                        ReplenishmentTranche = false,
                        State = i
                    });
                }
                decimal dataCount = data.Count;

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage RemoveTranche(Tranche o)
        {
            try
            {
                //BarsSql sql = SqlCreator.AddDealToCmque(o.ND, o.OperType);
                //_repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage GetTranche(Tranche o)
        {
            try
            {
                //BarsSql sql = SqlCreator.AddDealToCmque(o.ND, o.OperType);
                //_repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);


                //PlacementTranche o_ = new PlacementTranche {

                //};

                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetUserInfo()
        {
            try
            {
                GDAUserInfo ui = _repo.ExecuteStoreQuery<GDAUserInfo>(SqlCreator.GetUserInfo()).SingleOrDefault();
                return Request.CreateResponse(HttpStatusCode.OK, ui);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage TransheInfo([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                //var sql = SqlCreator.SearchMain();
                //var data = _repo.SearchGlobal<Tranches>(request, sql);
                //decimal dataCount = _repo.CountGlobal(request, sql);

                List<TrancheInfo> data = new List<TrancheInfo>();
                for (int i = 0; i < 50; i++)
                {
                    data.Add(new TrancheInfo { DateFill = DateTime.Now, SumFill = i * 10000, Status = "Закрыто" });
                }
                decimal dataCount = data.Count;

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage TrancheAutoLog([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                //var sql = SqlCreator.SearchMain();
                //var data = _repo.SearchGlobal<Tranches>(request, sql);
                //decimal dataCount = _repo.CountGlobal(request, sql);

                List<TrancheAutoLog> data = new List<TrancheAutoLog>();
                for (int i = 0; i < 50; i++)
                {
                    data.Add(new TrancheAutoLog { Number = i, DateAutoLog = DateTime.Now, BaseRate = i * 0.1, BonusAutoLog = i * 0.2, Status = "Пролонговано" });
                }
                decimal dataCount = data.Count;

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchInfoBack([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                //var sql = SqlCreator.SearchMain();
                //var data = _repo.SearchGlobal<Tranches>(request, sql);
                //decimal dataCount = _repo.CountGlobal(request, sql);

                List<BackOffInfo> data = new List<BackOffInfo>();
                for (int i = 0; i < 50; i++)
                {
                    data.Add(new BackOffInfo { rnk = i * 100000, contract_number = i * 22222, mfo = i * 33333, typeOperation = "Поповнення траншу", numCurrency = "10 UAH", statusOperation = "На авторизації", nameUser = "Петров О.О.", dateOperation = DateTime.Now });
                }
                decimal dataCount = data.Count;

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage HistoryOp([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                //var sql = SqlCreator.SearchMain();
                //var data = _repo.SearchGlobal<Tranches>(request, sql);
                //decimal dataCount = _repo.CountGlobal(request, sql);

                List<HistoryOp> data = new List<HistoryOp>();
                for (int i = 1; i < 20; i = i + 2)
                {
                    data.Add(new HistoryOp { operation = "Поповнення траншу", numTrache = i * 11111, dateOp = DateTime.Now.AddDays(i), stateOp = "Авторизовано", userRole = "Оператор", userName = "Петренко О.О." });
                }
                decimal dataCount = data.Count;

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }


        //Контроллер для получения данных транша для заполнения формы редактирования
        [HttpGet]
        public HttpResponseMessage GetReplacementTranche(string processId)
        {
            try
            {
                Kernel.Models.BarsSql sql = SqlCreator.GetTrancheFromDB(processId);
                var xmlString = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();

                var tranche = _repo.Deserialize<SMBDepositTranche>(xmlString);

                tranche.ProcessId = processId;

                return Request.CreateResponse(HttpStatusCode.OK, tranche);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.InnerException.Message);
            }
        }

        //Контроллер для получения данных депозита для заполнения формы закрытия
        [HttpGet]
        public HttpResponseMessage GetClosingDepositDemand(string processId, string objectId)
        {
            try
            {
                Kernel.Models.BarsSql sql = SqlCreator.GetClosingDeposit(processId, objectId);
                var xmlString = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();

                var deposit = _repo.Deserialize<SMBDepositOnDemand>(xmlString);

                //deposit.ProcessId = processId;

                return Request.CreateResponse(HttpStatusCode.OK, deposit);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.InnerException.Message);
            }
        }
        //Контроллер для получения данных пролонгации на форме создания/редактирования транша
        [HttpGet]
        public HttpResponseMessage GetProlongationDetails(string processId)
        {
            try
            {
                Kernel.Models.BarsSql sql = SqlCreator.ProlongationDetails(processId);
                var xmlString = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();

                var tranche = _repo.Deserialize<SMBDepositTrancheProlongation>(xmlString);

                return Request.CreateResponse(HttpStatusCode.OK, tranche);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.InnerException.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage GetEditingDepositDemand(string processId)
        {
            try
            {
                Kernel.Models.BarsSql sql = SqlCreator.GetEditingDeposit(processId);
                var xmlString = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();

                var deposit = _repo.Deserialize<SMBDepositOnDemand>(xmlString);

                //deposit.ProcessId = processId;

                return Request.CreateResponse(HttpStatusCode.OK, deposit);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.InnerException.Message);
            }
        }



        //Контроллер для получения данных транша для заполнения формы пополнения
        [HttpGet]
        public HttpResponseMessage GetReplenishTranche(string trancheId, string processId)
        {
            try
            {
                Kernel.Models.BarsSql sql = SqlCreator.GetReplenishTrancheXml(processId, trancheId);
                var xmlString = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();

                var tranche = _repo.Deserialize<SMBDepositTranche>(xmlString);

                //tranche.ProcessId = processId;

                return Request.CreateResponse(HttpStatusCode.OK, tranche);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.InnerException.Message);
            }
        }
        //Контроллер для получения данных оператора и контроллера
        [HttpGet]
        public HttpResponseMessage GetOperatorControllerInfo(string processId)
        {
            try
            {
                Kernel.Models.BarsSql sql = SqlCreator.GetOperatorController(processId);
                var xmlString = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();

                var tranche = _repo.Deserialize<UsersActivity>(xmlString);

                return Request.CreateResponse(HttpStatusCode.OK, tranche);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.InnerException.Message);
            }
        }
        //Контроллер для получения данных транша для заполнения формы досрочного возврата
        [HttpGet]
        public HttpResponseMessage GetEarlyPaymentTranche(string trancheId, string processId)
        {
            try
            {
                Kernel.Models.BarsSql sql = SqlCreator.GetEarlyRepaymentTrancheXml(processId, trancheId);
                var xmlString = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();

                var tranche = _repo.Deserialize<SMBDepositTranche>(xmlString);

                //tranche.ProcessId = processId;

                return Request.CreateResponse(HttpStatusCode.OK, tranche);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.InnerException.Message);
            }
        }

        //Контроллер для получения данных истории пополнения транша
        [HttpGet]
        public HttpResponseMessage GetReplenishmentHistory([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string trancheId)
        {
            try
            {
                var sql = SqlCreator.GetReplenishmentHistory(trancheId);
                var data = _repo.SearchGlobal<ReplenishmentHistory>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);


                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.InnerException.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage Autorize(string processId)
        {
            string errorMess = "";
            try
            {
                var sql = SqlCreator.Autorize(processId, errorMess);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                try
                {
                    errorMess = ((OracleParameter)sql.SqlParams[3]).Value.ToString();
                }
                catch (Exception e)
                {
                    return Request.CreateResponse(HttpStatusCode.InternalServerError, e.Message);
                }

                return Request.CreateResponse(HttpStatusCode.OK, errorMess);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage RemoveTimeTranche(string processId, string comment)
        {
            string errorMess = "";
            comment = HttpUtility.UrlDecode(comment);
            try
            {
                var sql = SqlCreator.CancelTimeTranche(processId, comment);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK, errorMess);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        [HttpPost]
        public HttpResponseMessage RemoveReplenishment(string processId, string comment)
        {
            string errorMess = "";
            comment = HttpUtility.UrlDecode(comment);

            try
            {
                var sql = SqlCreator.CancelReplenishment(processId, comment);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK, errorMess);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage RemoveRequireDeposit(string processId, string comment)
        {
            string errorMess = "";
            comment = HttpUtility.UrlDecode(comment);
            try
            {
                var sql = SqlCreator.CancelRequireDeposit(processId, comment);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK, errorMess);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage Reject(AuthorizeDataModel data)
        {
            try
            {
                var sql = SqlCreator.Reject(data.ProcessId, data.Comment, "");
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                return Request.CreateResponse(HttpStatusCode.OK, "Success");
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage AutorizeOnDemand(string processId, string type)
        {
            string errorMess = "";
            try
            {
                var sql = SqlCreator.AutorizeOnDemand(processId, errorMess, type);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                try
                {
                    errorMess = ((OracleParameter)sql.SqlParams[3]).Value.ToString();
                }
                catch (Exception e)
                {
                    return Request.CreateResponse(HttpStatusCode.InternalServerError, e.Message);
                }

                return Request.CreateResponse(HttpStatusCode.OK, errorMess);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage RejectOnDemand(AuthorizeDataModel data)
        {
            try
            {
                var sql = SqlCreator.RejectOnDemand(data.ProcessId, data.Comment, "", data.Type);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                return Request.CreateResponse(HttpStatusCode.OK, "Success");
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetBlockTypes([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var sql = SqlCreator.GetBlockTypes();
                var data = _repo.SearchGlobal<BlockType>(request, sql);
                //decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage Block(BlockModel data)
        {
            DateTime lockDate;
            if (!DateTime.TryParse(data.Date, out lockDate))
                lockDate = DateTime.Now;

            try
            {
                var sql = SqlCreator.Block(data.ProcessId, data.Comment, lockDate, data.BlockType);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                return Request.CreateResponse(HttpStatusCode.OK, "Success");
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage Unblock(BlockModel data)
        {
            DateTime lockDate;
            if (!DateTime.TryParse(data.Date, out lockDate))
                lockDate = DateTime.Now;

            try
            {
                var sql = SqlCreator.Unblock(data.ProcessId, data.Comment, lockDate);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                return Request.CreateResponse(HttpStatusCode.OK, "Success");
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage CloseDeposit(CloseDepositModel model)
        {
            try
            {
                string processId = "";
                string xml = _repo.Serialize<SMBDepositOnDemand>(model.deposite);
                var sql = SqlCreator.CloseDeposit(model.processId, model.objectId, xml);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                processId = ((OracleParameter)sql.SqlParams[0]).Value.ToString();

                return Request.CreateResponse(HttpStatusCode.OK, processId);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        #region SAVE DATA

        //Контроллер для сохранения нового транша
        [HttpPost]
        public HttpResponseMessage SavePlacementTranche(SMBDepositTranche o)
        {
            try
            {
                string processId = "";

                string xml = _repo.Serialize<SMBDepositTranche>(o);

                Kernel.Models.BarsSql sql = SqlCreator.SaveReplacementTranche(o.ProcessId, xml);

                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                processId = ((OracleParameter)sql.SqlParams[0]).Value.ToString();

                return Request.CreateResponse(HttpStatusCode.OK, processId);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //Контроллер для подсчета % ставки
        [HttpPost]
        public HttpResponseMessage CountPlacementTranche(SMBDepositTranche o)
        {
            try
            {

                string xml = _repo.Serialize<SMBDepositTranche>(o);
                Kernel.Models.BarsSql sql = SqlCreator.CountPlacementTranche(xml);
                var xmlString = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();

                var percentStavka = _repo.Deserialize<SMBDepositTrancheInterestRate>(xmlString);



                return Request.CreateResponse(HttpStatusCode.OK, percentStavka);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.InnerException.Message);
            }
        }

        //Контроллер для подсчета % ставки (бэк-оф)
        [HttpGet]
        public HttpResponseMessage CountPlacementTrancheBack(string processId)
        {
            try
            {
                Kernel.Models.BarsSql sqlTranshe = SqlCreator.GetTrancheFromDB(processId);
                var xml = _repo.ExecuteStoreQuery<string>(sqlTranshe).FirstOrDefault();

                Kernel.Models.BarsSql sql = SqlCreator.CountPlacementTranche(xml);
                var xmlString = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();
                var percentStavka = _repo.Deserialize<SMBDepositTrancheInterestRate>(xmlString);
                return Request.CreateResponse(HttpStatusCode.OK, percentStavka);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.InnerException.Message);
            }
        }

        //Контроллер для сохранения пополненого транша
        [HttpPost]
        public HttpResponseMessage SaveRepleishmentTranche(SMBDepositTranche o)
        {
            try
            {
                string processId = "";

                string xml = _repo.Serialize<SMBDepositTranche>(o);

                Kernel.Models.BarsSql sql = SqlCreator.SaveReplenishTrancheXml(o.ProcessId, o.ObjectId, xml);

                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                processId = ((OracleParameter)sql.SqlParams[0]).Value.ToString();

                return Request.CreateResponse(HttpStatusCode.OK, processId);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //Контроллер для сохранения отредактируемого транша
        [HttpPost]
        public HttpResponseMessage SaveReplacementTranche(SMBDepositTranche o)
        {

            var data = _repo.SetReplacementTranche(o);
            try
            {


                return Request.CreateResponse(HttpStatusCode.OK, new { data });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //Контроллер для сохранения дострочного возврата транша
        [HttpPost]
        public HttpResponseMessage SaveEarlyRepaymentTranche(SMBDepositTranche o)
        {
            try
            {
                string xml = _repo.Serialize<SMBDepositTranche>(o);

                Kernel.Models.BarsSql sql = SqlCreator.SaveEarlyRepaymentTrancheXml(o.ProcessId, o.ObjectId, xml);

                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage SaveDepositDemand(SMBDepositOnDemand o)
        {
            try
            {
                string processId = "";

                string xml = _repo.Serialize<SMBDepositOnDemand>(o);

                Kernel.Models.BarsSql sql = SqlCreator.SaveDepositDemand(o.ProcessId, xml);

                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                processId = ((OracleParameter)sql.SqlParams[0]).Value.ToString();

                return Request.CreateResponse(HttpStatusCode.OK, processId);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        #endregion

        //---------------------------------------------------------------------------------------------------------

        #region AUTH DATA

        //Контроллер для авторизации нового транша
        [HttpPost]
        public HttpResponseMessage AuthTranche([FromBody]string processId)
        {
            try
            {
                Kernel.Models.BarsSql sql = SqlCreator.AuthTranche(processId);

                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage ReturningAuthTranche([FromBody]string processId)
        {
            try
            {
                Kernel.Models.BarsSql sql = SqlCreator.ReturningAuthTranche(processId);

                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage AuthDeposit([FromBody]string processId)
        {
            try
            {
                Kernel.Models.BarsSql sql = SqlCreator.AuthDeposit(processId);

                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage AuthDepositClose([FromBody]string processId)
        {
            try
            {
                Kernel.Models.BarsSql sql = SqlCreator.AuthDepositClose(processId);

                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        [HttpPost]
        public HttpResponseMessage AuthChangeCalcType([FromBody]string processId)
        {
            try
            {
                Kernel.Models.BarsSql sql = SqlCreator.AuthChangeCalculationType(processId);

                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }


        //Контроллер для авторизации отредактируемого транша
        //[HttpPost]
        //public HttpResponseMessage AuthReplacementTranche(SMBDepositTranche o)
        //{

        //    string ProcessId = o.ProcessId;
        //    try
        //    {
        //        Kernel.Models.BarsSql sql = SqlCreator.AuthReplacementTranche(o.ProcessId);

        //        _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

        //        return Request.CreateResponse(HttpStatusCode.OK);
        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
        //    }
        //}

        //Контроллер для авторизации пополненого транша
        //[HttpPost]
        //public HttpResponseMessage AuthReplenishmentTranche(SMBDepositTranche o)
        //{
        //    try
        //    {
        //        string ProcessId = o.ProcessId;

        //        Kernel.Models.BarsSql sql = SqlCreator.AuthReplenishmentTranche(o.ProcessId);

        //        _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

        //        return Request.CreateResponse(HttpStatusCode.OK);

        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
        //    }
        //}



        //Контроллер для авторизации дострочного возврата транша
        //[HttpPost]
        //public HttpResponseMessage AuthEarlyRepaymentTranche(SMBDepositTranche o)
        //{
        //    string ProcessId = o.ProcessId;
        //    try
        //    {
        //        Kernel.Models.BarsSql sql = SqlCreator.AuthEarlyRepaymentTranche(o.ProcessId);

        //        _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

        //        return Request.CreateResponse(HttpStatusCode.OK);
        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
        //    }
        //}

        //Контроллер для авторизации дострочного возврата транша
        //[HttpPost]
        //public HttpResponseMessage AuthEditReplenishmentTranche(SMBDepositTranche o)
        //{
        //    string ProcessId = o.ProcessId;
        //    try
        //    {
        //        Kernel.Models.BarsSql sql = SqlCreator.AuthEditReplenishmentTranche(o.ProcessId);

        //        _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

        //        return Request.CreateResponse(HttpStatusCode.OK);
        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
        //    }
        //}

        //[HttpPost]
        //public HttpResponseMessage AuthDepositDemand(SMBDepositTranche o)
        //{
        //    string ProcessId = o.ProcessId;
        //    try
        //    {
        //        Kernel.Models.BarsSql sql = SqlCreator.AuthDepositDemand(o.ProcessId);

        //        _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

        //        return Request.CreateResponse(HttpStatusCode.OK);
        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
        //    }
        //}
        #endregion

        #region PRINT PDF
        [HttpGet]
        [AttributeRouting.Web.Http.GET("api/gda/gda/print/{formIdId}/{Id}/{Rnk}")]
        public HttpResponseMessage Print(string formIdId, decimal Id, decimal? rnk)
        {
            if (formIdId == "replacementTranche")
            {
                return InitDocument("MMSB_ZAYAVA_ROZMISHCHENNYA_TRANSHU.FRX", "0930001", "zayava_mmsb_tranche.pdf", rnk, Id);
            }
            else if (formIdId == "editDepositDemand" || formIdId == "depositDemand")
            {
                return InitDocument("MMSB_ZAYAVA_VIDKRYTYA_VKLADU_NA_VYMOGU.FRX", "0940001", "zayava_mmsb_deposit.pdf", rnk, Id);
            }
            else if (formIdId == "replenishmentTranche")
            {
                return InitDocument("MMSB_ZAYAVA_POPVN.FRX", "0930002", "zayava_mmsb_popovnennya.pdf", rnk, Id);
            }
            else if (formIdId == "earlyRepaymentTranche")
            {
                return InitDocument("MMSB_ZAYAVA_VOZVRAT.FRX", "0930003", "zayava_mmsb_dostrokove_povernennya.pdf", rnk, Id);
            }
            else if (formIdId == "closeDepositDemand")
            {
                return InitDocument("MMSB_ZAYAVA_ZAKR_VKLD.FRX", "0940002", "zayava_mmsb_zakrytya_vkladu_na_vumogy.pdf", rnk, Id);
            }
            return Request.CreateResponse(HttpStatusCode.InternalServerError, "Unknown formId");
        }
        #endregion

        private HttpResponseMessage InitDocument(string templateName, string eaStructID, string _fileName, decimal? _rnk, decimal _id)
        {

            HttpResponseMessage result = new HttpResponseMessage(HttpStatusCode.OK);
            EadPack ep = new EadPack(new BbConnection());

            var param = new FrxParameters { };
            string templatePath = FrxDoc.GetTemplatePathByFileName(templateName);
            decimal? AgrID = null;
            string TemplateID = templateName.Substring(0, templateName.Length - 4);
            decimal? RNK = _rnk;

            decimal? _DocId = ep.DOC_CREATE("DOC", TemplateID, null, eaStructID, RNK, AgrID);

            //только для пополнения нужно другой параметр передать
            if (templateName == "MMSB_ZAYAVA_POPVN.FRX")
            {
                param = new FrxParameters
                {
                new FrxParameter("p_porcess_id", TypeCode.Int64, _id),
                new FrxParameter("p_doc_id", TypeCode.Int64, Convert.ToInt64(_DocId.Value.ToString()))
                };
            }
            //для остальных одинаково
            else
            {
                param = new FrxParameters
                {
                new FrxParameter("p_deposit_id", TypeCode.Int64, _id),
                new FrxParameter("p_doc_id", TypeCode.Int64, Convert.ToInt64(_DocId.Value.ToString()))
                };
            }





            var doc = new FrxDoc(templatePath, param, null);
            using (var str = new MemoryStream())
            {
                doc.ExportToMemoryStream(FrxExportTypes.Pdf, str);

                var biteArray = str.ToArray();
                result.Content = new ByteArrayContent(biteArray);
                result.Content.Headers.ContentType = new MediaTypeHeaderValue("application/pdf");
                result.Content.Headers.ContentDisposition =
                    new ContentDispositionHeaderValue("attachment")
                    {
                        FileName = _fileName

                    };
            }
            return result;
        }

        [HttpGet]
        public HttpResponseMessage GetCalculationType()
        {
            try
            {
                var sql = SqlCreator.GetCalculationType();
                var data = _repo.ExecuteStoreQuery<CalculationTypeModel>(sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage ChangeCalculationType(ChangeCalcTypePostModel postModel)
        {
            try
            {
                var processId = string.Empty;

                var sql = SqlCreator.ChangeCalculationType(postModel);

                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                processId = ((OracleParameter)sql.SqlParams[0]).Value.ToString();

                return Request.CreateResponse(HttpStatusCode.OK, processId);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //Контроллер для подсчета % ставки на вкладах на вимогу
        [HttpPost]
        public HttpResponseMessage countdepositDemand(SMBDepositOnDemand o)
        {
            try
            {

                string xml = _repo.Serialize<SMBDepositOnDemand>(o);
                Kernel.Models.BarsSql sql = SqlCreator.CountDepositDemand(xml);
                var xmlString = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();

                var percentStavka = _repo.Deserialize<SMBDepositOnDemandInterestRate>(xmlString);


                return Request.CreateResponse(HttpStatusCode.OK, percentStavka);
            }

            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.InnerException.Message);
            }
        }
        //Контроллер для заполнения грида Портфель ДБО операциониста
        [HttpGet]
        public HttpResponseMessage SearchOperationistDBO([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {

                var date = DateTime.Now.ToString("dd.MM.yyyy");
                //var date = "14.08.2018";
                var sql = SqlCreator.GetOperationistDboPortfolio(date);
                var data = _repo.SearchGlobal<OperationistDBOData>(request, sql);
                data = data.ToList();
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        ////Контроллер для подсчета поля "Строк поповнення траншу до"
        [HttpGet]
        public HttpResponseMessage countLastReplenishmentDate(string startDate, string expiryDate)
        {
            try
            {
                var sql = SqlCreator.CountLastReplenishmentDate(startDate, expiryDate);
                var data = _repo.ExecuteStoreQuery<DateTime?>(sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }

            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex);
            }
        }

        //[HttpGet]
        //public HttpResponseMessage GetDocumentsFromEA(String rnk)
        //{
        //    //rnk = rnk.Substring(0, rnk.Length - 2);

        //    try
        //    {
        //        String Kf = _repo.GetKf();
        //        List<Bars.EAD.Structs.Result.DocumentData> eaDocs = new List<Bars.EAD.Structs.Result.DocumentData> {
        //            new Bars.EAD.Structs.Result.DocumentData{ DocLink = "http://www.google.com", Struct_Code = "0930001", Struct_Name = "test.pdf" },
        //            new Bars.EAD.Structs.Result.DocumentData{ DocLink = "http://translate.google.com", Struct_Code = "0940001", Struct_Name = "test.pdf" }
        //        };
        //        //List<Bars.EAD.Structs.Result.DocumentData> eaDocs = EADService.GetDocumentData("", Convert.ToDecimal(rnk), null, null, null, null, null, null, null, Kf);
        //        eaDocs = eaDocs.Where(d => structCodes.Contains(d.Struct_Code) && !String.IsNullOrEmpty(d.DocLink) && !String.IsNullOrEmpty(d.Struct_Name)).ToList();

        //        return Request.CreateResponse(HttpStatusCode.OK, new ResponseForEaView() { ResultObj = eaDocs });
        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateResponse(HttpStatusCode.OK, new ResponseForEaView() { Result = "ERROR", ErrorMsg = ex.Message });
        //    }
        //}
    }
}
//ТестРелиз
