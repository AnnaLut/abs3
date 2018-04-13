using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;

using ibank.objlayer;
using ibank.core;

public partial class admin_cash_open : Bars.BarsPage
{
    # region Приватные свойства
    private BarsCash _Cash
    {
        get
        {
            BbConnection con = new BbConnection();
            con.RoleName = "OPER000";
            return new BarsCash(con);
        }
    }

    private String OprDatePattern = "{0:d}";
    private String CurShiftPattern = "зміна №{0}  - відкрита";
    private String NewShiftAlertPattern1 = "if (!confirm('Ви впевнені, що закриваєте зміну №{0}, та відкриваєте зміну №{1}?')) return false;";
    private String NewShiftAlertPattern2 = "if (!confirm('Ви впевнені, що відкриваєте зміну №{0}?')) return false;";
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // устанавливаем смену
            SHIFT.Value = _Cash.NEXT_SHIFT();

            // опер дата
            lbOprDate.Text = String.Format(OprDatePattern, _Cash.CURRENT_OPDATE().Value);

            // текущая смена
            Decimal? CurShift = _Cash.CURRENT_SHIFT();
            if (CurShift == 0)
            {
                lbCurShift.Text = "не відкрито жодної";
                lbCurShift.Style.Add(HtmlTextWriterStyle.Color, "#3366FF");
            }
            else
            {
                lbCurShift.Text = String.Format(CurShiftPattern, CurShift.ToString());
                lbCurShift.Style.Add(HtmlTextWriterStyle.Color, "#FF0000");
            }

            // открытие смены
            if (CurShift == 0)
            {
                btOpen.OnClientClick = String.Format(NewShiftAlertPattern2, SHIFT.Value.ToString());
            }
            else
            {
                btOpen.OnClientClick = String.Format(NewShiftAlertPattern1, CurShift.ToString(), SHIFT.Value.ToString());
            }

        }
    }
    protected void btOpen_Click(object sender, EventArgs e)
    {
        // открываем смену
        try
        {
            _Cash.OPEN_CASH();
        }
        catch (Exception ex)
        {
            // ошибки
            ShowMessage("error", String.Format("Помилки при відкритті зміни : {0}", ex.Message));
            return;
        }

        // результат
        ShowMessage("successfuly_opened", String.Format("Зміна {0} успішно відкрита", SHIFT.Value.ToString()));
        gvVCashsnapshot.DataBind();
        upGv.Update();

        (sender as Button).Enabled = false;

        // касса
        Decimal? CurShift = _Cash.CURRENT_SHIFT();
        lbCurShift.Text = String.Format(CurShiftPattern, CurShift.ToString());
        lbCurShift.Style.Add(HtmlTextWriterStyle.Color, "#FF0000");
    }
    # endregion

    # region Приватные методы
    private void ShowMessage(String Key, String Text)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), Key, "alert('" + Text + "');", true);
    }
    # endregion
}
