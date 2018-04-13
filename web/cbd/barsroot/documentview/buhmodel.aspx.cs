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

public partial class BuhModel : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // страница вызиваеться исключительно во фрейме поэтому проверку наличия не выполняем
        decimal Ref = Convert.ToDecimal(Request.Params.Get("ref"));

        DataTable dtData = new DataTable();
        bool bBranchScheme = false;

        InitOraConnection(Context);
        try
        {
            SetRole(Resources.documentview.Global.AppRole);

            // выборка данных
            bBranchScheme = Convert.ToBoolean(SQL_SELECT_scalar("SELECT count(*) FROM PARAMS WHERE PAR = 'HAVETOBO' and VAL = '2'"));

            ClearParameters();
            SetParameters("pref", DB_TYPE.Decimal, Ref, DIRECTION.Input);

            dtData = SQL_SELECT_dataset(@"  SELECT  o.SOS as SOS, o.FDAT as FDAT, o.TT as TT, 
                                                    a.NLS as NLS, a.KV as KV, decode(o.DK, 0, o.S, null)/power(10,t.dig) as DOS, 
                                                    decode(o.DK, 1, o.S, null)/power(10,t.dig) as KOS, 
                                                    a.NMS as NMS, o.TXT as TXT, t.DIG as DIG " + ((bBranchScheme)?(", a.BRANCH as BRANCH "):("")) + 
                                            @"FROM OPLDOK o, ACCOUNTS a, TABVAL t 
                                              WHERE o.REF = :pref and o.ACC = a.ACC and a.kv = t.kv 
                                              ORDER BY o.fdat, a.kv, o.stmt, o.tt, o.dk").Tables[0];
        }
        finally
        {
            DisposeOraConnection();
        }

        // убираем колонку код отделения
        if (!bBranchScheme)
            grdData.Columns.RemoveAt(8);

        // наполняем даными
        grdData.DataSource = dtData;
        grdData.DataBind();

        // разукрашиваем табличку если есть данные
        if (dtData.Rows.Count > 0)
        {
            switch (Convert.ToInt32(dtData.Rows[0]["SOS"]))
            {
                case 1: grdData.RowStyle.ForeColor = System.Drawing.Color.Green;
                    break;
                case 2: grdData.RowStyle.ForeColor = System.Drawing.Color.Blue;
                    break;
            }
        }
    }
}
