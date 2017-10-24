

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REPORT_FORMS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REPORT_FORMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REPORT_FORMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REPORT_FORMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REPORT_FORMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REPORT_FORMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.REPORT_FORMS 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(300)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REPORT_FORMS ***
 exec bpa.alter_policies('REPORT_FORMS');


COMMENT ON TABLE BARS.REPORT_FORMS IS 'Форми звітів';
COMMENT ON COLUMN BARS.REPORT_FORMS.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.REPORT_FORMS.NAME IS 'Найменування';




PROMPT *** Create  constraint PK_REPORTFORMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORT_FORMS ADD CONSTRAINT PK_REPORTFORMS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009156 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORT_FORMS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009157 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORT_FORMS MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REPORTFORMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REPORTFORMS ON BARS.REPORT_FORMS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REPORT_FORMS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REPORT_FORMS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REPORT_FORMS    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REPORT_FORMS    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REPORT_FORMS.sql =========*** End *** 
PROMPT ===================================================================================== 
