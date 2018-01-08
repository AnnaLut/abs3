

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/DECISION.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table DECISION ***
begin 
  execute immediate '
  CREATE TABLE FINMON.DECISION 
   (	ID VARCHAR2(15), 
	KL_ID VARCHAR2(15), 
	KL_DATE DATE, 
	IN_DATE DATE, 
	IN_N NUMBER(3,0), 
	FILE_I_ID VARCHAR2(15), 
	TEXT VARCHAR2(4000), 
	RI_VID NUMBER(2,0), 
	RI_NUMB VARCHAR2(15), 
	RI_DATA DATE, 
	BRANCH_ID VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.DECISION IS '';
COMMENT ON COLUMN FINMON.DECISION.ID IS '';
COMMENT ON COLUMN FINMON.DECISION.KL_ID IS '';
COMMENT ON COLUMN FINMON.DECISION.KL_DATE IS '';
COMMENT ON COLUMN FINMON.DECISION.IN_DATE IS '';
COMMENT ON COLUMN FINMON.DECISION.IN_N IS '';
COMMENT ON COLUMN FINMON.DECISION.FILE_I_ID IS '';
COMMENT ON COLUMN FINMON.DECISION.TEXT IS '';
COMMENT ON COLUMN FINMON.DECISION.RI_VID IS '';
COMMENT ON COLUMN FINMON.DECISION.RI_NUMB IS '';
COMMENT ON COLUMN FINMON.DECISION.RI_DATA IS '';
COMMENT ON COLUMN FINMON.DECISION.BRANCH_ID IS '';




PROMPT *** Create  constraint NK_DEC_IN_DATE ***
begin   
 execute immediate '
  ALTER TABLE FINMON.DECISION MODIFY (IN_DATE CONSTRAINT NK_DEC_IN_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_DEC_IN_N ***
begin   
 execute immediate '
  ALTER TABLE FINMON.DECISION MODIFY (IN_N CONSTRAINT NK_DEC_IN_N NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_DEC_RI_VID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.DECISION MODIFY (RI_VID CONSTRAINT NK_DEC_RI_VID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_DEC_RI_NUM ***
begin   
 execute immediate '
  ALTER TABLE FINMON.DECISION MODIFY (RI_NUMB CONSTRAINT NK_DEC_RI_NUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_DEC_RI_DATA ***
begin   
 execute immediate '
  ALTER TABLE FINMON.DECISION MODIFY (RI_DATA CONSTRAINT NK_DEC_RI_DATA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_DECISION ***
begin   
 execute immediate '
  ALTER TABLE FINMON.DECISION ADD CONSTRAINT XPK_DECISION PRIMARY KEY (ID, BRANCH_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UQ_DECISION_RI_NUMB ***
begin   
 execute immediate '
  ALTER TABLE FINMON.DECISION ADD CONSTRAINT UQ_DECISION_RI_NUMB UNIQUE (RI_NUMB)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_DECISION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_DECISION ON FINMON.DECISION (ID, BRANCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UQ_DECISION_RI_NUMB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.UQ_DECISION_RI_NUMB ON FINMON.DECISION (RI_NUMB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DECISION ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on DECISION        to BARS;
grant SELECT                                                                 on DECISION        to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/DECISION.sql =========*** End *** ==
PROMPT ===================================================================================== 
