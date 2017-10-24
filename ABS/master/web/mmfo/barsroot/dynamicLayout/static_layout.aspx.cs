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

public partial class static_layout : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            gvDinamicLayouts.DataSourceID = "odsVStaticLayouts";
            Session["DynamicLayoutDk"] = "";
            Session["DynamicLayoutName"] = "";
            Session["DynamicLayoutNls"] = "";
            Session["DynamicLayoutOb"] = "";
            Session["DynamicLayoutBs"] = "";
            Session["DynamicLayoutNazn"] = "";
            Session["DynamicLayoutType"] = "1";
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
            string grp = Convert.ToString(gvDinamicLayouts.DataKeys[gvDinamicLayouts.SelectedRows[0]]["GRP"]);

            Session["DynamicLayoutDk"] = dk;
            Session["DynamicLayoutName"] = name;
            Session["DynamicLayoutNls"] = nls;
            Session["DynamicLayoutOb"] = ob;
            Session["DynamicLayoutBs"] = bs;
            Session["DynamicLayoutNazn"] = nazn;
            Session["DynamicLayoutGrp"] = grp;

            if (!String.IsNullOrEmpty(nls))
            {
                Response.Redirect("/barsroot/dynamicLayout/calculate_static_typeA.aspx");
            }
            else
            {
                Server.Transfer("/barsroot/dynamicLayout/calculate_static_typeB.aspx");
            }
        }

        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного радка');", true);
        }
    }
}
