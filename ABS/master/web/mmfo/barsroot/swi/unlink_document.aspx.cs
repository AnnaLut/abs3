using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class swi_unlink_document : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string refer = tbRef.Text;
    }
    private void Window_open(String URL)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "open", "window.showModalDialog('" + URL + "',null,'dialogWidth:700px;');", true);
    }
    protected void btSearh_Click(object sender, EventArgs e)
    {
        try
        {
            int cnt = 0;
            InitOraConnection();

            ClearParameters();
            SetParameters("Ref", DB_TYPE.Int64, Convert.ToInt64(tbRef.Text), DIRECTION.Input);
            SQL_Reader_Exec(@"select count(*) cnt from sw_oper where ref=:Ref");
            if (SQL_Reader_Read())
            {
                ArrayList reader = SQL_Reader_GetValues();
                cnt = Convert.ToInt32(reader[0]);
            }
            if (cnt == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Увага", "alert('Документ не знайдено!');", true);
            }
            else
            {
                Window_open("/barsroot/documentview/default.aspx?ref="+ tbRef.Text);
            }
            SQL_Reader_Close();

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void btUnlink_Click(object sender, EventArgs e)
    {
        try
        {
            int cnt = 0;
            InitOraConnection();

            ClearParameters();
            SetParameters("Ref", DB_TYPE.Int64, Convert.ToInt64(tbRef.Text), DIRECTION.Input);
            SQL_Reader_Exec(@"select count(*) cnt from sw_oper where ref=:Ref");
            if (SQL_Reader_Read())
            {
                ArrayList reader = SQL_Reader_GetValues();
                cnt = Convert.ToInt32(reader[0]);
            }
            if (cnt == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Увага", "alert('Документ не прикріплений до жодного повідомлення!');", true);
            }
            else
            {
                ClearParameters();
                SetParameters("dfRef", DB_TYPE.Int64, Convert.ToInt64(tbRef.Text), DIRECTION.Input);
                SQL_NONQUERY("begin bars_swift.document_unlink(:dfRef); end;");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Увага", "alert('Виконано!');", true);
                tbRef.Text = String.Empty;
            }
            SQL_Reader_Close();

        }
        finally
        {

            DisposeOraConnection();
        }
    }
}