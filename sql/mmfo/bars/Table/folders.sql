

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FOLDERS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FOLDERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FOLDERS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FOLDERS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FOLDERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FOLDERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.FOLDERS 
   (	IDFO NUMBER(38,0), 
	NAME VARCHAR2(60)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FOLDERS ***
 exec bpa.alter_policies('FOLDERS');


COMMENT ON TABLE BARS.FOLDERS IS 'Папки операций';
COMMENT ON COLUMN BARS.FOLDERS.IDFO IS 'Идентификатор папки';
COMMENT ON COLUMN BARS.FOLDERS.NAME IS 'Наименование папки';




PROMPT *** Create  constraint PK_FOLDERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOLDERS ADD CONSTRAINT PK_FOLDERS PRIMARY KEY (IDFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FOLDERS_IDFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOLDERS MODIFY (IDFO CONSTRAINT CC_FOLDERS_IDFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FOLDERS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOLDERS MODIFY (NAME CONSTRAINT CC_FOLDERS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FOLDERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FOLDERS ON BARS.FOLDERS (IDFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FOLDERS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FOLDERS         to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FOLDERS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FOLDERS         to BARS_DM;
grant SELECT                                                                 on FOLDERS         to KLBX;
grant DELETE,INSERT,SELECT,UPDATE                                            on FOLDERS         to OPER_EDITOR;
grant SELECT                                                                 on FOLDERS         to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on FOLDERS         to REF0000;
grant SELECT                                                                 on FOLDERS         to START1;
grant SELECT                                                                 on FOLDERS         to TECH005;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FOLDERS         to WR_ALL_RIGHTS;
grant SELECT                                                                 on FOLDERS         to WR_DOC_INPUT;
grant FLASHBACK,SELECT                                                       on FOLDERS         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FOLDERS.sql =========*** End *** =====
PROMPT ===================================================================================== 
