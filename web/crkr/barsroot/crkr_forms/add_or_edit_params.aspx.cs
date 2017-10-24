using Oracle.DataAccess.Client;
using System;
using System.Data;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Linq;
using Bars.Classes;
using Bars.CRKR;
using Bars.UserControls;
using Bars.Oracle;
using Bars.Classes;
using ibank.core;
using ibank.objlayer;

public partial class add_or_edit_crkr_params : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request["id"].ToString() != "0")
            {
                getParamData(Request["id"]);
            }
            else
            {
                getBankDate(0);
                tbValue.Text = "0";
            }

            populateDdlParTypes();
            ddlParTypes.Enabled = false;

            ddlParTypes.SelectedValue = Session["SELECT_PARAM_TYPE"].ToString();
            populateDdlParams();
            ddlParams.SelectedValue = Session["SELECT_PARAM"].ToString();
        }

    }

    protected void getParamData(string p_id)
    {
        List<VCompenParamsDataRecord> res = null;

        BbConnection connection = new BbConnection();
        connection.InitConnection();
        try
        {
            VCompenParamsData table = new VCompenParamsData(connection);
            table.Filter.ID.Equal(Convert.ToDecimal(p_id));
            res = table.Select();
        }
        finally
        {
            connection.CloseConnection();
        }

        foreach (VCompenParamsDataRecord item in res)
        {
            ddlParTypes.SelectedValue = item.TYPE.ToString();
            ddlParams.SelectedValue = item.PAR;
            tbValue.Text = item.VAL;
            deDateFrom.Date = Convert.ToDateTime(item.DATE_FROM);
            deDateTo.Date = Convert.ToDateTime(item.DATE_TO);
            ddlIsEnable.SelectedValue = item.IS_ENABLE.ToString();

        }
        ddlParTypes.Enabled = false;
        ddlParams.Enabled = false;
        getBankDate(1);
    }

    protected void ddlParTypes_SelectedIndexChanged(object sender, EventArgs e)
    {
        populateDdlParams();
    }

    protected void getBankDate(decimal type)
    {
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();

        try
        {
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select gl.bd val from dual";
            OracleDataReader rdr = cmd.ExecuteReader();

            while (rdr.Read())
            {
                if (type == 0)
                {
                    DateTime dat = Convert.ToDateTime(rdr["VAL"]);
                    deDateFrom.MinDate = dat;
                    deDateTo.MinDate = dat.AddDays(7);
                    deDateFrom.Date = dat;
                    deDateTo.Date = dat.AddDays(365);
                }
                if (type == 1)
                {
                    DateTime dat = Convert.ToDateTime(rdr["VAL"]);
                    deDateFrom.MinDate = dat;
                    deDateTo.MinDate = dat.AddDays(7);
                }
            }
        }
        catch(Exception E) {
            lbDateFrom.Text = E.Message;
        }
        finally
        {
            con.Close();
            cmd.Dispose();
            con.Dispose();
        }
    }

    protected void populateDdlParTypes()
    {
        List<CompenParamTypesRecord> res = null;

        BbConnection connection = new BbConnection();
        connection.InitConnection();
        try
        {
            CompenParamTypes table = new CompenParamTypes(connection);
            res = table.Select();
        }
        finally
        {
            connection.CloseConnection();
        }

        ddlParTypes.Items.Clear();

        foreach (CompenParamTypesRecord item in res)
        {
            ListItem l = new ListItem();

            l.Text = item.DISCRIPTION;
            l.Value = item.ID.ToString();
            ddlParTypes.Items.Add(l);
        }
    }

    protected void populateDdlParams()
    {
        List<CompenParamsRecord> res = null;

        BbConnection connection = new BbConnection();
        connection.InitConnection();
        try
        {
            CompenParams table = new CompenParams(connection);
            table.Filter.TYPE.Equal(ddlParTypes.SelectedValue == "" ? 1 : Convert.ToDecimal(ddlParTypes.SelectedValue));
            res = table.Select();
        }
        finally
        {
            connection.CloseConnection();
        }

        ddlParams.Items.Clear();

        foreach (CompenParamsRecord item in res)
        {
            ListItem l = new ListItem();

            l.Text = item.DISCRIPTION;
            l.Value = item.PAR.ToString();
            ddlParams.Items.Add(l);
        }
    }

    protected void btOK_Click(object sender, EventArgs e)
      {
        BbConnection conn = new BbConnection();

        decimal? p_id = null;
        decimal? p_all = 0;
        decimal? res_code = 0;
        string res_text = "";


        if (Request["id"] != "0")
        {
            p_id = Convert.ToDecimal(Request["id"]);
        }

        try
        {
            CaCompen mgr = new CaCompen(conn);
            mgr.SET_COMPEN_PARAM_VALUE(ddlParams.SelectedValue, Convert.ToDecimal(ddlParTypes.SelectedValue), p_id, tbValue.Text, null, null, p_all, deDateFrom.Date, deDateTo.Date, Convert.ToDecimal(ddlIsEnable.SelectedValue), out res_code, out res_text);

        }
        catch (Exception E)
        {
            res_text = E.Message;
        }
        finally
        {
            conn.CloseConnection();
        }

        if (res_code != 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "alert('" + res_text + "');", true);
        }
        else
        {
            Server.Transfer("/barsroot/crkr_forms/crkr_params.aspx?type_id=" + Session["SELECT_PARAM_TYPE"] + "&param=" + Session["SELECT_PARAM"] +
           "&dat=" + "&status=" + Session["SELECT_STATUS"], true);

            //Server.Transfer("/barsroot/crkr_forms/crkr_params.aspx?type_id=" + Session["SELECT_PARAM_TYPE"] + "&param=" + Session["SELECT_PARAM"] +
            //"&dat=" + Session["SELECT_DATE"] + "&status=" + Session["SELECT_STATUS"], true);
        }
    }

    protected void btCancel_Click(object sender, EventArgs e)
    {
        Server.Transfer("/barsroot/crkr_forms/crkr_params.aspx?type_id=" + Session["SELECT_PARAM_TYPE"] + "&param=" + Session["SELECT_PARAM"] +
           "&dat=" + Session["SELECT_DATE"] + "&status=" + Session["SELECT_STATUS"], true);
    }
}
