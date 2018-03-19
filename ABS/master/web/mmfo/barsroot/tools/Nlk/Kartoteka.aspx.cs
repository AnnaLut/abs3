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
using Bars.Oracle;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System.Globalization;
using System.Drawing;
using System.Collections.Generic;
using Oracle.DataAccess.Types;
using System.Threading;
using Bars.UserControls;

public partial class tools_Nlk_Kartoteka : Bars.BarsPage
{
    protected OracleConnection con;
    int row_counter = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        dsgrid_nlk.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        RegisterClientScript();

        if (!IsPostBack)
        { 
          ACC_.Value = Convert.ToString(Request["ACC"]);
          REF1_.Value = Convert.ToString(Request["REF1"]);
        }


        FillGrid();
    }

    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        if (sourceControl.GetType().Name == "BarsGridViewEx" || (eventArgument != null && eventArgument.Length > 4 && eventArgument.Substring(0, eventArgument.IndexOf("$")) == "Bars"))
        { FillGrid(); }

        base.RaisePostBackEvent(sourceControl, eventArgument);
      
    }

    private void FillGrid()
    {


        dsgrid_nlk.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsgrid_nlk.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DEP_SKRN");
        dsgrid_nlk.SelectParameters.Clear();
        dsgrid_nlk.WhereParameters.Clear();

        String selectCommand = "SELECT o.sos, o.datd, o.ref ref2, o.nlsb, o.s/100 as s, o.Nazn, o.userid, S.FIO  "
                            + "  from nlk_ref_hist h, oper o, staff s  "
                            +"  where ref2 = o.ref "
                            +"    and o.sos>=-10 "
                            +"    and o.userid = s.id";

        if (!String.IsNullOrEmpty(ACC_.Value))
        {
            selectCommand += " and acc = :acc ";
            dsgrid_nlk.SelectParameters.Add("acc", TypeCode.Decimal, ACC_.Value);
        }

        if (!String.IsNullOrEmpty(REF1_.Value))
        {
            selectCommand += " and ref1 = :ref1 ";
            dsgrid_nlk.SelectParameters.Add("ref1", TypeCode.Decimal, REF1_.Value);
        }
       

        selectCommand += " order by o.datd ";

        dsgrid_nlk.SelectCommand = selectCommand;
        grid_nlk.DataBind();


    }

    private void RegisterClientScript()
    {
        string script = @"<script language='javascript'>
			var selectedRow;
            var lastColor;
			function S_A(id,nd,rnk,cus, prod)
			{
			 if(selectedRow != null) selectedRow.style.backgroundColor = lastColor;
			 lastColor = document.getElementById('r_'+id).style.backgroundColor;
             document.getElementById('r_'+id).style.backgroundColor = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('REF2_').value = nd;
             document.getElementById('REF2_').value = rnk;
             document.getElementById('REF2_').value = cus;
             document.getElementById('REF2_').value = prod;
     //          nd = nd1;
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script_A", script);
    }

    protected void gridCCPortf_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        // if (e.Row.RowType == DataControlRowType.Header)
        //    e.Row.Cells[0].Visible = false;
        //else 



        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {


            row_counter++;


            string row_id = "r_" + row_counter.ToString();
            GridViewRow row = e.Row;



            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S_A('" + row_counter + "','" +
                row.Cells[0].Text + "','" + row.Cells[0].Text + "',\"" +
                row.Cells[0].Text + "\",'" + row.Cells[0].Text + "')");



            if (Convert.ToString(row.Cells[4].Text) == "1")
            {
                row.ForeColor = Color.Green;
            }

            if (Convert.ToDecimal(row.Cells[4].Text) < 0)
            {
                row.ForeColor = Color.Red;
            }

            //else if (((DropDownList)row.Cells[1].Controls[1]).Text == "11")
            //{
            //    row.Cells[2].ForeColor = Color.Olive;
            //    row.Cells[3].ForeColor = Color.Olive;
            //    row.Cells[4].ForeColor = Color.Olive;
            //    row.Cells[5].ForeColor = Color.Olive;
            //}
            //else if (((DropDownList)row.Cells[1].Controls[1]).Text == "13")
            //{
            //    row.Cells[2].ForeColor = Color.FromArgb(153, 38, 87);
            //    row.Cells[3].ForeColor = Color.FromArgb(153, 38, 87);
            //    row.Cells[4].ForeColor = Color.FromArgb(153, 38, 87);
            //    row.Cells[5].ForeColor = Color.FromArgb(153, 38, 87);
            //}
            //else if (((DropDownList)row.Cells[1].Controls[1]).Text == "14" || ((DropDownList)row.Cells[1].Controls[1]).Text == "15")
            //{
            //    row.ForeColor = Color.Gray;
            //}

        }

    }

}