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
    public sealed class VCustCompaniesInfoRecord : BbRecord
    {
        public VCustCompaniesInfoRecord(): base()
        {
            fillFields();
        }
        public VCustCompaniesInfoRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VCustCompaniesInfoRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? RNK, Decimal? CUST_ID, String NAME, String CUST_CODE, String COUNTRY_NAME, String ARTICLE_NAME, String HEAD_NAME, String ACCOUNTANT_NAME, String EMAIL)
            : this(Parent)
        {
            this.RNK = RNK;
            this.CUST_ID = CUST_ID;
            this.NAME = NAME;
            this.CUST_CODE = CUST_CODE;
            this.COUNTRY_NAME = COUNTRY_NAME;
            this.ARTICLE_NAME = ARTICLE_NAME;
            this.HEAD_NAME = HEAD_NAME;
            this.ACCOUNTANT_NAME = ACCOUNTANT_NAME;
            this.EMAIL = EMAIL;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add(new BbField("RNK", OracleDbType.Decimal, false, false, false, false, false, "CORE.V_CUST_COMPANIES_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів юр. осіб version 1.0", "Реєстраційний номер в АБС"));
            Fields.Add(new BbField("CUST_ID", OracleDbType.Decimal, false, false, false, false, false, "CORE.V_CUST_COMPANIES_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів юр. осіб version 1.0", "Реєстраційний номер"));
            Fields.Add(new BbField("NAME", OracleDbType.Varchar2, false, false, false, false, false, "CORE.V_CUST_COMPANIES_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів юр. осіб version 1.0", "Найменування"));
            Fields.Add(new BbField("CUST_CODE", OracleDbType.Varchar2, false, false, false, false, false, "CORE.V_CUST_COMPANIES_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів юр. осіб version 1.0", "Ідентифікаційний код"));
            Fields.Add(new BbField("COUNTRY_NAME", OracleDbType.Varchar2, false, false, false, false, false, "CORE.V_CUST_COMPANIES_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів юр. осіб version 1.0", "Країна"));
            Fields.Add(new BbField("ARTICLE_NAME", OracleDbType.Varchar2, false, false, false, false, false, "CORE.V_CUST_COMPANIES_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів юр. осіб version 1.0", "Найменування по уставу"));
            Fields.Add(new BbField("HEAD_NAME", OracleDbType.Varchar2, false, false, false, false, false, "CORE.V_CUST_COMPANIES_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів юр. осіб version 1.0", "Керівник"));
            Fields.Add(new BbField("ACCOUNTANT_NAME", OracleDbType.Varchar2, true, false, false, false, false, "CORE.V_CUST_COMPANIES_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів юр. осіб version 1.0", "Бухгалтер"));
            Fields.Add(new BbField("EMAIL", OracleDbType.Varchar2, true, false, false, false, false, "CORE.V_CUST_COMPANIES_INFO@IBANK", ObjectTypes.View, "Інформація про клієнтів юр. осіб version 1.0", "email"));        
        }
        public Decimal? RNK { get { return (Decimal?)FindField("RNK").Value; } set {SetField("RNK", value);} }
        public Decimal? CUST_ID { get { return (Decimal?)FindField("CUST_ID").Value; } set {SetField("CUST_ID", value);} }
        public String NAME { get { return (String)FindField("NAME").Value; } set {SetField("NAME", value);} }
        public String CUST_CODE { get { return (String)FindField("CUST_CODE").Value; } set {SetField("CUST_CODE", value);} }
        public String COUNTRY_NAME { get { return (String)FindField("COUNTRY_NAME").Value; } set {SetField("COUNTRY_NAME", value);} }
        public String ARTICLE_NAME { get { return (String)FindField("ARTICLE_NAME").Value; } set {SetField("ARTICLE_NAME", value);} }
        public String HEAD_NAME { get { return (String)FindField("HEAD_NAME").Value; } set {SetField("HEAD_NAME", value);} }
        public String ACCOUNTANT_NAME { get { return (String)FindField("ACCOUNTANT_NAME").Value; } set {SetField("ACCOUNTANT_NAME", value);} }
        public String EMAIL { get { return (String)FindField("EMAIL").Value; } set {SetField("EMAIL", value);} }
    }

    public sealed class VCustCompaniesInfoFilters : BbFilters
    {
        public VCustCompaniesInfoFilters(BbDataSource Parent) : base (Parent)
        {
            RNK = new BBDecimalFilter(this, "RNK");
            CUST_ID = new BBDecimalFilter(this, "CUST_ID");
            NAME = new BBVarchar2Filter(this, "NAME");
            CUST_CODE = new BBVarchar2Filter(this, "CUST_CODE");
            COUNTRY_NAME = new BBVarchar2Filter(this, "COUNTRY_NAME");
            ARTICLE_NAME = new BBVarchar2Filter(this, "ARTICLE_NAME");
            HEAD_NAME = new BBVarchar2Filter(this, "HEAD_NAME");
            ACCOUNTANT_NAME = new BBVarchar2Filter(this, "ACCOUNTANT_NAME");
            EMAIL = new BBVarchar2Filter(this, "EMAIL");
        }
        public BBDecimalFilter RNK;
        public BBDecimalFilter CUST_ID;
        public BBVarchar2Filter NAME;
        public BBVarchar2Filter CUST_CODE;
        public BBVarchar2Filter COUNTRY_NAME;
        public BBVarchar2Filter ARTICLE_NAME;
        public BBVarchar2Filter HEAD_NAME;
        public BBVarchar2Filter ACCOUNTANT_NAME;
        public BBVarchar2Filter EMAIL;
    }

    public partial class VCustCompaniesInfo : BbTable<VCustCompaniesInfoRecord, VCustCompaniesInfoFilters>
    {
        public VCustCompaniesInfo(): base(new BbConnection())
        {
        }
        public VCustCompaniesInfo(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VCustCompaniesInfoRecord> Select(VCustCompaniesInfoRecord Item)
        {
			List<VCustCompaniesInfoRecord> res = new List<VCustCompaniesInfoRecord>();
			OracleDataReader rdr = null;
			ConnectionResult connectionResult = Connection.InitConnection();
			try
			{
				rdr = ExecuteReader(Item);
				while (rdr.Read())
				{
					res.Add(new VCustCompaniesInfoRecord(
						this,
						rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
					rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
					rdr.IsDBNull(2) ?  (Decimal?)null : Convert.ToDecimal(rdr[2]), 
					rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
					rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
					rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
					rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
					rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
					rdr.IsDBNull(8) ?  (String)null : Convert.ToString(rdr[8]), 
					rdr.IsDBNull(9) ?  (String)null : Convert.ToString(rdr[9]))
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