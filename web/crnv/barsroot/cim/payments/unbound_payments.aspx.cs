using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.Services;
using ibank.core;
using barsroot.core;

public partial class cim_payments_unbound_payments : System.Web.UI.Page
{
    #region Protected

    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(this.Title, true);
        ScriptManager.GetCurrent(this).Scripts.Add(new ScriptReference("/barsroot/cim/payments/scripts/cim_payments.js?1.0"));
        if (!ClientScript.IsStartupScriptRegistered(this.GetType(),"init"))
            ClientScript.RegisterStartupScript(this.GetType(), "init", "CIM.setVariables('" + gvVCimUnboundPayments.ClientID + "'); ", true);
    }

    protected void rbInPays_CheckedChanged(object sender, EventArgs e)
    {
        gvVCimUnboundPayments.DataBind();
    }
    protected void rbOutPays_CheckedChanged(object sender, EventArgs e)
    {
        gvVCimUnboundPayments.DataBind();
    }
    protected void rbAllPays_CheckedChanged(object sender, EventArgs e)
    {
        gvVCimUnboundPayments.DataBind();
    }

    protected void gvVCimUnboundPayments_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string parMaskStr = "\"{0}\":'{1}',";
            string parMaskInt = "\"{0}\":{1},";
            string docdata = "{";
            docdata += string.Format(parMaskInt, "rf", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "REF")));
            docdata += string.Format(parMaskInt, "kv", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "KV")));
            docdata += string.Format(parMaskStr, "pt", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "PAY_TYPE")));
            docdata += string.Format(parMaskStr, "ts", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TOTAL_SUM")));
            docdata = docdata.Substring(0, docdata.Length - 1);
            docdata += "}";
            e.Row.Attributes.Add("docdata", docdata);
        }
    }
    
    
    protected void gvVCimUnboundPayments_PreRender(object sender, EventArgs e)
    {
        if (rbAllPays.Checked)
        {
            odsVCimUnboundPayments.TypeName = "cim.VCimUnboundPayments";
        }
        else if (rbInPays.Checked)
        {
            odsVCimUnboundPayments.TypeName = "cim.VCimInUnboundPayments";
        }
        else if (rbOutPays.Checked)
        {
            odsVCimUnboundPayments.TypeName = "cim.VCimOutUnboundPayments";
        }
    }

    #endregion

    #region Page Methods
    [WebMethod]
    public static bool PM_SetVisa(decimal docRef)
    {
        bool result = false;
        BbConnection con = new BbConnection();
        con.InitConnection();

        try
        {
            cim.CimMgr dm = new cim.CimMgr(con, AutoCommit.Disabled);
            dm.VISA_PAYMENT(docRef, null, null);

            result = true;
        }
        catch (System.Exception ex)
        {
            WebUtility.SaveExceptionInSession(ex);
            throw ex;
        }
        finally
        {
            con.CloseConnection();
        }
        return result;
    }

    [WebMethod]
    public static bool PM_BackVisa(decimal docRef)
    {
        bool result = false;
        BbConnection con = new BbConnection();
        con.InitConnection();

        try
        {
            cim.CimMgr dm = new cim.CimMgr(con, AutoCommit.Disabled);
            dm.BACK_PAYMENT(docRef);

            result = true;
        }
        catch (System.Exception ex)
        {
            WebUtility.SaveExceptionInSession(ex);
            throw ex;
        }
        finally
        {
            con.CloseConnection();
        }
        return result;
    }

    #endregion
}
