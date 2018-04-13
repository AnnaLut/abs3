using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Oracle.DataAccess.Client;
using Bars.Logger;
using Bars.Oracle;
using System.IO;
using Bars.Exception;

/// <summary>
/// Депозитний модуль: Друк
/// </summary>
public partial class cmd : Bars.BarsPage
{
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void Page_Load(object sender, System.EventArgs e)
    {
        if (Session["DPTPRINT_DPTID"] == null)
        {
            Response.Write("<script>alert('Відсутні параметри виклику!');</script>");
            return;
        }

        Page.Header.Title = Resources.Deposit.GlobalResources.hCmd;

        btPrint.Attributes["onclick"] = "fnShowProgress()";

        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            // Установка роли
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            Decimal dpt_id = Convert.ToDecimal(Convert.ToString(Session["DPTPRINT_DPTID"]));

            OracleCommand cmdGetBlanksParam = connect.CreateCommand();
            cmdGetBlanksParam.CommandText = "select nvl(val,'0') from params where par='DPT_BLNK'";
            String result = Convert.ToString(cmdGetBlanksParam.ExecuteScalar());

            Decimal agr_id = 1;
            if (Session["DPTPRINT_AGRID"] != null)
                agr_id = Convert.ToDecimal(Convert.ToString(Session["DPTPRINT_AGRID"]));

            OracleCommand cmdGetPrintOnBlank = connect.CreateCommand();
            cmdGetPrintOnBlank.CommandText = @"select nvl(s.print_on_blank,'0')
                  from doc_scheme s, dpt_deposit_clos d, dpt_vidd_scheme v
                 where d.deposit_id = :dpt_id
                   and v.flags      = :agr_id 
                   and s.id         = v.id 
                   and v.vidd       = d.vidd 
                   and d.idupd      = (select max(d1.idupd) from dpt_deposit_clos d1
                 where d1.deposit_id = d.deposit_id and d1.bdate <= bankdate)";
            cmdGetPrintOnBlank.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
            cmdGetPrintOnBlank.Parameters.Add("agr_id", OracleDbType.Decimal, agr_id, ParameterDirection.Input);
            String Print = Convert.ToString(cmdGetPrintOnBlank.ExecuteScalar());

            if (result != "1" || Print != "1")
            {
                tbBlanks.Visible = false;
                deadBlankNumValidator.Enabled = false;
                DptBlankNumValidator.Enabled = false;
            }
            else if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
            {
                OracleCommand cmdGetFirst = connect.CreateCommand();
                cmdGetFirst.CommandText = @"select count(b.id)
                      from dpt_blank b, dpt_deposit_clos d, dpt_vidd_scheme s 
                     where b.deposit_id = :dpt_id 
                       and s.flags      = :agr_id 
                       and d.deposit_id = b.deposit_id 
                       and d.vidd       = s.vidd
                       and s.id         = b.doc_scheme_id 
                       and d.idupd      = (select max(d1.idupd) from dpt_deposit_clos d1
                        where d1.deposit_id = d.deposit_id and d1.bdate <= bankdate)";
                cmdGetFirst.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                cmdGetFirst.Parameters.Add("agr_id", OracleDbType.Decimal, agr_id, ParameterDirection.Input);
                Decimal res = Convert.ToDecimal(Convert.ToString(cmdGetFirst.ExecuteScalar()));

                if (res <= 0)
                {
                    /// Друкуємо перший раз
                    FIRST_PRINT.Value = "1";
                    deadBlankNumValidator.Enabled = false;
                    deadBlankNum.Enabled = false;
                }
                else
                {
                    /// Вже має бути зіпсований бланк
                    FIRST_PRINT.Value = "0";
                    deadBlankNumValidator.Enabled = true;
                    deadBlankNum.Enabled = true;
                }

                cmdGetFirst.Dispose();
            }

            cmdGetPrintOnBlank.Dispose();
            cmdGetBlanksParam.Dispose();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

    #region Web Form Designer generated code
    override protected void OnInit(EventArgs e)
    {
        //
        // CODEGEN: This call is required by the ASP.NET Web Form Designer.
        //
        base.OnInit(e);
    }
    #endregion
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btPrint_Click(object sender, System.EventArgs e)
    {
        enable_print.Value = "1";

        OracleConnection connect = new OracleConnection();
        try
        {
            // Создаем соединение
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            // Открываем соединение с БД
            

            // Установка роли
            OracleCommand cmdSetRole = new OracleCommand();
            cmdSetRole.Connection = connect;
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            String template = String.Empty;
            if (Session["DPTPRINT_TEMPLATE"] != null)
                template = Convert.ToString(Session["DPTPRINT_TEMPLATE"]);
            Decimal dpt_id = Convert.ToDecimal(Convert.ToString(Session["DPTPRINT_DPTID"]));
            String id = Convert.ToString(dptBlankNum.Text);
            String did = Convert.ToString(deadBlankNum.Text);

            if (tbBlanks.Visible && ckUse.Checked)
            {

                if (template == String.Empty)
                {
                    OracleCommand cmdGetTemplateId = connect.CreateCommand();
                    cmdGetTemplateId.CommandText = @"select s.id 
                          from dpt_vidd_scheme s, dpt_deposit_clos d
                         where d.deposit_id = :dpt_id
                           and s.vidd       = d.vidd 
                           and s.flags      = 1 
                           and d.idupd      = (select max(d1.idupd) from dpt_deposit_clos d1
                         where d1.deposit_id = d.deposit_id and d1.bdate <= bankdate)";
                    cmdGetTemplateId.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

                    template = Convert.ToString(cmdGetTemplateId.ExecuteScalar());
                }

                if (deadBlankNum.Enabled)
                {
                    OracleCommand cmdGetDeadBlank = connect.CreateCommand();
                    cmdGetDeadBlank.CommandText = "select count(id) from dpt_blank where id=:id and status=1 and doc_scheme_id=:template";
                    cmdGetDeadBlank.Parameters.Add("id", OracleDbType.Varchar2, did, ParameterDirection.Input);
                    cmdGetDeadBlank.Parameters.Add("template", OracleDbType.Varchar2, template, ParameterDirection.Input);
                    Decimal res = Convert.ToDecimal(Convert.ToString(cmdGetDeadBlank.ExecuteScalar()));

                    if (res <= 0)
                    {
                        connect.Close();
                        string message = "Введенный номер не может быть номером испорченного бланка.\nБланк с указанным номером еще не использовался ,уже был помечен как испорченный,\nили использовался для печати другого договора.";
                        message = Resources.Deposit.GlobalResources.al04;
                        Response.Write("<script>alert('" + message + "');</script>");
                        //Response.Flush();
                        return;
                    }

                    cmdGetDeadBlank.Dispose();
                }

                OracleCommand cmdInsertNewEntry = connect.CreateCommand();
                cmdInsertNewEntry.CommandText = "insert into dpt_blank(id,print_date,deposit_id,doc_scheme_id,id_faulty,status,staff_id) " +
                    "values(:id,bankdate,:dpt_id,:doc_scheme_id,:did,1,user_id)";
                cmdInsertNewEntry.Parameters.Add("id", OracleDbType.Varchar2, id, ParameterDirection.Input);
                cmdInsertNewEntry.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                cmdInsertNewEntry.Parameters.Add("doc_scheme_id", OracleDbType.Varchar2, template, ParameterDirection.Input);
                cmdInsertNewEntry.Parameters.Add("did", OracleDbType.Varchar2, did, ParameterDirection.Input);

                try
                {
                    cmdInsertNewEntry.ExecuteNonQuery();
                }
                catch (OracleException ex)
                {
                    if (ex.Number == 1)
                    {
                        String message = "Бланк с номером " + id.ToString() + " уже был использован!";
                        message = Resources.Deposit.GlobalResources.al05;
                        message += " " + id.ToString() + " " + Resources.Deposit.GlobalResources.al06;
                        Response.Write("<script language='javascript' src='js/js.js'></script><script>alert('" +
                            message + "');</script>");
                        //Response.Flush();
                        connect.Close();
                        return;
                    }
                    else
                        throw ex;
                }

                cmdInsertNewEntry.Dispose();

                if (deadBlankNum.Enabled)
                {
                    OracleCommand cmdUpdateDead = connect.CreateCommand();
                    cmdUpdateDead.CommandText = "update dpt_blank set status =2 where id=:id";
                    cmdUpdateDead.Parameters.Add("id", OracleDbType.Varchar2, did, ParameterDirection.Input);

                    cmdUpdateDead.ExecuteNonQuery();
                    cmdUpdateDead.Dispose();
                }
            }

            Deposit dpt = new Deposit(dpt_id);
            String str_header = String.Empty;
            String str_footer = String.Empty;

            String header = dpt.CreateContractHeader(connect);
            if (header != String.Empty)
            {
                FileStream file = new FileStream(header, FileMode.Open);
                StreamReader streamRead = new StreamReader(file);
                str_header = streamRead.ReadToEnd();
                streamRead.Close();
                file.Close();
            }

            String footer = dpt.CreateContractFooter(connect);
            if (footer != String.Empty)
            {
                FileStream file = new FileStream(footer, FileMode.Open);
                StreamReader streamRead = new StreamReader(file);
                str_footer = streamRead.ReadToEnd();
                streamRead.Close();
                file.Close();

            }

            /// Друк у файл MS Word
            /// printFile();
            /// або
            /// Друк на принтер
            String nFooter = String.Empty; // dpt.CreateContractFooterText(connect);
            if (!String.IsNullOrEmpty(nFooter))
            {
                String script = "<script language='javascript' src='js/js.js'></script><script>printcmd_withfooter('"
                    + nFooter.Replace("'", "`") + "');</script>";
                ClientScript.RegisterClientScriptBlock(Page.GetType(), Page.ClientID, script);
            }
            else
            /// Друк колонтитулів не працює !!!
            /// Не передаються тексти в javascript
            {
                hidFooter.Value = str_footer;
                hidHeader.Value = str_header;

                String script = "<script language='javascript' src='js/js.js'></script><script>printcmd();</script>";
                ClientScript.RegisterClientScriptBlock(Page.GetType(), Page.ClientID, script);
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
            Page_Load(sender, e);
        }
    }
    private void printFile()
    {
        OracleConnection connect = new OracleConnection();
        Deposit dpt = new Deposit();

        try
        {
            if (Session["DPTPRINT_DPTID"] == null)
            {
                Response.Write("<script>alert('Відсутні параметри виклику!');</script>");
                return;
            }

            dpt.ID = Convert.ToDecimal(Convert.ToString(Session["DPTPRINT_DPTID"]));

            IOraConnection conn = (IOraConnection)Context.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД
            

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmd.ExecuteNonQuery();

            cmd.CommandText = "SELECT VAL FROM PARAMS WHERE PAR='C_FORMAT'";
            string result = Convert.ToString(cmd.ExecuteScalar());

            if (result == null)
                throw new DepositException("Параметр ознаки формату шаблонів в базі не знайдено!");

            result = result.ToUpper();

            if (result != "HTML" && result != "RTF")
                throw new DepositException("Формат шаблонів договорів: " + result
                    + " програмою не підтримується!");

            string filename = string.Empty;
            if (Session["DPTPRINT_AGRID"] != null)
            {
                DBLogger.Info("Пользователь распечатал доп.соглашение тип=" + Convert.ToString(Session["DPTPRINT_AGRID"])
                    + "( номер =" + Convert.ToString(Session["DPTPRINT_AGRNUM"])
                    + ") для депозитного договора №" + Convert.ToString(Session["DPTPRINT_DPTID"]),
                    "deposit");

                filename = dpt.CreateAddAgreementTextFile(Context);
            }
            else
            {
                DBLogger.Info("Пользователь розпечатал депозитный договор.  Номер договора " + Convert.ToString(Session["DPTPRINT_DPTID"]),
                    "deposit");
                filename = dpt.CreateContractTextFile(Context);
            }
            //				Response.ClearContent();
            //				Response.ClearHeaders();

            if (result == "RTF")
            {
                Response.ContentType = "application/octet-stream";
                Response.AddHeader("Content-Disposition", "attachment;filename=contract.rtf");
                Response.WriteFile(filename);
            }
            else
            {
                Response.ContentType = "application/octet-stream";
                Response.AddHeader("Content-Disposition", "attachment;filename=contract.doc");
                Response.WriteFile(filename);
            }

            Response.Flush();
        }
        finally
        {
            dpt.ClearContractTextFile(Context);

            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
}

