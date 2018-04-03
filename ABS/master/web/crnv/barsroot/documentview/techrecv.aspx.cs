using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class TechRecv : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        decimal Ref = Convert.ToDecimal(Request.Params.Get("ref"));

        InitOraConnection(Context);
        try
        {
            SetRole(Resources.documentview.Global.AppRole);

            ClearParameters();
            SetParameters("pref", DB_TYPE.Decimal, Ref, DIRECTION.Input);
            DataTable dtOper = SQL_SELECT_dataset("SELECT to_char(PDAT,'dd.MM.yyyy hh24:mi:ss') as PDAT, to_char(DATP,'dd.MM.yyyy hh24:mi:ss') as DATP FROM OPER WHERE ref = :pref").Tables[0];

            if (dtOper.Rows.Count > 0)
            {
                //дата ввода
                edPosted.Value = Convert.ToString(dtOper.Rows[0]["PDAT"]);
                //поступил в банк
                edArrived.Value = Convert.ToString(dtOper.Rows[0]["DATP"]);
            }

            // -- Данные СЭПовских документов ---
            ClearParameters();
            SetParameters("pref", DB_TYPE.Decimal, Ref, DIRECTION.Input);
            DataTable docArriv = SQL_SELECT_dataset("SELECT FN, to_char(DAT,'dd.MM.yyyy hh24:mi:ss') as DAT, to_char(DATK,'dd.MM.yyyy hh24:mi:ss') as DATK, to_char(DAT_2,'dd.MM.yyyy hh24:mi:ss') as DAT_2 FROM ZAG_A z, ARC_RRP a WHERE z.FN = a.FN_A AND z.DAT = a.DAT_A AND a.REF = :pref").Tables[0];

            if (docArriv.Rows.Count > 0)
            {
                // Получено в файле
                edFile.Value = Convert.ToString(docArriv.Rows[0]["FN"]);
                // Получено (дата)
                edFileDate.Value = Convert.ToString(docArriv.Rows[0]["DAT"]);
                // Поступил в наш РЦ
                edInFileRec.Value = Convert.ToString(docArriv.Rows[0]["DATK"]);
                // Сквитован
                edInFilePay.Value = Convert.ToString(docArriv.Rows[0]["DAT_2"]);
            }

            ClearParameters();
            SetParameters("pref", DB_TYPE.Decimal, Ref, DIRECTION.Input);
            DataTable docOut = SQL_SELECT_dataset("SELECT FN, to_char(DAT,'dd.MM.yyyy hh24:mi:ss') as DAT, to_char(DATK,'dd.MM.yyyy hh24:mi:ss') as DATK FROM ZAG_B z, ARC_RRP a WHERE z.FN = a.FN_B AND z.DAT = a.DAT_B AND a.REF = :pref").Tables[0];

            if (docOut.Rows.Count > 0)
            {
                // Отправлено в файле
                edOutFile.Value = Convert.ToString(docOut.Rows[0]["FN"]);
                // Отправлено (дата)
                edOutFileDate.Value = Convert.ToString(docOut.Rows[0]["DAT"]);
                // Сквитован
                edCheckedDate.Value = Convert.ToString(docOut.Rows[0]["DATK"]);
            }
        }
        finally
        {
            DisposeOraConnection();
        }
    }
}
