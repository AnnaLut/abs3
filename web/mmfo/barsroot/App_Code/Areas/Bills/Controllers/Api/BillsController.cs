using BarsWeb.Areas.Bills.Infrastructure.DI.Implementation;
using BarsWeb.Areas.Bills.Infrastructure.ModelBinders;
using BarsWeb.Areas.Bills.Infrastructure.Repository;
using BarsWeb.Areas.Bills.Model;
using BarsWeb.Infrastructure.Repository.DI.Implementation;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Bills.Controllers.Api
{
    [AuthorizeUser]
    public class BillsController: ApiController
    {
        /// <summary>
        /// Репозиторий для получения, изменения, удаления, добавления данных
        /// </summary>
        readonly IBillsRepository _repository; //репозиторий

        public BillsController(IBillsRepository repo)
        { _repository = repo; }

        /// <summary>
        /// Обновление данных получателя
        /// </summary>
        /// <param name="receiver"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage UpdateReceiver([ModelBinder(typeof(EditReceiverModelBind))]Receiver receiver)
        {
            if (ModelState.IsValid)
            {
                String result = _repository.ExecuteRequestAndGetTextResponse(SqlCreator.UpdateReceiver(receiver));
                return CreateReponseFromStringResult(result);
            }
            return Request.CreateResponse(HttpStatusCode.OK, new { status = 2, err = "Не всі поля були заповнені!" });
        }

        /// <summary>
        /// Сохранение отсканированных документов
        /// </summary>
        /// <param name="id">ИД взыскателя</param>
        /// <param name="docType">Тип документа:
        /// AppScan - заявление на выплату, OtherDoc - другой документ</param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage UploadScannedDocument(Int32 id, String docType)
        {
            // получение объекта отсканированного документа(ов) из сессии
            Bars.UserControls.ByteData uploadedImage = (Bars.UserControls.ByteData)HttpContext.Current.Session["image_bill_data"];
            // получение массива байтов (файла)
            byte[] bytes = uploadedImage.Data;
            // очистка сессии
            HttpContext.Current.Session["image_bill_data"] = null;
            String documentName = docType == "AppScan" ? String.Format("Application_{0}.pdf", id) : String.Format("OtherDoc_{0}.pdf", id);
            Int32? docId = null;
            Int32 docTypeId = docType == "AppScan" ? 2 : 3;
            if (docType == "AppScan")
            {
                // Получение документа и его ИД (или null если такого нет)
                V_Documents document = _repository.GetElement<V_Documents>(SqlCreator.GetDocumentByRecordIdAndType(id, docType));
                if (document != null)
                    docId = document.DOC_ID;
            }
            //сохранение документа
            String result = _repository.ExecuteRequestAndGetTextResponse(SqlCreator.ScanDocument(id, bytes, docId, documentName, docTypeId, ""));
            return CreateReponseFromStringResult(result);
        }

        /// <summary>
        /// Сохранение файла скан копии "Розрахунок сум реструктуризованної заборгованності"
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage SaveAmountOfRestrDebt(Int32 id)
        {
            Bars.UserControls.ByteData uploadedImage = (Bars.UserControls.ByteData)HttpContext.Current.Session["image_bill_data"];
            // получение массива байтов (файла)
            byte[] bytes = uploadedImage.Data;
            // очистка сессии
            HttpContext.Current.Session["image_bill_data"] = null;
            AddCalcRequestScanModel model = new AddCalcRequestScanModel
            {
                REQUEST_ID = id,
                SCAN_BODY = Convert.ToBase64String(bytes),
                SCAN_NAME = "amount_of_restructured_debt_"+id 
            };
            String result = _repository.ExecuteRequestAndGetTextResponse(SqlCreator.AddCalcRequestScan(model));
            return CreateReponseFromStringResult(result);
        }

        /// <summary>
        /// Получение получателя по его ИД
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage GetReceiver(Int32 id)
        {
            Receiver receiver = _repository.GetElement<Receiver>(SqlCreator.GetReceiverById(id));
            return Request.CreateResponse(HttpStatusCode.OK, receiver);
        }

        /// <summary>
        /// Стандартный текстовый ответ 
        /// </summary>
        /// <param name="result"></param>
        /// <returns></returns>
        private HttpResponseMessage CreateReponseFromStringResult(String result)
        {
            if (String.IsNullOrEmpty(result))
                return Request.CreateResponse(HttpStatusCode.OK, new { status = 1, err = "" });
            return Request.CreateResponse(HttpStatusCode.OK, new { status = 2, err = result });
        }

        /// <summary>
        /// Подтверждение векселей полученных от ДКСУ
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage ConfirmBills(List<ConfirmBillsResponse> data)
        {
            String result = _repository.ExecuteRequestAndGetTextResponse(SqlCreator.ConfirmBills(data));
            return CreateReponseFromStringResult(result);
        }

        /// <summary>
        /// Получение количества векселедержателей готовых к выплате
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public Int32 GetCAReceiversCount()
        {
            return _repository.GetElements<CA_Receivers>(SqlCreator.GetCAReceivers, x => x.STATUS == "XX").Count();
        }

        /// <summary>
        /// Изменение данных документов (к примеру описания)
        /// </summary>
        /// <param name="v_Documents"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage EditDocument(List<V_Documents> v_Documents)
        {
            StringBuilder stringBuilder = new StringBuilder();
            foreach (V_Documents document in v_Documents)
            {
                BillsSql sql = SqlCreator.ScanDocument(document.REC_ID.Value, new byte[0], document.DOC_ID, document.FILENAME, document.TYPE_ID, document.DESCRIPT);
                stringBuilder.Append(_repository.ExecuteRequestAndGetTextResponse(sql));
            }
            return CreateReponseFromStringResult(stringBuilder.ToString());
        }

        /// <summary>
        /// Получение количества РНК клиента по ИНН или паспортным данным
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage GetCustomersByParameter(String param, String sqlType)
        {
            Int32 result = _repository.GetCount<Customer>(SqlCreator.GetCustomerByParam(param, sqlType));
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

        /// <summary>
        /// Поиск клиента по РНК
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage GetClient(String rnk)
        {
            Customer result = _repository.GetElement<Customer>(SqlCreator.GetCustomerByRnk(rnk));
            if (result != null)
                result.ACCOUNTS = _repository.GetElements<ReceiverAccounts>(SqlCreator.GetReceiverAccounts(result.RNK.Value, result.CUSTTYPE.Value));
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

        /// <summary>
        /// Униварсальный метод для обработки запросов
        /// </summary>
        /// <param name="method">Выполняемый метод</param>        
        /// <param name="str">значение может быть пустым</param>
        /// <param name="id">значение может быть пустым (по умолчанию - 0)</param>
        /// <returns>Возвращает ответ на основе текстового результата запроса к БД</returns>
        [HttpPost]
        public HttpResponseMessage BillsRequest(String method, String str, Int32 id = 0)
        {
            // Получение варианта запроса в зависимости от значения переменной 'method'
            // Регистр приводится с нижнему...
            BillsSql sql = SqlCreator.GetSqlDataByMethodName(method, id, str);
            // Обработка запроса к БД
            String result = _repository.ExecuteRequestAndGetTextResponse(sql);
            // Формирование и отправка ответа в зависимости от результата полученного в результате
            // обработки запроса к БД
            return CreateReponseFromStringResult(result);
        }

        /// <summary>
        /// Получение буфера для подписи
        /// </summary>
        /// <param name="id">ИД взыскателя</param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage GetBuffer(Int32 id)
        {
            // Получение модели для запроса
            BillsSql sql = SqlCreator.GetSignBuffer(id);
            String buffer = String.Empty;
            String base64 = String.Empty;
            try
            {
                // Выполнение запроса на получение буфера
                OracleParameterCollection collection = _repository.ExecuteProcedureAndKeepOpen(sql, false, User.Identity.Name);
                // Получение объекта хранящего данные из массива данных с ответа
                using (OracleClob oracleClob = (OracleClob)collection["result"].Value)
                {
                    // получение буфера
                    buffer = oracleClob.Value;
                }
            }
            catch
            {
                _repository.RollbackTransaction(User.Identity.Name);
            }
            return Request.CreateResponse(HttpStatusCode.OK, new { buffer = buffer });
        }

        /// <summary>
        /// Сохранение подписи, выполнение процедуры по резервированию взыскателя за банком и закрытие соединения
        /// </summary>
        /// <param name="sign">объект хранящий подпись</param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage SaveCreateRequestSign([ModelBinder(typeof(SignModelBind))]Sign sign)
        {
            String result = "Виникла помилка при збереженні підпису!";
            try
            {
                OracleParameterCollection resultCollection = _repository.ExecuteProcedureAndKeepOpen(SqlCreator.SaveSign(sign), true, User.Identity.Name);
                if(resultCollection == null)
                    _repository.RollbackTransaction(User.Identity.Name);
                else
                    result = "";
            }
            catch {
                _repository.RollbackTransaction(User.Identity.Name);
            }
            return CreateReponseFromStringResult(result);
        }

        /// <summary>
        /// Сохранение изменений по взыскателю
        /// </summary>
        /// <param name="sign">объект хранящий подпись</param>
        /// <param name="receiver"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage SaveReceiver([ModelBinder(typeof(EditReceiverModelBind))]Receiver receiver)
        {
            String result = "";
            try
            {
                OracleParameterCollection collection = _repository.ExecuteProcedureAndKeepOpen(SqlCreator.UpdateReceiver(receiver), false, User.Identity.Name);
                OracleString oracleString = (OracleString)collection["p_err_text"].Value;
                result = oracleString.IsNull ? "" : oracleString.Value;
            }
            catch(Exception e)
            {
                result = e.Message;
                _repository.RollbackTransaction(User.Identity.Name);
            }
            return CreateReponseFromStringResult(result);
        }

        /// <summary>
        /// Откат транзакции
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage RollBackTransaction()
        {
            String result = "Зміни відмінено з технічних причин";
            _repository.RollbackTransaction(User.Identity.Name);
            return CreateReponseFromStringResult(result);
        }

        /// <summary>
        /// отправка файла расчета сумм реструктуризированной задолжности
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage SendAmountOfRestrDebt(Int32 id)
        {
            String result = _repository.ExecuteRequestAndGetTextResponse(SqlCreator.SendCalcRequest(id));
            return CreateReponseFromStringResult(result);
        }

        /// <summary>
        /// Добавление файла в хранилище
        /// </summary>
        /// <param name="description">описание файла</param>
        /// <param name="fileName">Имя файла</param>
        /// <returns>пустая строка - успешно, не пустая строка - текст ошибки</returns>
        [HttpPost]
        public HttpResponseMessage AttachStorageFile(String description, String fileName)
        {
            description = String.IsNullOrEmpty(description) ? "" : description;
            fileName = fileName.EndsWith(".pdf") ? fileName : fileName + ".pdf";
            SaveFileModel model = new SaveFileModel
            {
                Description = description,
                FileName = fileName
            };
            Bars.UserControls.ByteData uploadedImage = (Bars.UserControls.ByteData)HttpContext.Current.Session["image_bill_data"];
            // получение массива байтов (файла)
            model.Data = uploadedImage.Data;
            // очистка сессии
            HttpContext.Current.Session["image_bill_data"] = null;
            String result = _repository.ExecuteRequestAndGetTextResponse(SqlCreator.AttachStorageFile(model));
            return CreateReponseFromStringResult(result);
        }

        /// <summary>
        /// Изменение данных документов (к примеру описания)
        /// </summary>
        /// <param name="File_Archive"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage EditStorageFile(List<File_Archive> documents)
        {
            StringBuilder stringBuilder = new StringBuilder();
            foreach (File_Archive document in documents)
            {
                stringBuilder.Append(_repository.ExecuteRequestAndGetTextResponse(SqlCreator.EditStorageFile(document)));
            }
            return CreateReponseFromStringResult(stringBuilder.ToString());
        }

        /// <summary>
        /// Удаление файла из архива
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage RemoveStorageFile(Int32 id)
        {
            String result = _repository.ExecuteRequestAndGetTextResponse(SqlCreator.RemoveStorageFile(id));
            return CreateReponseFromStringResult(result);
        }
    }
}