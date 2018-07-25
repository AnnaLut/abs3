<%@ WebHandler Language="C#" Class="tomas" %>

using System;
using System.Web;

using System.Web.SessionState;
using System.IO;
using System.Xml;
using System.Data;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using bars.services.core.wrapper;
using bars.services.core.modules.security;

using Bars.Application;
using barsroot.core;

public class tomas : IHttpHandler, IRequiresSessionState
{
    #region Константы
    public const String TypeID = "TOMAS";
    #endregion

    #region Приватные методы
    string Xml2String(XmlDocument xmlDoc)
    {
        using (var stringWriter = new StringWriter())
        {
            using (var xmlTextWriter = XmlWriter.Create(stringWriter))
            {
                xmlDoc.WriteTo(xmlTextWriter);
                xmlTextWriter.Flush();
                return stringWriter.GetStringBuilder().ToString();
            }
        }
    }

    void Logging(XmlDocument XmlRequest, XmlDocument XmlResponce, string p_ref)
    {
        string p_in_xml = XmlRequest != null ? Xml2String(XmlRequest) : string.Empty;
        string p_out_xml = XmlResponce != null ? Xml2String(XmlResponce) : string.Empty;

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        try
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "ibx_pack.ins_log_xml";
                cmd.Parameters.Add("p_in_xml", OracleDbType.Clob, p_in_xml, ParameterDirection.Input);
                cmd.Parameters.Add("p_out_xml", OracleDbType.Clob, p_out_xml, ParameterDirection.Input);
                cmd.Parameters.Add("p_ref", OracleDbType.Varchar2, p_ref, ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    private string GetHostName()
    {
        string userHost = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

        if (String.IsNullOrEmpty(userHost) || String.Compare(userHost, "unknown", true) == 0)
            userHost = HttpContext.Current.Request.UserHostAddress;

        if (String.Compare(userHost, HttpContext.Current.Request.UserHostName) != 0)
            userHost += " (" + HttpContext.Current.Request.UserHostName + ")";

        return userHost;
    }
    private void LoginUser(String userName, HttpContext context)
    {
        // информация о текущем пользователе
        UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        try
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "bars.bars_login.login_user";

            cmd.Parameters.Add("p_session_id", OracleDbType.Varchar2, context.Session.SessionID, ParameterDirection.Input);
            cmd.Parameters.Add("p_user_id", OracleDbType.Varchar2, userMap.user_id, ParameterDirection.Input);
            cmd.Parameters.Add("p_hostname", OracleDbType.Varchar2, GetHostName(), ParameterDirection.Input);
            cmd.Parameters.Add("p_appname", OracleDbType.Varchar2, "barsroot", ParameterDirection.Input);

            cmd.ExecuteNonQuery();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        // Если выполнили установку параметров
        context.Session["UserLoggedIn"] = true;
    }
    #endregion

    #region Приватные методы
    //won't be used now, as processing and answers
    //public XmlDocument GetInfo(XmlDocument XmlMessage)
    //{
    //    XmlDocument Result = new XmlDocument();

    //    OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
    //    OracleCommand cmd = con.CreateCommand();
    //    try
    //    {
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.CommandText = "ibx_pack.get_info";
    //        cmd.Parameters.Add("p_type_id", OracleDbType.Varchar2, TypeID, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_params", OracleDbType.XmlType, XmlMessage.InnerXml, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_result", OracleDbType.XmlType, ParameterDirection.Output);
    //        cmd.ExecuteNonQuery();

    //        OracleXmlType XmlResponce = (OracleXmlType)cmd.Parameters["p_result"].Value;
    //        Result = XmlResponce.GetXmlDocument();
    //    }
    //    finally
    //    {
    //        con.Close();
    //        con.Dispose();
    //    }

    //    return Result;
    //}

    //public XmlDocument GetInfoDoc(XmlDocument XmlMessage)
    //{
    //    XmlDocument Result = new XmlDocument();

    //    OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
    //    OracleCommand cmd = con.CreateCommand();
    //    try
    //    {
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.CommandText = "ibx_pack.get_info_doc";
    //        cmd.Parameters.Add("p_params", OracleDbType.XmlType, XmlMessage.InnerXml, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_result", OracleDbType.XmlType, ParameterDirection.Output);
    //        cmd.ExecuteNonQuery();

    //        OracleXmlType XmlResponce = (OracleXmlType)cmd.Parameters["p_result"].Value;
    //        Result = XmlResponce.GetXmlDocument();
    //    }
    //    finally
    //    {
    //        con.Close();
    //        con.Dispose();
    //    }

    //    return Result;
    //}

    public class VerifyResult
    {
        public int Status { get; set; }
        public string Message { get; set; }
        public string ErrorMessage { get; set; }
    }
    /// <summary>
    ///  Проверка подписи на XML
    /// </summary>
    /// <param name="XmlMessage"></param>
    /// <returns></returns>
    public VerifyResult VerifySign(XmlDocument XmlMessage)
    {
        var verifyResult = new VerifyResult() { Status = 0 };

        /* Формирвание буфера из ТЗ
         * 1)	Для повідомлень ACT=1 та ACT=4 (ACT+”_” + PAY_ACCOUNT+”_”+SERVICE_ID+”_”+PAY_ID)  
           2)	Для ACT=7 (ACT+”_”+SERVICE_ID+”_”+PAY_ID) */
        var act = Convert.ToDecimal(XmlMessage.GetElementsByTagName("act")[0].InnerText);
        // проверка подписи только для act 1,4,7,10
        if (!(act == 1 || act == 4 || act == 7 || act == 10 )) return verifyResult;

        string payAccount = string.Empty;
        if (act != 7)
        {
            payAccount = XmlMessage.GetElementsByTagName("pay_account")[0].InnerText;
        }

        var serviceId = XmlMessage.GetElementsByTagName("service_id")[0].InnerText;
        var sign = XmlMessage.GetElementsByTagName("sign")[0].InnerText;
        var payId = XmlMessage.GetElementsByTagName("pay_id")[0].InnerText;
        XmlNodeList Transactions = XmlMessage.GetElementsByTagName("transaction");

        string buffer = string.Empty;
        if (act == 7)
        {
            buffer = string.Format("{0}_{1}_{2}", act, serviceId, payId);
        }
        else if (act == 10)
        {
            //Calculate sums of pay_amounts and fee_amounts:
            decimal pay_sum = 0;
            decimal fee_sum = 0;
            try
            {
                for (int i = 0; i < Transactions.Count; i++)
                {
                    pay_sum += Convert.ToDecimal(GetTransactionNodeElementValue(Transactions,"pay_amount", i, 2));
                    fee_sum += Convert.ToDecimal(GetTransactionNodeElementValue(Transactions,"fee_amount", i, 3));
                }
            }
            catch (Exception ex)
            {
                verifyResult.ErrorMessage = ex.Message; //wrong structure of <transaction> node element
                verifyResult.Status = -104;
                return verifyResult;
            }

            buffer = string.Format("{0}_{1}_{2}_{3}_{4}_{5}", act, payAccount, serviceId, payId, pay_sum, fee_sum);
        }
        else
        {
            buffer = string.Format("{0}_{1}_{2}_{3}", act, payAccount, serviceId, payId);
        }

        string serviceUrl = Bars.Configuration.ConfigurationSettings.AppSettings["Crypto.CryptoServer"];

        Uri serviceUri;
        if (!Uri.TryCreate(serviceUrl, UriKind.Absolute, out serviceUri))
        {
            verifyResult.ErrorMessage = string.Format("Не вдалося визначити адресу сервіса верифікації (вказано [{0}] у параметрі Crypto.CryptoServer)", serviceUrl);
            verifyResult.Status = -103;
            return verifyResult;
        }
        var data = new CheckSignData()
        {
            EncType = EncodingType.Base64,
            Buffer = AvtorManager.ToBase64(buffer, "utf-8"),
            SignedBuffer = sign,
            Id = "tomas_" + act + payId,
            ProviderType = ProviderType.CapiVegaDstu
        };

        var ht = new HttpCaller(serviceUri);
        var result = ht.Verify(data);
        verifyResult.Status = result.Status;
        if (verifyResult.Status != 0)
        {
            verifyResult.ErrorMessage = result.ErrorMessage;
            verifyResult.Status = -102;
        }

        return verifyResult;
    }

    //public XmlDocument Pay(XmlDocument XmlMessage)
    //{
    //    XmlDocument Result = new XmlDocument();
    //    /* NONSTOP24
    //     <pay-request>
    //        <act>4</act>
    //        <service_id>ХХХ</service_id>
    //        <pay_account>123434</pay_account>
    //        <pay_amount>10.20</pay_amount>
    //        <receipt_num>123568</receipt_num>
    //        <pay_id>XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</pay_id>
    //        <trade_point>term1232</trade_point>
    //        <sign>F454FR43DE32JHSAGDSSFS</sign>
    //       </pay-request>
    //     */
    //    Decimal Act = Convert.ToDecimal(XmlMessage.GetElementsByTagName("act")[0].InnerText);
    //    String ExtRef = XmlMessage.GetElementsByTagName("pay_id")[0].InnerText;
    //    String Serv_Id = XmlMessage.GetElementsByTagName("service_id")[0].InnerText;
    //    DateTime ExtDate = DateTime.Now;
    //    String ExtSource = XmlMessage.GetElementsByTagName("trade_point")[0].InnerText;
    //    String DealID = XmlMessage.GetElementsByTagName("pay_account")[0].InnerText;
    //    String ReceiptNumber = XmlMessage.GetElementsByTagName("receipt_num")[0].InnerText;
    //    String Sign = XmlMessage.GetElementsByTagName("sign")[0].InnerText;
    //    Decimal Sum = Convert.ToDecimal(XmlMessage.GetElementsByTagName("pay_amount")[0].InnerText);
    //    String Sum_Resp = XmlMessage.GetElementsByTagName("pay_amount")[0].InnerText;

    //    Decimal ResCode;
    //    String ResText;
    //    Decimal? ResRef = null;
    //    String Purpose = string.Empty;
    //    var tmp = String.Format("{0:yyyy-MM-dd HH:mm:ss}", ExtDate);

    //    OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
    //    OracleCommand cmd = con.CreateCommand();
    //    try
    //    {
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.CommandText = "ibx_pack.pay_osc";
    //        cmd.Parameters.Add("p_type_id", OracleDbType.Varchar2, 4000, TypeID, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_ext_ref", OracleDbType.Varchar2, 4000, ExtRef, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_ext_date", OracleDbType.Varchar2, 4000, string.Format("{0:yyyy-MM-dd HH:mm:ss}", ExtDate), ParameterDirection.Input);
    //        cmd.Parameters.Add("p_ext_source", OracleDbType.Varchar2, ExtSource, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_receipt_num", OracleDbType.Varchar2,4000, ReceiptNumber, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_deal_id", OracleDbType.Varchar2, 4000, DealID, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_sum", OracleDbType.Decimal, Sum, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_sign", OracleDbType.Varchar2, 4000, Sign, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_act", OracleDbType.Decimal, Act, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_serv_id", OracleDbType.Varchar2, 4000, Serv_Id, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_res_code", OracleDbType.Decimal, ParameterDirection.Output);
    //        cmd.Parameters.Add("p_res_text", OracleDbType.Varchar2, 1000, null, ParameterDirection.Output);
    //        cmd.Parameters.Add("p_res_ref", OracleDbType.Decimal, ParameterDirection.Output);
    //        cmd.ExecuteNonQuery();

    //        ResCode = ((OracleDecimal)cmd.Parameters["p_res_code"].Value).Value;
    //        ResText = ((OracleString)cmd.Parameters["p_res_text"].Value).IsNull ? String.Empty : ((OracleString)cmd.Parameters["p_res_text"].Value).Value;
    //        ResRef = ((OracleDecimal)cmd.Parameters["p_res_ref"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmd.Parameters["p_res_ref"].Value).Value;
    //    }
    //    catch (Exception e)
    //    {
    //        ResCode = -101;
    //        ResText = e.InnerException != null ? e.InnerException.Message : e.Message;
    //    }
    //    finally
    //    {
    //        con.Close();
    //        con.Dispose();
    //    }

    //    /*
    //     Код результата запроса:
    //        <?xml version="1.0" encoding="UTF-8" ?>
    //            <pay-response>
    //                <pay_id> XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</pay_id >
    //                <service_id>XXX</ service_id>
    //                <amount>10.20</amount>
    //                <status_code>22</status_code>
    //                <description>DDD</description>
    //                <time_stamp>27.01.2006 10:27:21</time_stamp>
    //                </pay-response>
    //                Или
    //                <?xml version="1.0" encoding="UTF-8" ?>
    //                <pay-response>
    //                <status_code>-100</status_code>
    //                <time_stamp>27.01.2006 10:27:21</time_stamp>
    //            </pay-response>
    //     */
    //    String ResponceText = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
    //    ResponceText += "<pay-response>";
    //    if (ResCode == 22)  // OK
    //    {
    //        ResponceText += String.Format("<pay_id>{0}</pay_id>", ExtRef);
    //        ResponceText += String.Format("<service_id>{0}</service_id>", Serv_Id);
    //        ResponceText += String.Format("<amount>{0}</amount>", Sum_Resp);
    //        // если платеж прошел - в description передаем реф-документа (для печати на чеке)
    //        ResponceText += String.Format("<description>{0}</description>", ResRef);
    //        // в pay_purpose запихиваем назначение платежа 
    //        ResponceText += String.Format("<pay_purpose>{0}</pay_purpose>", ResText);
    //    }
    //    else   // error
    //    {
    //        ResCode = -101;
    //        ResponceText += String.Format("<description>{0}</description>", ResText);
    //    }
    //    ResponceText += String.Format("<status_code>{0}</status_code>", ResCode);
    //    ResponceText += String.Format("<time_stamp>{0}</time_stamp>", DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss"));
    //    ResponceText += "</pay-response>";
    //    Result.LoadXml(ResponceText);

    //    return Result;
    //}

    //public XmlDocument MoneyTransfer(XmlDocument XmlMessage)
    //{
    //    XmlDocument Result = new XmlDocument();
    //    /* 
    //     <pay-request>
    //      <act>10</act>
    //      <service_id>TOMAS2</service_id>
    //      <trade_point>TERMIDSSTMFO</trade_point>
    //      <payer_name>XXXXXXXXXXXXXXX</payer_name>
    //      <pay_account>MFO.ACCOUNT.980</pay_account>
    //      <okpo>NNNNNN</okpo>
    //      <receiver_name>XXXXXXXXXXXXXX</receiver_name>
    //      <cash_symbol>NN</cash_symbol>
    //      <payment_purpose>XXXXXXXXXXXXXXXXXXXXXX</payment_purpose>
    //      <transactions>
    //        <transaction>
    //          <receipt_num>NNNNNNNNN</receipt_num>
    //          <pay_id>XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</pay_id>
    //          <pay_amount>XX.XX</pay_amount>
    //          <fee_amount>XX.XX</fee_amount>     
    //        </transaction>
    //        [...
    //        <transaction>
    //          <receipt_num>NNNNNNNNN</receipt_num>
    //          <pay_id>XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</pay_id>
    //          <pay_amount>XX.XX</pay_amount>
    //          <fee_amount>XX.XX</fee_amount>
    //        </transaction>
    //        ...]
    //       </transactions>
    //      <payment_params>
    //        <parameter>
    //          <name/>
    //          <value/>
    //        </parameter>
    //      </payment_params>
    //      <sign>VEGA.SIGN</sign>
    //    </pay-request>

    //     */
    //    Decimal Act = Convert.ToDecimal(XmlMessage.GetElementsByTagName("act")[0].InnerText);
    //    String Serv_Id = XmlMessage.GetElementsByTagName("service_id")[0].InnerText;

    //    DateTime ExtDate = DateTime.Now;
    //    String ExtSource = XmlMessage.GetElementsByTagName("trade_point")[0].InnerText;
    //    String PayerName = XmlMessage.GetElementsByTagName("payer_name")[0].InnerText;
    //    String[] DealID = XmlMessage.GetElementsByTagName("pay_account")[0].InnerText.Split('.'); //this field contains of MFO, Receiver account, Currency code
    //    String MFO = DealID[0];
    //    String ReceiverAccount = DealID[1];
    //    String CurrencyCode = DealID[2];
    //    Decimal OKPO = Convert.ToDecimal(XmlMessage.GetElementsByTagName("okpo")[0].InnerText);
    //    String ReceiverName = XmlMessage.GetElementsByTagName("receiver_name")[0].InnerText;
    //    String CashSymbol = XmlMessage.GetElementsByTagName("cash_symbol")[0].InnerText;
    //    String PaymentPurpose = XmlMessage.GetElementsByTagName("payment_purpose")[0].InnerText;

    //    XmlNodeList Transactions = XmlMessage.GetElementsByTagName("transaction");
    //    string[] transaction_infos = new string[Transactions.Count];
    //    int[] transaction_infos_sizes = new int[Transactions.Count];
    //    string[] answer_infos = null;

    //    String receiptNum = String.Empty;
    //    String extRef = String.Empty;
    //    String sum = String.Empty;
    //    String fee = String.Empty;

    //    try
    //    {
    //        for (int i = 0; i < Transactions.Count; i++)
    //        {
    //            receiptNum = GetTransactionNodeElementValue(Transactions, "receipt_num", i, 0);
    //            extRef = GetTransactionNodeElementValue(Transactions, "pay_id", i, 1);
    //            sum = GetTransactionNodeElementValue(Transactions, "pay_amount", i, 2);
    //            fee = GetTransactionNodeElementValue(Transactions, "fee_amount", i, 3);

    //            transaction_infos[i] = String.Concat(receiptNum,"@", extRef, "@", sum, "@", fee);  // format of transaction_infos[i] is pay_id@pay_amount@fee_amount
    //            transaction_infos_sizes[i] = transaction_infos[i].Length + 50; // just to make bigger than length of its string
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        return ErrorResponse(-104, ex.Message);  // wrong structure of <transaction> block
    //    }

    //    decimal ResCode = -100;
    //    string ResText = string.Empty;

    //    var tmp = String.Format("{0:yyyy-MM-dd HH:mm:ss}", ExtDate);

    //    OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
    //    OracleCommand cmd = con.CreateCommand();
    //    try
    //    {
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.CommandText = "ibx_pack.pay_legal_pers";
    //        cmd.Parameters.Add("p_trade_point", OracleDbType.Varchar2, 4000, ExtSource, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_payer_name", OracleDbType.Varchar2, 4000, PayerName, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_receiver_acc", OracleDbType.Varchar2, 4000, ReceiverAccount, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_receiver_mfo", OracleDbType.Varchar2, 4000, MFO, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_receiver_curr", OracleDbType.Varchar2, 4000, CurrencyCode, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_receiver_okpo", OracleDbType.Decimal, OKPO, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_receiver_name", OracleDbType.Varchar2, 4000, ReceiverName, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_cash_symb", OracleDbType.Varchar2, 4000, CashSymbol, ParameterDirection.Input);
    //        cmd.Parameters.Add("p_payment_purpose", OracleDbType.Varchar2, 4000, PaymentPurpose, ParameterDirection.Input);

    //        var transactions_info_assarr = cmd.Parameters.Add("p_transaction_info", OracleDbType.Varchar2, ParameterDirection.Input);
    //        transactions_info_assarr.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
    //        transactions_info_assarr.Value = transaction_infos;
    //        transactions_info_assarr.Size = transaction_infos.Length;
    //        transactions_info_assarr.ArrayBindSize = transaction_infos_sizes;

    //        var answer_assarr = cmd.Parameters.Add("p_answer_info", OracleDbType.Varchar2, ParameterDirection.Output);
    //        answer_assarr.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
    //        answer_assarr.Value = null;
    //        answer_assarr.Size = transaction_infos.Length;
    //        answer_assarr.ArrayBindSize = transaction_infos_sizes; //just any sizes big enough for answer_assarr[i] which contains pay_id@ref

    //        cmd.Parameters.Add("p_res_code", OracleDbType.Decimal, ParameterDirection.Output);
    //        cmd.Parameters.Add("p_res_text", OracleDbType.Varchar2, 1000, null, ParameterDirection.Output);
    //        cmd.ExecuteNonQuery();

    //        ResCode = ((OracleDecimal)cmd.Parameters["p_res_code"].Value).Value;
    //        ResText = ((OracleString)cmd.Parameters["p_res_text"].Value).IsNull ? String.Empty : ((OracleString)cmd.Parameters["p_res_text"].Value).Value;
    //        if (cmd.Parameters["p_answer_info"].Value != null)
    //        {
    //            answer_infos = new string[Transactions.Count];
    //            answer_infos = Array.ConvertAll((OracleString[])cmd.Parameters["p_answer_info"].Value, item => item.ToString());
    //        }
    //    }
    //    catch (Exception e)
    //    {
    //        ResText = e.InnerException != null ? e.InnerException.Message : e.Message;
    //    }
    //    finally
    //    {
    //        con.Close();
    //        con.Dispose();
    //    }

    //    /*
    //     Код результата запроса:

    //        1. Успешный запрос:
    //       <?xml version="1.0" encoding="utf-8"?>
    //        <pay-response>
    //            <transactions>
    //                <transaction>
    //                    <pay_id>XXXX-XXXXXXXXX-XXXX</pay_id>
    //                    <ref>XXXXXXXXX</ref>
    //                    <status_code>22</status_code>
    //                </transaction>
    //                <transaction>
    //                    <pay_id>XXXX-XXXXXXXXX-XXXX</pay_id>
    //                    <ref>XXXXXXXXX</ref>
    //                    <status_code>22</status_code>
    //                </transaction>
    //            </transactions>
    //            <service_id>TOMAS2</service_id>
    //            <time_stamp>22.09.2017 17:28:32</time_stamp>
    //        </pay-response>

    //       2. Ошибка при выполнении процедуры - не прошла ни одна операция:

    //                <?xml version="1.0" encoding="utf-8"?>
    //                <pay-response>
    //                    <service_id>TOMAS2</service_id>
    //                    <description>XXXXX</description>
    //                    <status_code>-100</status_code>    - в случае неправильной структуры xml в части транзакции - "-104"
    //                    <time_stamp>22.09.2017 17:24:21</time_stamp>
    //                </pay-response>
    //     */
    //    String ResponseText = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
    //    ResponseText += "<pay-response>";
    //    if (answer_infos != null)
    //    {
    //        ResponseText += "<transactions>";
    //        for (int i = 0; i < answer_infos.Length; i++)
    //        {
    //            var answer_info = answer_infos[i].Split('@');  //answer_info structure is pay_id@ref
    //            ResponseText += String.Format("<transaction>" +
    //                                              "<pay_id>{0}</pay_id>" +
    //                                              "<ref>{1}</ref>" +     // if ref field is empty = this operation went wrong, general status will be error
    //                                              "<status_code>{2}</status_code>" +
    //                                          "</transaction>", answer_info[0], answer_info[1],ResCode);
    //        }
    //        ResponseText += "</transactions>";
    //    };

    //    ResponseText += String.Format("<service_id>{0}</service_id>", Serv_Id);

    //    if (ResCode != 22)  //Error
    //    {
    //        ResponseText += String.Format("<description>{0}</description>", ResText);
    //        ResponseText += String.Format( "<status_code>{0}</status_code>", ResCode);
    //    }

    //    ResponseText += String.Format("<time_stamp>{0}</time_stamp>", DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss"));
    //    ResponseText += "</pay-response>";
    //    Result.LoadXml(ResponseText);

    //    return Result;
    //}

    private string GetTransactionNodeElementValue(XmlNodeList transList, string elemName, int trIndex, int orderIndex)
    {
        XmlNode elem = transList[trIndex].ChildNodes.Item(orderIndex);
        if (elem.Name == elemName)
        {
            return elem.InnerText;
        }
        else
        {
            throw new Exception("Не правильна структура вхідного запиту: не знайдено поле " + elemName + " як " + (orderIndex+1)+ "-й" + " параметр розділу transaction, номер транзакції: " + (trIndex + 1));
        }
    }

    public XmlDocument ErrorResponse(int statusCode, string ErrorMessage)
    {
        var result = new XmlDocument();
        var xmlText = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
                      " <pay-response>" +
                      "  <status_code>{0}</status_code>" +
                      "  <error_message>{1}</error_message>" +
                      "  <time_stamp>{2}</time_stamp>" +
                      " </pay-response>";
        xmlText = string.Format(xmlText, statusCode, ErrorMessage, DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss"));
        result.LoadXml(xmlText);
        return result;
    }

    #endregion

    #region Реализация интерфейса
    public void ProcessRequest(HttpContext context)
    {
        // переводим в XML
        XmlDocument XmlRequest = new XmlDocument();
        XmlRequest.Load(context.Request.InputStream);

        // логин/пароль
        String UserName = "tech_tomas";
        String Password = "qwerty";

        //// авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);
        if (isAuthenticated) LoginUser(UserName, context);

        // действие
        String Act = XmlRequest.GetElementsByTagName("act")[0].InnerText.ToLower();
        string pay_id = string.Format("{0} {1}", XmlRequest.GetElementsByTagName("pay_id")[0].InnerText,
            DateTime.Now.ToString());

        XmlDocument XmlResponce = null;
        Logging(XmlRequest, XmlResponce, pay_id);

        // проверка подписи
        var verifyResult = VerifySign(XmlRequest);
        //var verifyResult = new VerifyResult { Status = 0 };
        if (verifyResult.Status == 0)
        {
            string result = string.Empty;
            OracleClob clob =null;
            using (OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                using (OracleCommand comm = con.CreateCommand())
                {
                    comm.CommandText = "ibx_pack.ExchangeData";
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.Add("p_params", OracleDbType.Clob, XmlRequest.InnerXml, ParameterDirection.Input);
                    comm.Parameters.Add("p_result", OracleDbType.Clob, ParameterDirection.Output);
                    comm.ExecuteNonQuery();

                    using (clob = (OracleClob)comm.Parameters["p_result"].Value)
                    {
                        if (clob != null)
                        {
                            result = clob.Value;
                        }
                    }
                }
            }
            XmlResponce = new XmlDocument();
            XmlResponce.LoadXml(result);

            /*
             Допустимые значения:
                1 – запрос информации про абонента, и
                проверка возможности оплаты (info);
                4 – запрос на оплату платежа (pay);
                7 – проверка состояния транзакции (status);
                10 - перевод денег
             */
            //switch (Act)
            //{
            //    case "1":
            //        XmlResponce = GetInfo(XmlRequest);
            //        break;
            //    case "4":
            //        XmlResponce = Pay(XmlRequest);
            //        break;
            //    case "7":
            //        XmlResponce = GetInfoDoc(XmlRequest);
            //        break;
            //    case "10":
            //        XmlResponce = MoneyTransfer(XmlRequest);
            //        break;
            //    default:
            //        XmlResponce = null;
            //        break;
            //}
        }
        else
        {
            XmlResponce = ErrorResponse(verifyResult.Status, verifyResult.ErrorMessage);
        }

        // ответ
        context.Response.ContentType = "text/xml";
        context.Response.ContentEncoding = System.Text.Encoding.UTF8;
        XmlResponce.Save(context.Response.Output);

        Logging(XmlRequest, XmlResponce, pay_id);

        context.Response.Flush();
        context.Response.End();
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
    #endregion
}