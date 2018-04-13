using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text;
using System.Web.UI;
using Bars.Classes;
using barsroot.cim;
using DotNetDBF;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

public partial class cim_sanctions_default : System.Web.UI.Page
{
    private void loadData()
    {
        dsSanctions.SelectParameters.Clear();
        Bars.DataComponents.BarsGridViewEx gv;
        gvSanctionsRez.Visible = false;
        gvSanctionsNotRez.Visible = false;
        string sqlStatement = "select * from {0} where 1=1";
        if (rblRez.SelectedIndex == 0)
        {
            sqlStatement = string.Format(sqlStatement, "v_cim_f98_rez ");
            gv = gvSanctionsRez;
            if (!string.IsNullOrEmpty(tbSNameR11.Text))
            {
                sqlStatement += " and upper(r1_1) like upper(:r1_1) ";
                dsSanctions.SelectParameters.Add("r1_1", DbType.String, "%" + tbSNameR11.Text.Trim().ToUpper() + "%");
            }
            if (!string.IsNullOrEmpty(tbSOkpo.Text))
            {
                sqlStatement += " and k020 = :k020";
                dsSanctions.SelectParameters.Add("k020", DbType.String, tbSOkpo.Text);
            }
            if (cbOurClient.Checked)
            {
                sqlStatement += " and our_client is not null";
            }
        }
        else
        {
            sqlStatement = string.Format(sqlStatement, "v_cim_f98_notrez ");
            gv = gvSanctionsNotRez;
            if (!string.IsNullOrEmpty(tbSNameR4.Text))
            {
                sqlStatement += " and upper(r4) like upper(:r4) ";
                dsSanctions.SelectParameters.Add("r4", DbType.String, "%" + tbSNameR4.Text.Trim().ToUpper() + "%");
            }
            if (!string.IsNullOrEmpty(tbSCountry.Text))
            {
                sqlStatement += " and k040 = :ko40";
                dsSanctions.SelectParameters.Add("ko40", DbType.String, tbSCountry.Text);
            }
        }

        if (!string.IsNullOrEmpty(tbSStartNum.Text))
        {
            sqlStatement += " and nomnak = :nomak ";
            dsSanctions.SelectParameters.Add("nomak", DbType.String, tbSStartNum.Text);
        }
        if (!string.IsNullOrEmpty(tbSStopNum.Text))
        {
            sqlStatement += " and nomnaksk = :nomnaksk ";
            dsSanctions.SelectParameters.Add("nomnaksk", DbType.String, tbSStopNum.Text);
        }
        if (!string.IsNullOrEmpty(tbStartDate.Text))
        {
            sqlStatement += " and trunc(dt) >= to_date(:start_date,'DD/MM/YYYY') ";
            dsSanctions.SelectParameters.Add("start_date", DbType.String, tbStartDate.Text);
        }
        if (!string.IsNullOrEmpty(tbFinishDate.Text))
        {
            sqlStatement += " and trunc(dt) <= to_date(:finish_date,'DD/MM/YYYY') ";
            dsSanctions.SelectParameters.Add("finish_date", DbType.String, tbFinishDate.Text);
        }

        sqlStatement += " and ( " + ((cbZast.Checked) ? ("1") : ("0")) + "= 1 or v_sank != 1) and (" + ((cbSkas.Checked) ? ("1") : ("0")) + " =1 or v_sank != 2) ";

        gv.Visible = true;
        dsSanctions.SelectCommand = sqlStatement;
        gv.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        lbTotalCount.Text = getF98Count();
        dsCountries.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        Master.SetPageTitle(this.Title, true);
        ScriptManager.GetCurrent(this).RegisterPostBackControl(btImportF98);
        Master.AddScript("/barsroot/cim/sanctions/scripts/default.js");

        dsSanctions.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        if (!IsPostBack)
        {
            if (Session[barsroot.cim.Constants.StateKeys.SyncSide] == null)
                new CimManager(true);

            byte syncSide = Convert.ToByte(Session[barsroot.cim.Constants.StateKeys.SyncSide]);
            pnImportF98.Visible = syncSide == 1;
            pnSyncF98.Visible = syncSide == 0;
            if (Request["code"] != null)
            {
                if (Request["code"] == "3")
                    rblRez.SelectedIndex = 1;
                tbSOkpo.Text = Convert.ToString(Session[barsroot.cim.Constants.StateKeys.ContrTaxCode]);
                tbSNameR4.Text = Convert.ToString(Session[barsroot.cim.Constants.StateKeys.ContrBenefName]);
                Session.Remove(barsroot.cim.Constants.StateKeys.ContrTaxCode);
                Session.Remove(barsroot.cim.Constants.StateKeys.ContrBenefName);
                loadData();
            }
        }
        else
        {
            loadData();
        }
    }
    private string convertToWin(object source)
    {
        return Convert.ToString(source).Replace('ў', 'і').Replace('Ў', 'І').Replace('•', 'ї').Replace('Ї', 'Є').Replace('°', 'Ї').Replace('∙', '_').Trim();
    }

    private string getF98Count()
    {
        OracleConnection con = Bars.Classes.OraConnector.Handler.UserConnection;
        try
        {
            if (con.State != ConnectionState.Open)
                con.Open();
            OracleCommand command = new OracleCommand();
            command.Connection = con;
            command.CommandText = "select count(*) from cim_f98 where delete_date is null";

            string count = Convert.ToString(command.ExecuteScalar());
            Session["CIM.F98_COUNT"] = count;
            command.Dispose();
            return count;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    protected void btImportF98_Click(object sender, EventArgs e)
    {
        Master.WriteMessage(lbInfo, string.Empty, MessageType.Info);

        if (fuF98.HasFile)
        {
            string tempFile = string.Empty;
            try
            {
                string tempDir = Path.Combine(Path.GetTempPath(), "F98");
                if (!Directory.Exists(tempDir))
                    Directory.CreateDirectory(tempDir);
                tempFile = Path.Combine(tempDir, Path.GetFileName(fuF98.FileName));
                if (File.Exists(tempFile))
                    File.Delete(tempFile);
                fuF98.SaveAs(tempFile);
                DateTime dt = DateTime.Now;
                Master.WriteMessage(lbInfo, "Розпочата обробка файлу, зачекайте ...", MessageType.Info);

                OracleConnection con = Bars.Classes.OraConnector.Handler.UserConnection;
                try
                {
                    var command = new OracleCommand();
                    command.Connection = con;
                    byte[] data = File.ReadAllBytes(tempFile);
                    command.CommandType = CommandType.StoredProcedure;

                    command.CommandText = "bars_dbf.load_dbf";
                    command.Parameters.Add("p_dbfblob", OracleDbType.Blob, data, ParameterDirection.Input);
                    command.Parameters.Add("p_tabname", OracleDbType.Varchar2, "CIM_F98_LOAD", ParameterDirection.InputOutput);
                    command.Parameters.Add("p_createmode", OracleDbType.Decimal, 2, ParameterDirection.Input);
                    command.Parameters.Add("p_srcencode", OracleDbType.Varchar2, "UKG", ParameterDirection.Input);
                    command.Parameters.Add("p_destencode", OracleDbType.Varchar2, "WIN", ParameterDirection.Input);
                    command.ExecuteNonQuery();

                    command.Parameters.Clear();
                    command.Parameters.Add("p_total_count", OracleDbType.Decimal, ParameterDirection.Output);
                    command.Parameters.Add("p_upd_count", OracleDbType.Decimal, ParameterDirection.Output);
                    command.Parameters.Add("p_ins_count", OracleDbType.Decimal, ParameterDirection.Output);
                    command.CommandText = "cim_sync.f98_update";
                    command.ExecuteNonQuery();

                    decimal totalCount = ((OracleDecimal)command.Parameters["p_total_count"].Value).Value;
                    decimal updCount = ((OracleDecimal)command.Parameters["p_upd_count"].Value).Value;
                    decimal insCount = ((OracleDecimal)command.Parameters["p_ins_count"].Value).Value;

                    int sec = Convert.ToInt32((DateTime.Now - dt).TotalSeconds);
                    Master.WriteMessage(lbInfo, string.Format("Файл успішно завантажено! Оброблено {0} стрічки(ок)(з них {1} - оновлено, {2} - добавлено). Час імпорту - {3} сек.", totalCount, updCount, insCount, sec), MessageType.Success);
                    loadData();
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
                lbTotalCount.Text = getF98Count();
            }
            catch (Exception ex)
            {
                Master.WriteMessage(lbInfo, "Помилка обробки файлу [" + ex.Message + "]", MessageType.Error);
                return;
            }
            finally
            {
                try { File.Delete(tempFile); }
                catch { }
            }
        }
        else
        {
            Master.WriteMessage(lbInfo, "Виберіть файл для імпорту!", MessageType.Error);
        }
    }
    protected void rblRez_SelectedIndexChanged(object sender, EventArgs e)
    {
        trOKPO.Visible = rblRez.SelectedIndex == 0;
        trNameR11.Visible = rblRez.SelectedIndex == 0;
        trNameR4.Visible = rblRez.SelectedIndex == 1;
        trCountry.Visible = rblRez.SelectedIndex == 1;
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {

    }
    protected void btClear_Click(object sender, EventArgs e)
    {
        tbSStopNum.Text = string.Empty;
        tbSStartNum.Text = string.Empty;
        tbSNameR11.Text = string.Empty;
        tbSNameR4.Text = string.Empty;
        tbSCountry.Text = string.Empty;
        tbSOkpo.Text = string.Empty;
    }

    protected void btSyncF98_OnClick(object sender, EventArgs e)
    {
        OracleConnection con = Bars.Classes.OraConnector.Handler.UserConnection;
        try
        {
            OracleCommand command = new OracleCommand();
            command.Connection = con;
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("p_table_name", OracleDbType.Varchar2, "CIM_F98", ParameterDirection.Input);
            command.Parameters.Add("p_result", OracleDbType.Varchar2, ParameterDirection.Output);
            command.Parameters.Add("p_total_count", OracleDbType.Decimal, ParameterDirection.Output);
            command.CommandText = "cim_sync.sync_table";

            command.ExecuteNonQuery();

            var result = (OracleString)command.Parameters["p_result"].Value; 
            if (result.IsNull)
            {
                decimal totalCount = ((OracleDecimal)command.Parameters["p_total_count"].Value).Value;
                if(totalCount > 0)
                    Master.WriteMessage(lbInfoSync, String.Format("Синхронізацію успішно виконано. Оброблено {0} стрічки(ок)!", totalCount), MessageType.Success);
                else
                    Master.WriteMessage(lbInfoSync, "Синхронізація не потрібна, довідник в актуальному стані.", MessageType.Success);
            }
            else
                Master.WriteMessage(lbInfoSync, "Помилка при синхронізації - " + result.Value, MessageType.Error);

            command.Dispose();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }
}