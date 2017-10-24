using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using System.Data;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Types;
using System.Globalization;

using ibank.core;
using ibank.objlayer;
using Bars.DynamicLayout;

public partial class dynamic_layout : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            gvDinamicLayouts.DataSourceID = "odsVDinamicLayouts";
            Session["DynamicLayoutDk"] = "";
            Session["DynamicLayoutName"] = "";
            Session["DynamicLayoutNls"] = "";
            Session["DynamicLayoutOb"] = "";
            Session["DynamicLayoutBs"] = "";
            Session["DynamicLayoutNazn"] = "";

            if (null != Request["type"])
            {
                Session["DynamicLayoutType"] = Request["type"].ToString();
            }
            else
            {
                Session["DynamicLayoutType"] = "";
            }

        }
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void btOpen_Click(object sender, EventArgs e)
    {
        if (gvDinamicLayouts.SelectedRows.Count != 0)
        {

            string dk = Convert.ToString(gvDinamicLayouts.DataKeys[gvDinamicLayouts.SelectedRows[0]]["DK"]);
            string name = Convert.ToString(gvDinamicLayouts.DataKeys[gvDinamicLayouts.SelectedRows[0]]["NAME"]);
            string nls = Convert.ToString(gvDinamicLayouts.DataKeys[gvDinamicLayouts.SelectedRows[0]]["NLS"]);
            string ob = Convert.ToString(gvDinamicLayouts.DataKeys[gvDinamicLayouts.SelectedRows[0]]["OB"]);
            string bs = Convert.ToString(gvDinamicLayouts.DataKeys[gvDinamicLayouts.SelectedRows[0]]["BS"]);
            string nazn = Convert.ToString(gvDinamicLayouts.DataKeys[gvDinamicLayouts.SelectedRows[0]]["NAZN"]);


            Session["DynamicLayoutDk"] = dk;
            Session["DynamicLayoutName"] = name;
            Session["DynamicLayoutNls"] = nls;
            Session["DynamicLayoutOb"] = ob;
            Session["DynamicLayoutBs"] = bs;
            Session["DynamicLayoutNazn"] = nazn;

            Response.Redirect("/barsroot/dynamicLayout/calculate_layout.aspx");
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного радка');", true);
        }
    }
    protected void ibtEdit_Click(object sender, EventArgs e)
    {
        if (gvDinamicLayouts.SelectedRows.Count != 0)
        {

            string dk = Convert.ToString(gvDinamicLayouts.DataKeys[gvDinamicLayouts.SelectedRows[0]]["DK"]);
            string name = Convert.ToString(gvDinamicLayouts.DataKeys[gvDinamicLayouts.SelectedRows[0]]["NAME"]);
            string nls = Convert.ToString(gvDinamicLayouts.DataKeys[gvDinamicLayouts.SelectedRows[0]]["NLS"]);
            string ob = Convert.ToString(gvDinamicLayouts.DataKeys[gvDinamicLayouts.SelectedRows[0]]["OB"]);
            string bs = Convert.ToString(gvDinamicLayouts.DataKeys[gvDinamicLayouts.SelectedRows[0]]["BS"]);
            string nazn = Convert.ToString(gvDinamicLayouts.DataKeys[gvDinamicLayouts.SelectedRows[0]]["NAZN"]);

            Session["DynamicLayoutDk"] = dk;
            Session["DynamicLayoutName"] = name;
            Session["DynamicLayoutNls"] = nls;
            Session["DynamicLayoutOb"] = ob;
            Session["DynamicLayoutBs"] = bs;
            Session["DynamicLayoutNazn"] = nazn;

            Response.Redirect("/barsroot/dynamicLayout/edit_layout.aspx");
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного радка');", true);
        }
    }
}
