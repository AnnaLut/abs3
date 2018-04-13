using System;
using System.Threading;
using System.Web.Services;
using Bars.Configuration;
using Bars.Logger;
using EasySMPP;

public class SMSInfo
{
    public string ErrorMessage;
    public int Status;
}

/// <summary>
///     Summary description for send_sms
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class send_sms : WebService
{
    public const Int32 RunTimeOut = 1000;
    public const Int32 RunInterval = 500;

    public String Sender
    {
        get { return ConfigurationSettings.AppSettings["SMPP.Sender"]; }
    }

    [WebMethod]
    public SMSInfo Send(string phone, string text)
    {
        var si = new SMSInfo();
        SmsClient client;
        // типа Singleton - один экземпляр класса на приложение 
        if (Application["BarsSMS"] != null)
        {
            try
            {
                client = Application["BarsSMS"] as SmsClient;
            }
            catch (Exception)
            {
                client = new SmsClient();
                Application["BarsSMS"] = client;
            }
        }
        else
        {
            client = new SmsClient();
            Application["BarsSMS"] = client;
        }
        //long counter = (Application["BarsSMSCounter"] != null) ? (Convert.ToInt64(Application["BarsSMSCounter"]) + 1) : (1);
        //Application["BarsSMSCounter"] = counter;

        //DBLogger.Info("SMS::counter=" + counter);
        try
        {
            // если соединение еще не готово (сокет не открыт) или SMPP серевер не отвечает - то пробуем подождать
            if (!client.CanSend)
            {
                //if (client.LastStatusDesc.Contains("0x80004005"))
                //{
                //    client = null;
                //    Application["BarsSMS"] = null;
                //    si.ErrorMessage =
                //        String.Format("Cервер SMPP перестав відповідати, перевірте налаштування [{0}],code={1}",
                //            client.LastStatusDesc, client.LastStatusCode);
                //    return si;
                //}

                Int64 RunTime = 0;
                do
                {
                    Thread.Sleep(RunInterval);
                    RunTime += RunInterval;

                    if (RunTime > RunTimeOut)
                    {
                        si.ErrorMessage =
                            String.Format("Вичерпано TimeOut ({0}) очікування відправки СМС, системна помилка - {1}",
                                RunTimeOut, client.LastStatusDesc);
                        return si;
                    }
                } while (!client.CanSend);
            }

            if (client.CanSend)
            {
                Thread.Sleep(RunInterval);
                client.SendSms(Sender, phone, text);
                si.ErrorMessage = string.Empty;
            }
            else
                si.ErrorMessage = String.Format("Не вдалося відправити повідомлення [{0}]", client.LastStatusDesc);
        }
        catch (Exception ex)
        {
            DBLogger.Error("Помилка відправки СМС [" + ex.Message + ex.StackTrace + "]", "SMS");
        }
        return si;
    }
}