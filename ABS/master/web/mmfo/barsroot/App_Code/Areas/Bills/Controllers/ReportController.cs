using BarsWeb.Areas.Bills.Infrastructure.DI.Implementation;
using BarsWeb.Areas.Bills.Infrastructure.ModelBinders;
using BarsWeb.Areas.Bills.Infrastructure.Repository;
using BarsWeb.Areas.Bills.Model;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace BarsWeb.Areas.Bills.Controllers
{
    [AuthorizeUser]
    /// <summary>
    /// Контроллер для настройки и управления отчетов
    /// </summary>
    [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
    public class ReportController: ApplicationController
    {
        /// <summary>
        /// Репозиторий для получения, изменения, удаления, добавления данных!
        /// </summary>
        IBillsRepository _repository;

        /// <summary>
        /// Переопределение метода возвращаемого json с максимальной длинной данных
        /// </summary>
        /// <param name="data"></param>
        /// <param name="contentType"></param>
        /// <param name="contentEncoding"></param>
        /// <param name="behavior"></param>
        /// <returns></returns>
        protected override JsonResult Json(object data, string contentType, System.Text.Encoding contentEncoding, JsonRequestBehavior behavior)
        {
            return new JsonResult()
            {
                Data = data,
                ContentType = contentType,
                ContentEncoding = contentEncoding,
                JsonRequestBehavior = behavior,
                MaxJsonLength = Int32.MaxValue
            };
        }

        public ReportController(IBillsRepository repo)
        { this._repository = repo; }

        /// <summary>
        /// Формирование отчетов
        /// </summary>
        /// <returns></returns>
        public ActionResult Reports(Int32? id)
        {            
            return View(id);
        }

        /// <summary>
        /// форма с перечнем настроек отчетов
        /// </summary>
        /// <returns></returns>
        public ActionResult Settings()
        {
            return View();
        }

        /// <summary>
        /// отображение формы для редактирования\создания отчета
        /// </summary>
        /// <param name="id"></param>
        /// <param name="actionType"></param>
        /// <returns></returns>
        public ActionResult ActionWithReport(Int32? id, String actionType)
        {
            ReportInfo reportInfo = null;
            if (!String.IsNullOrEmpty(actionType) && actionType == "edit" && id.HasValue)
                reportInfo = _repository.GetElement<ReportInfo>(SqlCreator.GetReportInfoItem(id.Value));
            else
                reportInfo = new ReportInfo();
            return View(reportInfo);
        }

        /// <summary>
        /// Обновление, сохранение нового отчета
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult UpdateCreateReport([System.Web.Http.FromBody]ReportInfo model)
        {
            ViewBag.Result = 0;
            if (ModelState.IsValid)
                ViewBag.Result = _repository.ExecuteAndGetInputOutputId(SqlCreator.UpdateOrCreateReport(model), "p_report_id");
            else
                throw new InvalidOperationException("Не всі поля були заповнені");
            return View("UpdateCreateReportResult");
        }

        /// <summary>
        /// Активация\деактивация отчета
        /// </summary>
        /// <param name="id">Ид отчета</param>
        /// <param name="active">1 - деактивировать, 0 - активировать</param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult ActivateDeactivateReport(Int32 id, Int32? active)
        {
            Int32 result = 1;
            String errMessage = "";
            try
            {
                Int32 act = active.HasValue ? active.Value : 0;
                _repository.ExecuteProcedure(SqlCreator.EnableDisableReport(id, act));
            }
            catch(Exception e)
            {
                result = 0;
                errMessage = e.Message;
            }
            return Json(new { status = result, err = errMessage });
        }

        /// <summary>
        /// TAB - список отчетов
        /// </summary>
        /// <returns></returns>
        public PartialViewResult ReportsList()
        {
            return PartialView("_ReportsList");
        }

        /// <summary>
        /// TAB - список параметров для формирования отчетов
        /// </summary>
        /// <returns></returns>
        public ActionResult ReportsSettings()
        {
            return View();
        }

        /// <summary>
        /// Получение списка отчетов
        /// </summary>
        /// <returns></returns>
        public JsonResult GetReportsList(Int32? id)
        {
            List<ReportInfo> result = _repository.GetElements<ReportInfo>(SqlCreator.GetReportInfoList(id));
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Получение списка параметров по ИД отчета
        /// </summary>
        /// <param name="id">ИД отчета</param>
        /// <returns></returns>
        public JsonResult GetReportParametersList(Int32 id)
        {
            List<Parameter> parameters = _repository.GetElements<Parameter>(SqlCreator.GetReportParamValues(id));
            return Json(parameters, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Форма для работы со списком значений по умолчанию для подстановки
        /// </summary>
        /// <param name="id">ИД пакраметра</param>
        /// <returns></returns>
        public PartialViewResult ParameterValuesList(Int32 id)
        {
            String kf = _repository.GetCurrentUserMfo(SqlCreator.GetCurrentMfo);
            List<ParameterValue> model = _repository.GetElements<ParameterValue>(SqlCreator.GetParameterDefaultValues(id, kf));
            return PartialView("_ParameterValuesList", model);
        }

        /// <summary>
        /// Формирование списка параметров
        /// </summary>
        /// <param name="id">ИД отчета</param>
        /// <returns></returns>
        public PartialViewResult ReportParams(Int32 id)
        {
            String kf = _repository.GetCurrentUserMfo(SqlCreator.GetCurrentMfo);
            List<Parameter> paramsList = _repository.GetElements<Parameter>(SqlCreator.GetParametersModel(kf, id));
            List<ParameterViewModel> paramView = (from data in paramsList
                                        group data by data.PARAM_ID into paramGroup
                                        orderby paramGroup.Key
                                        select paramGroup
                             )
                      .Select(x => x.Select(par => 
                        new ParameterViewModel
                        {
                            PARAM_CODE = par.PARAM_CODE,
                            NULLABLE = par.NULLABLE,
                            PARAM_ID = par.PARAM_ID,
                            PARAM_NAME = par.PARAM_NAME,
                            PARAM_TYPE = par.PARAM_TYPE,
                            VALUES = null
                        }).FirstOrDefault())
                        .ToList();

            foreach(ParameterViewModel item in paramView)
            {
                List<Parameter> tmpParameters = paramsList.Where(x => x.PARAM_ID == item.PARAM_ID && x.VALUE_ID.HasValue).ToList();
                if (tmpParameters.Count > 0)
                    item.VALUES = new JavaScriptSerializer().Serialize(tmpParameters.Select(x => new ParameterValue { ID = x.VALUE_ID.Value, VALUE = x.VALUE }));
            }

            //List<ReportParameter> parameters = _repository.GetElements<ReportParameter>(SqlCreator.GetReportParameters(id));
            ViewBag.ReportId = id;
            return PartialView("_ReportParams", paramView);
        }

        /// <summary>
        /// Формирование списка параметров
        /// </summary>
        /// <param name="id">ИД отчета</param>
        /// <returns></returns>
        public PartialViewResult ReportParamsEditSettings(Int32 id)
        {
            List<ReportParam> parameters = _repository.GetElements<ReportParam>(SqlCreator.GetReportParamValues(id));
            ViewBag.ReportId = id;
            return PartialView("_ReportParamsEditSettings", parameters);
        }

        /// <summary>
        /// Форма создания\обновления параметра для формирования отчетов
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public PartialViewResult AddUpdateReportParam(Int32 reportId, Int32? id)
        {
            ReportParam param = null;
            if (id.HasValue)
                param = _repository.GetElement<ReportParam>(SqlCreator.GetReportParameter(id.Value));
            else
                param = new ReportParam();
            param.Report_Id = reportId;
            return PartialView("_AddUpdateReportParam", param);
        }

        /// <summary>
        /// Форма создания\редактирования значения параметра отчета
        /// </summary>
        /// <param name="id">ИД значения параметра (0 или null для создания нового)</param>
        /// <param name="parameterId">ИД параметра отчета</param>
        /// <returns></returns>
        public PartialViewResult AddUpdateParameterDefaultValue(Int32? id, Int32 parameterId)
        {
            ParameterValue model = null;
            if (id.HasValue && id.Value > 0)
            {
                String kf = _repository.GetCurrentUserMfo(SqlCreator.GetCurrentMfo);
                model = _repository.GetElement<ParameterValue>(SqlCreator.GetParameterDefaultValue(id.Value, kf, parameterId));
            }
            else
                model = new ParameterValue();

            ViewBag.TYPE = _repository.GetElement<ReportParam>(SqlCreator.GetReportParameter(parameterId)).Param_Type;
            model.PARAMETER_ID = parameterId;
            return PartialView("_AddUpdateParameterDefaultValue", model);
        }

        /// <summary>
        /// Добавление\изменеие значения параметра отчета
        /// </summary>
        /// <param name="model">Модель значения параметра отчета</param>
        /// <returns></returns>
        public PartialViewResult AddOrUpdateParameterValue([System.Web.Http.FromBody]ParameterValue model)
        {
            ViewBag.Result = 1;
            try
            {
                String kf = _repository.GetCurrentUserMfo(SqlCreator.GetCurrentMfo);
                _repository.ExecuteProcedure(SqlCreator.AddUpdateParameterValue(model, kf));
            }
            catch(Exception e) {
                ViewBag.Result = 0;
            }
            return PartialView("UpdateCreateReportResult");
        }

        /// <summary>
        /// Удаление значения параметра отчета
        /// </summary>
        /// <param name="parameterId">ИД параметра отчета</param>
        /// <param name="valueId">ИД значения параметра отчета</param>
        /// <returns></returns>
        public JsonResult RemoveParameterValue(Int32 parameterId, Int32 valueId)
        {
            String kf = _repository.GetCurrentUserMfo(SqlCreator.GetCurrentMfo);
            Int32 result = 1;
            String err = String.Empty;
            try
            {
                _repository.ExecuteProcedure(SqlCreator.RemoveParameterValue(new ParameterValue { ID = valueId, PARAMETER_ID = parameterId }, kf));
            }
            catch(Exception e)
            {
                result = 0;
                err = e.Message;
            }
            return Json(new { status = result, err = err });
        }

        /// <summary>
        /// Сохранение изменеий \ создание параметра отчета
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public PartialViewResult AddOrUpdateParameter([System.Web.Http.FromBody]ReportParam model)
        {
            try
            {
                ViewBag.Result = _repository.ExecuteAndGetInputOutputId(SqlCreator.CreateUpdateReportParam(model), "p_param_id");
            }
            catch(Exception e)
            {
                ViewBag.Result = 0;
            }
            return PartialView("UpdateCreateReportResult");
        }

        /// <summary>
        /// Выбор занчения для параметра
        /// </summary>
        /// <param name="paramCode">ИД параметра</param>
        /// <param name="values">Список значений</param>
        /// <returns></returns>
        public PartialViewResult SelectParameterValue(String paramCode, String values, String vtype)
        {
            List<ParameterValue> parameters = new JavaScriptSerializer().Deserialize<List<ParameterValue>>(values);
            ViewBag.ID = paramCode;
            ViewBag.VType = vtype;
            return PartialView("_SelectParameterValue", parameters);
        }

        /// <summary>
        /// Удаление параметра отчета
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public JsonResult RemoveReportParameter(Int32 id)
        {
            Int32 result = 1;
            String errMessage = "";
            try
            {
                _repository.ExecuteProcedure(SqlCreator.RemoveReportParameter(id));
            }
            catch (Exception e) {
                result = 0;
                errMessage = e.Message;
            }
            return Json(new { status = result, err = errMessage });
        }

        public PartialViewResult ParameterDefaultValues()
        {
            return PartialView("_ParameterDefaultValues");
        }

        /// <summary>
        /// Формирование файла отчета
        /// </summary>
        /// <param name="model">Модель параметров</param>
        /// <returns></returns>
        public FileResult GetReport([ModelBinder(typeof(FastReportModelBind))]CustomFastReportModel model)
        {
            Byte[] bytes = new byte[0];
            if (model != null)
            {
                String fileName = _repository.GetElement<String>(SqlCreator.GetReportFileName(model.ReportID));
                bytes = new FrxDocHelper(new FastReport.Models.FastReportModel
                { FileName = fileName, Parameters = model.Parameters, ResponseFileType = FrxExportTypes.Pdf })
                    .GetFileInByteArray();
            }
            return File(bytes, System.Net.Mime.MediaTypeNames.Application.Pdf);
        }

        #region Приватные (вспомагательные) методы

        private String GetCurrentUserMfo()
        {
            return _repository.GetCurrentUserMfo(SqlCreator.GetCurrentMfo);
        }

        #endregion

        #region Kendo

        /// <summary>
        /// Получение списка отчетов
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public JsonResult GetReporsts_Read([DataSourceRequest]DataSourceRequest request, Int32? id)
        {
            DataSourceResult result = _repository.GetKendoData<ReportInfo>(request, SqlCreator.GetReportInfoList(id));
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        #endregion
    }
}