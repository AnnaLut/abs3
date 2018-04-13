using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using System.IO;
using System.Text;

using Bars.DataComponents;
using Bars.UserControls;
using Bars.W4;

using ibank.core;

public partial class w4_import_esk_file : Bars.BarsPage
{
    # region Приватные свойства
    # endregion

    # region Публичные свойства
    public Decimal? File_ID
    {
        get { return (Decimal?)ViewState["File_ID"]; }
        set { ViewState["File_ID"] = value; }
    }
    public String File_Name
    {
        get { return (String)ViewState["File_Name"]; }
        set { ViewState["File_Name"] = value; }
    }
    public String Ticket_Name
    {
        get { return (String)ViewState["Ticket_Name"]; }
        set { ViewState["Ticket_Name"] = value; }
    }
    public String Ticket_Body
    {
        get { return (String)ViewState["Ticket_Body"]; }
        set { ViewState["Ticket_Body"] = value; }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void wzd_ActiveStepChanged(object sender, EventArgs e)
    {
        Label lStepTitle = (wzd.FindControl("HeaderContainer").FindControl("lStepTitle") as Label);
        lStepTitle.Text = wzd.ActiveStep.Title;
    }
    protected void wzd_NextButtonClick(object sender, WizardNavigationEventArgs e)
    {
        // действия в зависимости от шага
        BbConnection con = new BbConnection();
        BarsOwesk owEsk = new BarsOwesk(con);
        try
        {
            switch (wzd.WizardSteps[e.CurrentStepIndex].ID)
            {
                case "wsFile":
                    # region wsFile
                    if (fuFile.HasFile)
                    {
                        Decimal? FileID;
                        String FileName = System.IO.Path.GetFileName(fuFile.PostedFile.FileName);
                        String FileBody = (new System.IO.StreamReader(fuFile.PostedFile.InputStream, System.Text.Encoding.GetEncoding(1251))).ReadToEnd();

                        owEsk.W4_IMPORT_ESK_FILE(FileName, FileBody, out FileID);

                        File_ID = FileID;
                        File_Name = FileName;
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "no_file_alert", "alert('Не вибрано файл'); ", true);
                        e.Cancel = true;
                    }
                    # endregion
                    break;
                case "wsProcParams":
                    # region wsProcParams
                    String P_CARD_CODE = null;

                    P_CARD_CODE = CARDCODE.Value;

                    # endregion
                    break;
                case "wsProcCheck":
                    # region wsProcParams

                    # endregion
                    break;
            }
        }
        finally
        {
            con.CloseConnection();
        }
    }
    protected void wzd_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, typeof(Page), "finish", "location.href = '/barsroot/w4/import_esk_file.aspx'; ", true);
    }

    protected void odsVOwEskData_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["FileID"] = File_ID;
    }
    protected void odsVOwEskData2_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["FileID"] = File_ID;
    }

    protected void wsImportResults_Activate(object sender, EventArgs e)
    {
        InitOraConnection();
        try
        {
            SetParameters("p_fileid", DB_TYPE.Decimal, File_ID, DIRECTION.Input);
            ArrayList res = SQL_reader(@"select count(*) all_rows,
                                               sum(decode(nd, null, 0, 1)) good_rows,
                                               sum(decode(nd, null, 1, 0)) bad_rows,
                                               sum(decode(str_err, null, 0, 1)) err_rows
                                          from ow_salary_data
                                         where id = :p_fileid");
            FileTitle.Text = String.Format("Файл: {0} (рядків всього: {1}, помилки {2})", File_Name, res[0], res[3]);
        }
        finally
        {
            DisposeOraConnection();
        }
    }
    protected void wsProcCheck_Activate(object sender, EventArgs e)
    {
        InitOraConnection();
        try
        {
            SetParameters("p_fileid", DB_TYPE.Decimal, File_ID, DIRECTION.Input);
            ArrayList res = SQL_reader(@"select count(*) all_rows,
                                               sum(decode(flag_open, 0, 1, 0)) notopen,
                                               sum(decode(flag_open, 1, 1, 0)) open,
                                               sum(decode(flag_open, 2, 1, 0)) ask
                                          from ow_salary_data
                                         where id = :p_fileid");

            // если нечего спрашивать то идем на след шаг
            Decimal Ask = (Decimal)res[3];
            if (Ask == 0)
            {
                // добавить переход
                wzd.ActiveStepIndex = 4;
            }

            CheckTitle.Text = String.Format("Файл: {0} (рядків всього: {1}, не відкривати {2}, відкривати {3}, вже відкрито такого продукту {4})", File_Name, res[0], res[1], res[2], res[3]);
        }
        finally
        {
            DisposeOraConnection();
        }
    }
    protected void wsProcResults_Activate(object sender, EventArgs e)
    {
        // открываем карты
        Decimal? P_PROECT_ID = null;
        String P_CARD_CODE = null;

        P_PROECT_ID = String.IsNullOrEmpty(PROJECT.Value) ? (Decimal?)null : Convert.ToDecimal(PROJECT.Value);
        P_CARD_CODE = CARDCODE.Value;

        String P_BRANCH = BRANCH.Value;
        Decimal? P_ISP = Convert.ToDecimal(STAFF.Value);

        String P_TICKETNAME;
        String P_TICKETBODY;

        BbConnection con = new BbConnection();
        BarsOwesk ow = new BarsOwesk(con);
        ow.W4_CREATE_ESK_DEAL(File_ID, P_PROECT_ID, P_CARD_CODE, P_BRANCH, P_ISP, out P_TICKETNAME, out P_TICKETBODY);
        con.CloseConnection();

        Ticket_Name = P_TICKETNAME;
        Ticket_Body = P_TICKETBODY;

        // отображение результатов
        InitOraConnection();
        try
        {
            SetParameters("p_fileid", DB_TYPE.Decimal, File_ID, DIRECTION.Input);
            ArrayList res = SQL_reader(@"select count(*) all_rows,
                                               sum(decode(nd, null, 0, 1)) good_rows,
                                               sum(decode(nd, null, 1, 0)) bad_rows,
                                               sum(decode(str_err, null, 0, 1)) err_rows
                                          from ow_salary_data
                                         where id = :p_fileid");
            FileResTitle.Text = String.Format("Файл: {0} (рядків всього: {1}, оброблено {2}, не оброблено {3}, помилки {4})", File_Name, res[0], res[1], res[2], res[3]);
        }
        finally
        {
            DisposeOraConnection();
            con.CloseConnection();
        }
    }

    protected void BRANCH_ValueChanged(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(BRANCH.Value))
        {
            OurBranchRecord Branch = (new OurBranch()).SelectBranch(BRANCH.Value);
            BRANCHNAME.Text = Branch.NAME;
            STAFF.WHERE_CLAUSE = String.Format("WHERE BRANCH = '{0}'", BRANCH.Value);
        }
        else
        {
            BRANCHNAME.Text = String.Empty;
            STAFF.WHERE_CLAUSE = String.Empty;
        }

        STAFF.Value = String.Empty;
        STAFF_ValueChanged(STAFF, null);
    }
    protected void STAFF_ValueChanged(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(STAFF.Value))
        {
            StaffRecord Staff = (new Staff()).SelectStaff(Convert.ToDecimal(STAFF.Value));
            STAFFFIO.Text = String.Format("{0} - {1}", Staff.LOGNAME, Staff.FIO);
        }
        else
        {
            STAFFFIO.Text = String.Empty;
        }
    }

    protected void FileResMatch_Click(object sender, EventArgs e)
    {
        String TempFilePath = System.IO.Path.GetTempFileName();
        using (StreamWriter sw = new StreamWriter(TempFilePath, false, Encoding.GetEncoding(1251)))
        {
            sw.Write(Ticket_Body);
            sw.Close();
        }

        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "windows-1251";
        Response.AppendHeader("content-disposition", String.Format("attachment;filename={0}", Ticket_Name));
        Response.ContentType = "application/xml";
        Response.WriteFile(TempFilePath, true);
        Response.Flush();
        Response.Close();

        try
        {
            File.Delete(TempFilePath);
        }
        catch
        {
            // если занят то ничо не делаем
        }
    }

    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        // умолчательная кнопка
        Button btMoveNext = null;
        Button btMovePrevious = null;
        switch (wzd.ActiveStep.StepType)
        {
            case WizardStepType.Start:
                btMoveNext = (wzd.FindControl("StartNavigationTemplateContainerID").FindControl("btMoveNext") as Button);
                break;
            case WizardStepType.Step:
                btMovePrevious = (wzd.FindControl("StepNavigationTemplateContainerID").FindControl("btMovePrevious") as Button);
                btMoveNext = (wzd.FindControl("StepNavigationTemplateContainerID").FindControl("btMoveNext") as Button);
                break;
            case WizardStepType.Finish:
                btMovePrevious = (wzd.FindControl("FinishNavigationTemplateContainerID").FindControl("btMovePrevious") as Button);
                btMoveNext = (wzd.FindControl("FinishNavigationTemplateContainerID").FindControl("btMoveNext") as Button);
                break;
        }
        Page.Form.DefaultButton = btMoveNext.UniqueID;

        switch (wzd.ActiveStep.ID)
        {
            case "wsProcResults":
                btMoveNext.OnClientClick = String.Format("if (confirm('{0}')) {{ $get('{1}').click(); return false; }}", "Завантажити квитанцію?", FileResMatch.ClientID);
                break;
        }
    }
    # endregion

    # region Приватные методы
    # endregion
}