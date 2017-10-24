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
using Bars.DynamicLayout;

public partial class edit_layout : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!String.IsNullOrEmpty(Session["DynamicLayoutDk"] as string))
            {
                rbListDk.SelectedValue = Session["DynamicLayoutDk"].ToString();

            }
            if (!String.IsNullOrEmpty(Session["DynamicLayoutName"] as string))
            {
                tbName.Text = Session["DynamicLayoutName"].ToString();

            }
            if (!String.IsNullOrEmpty(Session["DynamicLayoutNls"] as string))
            {
                tbNls.Text = Session["DynamicLayoutNls"].ToString();

            }
            if (!String.IsNullOrEmpty(Session["DynamicLayoutOb"] as string))
            {
                tbOb.Text = Session["DynamicLayoutOb"].ToString();

            }
            if (!String.IsNullOrEmpty(Session["DynamicLayoutBs"] as string))
            {
                tbBs.Text = Session["DynamicLayoutBs"].ToString();

            }
            if (!String.IsNullOrEmpty(Session["DynamicLayoutNazn"] as string))
            {
                tbNazn.Text = Session["DynamicLayoutNazn"].ToString();

            }

            Session["DynamicLayoutDk"] = "";
            Session["DynamicLayoutName"] = "";
            Session["DynamicLayoutNls"] = "";
            Session["DynamicLayoutOb"] = "";
            Session["DynamicLayoutBs"] = "";
            Session["DynamicLayoutNazn"] = "";
        }
    }

    protected void btOK_Click(object sender, EventArgs e)
    {
        Session["DynamicLayoutDk"] = rbListDk.SelectedValue;
        Session["DynamicLayoutName"] = tbName.Text;
        Session["DynamicLayoutNls"] = tbNls.Text;
        Session["DynamicLayoutOb"] = tbOb.Text;
        Session["DynamicLayoutBs"] = tbBs.Text;
        Session["DynamicLayoutNazn"] = tbNazn.Text;

        Response.Redirect("/barsroot/dynamicLayout/calculate_layout.aspx");
    }

    protected void btCancel_Click(object sender, EventArgs e)
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
