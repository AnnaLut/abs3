using System;
using Bars.Classes;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using System.Globalization;

public partial class crkr_link_deposit : Bars.BarsPage
{
    protected OracleConnection con;
    private void FillData()
    {
        dsMain.DataBind();
        gvMain.DataBind();
    }

    //Населення грида
    protected void Page_Load(object sender, EventArgs e)
    {

        dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        String SelectCommand = String.Empty;

        if (rbPotential.Checked)
        {
            SelectCommand = @"select id, fio, docserial, docnumber, icod, 
                                    kkname, nsc, lcv, dato, sum, ost 
                                    from v_potential_cust_compens where rnk=" + Request["rnk"];

        }

        if (rbAll.Checked)
        {
            SelectCommand = @"select id, fio, docserial, docnumber, icod, 
                                    kkname, nsc, lcv, dato, sum, ost 
                                    from v_compens";
        }



        dsMain.SelectCommand = SelectCommand;

        gvMain.AutoGenerateCheckBoxColumn = true;
    }

    //Перечитати дани
    protected void btRefresh_Click(object sender, EventArgs e)
    {
        dsMain.DataBind();
        gvMain.DataBind();
    }

    // Для коректного відображення алертiв
    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, typeof(string), "send_error", "myFunc(" + ErrorText + ")", true);
    }

    //Для открытия в новом окне
    private void Window_open(String URL)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "open", " window.open('" + URL + "');", true);
    }


    //Розкраска грида
    protected void gvMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        DateTimeFormatInfo dateFormat = new DateTimeFormatInfo();
        dateFormat.ShortDatePattern = "dd.MM.yyyy";

        try
        {
            InitOraConnection();
            if (rbPotential.Checked)
            {

                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    e.Row.Cells[1].BackColor = System.Drawing.Color.LightGreen;
                    e.Row.Cells[2].BackColor = System.Drawing.Color.LightGreen;
                }
            }
            else
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    e.Row.Cells[1].BackColor = System.Drawing.Color.Pink;
                    e.Row.Cells[2].BackColor = System.Drawing.Color.Pink;
                }
            }

        }
        finally
        {
            DisposeOraConnection();
        }

    }

    protected void cbAll_CheckedChanged(object sender, EventArgs e)
    {
        Boolean chkd = (sender as CheckBox).Checked;

        foreach (GridViewRow row in gvMain.Rows)
        {
            CheckBox cb = row.FindControl("cb") as CheckBox;
            cb.Checked = chkd;
        }
    }



    protected void btLink_Click(object sender, EventArgs e)
    {
        InitOraConnection();

        var p_opercode = (Request["burial"] == "true" ? "ACT_HER" : (Request["funeral"] == "true" ? "ACT_BUR" : "ACT_DEP"));

        try
        {
            foreach (int row in gvMain.GetSelectedIndices())
            {
                Decimal id = Convert.ToDecimal(gvMain.DataKeys[row]["ID"]);


                ClearParameters();
                SetParameters("rnk", DB_TYPE.Varchar2, Request["rnk"], DIRECTION.Input);
                SetParameters("id", DB_TYPE.Int64, id, DIRECTION.Input);
                SetParameters("opercode", DB_TYPE.Varchar2, p_opercode, DIRECTION.Input);

                SQL_NONQUERY("begin crkr_compen_web.actualization_compen(:rnk, :id, :opercode); end;");
            }
        }
        catch (Exception ex)
        {
            ShowError(ex.Message);
        }
        finally
        {
            DisposeOraConnection();

        }
        FillData();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close", "window.close();", true);
    }
}
