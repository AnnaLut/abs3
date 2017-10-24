using System;
using Bars.Classes;
using System.Collections;
using System.Web.UI.WebControls;
using System.Globalization;
using Bars.UserControls;
using System.Web.UI;

public partial class cbirep_export_dbf_var : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            InitOraConnection();
            ClearParameters();
            SetParameters("kodz", DB_TYPE.Int64, Convert.ToInt64(Request["KODZ"]), DIRECTION.Input);
            SQL_NONQUERY(@"begin p_zapros_parse_variable(:kodz); end;");

            dsMainZapros.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
            String SelectCommand = @"select tag, name, value from tmp_zapros_variable
                                        where userid=user_id and kodz="+ Request["KODZ"];

            dsMainZapros.SelectCommand = SelectCommand;

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void btOk_Click(object sender, EventArgs e)
    {
        try
        {
            InitOraConnection();

            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";
            int pos = 0;
            string stmt = String.Empty;

            foreach(GridViewRow row in gvMainZapros.Rows)
            {
                string TAG = Convert.ToString( gvMainZapros.DataKeys[pos].Values[0]);
                TextBoxString tbVal = ((TextBoxString)row.Cells[2].Controls[1]);
                stmt = stmt + TAG + "=" + tbVal.Value + ";";
                pos++;
            }

            string encoding = String.Empty;

            if (rbWIN.Checked)
            {
                encoding = "WIN";
            }
            if (rbDOS.Checked)
            {
                encoding = "DOS";
            }
            if (rbUKG.Checked)
            {
                encoding = "UKG";
            }

            ClearParameters();
            SetParameters("kodz", DB_TYPE.Int64, Convert.ToInt64(Request["KODZ"]), DIRECTION.Input);
            SetParameters("stmt", DB_TYPE.Varchar2, stmt, DIRECTION.Input);
            SetParameters("encode", DB_TYPE.Varchar2, encoding, DIRECTION.Input);
            SQL_NONQUERY("begin p_export_to_dbf_web(:kodz, :stmt,:encode); end;");
        }
        finally
        {
            DisposeOraConnection();
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close", "window.close();", true);
    }
}