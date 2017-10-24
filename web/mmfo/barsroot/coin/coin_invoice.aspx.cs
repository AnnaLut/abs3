using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using System.IO;
using System.Text;

using Bars.DataComponents;
using Bars.UserControls;
using Bars.CoinInvoice;

using ibank.core;
using ibank.objlayer;

public partial class coin_invoice : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            clearInvoice();
            // populateDdl();

            diInvoiceDate.SelectedDate = DateTime.Now;
            rbTypeOuter.Checked = true;

            gv.Visible = true;
        }
        gv.DataSourceID = "odsInvoiceDetail";
        gv.DataBind();
    }

    protected void clearInvoice()
    {
        BbConnection con = new BbConnection();
        CoinInvoiceMgr mgr = new CoinInvoiceMgr(con);
        mgr.CLEAR_INVOICE(tbInvoiceNumber.Text);
        con.CloseConnection();
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            btRemoveDet.Enabled = true;

            if (lbRef.Text.Length > 3)
            {
                btOpenDocument.Enabled = true;

                tbInvoiceNumber.Enabled = false;
                tbReason.Enabled = false;
                diInvoiceDate.Enabled = false;
                tbBailee.Enabled = false;
                tbProxy.Enabled = false;
                //ibRefCoin.Enabled = false;
                tbCoinCode.Enabled = false;
                tbCoinCount.Enabled = false;
                tbCoinPrice.Enabled = false;
                btAddDetail.Enabled = false;
                btRemoveDet.Enabled = false;
                btPayInvoice.Enabled = false;
            }
        }
    }

    //protected void populateDdl()
    //{
    //    List<VRefCoinRecord> res = null;

    //    BbConnection connection = new BbConnection();
    //    connection.InitConnection();
    //    try
    //    {
    //        VRefCoin table = new VRefCoin(connection);
    //        res = table.Select();
    //    }
    //    finally
    //    {
    //        connection.CloseConnection();
    //    }

    //    ddlCoinCode.Items.Clear();


    //    foreach (VRefCoinRecord item in res)
    //    {
    //        ListItem l = new ListItem();

    //        l.Text = item.NAME;
    //        l.Value = item.CODE;
    //        ddlCoinCode.Items.Add(l);
    //    }
    //}

    protected void btAddDetail_Click(object sender, EventArgs e)
    {
        string l_nd = tbInvoiceNumber.Text;
        int l_type_id = rbTypeInner.Checked == true ? 0 : 1;
        DateTime? l_dat = diInvoiceDate.SelectedDate;
        string l_reason = tbReason.Text;
        string l_bailee = tbBailee.Text;
        string l_proxy = tbProxy.Text;

        decimal l_err = 0;
        string l_err_msg = "";

        if (String.IsNullOrEmpty(l_nd))
        {
            l_err = 1;
            l_err_msg = "Не вказано № накладної.";
        }
        if (String.IsNullOrEmpty(l_dat.ToString()))
        {
            l_err = 1;
            l_err_msg += " Не вказано дату накладної";
        }
        if (String.IsNullOrEmpty(l_reason))
        {
            l_err = 1;
            l_err_msg += " Не вказано підставу";
        }

        if (l_err == 0)
        {
            BbConnection con = new BbConnection();
            CoinInvoiceMgr mgr = new CoinInvoiceMgr(con);
            mgr.CREATE_INVOICE(l_type_id, l_nd, l_dat, l_reason, l_bailee, l_proxy, 0, 0, 0, 0, 0, 0, 0, 0);
            con.CloseConnection();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + l_err_msg + "');", true);
            return;
        }


        decimal l_rn = 0;
        //int l_type_id = rbTypeInner.Checked == true ? 0 : 1;
        //string l_nd = tbInvoiceNumber.Text;
        //string l_code = ddlCoinCode.SelectedValue;
        string l_code = tbCoinCode.Value; //tbCoinCode.Text;
        decimal l_count = Convert.ToDecimal(tbCoinCount.Text);
        decimal l_price = Convert.ToDecimal(tbCoinPrice.Text) * 100;
        //lbTotalCount.Text = l_price.ToString();
        if (gv.SelectedRows.Count != 0)
        {
            l_rn = Convert.ToDecimal(gv.DataKeys[gv.SelectedRows[0]].Value);
        }

        l_err = 0;

        if (String.IsNullOrEmpty(l_code))
        {
            l_err = 1;
            l_err_msg = "Оберіть монету з довідника";
        }

        if (l_count <= 0)
        {
            l_err = 1;
            l_err_msg = "Кількість має бути більшою 0";
            tbCoinCount.Text = "0";
        }

        if (l_price < 0)
        {
            l_err = 1;
            l_err_msg = "Ціна за 1шт. не може бути від`ємною";
            tbCoinPrice.Text = "0";
        }
        if (l_err == 0)
        {
            BbConnection con2 = new BbConnection();

            try
            {
                CoinInvoiceMgr mgr2 = new CoinInvoiceMgr(con2);
                mgr2.ADD_INVOICE_DETAIL(l_type_id, l_nd, l_code, l_count, l_price, l_rn);
            }
            catch (Exception E)
            {
                l_err_msg = E.Message.ToString().Substring(36,49);
                l_err = 1;

                con2.CloseConnection();

            }
            finally
            {
                con2.CloseConnection();
            }

            if (l_err != 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + l_err_msg + "');", true);
                return;
            }

            gv.DataSourceID = "odsInvoiceDetail";
            gv.DataBind();

            show_coin_totals();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + l_err_msg + "');", true);
            return;
        }
    }

    protected void show_coin_totals()
    {
        List<VCoinInvoiceRecord> res = null;

        BbConnection connection = new BbConnection();
        connection.InitConnection();
        try
        {
            VCoinInvoice table = new VCoinInvoice(connection);
            table.Filter.ND.Equal(tbInvoiceNumber.Text);
            res = table.Select();
        }
        finally
        {
            connection.CloseConnection();
        }

        foreach (VCoinInvoiceRecord item in res)
        {
            tbTotalCount.Text = item.TOTAL_COUNT.ToString();
            tbTotalNomonal.Text = item.TOTAL_NOMINAL.ToString();
            tbTotalSum.Text = item.TOTAL_SUM.ToString();
            tbTotalWithoutVat.Text = item.TOTAL_WITHOUT_VAT.ToString();
            tbVatPercent.Text = item.VAT_PERCENT.ToString();
            tbVatSum.Text = item.VAT_SUM.ToString();
            tbTotalNominalPrice.Text = item.TOTAL_NOMINAL_PRICE.ToString();
            tbTotalWithVat.Text = item.TOTAL_WITH_VAT.ToString();
            ta.InnerText = item.SUM_PR.ToString();
            lbRef.Text = item.REF.ToString();
        }

        if (0 < Convert.ToDecimal(tbTotalCount.Text))
        {
            btPayInvoice.Enabled = true;
            rbTypeInner.Enabled = false;
            rbTypeOuter.Enabled = false;
        }
        else
        {
            btPayInvoice.Enabled = false;
            rbTypeInner.Enabled = true;
            rbTypeOuter.Enabled = true;
        }

        if (lbRef.Text.Length > 3)
        {
            btOpenDocument.Enabled = true;

            tbInvoiceNumber.Enabled = false;
            tbReason.Enabled = false;
            diInvoiceDate.Enabled = false;
            tbBailee.Enabled = false;
            tbProxy.Enabled = false;
            //ibRefCoin.Enabled = false;
            tbCoinCode.Enabled = false;
            tbCoinCount.Enabled = false;
            tbCoinPrice.Enabled = false;
            btAddDetail.Enabled = false;
            btRemoveDet.Enabled = false;
            btPayInvoice.Enabled = false;
        }
        else
        {
            btOpenDocument.Enabled = false;
            btPayInvoice.Enabled = true;
        }


    }

    protected void btRemoveDet_Click(object sender, EventArgs e)
    {
        if (gv.SelectedRows.Count != 0)
        {
            decimal l_rn = Convert.ToDecimal(gv.DataKeys[gv.SelectedRows[0]]["RN"]);
            string l_code = gv.DataKeys[gv.SelectedRows[0]]["CODE"].ToString();

            BbConnection con = new BbConnection();
            CoinInvoiceMgr mgr = new CoinInvoiceMgr(con);
            mgr.REMOVE_INVOICE_DETAIL(l_rn, l_code);
            con.CloseConnection();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного рядку');", true);
        }

        gv.DataSourceID = "odsInvoiceDetail";
        gv.DataBind();

        show_coin_totals();
    }

    protected void btPayInvoice_Click(object sender, EventArgs e)
    {
        string l_nd = tbInvoiceNumber.Text;
        BbConnection con = new BbConnection();
        CoinInvoiceMgr mgr = new CoinInvoiceMgr(con);
        mgr.PAY_INVOICE(l_nd);
        con.CloseConnection();

        show_coin_totals();
    }
}
