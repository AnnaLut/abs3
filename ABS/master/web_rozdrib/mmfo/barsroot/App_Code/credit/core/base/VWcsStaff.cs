/*
    AUTOGENERATED! Do not modify this code.
*/

using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Collections.Specialized;
using System.Data;
using System.Web.Configuration;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using ibank.core;
using Bars.Classes;

namespace credit
{
    public sealed class VWcsStaffRecord : BbRecord
    {
        public VWcsStaffRecord(): base()
        {
            fillFields();
        }
        public VWcsStaffRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsStaffRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? ID, String FIO, String LOGNAME, Decimal? TYPE, String TABN, Decimal? BAX, DateTime? TBAX, Decimal? DISABLE, DateTime? ADATE1, DateTime? ADATE2, DateTime? RDATE1, DateTime? RDATE2, Decimal? CLSID, Decimal? APPROVE, String KF, String BRANCH, String TOBO, Decimal? COUNTCONN, Decimal? COUNTPASS, String PROFILE, String CSCHEMA, Decimal? USEARC, String WEB_PROFILE, Decimal? ACTIVE, DateTime? EXPIRED, Decimal? USEGTW, String BLK, DateTime? TBLK, String CAN_SELECT_BRANCH, String CHGPWD, Decimal? TIP)
            : this(Parent)
        {
            this.ID = ID;
            this.FIO = FIO;
            this.LOGNAME = LOGNAME;
            this.TYPE = TYPE;
            this.TABN = TABN;
            this.BAX = BAX;
            this.TBAX = TBAX;
            this.DISABLE = DISABLE;
            this.ADATE1 = ADATE1;
            this.ADATE2 = ADATE2;
            this.RDATE1 = RDATE1;
            this.RDATE2 = RDATE2;
            this.CLSID = CLSID;
            this.APPROVE = APPROVE;
            this.KF = KF;
            this.BRANCH = BRANCH;
            this.TOBO = TOBO;
            this.COUNTCONN = COUNTCONN;
            this.COUNTPASS = COUNTPASS;
            this.PROFILE = PROFILE;
            this.CSCHEMA = CSCHEMA;
            this.USEARC = USEARC;
            this.WEB_PROFILE = WEB_PROFILE;
            this.ACTIVE = ACTIVE;
            this.EXPIRED = EXPIRED;
            this.USEGTW = USEGTW;
            this.BLK = BLK;
            this.TBLK = TBLK;
            this.CAN_SELECT_BRANCH = CAN_SELECT_BRANCH;
            this.CHGPWD = CHGPWD;
            this.TIP = TIP;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("ID", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("FIO", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("LOGNAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("TYPE", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("TABN", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("BAX", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("TBAX", OracleDbType.Date, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("DISABLE", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("ADATE1", OracleDbType.Date, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("ADATE2", OracleDbType.Date, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("RDATE1", OracleDbType.Date, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("RDATE2", OracleDbType.Date, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("CLSID", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("APPROVE", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("KF", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("BRANCH", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("TOBO", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("COUNTCONN", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("COUNTPASS", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("PROFILE", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("CSCHEMA", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("USEARC", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("WEB_PROFILE", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("ACTIVE", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("EXPIRED", OracleDbType.Date, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("USEGTW", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("BLK", OracleDbType.Char, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("TBLK", OracleDbType.Date, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("CAN_SELECT_BRANCH", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("CHGPWD", OracleDbType.Char, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));
            Fields.Add( new BbField("TIP", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_STAFF", ObjectTypes.View, "Пользователи (представление)", ""));        
        }
        public Decimal? ID { get { return (Decimal?)FindField("ID").Value; } set {SetField("ID", value);} }
        public String FIO { get { return (String)FindField("FIO").Value; } set {SetField("FIO", value);} }
        public String LOGNAME { get { return (String)FindField("LOGNAME").Value; } set {SetField("LOGNAME", value);} }
        public Decimal? TYPE { get { return (Decimal?)FindField("TYPE").Value; } set {SetField("TYPE", value);} }
        public String TABN { get { return (String)FindField("TABN").Value; } set {SetField("TABN", value);} }
        public Decimal? BAX { get { return (Decimal?)FindField("BAX").Value; } set {SetField("BAX", value);} }
        public DateTime? TBAX { get { return (DateTime?)FindField("TBAX").Value; } set {SetField("TBAX", value);} }
        public Decimal? DISABLE { get { return (Decimal?)FindField("DISABLE").Value; } set {SetField("DISABLE", value);} }
        public DateTime? ADATE1 { get { return (DateTime?)FindField("ADATE1").Value; } set {SetField("ADATE1", value);} }
        public DateTime? ADATE2 { get { return (DateTime?)FindField("ADATE2").Value; } set {SetField("ADATE2", value);} }
        public DateTime? RDATE1 { get { return (DateTime?)FindField("RDATE1").Value; } set {SetField("RDATE1", value);} }
        public DateTime? RDATE2 { get { return (DateTime?)FindField("RDATE2").Value; } set {SetField("RDATE2", value);} }
        public Decimal? CLSID { get { return (Decimal?)FindField("CLSID").Value; } set {SetField("CLSID", value);} }
        public Decimal? APPROVE { get { return (Decimal?)FindField("APPROVE").Value; } set {SetField("APPROVE", value);} }
        public String KF { get { return (String)FindField("KF").Value; } set {SetField("KF", value);} }
        public String BRANCH { get { return (String)FindField("BRANCH").Value; } set {SetField("BRANCH", value);} }
        public String TOBO { get { return (String)FindField("TOBO").Value; } set {SetField("TOBO", value);} }
        public Decimal? COUNTCONN { get { return (Decimal?)FindField("COUNTCONN").Value; } set {SetField("COUNTCONN", value);} }
        public Decimal? COUNTPASS { get { return (Decimal?)FindField("COUNTPASS").Value; } set {SetField("COUNTPASS", value);} }
        public String PROFILE { get { return (String)FindField("PROFILE").Value; } set {SetField("PROFILE", value);} }
        public String CSCHEMA { get { return (String)FindField("CSCHEMA").Value; } set {SetField("CSCHEMA", value);} }
        public Decimal? USEARC { get { return (Decimal?)FindField("USEARC").Value; } set {SetField("USEARC", value);} }
        public String WEB_PROFILE { get { return (String)FindField("WEB_PROFILE").Value; } set {SetField("WEB_PROFILE", value);} }
        public Decimal? ACTIVE { get { return (Decimal?)FindField("ACTIVE").Value; } set {SetField("ACTIVE", value);} }
        public DateTime? EXPIRED { get { return (DateTime?)FindField("EXPIRED").Value; } set {SetField("EXPIRED", value);} }
        public Decimal? USEGTW { get { return (Decimal?)FindField("USEGTW").Value; } set {SetField("USEGTW", value);} }
        public String BLK { get { return (String)FindField("BLK").Value; } set {SetField("BLK", value);} }
        public DateTime? TBLK { get { return (DateTime?)FindField("TBLK").Value; } set {SetField("TBLK", value);} }
        public String CAN_SELECT_BRANCH { get { return (String)FindField("CAN_SELECT_BRANCH").Value; } set {SetField("CAN_SELECT_BRANCH", value);} }
        public String CHGPWD { get { return (String)FindField("CHGPWD").Value; } set {SetField("CHGPWD", value);} }
        public Decimal? TIP { get { return (Decimal?)FindField("TIP").Value; } set {SetField("TIP", value);} }
    }

    public sealed class VWcsStaffFilters : BbFilters
    {
        public VWcsStaffFilters(BbDataSource Parent) : base (Parent)
        {
            ID = new BBDecimalFilter(this, "ID");
            FIO = new BBVarchar2Filter(this, "FIO");
            LOGNAME = new BBVarchar2Filter(this, "LOGNAME");
            TYPE = new BBDecimalFilter(this, "TYPE");
            TABN = new BBVarchar2Filter(this, "TABN");
            BAX = new BBDecimalFilter(this, "BAX");
            TBAX = new BBDateFilter(this, "TBAX");
            DISABLE = new BBDecimalFilter(this, "DISABLE");
            ADATE1 = new BBDateFilter(this, "ADATE1");
            ADATE2 = new BBDateFilter(this, "ADATE2");
            RDATE1 = new BBDateFilter(this, "RDATE1");
            RDATE2 = new BBDateFilter(this, "RDATE2");
            CLSID = new BBDecimalFilter(this, "CLSID");
            APPROVE = new BBDecimalFilter(this, "APPROVE");
            KF = new BBVarchar2Filter(this, "KF");
            BRANCH = new BBVarchar2Filter(this, "BRANCH");
            TOBO = new BBVarchar2Filter(this, "TOBO");
            COUNTCONN = new BBDecimalFilter(this, "COUNTCONN");
            COUNTPASS = new BBDecimalFilter(this, "COUNTPASS");
            PROFILE = new BBVarchar2Filter(this, "PROFILE");
            CSCHEMA = new BBVarchar2Filter(this, "CSCHEMA");
            USEARC = new BBDecimalFilter(this, "USEARC");
            WEB_PROFILE = new BBVarchar2Filter(this, "WEB_PROFILE");
            ACTIVE = new BBDecimalFilter(this, "ACTIVE");
            EXPIRED = new BBDateFilter(this, "EXPIRED");
            USEGTW = new BBDecimalFilter(this, "USEGTW");
            BLK = new BBCharFilter(this, "BLK");
            TBLK = new BBDateFilter(this, "TBLK");
            CAN_SELECT_BRANCH = new BBVarchar2Filter(this, "CAN_SELECT_BRANCH");
            CHGPWD = new BBCharFilter(this, "CHGPWD");
            TIP = new BBDecimalFilter(this, "TIP");
        }
        public BBDecimalFilter ID;
        public BBVarchar2Filter FIO;
        public BBVarchar2Filter LOGNAME;
        public BBDecimalFilter TYPE;
        public BBVarchar2Filter TABN;
        public BBDecimalFilter BAX;
        public BBDateFilter TBAX;
        public BBDecimalFilter DISABLE;
        public BBDateFilter ADATE1;
        public BBDateFilter ADATE2;
        public BBDateFilter RDATE1;
        public BBDateFilter RDATE2;
        public BBDecimalFilter CLSID;
        public BBDecimalFilter APPROVE;
        public BBVarchar2Filter KF;
        public BBVarchar2Filter BRANCH;
        public BBVarchar2Filter TOBO;
        public BBDecimalFilter COUNTCONN;
        public BBDecimalFilter COUNTPASS;
        public BBVarchar2Filter PROFILE;
        public BBVarchar2Filter CSCHEMA;
        public BBDecimalFilter USEARC;
        public BBVarchar2Filter WEB_PROFILE;
        public BBDecimalFilter ACTIVE;
        public BBDateFilter EXPIRED;
        public BBDecimalFilter USEGTW;
        public BBCharFilter BLK;
        public BBDateFilter TBLK;
        public BBVarchar2Filter CAN_SELECT_BRANCH;
        public BBCharFilter CHGPWD;
        public BBDecimalFilter TIP;
    }

    public partial class VWcsStaff : BbTable<VWcsStaffRecord, VWcsStaffFilters>
    {
        public VWcsStaff() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsStaff(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsStaffRecord> Select(VWcsStaffRecord Item)
        {
            List<VWcsStaffRecord> res = new List<VWcsStaffRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsStaffRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (Decimal?)null : Convert.ToDecimal(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (Decimal?)null : Convert.ToDecimal(rdr[6]), 
                        rdr.IsDBNull(7) ?  (DateTime?)null : Convert.ToDateTime(rdr[7]), 
                        rdr.IsDBNull(8) ?  (Decimal?)null : Convert.ToDecimal(rdr[8]), 
                        rdr.IsDBNull(9) ?  (DateTime?)null : Convert.ToDateTime(rdr[9]), 
                        rdr.IsDBNull(10) ?  (DateTime?)null : Convert.ToDateTime(rdr[10]), 
                        rdr.IsDBNull(11) ?  (DateTime?)null : Convert.ToDateTime(rdr[11]), 
                        rdr.IsDBNull(12) ?  (DateTime?)null : Convert.ToDateTime(rdr[12]), 
                        rdr.IsDBNull(13) ?  (Decimal?)null : Convert.ToDecimal(rdr[13]), 
                        rdr.IsDBNull(14) ?  (Decimal?)null : Convert.ToDecimal(rdr[14]), 
                        rdr.IsDBNull(15) ?  (String)null : Convert.ToString(rdr[15]), 
                        rdr.IsDBNull(16) ?  (String)null : Convert.ToString(rdr[16]), 
                        rdr.IsDBNull(17) ?  (String)null : Convert.ToString(rdr[17]), 
                        rdr.IsDBNull(18) ?  (Decimal?)null : Convert.ToDecimal(rdr[18]), 
                        rdr.IsDBNull(19) ?  (Decimal?)null : Convert.ToDecimal(rdr[19]), 
                        rdr.IsDBNull(20) ?  (String)null : Convert.ToString(rdr[20]), 
                        rdr.IsDBNull(21) ?  (String)null : Convert.ToString(rdr[21]), 
                        rdr.IsDBNull(22) ?  (Decimal?)null : Convert.ToDecimal(rdr[22]), 
                        rdr.IsDBNull(23) ?  (String)null : Convert.ToString(rdr[23]), 
                        rdr.IsDBNull(24) ?  (Decimal?)null : Convert.ToDecimal(rdr[24]), 
                        rdr.IsDBNull(25) ?  (DateTime?)null : Convert.ToDateTime(rdr[25]), 
                        rdr.IsDBNull(26) ?  (Decimal?)null : Convert.ToDecimal(rdr[26]), 
                        rdr.IsDBNull(27) ?  (String)null : Convert.ToString(rdr[27]), 
                        rdr.IsDBNull(28) ?  (DateTime?)null : Convert.ToDateTime(rdr[28]), 
                        rdr.IsDBNull(29) ?  (String)null : Convert.ToString(rdr[29]), 
                        rdr.IsDBNull(30) ?  (String)null : Convert.ToString(rdr[30]), 
                        rdr.IsDBNull(31) ?  (Decimal?)null : Convert.ToDecimal(rdr[31]))
                    );
                }
            }
                        finally
            {
                DisposeDataReader(rdr);
                if (ConnectionResult.New == connectionResult)
                    Connection.CloseConnection();
            }
            return res;
        }
    }
}