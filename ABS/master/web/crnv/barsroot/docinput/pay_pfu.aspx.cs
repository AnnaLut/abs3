using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Bars.Logger;

public partial class docinput_PFU : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        dsDocument.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();

        dsDocumentsList.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();

        if (!IsPostBack)
        {
            listAgencyType.Items.Add(new ListItem("-", "-1", true));
            listAgencyType.Items.Add(new ListItem("Пенсійний Фонд", "1", true));
            listAgencyType.Items.Add(new ListItem("Пенсійний Фонд (Військові пенсіонери)", "6", true));

            tbYear.Text = DateTime.Now.Year.ToString();
            listMonths.SelectedIndex = DateTime.Now.Month - 1;

            btnPay.Enabled = false;
        }
        else
        {
            dsDocumentsList.SelectCommand = @"select ID, ND, NLSB_ALT, NLSB, NMSB, (S/100) S, NAZN 
                        from PAY_PFU where ISP = user_id and REF is null order by ID desc";
        }
    }

    protected void Fill_AgencyList()
    {
        try
        {
            InitOraConnection();
            
            ClearParameters();
            SetParameters("agency_type", DB_TYPE.Decimal, listAgencyType.SelectedValue, DIRECTION.Input);

            listAgency.DataSource = SQL_SELECT_dataset(@"select CREDIT_ACC, NAME from SOCIAL_AGENCY
                where TYPE_ID = :agency_type and DATE_OFF is Null
                  and BRANCH like SYS_CONTEXT('bars_context','user_branch_mask') order by BRANCH ");

            listAgency.DataBind();

        }
        finally
        {
            DisposeOraConnection();
        }

        listAgency.Items.Insert(0, new ListItem("-", "-1", true));

        // listAgency.Attributes["onchange"] = "SpecialMark_change(this)";
    }

    /// <summary>
    /// 
    /// </summary>
    protected void listAgencyType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (listAgencyType.SelectedItem.Value == "-1")
            tbSymbol.Text = String.Empty;
        else
            tbSymbol.Text = "87";

        Fill_AgencyList();
    }

    /// <summary>
    /// 
    /// </summary>
    protected void listAgency_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (listAgency.SelectedItem.Value == "-1")
        {
            tbAccountNumber.Text = String.Empty;
            tbAccountName.Text = String.Empty;
        }
        else
        {
            try
            {
                InitOraConnection();

                ClearParameters();
                SetParameters("acc", DB_TYPE.Decimal, listAgency.SelectedValue, DIRECTION.Input);

                ArrayList reader = SQL_reader("SELECT nls, nms FROM accounts WHERE acc = :acc and DAZS is Null");

                if (reader.Count == 0)
                {
                    throw new Exception("Не знайдено або закритий рахунок 2909 !");
                }
                else
                {
                    tbAccountNumber.Text = Convert.ToString(reader[0]);
                    tbAccountName.Text = Convert.ToString(reader[1]);

                    fmvDocument.Visible = true;

                    gvDocumentsList.DataBind();

                    if (gvDocumentsList.Rows.Count == 0)
                    {
                        btnPay.Enabled = false;
                    }
                    else
                    {
                        GetSumCount();

                        btnPay.Enabled = true;
                    }
                }
            }
            finally
            {
                DisposeOraConnection();
            }

            tbWarrantNumber.Focus();
        }
    }

    /// <summary>
    /// Підсумок введених документів (к-ть та сума)
    /// </summary>
    private void GetSumCount()
    {
        try
        {
            InitOraConnection();

            ArrayList reader = SQL_reader("select nvl(sum(s),0)/100, count(*) from PAY_PFU where ISP = user_id and REF is null");

            tbDocsSum.Text = Convert.ToDecimal(reader[0]).ToString("### ### ##0.00");
            tbDocsCount.Text = Convert.ToString(reader[1]);
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    /// <summary>
    /// 
    /// </summary>
    protected void gvDocumentsList_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        btnPay.Enabled = false;

        fmvDocument.ChangeMode(FormViewMode.Edit);
    }

    /// <summary>
    /// 
    /// </summary>
    protected void fmvDocument_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        if (e.CommandName == "Cancel")
        {
            gvDocumentsList.SelectedIndex = -1;
            
            btnPay.Enabled = true;
        }
    }

    /// <summary>
    /// виконується ПЕРЕД вставкою даних
    /// </summary>
    protected void fmvDocument_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        //
        // Перевірка введених даних
        //

        if (Convert.ToDecimal(e.Values["S"]) == 0)
        {
            e.Cancel = true;
            throw new Exception("Не вказано суму зарахування!");
        }
        else
        {
            e.Values["S"] = (Convert.ToDecimal(e.Values["S"]) * 100);
        }

        String Nls = Convert.ToString(e.Values["NLSB"]);

        if (String.IsNullOrEmpty(Nls))
        {
            String NlsAlt = Convert.ToString(e.Values["NLSB_ALT"]);

            if (String.IsNullOrEmpty(NlsAlt))
            {
                throw new Exception("Не вказано рахунок для зарахування!");
            }
            else
            {
                // пошук по альтернативному рахунку
                try
                {
                    DropDownList Pretenders = (fmvDocument.FindControl("it_ddPretenders") as DropDownList);

                    InitOraConnection();

                    ClearParameters();
                    SetParameters("nls_alt", DB_TYPE.Varchar2, NlsAlt, DIRECTION.Input);

                    Pretenders.DataSource = SQL_SELECT_dataset(@"select a.nls, nvl(c.nmkk, SubStr(c.nmk,1,38)) nms
                         from ACCOUNTS a, CUSTOMER c
                        where a.NBS = '2620' and a.KV = 980 and a.DAZS is Null and a.NLSALT = :nls_alt
                          and a.BRANCH like SYS_CONTEXT('bars_context','user_branch_mask')
                          and a.RNK = c.RNK");
                    Pretenders.DataBind();

                    if (Pretenders.Items.Count == 0)
                    {
                        e.Cancel = true;
                        throw new Exception("Не знайдено або закритий рахунок!");
                    }
                    else
                    {
                        if (Pretenders.Items.Count == 1)
                        {
                            e.Values["NLSB"] = Pretenders.Items[0].Value;
                            e.Values["NMSB"] = Pretenders.Items[0].Text;
                        }
                        else
                        {
                            e.Cancel = true;

                            Pretenders.Items.Insert(0, new ListItem("", "", true));
                            Pretenders.Visible = true;

                            Label lbMessage = (fmvDocument.FindControl("it_lbMessage") as Label);

                            lbMessage.Visible = true;
                            lbMessage.Text = "Виберійть отримувача із списку: &nbsp;";
                        }
                    }
                }
                finally
                {
                    DisposeOraConnection();
                }
            }
        }
        else
        {
            // пошук по особовому рахунку
            try
            {
                InitOraConnection();

                ClearParameters();
                SetParameters("nls", DB_TYPE.Varchar2, Nls, DIRECTION.Input);

                ArrayList reader = SQL_reader(@"select nls, nms from ACCOUNTS 
                        where NLS = :nls and KV = 980 and DAZS is Null");

                if (reader.Count == 0)
                {
                    e.Cancel = true;
                    throw new Exception("Не знайдено або закритий рахунок (" + Nls +"/980)!");
                }
                else
                {
                    e.Values["NMSB"] = Convert.ToString(reader[1]);
                }
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        e.Values.Add("NAZN", "Зарахування пенсії за " + listMonths.SelectedItem.Text + " " + tbYear.Text + " року.");
    }

    /// <summary>
    /// виконується ПІСЛЯ вставки даних 
    /// </summary>
    protected void fmvDocument_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        GetSumCount();
        gvDocumentsList.DataBind();
        btnPay.Enabled = true;
        (fmvDocument.FindControl("it_AsvoCreditNls") as TextBox).Focus();
    }

    /// <summary>
    /// 
    /// </summary>
    protected void et_ddPretenders_Init(object sender, EventArgs e)    
    {
        DropDownList Pretenders = (fmvDocument.FindControl("et_ddPretenders") as DropDownList);

        Int64 ID = Convert.ToInt64(gvDocumentsList.SelectedValue);

        try
        {
            InitOraConnection();

            ClearParameters();
            SetParameters("id", DB_TYPE.Decimal, ID, DIRECTION.Input);

            Pretenders.DataSource = SQL_SELECT_dataset(@"select a.nls, nvl(c.nmkk, SubStr(c.nmk,1,38)) nms
              from ACCOUNTS a, CUSTOMER c, PAY_PFU  p
             where a.NBS = '2620' and a.KV = 980 and a.DAZS is Null 
               and a.BRANCH like SYS_CONTEXT('bars_context','user_branch_mask')
               and a.NLSALT = p.nlsb_alt and p.ID = :id and a.RNK = c.RNK");
            
            Pretenders.DataBind();

            Pretenders.Items.Insert(0, new ListItem("", "", true));
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    /// <summary>
    /// виконується ПЕРЕД операцією видаленням даних 
    /// </summary>
    protected void fmvDocument_ItemDeleting(Object sender, FormViewDeleteEventArgs e)
    {
        // DBLogger.Info(dsDocument.DeleteCommand + " <> " + Convert.ToString(e.Values["ID"]), "social");

        dsDocument.DeleteCommand = "delete from PAY_PFU where ID = " + Convert.ToString(e.Values["ID"]);
    }

    /// <summary>
    /// виконується ПІСЛЯ завершення операції видалення даних
    /// </summary>
    protected void fmvDocument_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        GetSumCount();
        gvDocumentsList.DataBind();
        gvDocumentsList.SelectedIndex = -1;

        fmvDocument.ChangeMode(FormViewMode.Insert);

        btnPay.Enabled = true;
    }

    /// <summary>
    /// виконується перед операцією оновлення даних
    /// </summary>
    protected void fmvDocument_ItemUpdating(Object sender, FormViewUpdateEventArgs e)
    {
        //
        // Перевірка введених даних
        //

        if (Convert.ToDecimal(e.NewValues["S"]) == 0)
        {
            e.Cancel = true;
            throw new Exception("Не вказано суму зарахування!");
        }
        else
        {
            e.NewValues["S"] = (Convert.ToDecimal(e.NewValues["S"]) * 100);
        }

        e.NewValues.Add("NAZN", "Зарахування пенсії за " + listMonths.SelectedItem.Text + " " + tbYear.Text + " року.");
    }
    
    /// <summary>
    /// виконується ПІСЛЯ завершення операції оновлення даних
    /// </summary>
    protected void fmvDocument_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        GetSumCount();
        gvDocumentsList.DataBind();
        gvDocumentsList.SelectedIndex = -1;
        
        btnPay.Enabled = true;
    }

    /*  protected void fmvDocument_DataBound(object sender, EventArgs e)
        {
            FormView frmv = (sender as FormView);
        
            TextBox tbNLSB = (frmv.FindControl("et_RealCreditNls") as TextBox);

            TextBox tbNMSB = (frmv.FindControl("et_CreditName") as TextBox);

            DropDownList listPretenders = (frmv.FindControl("et_ddPretenders") as DropDownList);

            if (tbNLSB != null && tbNMSB != null)
            {
                tbNLSB.Text = listPretenders.SelectedItem.Value;
                tbNMSB.Text = listPretenders.SelectedItem.Text;
            
                DBLogger.Info("Pretender=" + listPretenders.SelectedItem.Value + " / " + listPretenders.SelectedItem.Text, "social");
            }
            DBLogger.Info("fmvDocument_DataBound", "social");
        }
    */

    /// <summary>
    /// Вибір отримувача із списку (пошук по альтернативному рахунку)
    /// </summary>
    protected void Pretenders_SelectedIndexChanged(object sender, EventArgs e)
    {       
        DropDownList list = (sender as DropDownList);

        if (list.ID == "et_ddPretenders")
        {
            (fmvDocument.FindControl("et_RealCreditNls") as TextBox).Text = list.SelectedItem.Value;
            (fmvDocument.FindControl("et_CreditName") as TextBox).Text = list.SelectedItem.Text;

        }

        if (list.ID == "it_ddPretenders")
        {
            (fmvDocument.FindControl("it_RealCreditNls") as TextBox).Text = list.SelectedItem.Value;
            (fmvDocument.FindControl("it_CreditName") as TextBox).Text = list.SelectedItem.Text;

        }
    }
    
    /// <summary>
    /// Створення документів на зарахування згідно введеного списку
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnPay_Click(object sender, EventArgs e)
    {
        try
        {
            InitOraConnection();

            ClearParameters();
            // SetParameters("nls", DB_TYPE.Varchar2, Nls, DIRECTION.Input);

            SQL_PROCEDURE("DPT_PF.CREATE_DOCS_BY_LIST");
        }
        finally
        {
            DisposeOraConnection();
        }

        GetSumCount();
        gvDocumentsList.DataBind();
        btnPay.Enabled = false;

        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", String.Format("alert('{0}'); ", "Сформовано документи згідно списку"), true);
    }
}