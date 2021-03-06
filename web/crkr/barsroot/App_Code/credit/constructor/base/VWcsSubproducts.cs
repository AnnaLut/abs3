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
    public sealed class VWcsSubproductsRecord : BbRecord
    {
        public VWcsSubproductsRecord(): base()
        {
            fillFields();
        }
        public VWcsSubproductsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsSubproductsRecord(BbDataSource Parent, OracleDecimal RowScn, String SUBPRODUCT_ID, String SUBPRODUCT_NAME, String PRODUCT_ID, String SUBPRODUCT_DESC)
            : this(Parent)
        {
            this.SUBPRODUCT_ID = SUBPRODUCT_ID;
            this.SUBPRODUCT_NAME = SUBPRODUCT_NAME;
            this.PRODUCT_ID = PRODUCT_ID;
            this.SUBPRODUCT_DESC = SUBPRODUCT_DESC;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("SUBPRODUCT_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SUBPRODUCTS", ObjectTypes.View, "Субпродукты (Представление)", "Идентификатор"));
            Fields.Add( new BbField("SUBPRODUCT_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SUBPRODUCTS", ObjectTypes.View, "Субпродукты (Представление)", "Наименование"));
            Fields.Add( new BbField("PRODUCT_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SUBPRODUCTS", ObjectTypes.View, "Субпродукты (Представление)", "Иденификатор продукта"));
            Fields.Add( new BbField("SUBPRODUCT_DESC", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SUBPRODUCTS", ObjectTypes.View, "Субпродукты (Представление)", "Расширеное наименование"));        
        }
        public String SUBPRODUCT_ID { get { return (String)FindField("SUBPRODUCT_ID").Value; } set {SetField("SUBPRODUCT_ID", value);} }
        public String SUBPRODUCT_NAME { get { return (String)FindField("SUBPRODUCT_NAME").Value; } set {SetField("SUBPRODUCT_NAME", value);} }
        public String PRODUCT_ID { get { return (String)FindField("PRODUCT_ID").Value; } set {SetField("PRODUCT_ID", value);} }
        public String SUBPRODUCT_DESC { get { return (String)FindField("SUBPRODUCT_DESC").Value; } set {SetField("SUBPRODUCT_DESC", value);} }
    }

    public sealed class VWcsSubproductsFilters : BbFilters
    {
        public VWcsSubproductsFilters(BbDataSource Parent) : base (Parent)
        {
            SUBPRODUCT_ID = new BBVarchar2Filter(this, "SUBPRODUCT_ID");
            SUBPRODUCT_NAME = new BBVarchar2Filter(this, "SUBPRODUCT_NAME");
            PRODUCT_ID = new BBVarchar2Filter(this, "PRODUCT_ID");
            SUBPRODUCT_DESC = new BBVarchar2Filter(this, "SUBPRODUCT_DESC");
        }
        public BBVarchar2Filter SUBPRODUCT_ID;
        public BBVarchar2Filter SUBPRODUCT_NAME;
        public BBVarchar2Filter PRODUCT_ID;
        public BBVarchar2Filter SUBPRODUCT_DESC;
    }

    public partial class VWcsSubproducts : BbTable<VWcsSubproductsRecord, VWcsSubproductsFilters>
    {
        public VWcsSubproducts() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsSubproducts(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsSubproductsRecord> Select(VWcsSubproductsRecord Item)
        {
            List<VWcsSubproductsRecord> res = new List<VWcsSubproductsRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsSubproductsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (String)null : Convert.ToString(rdr[1]), 
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