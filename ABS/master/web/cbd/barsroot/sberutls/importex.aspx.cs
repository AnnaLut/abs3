using System;
using System.Collections.Generic;
using System.Web;
using System.IO;
using System.Xml;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Runtime.InteropServices;
using System.Collections;
using System.Text.RegularExpressions;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using Bars.Configuration;
using Bars.DataComponents;
using Bars.Oracle;
using Bars.Classes;
using bars.sberimport;


public partial class sberutls_importex : Bars.BarsPage
{
    xml_base xmlimp = null;

    private xml_base createLoaderInstance()
    {
        if (null == xmlimp)
        {
            switch (getCurrType())
            {
                case 1:
                case 2:
                case 3:
                case 4:
                case 5:
                case -1:
                    xmlimp = new xml_a();
                    break;
                case 6:
                    xmlimp = new xml_r();
                    break;
                default:
                    throw new Exception("Невідомий тип імпорту");
            }
        }
        return xmlimp;
    }

    private int getCurrType()
    {
        if (Request["imptype"] == "lz")
            return 1;
        else if (Request["imptype"] == "kp")
            return 2;
        else if (Request["imptype"] == "zp")
            return 3;
        else if (Request["imptype"] == "ik")
            return 4;
        else if (Request["imptype"] == "bars")
            return -1;
        else if (Request["imptype"] == "hitz")
            return 6;
        else
            throw new Exception("Не коректнi параметри URL");
    }

    private string getCurrConfig()
    {
        string s = Request["config"];
        if (!String.IsNullOrEmpty(s))
        {
            return s;
        }
        return String.Empty;
    }

    private string getDescription(int currType)
    {
        if (currType != 6)
        {
            string[] s = xmlimp.description().Split(new char[1] { '|' }, StringSplitOptions.RemoveEmptyEntries);
            return s[currType - 1];
        }
        else
            return xmlimp.description();
    }

    private string getVersion(int currType)
    {
        return xmlimp.version();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        createLoaderInstance();

        if (getCurrType() == -1)
        {
            divCaption.InnerHtml = "Iмпорт документiв - <b>BARS</b>";
        }
        else
        {
            divCaption.InnerHtml = "Iмпорт документiв - <b>" + getDescription(getCurrType()) + "</b>";
            divDllinfo.InnerHtml = "version:" + getVersion(getCurrType()) + ", config: " + getCurrType() + ", settings: " + (getCurrConfig().Trim() == string.Empty ? "not used" : getCurrConfig());
        }
        resContainer.InnerHtml = "";
        if (!IsPostBack)
        {
        }
    }

    protected void btnLoad_Click(object sender, EventArgs e)
    {
        tbMessage.Text = "";
        lblResOk.Visible = false;
        lblResBad.Visible = false;
        //продолжить только если что-то загружено
        if (fileUpload.PostedFile.FileName == String.Empty || fileUpload.PostedFile.ContentLength == 0)
        {
            return;
        }
        byte[] data = new byte[fileUpload.PostedFile.ContentLength];
        fileUpload.PostedFile.InputStream.Read(data, 0, fileUpload.PostedFile.ContentLength);
        fileUpload.PostedFile.InputStream.Close();

        String buffer = String.Empty;

        if (getCurrType() != -1)
        {
            String res = String.Empty;

            String InputBuffer = Encoding.GetEncoding(1251).GetString(data);

            String configFile = getCurrType() < 6 ?
                String.Format("{0}\\file_a{1}.config", Server.MapPath("~/ExternalBin"), getCurrType()) :
                String.Format("{0}\\{1}", Server.MapPath("~/ExternalBin"), xmlimp.libsConfig());

            int r = xmlimp.ConvertBufferEx(
                configFile,
                getCurrConfig(),
                fileUpload.FileName,
                InputBuffer, out buffer, out res);

            if (r == -1)
            {
                tbMessage.Text = res.ToString();
                return;
            }
        }

        try
        {
            try
            {
                InitOraConnection();
                try
                {
                    decimal cnt = 0;
                    decimal sum = 0;
                    SetRole("OPER000");
                    ClearParameters();
                    if (getCurrType() != -1)
                    {
                        SetParameters("p_indoc", DB_TYPE.Clob, buffer, DIRECTION.Input);
                    }
                    else
                    {
                        SetParameters("p_indoc", DB_TYPE.Clob, Encoding.GetEncoding(1251).GetString(data), DIRECTION.Input);
                    }

                    SetParameters("p_packname", DB_TYPE.Clob, null, DIRECTION.Output);

                    SQL_NONQUERY(@"
                        begin 
                            bars_xmlklb_imp.make_import(:p_indoc, :p_packname); 
                        end;");
                    object packname = GetParameter("p_packname");

                    lastFileName.Value = packname != null ? ((OracleClob)packname).Value : String.Empty;

                    ClearParameters();
                    SetParameters("p_filename", DB_TYPE.Varchar2, packname != null ? ((OracleClob)packname).Value : null, DIRECTION.Input);
                    SetParameters("p_filecnt", DB_TYPE.Decimal, cnt, DIRECTION.Output);
                    SetParameters("p_filesum", DB_TYPE.Decimal, sum, DIRECTION.Output);
                    SQL_NONQUERY(@"
                    begin 
                        bars_xmlklb_imp.import_results(
                          p_filename => :p_filename,  
                          p_dat      => bankdate, 
                          p_filecnt  => :p_filecnt,  
                          p_filesum  => :p_filesum); 
                    end;");
                    lblCnt.Value = null != GetParameter("p_filecnt") ? ((OracleDecimal)GetParameter("p_filecnt")).ToString() : "0";
                    lblSum.Value = null != GetParameter("p_filesum") ? ((OracleDecimal)GetParameter("p_filesum") / 100).ToString() : "0";
                    lblResOk.Visible = true;
                    tbMessage.Text = "Без помилок";
                }
                finally
                {
                    DisposeOraConnection();
                }
            }
            catch (OracleException E)
            {
                lblResBad.Visible = true;
                tbMessage.Text += E.Message;
            }
        }
        finally
        {
            if (getCurrType() != -1)
            {
                //ReleaseBuffer(getCurrType(), out buffer, bufferSize.ToInt32());
                //tbMessage.Text += Environment.NewLine;
                //tbMessage.Text += getLoadDllLastError(getCurrType()) +
                //    Environment.NewLine + Environment.NewLine;
            }
        }
    }
    protected void btnGetLog_Click(object sender, EventArgs e)
    {
        HttpResponse response = HttpContext.Current.Response;
        string attachment = "attachment; filename=import.txt";
        response.ClearContent();
        response.BufferOutput = true;
        response.AddHeader("content-disposition", attachment);
        response.ContentType = "text/plain";
        response.Charset = "utf-8";
        response.ContentEncoding = Encoding.GetEncoding(1251);
        response.Write(tbMessage.Text);
        response.Flush();
        response.End();
    }
    protected void btnPay_Click(object sender, EventArgs e)
    {
        if (!lblResOk.Visible) return;
        InitOraConnection();
        try
        {
            decimal okcnt = 0;
            decimal oksum = 0;
            decimal badcnt = 0;
            decimal badsum = 0;
            ClearParameters();
            SetParameters("p_filename", DB_TYPE.Varchar2, lastFileName.Value, DIRECTION.Input);
            SetParameters("p_okcnt", DB_TYPE.Decimal, okcnt, DIRECTION.Output);
            SetParameters("p_oksum", DB_TYPE.Decimal, oksum, DIRECTION.Output);
            SetParameters("p_badcnt", DB_TYPE.Decimal, badcnt, DIRECTION.Output);
            SetParameters("p_badsum", DB_TYPE.Decimal, badsum, DIRECTION.Output);
            SQL_NONQUERY(@"
                begin 
                    bars_xmlklb_imp.pay_file_docs(
                      p_filename => :p_filename,  
                      p_dat      => bankdate, 
                      p_okcnt    => :p_okcnt,  
                      p_oksum    => :p_oksum, 
                      p_badcnt   => :p_badcnt,
                      p_badsum   => :p_badsum);
                end;");
            resContainer.InnerHtml = String.Format(@"
                <table id='resTable'>
                <tr><td>
                    Кiлькiсть документiв сплачених без помилок: <b>{0}</b>
                </td></tr>
                <tr><td>
                    Сума документiв сплачених без помилок: <b>{1}</b>
                </td></tr>
                <tr><td>
                    Кiлькiсть документiв сплачених з помилками: <b>{2}</b>
                </td></tr>
                <tr><td>
                    Сума документiв сплачених з помилками: <b>{3}</b>
                </td></tr>
                </table>
            ", GetParameter("p_okcnt"), ((OracleDecimal)GetParameter("p_oksum")).Value / 100,
                GetParameter("p_badcnt"), ((OracleDecimal)GetParameter("p_badsum")).Value / 100);
        }
        finally
        {
            DisposeOraConnection();
        }

    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Response.Redirect("importproc.aspx?tp=1");
    }
}
