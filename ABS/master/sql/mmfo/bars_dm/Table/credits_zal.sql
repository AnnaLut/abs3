

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/CREDITS_ZAL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table CREDITS_ZAL ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.CREDITS_ZAL 
   (	PER_ID NUMBER, 
	KF VARCHAR2(6), 
	ND NUMBER, 
	VIDD_NAME VARCHAR2(250), 
	RNK NUMBER, 
	REL_TYPE VARCHAR2(30), 
	ZAL_SUM NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.CREDITS_ZAL IS '';
COMMENT ON COLUMN BARS_DM.CREDITS_ZAL.PER_ID IS '';
COMMENT ON COLUMN BARS_DM.CREDITS_ZAL.KF IS '';
COMMENT ON COLUMN BARS_DM.CREDITS_ZAL.ND IS '';
COMMENT ON COLUMN BARS_DM.CREDITS_ZAL.VIDD_NAME IS '';
COMMENT ON COLUMN BARS_DM.CREDITS_ZAL.RNK IS '';
COMMENT ON COLUMN BARS_DM.CREDITS_ZAL.REL_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CREDITS_ZAL.ZAL_SUM IS '';




PROMPT *** Create  index I_CRED_ZAL_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_CRED_ZAL_PERID ON BARS_DM.CREDITS_ZAL (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CREDITS_ZAL ***
grant SELECT                                                                 on CREDITS_ZAL     to BARS;
grant SELECT                                                                 on CREDITS_ZAL     to BARSUPL;
grant SELECT                                                                 on CREDITS_ZAL     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/CREDITS_ZAL.sql =========*** End **
PROMPT ===================================================================================== 
