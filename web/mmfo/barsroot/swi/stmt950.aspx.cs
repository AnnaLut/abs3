using System;
using System.Collections.Generic;
using Bars.Classes;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Web.UI.HtmlControls;
using Oracle.DataAccess.Client;

public partial class swi_stmt950 : Bars.BarsPage
{
    protected OracleConnection con;
    private void FillData()
    {
        dsMain.DataBind();
        gvMain.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        String SelectCommand = String.Empty;
        if (String.IsNullOrEmpty(Convert.ToString(tbRnk.Value)))
            {
             SelectCommand = @"SELECT SW_STMT_CUSTOMER_LIST.rnk , 
                                        SW_STMT_CUSTOMER_LIST.nmk, 
                                        SW_STMT_CUSTOMER_LIST.bic, 
                                        SW_STMT_CUSTOMER_LIST.stmt, 
                                        s.name
                         FROM SW_STMT_CUSTOMER_LIST, STMT s
                      WHERE SW_STMT_CUSTOMER_LIST.stmt = s.stmt
                      ORDER BY SW_STMT_CUSTOMER_LIST.nmk ";
        }
        else
        {
             SelectCommand = @"SELECT SW_STMT_CUSTOMER_LIST.rnk , 
                                        SW_STMT_CUSTOMER_LIST.nmk, 
                                        SW_STMT_CUSTOMER_LIST.bic, 
                                        SW_STMT_CUSTOMER_LIST.stmt, 
                                        s.name
                         FROM SW_STMT_CUSTOMER_LIST, STMT s
                      WHERE SW_STMT_CUSTOMER_LIST.stmt = s.stmt and SW_STMT_CUSTOMER_LIST.rnk="+tbRnk.Value+"  ORDER BY SW_STMT_CUSTOMER_LIST.nmk ";
        }
       

        dsMain.SelectCommand = SelectCommand;

        gvMain.AutoGenerateCheckBoxColumn = true;
    }
    protected void cbAll_CheckedChanged(object sender, EventArgs e)
    {
        Boolean chkd = (sender as CheckBox).Checked;

        foreach (GridViewRow row in gvMain.Rows)
        {
            CheckBox cb = row.FindControl("cb") as CheckBox;
            cb.Checked = chkd;
        }
    }

    protected void btRun_Click(object sender, EventArgs e)
    {
        InitOraConnection();
        try
        {
            foreach (int row in gvMain.GetSelectedIndices())
            {
                decimal rnk = Convert.ToDecimal(gvMain.DataKeys[row]["RNK"]);
                string bic = Convert.ToString(gvMain.DataKeys[row]["BIC"]);
                decimal stmt = Convert.ToDecimal(gvMain.DataKeys[row]["STMT"]);


                ClearParameters();
                SetParameters("bic", DB_TYPE.Varchar2, bic, DIRECTION.Input);
                SetParameters("rnk", DB_TYPE.Int64, rnk, DIRECTION.Input);
                SetParameters("dat1", DB_TYPE.Date, tbDat1.Value, DIRECTION.Input);
                SetParameters("dat2", DB_TYPE.Date, tbDat2.Value, DIRECTION.Input);
                SetParameters("stmt", DB_TYPE.Int64, stmt, DIRECTION.Input);
                SQL_NONQUERY(@"BEGIN 
                                SWIFT.CreateCustomerStatementMessage(:bic, :rnk, :dat1, :dat2, :stmt);
                                END;");

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Увага", "alert('Виконано!');", true);

            }


        }
        finally
        {
            DisposeOraConnection();

        }
        FillData();
    }


    protected void btSearh_Click(object sender, EventArgs e)
    {
        FillData();
    }
}