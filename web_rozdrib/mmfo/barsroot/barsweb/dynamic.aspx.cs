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
using Bars;
using Bars.Web.Controls;

public partial class barsweb_dynamic : BarsPage
{
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["title"] == null || Request["proc"] == null)
            throw new ApplicationException("Сторінка викликана з невірними параметрами");

        //lbTitle.Text = Convert.ToString(Request["title"]);
        
        ///
        if (Request["p1type"] != null)
        {
            //lbParam1.Text = Convert.ToString(Request["p1"]);
            WebControl ctrl = null;

            switch(Convert.ToString(Request["p1type"]))
            {
                case "n": { ctrl = new TextBox(); break; }
                case "v": {ctrl = new TextBox();break;}
                case "d": {ctrl = new DateEdit();break;}
            }

            if (ctrl != null)
            {
                ctrl.ID = "PAR1";
                param1_ctrl.Controls.Add(ctrl);
            }
        }

        ///
        if (Request["p2type"] != null)
        {
            //lbParam2.Text = Convert.ToString(Request["p2"]);
            WebControl ctrl = null;

            switch (Convert.ToString(Request["p2type"]))
            {
                case "n": { ctrl = new TextBox(); break; }
                case "v": { ctrl = new TextBox(); break; }
                case "d": { ctrl = new DateEdit(); break; }
            }

            if (ctrl != null)
            {
                ctrl.ID = "PAR2";
                param2_ctrl.Controls.Add(ctrl);
            }
        }

        ///
        if (Request["p3type"] != null)
        {
            //lbParam3.Text = Convert.ToString(Request["p3"]);
            WebControl ctrl = null;

            switch (Convert.ToString(Request["p3type"]))
            {
                case "n": { ctrl = new TextBox(); break; }
                case "v": { ctrl = new TextBox(); break; }
                case "d": { ctrl = new DateEdit(); break; }
            }

            if (ctrl != null)
            {
                ctrl.ID = "PAR3";
                param3_ctrl.Controls.Add(ctrl);
            }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btExec_Click(object sender, EventArgs e)
    {
        try
        {
            InitOraConnection();

            ///
            if (Request["p1type"] != null)
            {
                DB_TYPE par1_type = DB_TYPE.Varchar2;
                Object par_val = null;

                switch(Convert.ToString(Request["p1type"]))
                {
                    case "n": { par1_type = DB_TYPE.Decimal; par_val = ((TextBox)param1_ctrl.FindControl("PAR1")).Text; break; }
                    case "v": { par1_type = DB_TYPE.Varchar2; par_val = ((TextBox)param1_ctrl.FindControl("PAR1")).Text; break; }
                    case "d": { par1_type = DB_TYPE.Date; par_val = ((DateEdit)param1_ctrl.FindControl("PAR1")).Date; break; }
                }

                if (String.IsNullOrEmpty(Convert.ToString(par_val)))
                {
                    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "DYNAMIC_SUCCESS",
                        "alert('Заповніть значення параметрів!');", true);
                    return;
                }

                SetParameters(Convert.ToString(Request["p1"]),
                    par1_type, par_val, DIRECTION.Input);
            }

            ///
            if (Request["p2type"] != null)
            {
                DB_TYPE par2_type = DB_TYPE.Varchar2;
                Object par_val = null;

                switch (Convert.ToString(Request["p2type"]))
                {
                    case "n": { par2_type = DB_TYPE.Decimal; par_val = ((TextBox)param2_ctrl.FindControl("PAR2")).Text; break; }
                    case "v": { par2_type = DB_TYPE.Varchar2; par_val = ((TextBox)param2_ctrl.FindControl("PAR2")).Text; break; }
                    case "d": { par2_type = DB_TYPE.Date; par_val = ((DateEdit)param2_ctrl.FindControl("PAR2")).Date; break; }
                }

                if (String.IsNullOrEmpty(Convert.ToString(par_val)))
                {
                    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "DYNAMIC_SUCCESS",
                        "alert('Заповніть значення параметрів!');", true);
                    return;
                }

                SetParameters(Convert.ToString(Request["p2"]),
                    par2_type, par_val, DIRECTION.Input);
            } 
            
            ///
            if (Request["p3type"] != null)
            {
                DB_TYPE par3_type = DB_TYPE.Varchar2;
                Object par_val = null;

                switch (Convert.ToString(Request["p3type"]))
                {
                    case "n": { par3_type = DB_TYPE.Decimal; par_val = ((TextBox)param3_ctrl.FindControl("PAR3")).Text; break; }
                    case "v": { par3_type = DB_TYPE.Varchar2; par_val = ((TextBox)param3_ctrl.FindControl("PAR3")).Text; break; }
                    case "d": { par3_type = DB_TYPE.Date; par_val = ((DateEdit)param3_ctrl.FindControl("PAR3")).Date; break; }
                }

                if (String.IsNullOrEmpty(Convert.ToString(par_val)))
                {
                    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "DYNAMIC_SUCCESS",
                        "alert('Заповніть значення параметрів!');", true);
                    return;
                }

                SetParameters(Convert.ToString(Request["p3"]),
                    par3_type, par_val, DIRECTION.Input);
            }    

            ///
            SQL_PROCEDURE(Convert.ToString(Request["PROC"]));

            ///
            ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "DYNAMIC_SUCCESS",
                "alert('Процедура успішно виконана');", true);
        }
        finally
        {
            DisposeOraConnection();
        }
    }
}
