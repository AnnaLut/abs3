

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_BCK_RESULTS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_BCK_RESULTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_BCK_RESULTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_BCK_RESULTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_BCK_RESULTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_BCK_RESULTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_BCK_RESULTS 
   (	ID NUMBER(38,0), 
	REP_ID NUMBER(38,0), 
	TAG_NAME VARCHAR2(38), 
	TAG_BLOCK NUMBER(2,0), 
	TAG_VALUE VARCHAR2(512), 
	SEQ_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_BCK_RESULTS ***
 exec bpa.alter_policies('WCS_BCK_RESULTS');


COMMENT ON TABLE BARS.WCS_BCK_RESULTS IS 'Таблица переменных, полученных из отчета кред бюро';
COMMENT ON COLUMN BARS.WCS_BCK_RESULTS.ID IS 'Идентификатор записи';
COMMENT ON COLUMN BARS.WCS_BCK_RESULTS.REP_ID IS 'Идентификатор отчета';
COMMENT ON COLUMN BARS.WCS_BCK_RESULTS.TAG_NAME IS 'Наименование параметра';
COMMENT ON COLUMN BARS.WCS_BCK_RESULTS.TAG_BLOCK IS 'Номер блока XML';
COMMENT ON COLUMN BARS.WCS_BCK_RESULTS.TAG_VALUE IS 'Значение параметра';
COMMENT ON COLUMN BARS.WCS_BCK_RESULTS.SEQ_ID IS 'Номер записи в последовательности';




PROMPT *** Create  constraint PK_WCSBCKRESULTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_RESULTS ADD CONSTRAINT PK_WCSBCKRESULTS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_WCSBCKRES_REPTAGNAMTAGBLKSQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_RESULTS ADD CONSTRAINT UK_WCSBCKRES_REPTAGNAMTAGBLKSQ UNIQUE (REP_ID, TAG_NAME, TAG_BLOCK, SEQ_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSBCKRESULTS_SEQID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_RESULTS MODIFY (SEQ_ID CONSTRAINT CC_WCSBCKRESULTS_SEQID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSBCKRESULTS_TAGVALUE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_RESULTS MODIFY (TAG_VALUE CONSTRAINT CC_WCSBCKRESULTS_TAGVALUE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSBCKRESULTS_TAGBLOCK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_RESULTS MODIFY (TAG_BLOCK CONSTRAINT CC_WCSBCKRESULTS_TAGBLOCK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSBCKRESULTS_TAGNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_RESULTS MODIFY (TAG_NAME CONSTRAINT CC_WCSBCKRESULTS_TAGNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSBCKRESULTS_REPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_RESULTS MODIFY (REP_ID CONSTRAINT CC_WCSBCKRESULTS_REPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSBCKRESULTS_WCSBCKRTAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_RESULTS ADD CONSTRAINT FK_WCSBCKRESULTS_WCSBCKRTAGS FOREIGN KEY (TAG_NAME, TAG_BLOCK)
	  REFERENCES BARS.WCS_BCK_TAGS (TAG_NAME, TAG_BLOCK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSBCKRESULTS_WCSBCKXMLBLK ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_RESULTS ADD CONSTRAINT FK_WCSBCKRESULTS_WCSBCKXMLBLK FOREIGN KEY (TAG_BLOCK)
	  REFERENCES BARS.WCS_BCK_XMLBLOCKS (BLOCK_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSBCKRESULTS_WCSBCKREPORTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_RESULTS ADD CONSTRAINT FK_WCSBCKRESULTS_WCSBCKREPORTS FOREIGN KEY (REP_ID)
	  REFERENCES BARS.WCS_BCK_REPORTS (REP_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSBCKRESULTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSBCKRESULTS ON BARS.WCS_BCK_RESULTS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_WCSBCKRES_REPTAGNAMTAGBLKSQ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_WCSBCKRES_REPTAGNAMTAGBLKSQ ON BARS.WCS_BCK_RESULTS (REP_ID, TAG_NAME, TAG_BLOCK, SEQ_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_BCK_RESULTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_BCK_RESULTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_BCK_RESULTS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_BCK_RESULTS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_BCK_RESULTS.sql =========*** End *
PROMPT ===================================================================================== 
