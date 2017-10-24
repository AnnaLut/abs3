using System.ComponentModel;
using System.Globalization;
using System.Web.Services;
using System.Collections;
using System.Xml;
using System;
using System.Data;
using Bars.Doc;
using Oracle.DataAccess.Client;
using System.Runtime.InteropServices;

namespace BarsWeb.BasicFunctions
{
	/// <summary>
	/// Summary description for BasicService.
	/// </summary>
	public class BasicService : Bars.BarsWebService
	{
		[DllImport("WINBARS2.DLL", EntryPoint="GetChecksumDigit")]
		public static extern char GetChecksumDigit(string mfo,string acc,decimal formula); 

		string base_role = "wr_acrint";
		CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
		public BasicService()
		{
			InitializeComponent();
			cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
			cinfo.DateTimeFormat.DateSeparator = "/";
			cinfo.NumberFormat.NumberDecimalSeparator = ".";
			cinfo.NumberFormat.CurrencyDecimalSeparator = ".";
		}

        [WebMethod(EnableSession = true)]
		public string[] GetGlobalData(string param)
		{
			string[] result = new  string[6];
			try
			{
				InitOraConnection();
				SetRole("BASIC_INFO");
				string type = string.Empty;
				DateTime bdate = Convert.ToDateTime(SQL_SELECT_scalar("select web_utl.get_bankdate from dual"),cinfo);
				DateTime dateFor = bdate;
				DateTime dVdat = bdate;
				double param_NACH = 0;
				string baseval = GetGlobalParam("BASEVAL","BASIC_INFO");
				if(GetGlobalParam("NACH%","BASIC_INFO") == "0")
					param_NACH = 0;
				else 
					param_NACH = 1;
				if(string.Empty == param)
				{
					type = "K";
					dateFor = dateFor.AddDays(param_NACH);
				}
				else if(param.Length == 1)
				{
					type = param;
					dateFor = dateFor.AddDays(param_NACH);
				}
				else
				{
					type = param.Substring(0,1);
					if(param.Substring(1,2) == "ZO")
					{
						result[2] = "1";
						dateFor = dateFor.AddDays(-dateFor.Day);
						dVdat = dateFor;
						string tmp = string.Empty;
						SetRole(base_role);
						while(true)
						{
							ClearParameters();
							SetParameters("kv",DB_TYPE.Decimal,baseval,DIRECTION.Input);
							SetParameters("dVdat",DB_TYPE.Date,dVdat,DIRECTION.Input);
							tmp = Convert.ToString(SQL_SELECT_scalar("SELECT kv FROM holiday WHERE kv=:kv and holiday=:dVdat"));
							if(string.Empty != tmp) break;
							dVdat = dVdat.AddDays(-1);
						}
						ClearParameters();
					}
					else
						dateFor = Convert.ToDateTime(param.Substring(1,10),cinfo);
				}

				result[0] = dateFor.ToString("dd.MM.yyyy");
				result[1] = type;
				if("980" == baseval)
				{
					//Если yyyyMM(текущего дня) Больше yyyyMM (дата начисления)
					if(bdate.Year+bdate.Month > dateFor.Year+dateFor.Month)
					{
						//Max.ДЕНЬ действия месячных корр.проводок (ЗО)
						string dateZO = GetGlobalParam("DAY_ZO","BASIC_INFO").Trim();
						if(string.Empty != dateZO)
						{
							//dd(тек.дня) Меньше или Равно ДНЮ действия ЗО (из PARAMS)  Day_ZO
							if(Convert.ToInt32(dateZO) >= bdate.Day )
							{
								//Достанем последний раб день пред мес
								SetRole(base_role);
								SetParameters("bdate",DB_TYPE.Date,bdate,DIRECTION.Input);
								string maxFdat = Convert.ToString(SQL_SELECT_scalar("SELECT TO_CHAR(max(FDAT),'dd.MM.yyyy') from fdat "+
																  "where to_char(fdat,'yyyyMM')< to_char(:bdate,'yyyyMM')"));
								result[3] = maxFdat;
							}
						}
					}
				}
				result[4] = dVdat.ToString("dd.MM.yyyy");
				result[5] = baseval;
			}
			finally
			{
				DisposeOraConnection();
			}
			return result; 
		}

		private string GetNodeInnerText(XmlNode node,string key)
		{
			string result = string.Empty;
			if(node.SelectSingleNode(key) != null)
				result = Convert.ToString(node.SelectSingleNode(key).InnerText);
			return result;
		}

        [WebMethod(EnableSession = true)]
		public object[] GetAcrIntData(string[] data)
		{
			try
			{
				InitOraConnection();
				string param_NAZNF = GetGlobalParam("NAZNF%","BASIC_INFO");
				string param_NAZN = GetGlobalParam("NAZN%","BASIC_INFO");
				string param_NAZN_R = GetGlobalParam("NAZN_R_%","BASIC_INFO");
				string baseval = Convert.ToString(data[9],cinfo);
				DateTime dVdat = Convert.ToDateTime(data[10],cinfo);
				SetRole(base_role);
				object[] obj = BindTableWithNewFilter("a.rid,a.ISP,a.ID,a.LCV,a.NLS,a.DATF,a.DATT,TO_CHAR(a.DATF,'DD.MM.YYYY') FDAT,TO_CHAR(a.DATT,'DD.MM.YYYY') TDAT,a.IR,a.BR,a.OSTS,ROUND(a.REMI,8) REM_,a.ACRD,a.OSTA,a.ACC,a.NMS,a.NLSA,a.KVA,a.NMSA,a.NLSB,a.KVB,a.NMSB,a.TT,a.NMK,a.OKPO,a.METR,a.DIG,a.NAZN,a.ACRD ACRDQ,a.ACRDR,DECODE(SIGN(a.OSTS),-1,1,0) DK",
											  "V_ACRINT a",
											  "",
											  data);
				string xml = (string) obj[0];
                XmlDocument doc = new XmlDocument();
				doc.LoadXml(xml);
				XmlNode root = doc.DocumentElement;
				IEnumerator ienum = root.GetEnumerator();
				XmlNode row;
				while (ienum.MoveNext()) 
				{     
					row = (XmlNode) ienum.Current;
					ClearParameters();
					row  = FetchRow(doc,row,dVdat,baseval,param_NAZNF,param_NAZN,param_NAZN_R);
				}
				
				obj[0] = doc.OuterXml;

				return obj;
			}
			finally
			{
				DisposeOraConnection();
			}
		}
		
		private XmlNode FetchRow(XmlDocument doc,XmlNode row,DateTime dVdat,string baseval, string param_NAZNF,string param_NAZN,string param_NAZN_R)
		{
			if(row.SelectSingleNode("NAZN") == null)
			{
				row.AppendChild(doc.CreateElement("NAZN"));
				string Id = row.SelectSingleNode("ID").InnerText;
				decimal Dk = Convert.ToDecimal(row.SelectSingleNode("DK").InnerText);
				decimal Ir = 0;
				if(row.SelectSingleNode("IR") != null)
					Ir = Convert.ToDecimal(row.SelectSingleNode("IR").InnerText);
				decimal Br = 0;
				if(row.SelectSingleNode("BR")!= null)
					Br = Convert.ToDecimal(row.SelectSingleNode("BR").InnerText);
				string tt = GetNodeInnerText(row,"TT");
				string Nls = GetNodeInnerText(row,"NLS");
				string Kv = GetNodeInnerText(row,"LCV");
				string NlsA = GetNodeInnerText(row,"NLSA");
				string KvA = GetNodeInnerText(row,"KVA");
				string BankA = "";
				string NlsB = GetNodeInnerText(row,"NLSB");
				string KvB = GetNodeInnerText(row,"KVB");
				string BankB = "";
				string S = GetNodeInnerText(row,"ACRDR");
						
				string Date1 = GetNodeInnerText(row,"FDAT");
				string Date2 = GetNodeInnerText(row,"TDAT");
				string Metr = GetNodeInnerText(row,"METR");
				string Nmk = GetNodeInnerText(row,"NMK");
				if(Metr == "4" || Metr == "5")
				{
					row.SelectSingleNode("DK").InnerText = Convert.ToString(1 - Dk);
				}
				cinfo.NumberFormat.NumberDecimalDigits = 4;
				string Rat = "";
				if(Ir > 0 && Br == 0)
					Rat = Ir.ToString("N",cinfo);
				else if(Ir == 0 && Br > 0)
					Rat = Br.ToString("N",cinfo);
				else
					Rat = Ir.ToString("N",cinfo) + " @ "+ Br.ToString("N",cinfo);
				//Валюта счета осн.капитала НЕ = валюте счета нач %%
				if(Kv != KvA)
				{
					ClearParameters();
					string sql_query = string.Empty;
					if(KvA == baseval)
					{
						SetParameters("lcv",DB_TYPE.Decimal,Kv,DIRECTION.Input);
						SetParameters("acrd",DB_TYPE.Decimal,Convert.ToDecimal(S,cinfo),DIRECTION.Input);
						SetParameters("dVdat",DB_TYPE.Date,dVdat,DIRECTION.Input);
						sql_query = "select gl.p_icurval(:lcv,:acrd,:dVdat) from dual";
					}
					else if(Kv == baseval)
					{
						SetParameters("lcv",DB_TYPE.Decimal,KvA,DIRECTION.Input);
						SetParameters("acrd",DB_TYPE.Decimal,Convert.ToDecimal(S,cinfo),DIRECTION.Input);
						SetParameters("dVdat",DB_TYPE.Date,dVdat,DIRECTION.Input);
						sql_query = "select gl.p_ncurval(:lcv,:acrd,:dVdat) from dual";
					}
					else
					{
						SetParameters("kva",DB_TYPE.Decimal,KvA,DIRECTION.Input);
						SetParameters("lcv",DB_TYPE.Decimal,KvA,DIRECTION.Input);
						SetParameters("acrd",DB_TYPE.Decimal,Convert.ToDecimal(S,cinfo),DIRECTION.Input);
						SetParameters("dVdat",DB_TYPE.Date,dVdat,DIRECTION.Input);
						SetParameters("dVdat",DB_TYPE.Date,dVdat,DIRECTION.Input);
						sql_query = "select gl.p_ncurval(:kva, gl.p_icurval(:lcv, :acrd, :dVdat), :dVdat) from dual";
					}
					string acrdq = Convert.ToString(SQL_SELECT_scalar(sql_query));
					if(string.Empty != acrdq)
						row.SelectSingleNode("ACRDR").InnerText = Convert.ToDecimal(acrdq,cinfo).ToString();
				}

				if(param_NAZNF == "1")
				{
					ClearParameters();ClearParameters();
					SetParameters("tt",DB_TYPE.Char,tt,DIRECTION.Input);
					string ttsNazn = Convert.ToString(SQL_SELECT_scalar("select nazn from tts where tt=:tt"));
					ClearParameters();
					string resNazn = TransNazn(ttsNazn,tt,Nls,Kv,NlsA,BankA,S,KvA,NlsB,BankB,KvB,"0",Rat,Date1,Date2);
					if(string.Empty == resNazn)
					{
						if(Metr == "5" || Metr == "4")
						{
							resNazn = "Амортизація рах.(";
							if(Metr == "4") resNazn += "пропорц.";
							else			resNazn += "по еф.%ст";	
							resNazn += ")";
						}
						else
						{	
							if(Id == "2" && Nls.Substring(0,1) == "8")
								resNazn += "Пеня по рах.";
							else
								resNazn += "%% по рах.";
						}
						if(string.Empty != Date1)
							Date1 = Convert.ToDateTime(Date1,cinfo).ToString("dd-MM-yy");
						if(string.Empty != Date2)
							Date2 = Convert.ToDateTime(Date2,cinfo).ToString("dd-MM-yy");
						resNazn += " " + Nls + " з " + Date1 + " по " + Date2 + " вкл.";
					}
					if(param_NAZN_R != "1")
					{
						if(Metr != "4" && Metr != "5")
							resNazn += "Ставка " + Rat; 
					}
					if(param_NAZN == "1" && NlsA.Substring(0,4) !="2628" && NlsA.Substring(0,4) !="2638")
						resNazn += "(" + Nmk + ")";
					row.SelectSingleNode("NAZN").InnerText = resNazn;
				}
						 
			}
			return row;
		}


		private string TransNazn(string Nazn,string TT,string Nls,string Kv,string NlsA,string BankA,string KvA,string SumA,string NlsB,string BankB,string KvB,string SumB,string Rat,string Dat1,string Dat2)
		{
			string result = Nazn;
			if(string.Empty == Nazn) return result;
			int index_start = result.IndexOf("?");
			if(index_start != -1 || result.IndexOf("#{") != -1)
			{
				try
				{
					ClearParameters();
					while(index_start != -1)
					{
						int index_end = result.IndexOf(" ",index_start);
						string id = string.Empty;
						if(index_end == -1)
							id = result.Substring(index_start+1);
						else
							id = result.Substring(index_start+1,index_end-index_start-1);
						if(id.Trim().Length > 0 && id.Trim().Length <=2)
						{	
							string res = Convert.ToString(SQL_SELECT_scalar("SELECT TRIM(txt) FROM tnaznf WHERE n="+id));
							if(null != res || string.Empty != res)
								result = result.Replace("?"+id,"#{"+res+"}");
						}
						index_start = result.IndexOf("?",index_start + 1);
					}

					result = result.Replace("#(TT)",TT);
					result = result.Replace("#(S)",SumA);
					result = result.Replace("#(S2)",SumB);
					result = result.Replace("#(NLS)",Nls);
					result = result.Replace("#(NLSA)",NlsA);
					result = result.Replace("#(NLSB)",NlsB);
					result = result.Replace("#(MFOA)",BankA);
					result = result.Replace("#(MFOB)",BankB);
					result = result.Replace("#(KV)",Kv);
					result = result.Replace("#(KVA)",KvA);
					result = result.Replace("#(KVB)",KvB);
					result = result.Replace("#(RAT)",Rat);
					result = result.Replace("#(DAT1)",Dat1);
					result = result.Replace("#(DAT2)",Dat2);

					index_start = result.IndexOf("#{");
					while(index_start != -1)
					{
						int index_end = result.IndexOf("}",index_start);	
						string formula = result.Substring(index_start+2,index_end-index_start-2);
						string text = "select " + formula + " from dual";

						SetParameters("sql_str",DB_TYPE.Varchar2, text, DIRECTION.Input);
						SetParameters("param",DB_TYPE.Varchar2, null, DIRECTION.Input);
						DataSet ds =  SQL_PROC_REFCURSOR("exec_refcursor",0,10);

						string res = Convert.ToString(ds.Tables[0].Rows[0][0]);
						if(null != res && string.Empty != res)
							result = result.Replace("#{"+formula+"}",res);
						ClearParameters();

						index_start = result.IndexOf("#{",index_start + 2);
					}
				}
				finally
				{
				}
			}
			else
			{
				result = result.Replace("#(TT)",TT);
				result = result.Replace("#(S)",SumA);
				result = result.Replace("#(S2)",SumB);
				result = result.Replace("#(NLS)",Nls);
				result = result.Replace("#(NLSA)",NlsA);
				result = result.Replace("#(NLSB)",NlsB);
				result = result.Replace("#(MFOA)",BankA);
				result = result.Replace("#(MFOB)",BankB);
				result = result.Replace("#(KV)",Kv);
				result = result.Replace("#(KVA)",KvA);
				result = result.Replace("#(KVB)",KvB);
				result = result.Replace("#(RAT)",Rat);
				result = result.Replace("#(DAT1)",Dat1);
				result = result.Replace("#(DAT2)",Dat2);
			}
			return result;
		}

        [WebMethod(EnableSession = true)]
		public string AcrIntProcess(string[] data)
		{
			try
			{
				InitOraConnection();
				SetRole(base_role);
				data[3] = "";
				string xml = (string)GetFullXmlDataForTable("a.METR,a.BASEY,a.ACC,a.ID,a.FREQ,a.DAT1,a.DAT2,a.KV,a.DAOS,a.NLS",
					"V_ACRINT_USER a",
					"",
					data);
				DateTime dDat = Convert.ToDateTime(data[12],cinfo);
				string CP_ = Convert.ToString(data[13]);
				XmlDocument doc = new XmlDocument();
				doc.LoadXml(xml);
				XmlNode root = doc.DocumentElement;
				IEnumerator ienum = root.GetEnumerator();
				XmlNode row;
				while (ienum.MoveNext()) 
				{     
					row = (XmlNode) ienum.Current;
					DateTime Daos = Convert.ToDateTime(row.SelectSingleNode("DAOS").InnerText);
					DateTime dat1 = Daos;
					DateTime dat2 = dDat; 
					int Id = 0;
					if(row.SelectSingleNode("ID") != null)
						Id = Convert.ToInt32(row.SelectSingleNode("ID").InnerText);
					int Metr = 0;
					if(row.SelectSingleNode("METR") != null)
						Metr = Convert.ToInt32(row.SelectSingleNode("METR").InnerText);
					if(row.SelectSingleNode("DAT1") != null)
						dat1 = Convert.ToDateTime(row.SelectSingleNode("DAT1").InnerText,cinfo);
					if(row.SelectSingleNode("DAT2") != null)
						dat2 = Convert.ToDateTime(row.SelectSingleNode("DAT2").InnerText,cinfo);
					if(dDat < dat2)
						dat2 = dDat;
					int Freq = 0;
					string Nls = GetNodeInnerText(row,"NLS");
					string Basey = GetNodeInnerText(row,"BASEY");
					decimal acc = Convert.ToDecimal(row.SelectSingleNode("ACC").InnerText);
					decimal Int = 0;
					if(row.SelectSingleNode("FREQ") != null)
						Freq = Convert.ToInt32(row.SelectSingleNode("FREQ").InnerText);
					TimeSpan daysSubst = dat2 - dat1;
					if( 1 == Freq ||
						3 == Freq && daysSubst.Days >= 7 ||
						5 == Freq && dat2 > dat1.AddMonths(1) ||
						7 == Freq && dat2 > dat1.AddMonths(3) ||
						180 == Freq && dat2 > dat1.AddMonths(6) ||
						360 == Freq && dat2 > dat1.AddMonths(12))
					{
						string procName = string.Empty;
						ClearParameters();
						// Метод плав % ставки для ОВЕРД
						if(7 == Metr && 0 == Id)
							procName = "ovr.int_ovrp";
							// Начисление комиссий по КП по разным METR > 90
						else if(Metr > 90 && 2 == Id && "8999" == Nls.Substring(0,4))
						{
							SetParameters("metr_",DB_TYPE.Decimal,Metr,DIRECTION.Input);
							procName = "cc_komissia";
						}
						else
						{
							procName = "acrn.p_int";
							if("4" == Basey)
							{
								SetParameters("acc_",DB_TYPE.Decimal,acc,DIRECTION.Input);
								SetParameters("dat_",DB_TYPE.Date,dDat,DIRECTION.Input);
								SQL_PROCEDURE("cp.cp_basey");
								ClearParameters();
							}
							if("Ц" == CP_)
							{
								SetParameters("acc_",DB_TYPE.Decimal,acc,DIRECTION.Input);
								SQL_PROCEDURE("cp.cp_nomin");
								ClearParameters();
							}
						}
						SetParameters("acc_",DB_TYPE.Decimal,acc,DIRECTION.Input);
						SetParameters("id_",DB_TYPE.Decimal,Id,DIRECTION.Input);
						SetParameters("dt1_",DB_TYPE.Date,dat1,DIRECTION.Input);
						SetParameters("dt2_",DB_TYPE.Date,dat2,DIRECTION.Input);
						SetParameters("int_",DB_TYPE.Decimal,Int,DIRECTION.Output);
						SetParameters("ost_",DB_TYPE.Varchar2,null,DIRECTION.Input);
						SetParameters("mode_",DB_TYPE.Decimal,1,DIRECTION.Input);

						SQL_PROCEDURE(procName);
					}
					if("Ц" == CP_)
					{
						SetParameters("acc_",DB_TYPE.Decimal,-22,DIRECTION.Input);
						SQL_PROCEDURE("cp.cp_nomin");
					}
				}
			}
			finally
			{
				DisposeOraConnection();
			}
			return "";
		}

        [WebMethod(EnableSession = true)]
		public void CompressRate()
		{
			try
			{
				InitOraConnection();
				SetRole(base_role);
				SQL_NONQUERY("begin acrn.p_cnds; end;");
			}
			finally
			{
				DisposeOraConnection();
			}
		}

		[WebMethod(EnableSession = true)]
		public void DelRow(string[] rowIds)
		{
			try
			{
                InitOraConnection();
				SetRole(base_role);
				for(int i = 0; i < rowIds.Length; i++)
				{
					if(rowIds[i] != string.Empty)
					{
						ClearParameters();
						SetParameters("rid",DB_TYPE.NVarchar2,rowIds[i].Split(',')[1],DIRECTION.Input);
						SQL_NONQUERY("delete from acr_intN where rowid=:rid");
					}
				}
			}
			finally
			{
				DisposeOraConnection();
			}
		}

        [WebMethod(EnableSession = true)]
		public void SaveTable(string rowId,string acrd,string nazn)
		{
			try
			{
				InitOraConnection();
				SetRole(base_role);
				SetParameters("acrd",DB_TYPE.Decimal,acrd,DIRECTION.Input);
				SetParameters("nazn",DB_TYPE.Varchar2,nazn,DIRECTION.Input);
				SetParameters("rid",DB_TYPE.NVarchar2,rowId,DIRECTION.Input);
				SQL_NONQUERY("update acr_intN set acrd=:acrd,nazn=:nazn where rowid=:rid");
			}
			finally
			{
				DisposeOraConnection();
			}
		}
		
		
		[WebMethod(EnableSession = true)]
		public string RunAccrueInt(string[] data)
		{
			try
			{
				InitOraConnection();
				string param_NAZNF = GetGlobalParam("NAZNF%","BASIC_INFO");
				string param_NAZN = GetGlobalParam("NAZN%","BASIC_INFO");
				string param_NAZN_R = GetGlobalParam("NAZN_R_%","BASIC_INFO");
				string bankMfo = GetGlobalParam("MFO","BASIC_INFO"); 
				string bankOkpoA = GetGlobalParam("OKPO","BASIC_INFO").PadLeft(8,'0'); 
				string TtsK = GetGlobalParam("TTSK_%","BASIC_INFO");
				DateTime bdate = Convert.ToDateTime(SQL_SELECT_scalar("select web_utl.get_bankdate from dual"),cinfo);
				string baseval = Convert.ToString(data[9],cinfo);
				DateTime dVdat = Convert.ToDateTime(data[10],cinfo);
				string bZo = Convert.ToString(data[11],cinfo);
				string Choice = Convert.ToString(data[13],cinfo);
				SetRole(base_role);
				string userKeyID = Convert.ToString(SQL_SELECT_scalar("select docsign.GetIdOper from dual"));
				
				string xml = (string)GetFullXmlDataForTable("a.rid,a.ISP,a.ID,a.LCV,a.NLS,a.DATF,a.DATT,TO_CHAR(a.DATF,'DD.MM.YYYY') FDAT,TO_CHAR(a.DATT,'DD.MM.YYYY') TDAT,a.IR,a.BR,a.OSTS,ROUND(a.REMI,8) REM_,a.ACRD,a.OSTA,a.ACC,a.NMS,a.NLSA,a.KVA,a.NMSA,a.NLSB,a.KVB,a.NMSB,a.TT,a.NMK,a.OKPO,a.METR,a.DIG,a.NAZN,a.ACRD ACRDQ,a.ACRDR,DECODE(SIGN(a.OSTS),-1,1,0) DK",
					"V_ACRINT a",
					"",
					data);
				XmlDocument doc = new XmlDocument();
				doc.LoadXml(xml);
				XmlNode root = doc.DocumentElement;
				IEnumerator ienum = root.GetEnumerator();
				XmlNode row;
				while (ienum.MoveNext()) 
				{
					row = (XmlNode) ienum.Current;
					row = FetchRow(doc,row,dVdat,baseval,param_NAZNF,param_NAZN,param_NAZN_R);
					decimal acc = Convert.ToDecimal(row.SelectSingleNode("ACC").InnerText);
					decimal id = Convert.ToDecimal(row.SelectSingleNode("ID").InnerText);
					ClearParameters();
					SetParameters("acc",DB_TYPE.Decimal,acc,DIRECTION.Input);
					SetParameters("id",DB_TYPE.Decimal,id,DIRECTION.Input);
					ArrayList reader =  SQL_reader("SELECT acr_dat, metr "+
													"FROM int_accN "+
													"WHERE acc=:acc and id=:id "+
													"FOR UPDATE OF acc NOWAIT");
					if(reader.Count > 0)
					{
						DateTime dDatT = DateTime.MinValue;
						if(Convert.ToString(reader[0]) != string.Empty)
							dDatT = Convert.ToDateTime(reader[0],cinfo);
						DateTime dDatF = DateTime.MinValue;
						if(row.SelectSingleNode("DATF") != null)
							dDatF = Convert.ToDateTime(row.SelectSingleNode("DATF").InnerText,cinfo);
						string sDatT = GetNodeInnerText(row,"DATT");
						int Metr = Convert.ToInt32(reader[1]);
						string remi = GetNodeInnerText(row,"REM_");
						if( (dDatT != DateTime.MinValue || dDatT < dDatF) || 7 == Metr)
						{
							ClearParameters();
							if(string.Empty != sDatT)
								SetParameters("dDatT",DB_TYPE.Date,Convert.ToDateTime(sDatT,cinfo),DIRECTION.Input);
							else 
								SetParameters("dDatT",DB_TYPE.Varchar2,null,DIRECTION.Input);
							if(String.Empty != remi)
								SetParameters("remi",DB_TYPE.Decimal,Convert.ToDecimal(remi,cinfo),DIRECTION.Input);
							else 
								SetParameters("remi",DB_TYPE.Varchar2,null,DIRECTION.Input);
							SetParameters("acc",DB_TYPE.Decimal,acc,DIRECTION.Input);
							SetParameters("id",DB_TYPE.Decimal,id,DIRECTION.Input);
							SQL_NONQUERY("UPDATE int_accN SET acr_dat = :dDatT, s=:remi WHERE acc=:acc and id=:id");
							if("1" == Choice)
							{
								short KvA = Convert.ToInt16(GetNodeInnerText(row,"KVA"));
								short KvB = 0;
								if(GetNodeInnerText(row,"KVB") != string.Empty)
									KvB = Convert.ToInt16(GetNodeInnerText(row,"KVB"));
								string tt = GetNodeInnerText(row,"TT");
								short Vob = 0;
								decimal SummCorr = 0;
								decimal acrdQ = Math.Abs(Convert.ToDecimal(GetNodeInnerText(row,"ACRDR"),cinfo));
								if(KvA == KvB)
								{
									Vob = 6;
									SummCorr = acrdQ;
								}
								else
								{
									Vob = 16;
									ClearParameters();
									SetParameters("RatO",DB_TYPE.Decimal,0,DIRECTION.InputOutput);
									SetParameters("RatB",DB_TYPE.Decimal,0,DIRECTION.InputOutput);
									SetParameters("RatS",DB_TYPE.Decimal,0,DIRECTION.InputOutput);
									SetParameters("Kv1",DB_TYPE.Decimal,KvA,DIRECTION.Input);
									SetParameters("Kv2",DB_TYPE.Decimal,KvB,DIRECTION.Input);
									SetParameters("Dat",DB_TYPE.Date,dVdat,DIRECTION.Input);
									SQL_PROCEDURE("gl.x_rat");
									string sRatO = Convert.ToString(GetParameter("RatO")).Replace(",",".");
									decimal RatO = Convert.ToDecimal(sRatO,cinfo);
									SummCorr = RatO * acrdQ;
								}
								if("1" == bZo)  Vob = 96;
								//Проводки
								if(acrdQ != 0)
								{
									cDoc ourDoc;
									byte dk = Convert.ToByte(GetNodeInnerText(row,"DK")); 	
									string NlsA = GetNodeInnerText(row,"NLSA");
									string NmsA = GetNodeInnerText(row,"NMSA");
									string NlsB = GetNodeInnerText(row,"NLSB");
									string NmsB = GetNodeInnerText(row,"NMSB");
									string Okpo = GetNodeInnerText(row,"OKPO");
									string Nazn = GetNodeInnerText(row,"NAZN");
									OracleConnection conn = new OracleConnection(ConnectionString(Context));

									if(string.Empty != TtsK && TtsK.IndexOf(tt) > 0)
									{
										ourDoc =  new cDoc(conn,0,tt,(byte)(1-dk),Vob,"",
											bdate,bdate,dVdat,bdate,
											NlsB,NmsB,bankMfo,"",KvB,SummCorr,bankOkpoA,
											NlsA,NmsA,bankMfo,"",KvA,acrdQ,Okpo,
											Nazn,"",userKeyID,new byte[0],Byte.MinValue,0,0,"","","","");
									}
									else
									{
										ourDoc =  new cDoc(conn,0,tt,dk,Vob,"",
											bdate,bdate,dVdat,bdate,
											NlsA,NmsA,bankMfo,"",KvA,acrdQ,Okpo,
											NlsB,NmsB,bankMfo,"",KvB,SummCorr,bankOkpoA,
											Nazn,"",userKeyID,new byte[0],Byte.MinValue,0,0,"","","","");
									}
									string rf = string.Empty;
									if (ourDoc.oDoc())
									{
										rf = ourDoc.Ref.ToString();
									}
								}
							}
						}
						//InitOraConnection();
						//SetRole(base_role);
						ClearParameters();
						string rid = GetNodeInnerText(row,"RID");
						SetParameters("rid",DB_TYPE.NVarchar2,rid,DIRECTION.Input);
						SQL_NONQUERY("delete from acr_intN where rowid=:rid");
					}
				}
			}
			finally
			{
				DisposeOraConnection();
			}
			return "";
		}

		[WebMethod(EnableSession = true)]
		public string BuildRep(string[] data,string par)
		{
			try
			{
				InitOraConnection();
				string mfo = GetGlobalParam("MFO","BASIC_INFO");
				string nb = GetGlobalParam("NAME","BASIC_INFO");
				string boss = GetGlobalParam("PROCMAN","BASIC_INFO");
				string nboss = GetGlobalParam("BOSS_%","BASIC_INFO");
				string bdate = Convert.ToString(SQL_SELECT_scalar("select To_CHAR(web_utl.get_bankdate,'dd-MM-yyyy') from dual"));
				string vyk = Convert.ToString(SQL_SELECT_scalar("select fio from staff where id=user_id"));

				SetRole(base_role);
				string boss1 = boss;
				string boss2 = boss;
				if(nboss == "1")
				{
					boss1 = Convert.ToString(SQL_SELECT_scalar("select s.fio FROM int_user i, staff s WHERE i.userid  = user_id AND i.procman = s.id AND i.kv=0"));
					boss2 = Convert.ToString(SQL_SELECT_scalar("select s.fio FROM int_user i, staff s WHERE i.userid  = user_id AND i.procman = s.id AND i.kv=1"));
				}
				if(string.Empty == boss1) boss1 = boss;
				if(string.Empty == boss2) boss2 = boss;
				string str1 = string.Empty;
				if(par != "S")
					str1 = "nmk";
				
				DataSet ds = GetFullDataSetForTable("TYPNACH, LCV_NAME VALNAME,KV_NAME,id,acc,nbs,lcv,nls,TO_CHAR(datf,'dd/MM/yy') FDAT,TO_CHAR(datt,'dd/MM/yy') TDAT,ir,br,osts,acrd,"+str1+" nms,osta,lcv,dig,acrdr,ostsr,ostcr",
					"V_ACRINT a",
					"",
					data);
				
				Random rnd = new Random();
				string key = string.Empty;
				key += DateTime.Now.ToString("ddMMyyyyhhmmssfff");
				key += rnd.Next().ToString();
				object[] obj = new object[8];
				obj[0] = ds;
				obj[1] = mfo;
				obj[2] = nb;
				obj[3] = boss;
				obj[4] = bdate;
				obj[5] = vyk;
				obj[6] = boss1;
				obj[7] = boss2;
				AppDomain.CurrentDomain.SetData(key,obj);
				
				string xml = ds.GetXml();
				XmlDocument doc = new XmlDocument();
				doc.LoadXml(xml);
				XmlNode root = doc.DocumentElement;
				IEnumerator ienum = root.GetEnumerator();
				XmlNode row;
				while (ienum.MoveNext()) 
				{     
					row = (XmlNode) ienum.Current;
					ClearParameters();
					string Acc = Convert.ToString(GetNodeInnerText(row,"ACC"));
					string Id = Convert.ToString(GetNodeInnerText(row,"ID"));
					string Fdat = Convert.ToString(GetNodeInnerText(row,"FDAT"));
					string Tdat = Convert.ToString(GetNodeInnerText(row,"TDAT"));
					string Nbs = Convert.ToString(GetNodeInnerText(row,"NBS"));
					string Lcv = Convert.ToString(GetNodeInnerText(row,"KV_NAME"));
					string Nls = Convert.ToString(GetNodeInnerText(row,"NLS"));
					string Ir = Convert.ToString(GetNodeInnerText(row,"IR"));
					string Br = Convert.ToString(GetNodeInnerText(row,"BR"));
					string Osts = Convert.ToString(GetNodeInnerText(row,"OSTSR"));
					string Acrd = Convert.ToString(GetNodeInnerText(row,"ACRDR"));
					string Nms = Convert.ToString(GetNodeInnerText(row,"NMS"));
					string Ostc = Convert.ToString(GetNodeInnerText(row,"OSTCR"));
					string Kv = Convert.ToString(GetNodeInnerText(row,"LCV"));
					SetParameters("acc",DB_TYPE.Decimal,Acc,DIRECTION.Input);
					SetParameters("id",DB_TYPE.Decimal,Id,DIRECTION.Input);
					SetParameters("fdat",DB_TYPE.Date,Convert.ToDateTime(Fdat,cinfo),DIRECTION.Input);
					SQL_NONQUERY("DELETE FROM tmp_intarc WHERE acc=:acc AND id=:id AND fdat>=:fdat");

					SetParameters("tdat",DB_TYPE.Date,Convert.ToDateTime(Tdat,cinfo),DIRECTION.Input);	
					SetParameters("nbs",DB_TYPE.Varchar2,Nbs,DIRECTION.Input);
					SetParameters("lcv",DB_TYPE.Varchar2,Lcv,DIRECTION.Input);
					SetParameters("nls",DB_TYPE.Varchar2,Nls,DIRECTION.Input);
					SetParameters("ir",DB_TYPE.Decimal,Convert.ToDecimal(Ir,cinfo),DIRECTION.Input);
					SetParameters("br",DB_TYPE.Decimal,Convert.ToDecimal(Br,cinfo),DIRECTION.Input);
					SetParameters("osts",DB_TYPE.Decimal,Osts,DIRECTION.Input);
					SetParameters("acrd",DB_TYPE.Decimal,Acrd,DIRECTION.Input);
					SetParameters("nms",DB_TYPE.Varchar2,Nms,DIRECTION.Input);
					SetParameters("ostc",DB_TYPE.Decimal,Ostc,DIRECTION.Input);
					SetParameters("kv",DB_TYPE.Decimal,Kv,DIRECTION.Input);
					SetParameters("bdat",DB_TYPE.Date,bdate,DIRECTION.Input);
					
					SQL_NONQUERY(@"INSERT INTO tmp_intarc
								  (acc,id,fdat,tdat,nbs,lcv,nls,ir,br,osts,acrd,nms,ostc,kv,userid,bdat) VALUES
								  (:acc,:id,:fdat,:tdat,:nbs,:lcv,:nls,:ir,:br,:osts,:acrd,:nms,:ostc,:kv,user_id,:bdat)");
				}
				return key;
			}
			finally
			{
				DisposeOraConnection();
			}
		}

		[WebMethod(EnableSession = true)]
		public object[] Percent_Button(decimal acc,decimal id,bool copy,decimal kv)
		{
			if(copy) id -=2;
			return Percent(acc,id,kv);
		}
		[WebMethod(EnableSession = true)]
		public object[] PercentTable(string[] data)
		{
			object[] obj = new object[2];
			DataSet ds = new DataSet();
			int count = 0;
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				string order = data[3];
				int startpos = Convert.ToInt32(data[4]);
				int pageSize = Convert.ToInt32(data[5]);
				SetParameters("acc",DB_TYPE.Decimal,data[9],DIRECTION.Input);
				SetParameters("id",DB_TYPE.Decimal,data[10],DIRECTION.Input);
				ds = SQL_SELECT_dataset(@"SELECT rownum ID,TO_CHAR(i.bdat,'DD/MM/YYYY') BDAT,i.ir IR,DECODE(i.op,'0','','1','+','2','-','3','*','4','/') OP,b.name NAME,i.br BR
					                      FROM int_ratN i, brates b
					                      WHERE i.acc=:acc AND i.id=:id AND i.br=b.br_id (+) ORDER BY "+order,startpos,pageSize);
				obj[0] = ds.GetXml();
				obj[1] = count;
				return obj;
			}
			finally
			{
				DisposeOraConnection();
			}
		}
		[WebMethod(EnableSession = true)]
		public string[] InitProcAccount(decimal acc)
		{
			string[] result = new string[14];
			try
			{
				InitOraConnection();
				string io  = GetGlobalParam("IO%","BASIC_INFO");
				string mfo  = GetGlobalParam("MFO","BASIC_INFO");
				string baseval  = GetGlobalParam("BASEVAL","BASIC_INFO"); 
				string sel_10 = GetGlobalParam("SEL_010","BASIC_INFO");
				string bdate = Convert.ToString(SQL_SELECT_scalar("select To_CHAR(web_utl.get_bankdate,'dd/MM/yyyy') from dual"));
				SetRole(base_role);
				SetParameters("acc",DB_TYPE.Decimal,acc,DIRECTION.Input);
				ArrayList reader = SQL_reader(@"SELECT a.nls,TO_CHAR(a.kv),TO_CHAR(a.pap),a.nbs,a.nms,TO_CHAR(a.ostc),t.lcv, TO_CHAR(a.tip), TO_CHAR(a.lim)
									            FROM accounts a, tabval t WHERE a.kv=t.kv AND acc=:acc");
				if(reader.Count == 0)
					throw new Exception("Не открыт счет с внутренним № "+acc);
				reader.CopyTo(result);
				result[9] = io;
				result[10] = bdate;
				result[11] = mfo;
				result[12] = baseval;
				result[13] = sel_10;
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
		}	
		[WebMethod(EnableSession = true)]
		public string[] ValidNls(string mfo,string nls,string kv)
		{
			string[] result = new string[2];
			try
			{ 
				string new_nls = KeyAccount(mfo,nls)[0];
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("nls",DB_TYPE.Varchar2,new_nls,DIRECTION.Input);
				SetParameters("kv",DB_TYPE.Decimal,kv,DIRECTION.Input);
				result[0] = Convert.ToString(SQL_SELECT_scalar("SELECT acc FROM accounts WHERE nls=:nls and kv=:kv"));
				result[1] = new_nls;  	
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
		}
		[WebMethod(EnableSession = true)]
		public string[] CheckAcc(string mfo,string nls,string kv)
		{
			string[] result = new string[2];
			result[0] = KeyAccount(mfo,nls)[0];
			if(kv != "")
			{
				try
				{
					InitOraConnection(Context);
					SetRole(base_role);
					SetParameters("kv",DB_TYPE.Decimal,kv,DIRECTION.Input);
					SetParameters("nls",DB_TYPE.Varchar2,nls,DIRECTION.Input);
					result[1] = SQL_SELECT_scalar("SELECT count(acc) FROM accounts WHERE kv=:kv AND nls=:nls").ToString();
				}
				finally
				{
					DisposeOraConnection();
				}
			}
			return result;
		}
		[WebMethod(EnableSession = true)]
		public string[] OpenAcc(string acc,string nls,string kv,string nms_new)
		{
			string[] result = new string[2];
			try
			{ 
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("acc",DB_TYPE.Decimal,acc,DIRECTION.Input);
				ArrayList reader = SQL_reader("SELECT u.rnk,a.isp,a.nms,a.grp FROM cust_acc u, accounts a WHERE a.acc=:acc AND a.acc=u.acc");
				string rnk = Convert.ToString(reader[0]);
				string isp = Convert.ToString(reader[1]);
				string nms = "Нач.%% "+Convert.ToString(reader[2]);
				if(nms_new != "") nms = nms_new;  
				string grp = Convert.ToString(reader[3]);
				ClearParameters();
				SetParameters("grp",DB_TYPE.Decimal,grp,DIRECTION.Input);
				SetParameters("rnk",DB_TYPE.Decimal,rnk,DIRECTION.Input);
				SetParameters("nls",DB_TYPE.Varchar2,nls,DIRECTION.Input);
				SetParameters("kv",DB_TYPE.Decimal,kv,DIRECTION.Input);
				SetParameters("nms",DB_TYPE.Varchar2,nms,DIRECTION.Input);
				SetParameters("isp",DB_TYPE.Decimal,isp,DIRECTION.Input);
				SetParameters("acc_",DB_TYPE.Decimal,"0",DIRECTION.Output);
				int iresult = SQL_NONQUERY("declare p4_ INTEGER;"+
					" begin "+
					" op_reg(99,0,0,:grp,p4_,:rnk,:nls,:kv,:nms,'ODB',:isp,:acc_); "+
					" end;");
				result[0] = iresult.ToString();
				result[1] = Convert.ToString(GetParameter("acc_"));
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
		}
		public void UpdatePercent(decimal acc,string[] data)
		{
			try
			{ 
				ClearParameters();
				SetRole(base_role);
				string Metr = data[0];
				string BaseM = data[1];  
				string BaseY = data[2];
				string Freq = data[3];
				object StpDat = null;
				if(data[4] != "") StpDat = Convert.ToDateTime(data[4],cinfo);
				object AcrDat = null;
				if(data[5] != "") AcrDat = Convert.ToDateTime(data[5],cinfo);
				object AplDat = null;
				if(data[6] != "") AplDat = Convert.ToDateTime(data[6],cinfo);
				string TT1 = data[7];
				string AcrA = data[8];
				string AcrB = data[9];
				string TT2 = data[10];
				string MFO = data[11];
				string KvC = data[12];	
				string NlsC = data[13];
				string NamC = data[14];	
				string Nazn = data[15];
				string Io = data[16];
				string nId = data[17];
				string query = "";
				SetParameters("nAcc",DB_TYPE.Decimal,acc,DIRECTION.Input);
				SetParameters("nId",DB_TYPE.Decimal,nId,DIRECTION.Input);
				decimal count = Convert.ToDecimal(SQL_SELECT_scalar("SELECT count(*) FROM int_accN WHERE acc=:nAcc AND id=:nId")); 
				if(count != 0)
					query  = "UPDATE Int_accN SET acc=:nAcc,id=:nId,metr=:nMetr,basem=:nBaseM,basey=:nBaseY,freq=:nFreq,stp_dat=:dStpDat,acr_dat=:dAcrDat,apl_dat=:dAplDat,tt=:sTT1,acra=:nAcrA,acrb=:nAcrB,ttb=:sTT2,mfob=:sMFO,kvb=:nKvC,nlsb=:sNlsC,namb=:sNamC,nazn=:sNazn,io=:nIo WHERE acc=:nAcc AND id=:nId";
				else 
					query  = "INSERT INTO Int_accN (acc,id,metr,basem,basey,freq,stp_dat,acr_dat,apl_dat,tt,acra,acrb,ttb,mfob,kvb,nlsb,namb,nazn,io) VALUES (:nAcc,:nId,:nMetr,:nBaseM,:nBaseY,:nFreq,:dStpDat,:dAcrDat,:dAplDat,:sTT1,:nAcrA,:nAcrB,:sTT2,:sMFO,:nKvC,:sNlsC,:sNamC,:sNazn,:nIo)";
				SetParameters("nMetr",DB_TYPE.Decimal,Metr,DIRECTION.Input);
				SetParameters("nBaseM",DB_TYPE.Decimal,BaseM,DIRECTION.Input);
				SetParameters("nBaseY",DB_TYPE.Decimal,BaseY,DIRECTION.Input);
				SetParameters("nFreq",DB_TYPE.Decimal,Freq,DIRECTION.Input);
				SetParameters("dStpDat",DB_TYPE.Date,StpDat,DIRECTION.Input);
				SetParameters("dAcrDat",DB_TYPE.Date,AcrDat,DIRECTION.Input);
				SetParameters("dAplDat",DB_TYPE.Date,AplDat,DIRECTION.Input);
				SetParameters("sTT1",DB_TYPE.Varchar2,TT1,DIRECTION.Input);
				SetParameters("nAcrA",DB_TYPE.Varchar2,AcrA,DIRECTION.Input);
				SetParameters("nAcrB",DB_TYPE.Varchar2,AcrB,DIRECTION.Input);
				SetParameters("sTT2",DB_TYPE.Varchar2,TT2,DIRECTION.Input);
				SetParameters("sMFO",DB_TYPE.Varchar2,MFO,DIRECTION.Input);
				SetParameters("nKvC",DB_TYPE.Decimal,KvC,DIRECTION.Input);
				SetParameters("sNlsC",DB_TYPE.Varchar2,NlsC,DIRECTION.Input);
				SetParameters("sNamC",DB_TYPE.Varchar2,NamC,DIRECTION.Input);
				SetParameters("sNazn",DB_TYPE.Varchar2,Nazn,DIRECTION.Input);
				SetParameters("nIo",DB_TYPE.Decimal,Io,DIRECTION.Input);
				SQL_NONQUERY(query);
			}
			finally{}
		}
		[WebMethod(EnableSession = true)]
		public string Save(decimal acc,string[] per,string[][] pertbl)
		{
			string result = "ok";
			try
			{
				InitOraConnection(Context);
				bool txCommited = false;
				BeginTransaction();
				try
				{
					if(per != null) UpdatePercent(acc,per);
					if(pertbl != null) UpdatePercentTbl(acc,pertbl);
					CommitTransaction();
					txCommited = true;
				}
				finally
				{
					if(!txCommited) RollbackTransaction();
				}
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
		}
		public void UpdatePercentTbl(decimal acc,string[][] data)
		{
			try
			{ 
				SetRole(base_role);
				for(int i = 0; i < data.Length - 1; i+=2)
				{
					ClearParameters();
					if(data[i+1].Length == 0) break;
					decimal op = 0;
					switch (data[i+1][2])
					{
						case "+" : op = 1;break; 
						case "-" : op = 2;break;
						case "*" : op = 3;break;
						case "/" : op = 4;break;
					}
					if(data[i+1][0].Substring(0,1) == "n")
					{
						SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
						SetParameters("id", DB_TYPE.Decimal, data[i+1][5], DIRECTION.Input);
						SetParameters("bdat", DB_TYPE.Date, Convert.ToDateTime(data[i+1][4],cinfo), DIRECTION.Input);
						SetParameters("ir", DB_TYPE.Decimal, data[i+1][1], DIRECTION.Input);
						string br = null;
						if(string.Empty != data[i+1][3])
							br = data[i+1][3];
						SetParameters("br", DB_TYPE.Varchar2, br, DIRECTION.Input);
						SetParameters("op", DB_TYPE.Decimal, op, DIRECTION.Input);
						SQL_NONQUERY("INSERT INTO Int_ratN (acc,id,bdat,ir,br,op)VALUES (:acc,:id,:bdat,:ir,:br,:op)");
					}
					else if(data[i+1][0].Substring(0,1) == "d")
					{
						SetParameters("bdat", DB_TYPE.Date, Convert.ToDateTime(data[i+1][4],cinfo), DIRECTION.Input);
						SetParameters("id", DB_TYPE.Decimal, data[i+1][5], DIRECTION.Input);
						SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
						SQL_NONQUERY("DELETE FROM int_ratN WHERE bdat=:bdat AND id=:id AND acc=:acc");
					}
					else 
					{
						SetParameters("ir", DB_TYPE.Decimal, data[i+1][1], DIRECTION.Input);
						string br = null;
						if(string.Empty != data[i+1][3])
							br = data[i+1][3];
						SetParameters("br", DB_TYPE.Varchar2, br, DIRECTION.Input);
						SetParameters("op", DB_TYPE.Decimal, op, DIRECTION.Input);
						SetParameters("id", DB_TYPE.Decimal, data[i+1][5], DIRECTION.Input);
						SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
						SetParameters("bdat", DB_TYPE.Date, Convert.ToDateTime(data[i+1][4],cinfo), DIRECTION.Input);
						SQL_NONQUERY("UPDATE Int_ratN SET ir=:ir,br=:br,op=:op WHERE id=:id AND acc=:acc AND bdat=:bdat");
					}
				}
			}
			finally{}
		}

		//Percent
		private object[] Percent(decimal acc,decimal id,decimal kv)
		{
			object[] result = new object[30];
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);

				result[0] = 0;
				result[1] = 0;
				result[2] = 0;
				SetParameters("kv",DB_TYPE.Decimal,kv,DIRECTION.Input);
				result[2] = SQL_SELECT_scalar("SELECT nvl(basey,0) FROM tabval WHERE kv=:kv");
				result[3] = 1;
				result[16] = 0;
					
				ClearParameters();
				SetParameters("acc",DB_TYPE.Decimal,acc,DIRECTION.Input);
				SetParameters("id",DB_TYPE.Decimal,id,DIRECTION.Input);

				ArrayList reader = SQL_reader(@"
					 SELECT metr,basem,basey,freq,stp_dat,acr_dat,apl_dat,tt,acrA,acrB,ttb,mfob,kvb,nlsb,namb,nazn,io 
					 FROM int_accn WHERE acc=:acc AND id=:id");
				if(reader.Count != 0)
				{
					if(Convert.ToString(reader[0]) == string.Empty) result[0] = 0;
					else result[0] = reader[0];//_Metr
					if(Convert.ToString(reader[1]) == string.Empty) result[1] = 0;
					else result[1] = reader[1];//_BaseM
					if(Convert.ToString(reader[2]) == string.Empty) result[2] = 0;
					else result[2] = reader[2];//_BaseY
					if(Convert.ToString(reader[3]) == string.Empty) result[3] = 1;
					else result[3] = reader[3];//_Freq
					if(Convert.ToString(reader[4]) == string.Empty) result[4] = null;
					else result[4] = Convert.ToDateTime(reader[4],cinfo).ToString("dd.MM.yyyy");//_StpDat
					if(Convert.ToString(reader[5]) == string.Empty) result[5] = null;
					else result[5] = Convert.ToDateTime(reader[5],cinfo).ToString("dd.MM.yyyy");//_AcrDat
					if(Convert.ToString(reader[6]) == string.Empty) result[6] = null;
					else result[6] = Convert.ToDateTime(reader[6],cinfo).ToString("dd.MM.yyyy");//_AplDat
					result[7] = reader[7];//_TT1
					result[8] = reader[8];//_AcrA
					result[9] = reader[9];//_AcrB
					result[10] = reader[10];//_TT2
					result[11] = reader[11];//_MFO
					result[12] = reader[12];//_KvC
					result[13] = reader[13];//_NlsC
					result[14] = reader[14];//_NamC
					result[15] = reader[15];//_Nazn
					if(Convert.ToString(reader[16]) == string.Empty) result[16] = 0;
					else result[16] = reader[16];//_Io
					if(Convert.ToString(result[8]) != string.Empty)
					{
						ClearParameters(); 
						SetParameters("acc",DB_TYPE.Decimal,result[8],DIRECTION.Input);
						reader = SQL_reader("SELECT nls,kv FROM accounts WHERE acc=:acc");
						result[17] = Convert.ToString(reader[0]); //NlsA
						result[18] = Convert.ToDecimal(reader[1]); //KvA
					}
					if(Convert.ToString(result[9]) != string.Empty)
					{
						ClearParameters(); 
						SetParameters("acc",DB_TYPE.Decimal,result[9],DIRECTION.Input); 
						reader = SQL_reader("SELECT nls,kv FROM accounts WHERE acc=:acc");
						result[19] = Convert.ToString(reader[0]); //NlsB
						result[20] = Convert.ToDecimal(reader[1]); //KvB
					
					}
				}
				//Mert
				if(Convert.ToString(result[0]) != string.Empty)
					result[21] = SQL_SELECT_scalar("SELECT name FROM int_metr WHERE metr="+result[0]);
				//BaseY
				if(Convert.ToString(result[2]) != string.Empty)
					result[22] = SQL_SELECT_scalar("SELECT name FROM basey WHERE basey="+result[2]);
				//Freq
				if(Convert.ToString(result[3]) != string.Empty)
					result[23] = SQL_SELECT_scalar("SELECT name FROM freq WHERE freq="+result[3]);
				result[24] = ""; 
				
			}
			finally
			{
				DisposeOraConnection(); 
			}
			return result;
		}
		
		[WebMethod(EnableSession = true)]
		public string getNlsA(string nbs,string mfo,string nls)
		{
			string result = string.Empty;
			try
			{ 
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("NBS",DB_TYPE.Varchar2,nbs,DIRECTION.Input);
				result = Convert.ToString(SQL_SELECT_scalar("SELECT nbsn FROM proc_dr WHERE nbs=:NBS and sour=4"));
				if(result != "")
					result = KeyAccount(mfo,result+"0"+nls.Substring(5,(nls.Length > 13)?(9):(nls.Length-5)))[0];
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
		}
		[WebMethod(EnableSession = true)]
		public string[] getNlsB(string acc)
		{
			string[] result = new string[2];
			try
			{ 
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("acc",DB_TYPE.Decimal,acc,DIRECTION.Input);
				string AcrB = ""; 
				try
				{
					AcrB = Convert.ToString(SQL_SELECT_scalar("SELECT f_proc_dr(:acc, 4, 0, '' ) FROM dual"));
				}
				catch{AcrB = "";}
				if(AcrB != "")
				{
					ArrayList reader = SQL_reader("SELECT nls,kv FROM accounts WHERE acc="+AcrB);
					result[0] = Convert.ToString(reader[0]);
					result[1] = Convert.ToString(reader[1]);
				}
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
		}

		//Рассчитать КР счета и подставить его обратно
		public string[] KeyAccount(string sMfo,string sAcc)
		{
			string []result = new string[6];
			try
			{
				sMfo = sMfo.Trim();
				sAcc = sAcc.Trim();
				if(sAcc.Length == 0) return result;
				try{Convert.ToUInt64(sAcc);}
				catch{return result;}
				if(sMfo.Length == 9)
				{
					sMfo = "00" + sMfo.Substring(6,3) + "0";
				}
				Hashtable tab =  GetAccountStructure();
				decimal nFormula = (decimal)tab["Align"];
				int KPos = (int)tab["KPos"];
				int BPos = (int)tab["BPos"];
				int BLen = (int)tab["BLen"];
				string sCtrlDigit = GetChecksumDigit(sMfo,sAcc,nFormula).ToString();
				string newAcc = string.Empty; 
				string newNbs = string.Empty; 
				if(nFormula == 1)
				{
					newAcc = sAcc.Substring(0,sAcc.Length-KPos) + sCtrlDigit + sAcc.Substring(KPos-1);
					string temp = newAcc.Insert(0,"000000000".Substring(0,BLen));
					newNbs = temp.Substring(temp.Length - BPos - 1).Substring(0,BLen);
					if(newAcc.Length < BPos)
						newAcc = newNbs + newAcc.Substring(newAcc.Length - BPos + BLen -1);
				}
				else 
				{
					if(sAcc.Length < KPos)
					{
						newAcc = sAcc + sCtrlDigit;
						if(newAcc.Length<BPos+BLen)
							newNbs = newAcc;
						else newNbs = newAcc.Substring(BPos-1,BLen);
					}
					else 
					{
						sAcc = sAcc.Remove(KPos-1,1);
						newAcc = sAcc.Insert(KPos-1,sCtrlDigit);
						newNbs = newAcc.Substring(BPos-1,BLen);
					}
				}
			
				ClearParameters();
				result[0] = newAcc;
				result[1] = newNbs;	
			return result;
			}
			finally
			{
				
			}
		}
		//Получить структуру счета
		public Hashtable GetAccountStructure()
		{
			Hashtable tab = new Hashtable();
			try
			{ 
				string acc_struct = "LBBBBK999999999";
				decimal bAlign = 0; //выравнивать слева FALSE или справа TRUE  
				int MLen = 0; //max длина счета
				int BPos = 0; //поз балансового счета
				int BLen = 0; //длина балансового счета
				int KPos = 0; //позиция контрольного разряда
				InitOraConnection(Context);
				SetRole("BASIC_INFO");
				string new_acc_struct = Convert.ToString(SQL_SELECT_scalar("SELECT VAL FROM PARAMS WHERE PAR='ACCSTRUC'"));
				if(new_acc_struct != "") acc_struct = new_acc_struct;
				bAlign = (acc_struct.Substring(0,1) == "R") ? (1):(0);
				MLen = acc_struct.Length - 1;
				BPos = acc_struct.IndexOf('B');
				KPos = acc_struct.IndexOf('K');
				BLen = acc_struct.LastIndexOf('B')-BPos + 1;
				if(bAlign == 1)
				{
					BPos = MLen + 1 - BPos;
					KPos = MLen + 1 - KPos;
				}
				tab["Align"] = bAlign;
				tab["MLen"] = MLen;
				tab["BPos"] = BPos;
				tab["BLen"] = BLen;
				tab["KPos"] = KPos;
			}
			finally
			{
				DisposeOraConnection();
			}
			return tab;
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
