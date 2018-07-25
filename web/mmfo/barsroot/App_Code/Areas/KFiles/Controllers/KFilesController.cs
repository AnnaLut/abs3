using System;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.KFiles.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.KFiles.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using System.Collections.Generic;
using BarsWeb.Core.Models.Json;
using Kendo.Mvc.UI;
using System.Web.Script.Serialization;

namespace BarsWeb.Areas.KFiles.Controllers
{
    [AuthorizeUser]
    public class KFilesController : ApplicationController
    {
        private readonly IKFilesRepository _kfRepository;
        private readonly IKFilesAccountCorpRepository _repoAccCorp;

        public KFilesController(IKFilesRepository kfRepository, IKFilesAccountCorpRepository repoAccCorp)
        {
            _kfRepository = kfRepository;
            _repoAccCorp = repoAccCorp;
        }

        public ViewResult Index()
        {
            return View();
        }

        /// <summary>
        /// View адміністратора в CA
        /// </summary>
        public ViewResult AdminCa()
        {
            return View();
        }

        /// <summary>
        /// View адміністратора в РУ
        /// </summary>
        public ViewResult AdminRu()
        {
            return View();
        }

        /// <summary>
        /// View Рахунки корпоративних клієнтів.
        /// </summary>
        public ViewResult AccountCorp()
        {
            return View();
        }

        //[HttpPost]
        public ActionResult GetAccountCorp([DataSourceRequest] DataSourceRequest request, List<decimal> corpIndexes)
        {
            List<V_CORP_ACCOUNTS_WEB> data = _repoAccCorp.GetAccountCorp(request, corpIndexes);
            var dataCount = _repoAccCorp.GetAccountCorpDataCount(request, corpIndexes);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        public ActionResult SaveAccCorpWithFilter([DataSourceRequest] DataSourceRequest request, int dropDownType, string value, List<decimal> corpIndexes)
        {
            var result = new JsonResponse();
            try
            {
                List<V_CORP_ACCOUNTS_WEB> data = _repoAccCorp.GetAccountCorp(request, corpIndexes);
                List<AccCorpSave> accCorpSave = CreateAccCorpSave(data, dropDownType, value);
                _repoAccCorp.AccCorpSave(accCorpSave);
                result.Status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                result.Message = "Виникла внутрішня помилка: " + ex.Message;
                result.Status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult GetCorpFilter()
        {
            var res = _repoAccCorp.GetCorpFilter().ToList();
            return Json(res, JsonRequestBehavior.AllowGet);
        }



        [HttpGet]
        public ActionResult GetDropDownAltCorpName([DataSourceRequest] DataSourceRequest request)
        {
            List<V_ROOT_CORPORATION> data = _repoAccCorp.GetDropDownAltCorpName(request);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Отримання корпорацій.
        /// </summary>
        //[OutputCache(NoStore = true, Duration = 0, VaryByParam = "None")]
        //public ActionResult GetCorporations([DataSourceRequest] DataSourceRequest request, bool mode)
        //{
        //    IQueryable<V_OB_CORPORATION> data = _kfRepository.GetCorporations(mode);

        //    return Json(data.Select(s => new { s.ID, s.CORPORATION_NAME, s.CORPORATION_CODE, s.PARENT_ID, s.STATE_ID, s.EXTERNAL_ID, s.CORPORATION_STATE, s.PARENT_NAME }).ToList().ToDataSourceResult(request), JsonRequestBehavior.AllowGet);

        //}


        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "None")]
        public ActionResult GetCorporations([DataSourceRequest] DataSourceRequest request, bool mode, string parentid)
        {
            IQueryable<V_OB_CORPORATION> data = _kfRepository.GetCorporations(mode, parentid);

            return Json(data.Select(s => new { s.ID, s.CORPORATION_NAME, s.CORPORATION_CODE, s.PARENT_ID, s.STATE_ID, s.EXTERNAL_ID, s.CORPORATION_STATE, s.PARENT_NAME }).ToList().ToDataSourceResult(request), JsonRequestBehavior.AllowGet);

        }

        [HttpGet]
        public ActionResult GetCorporationsList([DataSourceRequest] DataSourceRequest request)
        {
            IQueryable<V_OB_CORPORATION> data = _kfRepository.GetCorporationsList(false);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// отримання даних по синхронізації
        /// </summary>
        /// <returns></returns>
        public ActionResult GetSyncData([DataSourceRequest]DataSourceRequest request)
        {
            IEnumerable<V_SYNC_SESSION> data = _kfRepository.GetSyncData(request);
            var dataCount = _kfRepository.GetSyncDataCount(request);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// додавання корпорації чи під Корпорації
        /// </summary>
        [HttpPost]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "None")]
        public ActionResult AddCorporationOrSubCorporation(string CORPORATION_NAME, string CORPORATION_CODE, string EXTERNAL_ID, decimal PARENT_ID)
        {
            var result = new JsonResponse();
            try
            {
                _kfRepository.AddCorporationOrSubCorporation(CORPORATION_NAME, CORPORATION_CODE, EXTERNAL_ID, PARENT_ID);
                result.Status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                result.Message = "Виникла внутрішня помилка: " + ex.Message;
                result.Status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// редагування підрозділів
        /// </summary>
        [HttpPost]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "None")]
        public ActionResult EditCorporation(decimal ID, string CORPORATION_CODE, string CORPORATION_NAME, string EXTERNAL_ID)
        {
            var result = new JsonResponse();
            try
            {
                _kfRepository.EditCorporation(ID, CORPORATION_CODE, CORPORATION_NAME, EXTERNAL_ID);
                result.Status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                result.Message = "Виникла внутрішня помилка: " + ex.Message;
                result.Status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Блокування корпорації чи підкорпорації
        /// </summary>
        [HttpGet]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "None")]
        public ActionResult LockCorporation(decimal ID)
        {
            var result = new JsonResponse();
            try
            {
                _kfRepository.LockCorporation(ID);
                result.Status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                result.Message = "Виникла внутрішня помилка: " + ex.Message;
                result.Status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Розблокування корпорації чи підкорпорації
        /// </summary>
        [HttpGet]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "None")]
        public ActionResult UnLockCorporation(decimal ID)
        {
            var result = new JsonResponse();
            try
            {
                _kfRepository.UnLockCorporation(ID);
                result.Status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                result.Message = "Виникла внутрішня помилка: " + ex.Message;
                result.Status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Закритя корпорації чи підкорпорації
        /// </summary>
        [HttpGet]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "None")]
        public ActionResult CloseCorporation(decimal ID)
        {
            var result = new JsonResponse();
            try
            {
                _kfRepository.CloseCorporation(ID);
                result.Status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                result.Message = "Виникла внутрішня помилка: " + ex.Message;
                result.Status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Отримання  підкорпорації для зміни ієархії
        /// </summary>
        [HttpGet]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "None")]
        public ActionResult GetCorporationsForChangeHierarchy(decimal ID)
        {
            IQueryable<HierarchyCorporations> data = _kfRepository.GetCorporationsForChangeHierarchy(ID);

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Зміна ієархії підкорпорації
        /// </summary>
        [HttpPost]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "None")]
        public ActionResult ChangeHierarchy(decimal ID, decimal PARENT_ID)
        {
            var result = new JsonResponse();
            try
            {
                _kfRepository.ChangeHierarchy(ID, PARENT_ID);
                result.Status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                result.Message = "Виникла внутрішня помилка: " + ex.Message;
                result.Status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "None")]
        public ActionResult GetCorporationFiles(string CorporationID)
        {
            var data = _kfRepository.GetCorporationsFiles(CorporationID);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "None")]
        public ActionResult GetCorporationDataFiles(decimal sessionID)
        {
            var data = _kfRepository.GetCorporationDataFiles(sessionID);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public List<AccCorpSave> CreateAccCorpSave(List<V_CORP_ACCOUNTS_WEB> data, int dropDownType, string value)
        {
            string instCod = "";
            string altCorpCod = "";

            if (dropDownType == 3)
            {
                string[] values = value.Split('-');
                altCorpCod = values[1];
                instCod = values[2];
            }

            List<AccCorpSave> accCorpSave = new List<AccCorpSave>();
            for (int i = 0; i < data.Count; i++)
            {

                accCorpSave.Add(new AccCorpSave() { ACC = data[i].ACC, ALT_CORP_COD = dropDownType == 3 ? altCorpCod : data[i].ALT_CORP_COD, DAOS = data[i].DAOS, INST_KOD = dropDownType == 3 ? instCod : data[i].INST_KOD, RNK = data[i].RNK, TRKK_KOD = dropDownType == 2 ? value : data[i].TRKK_KOD, USE_INVP = dropDownType == 1 ? value : data[i].USE_INVP });
            }

            return accCorpSave;
        }

        [HttpGet]
        public ActionResult GetCorporationsGrid([DataSourceRequest] DataSourceRequest request)
        {

            List<V_ORG_CORPORATIONS> data = _repoAccCorp.GetCorporationsGrid(request);
            var dataCount = _repoAccCorp.GetCorporationsDataCount(request);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);

        }

        public ViewResult DataKFiles(Int64? d_sess_id, Int64? d_acc, string d_kf, Int64? d_ref, string d_dk)
        {   int dk;
            dk = d_dk == "Дт" ? 0 : 1;
            try
            {
                List<OB_CORP_DATA_SAL_DOC> data =_kfRepository.GetSalDoc(d_sess_id, d_acc, d_kf, d_ref, dk);
                ViewBag.Data = new JavaScriptSerializer().Serialize(data.FirstOrDefault());
            }
            catch (Exception ex)
            {
            ViewBag.Data = new JavaScriptSerializer().Serialize(ex.Message);
            }
            return View();
        }

        public JsonResult GetRegions()
        {
            try
            {
                var regions = _kfRepository.GetDropDownRegions();
                return Json(regions, JsonRequestBehavior.AllowGet);
            }
            catch
            {
                return null;
            }
        }

        public ViewResult DataView()
        {
            return View();
        }

        public JsonResult GetDataViewData([DataSourceRequest]DataSourceRequest request, SaldoFilters filterss)
        {
            try
            {
                IQueryable<V_OB_CORPORATION_SALDO> data = _kfRepository.GetDataViewData(request, filterss);
                Decimal count = _kfRepository.GetDataViewDataCount(request, filterss);
                return Json(new { Data = data, Total = count }, JsonRequestBehavior.AllowGet);
            }
            catch
            {
                return null;
            }
        }

        public JsonResult GetTurnoverbalanceData([DataSourceRequest]DataSourceRequest request, String FILE_DATE, Decimal? KV, String NLS, String TT)
        {
            try
            {
                var data = _kfRepository.GetTurnoverbalanceData(request, FILE_DATE, KV, NLS, TT);
                var dataCount = _kfRepository.GetTurnoverbalanceDataCount(request, FILE_DATE, KV, NLS, TT);
                return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
            }
            catch
            {
                return null;
            }
        }

        public JsonResult GetDropDownCorporations()
        {
            try
            {
                IQueryable<Corporation_SALDO> corporations = _kfRepository.GetDropDownCorporations();
                return Json(corporations, JsonRequestBehavior.AllowGet);
            }
            catch
            {
                return null;
            }
        }
    }
}