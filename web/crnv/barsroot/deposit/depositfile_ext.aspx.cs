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
using Bars.Logger;
using Bars.Oracle;
using System.IO;
using System.Text;
using System.Globalization;
using MultiLanguage;
using Bars.Classes;

/// <summary>
/// Summary description for DepositFile.
/// </summary>
public partial class DepositFile : Bars.BarsPage
{
    protected OracleDataAdapter adapterFillRecords;
	protected System.Data.DataSet dsAgencies;
	protected System.Data.DataSet dsTypes;
    protected System.Data.DataSet dsAgencyTypes;
	int row_counter = 0;

    /// <summary>
    /// 
    /// </summary>
	private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositFile;
		RegisterClientScript();

        //if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
        //{
        //    gridRecords.Columns[7].Visible = false;
        //    gridRecords.Columns[8].Visible = false;
        //    gridRecords.Columns[9].Visible = false;

        //    gridRecords.Columns.RemoveAt(7);
        //    gridRecords.Columns.RemoveAt(7);
        //    gridRecords.Columns.RemoveAt(7);

        //    listTypes.Visible = false;
        //}

        if (!IsPostBack)
		{
            if (Convert.ToString(Request["mode"]) != "copy")
            {
                Session["BF_HEADER_ID"] = String.Empty;
                Session["BF_FILENAME"] = String.Empty;
                Session["BF_DAT"] = String.Empty;
            }

            textYear.Text = DateTime.Now.Year.ToString();
            ddMonth.SelectedIndex = DateTime.Now.Month - 1;

            gridRecords.HeaderStyle.Font.Bold = true;
            gridRecords.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;

			LoadFileTypes();
            LoadAccTypes();

            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            /// Створюємо вручну новий файл
            if (Convert.ToString(Request["mode"]) == "create")
            {
                DAT.Date = DateTime.Now.Date;
                FILENAME.Text = BankFileExt.GetUFilename();
                InitGrid();

                tbNewHeader.Visible = true;

                bankFile.Disabled = true;
                rbWin.Enabled = false;
                rbDos.Enabled = false;
                btUpload.Disabled = true;
                btPay.Disabled = true;
            }
            /// Копіювання файла
            else if (Convert.ToString(Request["mode"]) == "copy")
            {
                DAT.Date = Convert.ToDateTime(Convert.ToString(Session["BF_DAT"]), cinfo);
                FILENAME.Text = Convert.ToString(Session["BF_FILENAME"]);
                ins_header_id.Value = Convert.ToString(Session["BF_HEADER_ID"]);
                DisableControls();
                InitGrid();

                tbNewHeader.Visible = true;

                bankFile.Disabled = true;
                rbWin.Enabled = false;
                rbDos.Enabled = false;
                btUpload.Disabled = true;
                btPay.Disabled = true;
            }
            /// Перегляд прийнятого файлу
			else if (Request["filename"] != null && Request["dat"] != null
                 && Request["header_id"] != null)
			{
				bankFile.Disabled = true;
                rbWin.Enabled = false;
                rbDos.Enabled = false;
				btUpload.Disabled = true;
				listTypes.Enabled = false;
                listAgencyType.Enabled = false;
                ddAccType.SelectedIndex = -1;
                ddAccType.Enabled = false;

				String filename = Convert.ToString(Request["filename"]);
				DateTime dat = Convert.ToDateTime(Convert.ToString(Request["dat"]),cinfo);
                Decimal header_id = Convert.ToDecimal(Convert.ToString(Request["header_id"]));

                BankFileExt bf = new BankFileExt(filename, dat, header_id);
				
				bf_filename.Value = bf.header.filename;
				bf_dat.Value = bf.header.dtCreated.ToString("dd/MM/yyyy");
                bf_header_id.Value = bf.header.id.ToString();

				if (!bf.IsPaid())
				{
					ShowRecords(bf);
					btPay.Disabled = false;
				}
				else
				{
					ShowRecordsNoUpdate(bf);
					btPay.Disabled = true;
				}
			}

            if (Convert.ToString(Request["gb"]) == "true")
            {
                ddAgencyInGb.Visible = true;
                LoabGbAgencies(Convert.ToDecimal(listAgencyType.SelectedValue));
            }
		}
		else
		{
			if (bf_reload.Value == "1")
			{
				bf_reload.Value = "0";
				String dt = Convert.ToString(bf_dat.Value);
		
				CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
				cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
				cinfo.DateTimeFormat.DateSeparator = "/";

                BankFileExt bf = new BankFileExt(Convert.ToString(bf_filename.Value),
					Convert.ToDateTime(dt,cinfo),Convert.ToDecimal(bf_header_id.Value));
				
				ShowRecords(bf);
                gvBranch.DataBind();
			}
		}
	}
	/// <summary>
	/// 
	/// </summary>
	/// <param name="e"></param>
    override protected void OnInit(EventArgs e)
	{
		InitializeComponent();
		base.OnInit(e);

        /// Створюємо вручну новий файл
        if (Convert.ToString(Request["mode"]) == "create" ||
            Convert.ToString(Request["mode"]) == "copy")
        {
            InitGrid();
        }

        // параметры соединения грида
        dsBranch.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsBranch.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

        ((CommandField)gvBranch.Columns[0]).UpdateText = Resources.barsweb.GlobalResources.vSave;
        ((CommandField)gvBranch.Columns[0]).EditText = Resources.barsweb.GlobalResources.vEdit;
        ((CommandField)gvBranch.Columns[0]).CancelText = Resources.barsweb.GlobalResources.vCancel;
    }

	/// <summary>
	/// Required method for Designer support - do not modify
	/// the contents of this method with the code editor.
	/// </summary>
	private void InitializeComponent()
	{    
		this.dsAgencies = new System.Data.DataSet();
		this.dsTypes = new System.Data.DataSet();
        this.dsAgencyTypes = new System.Data.DataSet();
		((System.ComponentModel.ISupportInitialize)(this.dsAgencies)).BeginInit();
		((System.ComponentModel.ISupportInitialize)(this.dsTypes)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.dsAgencyTypes)).BeginInit();
		// 
		// dsRecords
		// 
		this.btUpload.ServerClick += new System.EventHandler(this.btUpload_ServerClick);
		this.btPay.ServerClick += new System.EventHandler(this.btPay_ServerClick);
		// 
		// dsAgencies
		// 
		this.dsAgencies.DataSetName = "NewDataSet";
		this.dsAgencies.Locale = new System.Globalization.CultureInfo("uk-UA");
		// 
		// dsTypes
		// 
		this.dsTypes.DataSetName = "NewDataSet";
		this.dsTypes.Locale = new System.Globalization.CultureInfo("uk-UA");
        // 
        // dsAgencyTypes
        // 
        this.dsAgencyTypes.DataSetName = "NewDataSet";
        this.dsAgencyTypes.Locale = new System.Globalization.CultureInfo("uk-UA");
		;
		((System.ComponentModel.ISupportInitialize)(this.dsAgencies)).EndInit();
		((System.ComponentModel.ISupportInitialize)(this.dsTypes)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.dsAgencyTypes)).EndInit();

	}
    /// <summary>
    /// 
    /// </summary>
    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        if (sourceControl.GetType().Name == "BarsGridView" || sourceControl.GetType().Name == "BarsGridViewEx" ||
            sourceControl.GetType().Name == "DataControlLinkButton" || 
            (eventArgument != null && eventArgument.Length > 4 && eventArgument.Substring(0, eventArgument.IndexOf("$")) == "Bars"))
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            /// Створюємо вручну новий файл
            if (Convert.ToString(Request["mode"]) == "create" ||
            Convert.ToString(Request["mode"]) == "copy")
            {
                InitGrid();
            }
            /// Перегляд прийнятого файлу
            else if (Request["filename"] != null && Request["dat"] != null &&
                Request["header_id"] != null)
            {
                String filename = Convert.ToString(Request["filename"]);
                DateTime dat = Convert.ToDateTime(Convert.ToString(Request["dat"]), cinfo);
                Decimal header_id = Convert.ToDecimal(Convert.ToString(Request["header_id"]));

                BankFileExt bf = new BankFileExt(filename, dat,header_id);

                bf_filename.Value = bf.header.filename;
                bf_dat.Value = bf.header.dtCreated.ToString("dd/MM/yyyy");
                bf_header_id.Value = bf.header.id.ToString();

                if (!bf.IsPaid())
                {
                    ShowRecords(bf);
                    btPay.Disabled = false;
                }
                else
                {
                    ShowRecordsNoUpdate(bf);
                    btPay.Disabled = true;
                }
            }
            /// Імпортуємо новий файл
            else
            {
                String filename = Convert.ToString(bf_filename.Value);
                DateTime dat = Convert.ToDateTime(bf_dat.Value, cinfo);
                Decimal header_id = Convert.ToDecimal(bf_header_id.Value);
                BankFileExt bf = new BankFileExt(filename, dat, header_id);
                ShowRecords(bf);
            }
        }
        try
        {
            base.RaisePostBackEvent(sourceControl, eventArgument);
        }
        catch (Exception ex)
        {
            Deposit.SaveException(ex);
            Random r = new Random();
            Response.Write("<script> window.showModalDialog('dialog.aspx?type=err&rcode=" + 
                Convert.ToString(r.Next()) +
                "','','dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;'); " +
                "</script>");
            Response.Flush();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private void InitGrid()
    {
        if (!(gridRecords.Columns[0] is CommandField))
        {
            CommandField cf = new CommandField();
            cf.DeleteText = Resources.barsweb.GlobalResources.vDelete;
            cf.EditText = Resources.barsweb.GlobalResources.vEdit;
            cf.UpdateText = Resources.barsweb.GlobalResources.vSave;
            cf.CancelText = Resources.barsweb.GlobalResources.vCancel;
            cf.ShowEditButton = true;
            cf.ShowCancelButton = true;
            cf.ShowDeleteButton = true;
            gridRecords.Columns.Insert(0, cf);
        }

        //gridRecords.Columns[0].Visible = false;
        //gridRecords.Columns[1].Visible = false;
        //gridRecords.Columns[2].Visible = false;
        //gridRecords.Columns[3].Visible = false;

        if (btCreateHeader.Disabled)
            gridRecords.AutoGenerateNewButton = true;

        dsRecords.SelectParameters.Clear();
        dsRecords.InsertParameters.Clear();
        dsRecords.UpdateParameters.Clear();
        dsRecords.DeleteParameters.Clear();

        dsRecords.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsRecords.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

        dsRecords.DeleteCommand = "DELETE FROM DPT_FILE_ROW WHERE INFO_ID = :old_INFO_ID";
        
        dsRecords.UpdateCommand = @"UPDATE DPT_FILE_ROW 
            SET NLS = :NLS, BRANCH_CODE = :BRANCH_CODE, DPT_CODE = :DPT_CODE, 
            SUM = :SUM * 100, FIO = :FIO, ID_CODE = :ID_CODE, PAYOFF_DATE = to_date(:PAYOFF_DATE,'dd/mm/yyyy')
            WHERE INFO_ID = :old_INFO_ID";

        dsRecords.InsertCommand = " begin dpt_social.create_file_row_ext( " +
                " to_number('" + Convert.ToString(Session["BF_HEADER_ID"]) + "'), '" + FILENAME.Text +
                "', to_date('" + DAT.Date.ToString("dd/MM/yyyy") + "','dd/MM/yyyy'), " +
                " :NLS,:BRANCH_CODE,:DPT_CODE,:SUM * 100,:FIO,:ID_CODE, null, to_date(:PAYOFF_DATE,'dd/mm/yyyy'), " +
                " null, :INFO_ID); end;";

        Parameter par = new Parameter("NLS", TypeCode.String);
        par.Size = 19;
        dsRecords.UpdateParameters.Add(par);
        dsRecords.InsertParameters.Add(par);

        par = new Parameter("BRANCH_CODE", TypeCode.Decimal);
        par.Size = 4;
        dsRecords.UpdateParameters.Add(par);
        dsRecords.InsertParameters.Add(par);

        par = new Parameter("DPT_CODE", TypeCode.Decimal);
        par.Size = 3;
        dsRecords.UpdateParameters.Add(par);
        dsRecords.InsertParameters.Add(par);

        par = new Parameter("SUM", TypeCode.Decimal);
        par.Size = 19;
        dsRecords.UpdateParameters.Add(par);
        dsRecords.InsertParameters.Add(par);

        par = new Parameter("FIO", TypeCode.String);
        par.Size = 100;
        dsRecords.UpdateParameters.Add(par);
        dsRecords.InsertParameters.Add(par);

        par = new Parameter("ID_CODE", TypeCode.String);
        par.Size = 16;
        dsRecords.UpdateParameters.Add(par);
        dsRecords.InsertParameters.Add(par);

        par = new Parameter("PAYOFF_DATE", TypeCode.String);
        par.Size = 20;
        dsRecords.UpdateParameters.Add(par);
        dsRecords.InsertParameters.Add(par);

        par = new Parameter("old_INFO_ID", TypeCode.Decimal);
        par.Size = 18;
        dsRecords.DeleteParameters.Add(par);
        dsRecords.UpdateParameters.Add(par);
        dsRecords.InsertParameters.Add(par);

        //dsRecords.SelectCommand = "SELECT INFO_ID, INFO_ID INFO_ID_TEXT, NLS, " +
        //    "BRANCH_CODE, DPT_CODE, to_char(SUM/100,'9999999999999999990.99') SUM, " +
        //    "FIO, ID_CODE, PAYOFF_DATE, NULL AS REF, " +
        //    "incorrect,closed,excluded, BRANCH, AGENCY_NAME, MARKED4PAYMENT, null REAL_ACC_NUM,null REAL_CUST_CODE,null REAL_CUST_NAME  " +
        //    "FROM DPT_FILE_ROW WHERE header_id = to_number('" + Convert.ToString(Session["BF_HEADER_ID"]) +
        //    "') order by info_id";
        dsRecords.SelectCommand = "SELECT INFO_ID, INFO_ID INFO_ID_TEXT, NLS, " +
            "BRANCH_CODE, DPT_CODE, to_char(SUM/100,'9999999999999999990.99') SUM, " +
            "FIO, ID_CODE, PAYOFF_DATE, NULL AS REF, " +
            "incorrect,closed,excluded, BRANCH, AGENCY_NAME, MARKED4PAYMENT, null REAL_ACC_NUM,null REAL_CUST_CODE,null REAL_CUST_NAME  " +
            "FROM DPT_FILE_ROW WHERE header_id = to_number('" + Convert.ToString(Session["BF_HEADER_ID"]) +
            "') order by info_id";


        // gridRecords.DataBind();
    }
    /// <summary>
	/// 
	/// </summary>
	/// <param name="bf"></param>
	private void ShowRecords(BankFileExt bf)
	{
        dsRecords.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsRecords.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

        dsRecords.SelectCommand = "SELECT decode(ref, null, '<A href=# onclick=\"Correct_ext('||info_id||')\">Редагувати</a>', null) INFO_ID_TEXT, INFO_ID, NLS, " +
            "BRANCH_CODE,DPT_CODE,to_char(SUM/100,'9999999999999999990.99') SUM, FIO, ID_CODE, PAYOFF_DATE, " +
            "'<A href=# onclick=''ShowDocCard('||REF||')''>'||REF||'</a>' AS REF, incorrect, closed, excluded,BRANCH,AGENCY_NAME,MARKED4PAYMENT,DEAL_CREATED, " +
            " real_acc_num, real_cust_code, real_cust_name " +
            "FROM V_DPT_FILE_ROW WHERE header_id = " + bf.header.id.ToString();

        if (ckIncorrect.Checked)
            dsRecords.SelectCommand += " and incorrect = 1 ";

        if (ckExcluded.Checked)
            dsRecords.SelectCommand += " and (excluded = 1 or marked4payment = 0) ";

        if (ckUnknown.Checked)
            dsRecords.SelectCommand += " and incorrect = 0 and real_acc_num is null ";
    
        dsRecords.SelectCommand += " order by info_id ";

        dsRecords.DataBind();

		gridRecords.HeaderStyle.Font.Bold = true;
		gridRecords.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;

        listTypes.SelectedIndex = listTypes.Items.IndexOf(
            listTypes.Items.FindByValue(bf.type_id.ToString()));
        
        listAgencyType.SelectedIndex = listAgencyType.Items.IndexOf(
            listAgencyType.Items.FindByValue(bf.AGENCY_TYPE.ToString()));

        listTypes.Enabled = false;
        listAgencyType.Enabled = false;
        textYear.Enabled = false;
        ddMonth.Enabled = false;
	}		
	/// <summary>
	/// 
	/// </summary>
	/// <param name="bf"></param>
	private void ShowRecordsNoUpdate(BankFileExt bf)
	{
        /// З підстановкою дат в нас тут ГРОМАДНІ проблеми - тому вставляємо прямо
        dsRecords.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsRecords.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

        dsRecords.SelectCommand = "SELECT INFO_ID, INFO_ID INFO_ID_TEXT, NLS, " +
            "BRANCH_CODE, DPT_CODE, to_char(SUM/100,'9999999999999999990.99') SUM, FIO, ID_CODE, PAYOFF_DATE, " +
            "'<A href=# onclick=''ShowDocCard('||REF||')''>'||REF||'</a>' AS REF, " +
            "incorrect,closed,excluded,BRANCH, AGENCY_NAME, 1 as MARKED4PAYMENT,DEAL_CREATED, " +
            " real_acc_num, real_cust_code, real_cust_name " +
            "FROM V_DPT_FILE_ROW WHERE header_id = " + bf.header.id.ToString();

        if (ckIncorrect.Checked)
            dsRecords.SelectCommand += " and incorrect = 1 ";

        if (ckExcluded.Checked)
            dsRecords.SelectCommand += " and (excluded = 1 or marked4payment = 0) ";

        if (ckUnknown.Checked)
            dsRecords.SelectCommand += " and incorrect = 0 and real_acc_num is null ";

        dsRecords.SelectCommand += " order by info_id ";

        dsRecords.DataBind();

        gridRecords.Columns[0].Visible = false;
        gridRecords.Columns[1].Visible = false;
        gridRecords.Columns[2].Visible = false;
        gridRecords.Columns[3].Visible = false;

        gridRecords.HeaderStyle.Font.Bold = true;
		gridRecords.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;

        listTypes.SelectedIndex = listTypes.Items.IndexOf(
            listTypes.Items.FindByValue(bf.type_id.ToString()));
        listAgencyType.SelectedIndex = listAgencyType.Items.IndexOf(
            listAgencyType.Items.FindByValue(bf.AGENCY_TYPE.ToString()));

        listTypes.Enabled = false;
        listAgencyType.Enabled = false;
        ddAgencyInGb.Enabled = false;
        textYear.Enabled = false;
        ddMonth.Enabled = false;
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
			function S_A(id)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script_A", script);
	}
	/// <summary>
	/// 
	/// </summary>
	private void btUpload_ServerClick(object sender, System.EventArgs e)
	{
        if (listTypes.SelectedIndex == -1)
		{
            Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al24 + "');</script>");
            //Response.Write("<script>alert('Прийом неможливий!\\nВиберіть район (тип) зарахування!');</script>");
			Response.Flush();
			return;
		}

		if(bankFile.PostedFile != null && bankFile.PostedFile.FileName != String.Empty)
		{			
			string TempDir = Path.GetTempPath() + "BankFile\\";			
			DirectoryInfo TmpDitInf = new DirectoryInfo(TempDir);
			//-- если дериктории нету, то создаем ее
			if(!TmpDitInf.Exists) TmpDitInf.Create();

			string posFileName = bankFile.PostedFile.FileName;
			string TempFile = posFileName.Substring(posFileName.LastIndexOf("\\") + 1);
			string TempPath = TempDir + TempFile;
			
			bankFile.PostedFile.SaveAs(TempPath);		

			ArrayList arr = new ArrayList();
			String line = String.Empty;

            ///// Розпізнаємо кодування файлу
            //FileStream fs = new System.IO.FileStream(
            //    TempPath,
            //    System.IO.FileMode.Open,
            //    System.IO.FileAccess.Read);

            //byte[] bs = new byte[fs.Length];
            //fs.Read(bs, 0, bs.Length);
            //fs.Close();

            //sbyte[] sbs = new sbyte[bs.Length];
            //System.Buffer.BlockCopy(bs, 0, sbs, 0, bs.Length);

            //DetectCodepage dcp = new DetectCodepage(sbs, MLDETECTCP.MLDETECTCP_7BIT);
            ///
            //StreamReader sr = new StreamReader(TempPath, Encoding.GetEncoding(866));  
            int encoding = 866;
            if (rbDos.Checked) encoding = 866;
            else if (rbWin.Checked) encoding = 1251;

            StreamReader sr = new StreamReader(TempPath, Encoding.GetEncoding(encoding));  
            //StreamReader sr = new StreamReader(TempPath, Encoding.ASCII);  

			while (true) 
			{
				line = sr.ReadLine();

				if (line == null)
					break;

				arr.Add(line);
			}

			sr.Close();			
			File.Delete(TempPath);
			Directory.Delete(TempDir);

			BankFileExt bf = new BankFileExt(arr, Convert.ToInt32(ddMonth.SelectedValue), 
                Convert.ToInt32(textYear.Text));

			bf.type_id = Convert.ToDecimal(listTypes.SelectedValue);
            bf.AGENCY_TYPE = Convert.ToDecimal(listAgencyType.SelectedValue);
            bf.Acc_Type = Convert.ToString(ddAccType.SelectedValue);
			
            if (Convert.ToString(Request["gb"]) == "true")
                bf.WriteToDatabaseExt(false);
            else
                bf.WriteToDatabase();


            /// Записуємо на сторінку, щоб при постбеку гріда прочитати
            bf_filename.Value = bf.header.filename;
            bf_dat.Value = bf.header.dtCreated.ToString("dd/MM/yyyy");
            bf_header_id.Value = bf.header.id.ToString();

			ShowRecords(bf);

			bankFile.Disabled = true;
            rbWin.Enabled = false;
            rbDos.Enabled = false;
			btUpload.Disabled = true;
			btPay.Disabled = false;
            listTypes.Enabled = false;
            listAgencyType.Enabled = false;
            ddAccType.Enabled = false;

            gridRecords.DataBind();
            gvBranch.DataBind();

            Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al25 + "');</script>");
            //Response.Write("<script>alert('Файл был успешно принят.');</script>");
			Response.Flush();
		}
		else
		{
            Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al26 + "');</script>");
            //Response.Write("<script>alert('Не выбран файл!');</script>");
			Response.Flush();
			return;
		}
	}
	/// <summary>
	/// 
	/// </summary>
	private void btPay_ServerClick(object sender, System.EventArgs e)
	{       
        String dt = Convert.ToString(bf_dat.Value);
		
		CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
		cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
		cinfo.DateTimeFormat.DateSeparator = "/";

		BankFileExt bf = new BankFileExt(Convert.ToString(bf_filename.Value),
			Convert.ToDateTime(dt,cinfo),Convert.ToDecimal(bf_header_id.Value));

		if (bf.HasInvalidNLS())
		{				
			ShowRecords(bf);

            Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al27 + "');</script>");
			Response.Flush();
			return;
		}

//            bf.type_id = Convert.ToDecimal(listTypes.SelectedValue);
//            bf.agency_id = Convert.ToDecimal(listAgencies.SelectedValue);

        try
        {
            if (Convert.ToString(Request["gb"]) == "true")
                bf.PayGb(Convert.ToDecimal(ddAgencyInGb.SelectedValue));
            else
                bf.Pay();
        }
        catch (Exception ex)
        {
            bf.ReadFromDatabase();
            if (bf.IsPaid())
            {
                btPay.Disabled = true;

                ShowRecordsNoUpdate(bf);
            }
            else
                ShowRecords(bf);
            
            throw ex;
        }

        bf.ReadFromDatabase();
        if (bf.IsPaid())
        {
            btPay.Disabled = true;

            ShowRecordsNoUpdate(bf);
        }
        else
            ShowRecords(bf);

        Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al28 + "');</script>");
		//Response.Write("<script>alert('Оплата прошла успешно!');</script>");
		Response.Flush();		
	}
	/// <summary>
	/// 
	/// </summary>
	private void LoadFileTypes()
	{
		OracleConnection connect = new OracleConnection();

		try
		{
			// Открываем соединение с БД
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			

			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

			OracleCommand cmdLoadTypes = connect.CreateCommand();
            cmdLoadTypes.CommandText = "SELECT type_id, type_name || ' - (Позабалансовий символ ' || sk_zb || ')' as type_name FROM SOCIAL_FILE_TYPES";

			adapterFillRecords = new OracleDataAdapter();
			adapterFillRecords.SelectCommand = cmdLoadTypes;
			adapterFillRecords.Fill(dsTypes);

			listTypes.DataBind();

            cmdLoadTypes.CommandText = "SELECT type_id, type_name FROM SOCIAL_AGENCY_TYPE";

            adapterFillRecords = new OracleDataAdapter();
            adapterFillRecords.SelectCommand = cmdLoadTypes;
            adapterFillRecords.Fill(dsAgencyTypes);

            listAgencyType.DataBind();
		}
		finally	
		{
			if (connect.State != ConnectionState.Closed)
			{connect.Close();connect.Dispose();}
		}
	}
    /// <summary>
    /// 
    /// </summary>
    private void LoadAccTypes()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdLoadTypes = connect.CreateCommand();
            cmdLoadTypes.CommandText = "select type, name from v_file_account_types";

            DataSet dsAccTypes = new DataSet();
            OracleDataAdapter adapterFillAccTypes = new OracleDataAdapter();
            adapterFillAccTypes.SelectCommand = cmdLoadTypes;
            adapterFillAccTypes.Fill(dsAccTypes);

            ddAccType.DataSource = dsAccTypes;
            ddAccType.DataTextField = "NAME";
            ddAccType.DataValueField = "TYPE";
            ddAccType.DataBind();

            //ddAccType.SelectedIndex = ddAccType.Items.IndexOf(
            //    ddAccType.Items.FindByValue(tmp_acctype));
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
    protected void gridRecords_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();
            GridViewRow row = e.Row;
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S_A('" + row_counter + "')");

			if (Convert.ToString(((DataRowView)e.Row.DataItem).Row[15]) == "0")
				row.ForeColor = Color.Gray;
			else if (Convert.ToString(((DataRowView)e.Row.DataItem).Row[16]) == "1")
				row.ForeColor = Color.Blue;
			else if (Convert.ToString(((DataRowView)e.Row.DataItem).Row[17]) == String.Empty)
				row.ForeColor = Color.Red;

			if (Convert.ToString(((DataRowView)e.Row.DataItem).Row[10]) == "1")
				row.ForeColor = Color.Red;
			if (Convert.ToString(((DataRowView)e.Row.DataItem).Row[11]) == "1")
				row.ForeColor = Color.Orange;
			if (Convert.ToString(((DataRowView)e.Row.DataItem).Row[12]) == "1")
				row.ForeColor = Color.Green;
        }
	}
    /// <summary>
    /// 
    /// </summary>
    protected void btCreateHeader_Click(object sender, EventArgs e)
    {
        Session["BF_FILENAME"] = FILENAME.Text;
        Session["BF_DAT"] = DAT.Date.ToString("dd/MM/yyyy");

        InsertHeader();
        DisableControls();

        InitGrid();
    }
    /// <summary>
    /// 
    /// </summary>
    private void DisableControls()
    {
        btCreateHeader.Disabled = true;
        btFinish.Disabled = false;

        FILENAME.Enabled = false;
        HEADER_LENGTH.Enabled = false;
        DAT.Enabled = false;
        INFO_NUM.Enabled = false;
        MFO_A.Enabled = false;
        NLS_A.Enabled = false;
        MFO_B.Enabled = false;
        NLS_B.Enabled = false;
        DK.Enabled = false;
        SUM.Enabled = false;
        TYPE.Enabled = false;
        NUM.Enabled = false;
        HAS_ADD.Enabled = false;
        NAME_A.Enabled = false;
        NAME_B.Enabled = false;
        NAZN.Enabled = false;
        BRANCH_CODE.Enabled = false;
        DPT_CODE.Enabled = false;
        EXEC_ORD.Enabled = false;
        KS_EP.Enabled = false;

        listTypes.Enabled = false;
        listAgencyType.Enabled = false;
    }
    /// <summary>
    /// 
    /// </summary>
    private void InsertHeader()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdIns = connect.CreateCommand();
            cmdIns.CommandText = "BEGIN " +
                " dpt_social.create_file_header(:filename,:header_length,:dat,:info_length, " +
                "  :mfo_a,:nls_a,:mfo_b,:nls_b,:DK,:SUM,:TYPE,:num,:has_add,:name_a,:name_b, " +
                "  :dest,:branch_num,:dpt_code,:exec_ord,:ks_ep,:type_id,:AGENCY_TYPE,:header_id,'2'); " +
                " end; ";                
                
            cmdIns.Parameters.Add("FILENAME",OracleDbType.Varchar2,FILENAME.Text,ParameterDirection.Input);
            cmdIns.Parameters.Add("HEADER_LENGTH", OracleDbType.Decimal, HEADER_LENGTH.Text, ParameterDirection.Input);
            cmdIns.Parameters.Add("DAT", OracleDbType.Date, DAT.Date, ParameterDirection.Input);
            cmdIns.Parameters.Add("INFO_LENGTH", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmdIns.Parameters.Add("MFO_A", OracleDbType.Varchar2, MFO_A.Text, ParameterDirection.Input);
            cmdIns.Parameters.Add("NLS_A", OracleDbType.Varchar2, NLS_A.Text, ParameterDirection.Input);
            cmdIns.Parameters.Add("MFO_B", OracleDbType.Varchar2, MFO_B.Text, ParameterDirection.Input);
            cmdIns.Parameters.Add("NLS_B", OracleDbType.Varchar2, NLS_B.Text, ParameterDirection.Input);
            cmdIns.Parameters.Add("DK", OracleDbType.Decimal, DK.Text, ParameterDirection.Input);
            cmdIns.Parameters.Add("SUM", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmdIns.Parameters.Add("TYPE", OracleDbType.Decimal, TYPE.Text, ParameterDirection.Input);
            cmdIns.Parameters.Add("NUM", OracleDbType.Varchar2, NUM.Text, ParameterDirection.Input);
            cmdIns.Parameters.Add("HAS_ADD", OracleDbType.Varchar2, HAS_ADD.Text, ParameterDirection.Input);
            cmdIns.Parameters.Add("NAME_A", OracleDbType.Varchar2, NAME_A.Text, ParameterDirection.Input);
            cmdIns.Parameters.Add("NAME_B", OracleDbType.Varchar2, NAME_B.Text, ParameterDirection.Input);
            cmdIns.Parameters.Add("NAZN", OracleDbType.Varchar2, NAZN.Text, ParameterDirection.Input);
            cmdIns.Parameters.Add("BRANCH_CODE", OracleDbType.Decimal, BRANCH_CODE.Text, ParameterDirection.Input);
            cmdIns.Parameters.Add("DPT_CODE", OracleDbType.Decimal, DPT_CODE.Text, ParameterDirection.Input);
            cmdIns.Parameters.Add("EXEC_ORD", OracleDbType.Varchar2, EXEC_ORD.Text, ParameterDirection.Input);
            cmdIns.Parameters.Add("KS_EP", OracleDbType.Varchar2, KS_EP.Text, ParameterDirection.Input);
            cmdIns.Parameters.Add("TYPE_ID", OracleDbType.Decimal, listTypes.SelectedValue, ParameterDirection.Input);
            cmdIns.Parameters.Add("AGENCY_TYPE", OracleDbType.Decimal, listAgencyType.SelectedValue, ParameterDirection.Input);
            cmdIns.Parameters.Add("HEADER_ID", OracleDbType.Decimal, ins_header_id.Value, ParameterDirection.Output);

            cmdIns.ExecuteNonQuery();

            ins_header_id.Value = Convert.ToString(cmdIns.Parameters[22].Value);
            Session["BF_HEADER_ID"] = Convert.ToDecimal(Convert.ToString(cmdIns.Parameters[22].Value));

            listAgencyType.Enabled = false;
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
    protected void btFinish_ServerClick(object sender, EventArgs e)
    {
        if (gridRecords.Rows.Count < 1)
        {
            Response.Write("<script>alert('Недостатня кількість записів у файлі!');</script>");
            Response.Flush();
            return;
        }

        BankFileExt.UpdateDptHeader(Convert.ToDecimal(ins_header_id.Value));

        String inject = String.Empty;
        if (Convert.ToString(Request["gb"]) == "true")
            inject = "&gb=true";

        Response.Redirect("depositfile_ext.aspx?filename=" + FILENAME.Text +
            "&dat=" + DAT.Date.ToString("dd/MM/yyyy") + "&header_id=" + ins_header_id.Value + inject);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="e"></param>
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        dsBranch.SelectParameters["HEADER_ID"].DefaultValue = bf_header_id.Value;
        dsBranch.UpdateParameters["HEADER_ID"].DefaultValue = bf_header_id.Value;

        GetStatistics();
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Branch"></param>
    /// <returns></returns>
    public ListItemCollection GetSocAgency(Object Branch)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdLoadSocAgencies = connect.CreateCommand();
            cmdLoadSocAgencies.CommandText = "select agency_id, agency_name from v_socialagencies_ext where agency_branch = :branch and agency_type = :agency_type ";
            cmdLoadSocAgencies.Parameters.Add("branch", OracleDbType.Varchar2, Branch, ParameterDirection.Input);
            cmdLoadSocAgencies.Parameters.Add("agency_type", OracleDbType.Decimal, listAgencyType.SelectedValue, ParameterDirection.Input);

            ListItemCollection lc = new ListItemCollection();
            ListItem li = new ListItem();

            OracleDataReader rdr = cmdLoadSocAgencies.ExecuteReader();
            while (rdr.Read())
            {
                li = new ListItem(rdr.GetOracleString(1).Value,
                    Convert.ToString(rdr.GetOracleDecimal(0).Value));
                lc.Add(li);
            }

            if (!rdr.IsClosed) { rdr.Close(); rdr.Dispose(); }

            return lc;
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
    protected void gridRecords_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MARK_RECORD")
        {
            OracleConnection connect = new OracleConnection();

            try
            {
                // Открываем соединение с БД
                IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();
                

                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdIns = connect.CreateCommand();
                cmdIns.CommandText = @"update dpt_file_row set marked4payment = 1 where info_id = :info_id and ref is null";

                cmdIns.Parameters.Add("info_id", OracleDbType.Decimal,
                    Convert.ToDecimal(gridRecords.Rows[Convert.ToInt32(e.CommandArgument)].Cells[4].Text),
                ParameterDirection.Input);

                cmdIns.ExecuteNonQuery();
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }

            gridRecords.DataBind();
        }
        else if (e.CommandName == "UNMARK_RECORD")
        {
            OracleConnection connect = new OracleConnection();

            try
            {
                // Открываем соединение с БД
                IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();
                

                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdIns = connect.CreateCommand();
                cmdIns.CommandText = @"update dpt_file_row set marked4payment = 0 where info_id = :info_id and ref is null";

                cmdIns.Parameters.Add("info_id", OracleDbType.Decimal,
                    Convert.ToDecimal(gridRecords.Rows[Convert.ToInt32(e.CommandArgument)].Cells[4].Text),
                ParameterDirection.Input);

                cmdIns.ExecuteNonQuery();
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }

            gridRecords.DataBind();
        }        
    }
    /// <summary>
    /// 
    /// </summary>
    private void LoabGbAgencies(Decimal p_typeid)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdLoadGb = connect.CreateCommand();
            cmdLoadGb.CommandText = @"select name, agency_id from social_agency
                where branch = '/' || sys_context('bars_context', 'user_mfo') || '/'
                and type_id = :type_id
                and date_off is null";
            cmdLoadGb.Parameters.Add("type_id", OracleDbType.Decimal, p_typeid, ParameterDirection.Input);

            DataSet dsGb = new DataSet();

            OracleDataAdapter adapterFillAgenciesGb = new OracleDataAdapter();
            adapterFillAgenciesGb.SelectCommand = cmdLoadGb;
            adapterFillAgenciesGb.Fill(dsGb);

            ddAgencyInGb.DataSource = dsGb;
            ddAgencyInGb.DataValueField = "agency_id";
            ddAgencyInGb.DataTextField = "name";
            ddAgencyInGb.DataBind();
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
    protected void listAgencyType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Convert.ToString(Request["gb"]) == "true")
        {
            LoabGbAgencies(Convert.ToDecimal(listAgencyType.SelectedValue));
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ckIncorrect_CheckedChanged(object sender, EventArgs e)
    {
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";

        /// Перегляд прийнятого файлу
        if (Request["filename"] != null && Request["dat"] != null &&
            Request["header_id"] != null)
        {
            String filename = Convert.ToString(Request["filename"]);
            DateTime dat = Convert.ToDateTime(Convert.ToString(Request["dat"]), cinfo);
            Decimal header_id = Convert.ToDecimal(Convert.ToString(Request["header_id"]));

            BankFileExt bf = new BankFileExt(filename, dat, header_id);

            bf_filename.Value = bf.header.filename;
            bf_dat.Value = bf.header.dtCreated.ToString("dd/MM/yyyy");
            bf_header_id.Value = bf.header.id.ToString();

            if (!bf.IsPaid())
            {
                ShowRecords(bf);
                btPay.Disabled = false;
            }
            else
            {
                ShowRecordsNoUpdate(bf);
                btPay.Disabled = true;
            }
            gridRecords.DataBind();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ckExcluded_CheckedChanged(object sender, EventArgs e)
    {
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";

        /// Перегляд прийнятого файлу
        if (Request["filename"] != null && Request["dat"] != null &&
            Request["header_id"] != null)
        {
            String filename = Convert.ToString(Request["filename"]);
            DateTime dat = Convert.ToDateTime(Convert.ToString(Request["dat"]), cinfo);
            Decimal header_id = Convert.ToDecimal(Convert.ToString(Request["header_id"]));

            BankFileExt bf = new BankFileExt(filename, dat, header_id);

            bf_filename.Value = bf.header.filename;
            bf_dat.Value = bf.header.dtCreated.ToString("dd/MM/yyyy");
            bf_header_id.Value = bf.header.id.ToString();

            if (!bf.IsPaid())
            {
                ShowRecords(bf);
                btPay.Disabled = false;
            }
            else
            {
                ShowRecordsNoUpdate(bf);
                btPay.Disabled = true;
            }
            gridRecords.DataBind();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ckUnknown_CheckedChanged(object sender, EventArgs e)
    {
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";

        /// Перегляд прийнятого файлу
        if (Request["filename"] != null && Request["dat"] != null &&
            Request["header_id"] != null)
        {
            String filename = Convert.ToString(Request["filename"]);
            DateTime dat = Convert.ToDateTime(Convert.ToString(Request["dat"]), cinfo);
            Decimal header_id = Convert.ToDecimal(Convert.ToString(Request["header_id"]));

            BankFileExt bf = new BankFileExt(filename, dat, header_id);

            bf_filename.Value = bf.header.filename;
            bf_dat.Value = bf.header.dtCreated.ToString("dd/MM/yyyy");
            bf_header_id.Value = bf.header.id.ToString();

            if (!bf.IsPaid())
            {
                ShowRecords(bf);
                btPay.Disabled = false;
            }
            else
            {
                ShowRecordsNoUpdate(bf);
                btPay.Disabled = true;
            }

            gridRecords.DataBind();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private void GetStatistics()
    {
        if (!String.IsNullOrEmpty(bf_header_id.Value.Trim()))
        {
            Decimal header_id = Convert.ToDecimal(bf_header_id.Value);
            Decimal total_count = 0;
            Decimal total_sum = 0;
            Decimal paid_count = 0;
            Decimal paid_sum = 0;
            Decimal topay_count = 0;
            Decimal topay_sum = 0;
            Decimal our_count = 0;
            Decimal our_sum = 0;
            Decimal ex_count = 0;
            Decimal ex_sum = 0;

            OracleConnection connect = new OracleConnection();

            try
            {
                connect = OraConnector.Handler.IOraConnection.GetUserConnection();

                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmd = connect.CreateCommand();
                cmd.CommandText = "select sum/100, info_length from dpt_file_header where header_id = :header_id";
                cmd.Parameters.Add("header_id", OracleDbType.Decimal, header_id, ParameterDirection.Input);
                OracleDataReader rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    if (!rdr.IsDBNull(0))
                        total_sum = rdr.GetOracleDecimal(0).Value;
                    if (!rdr.IsDBNull(1))
                        total_count = rdr.GetOracleDecimal(1).Value;
                }

                if (!rdr.IsClosed) rdr.Close();
                rdr.Dispose();

                cmd.CommandText = "select sum(sum/100), count(*) from v_dpt_file_row where header_id = :header_id and ref is not null";
                rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    if (!rdr.IsDBNull(0))
                        paid_sum = rdr.GetOracleDecimal(0).Value;
                    if (!rdr.IsDBNull(1))
                        paid_count = rdr.GetOracleDecimal(1).Value;
                }

                if (!rdr.IsClosed) rdr.Close();
                rdr.Dispose();

                cmd.CommandText = "select sum(sum/100), count(*) from v_dpt_file_row where header_id = :header_id and marked4payment = 1";
                rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    if (!rdr.IsDBNull(0))
                        topay_sum = rdr.GetOracleDecimal(0).Value;
                    if (!rdr.IsDBNull(1))
                        topay_count = rdr.GetOracleDecimal(1).Value;
                }

                if (!rdr.IsClosed) rdr.Close();
                rdr.Dispose();

                cmd.CommandText = "select sum(sum/100), count(*) from v_dpt_file_row where header_id = :header_id";
                rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    if (!rdr.IsDBNull(0))
                        our_sum = rdr.GetOracleDecimal(0).Value;
                    if (!rdr.IsDBNull(1))
                        our_count = rdr.GetOracleDecimal(1).Value;
                }

                if (!rdr.IsClosed) rdr.Close();
                rdr.Dispose();

                cmd.CommandText = "select sum(sum/100), count(*) from v_dpt_file_row where header_id = :header_id and excluded = 1";
                rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    if (!rdr.IsDBNull(0))
                        ex_sum = rdr.GetOracleDecimal(0).Value;
                    if (!rdr.IsDBNull(1))
                        ex_count = rdr.GetOracleDecimal(1).Value;
                }

                if (!rdr.IsClosed) rdr.Close();
                rdr.Dispose();

                textStatistics.Text = "Загальна інформація про файл: кількість стрічок = " + Convert.ToString(total_count) + " сума = " + Convert.ToString(total_sum) + "\n" +
                "Видимих користувачу: кількість стрічок = " + Convert.ToString(our_count) + " сума = " + Convert.ToString(our_sum) + "\n" +
                "Зарахованих: кількість стрічок = " + Convert.ToString(paid_count) + " сума = " + Convert.ToString(paid_sum) + "\n" +
                "Виключених: кількість стрічок = " + Convert.ToString(ex_count) + " сума = " + Convert.ToString(ex_sum) + "\n" +
                "До зарахування: кількість стрічок = " + Convert.ToString(topay_count) + " сума = " + Convert.ToString(topay_sum);
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }
    }
}
