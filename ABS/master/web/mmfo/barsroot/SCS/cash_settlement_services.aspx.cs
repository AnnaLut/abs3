using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Bars.UserControls;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

public partial class cash_settlement_services : System.Web.UI.Page
{
    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            InitContols();
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
    }
   
    protected void btnApply_Click(object sender, EventArgs e)
    {
        List<Decimal?> IDs = new List<Decimal?>();
        
        // вычисляем масив ID для удаления или "дату отрезки"
        switch (rblObject2Apply.SelectedValue)
        {
            case "ALL":
                List<Bars.SCS.VSmsAccSendRecord> recs = (List<Bars.SCS.VSmsAccSendRecord>)ods.Select();
                foreach (Bars.SCS.VSmsAccSendRecord rec in recs)
                    IDs.Add(rec.ACC);
                break;
            case "SELECTED":
                foreach (GridViewRow row in gv.Rows)
                {
                    CheckBox cbSelect = row.FindControl("cbSelect") as CheckBox;
                    if (cbSelect.Checked)
                        IDs.Add((Decimal?)gv.DataKeys[row.RowIndex]["ACC"]);
                }
                break;
            
        }

        // обрабатываем полученный масив и считаем кол-во отработаных рядков
        Bars.SCS.SmsClearancePack SmsPack = new Bars.SCS.SmsClearancePack(new ibank.core.BbConnection());
        Int32 MsgCount = 0;
        switch (rblObject2Apply.SelectedValue)
        {
            case "ALL":
            case "SELECTED":
                foreach (Decimal? ID in IDs)
                {
                    switch (rblAction.SelectedValue)
                    {
                        case "CHARGE":
                            SmsPack.PAY_FOR_SMS_BY_ACC(ID);
                            break;
                        case "PAY":
                            SmsPack.PAY_CLEARANCE(ID);
                            break;
                        case "TRANSFER":
                            SmsPack.TRANSFER_CLEARANCE(ID);
                            break;
                    }
                }
                MsgCount = IDs.Count;
                break;
           
        }

        // перечитываем грид и выдаем сообщение
        gv.DataBind();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert_success", String.Format("alert('Виконано успішно. Оброблено {0} записів.'); ", MsgCount), true);
    }
  
    # endregion

    # region Приватные методы
    private void InitContols()
    {
        tbFrom.Value = DateTime.Now.AddDays(-7);
        tbTo.Value = DateTime.Now.AddDays(1);

   //     rblObject2Apply_SelectedIndexChanged(rblObject2Apply, new EventArgs());
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