using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Bars.Classes;
using barsroot.cim;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

public partial class cim_contracts_licenses : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["contr_id"] != null)
        {
            Master.SetPageTitle(
                this.Title + " по контракту №" + Request["contr_id"] + " (код ОКПО " + Request["taxcode"] + ")", true);
            dvBack.Visible = true;
        }

        dsLicenseType.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        //ScriptManager.GetCurrent(this).Scripts.Add(new ScriptReference("/barsroot/cim/contracts/scripts/cim_licenses.js?v" + CimManager.Version + Master.BuildVersion));
        Master.AddScript("/barsroot/cim/contracts/scripts/cim_licenses.js");
        if (!ClientScript.IsStartupScriptRegistered(this.GetType(), "init"))
            ClientScript.RegisterStartupScript(this.GetType(), "init", "CIM.setVariables('" + Request["contr_id"] + "', '" + Request["taxcode"] + "'); ", true);
    }
    protected void gvCimLicenses_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string parMaskStr = "\"{0}\":'{1}',";
            string parMaskInt = "\"{0}\":{1},";
            string rowdata = "{";
            rowdata += string.Format(parMaskInt, "li", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "LICENSE_ID")));
            rowdata += string.Format(parMaskStr, "okpo", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "OKPO")));
            rowdata += string.Format(parMaskStr, "nm", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "NUM")));
            rowdata += string.Format(parMaskStr, "tp", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TYPE")));
            rowdata += string.Format(parMaskStr, "kv", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "KV"))); 
            rowdata += string.Format(parMaskInt, "s", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S")));
            rowdata += string.Format(parMaskStr, "sd", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S_DOC")));
            string dat = (DataBinder.Eval(e.Row.DataItem, "BEGIN_DATE") == DBNull.Value) ? ("") : (Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "BEGIN_DATE")).ToString("dd/MM/yyyy"));
            rowdata += string.Format(parMaskStr, "bd", dat);
            dat = (DataBinder.Eval(e.Row.DataItem, "END_DATE") == DBNull.Value) ? ("") : (Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "END_DATE")).ToString("dd/MM/yyyy"));
            rowdata += string.Format(parMaskStr, "ed", dat);
            rowdata += string.Format(parMaskStr, "com", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "COMMENTS")));
            
            rowdata = rowdata.Substring(0, rowdata.Length - 1);
            rowdata += "}";
            e.Row.Attributes.Add("rd", rowdata);

            decimal s_doc = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "S_DOC"));
            if (s_doc != 0)
            {
                e.Row.Cells[0].Controls[1].Visible = false;
                e.Row.Cells[1].Controls[1].Visible = false;
            }
        }
    }
    
    [WebMethod(EnableSession = true)]
    public static void UpdateLicense(LicenseClass lc)
    {
        lc.UpdateLicense();
    }

    [WebMethod(EnableSession = true)]
    public static void DeleteLicense(decimal LicenseId)
    {
        LicenseClass lc = new LicenseClass();
        lc.DeleteLicense(LicenseId);
    }
    
}