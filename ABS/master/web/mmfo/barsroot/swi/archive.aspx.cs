using System;
using Bars.Classes;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class swi_archive : Bars.BarsPage
{
    private void FillData()
    {
        dsMain.DataBind();
        gvMain.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        String SelectCommand = @"SELECT SW_JOURNAL.SWREF,
                                           IO_IND,
                                           MT,
                                           TRN,
                                           SENDER,
                                           B1.NAME SENDER_NAME,
                                           PAYER,
                                          to_char( AMOUNT/100,'fm9999999999990.00') AMOUNT,
                                           CURRENCY,
                                           RECEIVER,
                                           B2.NAME RECEIVER_NAME,
                                           PAYEE,
                                           TRANSIT,
                                           ACCD,
                                           ACCK,
                                           to_char(DATE_IN, 'dd.mm.yyyy HH24:MI:SS') DATE_IN,
                                           to_char(DATE_OUT, 'dd.mm.yyyy HH24:MI:SS') DATE_OUT,
                                           to_char(DATE_PAY, 'dd.mm.yyyy HH24:MI:SS') DATE_PAY,
                                           to_char(VDATE,'dd.mm.yyyy') VDATE,
                                           O.REF,
                                           SUBSTR (SWW.VALUE, 1, 150) TAG20
                                      FROM sw_journal,
                                           sw_banks b1,
                                           sw_banks b2,
                                           tabval t,
                                           sw_oper o,
                                           sw_operw sww
                                     WHERE     sw_journal.swref = o.swref(+)
                                           AND t.lcv = currency
                                           AND b1.bic = sender
                                           AND b2.bic = receiver
                                           AND sww.swref(+) = sw_journal.swref
                                           AND CASE WHEN mt = '103' THEN '20' ELSE '21' END = sww.tag
                                           AND SW_JOURNAL.VDATE >= SYSDATE - 190
                                    ORDER BY SW_JOURNAL.SWREF DESC";
      
      

        if (cbDetails.Checked)
        {
            gvMain.Columns[5].Visible = true;
            gvMain.Columns[6].Visible = true;
            gvMain.Columns[10].Visible = true;
            gvMain.Columns[11].Visible = true;
            gvMain.Columns[12].Visible = true;
            gvMain.Columns[13].Visible = true;
            gvMain.Columns[14].Visible = true;
            gvMain.Columns[15].Visible = true;
            gvMain.Columns[16].Visible = true;

        }
        else
        {
            gvMain.Columns[5].Visible = false;
            gvMain.Columns[6].Visible = false;
            gvMain.Columns[10].Visible = false;
            gvMain.Columns[11].Visible = false;
            gvMain.Columns[12].Visible = false;
            gvMain.Columns[13].Visible = false;
            gvMain.Columns[14].Visible = false;
            gvMain.Columns[15].Visible = false;
            gvMain.Columns[16].Visible = false;

        }
        dsMain.SelectCommand = SelectCommand;
    }
    protected void btRefresh_Click(object sender, EventArgs e)
    {
        FillData();
    }

    private void Window_open(String URL)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "open", "window.showModalDialog('" + URL + "',null,'dialogWidth:850px;');", true);
    }

    protected void btPay_Click(object sender, EventArgs e)
    {
        if (gvMain.SelectedRows.Count == 0)
        {
            ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Не обрано рядок!');", true);
        }
        else
        {
            var swref = (gvMain.Rows[gvMain.SelectedRows[0]].Cells[0].Controls[1] as HyperLink).Text;

            var amount = (gvMain.Rows[gvMain.SelectedRows[0]].Cells[7]).Text;

            var lcv = (gvMain.Rows[gvMain.SelectedRows[0]].Cells[8]).Text;

            var vdate = (gvMain.Rows[gvMain.SelectedRows[0]].Cells[18]).Text;

            var tag20 = (gvMain.Rows[gvMain.SelectedRows[0]].Cells[20]).Text;

            Window_open(String.Format("/barsroot/swi/pickup_doc.aspx?swref={0}&amount={1}&lcv={2}&vdate={3}&tag20={4}", Convert.ToString(swref), Convert.ToString(amount), Convert.ToString(lcv), Convert.ToString(vdate), Convert.ToString(tag20)));
        }
    }
}