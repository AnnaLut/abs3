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
using System.Drawing.Printing;

/// <summary>
/// Summary description for DepositPrintContract.
/// </summary>

public partial class DepositPrintContract : Bars.BarsPage
{
    private void Page_Load(object sender, System.EventArgs e)
    {
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositPrintContract;
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

            //dpt.ReadFromDatabase();

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
                throw new DepositException("Формат шаблонів договорів: " + result + " програмою не підтримується!");

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
                String script = String.Empty;

                FileStream file = new FileStream(filename, FileMode.Open);
                StreamReader streamRead = new StreamReader(file);
                String str_mht = streamRead.ReadToEnd();
                streamRead.Close();file.Close();

                if (str_mht.IndexOf("</body>") <= 0)
                {
                    // якщо ж всетаки отримали "RTF" замість "HTML"
                    Response.ContentType = "application/octet-stream";
                    Response.AddHeader("Content-Disposition", "attachment;filename=contract.rtf");
                    Response.WriteFile(filename);
                    return;
                }

                /// Якщо є що писати
                if (str_mht.Length > 4)
                {
                    if (str_mht.Substring(0, 4) == "MIME")
                    {
                        script = "<script language=3D'JavaScript'> " +
                            "var str_object_barsie=3D'<OBJECT id=3D\"BarsPrint\" classid=3D\"CLSID:0E21DB0E-5A6E-435B-885B-04D3D92AA3BE\" BORDER=3D0 VSPACE=3D0 HSPACE=3D0 ALIGN=3DTOP HEIGHT=3D0% WIDTH=3D0%></OBJECT>'; " +
                            "var elem =3Dparent.frames['contents'].document.createElement(str_object_barsie); " +
                            "parent.frames['contents'].document.body.insertAdjacentElement('beforeEnd',elem); " +
                            "document.ondragstart =3D sec_mess; " +
                            "document.onselectstart =3D sec_mess; " +
                            "document.oncontextmenu =3D sec_mess; " +
                            "function sec_mess() { return false; } " +
                        "</script>";
                        Response.ContentType = "message/rfc822";
                        Response.AddHeader("Content-Disposition", "inline;filename=contract.mht");
                    }
                    else
                    {
                        script = "<script language='JavaScript'> " +
                            "var str_object_barsie='<OBJECT id=\"BarsPrint\" classid=\"CLSID:0E21DB0E-5A6E-435B-885B-04D3D92AA3BE\" BORDER=0 VSPACE=0 HSPACE=0 ALIGN=TOP HEIGHT=0% WIDTH=0%></OBJECT>'; " +
                            "var elem =parent.frames['contents'].document.createElement(str_object_barsie); " +
                            "parent.frames['contents'].document.body.insertAdjacentElement('beforeEnd',elem); " +
                            "document.ondragstart = sec_mess; " +
                            "document.onselectstart = sec_mess; " +
                            "document.oncontextmenu = sec_mess; " +
                            "function sec_mess() { return false; } " +
                        "</script>";
                        Response.ContentType = "text/html";
                        Response.AddHeader("Content-Disposition", "inline;filename=contract.html");
                    }

                    file = new FileStream(filename, FileMode.Create, FileAccess.Write);
                    StreamWriter streamWriter = new StreamWriter(file);
                    String new_str_mht = str_mht.Insert(str_mht.IndexOf("</body>"), script);

                    streamWriter.Write(new_str_mht);
                    streamWriter.Flush();
                    streamWriter.Close();
                    file.Close();

                    Response.WriteFile(filename);
                }
                else
                    throw new DepositException("Текст відсутній!");

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
        ;

    }
    #endregion
}
