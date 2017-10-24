using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using System.Data;
using System.Web;

public partial class swi_pickup_doc : Bars.BarsPage
{

    private void FillData()
    {
        dsMain.DataBind();
        gvMain.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        String SelectCommand = @"select ref, to_char(vdat,'dd.mm.yyyy') vdat, nlsa, nlsb, amount/100 amount, lcv, nazn, tag20, tt, nextvisagrp 
                    from v_sw_impmsg_doc
                            where fdat between to_date('" + Request["VDATE"]+"', 'dd.mm.yyyy')-10 and to_date('"+Request["VDATE"]+"', 'dd.mm.yyyy')+10 and lcv = '" + Request["LCV"] + "'";
        if (cbAmount.Checked)
        {
            SelectCommand = SelectCommand + " and s= to_number(" + Request["AMOUNT"]+")*100 ";
        }

        if (cb20.Checked)
        {
            SelectCommand = SelectCommand + " and tag20= '" + Request["TAG20"]+"'";
        }

        dsMain.SelectCommand = SelectCommand;

    }

    protected void cbAmount_CheckedChanged(object sender, EventArgs e)
    {
        FillData();
    }

    protected void btLink_Click(object sender, EventArgs e)
    {
        if (gvMain.SelectedRows.Count == 0)
        {
            ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Не обрано документ!');", true);
        }
        else
        {
            OracleConnection con = OraConnector.Handler.UserConnection;

            try
            {

                InitOraConnection();

                var ref_abs = (gvMain.Rows[gvMain.SelectedRows[0]].Cells[0].Controls[1] as HyperLink).Text;
                var swref = Request["SWREF"];
                var vdate = (gvMain.Rows[gvMain.SelectedRows[0]].Cells[1]).Text;





                ClearParameters();
                SetParameters("date_pay", DB_TYPE.Varchar2, Convert.ToString(vdate), DIRECTION.Input);
                SetParameters("swref", DB_TYPE.Int64, Convert.ToInt64(swref), DIRECTION.Input);
                SetParameters("ref", DB_TYPE.Int64, Convert.ToInt64(ref_abs), DIRECTION.Input);
                SetParameters("swref1", DB_TYPE.Int64, Convert.ToInt64(swref), DIRECTION.Input);
                SetParameters("ref1", DB_TYPE.Int64, Convert.ToInt64(ref_abs), DIRECTION.Input);
                SetParameters("swref2", DB_TYPE.Int64, Convert.ToInt64(swref), DIRECTION.Input);
                SQL_NONQUERY(@"begin 
                                UPDATE sw_journal SET date_pay= to_date(:date_pay,'dd.mm.yyyy') WHERE swref=:swref;
                                UPDATE sw_oper SET ref=:ref WHERE swref=:swref1;
                                if sql%rowcount=0 then
                                    INSERT INTO sw_oper (ref, swref) VALUES (:ref1, :swref2);
                                end if;
                        end;");

                ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Виконано!');", true);

            }
            finally
            {
                DisposeOraConnection();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "close", "window.close();", true);
            }
        }
    }

    protected void btClose_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close", "window.close();", true);
    }
}