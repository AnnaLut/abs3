using System.Collections;
using System.ComponentModel;
using System.Globalization;
using System.Web.Services;
using System;
using Bars;

namespace CustomerList
{
	public class CustService : BarsWebService
	{
		string base_role = "wr_custlist";

		CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
		public CustService()
		{
			InitializeComponent();
			cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
			cinfo.DateTimeFormat.DateSeparator = "/";
		}
		#region Component Designer generated code
		private IContainer components = null;
			
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

		[WebMethod(EnableSession = true)]
		public object[] GetData(string[] data)
		{
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
                return BindTableWithNewFilter("DISTINCT a.rnk RNK, a.okpo OKPO, a.nd ND,a.custname NAME,DECODE(TRIM(a.sed),'91','V','') B, a.nmk NMK,TO_CHAR(a.date_on,'DD/MM/YYYY') DAT_ON,TO_CHAR(a.date_off,'DD/MM/YYYY') DAT_OFF, a.branch BRANCH,a.date_on,a.date_off,decode(a.branch,sys_context('bars_context', 'user_branch'),1,0) branch_owner", "V_TOBO_CUST" + data[10] + " a", "", data);
			}
			finally
			{
				DisposeOraConnection();
			}
		}

		[WebMethod(EnableSession = true)]
		public string CloseCustomer(string rnk)
		{
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				int count = Convert.ToInt32(SQL_SELECT_scalar("SELECT count(*) FROM accounts a, cust_acc ca WHERE a.acc=ca.acc and ca.rnk="+rnk+" and a.dazs is null").ToString());
				if(count != 0)
					return "У клиента в наличии "+count+" незакрытых счетов!";
				DateTime date = Convert.ToDateTime(SQL_SELECT_scalar("SELECT date_on FROM customer WHERE rnk="+rnk),cinfo);
				DateTime bdate = Convert.ToDateTime(SQL_SELECT_scalar("SELECT bankdate FROM dual"),cinfo);
				if(bdate < date)
					return "Клиент не может быть закрыт датой ("+bdate.ToShortDateString()+"), меньшей даты открытия ("+date.ToShortDateString()+").";
				SetParameters("date_off",DB_TYPE.Date,bdate,DIRECTION.Input);
				SetParameters("rnk",DB_TYPE.Decimal,rnk,DIRECTION.Input);
                SQL_NONQUERY("UPDATE customer SET date_off=:date_off WHERE rnk=:rnk");
				return "";
			}
			finally
			{
				DisposeOraConnection();
			}
		}

		[WebMethod(EnableSession = true)]
		public string  ResurectCustomer(string rnk)
		{
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				string d = Convert.ToString(SQL_SELECT_scalar("SELECT date_off FROM customer WHERE rnk="+rnk));
				if(d == "") return "Клиент не закрыт!";
				DateTime date = Convert.ToDateTime(d,cinfo);
				DateTime bdate = Convert.ToDateTime(SQL_SELECT_scalar("SELECT bankdate FROM dual"),cinfo);
				if(bdate < date)
					return "Клиент не может быть перерегистрирован датой ("+bdate.ToShortDateString()+"), меньшей даты открытия ("+date.ToShortDateString()+").";
				SetParameters("rnk",DB_TYPE.Decimal,rnk,DIRECTION.Input);
				SQL_NONQUERY("UPDATE customer SET date_off=NULL WHERE rnk=:rnk");
				return "";
			}
			finally
			{
				DisposeOraConnection();
			}
		}
		[WebMethod(EnableSession = true)]
		public object[] ShowHistory(string[] data)
		{
			object[] obj = new object[5];
			string rnk = data[9];
			string date1 = data[10]; 
			string date2 = data[11]; 
			string Mode = data[12]; 
			string type = data[13]; 
			string role = base_role;
			try
			{
				InitOraConnection(Context);
				switch (type)
				{
					case "0" : 
						role = "wr_custlist";
						break;
					case "1" : 
						role = "WR_USER_ACCOUNTS_LIST";
						break;
					case "2" : 
						role = "WR_TOBO_ACCOUNTS_LIST";
						break;
					case "3" : 
						role = "WR_ND_ACCOUNTS";
						break;
					case "4" : 
						role = "WR_DEPOSIT_U";
						break;
                    default: 
                        role = "wr_custlist";
                        break;
				}

				SetRole(role);
				if(date1 == "" || date2 == "" )
				{
					ArrayList reader = SQL_reader("select TO_CHAR(bankdate,'DD.MM.YYYY'),TO_CHAR(ADD_MONTHS(bankdate,-1),'DD.MM.YYYY') from dual");
					date2 = Convert.ToString(reader[0]);
					date1 = Convert.ToString(reader[1]);
				}
				SetParameters("mode",DB_TYPE.Decimal,Mode,DIRECTION.Input);
				SetParameters("rnk",DB_TYPE.Decimal,rnk,DIRECTION.Input);
				SetParameters("date1",DB_TYPE.Date,Convert.ToDateTime(date1,cinfo),DIRECTION.Input);
				SetParameters("date2",DB_TYPE.Date,Convert.ToDateTime(date2,cinfo),DIRECTION.Input);
				SQL_NONQUERY("BEGIN p_acchist(:mode,:rnk,:date1,:date2); END;");
				ClearParameters();
				SetParameters("rnk",DB_TYPE.Decimal,rnk,DIRECTION.Input);
				object[] temp = BindTableWithFilter("c.semantic PAR,upper(t.tabname) TABNAME,h.valold OLD, h.valnew NEW, TO_CHAR(h.dat,'DD/MM/YYYY') DAT, h.isp USR, s.fio FIO","meta_tables t, meta_columns c, tmp_acchist h, staff s","h.iduser=user_id AND h.acc=:rnk AND h.tabid=t.tabid AND t.tabid=c.tabid AND h.colid=c.colid AND h.isp=s.logname","c.semantic",data);
				obj[0] = temp[0];
				obj[1] = temp[1];
				obj[2] = date1;
				obj[3] = date2;
				ClearParameters();
				SetParameters("rnk",DB_TYPE.Decimal,rnk,DIRECTION.Input);
				obj[4] = Convert.ToString(SQL_SELECT_scalar("select '(РНК '||rnk||',НД '||nd||').'||nmk from v_tobo_cust where rnk=:rnk"));
				return obj;
			}
			
			finally
			{
				DisposeOraConnection();
			}
		}

        [WebMethod(EnableSession = true)]
        public object[] ShowHistoryImmobile(string[] data)
        {
            object[] obj = new object[5];
            string key = data[9];
            string date1 = data[10];
            string date2 = data[11];
            try
            {
                InitOraConnection(Context);
                ClearParameters();
                string cond = "key=:key";
                SetParameters("key", DB_TYPE.Decimal, key, DIRECTION.Input);
                if (date1 != "" && date2 != "")
                {
                    SetParameters("date1", DB_TYPE.Varchar2, date1.Replace('.', '/'), DIRECTION.Input);
                    SetParameters("date2", DB_TYPE.Varchar2, date2.Replace('.', '/'), DIRECTION.Input);
                    cond += " and TRUNC(TO_DATE(chgdate), 'DD') BETWEEN to_date(:date1, 'dd/MM/yyyy') and to_date(:date2, 'dd/MM/yyyy')";
                }
                object[] temp = BindTableWithFilter("tag as PAR, old, new, TO_CHAR(chgdate,'DD/MM/YYYY HH24:MI:SS') DAT, donebuy as USR, fio", "v_asvo_immobile_history", cond, "tag", data);
                obj[0] = temp[0];
                obj[1] = temp[1];
                obj[2] = date1;
                obj[3] = date2;
                ClearParameters();
                return obj;
            }

            finally
            {
                DisposeOraConnection();
            }
        }

        [WebMethod(EnableSession = true)]
		public object[] GetCustAcc(string[] data)
		{
			object[] obj = new object[3];
			try
			{
				InitOraConnection(Context);
				string rnk = data[9];
				string type = data[10];
				string nd = data[11];
				string title = string.Empty;
				string table = string.Empty;
				string where = string.Empty;

				string sql = "DECODE(a.DAZS,NULL,1,2) MOD,"+
					"a.acc ACC,"+
					"a.nls NLS,"+
                    "a.lcv LCV,"+
                    "a.rnk RNK," +
					"a.nms NMS,"+
					"DECODE(a.pap,'1','A','2','П','3','А/П') PAP,"+
					"a.tip TIP,"+
					"TO_CHAR(a.dapp,'DD.MM.YYYY') DAPP,"+
					"a.dazs,"+
					"a.tobo TOBO,"+
					"a.ost OST,"+
					"a.dos DOS,"+
					"a.kos KOS,"+
					"a.ostc OSTC,"+
					"a.denom as DIG,"+
                    "a.blkd as BLKD," +
                    "a.blkk as BLKK," +
					"a.ostb OSTB";

                string localBD = Convert.ToString(Session["LocalBDate"]);
				if(type == "0")
				{
					SetRole(base_role);
					SetParameters("rnk",DB_TYPE.Decimal,rnk,DIRECTION.Input);
				
					if( (title = Convert.ToString(SQL_SELECT_scalar("select '(РНК '||rnk||',НД '||nd||').'||nmk from v_tobo_cust where rnk=:rnk"))) == "")
						throw new Exception("Нет доступа к просмотру счетов даного контрагента!");
					where  = "a.acc in (select acc from cust_acc where rnk=:rnk)";
                    
                    if(localBD == "1")
    					table = "V_TOBO_ACCOUNTS";
                    else
                        table = "V_TOBO_ACCOUNTS_LITE";
				}
				else if(type == "1")
				{
					SetRole("WR_USER_ACCOUNTS_LIST");
                    if (localBD == "1")
					    table = "WEB_SAL";
                    else 
                        table = "WEB_SAL_LITE";
				}
				else if(type == "2")
				{
					SetRole("WR_TOBO_ACCOUNTS_LIST");
                    if (localBD == "1")
					    table = "V_TOBO_ACCOUNTS";
                    else
                        table = "V_TOBO_ACCOUNTS_LITE";
				}
				else if(type == "3")
				{
					SetRole("WR_ND_ACCOUNTS");
					SetParameters("nd",DB_TYPE.Decimal,nd,DIRECTION.Input);
					table = "V_ND_ACCOUNTS";
					where  = "a.nd=:nd";
				}
				else if(type == "4")
				{
					SetRole("WR_DEPOSIT_U");
					if( (title = Convert.ToString(SQL_SELECT_scalar("select '(РНК '||rnk||',НД '||nd||').'||nmk from v_tobo_cust where rnk="+rnk+""))) == "")
						throw new Exception("Нет доступа к просмотру счетов даного контрагента!");
					table = "V_ACCOUNTS ";
					where  = "a.acc in("+data[12]+")";
				}
				
				obj = BindTableWithNewFilter(sql,table+" a",where,data);
				obj[2] = title;
				return obj; 
			}
			finally
			{
				DisposeOraConnection();
			}
		}

		[WebMethod(EnableSession = true)]
		public object[] GetDataHistory(string[] data)
		{
			InitOraConnection(Context);
			object[] result = new object[4];
			try
			{
				string type = data[13];
				string role = string.Empty;
				string table = string.Empty;
				switch (type)
				{
					case "0" : 
						role = "wr_custlist";
						table = "V_TOBO_ACCOUNTS";
						break;
					case "1" : 
						role = "WR_USER_ACCOUNTS_LIST";
						table = "WEB_SAL";
						break;
					case "2" : 
						role = "WR_TOBO_ACCOUNTS_LIST";
						table = "V_TOBO_ACCOUNTS";
						break;
					case "3" : 
						role = "WR_ND_ACCOUNTS";
						table = "V_ND_ACCOUNTS";
						break;
					case "4" : 
						role = "WR_DEPOSIT_U";
						table = "V_ACCOUNTS";
						break;
					default : throw new Exception("Неверный параметр type!");
				}

				SetRole(role);
				
				CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");	
				cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
				cinfo.DateTimeFormat.DateSeparator = ".";

				DateTime srtDate = Convert.ToDateTime(data[11].Trim(), cinfo);
				DateTime endDate = Convert.ToDateTime(data[12].Trim(), cinfo);
				long acc = Convert.ToInt64(data[10].Trim(), cinfo);

				string filter = " FDAT BETWEEN :srtDate and :endDate and ACC = :pacc ";

				ClearParameters();
				SetParameters("pacc", DB_TYPE.Int64, acc, DIRECTION.Input);
                ArrayList reader = SQL_reader("SELECT NLS,'№'||NLS||'('||LCV||')' FROM "+table+" WHERE ACC = :pacc");
				if(reader.Count == 0)
					throw new Exception("История данного счета недоступна текущему пользователю.");

                string title = Resources.customerlist.GlobalResources.titleHistory + " " + Convert.ToString(reader[1]);
                string nls = Convert.ToString(reader[0]);

				ClearParameters();
				SetParameters("srtDate", DB_TYPE.Date, srtDate, DIRECTION.Input);
				SetParameters("endDate", DB_TYPE.Date, endDate, DIRECTION.Input);
				SetParameters("pacc", DB_TYPE.Int64, acc, DIRECTION.Input);

                object[] xml = BindTableWithFilter(@" a.acc,
                                                    (select power(10, t.dig)
                                                       from tabval t
                                                      where t.kv = (select ac.kv from accounts ac where ac.acc = a.acc)) as dig,
                                                    to_char(a.fdat, 'dd.mm.yyyy') as ch_fdat,
                                                    a.ostf as ch_ostf,
                                                    a.dos as ch_dos,
                                                    a.kos as ch_kos,
                                                    (a.ostf + a.kos - a.dos) as ch_ost ", "saldoa a", filter, data);
				result[0] = xml[0];
				result[1] = xml[1];
				result[2] = title;
				result[3] = nls;

			}
			finally
			{
				DisposeOraConnection();
			}	
			return result;
		}

		[WebMethod(EnableSession = true)]
		public string ReanimAcc(string acc)
		{
			string result = "Счет ";
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				SetParameters("acc",DB_TYPE.Decimal,acc,DIRECTION.Input);
				if (Convert.ToString(SQL_SELECT_scalar("SELECT c.date_off FROM customer c, cust_acc b WHERE c.rnk=b.rnk AND b.acc=:acc")) != "")
				{
					return result+"не может быть восстановлен, так как закрыт контрагент";
				}
				string dat1 = Convert.ToString(SQL_SELECT_scalar("select TO_CHAR(bankdate,'DD.MM.YYYY') from dual"));
				string dat2 = Convert.ToString(SQL_SELECT_scalar("SELECT TO_CHAR(DAZS,'DD.MM.YYYY') FROM accounts WHERE acc=:acc"));
				if ((dat2 == "") || (dat1 != dat2))
				{
					return result + "не может быть восстановлен, так как не был закрыт вообще или закрыт не сегодня.";
				}
				SQL_NONQUERY("UPDATE accounts SET dazs=NULL WHERE acc=:acc AND dazs IS NOT NULL");
				result += "восстановлен!";
			}
			finally
			{
				DisposeOraConnection();
			}
			return result;
		}
		[WebMethod(EnableSession = true)]
		public int ReRegistr(string acc,string rnk_old,string rnk_new)
		{
			try
			{
				InitOraConnection(Context);
				SetRole(base_role);
				DateTime d1 = Convert.ToDateTime(SQL_SELECT_scalar("SELECT DAOS FROM accounts where acc="+acc),cinfo);
				DateTime d2 = Convert.ToDateTime(SQL_SELECT_scalar("SELECT bankdate FROM dual"),cinfo);
				if(d1 == d2)
					return SQL_NONQUERY("BEGIN accreg.changeAccountOwner("+acc+","+rnk_old+","+rnk_new+");END;");
				else
					return 0;
			}
			finally
			{
				DisposeOraConnection();
			}
		}
	}
}
