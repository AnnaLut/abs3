using System;
using System.Collections.Generic;
using Bars.Classes;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Web.Services;
using barsroot.cim;

public partial class cim_contracts_other_contracts_list : System.Web.UI.Page
{
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(this.Title, true);

        ScriptManager.GetCurrent(this).Scripts.Add(new ScriptReference("/barsroot/cim/contracts/scripts/cim_contacts.js?" + DateTime.Now.Ticks));
        if (!ClientScript.IsStartupScriptRegistered(this.GetType(), "init"))
            ClientScript.RegisterStartupScript(this.GetType(), "init", "CIM.setVariables('" + gvVCimContracts.ClientID + "'); ", true);

        dsContrType.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("CIM_ROLE");
        dsContrType.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        dsContrVal.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("CIM_ROLE");
        dsContrVal.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        dsContrStatus.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("CIM_ROLE");
        dsContrStatus.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        dsContrType.SelectCommand = "select -1 contr_type_id, 'Всі контракти' contr_type_name from dual union all select contr_type_id,contr_type_name from CIM_CONTRACT_TYPES";
        dsContrType.DataBind();

        dsContrVal.SelectCommand = "select null kv, 'Всі валюти' name from dual union all select kv, name from tabval where kv in (select kv from V_CIM_ALL_CONTRACTS)";
        dsContrVal.DataBind();

        dsContrStatus.SelectCommand = "select null status_id, 'Всі статуси' status_name from dual union all select status_id, status_name from CIM_CONTRACT_STATUSES";
        dsContrStatus.DataBind();

        gvVCimContracts.DataBind();
    }

    protected void gvVCimContracts_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string parMaskStr = "\"{0}\":'{1}',";
            string parMaskInt = "\"{0}\":{1},";
            string rowdata = "{";
            rowdata += string.Format(parMaskInt, "ci", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "CONTR_ID")));
            rowdata += string.Format(parMaskStr, "rnk", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "RNK")));
            rowdata += string.Format(parMaskStr, "ct", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "CONTR_TYPE_NAME")));
            rowdata += string.Format(parMaskStr, "cn", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "NUM")));
            rowdata = rowdata.Substring(0, rowdata.Length - 1);
            rowdata += "}";
            e.Row.Attributes.Add("rowdata", rowdata);
        }
    }

    [WebMethod(EnableSession = true)]
    public static bool CloseContract(decimal? contrId)
    {
        Contract contract = new Contract();
        return contract.CloseContract(contrId);
    }
}