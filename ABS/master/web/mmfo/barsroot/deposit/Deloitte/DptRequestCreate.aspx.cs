using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;
using Bars.Requests;
using Bars.Web.Controls;
using BarsWeb.Core.Logger;
using System.Data;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

public partial class DptClientRequestCreate : Bars.BarsPage
{
    private readonly IDbLogger _dbLogger;
    public DptClientRequestCreate()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
    }

    // тип третьої особи
    protected String TrusteeType
    {
        get
        {
            return (String)this.ViewState["TrusteeType"];
        }
        set
        {
            this.ViewState["TrusteeType"] = value;
        }
    }

    /// <summary>
    /// тип запиту на доступ
    /// </summary>
    protected Int16 req_type
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

    private List<AccessInfo> AccessList
    {
        get
        {
            return (List<AccessInfo>)this.ViewState["AccessList"];
        }
        set
        {
            this.ViewState["AccessList"] = value;
        }
    }

    // ідентифікатор запиту
    private Decimal? req_id
    {
        get
        {
            return (Decimal?)this.ViewState["req_id"];
        }
        set
        {
            this.ViewState["req_id"] = value;
        }
    }

    /// <summary>
    /// РНК клієнта що оформляє доступ
    /// </summary>
    private Decimal cust_id
    {
        get
        {
            return Convert.ToDecimal(Request["cust_id"]);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request["cust_id"] == null)
            {
                Response.Redirect("DptClientSearch.aspx");
            }
            else
            {
                // ПІБ третьої особи
                tbTrusteeName.Text = Request.QueryString["cust_name"];
                                
                // Перелік типів третіх осіб
                ddTrusteeType.Items.Add(new ListItem("Вкладник      ", "V", true));
                ddTrusteeType.Items.Add(new ListItem("Довірена особа", "T", true));
                ddTrusteeType.Items.Add(new ListItem("Спадкоємець   ", "H", true));
                ddTrusteeType.Items.Insert(0, new ListItem("<невизначений>", "-1", true));
                
                ddTrusteeType_SelectedIndexChanged(sender, e);

                btCreateRequest.Visible = false;
                pnRequestParams.Visible = false;
            }
        }
        else
        {
            // Для пейджинга
            //if (gvContracts.Visible)
            //    FillGrid(ddTrusteeType.SelectedValue);
        }

        // Наявні запити на доступ клієнта
        if (lvExistingRequests.Visible)
        {
            dsExistingRequests.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
            dsExistingRequests.WhereParameters.Clear();
            dsExistingRequests.SelectCommand = @"select r.REQ_ID, r.REQ_BDATE, 'Запит на доступ до ' || 
                                                        case REQ_TYPE when 0 then 'Картки Клієнта ' 
                                                        else 'Депозиту ('||dpt_utils.table2list_EX('CUST_REQ_ACCESS','CONTRACT_ID','where REQ_ID='||r.REQ_ID)||')' 
                                                        end as REQUEST, r.TRUSTEE_TYPE_NAME, r.REQ_STATE as REQ_STATE_CODE, r.STATE_NAME as REQ_STATE_NAME
                                                   from V_DPT_ACCESS_REQUESTS r
                                                  where r.TRUSTEE_ID = :p_custid
                                                    and (r.REQ_STATE = -1 or r.REQ_STATE = 0 or (r.REQ_STATE = 1 and r.REQ_BDATE = bankdate ))";
            dsExistingRequests.WhereParameters.Add("p_custid", TypeCode.Decimal, Convert.ToString(Request["cust_id"]));
            lvExistingRequests.DataBind();
        }
    }

    /// <summary>
    /// 
    /// </summary>
    protected void ddTrusteeType_SelectedIndexChanged(object sender, EventArgs e)
    {
        TrusteeType = ddTrusteeType.SelectedValue;

        // Якщо запит оформлюється на ВЛАСНИКА
        if (TrusteeType == "V")
        {
            rbClientCard.Enabled = true;
            rbContracts.Enabled = true;

            rbClientCard.Checked = true;
            rbContracts.Checked = false;

            rbClientCard_CheckedChanged(sender, e);
            
            pnSearch.Style.Add("display", "none");

            gvContracts.Columns[14].Visible = false;
            gvContracts.Columns[15].Visible = false;
            gvContracts.Columns[16].Visible = false;
            gvContracts.Columns[17].Visible = false;
            gvContracts.Columns[18].Visible = false;
        }
        else
        {
            rbClientCard.Enabled = false;
            rbContracts.Enabled = false;

            rbClientCard.Checked = false;
            rbContracts.Checked = true;

            rbContracts_CheckedChanged(sender, e);

            pnSearch.Style.Add("display", "block");

            gvContracts.Columns[14].Visible = true;

            if (ddTrusteeType.SelectedValue == "T")
            {
                gvContracts.Columns[15].Visible = true;
                gvContracts.Columns[16].Visible = true;
                gvContracts.Columns[17].Visible = true;
                gvContracts.Columns[18].Visible = true;
            }
        }

        gvContracts.Visible = false;
        btSelectContract.Visible = false;
    }

    /// <summary>
    /// Запит на доступ до Депозитів
    /// </summary>
    protected void rbContracts_CheckedChanged(object sender, EventArgs e)
    {
        req_type = 1;
        gvContracts.Columns[19].Visible = false;
        pnRequestParams.Visible = false;

        if (TrusteeType == "V")
        {
            if (!Tools.Get_DocumentVerifiedState(cust_id))
            {
                String alert = "alert('Заборонено оформлення вибраного типу запиту через неактуальність ідентифікуючих документів клієнта!'); ";

                alert = alert + "location.replace('/barsroot/clientproducts/DepositClient.aspx?rnk=" + cust_id.ToString() + "&scheme=DELOITTE');";
                
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", alert, true);
            }
            
            FillGrid(TrusteeType,false);

            if (gvContracts.Rows.Count > 0)
            {
                gvContracts.Visible = true;
                gvContracts.PageSize = gvContracts.Rows.Count;
                btSelectContract.Visible = true;
                lvExistingRequests.Visible = false;
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "alert('У клієнта відсутні депозити відкриті згідно ЕБП!');", true);
                
                rbContracts.Checked = false;
                rbClientCard.Checked = true;
                rbClientCard_CheckedChanged(sender, e);
            }
        }
    }
    /// <summary>
    /// Запит на доступ до Депозитів
    /// </summary>
    protected void rbContractsClose_CheckedChanged(object sender, EventArgs e)
    {
        req_type = 2;
        gvContracts.Columns[19].Visible = true;

        if (gvContracts.DataKeys.Count > 0)
        {
            foreach (GridViewRow row in gvContracts.Rows)
            {
                CheckBox cbSelectKV = row.FindControl("cbSelectKV") as CheckBox;

                if (gvContracts.DataKeys[row.DataItemIndex]["DPT_ID"] == "UAH")
                {
                    gvContracts.Rows[row.DataItemIndex].Enabled = false;
                    
                }
                /*if ((gvContracts.Rows[row.DataItemIndex].Cells[5].Controls[1] as TextBox).Text == "UAH")
                
                { (gvContracts.Rows[row.DataItemIndex].Cells[8].Controls[1] as CheckBox).Enabled = false; }
                else { (gvContracts.Rows[row.DataItemIndex].Cells[8].Controls[1] as CheckBox).Enabled = true; }
                 * */
                //(gvContracts.Rows[row.DataItemIndex].Cells[1].Controls[1] as CheckBox).Enabled = false; 
               
            }
        }
        pnRequestParams.Visible = false;

        if (TrusteeType == "V")
        {
            if (!Tools.Get_DocumentVerifiedState(cust_id))
            {
                String alert = "alert('Заборонено оформлення вибраного типу запиту через неактуальність ідентифікуючих документів клієнта!'); ";

                alert = alert + "location.replace('/barsroot/clientproducts/DepositClient.aspx?rnk=" + cust_id.ToString() + "&scheme=DELOITTE');";

                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", alert, true);
            }

            FillGrid(TrusteeType,true);

            if (gvContracts.Rows.Count > 0)
            {
                gvContracts.Visible = true;
                gvContracts.PageSize = gvContracts.Rows.Count;
                btSelectContract.Visible = true;
                lvExistingRequests.Visible = false;
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "alert('У клієнта відсутні депозити, доступні до закриття!');", true);

                rbContracts.Checked = false;
                rbClientCard.Checked = true;
                rbClientCard_CheckedChanged(sender, e);
            }
        }
    }

    /// <summary>
    /// Запит на доступ до Картки Клієнта
    /// </summary>
    protected void rbClientCard_CheckedChanged(object sender, EventArgs e)
    {
        req_type = 0;
        
        gvContracts.Visible = false;
        btSelectContract.Visible = false;

        LoadPanelRequestParams();
    }

    /// <summary>
    /// Перехід на картку клієнта
    /// </summary>
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        _dbLogger.Info("Користувач натиснув кнопку " + btnReturn.Text + " на сторінці \"Формування запиту на доступ через «БЕК-офіс»\".", "deposit");

        Response.Redirect("/barsroot/clientproducts/DepositClient.aspx?rnk=" + Request.QueryString["cust_id"] + "&scheme=DELOITTE");
    }

    /// <summary>
    /// Пошук договорів
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btSearchContracts_Click(object sender, EventArgs e)
    {
        if (ddTrusteeType.SelectedValue == "-1")
        {
            Response.Write("<script>alert('Не вибрано тип третьої особи!');</script>");
            return;
        }
        else
        {
            DateTime? BirthDate = null;

            if (!String.IsNullOrEmpty(textClientDate.Text))
            {
                BirthDate = Convert.ToDateTime(textClientDate.Text, Tools.Cinfo());
            }

            // p_extended = 2 - складність як при пошуку клієнта по ЕБП
            /*if (Tools.CheckSearchParams(null, textDepositNum.Text, null, null, textClientName.Text, textClientCode.Text,
                                        BirthDate, textClientSerial.Text, textClientNumber.Text, 2) == 1)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "diag", "window.showModalDialog('dialog.aspx?type=err','','dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;');", true);
                return;
            }*/
            if ((textClientName.Text == String.Empty) && (textClientCode.Text == String.Empty))
            {
                Response.Write("<script>alert('Недостатньо параметрів для пошуку! Заповніть ФІО або ОКПО і повторіть спробу знов!');</script>");
                return;
            }
            else
            {
                FillGrid(ddTrusteeType.SelectedValue,false);
            }

            if (gvContracts.Rows.Count > 0)
            {
                gvContracts.Visible = true;
                btSelectContract.Visible = true;
                ddTrusteeType.Enabled = false;
                lvExistingRequests.Visible = false;
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "alert('Не знайдено депозити (відкриті згідно ЕБП) по введеним умовам пошуку!');", true);
            }
        }
    }

    /// <summary>
    /// Вибір договору для формування запиту
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btSelectContract_Click(object sender, EventArgs e)
    {
       
        AccessList = new List<AccessInfo>();
        
        TrusteeType = ddTrusteeType.SelectedItem.Value;

        if (gvContracts.DataKeys.Count > 0)
        {
            foreach (GridViewRow row in gvContracts.Rows)
            {
                CheckBox cbSelect = row.FindControl("cbSelect") as CheckBox;
                CheckBox cbSelectKV = row.FindControl("cbSelectKV") as CheckBox;

                if (cbSelect.Checked)
                {
                    AccessInfo AccessRow = new AccessInfo();

                    AccessRow.DPT_ID = Convert.ToDecimal(gvContracts.DataKeys[row.DataItemIndex]["DPT_ID"]);
                    
                    _dbLogger.Info("Користувач вибрав депозитний договір №" + Convert.ToString(AccessRow.DPT_ID), "deposit");

                    AccessRow.AMOUNT = (gvContracts.Rows[row.DataItemIndex].Cells[14].Controls[1] as NumericEdit).Value;

                    if (TrusteeType == "H")
                    {
                        if ((AccessRow.AMOUNT < 1)|| (AccessRow.AMOUNT > 100))
                        {
                            // throw new DepositException("Частка спадку для договору №" + Convert.ToString(AccessRow.DPT_ID) + " має бути в межах від 1 до 100%!");

                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", 
                                "alert('Частка спадку для договору №" + Convert.ToString(AccessRow.DPT_ID) + " має бути в межах від 1 до 100%!');", true);
                        }

                        if (AccessRow.AMOUNT == 0)
                        {
                            // throw new DepositException("Не вказана частка спадку для договору №" + Convert.ToString(AccessRow.DPT_ID) + "!");

                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", 
                                "alert('Не вказана частка спадку для договору №" + Convert.ToString(AccessRow.DPT_ID) + "!');", true);
                        }
                    }
                    if (TrusteeType == "T")
                    {
                        if (Deposit.InheritedDeal(AccessRow.DPT_ID.ToString()))
                        {
                            // throw new DepositException("Оформлення довіреності заборонено! \n По депозитному договору #" + 
                            //     AccessRow.DPT_ID.ToString() + " є зареєстровані спадкоємці!");

                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error",
                                "alert('Оформлення довіреності заборонено! \n По депозитному договору №" + AccessRow.DPT_ID.ToString() + " є зареєстровані спадкоємці!');", true);
                        }

                        AccessRow.FL_REPORT = (gvContracts.Rows[row.DataItemIndex].Cells[15].Controls[1] as CheckBox).Checked;

                        AccessRow.FL_MONEY = (gvContracts.Rows[row.DataItemIndex].Cells[16].Controls[1] as CheckBox).Checked;

                        AccessRow.FL_EARLY = (gvContracts.Rows[row.DataItemIndex].Cells[17].Controls[1] as CheckBox).Checked;

                        AccessRow.FL_AGREEMENTS = (gvContracts.Rows[row.DataItemIndex].Cells[18].Controls[1] as CheckBox).Checked;

                        // якщо вказана сума але не вказано параметри виплати (по завершенні / дострокову)
                        if ((AccessRow.AMOUNT > 0) && (AccessRow.FL_MONEY == false && AccessRow.FL_EARLY == false))
                        {
                            //throw new DepositException("Для довіреності депозитному договору #" + AccessRow.DPT_ID.ToString() + 
                            //    " вказано суму але не вказано параметри виплати!");

                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error",
                                "alert('Для довіреності депозитному договору №" + AccessRow.DPT_ID.ToString() + " вказано суму але не вказано параметри виплати!');", true);
                        }
                    }                    
                    if (cbSelectKV.Checked) { AccessRow.FL_KV = (gvContracts.Rows[row.DataItemIndex].Cells[19].Controls[1] as CheckBox).Checked; }
                    else { AccessRow.FL_KV = false; }
                    AccessList.Add(AccessRow);
                }
            }
        }

        if (AccessList.Count > 0)
        {
            
            pnSearch.GroupingText = "Параметри вкладника";
            textClientName.Enabled = false;
            textClientCode.Enabled = false;
            textClientDate.Enabled = false;
            textClientSerial.Enabled = false;
            textClientNumber.Enabled = false;
            textDepositNum.Enabled = false;


            ddTrusteeType.Enabled = false;

            rbClientCard.Enabled = false;
            rbContracts.Enabled = false;

            btSearchContracts.Visible = false;
            btSelectContract.Visible = false;

            gvContracts.Visible = false;
            //gvContracts.Columns[0].Visible = false;
            //gvContracts.DataSource = AccessList;

            // 
            LoadPanelRequestParams();            
        }
        else        
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "alert('Не відмічено жодного депозитного договору!');", true);
            return;
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btPrintRequest_Click(object sender, EventArgs e)
    {
        ddTrusteeType.Enabled = false;

        rbClientCard.Enabled = false;
        rbContracts.Enabled = false;

        DateTime? DateFinish;

        if (dtDateFinish.Date == dtDateFinish.MinDate)
        {
            DateFinish = null;
        }
        else
        {
            DateFinish = dtDateFinish.Date;
        }

        DepositRequest DptRequest;

        if (req_id.HasValue)
        {
            // Зміна параметрів запиту без статусу (для друку заяви)
            DptRequest = new DepositRequest(Convert.ToDecimal(req_id.Value), AccessList);
            DptRequest.Modify(tbCertifNum.Text, dtCertifDate.Date, dtDateStart.Date, DateFinish);
        }
        else
        {
            // Створення нового запиту без статусу (для друку заяви)                        
            if (req_type == 0)
            {
                DptRequest = new DepositRequest();
            }
            else
            {
                DptRequest = new DepositRequest(AccessList);
            }

            DptRequest.Save(req_type, TrusteeType, cust_id, tbCertifNum.Text, dtCertifDate.Date, dtDateStart.Date, DateFinish);

            req_id = DptRequest.ID;
        }

        if (req_id.HasValue)
        {
            // Друк Заяви
            FrxParameters pars = new FrxParameters();
            pars.Add(new FrxParameter("p_req_id", TypeCode.Int64, req_id.Value));

            String template = (rbClientCard.Checked ? "DPT_ACCESS_APPLICATION_CARD" : "DPT_ACCESS_APPLICATION"); 

            FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(template)), pars, this.Page);

            // выбрасываем в поток в формате PDF
            doc.Print(FrxExportTypes.Pdf);

            scAccessApplication.ReadOnly = false;
            scWarrant.ReadOnly = false;
            scSignsCard.ReadOnly = false;

            btCreateRequest.Visible = true;
        }
        else
        {
            Response.Write("<script>alert('Не знайдено активного запиту!');</script>");
            return;
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btPrintSign_Click(object sender, EventArgs e)
    {

        Decimal p_rnk = Convert.ToDecimal( Request.QueryString["cust_id"]);
        _dbLogger.Info("Користувач роздрукував картку зразків підписів для кліента rnk =" + Convert.ToString(p_rnk), "deposit");
        if (p_rnk>0)
        {
            // Друк Заяви
            FrxParameters pars = new FrxParameters();
            pars.Add(new FrxParameter("p_rnk", TypeCode.Decimal, p_rnk));

            String template = "PRINT_SIGN";

            FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(template)), pars, this.Page);

            // выбрасываем в поток в формате PDF
            doc.Print(FrxExportTypes.Pdf);

        }
        else
        {
            Response.Write("<script>alert('Не знайдено активного запиту!');</script>");
            return;
        }
    }

    /// <summary>
    /// Створення запиту на доступ до БЕК-офісу
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btCreateRequest_Click(object sender, EventArgs e)
    {
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        cmd.Parameters.Clear();
        cmd.CommandText = "SELECT  sys_context('bars_context','user_mfo')  FROM dual";
        cmd.CommandType = CommandType.Text;
        string KF = Convert.ToString(cmd.ExecuteScalar());
        _dbLogger.Info("Користувач почав формування запиту на доступ №" , "deposit");
		if (req_id.HasValue)
        {
            DepositRequest.InitRequest(req_id.Value);

            _dbLogger.Info("Користувач завершив формування запиту на доступ №" + Convert.ToString(req_id.Value), "deposit");

            // Відправка сканкопій до ЕАД
            Bars.EAD.EadPack ep = new Bars.EAD.EadPack(new ibank.core.BbConnection());

            // Страховочна синхронізація клієнта в ЕАД
            Decimal? ClientApplicationID = ep.MSG_CREATE("CLIENT", cust_id.ToString(), (UInt64)cust_id, KF);

            if (req_type == 0)
            {
                // Заява на доступ до Картки Клієнта
                Decimal? AccessApplicationID = ep.DOC_CREATE("SCAN", null, scAccessApplication.Value, 146, cust_id);
            }
            else
            {
                for (int i = 0; i < AccessList.Count; i++)
                {
                    // Страховочна синхронізація договору в ЕАД
                    Decimal? DealApplicationID = ep.MSG_CREATE("AGR", "DPT;" + AccessList[i].DPT_ID.ToString(), (UInt64)cust_id, KF);

                    // Заява на доступ до вкладного рахунку
                    Decimal? AccessApplicationID = ep.DOC_CREATE("SCAN", null, scAccessApplication.Value, 224, cust_id, AccessList[i].DPT_ID, null);

                    if (scWarrant.Visible)
                    {
                        // Нот. док.
                        Decimal? WarrantID = ep.DOC_CREATE("SCAN", null, scWarrant.Value, (TrusteeType == "T" ? 222 : 223), cust_id, AccessList[i].DPT_ID, null);
                    }

                    if (scSignsCard.Visible)
                    {
                        // Зразки підпису
                        Decimal? SignsCardID = ep.DOC_CREATE("SCAN", null, scSignsCard.Value, 221, cust_id, AccessList[i].DPT_ID, null);
                    }
                }
                try
                {//створення повідомлень для працівників бекофісу
                    string url = "/barsroot/deposit/deloitte/DptRequestParameters.aspx?req_id=" + Convert.ToString(req_id.Value);
					_dbLogger.Info(url, "deposit");
					DepositRequest.SendMessageToBackOffice(url);
                }
                catch (Exception ex)
                {
                    _dbLogger.Info("Exception text = " + ex.Message, "deposit");

                }

            }
            
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CreateAgreement_Done", String.Format("alert('Створено запит #{0}'); location.replace(location.href);", req_id.Value), true);
        }
        else
        {
            //Response.Write("<script>alert('Відсутній активний запит на доступ');</script>");
            //Response.Flush();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CreateAgreement_Done", "alert('Відсутній активний запит на доступ!');", true);
        }
    }

    /// <summary>
    /// 
    /// </summary>
    private void FillGrid(String TrusteeType, Boolean toClose)
    {   dsContracts.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();

        dsContracts.SelectParameters.Clear();

        string strQuery = @"
            SELECT P.DPT_ID, P.DPT_NUM, P.VIDD_NAME type_name, P.DAT_BEGIN datz, P.DAT_END dat_end,
                   P.CUST_IDCODE okpo, P.CUST_NAME nmk, P.CUST_BIRTHDATE birthdate, P.DOC_SERIAL doc_ser,
                   P.DOC_NUM doc_num, P.DPT_ACCNUM nls, P.DPT_CURCODE lcv, p.BRANCH_ID
              FROM v_dpt_portfolio_ALL_active P
             WHERE p.CUST_ID " + (TrusteeType=="V" ? "=" : "<>") + " :Trustee_ID ";

        /// УМОВА ПОШУКУ

        //// РНК власника
        //dsContracts.SelectParameters.Add("Trustee_ID", TypeCode.Decimal, Request.QueryString["cust_id"]);

        if (TrusteeType != "V")
        {
            // Відсікаємо депозити по яким клієнт вже зареєстрований як 3-тя особа
            strQuery = strQuery + " and p.DPT_ID not in ( select DPT_ID from DPT_TRUSTEE where RNK_TR = :Trustee_ID " +
                " and TYP_TR = :searchParam_TrusteeType and FL_ACT = 1 and UNDO_ID Is Null )";

            dsContracts.SelectParameters.Add("searchParam_TrusteeType", TypeCode.String, TrusteeType);

            // Назва вкладника
            if (textClientName.Text != String.Empty)
            {
                strQuery = strQuery + " and upper(P.CUST_NAME) like :searchParam_clientName ";
                dsContracts.SelectParameters.Add("searchParam_clientName", TypeCode.String, textClientName.Text.ToUpper() + "%");
            }

            // ІПН вкладника
            if (textClientCode.Text != String.Empty)
            {
                strQuery = strQuery + " and P.CUST_IDCODE = :searchParam_clientCode ";
                dsContracts.SelectParameters.Add("searchParam_clientCode", TypeCode.String, textClientCode.Text);
            }

            // Дата народження вкладника
            if (!String.IsNullOrEmpty(textClientDate.Text))
            {
                strQuery = strQuery + " and P.cust_birthdate = :searchParam_bDate";
                dsContracts.SelectParameters.Add("searchParam_bDate", TypeCode.DateTime, textClientDate.Text);
            }

            // По серії докум.
            if (textClientSerial.Text != String.Empty)
            {
                strQuery = strQuery + " and P.DOC_SERIAL = :searchParam_DocSerial";
                dsContracts.SelectParameters.Add("searchParam_DocSerial", TypeCode.String, textClientSerial.Text);
            }

            // По номеру докум.
            if (textClientNumber.Text != String.Empty)
            {
                strQuery = strQuery + " and P.DOC_NUM = :searchParam_DocNumber";
                dsContracts.SelectParameters.Add("searchParam_DocNumber", TypeCode.String, textClientNumber.Text);
            }

            // По номеру вкладу
            if (textDepositNum.Text != String.Empty)
            {
                strQuery = strQuery + " and P.DPT_NUM  like :searchParam_depositND";
                dsContracts.SelectParameters.Add("searchParam_depositND", TypeCode.String, "%" + textDepositNum.Text + "%");
            }
            // По номеру рахунку вкладу
            if (textNLS.Text != String.Empty)
            {
                strQuery = strQuery + " and P.DPT_ACCNUM  = :searchParam_depositNLS";
                dsContracts.SelectParameters.Add("searchParam_depositNLS", TypeCode.String, textNLS.Text);
            }
            if (toClose)
            {
                strQuery += " and dpt_irrevocable(P.DPT_ID) =1 ";
            }
        }
        else
        {
            strQuery = strQuery + " and P.ARCHDOC_ID >= 0";
            if (toClose)
            {
                strQuery += " and dpt_irrevocable(P.DPT_ID) =1 ";
            }
            //додаємо депозити, на які в клієнта оформлена довіреність
            strQuery = strQuery + @" union
            SELECT P.DPT_ID, P.DPT_NUM, P.VIDD_NAME type_name, P.DAT_BEGIN datz, P.DAT_END dat_end,
                   P.CUST_IDCODE okpo, P.CUST_NAME nmk, P.CUST_BIRTHDATE birthdate, P.DOC_SERIAL doc_ser,
                   P.DOC_NUM doc_num, P.DPT_ACCNUM nls, P.DPT_CURCODE lcv, p.BRANCH_ID
              FROM v_dpt_portfolio_ALL_active P
             WHERE p.DPT_ID in (select dpt_id from DPT_TRUSTEE
                                                     where  typ_tr = 'T' 
                                                     and rnk_tr = :Trustee_ID
                                                       And FL_ACT = 1 And UNDO_ID Is Null)
                   and P.ARCHDOC_ID >= 0";
            if (toClose)
            {
                strQuery += " and dpt_irrevocable(P.DPT_ID) =1 ";
                strQuery += @" union SELECT p.dpt_id DPT_ID,  p.dpt_num DPT_NUM, '(успадк. '||P.CUST_NAME||')'||p.vidd_name TYPE_NAME, P.DAT_BEGIN datz, P.DAT_END dat_end,
                   P.CUST_IDCODE okpo, P.CUST_NAME nmk, P.CUST_BIRTHDATE birthdate, P.DOC_SERIAL doc_ser,
                   P.DOC_NUM doc_num, P.DPT_ACCNUM nls, P.DPT_CURCODE lcv, p.BRANCH_ID
                                  from V_DPT_PORTFOLIO_ALL_ACTIVE p,
                                       DPT_INHERITORS h
                                 WHERE p.DPT_ID = h.dpt_id
                                   and h.INHERIT_CUSTID = :Trustee_ID
                                   and dpt_irrevocable(P.DPT_ID) =1";                
            }

        }

       
        strQuery += " order by DPT_ID";

       
        // РНК власника
        dsContracts.SelectParameters.Add("Trustee_ID", TypeCode.Decimal, Request.QueryString["cust_id"]);
        _dbLogger.Info(strQuery, "deposit");
    

        dsContracts.SelectCommand = strQuery;

        gvContracts.DataBind();

    }

    /// <summary>
    /// 
    /// </summary>
    private void LoadPanelRequestParams()
    {
        pnRequestParams.Visible = true;

        dtDateStart.Date = DateTime.Now.Date;

        switch (TrusteeType)
        {
            // Власник
            case "V":
                lbCertifNum.Text = "Номер документу що посвідчує особу: &nbsp;";
                lbCertifDate.Text = "Дата документу що посвідчує особу: &nbsp;";

                //dtDateStart.ReadOnly = true;

                lbDateFinish.Visible = false;
                dtDateFinish.Visible = false;

                validatorDateFinish.Enabled = false;
                CompareValidatorDate2.Enabled = false;

                lbWarrant.Visible = false;
                scWarrant.Visible = false;

                lbSignsCard.Visible = false;
                scSignsCard.Visible = false;

                lbPrintSignsCard.Visible = false;
                PrintSignsCard.Visible = false;

                break;

            // Спадкоємець
            case "H":                
                lbCertifNum.Text = "Номер свідоцтва про право на спадщину: &nbsp;";
                lbCertifDate.Text = "Дата свідоцтва про право на спадщину: &nbsp;";
                lbRequestDates.Text = "Дата вступу в права: &nbsp;";
                lbWarrant.Text = "Сканування свідоцтва: &nbsp;";
                lbDateFinish.Visible = false;
                dtDateFinish.Visible = false;
                validatorDateFinish.Enabled = false;
                CompareValidatorDate2.Enabled = false;
                break;

            // Довірена особа
            case "T":
                lbCertifNum.Text = "Номер довіреності: &nbsp;";
                lbCertifDate.Text = "Дата видачі довіреності: &nbsp;";
                lbRequestDates.Text = "Дата початку дії: &nbsp;";
                lbDateFinish.Text = "Дата завершення дії: &nbsp;";
                lbWarrant.Text = "Сканування довіреності: &nbsp;";
                break;

            default:
                break;
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ExistingRequests_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            Label ReqStateCode = (Label)e.Item.FindControl("lbItemReqStateCode");
            // Label ReqStateName = (Label)e.Item.FindControl("lbItemReqStateName");

            if (ReqStateCode.Text == "-1")
                ((Label)e.Item.FindControl("lbItemReqStateName")).ForeColor = System.Drawing.Color.Red;

            if (ReqStateCode.Text == "1")
                ((Label)e.Item.FindControl("lbItemReqStateName")).ForeColor = System.Drawing.Color.Green;

            // TableRow row = (TableRow)e.Item.FindControl("row");
            // row.ForeColor = System.Drawing.Color.Red;
            //
            // if (row.Cells[).InnerText.ToString().IndexOf("Total") <> -1)    
            //     row.Style.Add("background-color", Drawing.Color.DarkGray.ToString())
        }
    }

    /// <summary>
    /// 
    /// </summary>
    protected void ExistingRequests_Command(Object sender, CommandEventArgs e)
    {
        // перегляд картки запиту
        if (e.CommandName == "ShowReqParams")
        {
            Random r = new Random();

            String url = string.Format("window.showModalDialog('DptRequestParameters.aspx?req_id={0}&readonly=true&scheme=DELOITTE&code={1}',null,'dialogWidth:1000px; dialogHeight:600px; center:yes; status:no');", e.CommandArgument, r.Next());

            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "ShowReqParams", url, true);
        }
    }
}