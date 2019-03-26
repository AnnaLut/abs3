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
    public sealed class VWcsBidCreditdataGroupsRecord : BbRecord
    {
        public VWcsBidCreditdataGroupsRecord(): base()
        {
            fillFields();
        }
        public VWcsBidCreditdataGroupsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsBidCreditdataGroupsRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? BID_ID, String GROUP_ID, String GROUP_NAME, String SUBPRODUCT_ID)
            : this(Parent)
        {
            this.BID_ID = BID_ID;
            this.GROUP_ID = GROUP_ID;
            this.GROUP_NAME = GROUP_NAME;
            this.SUBPRODUCT_ID = SUBPRODUCT_ID;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("BID_ID", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_BID_CREDITDATA_GROUPS", ObjectTypes.View, "Групы анкеты заявки (Представление)", "Идентификатор заявки"));
            Fields.Add( new BbField("GROUP_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_CREDITDATA_GROUPS", ObjectTypes.View, "Групы анкеты заявки (Представление)", "Идентификатор групы карты-анкеты"));
            Fields.Add( new BbField("GROUP_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_CREDITDATA_GROUPS", ObjectTypes.View, "Групы анкеты заявки (Представление)", "Наименование групы карты-анкеты"));
            Fields.Add( new BbField("SUBPRODUCT_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_CREDITDATA_GROUPS", ObjectTypes.View, "Групы анкеты заявки (Представление)", "Наименование групы карты-анкеты"));
        }
        public Decimal? BID_ID { get { return (Decimal?)FindField("BID_ID").Value; } set {SetField("BID_ID", value);} }
        public String GROUP_ID { get { return (String)FindField("GROUP_ID").Value; } set {SetField("GROUP_ID", value);} }
        public String GROUP_NAME { get { return (String)FindField("GROUP_NAME").Value; } set {SetField("GROUP_NAME", value);} }
        public String SUBPRODUCT_ID { get { return (String)FindField("SUBPRODUCT_ID").Value; } set { SetField("SUBPRODUCT_ID", value); } }
    }

    public sealed class VWcsBidCreditdataGroupsFilters : BbFilters
    {
        public VWcsBidCreditdataGroupsFilters(BbDataSource Parent) : base (Parent)
        {
            BID_ID = new BBDecimalFilter(this, "BID_ID");
            GROUP_ID = new BBVarchar2Filter(this, "GROUP_ID");
            GROUP_NAME = new BBVarchar2Filter(this, "GROUP_NAME");
            SUBPRODUCT_ID = new BBVarchar2Filter(this, "SUBPRODUCT_ID");
        }
        public BBDecimalFilter BID_ID;
        public BBVarchar2Filter GROUP_ID;
        public BBVarchar2Filter GROUP_NAME;
        public BBVarchar2Filter SUBPRODUCT_ID;
    }

    public partial class VWcsBidCreditdataGroups : BbTable<VWcsBidCreditdataGroupsRecord, VWcsBidCreditdataGroupsFilters>
    {
        public VWcsBidCreditdataGroups() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsBidCreditdataGroups(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsBidCreditdataGroupsRecord> Select(VWcsBidCreditdataGroupsRecord Item)
        {
            List<VWcsBidCreditdataGroupsRecord> res = new List<VWcsBidCreditdataGroupsRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsBidCreditdataGroupsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]),
                        rdr.IsDBNull(4) ? (String)null : Convert.ToString(rdr[4]))
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