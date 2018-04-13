using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.Exception;
using System.Globalization;
using System.Collections;
using Bars.Web.Report;
using System.IO;
using Oracle.DataAccess.Types;
using Bars.Classes;
using Bars;

/// <summary>
/// 
/// </summary>
public class safe_deposit
{
    /// ID сейфа
    public decimal safe_id;
    /// Номер сейфа
    public string safe_num;
    /// Код типу сейфа
    public decimal safe_type_id;
    /// Розмір
    public string safe_type_name;
    /// Видано ключ (0 - ні, 1 - так)
    public decimal key_used;
    /// Номер ключа
    public string key_number;
    /// Кількість виданих ключів
    public decimal key_count;
    /// Застава (в коп.) (вал = грн)
    public decimal bail_sum;
    /// Код валюти
    public decimal kv;
    /// Символьний код валюти
    public string lcv;
    /// Код рахунку
    public decimal acc;
    /// Рахунок
    public string nls;
    /// Фактичний залишок (коп.)
    public decimal ostc;
    /// Плановий залишок (коп.)
    public decimal ostb;
    /// Дата останньої проплати
    public DateTime mdate;
    public decimal account_man_id;
    /// Відповідальний виконавець по рахунку
    public string account_man;
    public decimal safe_man_id;
    /// Відповідальний виконавець по сейфу
    public string safe_man;
    public decimal bank_trustee_id;
    /// Довірена особа банку
    public string bank_trustee;
    public decimal deal_id;
    public string deal_num;
        /// Код тарифу
    public decimal tarif_id;
    public decimal sos;
    public DateTime deal_date;
    public DateTime deal_start_date;
    public DateTime deal_end_date;
    /// Тривалість (в днях)
    public decimal deal_length;
    /// Тип клієнта
    public decimal custtype;
    public string fio;
    public string okpo;
    public string doc;
    public string issued;
    public string address;
    public string birthplace;
    public DateTime birthdate;
    public string phone;
    public string NMK;
    public string nlsk;
    public string mfok;
    public string bankk;
    public string trustee_fio;
    public string trustee_okpo;
    public string trustee_doc;
    public string trustee_issued;
    public string trustee_address;
    public string trustee_birthplace;
    public DateTime trustee_birthdate;
    public string trustee_deal_num;
    public DateTime trustee_deal_start;
    public DateTime trustee_deal_end;
    
    public decimal RENT_SUM;
    public decimal PDV;
    public decimal DAY_PAYMENT;
    public decimal DISCOUNT;
    public decimal PENY;
	public decimal AMORT_INCOME;
    public decimal PLAN_PAY;
    public decimal P_LEFT;
    public decimal FACT_PAY;
    public decimal F_LEFT;
    public decimal NDS2;
    public decimal CUR_INCOME;
    public decimal F_INCOME;

    public ArrayList EXTRA_PROPS;
    /// <summary>
    /// 
    /// </summary>
    public safe_deposit(){ Clear(); }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="safe_id"></param>
    /// <param name="nd"></param>
    public safe_deposit(decimal safe_id, decimal nd){ Clear(); ReadFromDatabase(safe_id, nd); }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="safe_id"></param>
    public safe_deposit(decimal safe_id) { Clear(); ReadFromDatabase(safe_id); }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="safe_id"></param>
    public void ReadFromDatabase(decimal psafe_id, decimal pnd)
    {
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";

        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdReadSafe = connect.CreateCommand();
            cmdReadSafe.CommandText = @"select N_SK, SNUM, O_SK, TYPE, KEYUSED, KEYNUMBER, KEYCOUNT, BAIL_SUM, KV, LCV, ACC, NLS, OSTC, OSTB,
                MDATE, ACC_ISP, ACC_ISP_NAME, SAFE_ISP, SAFE_ISP_NAME,BANK_TR,BANK_TR_NAME,
                ND,NUM, TARIFF,SOS, DOC_DATE,DAT_BEGIN,DAT_END, CUSTTYPE,FIO,OKPO,DOCNUM, ISSUED,ADDRESS,MR,DATR,TEL, JNMK,
                NLSK,MFOK,NB,DOV_FIO, DOV_OKPO, DOV_DOCNUM, DOV_ISSUED, DOV_ADDRESS, DOV_MR, DOV_DATR, NDOV, DOV_DAT_BEGIN, DOV_DAT_END,
	            RENT_SUM, PDV, DAY_PAYMENT, DISCOUNT, PENY,
	            AMORT_INCOME,PLAN_PAY,P_LEFT,FACT_PAY, F_LEFT, NDS2, CUR_INCOME,F_INCOME
                from v_safe_deposit
                WHERE N_SK = :N_SK and ND = :ND";
            cmdReadSafe.Parameters.Add("N_SK", OracleDbType.Decimal, psafe_id, ParameterDirection.Input);
            cmdReadSafe.Parameters.Add("ND", OracleDbType.Decimal, pnd, ParameterDirection.Input);

            OracleDataReader rdr = cmdReadSafe.ExecuteReader();

            if (!rdr.Read())
                throw new SafeDepositException("Депозитна скринька з номером " + psafe_id + 
                    " не знайдена!");

            if (!rdr.IsDBNull(0))
                this.safe_id = Convert.ToDecimal(rdr.GetValue(0));
            if (!rdr.IsDBNull(1))
                this.safe_num = Convert.ToString(rdr.GetValue(1));
            if (!rdr.IsDBNull(2))
                this.safe_type_id = Convert.ToDecimal(rdr.GetValue(2));
            if (!rdr.IsDBNull(3))
                this.safe_type_name = Convert.ToString(rdr.GetValue(3));
            if (!rdr.IsDBNull(4))
                this.key_used = Convert.ToDecimal(rdr.GetValue(4));
            if (!rdr.IsDBNull(5))
                this.key_number = Convert.ToString(rdr.GetValue(5));
            if (!rdr.IsDBNull(6))
                this.key_count = Convert.ToDecimal(rdr.GetValue(6));
            if (!rdr.IsDBNull(7))
                this.bail_sum = Convert.ToDecimal(rdr.GetValue(7));
            if (!rdr.IsDBNull(8))
                this.kv = Convert.ToDecimal(rdr.GetValue(8));
            if (!rdr.IsDBNull(9))
                this.lcv = Convert.ToString(rdr.GetValue(9));
            if (!rdr.IsDBNull(10))
                this.acc = Convert.ToDecimal(rdr.GetValue(10));
            if (!rdr.IsDBNull(11))
                this.nls = Convert.ToString(rdr.GetValue(11));
            if (!rdr.IsDBNull(12))
                this.ostc = Convert.ToDecimal(rdr.GetValue(12));
            if (!rdr.IsDBNull(13))
                this.ostb = Convert.ToDecimal(rdr.GetValue(13));
            if (!rdr.IsDBNull(14))
                this.mdate = Convert.ToDateTime(rdr.GetValue(14),cinfo);
            else
                this.mdate = DateTime.MinValue;
            if (!rdr.IsDBNull(15))
                this.account_man_id = Convert.ToDecimal(rdr.GetValue(15));
            if (!rdr.IsDBNull(16))
                this.account_man = Convert.ToString(rdr.GetValue(16));
            if (!rdr.IsDBNull(17))
                this.safe_man_id = Convert.ToDecimal(rdr.GetValue(17));
            if (!rdr.IsDBNull(18))
                this.safe_man = Convert.ToString(rdr.GetValue(18));
            if (!rdr.IsDBNull(19))
                this.bank_trustee_id = Convert.ToDecimal(rdr.GetValue(19));
            if (!rdr.IsDBNull(20))
                this.bank_trustee = Convert.ToString(rdr.GetValue(20));
            if (!rdr.IsDBNull(21))
                this.deal_id = Convert.ToDecimal(rdr.GetValue(21));
            if (!rdr.IsDBNull(22))
                this.deal_num = Convert.ToString(rdr.GetValue(22));
            if (!rdr.IsDBNull(23))
                this.tarif_id = Convert.ToDecimal(rdr.GetValue(23));
            if (!rdr.IsDBNull(24))
                this.sos = Convert.ToDecimal(rdr.GetValue(24));
            if (!rdr.IsDBNull(25))
                this.deal_date = Convert.ToDateTime(rdr.GetValue(25),cinfo);
            else
                this.deal_date = DateTime.MinValue;
            if (!rdr.IsDBNull(26))
                this.deal_start_date = Convert.ToDateTime(rdr.GetValue(26),cinfo);
            else
                this.deal_start_date = DateTime.MinValue;
            if (!rdr.IsDBNull(27))
                this.deal_end_date = Convert.ToDateTime(rdr.GetValue(27),cinfo);
            else
                this.deal_end_date = DateTime.MinValue;
            if (deal_start_date != DateTime.MinValue && deal_end_date != DateTime.MinValue)
                this.deal_length = ((TimeSpan)(deal_end_date - deal_start_date)).Days + 1;
            else
                this.deal_length = 0;
            if (!rdr.IsDBNull(28))
                this.custtype = Convert.ToDecimal(rdr.GetValue(28));
            if (!rdr.IsDBNull(29))
                this.fio = Convert.ToString(rdr.GetValue(29));
            if (!rdr.IsDBNull(30))
                this.okpo = Convert.ToString(rdr.GetValue(30));
            if (!rdr.IsDBNull(31))
                this.doc = Convert.ToString(rdr.GetValue(31));
            if (!rdr.IsDBNull(32))
                this.issued = Convert.ToString(rdr.GetValue(32));
            if (!rdr.IsDBNull(33))
                this.address = Convert.ToString(rdr.GetValue(33));
            if (!rdr.IsDBNull(34))
                this.birthplace = Convert.ToString(rdr.GetValue(34));
            if (!rdr.IsDBNull(35))
                this.birthdate = Convert.ToDateTime(rdr.GetValue(35),cinfo);
            if (!rdr.IsDBNull(36))
                this.phone = Convert.ToString(rdr.GetValue(36));
            if (!rdr.IsDBNull(37))
                this.NMK = Convert.ToString(rdr.GetValue(37));
            if (!rdr.IsDBNull(38))
                this.nlsk = Convert.ToString(rdr.GetValue(38));
            if (!rdr.IsDBNull(39))
                this.mfok = Convert.ToString(rdr.GetValue(39));
            if (!rdr.IsDBNull(40))
                this.bankk = Convert.ToString(rdr.GetValue(40));
            if (!rdr.IsDBNull(41))
                this.trustee_fio = Convert.ToString(rdr.GetValue(41));
            if (!rdr.IsDBNull(42))
                this.trustee_okpo = Convert.ToString(rdr.GetValue(42));
            if (!rdr.IsDBNull(43))
                this.trustee_doc = Convert.ToString(rdr.GetValue(43));
            if (!rdr.IsDBNull(44))
                this.trustee_issued = Convert.ToString(rdr.GetValue(44));
            if (!rdr.IsDBNull(45))
                this.trustee_address = Convert.ToString(rdr.GetValue(45));
            if (!rdr.IsDBNull(46))
                this.trustee_birthplace = Convert.ToString(rdr.GetValue(46));
            if (!rdr.IsDBNull(47))
                this.trustee_birthdate = Convert.ToDateTime(rdr.GetValue(47), cinfo);
            else
                this.trustee_birthdate = DateTime.MinValue;
            if (!rdr.IsDBNull(48))
                this.trustee_deal_num = Convert.ToString(rdr.GetValue(48));
            if (!rdr.IsDBNull(49))
                this.trustee_deal_start = Convert.ToDateTime(rdr.GetValue(49), cinfo);
            else
                this.trustee_deal_start = DateTime.MinValue;
            if (!rdr.IsDBNull(50))
                this.trustee_deal_end = Convert.ToDateTime(rdr.GetValue(50), cinfo);
            else
                this.trustee_deal_end = DateTime.MinValue;

            if (!rdr.IsDBNull(51))
                this.RENT_SUM = Convert.ToDecimal(rdr.GetValue(51));
            if (!rdr.IsDBNull(52))
                this.PDV = Convert.ToDecimal(rdr.GetValue(52));
            if (!rdr.IsDBNull(53))
                this.DAY_PAYMENT = Convert.ToDecimal(rdr.GetValue(53));
            if (!rdr.IsDBNull(54))
                this.DISCOUNT = Convert.ToDecimal(rdr.GetValue(54));
            if (!rdr.IsDBNull(55))
                this.PENY = Convert.ToDecimal(rdr.GetValue(55));
            if (!rdr.IsDBNull(56))
                this.AMORT_INCOME = Convert.ToDecimal(rdr.GetValue(56));
            if (!rdr.IsDBNull(57))
                this.PLAN_PAY = Convert.ToDecimal(rdr.GetValue(57));
            if (!rdr.IsDBNull(58))
                this.P_LEFT = Convert.ToDecimal(rdr.GetValue(58));
            if (!rdr.IsDBNull(59))
                this.FACT_PAY = Convert.ToDecimal(rdr.GetValue(59));
            if (!rdr.IsDBNull(60))
                this.F_LEFT = Convert.ToDecimal(rdr.GetValue(60));
            if (!rdr.IsDBNull(61))
                this.NDS2 = Convert.ToDecimal(rdr.GetValue(61));
            if (!rdr.IsDBNull(62))
                this.CUR_INCOME = Convert.ToDecimal(rdr.GetValue(62));
            if (!rdr.IsDBNull(63))
                this.F_INCOME = Convert.ToDecimal(rdr.GetValue(63));

            if (!rdr.IsClosed) rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="safe_id"></param>
    public void ReadFromDatabase(decimal psafe_id)
    {
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";

        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdReadSafe = connect.CreateCommand();
            cmdReadSafe.CommandText = @"select N_SK, SNUM, O_SK, TYPE, KEYUSED, KEYNUMBER, KEYCOUNT, BAIL_SUM, KV, LCV, ACC, NLS, OSTC, OSTB,
                MDATE, ACC_ISP, ACC_ISP_NAME, SAFE_ISP, SAFE_ISP_NAME,BANK_TR,BANK_TR_NAME,
                ND,NUM, TARIFF,SOS, DOC_DATE,DAT_BEGIN,DAT_END, CUSTTYPE,FIO,OKPO,DOCNUM, ISSUED,ADDRESS,MR,DATR,TEL, JNMK,
                NLSK,MFOK,NB,DOV_FIO, DOV_OKPO, DOV_DOCNUM, DOV_ISSUED, DOV_ADDRESS, DOV_MR, DOV_DATR, NDOV, DOV_DAT_BEGIN, DOV_DAT_END,
	            RENT_SUM, PDV, DAY_PAYMENT, DISCOUNT, PENY,
	            AMORT_INCOME,PLAN_PAY,P_LEFT,FACT_PAY, F_LEFT, NDS2, CUR_INCOME,F_INCOME
                from v_safe_deposit
                WHERE N_SK = :N_SK";
            cmdReadSafe.Parameters.Add("N_SK", OracleDbType.Decimal, psafe_id, ParameterDirection.Input);

            OracleDataReader rdr = cmdReadSafe.ExecuteReader();

            if (!rdr.Read())
                throw new SafeDepositException("Депозитна скринька з номером " + psafe_id +
                    " не знайдена!");

            if (!rdr.IsDBNull(0))
                this.safe_id = Convert.ToDecimal(rdr.GetValue(0));
            if (!rdr.IsDBNull(1))
                this.safe_num = Convert.ToString(rdr.GetValue(1));
            if (!rdr.IsDBNull(2))
                this.safe_type_id = Convert.ToDecimal(rdr.GetValue(2));
            if (!rdr.IsDBNull(3))
                this.safe_type_name = Convert.ToString(rdr.GetValue(3));
            if (!rdr.IsDBNull(4))
                this.key_used = Convert.ToDecimal(rdr.GetValue(4));
            if (!rdr.IsDBNull(5))
                this.key_number = Convert.ToString(rdr.GetValue(5));
            if (!rdr.IsDBNull(6))
                this.key_count = Convert.ToDecimal(rdr.GetValue(6));
            if (!rdr.IsDBNull(7))
                this.bail_sum = Convert.ToDecimal(rdr.GetValue(7));
            if (!rdr.IsDBNull(8))
                this.kv = Convert.ToDecimal(rdr.GetValue(8));
            if (!rdr.IsDBNull(9))
                this.lcv = Convert.ToString(rdr.GetValue(9));
            if (!rdr.IsDBNull(10))
                this.acc = Convert.ToDecimal(rdr.GetValue(10));
            if (!rdr.IsDBNull(11))
                this.nls = Convert.ToString(rdr.GetValue(11));
            if (!rdr.IsDBNull(12))
                this.ostc = Convert.ToDecimal(rdr.GetValue(12));
            if (!rdr.IsDBNull(13))
                this.ostb = Convert.ToDecimal(rdr.GetValue(13));
            if (!rdr.IsDBNull(14))
                this.mdate = Convert.ToDateTime(rdr.GetValue(14), cinfo);
            else
                this.mdate = DateTime.MinValue;
            if (!rdr.IsDBNull(15))
                this.account_man_id = Convert.ToDecimal(rdr.GetValue(15));
            if (!rdr.IsDBNull(16))
                this.account_man = Convert.ToString(rdr.GetValue(16));
            if (!rdr.IsDBNull(17))
                this.safe_man_id = Convert.ToDecimal(rdr.GetValue(17));
            if (!rdr.IsDBNull(18))
                this.safe_man = Convert.ToString(rdr.GetValue(18));
            if (!rdr.IsDBNull(19))
                this.bank_trustee_id = Convert.ToDecimal(rdr.GetValue(19));
            if (!rdr.IsDBNull(20))
                this.bank_trustee = Convert.ToString(rdr.GetValue(20));
            if (!rdr.IsDBNull(21))
                this.deal_id = Convert.ToDecimal(rdr.GetValue(21));
            if (!rdr.IsDBNull(22))
                this.deal_num = Convert.ToString(rdr.GetValue(22));
            if (!rdr.IsDBNull(23))
                this.tarif_id = Convert.ToDecimal(rdr.GetValue(23));
            if (!rdr.IsDBNull(24))
                this.sos = Convert.ToDecimal(rdr.GetValue(24));
            if (!rdr.IsDBNull(25))
                this.deal_date = Convert.ToDateTime(rdr.GetValue(25), cinfo);
            else
                this.deal_date = DateTime.MinValue;
            if (!rdr.IsDBNull(26))
                this.deal_start_date = Convert.ToDateTime(rdr.GetValue(26), cinfo);
            else
                this.deal_start_date = DateTime.MinValue;
            if (!rdr.IsDBNull(27))
                this.deal_end_date = Convert.ToDateTime(rdr.GetValue(27), cinfo);
            else
                this.deal_end_date = DateTime.MinValue;
            if (deal_start_date != DateTime.MinValue && deal_end_date != DateTime.MinValue)
                this.deal_length = ((TimeSpan)(deal_end_date - deal_start_date)).Days + 1;
            else
                this.deal_length = 0;
            if (!rdr.IsDBNull(28))
                this.custtype = Convert.ToDecimal(rdr.GetValue(28));
            if (!rdr.IsDBNull(29))
                this.fio = Convert.ToString(rdr.GetValue(29));
            if (!rdr.IsDBNull(30))
                this.okpo = Convert.ToString(rdr.GetValue(30));
            if (!rdr.IsDBNull(31))
                this.doc = Convert.ToString(rdr.GetValue(31));
            if (!rdr.IsDBNull(32))
                this.issued = Convert.ToString(rdr.GetValue(32));
            if (!rdr.IsDBNull(33))
                this.address = Convert.ToString(rdr.GetValue(33));
            if (!rdr.IsDBNull(34))
                this.birthplace = Convert.ToString(rdr.GetValue(34));
            if (!rdr.IsDBNull(35))
                this.birthdate = Convert.ToDateTime(rdr.GetValue(35), cinfo);
            if (!rdr.IsDBNull(36))
                this.phone = Convert.ToString(rdr.GetValue(36));
            if (!rdr.IsDBNull(37))
                this.NMK = Convert.ToString(rdr.GetValue(37));
            if (!rdr.IsDBNull(38))
                this.nlsk = Convert.ToString(rdr.GetValue(38));
            if (!rdr.IsDBNull(39))
                this.mfok = Convert.ToString(rdr.GetValue(39));
            if (!rdr.IsDBNull(40))
                this.bankk = Convert.ToString(rdr.GetValue(40));
            if (!rdr.IsDBNull(41))
                this.trustee_fio = Convert.ToString(rdr.GetValue(41));
            if (!rdr.IsDBNull(42))
                this.trustee_okpo = Convert.ToString(rdr.GetValue(42));
            if (!rdr.IsDBNull(43))
                this.trustee_doc = Convert.ToString(rdr.GetValue(43));
            if (!rdr.IsDBNull(44))
                this.trustee_issued = Convert.ToString(rdr.GetValue(44));
            if (!rdr.IsDBNull(45))
                this.trustee_address = Convert.ToString(rdr.GetValue(45));
            if (!rdr.IsDBNull(46))
                this.trustee_birthplace = Convert.ToString(rdr.GetValue(46));
            if (!rdr.IsDBNull(47))
                this.trustee_birthdate = Convert.ToDateTime(rdr.GetValue(47), cinfo);
            else
                this.trustee_birthdate = DateTime.MinValue;
            if (!rdr.IsDBNull(48))
                this.trustee_deal_num = Convert.ToString(rdr.GetValue(48));
            if (!rdr.IsDBNull(49))
                this.trustee_deal_start = Convert.ToDateTime(rdr.GetValue(49), cinfo);
            else
                this.trustee_deal_start = DateTime.MinValue;
            if (!rdr.IsDBNull(50))
                this.trustee_deal_end = Convert.ToDateTime(rdr.GetValue(50), cinfo);
            else
                this.trustee_deal_end = DateTime.MinValue;

            if (!rdr.IsDBNull(51))
                this.RENT_SUM = Convert.ToDecimal(rdr.GetValue(51));
            if (!rdr.IsDBNull(52))
                this.PDV = Convert.ToDecimal(rdr.GetValue(52));
            if (!rdr.IsDBNull(53))
                this.DAY_PAYMENT = Convert.ToDecimal(rdr.GetValue(53));
            if (!rdr.IsDBNull(54))
                this.DISCOUNT = Convert.ToDecimal(rdr.GetValue(54));
            if (!rdr.IsDBNull(55))
                this.PENY = Convert.ToDecimal(rdr.GetValue(55));
            if (!rdr.IsDBNull(56))
                this.AMORT_INCOME = Convert.ToDecimal(rdr.GetValue(56));
            if (!rdr.IsDBNull(57))
                this.PLAN_PAY = Convert.ToDecimal(rdr.GetValue(57));
            if (!rdr.IsDBNull(58))
                this.P_LEFT = Convert.ToDecimal(rdr.GetValue(58));
            if (!rdr.IsDBNull(59))
                this.FACT_PAY = Convert.ToDecimal(rdr.GetValue(59));
            if (!rdr.IsDBNull(60))
                this.F_LEFT = Convert.ToDecimal(rdr.GetValue(60));
            if (!rdr.IsDBNull(61))
                this.NDS2 = Convert.ToDecimal(rdr.GetValue(61));
            if (!rdr.IsDBNull(62))
                this.CUR_INCOME = Convert.ToDecimal(rdr.GetValue(62));
            if (!rdr.IsDBNull(63))
                this.F_INCOME = Convert.ToDecimal(rdr.GetValue(63));

            if (!rdr.IsClosed) rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    public void Clear()
    {
        this.safe_id = Decimal.MinValue;
        this.safe_num = String.Empty;
        this.safe_type_id = Decimal.MinValue;
        this.safe_type_name = String.Empty;
        this.key_used = Decimal.MinValue;
        this.key_number = String.Empty;
        this.key_count = Decimal.MinValue;
        this.bail_sum = Decimal.MinValue;
        this.kv = Decimal.MinValue;
        this.lcv = String.Empty;
        this.acc = Decimal.MinValue;
        this.nls = String.Empty;
        this.ostc = Decimal.MinValue;
        this.ostb = Decimal.MinValue;
        this.mdate = DateTime.MinValue;
        this.account_man_id = Decimal.MinValue;
        this.account_man = String.Empty;
        this.safe_man_id = Decimal.MinValue;
        this.safe_man = String.Empty;
        this.bank_trustee_id = Decimal.MinValue;
        this.bank_trustee = String.Empty;
        this.deal_id = Decimal.MinValue;
        this.deal_num = String.Empty;
        this.tarif_id = Decimal.MinValue;
        this.sos = Decimal.MinValue;
        this.deal_date = DateTime.MinValue;
        this.deal_start_date = DateTime.MinValue;
        this.deal_end_date = DateTime.MinValue;
        this.deal_length = 0;
        this.custtype = Decimal.MinValue;
        this.fio = String.Empty;
        this.okpo = String.Empty;
        this.doc = String.Empty;
        this.issued = String.Empty;
        this.address = String.Empty;
        this.birthplace = String.Empty;
        this.birthdate = DateTime.MinValue;
        this.phone = String.Empty;
        this.NMK = String.Empty;
        this.nlsk = String.Empty;
        this.mfok = String.Empty;
        this.bankk = String.Empty;
        this.trustee_fio = String.Empty;
        this.trustee_okpo = String.Empty;
        this.trustee_doc = String.Empty;
        this.trustee_issued = String.Empty;
        this.trustee_address = String.Empty;
        this.trustee_birthplace = String.Empty;
        this.trustee_birthdate = DateTime.MinValue;
        this.trustee_deal_num = String.Empty;
        this.trustee_deal_start = DateTime.MinValue;
        this.trustee_deal_end = DateTime.MinValue;

        this.RENT_SUM = 0;
        this.PDV = 0;
        this.DAY_PAYMENT = 0;
        this.DISCOUNT = 0;
        this.PENY = 0;
        this.AMORT_INCOME = 0;
        this.PLAN_PAY = 0;
        this.P_LEFT = 0;
        this.FACT_PAY = 0;
        this.F_LEFT = 0;
        this.NDS2 = 0;
        this.CUR_INCOME = 0;
        this.F_INCOME = 0;

        this.EXTRA_PROPS = new ArrayList();
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="safe_id"></param>
    /// <param name="safe_type_code"></param>
    /// <param name="nls"></param>
    public void CreateSafe(String safe_id, Decimal safe_type_code, String nls)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdCreateSafe = connect.CreateCommand();
            cmdCreateSafe.CommandText = "begin safe_deposit.create_safe(:safe_id,:safe_type_id,:nls); end;";
            cmdCreateSafe.Parameters.Add("safe_id", OracleDbType.Varchar2, safe_id, ParameterDirection.Input);
            cmdCreateSafe.Parameters.Add("safe_type_id", OracleDbType.Decimal, safe_type_code, ParameterDirection.Input);
            cmdCreateSafe.Parameters.Add("nls", OracleDbType.Varchar2, nls, ParameterDirection.Input);

            cmdCreateSafe.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="safe_id"></param>
    public void DeleteSafe(Decimal safe_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSelectSafeType = connect.CreateCommand();
            cmdSelectSafeType.CommandText = "BEGIN safe_deposit.close_safe (:safe_id); END;";
            cmdSelectSafeType.Parameters.Add("safe_id", OracleDbType.Decimal, safe_id, ParameterDirection.Input);

            cmdSelectSafeType.ExecuteNonQuery();

        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    public void WriteToDataBase()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdCreateDeal = connect.CreateCommand();
            cmdCreateDeal.CommandText = "begin safe_deposit.DEAL (" +
                ":P_SAFE_ID,:p_safe_type_id,:p_key_used,:p_key_number,:p_key_count,:p_bail_sum, " +
                ":p_safe_man_id,:p_bank_trustee_id,:p_deal_id,:p_deal_num,:p_tarif_id,:p_deal_date, " +
                ":p_deal_start_date,:p_deal_end_date,:p_custtype,:p_fio,:p_okpo,:p_doc,:p_issued,:p_address, " +
                ":p_birthplace,:p_birthdate,:p_phone,:p_NMK,:p_nlsk,:p_mfok,:p_trustee_fio,:p_trustee_okpo, " +
                ":p_trustee_doc,:p_trustee_issued,:p_trustee_address,:p_trustee_birthplace,:p_trustee_birthdate, " +
                ":p_trustee_deal_num,:p_trustee_deal_start,:p_trustee_deal_end);end;";

            cmdCreateDeal.Parameters.Add("safe_id", OracleDbType.Decimal, safe_id, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("safe_type_id", OracleDbType.Decimal, safe_type_id, ParameterDirection.Input);
            if (key_used != Decimal.MinValue)
                cmdCreateDeal.Parameters.Add("p_key_used", OracleDbType.Decimal, key_used, ParameterDirection.Input);
            else
                cmdCreateDeal.Parameters.Add("p_key_used", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_key_number", OracleDbType.Varchar2, key_number, ParameterDirection.Input);
            if (key_count != Decimal.MinValue)
                cmdCreateDeal.Parameters.Add("p_key_count", OracleDbType.Decimal, key_count, ParameterDirection.Input);
            else
                cmdCreateDeal.Parameters.Add("p_key_count", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_bail_sum", OracleDbType.Decimal, bail_sum, ParameterDirection.Input);
            if (safe_man_id != Decimal.MinValue)
                cmdCreateDeal.Parameters.Add("p_safe_man_id", OracleDbType.Decimal, safe_man_id, ParameterDirection.Input);
            else
                cmdCreateDeal.Parameters.Add("p_safe_man_id", OracleDbType.Decimal, null, ParameterDirection.Input);
            if (bank_trustee_id != Decimal.MinValue)
                cmdCreateDeal.Parameters.Add("p_bank_trustee_id", OracleDbType.Decimal, bank_trustee_id, ParameterDirection.Input);
            else
                cmdCreateDeal.Parameters.Add("p_bank_trustee_id", OracleDbType.Decimal, null, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_deal_id", OracleDbType.Decimal, deal_id, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_deal_num", OracleDbType.Varchar2, deal_num, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_tarif_id", OracleDbType.Decimal, tarif_id, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_deal_date", OracleDbType.Date, deal_date, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_deal_start_date", OracleDbType.Date, deal_start_date, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_deal_end_date", OracleDbType.Date, deal_end_date, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_custtype", OracleDbType.Decimal, custtype, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_fio", OracleDbType.Varchar2, fio, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_okpo", OracleDbType.Varchar2, okpo, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_doc", OracleDbType.Varchar2, doc, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_issued", OracleDbType.Varchar2, issued, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_address", OracleDbType.Varchar2, address, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_birthplace", OracleDbType.Varchar2, birthplace, ParameterDirection.Input);
            if (birthdate != DateTime.MinValue)
                cmdCreateDeal.Parameters.Add("p_birthdate", OracleDbType.Date, birthdate, ParameterDirection.Input);
            else
                cmdCreateDeal.Parameters.Add("p_birthdate", OracleDbType.Date, null, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_phone", OracleDbType.Varchar2, phone, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_NMK", OracleDbType.Varchar2, NMK, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_nlsk", OracleDbType.Varchar2, nlsk, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_mfok", OracleDbType.Varchar2, mfok, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_trustee_fio", OracleDbType.Varchar2, trustee_fio, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_trustee_okpo", OracleDbType.Varchar2, trustee_okpo, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_trustee_doc", OracleDbType.Varchar2, trustee_doc, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_trustee_issued", OracleDbType.Varchar2, trustee_issued, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_trustee_address", OracleDbType.Varchar2, trustee_address, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_trustee_birthplace", OracleDbType.Varchar2, trustee_birthplace, ParameterDirection.Input);
            if (trustee_birthdate!= DateTime.MinValue)
                cmdCreateDeal.Parameters.Add("p_trustee_birthdate", OracleDbType.Date, trustee_birthdate, ParameterDirection.Input);
            else
                cmdCreateDeal.Parameters.Add("p_trustee_birthdate", OracleDbType.Date, null, ParameterDirection.Input);
            cmdCreateDeal.Parameters.Add("p_trustee_deal_num", OracleDbType.Varchar2, trustee_deal_num, ParameterDirection.Input);
            if (trustee_deal_start != DateTime.MinValue)
                cmdCreateDeal.Parameters.Add("p_trustee_deal_start", OracleDbType.Date, trustee_deal_start, ParameterDirection.Input);
            else
                cmdCreateDeal.Parameters.Add("p_trustee_deal_start", OracleDbType.Date, null, ParameterDirection.Input);
            if (trustee_deal_end != DateTime.MinValue)
                cmdCreateDeal.Parameters.Add("p_trustee_deal_end", OracleDbType.Date, trustee_deal_end, ParameterDirection.Input);
            else
                cmdCreateDeal.Parameters.Add("p_trustee_deal_end", OracleDbType.Date, null, ParameterDirection.Input);

            cmdCreateDeal.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="p_safe_id"></param>
    public void CloseDeal(Decimal p_safe_id, Decimal p_contract_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("dep_skrn,basic_info");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSelectSafeType = connect.CreateCommand();
            cmdSelectSafeType.CommandText = "BEGIN SKRN.P_DEP_SKRN( bankdate,bankdate, :N_SK , 1, :ND ); END;";
            cmdSelectSafeType.Parameters.Add("N_SK", OracleDbType.Decimal, p_safe_id, ParameterDirection.Input);
            cmdSelectSafeType.Parameters.Add("ND", OracleDbType.Decimal, p_contract_id, ParameterDirection.Input);

            cmdSelectSafeType.ExecuteNonQuery();

        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="p_safe_id"></param>
    /// <returns></returns>
    public void ReadExtraFields(Decimal p_safe_id, Decimal nd_ref)
    {
        this.EXTRA_PROPS.Clear();

        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("dep_skrn");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetFields = connect.CreateCommand();
            cmdGetFields.CommandText = "select st.tag, t.name, substr(n.txt,1,254) " +
                "from skrynka_nd s, skrynka_tag st, cc_tag t, nd_txt n " +
                    "where  t.TAG = n.TAG(+) " +
                        "and n.nd(+) = :nd " +
                        "and st.tag = t.tag " +
                        "and nvl(st.custtype,s.custtype) = s.custtype " +
                        "and s.n_sk = :N_SK " +
                        "and s.nd = :nd " +
                    "order by t.tag ";

            cmdGetFields.Parameters.Add("nd", OracleDbType.Decimal, nd_ref, ParameterDirection.Input);
            cmdGetFields.Parameters.Add("N_SK", OracleDbType.Decimal, p_safe_id, ParameterDirection.Input);
            cmdGetFields.Parameters.Add("nd", OracleDbType.Decimal, nd_ref, ParameterDirection.Input);

            safe_deposit_extra_field field;
            String tag, name, val;

            OracleDataReader rdr = cmdGetFields.ExecuteReader();
            
            while (rdr.Read())
            {
                tag = String.Empty;
                val = String.Empty;
                name = String.Empty;

                if (!rdr.IsDBNull(0))
                    tag = Convert.ToString(rdr.GetValue(0));
                if (!rdr.IsDBNull(1))
                    name = Convert.ToString(rdr.GetValue(1));
                if (!rdr.IsDBNull(2))
                    val = Convert.ToString(rdr.GetValue(2));

                field = new safe_deposit_extra_field(tag, name, val);

                this.EXTRA_PROPS.Add(field);
            }
            if (!rdr.IsClosed) rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="p_safe_id"></param>
    /// <param name="nd_ref"></param>
    public void WriteExtraFields(Decimal nd_ref)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("dep_skrn");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSetFields = connect.CreateCommand();
            cmdSetFields.CommandText = "BEGIN SAFE_DEPOSIT.SET_EXTRA_FIELD(:ND,:TAG,:VAL); END;";

            for (int i = 0; i < this.EXTRA_PROPS.Count; i++)
            {
                cmdSetFields.Parameters.Clear();
                safe_deposit_extra_field field = (safe_deposit_extra_field)this.EXTRA_PROPS[i];

                cmdSetFields.Parameters.Add("ND",OracleDbType.Decimal,nd_ref,ParameterDirection.Input);
                cmdSetFields.Parameters.Add("TAG", OracleDbType.Varchar2, field.tag, ParameterDirection.Input);
                cmdSetFields.Parameters.Add("VAL", OracleDbType.Varchar2, field.val, ParameterDirection.Input);

                cmdSetFields.ExecuteNonQuery();
            }            
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="m_nd"></param>
    /// <param name="m_ref"></param>
    /// <param name="doBind"></param>
    public void BindUnbindDoc(Decimal m_nd, Decimal m_ref, bool doBind)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            Decimal bind = 0;
            if (doBind) bind = 1;
                
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("dep_skrn");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSelectSafeType = connect.CreateCommand();
            cmdSelectSafeType.CommandText = "BEGIN safe_deposit.BIND_DOC(:P_ND,:P_REF,:P_BIND_UNBIND); END;";
            cmdSelectSafeType.Parameters.Add("P_ND", OracleDbType.Decimal, m_nd, ParameterDirection.Input);
            cmdSelectSafeType.Parameters.Add("P_REF", OracleDbType.Decimal, m_ref, ParameterDirection.Input);
            cmdSelectSafeType.Parameters.Add("P_BIND_UNBIND", OracleDbType.Decimal, bind, ParameterDirection.Input);            

            cmdSelectSafeType.ExecuteNonQuery();

        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="n_sk"></param>
    /// <param name="item"></param>
    /// <param name="dat1"></param>
    /// <param name="dat2"></param>
    /// <param name="numpar"></param>
    public void Pay(Decimal n_sk, Decimal item, DateTime dat1, DateTime dat2, String numpar)
    {
        OracleConnection connect = new OracleConnection();

        try
        {              
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("dep_skrn");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSelectSafeType = connect.CreateCommand();
            cmdSelectSafeType.CommandText = "begin SKRN.P_DEP_SKRN( :DAT1,:DAT2, :N_SK , :item, :nExecNpar ); end;";
            if (dat1 == DateTime.MinValue)
                cmdSelectSafeType.Parameters.Add("DAT1", OracleDbType.Date, null, ParameterDirection.Input);
            else
                cmdSelectSafeType.Parameters.Add("DAT1", OracleDbType.Date, dat1, ParameterDirection.Input);

            if (dat2 == DateTime.MinValue)
                cmdSelectSafeType.Parameters.Add("DAT2", OracleDbType.Date, null, ParameterDirection.Input);
            else
                cmdSelectSafeType.Parameters.Add("DAT2", OracleDbType.Date, dat2, ParameterDirection.Input);
            cmdSelectSafeType.Parameters.Add("N_SK", OracleDbType.Decimal, n_sk, ParameterDirection.Input);
            cmdSelectSafeType.Parameters.Add("item", OracleDbType.Decimal, item, ParameterDirection.Input);
            
            if (String.IsNullOrEmpty(numpar))
                cmdSelectSafeType.Parameters.Add("nExecNpar", OracleDbType.Decimal, null, ParameterDirection.Input);
            else
                cmdSelectSafeType.Parameters.Add("nExecNpar", OracleDbType.Decimal, numpar, ParameterDirection.Input);

            cmdSelectSafeType.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="m_nd"></param>
    /// <param name="m_adds"></param>
    /// <param name="template"></param>
    public void SignDoc(Decimal m_nd, Decimal m_adds, String template)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("dep_skrn");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSelectSafeType = connect.CreateCommand();
            cmdSelectSafeType.CommandText = "UPDATE CC_DOCS SET STATE=2, VERSION=SYSDATE " +
                " WHERE id=:template " +
                "   AND nd=:nd " +
                "   AND adds=:adds ";
            cmdSelectSafeType.Parameters.Add("template", OracleDbType.Varchar2, template, ParameterDirection.Input);
            cmdSelectSafeType.Parameters.Add("nd", OracleDbType.Decimal, m_nd, ParameterDirection.Input);
            cmdSelectSafeType.Parameters.Add("adds", OracleDbType.Decimal, m_adds, ParameterDirection.Input);

            cmdSelectSafeType.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="m_nd"></param>
    /// <param name="template"></param>
    public void InsertNewDoc(Decimal m_nd, String template)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("dep_skrn");
            cmdSetRole.ExecuteNonQuery();

            RtfReporter rep = new RtfReporter(HttpContext.Current);
            rep.RoleList = "basic_info,dep_skrn";
            rep.ContractNumber = (long)m_nd;
            rep.TemplateID = template;
            OracleClob repText = new OracleClob(connect);



                OracleCommand cmd = connect.CreateCommand();
                cmd.CommandText = @"select file_name from DOC_SCHEME where id = :TemplateID";
                cmd.Parameters.Add("TemplateID", OracleDbType.Varchar2, template, ParameterDirection.Input);

                String p_file_name = Convert.ToString(cmd.ExecuteScalar());

                if (String.IsNullOrEmpty(p_file_name))
                {
                    try
                    {
                        rep.Generate();

                        StreamReader sr = new StreamReader(rep.ReportFile, System.Text.Encoding.GetEncoding(1251));
                        char[] text = null;
                        String str = sr.ReadToEnd();
                        sr.Close();
                        text = str.ToCharArray();

                        File.Delete(rep.ReportFile);

                        repText.Write(text, 0, text.Length);

                        OracleCommand cmdInsDoc = connect.CreateCommand();

                        cmdInsDoc.CommandText = "begin safe_deposit.INSERT_DOC(:P_ND,:P_TEMPLATE,:p_text); end;";
                        cmdInsDoc.Parameters.Add("P_ND", OracleDbType.Decimal, m_nd, ParameterDirection.Input);
                        cmdInsDoc.Parameters.Add("P_TEMPLATE", OracleDbType.Varchar2, template, ParameterDirection.Input);
                        cmdInsDoc.Parameters.Add("p_text", OracleDbType.Clob, repText, ParameterDirection.Input);

                        cmdInsDoc.ExecuteNonQuery();

                        cmdInsDoc.Dispose();
                    }
                    finally
                    {
                        repText.Close();
                        repText.Dispose();

                        rep.DeleteReportFiles();
                    }


                }

                else
                {

                    FrxParameters pars = new FrxParameters();

                    pars.Add(new FrxParameter("p_nd", TypeCode.Decimal, m_nd));
                    


                    FrxDoc doc = new FrxDoc(
                      FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(p_file_name)) + p_file_name, pars, null);
                    {
                        try
                        {
                            
                            StreamReader sr = new StreamReader(doc.Export(FrxExportTypes.Rtf), System.Text.Encoding.GetEncoding(1251));
                            char[] text = null;
                            String str = sr.ReadToEnd();
                            sr.Close();
                            text = str.ToCharArray();

                            File.Delete(rep.ReportFile);

                            repText.Write(text, 0, text.Length);

                            OracleCommand cmdInsDoc = connect.CreateCommand();

                            cmdInsDoc.CommandText = "begin safe_deposit.INSERT_DOC(:P_ND,:P_TEMPLATE,:p_text); end;";
                            cmdInsDoc.Parameters.Add("P_ND", OracleDbType.Decimal, m_nd, ParameterDirection.Input);
                            cmdInsDoc.Parameters.Add("P_TEMPLATE", OracleDbType.Varchar2, template, ParameterDirection.Input);
                            cmdInsDoc.Parameters.Add("p_text", OracleDbType.Clob, repText, ParameterDirection.Input);

                            cmdInsDoc.ExecuteNonQuery();

                            cmdInsDoc.Dispose();
                        }
                        finally
                        {
                            repText.Close();
                            repText.Dispose();

                            rep.DeleteReportFiles();
                        }
                    
                    }



                }


        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

    

    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="m_nls"></param>
    /// <param name="m_nd"></param>
    public void Open3600(String m_nls, Decimal m_nd)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("dep_skrn");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSelectSafeType = connect.CreateCommand();
            cmdSelectSafeType.CommandText = "BEGIN safe_deposit.open_3600(:P_ND,:P_NLS); END;";
            cmdSelectSafeType.Parameters.Add("P_ND", OracleDbType.Decimal, m_nd, ParameterDirection.Input);
            cmdSelectSafeType.Parameters.Add("P_NLS", OracleDbType.Varchar2, m_nls, ParameterDirection.Input);

            cmdSelectSafeType.ExecuteNonQuery();

        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

    public static String GetOwnerByNum(Decimal ND)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"select fio from skrynka_nd where nd  = :nd";
            cmd.Parameters.Add("nd", OracleDbType.Decimal, ND, ParameterDirection.Input);

            return Convert.ToString(cmd.ExecuteScalar());
        }
        ///// Перехоплюємо бо ASP.NET ajax НІЯК не обробляє викинуті помилки
        catch (Exception ex)
        {
            SaveException(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    public static String GetNumById(Decimal safe_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"select snum from skrynka where n_sk = :n_sk";
            cmd.Parameters.Add("n_sk", OracleDbType.Decimal, safe_id, ParameterDirection.Input);

            return Convert.ToString(cmd.ExecuteScalar());
        }
        ///// Перехоплюємо бо ASP.NET ajax НІЯК не обробляє викинуті помилки
        catch (Exception ex)
        {
            SaveException(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

    public static void Amort()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "begin for k in (select distinct branch from skrynka_nd) loop bc.subst_branch(k.branch); SKRN.P_DEP_SKRN(null,null,null,22,null); end loop; end;";

            cmd.ExecuteNonQuery();
        }
        ///// Перехоплюємо бо ASP.NET ajax НІЯК не обробляє викинуті помилки
        catch (Exception ex)
        {
            SaveException(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="ex"></param>
    public static void SaveException(System.Exception ex)
    {
        ErrorPageGenerator ergen = new ErrorPageGenerator();
        bool fullInfo =
            ((Bars.Configuration.ConfigurationSettings.GetCurrentUserInfo.errormode == "1") ? (true) : (false));
        string hash = HttpContext.Current.Request.UserAgent;
        hash += HttpContext.Current.Request.UserHostAddress;
        hash += HttpContext.Current.Request.UserHostName;

        string key = hash.GetHashCode().ToString();
        AppDomain.CurrentDomain.SetData(key, ergen.GetHtmlErrorPage(ex, fullInfo));
    }

}
/// <summary>
/// 
/// </summary>
public class safe_deposit_extra_field
{
    public string name;
    public string val;
    public string tag;
    public safe_deposit_extra_field(string p_tag, string p_name, string p_val)
    { tag = p_tag; name = p_name; val = p_val; }
}
