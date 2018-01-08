

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_FUNCTIONS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_FUNCTIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_FUNCTIONS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_FUNCTIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_FUNCTIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_FUNCTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_FUNCTIONS 
   (	KOD NUMBER(*,0), 
	ID VARCHAR2(20), 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_FUNCTIONS ***
 exec bpa.alter_policies('REZ_FUNCTIONS');


COMMENT ON TABLE BARS.REZ_FUNCTIONS IS 'Список функций расчета резерва';
COMMENT ON COLUMN BARS.REZ_FUNCTIONS.KOD IS 'Код функции';
COMMENT ON COLUMN BARS.REZ_FUNCTIONS.ID IS 'Идентификатор функции';
COMMENT ON COLUMN BARS.REZ_FUNCTIONS.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_REZFUNCTIONS ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_FUNCTIONS ADD CONSTRAINT PK_REZFUNCTIONS PRIMARY KEY (KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REZFUNCTIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZFUNCTIONS ON BARS.REZ_FUNCTIONS (KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_FUNCTIONS ***
grant SELECT                                                                 on REZ_FUNCTIONS   to BARSREADER_ROLE;
grant SELECT                                                                 on REZ_FUNCTIONS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_FUNCTIONS   to BARS_DM;
grant SELECT                                                                 on REZ_FUNCTIONS   to RCC_DEAL;
grant SELECT                                                                 on REZ_FUNCTIONS   to START1;
grant SELECT                                                                 on REZ_FUNCTIONS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_FUNCTIONS.sql =========*** End ***
PROMPT ===================================================================================== 
