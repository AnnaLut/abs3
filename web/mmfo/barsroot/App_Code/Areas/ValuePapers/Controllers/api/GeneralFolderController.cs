using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using BarsWeb.Areas.ValuePapers.Infrastructure.DI.Abstract;
using System.Web.Http.ModelBinding;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using Areas.ValuePapers.Models;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using System.Data;

namespace BarsWeb.Areas.ValuePapers.Controllers.Api
{
    public class GeneralFolderController : ApiController
    {
        private readonly IGeneralFolderRepository _repo;
        private readonly ValuePapersModel _entity;
        public GeneralFolderController(IGeneralFolderRepository repo)
        {
            var connectionStr = EntitiesConnection.ConnectionString("ValuePapersModel", "ValuePapers");
            _entity = new ValuePapersModel(connectionStr);
            _repo = repo;
        }

        

        public HttpResponseMessage GetCpv([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request,
            [FromUri]InitParams initParams)
        {
            try
            {
                var data = _repo.CpV(initParams);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data.ToList().ToDataSourceResult(request));

                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        

        public HttpResponseMessage GetMFGrid([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request,
            [FromUri]MoneyFlowModel data)
        {
            try
            {
                var dataList = _repo.MFGridData(data.REF, data.RB1, data.RB2, data.DAT_ROZ);
                return Request.CreateResponse(HttpStatusCode.OK, dataList.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        public HttpResponseMessage GetCP_OB_INITIATOR([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request)
        {
            try
            {
                var data = _repo.CP_OB_INITIATOR();

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data.ToList().ToDataSourceResult(request));

                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
        public HttpResponseMessage GetCP_OB_MARKET([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request)
        {
            try
            {
                var data = _repo.CP_OB_MARKET();

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data.ToList().ToDataSourceResult(request));

                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        public HttpResponseMessage GetCP_OB_FORM_CALC([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request)
        {
            try
            {
                var data = _repo.CP_OB_FORM_CALC();

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data.ToList().ToDataSourceResult(request));

                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        /// <summary>
        /// Довідник видів договору 
        /// </summary>
        public HttpResponseMessage GetCP_V_OPER([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request)
        {
            try
            {
                var data = _repo.CP_VOPER();

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data.ToList().ToDataSourceResult(request));

                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        /// <summary>
        /// Довідник Класифікації ЦП по типу емітента
        /// </summary>
        public HttpResponseMessage GetCP_KLCPE([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request)
        {
            try
            {
                var data = _repo.CP_KLCPE();

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data.ToList().ToDataSourceResult(request));

                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        public HttpResponseMessage GetContractSaleWindowFixedParams()
        {
            try
            {
                var data = _repo.GetContractSaleWindowFixedParams();

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data);

                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }



        public HttpResponseMessage GetPrepareWndDeal(decimal? p_nOp, decimal? p_fl_END, decimal? p_nGrp, string p_strPar02)
        {
            try
            {
                var data = _repo.PrepareWndDeal(p_nOp, p_fl_END, p_nGrp, p_strPar02);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data);

                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        public HttpResponseMessage GetPrepareIrrWindow(decimal? NMODE1, decimal? REF, decimal? ID, string STRPAR01, string STRPAR02, DateTime? DAT_UG)
        {
            try
            {
                var data = _repo.PrepareIrrWnd(NMODE1,  REF, ID, STRPAR01, STRPAR02, DAT_UG);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data);

                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        public HttpResponseMessage GetIrrGrid([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, decimal? NMODE1, decimal? REF, decimal? ID, string STRPAR01, string STRPAR02, DateTime? DAT_UG)
        {
            try
            {
                var data = _repo.PopulateIrrGrid(NMODE1, REF, ID, STRPAR01, STRPAR02, DAT_UG);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data.ToList().ToDataSourceResult(request));

                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        public HttpResponseMessage GetMoneyFlowParams(decimal? REF)
        {
            try
            {
                var data = _repo.PrepareMoneyFlow(REF);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data);

                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        public HttpResponseMessage GetDataListFor_cbm_PF(decimal? p_DOX, decimal? p_nEMI)
        {
            try
            {
                var data = _repo.dataListFor_cbm_PF(p_DOX, p_nEMI);//.Select(p=> new {TEXT=p.TEXT, VAL = new { Val = p.VAL, PF = p.PF} });

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data);

                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        public HttpResponseMessage GetDataListFor_cbm_RYN(decimal? p_Vidd, decimal? p_Kv, decimal? p_Tipd)
        {
            try
            {
                var data = _repo.dataListFor_cbm_RYN(p_Vidd, p_Kv, p_Tipd);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data);

                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        public HttpResponseMessage Get_NLS_A_and_SVIDD(decimal? NKV, decimal? NRYN, decimal? NVIDD, decimal? P_DOX, decimal? P_NEMI)
        {
            try
            {
                var data = _repo.Get_NLS_A_and_SVIDD(NKV, NRYN, NVIDD, P_DOX, P_NEMI);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data);

                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        public HttpResponseMessage GetRR_(DateTime? DAT_ROZ, decimal? ID, decimal? SUMBN)
        {
            try
            {
                var data = _repo.GetRR_(DAT_ROZ, ID, SUMBN);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { RR_ = data });

                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        public HttpResponseMessage GetCheckMFOB(string MFOB)
        {
            try
            {
                var data = _repo.CheckMFOB(MFOB);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { isValid = data });

                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        public HttpResponseMessage GetCheckNls(string NLS, string MFO)
        {
            try
            {
                string sqlText = @"select case when :p_nls = vkrzn(substr(:p_mfo,1,5), nvl(:p_nls,'2')) then 1 else null end NLS from dual";

                object[] parametrs = {
                    new OracleParameter()
                    {
                        ParameterName = "p_dox",
                        Direction = ParameterDirection.Input,
                        OracleDbType = OracleDbType.Varchar2,
                        Value = NLS
                    },
                    new OracleParameter()
                    {
                        ParameterName = "p_dox",
                        Direction = ParameterDirection.Input,
                        OracleDbType = OracleDbType.Varchar2,
                        Value = MFO
                    }
                };
                bool result = false;
                var data = _entity.ExecuteStoreQuery<PrepareWndDealModel>(sqlText, parametrs).SingleOrDefault();
                if (data == null)
                    result = false;
                else
                    result = data.NLS == 1;


                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { isValid = result });

                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        public HttpResponseMessage GetPartnersFields(string NBB, string MFOB, string NLSB, string OKPOB)
        {
            try
            {
                var dataSet = new PartnerFieldSet() { MFOB = MFOB, NBB = NBB, NLSB = NLSB, OKPOB = OKPOB };
                var data = _repo.GetPartnersFields(dataSet);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data);

                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        public HttpResponseMessage PostFSave(FSaveModel data)
        {
            try
            {
                var resultModel = _repo.FSave(data);
                if(String.IsNullOrEmpty(resultModel.SERR) || resultModel.SERR == "null")
                    return Request.CreateResponse(HttpStatusCode.OK, new {
                        Message = "Угоду збережено з референсом " + resultModel.SREF,
                        NAZN = resultModel.NAZN,
                        REF_MAIN = resultModel.REF_MAIN
                    });
                else
                    return Request.CreateResponse(HttpStatusCode.OK, new { Error = true, Message = resultModel.SERR });
            }
            catch (Exception ex)
            {

                return Request.CreateResponse(HttpStatusCode.OK, new { Error = true, Message = ex.Message });
            }
        }

        public HttpResponseMessage PostDiuMany(IRR_GRID data)
        {
            try
            {
                var res = _repo.Diu_many(data);
                    return Request.CreateResponse(HttpStatusCode.Created, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { Error = true, Message = ex.Message });
            }
        }

        public HttpResponseMessage PostEfectBet()
        {
            try
            {
                var res = _repo.Diu_many(new IRR_GRID() {
                    Action = 10, REF= null, P_FDAT = null, P_SS1 = 0, P_SDP = 0, P_SN2 = 0
                });
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { Error = true, Message = ex.Message });
            }
        }

        public HttpResponseMessage PostCalcFlows(REFClass data)
        {
            try
            {
                _repo.CalcFlows(data.REF);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { Error = true, Message = ex.Message });
            }
        }

        public class REFClass
        {
            public decimal? REF { get; set;}
        }
        public HttpResponseMessage PostDelIir(REFClass data)
        {
            try
            {
                _repo.DelIir(data.REF);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {

                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { Error = true, Message = ex.Message });
            }
        }

        public HttpResponseMessage PostCpAmor(CP_AMOR_Model data)
        {
            try
            {
                var errorList = new List<string>();
                foreach (var item in data.items)
                {
                    string error =  _repo.CP_AMOR(item.REF, item.ID, data.NGRP, data.ADAT);

                    if(error != "null" || String.IsNullOrEmpty(error))
                        errorList.Add(error);
                }
                return Request.CreateResponse(HttpStatusCode.OK, new { errors = String.Join(",", errorList) });
            }
            catch (Exception ex)
            {

                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { Error = true, Message = ex.Message });
            }
        }

        
        public HttpResponseMessage PostMakeAmort(MakeAmortModel data)
        {
            try
            {
                var error = _repo.MakeAmort(data.NGRP, data.FILTER, data.ADAT);
                return Request.CreateResponse(HttpStatusCode.OK, new {error= error });
            }
            catch (Exception ex)
            {

                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { Error = true, Message = ex.Message });
            }
        }

        public HttpResponseMessage PostSetSpecparam(SpecParamDataModel data)
        {
            try
            {
                var result = _repo.SetSpecparam(data.REF_MAIN, data.COD_I, data.COD_M, data.COD_F, data.COD_V, data.COD_O);

                if (String.IsNullOrEmpty(result) || result == "null")
                    return Request.CreateResponse(HttpStatusCode.OK);
                else
                    return Request.CreateResponse(HttpStatusCode.InternalServerError, new { Error = true, Message = result });
            }
            catch (Exception ex)
            {

                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { Error = true, Message = ex.Message });
            }
        }

        public HttpResponseMessage PostSetNazn(FSaveModel data)
        {
            try
            {
                var error = _repo.SetNazn(data);
                if (String.IsNullOrEmpty(error) || error == "null")
                    return Request.CreateResponse(HttpStatusCode.OK);
                else
                    return Request.CreateResponse(HttpStatusCode.OK, new { Error = true, Message = error });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { Error = true, Message = ex.Message });
            }
        }

        public HttpResponseMessage GetDataListForBusMod()
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, _repo.GetDataListForBusMod());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        public HttpResponseMessage GetDataListForSppi()
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, _repo.GetDataListForSppi());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        public HttpResponseMessage GetIFRS(decimal vidd)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { IRFS = _repo.GetIFRS(vidd)});
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

    }
}
