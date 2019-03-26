/*
    AUTOGENERATED! Do not modify this code. 
*/

using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Collections.Specialized;
using System.Data;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using ibank.core;

namespace ibank.objlayer
{
    public sealed class VDpztArcDocumentsRecord : BbRecord
    {
        public VDpztArcDocumentsRecord(BbDataSource Parent) : base (Parent)
        {
            Fields.Add( new BbField("REC_ID", OracleDbType.Decimal, false, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Ід. запису"));
            Fields.Add( new BbField("REC_DATE", OracleDbType.Date, false, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Дата запису"));
            Fields.Add( new BbField("REC_ACTION", OracleDbType.Varchar2, false, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Тип дії"));
            Fields.Add( new BbField("REC_USERNAME", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Ім'я користувача"));
            Fields.Add( new BbField("REF", OracleDbType.Decimal, false, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Ід. документу"));
            Fields.Add( new BbField("DOCID", OracleDbType.Decimal, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Ід. проводки"));
            Fields.Add( new BbField("IDPDR", OracleDbType.Decimal, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Код підрозділу ОДБ"));
            Fields.Add( new BbField("IDFINTR", OracleDbType.Decimal, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Ід. фін. транзакції ОДБ"));
            Fields.Add( new BbField("NUMDOC", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Номер документу"));
            Fields.Add( new BbField("DTDOC", OracleDbType.Date, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Дата документу"));
            Fields.Add( new BbField("DTBNK", OracleDbType.Date, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Дата прийому"));
            Fields.Add( new BbField("DTVAL", OracleDbType.Date, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Дата вал."));
            Fields.Add( new BbField("DTODB", OracleDbType.Date, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Дата проводки"));
            Fields.Add( new BbField("DMFO", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "МФО А"));
            Fields.Add( new BbField("DACNUM", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Рахунок А"));
            Fields.Add( new BbField("KMFO", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "МФО Б"));
            Fields.Add( new BbField("KACNUM", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Рахунок Б"));
            Fields.Add( new BbField("RDBT", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Рахунок А (р)"));
            Fields.Add( new BbField("KVRDBT", OracleDbType.Char, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Код валюти А (р)"));
            Fields.Add( new BbField("RKRD", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Рахунок Б (р)"));
            Fields.Add( new BbField("KVRKRD", OracleDbType.Char, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Код валюти Б (р)"));
            Fields.Add( new BbField("KV", OracleDbType.Char, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Код валюти"));
            Fields.Add( new BbField("VSUM", OracleDbType.Decimal, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Сума номіналу"));
            Fields.Add( new BbField("NSUM", OracleDbType.Decimal, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Сума еквіваленту"));
            Fields.Add( new BbField("SUMNDS", OracleDbType.Decimal, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Сума НДС"));
            Fields.Add( new BbField("SIMK", OracleDbType.Decimal, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Сімвол каси"));
            Fields.Add( new BbField("CNTRY", OracleDbType.Decimal, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Код країни"));
            Fields.Add( new BbField("DNM", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Найменування клієнту А"));
            Fields.Add( new BbField("DTIN", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Код ОКПО клієнту А"));
            Fields.Add( new BbField("KNM", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Найменування клієнту Б"));
            Fields.Add( new BbField("KTIN", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Код ОКПО клієнту Б"));
            Fields.Add( new BbField("SGNDOC", OracleDbType.Char, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Ознака документу"));
            Fields.Add( new BbField("SGNINF", OracleDbType.Char, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Ознака інф. окументу"));
            Fields.Add( new BbField("SOP", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Призначення платежу"));
            Fields.Add( new BbField("TYPPLT", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Тип платежа"));
            Fields.Add( new BbField("KDOC", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Код документу"));
            Fields.Add( new BbField("AUXREK", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Додаткові реквізити"));
            Fields.Add( new BbField("FAM", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Фамілія"));
            Fields.Add( new BbField("IM", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "І'мя"));
            Fields.Add( new BbField("OTCH", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "По-батькові"));
            Fields.Add( new BbField("PSPSRS", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Серія паспорту"));
            Fields.Add( new BbField("PSPNUM", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Номер паспорту"));
            Fields.Add( new BbField("PSPDT", OracleDbType.Date, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Дата видачі паспорту"));
            Fields.Add( new BbField("PSPW", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Паспорт видан"));
            Fields.Add( new BbField("KPCKG", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Код пачки"));
            Fields.Add( new BbField("IDKEY_ECP", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Ід. ключа ЕЦП"));
            Fields.Add( new BbField("UNUMDOC", OracleDbType.Char, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Унік. номер документу"));
            Fields.Add( new BbField("PSPTYP", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Тип документу"));
            Fields.Add( new BbField("ADR", OracleDbType.Varchar2, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Адреса"));
            Fields.Add( new BbField("DTBIRTH", OracleDbType.Date, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Дата народження"));
            Fields.Add( new BbField("PRVDTODB", OracleDbType.Date, true, false, false, false, false, "V_DPZT_ARC_DOCUMENTS", ObjectTypes.View, "Интерфейс ОДБ. Архив документов", "Дата проводки в ОДБ"));
        }
        public VDpztArcDocumentsRecord(BbDataSource Parent, OracleDecimal RowScn, OracleDecimal REC_ID, OracleDate REC_DATE, OracleString REC_ACTION, OracleString REC_USERNAME, OracleDecimal REF, OracleDecimal DOCID, OracleDecimal IDPDR, OracleDecimal IDFINTR, OracleString NUMDOC, OracleDate DTDOC, OracleDate DTBNK, OracleDate DTVAL, OracleDate DTODB, OracleString DMFO, OracleString DACNUM, OracleString KMFO, OracleString KACNUM, OracleString RDBT, OracleString KVRDBT, OracleString RKRD, OracleString KVRKRD, OracleString KV, OracleDecimal VSUM, OracleDecimal NSUM, OracleDecimal SUMNDS, OracleDecimal SIMK, OracleDecimal CNTRY, OracleString DNM, OracleString DTIN, OracleString KNM, OracleString KTIN, OracleString SGNDOC, OracleString SGNINF, OracleString SOP, OracleString TYPPLT, OracleString KDOC, OracleString AUXREK, OracleString FAM, OracleString IM, OracleString OTCH, OracleString PSPSRS, OracleString PSPNUM, OracleDate PSPDT, OracleString PSPW, OracleString KPCKG, OracleString IDKEY_ECP, OracleString UNUMDOC, OracleString PSPTYP, OracleString ADR, OracleDate DTBIRTH, OracleDate PRVDTODB)
            : this(Parent)
        {
            this.REC_ID = REC_ID;
            this.REC_DATE = REC_DATE;
            this.REC_ACTION = REC_ACTION;
            this.REC_USERNAME = REC_USERNAME;
            this.REF = REF;
            this.DOCID = DOCID;
            this.IDPDR = IDPDR;
            this.IDFINTR = IDFINTR;
            this.NUMDOC = NUMDOC;
            this.DTDOC = DTDOC;
            this.DTBNK = DTBNK;
            this.DTVAL = DTVAL;
            this.DTODB = DTODB;
            this.DMFO = DMFO;
            this.DACNUM = DACNUM;
            this.KMFO = KMFO;
            this.KACNUM = KACNUM;
            this.RDBT = RDBT;
            this.KVRDBT = KVRDBT;
            this.RKRD = RKRD;
            this.KVRKRD = KVRKRD;
            this.KV = KV;
            this.VSUM = VSUM;
            this.NSUM = NSUM;
            this.SUMNDS = SUMNDS;
            this.SIMK = SIMK;
            this.CNTRY = CNTRY;
            this.DNM = DNM;
            this.DTIN = DTIN;
            this.KNM = KNM;
            this.KTIN = KTIN;
            this.SGNDOC = SGNDOC;
            this.SGNINF = SGNINF;
            this.SOP = SOP;
            this.TYPPLT = TYPPLT;
            this.KDOC = KDOC;
            this.AUXREK = AUXREK;
            this.FAM = FAM;
            this.IM = IM;
            this.OTCH = OTCH;
            this.PSPSRS = PSPSRS;
            this.PSPNUM = PSPNUM;
            this.PSPDT = PSPDT;
            this.PSPW = PSPW;
            this.KPCKG = KPCKG;
            this.IDKEY_ECP = IDKEY_ECP;
            this.UNUMDOC = UNUMDOC;
            this.PSPTYP = PSPTYP;
            this.ADR = ADR;
            this.DTBIRTH = DTBIRTH;
            this.PRVDTODB = PRVDTODB;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        public OracleDecimal REC_ID { get { return (OracleDecimal)FindField("REC_ID").Value; } set {SetField("REC_ID", value);} }
        public OracleDate REC_DATE { get { return (OracleDate)FindField("REC_DATE").Value; } set {SetField("REC_DATE", value);} }
        public OracleString REC_ACTION { get { return (OracleString)FindField("REC_ACTION").Value; } set {SetField("REC_ACTION", value);} }
        public OracleString REC_USERNAME { get { return (OracleString)FindField("REC_USERNAME").Value; } set {SetField("REC_USERNAME", value);} }
        public OracleDecimal REF { get { return (OracleDecimal)FindField("REF").Value; } set {SetField("REF", value);} }
        public OracleDecimal DOCID { get { return (OracleDecimal)FindField("DOCID").Value; } set {SetField("DOCID", value);} }
        public OracleDecimal IDPDR { get { return (OracleDecimal)FindField("IDPDR").Value; } set {SetField("IDPDR", value);} }
        public OracleDecimal IDFINTR { get { return (OracleDecimal)FindField("IDFINTR").Value; } set {SetField("IDFINTR", value);} }
        public OracleString NUMDOC { get { return (OracleString)FindField("NUMDOC").Value; } set {SetField("NUMDOC", value);} }
        public OracleDate DTDOC { get { return (OracleDate)FindField("DTDOC").Value; } set {SetField("DTDOC", value);} }
        public OracleDate DTBNK { get { return (OracleDate)FindField("DTBNK").Value; } set {SetField("DTBNK", value);} }
        public OracleDate DTVAL { get { return (OracleDate)FindField("DTVAL").Value; } set {SetField("DTVAL", value);} }
        public OracleDate DTODB { get { return (OracleDate)FindField("DTODB").Value; } set {SetField("DTODB", value);} }
        public OracleString DMFO { get { return (OracleString)FindField("DMFO").Value; } set {SetField("DMFO", value);} }
        public OracleString DACNUM { get { return (OracleString)FindField("DACNUM").Value; } set {SetField("DACNUM", value);} }
        public OracleString KMFO { get { return (OracleString)FindField("KMFO").Value; } set {SetField("KMFO", value);} }
        public OracleString KACNUM { get { return (OracleString)FindField("KACNUM").Value; } set {SetField("KACNUM", value);} }
        public OracleString RDBT { get { return (OracleString)FindField("RDBT").Value; } set {SetField("RDBT", value);} }
        public OracleString KVRDBT { get { return (OracleString)FindField("KVRDBT").Value; } set {SetField("KVRDBT", value);} }
        public OracleString RKRD { get { return (OracleString)FindField("RKRD").Value; } set {SetField("RKRD", value);} }
        public OracleString KVRKRD { get { return (OracleString)FindField("KVRKRD").Value; } set {SetField("KVRKRD", value);} }
        public OracleString KV { get { return (OracleString)FindField("KV").Value; } set {SetField("KV", value);} }
        public OracleDecimal VSUM { get { return (OracleDecimal)FindField("VSUM").Value; } set {SetField("VSUM", value);} }
        public OracleDecimal NSUM { get { return (OracleDecimal)FindField("NSUM").Value; } set {SetField("NSUM", value);} }
        public OracleDecimal SUMNDS { get { return (OracleDecimal)FindField("SUMNDS").Value; } set {SetField("SUMNDS", value);} }
        public OracleDecimal SIMK { get { return (OracleDecimal)FindField("SIMK").Value; } set {SetField("SIMK", value);} }
        public OracleDecimal CNTRY { get { return (OracleDecimal)FindField("CNTRY").Value; } set {SetField("CNTRY", value);} }
        public OracleString DNM { get { return (OracleString)FindField("DNM").Value; } set {SetField("DNM", value);} }
        public OracleString DTIN { get { return (OracleString)FindField("DTIN").Value; } set {SetField("DTIN", value);} }
        public OracleString KNM { get { return (OracleString)FindField("KNM").Value; } set {SetField("KNM", value);} }
        public OracleString KTIN { get { return (OracleString)FindField("KTIN").Value; } set {SetField("KTIN", value);} }
        public OracleString SGNDOC { get { return (OracleString)FindField("SGNDOC").Value; } set {SetField("SGNDOC", value);} }
        public OracleString SGNINF { get { return (OracleString)FindField("SGNINF").Value; } set {SetField("SGNINF", value);} }
        public OracleString SOP { get { return (OracleString)FindField("SOP").Value; } set {SetField("SOP", value);} }
        public OracleString TYPPLT { get { return (OracleString)FindField("TYPPLT").Value; } set {SetField("TYPPLT", value);} }
        public OracleString KDOC { get { return (OracleString)FindField("KDOC").Value; } set {SetField("KDOC", value);} }
        public OracleString AUXREK { get { return (OracleString)FindField("AUXREK").Value; } set {SetField("AUXREK", value);} }
        public OracleString FAM { get { return (OracleString)FindField("FAM").Value; } set {SetField("FAM", value);} }
        public OracleString IM { get { return (OracleString)FindField("IM").Value; } set {SetField("IM", value);} }
        public OracleString OTCH { get { return (OracleString)FindField("OTCH").Value; } set {SetField("OTCH", value);} }
        public OracleString PSPSRS { get { return (OracleString)FindField("PSPSRS").Value; } set {SetField("PSPSRS", value);} }
        public OracleString PSPNUM { get { return (OracleString)FindField("PSPNUM").Value; } set {SetField("PSPNUM", value);} }
        public OracleDate PSPDT { get { return (OracleDate)FindField("PSPDT").Value; } set {SetField("PSPDT", value);} }
        public OracleString PSPW { get { return (OracleString)FindField("PSPW").Value; } set {SetField("PSPW", value);} }
        public OracleString KPCKG { get { return (OracleString)FindField("KPCKG").Value; } set {SetField("KPCKG", value);} }
        public OracleString IDKEY_ECP { get { return (OracleString)FindField("IDKEY_ECP").Value; } set {SetField("IDKEY_ECP", value);} }
        public OracleString UNUMDOC { get { return (OracleString)FindField("UNUMDOC").Value; } set {SetField("UNUMDOC", value);} }
        public OracleString PSPTYP { get { return (OracleString)FindField("PSPTYP").Value; } set {SetField("PSPTYP", value);} }
        public OracleString ADR { get { return (OracleString)FindField("ADR").Value; } set {SetField("ADR", value);} }
        public OracleDate DTBIRTH { get { return (OracleDate)FindField("DTBIRTH").Value; } set {SetField("DTBIRTH", value);} }
        public OracleDate PRVDTODB { get { return (OracleDate)FindField("PRVDTODB").Value; } set {SetField("PRVDTODB", value);} }
    }

    public sealed class VDpztArcDocumentsFilters : BbFilters
    {
        public VDpztArcDocumentsFilters(BbDataSource Parent) : base (Parent)
        {
            REC_ID = new BBDecimalFilter(this, "REC_ID");
            REC_DATE = new BBDateFilter(this, "REC_DATE");
            REC_ACTION = new BBVarchar2Filter(this, "REC_ACTION");
            REC_USERNAME = new BBVarchar2Filter(this, "REC_USERNAME");
            REF = new BBDecimalFilter(this, "REF");
            DOCID = new BBDecimalFilter(this, "DOCID");
            IDPDR = new BBDecimalFilter(this, "IDPDR");
            IDFINTR = new BBDecimalFilter(this, "IDFINTR");
            NUMDOC = new BBVarchar2Filter(this, "NUMDOC");
            DTDOC = new BBDateFilter(this, "DTDOC");
            DTBNK = new BBDateFilter(this, "DTBNK");
            DTVAL = new BBDateFilter(this, "DTVAL");
            DTODB = new BBDateFilter(this, "DTODB");
            DMFO = new BBVarchar2Filter(this, "DMFO");
            DACNUM = new BBVarchar2Filter(this, "DACNUM");
            KMFO = new BBVarchar2Filter(this, "KMFO");
            KACNUM = new BBVarchar2Filter(this, "KACNUM");
            RDBT = new BBVarchar2Filter(this, "RDBT");
            KVRDBT = new BBCharFilter(this, "KVRDBT");
            RKRD = new BBVarchar2Filter(this, "RKRD");
            KVRKRD = new BBCharFilter(this, "KVRKRD");
            KV = new BBCharFilter(this, "KV");
            VSUM = new BBDecimalFilter(this, "VSUM");
            NSUM = new BBDecimalFilter(this, "NSUM");
            SUMNDS = new BBDecimalFilter(this, "SUMNDS");
            SIMK = new BBDecimalFilter(this, "SIMK");
            CNTRY = new BBDecimalFilter(this, "CNTRY");
            DNM = new BBVarchar2Filter(this, "DNM");
            DTIN = new BBVarchar2Filter(this, "DTIN");
            KNM = new BBVarchar2Filter(this, "KNM");
            KTIN = new BBVarchar2Filter(this, "KTIN");
            SGNDOC = new BBCharFilter(this, "SGNDOC");
            SGNINF = new BBCharFilter(this, "SGNINF");
            SOP = new BBVarchar2Filter(this, "SOP");
            TYPPLT = new BBVarchar2Filter(this, "TYPPLT");
            KDOC = new BBVarchar2Filter(this, "KDOC");
            AUXREK = new BBVarchar2Filter(this, "AUXREK");
            FAM = new BBVarchar2Filter(this, "FAM");
            IM = new BBVarchar2Filter(this, "IM");
            OTCH = new BBVarchar2Filter(this, "OTCH");
            PSPSRS = new BBVarchar2Filter(this, "PSPSRS");
            PSPNUM = new BBVarchar2Filter(this, "PSPNUM");
            PSPDT = new BBDateFilter(this, "PSPDT");
            PSPW = new BBVarchar2Filter(this, "PSPW");
            KPCKG = new BBVarchar2Filter(this, "KPCKG");
            IDKEY_ECP = new BBVarchar2Filter(this, "IDKEY_ECP");
            UNUMDOC = new BBCharFilter(this, "UNUMDOC");
            PSPTYP = new BBVarchar2Filter(this, "PSPTYP");
            ADR = new BBVarchar2Filter(this, "ADR");
            DTBIRTH = new BBDateFilter(this, "DTBIRTH");
            PRVDTODB = new BBDateFilter(this, "PRVDTODB");
        }
        public BBDecimalFilter REC_ID;
        public BBDateFilter REC_DATE;
        public BBVarchar2Filter REC_ACTION;
        public BBVarchar2Filter REC_USERNAME;
        public BBDecimalFilter REF;
        public BBDecimalFilter DOCID;
        public BBDecimalFilter IDPDR;
        public BBDecimalFilter IDFINTR;
        public BBVarchar2Filter NUMDOC;
        public BBDateFilter DTDOC;
        public BBDateFilter DTBNK;
        public BBDateFilter DTVAL;
        public BBDateFilter DTODB;
        public BBVarchar2Filter DMFO;
        public BBVarchar2Filter DACNUM;
        public BBVarchar2Filter KMFO;
        public BBVarchar2Filter KACNUM;
        public BBVarchar2Filter RDBT;
        public BBCharFilter KVRDBT;
        public BBVarchar2Filter RKRD;
        public BBCharFilter KVRKRD;
        public BBCharFilter KV;
        public BBDecimalFilter VSUM;
        public BBDecimalFilter NSUM;
        public BBDecimalFilter SUMNDS;
        public BBDecimalFilter SIMK;
        public BBDecimalFilter CNTRY;
        public BBVarchar2Filter DNM;
        public BBVarchar2Filter DTIN;
        public BBVarchar2Filter KNM;
        public BBVarchar2Filter KTIN;
        public BBCharFilter SGNDOC;
        public BBCharFilter SGNINF;
        public BBVarchar2Filter SOP;
        public BBVarchar2Filter TYPPLT;
        public BBVarchar2Filter KDOC;
        public BBVarchar2Filter AUXREK;
        public BBVarchar2Filter FAM;
        public BBVarchar2Filter IM;
        public BBVarchar2Filter OTCH;
        public BBVarchar2Filter PSPSRS;
        public BBVarchar2Filter PSPNUM;
        public BBDateFilter PSPDT;
        public BBVarchar2Filter PSPW;
        public BBVarchar2Filter KPCKG;
        public BBVarchar2Filter IDKEY_ECP;
        public BBCharFilter UNUMDOC;
        public BBVarchar2Filter PSPTYP;
        public BBVarchar2Filter ADR;
        public BBDateFilter DTBIRTH;
        public BBDateFilter PRVDTODB;
    }

    public sealed class VDpztArcDocuments : BbTable<VDpztArcDocumentsRecord, VDpztArcDocumentsFilters>
    {
        public VDpztArcDocuments(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VDpztArcDocumentsRecord> Select(VDpztArcDocumentsRecord Item)
        {
            List<VDpztArcDocumentsRecord> res = new List<VDpztArcDocumentsRecord>();
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                OracleDataReader rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VDpztArcDocumentsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.GetOracleDecimal(1), 
                        rdr.GetOracleDate(2), 
                        rdr.GetOracleString(3), 
                        rdr.GetOracleString(4), 
                        rdr.GetOracleDecimal(5), 
                        rdr.GetOracleDecimal(6), 
                        rdr.GetOracleDecimal(7), 
                        rdr.GetOracleDecimal(8), 
                        rdr.GetOracleString(9), 
                        rdr.GetOracleDate(10), 
                        rdr.GetOracleDate(11), 
                        rdr.GetOracleDate(12), 
                        rdr.GetOracleDate(13), 
                        rdr.GetOracleString(14), 
                        rdr.GetOracleString(15), 
                        rdr.GetOracleString(16), 
                        rdr.GetOracleString(17), 
                        rdr.GetOracleString(18), 
                        rdr.GetOracleString(19), 
                        rdr.GetOracleString(20), 
                        rdr.GetOracleString(21), 
                        rdr.GetOracleString(22), 
                        rdr.GetOracleDecimal(23), 
                        rdr.GetOracleDecimal(24), 
                        rdr.GetOracleDecimal(25), 
                        rdr.GetOracleDecimal(26), 
                        rdr.GetOracleDecimal(27), 
                        rdr.GetOracleString(28), 
                        rdr.GetOracleString(29), 
                        rdr.GetOracleString(30), 
                        rdr.GetOracleString(31), 
                        rdr.GetOracleString(32), 
                        rdr.GetOracleString(33), 
                        rdr.GetOracleString(34), 
                        rdr.GetOracleString(35), 
                        rdr.GetOracleString(36), 
                        rdr.GetOracleString(37), 
                        rdr.GetOracleString(38), 
                        rdr.GetOracleString(39), 
                        rdr.GetOracleString(40), 
                        rdr.GetOracleString(41), 
                        rdr.GetOracleString(42), 
                        rdr.GetOracleDate(43), 
                        rdr.GetOracleString(44), 
                        rdr.GetOracleString(45), 
                        rdr.GetOracleString(46), 
                        rdr.GetOracleString(47), 
                        rdr.GetOracleString(48), 
                        rdr.GetOracleString(49), 
                        rdr.GetOracleDate(50), 
                        rdr.GetOracleDate(51))
                    );
                }
                rdr.Close();
                rdr.Dispose();
            }
            finally
            {
                if (ConnectionResult.New == connectionResult)
                    Connection.CloseConnection();
            }
            return res;
        }
    }
}