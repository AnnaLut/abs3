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

namespace Bars.Ins
{
    public sealed class VInsPartnerTypeBranchesRecord : BbRecord
    {
        public VInsPartnerTypeBranchesRecord(): base()
        {
            fillFields();
        }
        public VInsPartnerTypeBranchesRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VInsPartnerTypeBranchesRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? ID, String BRANCH, String BRANCH_NAME, Decimal? PARTNER_ID, String PARTNER_NAME, Decimal? TYPE_ID, String TYPE_NAME, String TARIFF_ID, String TARIFF_NAME, String FEE_ID, String FEE_NAME, String LIMIT_ID, String LIMIT_NAME, Decimal? APPLY_HIER)
            : this(Parent)
        {
            this.ID = ID;
            this.BRANCH = BRANCH;
            this.BRANCH_NAME = BRANCH_NAME;
            this.PARTNER_ID = PARTNER_ID;
            this.PARTNER_NAME = PARTNER_NAME;
            this.TYPE_ID = TYPE_ID;
            this.TYPE_NAME = TYPE_NAME;
            this.TARIFF_ID = TARIFF_ID;
            this.TARIFF_NAME = TARIFF_NAME;
            this.FEE_ID = FEE_ID;
            this.FEE_NAME = FEE_NAME;
            this.LIMIT_ID = LIMIT_ID;
            this.LIMIT_NAME = LIMIT_NAME;
            this.APPLY_HIER = APPLY_HIER;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("ID", OracleDbType.Decimal, false, false, false, false, false, "V_INS_PARTNER_TYPE_BRANCHES", ObjectTypes.View, "Доступність СК у відділеннях (Представлення)", "Ідентифікатор"));
            Fields.Add( new BbField("BRANCH", OracleDbType.Varchar2, false, false, false, false, false, "V_INS_PARTNER_TYPE_BRANCHES", ObjectTypes.View, "Доступність СК у відділеннях (Представлення)", "Код відділення"));
            Fields.Add( new BbField("BRANCH_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_INS_PARTNER_TYPE_BRANCHES", ObjectTypes.View, "Доступність СК у відділеннях (Представлення)", "Найм. відділення"));
            Fields.Add( new BbField("PARTNER_ID", OracleDbType.Decimal, true, false, false, false, false, "V_INS_PARTNER_TYPE_BRANCHES", ObjectTypes.View, "Доступність СК у відділеннях (Представлення)", "Ідентифікатор СК"));
            Fields.Add( new BbField("PARTNER_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_INS_PARTNER_TYPE_BRANCHES", ObjectTypes.View, "Доступність СК у відділеннях (Представлення)", "Найм. СК"));
            Fields.Add( new BbField("TYPE_ID", OracleDbType.Decimal, true, false, false, false, false, "V_INS_PARTNER_TYPE_BRANCHES", ObjectTypes.View, "Доступність СК у відділеннях (Представлення)", "Ідентифікатор типу страхового договору"));
            Fields.Add( new BbField("TYPE_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_INS_PARTNER_TYPE_BRANCHES", ObjectTypes.View, "Доступність СК у відділеннях (Представлення)", "Найм. типу страхового договору"));
            Fields.Add( new BbField("TARIFF_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_INS_PARTNER_TYPE_BRANCHES", ObjectTypes.View, "Доступність СК у відділеннях (Представлення)", "Ід. тарифу на компанію та тип та відділення"));
            Fields.Add( new BbField("TARIFF_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_INS_PARTNER_TYPE_BRANCHES", ObjectTypes.View, "Доступність СК у відділеннях (Представлення)", "Найм. тарифу на компанію та тип та відділення"));
            Fields.Add( new BbField("FEE_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_INS_PARTNER_TYPE_BRANCHES", ObjectTypes.View, "Доступність СК у відділеннях (Представлення)", "Ід. комісії на компанію та тип та відділення"));
            Fields.Add( new BbField("FEE_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_INS_PARTNER_TYPE_BRANCHES", ObjectTypes.View, "Доступність СК у відділеннях (Представлення)", "Найм. комісії на компанію та тип та відділення"));
            Fields.Add( new BbField("LIMIT_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_INS_PARTNER_TYPE_BRANCHES", ObjectTypes.View, "Доступність СК у відділеннях (Представлення)", "Ід. ліміту на тип даної СК у відділенні"));
            Fields.Add( new BbField("LIMIT_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_INS_PARTNER_TYPE_BRANCHES", ObjectTypes.View, "Доступність СК у відділеннях (Представлення)", "Найм. ліміту на тип даної СК у відділенні"));
            Fields.Add( new BbField("APPLY_HIER", OracleDbType.Decimal, false, false, false, false, false, "V_INS_PARTNER_TYPE_BRANCHES", ObjectTypes.View, "Доступність СК у відділеннях (Представлення)", "Застосовувати до залежних"));        
        }
        public Decimal? ID { get { return (Decimal?)FindField("ID").Value; } set {SetField("ID", value);} }
        public String BRANCH { get { return (String)FindField("BRANCH").Value; } set {SetField("BRANCH", value);} }
        public String BRANCH_NAME { get { return (String)FindField("BRANCH_NAME").Value; } set {SetField("BRANCH_NAME", value);} }
        public Decimal? PARTNER_ID { get { return (Decimal?)FindField("PARTNER_ID").Value; } set {SetField("PARTNER_ID", value);} }
        public String PARTNER_NAME { get { return (String)FindField("PARTNER_NAME").Value; } set {SetField("PARTNER_NAME", value);} }
        public Decimal? TYPE_ID { get { return (Decimal?)FindField("TYPE_ID").Value; } set {SetField("TYPE_ID", value);} }
        public String TYPE_NAME { get { return (String)FindField("TYPE_NAME").Value; } set {SetField("TYPE_NAME", value);} }
        public String TARIFF_ID { get { return (String)FindField("TARIFF_ID").Value; } set {SetField("TARIFF_ID", value);} }
        public String TARIFF_NAME { get { return (String)FindField("TARIFF_NAME").Value; } set {SetField("TARIFF_NAME", value);} }
        public String FEE_ID { get { return (String)FindField("FEE_ID").Value; } set {SetField("FEE_ID", value);} }
        public String FEE_NAME { get { return (String)FindField("FEE_NAME").Value; } set {SetField("FEE_NAME", value);} }
        public String LIMIT_ID { get { return (String)FindField("LIMIT_ID").Value; } set {SetField("LIMIT_ID", value);} }
        public String LIMIT_NAME { get { return (String)FindField("LIMIT_NAME").Value; } set {SetField("LIMIT_NAME", value);} }
        public Decimal? APPLY_HIER { get { return (Decimal?)FindField("APPLY_HIER").Value; } set {SetField("APPLY_HIER", value);} }
    }

    public sealed class VInsPartnerTypeBranchesFilters : BbFilters
    {
        public VInsPartnerTypeBranchesFilters(BbDataSource Parent) : base (Parent)
        {
            ID = new BBDecimalFilter(this, "ID");
            BRANCH = new BBVarchar2Filter(this, "BRANCH");
            BRANCH_NAME = new BBVarchar2Filter(this, "BRANCH_NAME");
            PARTNER_ID = new BBDecimalFilter(this, "PARTNER_ID");
            PARTNER_NAME = new BBVarchar2Filter(this, "PARTNER_NAME");
            TYPE_ID = new BBDecimalFilter(this, "TYPE_ID");
            TYPE_NAME = new BBVarchar2Filter(this, "TYPE_NAME");
            TARIFF_ID = new BBVarchar2Filter(this, "TARIFF_ID");
            TARIFF_NAME = new BBVarchar2Filter(this, "TARIFF_NAME");
            FEE_ID = new BBVarchar2Filter(this, "FEE_ID");
            FEE_NAME = new BBVarchar2Filter(this, "FEE_NAME");
            LIMIT_ID = new BBVarchar2Filter(this, "LIMIT_ID");
            LIMIT_NAME = new BBVarchar2Filter(this, "LIMIT_NAME");
            APPLY_HIER = new BBDecimalFilter(this, "APPLY_HIER");
        }
        public BBDecimalFilter ID;
        public BBVarchar2Filter BRANCH;
        public BBVarchar2Filter BRANCH_NAME;
        public BBDecimalFilter PARTNER_ID;
        public BBVarchar2Filter PARTNER_NAME;
        public BBDecimalFilter TYPE_ID;
        public BBVarchar2Filter TYPE_NAME;
        public BBVarchar2Filter TARIFF_ID;
        public BBVarchar2Filter TARIFF_NAME;
        public BBVarchar2Filter FEE_ID;
        public BBVarchar2Filter FEE_NAME;
        public BBVarchar2Filter LIMIT_ID;
        public BBVarchar2Filter LIMIT_NAME;
        public BBDecimalFilter APPLY_HIER;
    }

    public partial class VInsPartnerTypeBranches : BbTable<VInsPartnerTypeBranchesRecord, VInsPartnerTypeBranchesFilters>
    {
        public VInsPartnerTypeBranches() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VInsPartnerTypeBranches(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VInsPartnerTypeBranchesRecord> Select(VInsPartnerTypeBranchesRecord Item)
        {
            List<VInsPartnerTypeBranchesRecord> res = new List<VInsPartnerTypeBranchesRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VInsPartnerTypeBranchesRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (Decimal?)null : Convert.ToDecimal(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (Decimal?)null : Convert.ToDecimal(rdr[6]), 
                        rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
                        rdr.IsDBNull(8) ?  (String)null : Convert.ToString(rdr[8]), 
                        rdr.IsDBNull(9) ?  (String)null : Convert.ToString(rdr[9]), 
                        rdr.IsDBNull(10) ?  (String)null : Convert.ToString(rdr[10]), 
                        rdr.IsDBNull(11) ?  (String)null : Convert.ToString(rdr[11]), 
                        rdr.IsDBNull(12) ?  (String)null : Convert.ToString(rdr[12]), 
                        rdr.IsDBNull(13) ?  (String)null : Convert.ToString(rdr[13]), 
                        rdr.IsDBNull(14) ?  (Decimal?)null : Convert.ToDecimal(rdr[14]))
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