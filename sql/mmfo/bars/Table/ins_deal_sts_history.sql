

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_DEAL_STS_HISTORY.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_DEAL_STS_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_DEAL_STS_HISTORY'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INS_DEAL_STS_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_DEAL_STS_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_DEAL_STS_HISTORY 
   (	ID NUMBER, 
	DEAL_ID NUMBER, 
	STATUS_ID VARCHAR2(100), 
	SET_DATE DATE, 
	COMM VARCHAR2(300), 
	STAFF_ID NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_DEAL_STS_HISTORY ***
 exec bpa.alter_policies('INS_DEAL_STS_HISTORY');


COMMENT ON TABLE BARS.INS_DEAL_STS_HISTORY IS 'Історія статусів СД';
COMMENT ON COLUMN BARS.INS_DEAL_STS_HISTORY.ID IS 'Сурогатний ключ';
COMMENT ON COLUMN BARS.INS_DEAL_STS_HISTORY.DEAL_ID IS 'Ід. СД';
COMMENT ON COLUMN BARS.INS_DEAL_STS_HISTORY.STATUS_ID IS 'Ід.статусу';
COMMENT ON COLUMN BARS.INS_DEAL_STS_HISTORY.SET_DATE IS 'Дата встановлення';
COMMENT ON COLUMN BARS.INS_DEAL_STS_HISTORY.COMM IS 'Кометнтар встановлення';
COMMENT ON COLUMN BARS.INS_DEAL_STS_HISTORY.STAFF_ID IS 'Ід. користувача, що встановив';
COMMENT ON COLUMN BARS.INS_DEAL_STS_HISTORY.KF IS '';




PROMPT *** Create  constraint CC_INSDLSSTSHIST_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_STS_HISTORY MODIFY (ID CONSTRAINT CC_INSDLSSTSHIST_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLSSTSHIST_DID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_STS_HISTORY MODIFY (DEAL_ID CONSTRAINT CC_INSDLSSTSHIST_DID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLSSTSHIST_STSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_STS_HISTORY MODIFY (STATUS_ID CONSTRAINT CC_INSDLSSTSHIST_STSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLSSTSHIST_SD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_STS_HISTORY MODIFY (SET_DATE CONSTRAINT CC_INSDLSSTSHIST_SD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLSSTSHIST_STAFFID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_STS_HISTORY MODIFY (STAFF_ID CONSTRAINT CC_INSDLSSTSHIST_STAFFID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INSDLSSTSHIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_STS_HISTORY ADD CONSTRAINT PK_INSDLSSTSHIST PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_INSDESTSHIST_DID_STSID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_INSDESTSHIST_DID_STSID ON BARS.INS_DEAL_STS_HISTORY (DEAL_ID, STATUS_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSDLSSTSHIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSDLSSTSHIST ON BARS.INS_DEAL_STS_HISTORY (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_DEAL_STS_HISTORY ***
grant SELECT                                                                 on INS_DEAL_STS_HISTORY to BARSREADER_ROLE;
grant SELECT                                                                 on INS_DEAL_STS_HISTORY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_DEAL_STS_HISTORY.sql =========*** 
PROMPT ===================================================================================== 
