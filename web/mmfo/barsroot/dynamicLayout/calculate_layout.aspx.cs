using Bars.CoinInvoice;
using Bars.DataComponents;
using Bars.DynamicLayout;
using Bars.UserControls;
using ibank.core;
using ibank.objlayer;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class calculate_layout : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            clearLayout();


            if (!String.IsNullOrEmpty(Session["DynamicLayoutDk"] as string))
            {
                rbListDk.SelectedValue = Session["DynamicLayoutDk"].ToString();
            }

            gv.Visible = true;
            show_headers();
        }

        gv.DataSourceID = "odsDynamicLayoutDetail";

        if (!String.IsNullOrEmpty(tbNd.Text) && !String.IsNullOrEmpty(diDatD.SelectedDate.ToString()) && Convert.ToDecimal(tbTotalSum.Text) != 0 && String.IsNullOrEmpty(tbRef.Text))
        {
            btPay.Enabled = true;
        }
        else
        {
            btPay.Enabled = false;
        }
    }

    protected void clearLayout()
    {
        BbConnection con = new BbConnection();
        DynamicLayoutUi mgr = new DynamicLayoutUi(con);
        mgr.CLEAR_DYNAMIC_LAYOUT();


        decimal dk = Convert.ToDecimal(Session["DynamicLayoutDk"].ToString());
        string nls = Session["DynamicLayoutNls"].ToString();
        string bs = Session["DynamicLayoutBs"].ToString();
        string ob = Session["DynamicLayoutOb"].ToString();

        try
        {
            if (Session["DynamicLayoutType"].ToString() == "3")
            {
                mgr.CREATE_DYNAMIC_LAYOUT(3, dk, nls, bs, ob, 0);
            }
            else
            {
                mgr.CREATE_DYNAMIC_LAYOUT(2, dk, nls, bs, ob, 0);
            }

        }
        catch (Exception E)
        {
            string txt = "";
            var ErrorText = E.Message.ToString();
            var x = ErrorText.IndexOf("ORA");
            var ora = ErrorText.Substring(x + 3, 6); //-20001

            var ora1 = ErrorText.Substring(x + 11);
            var y = ora1.IndexOf("ORA");
            txt = ErrorText.Substring(x + 11, y - 1);

            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + txt.Replace("ы", "і") + "');", true);
        }
        finally
        {
            con.CloseConnection();
        }


    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (!String.IsNullOrEmpty(tbRef.Text))
            {
                tbTotalSum.Enabled = false;
                tbKvA.Enabled = false;
                tbKvB.Enabled = false;
                tbNd.Enabled = false;
                tbNazn.Enabled = false;
                diDatD.Enabled = false;
                diDateFrom.Enabled = false;
                diDateTo.Enabled = false;
                cbDatesToNazn.Enabled = false;
                btOpenDocument.Enabled = true;
            }
        }
    }

    protected void show_headers()
    {
        List<VTmpDynamicLayoutRecord> res = null;

        BbConnection connection = new BbConnection();
        connection.InitConnection();
        try
        {
            VTmpDynamicLayout table = new VTmpDynamicLayout(connection);
            res = table.Select();
        }
        finally
        {
            connection.CloseConnection();
        }

        foreach (VTmpDynamicLayoutRecord item in res)
        {
            tbKvA.Value = item.KV_A.ToString();
            tbNlsA.Text = item.NLS_A.ToString();
            tbOstC.Text = item.OSTC.ToString();
            tbNlsAName.Text = item.NMS.ToString();
            if (Session["DynamicLayoutType"].ToString() == "1")
            {
                tbNazn.Text = Session["DynamicLayoutNazn"].ToString();
            }
            else
            {
                tbNazn.Text = item.NAZN.ToString();
            }
            tbKvB.Value = item.KV_A.ToString();
            diDatD.SelectedDate = item.DATD;
            diDateFrom.SelectedDate = item.DATE_FROM;
            diDateTo.SelectedDate = item.DATE_TO;
            tbRef.Text = item.REF.ToString();
            tbTypedPercents.Text = item.TYPED_PERCENT.ToString();
            tbTypedSum.Text = item.TYPED_SUMM.ToString();
            tbBranchCount.Text = item.BRANCH_COUNT.ToString();
        }
    }

    void tbKvB_ValueChanged(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        DynamicLayoutUi mgr = new DynamicLayoutUi(con);
        mgr.UPDATE_KV_B(Convert.ToDecimal(tbKvB.Value));
        con.CloseConnection();
    }

    protected void btPay_Click(object sender, EventArgs e)
    {
        if (Convert.ToDecimal(tbTotalSum.Text) == 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вказано суму розподілу');", true);
            return;
        }

        if (Convert.ToDecimal(tbTotalSum.Text) > Convert.ToDecimal(tbOstC.Text))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Сума розподілу більша за суму залишку на рахунку');", true);
            return;
        }

        if (Convert.ToDecimal(tbTotalSum.Text) > Convert.ToDecimal(tbOstC.Text))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Сума розподілу більша за суму залишку на рахунку');", true);
            return;
        }

        if (Convert.ToDecimal(tbTypedPercents.Text) != 100)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Загальний % не дорівнює 100');", true);
            return;
        }

        if (Convert.ToDecimal(tbTotalSum.Text) != Convert.ToDecimal(tbTypedSum.Text))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Набранна сума " + tbTypedSum.Text + " не дорівнює загальній сумі розподілу " + tbTotalSum.Text + "');", true);
            return;
        }


        BbConnection con = new BbConnection();
        DynamicLayoutUi mgr = new DynamicLayoutUi(con);
        if (Session["DynamicLayoutType"].ToString() == "3")
        {
            mgr.PAY_DYNAMIC_LAYOUT(3, tbNd.Text);

        }
        else
        {
            mgr.PAY_DYNAMIC_LAYOUT(2, tbNd.Text);
        }

        con.CloseConnection();

        show_headers();
        btPay.Enabled = false;
    }
    protected void btSaveDetail_Click(object sender, EventArgs e)
    {
        if (String.IsNullOrEmpty(tbRowPercent.Text))
        {
            tbRowPercent.Text = "0";
        }

        if (String.IsNullOrEmpty(tbRowSum.Text))
        {
            tbRowSum.Text = "0";
        }

        if (String.IsNullOrEmpty(tbTotalSum.Text))
        {
            tbTotalSum.Text = "0";
        }

        if (Convert.ToDecimal(tbRowPercent.Text) != 0 && Convert.ToDecimal(tbRowSum.Text) != 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Необхідно вказати або кількість відсотків від загальної суми або суму проведення');", true);
            return;
        }

        if (gv.SelectedRows.Count != 0)
        {
            decimal? l_id = Convert.ToDecimal(gv.DataKeys[gv.SelectedRows[0]]["ID"]);
            decimal? l_percents = Convert.ToDecimal(tbRowPercent.Text);
            decimal? l_sum = Convert.ToDecimal(tbRowSum.Text);
            decimal? l_total_summ = Convert.ToDecimal(tbTotalSum.Text);

            decimal? l_dates_to_nazn = cbDatesToNazn.Checked ? 1 : 0;

            DateTime? datD = (!String.IsNullOrEmpty(diDatD.SelectedDate.ToString()) ? diDatD.SelectedDate : DateTime.Now);
            DateTime? datFrom = (!String.IsNullOrEmpty(diDateFrom.SelectedDate.ToString()) ? diDateFrom.SelectedDate : DateTime.Now);
            DateTime? datTo = (!String.IsNullOrEmpty(diDateTo.SelectedDate.ToString()) ? diDateTo.SelectedDate : DateTime.Now);

            BbConnection con = new BbConnection();
            DynamicLayoutUi mgr = new DynamicLayoutUi(con);
            mgr.UPDATE_DYNAMIC_LAYOUT(tbNd.Text, datD, datFrom, datTo, l_dates_to_nazn, tbNazn.Text, Convert.ToDecimal(tbTotalSum.Text) * 100, 0);
            mgr.UPDATE_DYNAMIC_LAYOUT_DETAIL(l_id, l_percents, l_sum * 100, l_total_summ * 100);
            con.CloseConnection();

            tbRowPercent.Text = "0";
            tbRowSum.Text = "0.00";

            show_headers();

        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Оберіть рядок');", true);
        }
    }
    protected void btNew_Click(object sender, EventArgs e)
    {
        if (Session["DynamicLayoutType"].ToString() == "3")
        {
            //динамічний макет 3
            Response.Redirect("/barsroot/dynamicLayout/dynamic_layout.aspx?type=3");
        }
        else if (Session["DynamicLayoutType"].ToString() == "1")
        {
            //Створення розпорядження по вибору
            Server.Transfer("/barsroot/dynamicLayout/static_layout.aspx");
        }
        else
        {
            //динамічний макет 2
            Server.Transfer("/barsroot/dynamicLayout/dynamic_layout.aspx");
        }
    }
}
