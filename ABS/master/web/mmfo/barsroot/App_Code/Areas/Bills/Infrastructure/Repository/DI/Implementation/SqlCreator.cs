using BarsWeb.Areas.Bills.Model;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace BarsWeb.Areas.Bills.Infrastructure.DI.Implementation
{
    /// <summary>
    /// Формирование переменных для запросов к БД или строки запроса!
    /// </summary>
    public class SqlCreator
    {
        //  byte                => OracleDbType.Byte
        //  byte[]              => OracleDbType.Raw
        //  char                => OracleDbType.Varchar2
        //  char[]              => OracleDbType.Varchar2
        //  DateTime            => OracleDbType.TimeStamp
        //  short               => OracleDbType.Int16
        //  int                 => OracleDbType.Int32
        //  long                => OracleDbType.Int64
        //  float               => OracleDbType.Single
        //  double              => OracleDbType.Double
        //  Decimal             => OracleDbType.Decimal
        //  string              => OracleDbType.Varchar2
        //  TimeSpan            => OracleDbType.IntervalDS
        //  OracleBFile         => OracleDbType.BFile
        //  OracleBinary        => OracleDbType.Raw
        //  OracleBlob          => OracleDbType.Blob
        //  OracleClob          => OracleDbType.Clob
        //  OracleDate          => OracleDbType.Date
        //  OracleDecimal       => OracleDbType.Decimal
        //  OracleIntervalDS    => OracleDbType.IntervalDS
        //  OracleIntervalYM    => OracleDbType.IntervalYM
        //  OracleRefCursor     => OracleDbType.RefCursor
        //  OracleString        => OracleDbType.Varchar2
        //  OracleTimeStamp     => OracleDbType.TimeStamp
        //  OracleTimeStampLTZ  => OracleDbType.TimeStampLTZ
        //  OracleTimeStampTZ   => OracleDbType.TimeStampTZ
        //  OracleXmlType       => OracleDbType.XmlType
        //  OracleRef           => OracleDbType.Ref
        //  bool                => OracleDbType.Boolean

        /// <summary>
        /// Объект возвращаемого текстового значения для процедур 
        /// </summary>
        private static OracleParameter ErrTextParameter { get { return new OracleParameter("p_err_text", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output); } }

        /// <summary>
        /// Список объектов с параметром хранящем ИД
        /// </summary>
        /// <param name="id">ИД значение для параметра</param>
        /// <returns></returns>
        private static List<OracleParameter> parametersWithId(Int32 id) {
            return new List<OracleParameter>
            {
                new OracleParameter("id", OracleDbType.Int32, id, ParameterDirection.Input)
            }; 
        }

        /// <summary>
        /// Упрощенный метод возвращаемый объект для запроса к БД
        /// Объект фозмируется по зачению хранящемуся в переменной "method"
        /// Регистр значения не имеет
        /// </summary>
        /// <param name="method">Название метода</param>
        /// <param name="id">ИД (по умолчанию можно передавать - 0)</param>
        /// <param name="str">Строковой параметр (по умолчанию можно передавать - null)</param>
        /// <returns></returns>
        public static BillsSql GetSqlDataByMethodName(String method, Int32 id, String str)
        {
            switch (method.ToLower())
            {
                case "selectreceiver":
                    return SelectReceiver(id);          // Поиск получателя (получение его ИД)
                case "createrequest":
                    return CreateRequest(id, str);      // Выполнение операций с решением или получателем (в зависимости от передаваемого поля str)
                case "setrecrecreq":
                    return SetReqReqRec(id);            // отправка взыскателя в ЦА для формирования выдержки
                case "printbillrequest":
                    return PrintBillRequest(id);        // получение заявления на выплату
                case "deletereceiver":
                    return DeleteReceiver(id);          // Удаление получателя
                case "attachapplication":
                    return AttachApplication(id, null); // Отправка отсканированных документов в ДКСУ
                case "deletescanndoc":
                    return DeleteDocument(id);          // Удаление отсканированного документа
                case "sendcareceivers":
                    return ConfirmRequestList();        // Отправка списка получателей для формирование "витягу"
                case "getbills":
                    return GetBillsFromDKSU();          // Получение списка векселей с ДКСУ
                case "sendtoregion":
                    return SendBillsToRegion(str);      // Отправка полученных векселей на регионы
                case "getbillsfromca":
                    return GetBillsLocal();             // Получение списка векселей с ЦА
                case "updatestatuses":
                    return UpdateReqStatuses(id);       // Обновление статусов -- 1 - принудительно (по кнопке), 0 - обычное
                case "issuebillsofexchange":
                    return IssueBillsOfExchange(id);    // Выдача векселей взыскателю
                case "revokerequest":
                    return RevokeRequest(id);           // Отправка взыскателя в ДКСУ для отбракования
                default:
                    return null;
            }
        }

        /// <summary>
        /// Строка запроса для получения списка полученых векселей в ЦА
        /// </summary>
        public static String GetConfirmedBills
        {
            get { return "select * from bills.v_rec_bills t where t.status = 'RC' order by t.last_dt desc"; }
        }

        /// <summary>
        /// Строка запроса для получения списка векселей
        /// </summary>
        public static String GetAllBills
        {
            get { return "select * from bills.v_rec_bills t order by t.last_dt desc"; }
        }

        /// <summary>
        /// Строка запроса для получения списка выдержек (витягів)
        /// </summary>
        public static String GetExtracts
        {
            get { return "select * from bills.extracts order by extract_number_id desc"; }
        }

        /// <summary>
        /// Список выдержек
        /// </summary>
        public static String GetExtractsDetailIds
        {
            get { return "select t.extract_id extract_number_id, t.extract_date from bills.v_extracts_detail t group by t.extract_id, t.extract_date order by t.extract_id desc"; }
        }

        /// <summary>
        /// Строка запроса для получения списка векселей для подтвержения принятия от ЦА
        /// </summary>
        public static String GetBillsToConfirm
        {
            get { return "select * from bills.v_rec_bills t where t.status = 'SN' order by t.last_dt desc"; }
        }

        /// <summary>
        /// Строка запроса для получения векселей от ЦА
        /// </summary>
        public static String GetLocalBillsToConfirm
        {
            get { return "select * from bills.v_rec_bills_local t where t.STATUS = 'SR' order by t.last_dt desc"; }
        }

        /// <summary>
        /// Строка запроса для получения списка взыскателей (зтягувачів) на регионе
        /// </summary>
        public static String GetBillReceivers
        {
            get { return "select distinct t.exp_id, t.name, t.inn, t.doc_no, t.doc_who, t.expected_amount, t.status from bills.v_rec_bills_local t order by t.status desc"; }
        }

        /// <summary>
        /// Строка запроса для получения списка взыскателей (зтягувачів) на ЦА
        /// </summary>
        public static String GetReceivers // where t.status != 'VH'
        {
            get { return "select * from BILLS.V_RECEIVERS t order by t.last_dt desc"; }
        }

        /// <summary>
        /// Строка запроса для получения списка взыскателей готовых для отправки выдержки (витягу)
        /// </summary>
        public static String GetCAReceiversReadyForExtract
        {
            get { return "select * from BILLS.V_CA_RECEIVERS t where t.status = 'XX' order by t.extract_date desc"; }
        }

        /// <summary>
        /// Строка запроса для получения списка взыскателей на ЦА
        /// </summary>
        public static String GetCAReceivers
        {
            get { return "select * from bills.v_ca_receivers"; }
        }

        /// <summary>
        /// получение списка регионов с полученными векселями на ЦА
        /// </summary>
        public static String GetBranches
        {
            get { return "select distinct t.branch from bills.v_rec_bills t where t.status = 'RC'"; }
        }

        /// <summary>
        /// получение списка проводок по векселям
        /// </summary>
        public static String GetOpers
        {
            get { return "select * from BILLS.V_OPERS t"; }
        }

        /// <summary>
        /// получение списка файлов - расчет сумм реструктуризированной задолжности
        /// </summary>
        public static String GetAmountOfRestrDebt
        {
            get{ return "select * from bills.v_calc_requests t"; }
        }

        /// <summary>
        /// Хранилище файлов
        /// </summary>
        public static String GetFilesFromStorage
        {
            get { return "select t.kf, t.file_id, t.file_name, t.description, t.load_date, t.file_status from bills.v_file_archive t"; }
        }

        /// <summary>
        /// Получение текушего МФО
        /// </summary>
        public static String GetCurrentMfo
        {
            get{ return "select bills.bill_abs_integration.f_ourmfo from dual"; }
        }
        
        /// <summary>
        /// Получение списка документов по ИД взыскателя
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql GetScannedDocuments(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "select * from bills.v_documents t where t.rec_id = :rec_id and t.type_id != 1",
                Parameters = new List<OracleParameter> { new OracleParameter("rec_id", OracleDbType.Int32, id, ParameterDirection.Input) }
            };
        }

        /// <summary>
        /// Получение списка взыскателей по ИД выдержки
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql GetExtract_CA_Receivers(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "select * from bills.v_ca_receivers t where t.extract_number_id = :id",
                Parameters = parametersWithId(id)
            };
        }

        /// <summary>
        /// Получение списка взыскателей по ИД выдержки для архива выдержек
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql GetExtractsDetailReceivers(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "select * from bills.V_EXTRACTS_DETAIL t where t.extract_id = :id",
                Parameters = parametersWithId(id)
            };
        }

        /// <summary>
        /// Получение списка векселей по ИД взыскателя
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql GetBillsByExpectedId(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "select * from bills.v_rec_bills t where t.EXP_ID = :id order by t.last_dt desc",
                Parameters = parametersWithId(id)
            };
        }

        /// <summary>
        /// Получение списка векселей по взыскателю (определенному решению) полученных на регионе
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql GetBillsCountInRegionByExpId(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "select * from bills.v_rec_bills t where t.EXP_ID = :id and t.status = 'RR' order by t.last_dt desc",
                Parameters = parametersWithId(id)
            };
        }

        /// <summary>
        /// получение заявления на выплату
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql PrintBillRequest(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.GetApplication",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_id", OracleDbType.Int32, id, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Получение ИД документа или null в случае его отсутствия
        /// </summary>
        /// <param name="id"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        public static BillsSql GetDocumentId(Int32 id, String type)
        {
            return new BillsSql
            {
                SqlText = "select t.doc_id from BILLS.V_DOCUMENTS t where t.rec_id = :id and t.type_code = :type",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("id", OracleDbType.Int32, id, ParameterDirection.Input),
                    new OracleParameter("type", OracleDbType.Varchar2, type, ParameterDirection.Input)
                }
            };
        }

        /// <summary>
        /// Создание, редактирование документа
        /// </summary>
        /// <param name="id">record ID</param>
        /// <param name="bytes">Массив байтов</param>
        /// <param name="docId">doc ID</param>
        /// <param name="fileName">Имя файла</param>
        /// <param name="docType">2 - application, 3 - other document</param>
        /// <returns></returns>
        public static BillsSql ScanDocument(Int32 id, Byte[] bytes, Int32? docId, String fileName, Int32 docType, String description)
        {
            String clob = bytes.Length == 0 ? null : Convert.ToBase64String(bytes);
            return new BillsSql
            {
                SqlText = "bills.bill_api.AddDocument",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_doc_id", OracleDbType.Int32, docId, ParameterDirection.InputOutput),
                    new OracleParameter("p_rec_id", OracleDbType.Int32, id, ParameterDirection.Input),
                    new OracleParameter("p_doc_type", OracleDbType.Int32, docType, ParameterDirection.Input),
                    new OracleParameter("p_doc_body", OracleDbType.Clob, clob, ParameterDirection.Input),
                    new OracleParameter("p_filename", OracleDbType.Varchar2, fileName, ParameterDirection.Input),
                    new OracleParameter("p_descript", OracleDbType.Varchar2, description, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Получение документа по ИД и типу
        /// </summary>
        /// <param name="id"></param>
        /// <param name="docType"></param>
        /// <returns></returns>
        public static BillsSql GetDocumentByRecordIdAndType(Int32 id, String docType)
        {
            return new BillsSql
            {
                SqlText = "select t.doc_id from BILLS.V_DOCUMENTS t where t.rec_id = :id and t.type_code = :type",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("id", OracleDbType.Int32, id, ParameterDirection.Input),
                    new OracleParameter("type", OracleDbType.Varchar2, docType, ParameterDirection.Input)
                }
            };
        }

        /// <summary>
        /// Получение документа в виде массива байт
        /// </summary>
        /// <param name="docId"></param>
        /// <returns></returns>
        public static BillsSql GetPrintDocument(Int32 docId)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.GetPrintDoc",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_doc_id", OracleDbType.Int32, docId, ParameterDirection.Input),
                    new OracleParameter("result", OracleDbType.Clob, ParameterDirection.ReturnValue)
                }
            };
        }

        /// <summary>
        /// Получение ожидаемого взыскателя
        /// </summary>
        /// <param name="resolutionDate">Дата решения</param>
        /// <param name="resolutionNumber">Номер решения</param>
        /// <returns></returns>
        public static BillsSql GetExpectedReceivers(DateTime resolutionDate, String resolutionNumber)
        {
            return new BillsSql
            {
                SqlText = "select * from bills.v_exp_receivers t where t.res_code = :p_res_code and t.res_date = :p_res_date order by t.exp_id desc",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_res_code", OracleDbType.Varchar2, resolutionNumber, ParameterDirection.Input),
                    new OracleParameter("p_res_date", OracleDbType.Date,     resolutionDate,   ParameterDirection.Input)
                }
            };
        }

        /// <summary>
        /// Получение взыскателя по ИД
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql GetReceiverById(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "select * from BILLS.V_RECEIVERS t where t.EXP_ID = :id",
                Parameters = parametersWithId(id)
            };
        }

        /// <summary>
        /// Получение списка ожидаемых взыскателей от ДКСУ и запись их в ЦА
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static BillsSql SearchReceivers(SearchReceiverModel model)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.SearchResolution",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_code", OracleDbType.Varchar2, model.ResolutionNumber, ParameterDirection.Input),
                    new OracleParameter("p_date", OracleDbType.Date,     model.ResolutionDate,   ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Поиск получателя (получение его ИД)
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql SelectReceiver(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.Move2Work",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_exp_id", OracleDbType.Int32, id, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Обновление данных взыскателя
        /// </summary>
        /// <param name="receiver"></param>
        /// <returns></returns>
        public static BillsSql UpdateReceiver(Receiver receiver)
        {
            return new BillsSql
            {
                SqlText = "BILLS.BILL_API.UpdateReceiver",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_exp_id",  OracleDbType.Int32,     receiver.EXP_ID,    ParameterDirection.Input),
                    new OracleParameter("p_name",    OracleDbType.Varchar2,  receiver.NAME,      ParameterDirection.Input),
                    new OracleParameter("p_inn",     OracleDbType.Varchar2,  receiver.INN,       ParameterDirection.Input),
                    new OracleParameter("p_docno",   OracleDbType.Varchar2,  receiver.DOC_NO,    ParameterDirection.Input),
                    new OracleParameter("p_docdate", OracleDbType.Date,      receiver.DOC_DATE,  ParameterDirection.Input),
                    new OracleParameter("p_docwho",  OracleDbType.Varchar2,  receiver.DOC_WHO,   ParameterDirection.Input),
                    new OracleParameter("p_cltype",  OracleDbType.Decimal,   receiver.CL_TYPE,   ParameterDirection.Input),
                    new OracleParameter("p_phone",   OracleDbType.Varchar2,  receiver.PHONE,     ParameterDirection.Input),
                    new OracleParameter("p_account", OracleDbType.Varchar2,  receiver.ACCOUNT,   ParameterDirection.Input),
                    new OracleParameter("p_rnk",     OracleDbType.Decimal,   receiver.RNK,       ParameterDirection.Input),
                    new OracleParameter("p_address", OracleDbType.Varchar2, receiver.ADDRESS, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Выполнение операций с решением или получателем (в зависимости от передаваемого поля action)
        /// </summary>
        /// <param name="id"></param>
        /// <param name="action"></param>
        /// <returns></returns>
        public static BillsSql CreateRequest(Int32 id, String action)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.CreateRequest",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_exp_id",     OracleDbType.Int32,     id,         ParameterDirection.Input),
                    new OracleParameter("p_action",     OracleDbType.Varchar2,  action,     ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Отправка отсканированных документов в ДКСУ
        /// </summary>
        /// <param name="id"></param>
        /// <param name="docId"></param>
        /// <returns></returns>
        public static BillsSql AttachApplication(Int32 id, Int32? docId)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.SendDocument",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_rec_id", OracleDbType.Int32, id, ParameterDirection.Input),
                    new OracleParameter("p_doc_id", OracleDbType.Int32, docId, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// отправка взыскателя в ЦА для формирования выдержки
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql SetReqReqRec(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.ConfirmRequest",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_id", OracleDbType.Int32, id, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Удаление отсканированного документа
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql DeleteDocument(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.DeleteDocument",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_doc_id", OracleDbType.Int32, id, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Отправка списка получателей для формирование "витягу"
        /// </summary>
        /// <returns></returns>
        public static BillsSql ConfirmRequestList()
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.ConfirmRequestList",
                Parameters = new List<OracleParameter> { ErrTextParameter }
            };
        }

        /// <summary>
        /// Удаление взыскателя
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql DeleteReceiver(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.deletereceiver",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_exp_id", OracleDbType.Int32, id, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Удаление получателя
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql GetComments(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "select t.COMMENTS from BILLS.RECEIVERS t where t.EXP_ID = :id",
                Parameters = parametersWithId(id)
            };
        }

        /// <summary>
        /// Добавление комментария
        /// </summary>
        /// <param name="id"></param>
        /// <param name="text"></param>
        /// <returns></returns>
        public static BillsSql AddComment(Int32? id, String text)
        {
            return new BillsSql
            {
                SqlText = "BILLS.BILL_API.CommentRequest",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_request_id", OracleDbType.Int32, id, ParameterDirection.Input),
                    new OracleParameter("p_comment", OracleDbType.Varchar2, text, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Обновление комментариев (с ДКСУ)
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql GetCommentsHistory(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "BILLS.BILL_API.getCommentsHistory",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_request_id", OracleDbType.Int32, id, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Получение списка векселей с ДКСУ
        /// </summary>
        /// <returns></returns>
        public static BillsSql GetBillsFromDKSU()
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.getBills",
                Parameters = new List<OracleParameter> { ErrTextParameter }
            };
        }

        /// <summary>
        /// Подтверждение списка векселей
        /// </summary>
        /// <param name="list"></param>
        /// <returns></returns>
        public static BillsSql ConfirmBills(List<ConfirmBillsResponse> list)
        {
            String xml = SerializeConfirmBillsResponse(list);
            return new BillsSql
            {
                SqlText = "bills.bill_api.ConfirmBillList",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_billlist", OracleDbType.XmlType, xml, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Сериализация списка векселей в xml
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        private static String SerializeConfirmBillsResponse(List<ConfirmBillsResponse> data)
        {
            StringBuilder strBuilder = new StringBuilder("<ROOT>");
            foreach (ConfirmBillsResponse item in data)
            {
                strBuilder.Append("<ConfirmBill>");
                strBuilder.Append(String.Format("<EXP_ID>{0}</EXP_ID><BILL_NO>{1}</BILL_NO>", item.EXP_ID, item.BILL_NO));
                strBuilder.Append("</ConfirmBill>");
            }
            strBuilder.Append("</ROOT>");
            return strBuilder.ToString();
        }

        /// <summary>
        /// Проверка - нужна ли подпись при сохранении
        /// </summary>
        /// <returns>0 - не подписывать, 1 - подписывать</returns>
        public static BillsSql GetStatusToSign()
        {
            return new BillsSql
            {
                SqlText = "Bills.BILL_ABS_INTEGRATION.get_sign_status",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_result", OracleDbType.Int32, ParameterDirection.ReturnValue)
                }
            };
        }

        /// <summary>
        /// Отправка полученных векселей на регионы
        /// </summary>
        /// <param name="branch"></param>
        /// <returns></returns>
        public static BillsSql SendBillsToRegion(String branch)
        {
            branch = branch == "ALL" ? "" : branch;
            return new BillsSql
            {
                SqlText = "bills.Bill_API.sendBillsbyMFO",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_mfo", OracleDbType.Varchar2, branch, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Получение списка векселей с ЦА
        /// </summary>
        /// <returns></returns>
        public static BillsSql GetBillsLocal()
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.getBillsLocal",
                Parameters = new List<OracleParameter> { ErrTextParameter }
            };
        }

        /// <summary>
        /// Обновление статусов
        /// </summary>
        /// <param name="force">1 - принудительно (по кнопке), 0 - обычное</param>
        /// <returns></returns>
        public static BillsSql UpdateReqStatuses(Int32 force)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.updateReqStatuses",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_force", OracleDbType.Int32, force, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Поиск пользователя по параметрам для получения РНК
        /// </summary>
        /// <param name="param">значение поиска</param>
        /// <param name="sqlType">тип поиска зависит от значения
        /// если в значении находятся только цифры - ищем по ИНН
        /// если в значении находятся не только цифры - ищем по имени</param>
        /// <returns></returns>
        public static BillsSql GetCustomerByParam(String param, String sqlType)
        {
            String sql = "select * from bills.v_bars_customer t where ";
            sql += sqlType == "inn" ? "t.okpo =:param" : "upper(t.nmk) like '%' || :param || '%'";
            return new BillsSql
            {
                SqlText = sql,
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("param", OracleDbType.Varchar2, param.ToUpper(), ParameterDirection.Input)
                }
            };
        }

        /// <summary>
        /// Выбор пользователя по РНК
        /// </summary>
        /// <param name="rnk"></param>
        /// <returns></returns>
        public static BillsSql GetCustomerByRnk(String rnk)
        {
            return new BillsSql
            {
                SqlText = "select * from bills.v_bars_customer t where t.rnk =:rnk",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input)
                }
            };
        }

        /// <summary>
        /// Список проведенных действие по взыскателю
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql GetReceiverLog(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "select * from BILLS.V_BILL_RECEIVER_LOG t where t.exp_id = :id order by id desc",
                Parameters = parametersWithId(id)
            };
        }

        /// <summary>
        /// Выдача векселей взыскателю
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql IssueBillsOfExchange(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "Bills.Bill_Api.HandOutBills",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_exp_id", OracleDbType.Int32, id, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Получение буфера для подприси
        /// </summary>
        /// <param name="id">Receivers.Exp_Id</param>
        /// <returns></returns>
        public static BillsSql GetSignBuffer(Int32 id)
        {
            return new BillsSql {
                SqlText = "bills.bill_sign_mgr.get_receiver_buffer",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_exp_id", OracleDbType.Int32, id, ParameterDirection.Input),
                    new OracleParameter("result", OracleDbType.Clob, ParameterDirection.ReturnValue)
                }
            };
        }

        /// <summary>
        /// Сохранение ЕЦП
        /// </summary>
        /// <param name="signModel"></param>
        /// <returns></returns>
        public static BillsSql SaveSign(Sign signModel)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_sign_mgr.store_receiver_sign",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_exp_id", OracleDbType.Int32, signModel.EXP_ID, ParameterDirection.Input),
                    new OracleParameter("p_signer", OracleDbType.Varchar2, signModel.SIGNER, ParameterDirection.Input),
                    new OracleParameter("p_signature", OracleDbType.Clob, signModel.SignString, ParameterDirection.Input)
                }
            };
        }

        /// <summary>
        /// Отправка взыскателя в ДКСУ для отбракования
        /// </summary>
        /// <param name="expId"></param>
        /// <returns></returns>
        public static BillsSql RevokeRequest(Int32 expId)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.revokerequest",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_exp_id", OracleDbType.Int32, expId, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Получение файла по его ид (v_documents)
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql GetFileById(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "select t.doc_body from bills.documents t where t.doc_id = :doc_id",
                Parameters = new List<OracleParameter> {
                    new OracleParameter("doc_id", OracleDbType.Int32, id, ParameterDirection.Input)
                }
            };
        }

        /// <summary>
        /// Загрузка файла реструктуризированной задолжности (получение его ид)
        /// </summary>
        /// <param name="dateFrom"></param>
        /// <returns></returns>
        public static BillsSql GetCalcRequestId(DateTime dateFrom)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.GetCalcRequest",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_request_id", OracleDbType.Int32, ParameterDirection.Output),
                    new OracleParameter("p_date_from", OracleDbType.Date, dateFrom, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// отправка отсканированного файла (Расчет сумм реструктуризированной задолжности) в ДКСУ
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql SendCalcRequest(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.SendCalcRequest",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_request_id", OracleDbType.Int32, id, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Сохранение файла Расчет сумм реструктуризированной задолжности
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static BillsSql AddCalcRequestScan(AddCalcRequestScanModel model)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.AddCalcRequestScan",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_request_id", OracleDbType.Int32, model.REQUEST_ID, ParameterDirection.Input),
                    new OracleParameter("p_scan_name", OracleDbType.Varchar2, model.SCAN_NAME, ParameterDirection.Input),
                    new OracleParameter("p_scan_body", OracleDbType.Clob,model.SCAN_BODY, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Получение Clob файла
        /// </summary>
        /// <param name="id">
        /// request_body - полученный с дксу
        /// scan_body - отсканированный
        /// </param>
        /// <returns></returns>
        public static BillsSql GetCalcFile(Int32 id, String bodyName)
        {
            return new BillsSql
            {
                SqlText = String.Format("select t.{0} from bills.v_calc_requests t where t.request_id = :p_rec_id", bodyName),
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_rec_id", OracleDbType.Int32, id, ParameterDirection.Input)
                }
            };
        }

        /// <summary>
        /// Получение счетов взятіх из по рнк
        /// </summary>
        /// <param name="rnk"></param>
        /// <param name="accountType"></param>
        /// <returns></returns>
        public static BillsSql GetReceiverAccounts(Int64 rnk, Int32 accountType)
        {
            String nls = accountType == 2 ? "00" : "20";
            String sql = "select * from bills.v_bars_accounts t where t.RNK = :rnk and t.NLS like '26" + nls + "%'";
            sql += accountType == 2 ? "" : " and t.ob22 in ('38', '05') order by t.ob22 desc";
            return new BillsSql
            {
                SqlText = sql,
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("rnk", OracleDbType.Int64, rnk, ParameterDirection.Input)
                }
            };
        }

        /// <summary>
        /// Добавление файла в архив
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public static BillsSql AttachStorageFile(SaveFileModel model)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.StoreFile",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_file_id", OracleDbType.Int32, ParameterDirection.Output),
                    new OracleParameter("p_file_name", OracleDbType.Varchar2, 4000, model.FileName, ParameterDirection.Input),
                    new OracleParameter("p_description", OracleDbType.Varchar2, 4000, model.Description, ParameterDirection.Input),
                    new OracleParameter("p_file_data", OracleDbType.Blob, model.Data, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Получение файла из архива
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql GetStorageFile(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "select t.file_data from bills.v_file_archive t where t.file_id = :id",
                Parameters = parametersWithId(id)
            };
        }

        /// <summary>
        /// Изменение данных файла (названия, описания)
        /// </summary>
        /// <param name="fileModel"></param>
        /// <returns></returns>
        public static BillsSql EditStorageFile(File_Archive fileModel)
        {
            fileModel.FILE_NAME = fileModel.FILE_NAME.EndsWith(".pdf") ? fileModel.FILE_NAME : fileModel.FILE_NAME + ".pdf";
            return new BillsSql
            {
                SqlText = "bills.bill_api.EditFileProperties",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_file_id", OracleDbType.Int32, fileModel.FILE_ID, ParameterDirection.Input),
                    new OracleParameter("p_file_name", OracleDbType.Varchar2, 4000, fileModel.FILE_NAME, ParameterDirection.Input),
                    new OracleParameter("p_description", OracleDbType.Varchar2, 4000, fileModel.DESCRIPTION, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }
        
        /// <summary>
        /// Удаление файла из архива
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql RemoveStorageFile(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.DeleteFile",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_file_id", OracleDbType.Int32, id, ParameterDirection.Input),
                    ErrTextParameter
                }
            };
        }

        /// <summary>
        /// Проверка подписей для предварительного показа списка взыскателей перед отравкой выдержки в ДКСУ
        /// </summary>
        /// <returns></returns>
        public static BillsSql CheckRequestListSign()
        {
            return new BillsSql
            {
                SqlText = "bills.bill_api.CheckRequestListSign",
                Parameters = new List<OracleParameter> { ErrTextParameter }
            };
        }

        /// <summary>
        /// Получение списка параметров для формирования отчета
        /// </summary>
        /// <param name="id">ИД отчета</param>
        /// <returns></returns>
        public static BillsSql GetReportParameters(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "select t.param_id ID, t.param_code PARAMETER, t.param_name INFO, t.param_type TYPE, t.nullable, t.active from bills.v_bill_reports_parameterized t where t.report_id = :id",
                Parameters = parametersWithId(id)
            };
        }

        /// <summary>
        /// Получение имени файла отчета
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql GetReportFileName(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "select t.frx_file_name from bills.v_bill_reports_parameterized t where t.report_id = :id",
                Parameters = parametersWithId(id)
            };
        }

        /// <summary>
        /// Получение списка отчетов
        /// </summary>
        /// <param name="id">отображаемые:
        /// 1 - все, null или 0 - активные
        /// </param>
        /// <returns></returns>
        public static String GetReportInfoList(Int32? id)
        {
            String param = id.HasValue && id.Value == 1 ? "" : "where t.active = 1";
            return String.Format("select t.report_id, t.report_name, t.frx_file_name, t.description, t.active from bills.v_bill_reports_parameterized t {0} group by t.report_name, t.report_id, t.frx_file_name, t.description, t.active order by t.report_id", param);
        }

        #region Отчеты

        /// <summary>
        /// Получение данных отчета по его ИД
        /// </summary>
        /// <param name="id">Ид отчета</param>
        /// <returns></returns>
        public static BillsSql GetReportInfoItem(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "select t.report_id, t.report_name, t.frx_file_name, t.description from bills.v_bill_reports_parameterized t where t.report_id = :id",
                Parameters = parametersWithId(id)
            };
        }

        /// <summary>
        /// Редактирование\создание отчета
        /// </summary>
        /// <param name="report">Report_ID = 0 - создание нового отчета</param>
        /// <returns></returns>
        public static BillsSql UpdateOrCreateReport(ReportInfo report)
        {
            // null для создания нового отчета
            Int32? ReportId = report.Report_ID == 0 ? null : (Int32?)report.Report_ID;
            return new BillsSql
            {
                SqlText = "bills.bill_reports.set_report",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_report_id", OracleDbType.Int32, ReportId, ParameterDirection.InputOutput),
                    new OracleParameter("p_report_name", OracleDbType.Varchar2, report.Report_Name, ParameterDirection.Input),
                    new OracleParameter("p_frx_file_name", OracleDbType.Varchar2, report.Frx_File_Name, ParameterDirection.Input),
                    new OracleParameter("p_description", OracleDbType.Varchar2, report.Description, ParameterDirection.Input)
                }
            };
        }

        /// <summary>
        /// Активация\деактивация отчета
        /// </summary>
        /// <param name="id">ИД отчета</param>
        /// <param name="active">если 1 (активный) - деактивировать, если 0 (не активный) - активировать</param>
        /// <returns></returns>
        public static BillsSql EnableDisableReport(Int32 id, Int32 active)
        {
            String sql = "bills.bill_reports." + (active == 1 ? "disable_report" : "enable_report");
            return new BillsSql
            {
                SqlText = sql,
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_report_id", OracleDbType.Int32, id, ParameterDirection.Input)
                }
            };
        }

        /// <summary>
        /// Получение списка параметров для отчетов
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static BillsSql GetReportParamValues(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "select t.param_id, t.param_code, t.param_name, t.param_type, t.nullable, t.report_id from bills.v_bill_reports_parameterized t where t.report_id = :id",
                Parameters = parametersWithId(id)
            };
        }

        /// <summary>
        /// Создание\обновление параметра
        /// </summary>
        /// <param name="item"></param>
        /// <returns></returns>
        public static BillsSql CreateUpdateReportParam(ReportParam item)
        {
            Int32? id = item.Param_Id == 0 ? null : (Int32?)item.Param_Id;
            return new BillsSql
            {
                SqlText = "bills.bill_reports.set_report_param",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_param_id", OracleDbType.Int32, id, ParameterDirection.InputOutput),
                    new OracleParameter("p_report_id", OracleDbType.Int32, item.Report_Id, ParameterDirection.Input),
                    new OracleParameter("p_param_code", OracleDbType.Varchar2, item.Param_Code, ParameterDirection.Input),
                    new OracleParameter("p_param_name", OracleDbType.Varchar2, item.Param_Name, ParameterDirection.Input),
                    new OracleParameter("p_param_type", OracleDbType.Varchar2, item.Param_Type.ToUpper(), ParameterDirection.Input),
                    new OracleParameter("p_nullable", OracleDbType.Int32, item.Nullable, ParameterDirection.Input)
                }
            };
        }

        /// <summary>
        /// Получение параметра отчета по его ид
        /// </summary>
        /// <param name="id">ИД параметра</param>
        /// <returns></returns>
        public static BillsSql GetReportParameter(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "select t.param_id, t.param_code, t.param_name, t.param_type, t.nullable from bills.v_bill_reports_parameterized t where t.param_id = :id",
                Parameters = parametersWithId(id)
            };
        }

        /// <summary>
        /// Удаление параметра
        /// </summary>
        /// <param name="id">ИД параметра</param>
        /// <returns></returns>
        public static BillsSql RemoveReportParameter(Int32 id)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_reports.remove_report_param",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_param_id", OracleDbType.Int32, id, ParameterDirection.Input)
                }
            };
        }

        /// <summary>
        /// Получение моделей отчетов
        /// </summary>
        /// <param name="kf">отделение (берется текущее)</param>
        /// <param name="reportId">ИД отчета</param>
        /// <returns></returns>
        public static BillsSql GetParametersModel(String kf, Int32 reportId)
        {
            return new BillsSql
            {
                SqlText = "select t.param_id, t.param_code, t.param_name, t.param_type, t.nullable, p.value_id, p.value, p.kf from bills.v_bill_reports_parameterized t left join bills.v_bill_report_param_values p on t.param_id = p.param_id and p.kf = :kf where t.report_id = :id",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("kf", OracleDbType.Varchar2, kf, ParameterDirection.Input),
                    new OracleParameter("id", OracleDbType.Int32, reportId, ParameterDirection.Input)
                }
            };
        }

        /// <summary>
        /// Получение списка значений параметров по умолчанию выдаваемых для выбора
        /// </summary>
        /// <param name="id">ИД параметра</param>
        /// <param name="kf">отделение (берется текущее)</param>
        /// <returns></returns>
        public static BillsSql GetParameterDefaultValues(Int32 id, String kf)
        {
            return new BillsSql
            {
                SqlText = "select t.value_id ID, t.value, t.param_id PARAMETER_ID from bills.v_bill_report_param_values t where t.param_id = :id and t.kf = :kf",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("id", OracleDbType.Int32, id, ParameterDirection.Input),
                    new OracleParameter("kf", OracleDbType.Varchar2, kf, ParameterDirection.Input)
                }
            };
        }

        /// <summary>
        /// Получение значения для параметра отчета по его ИД
        /// </summary>
        /// <param name="id">ИД значения параметра</param>
        /// <returns></returns>
        public static BillsSql GetParameterDefaultValue(Int32 id, String kf, Int32 parameterId)
        {
            return new BillsSql
            {
                SqlText = "select t.value_id ID, t.value from bills.v_bill_report_param_values t where t.value_id = :id and t.kf = :kf and t.param_id = :param_id",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("id", OracleDbType.Int32, id, ParameterDirection.Input),
                    new OracleParameter("kf", OracleDbType.Varchar2, kf, ParameterDirection.Input),
                    new OracleParameter("param_id", OracleDbType.Int32, parameterId, ParameterDirection.Input)
                }
            };
        }

        /// <summary>
        /// Создание\изменение значения параметра отчета
        /// </summary>
        /// <param name="model">Модель значения параметра отчета</param>
        /// <param name="kf">отделение (берется текущее)</param>
        /// <returns></returns>
        public static BillsSql AddUpdateParameterValue(ParameterValue model, String kf)
        {
            Int32? id = model.ID == 0 ? null : (Int32?)model.ID;
            return new BillsSql
            {
                SqlText = "bills.bill_reports.set_param_value",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_kf", OracleDbType.Varchar2, kf, ParameterDirection.Input),
                    new OracleParameter("p_param_id", OracleDbType.Int32, model.PARAMETER_ID, ParameterDirection.Input),
                    new OracleParameter("p_value_id", OracleDbType.Int32, id, ParameterDirection.Input),
                    new OracleParameter("p_value", OracleDbType.Varchar2, model.VALUE, ParameterDirection.Input)
                }
            };
        }

        /// <summary>
        /// Удаление значения параметра отчета
        /// </summary>
        /// <param name="model">Модель значения параметра отчета</param>
        /// <param name="kf">отделение (берется текущее)</param>
        /// <returns></returns>
        public static BillsSql RemoveParameterValue(ParameterValue model, String kf)
        {
            return new BillsSql
            {
                SqlText = "bills.bill_reports.remove_param_value",
                Parameters = new List<OracleParameter>
                {
                    new OracleParameter("p_kf", OracleDbType.Varchar2, kf, ParameterDirection.Input),
                    new OracleParameter("p_param_id", OracleDbType.Int32, model.PARAMETER_ID, ParameterDirection.Input),
                    new OracleParameter("p_value_id", OracleDbType.Int32, model.ID, ParameterDirection.Input)
                }
            };
        }
        #endregion
    }
}