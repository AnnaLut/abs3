using System;
using System.ComponentModel;
using System.Data;
using System.Globalization;
using System.Web;
using System.Web.Services;
using Bars;

namespace BarsWeb.DocumentsView
{
	/// <summary>
	/// Summary description for Service.
	/// </summary>
	public class Service : BarsWebService
	{
		public Service()
		{
			//CODEGEN: This call is required by the ASP.NET Web Services Designer
			InitializeComponent();
		}
		[WebMethod(EnableSession = true)]
		public object[] GetData(string[] data)
		{
			try
			{
				InitOraConnection(Context);

                string role = "";
                switch (data[12])
                {
                    case "0": role = "WR_DOCLIST_TOBO";
                        break;
                    case "1": role = "WR_DOCLIST_USER";
                        break;
                    case "2": role = "WR_DOCLIST_SALDO";
                        break;
                    default:
                        throw new Exception("Страница вызвана без необходимого параметра!");
                }

				SetRole(role);
				
				CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");	
				cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
				cinfo.DateTimeFormat.DateSeparator = ".";

				string dateFilter = "";
                if (!string.IsNullOrEmpty(data[9]) && !string.IsNullOrEmpty(data[10]))
                {
                    /*
                    SetParameters("BEGIN_DATE", DB_TYPE.Date, Convert.ToDateTime(data[9], cinfo), DIRECTION.Input);
                    SetParameters("FINISH_DATE", DB_TYPE.Date, Convert.ToDateTime(data[10], cinfo), DIRECTION.Input);
                    dateFilter = " a.PDAT >= trunc(:BEGIN_DATE) and a.PDAT < (trunc(:FINISH_DATE)+1) ";
                    */
                    // для оптимизации подставляем в виде констант
                    dateFilter = String.Format(" a.PDAT >= to_date('{0}', 'dd.mm.yyyy') and a.PDAT < (to_date('{1}', 'dd.mm.yyyy')+1) ", data[9], data[10]);
                }
				else if(data[10] != "")
				{
                    /*
					SetParameters("BEGIN_DATE",DB_TYPE.Date,Convert.ToDateTime(data[10],cinfo),DIRECTION.Input);
					dateFilter = " a.PDAT >= :BEGIN_DATE ";
                    */
                    // для оптимизации подставляем в виде констант
                    dateFilter = String.Format(" a.PDAT >= to_date('{0}', 'dd.mm.yyyy') ", data[9]);
                }
				else
				{
					dateFilter = " a.PDAT >= trunc(sysdate) and a.PDAT < (trunc(sysdate)+1) ";
				}

				return BindTableWithNewFilter(@"	a.REF as REF, 
												a.TT as TT, 
												a.USERID as USERID, 
												a.ND as ND, 
												a.MFOA as MFOA, 
												a.NLSA as NLSA, 
												a.ID_A as ID_A,
												a.NAM_A as NAM_A,
												a.S_ as S_, 
												a.LCV as LCV, 
												to_char(a.VDAT,'dd.mm.yyyy') as VDAT, 
												a.S2_ as S2_, 
												a.LCV2 as LCV2, 
												a.MFOB as MFOB, 
												a.NLSB as NLSB, 
                                                a.ID_B as ID_B,
												a.NAM_B as NAM_B,
												a.DK as DK, 
												a.SK as SK, 
												to_char(a.DATD,'dd.mm.yyyy') as DATD, 
												a.NAZN as NAZN, 
												a.TOBO as TOBO, 
												a.SOS as SOS", data[11] + " a" , dateFilter, data);
			}
			catch(Exception e)
			{
				SaveExeption(e);
				throw e;
			}
			finally
			{
				DisposeOraConnection();
			}	
		}
		
#region Component Designer generated code
		
		//Required by the Web Services Designer 
		private IContainer components = null;
				
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if(disposing && components != null)
			{
				components.Dispose();
			}
			base.Dispose(disposing);		
		}
		
		#endregion
	}
}
