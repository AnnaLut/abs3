using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using EasySMPP;

public partial class sms_SendSms_Default : System.Web.UI.Page
{
    public const Int32 RunTimeOut = 5000;
    public const Int32 RunInterval = 500;
    public String Sender
    {
        get
        {
            return Bars.Configuration.ConfigurationSettings.AppSettings["SMPP.Sender"];
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private void log()
    {
        Response.Write("");
    }

    protected void bt_send_Click(object sender, EventArgs e)
    {
        SmsClient client = new SmsClient();
        
        Int64 RunTime = 0;
        do
        {
            System.Threading.Thread.Sleep(RunInterval);
            RunTime += RunInterval;

            if (RunTime > RunTimeOut)
                throw new System.Exception(String.Format("Вичерпано TimeOut ({0}) очікування відправки СМС, {1}", RunTimeOut, client.LastStatusDesc ));
        }
        while (!client.CanSend);

        if (client.SendSms(Sender, tb_ph.Text, tb_text.Text))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert_ok", "alert('Повідомлення відправлено '); ", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert_error", "alert('Повідомлення НЕ відправлено , код помилки - " + client.LastStatusCode + ", " + client.LastStatusDesc + "'); ", true);
        }
        client.Disconnect();
    }

    void client_OnLog(EasySMPP.LogEventArgs e)
    {
        //Response.Write();
    }
}