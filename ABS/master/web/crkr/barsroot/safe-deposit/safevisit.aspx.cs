using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Bars.Oracle;
using Bars.Exception;
using Oracle.DataAccess.Client;

public partial class safe_deposit_safevisit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request["safe_id"] == null || Request["SKRN_ND"] == null)
                throw new SafeDepositException("Некоректний запит!");

            N_SK.Text = safe_deposit.GetNumById(Convert.ToDecimal(Convert.ToString(Request["safe_id"])));
            ND.Text = Convert.ToString(Request["SKRN_ND"]);
            Name.Text = GetName(ND.Text);

            InitGrid();

        }
    }
    /// <summary>
    /// 
    /// </summary>
    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        if (sourceControl.GetType().Name == "BarsGridView" ||
            (eventArgument != null && eventArgument.Length > 4 && eventArgument.Substring(0, eventArgument.IndexOf("$")) == "Bars"))
        {
            InitGrid();
        }
        try
        {
            base.RaisePostBackEvent(sourceControl, eventArgument);
        }
        catch (Exception ex)
        {
            safe_deposit.SaveException(ex);
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
    /// <param name="e"></param>
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);

        InitGrid();
    }
    /// <summary>
    /// 
    /// </summary>
    protected override void OnLoad(EventArgs e)
    {
        //gvVisit.NewRowStyles.InsertButtonText = Resources.barsweb.GlobalResources.vSave;
        //gvVisit.NewRowStyles.NewButtonText = Resources.barsweb.GlobalResources.vAdd;
        //gvVisit.NewRowStyles.СancelNewButtonText = Resources.barsweb.GlobalResources.vCancel;

        base.OnLoad(e);
    }
    /// <summary>
    /// 
    /// </summary>
    private void InitGrid()
    {
        String nd = Convert.ToString(Request["SKRN_ND"]);

        if (String.IsNullOrEmpty(nd))
            throw new SafeDepositException("Не задано номер договору!");

        if (!(gvVisit.Columns[0] is CommandField))
        {
            CommandField cf = new CommandField();
            cf.DeleteText = Resources.barsweb.GlobalResources.vDelete;
            cf.EditText = Resources.barsweb.GlobalResources.vEdit;
            cf.UpdateText = Resources.barsweb.GlobalResources.vSave;
            cf.CancelText = Resources.barsweb.GlobalResources.vCancel;
            cf.ShowEditButton = true;
            cf.ShowCancelButton = true;
            cf.ShowDeleteButton = false;
            gvVisit.Columns.Insert(0, cf);
        }

        gvVisit.AutoGenerateNewButton = true;

        dsVisit.SelectParameters.Clear();
        dsVisit.InsertParameters.Clear();
        dsVisit.UpdateParameters.Clear();
        dsVisit.DeleteParameters.Clear();

        dsVisit.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsVisit.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DEP_SKRN");

        dsVisit.InsertCommand = "INSERT INTO SKRYNKA_VISIT (DATIN, DATOUT, DATSYS, ND) " +
            "VALUES (TO_DATE(trim(:DATIN_DATE) || trim(:DATIN_TIME), 'dd/MM/yyyyHH24:mi'), " +
            "TO_DATE(trim(:DATOUT_DATE) || trim(:DATOUT_TIME), 'dd/MM/yyyyHH24:mi'), sysdate, :ND)";

        dsVisit.SelectCommand = "select " +
            "to_char(DATIN,'dd/MM/yyyy') DATIN_DATE, " +
            "to_char(DATIN,'HH24:mi') DATIN_TIME, " +
            "to_char(DATOUT,'dd/MM/yyyy') DATOUT_DATE, " +
            "to_char(DATOUT,'HH24:mi') DATOUT_TIME " +
            "from skrynka_visit where nd = :ND " +
            "order by 1,2 asc";

        dsVisit.UpdateCommand = "UPDATE SKRYNKA_VISIT " +
            "SET DATIN = TO_DATE(trim(:DATIN_DATE) || trim(:DATIN_TIME), 'dd/MM/yyyyHH24:mi'), " +
            "DATOUT = TO_DATE(trim(:DATOUT_DATE) || trim(:DATOUT_TIME), 'dd/MM/yyyyHH24:mi') " +
            "WHERE ND = :ND AND DATIN = TO_DATE(trim(:" + string.Format(dsVisit.OldValuesParameterFormatString, "DATIN_DATE") +
            ") || trim(:" + string.Format(dsVisit.OldValuesParameterFormatString, "DATIN_TIME") + "), 'dd/MM/yyyyHH24:mi')";

        Parameter par = new Parameter("DATIN_DATE", TypeCode.String);
        par.Size = 10;
        dsVisit.InsertParameters.Add(par);
        dsVisit.UpdateParameters.Add(par);

        par = new Parameter("DATIN_TIME", TypeCode.String);
        par.Size = 5;
        dsVisit.InsertParameters.Add(par);
        dsVisit.UpdateParameters.Add(par);

        par = new Parameter("DATOUT_DATE", TypeCode.String);
        par.Size = 10;
        dsVisit.InsertParameters.Add(par);
        dsVisit.UpdateParameters.Add(par);

        par = new Parameter("DATOUT_TIME", TypeCode.String);
        par.Size = 5;
        dsVisit.InsertParameters.Add(par);
        dsVisit.UpdateParameters.Add(par);

        par = new Parameter("ND", TypeCode.Decimal);
        par.Size = 19;
        par.DefaultValue = nd;
        dsVisit.SelectParameters.Add(par);
        dsVisit.InsertParameters.Add(par);
        dsVisit.UpdateParameters.Add(par);

        par = new Parameter(string.Format(dsVisit.OldValuesParameterFormatString, "DATIN_DATE"), TypeCode.String);
        par.Size = 10;
        dsVisit.UpdateParameters.Add(par);

        par = new Parameter(string.Format(dsVisit.OldValuesParameterFormatString, "DATIN_TIME"), TypeCode.String);
        par.Size = 10;
        dsVisit.UpdateParameters.Add(par);        
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="nd"></param>
    private String GetName(String nd)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetName = connect.CreateCommand();
            cmdGetName.CommandText = "select fio from skrynka_nd where nd = :nd";
            cmdGetName.Parameters.Add("nd", OracleDbType.Decimal, nd, ParameterDirection.Input);

            return Convert.ToString(cmdGetName.ExecuteScalar());
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
}
