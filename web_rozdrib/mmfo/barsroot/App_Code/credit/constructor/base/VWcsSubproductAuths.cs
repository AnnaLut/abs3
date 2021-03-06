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
    public sealed class VWcsSubproductAuthsRecord : BbRecord
    {
        public VWcsSubproductAuthsRecord(): base()
        {
            fillFields();
        }
        public VWcsSubproductAuthsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsSubproductAuthsRecord(BbDataSource Parent, OracleDecimal RowScn, String SUBPRODUCT_ID, String AUTH_ID, String AUTH_NAME, Decimal? QUEST_CNT)
            : this(Parent)
        {
            this.SUBPRODUCT_ID = SUBPRODUCT_ID;
            this.AUTH_ID = AUTH_ID;
            this.AUTH_NAME = AUTH_NAME;
            this.QUEST_CNT = QUEST_CNT;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("SUBPRODUCT_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SUBPRODUCT_AUTHS", ObjectTypes.View, "Карта авторизации субпродукта (Представление)", "Идентификатор субродукта"));
            Fields.Add( new BbField("AUTH_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SUBPRODUCT_AUTHS", ObjectTypes.View, "Карта авторизации субпродукта (Представление)", "Идентификатор карты авторизации"));
            Fields.Add( new BbField("AUTH_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SUBPRODUCT_AUTHS", ObjectTypes.View, "Карта авторизации субпродукта (Представление)", "Наименование карты авторизации"));
            Fields.Add( new BbField("QUEST_CNT", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_SUBPRODUCT_AUTHS", ObjectTypes.View, "Карта авторизации субпродукта (Представление)", "Кол-во вопросов в карте"));        
        }
        public String SUBPRODUCT_ID { get { return (String)FindField("SUBPRODUCT_ID").Value; } set {SetField("SUBPRODUCT_ID", value);} }
        public String AUTH_ID { get { return (String)FindField("AUTH_ID").Value; } set {SetField("AUTH_ID", value);} }
        public String AUTH_NAME { get { return (String)FindField("AUTH_NAME").Value; } set {SetField("AUTH_NAME", value);} }
        public Decimal? QUEST_CNT { get { return (Decimal?)FindField("QUEST_CNT").Value; } set {SetField("QUEST_CNT", value);} }
    }

    public sealed class VWcsSubproductAuthsFilters : BbFilters
    {
        public VWcsSubproductAuthsFilters(BbDataSource Parent) : base (Parent)
        {
            SUBPRODUCT_ID = new BBVarchar2Filter(this, "SUBPRODUCT_ID");
            AUTH_ID = new BBVarchar2Filter(this, "AUTH_ID");
            AUTH_NAME = new BBVarchar2Filter(this, "AUTH_NAME");
            QUEST_CNT = new BBDecimalFilter(this, "QUEST_CNT");
        }
        public BBVarchar2Filter SUBPRODUCT_ID;
        public BBVarchar2Filter AUTH_ID;
        public BBVarchar2Filter AUTH_NAME;
        public BBDecimalFilter QUEST_CNT;
    }

    public partial class VWcsSubproductAuths : BbTable<VWcsSubproductAuthsRecord, VWcsSubproductAuthsFilters>
    {
        public VWcsSubproductAuths() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsSubproductAuths(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsSubproductAuthsRecord> Select(VWcsSubproductAuthsRecord Item)
        {
            List<VWcsSubproductAuthsRecord> res = new List<VWcsSubproductAuthsRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsSubproductAuthsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (String)null : Convert.ToString(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (Decimal?)null : Convert.ToDecimal(rdr[4]))
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