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

namespace cim
{
    public sealed class VCimBeneficiariesRecord : BbRecord
    {
        public VCimBeneficiariesRecord(): base()
        {
            fillFields();
        }
        public VCimBeneficiariesRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VCimBeneficiariesRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? BENEF_ID, String BENEF_NAME, Decimal? COUNTRY_ID, String COUNTRY_NAME, String BENEF_ADR, String COMMENTS, DateTime? DELETE_DATE)
            : this(Parent)
        {
            this.BENEF_ID = BENEF_ID;
            this.BENEF_NAME = BENEF_NAME;
            this.COUNTRY_ID = COUNTRY_ID;
            this.COUNTRY_NAME = COUNTRY_NAME;
            this.BENEF_ADR = BENEF_ADR;
            this.COMMENTS = COMMENTS;
            this.DELETE_DATE = DELETE_DATE;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("BENEF_ID", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_BENEFICIARIES", ObjectTypes.View, "Довідник бенефіціарів (неризидентів)", "Код бенефіціара"));
            Fields.Add( new BbField("BENEF_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_CIM_BENEFICIARIES", ObjectTypes.View, "Довідник бенефіціарів (неризидентів)", "Назва бенефіціара"));
            Fields.Add( new BbField("COUNTRY_ID", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_BENEFICIARIES", ObjectTypes.View, "Довідник бенефіціарів (неризидентів)", "Код країни бенефіціара"));
            Fields.Add( new BbField("COUNTRY_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_BENEFICIARIES", ObjectTypes.View, "Довідник бенефіціарів (неризидентів)", "Країна бенефіціара"));
            Fields.Add( new BbField("BENEF_ADR", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_BENEFICIARIES", ObjectTypes.View, "Довідник бенефіціарів (неризидентів)", "Адреса бенефіціара"));
            Fields.Add( new BbField("COMMENTS", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_BENEFICIARIES", ObjectTypes.View, "Довідник бенефіціарів (неризидентів)", "Коментар"));
            Fields.Add( new BbField("DELETE_DATE", OracleDbType.Date, true, false, false, false, false, "V_CIM_BENEFICIARIES", ObjectTypes.View, "Довідник бенефіціарів (неризидентів)", "Дата видалення"));        
        }
        public Decimal? BENEF_ID { get { return (Decimal?)FindField("BENEF_ID").Value; } set {SetField("BENEF_ID", value);} }
        public String BENEF_NAME { get { return (String)FindField("BENEF_NAME").Value; } set {SetField("BENEF_NAME", value);} }
        public Decimal? COUNTRY_ID { get { return (Decimal?)FindField("COUNTRY_ID").Value; } set {SetField("COUNTRY_ID", value);} }
        public String COUNTRY_NAME { get { return (String)FindField("COUNTRY_NAME").Value; } set {SetField("COUNTRY_NAME", value);} }
        public String BENEF_ADR { get { return (String)FindField("BENEF_ADR").Value; } set {SetField("BENEF_ADR", value);} }
        public String COMMENTS { get { return (String)FindField("COMMENTS").Value; } set {SetField("COMMENTS", value);} }
        public DateTime? DELETE_DATE { get { return (DateTime?)FindField("DELETE_DATE").Value; } set {SetField("DELETE_DATE", value);} }
    }

    public sealed class VCimBeneficiariesFilters : BbFilters
    {
        public VCimBeneficiariesFilters(BbDataSource Parent) : base (Parent)
        {
            BENEF_ID = new BBDecimalFilter(this, "BENEF_ID");
            BENEF_NAME = new BBVarchar2Filter(this, "BENEF_NAME");
            COUNTRY_ID = new BBDecimalFilter(this, "COUNTRY_ID");
            COUNTRY_NAME = new BBVarchar2Filter(this, "COUNTRY_NAME");
            BENEF_ADR = new BBVarchar2Filter(this, "BENEF_ADR");
            COMMENTS = new BBVarchar2Filter(this, "COMMENTS");
            DELETE_DATE = new BBDateFilter(this, "DELETE_DATE");
        }
        public BBDecimalFilter BENEF_ID;
        public BBVarchar2Filter BENEF_NAME;
        public BBDecimalFilter COUNTRY_ID;
        public BBVarchar2Filter COUNTRY_NAME;
        public BBVarchar2Filter BENEF_ADR;
        public BBVarchar2Filter COMMENTS;
        public BBDateFilter DELETE_DATE;
    }

    public partial class VCimBeneficiaries : BbTable<VCimBeneficiariesRecord, VCimBeneficiariesFilters>
    {
        public VCimBeneficiaries() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VCimBeneficiaries(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VCimBeneficiariesRecord> Select(VCimBeneficiariesRecord Item)
        {
            List<VCimBeneficiariesRecord> res = new List<VCimBeneficiariesRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VCimBeneficiariesRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (Decimal?)null : Convert.ToDecimal(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (DateTime?)null : Convert.ToDateTime(rdr[7]))
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