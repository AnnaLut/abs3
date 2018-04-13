using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Globalization;
using System.IO;
using System.Web.Services;
using Bars;
using Bars.Doc;
using Bars.DocPrint;
using Oracle.DataAccess.Client;

namespace KP 
{
	public class Service : BarsWebService
	{
		override public void PrimaryCheckAccess(){}
		private string basic_role = "wr_kp";
		CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");	
		public Service()
		{
			cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
			cinfo.DateTimeFormat.DateSeparator = "/";
			cinfo.NumberFormat.CurrencyDecimalSeparator = ".";
			InitializeComponent();
		}
		[WebMethod(EnableSession = true)]
		public string[] Populate()
		{
			string[] result = new string[11] ;
			try
			{
				InitOraConnection(Context);
				SetRole(basic_role);
				ArrayList array =  SQL_reader("SELECT bankdate,tobopack.GetTOBO,tobopack.GetToboCASH,user_id,f_ourmfo from dual");
				result[0] = Convert.ToDateTime(array[0],cinfo).ToShortDateString();
				result[1] = Convert.ToString(array[1]);
				result[2] = Convert.ToString(array[2]);
				result[3] = Convert.ToString(array[3]);
				result[4] = Convert.ToString(array[4]);
				result[5] = Convert.ToString(SQL_SELECT_scalar("SELECT val from params where par='BASEVAL'"));
				result[6] = Convert.ToString(SQL_SELECT_scalar("SELECT val from params where par='OKPO'"));
				result[7] = Convert.ToString(SQL_SELECT_scalar("SELECT fio from staff where id="+result[3]));
				result[9] = Convert.ToString(SQL_SELECT_scalar("SELECT val from params where par='ADDRESS'"));
				result[10] = Convert.ToString(SQL_SELECT_scalar("SELECT val from params where par='NAME'"));
				if(result[2] != "")
				{
					SetParameters("cash",DB_TYPE.Varchar2,result[2],DIRECTION.Input);
					result[8] = Convert.ToString(SQL_SELECT_scalar("select nms from accounts where nls=:cash and tip='KAS'"));
				}
			}
			catch(System.Exception ex)
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
		//Gen
		[WebMethod(EnableSession = true)]
		public object[] GetGen(string[] data)
		{
			try
			{
				string filter = data[10];
				string filter2 = data[11];
				InitOraConnection(Context);
				SetRole(basic_role);
				return BindTableWithFilter("t.pos POS,k.nd ND, k.name NAME,k.sum SUM, a.nls NLS, a.nms NMS,k.SK SK,s.name SKN, k.mfob MFO,k.okpob OKPO,k.nmsb NMSB, b.nb NB,k.nlsb NLSB,k.nazn NAZN,k.tt TT, DECODE(k.grp,0,'','v') GR,k.acc6f, k.acc6u,k.acc3u,k.nak,k.vob,k.grp",
										   "kp_deal k, accounts a, banks b, kp_tobo t, sk s",
										   "k.acc=a.acc(+) and a.dazs is null and k.mfob=b.MFO (+) and k.sk=s.sk(+) and k.nd=t.nd and t.tobo=tobopack.gettobo "+filter+filter2,
										   data);
			}
			catch(System.Exception ex)
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
		public object[] GetFolderList(string[] data)
		{
			try
			{
                InitOraConnection(Context);
				SetRole(basic_role);
				int nd = -Convert.ToInt32(data[10]);
				SetParameters("lg",DB_TYPE.Varchar2,nd,DIRECTION.Input);
				return BindTableWithFilter("d.name NAME, d.sum SUM,d.nd ND,d.tt TT,d.nak",
					"kp_log_nd l ,kp_deal d",
					"l.nd=d.nd and l.log=:lg",
					data);
			}
			catch(System.Exception ex)
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
		public string[][] GetFields()
		{
			try
			{
				InitOraConnection(Context);
				SetRole(basic_role);
				return MakeArrayFromDataSet(SQL_SELECT_dataset("select o.tt, o.tag, o.val, o.opt, f.name "+ 
															   "from OP_RULES o,OP_FIELD f "+
			    "WHERE o.tag=f.tag and o.USED4INPUT=1 and o.TT IN (select  tt from kp_deal  where ND in (select nd from kp_tobo where tobo=tobopack.gettobo)) order by o.ord"));
			}
			catch(System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
			finally
			{
				DisposeOraConnection();
			}
		}
		
		private string[][] MakeArrayFromDataSet(DataSet ds)
		{
			string[][] result = new string[100][];
			for(int i = 0; i < ds.Tables[0]. Rows.Count; i++)
			{
				result[i] = new string[20]; 
				for(int j = 0; j < ds.Tables[0].Columns.Count; j++)
				{
					result[i][j] = ds.Tables[0].Rows[i].ItemArray[j].ToString().Trim(); 
				}
			}
			return result;
		}
		
		[WebMethod(EnableSession = true)]
		public string[] GetSimpleNd()
		{
			string[] result = new string[10];
			try
			{ 
				InitOraConnection(Context);
				SetRole(basic_role);
				string nls2902 = Convert.ToString(SQL_SELECT_scalar("select tobopack.GetTOBOParam('NLS2902') from dual"));
				if(nls2902 != string.Empty)
				{
					result[0] = nls2902;
					SetParameters("nls",DB_TYPE.Varchar2,nls2902,DIRECTION.Input);
					result[1] = Convert.ToString(SQL_SELECT_scalar("select nms from accounts where nls=:nls and kv=980"));
				}
				ArrayList reader =  SQL_reader("select nazn,tt,acc6f,acc6u,acc3u,vob,sum from kp_deal where nd=0");
				if(reader.Count != 0){
					result[2] = Convert.ToString(reader[0]);
					result[3] = Convert.ToString(reader[1]);
					result[4] = Convert.ToString(reader[2]);
					result[5] = Convert.ToString(reader[3]);
					result[6] = Convert.ToString(reader[4]);
					result[7] = Convert.ToString(reader[5]);
					result[8] = Convert.ToString(reader[6]);
				}
			}
			catch(System.Exception ex)
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
		public string[] getNls2902()
		{
			string[] result = new string[2];
			try
			{ 
				InitOraConnection(Context);
				SetRole(basic_role);
				string nls2902 = Convert.ToString(SQL_SELECT_scalar("select tobopack.GetTOBOParam('NLS2902') from dual"));
				if(nls2902 != string.Empty)
				{
					result[0] = nls2902;
					SetParameters("nls",DB_TYPE.Varchar2,nls2902,DIRECTION.Input);
					result[1] = Convert.ToString(SQL_SELECT_scalar("select nms from accounts where nls=:nls and kv=980"));
				}
			}
			catch(System.Exception ex)
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
				SetRole(basic_role);
				SetParameters("ID",DB_TYPE.Decimal,id,DIRECTION.Input);
				result = Convert.ToString(SQL_SELECT_scalar("SELECT nb FROM banks WHERE nvl(blk,0) <>4 AND mfo=:ID"));
			}
			catch(System.Exception ex)
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
		public string getOkpo(string nls)
		{
			string result = string.Empty;
			try
			{ 
				InitOraConnection(Context);
				SetRole(basic_role);
				SetParameters("nls",DB_TYPE.Varchar2,nls,DIRECTION.Input);
				result = Convert.ToString(SQL_SELECT_scalar("SELECT okpo FROM alien WHERE nls=:nls"));
			}
			catch(System.Exception ex)
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
		public string getSK(string id)
		{
			string result = string.Empty;
			try
			{ 
				InitOraConnection(Context);
				SetRole(basic_role);
				SetParameters("ID",DB_TYPE.Decimal,id,DIRECTION.Input);
				result = Convert.ToString(SQL_SELECT_scalar("SELECT name FROM sk WHERE sk<40 AND sk=:ID"));
			}
			catch(System.Exception ex)
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
		public string[][] GetKomis(string nds,string sums)
		{
			string[][] result = new string[20][];
			try
			{ 
				InitOraConnection(Context);
				SetRole(basic_role);
				for(int i = 0; i < nds.Split(';').Length - 1; i++ )
				{
					result[i] = new string[19]; 
					string nd = nds.Split(';')[i];
					decimal sum = Convert.ToDecimal(sums.Split(';')[i],cinfo);
					result[i][0] = nd;
					result[i][18] = Convert.ToString(sum);//sum
					
					ClearParameters();
					SetParameters("nd",DB_TYPE.Decimal,nd,DIRECTION.Input);
					ArrayList reader =  SQL_reader("select a.nls,a.nms,k.sk,k.mfob,k.okpob,k.nmsb,k.nlsb,k.nazn,k.tt,k.nak,k.acc6f,k.acc6u,k.acc3u,k.vob,k.grp"+
													" from kp_deal k, accounts a"+
													" where k.nd=:nd and k.acc=a.acc(+)");
					if(reader.Count != 0)
					{
						result[i][3] = Convert.ToString(reader[0]);//nls
						result[i][4] = Convert.ToString(reader[1]);//nms
						result[i][5] = Convert.ToString(reader[2]);//sk
						result[i][6] = Convert.ToString(reader[3]);//mfob
						result[i][7] = Convert.ToString(reader[4]);//okpob
						result[i][8] = Convert.ToString(reader[5]);//nmsb
						result[i][9] = Convert.ToString(reader[6]);//nlsb
						result[i][10] = Convert.ToString(reader[7]);//nazn
						result[i][11] = Convert.ToString(reader[8]);//tt
						result[i][12] = Convert.ToString(reader[9]);//nak
						result[i][13] = Convert.ToString(reader[10]);//acc6f
						result[i][14] = Convert.ToString(reader[11]);//acc6u
						result[i][15] = Convert.ToString(reader[12]);//acc3u
						result[i][16] = Convert.ToString(reader[13]);//vob
						result[i][17] = Convert.ToString(reader[14]);//grp
					}
					if(result[i][12] != "1")
					{
						SetParameters("sum",DB_TYPE.Decimal,sum,DIRECTION.Input);
						ArrayList array = SQL_reader("SELECT Bars.KP_Kom(:nd,:sum,0),Bars.KP_Kom(:nd,:sum,1) from dual");
						if(array.Count != 0)
						{
							result[i][1] = array[0].ToString();
							result[i][2] = array[1].ToString();
						}
					}
					else
					{
						result[i][1] = "0";
						result[i][2] = "0";
					}
				}
			}
			catch(System.Exception ex)
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
		public string[] CheckSum(decimal nd,decimal sum,decimal nak)
		{
			string[] result = new string[2]{"0","0"};
			if(nak == 0)
			{
				try
				{ 
					InitOraConnection(Context);
					SetRole(basic_role);
					SetParameters("nd",DB_TYPE.Decimal,nd,DIRECTION.Input);
					SetParameters("sum",DB_TYPE.Decimal,sum,DIRECTION.Input);
					ArrayList array = SQL_reader("SELECT Bars.KP_Kom(:nd,:sum,0),Bars.KP_Kom(:nd,:sum,1) from dual");
					if(array.Count != 0)
					{
						result[0] = array[0].ToString(); 
						result[1] = array[1].ToString(); 
					}
				}
				catch(System.Exception ex)
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
		public string[] getNls(string nls)
		{
			string[] result = new string[2];
			try
			{ 
				InitOraConnection(Context);
				SetRole(basic_role);
				SetParameters("nls",DB_TYPE.Varchar2,nls,DIRECTION.Input);
				ArrayList array = SQL_reader("SELECT a.nms,c.okpo from accounts a,customer c where a.rnk=c.rnk and a.nls=:nls and a.kv=980");
				if(array.Count != 0)
				{
					result[0] = array[0].ToString(); 
					result[1] = array[1].ToString(); 
				}
			}
			catch(System.Exception ex)
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
		public string[] getInfo(string lc,string tt)
		{
			string[] result = new string[20];
			try
			{ 
				InitOraConnection(Context);
				SetRole(basic_role);
				SetParameters("tt",DB_TYPE.Varchar2,tt,DIRECTION.Input);
				SetParameters("lc",DB_TYPE.Varchar2,lc,DIRECTION.Input);
				ArrayList array = SQL_reader("SELECT fio,S, Nvl(TAG,0) FROM KP_FILE WHERE tt=:tt and lc=:lc");
				if(array.Count != 0)
				{
					result[0] = array[0].ToString(); 
					result[1] = array[1].ToString(); 
					byte nTag = Convert.ToByte(array[2].ToString());
					if(nTag == 1)
					{
                        int index = 2;
                        SQL_Reader_Exec("SELECT tag,value FROM KP_TAG where TT=:tt and LC=:lc");
                        while (SQL_Reader_Read())
                        {
                            array = SQL_Reader_GetValues();
                            result[index++] = array[0].ToString().Trim() +";" + array[1].ToString().Trim();
                        }
                        SQL_Reader_Close();
					}
				}
				else
				{
					result[0] = "NULL";
					result[1] = "Лицевой счет LC="+lc+" не найден в БД(ТТ="+tt+")";
					return result;
				}
			}
			catch(System.Exception ex)
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
		
		private struct oper_stuct
		{
			public OracleConnection con; 
			public long Ref;	        // референс (NUMBER_Null для новых)
			public string TT;			// Код операции
			public byte Dk;				// ДК (0-дебет, 1-кредит)
			public short Vob;			// Вид обработки
			public string Nd;			// № док
			public DateTime DatD;		// Дата док
			public DateTime DatP;		// Дата ввода(поступления в банк)
			public DateTime DatV1;		// Дата валютирования основной операции
			public DateTime DatV2;		// Дата валютирования связаной операции
			public string NlsA;			// Счет-А
			public string NamA;			// Наим-А
			public string BankA;		// МФО-А
			public string NbA;			// Наим банка-А(м.б. '')
			public short KvA;			// Код вал-А
			public decimal SA;			// Сумма-А
			public string OkpoA;		// ОКПО-А
			public string NlsB;			// Счет-Б
			public string NamB;			// Наим-Б
			public string BankB;		// МФО-Б
			public string NbB;			// Наим банка-Б(м.б. '')
			public short KvB;			// Код вал-Б
			public decimal SB;			// Сумма-Б
			public string OkpoB;		// ОКПО-Б
			public string Nazn;			// Назначение пл
			public string Drec;			// Доп реквизиты
			public string OperId;		// Идентификатор ключа опрециониста
			public byte[] Sign;			// ЭЦП опрециониста
			public byte Sk;				// СКП
			public short Prty;			// Приоритет документа
			public decimal SQ;			// Эквивалент для одновалютной оп
		}


		//Print
		[WebMethod(EnableSession = true)]
		public string GetFilesForPrint(string[] rf)
		{
			string filename = "";
			
			for(int i = 0; i < rf.Length-1; i++)
			{
				OracleConnection con = hsql.GetUserConnection(Context);
				OracleCommand cmd = con.CreateCommand();
				cmd.CommandText = "set role start1";
				cmd.ExecuteNonQuery();
				cDocPrint ourTick = new cDocPrint(con, 
					long.Parse(rf[i]), Server.MapPath("/TEMPLATE.RPT/"));
				filename += ourTick.GetTicketFileName()+";";
			}
			return filename;
		}

		[WebMethod(EnableSession = true)]
		public string GetFilesForOttisk(string vars,string vals,string qrd_name)
		{
			try
			{
				cDocPrint dp = new cDocPrint();
				return dp.PrintOttisk(vars,vals,Server.MapPath("/TEMPLATE.RPT/")+qrd_name);
			}
			catch(System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
		}
		
		//Оплата документа
		[WebMethod(EnableSession = true)]
		public string OplDoc(string[][] docs)
		{
			string result = "";
			try
			{
				InitOraConnection(Context);
				SetRole(basic_role+",start1");
				for(int i = 0; i < docs.Length; i+=2)
				{
					result += PayDoc(docs[i],docs[i+1])+";";
				}
				return result;
			}
			catch(System.Exception ex)
			{
				SaveExeption(ex);
				throw ex;
			}
            finally
			{
				DisposeOraConnection();
			}
		}

		private string PayDoc(string[] param,string[] tags)
		{
			bool grp = true;
			if(Convert.ToInt16(param[30]) == 0) grp = false;
			oper_stuct oper = new oper_stuct();
			
			oper.con = hsql.GetUserConnection(Context);
			OracleCommand cmd = oper.con.CreateCommand();
			cmd.CommandText = "set role start1";
			cmd.ExecuteNonQuery();
			
			oper.Ref = 0;
			oper.TT = param[0];
			oper.Dk = Convert.ToByte(param[1]);
			oper.Vob = Convert.ToInt16(param[28]);
			oper.Nd = string.Empty;
			oper.DatD = Convert.ToDateTime(SQL_SELECT_scalar("SELECT sysdate from dual"),cinfo);
			oper.DatP = oper.DatD;
			oper.DatV1 = Convert.ToDateTime(DateTime.Parse(param[17]),cinfo);
			oper.DatV2 = oper.DatV1;
			oper.NlsA = param[2];
			oper.NamA = param[3];
			oper.BankA = param[4];
			oper.NbA = param[5];
			oper.KvA = Convert.ToInt16(param[6]);
			oper.SA = Convert.ToDecimal(param[7],cinfo);
			oper.OkpoA = param[8];
			oper.NbB  = param[12];
			oper.KvB = oper.KvA;
			oper.SB = oper.SA;
			oper.Nazn = param[14];
			oper.Drec = "";
			oper.OperId = "";//param[15];
			oper.Sign = new byte[0];
			oper.Sk = Convert.ToByte(param[16]);
			oper.Prty = 0;
			oper.SQ = 0;

			if(grp)
			{
				// Деб 100*  Кред 29*
				oper.NlsB = param[9];
				oper.NamB = param[10];
				oper.BankB = param[11];
				oper.OkpoB = param[8];
			}
			else
			{
				// Деб 29*  Кред 26*
				oper.NamB = param[21];
				oper.BankB = param[22];
				oper.OkpoB = param[13];
				if(oper.BankA == oper.BankB)
                    oper.NlsB = param[20];
				else 
					oper.NlsB = param[9];
			}
		
			if(oper.NamA.Length > 38)
				oper.NamA = oper.NamA.Substring(0,37);
			if(oper.NamB.Length > 38)
				oper.NamB = oper.NamB.Substring(0,37);

			cDoc ourDoc = new cDoc(oper.con,oper.Ref,oper.TT,oper.Dk,oper.Vob,oper.Nd,oper.DatD,oper.DatP,
				oper.DatV1,oper.DatV2,oper.NlsA,oper.NamA,oper.BankA,oper.NbA,oper.KvA,oper.SA,oper.OkpoA,oper.NlsB,oper.NamB,oper.BankB,oper.NbB,
				oper.KvB,oper.SB,oper.OkpoB,oper.Nazn,oper.Drec,oper.OperId,oper.Sign,oper.Sk,oper.Prty,oper.SQ,"","","",""); 
			for(int i = 0; i < tags.Length; i += 2)
			{
				if(tags[i+1] != "") ourDoc.DrecS.Add(new cDoc.Tags(tags[i],tags[i+1]));
			}
			
			if(!ourDoc.oDoc()) return "";
			if(!grp && oper.BankA != oper.BankB)
			{
				ClearParameters();
				SetParameters("nlsb",DB_TYPE.Varchar2,param[20],DIRECTION.Input);
				SetParameters("ref",DB_TYPE.Decimal,ourDoc.Ref,DIRECTION.Input);
				SQL_NONQUERY("update oper set nlsb=:nlsb where ref=:ref");
			}
			if(Convert.ToDecimal(param[26],cinfo) > 0 )
			{
				//Деб 100*  Кред 611*ФЛ
				ClearParameters();
				SetParameters("acc",DB_TYPE.Decimal,param[23],DIRECTION.Input);
				string nls6f = Convert.ToString(SQL_SELECT_scalar("select nls from accounts where acc=:acc"));
				PayV(1,ourDoc.Ref,oper.DatV1,"Э99",oper.Dk,oper.KvA,param[2],Convert.ToDecimal(param[26],cinfo)*100,oper.KvA,nls6f,Convert.ToDecimal(param[26],cinfo)*100);
			}
			if(Convert.ToDecimal(param[27],cinfo) > 0 && grp) 
			{
				//Деб 29*  Кред 611*ЮЛ
				string nls3u = param[9];
				//Деб 35*  Кред 611*ЮЛ
				if(param[25] != "")
				{
					ClearParameters();
					SetParameters("acc",DB_TYPE.Decimal,param[25],DIRECTION.Input);
					nls3u = Convert.ToString(SQL_SELECT_scalar("select nls from accounts where acc=:acc"));
				}
				ClearParameters();
				SetParameters("acc",DB_TYPE.Decimal,param[24],DIRECTION.Input);
				string nls6u = Convert.ToString(SQL_SELECT_scalar("select nls from accounts where acc=:acc"));
				PayV(1,ourDoc.Ref,oper.DatV1,"Э99",oper.Dk,oper.KvA,nls3u,Convert.ToDecimal(param[27],cinfo)*100,oper.KvA,nls6u,Convert.ToDecimal(param[27],cinfo)*100);
			}

			ClearParameters();
			SetParameters("ref",DB_TYPE.Decimal,ourDoc.Ref,DIRECTION.Input);
			SetParameters("nd",DB_TYPE.Decimal,param[18],DIRECTION.Input);
			SQL_NONQUERY("INSERT INTO operw(ref,tag,value) VALUES(:ref,'ND',:nd)");

			return ourDoc.Ref.ToString();
		}
		
		private void PayV(decimal pay,decimal rf,DateTime datv,string tt,decimal dk,decimal kva,string nlsa,decimal sa,decimal kvb,string nlsb,decimal sb)
		{
			ClearParameters();
			SetParameters("Pay",DB_TYPE.Decimal,pay,DIRECTION.Input);
			SetParameters("Ref",DB_TYPE.Decimal,rf,DIRECTION.Input);
			SetParameters("DatV",DB_TYPE.Date,datv,DIRECTION.Input);
			SetParameters("TT",DB_TYPE.Varchar2,tt,DIRECTION.Input);
			SetParameters("Dk",DB_TYPE.Decimal,dk,DIRECTION.Input);
			SetParameters("KvA",DB_TYPE.Decimal,kva,DIRECTION.Input);
			SetParameters("NlsA",DB_TYPE.Varchar2,nlsa,DIRECTION.Input);
			SetParameters("SA",DB_TYPE.Decimal,sa,DIRECTION.Input);
			SetParameters("KvB",DB_TYPE.Decimal,kvb,DIRECTION.Input);
			SetParameters("NlsB",DB_TYPE.Varchar2,nlsb,DIRECTION.Input);
			SetParameters("SB",DB_TYPE.Decimal,sb,DIRECTION.Input);
			SQL_NONQUERY("begin gl.PAYV(:Pay,:Ref,:DatV,:TT,:Dk,:KvA,:NlsA,:SA,:KvB,:NlsB,:SB);end;");
			ClearParameters();
		}
		
	#region Component Designer generated code
		
		private IContainer components = null;
				
		private void InitializeComponent()
		{
		}
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
