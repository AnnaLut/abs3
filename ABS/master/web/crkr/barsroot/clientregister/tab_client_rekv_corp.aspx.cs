using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Infragistics.WebUI.UltraWebGrid;

namespace clientregister
{
    /// <summary>
    /// Реквизиты клиента "Юр. лицо"
    /// </summary>
    public partial class tab_client_rekv_corp : Bars.BarsPage
    {

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (Request.Params.Get("rnk") != null)
            {
                grdACCS.Columns[1].HeaderText = Resources.clientregister.GlobalResources.grdACCS1;
                grdACCS.Columns[2].HeaderText = Resources.clientregister.GlobalResources.grdACCS2;
                grdACCS.Columns[3].HeaderText = Resources.clientregister.GlobalResources.grdACCS3;
                grdACCS.Columns[4].HeaderText = Resources.clientregister.GlobalResources.grdACCS4;

                grdACCS.Columns[1].HeaderText = "0";
                //-------------------------------------------------------------------------------------------------
                Infragistics.WebUI.UltraWebGrid.UltraGridBand band = new UltraGridBand();
                //band.AddButtonCaption = "Добавить";

                bool blFlag = ((Request.Params.Get("readonly") != null) ? (((Request.Params.Get("readonly") == "true") ? (true) : (false))) : (false));

                //-------------------------------------------------------------------------------------------------
                grdACCS.DisplayLayout.AllowAddNewDefault = ((blFlag) ? (AllowAddNew.No) : (AllowAddNew.Yes));
                grdACCS.Bands[0].AllowAdd = grdACCS.DisplayLayout.AllowAddNewDefault;
                grdACCS.DisplayLayout.AllowDeleteDefault = ((blFlag) ? (AllowDelete.No) : (AllowDelete.Yes));
                grdACCS.Bands[0].AllowDelete = grdACCS.DisplayLayout.AllowDeleteDefault;
                grdACCS.DisplayLayout.AllowUpdateDefault = ((blFlag) ? (AllowUpdate.No) : (AllowUpdate.Yes));
                grdACCS.Bands[0].AllowUpdate = grdACCS.DisplayLayout.AllowUpdateDefault;

                td_add_accs.Disabled = blFlag;
                td_del_accs.Disabled = blFlag;

                if (Request.Params.Get("rnk").Trim() != string.Empty)
                {
                    grdACCS.DataSource = Client.GetLists.GetACCSTable(Context, Request.Params.Get("rnk"));
                    grdACCS.DataBind();
                }
            }
            else
            {
                throw new Exception("Страница вызвана без необходимого параметра");
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

        }
        #endregion

    }
}
