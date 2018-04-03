using System;
using System.Data;
using System.Globalization;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Bars;

//
public partial class BalansAcc : BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");

        int nPar = Convert.ToInt32(Request.Params.Get("par"));
        int nVal = Convert.ToInt32(Request.Params.Get("val"));
        string sNbs = Convert.ToString(Request.Params.Get("nbs"));
        string sDat = Convert.ToString(Request.Params.Get("fdat"));
        string res = "";

        try
        {
            InitOraConnection(Context);
            SetRole("WEB_BALANS");

            SetParameters("nVal", DB_TYPE.Decimal, nVal, DIRECTION.Input);
            
            if (nPar == 1)
            {
                res = Convert.ToString(SQL_SELECT_scalar("SELECT fio from staff where id=:nVal"), cinfo);
            }
            else
            {
                res = Convert.ToString(SQL_SELECT_scalar("SELECT name from tabval where kv=:nVal"), cinfo);
            }
            
        }
        finally
        {
            DisposeOraConnection();
        }
        if (nPar == 1)
            //Label1.Text = sDat +": Состояние Счетов БС " + sNbs + " (ном.), Исп. " + nVal + " - " + res;
            Label1.Text = sDat + ": " + Resources.balansaccdoc.Global.cTitleAcc + " " + sNbs +
                " (" + Resources.balansaccdoc.Global.cNominal + "), " + Resources.balansaccdoc.Global.cIsp + " " + nVal + " - " + res;
            
        else
             //Label1.Text = sDat + ": Состояние Счетов БС " + sNbs + " (ном.), Вал. " + nVal + " - " + res;
            Label1.Text = sDat + ": " + Resources.balansaccdoc.Global.cTitleAcc + " " + sNbs +
                " (" + Resources.balansaccdoc.Global.cNominal + "), " + Resources.balansaccdoc.Global.cVal + " " + nVal + " - " + res;

        }
}
