using Bars.Classes;
using Dapper;
using System;
using System.Linq;

namespace ViewAccounts
{
	public partial class Acc_Financial : Bars.BarsPage
	{
		private void Page_Load(object sender, EventArgs e)
		{
            b_depth.Value = GetBranch().ToString();
        }
        private int GetBranch()
        {
            string sql = @"select branch_usr.get_branch from dual";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<string>(sql).SingleOrDefault().Count(f => f == '/') - 1;
            }
        }
        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
