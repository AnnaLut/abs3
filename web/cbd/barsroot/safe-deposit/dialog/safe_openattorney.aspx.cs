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

public partial class safe_deposit_dialog_safe_open_attorney : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request["DPT_ID"] == null)
                throw new ApplicationException("Сторінка викликана з некоректними параметрами!");

            
            InitControls();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private void DisableControls()
    {
        RNK.Enabled = ddClientType.Enabled = CANCEL_DATE.Enabled = DATE_TO.Enabled = DATE_FROM.Enabled = btOK.Enabled = btSelectClient.Enabled = false;
    }     
    /// <summary>
    /// 
    /// </summary>
    private void InitControls()
    {
        DPT_ID.Text = Convert.ToString(Request["DPT_ID"]);
        RNK.Enabled = false;
        FIO.Enabled = false;
        DPT_ID.Enabled = false;

        OracleConnection connect = new OracleConnection();

        try
        {

            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            connect = conn.GetUserConnection();


            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleDataAdapter adapterCustType = new OracleDataAdapter();
            OracleCommand cmdSelectCustType = connect.CreateCommand();
            cmdSelectCustType.CommandText = "select custtype, name from custtype where custtype in (2,3) order by custtype desc";
            adapterCustType.SelectCommand = cmdSelectCustType;
            DataSet dsCustType = new DataSet();
            adapterCustType.Fill(dsCustType);

            ddClientType.DataSource = dsCustType;
            ddClientType.DataTextField = "name";
            ddClientType.DataValueField = "custtype";
            ddClientType.DataBind();

            cmdSelectCustType.Dispose();
            adapterCustType.Dispose();


            if (!String.IsNullOrEmpty(Request["RNK"]))
            {
                OracleCommand cmdGetAttorney = connect.CreateCommand();
                cmdGetAttorney.Connection = connect;

                cmdGetAttorney.BindByName = true;
                cmdGetAttorney.CommandText = "select t1.RNK RNK, t2.NMK NMK, to_char(t1.DATE_FROM,'dd/MM/yyyy') DATE_FROM, " +
                    " to_char(t1.DATE_TO,'dd/MM/yyyy') DATE_TO, to_char(t1.CANCEL_DATE,'dd/MM/yyyy') CANCEL_DATE" +
                    " from skrynka_attorney T1, CUSTOMER T2" +
                " where t1.nd =:nd and t1.rnk = t2.rnk and t2.rnk =:rnk";
                cmdGetAttorney.Parameters.Add("rnk", OracleDbType.Decimal, Convert.ToDecimal(Request["RNK"]), ParameterDirection.Input);
                cmdGetAttorney.Parameters.Add("nd", OracleDbType.Decimal, Convert.ToDecimal(Request["DPT_ID"]), ParameterDirection.Input);


                OracleDataReader rdr = cmdGetAttorney.ExecuteReader();

                while (rdr.Read())
                {
                    RNK.Text = Convert.ToString(Request["RNK"]);

                    if (!rdr.IsDBNull(0))
                        RNK.Text = rdr.GetOracleDecimal(0).Value.ToString();

                    // Наименование или ФИО
                    if (!rdr.IsDBNull(1))
                        FIO.Text = rdr.GetOracleString(1).Value;

                    if (!rdr.IsDBNull(2))
                        DATE_FROM.Text = rdr.GetOracleString(2).Value;
                    else
                        DATE_FROM.Text = null;

                    if (!rdr.IsDBNull(3))
                        DATE_TO.Text = rdr.GetOracleString(3).Value;
                    else
                        DATE_TO.Text = null;

                    if (!rdr.IsDBNull(4))
                        CANCEL_DATE.Text = rdr.GetOracleString(4).Value;
                    else
                        CANCEL_DATE.Text = null;

                }

            }
            else
            {
                CANCEL_DATE.Text = DATE_TO.Text = DATE_FROM.Text = null;
            }
        }
        catch (Exception ex)
        { 
        throw ex;
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
    protected void btOK_Click(object sender, EventArgs e)
    {
       
           OracleConnection connect = new OracleConnection();

           try
           {

               IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
               connect = conn.GetUserConnection();


               OracleCommand cmdSetRole = new OracleCommand();
               cmdSetRole.Connection = connect;
               cmdSetRole.CommandText = conn.GetSetRoleCommand("DEP_SKRN");
               cmdSetRole.ExecuteNonQuery();

               OracleCommand cmdAddAttorney = connect.CreateCommand();
               cmdAddAttorney.CommandType = CommandType.StoredProcedure;


               cmdAddAttorney.CommandText = "safe_deposit.merge_skrynka_attorney";

               cmdAddAttorney.BindByName = true;

               cmdAddAttorney.Parameters.Add("p_nd", OracleDbType.Decimal, Convert.ToDecimal( DPT_ID.Text) , ParameterDirection.Input);
               
               if (String.IsNullOrEmpty(RNK.Text))
                 cmdAddAttorney.Parameters.Add("p_rnk", OracleDbType.Decimal, Convert.ToDecimal( RNK_.Value ) , ParameterDirection.Input);
               else
                   cmdAddAttorney.Parameters.Add("p_rnk", OracleDbType.Decimal, Convert.ToDecimal(RNK.Text), ParameterDirection.Input);
               
               cmdAddAttorney.Parameters.Add("p_date_from", OracleDbType.Varchar2, DATE_FROM.Text , ParameterDirection.Input);
               cmdAddAttorney.Parameters.Add("p_date_to", OracleDbType.Varchar2, DATE_TO.Text, ParameterDirection.Input);
               cmdAddAttorney.Parameters.Add("p_cancel_date", OracleDbType.Varchar2, CANCEL_DATE.Text, ParameterDirection.Input);
               
               cmdAddAttorney.ExecuteNonQuery();


           }
           catch (Exception ex)
           {
               throw ex;
           }
           finally
           {
               if (connect.State != ConnectionState.Closed)
               { connect.Close(); connect.Dispose(); }
           }
        
        DisableControls();
        Response.Write("<script>alert('Дані збережено!');</script>");
        Response.Flush();
    }
}
