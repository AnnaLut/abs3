﻿using Bars.Classes;
using barsroot.cim;
using cim;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class cim_payments_unbound_payments : System.Web.UI.Page
{
    #region Protected

    private const string SuprovidniDocs = "Супровідні документи";

    protected void Page_Load(object sender, EventArgs e)
    {
        dsCimTypes.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCimPayTypes.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        Master.SetPageTitle(this.Title, true);
        if (Session[Constants.StateKeys.VisaId] == null)
            Session[Constants.StateKeys.VisaId] = (new CimManager(true)).VisaId;

		Master.AddScript(String.Format("/barsroot/cim/payments/scripts/cim_payments.js?v={0}.01", barsroot.ServicesClass.GetVersionWeb()));
        Master.AddScript("/barsroot/Scripts/Bars/bars.config.js");
        if (!ClientScript.IsStartupScriptRegistered(this.GetType(), "init"))
            ClientScript.RegisterStartupScript(this.GetType(), "init", "CIM.setVariables('" + gvVCimUnboundPayments.ClientID + "', '" + Request["contr_id"] + "','" + Request["direct"] + "','" + Request["payflag"] + "','" + Convert.ToString(Session["CIM.VisaId"]) + "','" + DateTime.Now.ToString("yyyyMMdd") + "','" + ((DateTime)Session[Constants.StateKeys.BankDate]).ToString("dd/MM/yyyy") + "'); ", true);

        if (Request["contr_id"] != null)
        {
            Master.SetPageTitle(this.Title + " (для привязки по контракту #" + Request["contr_id"] + ")", true);
            pnAddFilter.Visible = true;
            bool directIn = (Request["direct"] == "0");
            rbInPays.Checked = directIn;
            rbOutPays.Checked = !directIn;
            rbSearchByRef.Visible = false;
            pnUnboundsType.Enabled = false;
            dvBack.Visible = true;
        }

        bool chIn = rbInPays.Checked;
        bool chOut = rbOutPays.Checked;
        bool chAll = rbAllPays.Checked;


        if (!IsPostBack && Session["cim_payments_rbflag"] != null && Request["contr_id"] == null)
        {
            chIn = chOut = chAll = false;
            switch (Convert.ToString(Session["cim_payments_rbflag"]))
            {
                case "1": chIn = true; rbInPays.Checked = true; break;
                case "2": chOut = true; rbOutPays.Checked = true; break;
                case "0": chAll = true; rbAllPays.Checked = true; break;
            }
        }

        pnSearchByRef.Visible = false;
        odsVCimUnboundPayments.SelectParameters["CUST_RNK"].DefaultValue = Request["CUST_RNK"];
        var gridBoundColumns = gvVCimUnboundPayments.Columns.OfType<DataControlField>();

        if (chAll)
        {
            odsVCimUnboundPayments.TypeName = "cim.VCimUnboundPayments";
            gvVCimUnboundPayments.Columns[2].Visible = true;

            SetVisibility(gridBoundColumns, SuprovidniDocs, false);
        }
        else if (chIn)
        {
            odsVCimUnboundPayments.TypeName = "cim.VCimInUnboundPayments";
            gvVCimUnboundPayments.Columns[2].Visible = false;

            SetVisibility(gridBoundColumns, SuprovidniDocs, false);
        }
        else if (chOut)
        {
            odsVCimUnboundPayments.TypeName = "cim.VCimOutUnboundPayments";

            TemplateField attachmentsCountField = new TemplateField()
            {
                ItemTemplate = new ChebkBooxColumn(),
                HeaderText = SuprovidniDocs,
                SortExpression = "ATTACHMENTS_COUNT"
            };
            if (gridBoundColumns.Any(bf => bf.HeaderText.Equals(SuprovidniDocs)))
            {
                var col = gridBoundColumns.FirstOrDefault(c=> c.HeaderText== SuprovidniDocs);
                if (col != null) gvVCimUnboundPayments.Columns.Remove(col);
            }
            gvVCimUnboundPayments.Columns.Add(attachmentsCountField);
            SetVisibility(gridBoundColumns, SuprovidniDocs, true);

            gvVCimUnboundPayments.Columns[2].Visible = false;
        }
        else if (rbSearchByRef.Checked)
        {
            SetVisibility(gridBoundColumns, SuprovidniDocs, false);

            odsVCimUnboundPayments.TypeName = "cim.VCimFoundPayments";
            {
                odsVCimUnboundPayments.SelectParameters["CUST_RNK"].DefaultValue = tbSearchRef.Text;
            }
            {
                odsVCimUnboundPayments.SelectParameters["DOC_DATE"].DefaultValue = tbSearchVDat.Text;
                odsVCimUnboundPayments.SelectParameters["DOC_NLS"].DefaultValue = tbSearchNls.Text;
                odsVCimUnboundPayments.SelectParameters["DOC_KV"].DefaultValue = tbSearchKv.Text;
                odsVCimUnboundPayments.SelectParameters["DOC_SUM"].DefaultValue = tbSearchSum.Text;
            }

            gvVCimUnboundPayments.Columns[2].Visible = true;
            pnSearchByRef.Visible = true;
        }

        // Привязка 
        if (Request["contr_id"] != null)
        {
            gvVCimUnboundPayments.DataBind();
        }
    }

    private static void SetVisibility(IEnumerable<DataControlField> gridBoundColumns, string columnHeaderText, bool visibility)
    {
        if (gridBoundColumns.Any(bf => bf.HeaderText.Equals(columnHeaderText)) == true)
        {
            gridBoundColumns.First(bf => bf.HeaderText.Equals(columnHeaderText)).Visible = visibility;
        }
    }

    protected void rbInPays_CheckedChanged(object sender, EventArgs e)
    {
        Session["cim_payments_rbflag"] = "1";
        gvVCimUnboundPayments.PageIndex = 0;
        gvVCimUnboundPayments.DataBind();
    }
    protected void rbOutPays_CheckedChanged(object sender, EventArgs e)
    {
        Session["cim_payments_rbflag"] = "2";
        gvVCimUnboundPayments.PageIndex = 0;
        gvVCimUnboundPayments.DataBind();
    }
    protected void rbAllPays_CheckedChanged(object sender, EventArgs e)
    {
        Session["cim_payments_rbflag"] = "0";
        gvVCimUnboundPayments.PageIndex = 0;
        gvVCimUnboundPayments.DataBind();
    }

    protected void gvVCimUnboundPayments_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.Cells[9].Visible = false;
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[9].Visible = false;
            var objJson = new Dictionary<string, object>
                {
                    {"rf",getJsonMapping(e.Row.DataItem, "REF")},
                    {"kv", getJsonMapping(e.Row.DataItem, "KV")},
                    {"vd", getJsonMapping(e.Row.DataItem, "VDAT")},
                    {"pt",getJsonMapping(e.Row.DataItem, "PAY_TYPE")},
                    {"ts",getJsonMapping(e.Row.DataItem, "TOTAL_SUM")},
                    {"us",getJsonMapping(e.Row.DataItem, "UNBOUND_SUM")},
                    {"di",getJsonMapping(e.Row.DataItem, "DIRECT")},
                    {"ptn",getJsonMapping(e.Row.DataItem, "PAY_TYPE_NAME")},
                    {"crn", getJsonMapping(e.Row.DataItem, "CUST_RNK")},
                    {"cnm", getJsonMapping(e.Row.DataItem, "CUST_NMK")},
                    {"cop", getJsonMapping(e.Row.DataItem, "CUST_OKPO")},
                    {"bnm", getJsonMapping(e.Row.DataItem, "BENEF_NMK")},
                    {"nz", getJsonMapping(e.Row.DataItem, "NAZN")},
                    {"ot", getJsonMapping(e.Row.DataItem, "OP_TYPE")},
                    {"oti",getJsonMapping(e.Row.DataItem, "OP_TYPE_ID")},
                    {"isv",getJsonMapping(e.Row.DataItem, "IS_VISED")},
                    {"acc",getJsonMapping(e.Row.DataItem, "ACC")}
                };
            if (e.Row.DataItem is VCimOutUnboundPaymentsRecord)
                objJson.Add("attach", getJsonMapping(e.Row.DataItem, "ATTACHMENTS_COUNT"));

            e.Row.Attributes.Add("rd", new JavaScriptSerializer().Serialize(objJson));
            string rf = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "REF"));
            decimal type = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PAY_TYPE"));
            decimal direction = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "DIRECT"));

            if (!string.IsNullOrEmpty(rf) &&
                Session[Constants.StateKeys.ParamsPrintCorp2Doc] != null &&
                Convert.ToByte(Session[Constants.StateKeys.ParamsPrintCorp2Doc]) == 1 &&
                !(e.Row.DataItem is VCimFoundPaymentsRecord))
            {
                decimal kv = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "KV"));
                string tt = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TT")).ToUpper();
                if (type == 0)
                    e.Row.Cells[1].Text += "&nbsp;&nbsp;<img src='/Common/Images/default/16/document_edit.png' title='Редагування дод. реквізитів' onclick='curr_module.EditDocAttr(" + rf + ", \"" + tt + "\")'></img>";
                if (tt.StartsWith("IB") && kv != 980)
                {
                    e.Row.Cells[1].Text += "&nbsp;&nbsp;<img src='/Common/Images/default/16/print.png' title='Надрукувати форму документа по corp2' onclick='curr_module.PrintDoc(" + rf + ", \"" + tt + "\")'></img>";
                    //if (tt.Equals("IBO") || tt.Equals("IBS") || tt.Equals("IBB"))
                }

                if (direction == 0)
                    e.Row.Cells[1].Text += "&nbsp;&nbsp;<img src='/Common/Images/default/16/form_green.png' title='Запит на документи' onclick='curr_module.SaveDocFRX(" + rf + ")'></img>";
            }
            string isVised = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "IS_VISED"));
            if (isVised.Equals("0"))
                e.Row.ForeColor = Color.Green;

            if (type >= 1)
                e.Row.ForeColor = Color.Blue;

            try
            {
                string color = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BACKGROUND_COLOR"));
                if (color == "1")
                {
                    e.Row.Cells[0].BackColor = Color.Yellow;
                    e.Row.Cells[1].BackColor = Color.Yellow;
                }
            }
            catch (Exception)
            {
            }

            decimal totalSum = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TOTAL_SUM"));
            decimal unboundSum = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "UNBOUND_SUM"));
            // еще не привязан 
            if (unboundSum == totalSum)
            {
                e.Row.Cells[5].Font.Bold = true;
                e.Row.Cells[5].ForeColor = Color.Maroon;
            }
            else if (unboundSum < totalSum && unboundSum > 0) // частично привязан
            {
                e.Row.Cells[5].Font.Bold = true;
                e.Row.Cells[5].ForeColor = Color.Green;
            }
            else
                e.Row.Cells[5].ForeColor = Color.Black;

            //bind click event to ATTACHMENTS_COUNT column
            var corpLight = new[] { "CL0", "CL1", "CL2", "CL5", "CLB", "CLS" };
            var row = e.Row.DataItem as VCimOutUnboundPaymentsRecord;
            if (row != null && row.ATTACHMENTS_COUNT > 0 && corpLight.Contains(row.TT))
            {
                e.Row.Cells[e.Row.Cells.Count - 1].Attributes.Add("onclick", "curr_module.ShowAttachments("+ row.REF + ")");
            }
        }
    }

    private object getJsonMapping(object dataItem, string sourceField)
    {
        object obj = null; 
        try
        {
            obj = DataBinder.Eval(dataItem, sourceField);

        }
        catch (Exception)
        {
            obj = null;
        }
        if (obj is DateTime)
            obj = (obj == DBNull.Value || Convert.ToString(obj) == "" || Convert.ToString(obj) == "null") ? ("") : (Convert.ToDateTime(obj).ToString("dd/MM/yyyy"));

        return obj;
    }

    #endregion

    #region Page Methods
    [WebMethod(EnableSession = true)]
    public static Contract PopulateContract(decimal? contrId)
    {
        Contract contractInfo = new Contract(contrId);
        return contractInfo;
    }

    [WebMethod(EnableSession = true)]
    public static ResultData CheckBind(Contract contract, BindClass bindInfo)
    {
        return contract.CheckBind(bindInfo);
    }

    [WebMethod(EnableSession = true)]
    public static decimal SaveBind(Contract contract, BindClass bindInfo)
    {
        return contract.SaveBind(bindInfo);
    }

    [WebMethod(EnableSession = true)]
    public static void UnboundPayment(BindClass bindInfo)
    {
        Contract contract = new Contract();
        contract.UnboundPayment(bindInfo.BoundId.Value, bindInfo.PaymentType, "Привязка з занесенням в журнал");
    }

    [WebMethod(EnableSession = true)]
    public static ResultData CheckForVisa(decimal docRef, BindClass bindInfo)
    {
        CimManager cm = new CimManager(false);
        return cm.CheckForVisa(docRef, bindInfo);
    }


    [WebMethod(EnableSession = true)]
    public static ResultData GetCorp2Doc(decimal docRef, string tt)
    {
        CimManager cm = new CimManager(false);
        return cm.GetCorp2Doc(docRef, tt);
    }

    [WebMethod(EnableSession = true)]
    public static bool CheckForBackVisa(decimal docRef)
    {
        HttpContext.Current.Session[Constants.StateKeys.CurrRef] = docRef;
        return true;
    }
    [WebMethod(EnableSession = true)]
    public static void BackPayment(int docType, decimal docRef)
    {
        CimManager cm = new CimManager(false);
        cm.BackPayment(docType, docRef);
    }

    [WebMethod(EnableSession = true)]
    public static void ClearNullLicense(string okpo)
    {
        CimManager cm = new CimManager(false);
        cm.ClearNullLicense(okpo);
    }

    [WebMethod(EnableSession = true)]
    public static ResultData BindZeroContract(BindClass bindInfo)
    {
        CimManager cm = new CimManager(false);
        return cm.BindZeroContract(bindInfo);
    }

    [WebMethod(EnableSession = true)]
    public static string GetDocRels(decimal docRef, int docType)
    {
        CimManager cm = new CimManager(false);
        return cm.GetDocRels(docRef, docType);
    }

    #endregion

    protected void btSearchByRef_OnClick(object sender, EventArgs e)
    {
        odsVCimUnboundPayments.SelectParameters["CUST_RNK"].DefaultValue = tbSearchRef.Text;
        odsVCimUnboundPayments.SelectParameters["DOC_DATE"].DefaultValue = tbSearchVDat.Text;
        odsVCimUnboundPayments.SelectParameters["DOC_NLS"].DefaultValue = tbSearchNls.Text;
        odsVCimUnboundPayments.SelectParameters["DOC_KV"].DefaultValue = tbSearchKv.Text;
        odsVCimUnboundPayments.SelectParameters["DOC_SUM"].DefaultValue = tbSearchSum.Text;
        gvVCimUnboundPayments.DataBind();
    }

    protected void OnSelectedIndexChanged(object sender, EventArgs e)
    {
        if (rblModeSearch.SelectedIndex == 0)
        {
            tbSearchNls.Text = "";
            tbSearchKv.Text = "";
            tbSearchSum.Text = "";
            tbSearchVDat.Text = "";
            trSearchByRef.Visible = true;
            trSearchByDate.Visible = false;
        }
        else
        {
            tbSearchRef.Text = "";
            // tbSearchVDat.Text = ((DateTime)Session[Constants.StateKeys.BankDate]).ToString("dd/MM/yyyy");
            trSearchByRef.Visible = false;
            trSearchByDate.Visible = true;
        }
        gvVCimUnboundPayments.DataBind();
    }
}

class ChebkBooxColumn : ITemplate
{
    public void InstantiateIn(System.Web.UI.Control container)
    {
        CheckBox cbAttachmentsCount = new CheckBox();
        cbAttachmentsCount.Enabled = false;
        cbAttachmentsCount.ID = "cbAttachmentsCount";
        cbAttachmentsCount.DataBinding += new EventHandler(this.AttachmentsCount_DataBinding);
        container.Controls.Add(cbAttachmentsCount);
    }

    private void AttachmentsCount_DataBinding(object sender, EventArgs e)
    {
        CheckBox cb = (CheckBox)sender;
        GridViewRow row = (GridViewRow)cb.NamingContainer;
        int attachmentsCount;
        int.TryParse(DataBinder.Eval(row.DataItem, "ATTACHMENTS_COUNT").ToString(), out attachmentsCount);
        cb.Checked = attachmentsCount > 0;
    }
}