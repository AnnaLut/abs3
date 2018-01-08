

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LIST_SET.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LIST_SET ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LIST_SET'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''LIST_SET'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''LIST_SET'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LIST_SET ***
begin 
  execute immediate '
  CREATE TABLE BARS.LIST_SET 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(50), 
	COMMENTS VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LIST_SET ***
 exec bpa.alter_policies('LIST_SET');


COMMENT ON TABLE BARS.LIST_SET IS 'Справочник списков функций';
COMMENT ON COLUMN BARS.LIST_SET.ID IS '№ п/п';
COMMENT ON COLUMN BARS.LIST_SET.NAME IS 'Наименование функции';
COMMENT ON COLUMN BARS.LIST_SET.COMMENTS IS 'Комментарий';




PROMPT *** Create  constraint PK_LISTSET ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_SET ADD CONSTRAINT PK_LISTSET PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009992 ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_SET MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009993 ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_SET MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_LISTSET ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_LISTSET ON BARS.LIST_SET (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LIST_SET ***
grant DELETE,INSERT,SELECT,UPDATE                                            on LIST_SET        to ABS_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on LIST_SET        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LIST_SET        to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on LIST_SET        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on LIST_SET        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LIST_SET.sql =========*** End *** ====
PROMPT ===================================================================================== 
