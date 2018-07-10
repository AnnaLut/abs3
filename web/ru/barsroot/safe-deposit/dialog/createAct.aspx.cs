using System;
using System.Data;
using System.Web.UI;
using Bars.Oracle;
using Oracle.DataAccess.Client;

public partial class safe_deposit_dialog_createsafe : Page
{
    /// <summary>
    /// 
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            InitControls();
    }
    /// <summary>
    /// 
    /// </summary>
    private void InitControls()
    {
        OracleConnection connect = new OracleConnection();
        OracleDataAdapter adapterSafeType = new OracleDataAdapter();
        OracleCommand cmdSelectSafeType = new OracleCommand();
        try
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            cmdSelectSafeType = connect.CreateCommand();

            cmdSelectSafeType.CommandText = "select id,name from doc_scheme where id like 'DSKRN%'";
            adapterSafeType.SelectCommand = cmdSelectSafeType;
            DataSet dsSafeTypes = new DataSet();
            adapterSafeType.Fill(dsSafeTypes);

            listSafeTypes.DataSource = dsSafeTypes;
            listSafeTypes.DataTextField = "name";
            listSafeTypes.DataValueField = "id";
            listSafeTypes.DataBind();

        }
        finally
        {
            cmdSelectSafeType.Dispose();
            adapterSafeType.Dispose();
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        DAT_FROM.Date = DateTime.Now;
    }
    protected void btCreateAct_Click(object sender, EventArgs e)
    {
        DateTime datefrom = DAT_FROM.Date;
        DateTime dateto = DAT_TO.Date;
        if ((datefrom.Date.ToShortDateString() == "01/01/0001") || (dateto.Date.ToShortDateString() == "01/01/0001"))
        {
            Response.Write("<script>alert('Заповніть коректні дати!');</script>");
            Response.Flush();
        }
        else if (datefrom > dateto)
        {
            Response.Write("<script>alert('Дата по має бути більшою за Дату з!');</script>");
            Response.Flush();
        }
        else
        {
            safe_deposit sdpt = new safe_deposit();
            sdpt.InsertNewDoc(Convert.ToDecimal(Convert.ToString(Request["nd"])), listSafeTypes.SelectedValue.ToString(), datefrom, dateto);
            Response.Redirect("~/safe-deposit/safedealprint.aspx?nd=" + Convert.ToString(Request["nd"]) + "&safe_id=" + Convert.ToString(Request["safe_id"]));
        }
    }

    protected void btBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/safe-deposit/safedealprint.aspx?nd=" + Convert.ToString(Request["nd"]) + "&safe_id=" + Convert.ToString(Request["safe_id"]));
    }
}
