using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Oracle;
using Bars.Logger;

public partial class DepositSearch : Bars.BarsPage
{
    protected System.Web.UI.WebControls.RegularExpressionValidator validatorDepositId;
    protected System.Web.UI.WebControls.RegularExpressionValidator RegularExpressionValidator2;
    protected System.Web.UI.WebControls.HyperLink HyperLink;
    protected System.Web.UI.WebControls.RequiredFieldValidator textClientCode_Validator;
    protected System.Web.UI.WebControls.RequiredFieldValidator textClientName_Validator;
    protected System.Web.UI.WebControls.RequiredFieldValidator DocSerial_validator;
    protected System.Web.UI.WebControls.RequiredFieldValidator DocNumber_Validator;
    
    protected System.Web.UI.WebControls.Label lbStar;
    protected System.Web.UI.WebControls.Label Label1;
    protected System.Web.UI.WebControls.Label Label2;
    protected System.Web.UI.WebControls.Label Label3;
    private int row_counter = 0;
    /// <summary>
    /// Завантаження сторінки
    /// </summary>
    private void Page_Load(object sender, System.EventArgs e)
    {
        textDepositId.Attributes["onblur"] = "javascript:doValueCheck(\"textDepositId\")";
        //textDepositNum.Attributes["onblur"] = "javascript:doValueCheck(\"textDepositNum\")";
        textClientId.Attributes["onblur"] = "javascript:doValueCheck(\"textClientId\")";
        textAccount.Attributes["onblur"] = "javascript:doValueCheck(\"textAccount\")";
        textClientCode.Attributes["onblur"] = "javascript:doValueCheck(\"textClientCode\")";
        DocNumber.Attributes["onblur"] = "javascript:doValueCheck(\"DocNumber\")";
        listConditions.Attributes["onchange"] = "changeConditions()";
        listBranches.Attributes["onchange"] = "changeBranches()";

        RegisterClientScript();

        if (Request["action"] == "pay")
            btSelect.Attributes["onclick"] = "javascript:if (AskTransferType())";

        if (!IsPostBack)
        {
            dptid.Value = "";
        }
        else
        {
            if (listConditions.SelectedIndex == 3)
                FillBranches();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private void FillBranches()
    {
        try
        {
            if(!listBranches.Visible) listBranches.Visible = true;
            InitOraConnection();
            SetRole("DPT_ROLE");
            listBranches.DataSource = SQL_SELECT_dataset("select branch,name from our_branch order by name");
            listBranches.DataBind();
            if (branchid.Value != string.Empty)
                listBranches.SelectedIndex = Convert.ToInt32(branchid.Value);
        }
        finally
        {
            DisposeOraConnection();
        }
    }
    #region Web Form Designer generated code
    override protected void OnInit(EventArgs e)
    {
        //
        // CODEGEN: This call is required by the ASP.NET Web Form Designer.
        //
        InitializeComponent();
        base.OnInit(e);
    }

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
        this.Load += new System.EventHandler(this.Page_Load);
    }
    #endregion
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sourceControl"></param>
    /// <param name="eventArgument"></param>
    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        if (sourceControl.GetType().Name == "BarsGridView" || (eventArgument != null && eventArgument.Length > 4 && eventArgument.Substring(0, eventArgument.IndexOf("$")) == "Bars"))
        { 
            FillGrid(false); 
        }

        base.RaisePostBackEvent(sourceControl, eventArgument);
    }
    /// <summary>
    /// Клієнтський скріпт, який
    /// при виборі рядка таблиці
    /// виділяє його кольором
    /// </summary>
    private void RegisterClientScript()
    {
        string script = @"<script language='javascript'>
				var selectedRow;
				function S_A(id,val)
				{
				 if(selectedRow != null) selectedRow.style.background = '';
				 document.getElementById('r_'+id).style.background = '#d3d3d3';
				 selectedRow = document.getElementById('r_'+id);
				 document.getElementById('dptid').value = val;
				}
				</script>";
        Page.RegisterStartupScript(ID + "Script_A", script);
    }
    /// <summary>
    /// Пошук депозитних договорів
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btSearch_ServerClick(object sender, System.EventArgs e)
    {
        FillGrid(true);

        dptid.Value = String.Empty;
        //if (gridSearch.Rows.Count == 1)
        //{
        //    dptid.Value = gridSearch.Rows[0].Cells[1].Text;                
        //    btSelect_ServerClick(sender, e);
        //}
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="btSearchPressed"></param>
    private void FillGrid(bool btSearchPressed)
    {
        DBLogger.Info("Користувач виконав пошук депозитного договору по пенсіонерам та безробітним",
                "SocialDeposit");

        dsSearch.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsSearch.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

        string searchQuery = "select             " +
                        "s.contract_id CONTRACT_ID,       " + //Референс договору, 
                        "s.contract_number CONTRACT_NUMBER,   " + //Номер договору
                        "s.pension_num PENSION_NUM,       " + //Номер пенс.справи 
                        "decode(s.CARD_TYPE, 1, s.card_account, s.account_number) NLS, " + //Номер рахунку 
                        "s.currency_code CURRENCY_ID,       " + //Код валюти
                        "s.type_name ACC_TYPE, " + //Тип
                        "s.contract_date_on DATE_ON,  " + //Дата відкриття 
                        "s.contract_date_off DATE_OFF, " + //Дата закриття 
                        "to_char(s.account_saldo/100,'999999999999999990D99') SAL,     " + //Залишок 
                        "s.rate RATE,              " + //Відсотк.ставка
                        "s.branch_id BRANCH_ID,         " + //Код підрозділу 
                        "s.agency_name AGENCY_NAME,       " + //Район отримання пенсії
                        "s.customer_name CUSTOMER_NAME      " + //ПІБ клієнта"
                        "from v_socialcontracts s, v_dpt_customer d where s.customer_id = d.rnk ";

        // По вкладчику (наименование)
        if (textClientName.Text != String.Empty)
        {
            if (btSearchPressed)
            {
                searchQuery = searchQuery + " and upper(s.customer_name) like :searchParam_clientName ";
                dsSearch.WhereParameters.Add("searchParam_clientName", TypeCode.String, "%" + textClientName.Text.ToUpper() + "%");
            }
            else
                searchQuery = searchQuery + " and upper(s.customer_name) like '%" + textClientName.Text.ToUpper() + "%' ";
        }
        // По иден. коду вкладчика
        if (textClientCode.Text != String.Empty)
        {
            if (btSearchPressed)
            {
                searchQuery = searchQuery + " and d.okpo = :searchParam_clientCode ";
                dsSearch.WhereParameters.Add("searchParam_clientCode", TypeCode.String, textClientCode.Text);
            }
            else
                searchQuery = searchQuery + " and d.okpo = '" + textClientCode.Text + "' ";
        }

        // По дате рождения вкладчика
        if (bDate.Date != DateTime.MinValue)
        {
            if (btSearchPressed)
            {
                searchQuery = searchQuery + " and d.bdate = :searchParam_bDate ";
                dsSearch.WhereParameters.Add("searchParam_bDate", TypeCode.DateTime, bDate.Date.ToString("dd/MM/yyyy"));
            }
            else
            {
                searchQuery = searchQuery + " and d.bdate = :searchParam_bDate ";
                dsSearch.SelectParameters.Add("searchParam_bDate", TypeCode.DateTime, bDate.Date.ToString("dd/MM/yyyy"));
            }
        }

        // По номеру документа
        if (DocNumber.Text != String.Empty)
        {
            if (btSearchPressed)
            {
                searchQuery = searchQuery + " and d.docnum = :searchParam_DocNumber ";
                dsSearch.WhereParameters.Add("searchParam_DocNumber", TypeCode.String, DocNumber.Text);
            }
            else
                searchQuery = searchQuery + " and d.docnum = '" + DocNumber.Text + "' ";
        }

        // По серии документа
        if (DocSerial.Text != String.Empty)
        {
            if (btSearchPressed)
            {
                searchQuery = searchQuery + " and d.docserial = :searchParam_DocSerial ";
                dsSearch.WhereParameters.Add("searchParam_DocSerial", TypeCode.String, DocSerial.Text);
            }
            else
                searchQuery = searchQuery + " and d.docserial = '" + DocSerial.Text + "' ";
        }

        // По номеру счета
        if (textAccount.Text != String.Empty)
        {
            if (btSearchPressed)
            {
                searchQuery = searchQuery + " and (s.account_number like :searchParam_textAccount or s.card_account like :searchParam_textAccount) ";
                dsSearch.WhereParameters.Add("searchParam_textAccount", "%" + textAccount.Text + "%");
                dsSearch.WhereParameters.Add("searchParam_textAccount", "%" + textAccount.Text + "%");
            }
            else
                searchQuery = searchQuery + " and (s.account_number like '%" + textAccount.Text + "%' or s.card_account like '%" + textAccount.Text + "%') ";
        }

        // По контрагенту
        if (textClientId.Text != String.Empty)
        {
            if (btSearchPressed)
            {
                searchQuery = searchQuery + " and d.rnk  = :searchParam_clientID ";
                dsSearch.WhereParameters.Add("searchParam_clientID", TypeCode.Decimal, Convert.ToString(Convert.ToInt64(textClientId.Text)));
            }
            else
            {
                searchQuery = searchQuery + " and d.rnk = :searchParam_clientID ";
                dsSearch.SelectParameters.Add("searchParam_clientID", TypeCode.Decimal, Convert.ToString(Convert.ToInt64(textClientId.Text)));
            }
        }

        // По ид.коду вклада
        if (textDepositId.Text != String.Empty)
        {
            if (btSearchPressed)
            {
                searchQuery = searchQuery + " and s.contract_id = :searchParam_depositID";
                dsSearch.WhereParameters.Add("searchParam_depositID", TypeCode.Decimal, Convert.ToString(Convert.ToInt64(textDepositId.Text)));
            }
            else
            {
                searchQuery = searchQuery + " and s.contract_id = :searchParam_depositID";
                dsSearch.SelectParameters.Add("searchParam_depositID", TypeCode.Decimal, Convert.ToString(Convert.ToInt64(textDepositId.Text)));
            }
        }
        // По номеру вклада
        if (textDepositNum.Text != String.Empty)
        {
            if (btSearchPressed)
            {
                searchQuery = searchQuery + " and s.contract_number like :searchParam_depositND";
                dsSearch.WhereParameters.Add("searchParam_depositND", TypeCode.String, "%" + textDepositNum.Text + "%");
            }
            else
                searchQuery = searchQuery + " and s.contract_number like '%" + textDepositNum.Text + "%' ";
        }

        switch (listConditions.SelectedIndex)
        {
            case 0: searchQuery += " and s.contract_date_off is null"; break;
            case 1: searchQuery += " and s.contract_date_off is null and s.acc_type='PCD'"; break;
            case 3: searchQuery += " and s.branch_id = '" + listBranches.SelectedValue + "'"; break;
            case 2: searchQuery += " and s.contract_date_off is null and s.acc_type='PDM'"; break;
            case 4: searchQuery += " and s.contract_date_off is not null"; break;
            case 5: break;
            default: searchQuery += " and s.contract_date_off is null"; break;
        }

        if (Request.Params.Get("action") == "close")
            searchQuery += " and dpt_social.allow2close(s.contract_id)=1";

        searchQuery += " order by s.contract_id";
        dsSearch.SelectCommand = searchQuery;

        gridSearch.DataBind();
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btSelect_ServerClick(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(dptid.Value))
        {
            Session["DPT_NUM"] = SocialDeposit.GetDptNum(Convert.ToDecimal(dptid.Value));
            String url = String.Empty;

            if (Request["action"] == null)
                url = "DepositContract.aspx?dpt_id=" + dptid.Value;
            else if (Request["action"] == "close")
                url = "DepositContract.aspx?dpt_id=" + dptid.Value + "&action=close";
            else if (Request["action"] == "pay")
                url = "depositcoowner.aspx?dpt_id=" + dptid.Value + "&action=pay&cash=" +
                    cash.Value;
            else if (Request["action"] == "add")
                url = "depositcoowner.aspx?dpt_id=" + dptid.Value + "&action=add&cash=true";

            Response.Redirect(url);
        }
    }
    /// <summary>
    /// 
    /// </summary>
    protected void gridSearch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();
            GridViewRow row = e.Row;
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S_A('" + row_counter + "','" + row.Cells[1].Text + "')");
            row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[1].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[2].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[3].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[4].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[5].HorizontalAlign = HorizontalAlign.Left;
            row.Cells[6].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[7].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[8].HorizontalAlign = HorizontalAlign.Right;
            row.Cells[9].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[10].HorizontalAlign = HorizontalAlign.Right;
            row.Cells[11].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[12].HorizontalAlign = HorizontalAlign.Right;
                        
            if (row.Cells[7].Text != "&nbsp;" && row.Cells[7].Text != string.Empty)
                row.Attributes.Add("style", "color:navy");
        }
    }
}

