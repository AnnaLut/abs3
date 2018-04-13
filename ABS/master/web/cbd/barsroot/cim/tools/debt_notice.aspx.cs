using Bars.Classes;
using barsroot.cim;
using Ionic.Zip;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Types;

public class DebtClass
{
    public int? ri { get; set; }
    public string op { get; set; }
    public string rn { get; set; }
    public string nk { get; set; }
    public string ak { get; set; }
    public string nd { get; set; }
    public string dd { get; set; }
    public string dp { get; set; }
    public bool ins { get; set; }
}

public class CustClass
{
    public decimal? Rnk { get; set; }
    public string Okpo { get; set; }
    public string Name { get; set; }
    public string Adr { get; set; }
}

public partial class cim_tools_debt_notice : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(this.Title, true);
        if (!IsPostBack)
        {
            OracleConnection oraConn = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand oraCmd = oraConn.CreateCommand();
                oraCmd.CommandText = "select name, adr, f_ourmfo from cim_journal_num where branch = nvl(sys_context('bars_context', 'user_branch'), f_ourmfo)";
                OracleDataReader oraRdr = oraCmd.ExecuteReader();
                if (oraRdr.Read())
                {
                    lbBranchName.Text = Convert.ToString(oraRdr.GetValue(0));
                    lbBranchAdr.Text = Convert.ToString(oraRdr.GetValue(1));
                    Session["cim.bank_mfo"] = Convert.ToString(oraRdr.GetValue(2));
                }
                else
                {
                    lbError.Text = "Відсутня інформація про тазву та адресу банківської установи. Заповніть відповідні дані у таблиці CIM_JOURNAL_NUM!";
                    btGenFile.Enabled = false;
                    btAddDebt.Disabled = true;
                }
            }
            finally
            {
                oraConn.Close();
                oraConn.Dispose();
            }
        }
        bool isNadra = (Convert.ToString(Session["cim.bank_mfo"]) == "380764");
        cbSubBranch.Visible = !isNadra;

        ScriptManager.GetCurrent(this).RegisterPostBackControl(btGenFile);
        dsDebtNotice.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        string cb1 = (cbSend.Checked) ? ("1") : ("0");
        string cb2 = (cbSubBranch.Checked) ? ("1") : ("0");
        dsDebtNotice.SelectCommand = @"select * from v_cim_borg_message where delete_date is null and (" + cb1 + @"=1 or file_name is null) and
                                    branch like nvl(sys_context('bars_context', 'user_branch_mask'), '%') " +
                                    (isNadra ? (" ") : ("and (" + cb2 + @"=1 or branch = nvl(sys_context('bars_context', 'user_branch'), f_ourmfo) ) ")) +
                                    " order by nvl(approve,0) desc, file_name desc, id desc";

        ScriptManager.GetCurrent(this).Scripts.Add(new ScriptReference("/barsroot/cim/tools/script/debt_notice.js?v1.6"));
    }
    protected void gvDebtNotice_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string parMaskStr = "\"{0}\":'{1}',";
            string parMaskInt = "\"{0}\":{1},";
            string rowdata = "{";
            rowdata += string.Format(parMaskInt, "ri", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ID")));
            rowdata += string.Format(parMaskStr, "nb", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "NAME_BANK")).Replace("'", "\\'"));
            rowdata += string.Format(parMaskStr, "ab", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ADR_BANK")).Replace("'", "\\'"));
            rowdata += string.Format(parMaskStr, "op", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "OKPO")));
            rowdata += string.Format(parMaskInt, "rn", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "RNK")));
            rowdata += string.Format(parMaskStr, "nk", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "NAME_KL")).Replace("'", "\\'"));
            rowdata += string.Format(parMaskStr, "ak", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ADR_KL")).Replace("'", "\\'"));
            rowdata += string.Format(parMaskStr, "nd", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "NOM_DOG")));
            rowdata += string.Format(parMaskStr, "fn", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "FILE_NAME")));
            string dat = (DataBinder.Eval(e.Row.DataItem, "DATE_DOG") == DBNull.Value) ? ("") : (Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "DATE_DOG")).ToString("dd/MM/yyyy"));
            rowdata += string.Format(parMaskStr, "dd", dat);
            dat = (DataBinder.Eval(e.Row.DataItem, "DATE_PLAT") == DBNull.Value) ? ("") : (Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "DATE_PLAT")).ToString("dd/MM/yyyy"));
            rowdata += string.Format(parMaskStr, "dp", dat);
            rowdata = rowdata.Substring(0, rowdata.Length - 1);
            rowdata += "}";
            e.Row.Attributes.Add("rd", rowdata);

            if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "FILE_NAME")) != "")
                e.Row.Cells[0].Controls[1].Visible = false;
        }
    }

    [WebMethod(EnableSession = true)]
    public static void SaveDebt(DebtClass debt)
    {
        OracleConnection oraConn = OraConnector.Handler.UserConnection;
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            OracleCommand oraCmd = oraConn.CreateCommand();
            oraCmd.Parameters.Add("rnk", OracleDbType.Decimal, debt.rn, ParameterDirection.Input);
            oraCmd.Parameters.Add("nom_dog", OracleDbType.Varchar2, debt.nd, ParameterDirection.Input);
            DateTime? dt = DateTime.Now;
            if (!string.IsNullOrEmpty(debt.dd))
                dt = DateTime.Parse(debt.dd, cinfo);
            oraCmd.Parameters.Add("date_dog", OracleDbType.Date, dt, ParameterDirection.Input);
            if (!string.IsNullOrEmpty(debt.dp))
                dt = DateTime.Parse(debt.dp, cinfo);
            oraCmd.Parameters.Add("date_plat", OracleDbType.Date, dt, ParameterDirection.Input);
            if (debt.ins)
            {
                oraCmd.CommandText = "insert into cim_borg_message(rnk,nom_dog,date_dog,date_plat) values(:rnk, :nom_dog, :date_dog, :date_plat)";
            }
            else
            {
                oraCmd.CommandText = "update cim_borg_message set rnk=:rnk, nom_dog=:nom_dog, date_dog=:date_dog, date_plat=:date_plat where id=:id";
                oraCmd.Parameters.Add("id", OracleDbType.Decimal, debt.ri, ParameterDirection.Input);
            }
            oraCmd.ExecuteNonQuery();
        }
        finally
        {
            oraConn.Close();
            oraConn.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    public static void DeleteDebt(decimal id, string filename)
    {
        OracleConnection oraConn = OraConnector.Handler.UserConnection;
        try
        {
            OracleCommand oraCmd = oraConn.CreateCommand();
            if (string.IsNullOrEmpty(filename))
            {


                oraCmd.Parameters.Add("id", OracleDbType.Decimal, id, ParameterDirection.Input);
                oraCmd.CommandText = "update cim_borg_message set delete_date=sysdate, delete_uid=user_id where id=:id and approve=0";
                oraCmd.ExecuteNonQuery();

                oraCmd.CommandText = "update cim_borg_message set approve=0 where id=:id and approve=1";
                oraCmd.ExecuteNonQuery();
            }
            else
            {
                oraCmd.Parameters.Add("file_name", OracleDbType.Varchar2, filename, ParameterDirection.Input);
                oraCmd.CommandText = "update cim_borg_message set file_name=null where file_name=:file_name";
                oraCmd.ExecuteNonQuery();
            }
        }
        finally
        {
            oraConn.Close();
            oraConn.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    public static CustClass GetClientInfo(decimal? rnk, string okpo)
    {
        CustClass cust = new CustClass();
        OracleConnection oraConn = OraConnector.Handler.UserConnection;
        try
        {
            OracleCommand oraCmd = oraConn.CreateCommand();
            oraCmd.CommandText = "select c.rnk, c.okpo, c.nmk, ca.locality || ' ' || ca.address from customer c, customer_address ca where c.rnk=ca.rnk(+) and ca.type_id(+) = 1 and ";
            if (rnk.HasValue)
            {
                oraCmd.Parameters.Add("rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
                oraCmd.CommandText += " c.rnk=:rnk";
            }
            else
            {
                oraCmd.Parameters.Add("okpo", OracleDbType.Varchar2, okpo, ParameterDirection.Input);
                oraCmd.CommandText += " c.okpo like :okpo||'%'";
            }
            OracleDataReader oraRdr = oraCmd.ExecuteReader();
            if (oraRdr.Read())
            {
                cust.Rnk = Convert.ToDecimal(oraRdr.GetValue(0));
                cust.Okpo = Convert.ToString(oraRdr.GetValue(1));
                cust.Name = Convert.ToString(oraRdr.GetValue(2));
                cust.Adr = Convert.ToString(oraRdr.GetValue(3));
                if (oraRdr.Read())
                    cust.Rnk = -1;
            }
            else
                cust.Rnk = null;
            oraRdr.Close();
        }
        finally
        {
            oraConn.Close();
            oraConn.Dispose();
        }

        return cust;
    }
    protected void btGenFile_Click(object sender, EventArgs e)
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleClob cText = null;
        try
        {
            bool isNadra = (Convert.ToString(Session["cim.bank_mfo"]) == "380764");
            string funcName = "f_cim_borg_message";
            string template = "borg_message.frx";
            if (isNadra)
            {
                funcName = "bars.f_cim_borg_message2";
                template = "borg_message2.frx";
            }
            string templatePath = Path.Combine(System.Web.HttpContext.Current.Server.MapPath("templates"), template);

            FrxParameters pars = new FrxParameters();
            FrxDoc doc = new FrxDoc(templatePath, pars, null);
            string tmpFileName = doc.Export(FrxExportTypes.Rtf);

            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = (@"declare
                                     p_txt  clob  := null; 
                                 begin
                                    :p_txt :=" + funcName + @"(:p_file_name);
                                 end;");

            cmd.Parameters.Add("p_txt", OracleDbType.Clob, "", ParameterDirection.InputOutput);
            cmd.Parameters.Add("p_file_name", OracleDbType.Varchar2, "".PadRight(4000), ParameterDirection.InputOutput);
            cmd.ExecuteNonQuery();

            string file_name = Convert.ToString(cmd.Parameters["p_file_name"].Value);

            //string fileData = Convert.ToString(cmd.Parameters["p_txt"].Value);
            cText = (OracleClob)cmd.Parameters["p_txt"].Value;
            string fileData = cText.Value;

            if (!string.IsNullOrEmpty(fileData))
            {
                string docFileName = Path.Combine(Path.GetDirectoryName(tmpFileName), file_name + ".doc");
                File.Move(tmpFileName, docFileName);
                string xmlFileName = Path.Combine(Path.GetTempPath(), file_name + ".xml");
                using (StreamWriter sw = new StreamWriter(xmlFileName, false, System.Text.Encoding.GetEncoding(1251)))
                {
                    sw.Write(fileData);
                    sw.Close();
                }
                string zipFile = string.Format("{0}\\{1}.zip", Path.GetTempPath(), file_name);
                using (ZipFile zip = new ZipFile(zipFile, System.Text.Encoding.GetEncoding(1251)))
                {
                    zip.CompressionLevel = Ionic.Zlib.CompressionLevel.Level9;
                    zip.TempFileFolder = Path.GetTempPath();
                    if (File.Exists(docFileName))
                        zip.AddFile(docFileName, "\\");
                    if (File.Exists(xmlFileName))
                        zip.AddFile(xmlFileName, "\\");
                    zip.Save();
                }
                try
                {
                    Response.ClearContent();
                    Response.ClearHeaders();
                    Response.Charset = "windows-1251";
                    Response.AppendHeader("content-disposition", "attachment;filename=" + Path.GetFileName(zipFile));
                    Response.ContentType = "application/octet-stream";
                    Response.WriteFile(zipFile, true);
                    Response.Flush();
                    Response.End();
                }
                finally
                {
                    if (File.Exists(xmlFileName))
                        File.Delete(xmlFileName);
                    if (File.Exists(docFileName))
                        File.Delete(docFileName);
                }
            }
            else
                throw new Bars.Exception.BarsException("Помилка формування звіту.");
        }
        catch (System.Exception ex)
        {
            string exMessage = ex.Message;
            if (ex is OracleException)
            {
                OracleException oex = (OracleException)ex;
                if (oex.Number >= 20000)
                {
                    string message = oex.Message;
                    int pos = message.IndexOf(':');
                    exMessage = message.Substring(pos + 1, message.IndexOf("ORA-", pos) - pos - 1);
                }
                else
                    exMessage = ex.Message;
            }
            lbError.Text = exMessage;
        }
        finally
        {
            if (cText != null)
            {
                cText.Close();
                cText.Dispose();
            }
            con.Close();
            con.Dispose();
        }
    }
    protected void cbSend_CheckedChanged(object sender, EventArgs e)
    {
        gvDebtNotice.DataBind();
    }

    protected void btApprove_OnClick(object sender, EventArgs e)
    {
        string listId = string.Empty;
        foreach (GridViewRow row in gvDebtNotice.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox cb = (CheckBox)row.Cells[2].Controls[1];
                if (cb.Checked)
                    listId += cb.ToolTip + ",";
            }
        }
        if (!string.IsNullOrEmpty(listId))
        {
            listId = listId.Substring(0, listId.Length - 1);
            (new CimManager(false)).ApproveBorgMessage(listId);
            gvDebtNotice.DataBind();
        }

        //throw new NotImplementedException();
    }
}