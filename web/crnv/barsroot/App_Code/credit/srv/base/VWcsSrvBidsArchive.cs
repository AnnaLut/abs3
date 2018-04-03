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
    public sealed class VWcsSrvBidsArchiveRecord : BbRecord
    {
        public VWcsSrvBidsArchiveRecord(): base()
        {
            fillFields();
        }
        public VWcsSrvBidsArchiveRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsSrvBidsArchiveRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? BID_ID, String SUBPRODUCT_ID, String SUBPRODUCT_NAME, DateTime? CRT_DATE, String STATUS, String F, String I, String O, String FIO, DateTime? BDATE, String INN, String WORK_MAIN_NAME, String WORK_MAIN_INN, String WORK_ADD_NAME, String WORK_ADD_INN, Decimal? PROPERTY_COST, Decimal? SUMM, Decimal? OWN_FUNDS, String TERM, String CREDIT_CURRENCY, Decimal? SINGLE_FEE, Decimal? MONTHLY_FEE, Decimal? INTEREST_RATE, String REPAYMENT_METHOD, Decimal? REPAYMENT_DAY, String GARANTEES, String GARANTEES_IDS, Decimal? MGR_ID, String MGR_FIO, String BRANCH, String BRANCH_NAME, String STATES, String SRV, DateTime? CHECKOUT_DAT, DateTime? CHECKIN_DAT, Decimal? CHECKOUT_USER_ID, String CHECKOUT_USER_FIO, String CHECKOUT_USER_BRANCH, String SRV_HIERARCHY)
            : this(Parent)
        {
            this.BID_ID = BID_ID;
            this.SUBPRODUCT_ID = SUBPRODUCT_ID;
            this.SUBPRODUCT_NAME = SUBPRODUCT_NAME;
            this.CRT_DATE = CRT_DATE;
            this.STATUS = STATUS;
            this.F = F;
            this.I = I;
            this.O = O;
            this.FIO = FIO;
            this.BDATE = BDATE;
            this.INN = INN;
            this.WORK_MAIN_NAME = WORK_MAIN_NAME;
            this.WORK_MAIN_INN = WORK_MAIN_INN;
            this.WORK_ADD_NAME = WORK_ADD_NAME;
            this.WORK_ADD_INN = WORK_ADD_INN;
            this.PROPERTY_COST = PROPERTY_COST;
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
            this.GARANTEES_IDS = GARANTEES_IDS;
            this.MGR_ID = MGR_ID;
            this.MGR_FIO = MGR_FIO;
            this.BRANCH = BRANCH;
            this.BRANCH_NAME = BRANCH_NAME;
            this.STATES = STATES;
            this.SRV = SRV;
            this.CHECKOUT_DAT = CHECKOUT_DAT;
            this.CHECKIN_DAT = CHECKIN_DAT;
            this.CHECKOUT_USER_ID = CHECKOUT_USER_ID;
            this.CHECKOUT_USER_FIO = CHECKOUT_USER_FIO;
            this.CHECKOUT_USER_BRANCH = CHECKOUT_USER_BRANCH;
            this.SRV_HIERARCHY = SRV_HIERARCHY;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("BID_ID", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Идентификатор заявки"));
            Fields.Add( new BbField("SUBPRODUCT_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Идентификатор субпродукта"));
            Fields.Add( new BbField("SUBPRODUCT_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Наименование субпродукта"));
            Fields.Add( new BbField("CRT_DATE", OracleDbType.Date, false, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Дата создания заявки"));
            Fields.Add( new BbField("STATUS", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Статус заявки"));
            Fields.Add( new BbField("F", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Ф клиента"));
            Fields.Add( new BbField("I", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "И клиента"));
            Fields.Add( new BbField("O", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "О клиента"));
            Fields.Add( new BbField("FIO", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "ФИО клиента"));
            Fields.Add( new BbField("BDATE", OracleDbType.Date, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Дата рождения клиента"));
            Fields.Add( new BbField("INN", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "ИНН клиента"));
            Fields.Add( new BbField("WORK_MAIN_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Наименование основного места работы"));
            Fields.Add( new BbField("WORK_MAIN_INN", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "ЄДРПОУ основного места работы"));
            Fields.Add( new BbField("WORK_ADD_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Наименование дополнительного места работы"));
            Fields.Add( new BbField("WORK_ADD_INN", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "ЄДРПОУ дополнительного места работы"));
            Fields.Add( new BbField("PROPERTY_COST", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Стоимость имущества"));
            Fields.Add( new BbField("SUMM", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Сумма кредита"));
            Fields.Add( new BbField("OWN_FUNDS", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Сума власних коштів"));
            Fields.Add( new BbField("TERM", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Срок кредита"));
            Fields.Add( new BbField("CREDIT_CURRENCY", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Валюта кредиту"));
            Fields.Add( new BbField("SINGLE_FEE", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Комісія банку разова"));
            Fields.Add( new BbField("MONTHLY_FEE", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Комісія банку щомісячна"));
            Fields.Add( new BbField("INTEREST_RATE", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Відсоткова ставка"));
            Fields.Add( new BbField("REPAYMENT_METHOD", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Метод погашення"));
            Fields.Add( new BbField("REPAYMENT_DAY", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "День погашення"));
            Fields.Add( new BbField("GARANTEES", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Обеспечения"));
            Fields.Add( new BbField("GARANTEES_IDS", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Обеспечения (коды)"));
            Fields.Add( new BbField("MGR_ID", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Ид менеджера"));
            Fields.Add( new BbField("MGR_FIO", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "ФИО менеджера"));
            Fields.Add( new BbField("BRANCH", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Идентификатор отделения"));
            Fields.Add( new BbField("BRANCH_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Наименование отделения"));
            Fields.Add( new BbField("STATES", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Состояния"));
            Fields.Add( new BbField("SRV", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", ""));
            Fields.Add( new BbField("CHECKOUT_DAT", OracleDbType.Date, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Дата начала обработки"));
            Fields.Add( new BbField("CHECKIN_DAT", OracleDbType.Date, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Дата конца обработки"));
            Fields.Add( new BbField("CHECKOUT_USER_ID", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Ид. пользователя обработки"));
            Fields.Add( new BbField("CHECKOUT_USER_FIO", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "ФИО пользователя обработки"));
            Fields.Add( new BbField("CHECKOUT_USER_BRANCH", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Код отделения пользователя обработки"));
            Fields.Add( new BbField("SRV_HIERARCHY", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SRV_BIDS_ARCHIVE", ObjectTypes.View, "Архив заявок службы (CБ, ЮС, СПА, ДР, ФЕП) (Представление)", "Идентификатор уровеня иерархии"));        
        }
        public Decimal? BID_ID { get { return (Decimal?)FindField("BID_ID").Value; } set {SetField("BID_ID", value);} }
        public String SUBPRODUCT_ID { get { return (String)FindField("SUBPRODUCT_ID").Value; } set {SetField("SUBPRODUCT_ID", value);} }
        public String SUBPRODUCT_NAME { get { return (String)FindField("SUBPRODUCT_NAME").Value; } set {SetField("SUBPRODUCT_NAME", value);} }
        public DateTime? CRT_DATE { get { return (DateTime?)FindField("CRT_DATE").Value; } set {SetField("CRT_DATE", value);} }
        public String STATUS { get { return (String)FindField("STATUS").Value; } set {SetField("STATUS", value);} }
        public String F { get { return (String)FindField("F").Value; } set {SetField("F", value);} }
        public String I { get { return (String)FindField("I").Value; } set {SetField("I", value);} }
        public String O { get { return (String)FindField("O").Value; } set {SetField("O", value);} }
        public String FIO { get { return (String)FindField("FIO").Value; } set {SetField("FIO", value);} }
        public DateTime? BDATE { get { return (DateTime?)FindField("BDATE").Value; } set {SetField("BDATE", value);} }
        public String INN { get { return (String)FindField("INN").Value; } set {SetField("INN", value);} }
        public String WORK_MAIN_NAME { get { return (String)FindField("WORK_MAIN_NAME").Value; } set {SetField("WORK_MAIN_NAME", value);} }
        public String WORK_MAIN_INN { get { return (String)FindField("WORK_MAIN_INN").Value; } set {SetField("WORK_MAIN_INN", value);} }
        public String WORK_ADD_NAME { get { return (String)FindField("WORK_ADD_NAME").Value; } set {SetField("WORK_ADD_NAME", value);} }
        public String WORK_ADD_INN { get { return (String)FindField("WORK_ADD_INN").Value; } set {SetField("WORK_ADD_INN", value);} }
        public Decimal? PROPERTY_COST { get { return (Decimal?)FindField("PROPERTY_COST").Value; } set {SetField("PROPERTY_COST", value);} }
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
        public String GARANTEES_IDS { get { return (String)FindField("GARANTEES_IDS").Value; } set {SetField("GARANTEES_IDS", value);} }
        public Decimal? MGR_ID { get { return (Decimal?)FindField("MGR_ID").Value; } set {SetField("MGR_ID", value);} }
        public String MGR_FIO { get { return (String)FindField("MGR_FIO").Value; } set {SetField("MGR_FIO", value);} }
        public String BRANCH { get { return (String)FindField("BRANCH").Value; } set {SetField("BRANCH", value);} }
        public String BRANCH_NAME { get { return (String)FindField("BRANCH_NAME").Value; } set {SetField("BRANCH_NAME", value);} }
        public String STATES { get { return (String)FindField("STATES").Value; } set {SetField("STATES", value);} }
        public String SRV { get { return (String)FindField("SRV").Value; } set {SetField("SRV", value);} }
        public DateTime? CHECKOUT_DAT { get { return (DateTime?)FindField("CHECKOUT_DAT").Value; } set {SetField("CHECKOUT_DAT", value);} }
        public DateTime? CHECKIN_DAT { get { return (DateTime?)FindField("CHECKIN_DAT").Value; } set {SetField("CHECKIN_DAT", value);} }
        public Decimal? CHECKOUT_USER_ID { get { return (Decimal?)FindField("CHECKOUT_USER_ID").Value; } set {SetField("CHECKOUT_USER_ID", value);} }
        public String CHECKOUT_USER_FIO { get { return (String)FindField("CHECKOUT_USER_FIO").Value; } set {SetField("CHECKOUT_USER_FIO", value);} }
        public String CHECKOUT_USER_BRANCH { get { return (String)FindField("CHECKOUT_USER_BRANCH").Value; } set {SetField("CHECKOUT_USER_BRANCH", value);} }
        public String SRV_HIERARCHY { get { return (String)FindField("SRV_HIERARCHY").Value; } set {SetField("SRV_HIERARCHY", value);} }
    }

    public sealed class VWcsSrvBidsArchiveFilters : BbFilters
    {
        public VWcsSrvBidsArchiveFilters(BbDataSource Parent) : base (Parent)
        {
            BID_ID = new BBDecimalFilter(this, "BID_ID");
            SUBPRODUCT_ID = new BBVarchar2Filter(this, "SUBPRODUCT_ID");
            SUBPRODUCT_NAME = new BBVarchar2Filter(this, "SUBPRODUCT_NAME");
            CRT_DATE = new BBDateFilter(this, "CRT_DATE");
            STATUS = new BBVarchar2Filter(this, "STATUS");
            F = new BBVarchar2Filter(this, "F");
            I = new BBVarchar2Filter(this, "I");
            O = new BBVarchar2Filter(this, "O");
            FIO = new BBVarchar2Filter(this, "FIO");
            BDATE = new BBDateFilter(this, "BDATE");
            INN = new BBVarchar2Filter(this, "INN");
            WORK_MAIN_NAME = new BBVarchar2Filter(this, "WORK_MAIN_NAME");
            WORK_MAIN_INN = new BBVarchar2Filter(this, "WORK_MAIN_INN");
            WORK_ADD_NAME = new BBVarchar2Filter(this, "WORK_ADD_NAME");
            WORK_ADD_INN = new BBVarchar2Filter(this, "WORK_ADD_INN");
            PROPERTY_COST = new BBDecimalFilter(this, "PROPERTY_COST");
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
            GARANTEES_IDS = new BBVarchar2Filter(this, "GARANTEES_IDS");
            MGR_ID = new BBDecimalFilter(this, "MGR_ID");
            MGR_FIO = new BBVarchar2Filter(this, "MGR_FIO");
            BRANCH = new BBVarchar2Filter(this, "BRANCH");
            BRANCH_NAME = new BBVarchar2Filter(this, "BRANCH_NAME");
            STATES = new BBVarchar2Filter(this, "STATES");
            SRV = new BBVarchar2Filter(this, "SRV");
            CHECKOUT_DAT = new BBDateFilter(this, "CHECKOUT_DAT");
            CHECKIN_DAT = new BBDateFilter(this, "CHECKIN_DAT");
            CHECKOUT_USER_ID = new BBDecimalFilter(this, "CHECKOUT_USER_ID");
            CHECKOUT_USER_FIO = new BBVarchar2Filter(this, "CHECKOUT_USER_FIO");
            CHECKOUT_USER_BRANCH = new BBVarchar2Filter(this, "CHECKOUT_USER_BRANCH");
            SRV_HIERARCHY = new BBVarchar2Filter(this, "SRV_HIERARCHY");
        }
        public BBDecimalFilter BID_ID;
        public BBVarchar2Filter SUBPRODUCT_ID;
        public BBVarchar2Filter SUBPRODUCT_NAME;
        public BBDateFilter CRT_DATE;
        public BBVarchar2Filter STATUS;
        public BBVarchar2Filter F;
        public BBVarchar2Filter I;
        public BBVarchar2Filter O;
        public BBVarchar2Filter FIO;
        public BBDateFilter BDATE;
        public BBVarchar2Filter INN;
        public BBVarchar2Filter WORK_MAIN_NAME;
        public BBVarchar2Filter WORK_MAIN_INN;
        public BBVarchar2Filter WORK_ADD_NAME;
        public BBVarchar2Filter WORK_ADD_INN;
        public BBDecimalFilter PROPERTY_COST;
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
        public BBVarchar2Filter GARANTEES_IDS;
        public BBDecimalFilter MGR_ID;
        public BBVarchar2Filter MGR_FIO;
        public BBVarchar2Filter BRANCH;
        public BBVarchar2Filter BRANCH_NAME;
        public BBVarchar2Filter STATES;
        public BBVarchar2Filter SRV;
        public BBDateFilter CHECKOUT_DAT;
        public BBDateFilter CHECKIN_DAT;
        public BBDecimalFilter CHECKOUT_USER_ID;
        public BBVarchar2Filter CHECKOUT_USER_FIO;
        public BBVarchar2Filter CHECKOUT_USER_BRANCH;
        public BBVarchar2Filter SRV_HIERARCHY;
    }

    public partial class VWcsSrvBidsArchive : BbTable<VWcsSrvBidsArchiveRecord, VWcsSrvBidsArchiveFilters>
    {
        public VWcsSrvBidsArchive() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsSrvBidsArchive(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsSrvBidsArchiveRecord> Select(VWcsSrvBidsArchiveRecord Item)
        {
            List<VWcsSrvBidsArchiveRecord> res = new List<VWcsSrvBidsArchiveRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsSrvBidsArchiveRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (DateTime?)null : Convert.ToDateTime(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
                        rdr.IsDBNull(8) ?  (String)null : Convert.ToString(rdr[8]), 
                        rdr.IsDBNull(9) ?  (String)null : Convert.ToString(rdr[9]), 
                        rdr.IsDBNull(10) ?  (DateTime?)null : Convert.ToDateTime(rdr[10]), 
                        rdr.IsDBNull(11) ?  (String)null : Convert.ToString(rdr[11]), 
                        rdr.IsDBNull(12) ?  (String)null : Convert.ToString(rdr[12]), 
                        rdr.IsDBNull(13) ?  (String)null : Convert.ToString(rdr[13]), 
                        rdr.IsDBNull(14) ?  (String)null : Convert.ToString(rdr[14]), 
                        rdr.IsDBNull(15) ?  (String)null : Convert.ToString(rdr[15]), 
                        rdr.IsDBNull(16) ?  (Decimal?)null : Convert.ToDecimal(rdr[16]), 
                        rdr.IsDBNull(17) ?  (Decimal?)null : Convert.ToDecimal(rdr[17]), 
                        rdr.IsDBNull(18) ?  (Decimal?)null : Convert.ToDecimal(rdr[18]), 
                        rdr.IsDBNull(19) ?  (String)null : Convert.ToString(rdr[19]), 
                        rdr.IsDBNull(20) ?  (String)null : Convert.ToString(rdr[20]), 
                        rdr.IsDBNull(21) ?  (Decimal?)null : Convert.ToDecimal(rdr[21]), 
                        rdr.IsDBNull(22) ?  (Decimal?)null : Convert.ToDecimal(rdr[22]), 
                        rdr.IsDBNull(23) ?  (Decimal?)null : Convert.ToDecimal(rdr[23]), 
                        rdr.IsDBNull(24) ?  (String)null : Convert.ToString(rdr[24]), 
                        rdr.IsDBNull(25) ?  (Decimal?)null : Convert.ToDecimal(rdr[25]), 
                        rdr.IsDBNull(26) ?  (String)null : Convert.ToString(rdr[26]), 
                        rdr.IsDBNull(27) ?  (String)null : Convert.ToString(rdr[27]), 
                        rdr.IsDBNull(28) ?  (Decimal?)null : Convert.ToDecimal(rdr[28]), 
                        rdr.IsDBNull(29) ?  (String)null : Convert.ToString(rdr[29]), 
                        rdr.IsDBNull(30) ?  (String)null : Convert.ToString(rdr[30]), 
                        rdr.IsDBNull(31) ?  (String)null : Convert.ToString(rdr[31]), 
                        rdr.IsDBNull(32) ?  (String)null : Convert.ToString(rdr[32]), 
                        rdr.IsDBNull(33) ?  (String)null : Convert.ToString(rdr[33]), 
                        rdr.IsDBNull(34) ?  (DateTime?)null : Convert.ToDateTime(rdr[34]), 
                        rdr.IsDBNull(35) ?  (DateTime?)null : Convert.ToDateTime(rdr[35]), 
                        rdr.IsDBNull(36) ?  (Decimal?)null : Convert.ToDecimal(rdr[36]), 
                        rdr.IsDBNull(37) ?  (String)null : Convert.ToString(rdr[37]), 
                        rdr.IsDBNull(38) ?  (String)null : Convert.ToString(rdr[38]), 
                        rdr.IsDBNull(39) ?  (String)null : Convert.ToString(rdr[39]))
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