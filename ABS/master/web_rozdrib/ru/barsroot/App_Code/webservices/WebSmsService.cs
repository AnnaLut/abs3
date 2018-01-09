using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Xml;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.IO;
using System.Xml.Linq;
using System.Text;
using System.Net;
using websms;
using Bars.SMS;
using ibank.core;
using Bars.Configuration;
using Bars.Application;
using Bars.Classes;
using Oracle.DataAccess.Client;
using barsroot.core;
using BarsWeb.Core.Logger;
using BarsWeb.Infrastructure.Repository.DI.Implementation;

/// <summary>
/// клас смс повідомлення
/// </summary>
public class message
{
    private string msg_ref { get; set; }
    private Decimal msg_id { get; set; }
    private string msg_status { get; set; }
    //довідник статусів
    private List<string> state_code_list = new List<string> { "INVREQ", "ACCEPT", "INVSRC", "INVDST", "INVMSG", "DELIVERED", "EXPIRED", "UNDELIV" };

    /// <summary>
    /// конструктор для проставлення статусу та референсу після відпрвки
    /// </summary>
    /// <param name='msg_id'>ідентифікатор СМС в БАРС</param>
    /// <param name='msg_xml'>xml відповідно до специфікації</param>
    public message(Decimal msg_id, string msg_xml)
    {

        init(msg_id, msg_xml);

    }

    /// <summary>
    /// конструктор для проставлення статусу доставки
    /// </summary>
    /// <param name='msg_xml'>xml відповідно до специфікації</param>
    public message(string msg_xml)
    {

        init(msg_xml);

    }


    private void init(Decimal msg_id, string msg_xml)
    {
        this.msg_id = msg_id;
        parse_xml(msg_xml);
        save_ref();
    }
    private void init(string msg_xml)
    {
        parse_xml(msg_xml);
        set_status();
    }
    //збереження референсу повідомлення для проставлення статусу про доставку
    private void save_ref()
    {
        BbConnection bb_con = new BbConnection();
            
        try
        {
            SmsPack sp = new SmsPack(bb_con);
            sp.MSG_SET_REF(msg_id, msg_ref, msg_status);
        }
        catch (Exception ex)
        {
            savelog(ex.Message);
            throw ex;
        }
        finally
        {
            bb_con.CloseConnection();
        }

    }
    //збереженян статусу повідомлення
    private void set_status()
    {
        BbConnection bb_con = new BbConnection();
        try
        {
            SmsPack sp = new SmsPack(bb_con);
            sp.MSG_SET_STATUS(this.msg_ref, this.msg_status);
        }
        catch (Exception ex)
        {
            savelog(ex.Message);
            throw ex;
        }
        finally
        {
            bb_con.CloseConnection();
        }

    }
    //збереженян статусу повідомлення
    private void savelog(string logtxt)
    {
        BbConnection bb_con = new BbConnection();

        try
        {
     
            SmsPack sp = new SmsPack(bb_con);
            sp.MSG_SAVE_EXCEPTION(logtxt);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            bb_con.CloseConnection();
        }
    }


    //розбір xml
    private void parse_xml(string msg_xml)
    {
        using (XmlReader reader = XmlReader.Create(new StringReader(msg_xml)))
        {
            while (reader.Read())
            {
                //парсимо xml про статус доставки
                if ((reader.NodeType == XmlNodeType.Element) && reader.Name.Equals("status"))
                {

                    reader.ReadToFollowing("message");
                    reader.MoveToFirstAttribute();
                    this.msg_ref = Convert.ToString(reader.Value);
                    reader.ReadToFollowing("state");
                    reader.MoveToFirstAttribute();
                    string status = reader.Value;
                    if (state_code_list.Exists(element => element == status))
                        this.msg_status = status;
                    else
                    {
                        savelog("Invalid status!");
                        throw new Exception("status now found!");

                    }
                    break;
                }
                //парсимо xml про статус відпрвки 

                if ((reader.NodeType == XmlNodeType.Element) && reader.Name.Equals("message"))
                {

                    reader.ReadToFollowing("state");
                    reader.MoveToFirstAttribute();
                    string status = Convert.ToString(reader.Value);
                    if (state_code_list.Exists(element => element == status))
                        this.msg_status = status;
                    else
                    {
                        throw new Exception("status now found!");
                    }
                    if (status == "ACCEPT")
                    {
                        reader.ReadToFollowing("reference");
                        this.msg_ref = reader.ReadElementString();
                    }
                    break;
                }
            }


        }

    }
}


/// <summary>
/// Summary description for WebSmsService
/// </summary>
[WebService(Namespace = "http://ws.unity-bars.com.ua/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class WebSmsService : Bars.BarsWebService
{

    public WebSmsService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 

    }
    /// <summary>
    /// сервіс статусу доставки повідомлень - заглушка не використовується
    /// </summary>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public void websms(string message)
    {
        //  message msg = new message(message);

    }

    /// <summary>
    /// сервіс імітатор отримання повідомлень  - заглушка не використовується
    /// </summary>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public string sendsms(string message)
    {
        var xml = new XElement("message",
         new XElement("state", "Message accepted for delivery",
         new XAttribute("code", "INVDST"),
         new XAttribute("date", "22.05.2015")
         ),
        new XElement("reference", "F56")
        );

        XmlDocument xdoc = new XmlDocument();
        StringBuilder sb = new StringBuilder();
        sb.Append("<?xml version='1.0' encoding='utf-8' ?>");
        sb.Append(xml.ToString());
        xdoc.LoadXml(sb.ToString());
        string Message = xdoc.InnerXml;

        return Message;

    }


    /// <summary>
    /// сервіс відпрвки повідомлень
    /// </summary>
    /// <param name='msg_id'>ідентифікатор СМС в БАРС</param>
    /// <param name='oa'>телефон відпрвки СМС</param>
    /// <param name='da'>телефон доставки СМС</param>
    /// <param name='sms_text'>текст СМС</param>
    [WebMethod(EnableSession = true)]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public void websmssend(string msg_id, string oa, string da, string sms_text)
    {
            //отримуємо логін/пароль для СМС та куди їх кидати
            string UserPassword = Bars.Configuration.ConfigurationSettings.AppSettings["SMS.PWD"];
            string SmsServicePath = Bars.Configuration.ConfigurationSettings.AppSettings["SMS.PATH"];
            //login технологічного користувача
            string UserName = Bars.Configuration.ConfigurationSettings.AppSettings["SMS.TECH_USER"]; ;
            var repository = new AccountRepository(new AppModel(), DbLoggerConstruct.NewDbLogger());
            repository.LoginUser(UserName);

            string Resp;

        
            //пароль в base64
            string Base64_pwd = Convert.ToBase64String(Encoding.UTF8.GetBytes(UserPassword));

            var xml = new XElement("message",
                        new XElement("oa", oa),
                        new XElement("da", da),
                        new XElement("text", sms_text),
                        new XElement("valid-till", DateTime.Now.AddDays(1).ToString("yyyymmddHHMMss"))
                                    );
            XmlDocument xdoc = new XmlDocument();
            xdoc.CreateXmlDeclaration("1.0", "UTF-8", null);
            xdoc.LoadXml(xml.ToString());
            string Message = xdoc.InnerXml;

            //робимо requset з всіма необхідними параметрами
            Byte[] MessageBytes = Encoding.UTF8.GetBytes(Message);
            WebRequest Request = WebRequest.Create(SmsServicePath);
            Request.Method = "POST";
            Request.ContentType = "text/xml";
            Request.ContentLength = Message.Length;
            Request.Headers.Add("Authorization", "Basic " + Base64_pwd);

            using (Stream RequestStream = Request.GetRequestStream())
            {

                RequestStream.Write(MessageBytes, 0, MessageBytes.Length);
                RequestStream.Close();
            }

            // отримуємо відповідь
                using (WebResponse Response = Request.GetResponse())
                {
                    using (Stream ResponseStream = Response.GetResponseStream())
                    {
                        using (StreamReader rdr = new StreamReader(ResponseStream))
                        {
                            Resp = rdr.ReadToEnd();
                            rdr.Close();
                        }
                        ResponseStream.Close();
                    }
                    Response.Close();
                }

          
        //парсимо відповідь, проставляємо статуси
        message msg = new message(Convert.ToDecimal(msg_id), Resp);
        //return Resp;

    }


}
