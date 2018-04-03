using System;
using System.Collections;
using Bars.Application;
using Bars.Classes;
using System.Threading;
using System.Globalization;

namespace barsweb
{
	/// <summary>
	/// Summary description for LoginPage.
	/// </summary>
	public partial class OptionList : Bars.BarsPage
	{
        private void Page_Load(object sender, System.EventArgs e)
		{
		}


        protected override void OnPreRender(EventArgs evt)
        {
            if (!IsPostBack)
            {
                selGlob.Value = WebUserProfiles.GetParam("CULTURE");
                selLoc.Value = WebUserProfiles.GetParam("UI_CULTURE");
            }
            base.OnPreRender(evt);
        }

        protected void btnSave_ServerClick(object sender, EventArgs e)
        {
            WebUserProfiles.SetParam("CULTURE", selGlob.Value);
            WebUserProfiles.SetParam("UI_CULTURE", selLoc.Value);
            // Обновляем культуру окна настроек (job может не успеть отработать).
            //Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture(selLoc.Value);
            //DoNotSelectLanguage();
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
        { }

        #endregion
    }
}
