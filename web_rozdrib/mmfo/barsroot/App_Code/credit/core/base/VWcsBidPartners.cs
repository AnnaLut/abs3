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
    public sealed class VWcsBidPartnersRecord : BbRecord
    {
        public VWcsBidPartnersRecord(): base()
        {
            fillFields();
        }
        public VWcsBidPartnersRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsBidPartnersRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? BID_ID, Decimal? PARTNER_ID, String PARTNER_NAME, String TYPE_ID, String PTN_MFO, String PTN_NLS, String PTN_OKPO, String PTN_NAME)
            : this(Parent)
        {
            this.BID_ID = BID_ID;
            this.PARTNER_ID = PARTNER_ID;
            this.PARTNER_NAME = PARTNER_NAME;
            this.TYPE_ID = TYPE_ID;
            this.PTN_MFO = PTN_MFO;
            this.PTN_NLS = PTN_NLS;
            this.PTN_OKPO = PTN_OKPO;
            this.PTN_NAME = PTN_NAME;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("BID_ID", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_BID_PARTNERS", ObjectTypes.View, "Торговцы-партнеры заявки (Представление)", "Идентификатор заявки"));
            Fields.Add( new BbField("PARTNER_ID", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_BID_PARTNERS", ObjectTypes.View, "Торговцы-партнеры заявки (Представление)", "Идентификатор торговца-партнера"));
            Fields.Add( new BbField("PARTNER_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_PARTNERS", ObjectTypes.View, "Торговцы-партнеры заявки (Представление)", "Наименование торговца-партнера"));
            Fields.Add( new BbField("TYPE_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_PARTNERS", ObjectTypes.View, "Торговцы-партнеры заявки (Представление)", "Тип торговца-партнера"));
            Fields.Add( new BbField("PTN_MFO", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_PARTNERS", ObjectTypes.View, "Торговцы-партнеры заявки (Представление)", "МФО банка партнера"));
            Fields.Add( new BbField("PTN_NLS", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_PARTNERS", ObjectTypes.View, "Торговцы-партнеры заявки (Представление)", "Счет партнера"));
            Fields.Add( new BbField("PTN_OKPO", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_PARTNERS", ObjectTypes.View, "Торговцы-партнеры заявки (Представление)", "Идент. код партнера"));
            Fields.Add( new BbField("PTN_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_PARTNERS", ObjectTypes.View, "Торговцы-партнеры заявки (Представление)", "Наименование партнера"));        
        }
        public Decimal? BID_ID { get { return (Decimal?)FindField("BID_ID").Value; } set {SetField("BID_ID", value);} }
        public Decimal? PARTNER_ID { get { return (Decimal?)FindField("PARTNER_ID").Value; } set {SetField("PARTNER_ID", value);} }
        public String PARTNER_NAME { get { return (String)FindField("PARTNER_NAME").Value; } set {SetField("PARTNER_NAME", value);} }
        public String TYPE_ID { get { return (String)FindField("TYPE_ID").Value; } set {SetField("TYPE_ID", value);} }
        public String PTN_MFO { get { return (String)FindField("PTN_MFO").Value; } set {SetField("PTN_MFO", value);} }
        public String PTN_NLS { get { return (String)FindField("PTN_NLS").Value; } set {SetField("PTN_NLS", value);} }
        public String PTN_OKPO { get { return (String)FindField("PTN_OKPO").Value; } set {SetField("PTN_OKPO", value);} }
        public String PTN_NAME { get { return (String)FindField("PTN_NAME").Value; } set {SetField("PTN_NAME", value);} }
    }

    public sealed class VWcsBidPartnersFilters : BbFilters
    {
        public VWcsBidPartnersFilters(BbDataSource Parent) : base (Parent)
        {
            BID_ID = new BBDecimalFilter(this, "BID_ID");
            PARTNER_ID = new BBDecimalFilter(this, "PARTNER_ID");
            PARTNER_NAME = new BBVarchar2Filter(this, "PARTNER_NAME");
            TYPE_ID = new BBVarchar2Filter(this, "TYPE_ID");
            PTN_MFO = new BBVarchar2Filter(this, "PTN_MFO");
            PTN_NLS = new BBVarchar2Filter(this, "PTN_NLS");
            PTN_OKPO = new BBVarchar2Filter(this, "PTN_OKPO");
            PTN_NAME = new BBVarchar2Filter(this, "PTN_NAME");
        }
        public BBDecimalFilter BID_ID;
        public BBDecimalFilter PARTNER_ID;
        public BBVarchar2Filter PARTNER_NAME;
        public BBVarchar2Filter TYPE_ID;
        public BBVarchar2Filter PTN_MFO;
        public BBVarchar2Filter PTN_NLS;
        public BBVarchar2Filter PTN_OKPO;
        public BBVarchar2Filter PTN_NAME;
    }

    public partial class VWcsBidPartners : BbTable<VWcsBidPartnersRecord, VWcsBidPartnersFilters>
    {
        public VWcsBidPartners() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsBidPartners(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsBidPartnersRecord> Select(VWcsBidPartnersRecord Item)
        {
            List<VWcsBidPartnersRecord> res = new List<VWcsBidPartnersRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsBidPartnersRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (Decimal?)null : Convert.ToDecimal(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
                        rdr.IsDBNull(8) ?  (String)null : Convert.ToString(rdr[8]))
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