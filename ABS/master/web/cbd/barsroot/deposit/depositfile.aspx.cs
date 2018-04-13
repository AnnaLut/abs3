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

		if (!IsPostBack)
		{
            if (Convert.ToString(Request["mode"]) != "copy")
            {
                Session["BF_HEADER_ID"] = String.Empty;
                Session["BF_FILENAME"] = String.Empty;
                Session["BF_DAT"] = String.Empty;
            }

            gridRecords.HeaderStyle.Font.Bold = true;
            gridRecords.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;

			LoadFileTypes();

            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            /// Створюємо вручну новий файл
            if (Convert.ToString(Request["mode"]) == "create")
            {
                DAT.Date = DateTime.Now.Date;
                FILENAME.Text = BankFile.GetUFilename();
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

				String filename = Convert.ToString(Request["filename"]);
				DateTime dat = Convert.ToDateTime(Convert.ToString(Request["dat"]),cinfo);
                Decimal header_id = Convert.ToDecimal(Convert.ToString(Request["header_id"]));

				BankFile bf = new BankFile(filename,dat,header_id);
				
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

				BankFile bf = new BankFile(Convert.ToString(bf_filename.Value),
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
            sourceControl.GetType().Name == "DataControlLinkButton"	||
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

                BankFile bf = new BankFile(filename, dat,header_id);

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
                BankFile bf = new BankFile(filename, dat, header_id);
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

        if (btCreateHeader.Disabled)
            gridRecords.AutoGenerateNewButton = true;

        dsRecords.SelectParameters.Clear();
        dsRecords.InsertParameters.Clear();
        dsRecords.UpdateParameters.Clear();
        dsRecords.DeleteParameters.Clear();

        dsRecords.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsRecords.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

        dsRecords.DeleteCommand = "DELETE FROM DPT_FILE_ROW WHERE INFO_ID = :old_INFO_ID";
        
        dsRecords.UpdateCommand = "UPDATE DPT_FILE_ROW " +
            "SET NLS = :NLS, BRANCH_CODE = :BRANCH_CODE, DPT_CODE = :DPT_CODE, SUM = :SUM * 100, " +
            "FIO = :FIO, PASP = :PASP " +
            "WHERE INFO_ID = :old_INFO_ID";

        dsRecords.InsertCommand = " begin dpt_social.create_file_row( " +
                " to_number('" + Convert.ToString(Session["BF_HEADER_ID"]) + "'), '" + FILENAME.Text +
                "', to_date('" + DAT.Date.ToString("dd/MM/yyyy") + "','dd/MM/yyyy'), " +
                " :NLS,:BRANCH_CODE,:DPT_CODE,:SUM * 100,:FIO,:PASP, " +
                " :INFO_ID); end;";

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

        par = new Parameter("PASP", TypeCode.String);
        par.Size = 16;
        dsRecords.UpdateParameters.Add(par);
        dsRecords.InsertParameters.Add(par);

        par = new Parameter("old_INFO_ID", TypeCode.Decimal);
        par.Size = 18;
        dsRecords.DeleteParameters.Add(par);
        dsRecords.UpdateParameters.Add(par);
        dsRecords.InsertParameters.Add(par);

        dsRecords.SelectCommand = "SELECT INFO_ID, NLS, " +
            "BRANCH_CODE, DPT_CODE, to_char(SUM/100,'9999999999999999990.99') SUM, " +
            "FIO, PASP,NULL AS REF, " +
            "incorrect,closed,excluded, BRANCH, AGENCY_NAME " +
            "FROM DPT_FILE_ROW WHERE header_id = to_number('" + Convert.ToString(Session["BF_HEADER_ID"]) +
            "') order by info_id";

        // gridRecords.DataBind();
    }
    /// <summary>
	/// 
	/// </summary>
	/// <param name="bf"></param>
	private void ShowRecords(BankFile bf)
	{
        dsRecords.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsRecords.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

        dsRecords.SelectCommand = "SELECT '<A href=# onclick=\"Correct('||info_id||')\">'||INFO_ID||'</a>' INFO_ID, NLS, " +
            "BRANCH_CODE,DPT_CODE,to_char(SUM/100,'9999999999999999990.99') SUM, FIO, PASP, REF, incorrect, closed, excluded,BRANCH,AGENCY_NAME " +
            "FROM V_DPT_FILE_ROW WHERE header_id = " + bf.header.id.ToString() + " order by info_id ";
        dsRecords.DataBind();

		gridRecords.HeaderStyle.Font.Bold = true;
		gridRecords.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;

        listTypes.SelectedIndex = listTypes.Items.IndexOf(
            listTypes.Items.FindByValue(bf.type_id.ToString()));
        
        listAgencyType.SelectedIndex = listAgencyType.Items.IndexOf(
            listAgencyType.Items.FindByValue(bf.AGENCY_TYPE.ToString()));

        listTypes.Enabled = false;
        listAgencyType.Enabled = false;
	}		
	/// <summary>
	/// 
	/// </summary>
	/// <param name="bf"></param>
	private void ShowRecordsNoUpdate(BankFile bf)
	{
        /// З підстановкою дат в нас тут ГРОМАДНІ проблеми - тому вставляємо прямо
        dsRecords.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsRecords.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

		dsRecords.SelectCommand = "SELECT INFO_ID, NLS, " +
            "BRANCH_CODE, DPT_CODE, to_char(SUM/100,'9999999999999999990.99') SUM, FIO, PASP, " +
            "'<A href=# onclick=''ShowDocCard('||REF||')''>'||REF||'</a>' AS REF, " +
            "incorrect,closed,excluded,BRANCH, AGENCY_NAME " +
            "FROM V_DPT_FILE_ROW WHERE header_id = " + bf.header.id.ToString() + " order by info_id ";

        dsRecords.DataBind();
		
        gridRecords.HeaderStyle.Font.Bold = true;
		gridRecords.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;

        listTypes.SelectedIndex = listTypes.Items.IndexOf(
            listTypes.Items.FindByValue(bf.type_id.ToString()));
        listAgencyType.SelectedIndex = listAgencyType.Items.IndexOf(
            listAgencyType.Items.FindByValue(bf.AGENCY_TYPE.ToString()));

        listTypes.Enabled = false;
        listAgencyType.Enabled = false;
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

			BankFile bf = new BankFile(arr);
			bf.type_id = Convert.ToDecimal(listTypes.SelectedValue);
            bf.AGENCY_TYPE = Convert.ToDecimal(listAgencyType.SelectedValue);
			
			//bf_filename.Value = bf.header.filename;
			//bf_dat.Value = bf.header.dtCreated.ToString("dd/MM/yyyy");

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

		BankFile bf = new BankFile(Convert.ToString(bf_filename.Value),
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

		bf.Pay();
		btPay.Disabled = true;
		
		ShowRecordsNoUpdate(bf);

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
			cmdLoadTypes.CommandText = "SELECT type_id, type_name FROM SOCIAL_FILE_TYPES";

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
    protected void gridRecords_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();            
            GridViewRow row = e.Row;
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S_A('" + row_counter + "')");

            if (Convert.ToString(((DataRowView)e.Row.DataItem).Row[8]) == "1")
                row.ForeColor = Color.Red;
            if (Convert.ToString(((DataRowView)e.Row.DataItem).Row[9]) == "1")
                row.ForeColor = Color.Orange;
            if (Convert.ToString(((DataRowView)e.Row.DataItem).Row[10]) == "1")
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

        //OracleConnection connect = new OracleConnection();

        //try
        //{
        //    // Открываем соединение с БД
        //    IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
        //    connect = conn.GetUserConnection();
        //    

        //    OracleCommand cmdSetRole = connect.CreateCommand();
        //    cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
        //    cmdSetRole.ExecuteNonQuery();

        //    OracleCommand cmdInsFirst = connect.CreateCommand();
        //    cmdInsFirst.CommandText = " begin dpt_social.create_file_row( " +
        //        " to_number('" + Convert.ToString(Session["BF_HEADER_ID"]) + "'), '" + FILENAME.Text +
        //        "', to_date('" + DAT.Date.ToString("dd/MM/yyyy") + "','dd/MM/yyyy'), " +
        //        " null,null,null,null,null,null,null, " +
        //        " 0,0,0, :INFO_ID); end;";
        //    Decimal dummy = Decimal.MinValue;
        //    cmdInsFirst.Parameters.Add("INFO_ID", OracleDbType.Decimal, dummy, ParameterDirection.Output);

        //    cmdInsFirst.ExecuteNonQuery();
        //}
        //finally
        //{
        //    if (connect.State != ConnectionState.Closed)
        //    { connect.Close(); connect.Dispose(); }
        //}

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
                "  :dest,:branch_num,:dpt_code,:exec_ord,:ks_ep,:type_id,:AGENCY_TYPE,:header_id); " +
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

        BankFile.UpdateDptHeader(Convert.ToDecimal(ins_header_id.Value));

        Response.Redirect("depositfile.aspx?filename=" + FILENAME.Text +
            "&dat=" + DAT.Date.ToString("dd/MM/yyyy") + "&header_id=" + ins_header_id.Value);
    }

    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        dsBranch.SelectParameters["HEADER_ID"].DefaultValue = bf_header_id.Value;
        dsBranch.UpdateParameters["HEADER_ID"].DefaultValue = bf_header_id.Value;
        //dsBranch.UpdateParameters["BRANCH"].DefaultValue = "/321983/00046/";
    }

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
}
