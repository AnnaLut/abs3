using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class BIS : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Params.Get("ref") != null)
        {
            DataSet data = new DataSet();
            decimal Ref = Convert.ToDecimal(Request.Params.Get("ref"));

            InitOraConnection();
            try
            {

                SetRole(Resources.documentview.Global.AppRole);

                ClearParameters();
                SetParameters("pref", DB_TYPE.Decimal, Ref, DIRECTION.Input);
                data = SQL_SELECT_dataset(@"SELECT b.NAZN || decode(b.NAZNS, 33, b.D_REC, '') as BIS
                                            FROM ARC_RRP a, ARC_RRP b 
                                            WHERE a.REF = :pref and a.BIS = 1 and a.FN_A = b.FN_A and a.DAT_A = b.DAT_A and 
                                                a.REC <> b.REC and a.REC_A-a.BIS = b.REC_A-b.BIS and b.BIS > 0 
                                            ORDER BY b.BIS");
            }
            finally
            {
                DisposeOraConnection();
            }

            // наполнение таблицы данными
            grd_Data.DataSource = data;
            grd_Data.DataBind();
        }
    }
}
