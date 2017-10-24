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
using Oracle.DataAccess.Client;
using Bars.Classes;
using Bars.Exception;

public partial class safe_deposit_safedealdocs : System.Web.UI.Page
{
    /// <summary>
    /// 
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {            
           // FillGrid(); 
           // gridDocs.Visible = true;
            CheckAmort();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private void CheckAmort()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DEP_SKRN,BASIC_INFO");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "select max(amort_date), case when nvl(max(amort_date),bankdate-1) >= last_day(bankdate) then 0 else 1 end from skrynka_nd where dat_begin <= add_months(last_day(bankdate),-1) and sos != 15";

            Decimal allow_to_amort = 0;
            OracleDataReader rdr = cmd.ExecuteReader();

            if (!rdr.Read())
                throw new SafeDepositException("Відсутні договори по оренді сейфів!");
             
            if (!rdr.IsDBNull(0))
                AMORT_DATE.Text = Convert.ToString(rdr.GetValue(0));
            if (!rdr.IsDBNull(1))
                allow_to_amort = Convert.ToDecimal(rdr.GetValue(1));

            if (allow_to_amort > 0)
                btAmort.Enabled = true;
            else
                btAmort.Enabled = false;
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
    /// <param name="sourceControl"></param>
    /// <param name="eventArgument"></param>
    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        if (sourceControl.GetType().Name == "BarsGridView" || (eventArgument != null && eventArgument.Length > 4 && eventArgument.Substring(0, eventArgument.IndexOf("$")) == "Bars"))
        { FillGrid(); }

        base.RaisePostBackEvent(sourceControl, eventArgument);
    }    
    /// <summary>
    /// 
    /// </summary>
    private void FillGrid()
    {
        dsDocs.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsDocs.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DEP_SKRN");
        dsDocs.SelectParameters.Clear();

        String selectCommand = @"select '<A href=# onclick=''ShowDocCard('||o.REF||')''>'||o.REF||'</a>' AS REF, 
               o.datd,                
               o.tt,   
               o.s,    
               o.nazn, 
               s.snum,
               s.branch,  
               op.name status,   
               c.name visa    
          FROM skrynka_nd_ref ndr,
               skrynka_nd n,
               skrynka s,
               oper o,
               op_sos op,
               chklist c
        WHERE     ndr.nd = n.nd
               AND ndr.REF = o.REF
               AND o.sos = op.sos
               AND o.nextvisagrp = c.idchk
               AND n.n_sk = s.n_sk
               and o.tt = 'SN6'
               and o.datd between ADD_MONTHS(LAST_DAY (bankdate)+1,-1) and LAST_DAY (bankdate) ";

        dsDocs.SelectCommand = selectCommand;
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btRefresh_Click(object sender, EventArgs e)
    {
        
        // FillGrid();
        CheckAmort();
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btAmort_Click(object sender, EventArgs e)
    {
        safe_deposit.Amort();

      //   FillGrid();
        CheckAmort();

        Response.Write("<script>alert('Амортизація виконана успішно.');</script>");
        Response.Flush();
    }
}
