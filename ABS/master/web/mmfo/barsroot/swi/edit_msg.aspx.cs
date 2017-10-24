using System;
using System.IO;
using System.Data;
using Bars.Classes;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using System.Globalization;
using Bars.UserControls;
using System.Collections;
using Bars.Oracle;
using System.Linq;

public partial class swi_edit_msg : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lbRefVal.Text = Convert.ToString(Request["swref"]);
        lbRefVal.ForeColor = System.Drawing.Color.Blue;
        try
        {
            InitOraConnection();
            SetParameters("swref", DB_TYPE.Varchar2, Convert.ToString(Request["swref"]), DIRECTION.Input);
            SQL_Reader_Exec(@"select  j.sender, b.name name_send, j.receiver , b2.name name_receiv
                             from sw_journal j, sw_banks b, sw_banks b2 where j.swref = :swref
                             and J.SENDER=B.BIC
                             and j.receiver= b2.bic");
            while (SQL_Reader_Read())
            {
                ArrayList reader = SQL_Reader_GetValues();

                lbSender.Text = Convert.ToString(reader[0]);
                lbSender.ToolTip = Convert.ToString(reader[1]);
                lbReciv.Text = Convert.ToString(reader[2]);
                lbReciv.ToolTip = Convert.ToString(reader[3]);
                


            }
            lbSender.ForeColor = System.Drawing.Color.Blue;

            lbReciv.ForeColor = System.Drawing.Color.Blue;
  

            SQL_Reader_Close();

            dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
            String SelectCommand = @"SELECT num, seq, subseq, tag, opt, status, 
                                        empty, seqstat, value, optmodel, editval, swref
                                 FROM tmp_sw_message where userid=user_id() and swref=" + Request["SWREF"] + " order by num";

            dsMain.SelectCommand = SelectCommand;
        }
        finally
        {
            DisposeOraConnection();
        }
        
    }

    protected void btSave_Click(object sender, EventArgs e)
    {
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            InitOraConnection();
            int pos = 0;


            foreach (GridViewRow row in gvMain.Rows)
            {
                Int64 num = Convert.ToInt64(gvMain.DataKeys[pos].Values[0]);
                Int64 swref = Convert.ToInt64(gvMain.DataKeys[pos].Values[1]);
                TextBoxString tbValue = ((TextBoxString)row.Cells[5].Controls[1]);
                TextBoxRefer refOPT = ((TextBoxRefer)row.Cells[4].Controls[1]);







                ClearParameters();
                SetParameters("p_value", DB_TYPE.Varchar2, tbValue.Value, DIRECTION.Input);
                SetParameters("p_opt", DB_TYPE.Varchar2, refOPT.Value, DIRECTION.Input);
                SetParameters("swref", DB_TYPE.Int64, swref, DIRECTION.Input);
                SetParameters("num", DB_TYPE.Int64, num, DIRECTION.Input);
                




                SQL_NONQUERY(@"begin  
                                update tmp_sw_message t
                                set t.value =:p_value, t.opt = :p_opt
                                where t.swref=:swref and t.num=:num and userid=user_id;
                                                  end;");

                pos++;
            }
            try
            {
                InitOraConnection();
                ClearParameters();
                SetParameters("swref", DB_TYPE.Int64, Convert.ToInt64(Request["swref"]), DIRECTION.Input);
                SetParameters("mt", DB_TYPE.Int64, Convert.ToInt64(Request["mt"]), DIRECTION.Input);
                SQL_NONQUERY("begin bars_swift.update_message(:swref, :mt); end;");
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        finally
        {
            DisposeOraConnection();
        }
        ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Дані збережено!');", true);
    }

    protected void btClose_Click(object sender, EventArgs e)
    {
        try
        {
            InitOraConnection();
            ClearParameters();
            SetParameters("swref", DB_TYPE.Int64, Convert.ToInt64(Request["swref"]), DIRECTION.Input);
            SQL_NONQUERY("begin delete from tmp_sw_message where userid=user_id() and swref=:swref; end;");
        }
        finally
        {
            DisposeOraConnection();
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close", "window.close();", true);
    }

    protected void tbValue_DataBinding(object sender, EventArgs e)
    {
        TextBoxString s = sender as TextBoxString;
        if (s.ID == "tbValue" && s.Value != null)
        {
            int enterCount = s.Value.Count(symb => symb == '\n');
            if(enterCount > 0)
            {
                s.Rows += enterCount+1;
            }
        }
    }
}