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
using Bars.Web.Report;
using Bars.Logger;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using System.IO;
using System.Text;
using Microsoft.Win32;
using System.Security.Permissions;
using Bars.Exception;

public partial class DepositPrintContract : Bars.BarsPage
{
    private void Page_Load(object sender, System.EventArgs e)
    {
        OracleConnection connect = new OracleConnection();
        SocialDeposit dpt = new SocialDeposit();

        try
        {
            dpt.ID = Convert.ToDecimal(Convert.ToString(Request["dpt_id"]));

            if (dpt.ID <= 0)
                return;

            dpt.ReadFromDatabase(Context);

            // Создаем соединение
            IOraConnection conn = (IOraConnection)Context.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД
            

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmd.ExecuteNonQuery();

            cmd.CommandText = "SELECT VAL FROM PARAMS WHERE PAR='C_FORMAT'";
            string result = Convert.ToString(cmd.ExecuteScalar());

            if (result == null)
                throw new ApplicationException("Параметр признака формата шаблонов договоров в базе не найден!");

            result = result.ToUpper();

            if (result != "HTML" && result != "RTF")
                throw new ApplicationException("Прописаный формат шаблона договора не поддерживается!");

            string filename = string.Empty;
            if (Request["agr_id"] != null)
            {
                DBLogger.Info("Пользователь распечатал доп.соглашение тип=" + Convert.ToString(Request["agr_id"])
                    + "( номер =" + Convert.ToString(Request["agr_num"])
                    + ") для депозитного договора №" + Convert.ToString(Request["dpt_id"]),
                    "SocialDeposit");

                filename = dpt.CreateAddAgreementTextFile(Context);
            }
            else
            {
                DBLogger.Info("Пользователь розпечатал депозитный договор.  Номер договора " + Convert.ToString(Request["dpt_id"]),
                    "SocialDeposit");
                filename = dpt.CreateContractTextFile(Context);
            }

            Response.ClearContent();
            Response.ClearHeaders();

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

    #region Web Form Designer generated code
    override protected void OnInit(EventArgs e)
    {
        //
        // CODEGEN: This call is required by the ASP.NET Web Form Designer.
        //
        InitializeComponent();
        base.OnInit(e);
    }

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
        this.Load += new System.EventHandler(this.Page_Load);

    }
    #endregion
}

