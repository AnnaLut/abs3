

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_SCHOOLS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_SCHOOLS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_SCHOOLS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OW_SCHOOLS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OW_SCHOOLS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_SCHOOLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_SCHOOLS 
   (	SCHOOLID NUMBER(*,0), 
	SCHOOLTYPEID NUMBER(*,0), 
	NAME VARCHAR2(250), 
	SHORTNAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_SCHOOLS ***
 exec bpa.alter_policies('OW_SCHOOLS');


COMMENT ON TABLE BARS.OW_SCHOOLS IS 'Довідник шкіл';
COMMENT ON COLUMN BARS.OW_SCHOOLS.SCHOOLID IS 'Ідентифікатор школи';
COMMENT ON COLUMN BARS.OW_SCHOOLS.SCHOOLTYPEID IS 'Ідентифікатор типу навчального закладу';
COMMENT ON COLUMN BARS.OW_SCHOOLS.NAME IS 'Назва, номер школи';
COMMENT ON COLUMN BARS.OW_SCHOOLS.SHORTNAME IS 'Скорочена назва';




PROMPT *** Create  constraint PK_OWSCHOOLS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_SCHOOLS ADD CONSTRAINT PK_OWSCHOOLS PRIMARY KEY (SCHOOLID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCHOOLTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_SCHOOLS ADD CONSTRAINT FK_SCHOOLTYPES FOREIGN KEY (SCHOOLTYPEID)
	  REFERENCES BARS.OW_SCHOOLTYPES (SCHOOLTYPEID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009368 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_SCHOOLS MODIFY (SCHOOLID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009369 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_SCHOOLS MODIFY (SCHOOLTYPEID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009370 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_SCHOOLS MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWSCHOOLS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWSCHOOLS ON BARS.OW_SCHOOLS (SCHOOLID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_SCHOOLS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_SCHOOLS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_SCHOOLS      to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_SCHOOLS.sql =========*** End *** ==
PROMPT ===================================================================================== 
