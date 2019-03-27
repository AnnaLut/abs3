/*
    AUTOGENERATED! Do not modify this code.
*/

using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Collections.Specialized;
using System.Data;
using System.Web;
using System.Web.Configuration;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using ibank.core;

namespace ibank.objlayer
{
    public sealed class VCustIndividualsInfoRecord : BbRecord
    {
        public VCustIndividualsInfoRecord(): base()
        {
            fillFields();
        }
        public VCustIndividualsInfoRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VCustIndividualsInfoRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? RNK, Decimal? CUST_ID, String NAME, String CUST_CODE, String COUNTRY_NAME, String ID_SERIAL, String ID_NUMBER, DateTime? ID_DATE, String ID_ISSUER, DateTime? BIRTHDAY, String BIRTHPLACE)
            : this(Parent)
        {
            this.RNK = RNK;
            this.CUST_ID = CUST_ID;
            this.NAME = NAME;
            this.CUST_CODE = CUST_CODE;
            this.COUNTRY_NAME = COUNTRY_NAME;
            this.ID_SERIAL = ID_SERIAL;
            this.ID_NUMBER = ID_NUMBER;
            this.ID_DATE = ID_DATE;
            this.ID_ISSUER = ID_ISSUER;
            this.BIRTHDAY = BIRTHDAY;
            this.BIRTHPLACE = BIRTHPLACE;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add(new BbField("RNK", OracleDbType.Decimal, false, false, false, false, false, "CORE.V_CUST_INDIVIDUALS_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів фіз. осіб version 1.0", "Реєстраційний номер в АБС"));
            Fields.Add(new BbField("CUST_ID", OracleDbType.Decimal, false, false, false, false, false, "CORE.V_CUST_INDIVIDUALS_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів фіз. осіб version 1.0", "Реєстраційний номер"));
            Fields.Add(new BbField("NAME", OracleDbType.Varchar2, false, false, false, false, false, "CORE.V_CUST_INDIVIDUALS_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів фіз. осіб version 1.0", "ПІБ"));
            Fields.Add(new BbField("CUST_CODE", OracleDbType.Varchar2, false, false, false, false, false, "CORE.V_CUST_INDIVIDUALS_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів фіз. осіб version 1.0", "Ідентифікаційний код"));
            Fields.Add(new BbField("COUNTRY_NAME", OracleDbType.Varchar2, false, false, false, false, false, "CORE.V_CUST_INDIVIDUALS_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів фіз. осіб version 1.0", "Країна"));
            Fields.Add(new BbField("ID_SERIAL", OracleDbType.Varchar2, false, false, false, false, false, "CORE.V_CUST_INDIVIDUALS_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів фіз. осіб version 1.0", "Серія документу"));
            Fields.Add(new BbField("ID_NUMBER", OracleDbType.Varchar2, false, false, false, false, false, "CORE.V_CUST_INDIVIDUALS_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів фіз. осіб version 1.0", "Номер документа"));
            Fields.Add(new BbField("ID_DATE", OracleDbType.Date, false, false, false, false, false, "CORE.V_CUST_INDIVIDUALS_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів фіз. осіб version 1.0", "Дата документу"));
            Fields.Add(new BbField("ID_ISSUER", OracleDbType.Varchar2, false, false, false, false, false, "CORE.V_CUST_INDIVIDUALS_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів фіз. осіб version 1.0", "Ким виданий"));
            Fields.Add(new BbField("BIRTHDAY", OracleDbType.Date, false, false, false, false, false, "CORE.V_CUST_INDIVIDUALS_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів фіз. осіб version 1.0", "Дата народження"));
            Fields.Add(new BbField("BIRTHPLACE", OracleDbType.Varchar2, false, false, false, false, false, "CORE.V_CUST_INDIVIDUALS_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів фіз. осіб version 1.0", "Міце народження"));        
        }
        public Decimal? RNK { get { return (Decimal?)FindField("RNK").Value; } set {SetField("RNK", value);} }
        public Decimal? CUST_ID { get { return (Decimal?)FindField("CUST_ID").Value; } set {SetField("CUST_ID", value);} }
        public String NAME { get { return (String)FindField("NAME").Value; } set {SetField("NAME", value);} }
        public String CUST_CODE { get { return (String)FindField("CUST_CODE").Value; } set {SetField("CUST_CODE", value);} }
        public String COUNTRY_NAME { get { return (String)FindField("COUNTRY_NAME").Value; } set {SetField("COUNTRY_NAME", value);} }
        public String ID_SERIAL { get { return (String)FindField("ID_SERIAL").Value; } set {SetField("ID_SERIAL", value);} }
        public String ID_NUMBER { get { return (String)FindField("ID_NUMBER").Value; } set {SetField("ID_NUMBER", value);} }
        public DateTime? ID_DATE { get { return (DateTime?)FindField("ID_DATE").Value; } set {SetField("ID_DATE", value);} }
        public String ID_ISSUER { get { return (String)FindField("ID_ISSUER").Value; } set {SetField("ID_ISSUER", value);} }
        public DateTime? BIRTHDAY { get { return (DateTime?)FindField("BIRTHDAY").Value; } set {SetField("BIRTHDAY", value);} }
        public String BIRTHPLACE { get { return (String)FindField("BIRTHPLACE").Value; } set {SetField("BIRTHPLACE", value);} }
    }

    public sealed class VCustIndividualsInfoFilters : BbFilters
    {
        public VCustIndividualsInfoFilters(BbDataSource Parent) : base (Parent)
        {
            RNK = new BBDecimalFilter(this, "RNK");
            CUST_ID = new BBDecimalFilter(this, "CUST_ID");
            NAME = new BBVarchar2Filter(this, "NAME");
            CUST_CODE = new BBVarchar2Filter(this, "CUST_CODE");
            COUNTRY_NAME = new BBVarchar2Filter(this, "COUNTRY_NAME");
            ID_SERIAL = new BBVarchar2Filter(this, "ID_SERIAL");
            ID_NUMBER = new BBVarchar2Filter(this, "ID_NUMBER");
            ID_DATE = new BBDateFilter(this, "ID_DATE");
            ID_ISSUER = new BBVarchar2Filter(this, "ID_ISSUER");
            BIRTHDAY = new BBDateFilter(this, "BIRTHDAY");
            BIRTHPLACE = new BBVarchar2Filter(this, "BIRTHPLACE");
        }
        public BBDecimalFilter RNK;
        public BBDecimalFilter CUST_ID;
        public BBVarchar2Filter NAME;
        public BBVarchar2Filter CUST_CODE;
        public BBVarchar2Filter COUNTRY_NAME;
        public BBVarchar2Filter ID_SERIAL;
        public BBVarchar2Filter ID_NUMBER;
        public BBDateFilter ID_DATE;
        public BBVarchar2Filter ID_ISSUER;
        public BBDateFilter BIRTHDAY;
        public BBVarchar2Filter BIRTHPLACE;
    }

    public partial class VCustIndividualsInfo : BbTable<VCustIndividualsInfoRecord, VCustIndividualsInfoFilters>
    {
        public VCustIndividualsInfo(): base(new BbConnection())
        {
        }
        public VCustIndividualsInfo(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VCustIndividualsInfoRecord> Select(VCustIndividualsInfoRecord Item)
        {
			List<VCustIndividualsInfoRecord> res = new List<VCustIndividualsInfoRecord>();
			OracleDataReader rdr = null;
			ConnectionResult connectionResult = Connection.InitConnection();
			try
			{
				rdr = ExecuteReader(Item);
				while (rdr.Read())
				{
					res.Add(new VCustIndividualsInfoRecord(
						this,
						rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
					rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
					rdr.IsDBNull(2) ?  (Decimal?)null : Convert.ToDecimal(rdr[2]), 
					rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
					rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
					rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
					rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
					rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
					rdr.IsDBNull(8) ?  (DateTime?)null : Convert.ToDateTime(rdr[8]), 
					rdr.IsDBNull(9) ?  (String)null : Convert.ToString(rdr[9]), 
					rdr.IsDBNull(10) ?  (DateTime?)null : Convert.ToDateTime(rdr[10]), 
					rdr.IsDBNull(11) ?  (String)null : Convert.ToString(rdr[11]))
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