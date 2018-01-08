

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TYPEREF.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TYPEREF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TYPEREF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TYPEREF'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TYPEREF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TYPEREF ***
begin 
  execute immediate '
  CREATE TABLE BARS.TYPEREF 
   (	TYPE NUMBER(38,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TYPEREF ***
 exec bpa.alter_policies('TYPEREF');


COMMENT ON TABLE BARS.TYPEREF IS 'Типы  СПРАВОЧНИКОВ';
COMMENT ON COLUMN BARS.TYPEREF.TYPE IS 'Код';
COMMENT ON COLUMN BARS.TYPEREF.NAME IS 'Наименование группы справочника';




PROMPT *** Create  constraint PK_TYPEREF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TYPEREF ADD CONSTRAINT PK_TYPEREF PRIMARY KEY (TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009656 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TYPEREF MODIFY (TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TYPEREF_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TYPEREF MODIFY (NAME CONSTRAINT CC_TYPEREF_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TYPEREF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TYPEREF ON BARS.TYPEREF (TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TYPEREF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TYPEREF         to ABS_ADMIN;
grant SELECT                                                                 on TYPEREF         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TYPEREF         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TYPEREF         to BARS_DM;
grant SELECT                                                                 on TYPEREF         to REF0000;
grant SELECT                                                                 on TYPEREF         to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on TYPEREF         to TYPEREF;
grant SELECT                                                                 on TYPEREF         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TYPEREF         to WR_ALL_RIGHTS;
grant SELECT                                                                 on TYPEREF         to WR_METATAB;
grant FLASHBACK,SELECT                                                       on TYPEREF         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TYPEREF.sql =========*** End *** =====
PROMPT ===================================================================================== 
