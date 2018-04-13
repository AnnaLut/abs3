using System;
using System.Web.UI.WebControls;
using Bars.Classes;

namespace barsroot.barsweb
{
    /// <summary> 
    /// Summary description for Welcome.
    /// </summary>
    public partial class Welcome : Bars.BarsPage
    {
        protected void Page_Load(object sender, System.EventArgs e)
        {
            System.Threading.Thread.CurrentThread.CurrentCulture = System.Threading.Thread.CurrentThread.CurrentUICulture;
        }

        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);

            ds.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("BASIC_INFO");
            ds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        }
        private void InitializeComponent()
        {

        }
        #endregion
        protected void gvBoards_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string sCommand = Convert.ToString(e.CommandArgument);
            int nRowsCount = Session["ROWSCOUNT"] == null ? 0 : Convert.ToInt32(Session["ROWSCOUNT"]);
            int nLastPageIdx = nRowsCount / gvBoards.PageSize;
            int nNextPageIdx = gvBoards.PageIndex + (gvBoards.PageIndex == nLastPageIdx ? 0 : 1);
            int nPrevPageIdx = gvBoards.PageIndex - (gvBoards.PageIndex == 0 ? 0 : 1);

            switch (sCommand)
            {
                case "First1":
                    gvBoards.PageIndex = 0;
                    break;
                case "Last1":
                    gvBoards.PageIndex = nLastPageIdx;
                    break;
                case "Previous1":
                    gvBoards.PageIndex = nPrevPageIdx;
                    break;
                case "Next1":
                    gvBoards.PageIndex = nNextPageIdx;
                    break;
            }
        }
    }
}
