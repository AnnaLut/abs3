

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SCORINGS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SCORINGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SCORINGS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCORINGS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCORINGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SCORINGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SCORINGS 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	RESULT_QID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SCORINGS ***
 exec bpa.alter_policies('WCS_SCORINGS');


COMMENT ON TABLE BARS.WCS_SCORINGS IS 'Карты скоринга';
COMMENT ON COLUMN BARS.WCS_SCORINGS.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_SCORINGS.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.WCS_SCORINGS.RESULT_QID IS 'Идентификатор вопроса-результата вычисления скор. балла';




PROMPT *** Create  constraint PK_SCORINGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORINGS ADD CONSTRAINT PK_SCORINGS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORINGS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORINGS MODIFY (NAME CONSTRAINT CC_SCORINGS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORINGS_RESULTQID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORINGS MODIFY (RESULT_QID CONSTRAINT CC_SCORINGS_RESULTQID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SCORINGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SCORINGS ON BARS.WCS_SCORINGS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SCORINGS ***
grant SELECT                                                                 on WCS_SCORINGS    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SCORINGS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SCORINGS    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SCORINGS    to START1;
grant SELECT                                                                 on WCS_SCORINGS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SCORINGS.sql =========*** End *** 
PROMPT ===================================================================================== 
