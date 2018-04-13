using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Runtime.InteropServices;
using System.Web.Services;
using Bars.Web.Report;

namespace ViewAccounts
{
	public class AccService : Bars.BarsWebService
	{
		[DllImport("WINBARS2.DLL", EntryPoint = "GetChecksumDigit")]
		public static extern char GetChecksumDigit(string mfo, string acc, decimal formula);
		//Main role for application 
		private string base_role = "wr_viewacc";

		CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");

		public AccService()
		{
			cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
			cinfo.DateTimeFormat.DateSeparator = "/";
			InitializeComponent();
		}
		[WebMethod(EnableSession = true)]
		public string GetFileForPrint(string acc, string templateID)
		{
			string fileName = string.Empty;
			RtfReporter rep = new RtfReporter(Context);
			rep.RoleList = "reporter,cc_doc";
			rep.ContractNumber = Convert.ToInt64(acc);
			rep.TemplateID = templateID;
			rep.Generate();
			fileName = rep.ReportFile;

			return fileName;
		}
		[WebMethod(EnableSession = true)]
		public object[] GetSPTable(string[] data)
		{
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("spid_", DB_TYPE.Decimal, data[9], DIRECTION.Input);
				SetParameters("nbs_", DB_TYPE.Varchar2, data[10], DIRECTION.Input);
				SetParameters("ord_", DB_TYPE.Varchar2, data[3], DIRECTION.Input);
				int startpos = Convert.ToInt32(data[4]);
				int pageSize = Convert.ToInt32(data[5]);
				DataSet ds = SQL_PROC_REFCURSOR("get_sp_table", startpos, pageSize);
				int count = pageSize + startpos + 1;
				if (ds.Tables[0].Rows.Count < pageSize)
					count = ds.Tables[0].Rows.Count + startpos;
				return new object[] { ds.GetXml(), count };
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
		}

		[WebMethod(EnableSession = true)]
		public object[] Populate(decimal acc, string rnk)
		{
			object[] result = new object[63];
			object[] reader;
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				if (rnk == "")
				{
					SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
					rnk = SQL_SELECT_scalar("select rnk from cust_acc where acc=:acc").ToString();
				}
				ClearParameters();
				SetParameters("rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);
				//if(SQL_SELECT_scalar("select rnk from v_tobo_cust where rnk=:rnk") == null)
				//	throw new Exception("Нет прав на просмотр счета в даном отделении");
			    var customerParam = SQL_SELECT_reader(@"select 
                                                            nmk||'(РНК '||rnk||',НД '||nd||')' as nmk,
                                                            custtype,                                                        
                                                            sed
                                                        from 
                                                            customer 
                                                        where 
                                                            rnk=:rnk");
			    result[56] = customerParam[0].ToString();// SQL_SELECT_scalar("select nmk||'(РНК '||rnk||',НД '||nd||')' from customer where rnk=:rnk").ToString();
				ClearParameters();
				result[57] = SQL_SELECT_scalar("select fio from staff$base where id=user_id").ToString();
				reader = SQL_SELECT_reader("select TO_CHAR(bankdate,'dd/MM/yyyy'),user_id,tobopack.gettobo from dual");
				string bdate = Convert.ToString(reader[0], cinfo);
				result[54] = reader[1];
				result[58] = reader[2];

				result[59] = Convert.ToString(SQL_SELECT_scalar("select tabid from meta_tables where tabname = 'GROUPS_ACC'"));

				if (acc != 0)
				{
					SetParameters("p_acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
					object[] temp = SQL_SELECT_reader(@"
                                SELECT 
                                       a.nls, 
                                       a.kv, 
                                       a.nbs, 
                                       a.nlsalt, 
                                       a.nms,
                                       a.pap, 
                                       a.tip, 
                                       a.vid, 
                                       a.pos, 				 
                                       TO_CHAR(a.daos,'dd/MM/yyyy'), 
                                       TO_CHAR(a.dazs,'dd/MM/yyyy'),
                                       TO_CHAR(a.dapp,'dd/MM/yyyy'), 
                                       a.mdate, 
                                       a.blkd, 
                                       a.blkk, 					
                                       a.ostc, 
                                       a.dos, 
                                       a.kos,
                                       a.ostq,
                                       a.dosq, 
                                       a.kosq, 
                                       a.lim, 
                                       a.ostx, 					 
                                       a.isp, 
                                       a.grp, 
                                       a.seci, 
                                       a.seco,
                                       a.rnk,
                                       a.tobo,
                                       nvl(t.flag_edit,1) as flagEditTarif
                                FROM 
                                       Accounts a,
                                       accountsw w,
                                       tarif_scheme t
                                WHERE 
                                       a.acc=:p_acc
                                       and a.acc = w.acc(+)
                                       and w.tag(+) = 'SHTAR'
                                       and to_number(w.value) = t.id(+)");
					result[0] = temp[0]; // _Nls;
					result[1] = temp[1]; // _Kv;
					result[2] = temp[2]; // _Nbs;
					result[3] = temp[3]; // _NlsAlt;
					result[4] = temp[4]; // _Nms;
					result[5] = temp[5]; // _Pap;
					result[6] = temp[6]; // _Tip;
					result[7] = temp[7]; // _Vid;
					result[8] = temp[8]; // _Pos;
					if (temp[9] == null) result[9] = null;
					else result[9] = temp[9];// _Daos;
					if (temp[10] == null) result[10] = null;
					else result[10] = temp[10]; // _Dazg; 
					if (temp[11] == null) result[11] = null;
					else result[11] = temp[11]; // _Dapp;
					result[12] = temp[12]; // _MDate;
					result[13] = temp[13]; // _Blkd;
					result[14] = temp[14]; // _Blkk;
					result[15] = temp[15]; // _Ostc;
					result[16] = temp[16]; // _Dos;
					result[17] = temp[17]; // _Kos;
					result[18] = temp[18]; // _Ostq;
					result[19] = temp[19]; // _Dosq;
					result[20] = temp[20]; // _Kosq;
					result[21] = temp[21]; // _Lim;
					result[22] = temp[22]; // _Ostx;
					result[23] = temp[23]; // _Isp;
					result[24] = temp[24]; // _Grp;
					result[25] = temp[25]; // _Seci;
					result[26] = temp[26]; // _Seco;
					result[27] = temp[27]; // _Rnk;
					result[28] = temp[28]; // _Tobo;

					if (result[59] != null && Convert.ToString(result[59]) != string.Empty)
					{
						SQL_Reader_Exec("SELECT g.id, g.name FROM groups_acc g, table(sec.getAgrp(:acc)) b WHERE g.id=b.column_value");
						while (SQL_Reader_Read())
						{
							result[60] += SQL_Reader_GetValues()[0] + " " + SQL_Reader_GetValues()[1] + "##";
						}
						SQL_Reader_Close();
					}
                    //признак можливості редагування тарифів
                    result[61] = temp[29]; //признак доступності редагу4вання тарифів
                    result[62] = (new Bars.Configuration.Module_Accounts().DisableEditBlkType 
                        && (Convert.ToString(customerParam[1]) == "2" 
                        || Convert.ToString(customerParam[2]).Trim() == "91")) ? "0" : "1"; //признак можливості редагування параметррів блокування по Д/К
				}
				if (acc == 0)
				{
					result[0] = "";
					result[1] = SQL_SELECT_scalar("SELECT VAL FROM PARAMS WHERE PAR='BASEVAL'");
					result[2] = null;
					result[5] = 0;
					result[6] = "ODB";
					result[7] = 0;
					result[8] = 1;
					result[9] = bdate;
					result[10] = null;
					result[13] = 0;
					result[14] = 0;
					result[28] = result[58];
					result[33] = "";
				}
				if (result[2] != null)
				{
					ClearParameters();
					SetParameters("NBS", DB_TYPE.Varchar2, result[2], DIRECTION.Input);
					object[] temp0 = SQL_SELECT_reader(@"
														SELECT name, xar, pap 
														FROM Ps 
														WHERE d_close is null AND nbs=:NBS");
					result[29] = temp0[0]; // NameNbs;
					result[30] = temp0[1]; // _Xar;
					result[31] = temp0[2]; // _PapPs;
				}
				if (result[1] != null)
				{
					ClearParameters();
					SetParameters("KV", DB_TYPE.Decimal, result[1], DIRECTION.Input);
					reader = SQL_SELECT_reader(@"
					SELECT dig,lcv
					FROM tabval 
					WHERE kv=:KV");
					result[32] = reader[0]; // nDig;
					result[33] = reader[1]; // _Lcv;
				}
				ClearParameters();
				SetParameters("ACC", DB_TYPE.Decimal, acc, DIRECTION.Input);
				result[34] = SQL_SELECT_scalar("SELECT mfo FROM Bank_acc WHERE acc=:ACC"); // _ProcMfo;
				if (result[34] == null) result[34] = "";
				result[55] = result[34];
				if (result[30] != null)
				{
					ClearParameters();
					SetParameters("xar", DB_TYPE.Decimal, result[30], DIRECTION.Input);
					result[35] = SQL_SELECT_scalar("SELECT name FROM Xar WHERE xar=:xar");// _XarStr;
				}
				if (Convert.ToDecimal(result[5]) == 1 && Convert.ToDecimal(result[21]) >= 0) result[36] = 0; //nId
				else if (Convert.ToDecimal(result[5]) == 2 && Convert.ToDecimal(result[21]) <= 0) result[36] = 1;
				else if (Convert.ToDecimal(result[21]) > 0) result[36] = 0;
				else result[36] = 1;
				result[37] = bdate;
				//---------------DDLists
				//Valuta
				if (result[1] != null)
					result[38] = SQL_SELECT_scalar("SELECT (kv || ' ' || name ) name_  FROM tabval WHERE d_close is null AND kv=" + result[1]);
				//Users
				if (result[23] != null)
					result[39] = SQL_SELECT_scalar("SELECT fio FROM staff WHERE type=1 AND id=" + result[23]);
				//Pap
				if (result[5] != null)
					result[40] = SQL_SELECT_scalar("SELECT name FROM pap WHERE pap=" + result[5]);
				//Tip
				if (result[6] != null)
					result[41] = SQL_SELECT_scalar("SELECT name FROM tips WHERE tip='" + result[6] + "'");
				//Pos
				if (result[8] != null)
					result[42] = SQL_SELECT_scalar("SELECT name FROM pos WHERE pos=" + result[8]);
				//Vid
				if (result[7] != null)
					result[43] = SQL_SELECT_scalar("SELECT name FROM vids WHERE vid=" + result[7]);
				//VidBlkD
				if (result[13] != null)
					result[44] = SQL_SELECT_scalar("SELECT name FROM rang WHERE rang=" + result[13]);
				//VidBlkK
				if (result[14] != null)
					result[45] = SQL_SELECT_scalar("SELECT name FROM rang WHERE rang=" + result[14]);
				//Mfo
				if (result[34] != null)
					result[46] = SQL_SELECT_scalar("SELECT nb FROM banks WHERE kodn is not null and (blk=0 or blk=9 or blk=null) AND mfo='" + result[34] + "'");
				//Tobo
				if (result[28] != null)
					result[47] = SQL_SELECT_scalar("SELECT name FROM tobo WHERE tobo='" + result[28] + "'");
				//Groups
				if (result[24] != null)
					result[50] = SQL_SELECT_scalar("SELECT (id || ' ' || name ) name_ FROM groups WHERE id=" + result[24]);

				result[48] = SQL_SELECT_scalar("SELECT VAL FROM PARAMS WHERE PAR='HAVETOBO'");
				result[49] = SQL_SELECT_scalar("SELECT VAL FROM PARAMS WHERE PAR='EQV'");
				result[51] = SQL_SELECT_scalar("SELECT VAL FROM PARAMS WHERE PAR='MFO'");
				result[52] = SQL_SELECT_scalar("SELECT VAL FROM PARAMS WHERE PAR='IO%'");
				result[53] = SQL_SELECT_scalar("SELECT VAL FROM PARAMS WHERE PAR='BASEVAL'");
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
		}

        public class SPCodes
        {
            public string Code;
            public string Name;
        }

		[WebMethod(EnableSession = true)]
		public string[] GetSPCodes(string nbs, string acc)
		{
            string[] result = new string[2];
            ArrayList reader;
            List<SPCodes> codesList = new List<SPCodes>();
            List<SPReq> reqParamsList = new List<SPReq>();
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
			try
			{
				InitOraConnection();
				SetRole(base_role);
				SetParameters("nbs", DB_TYPE.Varchar2, nbs, DIRECTION.Input);
                SQL_Reader_Exec("select unique code, code_name, code_ord from v_ps_sparam where nbs=:nbs order by code_ord");
                while (SQL_Reader_Read())
                {
                    reader = SQL_Reader_GetValues();
                    SPCodes sc = new SPCodes();
                    sc.Code = Convert.ToString(reader[0]);
                    sc.Name = Convert.ToString(reader[1]);
                    codesList.Add(sc);
                }
				SQL_Reader_Close();

				Bars.Configuration.ModuleSettings ms = new Bars.Configuration.ModuleSettings();
				if (ms.Accounts.EnhanceCheck)
				{
					string paramsList = string.Empty;
					if ("2600,2560,2570,2602,2605,2650".Contains(nbs))
						paramsList = "('S260','R011','R012')";

                    if ("2604".Contains(nbs))
                        paramsList = "('S260','R012')";

                    if ("2062, 2063, 2067, 2071, 2072, 2073, 2074,  2077, 2082, 2083, 2089".Contains(nbs))
                        paramsList = "('S182','S031','DEB02','S080','DEB03','MDATE','S180','S260','S270','DEB04','K072','OB22','S090','R012','D020','K150','NKD','DEB06')";

                    if ("2068,2069,2078,2079,2088,2089,2607".Contains(nbs))
                        paramsList = "('S182','R011','R013','S031','DEB02','S080','DEB03','MDATE','S180','S260','S270','DEB04','K072','OB22','S090','R012','NKD','DEB06')";

                    if ("9129,9500,9520,9521,9523,9531".Contains(nbs))
                        paramsList = "('DEB06','R013','S182','S031','DEB02','S080','DEB03','MDATE','S180','S260','DEB06','OB22','S090','R012')";

                    if ("3570,3578".Contains(nbs))
                        paramsList = "('R013','S180')";

                    string query = string.Empty;
					if (!string.IsNullOrEmpty(paramsList))
					{
                        ClearParameters();
                        SetParameters("nbs", DB_TYPE.Varchar2, nbs, DIRECTION.Input);
                        int count = Convert.ToInt32(SQL_SELECT_scalar("SELECT count(*) from ps_sparam where nbs=:nbs").ToString());
                        if (count > 0)
                        {
                            ClearParameters();
                            SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
                            SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
                            SetParameters("nbs", DB_TYPE.Varchar2, nbs, DIRECTION.Input);
                            query = "select s.spid, s.name, s.semantic, decode(:acc, '0', null,f_read_sp(s.spid,:acc)) from sparam_list s, ps_sparam p where s.spid=p.spid and s.inuse = 1 and p.nbs=:nbs and (opt=1 or s.name in " + paramsList + " )";
                        }
                        else
                        {
                            ClearParameters();
                            SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
                            SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
                            query = "select s.spid, s.name, s.semantic, decode(:acc, '0', null,f_read_sp(s.spid,:acc)) from sparam_list s where s.inuse = 1 and s.name in " + paramsList;
                        }
						SQL_Reader_Exec(query);
						while (SQL_Reader_Read())
						{
							SPReq spr = new SPReq();
							reader = SQL_Reader_GetValues();
							spr.Id = Convert.ToString(reader[0]);
							spr.Name = Convert.ToString(reader[1]);
							spr.Desc = Convert.ToString(reader[2]);
							spr.Val = Convert.ToString(reader[3]);
							reqParamsList.Add(spr);
						}
						SQL_Reader_Close();
					}
				}

                result[0] = serializer.Serialize(codesList);
                result[1] = serializer.Serialize(reqParamsList);
				return result;
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
		}

		//Load SParams
		[WebMethod(EnableSession = true)]
		public object[] GetSParams(string[] data)
		{
			object[] obj = new object[3];
			DataSet ds = new DataSet();
			int count = 0;
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				string Nbs = data[9];
				string acc = data[10];
				string isNewAcc = data[11];
				string code = data[12];
				string order = data[3];
				int startpos = Convert.ToInt32(data[4]);
				int pageSize = Convert.ToInt32(data[5]);
				if (!string.IsNullOrEmpty(Nbs))
				{
					SetParameters("nbs", DB_TYPE.Varchar2, Nbs, DIRECTION.Input);
					count = Convert.ToInt32(SQL_SELECT_scalar("SELECT count(*) from ps_sparam where nbs=:nbs").ToString());
					ClearParameters();
				}
				if (count != 0)
				{
					SetParameters("nbs", DB_TYPE.Varchar2, Nbs, DIRECTION.Input);
					SetParameters("code", DB_TYPE.Varchar2, code, DIRECTION.Input);
					ds = SQL_SELECT_dataset(@"SELECT DISTINCT l.spid, l.name PName, l.semantic PSem, upper(l.tabname) PTab, upper(rtrim(l.type)) PType, upper(l.nsiname) PNSI, upper(l.pkname) PNamePK,'' Value,'' HREF,s.opt Opt,s.sqlval,upper(l.nsisqlwhere) NsiSql, l.sqlcondition, l.tag, l.tabcolumn_check
										   FROM sparam_list l, ps_sparam s, ps p
										   WHERE p.nbs=s.nbs AND s.spid=l.spid AND l.inuse = 1 AND p.nbs=:nbs and l.code=:code order by " + order);
				}
				else
				{
					SetParameters("code", DB_TYPE.Varchar2, code, DIRECTION.Input);
					ds = SQL_SELECT_dataset(@"SELECT spid, name PName, semantic PSem, upper(tabname) PTab, upper(rtrim(type)) PType, upper(nsiname) PNSI, upper(pkname) PNamePK,'' Value,'' HREF,'' Opt, '' SqlVal,nsisqlwhere NsiSql, sqlcondition, tag, tabcolumn_check 
											FROM sparam_list WHERE inuse = 1 and code=:code order by " + order);
				}

				DataRow row = null;
				
				{
					for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
					{
						row = ds.Tables[0].Rows[i];
						string result = "";
						string sqlCondition = Convert.ToString(row["SQLCONDITION"]);
						if (!string.IsNullOrEmpty(sqlCondition))
						{
							ClearParameters();
							SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
							int count2 = Convert.ToInt32(SQL_SELECT_scalar("SELECT count(*) FROM accounts a WHERE a.acc=:acc AND (" + sqlCondition + ")"));
							if (count2 == 0)
							{
								row.BeginEdit();
								ds.Tables[0].Rows.Remove(row);
								continue;
							}
						}
                        if (acc != "0")
                        {
                            ClearParameters();
                            SetParameters("spid", DB_TYPE.Decimal, row["spid"].ToString(), DIRECTION.Input);
                            SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
                            result = Convert.ToString(SQL_SELECT_scalar("select f_read_sp(:spid,:acc) from dual"));
                            row["Value"] = result;
                        }
                        else
                            result = string.Empty;
						
						if (row["PNSI"].ToString() != "")
						{
                            row["HREF"] = "<a href=\"javascript:fnShowDic('" + row["PNSI"] + "','" + row["PNamePK"] + "','" + Convert.ToString(row["NsiSql"]).Replace("'", "__prime__") + "')\">Справочник</a>";
						}
						if (isNewAcc == "1" && result == "" && row["Opt"].ToString() == "1" && row["SqlVal"].ToString() != "")
						{
							row["Value"] = Convert.ToString(SQL_SELECT_scalar(row["SqlVal"].ToString()));
						}
					}
					ds.Tables[0].AcceptChanges();
				}
				obj[0] = ds.GetXml();
				obj[1] = 0;
				obj[2] = null;
				
				return obj;
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
		}

		public class SPReq
		{
			public string Id;
			public string Name;
			public string Desc;
			public string Val;
		}

		[WebMethod(EnableSession = true)]
		public string CheckSPDic(string val, string spid, string nbs)
		{
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("nbs", DB_TYPE.Varchar2, nbs, DIRECTION.Input);
				SetParameters("spid", DB_TYPE.Varchar2, spid, DIRECTION.Input);
				SetParameters("val", DB_TYPE.Varchar2, val, DIRECTION.Input);
				return Convert.ToString(SQL_SELECT_scalar("select f_check_sp(:nbs,:spid,:val) from dual"));
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
		}

		[WebMethod(EnableSession = true)]
		public object[] ListValuts(string[] data)
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
				count = Convert.ToInt32(SQL_SELECT_scalar("SELECT COUNT(kv) FROM tabval").ToString());
				ds = SQL_SELECT_dataset("SELECT KV, LCV, trim(name) NAME, '' PR FROM Tabval order by " + order, startpos, pageSize);
				obj[0] = ds.GetXml();
				obj[1] = count;
				return obj;
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
		}
		[WebMethod(EnableSession = true)]
		public object[] ListNbs(string[] data, decimal? rnk)
		{
			object[] obj = new object[2];
			DataSet ds = new DataSet();
			int count = 0;
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				string sA = data[0];
				string sB = data[1];
				string length = data[2];
				string order = data[3];
				int startpos = Convert.ToInt32(data[4]);
				int pageSize = Convert.ToInt32(data[5]);
                SetParameters("p_rnk", DB_TYPE.Decimal, data[10], DIRECTION.Input);
				ds = SQL_SELECT_dataset(@"SELECT distinct trim(p.nbs) NBS, 
                                                 p.name NAME, 
                                                 p.xar 
                                          FROM PS p,
                                               nbs_k014 k014,
                                               customer c 
                                          WHERE length(trim(p.nbs))=" + length + @" 
                                                AND trim(p.nbs) BETWEEN '" + sA + @"' AND '" + sB + @"'
                                                and trim(p.nbs) like rpad(trim(substr(k014.nbs,1,"+length+@")),"+length+@",'_')
                                                --and trim(p.nbs) like rpad(trim(k014.nbs),4,'_') 
                                                and K014.K014 = decode(c.okpo,f_ourokpo,5,decode(c.custtype,1,4,2,1,decode(nvl(trim(c.sed),'00'),'91',2,3)))  
                                                and c.rnk=:p_rnk 
                                                and (d_close is null or d_close>=bankdate) 
                                          ORDER BY " + order, 
                                        startpos, pageSize);
				obj[0] = ds.GetXml();
				obj[1] = count;
				return obj;
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
		}
		[WebMethod(EnableSession = true)]
		public string[] getNbs(string id, decimal? rnk)
		{
			string[] result = new string[4];
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("p_nbs", DB_TYPE.Varchar2, id.Trim(), DIRECTION.Input);
				SetParameters("p_rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);
				object[] temp = SQL_SELECT_reader(@"SELECT 
                                                            s.name,
                                                            x.name,
                                                            s.pap,
                                                            p.name 
                                                    FROM 
                                                            PS s,
                                                            pap p,
                                                            xar x,
                                                            nbs_k014 k014,
                                                            customer c  
                                                    WHERE 
                                                            TRIM(s.nbs)=:p_nbs
                                                            and trim(s.nbs) like rpad(trim(k014.nbs),4,'_') 
                                                            and K014.K014 = decode(c.okpo,f_ourokpo,5,decode(c.custtype,1,4,2,1,decode(nvl(trim(c.sed),'00'),'91',2,3)))  
                                                            and c.rnk=:p_rnk 
                                                            AND s.xar=x.xar
                                                            AND s.pap=p.pap 
                                                            and (d_close is null 
                                                                    or d_close>=bankdate)");
				result[0] = Convert.ToString(temp[0]);
				result[1] = Convert.ToString(temp[1]);
				result[2] = Convert.ToString(temp[2]);
				result[3] = Convert.ToString(temp[3]);
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
		}
		[WebMethod(EnableSession = true)]
		public string getProf(string nbs)
		{
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("nbs", DB_TYPE.Varchar2, nbs, DIRECTION.Input);
				return SQL_SELECT_list("SELECT UNIQUE np from nbs_prof where nbs=2630");
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
		}
		[WebMethod(EnableSession = true)]
		public string[] setProf(string nbs, string np)
		{
			string[] result = new string[10];
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("nbs", DB_TYPE.Varchar2, "2630", DIRECTION.Input);
				SetParameters("np", DB_TYPE.Varchar2, np, DIRECTION.Input);
				result[0] = Convert.ToString(SQL_SELECT_scalar("SELECT val FROM nbs_prof WHERE nbs=:nbs AND np=:np AND tag='RATI'"));
				result[1] = Convert.ToString(SQL_SELECT_scalar("SELECT val FROM nbs_prof WHERE nbs=:nbs AND np=:np AND tag='RATB'"));
				result[2] = Convert.ToString(SQL_SELECT_scalar("SELECT name FROM brates WHERE br_id='" + result[1] + "'"));
				result[3] = Convert.ToString(SQL_SELECT_scalar("SELECT val FROM nbs_prof WHERE nbs=:nbs AND np=:np AND tag='METR'"));
				result[4] = Convert.ToString(SQL_SELECT_scalar("SELECT val FROM nbs_prof WHERE nbs=:nbs AND np=:np AND tag='BASEY'"));
				result[5] = Convert.ToString(SQL_SELECT_scalar("SELECT val FROM nbs_prof WHERE nbs=:nbs AND np=:np AND tag='FREQ'"));
				result[6] = Convert.ToString(SQL_SELECT_scalar("SELECT val FROM nbs_prof WHERE nbs=:nbs AND np=:np AND tag='IO'"));
				if (result[3] != "")
					result[7] = Convert.ToString(SQL_SELECT_scalar("SELECT name FROM int_metr WHERE metr=" + result[3]));
				if (result[4] != "")
					result[8] = Convert.ToString(SQL_SELECT_scalar("SELECT name FROM basey WHERE basey=" + result[4]));
				if (result[5] != "")
					result[9] = Convert.ToString(SQL_SELECT_scalar("SELECT name FROM freq WHERE freq=" + result[5]));
				return result;
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
		}
		[WebMethod(EnableSession = true)]
		public string[] AccMask(string nbs, string tip, string rnk, string mfo)
		{
			string[] result = new string[2];
			if (nbs.Length == 0) return result;
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("TIP", DB_TYPE.Varchar2, tip, DIRECTION.Input);
				SetParameters("NBS", DB_TYPE.Varchar2, nbs, DIRECTION.Input);
				SetParameters("RNK", DB_TYPE.Varchar2, rnk, DIRECTION.Input);
				object[] temp = SQL_SELECT_reader("SELECT f_newnls2(null,:TIP,:NBS,:RNK,null),substr(f_newnms(null,:TIP,:NBS,:RNK,null),1,70) FROM dual");
				result[0] = KeyAccount(mfo, Convert.ToString(temp[0]))[0]; ;
				result[1] = Convert.ToString(temp[1]);
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
		}
		[WebMethod(EnableSession = true)]
		public string[] GetKeyAccount(string mfo, string nls)
		{
			return KeyAccount(mfo, nls);
		}
		[WebMethod(EnableSession = true)]
		public string[] CheckAcc(string mfo, string nls, string kv)
		{
			string[] result = new string[2];
			result[0] = KeyAccount(mfo, nls)[0];
			if (kv != "")
			{
				try
				{
					InitOraConnection(Context);
					SetRole(base_role);
					SetParameters("kv", DB_TYPE.Decimal, kv, DIRECTION.Input);
					SetParameters("nls", DB_TYPE.Varchar2, nls, DIRECTION.Input);
					result[1] = SQL_SELECT_scalar("SELECT count(acc) FROM accounts WHERE kv=:kv AND nls=:nls").ToString();
				}
				catch (System.Exception ex)
				{
					SaveExeption(ex);
					throw ex;
				}
				finally
				{
					DisposeOraConnection();
				}
			}
			return result;
		}
		[WebMethod(EnableSession = true)]
		public string getKvFromLcv(string lcv)
		{
			string result = string.Empty;
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("LCV", DB_TYPE.Varchar2, lcv.ToUpper(), DIRECTION.Input);
				result = Convert.ToString(SQL_SELECT_scalar("SELECT (kv || ' ' || name ) name_ FROM tabval WHERE d_close is null and lcv=:LCV"));
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
		}
		[WebMethod(EnableSession = true)]
		public string getFioFromId(string id)
		{
			string result = string.Empty;
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("ID", DB_TYPE.Decimal, id, DIRECTION.Input);
				result = Convert.ToString(SQL_SELECT_scalar("SELECT fio FROM staff WHERE type=1 AND id=:ID"));
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
		}
		[WebMethod(EnableSession = true)]
		public string getMfo(string id)
		{
			string result = string.Empty;
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("ID", DB_TYPE.Decimal, id, DIRECTION.Input);
				result = Convert.ToString(SQL_SELECT_scalar("SELECT nb FROM banks WHERE kodn is not null and (blk=0 or blk=9 or blk=null) AND mfo=:ID"));
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
		}
		[WebMethod(EnableSession = true)]
		public string getTobo(string id)
		{
			string result = string.Empty;
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("ID", DB_TYPE.Varchar2, id, DIRECTION.Input);
				result = Convert.ToString(SQL_SELECT_scalar("SELECT name FROM tobo WHERE tobo=:ID and tobo <> '0'"));
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
		}
		[WebMethod(EnableSession = true)]
		public object[] Percent_Button(decimal acc, decimal id, bool copy)
		{
			if (copy) id -= 2;
			return Percent(acc, id);
		}
		[WebMethod(EnableSession = true)]
		public string Save(decimal acc, string[] CodValutes, string[] gen, string[] sp, string[] per, string[][] pertbl, string[][] rates, string[][] sob)
		{
			string result = "ok";
			try
			{
				InitOraConnection(Context);
				bool txCommited = false;
				BeginTransaction();
				try
				{
					if (CodValutes != null)
					{
						string old_kv = gen[6];
						for (int i = 0; i < CodValutes.Length; i++)
						{
							gen[6] = CodValutes[i];
							gen[23] = gen[23] + gen[25];
							UpdateAccount(gen, acc);
						}
						gen[6] = old_kv;
					}
					if (gen != null) result = UpdateAccount(gen, acc);
					if (sp != null) UpdateSP(acc, sp, result);
                    if (per != null) UpdatePercent(acc, per, result);
                    if (pertbl != null) UpdatePercentTbl(acc, pertbl, result);
					if (rates != null) UpdateRates(acc, rates);
					if (sob != null) UpdateSob(acc, sob);
					CommitTransaction();
					txCommited = true;
				}
				finally
				{
					if (!txCommited) RollbackTransaction();
				}
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
		}
		[WebMethod(EnableSession = true)]
		public object[] PercentTable(string[] data)
		{
			object[] obj = new object[2];
			DataSet ds = new DataSet();
			int count = 0;
            if (data[9] == "0") data[9] = "-1";
		    if (string.IsNullOrEmpty(data[10])) data[10] = "1";
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				string order = data[3];
				int startpos = Convert.ToInt32(data[4]);
				int pageSize = Convert.ToInt32(data[5]);
				SetParameters("acc", DB_TYPE.Decimal, data[9], DIRECTION.Input);
				SetParameters("id", DB_TYPE.Decimal, data[10], DIRECTION.Input);
				ds = SQL_SELECT_dataset(@"SELECT rownum ID,TO_CHAR(i.bdat,'DD/MM/YYYY') BDAT,i.ir IR,DECODE(i.op,'0','','1','+','2','-','3','*','4','/') OP,b.name NAME,i.br BR
										  FROM int_ratN i, brates b
										  WHERE i.acc=:acc AND i.id=:id AND i.br=b.br_id (+) ORDER BY " + order, startpos, pageSize);
				obj[0] = ds.GetXml();
				obj[1] = count;
				return obj;
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
		}
		[WebMethod(EnableSession = true)]
		public string getNlsA(string nbs, string mfo, string nls)
		{
			string result = string.Empty;
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("NBS", DB_TYPE.Varchar2, nbs, DIRECTION.Input);
				result = Convert.ToString(SQL_SELECT_scalar("SELECT nbsn FROM proc_dr WHERE nbs=:NBS and sour=4"));
				if (result != "")
					result = KeyAccount(mfo, result + "0" + nls.Substring(5, (nls.Length > 13) ? (9) : (nls.Length - 5)))[0];
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
		}
		[WebMethod(EnableSession = true)]
		public string[] ValidNls(string mfo, string nls, string kv)
		{
			string[] result = new string[2];
			try
			{
				string new_nls = KeyAccount(mfo, nls)[0];
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("nls", DB_TYPE.Varchar2, new_nls, DIRECTION.Input);
				SetParameters("kv", DB_TYPE.Decimal, kv, DIRECTION.Input);
				result[0] = Convert.ToString(SQL_SELECT_scalar("SELECT acc FROM accounts WHERE nls=:nls and kv=:kv"));
				result[1] = new_nls;
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
		}
		[WebMethod(EnableSession = true)]
		public string[] OpenAcc(string acc, string nls, string kv, string nms_new)
		{
			string[] result = new string[2];
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
				object[] reader = SQL_SELECT_reader("SELECT u.rnk,a.isp,a.nms,a.grp FROM cust_acc u, accounts a WHERE a.acc=:acc AND a.acc=u.acc");
				string rnk = Convert.ToString(reader[0]);
				string isp = Convert.ToString(reader[1]);
				string nms = "Нач.%% " + Convert.ToString(reader[2]);
				if (nms_new != "") nms = nms_new;
				string grp = Convert.ToString(reader[3]);
				ClearParameters();
				SetParameters("grp", DB_TYPE.Varchar2, grp, DIRECTION.Input);
				SetParameters("rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);
				SetParameters("nls", DB_TYPE.Varchar2, nls, DIRECTION.Input);
				SetParameters("kv", DB_TYPE.Decimal, kv, DIRECTION.Input);
				SetParameters("nms", DB_TYPE.Varchar2, nms, DIRECTION.Input);
				SetParameters("isp", DB_TYPE.Decimal, isp, DIRECTION.Input);
				SetParameters("acc_", DB_TYPE.Decimal, "0", DIRECTION.Output);
				int iresult = SQL_NONQUERY("declare p4_ INTEGER;" +
											" begin " +
											" op_reg(99,0,0,:grp,p4_,:rnk,:nls,:kv,:nms,'ODB',:isp,:acc_); " +
											" end;");
				result[0] = iresult.ToString();
				result[1] = Convert.ToString(GetParameter("acc_"));
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
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
				SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
				string AcrB = "";
				try
				{
					AcrB = Convert.ToString(SQL_SELECT_scalar("SELECT f_proc_dr(:acc, 4, 0, '' ) FROM dual"));
				}
				catch { AcrB = ""; }
				if (AcrB != "")
				{
					object[] reader = SQL_SELECT_reader("SELECT nls,kv FROM accounts WHERE acc=" + AcrB);
					result[0] = Convert.ToString(reader[0]);
					result[1] = Convert.ToString(reader[1]);
				}
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
		}
		//Rates
		[WebMethod(EnableSession = true)]
		public object[] GetRates(string[] data)
		{
			object[] obj = new object[3];
			DataSet ds = new DataSet();
			DataSet ds_list = new DataSet();
			int count = 0;
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				string order = data[3];
				string acc = data[0];
				int startpos = Convert.ToInt32(data[4]);
				int pageSize = Convert.ToInt32(data[5]);
				int tarifSchemeId = 0;
				string tarifSchemeName = string.Empty;

				// определяем есть ли схема тарифов на базе
				int isTarifScheme = Convert.ToInt32(SQL_SELECT_scalar("SELECT count(*) FROM ALL_OBJECTS WHERE OBJECT_NAME = 'TARIF_SCHEME' and OBJECT_TYPE = 'TABLE'"));
				SetParameters("p_acc", DB_TYPE.Decimal, acc, DIRECTION.Input);

				if (isTarifScheme > 0)
				{
					ArrayList reader = SQL_reader(@"select 
                                                        t.id, 
                                                        t.name
							                        from 
                                                        tarif_scheme t, 
                                                        accountsw w
							                        where 
                                                        w.acc = :nAcc 
                                                        and w.tag = 'SHTAR' 
                                                        and trim(w.value) = to_char(t.id)");
					if (reader.Count > 0)
					{
						tarifSchemeId = Convert.ToInt32(reader[0]);
						tarifSchemeName = Convert.ToString(reader[1]);
					}

					ds_list = SQL_SELECT_dataset(@"SELECT 
                                                        a.kod kod, 
                                                        a.tar tar, 
                                                        a.pr pr, 
                                                        a.smin smin, 
                                                        a.smax smax, 
                                                        TO_CHAR(a.bdate,'DD/MM/YYYY') bdat, 
                                                        TO_CHAR(a.edate,'DD/MM/YYYY') edat,
                                                        a.kv_smin kv_smin,
                                                        a.kv_smax kv_smax 
											        FROM 
                                                        v_acc_tarif a
											        WHERE 
                                                        a.acc=:p_acc");
					ClearParameters();
					count = Convert.ToInt32(SQL_SELECT_scalar("SELECT count(*) from tarif"));
					SetParameters("tarifSchemeId", DB_TYPE.Decimal, tarifSchemeId, DIRECTION.Input);
					ds = SQL_SELECT_dataset(@"SELECT 
                                                a.kod kod,
                                                a.name name, 
                                                b.lcv lcv,
                                                a.smin smin,
                                                a.tar tar,
                                                a.pr pr,
                                                a.smax smax, 
                                                '' bdat, 
                                                '' edat,
                                                a.kv_smin kv_smin,
                                                a.kv_smax kv_smax
										    FROM 
                                                v_sh_tarif a, 
                                                tabval b
										    WHERE 
                                                a.kv=b.kv 
                                                and a.id=:tarifSchemeId 
                                            ORDER BY " + order, startpos, pageSize);
				}
				else
				{
					ds_list = SQL_SELECT_dataset(@"SELECT
                                                    b.kod kod, 
                                                    a.tar tar, 
                                                    a.pr pr, 
                                                    a.smin smin,
                                                    a.smax smax,
                                                    TO_CHAR(a.bdate,'DD/MM/YYYY') bdat,
                                                    TO_CHAR(a.edate,'DD/MM/YYYY') edat,
                                                    a.kv_smin kv_smin,
                                                    a.kv_smax kv_smax
											    FROM 
                                                    acc_tarif a, 
                                                    tarif b 
											    WHERE 
                                                    a.kod(+)=b.kod 
                                                    AND a.acc(+)=:p_acc");
					ClearParameters();
					count = Convert.ToInt32(SQL_SELECT_scalar("SELECT count(*) from tarif"));

					ds = SQL_SELECT_dataset(@"SELECT 
                                                a.kod kod, 
                                                a.name name,
                                                b.lcv lcv, 
                                                a.smin smin, 
                                                a.tar tar,
                                                a.pr pr,
                                                a.smax smax, 
                                                '' bdat, 
                                                '' edat,
                                                a.kv_smin kv_smin,
                                                a.kv_smax kv_smax
										    FROM 
                                                tarif a, 
                                                tabval b
										    WHERE 
                                                a.kv=b.kv 
                                            ORDER BY " + order, startpos, pageSize);
				}
				DataRow row = null;
				DataRow row_list = null;
				for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
				{
					row = ds.Tables[0].Rows[i];
					row_list = ds_list.Tables[0].Select("kod=" + row["kod"])[0];
					if (row_list["tar"].ToString() != "") row["tar"] = row_list["tar"];
					if (row_list["pr"].ToString() != "") row["pr"] = row_list["pr"];
					if (row_list["smin"].ToString() != "") row["smin"] = row_list["smin"];
					if (row_list["smax"].ToString() != "") row["smax"] = row_list["smax"];

					if (row_list["kv_smin"].ToString() != "") row["kv_smin"] = row_list["kv_smin"];
					if (row_list["kv_smax"].ToString() != "") row["kv_smax"] = row_list["kv_smax"];

					row["bdat"] = row_list["bdat"];
					row["edat"] = row_list["edat"];
				}
				ds.Tables[0].AcceptChanges();
				obj[0] = ds.GetXml();
				obj[1] = count;
				obj[2] = tarifSchemeName;
				return obj;
			}
			catch (Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
		}
		//Sob
		[WebMethod(EnableSession = true)]
		public object[] GetSob(string[] data)
		{
			object[] obj = new object[2];
			DataSet ds = new DataSet();
			int count = 0;
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				string order = data[3];
				string acc = data[0];
				int startpos = Convert.ToInt32(data[4]);
				int pageSize = Convert.ToInt32(data[5]);
				string _acc = "";
				if (acc != "0")
				{
					_acc = "AND a.acc=:acc";
					SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
				}
				count = Convert.ToInt32(SQL_SELECT_scalar("SELECT count(*) from acc_sob a, staff s WHERE a.isp=s.id " + _acc));
				ds = SQL_SELECT_dataset(@"SELECT  a.id,TO_CHAR(a.fdat,'DD/MM/YYYY') fdat,a.isp,s.fio,a.txt 
									 FROM acc_sob a, staff s
									 WHERE a.isp=s.id " + _acc +
									 " order by " + order, startpos, pageSize);

				obj[0] = ds.GetXml();
				obj[1] = count;
				return obj;
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
		}
		//Utils
		//Percent
		private object[] Percent(decimal acc, decimal id)
		{
			object[] result = new object[30];
            if (acc == 0) acc = -1;
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
				SetParameters("id", DB_TYPE.Decimal, id, DIRECTION.Input);
				object[] reader = SQL_SELECT_reader(@"
					 SELECT metr,basem,basey,freq,stp_dat,acr_dat,apl_dat,tt,acrA,acrB,ttb,mfob,kvb,nlsb,namb,nazn,io 
					 FROM int_accn WHERE acc=:acc AND id=:id");
				if (reader[0] == null) result[0] = 0;
				else result[0] = reader[0];//_Metr
				if (reader[1] == null) result[1] = 0;
				else result[1] = reader[1];//_BaseM
				if (reader[2] == null) result[2] = 0;
				else result[2] = reader[2];//_BaseY
				if (reader[3] == null) result[3] = 1;
				else result[3] = reader[3];//_Freq
				if (reader[4] == null) result[4] = null;
				else result[4] = Convert.ToDateTime(reader[4], cinfo).ToShortDateString();//_StpDat
				if (reader[5] == null) result[5] = null;
				else result[5] = Convert.ToDateTime(reader[5], cinfo).ToShortDateString();//_AcrDat
				if (reader[6] == null) result[6] = null;
				else result[6] = Convert.ToDateTime(reader[6], cinfo).ToShortDateString();//_AplDat
				result[7] = reader[7];//_TT1
				result[8] = reader[8];//_AcrA
				result[9] = reader[9];//_AcrB
				result[10] = reader[10];//_TT2
				result[11] = reader[11];//_MFO
				result[12] = reader[12];//_KvC
				result[13] = reader[13];//_NlsC
				result[14] = reader[14];//_NamC
				result[15] = reader[15];//_Nazn
				if (reader[16] == null) result[16] = 0;
				else result[16] = reader[16];//_Io
				if (result[8] != null)
				{
					ClearParameters();
					SetParameters("acc", DB_TYPE.Decimal, result[8], DIRECTION.Input);
					reader = SQL_SELECT_reader("SELECT nls,kv FROM accounts WHERE acc=:acc");
					result[17] = Convert.ToString(reader.GetValue(0)); //NlsA
					result[18] = Convert.ToDecimal(reader.GetValue(1)); //KvA
				}
				if (result[9] != null)
				{
					ClearParameters();
					SetParameters("acc", DB_TYPE.Decimal, result[9], DIRECTION.Input);
					reader = SQL_SELECT_reader("SELECT nls,kv FROM accounts WHERE acc=:acc");
					result[19] = Convert.ToString(reader.GetValue(0)); //NlsB
					result[20] = Convert.ToDecimal(reader.GetValue(1)); //KvB

				}
				//Mert
				if (result[0] != null)
					result[21] = SQL_SELECT_scalar("SELECT name FROM int_metr WHERE metr=" + result[0]);
				//BaseY
				if (result[2] != null)
					result[22] = SQL_SELECT_scalar("SELECT name FROM basey WHERE basey=" + result[2]);
				//Freq
				if (result[3] != null)
					result[23] = SQL_SELECT_scalar("SELECT name FROM freq WHERE freq=" + result[3]);
				result[24] = "";
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
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
				SetRole(base_role);
				string new_acc_struct = Convert.ToString(SQL_SELECT_scalar("SELECT VAL FROM PARAMS WHERE PAR='ACCSTRUC'"));
				if (new_acc_struct != "") acc_struct = new_acc_struct;
				bAlign = (acc_struct.Substring(0, 1) == "R") ? (1) : (0);
				MLen = acc_struct.Length - 1;
				BPos = acc_struct.IndexOf('B');
				KPos = acc_struct.IndexOf('K');
				BLen = acc_struct.LastIndexOf('B') - BPos + 1;
				if (bAlign == 1)
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
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
			return tab;
		}
		//Рассчитать КР счета и подставить его обратно
		public string[] KeyAccount(string sMfo, string sAcc)
		{
			string[] result = new string[7];
			try
			{
				sMfo = sMfo.Trim();
				sAcc = sAcc.Trim();
				if (sAcc.Length == 0) return result;
				try { Convert.ToUInt64(sAcc); }
				catch { return result; }
				if (sMfo.Length == 9)
				{
					sMfo = "00" + sMfo.Substring(6, 3) + "0";
				}
				Hashtable tab = GetAccountStructure();
				decimal nFormula = (decimal)tab["Align"];
				int KPos = (int)tab["KPos"];
				int BPos = (int)tab["BPos"];
				int BLen = (int)tab["BLen"];
				string sCtrlDigit = GetChecksumDigit(sMfo, sAcc, nFormula).ToString();
				string newAcc = string.Empty;
				string newNbs = string.Empty;
				if (nFormula == 1)
				{
					newAcc = sAcc.Substring(0, sAcc.Length - KPos) + sCtrlDigit + sAcc.Substring(KPos - 1);
					string temp = newAcc.Insert(0, "000000000".Substring(0, BLen));
					newNbs = temp.Substring(temp.Length - BPos - 1).Substring(0, BLen);
					if (newAcc.Length < BPos)
						newAcc = newNbs + newAcc.Substring(newAcc.Length - BPos + BLen - 1);
				}
				else
				{
					if (sAcc.Length < KPos)
					{
						newAcc = sAcc + sCtrlDigit;
						if (newAcc.Length < BPos + BLen)
							newNbs = newAcc;
						else newNbs = newAcc.Substring(BPos - 1, BLen);
					}
					else
					{
						sAcc = sAcc.Remove(KPos - 1, 1);
						newAcc = sAcc.Insert(KPos - 1, sCtrlDigit);
						newNbs = newAcc.Substring(BPos - 1, BLen);
					}
				}
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("nbs", DB_TYPE.Varchar2, newNbs, DIRECTION.Input);
				object[] reader = SQL_SELECT_reader("SELECT name, xar, pap, nbs  FROM Ps WHERE (d_close is null or d_close>=bankdate) AND nbs=:nbs");
				string NameNbs = Convert.ToString(reader.GetValue(0));
				decimal Xar = Convert.ToDecimal(reader.GetValue(1));
				decimal Pap = Convert.ToDecimal(reader.GetValue(2));
				newNbs = Convert.ToString(reader.GetValue(3));
				ClearParameters();
				SetParameters("xar", DB_TYPE.Varchar2, Xar, DIRECTION.Input);
				string har_str = Convert.ToString(SQL_SELECT_scalar("SELECT name FROM Xar WHERE xar=:xar"));
				ClearParameters();
				SetParameters("pap", DB_TYPE.Varchar2, Pap, DIRECTION.Input);
				string pap_str = Convert.ToString(SQL_SELECT_scalar("SELECT name FROM pap WHERE pap=:pap"));

				ClearParameters();
				SetParameters("nls", DB_TYPE.Varchar2, newAcc, DIRECTION.Input);
				if ("" != Convert.ToString(SQL_SELECT_scalar("SELECT nls FROM accounts WHERE nls=:nls")))
					result[6] = "?";
				result[0] = newAcc;
				result[1] = newNbs;
				result[2] = NameNbs;
				result[3] = har_str;
				result[4] = pap_str;
				result[5] = Pap.ToString();
				return result;
			}
			catch (System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
		}
		//Обновление\регистрация счета	
		public string UpdateAccount(string[] data, decimal acc)
		{
			string result;
			try
			{
				ClearParameters();
				SetRole(base_role);
				string ProcMfoOld = data[21];
				string ProcMfo = data[0];
				decimal Ostx = (data[1] == "") ? (0) : Convert.ToDecimal(data[1]);
				string NlsAlt = data[2];
				string Grp = data[3];
				string Rnk = data[4];
				string Nls = data[5];
				string Kv = data[6];
				if (Kv.Length > 3)
					Kv = Kv.Substring(0, 3);
				string Nms = data[7];
				string Tip = data[8];
				string Isp = data[9];
				string newacc = "";
				string Nbs = data[10];
				string Pap = data[11];
				string Vid = data[12];
				string Pos = data[13];
				string Seci = (data[14] == "") ? (null) : (data[14]);
				string Seco = (data[15] == "") ? (null) : (data[15]);
				string Blkd = data[16];
				string Blkk = data[17];
				decimal Lim = (data[18] == "") ? (0) : Convert.ToDecimal(data[18]);
				string Tobo = data[19];
				decimal mode = (ProcMfo != "" || ProcMfoOld != "") ? (4) : (77);
				string ostx = (Ostx == 0) ? ("NULL") : (Ostx.ToString());
				string nlsalt = (NlsAlt == "") ? ("NULL") : (NlsAlt);
				decimal P4 = 0;
				// При відкритті рахунку перевіряємо наявніть такого в системі
				/*if (acc == 0)
				{
					SetRole(base_role);
					SetParameters("kv", DB_TYPE.Decimal, Kv, DIRECTION.Input);
					SetParameters("nls", DB_TYPE.Varchar2, Nls, DIRECTION.Input);
					if (Convert.ToDecimal(SQL_SELECT_scalar("SELECT count(acc) FROM accounts WHERE kv=:kv AND nls=:nls")) > 0)
					{
						throw new Bars.Exception.BarsException("Рахунок " + Nls + "(" + Kv + ") вже зареєстровано в системі." );
					}
					ClearParameters();
				}*/

				SetParameters("mod_", DB_TYPE.Decimal, mode, DIRECTION.Input);
				SetParameters("p1_", DB_TYPE.Varchar2, ProcMfo, DIRECTION.Input);
				SetParameters("p2_", DB_TYPE.Decimal, 0, DIRECTION.Input);
				SetParameters("p3_", DB_TYPE.Decimal, Grp, DIRECTION.Input);
				SetParameters("p4_", DB_TYPE.Decimal, P4, DIRECTION.InputOutput);
				SetParameters("rnk_", DB_TYPE.Decimal, Rnk, DIRECTION.Input);
				SetParameters("nls_", DB_TYPE.Varchar2, Nls, DIRECTION.Input);
				SetParameters("kv_", DB_TYPE.Decimal, Kv, DIRECTION.Input);
				SetParameters("nms_", DB_TYPE.Varchar2, Nms, DIRECTION.Input);
				SetParameters("tip_", DB_TYPE.Varchar2, Tip, DIRECTION.Input);
				SetParameters("isp_", DB_TYPE.Decimal, Isp, DIRECTION.Input);
				SetParameters("accR_", DB_TYPE.Decimal, newacc, DIRECTION.Output);
				SetParameters("nbsnull_", DB_TYPE.Varchar2, "1", DIRECTION.Input);
				SetParameters("pap_", DB_TYPE.Decimal, Pap, DIRECTION.Input);
				SetParameters("vid_", DB_TYPE.Decimal, Vid, DIRECTION.Input);
				SetParameters("pos_", DB_TYPE.Decimal, Pos, DIRECTION.Input);
				SetParameters("sec_", DB_TYPE.Decimal, 0, DIRECTION.Input);
				SetParameters("seci_", DB_TYPE.Decimal, Seci, DIRECTION.Input);
				SetParameters("seco_", DB_TYPE.Decimal, Seco, DIRECTION.Input);
				SetParameters("blkd_", DB_TYPE.Decimal, Blkd, DIRECTION.Input);
				SetParameters("blkk_", DB_TYPE.Decimal, Blkk, DIRECTION.Input);
				SetParameters("lim_", DB_TYPE.Decimal, Lim, DIRECTION.Input);
				SetParameters("ostx_", DB_TYPE.Varchar2, ostx, DIRECTION.Input);
				SetParameters("nlsalt_", DB_TYPE.Varchar2, nlsalt, DIRECTION.Input);
				SetParameters("tobo_", DB_TYPE.Varchar2, Tobo, DIRECTION.Input);
				SQL_PROCEDURE("op_reg_ex");
				result = Convert.ToString(GetParameter("accR_"));

				//Новая система доступа к счетам
				if (string.Empty != data[22])
				{
					string[] groups_insert = data[23].Trim().Split(' ');
					string[] groups_delete = data[24].Trim().Split(' ');
					for (int i = 0; i < groups_insert.Length; i++)
					{
						if (!string.IsNullOrEmpty(groups_insert[i].Trim()))
						{
							ClearParameters();
							SetParameters("acc", DB_TYPE.Decimal, result, DIRECTION.Input);
							SetParameters("id", DB_TYPE.Decimal, groups_insert[i], DIRECTION.Input);
							SQL_PROCEDURE("sec.addAgrp");
						}
					}
					for (int i = 0; i < groups_delete.Length; i++)
					{
						if (!string.IsNullOrEmpty(groups_delete[i].Trim()))
						{
							ClearParameters();
							SetParameters("acc", DB_TYPE.Decimal, result, DIRECTION.Input);
							SetParameters("id", DB_TYPE.Decimal, groups_delete[i], DIRECTION.Input);
							SQL_PROCEDURE("sec.delAgrp");
						}
					}
				}
			}
			finally { }
			return result;
		}
		public void UpdateSP(decimal acc, string[] data, string newAcc)
		{
			try
			{
				if (acc == 0 && !string.IsNullOrEmpty(newAcc)) acc = Convert.ToDecimal(newAcc);
				ClearParameters();
				SetRole(base_role);
				bool cbSPOpt = Convert.ToBoolean(data[data.Length - 2]);
				string nbs = Convert.ToString(data[data.Length - 1]);
				Hashtable requiredParams = new Hashtable();
				// Проверка на обазательность реквизитов
				ClearParameters();
				SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
				SetParameters("nbs", DB_TYPE.Varchar2, nbs, DIRECTION.Input);
                SQL_Reader_Exec("SELECT p.spid, f_read_sp(p.spid,:acc), s.semantic from sparam_list s, ps_sparam p where s.spid=p.spid and p.nbs=:nbs and opt=1 and inuse = 1");
				while (SQL_Reader_Read())
				{
					ArrayList reader = SQL_Reader_GetValues();
					requiredParams[Convert.ToString(reader[0])] = reader;
				}
				SQL_Reader_Close();

				for (int i = 0; i < data.Length - 2; i += 2)
				{
					//if (cbSPOpt)
					//{
					//    ClearParameters();
					//    SetParameters("name", DB_TYPE.Varchar2, data[i], DIRECTION.Input);
					//    SetParameters("nbs", DB_TYPE.Varchar2, nbs, DIRECTION.Input);
					//    object[] obj = SQL_SELECT_reader("SELECT p.opt,s.semantic from sparam_list s, ps_sparam p where s.spid=p.spid and s.name=:name and p.nbs=:nbs");
					//    if (Convert.ToString(obj[0]) == "1" && data[i + 1] == "")
					//    {
					//        throw (new Exception("Не заполнен реквизит <" + obj[1].ToString() + ">"));
					//    }
					//}

					string spid = data[i];
					string spValue = data[i + 1];
					if (cbSPOpt)
					{
						// есть в обязательных и пришел не пустой - удаляем из колекции
						if (requiredParams[spid] != null && !string.IsNullOrEmpty(spValue))
							requiredParams.Remove(spid);
					}

					ClearParameters();
					SetParameters("spid", DB_TYPE.Decimal, spid, DIRECTION.Input);
					ArrayList reader = SQL_reader("select tag, upper(tabname),delonnull,type,name from sparam_list where spid=:spid");
					if (reader.Count > 0)
					{
						string tag = Convert.ToString(reader[0]);
						string tabname = Convert.ToString(reader[1]);
						string delonnull = Convert.ToString(reader[2]);
						string type = Convert.ToString(reader[3]).ToUpper();
						string name = Convert.ToString(reader[4]);

						string query = "select count(acc) from " + tabname + " where acc=:acc";
						ClearParameters();
						SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
						if (!string.IsNullOrEmpty(tag))
						{
							SetParameters("tag", DB_TYPE.Varchar2, tag, DIRECTION.Input);
							query += " and tag=:tag";
						}
                        int count = Convert.ToInt32(SQL_SELECT_scalar(query));

						if (string.IsNullOrEmpty(spValue) && delonnull.Equals("1"))
							SQL_NONQUERY("delete from " + tabname + " where acc=:acc" + ((string.IsNullOrEmpty(tag)) ? ("") : (" and tag=:tag")));
						else
						{
							ClearParameters();
							if (type.Equals("N"))
								SetParameters("val", DB_TYPE.Decimal, spValue, DIRECTION.Input);
							else if (type.Equals("D") && !string.IsNullOrEmpty(spValue))
							{
								cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
								cinfo.DateTimeFormat.DateSeparator = "/";
								SetParameters("val", DB_TYPE.Date, Convert.ToDateTime(spValue, cinfo), DIRECTION.Input);
							}
							else
								SetParameters("val", DB_TYPE.Varchar2, spValue, DIRECTION.Input);

							SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
							if (!string.IsNullOrEmpty(tag))
								SetParameters("tag", DB_TYPE.Varchar2, tag, DIRECTION.Input);
                            
                            if (count == 0)
                                SQL_NONQUERY("insert into " + tabname + " (" + name + ", acc" + ((string.IsNullOrEmpty(tag)) ? ("") : (",tag")) + ") values (:val, :acc" + ((string.IsNullOrEmpty(tag)) ? ("") : (",:tag")) + ")");
                            else 
    							SQL_NONQUERY("update " + tabname + " set " + name + "=:val where acc=:acc" + ((string.IsNullOrEmpty(tag)) ? ("") : (" and tag=:tag")));
						}
					}
				}

				// проверка на рекв. обязательные
				if (cbSPOpt)
				{
					string errMsg = string.Empty;
					foreach (string key in requiredParams.Keys)
					{
						ArrayList list = (ArrayList)requiredParams[key];
						if (string.IsNullOrEmpty(Convert.ToString(list[1])))
							errMsg += " - " + Convert.ToString(list[2]) + ";\n";
					}
					if (!string.IsNullOrEmpty(errMsg))
					{
						throw new Exception("CheckSP::Не заповнено спец. параметр(и):\n" + errMsg + "::CheckSP");
					}
				}
			}
			finally { }
		}
        public void UpdatePercent(decimal acc, string[] data, string newAcc)
		{
			try
			{
                if (acc == 0 && !string.IsNullOrEmpty(newAcc)) acc = Convert.ToDecimal(newAcc);
				ClearParameters();
				SetRole(base_role);
				string Metr = data[0];
				string BaseM = data[1];
				string BaseY = data[2];
				string Freq = data[3];
				object StpDat = null;
				if (data[4] != "") StpDat = Convert.ToDateTime(data[4], cinfo);
				object AcrDat = null;
				if (data[5] != "") AcrDat = Convert.ToDateTime(data[5], cinfo);
				object AplDat = null;
				if (data[6] != "") AplDat = Convert.ToDateTime(data[6], cinfo);
				string TT1 = data[7];
                if (string.IsNullOrEmpty(TT1.Trim())) TT1 = "%%1";
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
				SetParameters("nAcc", DB_TYPE.Decimal, acc, DIRECTION.Input);
				SetParameters("nId", DB_TYPE.Decimal, nId, DIRECTION.Input);
				decimal count = Convert.ToDecimal(SQL_SELECT_scalar("SELECT count(*) FROM int_accN WHERE acc=:nAcc AND id=:nId"));
				if (count != 0)
					query = "UPDATE Int_accN SET acc=:nAcc,id=:nId,metr=:nMetr,basem=:nBaseM,basey=:nBaseY,freq=:nFreq,stp_dat=:dStpDat,acr_dat=:dAcrDat,apl_dat=:dAplDat,tt=:sTT1,acra=:nAcrA,acrb=:nAcrB,ttb=:sTT2,mfob=:sMFO,kvb=:nKvC,nlsb=:sNlsC,namb=:sNamC,nazn=:sNazn,io=:nIo WHERE acc=:nAcc AND id=:nId";
				else
					query = "INSERT INTO Int_accN (acc,id,metr,basem,basey,freq,stp_dat,acr_dat,apl_dat,tt,acra,acrb,ttb,mfob,kvb,nlsb,namb,nazn,io) VALUES (:nAcc,:nId,:nMetr,:nBaseM,:nBaseY,:nFreq,:dStpDat,:dAcrDat,:dAplDat,:sTT1,:nAcrA,:nAcrB,:sTT2,:sMFO,:nKvC,:sNlsC,:sNamC,:sNazn,:nIo)";
				SetParameters("nMetr", DB_TYPE.Decimal, Metr, DIRECTION.Input);
				SetParameters("nBaseM", DB_TYPE.Decimal, BaseM, DIRECTION.Input);
				SetParameters("nBaseY", DB_TYPE.Decimal, BaseY, DIRECTION.Input);
				SetParameters("nFreq", DB_TYPE.Decimal, Freq, DIRECTION.Input);
				SetParameters("dStpDat", DB_TYPE.Date, StpDat, DIRECTION.Input);
				SetParameters("dAcrDat", DB_TYPE.Date, AcrDat, DIRECTION.Input);
				SetParameters("dAplDat", DB_TYPE.Date, AplDat, DIRECTION.Input);
				SetParameters("sTT1", DB_TYPE.Varchar2, TT1, DIRECTION.Input);
				SetParameters("nAcrA", DB_TYPE.Varchar2, AcrA, DIRECTION.Input);
				SetParameters("nAcrB", DB_TYPE.Varchar2, AcrB, DIRECTION.Input);
				SetParameters("sTT2", DB_TYPE.Varchar2, TT2, DIRECTION.Input);
				SetParameters("sMFO", DB_TYPE.Varchar2, MFO, DIRECTION.Input);
				SetParameters("nKvC", DB_TYPE.Varchar2, KvC, DIRECTION.Input);
				SetParameters("sNlsC", DB_TYPE.Varchar2, NlsC, DIRECTION.Input);
				SetParameters("sNamC", DB_TYPE.Varchar2, NamC, DIRECTION.Input);
				SetParameters("sNazn", DB_TYPE.Varchar2, Nazn, DIRECTION.Input);
				SetParameters("nIo", DB_TYPE.Decimal, Io, DIRECTION.Input);
				SQL_NONQUERY(query);
			}
			finally { }
		}
		public void UpdatePercentTbl(decimal acc, string[][] data, string newAcc)
		{
			try
			{
                if (acc == 0 && !string.IsNullOrEmpty(newAcc)) acc = Convert.ToDecimal(newAcc);
				SetRole(base_role);
				for (int i = 0; i < data.Length - 1; i += 2)
				{
					ClearParameters();
					if (data[i + 1].Length == 0) break;
					decimal op = 0;
					switch (data[i + 1][2])
					{
						case "+": op = 1; break;
						case "-": op = 2; break;
						case "*": op = 3; break;
						case "/": op = 4; break;
					}
					if (data[i + 1][0].Substring(0, 1) == "n")
					{
						SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
						SetParameters("id", DB_TYPE.Decimal, data[i + 1][6], DIRECTION.Input);
						SetParameters("bdat", DB_TYPE.Date, Convert.ToDateTime(data[i + 1][4], cinfo), DIRECTION.Input);
						SetParameters("ir", DB_TYPE.Varchar2, data[i + 1][1], DIRECTION.Input);
						SetParameters("br", DB_TYPE.Varchar2, data[i + 1][3], DIRECTION.Input);
						SetParameters("op", DB_TYPE.Decimal, op, DIRECTION.Input);
						SQL_NONQUERY("INSERT INTO Int_ratN (acc,id,bdat,ir,br,op)VALUES (:acc,:id,:bdat,:ir,:br,:op)");
					}
					else if (data[i + 1][0].Substring(0, 1) == "d")
					{
						SetParameters("bdat", DB_TYPE.Date, Convert.ToDateTime(data[i + 1][4], cinfo), DIRECTION.Input);
						SetParameters("id", DB_TYPE.Decimal, data[i + 1][6], DIRECTION.Input);
						SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
						SQL_NONQUERY("DELETE FROM int_ratN WHERE bdat=:bdat AND id=:id AND acc=:acc");
					}
					else
					{
						SetParameters("ir", DB_TYPE.Varchar2, data[i + 1][1], DIRECTION.Input);
						SetParameters("br", DB_TYPE.Varchar2, data[i + 1][3], DIRECTION.Input);
						SetParameters("op", DB_TYPE.Decimal, op, DIRECTION.Input);
						SetParameters("id", DB_TYPE.Decimal, data[i + 1][6], DIRECTION.Input);
						SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
						SetParameters("prev_bdat", DB_TYPE.Date, Convert.ToDateTime(data[i + 1][5], cinfo), DIRECTION.Input);
						if (data[i + 1][4] == data[i + 1][5])
							SQL_NONQUERY("UPDATE Int_ratN SET ir=:ir,br=:br,op=:op WHERE id=:id AND acc=:acc AND bdat=:prev_bdat");
						else
						{
							ClearParameters();
							SetParameters("bdat", DB_TYPE.Date, Convert.ToDateTime(data[i + 1][5], cinfo), DIRECTION.Input);
							SetParameters("id", DB_TYPE.Decimal, data[i + 1][6], DIRECTION.Input);
							SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
							SQL_NONQUERY("DELETE FROM int_ratN WHERE bdat=:bdat AND id=:id AND acc=:acc");

							ClearParameters();
							SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
							SetParameters("id", DB_TYPE.Decimal, data[i + 1][6], DIRECTION.Input);
							SetParameters("bdat", DB_TYPE.Date, Convert.ToDateTime(data[i + 1][4], cinfo), DIRECTION.Input);
							SetParameters("ir", DB_TYPE.Varchar2, data[i + 1][1], DIRECTION.Input);
							SetParameters("br", DB_TYPE.Varchar2, data[i + 1][3], DIRECTION.Input);
							SetParameters("op", DB_TYPE.Decimal, op, DIRECTION.Input);
							SQL_NONQUERY("INSERT INTO Int_ratN (acc,id,bdat,ir,br,op)VALUES (:acc,:id,:bdat,:ir,:br,:op)");
						}
					}
				}
			}
			finally { }
		}
		//Update Rates
		public void UpdateRates(decimal acc, string[][] data)
		{
			try
			{
				ClearParameters();
				SetRole(base_role);
				for (int i = 0; i < data.Length; i += 2)
				{
					ClearParameters();
					SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
					SetParameters("kod", DB_TYPE.Decimal, data[i + 1][0], DIRECTION.Input);
					if (Convert.ToDecimal(SQL_SELECT_scalar("SELECT count(acc) FROM acc_tarif WHERE acc=:acc AND kod=:kod")) == 0)
					{

						SetParameters("tar", DB_TYPE.Decimal, data[i + 1][1], DIRECTION.Input);
						SetParameters("pr", DB_TYPE.Decimal, data[i + 1][2], DIRECTION.Input);
						string par = (string.IsNullOrEmpty(data[i + 1][3].Trim())) ? (null) : (data[i + 1][3]);
						SetParameters("smin", DB_TYPE.Decimal, par, DIRECTION.Input);
						par = (string.IsNullOrEmpty(data[i + 1][4].Trim())) ? (null) : (data[i + 1][4]);
						SetParameters("smax", DB_TYPE.Decimal, par, DIRECTION.Input);
						if (data[i + 1][5].Trim() != "")
							SetParameters("bdat", DB_TYPE.Date, Convert.ToDateTime(data[i + 1][5], cinfo), DIRECTION.Input);
						else
							SetParameters("bdat", DB_TYPE.Date, null, DIRECTION.Input);
						if (data[i + 1][6].Trim() != "")
							SetParameters("edat", DB_TYPE.Date, Convert.ToDateTime(data[i + 1][6], cinfo), DIRECTION.Input);
						else
							SetParameters("edat", DB_TYPE.Date, null, DIRECTION.Input);

                        par = (string.IsNullOrEmpty(data[i + 1][7].Trim())) ? (null) : (data[i + 1][7]);
                        SetParameters("kv_smin", DB_TYPE.Decimal, par, DIRECTION.Input);
                        par = (string.IsNullOrEmpty(data[i + 1][8].Trim())) ? (null) : (data[i + 1][8]);
                        SetParameters("kv_smax", DB_TYPE.Decimal, par, DIRECTION.Input);

						SQL_NONQUERY(@"INSERT INTO 
                                            acc_tarif(acc,kod,tar,pr,smin,smax,bdate,edate,kv_smin,kv_smax) 
                                        VALUES(:acc,:kod,:tar,:pr,:smin,:smax,:bdat,:edat,:kv_smin,:kv_smax)");
					}
					else
					{
						if (data[i + 1][1] == "0" && data[i + 1][2] == "0" && data[i + 1][3] == "0" && data[i + 1][4] == "0")
							SQL_NONQUERY("DELETE FROM acc_tarif WHERE acc=:acc AND kod=:kod");
						else
						{
							ClearParameters();
							SetParameters("tar", DB_TYPE.Decimal, data[i + 1][1], DIRECTION.Input);
							SetParameters("pr", DB_TYPE.Decimal, data[i + 1][2], DIRECTION.Input);
							string par = (string.IsNullOrEmpty(data[i + 1][3].Trim())) ? (null) : (data[i + 1][3]);
							SetParameters("smin", DB_TYPE.Decimal, par, DIRECTION.Input);
							par = (string.IsNullOrEmpty(data[i + 1][4].Trim())) ? (null) : (data[i + 1][4]);
							SetParameters("smax", DB_TYPE.Decimal, par, DIRECTION.Input);
							if (data[i + 1][5].Trim() != "")
								SetParameters("bdat", DB_TYPE.Date, Convert.ToDateTime(data[i + 1][5], cinfo), DIRECTION.Input);
							else
								SetParameters("bdat", DB_TYPE.Date, null, DIRECTION.Input);
							if (data[i + 1][6].Trim() != "")
								SetParameters("edat", DB_TYPE.Date, Convert.ToDateTime(data[i + 1][6], cinfo), DIRECTION.Input);
							else
								SetParameters("edat", DB_TYPE.Date, null, DIRECTION.Input);

                            par = (string.IsNullOrEmpty(data[i + 1][7].Trim())) ? (null) : (data[i + 1][7]);
                            SetParameters("kv_smin", DB_TYPE.Decimal, par, DIRECTION.Input);
                            par = (string.IsNullOrEmpty(data[i + 1][8].Trim())) ? (null) : (data[i + 1][8]);
                            SetParameters("kv_smax", DB_TYPE.Decimal, par, DIRECTION.Input);

							SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
							SetParameters("kod", DB_TYPE.Decimal, data[i + 1][0], DIRECTION.Input);
							SQL_NONQUERY(@"UPDATE 
                                                acc_tarif 
                                            SET 
                                                tar=nvl(:tar,tar),
                                                pr=nvl(:pr,pr),
                                                smin=:smin, 
                                                smax=:smax, 
                                                bdate=:bdat, 
                                                edate=:edat,
                                                kv_smin = :kv_smin,
                                                kv_smax = :kv_smax
                                            WHERE 
                                                acc=:acc 
                                                AND kod=:kod");
						}
					}
				}
			}
			finally { }
		}
		//Update Sob
		public void UpdateSob(decimal acc, string[][] data)
		{
			try
			{
				ClearParameters();
				SetRole(base_role);
				string isp = data[data.Length - 1][0];
				for (int i = 0; i < data.Length - 1; i += 2)
				{
					if (data[i + 1][0].Substring(0, 1) == "n")
					{
						SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
						SetParameters("isp", DB_TYPE.Varchar2, isp, DIRECTION.Input);
						SetParameters("fdat", DB_TYPE.Date, Convert.ToDateTime(data[i + 1][1], cinfo), DIRECTION.Input);
						SetParameters("txt", DB_TYPE.Varchar2, data[i + 1][2], DIRECTION.Input);
						SQL_NONQUERY("INSERT INTO acc_sob(acc,isp,fdat,txt) VALUES(:acc,:isp,:fdat,:txt)");
					}
					else if (data[i + 1][1].Substring(0, 1) == "d")
					{
						SetParameters("id", DB_TYPE.Decimal, data[i + 1][0], DIRECTION.Input);
						SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
						SQL_NONQUERY("DELETE FROM acc_sob WHERE id=:id AND acc=:acc");
					}
					else
					{
						SetParameters("isp", DB_TYPE.Decimal, isp, DIRECTION.Input);
						SetParameters("fdat", DB_TYPE.Date, Convert.ToDateTime(data[i + 1][1], cinfo), DIRECTION.Input);
						SetParameters("txt", DB_TYPE.Varchar2, data[i + 1][2], DIRECTION.Input);
						SetParameters("id", DB_TYPE.Decimal, data[i + 1][0], DIRECTION.Input);
						SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
						SQL_NONQUERY("UPDATE acc_sob SET isp=:isp,fdat=:fdat,txt=:txt WHERE id=:id AND acc=:acc");
					}
				}
			}
			finally { }
		}

		#region Component Designer generated code

		private void InitializeComponent()
		{
		}

		#endregion
	}
}
