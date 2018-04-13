using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.IO;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Bars.Oracle;
using Bars.Logger;
using Bars.Web.Report;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Globalization;
	/// <summary>
	/// 
	/// </summary>
	public partial class DepositContract : Bars.BarsPage
	{
        protected System.Data.DataSet dataSet;
		protected string  ContractTypeName;
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
		/// <summary>
		/// Процедура загрузка страницы
		/// </summary>
		private void Page_Load(object sender, System.EventArgs e)
		{
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

			if (!IsPostBack)
			{
                if (Request["dpt_id"] != null)
                {
                    ReadContractInfo(Request.Params.Get("dpt_id"));
                    FillControlsFromClass();
                }
                else
                {
                    /// Инициализируем элементы страницы
                    InitControls();
                }
                CkHistSchema();
				/// 
				RegisterOnLoadScript("textContractNumber");
			}
			else
			{
				RegisterOnLoadScript("listContractType");
			}
			/// Устанавливаем состояние некоторых элементов в зависимости от
			/// вида выбранного договора
            FillContractDependControls();
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
            dataSet = new DataSet();
        }
		#endregion
        private void CkHistSchema()
        {
            try
            {
                InitOraConnection();
                SetRole("BASIC_INFO");
                String result = Convert.ToString(SQL_SELECT_scalar("select upper(cschema) from staff where logname = user"));
                if (result == "HIST")
                {
                    btnClose.Disabled = true;
                    btSurvey.Disabled = true;
                    btAddAgreement.Disabled = true;
                    btFormDocs.Disabled = true;
                    btnSubmit.Disabled = true;
                    textComment.Enabled = false;
                    textNumPens.Enabled = false;
                    listSocOrgan.Enabled = false;
                }
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        /// <summary>
        /// Вычитка данных договора
        /// </summary>
        private void ReadContractInfo(string dpt_id)
        {
            try
            {
                InitOraConnection();
                SetRole("DPT_ROLE");

                // Заполняем список видов договоров
                listContractType.DataSource = SQL_SELECT_dataset("select type_id, type_name from v_socialdpttypes");
                listContractType.DataBind();

                SocialDeposit dpt = new SocialDeposit();
                Session["DepositInfo"] = dpt;
                dpt.ID = Convert.ToDecimal(dpt_id);
                SetParameters("dpt_id",DB_TYPE.Decimal,dpt_id,DIRECTION.Input);
                ArrayList reader = SQL_reader("select                   "           +
											"d.contract_number,		    "			+
                                            "d.pension_num,			    "			+
                                            "d.contract_date_on,	    "			+
                                            "d.card_account,		    "			+
                                            "d.type_id,		    	    "			+
                                            "d.type_name,			    "			+
                                            "d.agency_id,			    "			+
                                            "d.agency_name,			    "			+
                                            "d.customer_id,			    "			+
                                            "d.customer_name,		    "			+
                                            "d.currency_id,			    "			+
                                            "d.currency_name,		    "			+
                                            "d.rate,     			    "			+
                                            "d.contract_date_off, 	    "           +
                                            "d.details,	                "           +
                                            "d.account_number,          "           +
                                            "d.interest_number,         "           +
                                            "d.account_id,              "           +
                                            "d.interest_id              "           +
                                            "from v_socialcontracts d   "           +    
                                            "where contract_id=:dpt_id  ");
                if (reader.Count > 0)
                {
                    dpt.State = 9;
                    Session["DPT_NUM"] = Convert.ToString(reader[0]);
                    dpt.Number = Convert.ToString(reader[0]);
                    dpt.SocialNum = Convert.ToString(reader[1]);
                    dpt.BeginDate = Convert.ToDateTime(reader[2]);
                    dpt.SocialTechAcc = Convert.ToString(reader[3]);
                    dpt.Type = Convert.ToDecimal(reader[4]);
                    dpt.TypeName = Convert.ToString(reader[5]);
                    dpt.SocialAgancyID = Convert.ToDecimal(reader[6]);
                    dpt.SocialAgancyName = Convert.ToString(reader[7]);
                    dpt.Client.ID = Convert.ToDecimal(reader[8]);
                    dpt.Client.Name = Convert.ToString(reader[9]);
                    dpt.Currency = Convert.ToDecimal(reader[10]);
                    dpt.CurrencyName = Convert.ToString(reader[11]);
                    dpt.RealIntRate = Convert.ToDecimal(reader[12]);
                    if (Convert.ToString(reader[13]) != string.Empty)
                    {
                        dpt.EndDate = Convert.ToDateTime(reader[13]);
                        dpt.State = 1;
                    }
                    dpt.Comment = Convert.ToString(reader[14]);
                    dpt.RestReceiverAccount = Convert.ToString(reader[15]);
                    dpt.IntReceiverAccount = Convert.ToString(reader[16]);
                    dpt.RestReceiverName = Convert.ToString(reader[17]);
                    dpt.IntReceiverName = Convert.ToString(reader[18]);
                }
                else 
                {
                    throw new ApplicationException("Договір №" + dpt_id+ " не знайдено.");
                }

                // Орган социальной защиты
                ClearParameters();
                SetParameters("agency_id", DB_TYPE.Decimal, dpt.SocialAgancyID, DIRECTION.Input);
                SetParameters("dpt_id", DB_TYPE.Decimal, dpt.ID, DIRECTION.Input);
                listSocOrgan.DataSource = SQL_SELECT_dataset(@"
                    select agency_id, agency_name 
                    from v_socialagencies 
                    where agency_id = :agency_id                    
                    UNION
                    select agency_id, name 
                    from social_agency 
                    where dpt_social.ck_social_agency(:dpt_id, agency_id) > 0
                      and branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')");
                listSocOrgan.DataBind();
            }
            finally
            {
                DisposeOraConnection();
            }

        }
		/// <summary>
		/// Инициализиция элементов страницы
		/// </summary>
		private void InitControls()
		{
			SocialDeposit dpt = (SocialDeposit)Session["DepositInfo"];					
			try
			{
                InitOraConnection();
				SetRole("DPT_ROLE");

                // Орган социальной защиты
                listSocOrgan.DataSource = SQL_SELECT_dataset("select agency_id, agency_name from v_socialagencies where CONTRACT_CLOSED is null ");
                listSocOrgan.DataBind();

                listSocOrgan.SelectedIndex = listSocOrgan.Items.IndexOf(listSocOrgan.Items.FindByValue(dpt.SocialAgancyID.ToString()));

				// Заполняем список видов договоров
                ClearParameters();
                if (String.IsNullOrEmpty(listSocOrgan.SelectedValue))
                    SetParameters("agntype_id", DB_TYPE.Decimal, null, DIRECTION.Input);
                else
                    SetParameters("agntype_id", DB_TYPE.Decimal, listSocOrgan.SelectedValue, DIRECTION.Input);
                listContractType.DataSource = SQL_SELECT_dataset("select type_id, type_name " +
                    "from v_socialdpttypes t, v_socialagencies a " +
                    "where a.agency_id = :agency_id and  a.agency_type = t.AGNTYPE_ID and a.CONTRACT_CLOSED is null");

				listContractType.DataBind();

				listContractType.Items.Insert(0,"-");
				listContractType.Items[0].Value = "-1000";
             
                // Если первоначальный ввод, то устанавливаем 
				// умолчательные параметры
				if (dpt.Type == decimal.MinValue)
				{
					// Дата начала равна текущей банковской дате
					dpt.BeginDate = Convert.ToDateTime(SQL_SELECT_scalar("select to_char(bankdate,'dd/mm/yyyy') from dual"), cinfo);
				}

                FillControlsFromClass();
    		}
			finally	
			{
                DisposeOraConnection();
			}
		}	
		/// <summary>
		/// Заполняем необходимые элементы значениями в зависимости от вида
		/// выбранного договора
		/// </summary>
		private void FillContractDependControls()
		{
			try
			{
                InitOraConnection();
                SetRole("DPT_ROLE");

                SocialDeposit dpt = (SocialDeposit)Session["DepositInfo"];
                if (dpt.State == 9 || dpt.State == 1)
                {
                    ClearParameters();
                    SetParameters("rnk", DB_TYPE.Decimal, dpt.Client.ID, DIRECTION.Input);

                    if (dpt.State == 9)
                    {
                        Decimal sur_type = Convert.ToDecimal(SQL_SELECT_scalar("select val from params where par='SURVSOC0'"));
                        SetParameters("sur", DB_TYPE.Decimal, sur_type, DIRECTION.Input);

                        /// Якщо в схемі HIST то ніяких там анкет
                        if (!btSurvey.Disabled)
                        {
                            string res_sur = Convert.ToString(SQL_SELECT_scalar("select cust_survey.fill_up_survey(:rnk,:sur) from dual"));
                            if (res_sur != "1")
                                btSurvey.Visible = false;
                            else
                            {
                                btSurvey.Visible = true;
                                rnk.Value = dpt.Client.ID.ToString();
                            }
                        }
                    }
                }

				// Получаем выбранный вид договора
				if (dpt.State == 0 && listContractType.SelectedValue != "-1000")
				{
					decimal contractTypeCode = Convert.ToDecimal(listContractType.SelectedValue);

                    ClearParameters();
					// Формируем запрос для определения параметров этого вида договора
					SetParameters("type_id", DB_TYPE.Decimal, contractTypeCode, DIRECTION.Input);
                    ArrayList reader = SQL_reader("select type_id, type_name, kv_name, rate, to_char(bankdate,'dd/mm/yyyy')" +
                                                  " from v_socialdpttypes where type_id = :type_id");

					// Читаем данные запроса
					if (reader.Count > 0)
					{
						// Наименование типа депозита
						if (reader[1] != null)
                            ContractTypeName = Convert.ToString(reader[1]);
						else 
							ContractTypeName = string.Empty;

						// Валюта депозита
                        if (reader[2] != null)
                            textDepositCurrency.Text = Convert.ToString(reader[2]);
						else
							textDepositCurrency.Text = string.Empty;
					
						// Базовая процентная ставка
                        if (reader[3] != null)
                            textBasePercent.ValueDecimal = Convert.ToDecimal(reader[3]);
						else
							textBasePercent.ValueDecimal = Decimal.Zero;
    				}
					else
					{
						ContractTypeName = string.Empty;
						textDepositCurrency.Text = string.Empty;
						textBasePercent.ValueDecimal = Decimal.Zero;
					}
				}
			}
			finally	
			{
                DisposeOraConnection();
			}
		}
		/// <summary>
		/// Метод заполняет страницу из класса
		/// </summary>
		private void FillControlsFromClass()
		{
			SocialDeposit dpt = (SocialDeposit)Session["DepositInfo"];
            contract_id.Value = dpt.ID.ToString();
            // ФИО клиента
            textClientName.Text = dpt.Client.Name;
			// Номер договора
            textContractNumber.Text = dpt.Number;
			// Тип догорова
            listContractType.SelectedIndex	= listContractType.Items.IndexOf(listContractType.Items.FindByValue(dpt.Type.ToString()));
			ContractTypeName = dpt.TypeName;
            socType.Value = dpt.Type.ToString();

            if (dpt.IntReceiverAccount == string.Empty)
            {
                lbIntAccount.Visible = false;
                textIntAccount.Visible = false;
            }
            else
            {
                lbIntAccount.Visible = true;
                textIntAccount.Visible = true;
            }
            textIntAccount.Text = dpt.IntReceiverAccount;
            textAccounts.Text = dpt.RestReceiverAccount;

            account_id.Value = dpt.RestReceiverName;
            interest_id.Value = dpt.IntReceiverName;

            textNumPens.Text = dpt.SocialNum;
            textTechAcc.Text = dpt.SocialTechAcc;
            listSocOrgan.SelectedIndex = listSocOrgan.Items.IndexOf(listSocOrgan.Items.FindByValue(dpt.SocialAgancyID.ToString()));

            textDepositCurrency.Text = dpt.CurrencyName;
            if(dpt.RealIntRate != decimal.MinValue)
                textBasePercent.ValueDecimal = dpt.RealIntRate;

			// Сумма договора
			// Признак оплаты наличными
			// Дата начала договора
			if (dpt.BeginDate == DateTime.MinValue)
				dtContractBegin.Value	= string.Empty;
			else
				dtContractBegin.Date	= dpt.BeginDate;

            if (dpt.EndDate == DateTime.MinValue)
                dtContractEnd.Value = string.Empty;
            else
                dtContractEnd.Date = dpt.EndDate;

			// Комментарий
			textComment.Text		= dpt.Comment;

            if (dpt.State == 9) 
			{
                if (Request.Params.Get("dpt_id") != null)
                {
                    btnSubmit.Disabled      = false;
                    btnSubmit.Value         = "Зберегти зміни";
                    textComment.ReadOnly    = false;
                    
                    if (Request.Params.Get("action") == "close")
                        btnClose.Visible    = true;
                    else
                        btnClose.Visible    = false;
                }
                else 
                {
                    textNumPens.ReadOnly    = true;
                    textTechAcc.ReadOnly    = true;
                    btnSubmit.Disabled      = true;
                    textComment.ReadOnly    = true;
                }

                listContractType.Enabled	= false;
                btFormDocs.Visible          = true;
                btAddAgreements.Disabled    = false;
                btPrintDocs.Visible         = true;
                btAddAgreement.Visible      = true;
			}
            else if (dpt.State == 1)
            {
                btnClose.Disabled           = true;
                listContractType.Enabled    = false;
                btnSubmit.Visible           = false;
                btSurvey.Visible            = false;
                textNumPens.ReadOnly        = true;
                textTechAcc.ReadOnly        = true;
                btnSubmit.Disabled          = true;
                textComment.ReadOnly        = true;
            }
            else
            {
                btAddAgreement.Visible      = false;
                listContractType.Enabled    = true;
                textComment.ReadOnly        = false;
                textNumPens.ReadOnly        = false;
                textTechAcc.ReadOnly        = false;
                btnSubmit.Disabled          = false;
                btFormDocs.Visible          = false;
                btPrintDocs.Visible         = false;
                btAddAgreements.Disabled    = true;
            }
		}
		/// <summary>
		/// Сохраняет данные формы в классе
		/// </summary>
		private void FillClassFromControls()
		{
			SocialDeposit dpt = (SocialDeposit)Session["DepositInfo"];
			//
			dpt.Type		= Convert.ToDecimal(listContractType.SelectedValue);
			dpt.TypeName	= ContractTypeName;
			dpt.Number		= textContractNumber.Text;
			dpt.BeginDate	= dtContractBegin.Date;
			dpt.Comment		= textComment.Text;
            dpt.SocialNum   = textNumPens.Text;
            dpt.CurrencyName = textDepositCurrency.Text;
            dpt.RealIntRate = textBasePercent.ValueDecimal;
            dpt.SocialTechAcc = textTechAcc.Text;
            dpt.SocialAgancyID = Convert.ToDecimal(listSocOrgan.SelectedValue);

			Session["DepositInfo"] = dpt;
		}
		/// <summary>
		/// Перехід на попередню сторінку
		/// </summary>
		protected void btnBack_ServerClick(object sender, System.EventArgs e)
		{
            if (Request.Params.Get("dpt_id") != null)
            {
                DBLogger.Debug("Користувач натиснув на кнопку \"Назад\" на сторінці карточки депозиту и повернувся на сторінку пошуку.",
                    "SocialDeposit");
                Response.Redirect("DepositSearch.aspx");
            }
            else
            {
                DBLogger.Debug("Користувач натиснув на кнопку \"Назад\" на сторінці вибору типу депозиту и повернувся на карточку клієнта.",
                    "SocialDeposit");
                Response.Redirect("Default.aspx");		
            }
		}
		/// <summary>
		/// Встановлення фокусу
		/// </summary>
		/// <param name="control_id">Контрол</param>
		private void RegisterOnLoadScript(String control_id)
		{
			String script = "<script>focusControl('" + control_id + "');</script>";
			Page.RegisterStartupScript(ID+"Script_A",script );
		}
		/// <summary>
		/// Збереження договору
		/// </summary>
		protected void btnSubmit_ServerClick(object sender, System.EventArgs e)
		{
            // Сохраняем данные
            FillClassFromControls();
            SocialDeposit dpt = (SocialDeposit)Session["DepositInfo"];
            if (Request.Params.Get("dpt_id") != null)
            {
                DBLogger.Info("Користувач змінює данні депозитного договору пенсіонерів та безробітних." +
                    "Договір № " + dpt.ID,
                    "SocialDeposit");
                dpt.UpdateContarct(Context);
                Response.Write("<script>alert('Договір успішно обновлено!');</script>");
            }
            else
            {
                DBLogger.Info("Користувач починає відкивати депозитний договір пенсіонерів та безробітних." +
                    " Тип вибраного договору " + ContractTypeName,
                    "SocialDeposit");
                dpt.WriteToDatabase();
                Session["DPT_NUM"] = Convert.ToString(dpt.Number);
                Response.Write("<script>alert('Договір успішно зареєстровано!');</script>");
            }
			            
            contract_id.Value = dpt.ID.ToString();
            Response.Flush();

            ReadContractInfo(dpt.ID.ToString());
            FillContractDependControls();
            FillControlsFromClass();
    	}
        /// <summary>
        /// Формування документів
        /// </summary>
        protected void btFormDocs_ServerClick(object sender, EventArgs e)
        {
            string[] templates = templates_ids.Value.Substring(0,templates_ids.Value.Length-1).Split(';');
            SocialDeposit dpt = (SocialDeposit)Session["DepositInfo"];
            dpt.AddContractText(templates);
            Response.Write("<script>alert('Документи успішно сформовано!');</script>");
        }
        /// <summary>
        /// Закриття договору
        /// </summary>        
        protected void btnClose_ServerClick(object sender, EventArgs e)
        {
            try
            {
                InitOraConnection();
                SetRole("DPT_ROLE");
                SocialDeposit dpt = (SocialDeposit)Session["DepositInfo"];
                SetParameters("contract_id", DB_TYPE.Decimal, dpt.ID, DIRECTION.Input);
                SQL_PROCEDURE("dpt_social.close_contract");
                Response.Write("<script>alert('Договір успішно закрито!');</script>");
                dpt.State = 1;
                dpt.ReadFromDatabase(HttpContext.Current);
                Session["DepositInfo"] = dpt;
                FillControlsFromClass();
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        /// <summary>
        /// Історія додаткових угод
        /// </summary>
        protected void btAddAgreements_ServerClick(object sender, EventArgs e)
        {
            decimal dpt_id = Convert.ToDecimal(contract_id.Value);

            OracleConnection connect = new OracleConnection();

            try
            {
                IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();
                

                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdGetInfo = connect.CreateCommand();
                cmdGetInfo.CommandText = "select decode(to_char(substr(c.text,1,1)),to_char(null),'текст відсутній','<A href=# onclick=\"Go('||c.nd||','||c.adds||','''||c.id||''')\">Перегляд</a>'), " +
                    "s.add_num adds, s.FLAG_NAME,to_char(c.version,'dd/mm/yyyy'),details " +
                    "from v_socialtrustee s, cc_docs c " +
                    "where c.ND(+) = s.CONTRACT_ID and c.adds(+) = s.ADD_NUM and s.CONTRACT_ID = :dpt_id order by s.add_num";
                cmdGetInfo.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

                OracleDataAdapter adapterFillDataSet = new OracleDataAdapter();
                adapterFillDataSet.SelectCommand = cmdGetInfo;
                adapterFillDataSet.Fill(dataSet);

                dataSet.Tables[0].Columns[0].ColumnName = "Текст";
                dataSet.Tables[0].Columns[1].ColumnName = "Номер";
                dataSet.Tables[0].Columns[2].ColumnName = "Найменування";
                dataSet.Tables[0].Columns[3].ColumnName = "Версія";
                dataSet.Tables[0].Columns[4].ColumnName = "Статус";

                dataGrid.DataBind();

                dataGrid.HeaderStyle.BackColor = Color.Gray;
                dataGrid.HeaderStyle.Font.Bold = true;
                dataGrid.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void listSocOrgan_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                InitOraConnection();
                SetRole("DPT_ROLE");

                if (Request["dpt_id"] == null)
                {
                    // Заполняем список видов договоров
                    ClearParameters();
                    SetParameters("agntype_id", DB_TYPE.Decimal, listSocOrgan.SelectedValue, DIRECTION.Input);
                    listContractType.DataSource = SQL_SELECT_dataset("select type_id, type_name " +
                        "from v_socialdpttypes t, v_socialagencies a " +
                        "where a.agency_id = :agency_id and  a.agency_type = t.AGNTYPE_ID and a.CONTRACT_CLOSED is null");
                    listContractType.DataBind();

                    listContractType.Items.Insert(0, "-");
                    listContractType.Items[0].Value = "-1000";
                }

                FillContractDependControls();
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        protected void btReport_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(contract_id.Value))
            {
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "DOCLIST_EDIT_NOT_SELECTED",
                    "alert('Договір не збережено!');", true);
                return;
            }

            Response.Redirect("/barsroot/cbirep/rep_query.aspx?repid=703&Param0=" + contract_id.Value);
        }
}

