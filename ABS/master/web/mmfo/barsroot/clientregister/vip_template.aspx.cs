using System;
using System.Data;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class clientregister_vip_template : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            InitOraConnection();
            try
            {
                SQL_Reader_Exec("select template from VIP_TEMPLATE");
                if (SQL_Reader_Read())
                {
                    ArrayList reader = SQL_Reader_GetValues();
                    tbTemplate.Text = Convert.ToString(reader[0]);
                }
                SQL_Reader_Close();

            }
            finally
            {
                DisposeOraConnection();
            }
        }
    }

    protected void btSave_Click(object sender, EventArgs e)
    {
        
            InitOraConnection();
            try
            {
                ClearParameters();
                SetParameters("txt", DB_TYPE.Clob, tbTemplate.Text, DIRECTION.Input);
                SetParameters("txt2", DB_TYPE.Clob, tbTemplate.Text, DIRECTION.Input);
                SQL_NONQUERY(@"begin
                            update VIP_TEMPLATE
                                set template=:txt;
                            if sql%rowcount=0 then
                                insert into vip_template(template) values(:txt2);
                            end if;
                            end;");
            }
            finally
            {
                DisposeOraConnection();
            }
        
    }
}