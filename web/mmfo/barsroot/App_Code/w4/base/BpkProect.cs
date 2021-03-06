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

namespace Bars.W4
{
    public sealed class BpkProectRecord : BbRecord
    {
        public BpkProectRecord(): base()
        {
            fillFields();
        }
        public BpkProectRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public BpkProectRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? ID, String NAME, String OKPO, String PRODUCT_CODE)
            : this(Parent)
        {
            this.ID = ID;
            this.NAME = NAME;
            this.OKPO = OKPO;
            this.PRODUCT_CODE = PRODUCT_CODE;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("ID", OracleDbType.Decimal, false, true, false, false, false, "BPK_PROECT", ObjectTypes.Table, "", ""));
            Fields.Add( new BbField("NAME", OracleDbType.Varchar2, true, false, false, false, false, "BPK_PROECT", ObjectTypes.Table, "", ""));
            Fields.Add( new BbField("OKPO", OracleDbType.Varchar2, true, false, false, false, false, "BPK_PROECT", ObjectTypes.Table, "", ""));
            Fields.Add( new BbField("PRODUCT_CODE", OracleDbType.Varchar2, true, false, false, false, false, "BPK_PROECT", ObjectTypes.Table, "", ""));        
        }
        public Decimal? ID { get { return (Decimal?)FindField("ID").Value; } set {SetField("ID", value);} }
        public String NAME { get { return (String)FindField("NAME").Value; } set {SetField("NAME", value);} }
        public String OKPO { get { return (String)FindField("OKPO").Value; } set {SetField("OKPO", value);} }
        public String PRODUCT_CODE { get { return (String)FindField("PRODUCT_CODE").Value; } set {SetField("PRODUCT_CODE", value);} }
    }

    public sealed class BpkProectFilters : BbFilters
    {
        public BpkProectFilters(BbDataSource Parent) : base (Parent)
        {
            ID = new BBDecimalFilter(this, "ID");
            NAME = new BBVarchar2Filter(this, "NAME");
            OKPO = new BBVarchar2Filter(this, "OKPO");
            PRODUCT_CODE = new BBVarchar2Filter(this, "PRODUCT_CODE");
        }
        public BBDecimalFilter ID;
        public BBVarchar2Filter NAME;
        public BBVarchar2Filter OKPO;
        public BBVarchar2Filter PRODUCT_CODE;
    }

    public partial class BpkProect : BbTable<BpkProectRecord, BpkProectFilters>
    {
        public BpkProect() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public BpkProect(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<BpkProectRecord> Select(BpkProectRecord Item)
        {
            List<BpkProectRecord> res = new List<BpkProectRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new BpkProectRecord(
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