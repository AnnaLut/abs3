using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Oracle;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System.Globalization;
using Bars.Exception;

public partial class safe_deposit_Attorney : System.Web.UI.Page
{
    int row_counter = 0;
    /// <summary>
    /// 
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        RegisterClientScript();

        if (!IsPostBack)
        {
            InitLists();
            if (Request["safe_id"] == null || Request["SKRN_ND"] == null)
                throw new SafeDepositException("Некоректний запит!");

            NUM.Text = safe_deposit.GetNumById(Convert.ToDecimal(Convert.ToString(Request["safe_id"])));
            REF.Text = Convert.ToString(Request["SKRN_ND"]);
            SAFENUM.Text = Convert.ToString(Request["safe_id"]);
            PERSON.Text = safe_deposit.GetOwnerByNum(Convert.ToDecimal(Convert.ToString(Request["SKRN_ND"])));
            DPT_ID.Value =  Convert.ToString(Request["SKRN_ND"]);
        }

     
        FillGrid();
    }
    /// <summary>
    /// 
    /// </summary>
    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        if (sourceControl.GetType().Name == "BarsGridViewEx" || (eventArgument != null && eventArgument.Length > 4 && eventArgument.Substring(0, eventArgument.IndexOf("$")) == "Bars"))
        { FillGrid(); }

        base.RaisePostBackEvent(sourceControl, eventArgument);
    }
    /// <summary>
    /// 
    /// </summary>
    private void InitLists()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            connect = conn.GetUserConnection();


            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();
           
            OracleCommand cmdGetBankDate = connect.CreateCommand();
            cmdGetBankDate.CommandText = "select to_char(bankdate,'dd/mm/yyyy') from dual";
            BANKDATE.Value = Convert.ToString(cmdGetBankDate.ExecuteScalar());

            OracleCommand cmdGetMode = connect.CreateCommand();
            cmdGetMode.CommandText = "SELECT nvl(substr(val,1),0) FROM params WHERE par='SKRN_ACC'";
            String mode = Convert.ToString(cmdGetMode.ExecuteScalar());
            /// Індивідуальні рахунки
            if (mode == "1")
            {
              //  btOpen.OnClientClick = "return OpenSafeEx(1)";
            }
            /// Котлові рахунки
            else
            {
                //btOpen.OnClientClick = "return OpenSafe()";
            }
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
    private void FillGrid()
    {
        dsSafeDepositAttorney.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsSafeDepositAttorney.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DEP_SKRN");
        dsSafeDepositAttorney.SelectParameters.Clear();
        dsSafeDepositAttorney.WhereParameters.Clear();

        String selectCommand = "select t1.rnk as RNK, " +
               "T1.ND as ND, " +
               "T2.NMK as NMK, " +
               "T2.OKPO as OKPO, " +
               "(select t3.ser||t3.numdoc from person t3 where t3.rnk = t2.rnk and t3.passp = 1)  as NUMDOC, " +
               "TO_CHAR(t1.date_from, 'DD/MM/YYYY') as DATE_FROM , " +
               "TO_CHAR(t1.date_to, 'DD/MM/YYYY') as DATE_TO, " +
               "TO_CHAR(t1.cancel_date, 'DD/MM/YYYY') as CANCEL_DATE " +
            "from bars.skrynka_attorney T1, CUSTOMER T2 " +
            " WHERE T1.RNK = T2.RNK" +
            " and t1.ND = :ND " +
            " and trunc(t1.date_to) >= trunc(sysdate)";

        dsSafeDepositAttorney.SelectParameters.Add("ND", TypeCode.Decimal, REF.Text);
        
        dsSafeDepositAttorney.SelectCommand = selectCommand;
        gridSafeDepositAttorney.DataBind();
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
            var lastColor;
			function S_A(id,rnk)
			{
			 if(selectedRow != null) selectedRow.style.backgroundColor = lastColor;
			 lastColor = document.getElementById('r_'+id).style.backgroundColor;
             document.getElementById('r_'+id).style.backgroundColor = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('RNK').value = rnk;
             }
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script_A", script);
    }
    /// <summary>
    /// 
    /// </summary>
    protected void gridSafeDepositAttorney_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       if (e != null && e.Row.RowType == DataControlRowType.DataRow)
         {
             row_counter++;
             string row_id = "r_" + row_counter.ToString();
             GridViewRow row = e.Row;
             row.Attributes.Add("id", row_id);
             row.Attributes.Add("onclick", "S_A('" + row_counter + "','" +
                  row.Cells[7].Text + "')");

             CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
             cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
             cinfo.DateTimeFormat.DateSeparator = "/";
         }
    }


    protected void btPrint_Click(object sender, EventArgs e)
    {
        if (String.IsNullOrEmpty(REF.Text))
        {
            Response.Write("<script>alert('Сейф не вибрано !');</script>");
            Response.Flush();
            return;
        }
        if (String.IsNullOrEmpty(RNK.Value))
        {
            Response.Write("<script>alert(Довіреність не вибрано !');</script>");
            Response.Flush();
            return;
        }
        FrxParameters pars = new FrxParameters();
        pars.Add(new FrxParameter("p_nd", TypeCode.Int64, Convert.ToInt64( REF.Text) ));
        pars.Add(new FrxParameter("p_rnk", TypeCode.Int64, Convert.ToInt64(RNK.Value)));


        String template = "SKRK_ATTORNEY";


        FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(template)), pars , this.Page );

        //// выбрасываем в поток в формате PDF
        doc.Print(FrxExportTypes.Pdf);

    }
    /// <summary>
    /// 
    /// </summary>
   

    /// <summary>
    /// 
    /// </summary>
    protected void btBack_Click(object sender, EventArgs e)
    {
        String url = "/barsroot/safe-deposit/safedeposit.aspx?safe_id=" + Convert.ToString(Request["safe_id"]) + "&dpt_id=" +  Convert.ToString(Request["SKRN_ND"]); ;
        Response.Redirect(url);
        
    }
  
    /// <summary>
    /// 
    /// </summary>
    private void HideButtons()
    {
        btNew.Visible = false;
      
        Separator1.Visible = false;
        Separator2.Visible = false;
       // Separator3.Visible = false;
    }
    /// <summary>
    /// 
    /// </summary>
    
}
