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
            /// Заповняємо для порівняння при переході далі
            //hidRegion.Value = Resources.Deposit.GlobalResources.client_region;
            //hidDistrict.Value = Resources.Deposit.GlobalResources.client_district;
            //hidAddress.Value = Resources.Deposit.GlobalResources.client_address;
            //hidSettlement.Value = Resources.Deposit.GlobalResources.client_city;

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
                    //btnClear_Click(sender, e);
                    ((Deposit)Session["DepositInfo"]).Clear();
                    btSubmit.Visible = false;
                    btUpdate.Visible = true;
                    switch (Convert.ToInt32(Convert.ToString(Request["agr_id"])))
                    {
                        case 5:
                            {
                                //lbInfo.Text = "Регистрация клиента (бенефициара)";
                                Value = Resources.Deposit.GlobalResources.reg1;
                                if (Request["dest"] != "print")
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
                    }
                }

                lbInfo.Text = Value;

                if (Request["rnk"] != null)
                {
                    Client client = ((Deposit)Session["DepositInfo"]).Client;
                    client.ID = Convert.ToDecimal(Request["rnk"]);

                    client.ReadFromDatabase();
                }

                /*
                if (BankType.GetCurrentBank() == BANKTYPE.UPB)
                {
                    btSearch.Visible = false;

                    if (Request["customer"] == null && Request["rnk"] != null)
                    {
                        btSubmit_ServerClick(sender, e);
                        return;
                    }
                }
                */
            }
            else
            {
                foreach (Control ctrl in DepositFormMain.Controls)
                {
                    if (ctrl is TextBox)
                        ((TextBox)ctrl).Enabled = false;
                    else if (ctrl is DropDownList)
                        ((DropDownList)ctrl).Enabled = false;
                    else if (ctrl is HtmlInputText)
                        ((HtmlInputText)ctrl).Disabled = true;
                    else if (ctrl is HtmlInputCheckBox)
                        ((HtmlInputCheckBox)ctrl).Disabled = true;
                    else if (ctrl is Button)
                        ((Button)ctrl).Enabled = false;
                    else if (ctrl is Infragistics.WebUI.WebDataInput.WebDateTimeEdit)
                        ((Infragistics.WebUI.WebDataInput.WebDateTimeEdit)ctrl).Enabled = false;

                    if (ctrl is HtmlInputButton)
                        ((HtmlInputButton)ctrl).Disabled = true;
                }

                btSubmit.Visible = false;
                btSearch.Visible = false;
                btnClear.Visible = false;
                btUpdate.Visible = false;
            }

            InitControls(true);
            if (Tools.Get_CellPhoneVerifiedState(((Deposit)Session["DepositInfo"]).Client.ID))
            {
               LCellphone2.Visible = false;
            }
            else
            {
               LCellphone2.Visible = true;
            }   
        }
        else
        {
            Client client = ((Deposit)Session["DepositInfo"]).Client;

            if (fRNK.Value != string.Empty && fRNK.Value != "undefined" && fRNK.Value != "-1")
            {
                DBLogger.Info("Пользователь получил информацию из страницы SearchResults = ",
                    "deposit");
                DBLogger.Info("Пользователь получил информацию из страницы SearchResults. agr_id = " + Convert.ToString(Request["agr_id"]),
                    "deposit");

                client.ID = Convert.ToDecimal(fRNK.Value);
                client.ReadFromDatabase();

                InitControls(true);

                fRNK.Value = string.Empty;
            }
        }
    }
    /// <summary>
    /// Локализация
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        base.OnPreRender(evt);

        // Локализируем infra
        dtDocDate.ToolTip = Resources.Deposit.GlobalResources.tb15;
        dtBirthDate.ToolTip = Resources.Deposit.GlobalResources.tb16;
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
        this.btUpdate.Click += new System.EventHandler(this.btUpdate_Click);
        this.btnClear.Click += new System.EventHandler(this.btnClear_Click);
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
            // lbClientTerritory.Visible = true;
            // textClientTerritory.Visible = true;
            btTerritory.Visible = true;
            validatorTextClientTerritory.Enabled = true;
        }   

        // некоторые умолчательные значения
        string ourCountryParameter = "KOD_G";
        decimal defaultCodeType = 2;	// код ДРФОУ
        decimal defaultDocType = 1;	// паспорт

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
            // Открываем соединение с БД
            

            // Установка роли
            OracleCommand cmdSetRole = new OracleCommand();
            cmdSetRole.Connection = connect;
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

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

            // Заполняем форму данными из класса
            if (reloadINFO)
                FillControlsFromClass(dpt.Client);         
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
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

        if (textCountryCode.Value == "804")
        {
            ckResident.Checked = true;
            ckResident.Disabled = true;
            resid_checked.Value = (ckResident.Checked ? "1" : "0");
        }
        else
        {
            ckResident.Disabled = false;
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
            dtDocDate.Value = string.Empty;
        else
            dtDocDate.Date = client.DocDate;


        if (client.BirthDate == DateTime.MinValue)
            dtBirthDate.Value = string.Empty;
        else
            dtBirthDate.Date = client.BirthDate;

        textBirthPlace.Text = client.BirthPlace;        
        listSex.SelectedIndex = listSex.Items.IndexOf(listSex.Items.FindByValue(client.Sex.ToString()));

        textCellPhone.Text = client.CellPhone.Substring(Math.Max(0, client.CellPhone.Length - 10));
        textHomePhone.Text = client.HomePhone;
        textWorkPhone.Text = client.WorkPhone;

        // Перевірка актуальності мобільного телефону 

        if (Tools.Get_CellPhoneVerifiedState(client.ID))
        {
           LCellphone2.Visible = false;
        }
        else
        {            
            LCellphone2.Visible = true;
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

        client.Code = textClientCode.Text;
        client.isResident = (resid_checked.Value == "1" ? true : false); //ckResident.Checked;        
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
        client.DocDate = dtDocDate.Date;
        
        client.BirthDate = dtBirthDate.Date;
        
        client.Country = textCountry.Value;
        client.CountryCode = Convert.ToDecimal(textCountryCode.Value);

        client.TruncateAddress();
        client.Address = client.Index + " " + client.Region + " " + client.District + " " + client.Settlement + " " + client.Location;

    }
    /// <summary>
    /// Обновление параметров вкладчика
    /// </summary>
    private void btUpdate_Click(object sender, System.EventArgs e)
    {
        // Сохраняем параметры клиента
        FillClassFromControls();

        OracleConnection connect = new OracleConnection();

        try
        {
            Client client = ((Deposit)Session["DepositInfo"]).Client;

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

                return;
            }

            client.WriteToDatabase();

            DBLogger.Info("Пользователь обновил данные о клиенте №" + client.ID.ToString() + " на странице карточки вкладчика",
                "deposit");

            if (Request["agr_id"] != null)
            {
                if (Request["dest"] == "print")
                {
                    String dest = "DepositAgreementPrint.aspx?"
                        + "dpt_id=" + Convert.ToString(Request["dpt_id"])
                        + "&agr_id=" + Convert.ToString(Request["agr_id"])
                        + "&template=" + Convert.ToString(Request["template"])
                        + "&rnk=" + Convert.ToString(Request["rnk_b"]); ;
                    if (Request["idtr"] != null)
                        dest += "&idtr=" + Convert.ToString(Request["idtr"]);
                    if (Request["rnk_tr"] != null)
                        dest += "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);

                    Response.Redirect(dest);

                    return;
                }
                else
                {
                    if (Request["dpt_id"] == null)
                        Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");
                    if (Request["template"] == null)
                        Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

                    IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
                    connect = conn.GetUserConnection();
                    

                    OracleCommand cmd = connect.CreateCommand();
                    cmd.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                    cmd.ExecuteNonQuery();

                    Decimal agr_id = Convert.ToDecimal(Request["agr_id"]);
                    Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);
                    String typ_tr = String.Empty;
                    String typ = String.Empty;

                    if (agr_id == 5) { typ_tr = "B"; typ = "бенефециаром"; }
                    else if (agr_id == 8) { typ_tr = "H"; typ = "наследником"; }
                    else if (agr_id == 12) { typ_tr = "T"; typ = "довереным лицом"; }

                    /// Дебільна доробка зроблена по ЕКСКЛЮЗИВНОМУ проханню ПРАВЕКСУ
                    //if (typ_tr != String.Empty)
                    //{
                    //    OracleCommand ckPerson = connect.CreateCommand();
                    //    ckPerson.CommandText = "select id from dpt_trustee where rnk_tr=:rnk and dpt_id = :dpt_id and fl_act=1 and typ_tr=:typ_tr and undo_id is null ";
                    //    ckPerson.Parameters.Add("rnk", OracleDbType.Decimal, client.ID, ParameterDirection.Input);
                    //    ckPerson.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                    //    ckPerson.Parameters.Add("typ_tr", OracleDbType.Varchar2, typ_tr, ParameterDirection.Input);
                    //    String result = Convert.ToString(ckPerson.ExecuteScalar());
                    //    if (result != String.Empty)
                    //        throw new DepositException("Даний клієнт уже є існуючим " + typ + " по даному депозитному договору!");
                    //}

                    String dest = "DepositAgreementPrint.aspx?dpt_id="
                        + Convert.ToString(dpt_id) + "&agr_id=" + Convert.ToString(agr_id) +
                        "&template=" + Convert.ToString(Request["template"]) +
                        "&rnk=" + Convert.ToString(client.ID);
                    if (Request["idtr"] != null)
                        dest += "&idtr=" + Convert.ToString(Request["idtr"]);
                    if (Request["rnk_tr"] != null)
                        dest += "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);

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
                        cmd.CommandText = "select s.nls, s.kv from dpt_deposit d, saldo s where d.deposit_id = :dpt_id and d.acc = s.acc";
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

                        string script = "<script>window.showModalDialog(encodeURI(" + url + "),null," +
                            "'dialogWidth:700px; dialogHeight:800px; center:yes; status:no');";

                        script += "location.replace('" + dest + "');";

                        script += "</script>";
                        Response.Write(script);
                        Response.Flush();
                    }
                    else
                    {
                        String script = "<script>location.replace('" + dest + "');";
                        script += "</script>";
                        Response.Write(script);
                        Response.Flush();
                    }
                    #endregion
                }
            }
            else
            {
                String s_str = "<script>window.alert(\"" +
                    Resources.Deposit.GlobalResources.al16 +
                    "\");</script>";

                if (Request["inherit"] != null)
                    s_str += "<script>var res = new Array(); res[0] = " + client.ID + "; " +
                    "res[1] = '" + client.Name + "'; " +
                    "window.returnValue = res; window.close(); </script>";
                Response.Write(s_str);
                //Response.Write("<script>alert(\"Изменения были успешно внесены!\");</script>");
                Response.Flush();
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
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
    /// запись текущей информации в сесию
    /// и переход к следующему етапу договора
    /// </summary>
    private void btSubmit_ServerClick(object sender, System.EventArgs e)
    {
        DBLogger.Info("Пользователь подтвердил данные о клиенте на странице карточки вкладчика заведения депозитного договора и перешёл на следующий этап" +
            ". ДРФО клиента = " + ((Deposit)Session["DepositInfo"]).Client.Code,
            "deposit");
        FillClassFromControls();
        DBLogger.Info("client.CellPhone = " + (((Deposit)Session["DepositInfo"]).Client.CellPhone) + " =>> " + Convert.ToString(Tools.Get_CellPhoneVerState(((Deposit)Session["DepositInfo"]).Client.CellPhone)));
        Client client = ((Deposit)Session["DepositInfo"]).Client;
        client.WriteToDatabase();         

        if (Tools.Get_CellPhoneVerState(((Deposit)Session["DepositInfo"]).Client.CellPhone))
        {
            LCellphone2.Visible = false;
            
            // Сохраняем параметры клиента
            string location = "DepositContract.aspx";
            string ckurl = "DepositShowClients.aspx";
            string cmd = string.Empty;
            
            if (clientChanged() && BankType.GetCurrentBank() != BANKTYPE.UPB)
            {
                //cmd = "<script>if (confirm(\"Данный клиент уже существует!\\nПросмотреть зарегистрированых клиентов?\")) " +
                cmd = "<script>if (confirm(\"" + Resources.Deposit.GlobalResources.al15 + "\")) " +
                "location.replace(\"" + ckurl + "\");</script>";
            }
            else
            {                
                cmd = "<script>location.replace(\"" + location + "\");</script>";
            }
            Response.Write(cmd);
            Response.Flush();
        }
        else
        {
            LCellphone2.Visible = true;
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

        lbVClientCode.Visible = false;
        lbVCodeType.Visible = false;
        lbVCountry.Visible = false;
        lbVDocDate.Visible = false;
        lbVDocNumber.Visible = false;
        lbVDocOrg.Visible = false;
        lbVSettlement.Visible = false;
        lbFIOGenitiveReq.Visible = false;
        lbVTerritory.Visible = false;
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

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"select f_getNameInGenitiveCase (:LN,1, :sex, 'U') || ' ' || 
	         f_getNameInGenitiveCase (:FN,2, :sex, 'U') || ' ' ||
             f_getNameInGenitiveCase (:PN,3, :sex, 'U') 
             from dual";
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
}
