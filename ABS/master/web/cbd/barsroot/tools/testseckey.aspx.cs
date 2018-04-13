using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.IO;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using ViewAccounts;

public partial class testseckey : Bars.BarsPage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        //btCheckSign.Attributes["onclick"] = "return CheckSign();"; // это типа чтобы если все ок, то идет постбек дальше как обычно
        try
        {
            InitOraConnection();
            // получаем ключ юзера (2 символа из REGNCODE + таб. номер из staff - итого 8 символов ) и банковскую дату 
            ArrayList reader = SQL_reader("select val||docsign.GetIdOper, to_char(bankdate, 'YYYY/MM/DD HH:mm:ss') from params where par='REGNCODE'");
            tbKeyID.Text = Convert.ToString(reader[0]);
            hKeyId.Value = Convert.ToString(reader[0]); // можно тоже в hidden поле 
            hBankDate.Value = Convert.ToString(reader[1]);
            hBuffer.Value = Convert.ToString(SQL_SELECT_scalar("select /*тут типа визов функции получения буфера*/ 'This is buffer'  from dual"));
        }
        finally
        {
            DisposeOraConnection();
        }
    }
    protected void btSign_Click(object sender, EventArgs e)
    {
    	lbSuccess.Visible = true;
    	pnStep3.Enabled = false;
        Bars.Logger.DBLogger.Info("TESTSIGN::Подпись наложена на строку[ " + hBuffer.Value + "] и проверена подпись [" + hSignedBuffer.Value + "] " + tbKeyID.Text);
    }
}
