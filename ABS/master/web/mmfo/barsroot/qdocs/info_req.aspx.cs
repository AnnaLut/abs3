using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;
using Bars.Oracle;
using Bars.DataComponents;
using Resources;
using Bars.Configuration;
using System.Collections;
using System.Web.Caching;
using System.Resources;
using System.Text;

enum Severity { Error, Warning, Info}
 // <summary>
/// Класс для работы с кешированными данными
/// </summary>
public sealed class StaticData : Bars.BarsPage
{
    string f_key;
    public StaticData(string key)
    {
        if (key != "Params" && key != "snrTable")
            throw new ArgumentException("Недопустимое имя параметра для конструктора класса StaticData");
        f_key = key;
    }
    private DataTable GetDataFromDb()
    {
        InitOraConnection();
        try
        {
            SetRole(Resources.qdocs.GlobalResources.RoleName);
            switch (f_key)
            {
                case "snrTable" :
                    return SQL_SELECT_dataset("select k_rk, n_rk from s_nr where k_rk in ('!','*','-','+','?')").Tables[0];
                case "Params":            
                    return SQL_SELECT_dataset("select par, val from params where par in ('INFDB_OP', 'INFKR_OP')").Tables[0];
                default: return null;
            }
        }
        finally
        {
            DisposeOraConnection();
        }
    }
    public DataTable GetCachedData()
    {
        Cache cache = System.Web.HttpContext.Current.Cache;
        DataTable table = (DataTable)cache[f_key];
        if (null == table)
        {
            table = GetDataFromDb();
            cache.Add(
                f_key,
                table,
                null, // CacheDependency
                Cache.NoAbsoluteExpiration,
                Cache.NoSlidingExpiration,
                CacheItemPriority.Normal,
                null // CacheItemRemovedCallback
            );
        }
        return table;
    }
}

/// <summary>
/// Класс веб-формы
/// </summary>
public partial class Qdocs : Bars.BarsPage
{

    protected void Page_Init(object sender, EventArgs e)
    {
        //заполнить параметры datasource
        ds.PreliminaryStatement = Resources.qdocs.GlobalResources.SetRoleCmd;
        ds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        ds.DataBind();
        gv.DataBind();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void btnRun_Click(object sender, EventArgs e)
    {
        List<Decimal> infoRef = new List<Decimal>();
        int i = 0;

        foreach (GridViewRow gr in gv.Rows)
        {
            CheckBox chk = (CheckBox)gr.FindControl("chkSelect");
            if (chk == null) continue;
            if (!chk.Checked) continue;
            infoRef.Add(Convert.ToDecimal(gv.DataKeys[gr.RowIndex]["rec"].ToString()));
            i++;
            //break;
        }

        if (i == 0)
        {
            showMessage("Не вибрано жодного документа", Severity.Error);
        }
        else
        {
            String res = "";
            for (int j = 0; j < infoRef.Count; j++)
            {
                OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.CommandText = "";

                cmd.CommandText = "bars.p_imm_qdocs";
                cmd.Parameters.Add("p_rec", OracleDbType.Decimal, infoRef[j], System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_ref", OracleDbType.Decimal, System.Data.ParameterDirection.Output);
                OracleParameter parerr = new OracleParameter("p_msg", OracleDbType.Varchar2, 4000, null, System.Data.ParameterDirection.Output);
                cmd.Parameters.Add(parerr);

                cmd.ExecuteNonQuery();

                if ((OracleDecimal)cmd.Parameters["p_ref"].Value == 0)
                    res += "<span style='color: red'>" + cmd.Parameters["p_msg"].Value.ToString() + " № запиту " + infoRef[j] + "</span><br />";
                else
                    res += "Успішно! " + "Для повідомлення №" + Convert.ToString(infoRef[j]) + " створено документ №" + Convert.ToString(cmd.Parameters["p_ref"].Value) + "<br />";

                con.Dispose();
                con.Close();
            }

             Hashtable ht = new Hashtable();

            ht.Add("Оk ", "/barsroot/qdocs/info_req.aspx");

            Session.Add("dlg_buttons", ht);
            Session.Add("dlg_text", res);
            Session.Add("dlg_title", lblMsg6.Text);
            Response.Redirect("qdialog.aspx");
        }
    }

    protected void gv_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            CheckBox chk = (CheckBox)e.Row.FindControl("chkSelect");
            if (chk != null)
            {
                chk.Attributes.Add("onclick", "SelectRow()");
            }
            //e.Row.Attributes.Add("onclick", "SelectRow()");
        }
    }

    private void showMessage(string msgText, Severity msgSeverity)
    {
        Label lblMsg = new Label();
        lblMsg.Text = msgText;
        switch (msgSeverity)
        {
            case Severity.Error: lblMsg.CssClass = "MsgError";
                break;
            case Severity.Warning: lblMsg.CssClass = "MsgWarning";
                break;
            case Severity.Info: lblMsg.CssClass = "MsgInfo";
                break;
        }
        placeHolder.Controls.Add(lblMsg);
    }
}


