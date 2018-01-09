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
    public sealed class VWcsMgrBidsRecord : BbRecord
    {
        public VWcsMgrBidsRecord(): base()
        {
            fillFields();
        }
        public VWcsMgrBidsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsMgrBidsRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? BID_ID, String SUBPRODUCT_ID, String SUBPRODUCT_NAME, DateTime? CRT_DATE, String F, String I, String O, DateTime? BDATE, String INN, Decimal? SUMM, Decimal? OWN_FUNDS, String TERM, String CREDIT_CURRENCY, Decimal? SINGLE_FEE, Decimal? MONTHLY_FEE, Decimal? INTEREST_RATE, String REPAYMENT_METHOD, Decimal? REPAYMENT_DAY, String GARANTEES, Decimal? MGR_ID, String MGR_FIO, String BRANCH, String BRANCH_NAME, String STATES, String FIO)
            : this(Parent)
        {
            this.BID_ID = BID_ID;
            this.SUBPRODUCT_ID = SUBPRODUCT_ID;
            this.SUBPRODUCT_NAME = SUBPRODUCT_NAME;
            this.CRT_DATE = CRT_DATE;
            this.F = F;
            this.I = I;
            this.O = O;
            this.BDATE = BDATE;
            this.INN = INN;
            this.SUMM = SUMM;
            this.OWN_FUNDS = OWN_FUNDS;
            this.TERM = TERM;
            this.CREDIT_CURRENCY = CREDIT_CURRENCY;
            this.SINGLE_FEE = SINGLE_FEE;
            this.MONTHLY_FEE = MONTHLY_FEE;
            this.INTEREST_RATE = INTEREST_RATE;
            this.REPAYMENT_METHOD = REPAYMENT_METHOD;
            this.REPAYMENT_DAY = REPAYMENT_DAY;
            this.GARANTEES = GARANTEES;
            this.MGR_ID = MGR_ID;
            this.MGR_FIO = MGR_FIO;
            this.BRANCH = BRANCH;
            this.BRANCH_NAME = BRANCH_NAME;
            this.STATES = STATES;
            this.FIO = FIO;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("BID_ID", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Идентификатор заявки"));
            Fields.Add( new BbField("SUBPRODUCT_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Идентификатор субпродукта"));
            Fields.Add( new BbField("SUBPRODUCT_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Наименование субпродукта"));
            Fields.Add( new BbField("CRT_DATE", OracleDbType.Date, false, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Дата создания заявки"));
            Fields.Add( new BbField("F", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Ф клиента"));
            Fields.Add( new BbField("I", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "И клиента"));
            Fields.Add( new BbField("O", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "О клиента"));
            Fields.Add( new BbField("BDATE", OracleDbType.Date, true, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Дата рождения клиента"));
            Fields.Add( new BbField("INN", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "ИНН клиента"));
            Fields.Add( new BbField("SUMM", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Сумма кредита"));
            Fields.Add( new BbField("OWN_FUNDS", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Сума власних коштів"));
            Fields.Add( new BbField("TERM", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Срок кредита"));
            Fields.Add( new BbField("CREDIT_CURRENCY", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Валюта кредиту"));
            Fields.Add( new BbField("SINGLE_FEE", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Комісія банку разова"));
            Fields.Add( new BbField("MONTHLY_FEE", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Комісія банку щомісячна"));
            Fields.Add( new BbField("INTEREST_RATE", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Відсоткова ставка"));
            Fields.Add( new BbField("REPAYMENT_METHOD", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Метод погашення"));
            Fields.Add( new BbField("REPAYMENT_DAY", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "День погашення"));
            Fields.Add( new BbField("GARANTEES", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Обеспечения"));
            Fields.Add( new BbField("MGR_ID", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Ид менеджера"));
            Fields.Add( new BbField("MGR_FIO", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "ФИО менеджера"));
            Fields.Add( new BbField("BRANCH", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Идентификатор отделения"));
            Fields.Add( new BbField("BRANCH_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Наименование отделения"));
            Fields.Add( new BbField("STATES", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "Состояния"));
            Fields.Add( new BbField("FIO", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_MGR_BIDS", ObjectTypes.View, "Заявки менеджера (Представление)", "ФИО клиента"));        
        }
        public Decimal? BID_ID { get { return (Decimal?)FindField("BID_ID").Value; } set {SetField("BID_ID", value);} }
        public String SUBPRODUCT_ID { get { return (String)FindField("SUBPRODUCT_ID").Value; } set {SetField("SUBPRODUCT_ID", value);} }
        public String SUBPRODUCT_NAME { get { return (String)FindField("SUBPRODUCT_NAME").Value; } set {SetField("SUBPRODUCT_NAME", value);} }
        public DateTime? CRT_DATE { get { return (DateTime?)FindField("CRT_DATE").Value; } set {SetField("CRT_DATE", value);} }
        public String F { get { return (String)FindField("F").Value; } set {SetField("F", value);} }
        public String I { get { return (String)FindField("I").Value; } set {SetField("I", value);} }
        public String O { get { return (String)FindField("O").Value; } set {SetField("O", value);} }
        public DateTime? BDATE { get { return (DateTime?)FindField("BDATE").Value; } set {SetField("BDATE", value);} }
        public String INN { get { return (String)FindField("INN").Value; } set {SetField("INN", value);} }
        public Decimal? SUMM { get { return (Decimal?)FindField("SUMM").Value; } set {SetField("SUMM", value);} }
        public Decimal? OWN_FUNDS { get { return (Decimal?)FindField("OWN_FUNDS").Value; } set {SetField("OWN_FUNDS", value);} }
        public String TERM { get { return (String)FindField("TERM").Value; } set {SetField("TERM", value);} }
        public String CREDIT_CURRENCY { get { return (String)FindField("CREDIT_CURRENCY").Value; } set {SetField("CREDIT_CURRENCY", value);} }
        public Decimal? SINGLE_FEE { get { return (Decimal?)FindField("SINGLE_FEE").Value; } set {SetField("SINGLE_FEE", value);} }
        public Decimal? MONTHLY_FEE { get { return (Decimal?)FindField("MONTHLY_FEE").Value; } set {SetField("MONTHLY_FEE", value);} }
        public Decimal? INTEREST_RATE { get { return (Decimal?)FindField("INTEREST_RATE").Value; } set {SetField("INTEREST_RATE", value);} }
        public String REPAYMENT_METHOD { get { return (String)FindField("REPAYMENT_METHOD").Value; } set {SetField("REPAYMENT_METHOD", value);} }
        public Decimal? REPAYMENT_DAY { get { return (Decimal?)FindField("REPAYMENT_DAY").Value; } set {SetField("REPAYMENT_DAY", value);} }
        public String GARANTEES { get { return (String)FindField("GARANTEES").Value; } set {SetField("GARANTEES", value);} }
        public Decimal? MGR_ID { get { return (Decimal?)FindField("MGR_ID").Value; } set {SetField("MGR_ID", value);} }
        public String MGR_FIO { get { return (String)FindField("MGR_FIO").Value; } set {SetField("MGR_FIO", value);} }
        public String BRANCH { get { return (String)FindField("BRANCH").Value; } set {SetField("BRANCH", value);} }
        public String BRANCH_NAME { get { return (String)FindField("BRANCH_NAME").Value; } set {SetField("BRANCH_NAME", value);} }
        public String STATES { get { return (String)FindField("STATES").Value; } set {SetField("STATES", value);} }
        public String FIO { get { return (String)FindField("FIO").Value; } set {SetField("FIO", value);} }
    }

    public sealed class VWcsMgrBidsFilters : BbFilters
    {
        public VWcsMgrBidsFilters(BbDataSource Parent) : base (Parent)
        {
            BID_ID = new BBDecimalFilter(this, "BID_ID");
            SUBPRODUCT_ID = new BBVarchar2Filter(this, "SUBPRODUCT_ID");
            SUBPRODUCT_NAME = new BBVarchar2Filter(this, "SUBPRODUCT_NAME");
            CRT_DATE = new BBDateFilter(this, "CRT_DATE");
            F = new BBVarchar2Filter(this, "F");
            I = new BBVarchar2Filter(this, "I");
            O = new BBVarchar2Filter(this, "O");
            BDATE = new BBDateFilter(this, "BDATE");
            INN = new BBVarchar2Filter(this, "INN");
            SUMM = new BBDecimalFilter(this, "SUMM");
            OWN_FUNDS = new BBDecimalFilter(this, "OWN_FUNDS");
            TERM = new BBVarchar2Filter(this, "TERM");
            CREDIT_CURRENCY = new BBVarchar2Filter(this, "CREDIT_CURRENCY");
            SINGLE_FEE = new BBDecimalFilter(this, "SINGLE_FEE");
            MONTHLY_FEE = new BBDecimalFilter(this, "MONTHLY_FEE");
            INTEREST_RATE = new BBDecimalFilter(this, "INTEREST_RATE");
            REPAYMENT_METHOD = new BBVarchar2Filter(this, "REPAYMENT_METHOD");
            REPAYMENT_DAY = new BBDecimalFilter(this, "REPAYMENT_DAY");
            GARANTEES = new BBVarchar2Filter(this, "GARANTEES");
            MGR_ID = new BBDecimalFilter(this, "MGR_ID");
            MGR_FIO = new BBVarchar2Filter(this, "MGR_FIO");
            BRANCH = new BBVarchar2Filter(this, "BRANCH");
            BRANCH_NAME = new BBVarchar2Filter(this, "BRANCH_NAME");
            STATES = new BBVarchar2Filter(this, "STATES");
            FIO = new BBVarchar2Filter(this, "FIO");
        }
        public BBDecimalFilter BID_ID;
        public BBVarchar2Filter SUBPRODUCT_ID;
        public BBVarchar2Filter SUBPRODUCT_NAME;
        public BBDateFilter CRT_DATE;
        public BBVarchar2Filter F;
        public BBVarchar2Filter I;
        public BBVarchar2Filter O;
        public BBDateFilter BDATE;
        public BBVarchar2Filter INN;
        public BBDecimalFilter SUMM;
        public BBDecimalFilter OWN_FUNDS;
        public BBVarchar2Filter TERM;
        public BBVarchar2Filter CREDIT_CURRENCY;
        public BBDecimalFilter SINGLE_FEE;
        public BBDecimalFilter MONTHLY_FEE;
        public BBDecimalFilter INTEREST_RATE;
        public BBVarchar2Filter REPAYMENT_METHOD;
        public BBDecimalFilter REPAYMENT_DAY;
        public BBVarchar2Filter GARANTEES;
        public BBDecimalFilter MGR_ID;
        public BBVarchar2Filter MGR_FIO;
        public BBVarchar2Filter BRANCH;
        public BBVarchar2Filter BRANCH_NAME;
        public BBVarchar2Filter STATES;
        public BBVarchar2Filter FIO;
    }

    public partial class VWcsMgrBids : BbTable<VWcsMgrBidsRecord, VWcsMgrBidsFilters>
    {
        public VWcsMgrBids() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsMgrBids(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsMgrBidsRecord> Select(VWcsMgrBidsRecord Item)
        {
            List<VWcsMgrBidsRecord> res = new List<VWcsMgrBidsRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsMgrBidsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (DateTime?)null : Convert.ToDateTime(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
                        rdr.IsDBNull(8) ?  (DateTime?)null : Convert.ToDateTime(rdr[8]), 
                        rdr.IsDBNull(9) ?  (String)null : Convert.ToString(rdr[9]), 
                        rdr.IsDBNull(10) ?  (Decimal?)null : Convert.ToDecimal(rdr[10]), 
                        rdr.IsDBNull(11) ?  (Decimal?)null : Convert.ToDecimal(rdr[11]), 
                        rdr.IsDBNull(12) ?  (String)null : Convert.ToString(rdr[12]), 
                        rdr.IsDBNull(13) ?  (String)null : Convert.ToString(rdr[13]), 
                        rdr.IsDBNull(14) ?  (Decimal?)null : Convert.ToDecimal(rdr[14]), 
                        rdr.IsDBNull(15) ?  (Decimal?)null : Convert.ToDecimal(rdr[15]), 
                        rdr.IsDBNull(16) ?  (Decimal?)null : Convert.ToDecimal(rdr[16]), 
                        rdr.IsDBNull(17) ?  (String)null : Convert.ToString(rdr[17]), 
                        rdr.IsDBNull(18) ?  (Decimal?)null : Convert.ToDecimal(rdr[18]), 
                        rdr.IsDBNull(19) ?  (String)null : Convert.ToString(rdr[19]), 
                        rdr.IsDBNull(20) ?  (Decimal?)null : Convert.ToDecimal(rdr[20]), 
                        rdr.IsDBNull(21) ?  (String)null : Convert.ToString(rdr[21]), 
                        rdr.IsDBNull(22) ?  (String)null : Convert.ToString(rdr[22]), 
                        rdr.IsDBNull(23) ?  (String)null : Convert.ToString(rdr[23]), 
                        rdr.IsDBNull(24) ?  (String)null : Convert.ToString(rdr[24]), 
                        rdr.IsDBNull(25) ?  (String)null : Convert.ToString(rdr[25]))
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