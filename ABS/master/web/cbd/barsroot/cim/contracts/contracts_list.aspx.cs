using System;
using System.Drawing;
using System.Linq;
using System.Collections.Generic;
using Bars.Classes;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Web.Services;
using barsroot.cim;
using System.Threading;
using FastReport.Format;
using System.Globalization;
using cim;

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

        Master.AddScript("/barsroot/cim/contracts/scripts/cim_contacts.js");
        if (!ClientScript.IsStartupScriptRegistered(this.GetType(), "init"))
            ClientScript.RegisterStartupScript(this.GetType(), "init", "CIM.setVariables('" + gvVCimContracts.ClientID + "','" + Request["mode"] + "'); ", true);

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

        dsContrStatus.SelectCommand = "select null status_id, 'Всі статуси' status_name from dual union all select -1 status_id, 'Всі незакриті' status_name from dual union all select status_id, status_name from CIM_CONTRACT_STATUSES";
        dsContrStatus.DataBind();

        if (Request["mode"] == "select")
        {
            trActions.Visible = false;
            trSelect.Visible = true;
            Master.HideTitle();
            cbFilterByOkpo.Visible = true;
        }
        if (!IsPostBack)
        {
            if (Session[barsroot.cim.Constants.StateKeys.ParamsContractOwnerFlag] == null)
                new CimManager(true);
            cbFilterByOwner.Checked = (Convert.ToString(Session[barsroot.cim.Constants.StateKeys.ParamsContractOwnerFlag]) == "1");
            cbFilterByOkpo.Checked = true;
        }

        gvVCimContracts.DataBind();
    }
    private VCimBoundVmd _vCimBoundVmd;
    private VCimBoundVmd vCimBoundVmd
    {
        get
        {
            if (_vCimBoundVmd == null)
                _vCimBoundVmd = new VCimBoundVmd();

            return _vCimBoundVmd;
        }
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
            rowdata += string.Format(parMaskStr, "ok", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "OKPO")));
            rowdata += string.Format(parMaskStr, "cdel", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "CAN_DELETE")));

            rowdata = rowdata.Substring(0, rowdata.Length - 1);
            rowdata += "}";
            e.Row.Attributes.Add("rd", rowdata);

            decimal flag = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "ATTANTION_FLAG"));
            if (flag == 1)
                e.Row.ForeColor = Color.Red;
        }
    }

    [WebMethod(EnableSession = true)]
    public static bool CloseContract(decimal? contrId)
    {
        Contract contract = new Contract();
        return contract.CloseContract(contrId);
    }

    [WebMethod(EnableSession = true)]
    public static bool ResurrectContract(decimal? contrId)
    {
        Contract contract = new Contract();
        return contract.ResurrectContract(contrId);
    }



    [WebMethod(EnableSession = true)]
    public static ResultData CheckSanction(decimal? contrId)
    {
        Contract contract = new Contract();
        return contract.CheckContractSanctions(contrId);
    }

    [WebMethod(EnableSession = true)]
    public static string getGridData(int? numRows, int? page, string sortField, string sortOrder, bool isSearch, string searchField, string searchString, string searchOper)
    {
        string result = null;
        try
        {
            string whereClause = String.Format("{0} {1} {2}", searchField, searchOper, "@" + searchField);

            VCimAllContracts al = new VCimAllContracts();

            int pageIndex = page ?? 1; //--- current page
            int pageSize = numRows ?? 10; //--- number of rows to show per page
            int totalRecords = 0;// al.Select().Count; //--- number of total items from query
            int totalPages = (int)Math.Ceiling((decimal)totalRecords / (decimal)pageSize); //--- number of pages

            List<VCimAllContractsRecord> list = al.Select(sortField + " " + sortOrder, pageIndex + pageSize, pageIndex * pageSize + 1);
            IEnumerable<VCimAllContractsRecord> sortedRecords = list.ToArray();
            //--- format json
            var jsonData = new
            {
                totalpages = totalPages, //--- number of pages
                page = pageIndex, //--- current page
                totalrecords = totalRecords, //--- total items
                rows = (from row in list
                        select new
                        {
                            i = row.CONTR_ID,
                            cell = new string[] { 
                                row.CONTR_ID.ToString(), 
                    row.CONTR_TYPE_NAME,
                            row.STATUS_NAME}
                        }).ToArray()
            };

            result = Newtonsoft.Json.JsonConvert.SerializeObject(jsonData);

        }
        finally
        {
        }

        return result;
    }
}