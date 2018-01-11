

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_ACCIDENTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_ACCIDENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_ACCIDENTS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INS_ACCIDENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_ACCIDENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_ACCIDENTS 
   (	ID NUMBER, 
	DEAL_ID NUMBER, 
	BRANCH VARCHAR2(30), 
	STAFF_ID NUMBER, 
	CRT_DATE DATE, 
	ACDT_DATE DATE, 
	COMM VARCHAR2(1024), 
	REFUND_SUM NUMBER, 
	REFUND_DATE DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_ACCIDENTS ***
 exec bpa.alter_policies('INS_ACCIDENTS');


COMMENT ON TABLE BARS.INS_ACCIDENTS IS 'Дод. угоди до страхових договорів';
COMMENT ON COLUMN BARS.INS_ACCIDENTS.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_ACCIDENTS.DEAL_ID IS 'Ід. СД';
COMMENT ON COLUMN BARS.INS_ACCIDENTS.BRANCH IS 'Код відділення';
COMMENT ON COLUMN BARS.INS_ACCIDENTS.STAFF_ID IS 'Код менеджера';
COMMENT ON COLUMN BARS.INS_ACCIDENTS.CRT_DATE IS 'Дата створення';
COMMENT ON COLUMN BARS.INS_ACCIDENTS.ACDT_DATE IS 'Дата випадку';
COMMENT ON COLUMN BARS.INS_ACCIDENTS.COMM IS 'Коментар';
COMMENT ON COLUMN BARS.INS_ACCIDENTS.REFUND_SUM IS 'Сума відшкодування';
COMMENT ON COLUMN BARS.INS_ACCIDENTS.REFUND_DATE IS 'Дата відшкодування';
COMMENT ON COLUMN BARS.INS_ACCIDENTS.KF IS '';




PROMPT *** Create  constraint SYS_C0033447 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ACCIDENTS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSACCIDENTS_DID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ACCIDENTS MODIFY (DEAL_ID CONSTRAINT CC_INSACCIDENTS_DID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSACCIDENTS_BRCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ACCIDENTS MODIFY (BRANCH CONSTRAINT CC_INSACCIDENTS_BRCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSACCIDENTS_SID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ACCIDENTS MODIFY (STAFF_ID CONSTRAINT CC_INSACCIDENTS_SID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSACCIDENTS_CRTD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ACCIDENTS MODIFY (CRT_DATE CONSTRAINT CC_INSACCIDENTS_CRTD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSACCIDENTS_ACDTD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ACCIDENTS MODIFY (ACDT_DATE CONSTRAINT CC_INSACCIDENTS_ACDTD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSACCIDENTS_COMM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ACCIDENTS MODIFY (COMM CONSTRAINT CC_INSACCIDENTS_COMM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INSACCIDENTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ACCIDENTS ADD CONSTRAINT PK_INSACCIDENTS PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSACCIDENTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSACCIDENTS ON BARS.INS_ACCIDENTS (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_INSACCIDENTS_DEALID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_INSACCIDENTS_DEALID ON BARS.INS_ACCIDENTS (DEAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_ACCIDENTS ***
grant SELECT                                                                 on INS_ACCIDENTS   to BARSREADER_ROLE;
grant SELECT                                                                 on INS_ACCIDENTS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_ACCIDENTS.sql =========*** End ***
PROMPT ===================================================================================== 
