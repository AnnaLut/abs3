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
    public sealed class WcsSrvHierarchyRecord : BbRecord
    {
        public WcsSrvHierarchyRecord(): base()
        {
            fillFields();
        }
        public WcsSrvHierarchyRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public WcsSrvHierarchyRecord(BbDataSource Parent, OracleDecimal RowScn, String ID, String NAME)
            : this(Parent)
        {
            this.ID = ID;
            this.NAME = NAME;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("ID", OracleDbType.Varchar2, false, true, false, false, false, "WCS_SRV_HIERARCHY", ObjectTypes.Table, "Иерархия служб", "Идентификатор"));
            Fields.Add( new BbField("NAME", OracleDbType.Varchar2, false, false, false, false, false, "WCS_SRV_HIERARCHY", ObjectTypes.Table, "Иерархия служб", "Наименование"));        
        }
        public String ID { get { return (String)FindField("ID").Value; } set {SetField("ID", value);} }
        public String NAME { get { return (String)FindField("NAME").Value; } set {SetField("NAME", value);} }
    }

    public sealed class WcsSrvHierarchyFilters : BbFilters
    {
        public WcsSrvHierarchyFilters(BbDataSource Parent) : base (Parent)
        {
            ID = new BBVarchar2Filter(this, "ID");
            NAME = new BBVarchar2Filter(this, "NAME");
        }
        public BBVarchar2Filter ID;
        public BBVarchar2Filter NAME;
    }

    public partial class WcsSrvHierarchy : BbTable<WcsSrvHierarchyRecord, WcsSrvHierarchyFilters>
    {
        public WcsSrvHierarchy() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public WcsSrvHierarchy(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<WcsSrvHierarchyRecord> Select(WcsSrvHierarchyRecord Item)
        {
            List<WcsSrvHierarchyRecord> res = new List<WcsSrvHierarchyRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new WcsSrvHierarchyRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (String)null : Convert.ToString(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]))
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