using System;
using System.Data;
using System.Globalization;
using System.IO;
using System.Text;
using Bars;
//using CrystalDecisions.Shared;
//using CrystalDecisions.CrystalReports.Engine;

namespace BarsWeb.CrystalReports
{
	/// <summary>`
	/// Печать шаблона Crystal Report
	/// Существующие отчеты :
	/// 1. Выписка по счету - template=0
    /// 2. Начислинные проценты - template=1
    /// 3. Виписка по счетам(ОР ГРН виконавця 2 екз)- template=2
	/// Форматы:
	/// 0 - html(format=0)
	/// 1 - rtf (format=1)
	/// 2 - pdf (format=2)
	/// 3 - xls (format=3)
    /// 4 - txt (format=4)
	/// </summary>
	public partial class WebForm1 : BarsPage
	{
		/*string base_role = "wr_creports";
        bool isEmpty = false;
		CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");

        //
        private string exportPath;
        private DiskFileDestinationOptions diskFileDestinationOptions;
        private ExportOptions exportOptions;

        private void ExportSetup()
        {
            exportPath = "C:\\Exported\\";
            diskFileDestinationOptions = new DiskFileDestinationOptions();
            //exportOptions = hierarchicalGroupingReport.ExportOptions;
            
            exportOptions.ExportDestinationType = ExportDestinationType.DiskFile;
        }

		private void Page_Load(object sender, EventArgs e)
		{
			cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
			cinfo.DateTimeFormat.DateSeparator = ".";
			cinfo.NumberFormat.NumberDecimalSeparator = ".";

			if(Request.Params.Get("template") == null)
				throw new Exception("Не задан параметр template!");

			byte templateId = Convert.ToByte(Request.Params.Get("template"));
			
			switch (templateId)
			{
				case 0 : BindReport_AccExtract(); break;
				case 1 : BindReport_AcrInt(); break;
                case 2:  BindReport_LicAcc(); break;
                case 3:  BindGraph_Ussr1(); break;
				default : throw new Exception("Отчет не существует!");
			}*/
		}

		/*private void PrintReport(ReportClass oRpt)
		{
            int format = (Request.Params.Get("format") == null)?(0):(Convert.ToInt32(Request.Params.Get("format")));

            string tempFileName = "report";
            ExportFormatType exportType = ExportFormatType.NoFormat;

			Response.ClearContent();
			Response.ClearHeaders();
			Response.Charset = "windows-1251";
			Response.ContentEncoding = Encoding.GetEncoding("windows-1251");

            if (isEmpty)
            {
                Response.Write("Нет данных для отчета");
                return;
            }

			switch (format)
			{
				case 0: tempFileName += ".htm";
						break;
				case 1: tempFileName += ".doc";
                        exportType = ExportFormatType.WordForWindows;
						break;
				case 2: tempFileName += ".pdf";
                        exportType = ExportFormatType.PortableDocFormat;
						break;
				case 3: tempFileName += ".xls";
                        exportType = ExportFormatType.Excel;
						break;
                case 4: tempFileName += ".rtf";
                        exportType = ExportFormatType.RichText;
                        break;
			}
            if (format == 0)
            {
                Stream stream = oRpt.ExportToStream(ExportFormatType.HTML40); 
                stream.Position = 0;
                StreamReader sr = new StreamReader(stream, Encoding.GetEncoding("utf-8"));
                Response.Write(sr.ReadToEnd());
            }
            else
            {
                oRpt.ExportToHttpResponse(exportType, Response, true, tempFileName);
            }

			Response.Flush();			
			Response.End();
		}

		/// <summary>
		/// Отчет: Выписка по счету
		/// параметры
		/// nls - счет
		/// date - дата
		/// </summary>
		private void BindReport_AccExtract()
		{
			try
			{
                ReportClass oRpt = new ReportClass();
                string reportFile = Server.MapPath("Reports/rptAccExtract.rpt");
                oRpt.FileName = reportFile;
                oRpt.Load();
				InitOraConnection();
				SetRole(base_role);

				if(Request.Params.Get("nls") == null || Request.Params.Get("dateB") == null || Request.Params.Get("dateE") == null)
					throw new Exception("Не заданы обязательные параметры!");
				DateTime dateB = Convert.ToDateTime(Request.Params.Get("dateB"),cinfo);
				DateTime dateE = Convert.ToDateTime(Request.Params.Get("dateE"),cinfo);
				string nls = Request.Params.Get("nls");

				SetParameters("dateB",DB_TYPE.Date,dateB,DIRECTION.Input);
				SetParameters("dateE",DB_TYPE.Date,dateE,DIRECTION.Input);
				SetParameters("nls",DB_TYPE.Varchar2,nls,DIRECTION.Input);
				SQL_NONQUERY("begin P_LIC20(USER_ID, :dateB, :dateE, :nls); end;");
				
				ClearParameters();
				SetParameters("nls",DB_TYPE.Varchar2,nls,DIRECTION.Input);
                DataSet ds = SQL_SELECT_dataset(@"SELECT to_char(tl.acc) ACC, to_char(ca.rnk) RNK, c.nmk NMK, tl.nls NLS, tl.nms NMS, to_char(tl.isp) ISP,
														s.fio FIO, TO_CHAR(tl.fdat,'DD/MM/YYYY') FDAT, TO_CHAR(tl.dapp,'DD/MM/YYYY') DAPP, (tl.ostf/100) OSTF, tl.tt TT,
														to_char(tl.ref) REF, tl.mfo MFO, to_char(tl.vob) VOB, tl.nd ND, to_char(tl.sk) SK, tl.nlsk NLSK,
														DECODE(SIGN(tl.ostf),-1,'ДЕБЕТ*',0,'',1,'КРЕДИТ*')||TO_CHAR(ABS(tl.ostf/100)) OSTF_STR,			
														DECODE(SIGN(tl.s),-1,ABS(tl.s),0,0,1,0)/100 S1,DECODE(SIGN(tl.s),1,ABS(tl.s),0,0,-1,0)/100 S2,
													    to_char(tl.userid) USERID, tl.nb NB, tl.okpo OKPO, tl.namk NAMK, tl.nazn NAZN, f_ourmfo OUR_MFO, (select nb from banks where mfo=f_ourmfo) OUR_MFO_NB
												  FROM tmp_lic tl, cust_acc ca, customer c, staff s, saldo d 
												 WHERE tl.acc=ca.acc         
													AND  tl.ID=user_id   
													AND ca.rnk=c.rnk           
													AND s.id=tl.isp            
													AND tl.nls = :nls
													AND tl.acc=d.acc           
												ORDER BY substr(tl.nls,1,4)||substr(tl.nls,6,9),8,18,12,nvl(tl.bis, 0)");
                if (ds.Tables[0].Rows.Count == 0)
                    isEmpty = true;
                oRpt.SetDataSource(ds.Tables[0]);
				PrintReport(oRpt);

			}
			finally
			{
				DisposeOraConnection();
			}
		}

		/// <summary>
		/// Начисление процентов
		/// </summary>
		private void BindReport_AcrInt()
		{
			try
			{
                ReportClass oRpt = new ReportClass();
                string reportFile = Server.MapPath("Reports/rptAcrIntU.rpt");
                oRpt.FileName = reportFile;
                oRpt.Load();
				InitOraConnection();
				string mfo = GetGlobalParam("MFO","BASIC_INFO");
				string nb = GetGlobalParam("NAME","BASIC_INFO");
				string boss = GetGlobalParam("PROCMAN","BASIC_INFO");
				string bdate = Convert.ToString(SQL_SELECT_scalar("select To_CHAR(web_utl.get_bankdate,'dd-MM-yyyy') from dual"));
				string vyk = Convert.ToString(SQL_SELECT_scalar("select fio from staff where id=user_id"));
                				
				SetRole("wr_acrint");
				//DataSet ds = SQL_SELECT_dataset(@"select TYPNACH, LCV_NAME VALNAME,KV_NAME,id,acc,nbs,lcv,nls,TO_CHAR(datf,'dd/MM/yy') FDAT,TO_CHAR(datt,'dd/MM/yy') TDAT,ir,br,osts,acrd,nms,osta,lcv,dig
				//			  				      from v_acrint where isp=257");
				DataSet ds = (DataSet)Context.Cache["TEST1"];
                oRpt.SetDataSource(ds.Tables[0]);
                oRpt.SetParameterValue("paramMFO", mfo);
                oRpt.SetParameterValue("paramNB", nb);
                oRpt.SetParameterValue("paramReportData", bdate);
                oRpt.SetParameterValue("paramBoss", boss);
                oRpt.SetParameterValue("paramVyk", vyk);
				PrintReport(oRpt);
			}
			finally
			{
				DisposeOraConnection();
			}
		}

        /// <summary>
        /// Отчет: Выписка по счету
        /// параметры
        /// nls - счет
        /// dateE - дата нач.
        /// dateB - дата конеч.
        /// </summary>
        private void BindReport_LicAcc()
        {
            try
            {
                ReportClass oRpt = new ReportClass();
                string reportFile = Server.MapPath("Reports/rptLicAcc.rpt");
                oRpt.FileName = reportFile;
                oRpt.Load();
                
                InitOraConnection();
                SetRole(base_role+",basic_info");

                if (Request.Params.Get("nls") == null || Request.Params.Get("dateB") == null || Request.Params.Get("dateE") == null)
                    throw new Exception("Не заданы обязательные параметры!");
                DateTime dateB = Convert.ToDateTime(Request.Params.Get("dateB"), cinfo);
                DateTime dateE = Convert.ToDateTime(Request.Params.Get("dateE"), cinfo);
                string nls = Request.Params.Get("nls");
                nls = nls.Replace("*", "%");
                SetParameters("dateB", DB_TYPE.Date, dateB, DIRECTION.Input);
                SetParameters("dateE", DB_TYPE.Date, dateE, DIRECTION.Input);
                SetParameters("nls", DB_TYPE.Varchar2, nls, DIRECTION.Input);
                SQL_NONQUERY("begin P_LIC0(user_id, :dateB, :dateE, :nls); end;");
                
                ClearParameters();
                SetParameters("nls", DB_TYPE.Varchar2, nls, DIRECTION.Input);
                DataSet ds = SQL_SELECT_dataset(@"SELECT t.isp,t.nls,t.kv,t.nms,t.acc,t.fdat,to_char(t.fdat,'dd/MM/yyyy') fdat_str  ,t.wd,t.s/100 S1,t.nd,t.mfo,t.nlsk,
                                                         t.namk,t.userid,t.ref,t.sk,t.nazn,t.tt,t.ostf/100 OSTF,abs(t.ostf/100) ostf_str,t.dapp,to_char(t.dapp,'dd/MM/yyyy') dapp_str, c.rnk, c.nmk
                                                FROM tmp_lic t, customer c, cust_acc ca,saldo s
                                                WHERE t.acc=ca.acc and ca.rnk=c.rnk and substr(t.nls,1,1)<>'8' and t.id=user_id and t.nls like :nls and t.acc=s.acc and s.tobo=tobopack.gettobo
                                                ORDER BY substr(t.nls,1,4)||substr(t.nls,6,9), t.kv, t.fdat, t.s, t.ref, nvl(t.bis, 0)");

                ds.Tables[0].TableName = "dataLicAcc";
                if (ds.Tables[0].Rows.Count == 0)
                    isEmpty = true;
                oRpt.SetDataSource(ds.Tables[0]);

                ClearParameters();
                oRpt.SetParameterValue("dateB", Request.Params.Get("dateB"));
                oRpt.SetParameterValue("dateE", Request.Params.Get("dateE"));
                oRpt.SetParameterValue("printTime", DateTime.Now.ToString("dd/MM/yyyy  HH:mm:ss"));
                oRpt.SetParameterValue("mfoBank", GetGlobalParam("MFO", "BASIC_INFO"));
                oRpt.SetParameterValue("nameBank", GetGlobalParam("NAME", "BASIC_INFO"));

                PrintReport(oRpt);

            }
            finally
            {
                DisposeOraConnection();
            }
        }

        private void BindGraph_Ussr1()
        {
            try
            {
                ReportClass oRpt = new ReportClass();
                string reportFile = Server.MapPath("Reports/rptUssr1.rpt");
                oRpt.FileName = reportFile;
                oRpt.Load();

                InitOraConnection();
                SetRole(base_role);

                DataSet ds = SQL_SELECT_dataset(@"select * from v_ussr_reg_totals");

                ds.Tables[0].TableName = "ussr1";
                oRpt.SetDataSource(ds.Tables[0]);

                PrintReport(oRpt);
            }
            finally
            {
                DisposeOraConnection();
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
	}*/
}
