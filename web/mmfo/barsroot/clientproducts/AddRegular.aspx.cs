using System;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web.UI.WebControls;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using System.Collections.Generic;
using BarsWeb.Core.Logger;
using BarsWeb.Areas.Sto.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sto.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.Sto;

/// <summary>
/// Summary description for DepositAddRegular.
/// </summary>
public partial class AddRegular : Bars.BarsPage
{
    private String scheme
    {
        get
        {
            return Request["scheme"];
        }
    }

    protected DataSet dsRegular;
    private OracleDataAdapter adapterSearchAgreement;
    private int row_counter = 0;
    OracleConnection connect = new OracleConnection();
    private readonly IDbLogger _dbLogger;

    private IContractRepository stoRepo;

    public AddRegular()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
        stoRepo = new ContractRepository();
    }
    /// <summary>
    /// Загрузка страницы
    /// </summary>
    private void Page_Load(object sender, System.EventArgs e)
    {
       
        Page.Header.Title = "Кредиты (погашение с картсчетов)";

        Int32 agr_id = Convert.ToInt32(Request.QueryString["agr_id"]);
        RegisterClientScript();
        
        // Открываем соединение с БД
        IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
        connect = conn.GetUserConnection();
        
        OracleCommand cmdSetRole = new OracleCommand();
        cmdSetRole.Connection = connect;
        cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
        cmdSetRole.ExecuteNonQuery();

        GridFill(); 
 
        if (!IsPostBack)
        {
            GridFill(); 
            ComboFill();
            InitControls();
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
        this.dsRegular = new System.Data.DataSet();
        ((System.ComponentModel.ISupportInitialize)(this.dsRegular)).BeginInit();
        //this.dsRegular.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.gridRegular_ItemDataBound);
     
        this.dsRegular.DataSetName = "NewDataSet";
        this.dsRegular.Locale = new System.Globalization.CultureInfo("uk-UA");        
        ((System.ComponentModel.ISupportInitialize)(this.dsRegular)).EndInit();
       

    }
    #endregion
    /// <summary>
    /// Инициализация контролов
    /// </summary>
    protected void InitControls()
    {
        Deposit dpt = new Deposit(Convert.ToDecimal(Convert.ToString(Request["dpt_id"])), true);

        Int32 agr_id = Convert.ToInt32(Convert.ToString(Request["agr_id"]));
        DateTime date_now = DateTime.Now.Date;        
        cur_id.Value = dpt.Currency.ToString();
        rnk.Value = dpt.Client.ID.ToString();
        NMK.Value = dpt.Client.Name;
        OKPO.Value = dpt.Client.Code;
        textClientName.Text = dpt.Client.Name;
        textContractType.Text = dpt.TypeName;
        textContractID.Text = Convert.ToString(Request["dpt_id"]);
        textBankAccount.Text = dpt.IntReceiverCARDN;

        textBankMFO.Text = BankType.GetOurMfo();
        textIntRcpName.Text = dpt.Client.Name;
        textIntRcpOKPO.Text = dpt.Client.Code;
        textNazn.Text = "Поповнення вкладу №" + Convert.ToString(Request["dpt_id"]) + " згідно ДУ від " + Convert.ToString(date_now.ToString("d"));
        textDPTAccount.Text = dpt.dpt_nls;
        textSumRegular.Text = Convert.ToString(dpt.Sum);
        Weekends.Checked = true;
        Weekends_1.Checked = false;
        textCur.Text = dpt.CurrencyName;
        StartDate.Text = Convert.ToString(date_now.ToString("d"));
        MFO.Value = BankType.GetOurMfo();        
        MFO.Value = BankType.GetOurMfo();        
        //FillControlsFromClass(dpt);     

        btPrint.Enabled = false;
    }
    
    /// <summary>
    /// Локализация DataGrid
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        // Локализируем грид
        if (gridRegular.Controls.Count > 0)
        {
            Table tb = gridRegular.Controls[0] as Table;         

        }
    }

    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void gridRegular_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();
            DataGridItem row = e.Item;
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S('" + row_counter + "','" + row.Cells[2].Text + "')");
        }
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
			function S(id,rnk)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('rnk').value = rnk;
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script_C", script);
    }

    //стандартная группа регулярных платежей "EBP Регулярні платежі поповнення депозитного договору з картрахунку"
    private readonly decimal STO_DPT_Group = 6;

    /// <summary>
    /// Нажатие на кнопку "Сохранить"
    /// </summary>
    protected void btnReg_ServerClick(object sender, System.EventArgs e)
    {
        Deposit dpt = new Deposit(Convert.ToDecimal(Request.QueryString["dpt_id"]), true);

        _dbLogger.Info("Пользователь начал оформление ДУ на регулярные платежи. Депозитный договор №" + dpt.ID.ToString(),
            "deposit");
        
        String template_id = String.Empty;
        Decimal agr_id = Decimal.MinValue;

        OracleConnection connect = new OracleConnection();

        try
        {
            // Создаем соединение
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            // Открываем соединение с БД
            // Установка роли
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");

            // Создание договора на выполнение регулярных платежей
            ids contract = new ids(Convert.ToDecimal(rnk.Value), STO_DPT_Group, ("Regular " + NMK.Value))
            {
                SDAT = DateTime.Now.Date
            };
            if (stoRepo.ContractData().Where(x => x.RNK == contract.RNK && x.IDG == contract.IDG).Any())
            {
                // если есть уже для этого клиента и группы - берем существующий
                contract.IDS = stoRepo.ContractData().Where(x => x.RNK == contract.RNK && x.IDG == contract.IDG).First().IDS;
            }
            stoRepo.AddIDS(contract);

            payment payment = new payment()
            {
                idd = 0,
                ord = Convert.ToDecimal(Proir.SelectedValue),
                tt = "DPA",
                vob = 6,
                dk = 1,
                nlsa = textBankAccount.Text,
                kva = Convert.ToDecimal(cur_id.Value),
                nlsb = textDPTAccount.Text,
                kvb = Convert.ToDecimal(cur_id.Value),
                mfob = MFO.Value,
                polu = NMK.Value,
                nazn = textNazn.Text,
                fsum = textSumRegular.Value.ToString(),
                okpo = OKPO.Value,
                DAT1 = Convert.ToDateTime(StartDate.Text),
                DAT2 = Convert.ToDateTime(EndDate.Text),
                FREQ = Convert.ToDecimal(Freq.SelectedValue),
                WEND = Convert.ToDecimal(Weekends_1.Checked) == 1 ? -1 : 1,
                DR = String.Empty
            };
            payment.idd = stoRepo.AddPayment(payment);

            
            _dbLogger.Info(Convert.ToString(payment.idd));

            IDD.Value = Convert.ToString(payment.idd); 
            _dbLogger.Info(Convert.ToString(IDD.Value));            
            
            if (payment.idd != 0) 
            {
                btPrint.Enabled = true;
            }

            GridFill();
            ComboFill();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        _dbLogger.Info("Пользователь нажал кнопку \"Сохранить\" (договор на регулярные платежи).  Номер договора " + Convert.ToString(Request["dpt_id"]),
                "deposit");

        String add_tr = "&rnk_tr=" + (Request["rnk_tr"] == null ? Convert.ToString(dpt.Client.ID) : Request.QueryString["rnk_tr"]);
    }

    /// <summary>
    /// Назад (до картки договору)
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    /// 
    protected void btnBack_Click(object sender, EventArgs e)
    {
        String url = "/barsroot/deposit/DepositContractInfo.aspx?dpt_id=" + Request.QueryString["dpt_id"];

        if (Request["rnk_tr"] != null)
            url += "&rnk_tr=" + Request.QueryString["rnk_tr"];

        if (Request["scheme"] != null)
            url += "&scheme=" + Request.QueryString["scheme"];
        
        Response.Redirect( url );
    }

    /// <summary>
    /// 
    /// </summary>
    protected void GridFill()
    {   
        OracleCommand cmdSearch = new OracleCommand();
        cmdSearch.Connection = connect;

        /// Завантажуємо всі договора про регулярні платежі в наявності по клієнту        
        cmdSearch.CommandText = @"SELECT distinct SD.ORD, F.NAME FREQ, TO_CHAR(SD.DAT1,'dd/mm/rr') DAT1, TO_CHAR(SD.DAT2,'dd/mm/rr') DAT2 ,SD.NLSA, SD.NLSB, SD.FSUM, SD.NAZN
                    FROM BARS.STO_LST SA, BARS.STO_DET SD, FREQ F
                    Where SD.IDS = SA.IDS and SA.RNK = :rnk and F.FREQ = SD.FREQ order by 1";
        cmdSearch.Parameters.Add("rnk", OracleDbType.Decimal, Request.QueryString["rnk_tr"], ParameterDirection.Input);       

        adapterSearchAgreement = new OracleDataAdapter();
        adapterSearchAgreement.SelectCommand = cmdSearch;        
        adapterSearchAgreement.Fill(dsRegular);
        
        gridRegular.DataSource = dsRegular;
        gridRegular.DataBind();

        gridRegular.HeaderStyle.BackColor = Color.WhiteSmoke;
        gridRegular.HeaderStyle.Font.Bold = true;
        gridRegular.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        
    }

    protected void ComboFill()
    {
        /// Регулярные платежи
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandText = "select * from BARS.FREQ order by FREQ";
            var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                Freq.Items.Add(new ListItem()
                {
                    Value = Convert.ToString(reader["FREQ"]),
                    Text = Convert.ToString(reader["NAME"])
                });
            }      
        
        OracleCommand cmd2 = con.CreateCommand();
        cmd2.CommandText = @"SELECT SD.ORD
                            FROM BARS.STO_LST SA, BARS.STO_DET SD, FREQ F
                            Where SD.IDS = SA.IDS and SA.RNK = :rnk and F.FREQ = SD.FREQ";
        cmd2.Parameters.Add("rnk", OracleDbType.Decimal, Request.QueryString["rnk_tr"], ParameterDirection.Input);

        var reader2 = cmd2.ExecuteReader();
        var listExist = new List<decimal>();

        while (reader2.Read())
        {
            listExist.Add(Convert.ToDecimal(reader2["ord"]));
        }
        decimal max = 0;
        if (listExist.Count() > 0)
        {
            max = listExist.AsEnumerable().Max();
        }
        
       
        for (decimal i = 1; i < max + 6; i++)
        {
            if (listExist.FirstOrDefault(item => item == i) == 0)
            {
                Proir.Items.Add(new ListItem()
                {
                    Value = Convert.ToString(i),
                    Text = Convert.ToString(i)
                });
            }
        } 
    }

    protected void btPrint_Click(object sender, EventArgs e)
    {
       
        IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
        connect = conn.GetUserConnection();
        OracleCommand cmdSearch_branch = new OracleCommand();
        cmdSearch_branch.Connection = connect;
        cmdSearch_branch.CommandText = @"SELECT branch from dpt_deposit where deposit_id = :deposit_id";
        cmdSearch_branch.Parameters.Add("deposit_id", OracleDbType.Decimal, Request["dpt_id"], ParameterDirection.Input);
        String branch = Convert.ToString(cmdSearch_branch.ExecuteScalar());
        
            // Друк Заяви
            FrxParameters pars = new FrxParameters();
            pars.Add(new FrxParameter("rnk", TypeCode.Int64, Request.QueryString["rnk_tr"]));
            pars.Add(new FrxParameter("branch", TypeCode.String, branch));
            pars.Add(new FrxParameter("IDD", TypeCode.String, IDD.Value));

            String template = ("dpt_agrmreg");

            FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(template)), pars, this.Page);

            // выбрасываем в поток в формате PDF
            doc.Print(FrxExportTypes.Pdf);
            GridFill();
            
    }

}
