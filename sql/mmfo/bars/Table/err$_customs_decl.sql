

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CUSTOMS_DECL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CUSTOMS_DECL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CUSTOMS_DECL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CUSTOMS_DECL 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FN VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	N VARCHAR2(4000), 
	LEN VARCHAR2(4000), 
	CDAT VARCHAR2(4000), 
	ISNULL VARCHAR2(4000), 
	NDAT VARCHAR2(4000), 
	MDAT VARCHAR2(4000), 
	CTYPE VARCHAR2(4000), 
	CNUM_CST VARCHAR2(4000), 
	CNUM_YEAR VARCHAR2(4000), 
	CNUM_NUM VARCHAR2(4000), 
	MVM_FEAT VARCHAR2(4000), 
	S_OKPO VARCHAR2(4000), 
	S_NAME VARCHAR2(4000), 
	S_ADRES VARCHAR2(4000), 
	S_TYPE VARCHAR2(4000), 
	S_TAXID VARCHAR2(4000), 
	R_OKPO VARCHAR2(4000), 
	R_NAME VARCHAR2(4000), 
	R_ADRES VARCHAR2(4000), 
	R_TYPE VARCHAR2(4000), 
	R_TAXID VARCHAR2(4000), 
	F_OKPO VARCHAR2(4000), 
	F_NAME VARCHAR2(4000), 
	F_ADRES VARCHAR2(4000), 
	F_TYPE VARCHAR2(4000), 
	F_TAXID VARCHAR2(4000), 
	F_COUNTRY VARCHAR2(4000), 
	UAH_NLS VARCHAR2(4000), 
	UAH_MFO VARCHAR2(4000), 
	CCY_NLS VARCHAR2(4000), 
	CCY_MFO VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	KURS VARCHAR2(4000), 
	S VARCHAR2(4000), 
	ALLOW_DAT VARCHAR2(4000), 
	CMODE_CODE VARCHAR2(4000), 
	RESERV VARCHAR2(4000), 
	DOC VARCHAR2(4000), 
	SDATE VARCHAR2(4000), 
	FDATE VARCHAR2(4000), 
	SIGN_KEY VARCHAR2(4000), 
	SIGN RAW(2000), 
	CHARACTER VARCHAR2(4000), 
	RESERVE2 VARCHAR2(4000), 
	FL_EIK VARCHAR2(4000), 
	IDT VARCHAR2(4000), 
	DATJ VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	CIM_ID VARCHAR2(4000), 
	CIM_BRANCH VARCHAR2(4000), 
	CIM_DATE VARCHAR2(4000), 
	CIM_BOUNDSUM VARCHAR2(4000), 
	CIM_ORIGINAL VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CUSTOMS_DECL ***
 exec bpa.alter_policies('ERR$_CUSTOMS_DECL');


COMMENT ON TABLE BARS.ERR$_CUSTOMS_DECL IS 'DML Error Logging table for "CUSTOMS_DECL"';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.CIM_ORIGINAL IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.FN IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.N IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.LEN IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.CDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.ISNULL IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.NDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.MDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.CTYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.CNUM_CST IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.CNUM_YEAR IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.CNUM_NUM IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.MVM_FEAT IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.S_OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.S_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.S_ADRES IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.S_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.S_TAXID IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.R_OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.R_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.R_ADRES IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.R_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.R_TAXID IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.F_OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.F_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.F_ADRES IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.F_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.F_TAXID IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.F_COUNTRY IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.UAH_NLS IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.UAH_MFO IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.CCY_NLS IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.CCY_MFO IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.KV IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.KURS IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.S IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.ALLOW_DAT IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.CMODE_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.RESERV IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.DOC IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.SDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.FDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.SIGN_KEY IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.SIGN IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.CHARACTER IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.RESERVE2 IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.FL_EIK IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.IDT IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.DATJ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.KF IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.CIM_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.CIM_BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.CIM_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMS_DECL.CIM_BOUNDSUM IS '';



PROMPT *** Create  grants  ERR$_CUSTOMS_DECL ***
grant SELECT                                                                 on ERR$_CUSTOMS_DECL to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CUSTOMS_DECL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CUSTOMS_DECL.sql =========*** End
PROMPT ===================================================================================== 
