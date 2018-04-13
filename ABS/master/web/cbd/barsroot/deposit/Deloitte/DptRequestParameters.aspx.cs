using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Bars.Exception;
using Bars.Logger;
using Bars.Oracle;
using Bars.Requests;
using Bars.Web.Controls;
using Oracle.DataAccess.Client;

public partial class deposit_DptRequestParameters : System.Web.UI.Page
{
    public Boolean IsEdit
    {
        get
        {
            return (Boolean)this.ViewState["IsEdit"];
        }
        set
        {
            this.ViewState["IsEdit"] = value;
        }
    }

    /// <summary>
    /// тип запиту на доступ
    /// </summary>
    private Int16 req_type
    {
        get
        {
            return (Int16)this.ViewState["req_type"];
        }
        set
        {
            this.ViewState["req_type"] = value;
        }
    }

    /// <summary>
    /// ІД запиту
    /// </summary>
    private Int32 req_id
    {
        get
        {
            return Convert.ToInt32(Request["req_id"]);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request["req_id"] == null)
            {
                Response.Redirect("DptRequestProcessing.aspx");
            }
            else
            {
                tbRequestID.Text = Request.QueryString["req_id"];
            }

            IsEdit = false;

            btRequestSaveChanges.Enabled = false;

            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "OnPageLoad", "AfterPageLoad()", true);
        }

        if (Request["readonly"] != null)
        {
            // Перегляд картки запиту з архіву
            btRequestAllowed.Visible = false;
            btRequestModify.Visible = false;
            btRequestSaveChanges.Visible = false;
            btRequestRejected.Visible = false;
            tbRequestComment.Enabled = false;

            lbPageTitle.Text = "Перегляд запиту на доступ";

            lbDateProc.Visible = true;
            tbDateProc.Visible = true;
            lbUserName.Visible = true;
            tbUserName.Visible = true;
            lbReqStatus.Visible = true;
            tbReqStatus.Visible = true;
        }

        rbClientCard.Enabled = false;
        rbContracts.Enabled = false;
    }

    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        // 
        FillControls(req_id);
    }

    /// <summary>
    /// Наповнення полів даними заиту
    /// </summary>
    private void FillControls(Decimal Request_ID)
    {        
        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmdSQL = connect.CreateCommand();

            cmdSQL.CommandText = @"select TRUSTEE_ID, TRUSTEE_NAME, TRUSTEE_CODE, 
                                          p.BDAY as TRUSTEE_BDAY, 
                                          TRUSTEE_TYPE_ID, TRUSTEE_TYPE_NAME, CERTIF_NUM, CERTIF_DATE,
                                          REQ_DAT_START, REQ_DAT_FINISH,
                                          r.REQ_STATE as STATE_CODE, r.STATE_NAME, r.REQ_TYPE, REQ_COMMENTS,
                                          to_char(r.REQ_PRCDATE,'dd/mm/yyyy hh24:mi:ss') as REQ_PRCDATE, s.FIO
                                     from V_DPT_ACCESS_REQUESTS r
                                    inner join PERSON p on ( p.rnk = r.TRUSTEE_ID )
                                     left join STAFF$BASE s on ( s.ID = r.REQ_PRCUSERID )
                                    where r.REQ_ID = :p_reqid ";

            cmdSQL.Parameters.Add("p_reqid", OracleDbType.Decimal, Request_ID, ParameterDirection.Input);
        
            OracleDataReader rdr = cmdSQL.ExecuteReader();

            if (rdr.Read())
            {
                // РНК 3-ї особи
                if (!rdr.IsDBNull(0))
                    // HiddenField для javascript перегляду картки клієнта
                    rnk.Value = Convert.ToString(rdr.GetOracleDecimal(0).Value);

                // Назва клієнта 3-ї особи
                if (!rdr.IsDBNull(1))
                    textClientName.Text = rdr.GetOracleString(1).Value;

                // ІПН клієнта 3-ї особи
	            if (!rdr.IsDBNull(2))
                    textClientCode.Text = rdr.GetOracleString(2).Value;

                // Дата народження клієнта 3-ї особи
                if (!rdr.IsDBNull(3))
                    dtClienBirthday.Date = rdr.GetOracleDate(3).Value;
                 // dtClienBirthday.Date = rdr.GetDateTime(3).Date;

                // Тип 3-ї особи (код)
                if (!rdr.IsDBNull(4))
                    TrusteeTypeCode.Value = rdr.GetOracleString(4).Value;

                // Тип 3-ї особи (Назва)
                if (!rdr.IsDBNull(5))
                    textTrusteeType.Text = rdr.GetOracleString(5).Value;
                
                // Номер нотаріального документу
                if (!rdr.IsDBNull(6))
                    tbCertifNum.Text = rdr.GetOracleString(6).Value;
                
                // Дата нотаріального документу
                if (!rdr.IsDBNull(7))
                    dtCertifDate.Date = rdr.GetOracleDate(7).Value;

                // Дата початку дії доручення / дата вступу в права спадкоємця
                if (!rdr.IsDBNull(8))
                    dtDateStart.Date = rdr.GetOracleDate(8).Value;
                
                // Дата завершення дії доручення
                if (!rdr.IsDBNull(9))
                    dtDateFinish.Date = rdr.GetOracleDate(9).Value;

                // Код статусу запиту
                if (!rdr.IsDBNull(10))
                {
                    if (rdr.GetOracleDecimal(10).Value == 0)
                        tbReqStatus.BackColor = System.Drawing.Color.LightGray;
                    else
                    {
                        tbReqStatus.BackColor = System.Drawing.Color.LightPink;
                        btRequestAllowed.Enabled = false;
                        btRequestModify.Enabled = false;
                        btRequestRejected.Enabled = false;

                    }
                }

                // Назва статусу запиту
                if (!rdr.IsDBNull(11))
                    tbReqStatus.Text = rdr.GetOracleString(11).Value;

                // Тип запиту
                if (!rdr.IsDBNull(12))
                    req_type = Convert.ToInt16(rdr.GetOracleDecimal(12).Value);

                // Коментар БЕК-офісу до запиту
                if (!rdr.IsDBNull(13))
                    tbRequestComment.Text = rdr.GetOracleString(13).Value;

                // Дата обробки запиту
                if (!rdr.IsDBNull(14))
                    tbDateProc.Text = rdr.GetOracleString(14).Value;

                // ПІБ користувача, що обробив запит
                if (!rdr.IsDBNull(15))
                    tbUserName.Text = rdr.GetOracleString(15).Value;
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }

        // Тип 3-ї особи
        switch (TrusteeTypeCode.Value)
        {
            case "H":
                lbCertifNum.Text = "Номер свідоцтва про право на спадщину: &nbsp;";
                lbCertifDate.Text = "Дата свідоцтва про право на спадщину: &nbsp;";
                lbRequestDates.Text = "Дата вступу в права: &nbsp;";
                lbDateFinish.Visible = false;
                dtDateFinish.Visible = false;
                break;

            case "T":
                lbCertifNum.Text = "Номер довіреності: &nbsp;";
                lbCertifDate.Text = "Дата довіреності: &nbsp;";
                lbRequestDates.Text = "Дата початку дії: &nbsp;";
                break;

            default:
                lbCertifNum.Text = "Номер документу що посвідчує особу: &nbsp;";
                lbCertifDate.Text = "Дата документу що посвідчує особу: &nbsp;";
                lbRequestDates.Text = "Дата дії: &nbsp;";
                lbDateFinish.Visible = false;
                dtDateFinish.Visible = false;
                break;
        }

        if (req_type == 1)
        {
            rbContracts.Checked = true;

            dsReqDetails.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
            dsReqDetails.WhereParameters.Clear();

            dsReqDetails.SelectCommand = @"select ra.CONTRACT_ID, ra.AMOUNT, d.RNK as CONTRACT_RNK,
                                                  decode(SubStr(ra.FLAGS,1,1),'1','true','false') as FL_REPORT,
                                                  decode(SubStr(ra.FLAGS,2,1),'1','true','false') as FL_MONEY,
                                                  decode(SubStr(ra.FLAGS,3,1),'1','true','false') as FL_EARLY,
                                                  decode(SubStr(ra.FLAGS,4,1),'1','true','false') as FL_AGREEMENTS                                       
                                             from CUST_REQ_ACCESS ra
                                            inner join DPT_DEPOSIT d on (d.deposit_id = ra.CONTRACT_ID)
                                            where ra.REQ_ID = :p_reqid";

            dsReqDetails.WhereParameters.Add("p_reqid", TypeCode.Decimal, Convert.ToString(Request_ID));
            dsReqDetails.DataBind();
        }
        else // (req_type == 0)
        {            
            rbClientCard.Checked = true;

            EADocsView.Visible = true;
            EADocsView.RNK = Convert.ToInt64(rnk.Value);
        }
    }

    /// <summary>
    /// Надати доступ
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btRequestAllowed_Click(object sender, EventArgs e)
    {
        try
        {
            DepositRequest.Process(req_id, 1, tbRequestComment.Text);

            DBLogger.Info("Користувач надав доступ згідно запиту #" + req_id.ToString(), "deposit");
            try
            {
                //відправляємо відповідь в БОР про обробку запиту
                DepositRequest.SendMessageToBOR(req_id, tbRequestComment.Text);
                DBLogger.Info("Користувач відправив відповідь згідно запиту #" + req_id.ToString(), "deposit");
           
            }
            catch (Exception ex)
            {
                Deposit.SaveException(ex);
                DBLogger.Info(ex.Message , "deposit");
            }

            ClientScript.RegisterStartupScript(this.GetType(), "RequestProcessing",
                "alert('Запит погоджено!'); location.replace('DptRequestProcessing.aspx');", true);
        }
        catch (Exception ex)
        {
            if (ex.Message.Contains("UK_DPTTRUSTEE"))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error_mesage", "alert('Вказана 3-тя особа вже зареєстрована по договору!');", true);
            }
            else
            {
                Deposit.SaveException(ex);

                Random r = new Random();

                String url = string.Format("window.showModalDialog('dialog.aspx?type=err&rcode={0}','','dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;');", r.Next());

                ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "error_mesage", url, true);
            }
        }
    }

    /// <summary>
    /// Редагувати запит
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btRequestModify_Click(object sender, EventArgs e)
    {
        IsEdit = true;

        btClientCard.Enabled = false;

        tbCertifNum.Enabled = true;
        dtCertifDate.Enabled = true;
        dtDateStart.Enabled = true;

        dtDateFinish.Enabled = true;

        tbRequestComment.Enabled = false;
        btRequestAllowed.Enabled = false;
        btRequestModify.Enabled = false;
        btRequestRejected.Enabled = false;

        btRequestSaveChanges.Enabled = true;
    }

    /// <summary>
    /// Зберегти зміни (внесенні працівником БЕК-офісу в запит)
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btRequestSaveChanges_Click(object sender, EventArgs e)
    {
        IsEdit = false;

        btClientCard.Enabled = true;

        tbRequestComment.Enabled = true;

        btRequestAllowed.Enabled = true;
        btRequestModify.Enabled = true;
        btRequestRejected.Enabled = true;

        btRequestSaveChanges.Enabled = false;

        DepositRequest DptRequest;

        List<AccessInfo> AccessList = new List<AccessInfo>();

        if (req_type == 1)
        {
            foreach (ListViewItem row in lvReqDetails.Items)
            {
                AccessInfo AccessRow = new AccessInfo();

                AccessRow.DPT_ID = Convert.ToInt32(lvReqDetails.DataKeys[row.DataItemIndex]["CONTRACT_ID"]);

                NumericEdit nmAmount = row.FindControl("nmAmount") as NumericEdit;
                AccessRow.AMOUNT = nmAmount.Value;

                if ((TrusteeTypeCode.Value == "H") && ((AccessRow.AMOUNT < 1)|| (AccessRow.AMOUNT > 100)))
                {
                    throw new DepositException("Частка спадку має бути в межах від 1 до 100%!");
                }

                if (TrusteeTypeCode.Value == "T")
                {
                    if (Deposit.InheritedDeal(AccessRow.DPT_ID.ToString()))
                    {
                        throw new DepositException("Оформлення довіреності заборонено! \n По депозитному договору є зареєстровані спадкоємці!");
                    }

                    CheckBox cbPrint = row.FindControl("cbPrint") as CheckBox;
                    AccessRow.FL_REPORT = cbPrint.Checked;

                    CheckBox cbMoney = row.FindControl("cbMoney") as CheckBox;
                    AccessRow.FL_MONEY = cbMoney.Checked;

                    CheckBox cbEarlyTermination = row.FindControl("cbEarlyTermination") as CheckBox;
                    AccessRow.FL_EARLY = cbEarlyTermination.Checked;

                    CheckBox cbAgreements = row.FindControl("cbAgreements") as CheckBox;
                    AccessRow.FL_AGREEMENTS = cbAgreements.Checked;
                }                    

                AccessList.Add(AccessRow);
            }
        }

        DptRequest = new DepositRequest(req_id, AccessList);

        DateTime? DateFinish;

        if (dtDateFinish.Date == dtDateFinish.MinDate)
        {
            DateFinish = null;
        }
        else
        {
            DateFinish = dtDateFinish.Date;
        }

        DptRequest.Modify(tbCertifNum.Text, dtCertifDate.Date, dtDateStart.Date, DateFinish);

        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "OnPageLoad", "AfterPageLoad(); alert('Зміни збережено!');", true);
    }

    /// <summary>
    /// Відмовити у доступі
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btRequestRejected_Click(object sender, EventArgs e)
    {
        try
        {
            DepositRequest.Process(req_id, -1, tbRequestComment.Text);

            DBLogger.Info("Користувач відмовив у доступі по запиту #" + Convert.ToString(Request["req_id"]), "deposit");

            try
            {
                //відправляємо відповідь в БОР про обробку запиту
                DepositRequest.SendMessageToBOR(req_id, tbRequestComment.Text);
            }
            catch (Exception ex)
            {
                Deposit.SaveException(ex);
            }

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "RequestProcessing",
                "alert('Запит відхилено!'); location.replace('DptRequestProcessing.aspx');", true);
        }
        catch (Exception ex)
        {
            Deposit.SaveException(ex);

            Random r = new Random();

            String url = string.Format("window.showModalDialog('dialog.aspx?type=err&rcode={0}','','dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;');", r.Next());            

            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "error_mesage", url, true);
        }
    }

    // Перегляд картки клієнта
    protected void btClientCard_Click(object sender, EventArgs e)
    {
        Random r = new Random();

        String url = string.Format("window.showModalDialog('/barsroot/clientproducts/DepositClient.aspx?rnk={0}&info=1&scheme=DELOITTE&code={1}',null,'dialogWidth:750px; dialogHeight:850px; center:yes; status:no');", rnk.Value, r.Next());
        
        ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "ShowClientCard", url, true);
    }

    /// <summary>
    /// Перегляд картки депозитного договору
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lbtShowDepositCard_Command(Object sender, CommandEventArgs e) 
    {
        Random r = new Random();

        String url = string.Format("window.showModalDialog('/barsroot/deposit/DELOITTE/DepositContractinfo.aspx?dpt_id={0}&readonly=true&scheme=DELOITTE&code={1}',null,'dialogWidth:900px; dialogHeight:750px; center:yes; status:no');", e.CommandArgument, r.Next());

        ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "ShowDepositCard", url, true);

        /*  function ShowDepositCardExt(dpt_id, mode)
            {
                var url = "DepositContractInfo.aspx?dpt_id=" + dpt_id + "&readonly=true" + mode;
                url +="&code=" + Math.random();
                var top = window.screen.height/2 - 400;
                var left = window.screen.width/2 - 400;

	            window.open(encodeURI(url),"_blank",
	            "left=" + left + ",top=" + top + 
	            ",height=800px,width=800px,menubar=no,toolbar=no,location=no,titlebar=no,resizable=yes,scrollbars=yes");
            }
        */
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void OnLayoutCreated(object sender, EventArgs e)
    {
        // DBLogger.Info("Тип 3-ї особи " + TrusteeTypeCode.Value, "deposit");

        // Тип 3-ї особи
        switch (TrusteeTypeCode.Value)
        {
            case "T":
                {
                    (lvReqDetails.FindControl("lbAmount") as Label).Text = "Сума доручення";
                    break;
                }

            case "H":
                {
                    (lvReqDetails.FindControl("lbAmount") as Label).Text = "Частка спадку (%)";

                    (lvReqDetails.FindControl("colPrint") as HtmlTableCell).Style.Add("display", "none");
                    (lvReqDetails.FindControl("colMoney") as HtmlTableCell).Style.Add("display", "none");
                    (lvReqDetails.FindControl("colEarly") as HtmlTableCell).Style.Add("display", "none");
                    (lvReqDetails.FindControl("colAgreements") as HtmlTableCell).Style.Add("display", "none");
                    break;
                }

            case "V":
                {
                    (lvReqDetails.FindControl("colAmount") as HtmlTableCell).Style.Add("display", "none");
                    (lvReqDetails.FindControl("colPrint") as HtmlTableCell).Style.Add("display", "none");
                    (lvReqDetails.FindControl("colMoney") as HtmlTableCell).Style.Add("display", "none");
                    (lvReqDetails.FindControl("colEarly") as HtmlTableCell).Style.Add("display", "none");
                    (lvReqDetails.FindControl("colAgreements") as HtmlTableCell).Style.Add("display", "none");
                    break;
                }

            default:
                {
                    break;
                }
        }   
    }
}