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
public partial class DepositAddRegular : Bars.BarsPage
{
    private readonly IDbLogger _dbLogger;
    private IContractRepository stoRepo;
    public DepositAddRegular()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
        stoRepo = new ContractRepository();
    }

    private String scheme
    {
        get
        {
            return Request["scheme"];
        }
    }
    public Decimal dpt_id
    {
        get
        {
            if (Request["dpt_id"] == null)
                Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");
            return Convert.ToDecimal(Request["dpt_id"]);
        }
    }
    
    protected DataSet dsRegular;
    private OracleDataAdapter adapterSearchAgreement;
    private int row_counter = 0;
    OracleConnection connect = new OracleConnection();

    public DateTime NextBankdate
    {
        get
        { // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            OracleCommand cmdNextBankdate = new OracleCommand();
            cmdNextBankdate.Connection = connect;
            cmdNextBankdate.CommandText = @"select DAT_NEXT_U(bankdate,1) from dual";
            DateTime NextBankdate = Convert.ToDateTime(cmdNextBankdate.ExecuteScalar());
            return NextBankdate;
        }
    }
    public Decimal MinSumm(decimal dpt_id)
    {       
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            OracleCommand cmdMinSumm = new OracleCommand();
            cmdMinSumm.Connection = connect;
            cmdMinSumm.CommandText = @"select nvl(dv.limit,0)      
                                               from dpt_deposit d, dpt_vidd dv
                                              where d.vidd = dv.vidd
                                                and d.deposit_id = :dpt_id";
            cmdMinSumm.Parameters.Add("dpt_id", OracleDbType.Decimal, Convert.ToDecimal(Request["dpt_id"]), ParameterDirection.Input);  
            Decimal MinSumm = Convert.ToDecimal(cmdMinSumm.ExecuteScalar());
            return MinSumm;  
   }
    /// <summary>
    /// Загрузка страницы
    /// </summary>
    private void Page_Load(object sender, EventArgs e)
    {
        if (Request["dpt_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement");

        if (Request["agr_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement");

        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositEditAccount;

        Decimal IDD = 0;

        Int64 agr_id = Convert.ToInt64(Request.QueryString["agr_id"]);
        RegisterClientScript();
        
        // Открываем соединение с БД
        IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
        connect = conn.GetUserConnection();
        
        OracleCommand cmdSetRole = new OracleCommand();
        cmdSetRole.Connection = connect;
        cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
        cmdSetRole.ExecuteNonQuery();       
 
       
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
        Deposit dpt = new Deposit(Convert.ToDecimal(Convert.ToString(Request["dpt_id"])),true);

        Int64 agr_id = Convert.ToInt64(Convert.ToString(Request["agr_id"]));
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
        textSumRegular.MinValue = Convert.ToDouble(MinSumm(Convert.ToDecimal(Convert.ToString(Request["dpt_id"]))));
        textSumRegular.Text = Convert.ToString(MinSumm(Convert.ToDecimal(Convert.ToString(Request["dpt_id"]))));
        Weekends.Checked = true;
        Weekends_1.Checked = false;
        textCur.Text = dpt.CurrencyName;
        StartDate.Text = NextBankdate.ToString("d");        
        nextBankDate.Value = Convert.ToString(NextBankdate.ToString("d"));
        MFO.Value = BankType.GetOurMfo();        
        MFO.Value = BankType.GetOurMfo();        
        //FillControlsFromClass(dpt);     

        btPrint.Enabled = false;

    }
 

    /// <summary>
    /// Сохранение информации из контролов в классе депозит
    /// </summary>
    /// <param name="dpt"></param>
    protected void FillClassFromControls(Deposit dpt)
    {
        // Счета выплаты процентов
        //dpt.IntReceiverName = textIntRcpName.Text;
        
        // Счета выплаты депозита
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
            string row_id = "r_" + row_counter;
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
        ClientScript.RegisterStartupScript(GetType(), ID + "Script_C", script);
    }

    //стандартная группа регулярных платежей "EBP Регулярні платежі поповнення депозитного договору з картрахунку"
    private readonly decimal STO_DPT_Group = 6;
    /// <summary>
    /// Нажатие на кнопку "Сохранить"
    /// </summary>
    protected void btnReg_ServerClick(object sender, EventArgs e)
    {
        Deposit dpt = new Deposit(Convert.ToDecimal(Request.QueryString["dpt_id"]), true);

        _dbLogger.Info("Пользователь начал оформление ДУ на регулярные платежи. Депозитный договор №" + dpt.ID,
            "deposit");
        
        String templateId = String.Empty;

        OracleConnection connect = new OracleConnection();
        OracleTransaction transaction = null;
        try
        {
            // Открываем транзакцию
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            transaction = connect.BeginTransaction();
            
            // Открываем транзакцию в репозитории STO
            stoRepo.BeginTransaction();

            var cultute = new System.Globalization.CultureInfo("uk-UA")
            {
                DateTimeFormat = { ShortDatePattern = "dd/MM/yyyy", DateSeparator = "/" }
            };

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

            _dbLogger.Info("Идентификатор договора по регулярным платежам = " + Convert.ToString(contract.IDS));
            DateTime p_DatBegin = DateTime.ParseExact(StartDate.Text, "dd/MM/yyyy", null);
            DateTime p_DatEnd = DateTime.ParseExact(EndDate.Text, "dd/MM/yyyy", null);
			
			 string tip;
            using (OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = "select BARS.get_nls_tip (:ptextBankAccount, :pcur_id) from dual";
                    cmd.Parameters.Add(new OracleParameter
                                            { ParameterName = "ptextBankAccount",
                                              OracleDbType = OracleDbType.Varchar2,
                                              Value = textBankAccount.Text,
                                              Direction = ParameterDirection.Input
                                            });
                    cmd.Parameters.Add(new OracleParameter
                                            {
                                              ParameterName = "pcur_id",
                                               OracleDbType = OracleDbType.Decimal,
                                               Value = Convert.ToDecimal(cur_id.Value),
                                               Direction = ParameterDirection.Input
                                               });
                    tip = cmd.ExecuteScalar().ToString();
                }
            }
            _dbLogger.Info("Тип рахунку = " + tip);
			
            // Начало заполнения макета платежа
            payment payment = new payment()
            {
                ord = Convert.ToDecimal(Proir.SelectedValue),
                vob = 6,
                dk = 1,
                nlsa = textBankAccount.Text,
                kva = Convert.ToDecimal(cur_id.Value),
                nlsb = textDPTAccount.Text,
                tt = (tip.Substring(0, 2) == "W4")  ? "PK!" : "191",
                WEND = -1,
                kvb = Convert.ToDecimal(cur_id.Value),
                mfob = MFO.Value,
                polu = NMK.Value,
                nazn = textNazn.Text,
                okpo = OKPO.Value,
                DAT1 = DateTime.ParseExact(StartDate.Text, "dd/MM/yyyy", null),
                DAT2 = DateTime.ParseExact(EndDate.Text, "dd/MM/yyyy", null),
                FREQ = Convert.ToDecimal(Freq.SelectedValue),
                DR = String.Empty,
                fsum = Convert.ToString(Convert.ToDecimal(textSumRegular.Value) * 100),
                IDS = contract.IDS
            };

            // Создание макета платежа
            Decimal idd = stoRepo.AddPayment(payment);

            // Создаем допсоглашение
            OracleCommand cmdCommand = connect.CreateCommand();
            Decimal pArgId = 0;
            cmdCommand.Parameters.Add("p_id", OracleDbType.Decimal, Convert.ToDecimal(Request["dpt_id"]), ParameterDirection.Input);
            cmdCommand.Parameters.Add("p_agrmnttype", OracleDbType.Decimal, 25, ParameterDirection.Input);
            cmdCommand.Parameters.Add("p_trustcustid", OracleDbType.Decimal, Request["rnk_tr"] == null ? Convert.ToString(dpt.Client.ID) : Convert.ToString(Request["rnk_tr"]), ParameterDirection.Input);
            cmdCommand.Parameters.Add("p_agr_id", OracleDbType.Decimal, pArgId, ParameterDirection.Output);

            const string sql = @"begin dpt_web.create_agreement(
                                                :p_id,
                                                :p_agrmnttype, 
                                                :p_trustcustid,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                :p_agr_id,
                                                'DPT_ARMREG');
                                            end;";
            cmdCommand.CommandText = sql;
            cmdCommand.ExecuteNonQuery();
            pArgId = Convert.ToDecimal(Convert.ToString(cmdCommand.Parameters["p_agr_id"].Value));
            _dbLogger.Info("Идентификатор новой додугоды 25 = " + Convert.ToString(pArgId));
            
            // Создаем связь допсоглашения с созданным макетом платежа
            OracleCommand cmdCommandIns = connect.CreateCommand();
            cmdCommandIns.Parameters.Add("p_id", OracleDbType.Decimal, idd, ParameterDirection.Input);
             cmdCommandIns.Parameters.Add("p_agr_id", OracleDbType.Decimal, pArgId, ParameterDirection.Input);
             cmdCommandIns.CommandText = "insert into sto_det_agr(IDD, AGR_ID) values(:p_idd,:p_agr_id)";
            cmdCommandIns.ExecuteNonQuery();

            IDD.Value = Convert.ToString(idd);
            _dbLogger.Info("Идентификатор нового регулярного платежа" + Convert.ToString(IDD.Value));            
            

            btPrint.Enabled = true;

            stoRepo.Commit();
            transaction.Commit();
        }
        catch(Exception ex)
        {
            if (transaction != null)
            {
                transaction.Rollback();
            }
            stoRepo.Rollback();
            throw;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        //Сохраняем данные в классе
        FillClassFromControls(dpt);

        _dbLogger.Info("Пользователь нажал кнопку \"Сохранить\" (договор на регулярные платежи).  Номер договора " + Convert.ToString(Request["dpt_id"]),
                "deposit");

       GridFill();
       ComboFill();
    }

    /// <summary>
    /// Назад (до картки договору)
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    /// 
    protected void btnBack_Click(object sender, EventArgs e)
    {
        String url = "/barsroot/deposit/deloitte/DepositContractInfo.aspx?dpt_id=" + Request.QueryString["dpt_id"];

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

        // Завантажуємо всі договора про регулярні платежі в наявності по клієнту        
        cmdSearch.CommandText = @"SELECT 
                                    distinct SD.ORD, 
                                    F.NAME FREQ, 
                                    TO_CHAR(SD.DAT1,'dd/mm/yyyy') DAT1,
                                    TO_CHAR(SD.DAT2,'dd/mm/yyyy') DAT2,
                                    SD.NLSA,
                                    SD.NLSB,
                                    decode(
                                        nvl(TRIM(TRANSLATE(SD.FSUM, ' +-.0123456789', ' ')),' '), ' ',to_char( to_number(SD.FSUM)/100,'9999999999999990D00'),'Формула'
                                        ) as FSUM,
                                    SD.NAZN,
                                    SD.USERID_MADE,
                                    SD.BRANCH_MADE,
                                    SD.BRANCH_CARD,
                                    SD.DATETIMESTAMP
                               FROM BARS.STO_GRP SG,
                                    BARS.STO_LST SA,
                                    BARS.STO_DET SD,
                                    V_FREQ_STO F
                              WHERE     SG.IDG = 6
                                    AND SA.IDG = SG.IDG
                                    AND SD.IDS = SA.IDS                                    
                                    AND SA.RNK = :rnk 
                                    AND F.FREQ = SD.FREQ 
                                order by 1";
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
        Freq.Items.Clear();
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandText = "select * from V_FREQ_STO";
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
                               FROM BARS.STO_GRP SG,
                                    BARS.STO_LST SA,
                                    BARS.STO_DET SD,
                                    V_FREQ_STO F
                              WHERE     SG.IDG = 6
                                    AND SA.IDG = SG.IDG
                                    AND SD.IDS = SA.IDS
                                    AND SA.RNK = :rnk
                                    AND F.FREQ = SD.FREQ";
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
        
        Proir.Items.Clear();
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
