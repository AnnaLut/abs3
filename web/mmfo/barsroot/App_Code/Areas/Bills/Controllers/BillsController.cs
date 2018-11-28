using BarsWeb.Areas.Bills.Infrastructure.DI.Implementation;
using BarsWeb.Areas.Bills.Infrastructure.ModelBinders;
using BarsWeb.Areas.Bills.Infrastructure.Repository;
using BarsWeb.Areas.Bills.Model;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Xml;

namespace BarsWeb.Areas.Bills.Controllers
{
    [AuthorizeUser]
    /// <summary>
    /// Контроллер для работы с отображением и получением данных (для Kendo) по векселям
    /// </summary>
    public class BillsController : ApplicationController
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

        public BillsController(IBillsRepository repo)
        { this._repository = repo; }

        #region Views

        /// <summary>
        /// Отображение списка проводок по векселям
        /// </summary>
        /// <returns></returns>
        public ActionResult Opers()
        {
            return View();
        }

        /// <summary>
        /// Отображение списка получателей
        /// </summary>
        /// <returns></returns>
        public ActionResult Receivers()
        {
            // Обновление статусов
            UpdateStatuses();
            return View();
        }

        /// <summary>
        /// Работа с данными получателей (ЦА)
        /// </summary>
        /// <returns></returns>
        public ActionResult CAReceivers()
        {
            // Обновление статусов
            UpdateStatuses();
            // получение количества взыскалелей готовых для формирования выдержки
            Int32 count = _repository.GetElements<CA_Receivers>(SqlCreator.GetCAReceivers, x => x.STATUS == "XX").Count();
            return View(count);
        }

        /// <summary>
        /// Страница поиска потенциальных получателей
        /// </summary>
        /// <returns></returns>
        public ActionResult Search()
        {
            // инициализация модели для поиска казначейских векселей текущей датой для отображения на форме
            return View(new SearchReceiverModel {
                ResolutionDate = DateTime.Now
            });
        }

        /// <summary>
        /// Работа с "витягами"
        /// </summary>
        /// <returns></returns>
        public ActionResult Extracts()
        {
            // Обновление статусов
            UpdateStatuses();
            return View();
        }

        /// <summary>
        /// View Отримання векселів від ДКСУ
        /// </summary>
        /// <returns></returns>
        public ActionResult GetBills()
        {
            // Обновление статусов
            UpdateStatuses();
            return View();
        }

        /// <summary>
        /// View Отримання векселів від ЦА
        /// </summary>
        /// <returns></returns>
        public ActionResult GetBillsFromCA()
        {
            // Обновление статусов
            UpdateStatuses();
            return View();
        }

        /// <summary>
        /// View для отправки векселей на регионы
        /// </summary>
        /// <returns></returns>
        public ActionResult SendToRegion()
        {
            // Обновление статусов
            UpdateStatuses();
            //получение списка регионов
            List<String> list = _repository.GetElements<String>(SqlCreator.GetBranches);
            List<SelectListItem> model = list != null && list.Count() > 0 ? list.Select(x => new SelectListItem { Text = x, Value = x }).ToList() : new List<SelectListItem>();
            return View(model);
        }

        /// <summary>
        /// Отображение списка отсканированных документов
        /// </summary>
        /// <param name="id"></param>
        /// <param name="status"></param>
        /// <returns></returns>
        public ActionResult ScannedDocuments(Int32 id, String status)
        {
            // сохранение значения переменной статуса во временную переменную
            ViewBag.STATUS = status;
            return View(id);
        }

        /// <summary>
        /// View выдача векселей взыскателю
        /// </summary>
        /// <returns></returns>
        public ActionResult ReceiversWithBills()
        {
            // Обновление статусов
            UpdateStatuses();
            return View();
        }

        /// <summary>
        /// Поиск получателей в ДКСУ и отображение его результата
        /// </summary>
        /// <param name="model">используется модель привязки из-за невозможного использования стандартной модели привязки</param>
        /// <returns></returns>
        public ActionResult SearchReceiver([ModelBinder(typeof(SearchReceiverModelBind))]SearchReceiverModel model)
        {
            // присваиваем переменной ссылку на объект для отсутствия обработки исключений на пустоту (null) 
            List<ExpectedReceivers> expectedReceivers = new List<ExpectedReceivers>();
            // получаем запрашиваемые данные поиска из ДКСУ. result - не пустой в случае ошибки или отсутствия данных
            String result = _repository.ExecuteRequestAndGetTextResponse(SqlCreator.SearchReceivers(model));
            // если ошибок нет, тогда получаем искомые данные
            if (String.IsNullOrEmpty(result))
                expectedReceivers = _repository.GetElements<ExpectedReceivers>(SqlCreator.GetExpectedReceivers(model.ResolutionDate, model.ResolutionNumber));
            // текст ошибки используется в случае если переменная не пустая
            ViewBag.Err = result;
            return View(expectedReceivers);
        }

        /// <summary>
        /// Редактирование получателя
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult EditReceiver(Int32 id)
        {
            // получение логина текущего пользователя для распределения комментариев
            ViewBag.UserName = User.Identity.Name;
            // получаем данные взыскателя по его ИД для редактирования
            Receiver receiver = _repository.GetElement<Receiver>(SqlCreator.GetReceiverById(id));
            // если пользователю задан РНК, тогда подтягиваем счета
            if (receiver.RNK.HasValue)
                receiver.ACCOUNTS = _repository.GetElements<ReceiverAccounts>(SqlCreator.GetReceiverAccounts(receiver.RNK.Value, receiver.CL_TYPE.Value));
            if (receiver.ACCOUNTS == null)
                receiver.ACCOUNTS = new List<ReceiverAccounts>();
            // Получаем комментарии в видк xml
            String xml = _repository.GetElement<String>(SqlCreator.GetComments(id));
            // Получаем комментарии ввиде массива
            ViewBag.comments = ParseXmlComments(xml);
            // Получаем статус для подписи
            ViewBag.needSign = _repository.GetStatusToSign(SqlCreator.GetStatusToSign());
            return View(receiver);
        }

        /// <summary>
        /// Отправка запроса в ДКСУ для формирования "витягу"
        /// </summary>
        /// <param name="expectedIds"></param>
        /// <returns></returns>
        public ActionResult SelectedCAReceivers(List<Int32> expectedIds)
        {
            // Обновление статусов
            UpdateStatuses();
            // получаем список выцбранных взыскателей для формирования выдержки
            List<CA_Receivers> list = _repository.GetElements<CA_Receivers>("", x => expectedIds.Contains(x.EXP_ID));
            return View(list);
        }

        /// <summary>
        /// Отображение найденных клиентов по РНК
        /// </summary>
        /// <param name="param">Данные для поиска</param>
        /// <param name="sqlType">Тип поиска: по ИНН или по имени</param>
        /// <returns></returns>
        public ActionResult Clients(String param, String sqlType, Int32 count)
        {
            return View(new CustomerViewModel { Param = param, SqlType = sqlType, Count = count });
        }

        /// <summary>
        /// Просмотр действий пользователя 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult ReceiverLogs(Int32 id)
        {
            // получение имени необходимого взыскателя для отображения
            ViewBag.receiverName = _repository.GetElement<Receiver>(SqlCreator.GetReceiverById(id)).NAME;
            // получение списка действий по определенному взыскателю
            List<ReceiverLog> receiverLogs = _repository.GetElements<ReceiverLog>(SqlCreator.GetReceiverLog(id));
            return View(receiverLogs);
        }

        /// <summary>
        /// Форма для выбора подписи
        /// </summary>
        /// <returns></returns>
        public ActionResult Cryptor()
        {
            return View();
        }

        /// <summary>
        /// Розрахунок сум реструктуризованої заборгованності
        /// </summary>
        /// <returns></returns>
        public ActionResult AmountOfRestrDebt()
        {
            return View();
        }

        /// <summary>
        /// Архив реестра выдержек
        /// </summary>
        /// <returns></returns>
        public ActionResult ExtractsDetail()
        {
            // Обновление статусов
            UpdateStatuses();
            return View();
        }

        #endregion

        #region Kendo grid read

        /// <summary>
        /// Kendo метод для получения списка файлов в хранилище
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public JsonResult FileStorage_Read([DataSourceRequest]DataSourceRequest request)
        {
            DataSourceResult result = _repository.GetKendoData<File_Archive>(request, SqlCreator.GetFilesFromStorage);
            return Json(result);
        }

        /// <summary>
        /// Kendo метод для получения списка проводок по векселям
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public JsonResult GetOpers_Read([DataSourceRequest]DataSourceRequest request)
        {
            DataSourceResult result = _repository.GetKendoData<Opers>(request, SqlCreator.GetOpers);
            return Json(result);
        }

        /// <summary>
        /// Kendo метод для получения списка найденых по РНК клиентов
        /// </summary>
        /// <param name="request"></param>
        /// <param name="param"></param>
        /// <param name="sqlType"></param>
        /// <returns></returns>
        public JsonResult GetCustomers_Read([DataSourceRequest]DataSourceRequest request, String param, String sqlType, Int32 count)
        {
            List<Customer> result = _repository.GetTransformedKendoData<Customer>(request, SqlCreator.GetCustomerByParam(param, sqlType));
            return Json(new { Data = result, Total = count });
        }

        /// <summary>
        /// Kendo метод для получения списка подтвержденных векселей полученых от ДКСУ
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public JsonResult GetConfirmedBills_Read([DataSourceRequest]DataSourceRequest request)
        {
            DataSourceResult result = _repository.GetKendoData<BillsModel>(request, SqlCreator.GetConfirmedBills);
            return Json(result);
        }

        /// <summary>
        /// Kendo получение списка всех векселей
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public JsonResult GetBills_Read([DataSourceRequest]DataSourceRequest request)
        {
            DataSourceResult result = _repository.GetKendoData<BillsModel>(request, SqlCreator.GetAllBills);
            return Json(result);
        }

        /// <summary>
        /// Kendo метод для получения списка векселей полученных от ДКСУ на подтверждение 
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public JsonResult AllBills_Read([DataSourceRequest]DataSourceRequest request)
        {
            DataSourceResult result = _repository.GetKendoData<BillsModel>(request, SqlCreator.GetBillsToConfirm);
            return Json(result);
        }

        /// <summary>
        /// Kendo метод для получения списка векселей полученных от ЦА на подтверждение 
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public JsonResult AllFromCABills_Read([DataSourceRequest]DataSourceRequest request)
        {
            DataSourceResult result = _repository.GetKendoData<BillsModel>(request, SqlCreator.GetLocalBillsToConfirm);
            return Json(result);
        }

        /// <summary>
        /// Получение списка "витягів"
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public JsonResult Extracts_Read([DataSourceRequest]DataSourceRequest request)
        {
            DataSourceResult result = _repository.GetKendoData<Extract>(request, SqlCreator.GetExtracts);
            return Json(result);
        }

        /// <summary>
        /// Получение списка "архіву витягів"
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public JsonResult ExtractsDetail_Read([DataSourceRequest]DataSourceRequest request)
        {
            DataSourceResult result = _repository.GetKendoData<Extract>(request, SqlCreator.GetExtractsDetailIds);
            return Json(result);
        }

        /// <summary>
        /// Kendo список взыскателей для отображения грида с векселями
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public JsonResult GetReceiversForBills([DataSourceRequest]DataSourceRequest request)
        {
            DataSourceResult result = _repository.GetKendoData<ReceiversForBills>(request, SqlCreator.GetBillReceivers);
            foreach (ReceiversForBills item in result.Data)
            {
                if (item.STATUS == "RR")
                {
                    Int32 count = _repository.GetCount<BillsModel>(SqlCreator.GetBillsCountInRegionByExpId(item.EXP_ID));
                    if (count >= 7)
                        item.EnableButton = true;
                }
            }
            return Json(result);
        }

        /// <summary>
        /// метод для Kendo (получение списка получателей)
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public JsonResult Receivers_read([DataSourceRequest]DataSourceRequest request)
        {
            DataSourceResult result = _repository.GetKendoData<Receiver>(request, SqlCreator.GetReceivers);
            return Json(result);
        }

        /// <summary>
        /// метод для Kendo (получение списка получателей в ЦА)
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public JsonResult CA_Receivers_read([DataSourceRequest]DataSourceRequest request)
        {
            DataSourceResult result = _repository.GetKendoData<CA_Receivers>(request, SqlCreator.GetCAReceiversReadyForExtract);
            return Json(result);
        }

        /// <summary>
        /// Получение данных для отображения списка отсканированных документов
        /// </summary>
        /// <param name="request"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public JsonResult ScannedDocuments_read([DataSourceRequest]DataSourceRequest request, Int32 id)
        {
            List<V_Documents> result = _repository.GetTransformedKendoData<V_Documents>(request, SqlCreator.GetScannedDocuments(id));
            Int32 count = _repository.GetCount<V_Documents>(SqlCreator.GetScannedDocuments(id));
            return Json(new { Data = result, Total = count });
        }

        /// <summary>
        /// Получение списка получателей по "витягу"
        /// </summary>
        /// <param name="request"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public JsonResult CA_Extract_Receivers_read([DataSourceRequest]DataSourceRequest request, Int32 id)
        {
            List<CA_Receivers> result = _repository.GetTransformedKendoData<CA_Receivers>(request, SqlCreator.GetExtract_CA_Receivers(id));
            Int32 count = _repository.GetCount<CA_Receivers>(SqlCreator.GetExtract_CA_Receivers(id));
            return Json(new { Data = result, Total = count });
        }

        /// <summary>
        /// Получение списка получателей по "витягу"
        /// </summary>
        /// <param name="request"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public JsonResult CA_ExtractsDetail_Receivers_read([DataSourceRequest]DataSourceRequest request, Int32 id)
        {
            List<CA_Receivers> result = _repository.GetTransformedKendoData<CA_Receivers>(request, SqlCreator.GetExtractsDetailReceivers(id));
            Int32 count = _repository.GetCount<CA_Receivers>(SqlCreator.GetExtractsDetailReceivers(id));
            return Json(new { Data = result, Total = count });
        }

        /// <summary>
        /// Kendo список векселей по ИД взыскателя (ЦА)
        /// </summary>
        /// <param name="request"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public JsonResult GetBillsByExpID([DataSourceRequest]DataSourceRequest request, Int32 id)
        {
            List<BillsModel> result = _repository.GetTransformedKendoData<BillsModel>(request, SqlCreator.GetBillsByExpectedId(id));
            Int32 count = _repository.GetCount<BillsModel>(SqlCreator.GetBillsByExpectedId(id));
            return Json(new { Data = result, Total = count });
        }

        /// <summary>
        /// Kendo список файлов расчетов реструктуризированной задолжности
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public JsonResult GetAmountOfRestrDebt([DataSourceRequest]DataSourceRequest request)
        {
            DataSourceResult result = _repository.GetKendoData<AmountOfRestrDebt>(request, SqlCreator.GetAmountOfRestrDebt);
            return Json(result);
        }
        #endregion

        #region работа с файлами

        /// <summary>
        /// Получение файла в формате Pdf
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public FileResult PrintBillRequest(Int32 id)
        {
            String result = _repository.ExecuteRequestAndGetTextResponse(SqlCreator.PrintBillRequest(id)); //_repository.PrintBillRequest(id);
            if (!String.IsNullOrEmpty(result))
                throw new Exception(result);
            // Получение документа и его ИД (или null если такого нет)
            V_Documents document = _repository.GetElement<V_Documents>(SqlCreator.GetDocumentByRecordIdAndType(id, "Application"));
            Int32? docId = null;
            if(document != null)
                docId = document.DOC_ID;
            // Получение файла в форме массива байтов
            Byte[] bytes = _repository.GetPrintDoc(docId.Value);
            return File(bytes, System.Net.Mime.MediaTypeNames.Application.Pdf);
        }

        /// <summary>
        /// Скачивание файла 'Заява на погашення'
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public FileResult DownloadApplication(Int32 id)
        {
            // Получение документа и его ИД (или null если такого нет)
            V_Documents document = _repository.GetElement<V_Documents>(SqlCreator.GetDocumentByRecordIdAndType(id, "Application"));
            Int32? docId = null;
            if (document != null)
                docId = document.DOC_ID;
            // Получение файла в форме массива байтов
            Byte[] bytes = _repository.GetPrintDoc(docId.Value);
            return File(bytes, System.Net.Mime.MediaTypeNames.Application.Pdf);
        }

        /// <summary>
        /// Загрузка файлов в формате Pdf
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public FileResult DownloadPdf(Int32 id)
        {
            Byte[] bytes = _repository.GetPrintDoc(id);
            return File(bytes, System.Net.Mime.MediaTypeNames.Application.Pdf);
        }

        /// <summary>
        /// Загрузка файла из bills.documents по его ид
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public FileResult DowloadFile(Int32 id)
        {
            String base64 = _repository.GetElement<String>(SqlCreator.GetFileById(id));
            Byte[] bytes = Convert.FromBase64String(base64);
            return File(bytes, System.Net.Mime.MediaTypeNames.Application.Pdf);
        }

        /// <summary>
        /// Форма для закачки файла
        /// </summary>
        /// <param name="fileType">тип файла
        /// AppScan
        /// OtherDoc
        /// </param>
        /// <returns></returns>
        public ActionResult AttachPdf(Int32 id)
        {
            return View(id);
        }

        /// <summary>
        /// Сохранение файлов и вывод результата
        /// </summary>
        /// <param name="id">ExpectedId</param>
        /// <returns></returns>
        public ActionResult AttachFile(Int32 id)
        {
            String result = "";
            if (Request.Files.Count > 0)
            {
                String fType = String.IsNullOrEmpty(Request["fileType"]) ? Request.Form["fType"] : Request["fileType"];
                Int32 fileType = Convert.ToInt32(fType);
                for (Int32 i = 0; i < Request.Files.Count; ++i)
                {
                    HttpPostedFileBase file = Request.Files[i];
                    if (file != null && file.ContentLength > 0)
                    {
                        var fileName = Path.GetFileName(file.FileName);
                        String[] fileSplitedName = fileName.Split('.');
                        String fileFormat = fileSplitedName.Last();
                        if (fileFormat.ToLower() != "pdf")
                        {
                            result += String.Format("Файл '{0}' має не вірний формат.!", fileName);
                            continue;
                        }
                        Byte[] bytes = null;
                        using (BinaryReader binaryReader = new BinaryReader(file.InputStream))
                            bytes = binaryReader.ReadBytes(file.ContentLength);

                        if (bytes == null)
                            break;
                        String docName = fileType == 2 ? String.Format("Application_{0}.pdf", id) : String.Format("OtherDoc_{0}.pdf", id);
                        String docType = fileType == 2 ? "AppScan" : "OtherScan";
                        Int32? docId = null;
                        if (fileType == 2)
                        {
                            V_Documents document = _repository.GetElement<V_Documents>(SqlCreator.GetDocumentByRecordIdAndType(id, docType));
                            if (document != null)
                                docId = document.DOC_ID;
                        }
                        String inputResult = _repository.ExecuteRequestAndGetTextResponse(SqlCreator.ScanDocument(id, bytes, docId, docName, fileType, ""));
                        if (!String.IsNullOrEmpty(inputResult))
                        {
                            String documentType = fileType == 2 ? "'Заява на погашення'" : "'Інщі документи'";
                            result += String.Format("Помилка збереження файлу {0} з типом {1}: {2}.!", fileName, documentType, inputResult);
                        }
                    }
                }
            }
            else
                result = "Жодного файлу не було передано!";
            ViewBag.Result = result.Split('!');
            return View();
        }

        /// <summary>
        /// Загрузка файла из шаблона
        /// </summary>
        /// <param name="id">ID - может быть пустой</param>
        /// <param name="reportType">тип шаблона (по типу выбирается имя файла fast report). Содержимое параметра приводится к нижнему регистру</param>
        /// <returns></returns>
        public FileResult DownloadReport(Int32? id, String reportType)
        {
            Byte[] bytes = new FrxDocHelper(FileRequestCreator.SwitchReportModel(reportType, id?? 0)).GetFileInByteArray();
            return File(bytes, System.Net.Mime.MediaTypeNames.Application.Pdf);
        }

        /// <summary>
        /// Предварительный просмотр выдержки
        /// </summary>
        /// <returns></returns>
        public FileResult ExtractPreView()
        {
            String result = _repository.ExecuteRequestAndGetTextResponse(SqlCreator.CheckRequestListSign());
            if (!string.IsNullOrEmpty(result))
                throw new Exception(result);
            Byte[] bytes = new FrxDocHelper(FileRequestCreator.SwitchReportModel("extractpreview", 0)).GetFileInByteArray();
            return File(bytes, System.Net.Mime.MediaTypeNames.Application.Pdf);
        }

        /// <summary>
        /// Форма для загрузки файла расчета реструктуризированной задолжности (из дксу)
        /// </summary>
        /// <returns></returns>
        public ActionResult DownloadAmountOfRestrDebtForm()
        {
            return View();
        }

        /// <summary>
        /// загрузка файла расчета реструктуризированной задолжности (для печати)
        /// </summary>
        /// <param name="dateFrom"></param>
        /// <returns></returns>
        public FileResult DownloadAmountOfRestrDebt(DateTime? dateFrom)
        {
            if (dateFrom == null)
                dateFrom = DateTime.Now;
            AmountOfRestructuredDeptDowloadResult result = _repository.DownloadAmountOfRestructuredDept(SqlCreator.GetCalcRequestId(dateFrom.Value));
            String base64 = _repository.GetElement<String>(SqlCreator.GetCalcFile(result.ID, "request_body"));
            Byte[] bytes = Convert.FromBase64String(base64);
            return File(bytes, System.Net.Mime.MediaTypeNames.Application.Pdf);
        }

        /// <summary>
        /// загрузка файла расчета реструктуризированной задолжности (отсканированная копия)
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public FileResult GetScanOfAmountOfRestrDebt(Int32 id)
        {
            String base64 = _repository.GetElement<String>(SqlCreator.GetCalcFile(id, "scan_body"));
            if (String.IsNullOrEmpty(base64))
                return File(new byte[0], System.Net.Mime.MediaTypeNames.Application.Pdf);
            Byte[] bytes = Convert.FromBase64String(base64);
            return File(bytes, System.Net.Mime.MediaTypeNames.Application.Pdf);
        }

        /// <summary>
        /// Сканирование файла в хранилище
        /// </summary>
        /// <returns></returns>
        public ActionResult FileStorageScann()
        {
            return View(new SaveFileModel());
        }

        /// <summary>
        /// Форма добавления файла в хранилище
        /// </summary>
        /// <returns></returns>
        public ActionResult AttachStorageFile()
        {
            return View(new SaveFileModel());
        }

        /// <summary>
        /// Сохранение файлов в хранилище
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult UploadStorageFile(SaveFileModel model)
        {
            String result = "";
            if (Request.Files.Count > 0)
            {
                HttpPostedFileBase file = Request.Files[0];
                if (file != null && file.ContentLength > 0)
                {
                    var fileName = Path.GetFileName(file.FileName);
                    String[] fileSplitedName = fileName.Split('.');
                    String fileFormat = fileSplitedName.Last();
                    if (fileFormat.ToLower() != "pdf")
                        result += String.Format("Файл '{0}' має не вірний формат.!", fileName);
                    Byte[] bytes = null;
                    using (BinaryReader binaryReader = new BinaryReader(file.InputStream))
                        bytes = binaryReader.ReadBytes(file.ContentLength);

                    if (bytes == null)
                        result = "Жодного файлу не було передано";
                    if (String.IsNullOrEmpty(result))
                    {
                        model.FileName = model.FileName.EndsWith(".pdf") ? model.FileName : model.FileName + ".pdf";
                        model.Data = bytes;
                        result = _repository.ExecuteRequestAndGetTextResponse(SqlCreator.AttachStorageFile(model));
                    }
                }
            }
            else
                result = "Жодного файлу не було передано";
            ViewBag.Result = new String[] { result };
            return View("AttachFile");
        }

        /// <summary>
        /// Загрузка файла из хранилища
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public FileResult GerStorageFile(Int32 id)
        {
            Byte[] bytes = _repository.GetElement<Byte[]>(SqlCreator.GetStorageFile(id));
            return File(bytes, System.Net.Mime.MediaTypeNames.Application.Pdf);
        }

        /// <summary>
        /// Хранилище файлов
        /// </summary>
        /// <returns></returns>
        public ActionResult FileStorage()
        {
            return View();
        }

        /// <summary>
        /// для формы "передача векселей на регіони"
        ///
        ///
        /// </summary>
        /// <param name="branch"></param>
        /// <param name="reportType">
        ///  acttransfer - Акт приема-передачи векселей, 
        ///  actbags - Акт опломбированных сумок
        /// </param>
        /// <returns></returns>
        public FileResult GetActOfTransferToRegion(String branch, String reportType)
        {
            Byte[] bytes = new FrxDocHelper(FileRequestCreator.GetActTtansferToRegion(branch, reportType)).GetFileInByteArray();
            return File(bytes, System.Net.Mime.MediaTypeNames.Application.Pdf);
        }
        
        #endregion

        #region Частичные представления    

        /// <summary>
        /// Частичное отображение html со списком комминтариев
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public PartialViewResult Comments(Int32 id)
        {
            // Получаем комментарии в видк xml
            String xml = _repository.GetElement<String>(SqlCreator.GetComments(id));
            // Получаем комментарии ввиде массива
            List<Comment> comments = ParseXmlComments(xml);
            return PartialView("_Comments", comments);
        }

        /// <summary>
        /// Добавление комментария
        /// </summary>
        /// <param name="id"></param>
        /// <param name="req_id"></param>
        /// <param name="comment"></param>
        /// <returns></returns>
        public PartialViewResult AddComment(Int32 id, Int32? req_id, String comment)
        {
            String addResult = _repository.ExecuteRequestAndGetTextResponse(SqlCreator.AddComment(req_id, comment));
            ViewBag.UserName = User.Identity.Name;
            List<Comment> comments = new List<Comment>();
            if (String.IsNullOrEmpty(addResult))
            {
                // Получаем комментарии в видк xml
                String xml = _repository.GetElement<String>(SqlCreator.GetComments(id));
                // Получаем комментарии ввиде массива
                comments = ParseXmlComments(xml);
            }
            else
                ViewBag.Error = addResult;
            return PartialView("_Comments", comments);
        }

        /// <summary>
        /// Онновление комментариев из ДКСУ
        /// </summary>
        /// <param name="id"></param>
        /// <param name="req_id"></param>
        /// <returns></returns>
        public PartialViewResult UpdateComments(Int32 id, Int32 req_id)
        {
            List<Comment> comments = new List<Comment>();
            ViewBag.UserName = User.Identity.Name;
            String updateResult = _repository.ExecuteRequestAndGetTextResponse(SqlCreator.GetCommentsHistory(req_id));
            if (String.IsNullOrEmpty(updateResult))
            {
                // Получаем комментарии в видк xml
                String xml = _repository.GetElement<String>(SqlCreator.GetComments(id));
                // Получаем комментарии ввиде массива
                comments = ParseXmlComments(xml);
            }
            else
                ViewBag.Error = updateResult;
            return PartialView("_Comments", comments);
        }
        #endregion

        #region Вспомогательные (приватные) методы
        /// <summary>
        /// Рахбор списка сообщений полученных от ДКСУ в формате xml
        /// </summary>
        /// <param name="xml">Строка в формате xml</param>
        /// <returns></returns>
        private List<Comment> ParseXmlComments(String xml)
        {
            List<Comment> model = new List<Comment>();
            if (String.IsNullOrEmpty(xml))
                return model;
            XmlDocument xmlDocument = new XmlDocument();
            xmlDocument.LoadXml(xml);
            if (xmlDocument.InnerXml.Length > 0)
            {
                var ch = xmlDocument.FirstChild.ChildNodes[0];
                foreach (XmlNode parent in xmlDocument.FirstChild.ChildNodes)
                {
                    var comment = new Comment();
                    foreach (XmlNode node in parent.ChildNodes)
                    {
                        if (node.Name == "author")
                            comment.Author = node.InnerText;
                        else if (node.Name == "date")
                            comment.Date = DateTime.Parse(node.InnerText);
                        else if (node.Name == "text")
                            comment.Text = node.InnerText;
                    }
                    model.Add(comment);
                }
            }
            return model;
        }

        /// <summary>
        /// обновление статусов (принудительное)
        /// </summary>
        private void UpdateStatuses()
        {
            // Получение варианта запроса в зависимости от значения переменной 'method'
            // Регистр приводится с нижнему...
            BillsSql sql = SqlCreator.GetSqlDataByMethodName("UpdateStatuses", 0, null);
            // Обработка запроса к БД
            String result = _repository.ExecuteRequestAndGetTextResponse(sql);
        }
        #endregion
    }
}