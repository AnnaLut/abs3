using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Bars.UserControls;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

public partial class admin_ead_sync_queue : System.Web.UI.Page
{
    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            InitContols();
    }
    protected void btnFilter_Click(object sender, EventArgs e)
    {
        gv.DataBind();
    }
    protected void ods_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        // обязательная фильтрация по датам
        e.InputParameters["From"] = tbFrom.Value;
        e.InputParameters["To"] = tbTo.Value;

        // фильтрация по статусу
        List<String> Status = new List<String>();
        foreach (ListItem li in lbStatus.Items)
            if (li.Selected)
                Status.Add(li.Value);
        e.InputParameters["Status"] = Status;

        // фильтрация по типу
        List<String> Type = new List<String>();
        foreach (ListItem li in lbType.Items)
            if (li.Selected)
                Type.Add(li.Value);
        e.InputParameters["Type"] = Type;

        // фильтрация по перечню объектов
        List<String> ObjID = new List<String>();
        foreach (String ID in tbObjID.Text.Split(';'))
            if (!String.IsNullOrEmpty(ID))
                ObjID.Add(ID.Trim());
        e.InputParameters["ObjID"] = ObjID;

        // фильтрация по RNK (COBUSUPABS-4648)
        List<String> ObjRNK = new List<String>();
        foreach (String RNK in tbRNK.Text.Split(';'))
            if (!String.IsNullOrEmpty(RNK))
                ObjRNK.Add(RNK.Trim());
        e.InputParameters["ObjRNK"] = ObjRNK;
        // фильтрация по кол-ву ошибок(COBUSUPABS-3141)

        List<Decimal?> ERR_COUNT = new List<Decimal?>();
        try
        {
            foreach (String cnt in tbErrCnt.Text.Split(';'))
                if (!String.IsNullOrEmpty(cnt))
                    ERR_COUNT.Add(Convert.ToDecimal(cnt.Trim()));
        }
        catch (Exception ex)
        {
            // gv.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert_success", String.Format("alert('Невірний формат даних: кількість помилок!'); "), true);
        }
        e.InputParameters["ErrCount"] = ERR_COUNT;

        // фильтрация по тексту ошибок(COBUSUPABS-3141)
        if (tbErrTxt.Text.Length > 500)
        {
            tbErrTxt.Text = tbErrTxt.Text.Substring(0,500) ;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert_success", String.Format("alert('Текст помилки був занадто довгий! Текст скорочено до 500 символів.'); "), true);
        }
       
        e.InputParameters["ErrText"] = tbErrTxt.Text;

    }
    protected void rblObject2Apply_SelectedIndexChanged(object sender, EventArgs e)
    {
        dlAgeWeeks.Enabled = (rblObject2Apply.SelectedValue == "OLDER_THEN");

        if (rblObject2Apply.SelectedValue == "OLDER_THEN")
        {
            if (rblAction.Items.FindByValue("PROC").Selected)
                rblAction.SelectedIndex = 1; // DEL

            rblAction.Items.FindByValue("PROC").Enabled = false;
        }
        else
        {
            rblAction.Items.FindByValue("PROC").Enabled = true;
        }
    }
    protected void btnApply_Click(object sender, EventArgs e)
    {
        List<Decimal?> IDs = new List<Decimal?>();
        DateTime CutoffDate = DateTime.Now.Date.AddYears(-1);

        // вычисляем масив ID для удаления или "дату отрезки"
        switch (rblObject2Apply.SelectedValue)
        {
            case "ALL":
                List<Bars.EAD.VEadSyncQueueRecord> recs = (List<Bars.EAD.VEadSyncQueueRecord>)ods.Select();
                foreach (Bars.EAD.VEadSyncQueueRecord rec in recs)
                    IDs.Add(rec.SYNC_ID);
                break;
            case "SELECTED":
                foreach (GridViewRow row in gv.Rows)
                {
                    CheckBox cbSelect = row.FindControl("cbSelect") as CheckBox;
                    if (cbSelect.Checked)
                        IDs.Add((Decimal?)gv.DataKeys[row.DataItemIndex]["SYNC_ID"]);
                }
                break;
            case "OLDER_THEN":
                CutoffDate = DateTime.Now.Date.AddDays(-7 * Convert.ToInt16(dlAgeWeeks.SelectedValue));
                break;
        }

        // обрабатываем полученный масив и считаем кол-во отработаных рядков
        Bars.EAD.EadPack ep = new Bars.EAD.EadPack(new ibank.core.BbConnection());
        Int32 MsgCount = 0;
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        cmd.Parameters.Clear();
        cmd.CommandText = "SELECT  sys_context('bars_context','user_mfo')  FROM dual";
        cmd.CommandType = CommandType.Text;
        string KF = Convert.ToString(cmd.ExecuteScalar());
        switch (rblObject2Apply.SelectedValue)
        {
            case "ALL":
            case "SELECTED":
                foreach (Decimal? ID in IDs)
                {
                    switch (rblAction.SelectedValue)
                    {
                        case "PROC":
                            ep.MSG_PROCESS(ID, KF);
                            break;
                        case "DEL":
                            ep.MSG_DELETE(ID, KF);
                            break;
                    }
                }
                MsgCount = IDs.Count;
                break;
            case "OLDER_THEN":
                switch (rblAction.SelectedValue)
                {
                    case "DEL":
                        MsgCount = Convert.ToInt32(ep.MSG_DELETE_OLDER(CutoffDate, KF));
                        break;
                    default:
                        break;
                }
                break;
        }

        // перечитываем грид и выдаем сообщение
        gv.DataBind();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert_success", String.Format("alert('Виконано успішно. Оброблено {0} повідомлень.'); ", MsgCount), true);
    }
    protected void btnSyncDict_Click(object sender, EventArgs e)
    {
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        cmd.Parameters.Clear();
        cmd.CommandText = "SELECT  sys_context('bars_context','user_mfo')  FROM dual";
        cmd.CommandType = CommandType.Text;
        string  KF = Convert.ToString(cmd.ExecuteScalar());

        Bars.EAD.EadPack ep = new Bars.EAD.EadPack(new ibank.core.BbConnection());
        Decimal? ID;

        ID = ep.MSG_CREATE("DICT", "EA-UB", null, KF);
        ep.MSG_PROCESS(ID, KF);

    }
    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        String CommandName = e.CommandName;

        switch (CommandName)
        {
            case "DLMessage":
            case "DLResponce":
                Int64 SYNC_ID = Convert.ToInt64(e.CommandArgument);

                OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                OracleCommand cmd = con.CreateCommand();

                cmd.Parameters.Add("p_sync_id", OracleDbType.Int64, SYNC_ID, System.Data.ParameterDirection.Input);
                cmd.CommandText = String.Format("select sq.{0} from ead_sync_queue sq where sq.id = :p_sync_id", CommandName == "DLMessage" ? "message" : "responce");

                String ResText = Convert.ToString(cmd.ExecuteScalar());
                if (!String.IsNullOrEmpty(ResText))
                    WriteFile2Responce(ResText, String.Format("{0}_{1}.txt", CommandName, SYNC_ID));

                break;
            default:
                break;
        }
    }
    # endregion

    # region Приватные методы
    private void InitContols()
    {
        tbFrom.Value = DateTime.Now.AddDays(-7);
        tbTo.Value = DateTime.Now.AddDays(1);

        rblObject2Apply_SelectedIndexChanged(rblObject2Apply, new EventArgs());
    }
    private void WriteFile2Responce(String FileText, String FileName)
    {
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "windows-1251";
        Response.AppendHeader("content-disposition", String.Format("attachment;filename={0}", FileName));
        Response.ContentType = "text/plain";
        Response.Write(FileText);
        Response.Flush();
        Response.Close();
    }
    # endregion
}