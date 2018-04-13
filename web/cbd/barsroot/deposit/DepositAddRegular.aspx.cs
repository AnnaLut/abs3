using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Bars.Logger;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using System.Collections.Generic;

/// <summary>
/// Summary description for DepositAddRegular.
/// </summary>
public partial class DepositAddRegular : Bars.BarsPage
{
    # region Публичные свойства
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
    # endregion

    protected System.Data.DataSet dsRegular;
    private OracleDataAdapter adapterSearchAgreement;
    private int row_counter = 0;
    OracleConnection connect = new OracleConnection();

    /// <summary>
    /// Загрузка страницы
    /// </summary>
    private void Page_Load(object sender, System.EventArgs e)
    {
        if (Request["dpt_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement");

        if (Request["agr_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement");

        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositEditAccount;

        Decimal IDD = 0;

        Int32 agr_id = Convert.ToInt32(Request.QueryString["agr_id"]);
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
        Deposit dpt = new Deposit(Convert.ToDecimal(Convert.ToString(Request["dpt_id"])));

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

    /// <summary>
    /// Нажатие на кнопку "Сохранить"
    /// </summary>
    protected void btnReg_ServerClick(object sender, EventArgs e)
    {
        Deposit dpt = new Deposit(Convert.ToDecimal(Request.QueryString["dpt_id"]));

        DBLogger.Info("Пользователь начал оформление ДУ на регулярные платежи. Депозитный договор №" + dpt.ID,
            "deposit");
        
        String templateId = String.Empty;
        Decimal agrId = Decimal.MinValue;

        OracleConnection connect = new OracleConnection();
        OracleTransaction transaction = null; 
        try
        {
            // Создаем соединение
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            
            connect = conn.GetUserConnection();
            transaction = connect.BeginTransaction();

            // Открываем соединение с БД
            // Установка роли
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");

            Decimal p_IDG = 6; // STO_GRP. EBP Регулярні платежі поповнення депозитного договору з картрахунку
            Decimal p_IDS = 0;
            DateTime p_SDAT = DateTime.Now.Date;           

            OracleCommand cmdMakeRegularLST = connect.CreateCommand();
            cmdMakeRegularLST.Parameters.Clear();
            cmdMakeRegularLST.Parameters.Add("IDG", OracleDbType.Decimal, p_IDG, ParameterDirection.Input);
            cmdMakeRegularLST.Parameters.Add("p_IDS", OracleDbType.Decimal, p_IDS, ParameterDirection.Output);
            cmdMakeRegularLST.Parameters.Add("RNK", OracleDbType.Decimal, rnk.Value, ParameterDirection.Input);
            cmdMakeRegularLST.Parameters.Add("NAME", OracleDbType.Varchar2, ("Regular "+NMK.Value), ParameterDirection.Input);
            cmdMakeRegularLST.Parameters.Add("SDAT", OracleDbType.Date, p_SDAT, ParameterDirection.Input);            
            cmdMakeRegularLST.CommandText = "begin sto_all.add_RegularLST(:IDG, :p_IDS, :RNK, :NAME, :SDAT); end;";
            cmdMakeRegularLST.ExecuteNonQuery();

            p_IDS = Convert.ToDecimal(Convert.ToString(cmdMakeRegularLST.Parameters["p_IDS"].Value));                

            DBLogger.Info("Идентификатор клиента по регулярным платежам = " + Convert.ToString(cmdMakeRegularLST.Parameters["p_IDS"].Value));            
            
            Decimal p_ord = Convert.ToDecimal(Proir.SelectedValue);            
            Decimal p_vob = 6;
            Decimal p_dk = 1;
            String  p_nlsa = textBankAccount.Text;
            Decimal p_kva = Convert.ToDecimal(cur_id.Value);
            String p_tt = "";
            if (p_nlsa.Substring(0, 4) == "2625") { p_tt = "PK!"; }
            if (p_nlsa.Substring(0, 4) == "2620" || p_nlsa.Substring(0, 3) == "263")
            {
                if (p_kva == 980) { p_tt = "DP0"; }
                else { p_tt = "DPD"; }
            }            
            String p_nlsb = textDPTAccount.Text;
            Decimal p_kvb = Convert.ToDecimal(cur_id.Value);
            String p_mfob = MFO.Value;
            String p_polu = NMK.Value;
            String p_nazn = textNazn.Text;
            Decimal p_sum = Convert.ToDecimal(textSumRegular.Value)*100;
            String p_okpo = OKPO.Value;
            DateTime p_DatBegin = Convert.ToDateTime(StartDate.Text);
            DateTime p_DatEnd = Convert.ToDateTime(EndDate.Text);
            Decimal p_freq = Convert.ToDecimal(Freq.SelectedValue);
            Decimal p_wend = -1;
            Decimal p_idd = 0;
            Decimal p_status = 0;
            String p_status_text = "";
            if (Convert.ToDecimal(Weekends_1.Checked) == 1)
            {
                p_wend = 1;
            }
            String p_dr = String.Empty;      
               
            OracleCommand cmdMakeRegular = connect.CreateCommand();         

            cmdMakeRegular.Parameters.Add("IDS", OracleDbType.Decimal, p_IDS, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("ord", OracleDbType.Decimal, p_ord, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("tt", OracleDbType.Varchar2, p_tt, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("vob", OracleDbType.Decimal, p_vob, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("dk", OracleDbType.Decimal, p_dk, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("nlsa", OracleDbType.Varchar2, p_nlsa, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("kva", OracleDbType.Decimal, p_kva, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("nlsb", OracleDbType.Varchar2, p_nlsb, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("kvb", OracleDbType.Decimal, p_kvb, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("mfob", OracleDbType.Varchar2, p_mfob, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("polu", OracleDbType.Varchar2, p_polu, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("nazn", OracleDbType.Varchar2, p_nazn, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("fsum", OracleDbType.Decimal, p_sum, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("okpo", OracleDbType.Varchar2, p_okpo, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("DAT1", OracleDbType.Date, p_DatBegin, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("DAT2", OracleDbType.Date, p_DatEnd, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("FREQ", OracleDbType.Decimal, p_freq, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("WEND", OracleDbType.Decimal, p_wend, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("DR", OracleDbType.Varchar2, p_dr, ParameterDirection.Input);
            cmdMakeRegular.Parameters.Add("p_idd", OracleDbType.Decimal, p_idd, ParameterDirection.Output);
            cmdMakeRegular.Parameters.Add("p_status", OracleDbType.Decimal, p_status, ParameterDirection.Output);
            cmdMakeRegular.Parameters.Add("p_status_text", OracleDbType.Varchar2, p_status_text, ParameterDirection.Output);

            cmdMakeRegular.CommandText = @"begin sto_all.Add_RegularTreaty( 
                                                        :IDS, 
                                                        :ord, 
                                                        :tt, 
                                                        :vob, 
                                                        :dk, 
                                                        :nlsa, 
                                                        :kva, 
                                                        :nlsb, 
                                                        :kvb, 
                                                        :mfob, 
                                                        :polu, 
                                                        :nazn,
                                                        :fsum, 
                                                        :okpo, 
                                                        :DAT1, 
                                                        :DAT2, 
                                                        :FREQ, 
                                                        null,
                                                        :WEND, 
                                                        :DR, 
                                                        null,
                                                        1,
                                                        sysdate, 
                                                        :p_idd, 
                                                        :p_status, 
                                                        :p_status_text); 
                                            end;";
            
            OracleDataReader rdr = cmdMakeRegular.ExecuteReader();

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
            p_idd = Convert.ToDecimal(Convert.ToString(cmdMakeRegular.Parameters["p_idd"].Value));
            pArgId = Convert.ToDecimal(Convert.ToString(cmdCommand.Parameters["p_agr_id"].Value));

            OracleCommand cmdCommandIns = connect.CreateCommand();
            cmdCommandIns.Parameters.Add("p_id", OracleDbType.Decimal, p_idd, ParameterDirection.Input);
            cmdCommandIns.Parameters.Add("p_id", OracleDbType.Decimal, pArgId, ParameterDirection.Input);
            cmdCommandIns.CommandText = "insert into sto_det_agr values(:p_idd,:p_agr_id)";
            cmdCommandIns.ExecuteNonQuery();

            IDD.Value = Convert.ToString(p_idd); 
            DBLogger.Info("Идентификатор ноого регулярного платежа" + Convert.ToString(IDD.Value));            
            
            if (p_idd != 0) 
            {
                btPrint.Enabled = true;
            }
            transaction.Commit();
            rdr.Close();
            rdr.Dispose();   
        }
        catch(Exception)
        {
            if (transaction != null) transaction.Rollback();
            throw;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        //Сохраняем данные в классе
        FillClassFromControls(dpt);

        DBLogger.Info("Пользователь нажал кнопку \"Сохранить\" (договор на регулярные платежи).  Номер договора " + Convert.ToString(Request["dpt_id"]),
                "deposit");

        GridFill();
        ComboFill();
        //String add_tr = "&rnk_tr=" + (Request["rnk_tr"] == null ? Convert.ToString(dpt.Client.ID) : Request.QueryString["rnk_tr"]);
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
                                    TO_CHAR(SD.DAT1,'dd/mm/rr') DAT1,
                                    TO_CHAR(SD.DAT2,'dd/mm/rr') DAT2,
                                    SD.NLSA,
                                    SD.NLSB,
                                    decode(
                                        nvl(TRIM(TRANSLATE(SD.FSUM, ' +-.0123456789', ' ')),' '), ' ',to_char( to_number(SD.FSUM)/100,'9999999999999990D00'),'Формула'
                                        ) as FSUM,
                                    SD.NAZN
                                FROM 
                                    BARS.STO_LST SA,
                                    BARS.STO_DET SD,
                                    FREQ F
                                Where 
                                    SD.IDS = SA.IDS 
                                    and SA.RNK = :rnk 
                                    and F.FREQ = SD.FREQ 
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
