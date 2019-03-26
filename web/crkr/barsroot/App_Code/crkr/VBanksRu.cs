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

namespace Bars.CRKR
{
    public sealed class VBanksRuRecord : BbRecord
    {
        public VBanksRuRecord(): base()
        {
            fillFields();
        }
        public VBanksRuRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VBanksRuRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? RU, String RU_NAME, String MFO, String BANKNAME)
            : this(Parent)
        {
            this.RU = RU;
            this.RU_NAME = RU_NAME;
            this.MFO = MFO;
            this.BANKNAME = BANKNAME;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("RU", OracleDbType.Decimal, true, false, false, false, false, "V_BANKS_RU", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("RU_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_BANKS_RU", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("MFO", OracleDbType.Varchar2, true, false, false, false, false, "V_BANKS_RU", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("BANKNAME", OracleDbType.Varchar2, true, false, false, false, false, "V_BANKS_RU", ObjectTypes.View, "", ""));        
        }
        public Decimal? RU { get { return (Decimal?)FindField("RU").Value; } set {SetField("RU", value);} }
        public String RU_NAME { get { return (String)FindField("RU_NAME").Value; } set {SetField("RU_NAME", value);} }
        public String MFO { get { return (String)FindField("MFO").Value; } set {SetField("MFO", value);} }
        public String BANKNAME { get { return (String)FindField("BANKNAME").Value; } set {SetField("BANKNAME", value);} }
    }

    public sealed class VBanksRuFilters : BbFilters
    {
        public VBanksRuFilters(BbDataSource Parent) : base (Parent)
        {
            RU = new BBDecimalFilter(this, "RU");
            RU_NAME = new BBVarchar2Filter(this, "RU_NAME");
            MFO = new BBVarchar2Filter(this, "MFO");
            BANKNAME = new BBVarchar2Filter(this, "BANKNAME");
        }
        public BBDecimalFilter RU;
        public BBVarchar2Filter RU_NAME;
        public BBVarchar2Filter MFO;
        public BBVarchar2Filter BANKNAME;
    }

    public partial class VBanksRu : BbTable<VBanksRuRecord, VBanksRuFilters>
    {
        public VBanksRu() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VBanksRu(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VBanksRuRecord> Select(VBanksRuRecord Item)
        {
            List<VBanksRuRecord> res = new List<VBanksRuRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VBanksRuRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]))
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