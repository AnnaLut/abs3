using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.Exception;

public partial class AddSum : Page
{
    bool nonCash = true;
    private int row_counter = 0;
    /// <summary>
    /// Завантаження сторінки
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["rnk"] == null || Request["dpt_id"] == null)
            throw new SafeDepositException("Сторінка викликана з некоректними параметрами!");

        DPT_ID.Value = Convert.ToString(Request["dpt_id"]);
        RNK.Value = Convert.ToString(Request["rnk"]);
        cash.Value = (Request["cash"] == "true"?"1":"0");

        if (Request["cash"] == "true")
        {
            SumTable.Visible = true;
            gridTechAccCredit.Visible = false;
            lbTitle.Text = lbTitle.Text.Replace("%", "через касу");
            nonCash = false;
        }
        else
        {
            SumTable.Visible = false;
            btAddPayment.Visible = false;
            btCommission.Disabled = false;
            nonCash = true;
            lbTitle.Text = lbTitle.Text.Replace("%", "безготівковим переказом");
        }

        /// Якщо безготівка - наповнюємо поповнення
        if (nonCash)
        {
            RegisterClientScript();
            FillGrid();
        }
        /// Заповнюємо інформацію для оплати
        FillControls();
    }
    /// <summary>
    /// Наповнення списку зроблених
    /// безготівкових поповнень
    /// за які не була стягнена комісія
    /// </summary>
    private void FillGrid()
    {
        dsTechAccCredit.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsTechAccCredit.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

        string searchQuery = "SELECT " +
                "'<A href=# onclick=''ShowDocCard('||REF||')''>Перегляд</a>' AS REF, " +                
                "NLS,SUM,LCV,DAT,NAZN, " +
                "REF as DREF " +
                "FROM v_tech_acc_credit " +
                "WHERE acc = :acc and refl is null";

        dsTechAccCredit.SelectParameters.Clear();
        dsTechAccCredit.SelectParameters.Add("acc", TypeCode.Decimal, Convert.ToString(Request["acc"]));
        dsTechAccCredit.SelectCommand = searchQuery;
        gridTechAccCredit.DataBind();
    }
    /// <summary>
    /// Наповнення даних
    /// </summary>
    private void FillControls()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");            
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetInfo = connect.CreateCommand();
            cmdGetInfo.CommandText = @"SELECT c.adr, pa.name, TO_CHAR(p.ser) || ' ' ||  TO_CHAR(p.NUMDOC),
                TO_CHAR(p.ORGAN) || ' ' || TO_CHAR (p.PDATE,'dd/mm/yyyy'),
                TO_CHAR(p.bday,'dd/mm/yyyy'), c.nmk
                FROM  customer c, person p, passp pa
                WHERE c.rnk = :rnk AND c.rnk = p.rnk AND pa.passp = p.passp";
            cmdGetInfo.Parameters.Add("rnk", OracleDbType.Decimal, Convert.ToDecimal(Convert.ToString(Request["rnk"])), ParameterDirection.Input);

            OracleDataReader rdr = cmdGetInfo.ExecuteReader();

            if (!rdr.Read())
                throw new SocialDepositException("Дані про клієнта rnk=" +
                    Convert.ToString(Request["rnk"]) + " не знайдені!");

            if (!rdr.IsDBNull(0))
                ADRES.Value = Convert.ToString(rdr.GetOracleString(0).Value);
            if (!rdr.IsDBNull(1))
                PASP.Value = Convert.ToString(rdr.GetOracleString(1).Value);
            if (!rdr.IsDBNull(2))
                PASPN.Value = Convert.ToString(rdr.GetOracleString(2).Value);
            if (!rdr.IsDBNull(3))
                ATRT.Value = Convert.ToString(rdr.GetOracleString(3).Value);
            if (!rdr.IsDBNull(4))
                DT_R.Value = Convert.ToString(rdr.GetOracleString(4).Value);
            if (!rdr.IsDBNull(5))
                NMK.Value = Convert.ToString(rdr.GetOracleString(5).Value);

            cmdGetInfo.Parameters.Clear();

            cmdGetInfo.CommandText = @"select account_number, currency_code,
                    TO_CHAR(account_saldo/100,'999999999990.99'),
                    customer_id,  customer_name, cusomer_code,
                    contract_number, currency_id,
                    bars_context.extract_mfo(branch_id) 
                    from v_socialcontracts
                    where contract_id = :contract_id";

            cmdGetInfo.Parameters.Add("contract_id", OracleDbType.Decimal, Convert.ToDecimal(Request["dpt_id"]), ParameterDirection.Input);

            rdr = cmdGetInfo.ExecuteReader();

            if (!rdr.Read())
                throw new SocialDepositException("Дані про договір id=" +
                    Convert.ToString(Request["dpt_id"]) + " не знайдені!");

            if (!rdr.IsDBNull(0))
                textNLS.Text = Convert.ToString(rdr.GetOracleString(0).Value);
            if (!rdr.IsDBNull(1))
                textKV.Text = Convert.ToString(rdr.GetOracleString(1).Value);
            if (!rdr.IsDBNull(2))
                textSUM.Text = Convert.ToString(rdr.GetOracleString(2).Value);
            if (!rdr.IsDBNull(3))
                textRNK.Text = Convert.ToString(rdr.GetOracleDecimal(3).Value);
            if (!rdr.IsDBNull(4))
                textNMK.Text = Convert.ToString(rdr.GetOracleString(4).Value);
            if (!rdr.IsDBNull(5))
                textOKPO.Text = Convert.ToString(rdr.GetOracleString(5).Value);
            if (!rdr.IsDBNull(6))
                textDPT_ID.Text = Convert.ToString(rdr.GetOracleString(6).Value);
            if (!rdr.IsDBNull(7))
                KV.Value = Convert.ToString(rdr.GetOracleDecimal(7).Value);

            cmdGetInfo.Parameters.Clear();

            /// Поповнення готівкою
            tt.Value = SocialDeposit.GetSocTT(DPT_OP.OP_1);

            if (!rdr.IsClosed) rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Подія - заповнення гріда даними 
    /// </summary>
    protected void gridTechAccCredit_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {           
            row_counter++;
            string row_id = "r_" + row_counter;
            GridViewRow row = e.Row;
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", string.Format("S_A('{0}','{1}','{2}','{3}')", row_counter, row.Cells[4].Text, Convert.ToString(Convert.ToDecimal(row.Cells[3].Text) * 100), row.Cells[1].Text));
        }
    }
    /// <summary>
    /// Скріпт, для виділення рядків у гріді
    /// </summary>
    private void RegisterClientScript()
    {
        string script = @"<script language='javascript'>
        			var selectedRow;
        			function S_A(id,lcv,sum,ref)
        			{
                     if(selectedRow != null) selectedRow.style.background = '';
        			 document.getElementById('r_'+id).style.background = '#d3d3d3';
        			 selectedRow = document.getElementById('r_'+id);
        			 document.getElementById('LCV').value = lcv;
                     document.getElementById('SMAIN').value = sum;
                     document.getElementById('REF').value = ref;
        			}
        			</script>";
        ClientScript.RegisterStartupScript(GetType(), ID + "Script_A", script);
    }
}
