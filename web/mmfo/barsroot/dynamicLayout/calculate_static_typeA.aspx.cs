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
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class calculate_static_typeA : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            clearLayout();
            show_headers();
            btPay.Enabled = false;
            btSaveDetail.Enabled = false;
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
        decimal grp = Convert.ToDecimal(Session["DynamicLayoutGrp"]);

        try
        {
            mgr.CREATE_DYNAMIC_LAYOUT(1, dk, nls, bs, ob, grp);
        }
        catch (Exception E)
        {
            string txt = "";
            var ErrorText = E.Message.ToString();
            var x = ErrorText.IndexOf("ORA");
            var ora = ErrorText.Substring(x + 4, 5); //-20001

            if (Convert.ToDecimal(ora) >= 20000)
            {
                var ora1 = ErrorText.Substring(x + 11);
                var y = ora1.IndexOf("ORA");
                if (x > 0 && y > 0)
                {
                    txt = ErrorText.Substring(x + 11, y - 1);
                }
                else
                {
                    txt = ErrorText;
                }

                ErrorText = txt.Replace("ы", "і");
            }

            con.CloseConnection();

            Server.Transfer("/barsroot/dynamicLayout/calculate_static_typeB.aspx?type=err&errMsg=" + Server.UrlEncode(Regex.Replace(ErrorText, @"\t|\n|\r", " ")));
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
            VTmpStaticLayoutDetailARecord rec = (e.Row.DataItem as VTmpStaticLayoutDetailARecord);

            if (!String.IsNullOrEmpty(tbRef.Text))
            {
                tbTotalSum.Enabled = false;
                tbKvA.Enabled = false;
                tbNd.Enabled = false;
                tbNazn.Enabled = false;
                diDatD.Enabled = false;
                diDateFrom.Enabled = false;
                diDateTo.Enabled = false;
                cbDatesToNazn.Enabled = false;
                btOpenDocument.Enabled = true;
            }

            if (!String.IsNullOrEmpty(rec.REF))
            {
                e.Row.Cells[9].Attributes.Add("onclick", "javascript:" + "OpenDocument(this);" + "return false;");
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

            diDatD.SelectedDate = item.DATD;
            diDateFrom.SelectedDate = item.DATE_FROM;
            diDateTo.SelectedDate = item.DATE_TO;
            tbRef.Text = item.REF.ToString();
            tbTypedPercents.Text = item.TYPED_PERCENT.ToString();
            tbTypedSum.Text = item.TYPED_SUMM.ToString();

            if (item.DK == 0)
            {
                rbListDk.SelectedValue = "0";
                cbInfo.Checked = false;
            }
            else if (item.DK == 1)
            {
                rbListDk.SelectedValue = "1";
                cbInfo.Checked = false;
            }
            else if (item.DK == 2)
            {
                rbListDk.SelectedValue = "0";
                cbInfo.Checked = true;
            }
            else if (item.DK == 3)
            {
                rbListDk.SelectedValue = "1";
                cbInfo.Checked = true;
            }
        }
    }

    void tbKvB_ValueChanged(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        DynamicLayoutUi mgr = new DynamicLayoutUi(con);
        con.CloseConnection();
    }

    protected void btPay_Click(object sender, EventArgs e)
    {
        if (Convert.ToDecimal(tbTotalSum.Text) == 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вказано суму розподілу');", true);
            return;
        }

        //if (String.IsNullOrEmpty(tbNd.Text))
        //{
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Необхідно вказати № документу');", true);
        //    return;
        //}

        if (Convert.ToDecimal(tbTypedPercents.Text) != 100)
        {
            if (Convert.ToDecimal(tbTotalSum.Text) != Convert.ToDecimal(tbTypedSum.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Загальний % не дорівнює 100');", true);
                return;
            }
        }

        if (Convert.ToDecimal(tbTotalSum.Text) != Convert.ToDecimal(tbTypedSum.Text))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Набранна сума " + tbTypedSum.Text + " не дорівнює загальній сумі розподілу " + tbTotalSum.Text + "');", true);
            return;
        }

        BbConnection con = new BbConnection();
        DynamicLayoutUi mgr = new DynamicLayoutUi(con);
        mgr.PAY_STATIC_LAYOUT(1);

        con.CloseConnection();

        show_headers();
        gvStatic.DataBind();
        btPay.Enabled = false;
    }
    protected void btSaveDetail_Click(object sender, EventArgs e)
    {
        if (tbMfoBTypeA.Text != null)
        {
            decimal? dk = null;
            decimal? id = (lbId.Text == null ? 0 : Convert.ToDecimal(lbId.Text));
            decimal? l_dates_to_nazn = cbDatesToNazn.Checked ? 1 : 0;
            if (cbInfo.Checked == false)
            {
                if (rbListDk.SelectedValue == "1")
                {
                    dk = 1;
                }
                if (rbListDk.SelectedValue == "0")
                {
                    dk = 0;
                }
            }
            else
            {
                if (rbListDk.SelectedValue == "1")
                {
                    dk = 3;
                }
                if (rbListDk.SelectedValue == "0")
                {
                    dk = 2;
                }
            }

            if (String.IsNullOrEmpty(tbTotalSum.Text))
            {
                tbTotalSum.Text = "0.00";
            }

            if (String.IsNullOrEmpty(tbPersentTypeA.Text))
            {
                tbPersentTypeA.Text = "0.00";
            }

            if (String.IsNullOrEmpty(tbSumTypeA.Text))
            {
                tbSumTypeA.Text = "0.00";
            }

            if (String.IsNullOrEmpty(tbConstTypeA.Text))
            {
                tbConstTypeA.Text = "0.00";
            }

            if (String.IsNullOrEmpty(tbSpecNaznTypeA.Text))
            {
                tbSpecNaznTypeA.Text = tbNazn.Text;
            }

            //if (String.IsNullOrEmpty(tbNd.Text))
            //{
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Необхідно запонити поле № документу');", true);
            //    return;
            //}

            if (String.IsNullOrEmpty(tbNlsBTypeA.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Необхідно запонити поле Рах.Б в МФО-Б');", true);
                return;
            }

            if (String.IsNullOrEmpty(tbNameBTypeA.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Необхідно запонити поле Назва отримувача ');", true);
                return;
            }

            if (String.IsNullOrEmpty(tbOkpobTypeA.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Необхідно запонити поле Ід Код-Б');", true);
                return;
            }

            if (tbPersentTypeA.Text != "0" && tbSumTypeA.Text != "0")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Необхідно заповнити або % від суми або суму проводки');", true);

                return;
            }

            BbConnection con = new BbConnection();
            DynamicLayoutUi mgr = new DynamicLayoutUi(con);

            try
            {
                decimal ord = (String.IsNullOrEmpty(tbOrdTypeA.Text) ? 0 : Convert.ToDecimal(tbOrdTypeA.Text));
                decimal vob = (String.IsNullOrEmpty(tbVobTypeA.Text) ? 0 : Convert.ToDecimal(tbVobTypeA.Text));

                mgr.UPDATE_DYNAMIC_LAYOUT(tbNd.Text, diDatD.SelectedDate, diDateFrom.SelectedDate, diDateTo.SelectedDate, l_dates_to_nazn, tbNazn.Text, Convert.ToDecimal(tbTotalSum.Text) * 100, 0);
                mgr.ADD_STATIC_LAYOUT(id, dk, tbNd.Text, Convert.ToDecimal(tbKvA.Value), tbNlsA.Text, null, null,
                                      tbMfoBTypeA.Text, tbNlsBTypeA.Text, tbNameBTypeA.Text, tbOkpobTypeA.Text, Convert.ToDecimal(tbPersentTypeA.Text), Convert.ToDecimal(tbSumTypeA.Text),
                                      Convert.ToDecimal(tbSumTypeA.Text), Convert.ToDecimal(tbConstTypeA.Text), tbTTTypeA.Text, vob, tbSpecNaznTypeA.Text, ord);
            }
            catch (Exception E)
            {
                string txt = "";
                var ErrorText = E.Message.ToString();
                var x = ErrorText.IndexOf("ORA");
                var ora = ErrorText.Substring(x + 4, 5); //-20001

                if (Convert.ToDecimal(ora) >= 20000)
                {
                    var ora1 = ErrorText.Substring(x + 11);
                    var y = ora1.IndexOf("ORA");
                    if (x > 0 && y > 0)
                    {
                        txt = ErrorText.Substring(x + 11, y - 1);
                    }
                    else
                    {
                        txt = ErrorText;
                    }

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + txt.Replace("ы", "і") + "');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + ErrorText + "');", true);
                }
                con.CloseConnection();
            }
            finally
            {
                con.CloseConnection();
            }

            gvStatic.DataBind();


            tblDetailTypeA.Visible = false;
            btAddLayout.Enabled = true;
            btEditLayout.Enabled = true;
            btDeleteLayout.Enabled = true;
            btSaveDetail.Enabled = false;
            show_headers();

            lbId.Text = "0";
            tbMfoBTypeA.Text = null;
            tbNlsBTypeA.Text = null;
            tbNameBTypeA.Text = null;
            tbOkpobTypeA.Text = null;
            tbPersentTypeA.Text = "0";
            tbSumTypeA.Text = "0";
            tbConstTypeA.Text = "0";
            tbTTTypeA.Text = null;
            tbVobTypeA.Text = null;
            tbSpecNaznTypeA.Text = null;
            tbOrdTypeA.Text = null;

        }
    }
    protected void btNew_Click(object sender, EventArgs e)
    {
        //Створення розпорядження по вибору
        Server.Transfer("/barsroot/dynamicLayout/static_layout.aspx");
    }
    protected void btAddLayout_Click(object sender, EventArgs e)
    {
        tblDetailTypeA.Visible = true;
        btAddLayout.Enabled = false;
        btEditLayout.Enabled = false;
        btDeleteLayout.Enabled = false;
        btSaveDetail.Enabled = true;
    }
    protected void btEditLayout_Click(object sender, EventArgs e)
    {
        if (gvStatic.SelectedRows.Count != 0)
        {
            tblDetailTypeA.Visible = true;
            btAddLayout.Enabled = false;
            btEditLayout.Enabled = false;
            btDeleteLayout.Enabled = false;
            btSaveDetail.Enabled = true;

            lbId.Text = gvStatic.DataKeys[gvStatic.SelectedRows[0]]["ID"].ToString();
            tbMfoBTypeA.Text = gvStatic.DataKeys[gvStatic.SelectedRows[0]]["MFOB"].ToString();
            tbNlsBTypeA.Text = gvStatic.DataKeys[gvStatic.SelectedRows[0]]["NLS_B"].ToString();
            tbNameBTypeA.Text = gvStatic.DataKeys[gvStatic.SelectedRows[0]]["NAMB"].ToString();
            tbOkpobTypeA.Text = gvStatic.DataKeys[gvStatic.SelectedRows[0]]["OKPOB"].ToString();
            tbPersentTypeA.Text = gvStatic.DataKeys[gvStatic.SelectedRows[0]]["PERCENT"].ToString();
            tbSumTypeA.Text = gvStatic.DataKeys[gvStatic.SelectedRows[0]]["SUMM_A"].ToString();
            tbConstTypeA.Text = gvStatic.DataKeys[gvStatic.SelectedRows[0]]["DELTA"].ToString();
            tbTTTypeA.Text = gvStatic.DataKeys[gvStatic.SelectedRows[0]]["TT"].ToString();
            tbVobTypeA.Text = gvStatic.DataKeys[gvStatic.SelectedRows[0]]["VOB"].ToString();
            tbSpecNaznTypeA.Text = gvStatic.DataKeys[gvStatic.SelectedRows[0]]["NAZN"].ToString();
            tbOrdTypeA.Text = (Convert.ToDecimal(gvStatic.DataKeys[gvStatic.SelectedRows[0]]["ORD"]) == 0 ? "1" : gvStatic.DataKeys[gvStatic.SelectedRows[0]]["ORD"].ToString());
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Оберіть рядок');", true);
        }
    }
    protected void btDeleteLayout_Click(object sender, EventArgs e)
    {
        if (gvStatic.SelectedRows.Count != 0)
        {
            decimal id = Convert.ToDecimal(gvStatic.DataKeys[gvStatic.SelectedRows[0]]["ID"]);
            decimal grp = Convert.ToDecimal(gvStatic.DataKeys[gvStatic.SelectedRows[0]]["NLS_COUNT"]);

            BbConnection con = new BbConnection();
            DynamicLayoutUi mgr = new DynamicLayoutUi(con);

            try
            {
                mgr.DELETE_STATIC_LAYOUT(grp, id);
            }
            catch (Exception E)
            {
                string txt = "";
                var ErrorText = E.Message.ToString();
                var x = ErrorText.IndexOf("ORA");
                var ora = ErrorText.Substring(x + 4, 5); //-20001

                if (Convert.ToDecimal(ora) >= 20000)
                {
                    var ora1 = ErrorText.Substring(x + 11);
                    var y = ora1.IndexOf("ORA");
                    if (x > 0 && y > 0)
                    {
                        txt = ErrorText.Substring(x + 11, y - 1);
                    }
                    else
                    {
                        txt = ErrorText;
                    }

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + txt.Replace("ы", "і") + "');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + ErrorText + "');", true);
                }
                con.CloseConnection();
            }
            finally
            {
                con.CloseConnection();
            }

            show_headers();
            gvStatic.DataBind();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Оберіть рядок');", true);
        }
    }
    protected void btCalc_Click(object sender, EventArgs e)
    {
        //if (String.IsNullOrEmpty(tbNd.Text))
        //{
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Необхідно заповнити поле № док ');", true);
        //    return;
        //}

        if (String.IsNullOrEmpty(tbTotalSum.Text))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Необхідно заповнити суму розподілу');", true);
            return;
        }

        BbConnection con = new BbConnection();
        DynamicLayoutUi mgr = new DynamicLayoutUi(con);

        decimal? l_dates_to_nazn = cbDatesToNazn.Checked ? 1 : 0;
        try
        {
            mgr.UPDATE_DYNAMIC_LAYOUT(tbNd.Text, diDatD.SelectedDate, diDateFrom.SelectedDate, diDateTo.SelectedDate, l_dates_to_nazn, tbNazn.Text, Convert.ToDecimal(tbTotalSum.Text) * 100, 0);
            mgr.CALCULATE_DYNAMIC_LAYOUT(null);
            mgr.CALCULATE_STATIC_LAYOUT();
        }
        catch (Exception E)
        {
            string txt = "";
            var ErrorText = E.Message.ToString();
            var x = ErrorText.IndexOf("ORA");
            var ora = ErrorText.Substring(x + 4, 5); //-20001

            if (Convert.ToDecimal(ora) >= 20000)
            {
                var ora1 = ErrorText.Substring(x + 11);
                var y = ora1.IndexOf("ORA");
                if (x > 0 && y > 0)
                {
                    txt = ErrorText.Substring(x + 11, y - 1);
                }
                else
                {
                    txt = ErrorText;
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + txt.Replace("ы", "і") + "');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + ErrorText + "');", true);
            }
            con.CloseConnection();
        }
        finally
        {
            con.CloseConnection();
        }

        show_headers();
        gvStatic.DataBind();

        btPay.Enabled = true;
    }
}
