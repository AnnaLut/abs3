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
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.Logger;
using Bars.Exception;
using System.Web.Services;
using Bars.Classes;
using Bars.UserControls;
using Bars.Requests;
using System.Collections.Generic;
using Oracle.DataAccess.Types;
using System.Globalization;


/// <summary>
/// Форма для внесения реквизитов вкладчика
/// </summary>
public partial class DepositClient : Bars.BarsPage
{
    protected Oracle.DataAccess.Client.OracleDataAdapter adapterCountry;
    protected System.Data.DataSet dsCountry;
    protected Oracle.DataAccess.Client.OracleDataAdapter adapterClientCodeType;
    protected System.Data.DataSet dsClientCodeType;
    protected System.Data.DataSet dsDocType;
    protected Oracle.DataAccess.Client.OracleCommand cmdSelectDocType;
    protected Oracle.DataAccess.Client.OracleDataAdapter adapterDocType;

    /// <summary>
    /// Загрузка формы
    /// </summary>
    private void Page_Load(object sender, System.EventArgs e)
    {
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositClient;
        if (!IsPostBack)
        {
            // Для УПБ забираємо скорочення адреси
            if (BankType.GetDptBankType() == BANKTYPE.UPB)
            {
                preClientRegion.Text = String.Empty;
                preClientDistrict.Text = String.Empty;
                preClientSettlement.Text = String.Empty;
                preClientAddress.Text = String.Empty;
                btStreetType.Visible = false;
            }
            else
            {
                preClientRegion.Text = Resources.Deposit.GlobalResources.client_region;
                preClientDistrict.Text = Resources.Deposit.GlobalResources.client_district;
                preClientAddress.Text = Resources.Deposit.GlobalResources.client_address;
                preClientSettlement.Text = Resources.Deposit.GlobalResources.client_city;
            }

            if (Request["info"] == null)
            {
                if (Request["ext"] == null)
                {
                    FillInSession();
                }
                else
                {
                    btSubmit.Visible = false;
                    btUpdate.Visible = true;
                }

                Deposit dpt = (Deposit)Session["DepositInfo"];

                if (dpt.Client.Code == String.Empty)
                    ((Deposit)Session["DepositInfo"]).Clear();

                if (Request["simplify"] != null)
                {
                    validatorTextFioGenitive.Enabled = false;
                    validatorClientSettlement.Enabled = false;
                    validatorAddressFull.Enabled = false;
                    validatorDocNumber.Enabled = false;
                    validatorDocDate.Enabled = false;
                    validatorDocOrg.Enabled = false;
                    validatorBirthDate.Enabled = false;
                    validatorTextClientTerritory.Enabled = false;
                }

                if (Request["customer"] != null)
                {
                    btSubmit.Visible = false;
                    btUpdate.Visible = true;
                }

                string Value = Resources.Deposit.GlobalResources.reg;

                if (Request["agr_id"] != null)
                {
                    ((Deposit)Session["DepositInfo"]).Clear();
                    btSubmit.Visible = false;
                    btUpdate.Visible = true;

                    switch (Convert.ToInt32(Convert.ToString(Request["agr_id"])))
                    {
                        case 5:
                            {
                                //lbInfo.Text = "Регистрация клиента (бенефициара)";
                                Value = Resources.Deposit.GlobalResources.reg1;
                                
                                //if (Request["dest"] != "print")
                                disableValidators();

                                break;
                            }
                        case 8:
                            {
                                //lbInfo.Text = "Регистрация клиента (наследника)";
                                Value = Resources.Deposit.GlobalResources.reg2;
                                if (Request["dest"] != "print")
                                    disableValidators();
                                break;
                            }
                        case 12:
                            {
                                //lbInfo.Text = "Регистрация клиента (довереного лица)";
                                Value = Resources.Deposit.GlobalResources.reg3;
                                break;
                            }
                        case 26:
                            {
                                //lbInfo.Text = "Регистрация клиента (розпорядник по депозитах малолітніх осіб)";
                                Value = Resources.Deposit.GlobalResources.reg5;
                                disableValidators();
                                break;
                            }
                        case 27:
                            {
                                //lbInfo.Text = "Регистрация клиента (малолітня особа)";
                                Value = Resources.Deposit.GlobalResources.reg6;
                                disableValidators();
                                break;
                            }

                    }
                }

                # region DELOITTE
                // ***************************************************************
                // *** для Ощадбанку (робота по схемі DELOITTE описаній в ЕБП) ***
                // ***************************************************************
                if (Request["scheme"] == "DELOITTE")
                {
                    if (Request["agr_id"] == null)
                    {
                        // lbInfo.Text = "Картка Клієнта"
                        Value = Resources.Deposit.GlobalResources.reg4 +
                            ((Request["rnk"] != null) ? (" (РНК=" + Request.QueryString["rnk"] + ")") : "");
                        btSearch.Visible = false;
                    }

                    if (Request["rnk"] != null)
                    {
                        Decimal cust_id = Convert.ToDecimal(Request["rnk"]);

                        // РНК для сканування документів
                        ScanIdentDocs.RNK = Convert.ToInt64(cust_id);

                        // РНК для перегляду сканкопій документів
                        EADocsView.RNK = Convert.ToInt64(cust_id);

                        // Друк заяви на зміну
                        eadPrintChange.RNK = Convert.ToInt64(cust_id);

                        // галочка перевірки актуальності документів
                        cbDocVerified.Visible = true;
                        cbDocVerified.Attributes["onclick"] = "cbDocVerified_CheckedChanged();";

                        IDDocScheme DocScheme = new IDDocScheme();

                        // якщо використовується сканування
                        if (DocScheme.DocsOriginals > 0)
                        {
                            ScanIdentDocs.Visible = true;
                        }
                            // Якщо використовується вирізання фото та підпису клієнта при скануванні
                        if ((DocScheme.ClientPhoto != 0) && (DocScheme.ClientSign != 0))
                        {
                            biClietFoto.Visible = true;
                            biClietFoto.Value = Tools.get_cliet_picture(cust_id, "PHOTO");

                            biClietSign.Visible = true;
                            biClietSign.Value = Tools.get_cliet_picture(cust_id, "SIGN");

                            if (biClietFoto.HasValue && biClietSign.HasValue)
                            {
                                EADocsView.Visible = true;
                            }
                            else
                            {
                                // Якщо відсутні фото та підпис
                                cbDocVerified.Checked = false;
                                cbDocVerified.Enabled = false;
                            }
                        }
                        else
                        {
                            EADocsView.Visible = true;
                        }

                        // Перевірка актуальності ідентифікуючих документів                        
                        if (Tools.Get_DocumentVerifiedState(cust_id))
                        {
                             cbDocVerified.Checked = true;
                             btCreateRequest.Enabled = true;
                        }
                        else
                        {
                            cbDocVerified.Checked = false;
                            btCreateRequest.Enabled = false;
                        }

                        /*
                        // рівень доступу корисувача
                        if (ClientAccessRights.Get_AccessLevel(Convert.ToInt64(cust_id)) == LevelState.Complete)
                        {
                            btEditClient.Enabled = true;
                            eadPrintChange.Visible = true;
                            eadPrintChange.Enabled = false;
                        }
                        else
                        {
                            btEditClient.Enabled = false;
                            eadPrintChange.Visible = false;
                        }
                        */

                        btSubmit.Visible = false;
                        btnClear.Visible = false;

                        btEditClient.Visible = true;

                        eadPrintChange.Visible = true;
                        eadPrintChange.Enabled = false;

                        btCreateRequest.Visible = true;
                        btContracts.Visible = true;
                    }
                    else // Request["rnk"] == null
                    {
                        if (Request["agr_id"] == null)
                            Session.Remove("AccessRights");

                        cbDocVerified.Visible = false;
                        btCreateRequest.Visible = false;
                        btContracts.Visible = false;
                    }

                }
                # endregion

                lbInfo.Text = Value;

                if (Request["rnk"] != null)
                {
                    Client client = ((Deposit)Session["DepositInfo"]).Client;
                    client.ID = Convert.ToDecimal(Request["rnk"]);

                    client.ReadFromDatabase();
                }

            }
            else // info
            {
                # region INFO

                foreach (Control ctrl in DepositFormMain.Controls)
                {
                    if (ctrl is TextBox)
                        ((TextBox)ctrl).Enabled = false;
                    else if (ctrl is DropDownList)
                        ((DropDownList)ctrl).Enabled = false;
                    else if (ctrl is HtmlInputButton)
                        ((HtmlInputButton)ctrl).Disabled = true;
                    else if (ctrl is HtmlInputText)
                        ((HtmlInputText)ctrl).Disabled = true;
                    else if (ctrl is HtmlInputCheckBox)
                        ((HtmlInputCheckBox)ctrl).Disabled = true;
                    else if (ctrl is Button)
                        ((Button)ctrl).Enabled = false;
                    else if (ctrl is Infragistics.WebUI.WebDataInput.WebDateTimeEdit)
                        ((Infragistics.WebUI.WebDataInput.WebDateTimeEdit)ctrl).Enabled = false;
                }

                btSubmit.Visible = false;
                btSearch.Visible = false;
                btnClear.Visible = false;
                btUpdate.Visible = false;
                btEditClient.Visible = false;
                // btPrintChange.Visible = false;
                btCreateRequest.Visible = false;
                btContracts.Visible = false;

                ScanIdentDocs.Visible = false;
                eadPrintChange.Visible = false;

                if (Request["scheme"] == "DELOITTE")
                {
                    Decimal cust_id = Convert.ToDecimal(Request["rnk"]);

                    // Фото та підпис клієнта
                    biClietFoto.Visible = true;
                    biClietFoto.Value = Tools.get_cliet_picture(cust_id, "PHOTO");
                    biClietSign.Visible = true;
                    biClietSign.Value = Tools.get_cliet_picture(cust_id, "SIGN");

                    EADocsView.RNK = Convert.ToInt64(cust_id);
                    EADocsView.Visible = true;
                    
                    /*
                    // Якщо є фото та підпис то є і документи в ЕА
                    if (biClietFoto.HasValue && biClietSign.HasValue)
                    {
                        EADocsView.RNK = Convert.ToInt64(cust_id);
                        EADocsView.Visible = true;
                    }
                    */
                }
            }
            # endregion

            InitControls(true);
        }
        else // IsPostBack
        {
            Client client = ((Deposit)Session["DepositInfo"]).Client;

            if (fRNK.Value != string.Empty && fRNK.Value != "undefined" && fRNK.Value != "-1")
            {
                DBLogger.Info("Пользователь получил информацию из страницы SearchResults", "deposit");

                client.ID = Convert.ToDecimal(fRNK.Value);
                client.ReadFromDatabase();

                InitControls(true);

                fRNK.Value = string.Empty;
                
                // ДУ про реєстрацію довіреної особи
               /* if (Request.QueryString["agr_id"] == "12")
                {
                    InitEADControls(Convert.ToInt64(client.ID));
                }*/
                // блок коду, заборонено змінювати існуючі дані по бенефіціарам, спадкоємцям,довіреним особам, що вже існують.
                if (Request["agr_id"] != null)
                {
                    switch (Convert.ToInt32(Convert.ToString(Request["agr_id"])))
                    {
                        case 5:
                        case 8:
                        case 26:
                        case 27:
                            {
                                foreach (Control ctrl in DepositFormMain.Controls)
                                {
                                    if (ctrl is TextBox)
                                        ((TextBox)ctrl).Enabled = false;
                                    else if (ctrl is DropDownList)
                                        ((DropDownList)ctrl).Enabled = false;
                                    else if (ctrl is HtmlInputButton)
                                        ((HtmlInputButton)ctrl).Disabled = true;
                                    else if (ctrl is HtmlInputText)
                                        ((HtmlInputText)ctrl).Disabled = true;
                                    else if (ctrl is HtmlInputCheckBox)
                                        ((HtmlInputCheckBox)ctrl).Disabled = true;
                                    /*else if (ctrl is Button)
                                        ((Button)ctrl).Enabled = false;*/
                                    else if (ctrl is Infragistics.WebUI.WebDataInput.WebDateTimeEdit)
                                        ((Infragistics.WebUI.WebDataInput.WebDateTimeEdit)ctrl).Enabled = false;
                                }
                                //Edited.Value = "0";
                                break;
                            }
                        case 12:
                            {
                                 InitEADControls(Convert.ToInt64(client.ID));
                                //ClientScript.RegisterStartupScript(this.GetType(), "DisableEditCliet", "f_DisableEditCliet();", true);
                                foreach (Control ctrl in DepositFormMain.Controls)
                                {
                                    if (ctrl is TextBox)
                                        ((TextBox)ctrl).Enabled = false;
                                    else if (ctrl is DropDownList)
                                        ((DropDownList)ctrl).Enabled = false;
                                    else if (ctrl is HtmlInputButton)
                                        ((HtmlInputButton)ctrl).Disabled = true;
                                    else if (ctrl is HtmlInputText)
                                        ((HtmlInputText)ctrl).Disabled = true;
                                    else if (ctrl is HtmlInputCheckBox)
                                        ((HtmlInputCheckBox)ctrl).Disabled = true;
                                    /*else if (ctrl is Button)
                                        ((Button)ctrl).Enabled = false;*/
                                    else if (ctrl is Infragistics.WebUI.WebDataInput.WebDateTimeEdit)
                                        ((Infragistics.WebUI.WebDataInput.WebDateTimeEdit)ctrl).Enabled = false;
                                }
                                //Edited.Value = "0";
                                
                                break;
                            }
                       
                    }
                }
                //кінець заборони зміни параметрів існуючих клієнтів
            }
        }

        // блок команд которые нужно выполнять при каждой загрузке
        if (Request["info"] == null)
        {
            Decimal cust_id = (HttpContext.Current.Session["DepositInfo"] as Deposit).Client.ID;

            // Якщо КК знаходиться не в стані редагування то поля недоступні
            if (Edited.Value != "1")
            {
                if (Request["rnk"] != null)
                {
                    // Перевірка актуальності ідентифікуючих документів
                    if (Tools.Get_DocumentVerifiedState(cust_id))
                    {
                        cbDocVerified.Checked = true;
                        cbDocVerified.Enabled = false;
                    }
                    else
                    {
                        cbDocVerified.Checked = false;
                        cbDocVerified.Enabled = true;
                    }
                
                    // Згортаєм ПІБ та фактичну адресу клієнта
                    ClientScript.RegisterStartupScript(this.GetType(), "DisableEditCliet", "f_DisableEditCliet();", true);
               }
            }
            else
            {
                eadPrintChange.Enabled = true;

                // Приховуємо "базові" поля для неповного доступу
                if ((ClientAccessRights.Get_AccessLevel(Convert.ToInt64(cust_id)) == LevelState.Limited) &&
                    (DepositRequest.HasActive(cust_id, null) == false))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "DisableEditCliet", "SetDisableBaseFields();", true);
                }
            }
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
        this.adapterCountry = new Oracle.DataAccess.Client.OracleDataAdapter();
        this.dsCountry = new System.Data.DataSet();
        this.adapterClientCodeType = new Oracle.DataAccess.Client.OracleDataAdapter();
        this.dsClientCodeType = new System.Data.DataSet();
        this.dsDocType = new System.Data.DataSet();
        ((System.ComponentModel.ISupportInitialize)(this.dsCountry)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.dsClientCodeType)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.dsDocType)).BeginInit();
        // 
        // dsCountry
        // 
        this.dsCountry.DataSetName = "NewDataSet";
        this.dsCountry.Locale = new System.Globalization.CultureInfo("ru-RU");
        // 
        // dsClientCodeType
        // 
        this.dsClientCodeType.DataSetName = "NewDataSet";
        this.dsClientCodeType.Locale = new System.Globalization.CultureInfo("ru-RU");
        // 
        // dsDocType
        // 
        this.dsDocType.DataSetName = "NewDataSet";
        this.dsDocType.Locale = new System.Globalization.CultureInfo("ru-RU");
        //
        // Кнопки
        //
        this.btUpdate.Click += new System.EventHandler(this.btUpdate_Click);
        this.btnClear.Click += new System.EventHandler(this.btnClear_Click);
        // <asp:button>
        this.btContracts.Click += new System.EventHandler(this.btContracts_Click);
        this.btCreateRequest.Click += new System.EventHandler(this.btCreateRequest_Click);
        // <input> 
        this.btSubmit.ServerClick += new System.EventHandler(this.btSubmit_ServerClick);

        ((System.ComponentModel.ISupportInitialize)(this.dsCountry)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.dsClientCodeType)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.dsDocType)).EndInit();

    }
    #endregion

    /// <summary>
    /// Инициализация контролов
    /// </summary>
    /// <param name="reloadINFO">переинициализировать значения или нет</param>
    private void InitControls(bool reloadINFO)
    {
        Deposit dpt;
        if (Request["info"] == null)
            dpt = (Deposit)Session["DepositInfo"];
        else
        {
            dpt = new Deposit();
            dpt.Client.ID = Convert.ToDecimal(Request["rnk"]);
            dpt.Client.ReadFromDatabase();
        }

        if (BankType.GetDptBankType() == BANKTYPE.UPB)
        {
            lbVTerritory.Visible = true;
            btTerritory.Visible = true;
            validatorTextClientTerritory.Enabled = true;
        }

        // Ініціалізація компонетів для роботи згідно ЕБП (Ощадбанк)
        //if (BankType.GetDptBankType() == BANKTYPE.SBER_EBP)
        //{
        //    ScanIdentDocs.RNK = Convert.ToInt64(Request["rnk"]);
        //    EADocsView.RNK = Convert.ToInt64(Request["rnk"]);

        //    // Фото та підпис клієнта
        //    biClietFoto.Visible = true;
        //    biClietFoto.Value = Tools.get_cliet_picture(dpt.Client.ID, "PHOTO");
        //    biClietSign.Visible = true;
        //    biClietSign.Value = Tools.get_cliet_picture(dpt.Client.ID, "SIGN");
        //}


        // некоторые умолчательные значения
        string ourCountryParameter = "KOD_G";
        decimal defaultCodeType = 2;	// код ДРФОУ
        decimal defaultDocType = 1;	    // паспорт

        // Устанавливаем умолчательные значения для этой формы
        // если класс пустой
        if (dpt.Client.CodeType == decimal.MinValue && dpt.Client.DocType == decimal.MinValue)
        {
            dpt.Client.CodeType = defaultCodeType;
            dpt.Client.DocType = defaultDocType;
        }

        OracleConnection connect = new OracleConnection();
        try
        {
            // Создаем соединение
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            if (dpt.Client.CountryCode == decimal.MinValue)
            {
                // Получаем код нашей страны
                OracleCommand cmdSelectOurCountry = new OracleCommand();
                cmdSelectOurCountry.Connection = connect;
                cmdSelectOurCountry.CommandText = "select val from params where par = :b1";
                cmdSelectOurCountry.Parameters.Add("b1", OracleDbType.Varchar2, ourCountryParameter, ParameterDirection.Input);
                dpt.Client.CountryCode = Convert.ToDecimal(Convert.ToString(cmdSelectOurCountry.ExecuteScalar()));
                dpt.Client.Country = "Україна";
            }

            // Заполняем список типов идентификационных кодов
            adapterClientCodeType = new OracleDataAdapter();
            OracleCommand cmdSelectClientCodeType = connect.CreateCommand();
            cmdSelectClientCodeType.CommandText = "select tgr, name from tgr";
            adapterClientCodeType.SelectCommand = cmdSelectClientCodeType;
            adapterClientCodeType.Fill(dsClientCodeType);
            listClientCodeType.DataBind();

            // Заполняем список удостоверяющих документов
            adapterDocType = new OracleDataAdapter();
            OracleCommand cmdSelectDocType = connect.CreateCommand();
            cmdSelectDocType.CommandText = "select passp, name from passp";
            adapterDocType.SelectCommand = cmdSelectDocType;
            adapterDocType.Fill(dsDocType);
            listDocType.DataBind();
            /*
            DataSet dsSex = new DataSet();
            OracleDataAdapter adapterSex = new OracleDataAdapter();
            OracleCommand cmdGetSex = connect.CreateCommand();
            cmdGetSex.CommandText = "select id, name from sex order by id";
            adapterSex.SelectCommand = cmdGetSex;
            adapterSex.Fill(dsSex);
            listSex.DataValueField = "id";
            listSex.DataTextField = "name";
            listSex.DataSource = dsSex;
            listSex.DataBind();
            */
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        try
        {
            InitOraConnection();

            // "Особливі відмітки" клієнта
            #region SPECIAL
            listSpecial.DataSource = SQL_SELECT_dataset("select MARK_CODE, MARK_NAME from CUST_MARK_TYPES order by MARK_CODE");

            listSpecial.DataBind();

            listSpecial.Items.Insert(0, new ListItem("", "-1", true));

            listSpecial.Attributes["onchange"] = "SpecialMark_change(this)";
            #endregion

            #region SEX
            listSex.DataSource = SQL_SELECT_dataset("select ID, NAME from SEX order by ID");

            listSex.DataValueField = "id";

            listSex.DataTextField = "name";

            listSex.DataBind();
            #endregion

        }
        finally
        {
            DisposeOraConnection();
        }

        // Заполняем форму данными из класса
        if (reloadINFO)
            FillControlsFromClass(dpt.Client);
    }

    /// <summary>
    /// Ініціалізація контролів для роботи з ЕАД
    /// </summary>
    private void InitEADControls(Int64 cust_id)
    {
        // РНК для перегляду сканкопій документів
        EADocsView.RNK = cust_id;
        EADocsView.Visible = true;

        // РНК для сканування документів
        ScanIdentDocs.RNK = cust_id;
        ScanIdentDocs.Visible = true;

        // галочка перевірки актуальності документів
        cbDocVerified.Visible = true;
        cbDocVerified.Attributes["onclick"] = "cbDocVerified_CheckedChanged();";

        // переніс на кожен page_load 
        //// Перевірка актуальності ідентифікуючих документів
        //if (Tools.Get_DocumentVerifiedState(cust_id))
        //{
        //    cbDocVerified.Checked = true;
        //    cbDocVerified.Enabled = false;
        //}
        //else
        //{
        //    cbDocVerified.Checked = false;
        //    cbDocVerified.Enabled = true;
        //}
    }

    /// <summary>
    /// Записываем текущие даные на форму
    /// </summary>
    private void FillControlsFromClass(Client client)
    {
        //        Client client = ((Deposit)Session["DepositInfo"]).Client;

        textClientName.Value = client.Name;
        textFIOGenitive.Value = client.NameGenitive;
        textClientFirstName.Value = client.FirstName;
        textClientLastName.Value = client.LastName;
        textClientPatronymic.Value = client.Patronymic;
        textCountry.Value = client.Country;
        textCountryCode.Value = client.CountryCode.ToString();
        ckResident.Checked = client.isResident;
        resid_checked.Value = (ckResident.Checked ? "1" : "0");

        #region Самозайнята особа

        cbSelfEmployer.Checked = client.isSelfEmployer;

        if (client.isSelfEmployer)
        {
            //
            if (client.TaxAgencyCode > 0)
            {
                textTaxAgencyCode.Text = client.TaxAgencyCode.ToString();

                try
                {
                    InitOraConnection();
                    SetParameters("c_reg", DB_TYPE.Decimal, client.TaxAgencyCode, DIRECTION.Input);
                    textTaxAgencyName.Text = Convert.ToString(SQL_SELECT_scalar("select NAME_REG from SPR_OBL where C_REG = :c_reg"));
                }
                finally
                {
                    DisposeOraConnection();
                }
            }

            //
            if (client.RegAgencyCode > 0)
            {
                textRegAgencyCode.Text = client.RegAgencyCode.ToString();

                try
                {
                    InitOraConnection();
                    
                    SetParameters("c_reg", DB_TYPE.Decimal, client.TaxAgencyCode, DIRECTION.Input);
                    SetParameters("c_dst", DB_TYPE.Decimal, client.RegAgencyCode, DIRECTION.Input);

                    textRegAgencyName.Text = Convert.ToString(
                        SQL_SELECT_scalar("select NAME_STI from SPR_REG where C_REG = :c_reg And C_DST = :c_dst"));
                }
                finally
                {
                    DisposeOraConnection();
                }
            }
        }

        #endregion

        if (textCountryCode.Value == "804")
        {
            ckResident.Checked = true;
            resid_checked.Value = (ckResident.Checked ? "1" : "0");
            ckResident.Attributes["disabled"] = "disabled";
        }
        else
        {
            ckResident.Attributes["disabled"] = null;
        }

        // код території або пусто
        textClientTerritory.Text = (client.Territory == Decimal.MinValue ? String.Empty : Convert.ToString(client.Territory));

        textClientIndex.Text = client.Index;

        if (BankType.GetDptBankType() == BANKTYPE.UPB)
        {
            textClientRegion.Text = client.Region;
            textClientDistrict.Text = client.District;
            textClientSettlement.Text = client.Settlement;
            textClientAddress.Text = client.Location;
        }
        else
        {
            textClientRegion.Text = client.Region.TrimStart(Resources.Deposit.GlobalResources.client_region.ToCharArray()).Trim();
            textClientDistrict.Text = client.District.TrimStart(Resources.Deposit.GlobalResources.client_district.ToCharArray()).Trim();
            textClientSettlement.Text = client.Settlement.TrimStart(Resources.Deposit.GlobalResources.client_city.ToCharArray()).Trim();
            //textClientAddress.Text = client.Location.TrimStart(Resources.Deposit.GlobalResources.client_address.ToCharArray()).Trim();

            if (client.Location.IndexOf(' ') > 0)
            {
                preClientAddress.Text = client.Location.Substring(0, client.Location.IndexOf(' ')).Trim(); ;
                textClientAddress.Text = client.Location.Substring(client.Location.IndexOf(' ') + 1).Trim();
            }
            else if (!String.IsNullOrEmpty(client.Location))
            {
                preClientAddress.Text = client.Location.Trim();
            }
        }

        textFactIndex.Text = client.fact_index;
        textFactRegion.Text = client.fact_region;
        textFactDistrict.Text = client.fact_district;
        textFactSettlement.Text = client.fact_settlement;
        textFactAddress.Text = client.fact_location;

        textFactAddressFull.Text = client.fact_index;
        textFactAddressFull.Text = textFactAddressFull.Text.Trim();

        if (client.fact_region != Resources.Deposit.GlobalResources.client_region)
            textFactAddressFull.Text = textFactAddressFull.Text.Trim() + " " + client.fact_region;

        if (client.fact_district != Resources.Deposit.GlobalResources.client_district)
            textFactAddressFull.Text = textFactAddressFull.Text.Trim() + " " + client.fact_district;

        if (client.fact_settlement != Resources.Deposit.GlobalResources.client_city)
            textFactAddressFull.Text = textFactAddressFull.Text.Trim() + " " + client.fact_settlement;

        if (client.fact_location != Resources.Deposit.GlobalResources.client_address)
            textFactAddressFull.Text = textFactAddressFull.Text.Trim() + " " + client.fact_location;

        listClientCodeType.SelectedIndex = listClientCodeType.Items.IndexOf(listClientCodeType.Items.FindByValue(client.CodeType.ToString()));
        textClientCode.Text = client.Code;
        listDocType.SelectedIndex = listDocType.Items.IndexOf(listDocType.Items.FindByValue(client.DocType.ToString()));
        textDocSerial.Text = client.DocSerial;
        textDocNumber.Text = client.DocNumber;
        textDocOrg.Text = client.DocOrg;

        if (client.DocDate == DateTime.MinValue)
            textDocDate.Text = string.Empty;
        else
            textDocDate.Text = client.DocDate.ToString("dd/MM/yyyy");

        if (client.PhotoDate == DateTime.MinValue)
            textPhotoDate.Text = String.Empty;
        else
            textPhotoDate.Text = client.PhotoDate.ToString("dd/MM/yyyy");

        if (client.BirthDate == DateTime.MinValue)
            textBirthDate.Text = string.Empty;
        else
            textBirthDate.Text = client.BirthDate.ToString("dd/MM/yyyy");

        textBirthPlace.Text = client.BirthPlace;
        listSex.SelectedIndex = listSex.Items.IndexOf(listSex.Items.FindByValue(client.Sex.ToString()));

        textHomePhone.Text = client.HomePhone.Substring(Math.Max(0, client.HomePhone.Length - 10));
        textWorkPhone.Text = client.WorkPhone.Substring(Math.Max(0, client.WorkPhone.Length - 10));
        textCellPhone.Text = client.CellPhone.Substring(Math.Max(0, client.CellPhone.Length - 10));

        // Особлива відмітка нестандартного клієнта
        if ((client.SpecialMarks.HasValue) && (listSpecial.Items.FindByValue(Convert.ToString(client.SpecialMarks)) != null))
        {
            listSpecial.SelectedValue = Convert.ToString(client.SpecialMarks.Value);
        }
        else
        {
            listSpecial.SelectedValue = "-1";
        }
    }
    /// <summary>
    /// Сохраняет значения полей формы в классе
    /// </summary>
    private void FillClassFromControls()
    {
        Client client = ((Deposit)Session["DepositInfo"]).Client;

        client.Name = textClientName.Value;
        client.NameGenitive = textFIOGenitive.Value;
        client.FirstName = textClientFirstName.Value;
        client.LastName = textClientLastName.Value;
        client.Patronymic = textClientPatronymic.Value;

        client.isResident = (resid_checked.Value == "1" ? true : false); //ckResident.Checked;

        // Для нерезидента ІПН завжди 9 нулів
        if (client.isResident)
            client.Code = textClientCode.Text;
        else
            client.Code = "000000000";

        // Самозайнята особа
        if (cbSelfEmployer.Checked)
        {
            client.isSelfEmployer = true;
            client.TaxAgencyCode = Convert.ToDecimal(textTaxAgencyCode.Text);
            client.RegAgencyCode = Convert.ToDecimal(textRegAgencyCode.Text);
        }
        else
        {
            client.isSelfEmployer = false;
            client.TaxAgencyCode = -1;
            client.RegAgencyCode = -1;
        }

        // Особлива відмітка нестандартного клієнта
        if (listSpecial.SelectedValue == "-1")
        {
            client.SpecialMarks = null;
        }
        else
        {
            client.SpecialMarks = Convert.ToDecimal(listSpecial.SelectedValue);
        }

        // Адреса
        client.Index = textClientIndex.Text;

        if (BankType.GetDptBankType() == BANKTYPE.UPB)
        {
            client.Region = textClientRegion.Text.Trim();
            client.District = textClientDistrict.Text.Trim();
            client.Settlement = textClientSettlement.Text.Trim();
            client.Location = textClientAddress.Text.Trim();
        }
        else
        {
            client.Region = preClientRegion.Text + " " + textClientRegion.Text;
            client.Region = client.Region.Trim();

            client.District = preClientDistrict.Text + " " + textClientDistrict.Text;
            client.District = client.District.Trim();

            client.Settlement = preClientSettlement.Text + " " + textClientSettlement.Text;
            client.Settlement = client.Settlement.Trim();

            if (String.IsNullOrEmpty(textClientAddress.Text))
            {
                client.Location = String.Empty;
            }
            else
            {
                if (!String.IsNullOrEmpty(hidStreetType.Value))
                {
                    client.Location = hidStreetType.Value + " " + textClientAddress.Text;
                    client.Location = client.Location.Trim();
                }
                else
                {
                    client.Location = preClientAddress.Text + " " + textClientAddress.Text;
                    client.Location = client.Location.Trim();
                }
            }
        }

        // Код території
        if (!String.IsNullOrEmpty(textClientTerritory.Text))
            client.Territory = Convert.ToDecimal(textClientTerritory.Text);

        client.fact_index = textFactIndex.Text.Trim();
        client.fact_region = textFactRegion.Text.Trim();
        client.fact_district = textFactDistrict.Text.Trim();
        client.fact_settlement = textFactSettlement.Text.Trim();
        client.fact_location = textFactAddress.Text.Trim();

        client.DocSerial = textDocSerial.Text;
        client.DocNumber = textDocNumber.Text;
        client.DocOrg = textDocOrg.Text;

        if (!String.IsNullOrEmpty(textDocDate.Text))
        {
            client.DocDate = Convert.ToDateTime(textDocDate.Text, Tools.Cinfo());
        }

        if (!String.IsNullOrEmpty(textPhotoDate.Text))
        {
            client.PhotoDate = Convert.ToDateTime(textPhotoDate.Text, Tools.Cinfo());
        }

        client.BirthPlace = textBirthPlace.Text;

        client.HomePhone = textHomePhone.Text;
        client.WorkPhone = textWorkPhone.Text;
        if (!String.IsNullOrEmpty(textCellPhone.Text))
            client.CellPhone = "+38" + textCellPhone.Text; //Доопрацювання в зв'язку з заявкою по єдиному формату номера мобільного у клієнта в різних АРМ
       
        client.CodeType = Convert.ToDecimal(listClientCodeType.SelectedValue);
        client.textCodeType = listClientCodeType.Items[listClientCodeType.SelectedIndex].Text;
        client.DocType = Convert.ToDecimal(listDocType.SelectedValue);
        client.DocTypeName = listDocType.Items[listDocType.SelectedIndex].Text;
        client.Sex = Convert.ToDecimal(listSex.SelectedValue);
        client.textSex = listSex.Items[listSex.SelectedIndex].Text;

        if (!String.IsNullOrEmpty(textBirthDate.Text))
        {
            client.BirthDate = Convert.ToDateTime(textBirthDate.Text, Tools.Cinfo());
        }

        client.Country = textCountry.Value;
        client.CountryCode = Convert.ToDecimal(textCountryCode.Value);

        client.TruncateAddress();
        client.Address = client.Index + " " + client.Region + " " + client.District + " " + client.Settlement + " " + client.Location;

    }

    /// <summary>
    /// Очищаем всю информацию на форме
    /// </summary>
    private void btnClear_Click(object sender, System.EventArgs e)
    {
        ((Deposit)Session["DepositInfo"]).Clear();
        InitControls(true);
    }

    /// <summary>
    /// Заполнение сесии
    /// </summary>
    private void FillInSession()
    {
        Deposit deposit = new Deposit();
        Session["DepositInfo"] = deposit;
    }

    /// <summary>
    /// Подтверждение заполненой информации 
    /// запись текущей информации в сесию и переход к следующему етапу
    /// (кнопка "ДАЛІ")
    /// </summary>
    private void btSubmit_ServerClick(object sender, System.EventArgs e)
    {
        // Сохраняем параметры клиента
        FillClassFromControls();

        if (Request.QueryString["scheme"] == "DELOITTE")
        {
            Client client = ((Deposit)Session["DepositInfo"]).Client;
            
         
            if (client.ID <= 0)/*при створенні клієнта client.ID = decimal.minvalue, яке не влізе в Int64*/
            {
                client.CheckBeforeWriteToDatabase();//перевірка наявності клієнта за ІНН,Серія та номер паспорту
                if (client.ID > 0)
                {
                    throw new DepositException("За данними параметрами знайдено кліента з РНК" + client.ID.ToString());
                    return;
                }
                else
                {
                    client.WriteToDatabase();

                    ClientAccessRights AccessRights = new ClientAccessRights(Convert.ToInt64(client.ID), 0, false);

                    Session["AccessRights"] = AccessRights;

                    DBLogger.Info(String.Format("Користувач зареєстрував нового клієнта (ІПН = {0}, РНК = {1}) згідно ЕБП.",
                        client.Code, client.ID), "deposit");

                    ClientScript.RegisterStartupScript(this.GetType(), "CreateClient_Done", String.Format("alert('Зареєстровано клієнта (РНК={0})');" +
                        "location.href = '/barsroot/clientproducts/DepositClient.aspx?rnk={1}&scheme=DELOITTE'; ", client.ID, client.ID), true);
                }
            }
            else
            {
                
                client.WriteToDatabase();
                ClientAccessRights AccessRights = new ClientAccessRights(Convert.ToInt64(client.ID), 0, false);

                Session["AccessRights"] = AccessRights;

                DBLogger.Info(String.Format("Клієнт вже існує  (ІПН = {0}, РНК = {1}).",
                    client.Code, client.ID), "deposit");

                ClientScript.RegisterStartupScript(this.GetType(), "CreateClient_Done", String.Format("alert('Клієнт вже існує (РНК={0})');" +
                    "location.href = '/barsroot/clientproducts/DepositClient.aspx?rnk={1}&scheme=DELOITTE'; ", client.ID, client.ID), true);
            }
        }
        else
        {
            DBLogger.Info("Пользователь подтвердил данные о клиенте на странице карточки вкладчика заведения депозитного договора" +
                " и перешёл на следующий этап. ДРФО клиента = " + ((Deposit)Session["DepositInfo"]).Client.Code, "deposit");
            /*
            string location = "/barsroot/deposit/deloitte/DepositContract.aspx";
            string ckurl = "/barsroot/clientproducts/DepositShowClients.aspx";
            string url = string.Empty;

            if (clientChanged() && BankType.GetCurrentBank() != BANKTYPE.UPB)
            {
                //cmd = "<script>if (confirm(\"Данный клиент уже существует!\\nПросмотреть зарегистрированых клиентов?\")) " +
                url = "<script>if (confirm(\"" + Resources.Deposit.GlobalResources.al15 + "\")) " +
                "location.replace(\"" + ckurl + "\");</script>";
            }
            else
            {
                Client client = ((Deposit)Session["DepositInfo"]).Client;
                client.WriteToDatabase();
                url = "<script>location.replace(\"" + location + "\");</script>";
            }

            Response.Write(url);
            Response.Flush();
            */
        }
    }

     /// <summary>
    /// Обновление параметров вкладчика (кнопка Реєструвати)
    /// </summary>
    private void btUpdate_Click(object sender, System.EventArgs e)
    {
        DBLogger.Info("textClientName.Value = " + textClientName.Value, "deposit");
        
        bool OnBeneficiary = false;//кусочек гавнокода для сообщения о регистарции бенефициара при redirect(не ломает логику. true - бенефициар создан новим клиентом)

        FillClassFromControls();
        // Сохраняем параметры клиента
        DBLogger.Info("textClientName.Value = " + textClientName.Value, "deposit");
           
        Client client = ((Deposit)Session["DepositInfo"]).Client;
           
        if (Request.QueryString["scheme"] == "DELOITTE")
        {
            //якщо клієнт - зі знайдених клієнтів
            if ( client.ID > 0 )
            {
                client.WriteToDatabase();
                DBLogger.Info("Користувач оновив інформацію по клієнту №" + client.ID.ToString() +
                " на сторінці \"Картка Клієнта\".", "deposit");
               // OnBeneficiary = true;
                
             }
            //якщо клієнт новий
            else
            {
                client.WriteToDatabase();
                if (Convert.ToString(Session["OnBeneficiary"]) == "YES" || Request["agr_id"] == "12" || Request["agr_id"] == "8")
                {
                    DBLogger.Info("Користувач зареєстрував бенефіціара/спадкоємця/по клієнту №" + client.ID.ToString() +
                   " на сторінці \"Картка Клієнта\".", "deposit");

              
                    OnBeneficiary = true;
                }
                else
                {
                    DBLogger.Info("Користувач зареестрував клієнта №" + client.ID.ToString() +
         " на сторінці \"Картка Клієнта\".", "deposit");
                }
   
            }
            // може тут вставити чистку сесії
            //if (Deposit.InheritedDeal(dpt.ID.ToString()) && (Request["inherit_id"] == null))
            //    throw new DepositException("Дана функція заблокована. По депозитному договору є зареєстровані спадкоємці. Скористайтесь функцією \"Реєстрація свідоцтв про право на спадок\".");
                      
        }
        else
        {
            if (clientChanged())
            {
                DBLogger.Info("Внимание! Пользователь пытается зарегистрировать (обновить) данные о клиенте," +
                    " который уже существует. Введенное ДРФО клиента=" + client.Code, "deposit");

                String addon = String.Empty;

                if (Request["dpt_id"] != null)
                    addon += "&dpt_id=" + Convert.ToString(Request["dpt_id"]);

                if (Request["agr_id"] != null)
                    addon += "&agr_id=" + Convert.ToString(Request["agr_id"]);

                if (Request["template"] != null)
                    addon += "&template=" + Convert.ToString(Request["template"]);

                if (Request["rnk_b"] != null)
                    addon += "&rnk_b=" + Convert.ToString(Request["rnk_b"]);

                if (Request["rnk_tr"] != null)
                    addon += "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);

                if (Request["idtr"] != null)
                    addon += "&idtr=" + Convert.ToString(Request["idtr"]);

                if (Request["inherit"] != null)
                    addon += "&inherit=" + Convert.ToString(Request["inherit"]); ;

                Response.Redirect("DepositShowClients.aspx?update=1" + addon);
              /*  ClientScript.RegisterStartupScript(this.GetType(), "CreateClient_Done", String.Format("alert('Зареєстровано клієнта (РНК={0})');" +
                      "location.href = '/barsroot/clientproducts/DepositClient.aspx?rnk={1}&scheme=DELOITTE'; ", client.ID, client.ID), true);
                */
                return;
            }
        }

        if (Request["agr_id"] != null)
        {
            DBLogger.Info("Request[agr_id]= " + Request["agr_id"], "deposit");
       
            if (Request["dest"] == "print")
            {
                String dest = "/barsroot/deposit/deloitte/DepositAgreementPrint.aspx?"
                    + "dpt_id=" + Request.QueryString["dpt_id"]
                    + "&agr_id=" + Request.QueryString["agr_id"]
                    + "&template=" + Request.QueryString["template"]
                    + "&rnk=" + client.ID.ToString();

                if (Request["idtr"] != null)
                    dest += "&idtr=" + Request.QueryString["idtr"];

                if (Request["rnk_tr"] != null)
                    dest += "&rnk_tr=" + Request.QueryString["rnk_tr"];

                if (Request["scheme"] != null)
                    dest += "&scheme=" + Request.QueryString["scheme"];

                DBLogger.Info(dest, "deposit");
                
                if (OnBeneficiary)
                //    Response.Redirect(dest);
                        ClientScript.RegisterStartupScript(this.GetType(), "CreateClient_Done", String.Format("alert('Зареєстровано клієнта (РНК={0})');" +
                        "location.href = '"+ dest +"'; ", client.ID), true);
                else
                    Response.Redirect(dest);
               
                return;
            }
            else
            {
                if (Request["dpt_id"] == null)
                {
                    if ((Session["OnTrustee"]) == "YES" && Request["agr_id"] == "12")
                    {
                        if (!Tools.card_account_exists(client.ID, null))
                        {
                            string dest = "/barsroot/clientproducts/SelectCardType.aspx?rnk=" + client.ID.ToString();
                            ClientScript.RegisterStartupScript(this.GetType(), "CreateClient_Done", String.Format("alert('В клієнта (РНК={0}) відсутні карткові рахунки для виплати! заведіть картковий рахунок і повторіть реєстрацію знову.');" +
                          "location.href = '" + dest + "'; ", client.ID), true);
                            return;
                        }
                        else
                        {
                            DBLogger.Info("Обрано клієнта для заведення депозиту по довіреності " + client.ID.ToString(), "deposit");
                            Response.Redirect("/barsroot/deposit/deloitte/DepositContract.aspx?scheme=DELOITTE&rnk=" + client.ID.ToString() + "&rnk_tr=" + Request["rnk_tr"]);
                        }
                    }

                    if (OnBeneficiary)
                        //Response.Redirect("/barsroot/deposit/DepositSearch.aspx?action=agreement&extended=0");
                        ClientScript.RegisterStartupScript(this.GetType(), "CreateClient_Done", String.Format("alert('Зареєстровано клієнта (РНК={0})');" +
                        "location.href = '" + "/arsroot/deposit/DepositSearch.aspx?action=agreement&extended=0" + "'; ", client.ID), true);
                    else
                        Response.Redirect("/barsroot/deposit/DepositSearch.aspx?action=agreement&extended=0");
                }
                
                if (Request["template"] == null)
                {
                    if (OnBeneficiary)
                        //Response.Redirect("/barsroot/deposit/DepositSearch.aspx?action=agreement&extended=0");
                        ClientScript.RegisterStartupScript(this.GetType(), "CreateClient_Done", String.Format("alert('Зареєстровано клієнта (РНК={0})');" +
                        "location.href = '" + "/barsroot/deposit/DepositSearch.aspx?action=agreement&extended=0" + "'; ", client.ID), true);
                    else
                        Response.Redirect("/barsroot/deposit/DepositSearch.aspx?action=agreement&extended=0");
                }

                OracleConnection connect = new OracleConnection();

                try
                {
                    IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
                    connect = conn.GetUserConnection();

                    OracleCommand cmd = connect.CreateCommand();
                    cmd.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                    cmd.ExecuteNonQuery();

                    Decimal agr_id = Convert.ToDecimal(Request["agr_id"]);
                    Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);

                    String dest = "/barsroot/deposit/deloitte/DepositAgreementPrint.aspx?" +
                        "dpt_id=" + Convert.ToString(dpt_id) +
                        "&agr_id=" + Convert.ToString(agr_id) +
                        "&template=" + Convert.ToString(Request["template"]) +
                        "&rnk=" + Convert.ToString(client.ID);

                    if (Request["idtr"] != null)
                        dest += "&idtr=" + Request.QueryString["idtr"];

                    if (Request["rnk_tr"] != null)
                        dest += "&rnk_tr=" + Request.QueryString["rnk_tr"];

                    if (Request["scheme"] != null)
                        dest += "&scheme=" + Request.QueryString["scheme"];

                    /// Комісія за додаткову угоду
                    #region commision

                    String TT = String.Empty;

                    /// Код операції для утримання комісії
                    if (String.IsNullOrEmpty(Convert.ToString(Session["NO_COMISSION"])))
                    {
                        cmd.Parameters.Clear();
                        cmd.CommandText = "select nvl(main_tt,'') from dpt_vidd_flags where id=:agr_id";
                        cmd.Parameters.Add("agr_id", OracleDbType.Decimal, Convert.ToDecimal(agr_id), ParameterDirection.Input);

                        TT = Convert.ToString(cmd.ExecuteScalar());
                    }

                    /// Утримання комісії
                    if (TT != String.Empty)
                    {
                        DBLogger.Info("За оформление доп. соглашения тип=" + Convert.ToString(agr_id) +
                            " по депозитному договору №" + dpt_id.ToString() +
                            " была взята коммиссия. Код операции " + TT,
                            "deposit");

                        cmd.Parameters.Clear();
                        cmd.CommandText = "select s.nls, s.kv from DPT_DEPOSIT d, ACCOUNTS s where d.deposit_id = :dpt_id and d.acc = s.acc";
                        cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, Convert.ToString(dpt_id), ParameterDirection.Input);

                        OracleDataReader rdr = cmd.ExecuteReader();

                        if (!rdr.Read())
                            throw new DepositException("Депозитний договір №" + Convert.ToString(dpt_id) + " не знайдено!");

                        String nls = Convert.ToString(rdr.GetOracleString(0).Value);
                        Decimal kv = Convert.ToDecimal(rdr.GetOracleDecimal(1).Value);

                        if (!rdr.IsClosed)
                            rdr.Close();

                        Client cl;

                        if (Request["rnk_tr"] != null)
                        {
                            cl = new Client();
                            cl.ID = Convert.ToDecimal(Convert.ToString(Request["rnk_tr"]));
                            cl.ReadFromDatabase();
                        }
                        else
                        {
                            Deposit dpt_dop = new Deposit(dpt_id);
                            cl = dpt_dop.Client;
                        }

                        Random r = new Random();
                        String dop_rec = "&RNK=" + Convert.ToString(cl.ID) +
                            "&Code=" + Convert.ToString(r.Next());

                        string url = "\"/barsroot/DocInput/DocInput.aspx?tt=" + TT + "&nd=" +
                            Convert.ToString(dpt_id) + dop_rec + "&SumC_t=1&APROC=" +
                            OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                            "@" + "begin dpt_web.fill_dpt_payments(" + dpt_id + ",:REF);end;" +
                            "\"";

                        string script = "<script>" + String.Format("alert('Зареєстровано клієнта (РНК={0})');", client.ID) + " window.showModalDialog(encodeURI(" + url + "),null," +
                            "'dialogWidth:700px; dialogHeight:800px; center:yes; status:no');";

                        script += "location.replace('" + dest + "');";

                        script += "</script>";

                        if (OnBeneficiary)
                        {
                   
                            Response.Write(script);
                            Response.Flush();
                        }
                        else
                        {
                            Response.Write(script);
                            Response.Flush();
                        }
                    }
                    else
                    {
                        String script = "<script>" + String.Format("alert('Зареєстровано клієнта (РНК={0})');",client.ID) + " location.replace('" + dest + "');" ;
                        script += "</script>";
                        if (OnBeneficiary)
                        {
                 
                            Response.Write(script);
                            Response.Flush();
                        }
                        else
                        {
                            Response.Write(script);
                            Response.Flush();
                        }
                    }
                    #endregion
                }
                finally
                {
                    if (connect.State != ConnectionState.Closed)
                    { connect.Close(); connect.Dispose(); }
                }
            }
        }
        else
        {
            String s_str = "<script>window.alert(\"" + Resources.Deposit.GlobalResources.al16 + "\");</script>";

            if (Request["inherit"] != null)
                s_str += "<script>var res = new Array(); res[0] = " + client.ID + "; " +
                "res[1] = '" + client.Name + "'; " +
                "window.returnValue = res; window.close(); </script>";

            Response.Write(s_str);
            //Response.Write("<script>alert(\"Изменения были успешно внесены!\");</script>");
            Response.Flush();
        }
    }

    /// <summary>
    /// Попередне збереження змін в реквізитах клієнта для друку
    /// </summary>
    protected void eadPrintChange_BeforePrint(object sender, System.EventArgs e)
    {
        Client client = ((Deposit)Session["DepositInfo"]).Client;

        // чистим таблицю 
        Tools.save_changes_customer_params(client.ID);

        // ПІБ
        if (!String.IsNullOrEmpty(textClientName.Value) && client.Name != textClientName.Value)
            Tools.pre_save_customer_changes(client.ID, "NAME_FULL", textClientLastName.Value + " " + textClientFirstName.Value + " " + textClientPatronymic.Value, client.Name);

        // Д.Н.
        if (client.BirthDate.ToString("dd/MM/yyyy") != textBirthDate.Text)
            Tools.pre_save_customer_changes(client.ID, "BIRTH_DATE", textBirthDate.Text, client.BirthDate.ToString("dd/MM/yyyy"));

        // Ідентифікаційний код
        if (client.Code != textClientCode.Text)
            Tools.pre_save_customer_changes(client.ID, "CUST_CODE", textClientCode.Text, client.Code);

        // тип документу (назва)
        if (client.DocTypeName != listDocType.Items[listDocType.SelectedIndex].Text)
            Tools.pre_save_customer_changes(client.ID, "DOC_TYPE", listDocType.Items[listDocType.SelectedIndex].Text, client.DocTypeName);

        // серія документу 
        // !String.IsNullOrEmpty(textDocSerial.Text) &&
        if (client.DocSerial != textDocSerial.Text)
            Tools.pre_save_customer_changes(client.ID, "DOC_SERIAL", textDocSerial.Text, client.DocSerial);

        // номер документу
        if (client.DocNumber != textDocNumber.Text)
            Tools.pre_save_customer_changes(client.ID, "DOC_NUMBER", textDocNumber.Text, client.DocNumber);

        // Орган що видав документ
        if (client.DocOrg != textDocOrg.Text)
            Tools.pre_save_customer_changes(client.ID, "DOC_ORGAN", textDocOrg.Text, client.DocOrg);

        // Дата видачі документу
        if (client.DocDate.ToString("dd/MM/yyyy") != textDocDate.Text)
            Tools.pre_save_customer_changes(client.ID, "DOC_DATE", textDocDate.Text, client.DocDate.ToString("dd/MM/yyyy"));

        // Дата вклеювання ост.фото в паспорт
        if (client.PhotoDate.ToString("dd/MM/yyyy") != textPhotoDate.Text)
            Tools.pre_save_customer_changes(client.ID, "PHOTO_DATE", textPhotoDate.Text, client.PhotoDate.ToString("dd/MM/yyyy"));

        // Домашній телефон
        if (!String.IsNullOrEmpty(textHomePhone.Text) && client.HomePhone != textHomePhone.Text)
            Tools.pre_save_customer_changes(client.ID, "HOME_PHONE", textHomePhone.Text, client.HomePhone);

        // Робочий телефон
        if (!String.IsNullOrEmpty(textWorkPhone.Text) && client.WorkPhone != textWorkPhone.Text)
            Tools.pre_save_customer_changes(client.ID, "WORK_PHONE", textWorkPhone.Text, client.WorkPhone);

        //DBLogger.Info("textCellPhone.Text = " + textCellPhone.Text + "client.CellPhone = " + client.CellPhone, "deposit");

        // Мобільний телефон
        if (!String.IsNullOrEmpty(textCellPhone.Text) && client.CellPhone != "+38" + textCellPhone.Text)
            Tools.pre_save_customer_changes(client.ID, "CELL_PHONE", "+38" + textCellPhone.Text, client.CellPhone);

        // Країна (назва)
        if (client.Country != textCountry.Value)
            Tools.pre_save_customer_changes(client.ID, "COUNTRY", textCountry.Value, client.Country);

        String AddressOld;
        String AddressNew;

        // Повна адреса реєстрації (юридична)
        AddressOld = GetFullAddress(client.Index, client.Region, client.District, client.Settlement, client.Location);
        AddressNew = GetFullAddress(textClientIndex.Text, textClientRegion.Text, textClientDistrict.Text, textClientSettlement.Text, textClientAddress.Text,
            preClientRegion.Text, preClientDistrict.Text, preClientSettlement.Text, preClientAddress.Text);

        if (AddressOld != AddressNew)
            Tools.pre_save_customer_changes(client.ID, "ADDRESS_U", AddressNew, AddressOld);
        
        // Повна адреса проживання (фактична)
       /* AddressOld = GetFullAddress(client.fact_index, client.fact_region, client.fact_district, client.fact_settlement, client.fact_location);
        AddressNew = GetFullAddress(textFactIndex.Text, textFactRegion.Text, textFactDistrict.Text, textFactSettlement.Text, textFactAddress.Text);

        if (AddressOld != AddressNew)
            Tools.pre_save_customer_changes(client.ID, "ADDRESS_F", AddressNew, AddressOld);*/
    }

    /// <summary>
    /// Збереження змін реквізитів клієнта
    /// </summary>
    protected void eadPrintChange_DocSigned(object sender, System.EventArgs e)
    {
        DBLogger.Info("Користувач поставив відмітку про наявність підпису клієнта (rnk=" + Request.QueryString["rnk"] +
             ") на заяві про зміну реквізитів", "deposit");

        Client client = ((Deposit)Session["DepositInfo"]).Client;

        string t_OldPhoneNumber = client.CellPhone;//тимчасова змінна для відправки смс на старий та новий номер
        DBLogger.Info("t_OldPhoneNumber =" + t_OldPhoneNumber, "deposit");

            // Зміна номеру моб.тел.
        if (client.CellPhone != "+38" + textCellPhone.Text)
        {
            // SMS-повідомлення на «старий» номер 
            Tools.Send_SMS(client.ID, "Shanovnyy kliente, za Vashym zapytom, Vam vidkliucheno poslugu SMS-banking po depozytam na nomer " + client.CellPhone + ".");
     
            // SMS-повідомлення на «новий» номер перенесене після збереження данних в базу
     //       Tools.Send_SMS(client.ID, "Shanovnyy kliente, za Vashym zapytom, Vam pidkliucheno poslugu SMS-banking po depozytam na nomer " + textCellPhone.Text + ".");
        }

        FillClassFromControls();
     
        client = ((Deposit)Session["DepositInfo"]).Client;

        if (String.IsNullOrEmpty(client.Name) && String.IsNullOrEmpty(client.Code) &&
            String.IsNullOrEmpty(client.Address) && String.IsNullOrEmpty(client.DocNumber))
        {
            DBLogger.Info("Користувач намагався обнулити картку клієнта (rnk=" + Request.QueryString["rnk"] + ").", "deposit");

            return;
        }
        else
        {
            client.WriteToDatabase();
            // Зміна якщо була зміна номеру моб.тел.
            //ID-3257 - запрет на отправку           
            //if (client.CellPhone != t_OldPhoneNumber)
	    //{
               
                // SMS-повідомлення на «новий» номер перенесене після збереження данних в базу
	
                // Tools.Send_SMS(client.ID, "Shanovnyy kliente, za Vashym zapytom, Vam pidkliucheno poslugu SMS-banking po depozytam na nomer " + client.CellPhone + ".");
	    //}


        }

        ScanIdentDocs.Visible = true;
        // eadPrintChange.Visible = false;
        eadPrintChange.Enabled = false;

        Edited.Value = "0";

        //ClientScript.RegisterStartupScript(this.GetType(), "EditClient_Done", 
        //    String.Format("alert('Зміни в реквізитах клієнта збережені!'); " +
        //    "location.href = '/barsroot/clientproducts/DepositClient.aspx?rnk={0}&scheme=DELOITTE'; ", client.ID), true);

        //ClientScript.RegisterStartupScript(this.GetType(), "EditClient_Done",
        //    "alert('Зміни в реквізитах клієнта збережені!'); __doPostBack('',''); ", true);

        ClientScript.RegisterStartupScript(this.GetType(), "EditClient_Done",
            "alert('Зміни в реквізитах клієнта збережені!'); f_DisableEditCliet(); ", true);
    }

        protected void eadFinmonQuestionnaire_BeforePrint_(object sender, EventArgs e)
        {
            // Опитувальний лист фінмоніторингу
            Client client = ((Deposit)Session["DepositInfo"]).Client;
            client = ((Deposit)Session["DepositInfo"]).Client;
            FillControlsFromClass(client);
            FillClassFromControls();
            
            eadFinmonQuestionnaire_.RNK = Convert.ToInt64(Request.QueryString["rnk"]);
            
            FillControlsFromClass(client);
            FillClassFromControls();
        }
     protected void eadFinmonQuestionnaire_DocSigned_(object sender, EventArgs e)
        {         
            Client client = ((Deposit)Session["DepositInfo"]).Client;
            client = ((Deposit)Session["DepositInfo"]).Client;
            FillControlsFromClass(client);
            FillClassFromControls();
        }
       
    /// <summary>
    /// "Портфель договорів" клієнта
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btContracts_Click(object sender, EventArgs e)
    {
        DBLogger.Info("Користувач натиснув кнопку \"Портфель договорів\" на сторінці Картка клієнта.", "deposit");

        Response.Redirect("/barsroot/clientproducts/DptClientPortfolioContracts.aspx?cust_id=" + Request.QueryString["rnk"]);
    }

    /// <summary>
    /// Запит на БЕК-офіс
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btCreateRequest_Click(object sender, EventArgs e)
    {
        DBLogger.Info("Користувач натиснув кнопку \"Запит на БЕК-офіс\" на сторінці Картка клієнта.", "deposit");

        Response.Redirect("/barsroot/deposit/deloitte/DptRequestCreate.aspx?cust_id=" +
            Request.QueryString["rnk"] + "&cust_name=" + (Session["DepositInfo"] as Deposit).Client.Name);
    }

    // Після успішного завершення сканування ідент.документів
    protected void ScanIdentDocs_ScanIdDocsDone(object sender, System.EventArgs e)
    {
        Decimal cust_id = Convert.ToDecimal(ScanIdentDocs.RNK);

        biClietFoto.Value = Tools.get_cliet_picture(cust_id, "PHOTO");
        biClietSign.Value = Tools.get_cliet_picture(cust_id, "SIGN");

        Tools.Set_DocumentVerifiedState(cust_id);
        cbDocVerified.Checked = true;
        // cbDocVerified.Enabled = true;

        EADocsView.Visible = true;

        DBLogger.Info("Користувач завершив сканування ідентифікуючих документів клієнта з РНК = " + cust_id.ToString(), "deposit");

        if (Request.QueryString["scheme"] == "DELOITTE")
        {
            Client client = ((Deposit)Session["DepositInfo"]).Client;

            ClientAccessRights AccessRights = new ClientAccessRights(Convert.ToInt64(client.ID), 0, false);

            Session["AccessRights"] = AccessRights;

            ClientScript.RegisterStartupScript(this.GetType(), "ScanIdDocs_Done", String.Format("location.href = 'DepositClient.aspx?rnk={0}&scheme=DELOITTE'; ", client.ID), true);
        }
    }

    /// <summary>
    /// Проверка на изменение реквизитов клиента
    /// </summary>
    /// <returns>Изменились ли реквизиты</returns>
    private bool clientChanged()
    {
        Deposit dpt = (Deposit)Session["DepositInfo"];

        if ((dpt.Client.Code != Client.DefaultOKPO()) && (dpt.Client.Code != Client.NonResidentOKPO()))
        {
            OracleConnection connect = new OracleConnection();

            DBLogger.Debug("Перевірка існування контрагента на сторінці \"Картка клієнта\". ІПН=" +
                dpt.Client.Code, "deposit");

            try
            {
                // Создаем соединение
                IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();
                // Открываем соединение с БД


                // Установка роли
                OracleCommand cmdSetRole = new OracleCommand();
                cmdSetRole.Connection = connect;
                cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdGetOkpo = new OracleCommand();
                cmdGetOkpo.Connection = connect;
                cmdGetOkpo.CommandText = "select rnk from v_dpt_customer where okpo=:okpo";
                cmdGetOkpo.Parameters.Add("okpo", OracleDbType.Varchar2, dpt.Client.Code, ParameterDirection.Input);

                OracleDataReader rdr = cmdGetOkpo.ExecuteReader();

                if (!rdr.Read())
                {
                    rdr.Close();
                    return false;
                }

                Client curClient = new Client(Convert.ToDecimal(rdr.GetOracleDecimal(0).Value));

                if (!rdr.IsClosed)
                    rdr.Close();

                if (curClient == dpt.Client)
                    return false;

                return true;
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }
        return false;
    }

    /// <summary>
    /// Виключити валідатори
    /// </summary>
    private void disableValidators()
    {
        validatorClientSettlement.Enabled = false;
        validatorClientCodeEx.Enabled = false;
        validatorDocNumber.Enabled = false;
        validatorDocOrg.Enabled = false;
        validatorDocDate.Enabled = false;
        validatorTextFioGenitive.Enabled = false;
        validatorAddressFull.Enabled = false;
        validatorTextClientTerritory.Enabled = false;
        validatorPhotoDate.Enabled = false;
        validatorPhones.Enabled = false;

        lbVClientCode.Visible = false;
        lbVCodeType.Visible = false;
        lbVCountry.Visible = false;
        lbVDocType.Visible = false;
        lbVDocNumber.Visible = false;
        lbVDocOrg.Visible = false;
        lbVDocDate.Visible = false;
        lbVPhotoDate.Visible = false;
        lbVSettlement.Visible = false;
        lbFIOGenitiveReq.Visible = false;
        lbVTerritory.Visible = false;
        lbVPhotoDate.Visible = false;

        // телефони
        lbVCellPhone.Visible = false;
        lbVHomePhone.Visible = false;
        lbVWorkPhone.Visible = false;
    }

    /// <summary>
    /// Отримання ПІБ у родовому відмінку
    /// </summary>
    /// <param name="FirstName">Імя</param>
    /// <param name="LastName">Прізвище</param>
    /// <param name="Patronymic">По батькові</param>
    /// <param name="sex">Стать: 1 - чоловіча стать; 2 - жіноча</param>
    /// <returns>ПІБ у родовому відмінку</returns>
    [WebMethod(EnableSession = true)]
    public static String GetNameGenitive(String FirstName, String LastName, String Patronymic, String sex)
    {
        /// Якщо прийшли порожні дані - повертаємо порожню стрічку
        if (String.IsNullOrEmpty(FirstName) && String.IsNullOrEmpty(LastName) && String.IsNullOrEmpty(Patronymic))
            return String.Empty;

        OracleConnection connect = new OracleConnection();
        Decimal dsex = Convert.ToDecimal(sex);
        dsex = 2 - dsex;

        DBLogger.Info("sex=" + sex + ",dsex=" + dsex.ToString() + ".", "deposit");

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();


            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"select f_getNameInGenitiveCase (:LN, 1, :sex, 'U') || ' ' || 
	                                   f_getNameInGenitiveCase (:FN, 2, :sex, 'U') || ' ' ||
                                       f_getNameInGenitiveCase (:PN, 3, :sex, 'U')  from dual";
            cmd.Parameters.Add("LN", OracleDbType.Varchar2, LastName, ParameterDirection.Input);
            cmd.Parameters.Add("sex", OracleDbType.Decimal, dsex, ParameterDirection.Input);
            cmd.Parameters.Add("FN", OracleDbType.Varchar2, FirstName, ParameterDirection.Input);
            cmd.Parameters.Add("sex", OracleDbType.Decimal, dsex, ParameterDirection.Input);
            cmd.Parameters.Add("PN", OracleDbType.Varchar2, Patronymic, ParameterDirection.Input);
            cmd.Parameters.Add("sex", OracleDbType.Decimal, dsex, ParameterDirection.Input);

            String result = Convert.ToString(cmd.ExecuteScalar());
            return result.ToUpper();
        }
        catch (Exception ex)
        {
            Deposit.SaveException(ex);
            throw ex;
        }
        finally
        {

            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }

    /// <summary>
    /// Збереження відмітки про перевірку реквізитів ідентифікуючого документу клієнта
    /// </summary>
    [WebMethod(EnableSession = true)]
    public static void DocumentVerified()
    {
        Decimal cust_id = (HttpContext.Current.Session["DepositInfo"] as Deposit).Client.ID;

        Tools.Set_DocumentVerifiedState(cust_id);

        // (HttpContext.Current.Session["AccessRights"] as ClientAccessRights).DocumetVerified = true;

        DBLogger.Info("Користувач встановив відмітку про перевірку реквізитів ідентифікуючого документу клієнта з РНК=" +
                Convert.ToString(cust_id), "deposit");
    }

    /// <summary>
    /// 
    /// </summary>
    /// <returns>true - якщо повний доступ</returns>
    [WebMethod(EnableSession = true)]
    public static bool FullAccess()
    {
        Decimal cust_id = (HttpContext.Current.Session["DepositInfo"] as Deposit).Client.ID;

        if ((ClientAccessRights.Get_AccessLevel(Convert.ToInt64(cust_id)) == LevelState.Complete) ||
            (DepositRequest.HasActive(cust_id, null)))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void EADocsView_DocsViewed(object sender, EventArgs e)
    {
        if (!cbDocVerified.Checked)
        {
            cbDocVerified.Enabled = true;
        }
    }

    /// <summary>
    /// ф-я Повертає повний адрес клієнта
    /// </summary>
    /// <param name="Index"></param>
    /// <param name="Region"></param>
    /// <param name="District"></param>
    /// <param name="Settlement"></param>
    /// <param name="Address"></param>
    /// <returns></returns>
    protected String GetFullAddress(String Index, String Region, String District, String Settlement, String Address)
    {
        return GetFullAddress(Index, Region, District, Settlement, Address, String.Empty, String.Empty, String.Empty, String.Empty);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Index">Індекс</param>
    /// <param name="Region">Назва областы</param>
    /// <param name="District">Назва району</param>
    /// <param name="Settlement">Назва населеного пункту</param>
    /// <param name="Address">Нава вулиці, номер будинку та квартири</param>
    /// <param name="preRegion">обл.</param>
    /// <param name="preDistrict">р-н</param>
    /// <param name="preSettlement">Тип населеного пункту</param>
    /// <param name="preAddress">Тип вулиці</param>
    /// <returns></returns>
    protected String GetFullAddress(String Index, String Region, String District, String Settlement, String Address,
        String preRegion, String preDistrict, String preSettlement, String preAddress)
    {
        String AddressFull = String.Empty;

        if (!String.IsNullOrEmpty(Index))
            AddressFull = AddressFull + Index;

        if (!String.IsNullOrEmpty(Region) && !String.IsNullOrEmpty(AddressFull))
        {
            if (String.IsNullOrEmpty(preRegion))
                AddressFull = AddressFull + ", " + Region.Trim();
            else
                AddressFull = AddressFull + ", " + preRegion + " " + Region.Trim();
        }

        if (!String.IsNullOrEmpty(District) && !String.IsNullOrEmpty(AddressFull))
        {
            if (String.IsNullOrEmpty(preDistrict))
                AddressFull = AddressFull + ", " + District.Trim();
            else
                AddressFull = AddressFull + ", " + preDistrict + " " + District.Trim();
        }

        if (!String.IsNullOrEmpty(Settlement) && !String.IsNullOrEmpty(AddressFull))
        {
            if (String.IsNullOrEmpty(preSettlement))
                AddressFull = AddressFull + ", " + Settlement.Trim();
            else
                AddressFull = AddressFull + ", " + preSettlement + " " + Settlement.Trim();
        }

        if (!String.IsNullOrEmpty(Address) && !String.IsNullOrEmpty(AddressFull))
        {
            if (String.IsNullOrEmpty(preAddress))
                AddressFull = AddressFull + ", " + Address.Trim();
            else
                AddressFull = AddressFull + ", " + preAddress + " " + Address.Trim();
        }

        return AddressFull;
    }
}
