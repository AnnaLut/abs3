/*
    AUTOGENERATED! Do not modify this code. 
*/

using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Collections.Specialized;
using System.Data;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using ibank.core;

namespace ibank.objlayer
{
    public sealed class VDpztArcAccountsRecord : BbRecord
    {
        public VDpztArcAccountsRecord(BbDataSource Parent) : base (Parent)
        {
            Fields.Add( new BbField("REC_ID", OracleDbType.Decimal, false, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Ід. запису"));
            Fields.Add( new BbField("REC_DATE", OracleDbType.Date, false, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Дата запису"));
            Fields.Add( new BbField("REC_ACTION", OracleDbType.Varchar2, false, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Тип дії"));
            Fields.Add( new BbField("REC_USERNAME", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Ім'я користувача"));
            Fields.Add( new BbField("ACC", OracleDbType.Decimal, false, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Ід. рахунку"));
            Fields.Add( new BbField("KF", OracleDbType.Varchar2, false, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Код філіалу"));
            Fields.Add( new BbField("NLS", OracleDbType.Varchar2, false, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Номер рахунку"));
            Fields.Add( new BbField("KV", OracleDbType.Decimal, false, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Код валюти"));
            Fields.Add( new BbField("BLK", OracleDbType.Decimal, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Ознака блокування"));
            Fields.Add( new BbField("ACTYPE", OracleDbType.Decimal, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Тип рахунку"));
            Fields.Add( new BbField("TYPRST", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Тип залишку"));
            Fields.Add( new BbField("SGNRST", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Знак залишку"));
            Fields.Add( new BbField("DTOPEN", OracleDbType.Date, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Дата відкриття"));
            Fields.Add( new BbField("DTCLOSE", OracleDbType.Date, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Дата закриття"));
            Fields.Add( new BbField("ACNMS", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Найменування рахунку"));
            Fields.Add( new BbField("CHRCNT", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Хар. контрагенту"));
            Fields.Add( new BbField("NMCNT", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Найменування контрагенту"));
            Fields.Add( new BbField("TINCNT", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Код ОКПО"));
            Fields.Add( new BbField("DOGCNT", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Номер договору"));
            Fields.Add( new BbField("DOGCNTDT", OracleDbType.Date, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Дата договору"));
            Fields.Add( new BbField("K040", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "K040"));
            Fields.Add( new BbField("K050", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "K050"));
            Fields.Add( new BbField("K060", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "K060"));
            Fields.Add( new BbField("K070", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "K070"));
            Fields.Add( new BbField("K080", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "K080"));
            Fields.Add( new BbField("K090", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "K090"));
            Fields.Add( new BbField("K110", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "K110"));
            Fields.Add( new BbField("K140", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "K140"));
            Fields.Add( new BbField("S040", OracleDbType.Date, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "S040"));
            Fields.Add( new BbField("S050", OracleDbType.Date, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "S050"));
            Fields.Add( new BbField("S080", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "S080"));
            Fields.Add( new BbField("S120", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "S120"));
            Fields.Add( new BbField("S180", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "S180"));
            Fields.Add( new BbField("S190", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "S190"));
            Fields.Add( new BbField("S230", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "S230"));
            Fields.Add( new BbField("R011", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "R011"));
            Fields.Add( new BbField("R013", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "R013"));
            Fields.Add( new BbField("PRS", OracleDbType.Decimal, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Проц. ставка"));
            Fields.Add( new BbField("ISCLCR", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Ознака валюти"));
            Fields.Add( new BbField("IUSRNM", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_ACCOUNTS", ObjectTypes.View, "Інтерфейс ОДБ. Архів розпоряждень рахунків", "Користувач"));
        }
        public VDpztArcAccountsRecord(BbDataSource Parent, OracleDecimal RowScn, OracleDecimal REC_ID, OracleDate REC_DATE, OracleString REC_ACTION, OracleString REC_USERNAME, OracleDecimal ACC, OracleString KF, OracleString NLS, OracleDecimal KV, OracleDecimal BLK, OracleDecimal ACTYPE, OracleString TYPRST, OracleString SGNRST, OracleDate DTOPEN, OracleDate DTCLOSE, OracleString ACNMS, OracleString CHRCNT, OracleString NMCNT, OracleString TINCNT, OracleString DOGCNT, OracleDate DOGCNTDT, OracleString K040, OracleString K050, OracleString K060, OracleString K070, OracleString K080, OracleString K090, OracleString K110, OracleString K140, OracleDate S040, OracleDate S050, OracleString S080, OracleString S120, OracleString S180, OracleString S190, OracleString S230, OracleString R011, OracleString R013, OracleDecimal PRS, OracleString ISCLCR, OracleString IUSRNM)
            : this(Parent)
        {
            this.REC_ID = REC_ID;
            this.REC_DATE = REC_DATE;
            this.REC_ACTION = REC_ACTION;
            this.REC_USERNAME = REC_USERNAME;
            this.ACC = ACC;
            this.KF = KF;
            this.NLS = NLS;
            this.KV = KV;
            this.BLK = BLK;
            this.ACTYPE = ACTYPE;
            this.TYPRST = TYPRST;
            this.SGNRST = SGNRST;
            this.DTOPEN = DTOPEN;
            this.DTCLOSE = DTCLOSE;
            this.ACNMS = ACNMS;
            this.CHRCNT = CHRCNT;
            this.NMCNT = NMCNT;
            this.TINCNT = TINCNT;
            this.DOGCNT = DOGCNT;
            this.DOGCNTDT = DOGCNTDT;
            this.K040 = K040;
            this.K050 = K050;
            this.K060 = K060;
            this.K070 = K070;
            this.K080 = K080;
            this.K090 = K090;
            this.K110 = K110;
            this.K140 = K140;
            this.S040 = S040;
            this.S050 = S050;
            this.S080 = S080;
            this.S120 = S120;
            this.S180 = S180;
            this.S190 = S190;
            this.S230 = S230;
            this.R011 = R011;
            this.R013 = R013;
            this.PRS = PRS;
            this.ISCLCR = ISCLCR;
            this.IUSRNM = IUSRNM;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        public OracleDecimal REC_ID { get { return (OracleDecimal)FindField("REC_ID").Value; } set {SetField("REC_ID", value);} }
        public OracleDate REC_DATE { get { return (OracleDate)FindField("REC_DATE").Value; } set {SetField("REC_DATE", value);} }
        public OracleString REC_ACTION { get { return (OracleString)FindField("REC_ACTION").Value; } set {SetField("REC_ACTION", value);} }
        public OracleString REC_USERNAME { get { return (OracleString)FindField("REC_USERNAME").Value; } set {SetField("REC_USERNAME", value);} }
        public OracleDecimal ACC { get { return (OracleDecimal)FindField("ACC").Value; } set {SetField("ACC", value);} }
        public OracleString KF { get { return (OracleString)FindField("KF").Value; } set {SetField("KF", value);} }
        public OracleString NLS { get { return (OracleString)FindField("NLS").Value; } set {SetField("NLS", value);} }
        public OracleDecimal KV { get { return (OracleDecimal)FindField("KV").Value; } set {SetField("KV", value);} }
        public OracleDecimal BLK { get { return (OracleDecimal)FindField("BLK").Value; } set {SetField("BLK", value);} }
        public OracleDecimal ACTYPE { get { return (OracleDecimal)FindField("ACTYPE").Value; } set {SetField("ACTYPE", value);} }
        public OracleString TYPRST { get { return (OracleString)FindField("TYPRST").Value; } set {SetField("TYPRST", value);} }
        public OracleString SGNRST { get { return (OracleString)FindField("SGNRST").Value; } set {SetField("SGNRST", value);} }
        public OracleDate DTOPEN { get { return (OracleDate)FindField("DTOPEN").Value; } set {SetField("DTOPEN", value);} }
        public OracleDate DTCLOSE { get { return (OracleDate)FindField("DTCLOSE").Value; } set {SetField("DTCLOSE", value);} }
        public OracleString ACNMS { get { return (OracleString)FindField("ACNMS").Value; } set {SetField("ACNMS", value);} }
        public OracleString CHRCNT { get { return (OracleString)FindField("CHRCNT").Value; } set {SetField("CHRCNT", value);} }
        public OracleString NMCNT { get { return (OracleString)FindField("NMCNT").Value; } set {SetField("NMCNT", value);} }
        public OracleString TINCNT { get { return (OracleString)FindField("TINCNT").Value; } set {SetField("TINCNT", value);} }
        public OracleString DOGCNT { get { return (OracleString)FindField("DOGCNT").Value; } set {SetField("DOGCNT", value);} }
        public OracleDate DOGCNTDT { get { return (OracleDate)FindField("DOGCNTDT").Value; } set {SetField("DOGCNTDT", value);} }
        public OracleString K040 { get { return (OracleString)FindField("K040").Value; } set {SetField("K040", value);} }
        public OracleString K050 { get { return (OracleString)FindField("K050").Value; } set {SetField("K050", value);} }
        public OracleString K060 { get { return (OracleString)FindField("K060").Value; } set {SetField("K060", value);} }
        public OracleString K070 { get { return (OracleString)FindField("K070").Value; } set {SetField("K070", value);} }
        public OracleString K080 { get { return (OracleString)FindField("K080").Value; } set {SetField("K080", value);} }
        public OracleString K090 { get { return (OracleString)FindField("K090").Value; } set {SetField("K090", value);} }
        public OracleString K110 { get { return (OracleString)FindField("K110").Value; } set {SetField("K110", value);} }
        public OracleString K140 { get { return (OracleString)FindField("K140").Value; } set {SetField("K140", value);} }
        public OracleDate S040 { get { return (OracleDate)FindField("S040").Value; } set {SetField("S040", value);} }
        public OracleDate S050 { get { return (OracleDate)FindField("S050").Value; } set {SetField("S050", value);} }
        public OracleString S080 { get { return (OracleString)FindField("S080").Value; } set {SetField("S080", value);} }
        public OracleString S120 { get { return (OracleString)FindField("S120").Value; } set {SetField("S120", value);} }
        public OracleString S180 { get { return (OracleString)FindField("S180").Value; } set {SetField("S180", value);} }
        public OracleString S190 { get { return (OracleString)FindField("S190").Value; } set {SetField("S190", value);} }
        public OracleString S230 { get { return (OracleString)FindField("S230").Value; } set {SetField("S230", value);} }
        public OracleString R011 { get { return (OracleString)FindField("R011").Value; } set {SetField("R011", value);} }
        public OracleString R013 { get { return (OracleString)FindField("R013").Value; } set {SetField("R013", value);} }
        public OracleDecimal PRS { get { return (OracleDecimal)FindField("PRS").Value; } set {SetField("PRS", value);} }
        public OracleString ISCLCR { get { return (OracleString)FindField("ISCLCR").Value; } set {SetField("ISCLCR", value);} }
        public OracleString IUSRNM { get { return (OracleString)FindField("IUSRNM").Value; } set {SetField("IUSRNM", value);} }
    }

    public sealed class VDpztArcAccountsFilters : BbFilters
    {
        public VDpztArcAccountsFilters(BbDataSource Parent) : base (Parent)
        {
            REC_ID = new BBDecimalFilter(this, "REC_ID");
            REC_DATE = new BBDateFilter(this, "REC_DATE");
            REC_ACTION = new BBVarchar2Filter(this, "REC_ACTION");
            REC_USERNAME = new BBVarchar2Filter(this, "REC_USERNAME");
            ACC = new BBDecimalFilter(this, "ACC");
            KF = new BBVarchar2Filter(this, "KF");
            NLS = new BBVarchar2Filter(this, "NLS");
            KV = new BBDecimalFilter(this, "KV");
            BLK = new BBDecimalFilter(this, "BLK");
            ACTYPE = new BBDecimalFilter(this, "ACTYPE");
            TYPRST = new BBVarchar2Filter(this, "TYPRST");
            SGNRST = new BBVarchar2Filter(this, "SGNRST");
            DTOPEN = new BBDateFilter(this, "DTOPEN");
            DTCLOSE = new BBDateFilter(this, "DTCLOSE");
            ACNMS = new BBVarchar2Filter(this, "ACNMS");
            CHRCNT = new BBVarchar2Filter(this, "CHRCNT");
            NMCNT = new BBVarchar2Filter(this, "NMCNT");
            TINCNT = new BBVarchar2Filter(this, "TINCNT");
            DOGCNT = new BBVarchar2Filter(this, "DOGCNT");
            DOGCNTDT = new BBDateFilter(this, "DOGCNTDT");
            K040 = new BBVarchar2Filter(this, "K040");
            K050 = new BBVarchar2Filter(this, "K050");
            K060 = new BBVarchar2Filter(this, "K060");
            K070 = new BBVarchar2Filter(this, "K070");
            K080 = new BBVarchar2Filter(this, "K080");
            K090 = new BBVarchar2Filter(this, "K090");
            K110 = new BBVarchar2Filter(this, "K110");
            K140 = new BBVarchar2Filter(this, "K140");
            S040 = new BBDateFilter(this, "S040");
            S050 = new BBDateFilter(this, "S050");
            S080 = new BBVarchar2Filter(this, "S080");
            S120 = new BBVarchar2Filter(this, "S120");
            S180 = new BBVarchar2Filter(this, "S180");
            S190 = new BBVarchar2Filter(this, "S190");
            S230 = new BBVarchar2Filter(this, "S230");
            R011 = new BBVarchar2Filter(this, "R011");
            R013 = new BBVarchar2Filter(this, "R013");
            PRS = new BBDecimalFilter(this, "PRS");
            ISCLCR = new BBVarchar2Filter(this, "ISCLCR");
            IUSRNM = new BBVarchar2Filter(this, "IUSRNM");
        }
        public BBDecimalFilter REC_ID;
        public BBDateFilter REC_DATE;
        public BBVarchar2Filter REC_ACTION;
        public BBVarchar2Filter REC_USERNAME;
        public BBDecimalFilter ACC;
        public BBVarchar2Filter KF;
        public BBVarchar2Filter NLS;
        public BBDecimalFilter KV;
        public BBDecimalFilter BLK;
        public BBDecimalFilter ACTYPE;
        public BBVarchar2Filter TYPRST;
        public BBVarchar2Filter SGNRST;
        public BBDateFilter DTOPEN;
        public BBDateFilter DTCLOSE;
        public BBVarchar2Filter ACNMS;
        public BBVarchar2Filter CHRCNT;
        public BBVarchar2Filter NMCNT;
        public BBVarchar2Filter TINCNT;
        public BBVarchar2Filter DOGCNT;
        public BBDateFilter DOGCNTDT;
        public BBVarchar2Filter K040;
        public BBVarchar2Filter K050;
        public BBVarchar2Filter K060;
        public BBVarchar2Filter K070;
        public BBVarchar2Filter K080;
        public BBVarchar2Filter K090;
        public BBVarchar2Filter K110;
        public BBVarchar2Filter K140;
        public BBDateFilter S040;
        public BBDateFilter S050;
        public BBVarchar2Filter S080;
        public BBVarchar2Filter S120;
        public BBVarchar2Filter S180;
        public BBVarchar2Filter S190;
        public BBVarchar2Filter S230;
        public BBVarchar2Filter R011;
        public BBVarchar2Filter R013;
        public BBDecimalFilter PRS;
        public BBVarchar2Filter ISCLCR;
        public BBVarchar2Filter IUSRNM;
    }

    public sealed class VDpztArcAccounts : BbTable<VDpztArcAccountsRecord, VDpztArcAccountsFilters>
    {
        public VDpztArcAccounts(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VDpztArcAccountsRecord> Select(VDpztArcAccountsRecord Item)
        {
            List<VDpztArcAccountsRecord> res = new List<VDpztArcAccountsRecord>();
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                OracleDataReader rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VDpztArcAccountsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.GetOracleDecimal(1), 
                        rdr.GetOracleDate(2), 
                        rdr.GetOracleString(3), 
                        rdr.GetOracleString(4), 
                        rdr.GetOracleDecimal(5), 
                        rdr.GetOracleString(6), 
                        rdr.GetOracleString(7), 
                        rdr.GetOracleDecimal(8), 
                        rdr.GetOracleDecimal(9), 
                        rdr.GetOracleDecimal(10), 
                        rdr.GetOracleString(11), 
                        rdr.GetOracleString(12), 
                        rdr.GetOracleDate(13), 
                        rdr.GetOracleDate(14), 
                        rdr.GetOracleString(15), 
                        rdr.GetOracleString(16), 
                        rdr.GetOracleString(17), 
                        rdr.GetOracleString(18), 
                        rdr.GetOracleString(19), 
                        rdr.GetOracleDate(20), 
                        rdr.GetOracleString(21), 
                        rdr.GetOracleString(22), 
                        rdr.GetOracleString(23), 
                        rdr.GetOracleString(24), 
                        rdr.GetOracleString(25), 
                        rdr.GetOracleString(26), 
                        rdr.GetOracleString(27), 
                        rdr.GetOracleString(28), 
                        rdr.GetOracleDate(29), 
                        rdr.GetOracleDate(30), 
                        rdr.GetOracleString(31), 
                        rdr.GetOracleString(32), 
                        rdr.GetOracleString(33), 
                        rdr.GetOracleString(34), 
                        rdr.GetOracleString(35), 
                        rdr.GetOracleString(36), 
                        rdr.GetOracleString(37), 
                        rdr.GetOracleDecimal(38), 
                        rdr.GetOracleString(39), 
                        rdr.GetOracleString(40))
                    );
                }
                rdr.Close();
                rdr.Dispose();
            }
            finally
            {
                if (ConnectionResult.New == connectionResult)
                    Connection.CloseConnection();
            }
            return res;
        }
    }
}