

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_SEND_HISTORY.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_SEND_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_SEND_HISTORY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_SEND_HISTORY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_SEND_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_SEND_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_SEND_HISTORY 
   (	DOG_ID NUMBER(38,0), 
	SEND_DATE DATE, 
	BATCH_ID NUMBER, 
	SEND_ID NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIG_SEND_HISTORY ***
 exec bpa.alter_policies('CIG_SEND_HISTORY');


COMMENT ON TABLE BARS.CIG_SEND_HISTORY IS 'История отправлений пакетов с договорами';
COMMENT ON COLUMN BARS.CIG_SEND_HISTORY.DOG_ID IS 'Код договору';
COMMENT ON COLUMN BARS.CIG_SEND_HISTORY.SEND_DATE IS 'Дата передачі до ПВБКІ';
COMMENT ON COLUMN BARS.CIG_SEND_HISTORY.BATCH_ID IS 'Код пакету наданого ПВБКІ';
COMMENT ON COLUMN BARS.CIG_SEND_HISTORY.SEND_ID IS 'Код пакету (Барса)';
COMMENT ON COLUMN BARS.CIG_SEND_HISTORY.BRANCH IS 'Відділення';




PROMPT *** Create  constraint PK_CIGSENDHIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_SEND_HISTORY ADD CONSTRAINT PK_CIGSENDHIST PRIMARY KEY (BRANCH, DOG_ID, SEND_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGSENDHIST_BATCHID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_SEND_HISTORY MODIFY (BATCH_ID CONSTRAINT CC_CIGSENDHIST_BATCHID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGSENDHIST_SEND_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_SEND_HISTORY MODIFY (SEND_ID CONSTRAINT CC_CIGSENDHIST_SEND_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGSENDHIST_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_SEND_HISTORY MODIFY (BRANCH CONSTRAINT CC_CIGSENDHIST_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGSENDHIST_SDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_SEND_HISTORY MODIFY (SEND_DATE CONSTRAINT CC_CIGSENDHIST_SDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIGSENDHIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIGSENDHIST ON BARS.CIG_SEND_HISTORY (BRANCH, DOG_ID, SEND_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CIGSENDHIST_DOGIDBRANCH ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_CIGSENDHIST_DOGIDBRANCH ON BARS.CIG_SEND_HISTORY (DOG_ID, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_SEND_HISTORY ***
grant DELETE,INSERT,SELECT                                                   on CIG_SEND_HISTORY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIG_SEND_HISTORY to BARS_DM;
grant DELETE,INSERT,SELECT                                                   on CIG_SEND_HISTORY to CIG_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_SEND_HISTORY.sql =========*** End 
PROMPT ===================================================================================== 
