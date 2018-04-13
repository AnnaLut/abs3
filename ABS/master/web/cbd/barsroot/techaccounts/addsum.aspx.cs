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
        if (Request["acc"] == null || Request["rnk"] == null || Request["dpt_id"] == null)
            throw new TechAccountsException("Сторінка викликана з некоректними параметрами!");

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

            /// Прописуємо після оплати комісії, що по даному поповненню
            /// комісію ми вже взяли
            after_pay_role.Value = "DPT_ROLE";
            after_pay_proc.Value = "dpt_web.p_tech_oper_update(#(REF),:REF)";

            OracleCommand cmdGetInfo = connect.CreateCommand();
            cmdGetInfo.CommandText = @"SELECT c.adr, pa.name, TO_CHAR(p.ser) || ' ' ||  TO_CHAR(p.NUMDOC),
                TO_CHAR(p.ORGAN) || ' ' || TO_CHAR (p.PDATE,'dd/mm/yyyy'),
                TO_CHAR(p.bday,'dd/mm/yyyy'), c.nmk
                FROM  customer c, person p, passp pa
                WHERE c.rnk = :rnk AND c.rnk = p.rnk AND pa.passp = p.passp";
            cmdGetInfo.Parameters.Add("rnk", OracleDbType.Decimal, Convert.ToDecimal(Convert.ToString(Request["rnk"])), ParameterDirection.Input);

            OracleDataReader rdr = cmdGetInfo.ExecuteReader();

            if (!rdr.Read())
                throw new TechAccountsException("Дані про клієнта rnk=" +
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
            /// Поповнення готівкою
            cmdGetInfo.CommandText = "SELECT tt_main FROM v_techacc_operations WHERE op_id = :op_id";
            cmdGetInfo.Parameters.Add("op_id", OracleDbType.Decimal, 196, ParameterDirection.Input);            
            tt.Value = Convert.ToString(cmdGetInfo.ExecuteScalar());

            cmdGetInfo.Parameters.Clear();
            /// Комісія за поповнення готівкою
            cmdGetInfo.CommandText = "SELECT tt_comiss FROM v_techacc_operations WHERE op_id = :op_id";
            cmdGetInfo.Parameters.Add("op_id", OracleDbType.Decimal, 196, ParameterDirection.Input);            
            tt_K.Value = Convert.ToString(cmdGetInfo.ExecuteScalar());

            cmdGetInfo.Parameters.Clear();
            /// Комісія за поповнення безготівкою в нац. валюті
            cmdGetInfo.CommandText = "SELECT tt_comiss FROM v_techacc_operations WHERE op_id = :op_id";
            cmdGetInfo.Parameters.Add("op_id", OracleDbType.Decimal, 197, ParameterDirection.Input);            
            tt_K_N.Value = Convert.ToString(cmdGetInfo.ExecuteScalar());

            cmdGetInfo.Parameters.Clear();
            /// Комісія за поповнення безготівкою в іноземній валюті
            cmdGetInfo.CommandText = "SELECT tt_comiss FROM v_techacc_operations WHERE op_id = :op_id";
            cmdGetInfo.Parameters.Add("op_id", OracleDbType.Decimal, 198, ParameterDirection.Input);            
            tt_K_F.Value = Convert.ToString(cmdGetInfo.ExecuteScalar());

            cmdGetInfo.Parameters.Clear();
            /// Дістаємо номер рахунку
            cmdGetInfo.CommandText = @"SELECT nls FROM saldo WHERE acc=:acc";
            cmdGetInfo.Parameters.Add("acc",OracleDbType.Decimal,
                Convert.ToDecimal(Convert.ToString(Request["acc"])),ParameterDirection.Input);
            NLS.Value = Convert.ToString(cmdGetInfo.ExecuteScalar());

            cmdGetInfo.Parameters.Clear();

            cmdGetInfo.CommandText = @"SELECT v.tech_accnum, v.tech_currency, 
                TO_CHAR(v.tech_dat_open,'dd/mm/yyyy'),
                TO_CHAR(v.tech_saldo/100,'999999999990.99'), 
                v.tech_custnum, v.tech_customer, v.tech_custid, v.dpt_num,t.kv
                FROM v_dpt_tech_accounts v, tabval t
                WHERE v.tech_accid = :acc and v.tech_currency = t.lcv";

            cmdGetInfo.Parameters.Add("acc", OracleDbType.Decimal, Convert.ToDecimal(Request["acc"]), ParameterDirection.Input);

            rdr = cmdGetInfo.ExecuteReader();

            if (!rdr.Read())
                throw new TechAccountsException("Дані про рахунок acc=" +
                    Convert.ToString(Request["acc"]) + " не знайдені!");

            if (!rdr.IsDBNull(0))
                textNLS.Text = Convert.ToString(rdr.GetOracleString(0).Value);
            if (!rdr.IsDBNull(1))
                textKV.Text = Convert.ToString(rdr.GetOracleString(1).Value);
            if (!rdr.IsDBNull(2))
                textDAT.Text = Convert.ToString(rdr.GetOracleString(2).Value);
            if (!rdr.IsDBNull(3))
                textSUM.Text = Convert.ToString(rdr.GetOracleString(3).Value);
            if (!rdr.IsDBNull(4))
                textRNK.Text = Convert.ToString(rdr.GetOracleDecimal(4).Value);
            if (!rdr.IsDBNull(5))
                textNMK.Text = Convert.ToString(rdr.GetOracleString(5).Value);
            if (!rdr.IsDBNull(6))
                textOKPO.Text = Convert.ToString(rdr.GetOracleString(6).Value);
            if (!rdr.IsDBNull(7))
                textDPT_ID.Text = Convert.ToString(rdr.GetOracleString(7).Value);
            if (!rdr.IsDBNull(8))
                KV.Value = Convert.ToString(rdr.GetOracleDecimal(8).Value);

            cmdGetInfo.Parameters.Clear();


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
