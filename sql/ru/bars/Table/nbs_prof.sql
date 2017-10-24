

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_PROF.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_PROF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_PROF'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBS_PROF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_PROF ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_PROF 
   (	NBS VARCHAR2(4), 
	NP NUMBER, 
	PR NUMBER, 
	ID NUMBER, 
	VAL VARCHAR2(70), 
	SQL_TEXT VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBS_PROF ***
 exec bpa.alter_policies('NBS_PROF');


COMMENT ON TABLE BARS.NBS_PROF IS 'Значения профилей счетов';
COMMENT ON COLUMN BARS.NBS_PROF.NBS IS 'Номер БС';
COMMENT ON COLUMN BARS.NBS_PROF.NP IS 'Номер профиля';
COMMENT ON COLUMN BARS.NBS_PROF.PR IS 'Признак 1-осн.рекв, 2-спецпараметр';
COMMENT ON COLUMN BARS.NBS_PROF.ID IS 'Код поля';
COMMENT ON COLUMN BARS.NBS_PROF.VAL IS 'Значение Поля';
COMMENT ON COLUMN BARS.NBS_PROF.SQL_TEXT IS 'SQL-выражение для определения значения поля';




PROMPT *** Create  constraint FK_NBS_PROF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_PROF ADD CONSTRAINT FK_NBS_PROF FOREIGN KEY (NBS, NP)
	  REFERENCES BARS.NBS_PROFNAM (NBS, NP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_NBS_PROF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_PROF ADD CONSTRAINT XPK_NBS_PROF PRIMARY KEY (NBS, NP, PR, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_NBS_PROF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_NBS_PROF ON BARS.NBS_PROF (NBS, NP, PR, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBS_PROF ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_PROF        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBS_PROF        to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_PROF        to NBS_PROF;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_PROF        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_PROF        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on NBS_PROF        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_PROF.sql =========*** End *** ====
PROMPT ===================================================================================== 
