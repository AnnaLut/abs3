

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SURVEY_REPLINES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SURVEY_REPLINES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SURVEY_REPLINES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SURVEY_REPLINES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SURVEY_REPLINES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SURVEY_REPLINES 
   (	REP_ID NUMBER, 
	LIN_ORD NUMBER, 
	QUEST_ID NUMBER, 
	LIN_NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 1 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SURVEY_REPLINES ***
 exec bpa.alter_policies('SURVEY_REPLINES');


COMMENT ON TABLE BARS.SURVEY_REPLINES IS '���������� ������ ������� �� �������';
COMMENT ON COLUMN BARS.SURVEY_REPLINES.REP_ID IS '��� ������';
COMMENT ON COLUMN BARS.SURVEY_REPLINES.LIN_ORD IS '����� ������ ������';
COMMENT ON COLUMN BARS.SURVEY_REPLINES.QUEST_ID IS '��� �������, ������ �� ������� �������';
COMMENT ON COLUMN BARS.SURVEY_REPLINES.LIN_NAME IS '��������� ������ ������';




PROMPT *** Create  constraint XFK_SURV_REPL_QUEST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_REPLINES ADD CONSTRAINT XFK_SURV_REPL_QUEST FOREIGN KEY (QUEST_ID)
	  REFERENCES BARS.SURVEY_QUEST (QUEST_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_SURV_REPL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_REPLINES ADD CONSTRAINT XPK_SURV_REPL PRIMARY KEY (REP_ID, LIN_ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SURV_REPL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SURV_REPL ON BARS.SURVEY_REPLINES (REP_ID, LIN_ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SURVEY_REPLINES ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SURVEY_REPLINES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SURVEY_REPLINES.sql =========*** End *
PROMPT ===================================================================================== 
