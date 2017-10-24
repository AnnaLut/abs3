using System;
using System.Collections;
using BarsWeb.Core.Logger;

public partial class testseckey : Bars.BarsPage
{
    private readonly IDbLogger _dbLogger;
    public testseckey()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            InitOraConnection();
            // получаем ключ юзера (2 символа из REGNCODE + таб. номер из staff - итого 8 символов ) и банковскую дату 
            ArrayList reader = SQL_reader("select val||docsign.GetIdOper, to_char(bankdate, 'YYYY/MM/DD HH:mm:ss') from params where par='REGNCODE'");
            tbKeyID.Text = "04TST801";//Convert.ToString(reader[0]);
            hKeyId.Value = "04TST801";//Convert.ToString(reader[0]); // можно тоже в hidden поле 
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
        _dbLogger.Info("TESTSIGN::Подпись наложена на строку[ " + hBuffer.Value + "] и проверена подпись [" + hSignedBuffer.Value + "] " + tbKeyID.Text);
    }
}
