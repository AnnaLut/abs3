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
    public sealed class VWcsBidInsurancesRecord : BbRecord
    {
        public VWcsBidInsurancesRecord(): base()
        {
            fillFields();
        }
        public VWcsBidInsurancesRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsBidInsurancesRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? BID_ID, String INSURANCE_ID, String INSURANCE_NAME, Decimal? INSURANCE_NUM, Decimal? INS_TYPE_ID, String WS_ID, Decimal? STATUS_ID, String STATUS_NAME, String PARTNER_ID, String PARTNER_NAME, String SER, String NUM, DateTime? DATE_ON, DateTime? DATE_OFF, Decimal? SUM)
            : this(Parent)
        {
            this.BID_ID = BID_ID;
            this.INSURANCE_ID = INSURANCE_ID;
            this.INSURANCE_NAME = INSURANCE_NAME;
            this.INSURANCE_NUM = INSURANCE_NUM;
            this.INS_TYPE_ID = INS_TYPE_ID;
            this.WS_ID = WS_ID;
            this.STATUS_ID = STATUS_ID;
            this.STATUS_NAME = STATUS_NAME;
            this.PARTNER_ID = PARTNER_ID;
            this.PARTNER_NAME = PARTNER_NAME;
            this.SER = SER;
            this.NUM = NUM;
            this.DATE_ON = DATE_ON;
            this.DATE_OFF = DATE_OFF;
            this.SUM = SUM;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("BID_ID", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_BID_INSURANCES", ObjectTypes.View, "Страховки заявки", "Идентификатор заявки"));
            Fields.Add( new BbField("INSURANCE_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_INSURANCES", ObjectTypes.View, "Страховки заявки", "Идентификатор типа страховки"));
            Fields.Add( new BbField("INSURANCE_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_INSURANCES", ObjectTypes.View, "Страховки заявки", "Наименование типа страховки"));
            Fields.Add( new BbField("INSURANCE_NUM", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_BID_INSURANCES", ObjectTypes.View, "Страховки заявки", "Номер договора (по счету) в рамках одного типа"));
            Fields.Add( new BbField("INS_TYPE_ID", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_BID_INSURANCES", ObjectTypes.View, "Страховки заявки", "Идентификатор типа страховки (из модуля страховок)"));
            Fields.Add( new BbField("WS_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_INSURANCES", ObjectTypes.View, "Страховки заявки", "Идентификатор рабочего пространства"));
            Fields.Add( new BbField("STATUS_ID", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_BID_INSURANCES", ObjectTypes.View, "Страховки заявки", "Идентификатор статуса"));
            Fields.Add( new BbField("STATUS_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_INSURANCES", ObjectTypes.View, "Страховки заявки", "Наименование статуса"));
            Fields.Add( new BbField("PARTNER_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_INSURANCES", ObjectTypes.View, "Страховки заявки", "Идентификатор СК"));
            Fields.Add( new BbField("PARTNER_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_INSURANCES", ObjectTypes.View, "Страховки заявки", "Наименование СК"));
            Fields.Add( new BbField("SER", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_INSURANCES", ObjectTypes.View, "Страховки заявки", "Серия договора"));
            Fields.Add( new BbField("NUM", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_INSURANCES", ObjectTypes.View, "Страховки заявки", "Номер договора"));
            Fields.Add( new BbField("DATE_ON", OracleDbType.Date, true, false, false, false, false, "V_WCS_BID_INSURANCES", ObjectTypes.View, "Страховки заявки", "Дата начала действия"));
            Fields.Add( new BbField("DATE_OFF", OracleDbType.Date, true, false, false, false, false, "V_WCS_BID_INSURANCES", ObjectTypes.View, "Страховки заявки", "Дата окончания действия"));
            Fields.Add( new BbField("SUM", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_BID_INSURANCES", ObjectTypes.View, "Страховки заявки", "Страховая сумма (нац. валюта)"));        
        }
        public Decimal? BID_ID { get { return (Decimal?)FindField("BID_ID").Value; } set {SetField("BID_ID", value);} }
        public String INSURANCE_ID { get { return (String)FindField("INSURANCE_ID").Value; } set {SetField("INSURANCE_ID", value);} }
        public String INSURANCE_NAME { get { return (String)FindField("INSURANCE_NAME").Value; } set {SetField("INSURANCE_NAME", value);} }
        public Decimal? INSURANCE_NUM { get { return (Decimal?)FindField("INSURANCE_NUM").Value; } set {SetField("INSURANCE_NUM", value);} }
        public Decimal? INS_TYPE_ID { get { return (Decimal?)FindField("INS_TYPE_ID").Value; } set {SetField("INS_TYPE_ID", value);} }
        public String WS_ID { get { return (String)FindField("WS_ID").Value; } set {SetField("WS_ID", value);} }
        public Decimal? STATUS_ID { get { return (Decimal?)FindField("STATUS_ID").Value; } set {SetField("STATUS_ID", value);} }
        public String STATUS_NAME { get { return (String)FindField("STATUS_NAME").Value; } set {SetField("STATUS_NAME", value);} }
        public String PARTNER_ID { get { return (String)FindField("PARTNER_ID").Value; } set {SetField("PARTNER_ID", value);} }
        public String PARTNER_NAME { get { return (String)FindField("PARTNER_NAME").Value; } set {SetField("PARTNER_NAME", value);} }
        public String SER { get { return (String)FindField("SER").Value; } set {SetField("SER", value);} }
        public String NUM { get { return (String)FindField("NUM").Value; } set {SetField("NUM", value);} }
        public DateTime? DATE_ON { get { return (DateTime?)FindField("DATE_ON").Value; } set {SetField("DATE_ON", value);} }
        public DateTime? DATE_OFF { get { return (DateTime?)FindField("DATE_OFF").Value; } set {SetField("DATE_OFF", value);} }
        public Decimal? SUM { get { return (Decimal?)FindField("SUM").Value; } set {SetField("SUM", value);} }
    }

    public sealed class VWcsBidInsurancesFilters : BbFilters
    {
        public VWcsBidInsurancesFilters(BbDataSource Parent) : base (Parent)
        {
            BID_ID = new BBDecimalFilter(this, "BID_ID");
            INSURANCE_ID = new BBVarchar2Filter(this, "INSURANCE_ID");
            INSURANCE_NAME = new BBVarchar2Filter(this, "INSURANCE_NAME");
            INSURANCE_NUM = new BBDecimalFilter(this, "INSURANCE_NUM");
            INS_TYPE_ID = new BBDecimalFilter(this, "INS_TYPE_ID");
            WS_ID = new BBVarchar2Filter(this, "WS_ID");
            STATUS_ID = new BBDecimalFilter(this, "STATUS_ID");
            STATUS_NAME = new BBVarchar2Filter(this, "STATUS_NAME");
            PARTNER_ID = new BBVarchar2Filter(this, "PARTNER_ID");
            PARTNER_NAME = new BBVarchar2Filter(this, "PARTNER_NAME");
            SER = new BBVarchar2Filter(this, "SER");
            NUM = new BBVarchar2Filter(this, "NUM");
            DATE_ON = new BBDateFilter(this, "DATE_ON");
            DATE_OFF = new BBDateFilter(this, "DATE_OFF");
            SUM = new BBDecimalFilter(this, "SUM");
        }
        public BBDecimalFilter BID_ID;
        public BBVarchar2Filter INSURANCE_ID;
        public BBVarchar2Filter INSURANCE_NAME;
        public BBDecimalFilter INSURANCE_NUM;
        public BBDecimalFilter INS_TYPE_ID;
        public BBVarchar2Filter WS_ID;
        public BBDecimalFilter STATUS_ID;
        public BBVarchar2Filter STATUS_NAME;
        public BBVarchar2Filter PARTNER_ID;
        public BBVarchar2Filter PARTNER_NAME;
        public BBVarchar2Filter SER;
        public BBVarchar2Filter NUM;
        public BBDateFilter DATE_ON;
        public BBDateFilter DATE_OFF;
        public BBDecimalFilter SUM;
    }

    public partial class VWcsBidInsurances : BbTable<VWcsBidInsurancesRecord, VWcsBidInsurancesFilters>
    {
        public VWcsBidInsurances() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsBidInsurances(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsBidInsurancesRecord> Select(VWcsBidInsurancesRecord Item)
        {
            List<VWcsBidInsurancesRecord> res = new List<VWcsBidInsurancesRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsBidInsurancesRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (Decimal?)null : Convert.ToDecimal(rdr[4]), 
                        rdr.IsDBNull(5) ?  (Decimal?)null : Convert.ToDecimal(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (Decimal?)null : Convert.ToDecimal(rdr[7]), 
                        rdr.IsDBNull(8) ?  (String)null : Convert.ToString(rdr[8]), 
                        rdr.IsDBNull(9) ?  (String)null : Convert.ToString(rdr[9]), 
                        rdr.IsDBNull(10) ?  (String)null : Convert.ToString(rdr[10]), 
                        rdr.IsDBNull(11) ?  (String)null : Convert.ToString(rdr[11]), 
                        rdr.IsDBNull(12) ?  (String)null : Convert.ToString(rdr[12]), 
                        rdr.IsDBNull(13) ?  (DateTime?)null : Convert.ToDateTime(rdr[13]), 
                        rdr.IsDBNull(14) ?  (DateTime?)null : Convert.ToDateTime(rdr[14]), 
                        rdr.IsDBNull(15) ?  (Decimal?)null : Convert.ToDecimal(rdr[15]))
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