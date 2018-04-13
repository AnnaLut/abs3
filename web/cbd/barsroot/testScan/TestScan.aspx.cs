using System;
using System.Linq;
using BarsWeb.Models;
using Oracle.DataAccess.Client;

public partial class TEST_TestScan : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            var entity = new EntitiesBarsCore().NewEntity();
            object[] param = new[] {new OracleParameter("p_id", OracleDbType.Int32).Value = 10364};
            var docData = entity.ExecuteStoreQuery<EAD_DOCS>("select * from ead_docs where id = :p_id", param).First();
        }
    }

    protected void Button1_Click(object o, EventHandler e)
    {
    }
}