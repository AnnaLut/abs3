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
    public sealed class VWcsMacsRecord : BbRecord
    {
        public VWcsMacsRecord(): base()
        {
            fillFields();
        }
        public VWcsMacsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsMacsRecord(BbDataSource Parent, OracleDecimal RowScn, String MAC_ID, String MAC_NAME, String TYPE_ID, String TYPE_NAME, String APPLY_LEVEL, String APPLY_LEVEL_NAME)
            : this(Parent)
        {
            this.MAC_ID = MAC_ID;
            this.MAC_NAME = MAC_NAME;
            this.TYPE_ID = TYPE_ID;
            this.TYPE_NAME = TYPE_NAME;
            this.APPLY_LEVEL = APPLY_LEVEL;
            this.APPLY_LEVEL_NAME = APPLY_LEVEL_NAME;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("MAC_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_MACS", ObjectTypes.View, "МАКи (представление)", "Идентификатор"));
            Fields.Add( new BbField("MAC_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_MACS", ObjectTypes.View, "МАКи (представление)", "Наименование"));
            Fields.Add( new BbField("TYPE_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_MACS", ObjectTypes.View, "МАКи (представление)", "Идентификатор типа"));
            Fields.Add( new BbField("TYPE_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_MACS", ObjectTypes.View, "МАКи (представление)", "Наименование типа"));
            Fields.Add( new BbField("APPLY_LEVEL", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_MACS", ObjectTypes.View, "МАКи (представление)", "Уровень применения"));
            Fields.Add( new BbField("APPLY_LEVEL_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_MACS", ObjectTypes.View, "МАКи (представление)", "Наименование уровеня применения"));        
        }
        public String MAC_ID { get { return (String)FindField("MAC_ID").Value; } set {SetField("MAC_ID", value);} }
        public String MAC_NAME { get { return (String)FindField("MAC_NAME").Value; } set {SetField("MAC_NAME", value);} }
        public String TYPE_ID { get { return (String)FindField("TYPE_ID").Value; } set {SetField("TYPE_ID", value);} }
        public String TYPE_NAME { get { return (String)FindField("TYPE_NAME").Value; } set {SetField("TYPE_NAME", value);} }
        public String APPLY_LEVEL { get { return (String)FindField("APPLY_LEVEL").Value; } set {SetField("APPLY_LEVEL", value);} }
        public String APPLY_LEVEL_NAME { get { return (String)FindField("APPLY_LEVEL_NAME").Value; } set {SetField("APPLY_LEVEL_NAME", value);} }
    }

    public sealed class VWcsMacsFilters : BbFilters
    {
        public VWcsMacsFilters(BbDataSource Parent) : base (Parent)
        {
            MAC_ID = new BBVarchar2Filter(this, "MAC_ID");
            MAC_NAME = new BBVarchar2Filter(this, "MAC_NAME");
            TYPE_ID = new BBVarchar2Filter(this, "TYPE_ID");
            TYPE_NAME = new BBVarchar2Filter(this, "TYPE_NAME");
            APPLY_LEVEL = new BBVarchar2Filter(this, "APPLY_LEVEL");
            APPLY_LEVEL_NAME = new BBVarchar2Filter(this, "APPLY_LEVEL_NAME");
        }
        public BBVarchar2Filter MAC_ID;
        public BBVarchar2Filter MAC_NAME;
        public BBVarchar2Filter TYPE_ID;
        public BBVarchar2Filter TYPE_NAME;
        public BBVarchar2Filter APPLY_LEVEL;
        public BBVarchar2Filter APPLY_LEVEL_NAME;
    }

    public partial class VWcsMacs : BbTable<VWcsMacsRecord, VWcsMacsFilters>
    {
        public VWcsMacs() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsMacs(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsMacsRecord> Select(VWcsMacsRecord Item)
        {
            List<VWcsMacsRecord> res = new List<VWcsMacsRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsMacsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (String)null : Convert.ToString(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]))
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