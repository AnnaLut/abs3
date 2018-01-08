

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/CUSTUR_REL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table CUSTUR_REL ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.CUSTUR_REL 
   (	PER_ID NUMBER, 
	KF VARCHAR2(6), 
	RNK NUMBER(15,0), 
	REL_ID NUMBER(22,0), 
	REL_RNK NUMBER, 
	REL_INTEXT NUMBER(1,0), 
	NAME VARCHAR2(70), 
	OKPO VARCHAR2(14), 
	VAGA1 NUMBER(8,4), 
	CUSTTYPE NUMBER, 
	TEL VARCHAR2(100), 
	EMAIL VARCHAR2(254), 
	POSITION VARCHAR2(100), 
	SED VARCHAR2(4), 
	BDATE DATE, 
	EDATE DATE, 
	SIGN_PRIVS NUMBER(1,0), 
	CUSTTYPE_OR NUMBER, 
	CHANGE_TYPE VARCHAR2(1), 
	CL_TYPE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.CUSTUR_REL IS '���'����� �����';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.CL_TYPE IS 'Тип клиента, 4 - ФОП';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.CHANGE_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.PER_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.KF IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.RNK IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.REL_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.REL_RNK IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.REL_INTEXT IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.NAME IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.OKPO IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.VAGA1 IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.CUSTTYPE IS 'Тип связанного лица(юр/физ)';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.TEL IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.EMAIL IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.POSITION IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.SED IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.BDATE IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.EDATE IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.SIGN_PRIVS IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR_REL.CUSTTYPE_OR IS '';




PROMPT *** Create  index I_CUSTUR_REL_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_CUSTUR_REL_PERID ON BARS_DM.CUSTUR_REL (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTUR_REL ***
grant SELECT                                                                 on CUSTUR_REL      to BARS;
grant SELECT                                                                 on CUSTUR_REL      to BARSREADER_ROLE;
grant SELECT                                                                 on CUSTUR_REL      to BARSUPL;
grant SELECT                                                                 on CUSTUR_REL      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/CUSTUR_REL.sql =========*** End ***
PROMPT ===================================================================================== 
