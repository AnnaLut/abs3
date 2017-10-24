using System;
using System.Collections;
using BarsWeb.Core.Logger;
using Bars.Configuration;
using Oracle.DataAccess.Client;
using System.Web.SessionState;

public partial class testseckey : Bars.BarsPage
{
    private readonly IDbLogger _dbLogger;
    public testseckey()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
    }

    private void ReadConfigSettings()
    {
        var parSignMixedMode = ConfigurationSettings.AppSettings["Crypto.SignMixedMode"];
        lbMode.Text = parSignMixedMode;
        lbServiceUrl.Text = ConfigurationSettings.AppSettings["Crypto.CryptoServer"];
        lbDebugMode.Text = ConfigurationSettings.AppSettings["Crypto.DebugMode"];

        lbActualBcVersion.Text = ConfigurationSettings.AppSettings["Crypto.BarsCryptor.Version"];
        __BC_VERSION.Value= ConfigurationSettings.AppSettings["Crypto.BarsCryptor.Version"];
        __BC_MIN_VERSION.Value = ConfigurationSettings.AppSettings["Crypto.BarsCryptor.MinVersion"];
        __BC_UPDATE_SERVER.Value = ConfigurationSettings.AppSettings["Crypto.BarsCryptor.UpdateServer"];
        

        __SIGN_MIXED_MODE.Value = parSignMixedMode;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Bars.Configuration.ConfigurationSettings.RefreshBarsConfig();
        ReadConfigSettings();
        try
        {
            InitOraConnection();
            ArrayList reader = SQL_reader(@"select 
                docsign.GetIdOper, 
                to_char(bankdate, 'YYYY/MM/DD HH:mm:ss'), 
                docsign.get_user_sign_type,
                docsign.get_user_keyid, 
                (select val from params where par='CRYPTO_USE_VEGA2') CRYPTO_USE_VEGA2,
                (select val from params where par='CRYPTO_CA_KEY') CRYPTO_CA_KEY
                from dual");
            hKeyId.Value = Convert.ToString(reader[0]);

            __BDATE.Value = Convert.ToString(reader[1]);
            __USER_SIGN_TYPE.Value = Convert.ToString(reader[2]);
            __USER_KEYID.Value = Convert.ToString(reader[3]);
            tbKeyID.Text = __USER_KEYID.Value;
            __CRYPTO_USE_VEGA2.Value = Convert.ToString(reader[4]);
            __CRYPTO_CA_KEY.Value = Convert.ToString(reader[5]);

            __USER_ADDRESS.Value = Request.UserHostAddress;

            __USER_INFO.Value =
                        "UserHostName=" + Request.UserHostName + ";" +
                        "Browser=" + Request.Browser.Browser + ";" +
                        "Version=" + Request.Browser.Version + ";" +
                        "Type=" + Request.Browser.Type + ";" +
                        "Platform=" + Request.Browser.Platform + ";" +
                        "Id=" + Request.Browser.Id + ";";


            hBuffer.Value = Convert.ToString(SQL_SELECT_scalar("select 'This is buffer'  from dual"));
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void btChangeDebugMode_Click(object sender, EventArgs e)
    {
        InitOraConnection();

        try
        {
            SQL_PROCEDURE("sgn_mgr.toggle_trace");
        }
        finally
        {
            DisposeOraConnection();
        }
        Bars.Configuration.ConfigurationSettings.RefreshBarsConfig();
        ReadConfigSettings();
    }
}
