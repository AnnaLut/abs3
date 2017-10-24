using System.Web;
using System.Web.SessionState;
using System.Xml;
using System.Xml.Serialization;
using Oracle.DataAccess.Client;
using System.Text;
using System;
using System.Collections;
using System.Data;
using System.IO;
using Bars.Oracle;
using System.Resources;


namespace Bars.DocHand
{
	/// <summary>
	/// Summary description for cDocHand
	/// </summary>
	/// 

    public class cDocHandler : IHttpHandler, IRequiresSessionState 
	{   
		public void ProcessRequest(HttpContext context) 
		{
			// Банк	
		
			if (context.Request.QueryString["mfo"] != null )
			{
                //Alien
                if (context.Request.QueryString["nls"] != null
                   && context.Request.QueryString["kv"] != null)
                {
                    Alien alien = new Alien(context, context.Request.QueryString.Get("nls"),context.Request.QueryString.Get("kv"),context.Request.QueryString.Get("mfo"));
                    XmlSerializer sr = new XmlSerializer(typeof(Alien));

                    StringBuilder sb = new System.Text.StringBuilder();

                    TextWriter wr = new StringWriter(sb);
                    sr.Serialize(wr, alien);
                    context.Response.Write(sb.ToString());
                }
                else
                {
                    Bank bnk = new Bank(context, context.Request.QueryString.Get("mfo"));
                    XmlSerializer sr = new XmlSerializer(typeof(Bank));

                    StringBuilder sb = new System.Text.StringBuilder();

                    TextWriter wr = new StringWriter(sb);
                    sr.Serialize(wr, bnk);
                    context.Response.Write(sb.ToString());
                }
			} 
			else
				// Счет
				if (  context.Request.QueryString["nls"] != null 
				   && context.Request.QueryString["kv"] != null)
			{
				string dk = "";
				if(context.Request.QueryString["dk"] != null) dk=context.Request.QueryString.Get("dk");
				Saldo sal = new Saldo(context,context.Request.QueryString.Get("nls"),
					context.Request.QueryString.Get("kv"),
                    dk, context.Request.QueryString.Get("tt"));
				XmlSerializer sr = new XmlSerializer(typeof(Saldo));
          						
				StringBuilder sb = new System.Text.StringBuilder();
			
				TextWriter wr = new StringWriter(sb);
				sr.Serialize(wr, sal);
				context.Response.Write(sb.ToString());
			} 
			else
				// Референция
				if (context.Request.QueryString["ref"] != null )
			{
				Reference rfr = new Reference(context);
				XmlSerializer sr = new XmlSerializer(typeof(Reference));
          						
				StringBuilder sb = new System.Text.StringBuilder();
			
				TextWriter wr = new StringWriter(sb);
				sr.Serialize(wr, rfr);
				context.Response.Write(sb.ToString());
			}			
			else
				// Символ кассового плана
				if (context.Request.QueryString["sk"] != null)
			{
				SK sk = new SK(context, context.Request.QueryString.Get("sk"));
				XmlSerializer sr = new XmlSerializer(typeof(SK));
          						
				StringBuilder sb = new System.Text.StringBuilder();
			
				TextWriter wr = new StringWriter(sb);
				sr.Serialize(wr, sk);
				context.Response.Write(sb.ToString());
			}
			else
				// Кросс курс валют

				if (context.Request.QueryString["kv1"] != null
			    && context.Request.QueryString["kv2"] != null
				&& context.Request.QueryString["dat"] != null)
			{
				CrossRate rat = new CrossRate(context,
					context.Request.QueryString.Get("kv1"),	context.Request.QueryString.Get("kv2"),
					context.Request.QueryString.Get("dat"));
				XmlSerializer sr = new XmlSerializer(typeof(CrossRate));
          						
				StringBuilder sb = new System.Text.StringBuilder();
			
				TextWriter wr = new StringWriter(sb);
				sr.Serialize(wr, rat);
				context.Response.Write(sb.ToString());
			}
		}
		public class Bank
		{
			public string Mfo;        // код МФО
			public string Nb;         // наименование банка
			public string ErrMessage; // сообщение об ошибке
			private OracleConnection con;
			public Bank () {}
			public Bank ( HttpContext context,string mfo )
			{
				IOraConnection conn = (IOraConnection)context.Application["OracleConnectClass"];
				con = conn.GetUserConnection(context);

				try
				{
					OracleCommand cmd = con.CreateCommand();
					
					cmd.CommandText = conn.GetSetRoleCommand("WR_DOCHAND");
					cmd.ExecuteNonQuery();

                    cmd.CommandText = "SELECT mfo,nb FROM banks WHERE mfo=:MFO and nvl(blk,0)<>4";
					cmd.Parameters.Add("MFO", OracleDbType.Varchar2, mfo,ParameterDirection.Input);
					OracleDataReader rdr = cmd.ExecuteReader();
					if (rdr.Read())
					{
						this.Mfo  = rdr.GetOracleString(0).Value;
						this.Nb   = rdr.GetOracleString(1).Value;
					} 
					else 
					{
                        resManager rm = new resManager();
						//this.ErrMessage = "Не найдено банк "+mfo;
                        this.ErrMessage = rm.getString("ErrMfo").Replace("%1", mfo);
					}
                    rdr.Close();
                    rdr.Dispose();
				}
				finally
				{
					con.Close();
                    con.Dispose();
				}				
			}
		}
		// Символ кассового плана
		public class SK
		{
			public string Skname;     // наименование символа кассового плана
			public string ErrMessage; // сообщение об ошибке
			private OracleConnection con;
			public SK () {}
			public SK ( HttpContext context, string sk )
			{
				IOraConnection conn = (IOraConnection)context.Application["OracleConnectClass"];
				con = conn.GetUserConnection(context);

				try
				{
					OracleCommand cmd = con.CreateCommand();

					cmd.CommandText = conn.GetSetRoleCommand("WR_DOCHAND");
					cmd.ExecuteNonQuery();
			
					cmd.CommandText = "SELECT name FROM sk WHERE sk=:vSK and d_close is null";
					cmd.Parameters.Add("vSK",OracleDbType.Varchar2,sk,ParameterDirection.Input);
					OracleDataReader rdr = cmd.ExecuteReader();
					if (rdr.Read())
					{						
						this.Skname   = rdr.GetOracleString(0).Value;
					} 
					else 
					{
						this.ErrMessage = "Не найдено символ касс. плана "+sk;
					}
                    rdr.Close();
                    rdr.Dispose();
				}
				finally
				{
					con.Close();
                    con.Dispose();
				}				
			}
		}

		public class Account
		{
			//[XmlElement(ElementName = "TAG1")]
			//[XmlAttribute]
			[XmlElementAttribute(IsNullable = false)]
			
			public string  Nls;        // номер счета
			public string  Kv;         // код валюты
			public string  Ost;        // сумма
			public string  Nms;        // намиенвание счета
			public string  Nmk;        // намиенвание счета
			public string  Okpo;       // код клиента
			public string  ErrMessage; // сообщение об ошибке
			private OracleConnection con;
            public Account() {}
			public Account( HttpContext context, string nls, string kv )
			{
				IOraConnection conn = (IOraConnection)context.Application["OracleConnectClass"];
				con = conn.GetUserConnection(context);
				try
				{
					OracleCommand cmd = con.CreateCommand();
					cmd.CommandText = conn.GetSetRoleCommand("WR_DOCHAND");
					cmd.ExecuteNonQuery();
			
					cmd.CommandText = "SELECT nls,kv,ostc,nms,nmk,okpo FROM accounts a,cust_acc cu,customer c "+
						"WHERE a.acc=cu.acc AND cu.rnk=c.rnk AND a.nls=:NLS AND a.kv=:KV";
					cmd.Parameters.Add("NLS", OracleDbType.Varchar2, nls,ParameterDirection.Input);
					cmd.Parameters.Add("KV",  OracleDbType.Decimal,  kv, ParameterDirection.Input);
			
					OracleDataReader rdr = cmd.ExecuteReader();
					if (rdr.Read())
					{
						this.Nls  = rdr.GetOracleString(0).Value;
						this.Kv   = Convert.ToString(rdr.GetOracleDecimal(1).Value);
						this.Ost  = Convert.ToString(rdr.GetOracleDecimal(2).Value);
						this.Nms  = rdr.GetOracleString(3).Value;
						this.Nmk  = rdr.GetOracleString(4).Value;
						this.Okpo = rdr.GetOracleString(5).Value;
					} 
					else 
					{
						this.ErrMessage = "Не найдено счет "+nls+"("+Convert.ToString(kv)+")";
					}
                    rdr.Close();
                    rdr.Dispose();
				}
				finally
				{
					con.Close();
                    con.Dispose();
				}				
			}
		}
        //Alien
        public class Alien
        {
            [XmlElementAttribute(IsNullable = false)]

            public string Nls;        // номер счета
            public string Kv;         // код валюты
            public string Nms;        // намиенвание счета
            public string Mfo;        // Mfo банка
            public string Okpo;       // код клиента
            public string ErrMessage; // сообщение об ошибке
            private OracleConnection con;
            public Alien() { }
            public Alien(HttpContext context, string nls, string kv,string mfo)
            {
                IOraConnection conn = (IOraConnection)context.Application["OracleConnectClass"];
                con = conn.GetUserConnection(context);
                try
                {
                    OracleCommand cmd = con.CreateCommand();
                    cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = "SELECT nls,kv,mfo,name,okpo FROM alien " +
                        "WHERE nls=:NLS AND kv=:KV and mfo=:MFO and ( id=user_id or id is null) and rownum=1";
                    cmd.Parameters.Add("NLS", OracleDbType.Varchar2, nls, ParameterDirection.Input);
                    cmd.Parameters.Add("KV", OracleDbType.Decimal, kv, ParameterDirection.Input);
                    cmd.Parameters.Add("MFO", OracleDbType.Varchar2, mfo, ParameterDirection.Input);

                    OracleDataReader rdr = cmd.ExecuteReader();
                    if (rdr.Read())
                    {
                        this.Nls = Convert.ToString(rdr.GetValue(0));
                        this.Kv = Convert.ToString(rdr.GetOracleDecimal(1).Value);
                        this.Mfo = Convert.ToString(rdr.GetValue(2));
                        this.Nms = Convert.ToString(rdr.GetValue(3));
                        this.Okpo = Convert.ToString(rdr.GetValue(4));
                    }
                    else
                    {
                        this.ErrMessage = "Не найдено счет " + nls + "(" + Convert.ToString(kv) + ")";
                    }
                    rdr.Close();
                    rdr.Dispose();
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }
        }
		

		public class Saldo
		{
			[XmlElementAttribute(IsNullable = false)]
			
			public string  Nls;        // номер счета
			public string  Kv;         // код валюты
			public string  Ost;        // сумма
			public string  Nms;        // наименование счета
			public string  Nmk;        // наименование контрагента
			public string  NmkV;       // наименование контрагента международное
			public string  Okpo;       // код клиента
			public string  Country;	   // код страны контрагента
			public string  Dig;		   // знаков после запятой в валюте
			public string  ErrMessage; // сообщение об ошибке
			public string  Ostc;	   // остаток фактический	
			public string  Ostb;	   // остаток плановый	
			public string  Pap;		   // признак счета	 
		    public string  Address;    // адресс
		    public string  Locality;   // город 
		    public string  CountryName;// страна 

		    public string  DocTypeName;
            public string  DocSerial;
            public string  DocNumber;
            public string  DocIssue;
            public string  PersonSurname;
            public string  PersonName;
            public string  PersonPatr;
            public string  PersonFullName;
            public string  PersonRezId;

            //    select p.name doc_type_name, d.ser doc_serial, d.numdoc doc_num, d.organ || ' ' || to_char(d.pdate,'DD/MM/YYYY') doc_issue, fio(c.nmk,1) surname, fio(c.nmk,2) name, fio(c.nmk,3) patr, c.nmk, nvl(c.country,804) country, ca.rezid
			private OracleConnection con;
			public Saldo() {}
			public Saldo( HttpContext context, string nls, string kv, string dk, string tt)
			{
				string strDK;
                bool checkSaldo = true;
				if(""==dk) strDK = "";
				else if("0"==dk || "2"==dk) strDK = "D";
				else if("1"==dk || "3"==dk) strDK = "K";
				else 
				{					
					this.ErrMessage ="Значение DK="+dk+" задано неверно.";
					return;
				}

				IOraConnection conn = (IOraConnection)context.Application["OracleConnectClass"];
				con = conn.GetUserConnection(context);
				try
				{
					OracleCommand cmd = con.CreateCommand();
                    cmd.CommandText = conn.GetSetRoleCommand("BASIC_INFO");
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = "select val from params where par='XPS_TTS'";
                    string xps_tts = Convert.ToString(cmd.ExecuteScalar()).Trim().ToUpper();
                    cmd.CommandText = "select val from params where par='OB22'";
                    string ob22 = Convert.ToString(cmd.ExecuteScalar()).Trim().ToUpper();

                    string ob22Tail = string.Empty;
                    if ("1" == ob22)
                        ob22Tail = " AND ( p.ob22 IS NULL or EXISTS ( SELECT 1 FROM specparam_int i WHERE s.acc=i.acc AND p.ob22=i.ob22 ))";

                    string column = "1";
                    if ("Y" == xps_tts)
                        column = "nvl(x, 1)";

					cmd.CommandText = conn.GetSetRoleCommand("WR_DOCHAND");
					cmd.ExecuteNonQuery();
                    cmd.CommandText = "select " + column + " FROM ps_tts WHERE tt=:tt and dk=:dk";
                    cmd.Parameters.Add("tt", OracleDbType.Char, tt, ParameterDirection.Input);
                    cmd.Parameters.Add("dk", OracleDbType.Decimal, dk, ParameterDirection.Input);
                    string res = Convert.ToString(cmd.ExecuteScalar());
                    string sql_filter = string.Empty;

                    cmd.CommandText = "select flags FROM tts WHERE tt=:tt";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("tt", OracleDbType.Char, tt, ParameterDirection.Input);
                    string ttFlags = Convert.ToString(cmd.ExecuteScalar());
                    // 0 - основний рахунок, 1 - 
                    string side = context.Request.QueryString["n"];
                    // 26 flag
                    if (ttFlags[26] == '1' && "0" == side)
                        checkSaldo = false;
                    // 27 flag
                    if (ttFlags[27] == '1' && "1" == side)
                        checkSaldo = false;
                    // для вызова из js
                    if (context.Request.QueryString["nosaldo"] != null)
                        checkSaldo = false;

                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("NLS", OracleDbType.Varchar2, nls,ParameterDirection.Input);
					cmd.Parameters.Add("KV",  OracleDbType.Decimal,  kv, ParameterDirection.Input);
                    if (!string.IsNullOrEmpty(res))
                    {
                        cmd.Parameters.Add("tt", OracleDbType.Char, tt, ParameterDirection.Input);
                        cmd.Parameters.Add("dk", OracleDbType.Decimal, dk, ParameterDirection.Input);
                        sql_filter = " AND " + ((res == "1") ? ("") : ("NOT")) + @" EXISTS (
                                    SELECT p.nbs FROM ps_tts p
                                     WHERE p.tt=:tt and p.dk=:dk
                                      and ( LTRIM(RTRIM(p.nbs)) =  SUBSTR(s.nbs,1,1) or
                                           LTRIM(RTRIM(p.nbs)) =  SUBSTR(s.nbs,1,2) or
                                           LTRIM(RTRIM(p.nbs)) =  SUBSTR(s.nbs,1,3) or p.nbs=s.nbs)" + ob22Tail + ")";
                    }
                    cmd.CommandText = " SELECT ostc, s.nms,TRIM(NVL(k.nmkk,k.nmk)),k.nmkv,k.okpo, k.country, t.dig "
									  +" FROM saldo"+ strDK +" s,customer k,cust_acc a,tabval t "
                                      + " WHERE t.kv=s.kv AND nls = :NLS AND s.kv = :KV AND a.rnk=k.rnk AND s.acc=a.acc AND s.dazs IS NULL " + sql_filter;

                    if (!checkSaldo)
                    {
                        cmd.CommandText = cmd.CommandText.Replace("saldo" + strDK, "accounts");
                    }

                    //Logger.DBLogger.Info("DOCHAND:::" + cmd.CommandText.Replace(":tt", "'" + tt + "'").Replace(":dk", dk).Replace(":NLS", nls).Replace(":KV", kv));

					OracleDataReader rdr = cmd.ExecuteReader();
					if (rdr.Read())
					{
						this.Nls  = nls;
						this.Kv   = kv;
						if(!rdr.IsDBNull(0)) this.Ost  = Convert.ToString(rdr.GetOracleDecimal(0).Value);
						else this.Ost  = "";
						if(!rdr.IsDBNull(1)) this.Nms  = rdr.GetOracleString(1).Value;
						else this.Nms  = "";
						if(!rdr.IsDBNull(2)) this.Nmk  = rdr.GetOracleString(2).Value;
						else this.Nmk  = "";
						if(!rdr.IsDBNull(3)) this.NmkV = rdr.GetOracleString(3).Value;
						else this.NmkV = "";
						if(!rdr.IsDBNull(4)) this.Okpo = rdr.GetOracleString(4).Value;
						else this.Okpo = "";
						if(!rdr.IsDBNull(5)) this.Country = Convert.ToString(rdr.GetOracleDecimal(5).Value);
						else this.Country = "";
						if(!rdr.IsDBNull(6)) this.Dig = Convert.ToString(rdr.GetValue(6));
						else this.Dig = "";
					} 
					else 
					{
                        resManager rm = new resManager();
						//this.ErrMessage = "Счет не найден "+nls+"("+kv+")"+" или нет права на ";
                        this.ErrMessage = rm.getString("ErrSaldo").Replace("%1", nls).Replace("%2", kv);
                        if ("" == strDK)
                            this.ErrMessage += rm.getString("sSaldoView");//"просмотр";
                        else if ("D" == strDK)
                            this.ErrMessage += rm.getString("sSaldoDebet");//"дебет";
                        else if ("K" == strDK)
                            this.ErrMessage += rm.getString("sSaldoKredit");//"кредит";
						this.ErrMessage += ".";
                        return;
					}

                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("NLS", OracleDbType.Varchar2, nls, ParameterDirection.Input);
                    cmd.Parameters.Add("KV", OracleDbType.Decimal, kv, ParameterDirection.Input);
                    cmd.CommandText = "SELECT ostb,ostc,pap FROM  saldo WHERE nls = :NLS AND kv = :KV AND dazs IS NULL";
                    rdr = cmd.ExecuteReader();
                    if (rdr.Read())
                    {
                        if (!rdr.IsDBNull(0)) this.Ostb = Convert.ToString(rdr.GetValue(0));
                        else this.Ostb = "";
                        if (!rdr.IsDBNull(1)) this.Ostc = Convert.ToString(rdr.GetValue(1));
                        else this.Ostc = "";
                        if (!rdr.IsDBNull(2)) this.Pap = Convert.ToString(rdr.GetValue(2));
                        else this.Pap = "";
                    }

                    if (context.Request.QueryString["isswt"] != null)
				    {
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("NLS", OracleDbType.Varchar2, nls, ParameterDirection.Input);
                        cmd.Parameters.Add("KV", OracleDbType.Decimal, kv, ParameterDirection.Input);
                        cmd.CommandText = "select address,locality,c.name from accounts a, customer_address ca, country c where ca.country=c.country and  a.rnk=ca.rnk(+) and type_id=1 and nls=:NLS and kv=:KV";
                        rdr = cmd.ExecuteReader();
                        if (rdr.Read())
                        {
                            if (!rdr.IsDBNull(0)) this.Address = Convert.ToString(rdr.GetValue(0));
                            else this.Address = "";
                            if (!rdr.IsDBNull(1)) this.Locality = Convert.ToString(rdr.GetValue(1));
                            else this.Locality = "";
                            if (!rdr.IsDBNull(2)) this.CountryName = Convert.ToString(rdr.GetValue(2));
                            else this.CountryName = "";
                        }
				    }

                    if (context.Request.QueryString["getperson"] != null)
                    {
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("nls", OracleDbType.Varchar2, nls, ParameterDirection.Input);
                        cmd.Parameters.Add("kv", OracleDbType.Decimal, kv, ParameterDirection.Input);
                        cmd.CommandText = "select p.name doc_type_name, d.ser doc_serial, d.numdoc doc_num, d.organ || ' ' || to_char(d.pdate,'DD/MM/YYYY') doc_issue, fio(c.nmk,1) surname, fio(c.nmk,2) name, fio(c.nmk,3) patr, c.nmk, nvl(c.country,804) country, ca.rezid "+ 
                                          "from accounts a, passpt p, person d, customer c, codcagent ca where c.codcagent=ca.codcagent(+) and d.passp=p.passpt(+) and a.rnk = d.rnk and c.rnk = a.rnk and  a.nls=:nls and a.kv=:kv";
                        rdr = cmd.ExecuteReader();
                        if (rdr.Read())
                        {
                            DocTypeName = Convert.ToString(rdr.GetValue(0));
                            DocSerial = Convert.ToString(rdr.GetValue(1));
                            DocNumber = Convert.ToString(rdr.GetValue(2));
                            DocIssue = Convert.ToString(rdr.GetValue(3));
                            PersonSurname = Convert.ToString(rdr.GetValue(4));
                            PersonName = Convert.ToString(rdr.GetValue(5));
                            PersonPatr = Convert.ToString(rdr.GetValue(6));
                            PersonFullName = Convert.ToString(rdr.GetValue(7));
                            Country = Convert.ToString(rdr.GetValue(8));
                            PersonRezId = Convert.ToString(rdr.GetValue(9));
                        }
                    }

				    rdr.Close();
                    rdr.Dispose();
				}
				finally
				{
					con.Close();
                    con.Dispose();
				}				
			}
		}

		public class Reference
		{
			public string Ref;        // Референция
			public string ErrMessage; // сообщение об ошибке
			private OracleConnection con;
			public Reference () {}
			public Reference ( HttpContext context )
			{
				IOraConnection conn = (IOraConnection)context.Application["OracleConnectClass"];
				con = conn.GetUserConnection(context);
				try
				{
					OracleCommand cmd = con.CreateCommand();
					cmd.CommandText = conn.GetSetRoleCommand("WR_DOCHAND");
					cmd.ExecuteNonQuery();			

					cmd.CommandText = "gl.ref";
					cmd.CommandType = CommandType.StoredProcedure;
					cmd.Parameters.Add("ref",  OracleDbType.Decimal, this.Ref, ParameterDirection.InputOutput );  //0
					try
					{
						cmd.ExecuteNonQuery(); 
						this.Ref = cmd.Parameters["ref"].Value.ToString(); }

                    catch (System.Exception e)
					{
						this.ErrMessage = "Невозможно получить РЕФЕРЕНС";
					}
				}
				finally
				{
					con.Close();
				}				
			}
		}

		public class CrossRate
		{
			public string RatO;        // Курс официальный
			public string RatB;        // Курс покупки
			public string RatS;        // Курс продажи
			public string ErrMessage; // сообщение об ошибке
			private OracleConnection con;
			public CrossRate () {}
			public CrossRate ( HttpContext context, string kv1, string kv2, string dat )
			{
				IOraConnection conn = (IOraConnection)context.Application["OracleConnectClass"];
				con = conn.GetUserConnection(context);
				DateTime Dat = new DateTime(Convert.ToInt32(dat.Substring(0,4)),Convert.ToInt32(dat.Substring(4,2)),
					                        Convert.ToInt32(dat.Substring(6,2)));
				
				try
				{
					OracleCommand cmd = con.CreateCommand();
					cmd.CommandText = conn.GetSetRoleCommand("WR_DOCHAND");
					cmd.ExecuteNonQuery();
					
					cmd.CommandText = "select tobopack.gettobo from dual";
					
					cmd.CommandText = "SELECT VAL FROM PARAMS WHERE PAR='XRATFUN'";
					string procname = Convert.ToString(cmd.ExecuteScalar()).Trim(); 
					
					if(string.Empty == procname)
						procname = "gl.x_rat";
					
					cmd.CommandText = procname;
					cmd.CommandType = CommandType.StoredProcedure;
					cmd.Parameters.Add("RatO",  OracleDbType.Decimal, RatO, ParameterDirection.InputOutput );
					cmd.Parameters.Add("RatB",  OracleDbType.Decimal, RatB, ParameterDirection.InputOutput );
					cmd.Parameters.Add("RatS",  OracleDbType.Decimal, RatS, ParameterDirection.InputOutput );
					cmd.Parameters.Add("Kv1",   OracleDbType.Decimal, kv1,  ParameterDirection.Input );
					cmd.Parameters.Add("Kv2",   OracleDbType.Decimal, kv2,  ParameterDirection.Input );
					cmd.Parameters.Add("Dat",   OracleDbType.Date,    Dat,  ParameterDirection.Input );  
					
					cmd.ExecuteNonQuery(); 
					this.RatO = cmd.Parameters["RatO"].Value.ToString();
					this.RatB = cmd.Parameters["RatB"].Value.ToString(); 
					this.RatS = cmd.Parameters["RatS"].Value.ToString(); 
					
				}
				finally
				{
					con.Close();
				}				
			}
		}

        public class resManager
        {
            private string ui_culture;
            private ResourceManager rm;
            public resManager()
            {
                ui_culture = System.Threading.Thread.CurrentThread.CurrentUICulture.Name.Substring(0, 2);
                rm = Resources.Bars.DocHand.Resource.ResourceManager;
            }
            public string getString(string key)
            {
                return rm.GetString(key + "_" + ui_culture);
            }
        }

		public bool IsReusable 
		{
			// To enable pooling, return true here.
			// This keeps the handler in memory.
			get { return false; }  
		}
	}
}
