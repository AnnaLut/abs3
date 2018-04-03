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
using System.Drawing;
using System.Globalization;
using Bars.Exception;
using System.Web.Services;
using Bars.Classes;

public partial class SocialAgencies : System.Web.UI.Page
{
    DataSet dsAgencyTypes = new DataSet();
    DataSet dsBranch = new DataSet();
    DataSet dsAgency = new DataSet();
    OracleDataAdapter adAgencyTypes = new OracleDataAdapter();
    OracleDataAdapter adBranch = new OracleDataAdapter();
    OracleDataAdapter adAgency = new OracleDataAdapter();
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        listAgencyType.Attributes["onchange"] = "javascript:GetRequiredFields()";

        if (!IsPostBack)
            FillControls();
        
        get_req_field();
    }
    /// <summary>
    /// 
    /// </summary>
    private void FillControls()
    {
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
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdFillAgencyTypes = connect.CreateCommand();
            cmdFillAgencyTypes.CommandText = "select null as nf,type_id, type_name from social_agency_type";
            adAgencyTypes.SelectCommand = cmdFillAgencyTypes;
            adAgencyTypes.Fill(dsAgencyTypes);
            gAgencyTypes.DataSource = dsAgencyTypes;
            gAgencyTypes.DataBind();

            gAgencyTypes.HeaderStyle.BackColor = Color.Gray;
            gAgencyTypes.HeaderStyle.Font.Bold = true;
            gAgencyTypes.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;	

            OracleCommand cmdFillBranch = connect.CreateCommand();
            cmdFillBranch.CommandText = "select branch, branch || ' ' || name as name from our_branch order by name";
            adBranch.SelectCommand = cmdFillBranch;
            adBranch.Fill(dsBranch);
            listSearchBranch.DataSource = dsBranch;
            listSearchBranch.DataBind();

            listAgencyType.DataSource = dsAgencyTypes;
            listAgencyType.DataBind();

            listBranch.DataSource = dsBranch;
            listBranch.DataBind();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
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
				function S_A(id,val)
				{
				 if(selectedRow != null) selectedRow.style.background = '';
				 document.getElementById('r_'+id).style.background = '#d3d3d3';
				 selectedRow = document.getElementById('r_'+id);
				 document.getElementById('letter_id').value = val;
				}
				</script>";
        Page.RegisterStartupScript(ID + "Script_A", script);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btSearch_ServerClick(object sender, EventArgs e)
    {
        FillGrid();
    }
    /// <summary>
    /// 
    /// </summary>
    private void FillGrid()
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            // Создаем соединение
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Установка роли
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdFillAgency = connect.CreateCommand();
            cmdFillAgency.CommandText = @"SELECT 
                decode(contract_closed, null, '<A href=# onclick=''DeleteAgency('||agency_id||')''>Видалити</a>', null) AS DEL,
                agency_id, agency_name,debit_nls, credit_nls, card_nls, comiss_nls, contract_number,TO_CHAR(contract_date,'dd/mm/yyyy') AS cdate, 
                TO_CHAR(contract_closed,'dd/mm/yyyy') AS contract_closed
                FROM v_socialagencies
                WHERE agency_type IN (";

            bool need2trim = false;
            for (int i = 0; i < gAgencyTypes.Rows.Count; i++)
            {
                CheckBox cb = (CheckBox)gAgencyTypes.Rows[i].Cells[0].FindControl("CheckBoxColumn");
                if (cb.Checked)
                {
                    if (!need2trim) need2trim = true;

                    cmdFillAgency.CommandText += ":p" + i.ToString() + ",";
                    cmdFillAgency.Parameters.Add("p" + i.ToString(),
                        OracleDbType.Decimal, gAgencyTypes.Rows[i].Cells[1].Text, ParameterDirection.Input);
                }
            }

            if (need2trim)
                cmdFillAgency.CommandText = cmdFillAgency.CommandText.TrimEnd(',');
            else
            {
                //Response.Write("<script>alert('Не задано жодного органу соціального захисту!');</script>");
                cmdFillAgency.CommandText += "null";
            }

            cmdFillAgency.CommandText += ") AND agency_branch = :branch ";
            cmdFillAgency.Parameters.Add("branch", OracleDbType.Varchar2, listSearchBranch.SelectedValue, ParameterDirection.Input);

            adAgency.SelectCommand = cmdFillAgency;
            adAgency.Fill(dsAgency);
            gSocialAgencies.DataSource = dsAgency;
            gSocialAgencies.DataBind();

            gSocialAgencies.HeaderStyle.BackColor = Color.Gray;
            gSocialAgencies.HeaderStyle.Font.Bold = true;
            gSocialAgencies.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
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
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btAdd_ServerClick(object sender, EventArgs e)
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            // Создаем соединение
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Установка роли
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            Decimal? a_id = null;

            OracleCommand cmdSubmitAgency = connect.CreateCommand();
            cmdSubmitAgency.CommandText = "begin dpt_social.open_agency(:p_typeid,"
              + ":p_branch,:p_name,:p_num,:p_dat,:p_address,:p_phone,:p_details,:p_debit,:p_credit,:p_card,"
              + ":p_comiss,:p_agencyid); end;";
            
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");	
			cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";

            cmdSubmitAgency.Parameters.Add("p_typeid",      OracleDbType.Decimal,       listAgencyType.SelectedValue,   ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_branch",      OracleDbType.Varchar2,      listBranch.SelectedValue,       ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_name",        OracleDbType.Varchar2,      textName.Text,                  ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_num",         OracleDbType.Varchar2,      textNum.Text,                   ParameterDirection.Input);
            if (textDate.Date == DateTime.MinValue)
                cmdSubmitAgency.Parameters.Add("p_dat", OracleDbType.Date, null, ParameterDirection.Input);
            else
                cmdSubmitAgency.Parameters.Add("p_dat",         OracleDbType.Date,          textDate.Date,                  ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_address",     OracleDbType.Varchar2,      textAddres.Text,                ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_phone",       OracleDbType.Varchar2,      textPhone.Text,                 ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_details",     OracleDbType.Varchar2,      textNote.Text,                  ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_debit",       OracleDbType.Varchar2,      textDZ.Text,                    ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_credit",      OracleDbType.Varchar2,      textKPZ.Text,                   ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_card",        OracleDbType.Varchar2,      textKCZ.Text,                   ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_comiss",      OracleDbType.Varchar2,      textMZ.Text,                    ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_agencyid",    OracleDbType.Decimal,       a_id,                           ParameterDirection.Output);

            cmdSubmitAgency.ExecuteNonQuery();

            try
            {
                a_id = Convert.ToDecimal(Convert.ToString(cmdSubmitAgency.Parameters["p_agencyid"].Value));
            }
            catch (FormatException)
            {
                throw new SocialDepositException("Неуспішне відкриття органу соціального захисту!");
            }

            ClearFields();

            FillGrid();

            String script = "<script>alert('Орган соціального захисту успішно зареєстровано!Ідентифікатор органа = "
                + a_id.ToString() + "');</script>";
            Response.Write(script);
            Response.Flush();
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
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btUpdate_ServerClick(object sender, EventArgs e)
    {
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
            cmdSetRole.ExecuteNonQuery();

            if (String.IsNullOrEmpty(SELECTED_AGENCY_ID.Value))
            {
                String script1 = "<script>alert('Не вибрано орган соц. захисту для редагування.  Спочатку знайдіть орган соц. захисту та щоб вибрати натисніть кнопку <Редагувати>.');</script>";
                Response.Write(script1);

                return;
            }

            Decimal a_id = Convert.ToDecimal(SELECTED_AGENCY_ID.Value);

            OracleCommand cmdSubmitAgency = connect.CreateCommand();
            cmdSubmitAgency.CommandText = "begin dpt_social.open_agency(:p_typeid,"
              + ":p_branch,:p_name,:p_num,:p_dat,:p_address,:p_phone,:p_details,:p_debit,:p_credit,:p_card,"
              + ":p_comiss,:p_agencyid); end;";

            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";

            cmdSubmitAgency.Parameters.Add("p_typeid", OracleDbType.Decimal, listAgencyType.SelectedValue, ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_branch", OracleDbType.Varchar2, listBranch.SelectedValue, ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_name", OracleDbType.Varchar2, textName.Text, ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_num", OracleDbType.Varchar2, textNum.Text, ParameterDirection.Input);
            if (textDate.Date == DateTime.MinValue)
                cmdSubmitAgency.Parameters.Add("p_dat", OracleDbType.Date, null, ParameterDirection.Input);
            else
                cmdSubmitAgency.Parameters.Add("p_dat", OracleDbType.Date, textDate.Date, ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_address", OracleDbType.Varchar2, textAddres.Text, ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_phone", OracleDbType.Varchar2, textPhone.Text, ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_details", OracleDbType.Varchar2, textNote.Text, ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_debit", OracleDbType.Varchar2, textDZ.Text, ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_credit", OracleDbType.Varchar2, textKPZ.Text, ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_card", OracleDbType.Varchar2, textKCZ.Text, ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_comiss", OracleDbType.Varchar2, textMZ.Text, ParameterDirection.Input);
            cmdSubmitAgency.Parameters.Add("p_agencyid", OracleDbType.Decimal, a_id, ParameterDirection.InputOutput);

            cmdSubmitAgency.ExecuteNonQuery();

            try
            {
                a_id = Convert.ToDecimal(Convert.ToString(cmdSubmitAgency.Parameters["p_agencyid"].Value));
            }
            catch (FormatException)
            {
                throw new SocialDepositException("Неуспішне відкриття органу соціального захисту!");
            }

            FillGrid();

            String script = "<script>alert('Орган соціального захисту успішно оновлено.');</script>";
            Response.Write(script);
            Response.Flush();
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
    public void get_req_field()
    {
        lbCZM1.Style.Add("visibility", "hidden");
        lbKZM1.Style.Add("visibility", "hidden");
        lbBZM1.Style.Add("visibility", "hidden");
        lbMZM1.Style.Add("visibility", "hidden");

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
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetAcc = connect.CreateCommand();
            cmdGetAcc.CommandText = "select account_typeid " +
                "from v_socialagencyacctypes " +
                "where agency_typeid = :atype";
            cmdGetAcc.Parameters.Add("atype", OracleDbType.Decimal, listAgencyType.SelectedValue, ParameterDirection.Input);

            OracleDataReader rdr = cmdGetAcc.ExecuteReader();

            while (rdr.Read())
            {
                String par = Convert.ToString(rdr.GetOracleString(0).Value);
                if (par == "C")
                    lbCZM1.Style.Add("visibility","visible");
                else if (par == "K")
                    lbKZM1.Style.Add("visibility","visible");
                else if (par == "D")
                    lbBZM1.Style.Add("visibility","visible");
                else if (par == "M")
                    lbMZM1.Style.Add("visibility","visible");
            }
            rdr.Close();
            rdr.Dispose();
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
    public void ClearFields()
    {
        textName.Text = String.Empty;
        listAgencyType.SelectedIndex = 0;
        listBranch.SelectedIndex = 0;
        textNum.Text = String.Empty;
        textDate.Date = DateTime.MinValue;
        textDZ.Text = String.Empty;
        textKCZ.Text = String.Empty;
        textKPZ.Text = String.Empty;
        textMZ.Text = String.Empty;
        textAddres.Text = String.Empty;
        textPhone.Text = String.Empty;
        textNote.Text = String.Empty;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gSocialAgencies_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            GridViewRow row = e.Row;
            if (!String.IsNullOrEmpty(row.Cells[10].Text) && row.Cells[10].Text != "&nbsp;")
            {
                    row.BackColor = Color.Red;
            }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gSocialAgencies_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EDIT")
        {
            OracleConnection connect = new OracleConnection();

            try
            {
                // Открываем соединение с БД
                IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();

                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdGetAgency = connect.CreateCommand();
                cmdGetAgency.CommandText = @"select agency_id, agency_name, agency_type, agency_branch, 
                    contract_number, contract_date,
                    debit_nls, credit_nls, card_nls, comiss_nls,
                    agency_address, agency_phone, details  
                    from v_socialagencies
                    where agency_id = :agency_id";

                cmdGetAgency.Parameters.Add("agency_id", OracleDbType.Decimal,
                    Convert.ToDecimal(gSocialAgencies.Rows[Convert.ToInt32(e.CommandArgument)].Cells[2].Text),
                ParameterDirection.Input);

                OracleDataReader rdr = cmdGetAgency.ExecuteReader();

                if (!rdr.Read())
                    throw new SocialDepositException("Не знайдено орган соц. захисту ід=" + Convert.ToDecimal(gSocialAgencies.Rows[Convert.ToInt32(e.CommandArgument)].Cells[2].Text));

                if (!rdr.IsDBNull(0))
                    SELECTED_AGENCY_ID.Value = Convert.ToString(rdr.GetOracleDecimal(0).Value);
                if (!rdr.IsDBNull(1))
                    textName.Text = rdr.GetOracleString(1).Value;
                if (!rdr.IsDBNull(2))
                    listAgencyType.SelectedIndex = listAgencyType.Items.IndexOf(
                        listAgencyType.Items.FindByValue(
                            Convert.ToString(rdr.GetOracleDecimal(2).Value)));
                if (!rdr.IsDBNull(3))
                    listBranch.SelectedIndex = listBranch.Items.IndexOf(
                        listBranch.Items.FindByValue(
                            Convert.ToString(rdr.GetOracleString(3).Value)));
                if (!rdr.IsDBNull(4))
                    textNum.Text = rdr.GetOracleString(4).Value;
                if (!rdr.IsDBNull(5))
                    textDate.Date = rdr.GetOracleDate(5).Value;
                if (!rdr.IsDBNull(6))
                    textDZ.Text = rdr.GetOracleString(6).Value;
                if (!rdr.IsDBNull(7))
                    textKPZ.Text = rdr.GetOracleString(7).Value;
                if (!rdr.IsDBNull(8))
                    textKCZ.Text = rdr.GetOracleString(8).Value;
                if (!rdr.IsDBNull(9))
                    textMZ.Text = rdr.GetOracleString(9).Value;
                if (!rdr.IsDBNull(10))
                    textAddres.Text = rdr.GetOracleString(10).Value;
                if (!rdr.IsDBNull(11))
                    textPhone.Text = rdr.GetOracleString(11).Value;
                if (!rdr.IsDBNull(12))
                    textNote.Text = rdr.GetOracleString(12).Value;
                rdr.Close();
                rdr.Dispose();
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }
        else if (e.CommandName == "DELETE")
        {
            OracleConnection connect = new OracleConnection();
            try
            {
                connect = OraConnector.Handler.IOraConnection.GetUserConnection();


                // Установка роли
                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdDeleteAgency = connect.CreateCommand();
                cmdDeleteAgency.CommandText = "begin dpt_social.close_agency(:ag_type); end;";
                cmdDeleteAgency.Parameters.Add("ag_type", OracleDbType.Decimal,
                    Convert.ToDecimal(e.CommandArgument.ToString()),
                    ParameterDirection.Input);
                cmdDeleteAgency.ExecuteNonQuery();

                FillGrid();

                Response.Write("<script>alert('Вибраний орган соціального захисту успішно видалений!');</script>");
            }
            catch (Exception ex)
            {
                Deposit.SaveException(ex);
                throw ex;
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }
    }
    protected void gSocialAgencies_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }
    protected void gSocialAgencies_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
}
