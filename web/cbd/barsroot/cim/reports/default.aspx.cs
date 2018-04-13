using System;
using System.Collections.Generic;
using System.Data.Entity.Design;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Data;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using barsroot.cim;
using cim;
using System.Globalization;
using Bars.Classes;
using System.IO;
using Bars.Classes;
using System.Globalization;

public partial class cim_reports_default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(this.Title, true);
        ScriptManager.GetCurrent(this).RegisterPostBackControl(btFormReport);
        dsReports.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        ReportsChange();
    }
    protected void ReportsChange()
    {
        btFormReport.Visible = ddReports.SelectedIndex > 0;
        pbParamsList.Visible = ddReports.SelectedIndex > 0;
        if (ddReports.SelectedIndex > 0)
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.Parameters.Add("report_id", OracleDbType.Decimal, ddReports.SelectedValue, ParameterDirection.Input);
                cmd.CommandText = "select report_id, param_id, name, type_id, param_name, default_value, nvl(required,0) required from cim_report_params where report_id=:report_id order by param_id";
                OracleDataReader rdr = cmd.ExecuteReader();
                HtmlTable tbl = new HtmlTable();
                tbl.ID = "tblParams";
                tbl.CellPadding = 3;
                tbl.CellSpacing = 0;
                while (rdr.Read())
                {
                    HtmlTableRow row = new HtmlTableRow();
                    HtmlTableCell cellName = new HtmlTableCell();
                    row.Cells.Add(cellName);
                    Label lb = new Label();

                    cellName.Controls.Add(lb);

                    string repId = Convert.ToString(rdr["report_id"]);
                    string labelName = Convert.ToString(rdr["name"]);
                    string defaultValue = Convert.ToString(rdr["default_value"]);
                    string parType = Convert.ToString(rdr["type_id"]);
                    string parName = Convert.ToString(rdr["param_name"]);
                    byte required = Convert.ToByte(rdr["required"]);
                    string parId = Convert.ToString(rdr["param_id"]);

                    lb.Text = labelName + ":";
                    HtmlTableCell cellControl = new HtmlTableCell();
                    row.Cells.Add(cellControl);
                    TextBox tb = new TextBox();
                    tb.EnableViewState = true;
                    tb.ID = "tbPar" + repId + parId;
                    tb.ToolTip = parName;
                    row.ID = "r_tb_" + repId + parId;

                    
                    // parName
                    if (parType == "Varchar2")
                    {
                        tb.Width = Unit.Pixel(250);
                        if (!string.IsNullOrEmpty(defaultValue))
                        {
                            if (defaultValue.Equals("%"))
                                tb.Text = defaultValue;
                            else
                            {
                                cmd.Parameters.Clear();
                                cmd.CommandText = "select " + defaultValue + " from dual";
                                tb.Text = Convert.ToString(cmd.ExecuteScalar());
                            }
                        }
                        cellControl.Controls.Add(tb);
                    }
                    else if (parType == "Integer")
                    {
                        if (!string.IsNullOrEmpty(defaultValue))
                        {
                            cmd.Parameters.Clear();
                            cmd.CommandText = "select " + defaultValue + " from dual";
                            tb.Text = Convert.ToString(cmd.ExecuteScalar());
                        }
                        tb.CssClass = "numeric";
                        cellControl.Controls.Add(tb);
                    }
                    else if (parType == "Date")
                    {
                        // Bars.Web.Controls.DateEdit tb = new Bars.Web.Controls.DateEdit();
                        if (!string.IsNullOrEmpty(defaultValue))
                        {
                            cmd.Parameters.Clear();
                            cmd.CommandText = "select to_char(" + defaultValue + ",'DD/MM/YYYY') from dual";
                            tb.Text = Convert.ToString(cmd.ExecuteScalar());
                        }
                        tb.CssClass = "ctrl-date";
                        cellControl.Controls.Add(tb);
                    }
                    else if (parType == "CheckBox")
                    {
                        var cb = new CheckBox
                        {
                            ID = "cbPar" + repId + Convert.ToString(rdr["param_id"]),
                            Checked = defaultValue == "1",
                            ToolTip = parName
                        };
                        row.ID = "r_cb_" + repId + parId;
                        cellControl.Controls.Add(cb);
                    }

                    if (required > 0)
                    {
                        var validate = new RequiredFieldValidator();
                        validate.ID = "rfv_" + repId + parId; ;
                        validate.ControlToValidate = tb.ID;
                        validate.ErrorMessage = "Необхідно заповнити поле";
                        validate.Display = ValidatorDisplay.Dynamic;
                        cellControl.Controls.Add(validate);
                    }

                    tbl.Rows.Add(row);
                }
                rdr.Close();
                phParams.Controls.Add(tbl);
            }
            finally
            {
                cmd.Dispose();
                con.Close();
                con.Dispose();
            }
        }
    }

    protected void btFormReport_Click(object sender, EventArgs e)
    {

        if (ddReports.SelectedIndex >= 0)
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            OracleClob cText = null;
            try
            {
                cmd.Parameters.Add("report_id", OracleDbType.Decimal, ddReports.SelectedValue, ParameterDirection.Input);
                cmd.CommandText = "select report_id, name, proc, template, file_type, file_name from cim_reports_list where report_id=:report_id";
                OracleDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    string proc = Convert.ToString(rdr["proc"]);
                    string template = Convert.ToString(rdr["template"]);
                    string file_type = Convert.ToString(rdr["file_type"]);
                    string file_name = Convert.ToString(rdr["file_name"]);

                    // 1- типп
                    if (!string.IsNullOrEmpty(proc))
                    {
                        string parList = string.Empty;

                        cmd.CommandText = (@"declare
                                    p_error varchar2(32767) := null;
                                    p_txt  clob  := null; 
                                 begin
                                    :p_txt := " + proc + @"({0} :p_error);
                                 end;");
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("p_txt", OracleDbType.Clob, "", ParameterDirection.InputOutput);

                        HtmlTable c = phParams.Controls[0] as HtmlTable;
                        for (int i = 0; i < c.Rows.Count; i++)
                        {
                            TextBox tb = phParams.FindControl("tbPar" + ddReports.SelectedValue + i) as TextBox;
                            object val = tb.Text;
                            OracleDbType type = OracleDbType.Varchar2;
                            if (tb.CssClass == "ctrl-date")
                            {
                                type = OracleDbType.Date;
                                val = CimManager.StrToDate(tb.Text);
                            }
                            cmd.Parameters.Add("p_" + i, type, val, ParameterDirection.Input);
                            parList += ":p_" + i + ",";
                        }
                        cmd.CommandText = string.Format(cmd.CommandText, parList);
                        cmd.Parameters.Add("p_error", OracleDbType.Varchar2, "".PadRight(32767), ParameterDirection.InputOutput);
                        cmd.ExecuteNonQuery();

                        string output = Convert.ToString(cmd.Parameters["p_error"].Value);

                        cText = (OracleClob)cmd.Parameters["p_txt"].Value;

                        if (!cText.IsNull)
                        {
                            string fileData = cText.Value;

                            string fileName = Path.Combine(Path.GetTempPath(), output);
                            using (StreamWriter sw = new StreamWriter(fileName, false, System.Text.Encoding.GetEncoding(1251)))
                            {
                                sw.Write(fileData);
                                sw.Close();
                            }
                            try
                            {
                                Response.ClearContent();
                                Response.ClearHeaders();
                                Response.Charset = "windows-1251";
                                Response.AppendHeader("content-disposition", "attachment;filename=" + HttpUtility.UrlEncode(Path.GetFileName(fileName)));
                                Response.ContentType = "application/octet-stream";
                                Response.WriteFile(fileName, true);
                                Response.Flush();
                                Response.End();
                            }
                            finally
                            {
                                if (File.Exists(fileName))
                                    File.Delete(fileName);
                                Directory.Delete(Path.GetDirectoryName(fileName), true);
                            }
                        }
                        else
                            throw new Bars.Exception.BarsException("Помилка формування звіту [" + ddReports.SelectedItem.Text +
                                                                   "]." + output);
                    }
                    else if (!string.IsNullOrEmpty(template))
                    {
                        FrxParameters pars = new FrxParameters();
                        string templatePath = Path.Combine(HttpContext.Current.Server.MapPath("/barsroot/cim/tools/templates"), template);
                        HtmlTable c = phParams.Controls[0] as HtmlTable;
                        for (int i = 0; i < c.Rows.Count; i++)
                        {
                            object val = null;
                            string parName = string.Empty;
                            if (c.Rows[i].ID.StartsWith("r_cb_"))
                            {
                                CheckBox cb = phParams.FindControl("cbPar" + ddReports.SelectedValue + i) as CheckBox;
                                val = (cb.Checked)?("1"):("0");
                                parName = cb.ToolTip;
                            }
                            else if (c.Rows[i].ID.StartsWith("r_tb_"))
                            {
                                TextBox tb = phParams.FindControl("tbPar" + ddReports.SelectedValue + i) as TextBox;
                                val = tb.Text;
                                parName = tb.ToolTip;
                            }
                            pars.Add(new FrxParameter(parName, TypeCode.String, val));
                        }
                        FrxDoc doc = new FrxDoc(templatePath, pars, null);
                        FrxExportTypes fType = FrxExportTypes.Excel2007;
                        if (file_type == "excel")
                            fType = FrxExportTypes.Excel2007;
                        else if (file_type == "word")
                            fType = FrxExportTypes.Rtf;
                        string tmpFileName = doc.Export(fType);
                        Response.ClearContent();
                        Response.ClearHeaders();
                        Response.Charset = "windows-1251";
                        Response.AppendHeader("content-disposition", "attachment;filename=" + file_name);
                        Response.ContentType = "application/octet-stream";
                        Response.WriteFile(tmpFileName, true);
                        Response.Flush();
                        Response.End();
                    }

                }
                rdr.Close();
            }
            finally
            {
                if (cText != null)
                {
                    cText.Close();
                    cText.Dispose();
                }
                cmd.Dispose();
                con.Close();
                con.Dispose();
            }
        }


    }
}