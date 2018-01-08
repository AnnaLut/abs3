

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_CLI.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_CLI ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_CLI ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_CLI 
   (	NAME_CLI VARCHAR2(24), 
	KOD_CLI NUMBER(10,0), 
	NNN_CLI NUMBER(10,0), 
	NAME_FILEU VARCHAR2(14), 
	NAME_POLEU VARCHAR2(15), 
	NAME_FILE VARCHAR2(12), 
	NAME_POLE VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_CLI ***
 exec bpa.alter_policies('KOD_CLI');


COMMENT ON TABLE BARS.KOD_CLI IS 'Параметры корп. клиентов (спец. справочник для Ощад.б.)';
COMMENT ON COLUMN BARS.KOD_CLI.NAME_CLI IS 'Наименование клиента';
COMMENT ON COLUMN BARS.KOD_CLI.KOD_CLI IS 'Код клиента';
COMMENT ON COLUMN BARS.KOD_CLI.NNN_CLI IS '';
COMMENT ON COLUMN BARS.KOD_CLI.NAME_FILEU IS '';
COMMENT ON COLUMN BARS.KOD_CLI.NAME_POLEU IS '';
COMMENT ON COLUMN BARS.KOD_CLI.NAME_FILE IS '';
COMMENT ON COLUMN BARS.KOD_CLI.NAME_POLE IS '';




PROMPT *** Create  constraint XPK_KOD_CLI ***
begin   
 execute immediate '
  ALTER TABLE BARS.KOD_CLI ADD CONSTRAINT XPK_KOD_CLI PRIMARY KEY (KOD_CLI)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KOD_CLI ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KOD_CLI ON BARS.KOD_CLI (KOD_CLI) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KOD_CLI ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KOD_CLI         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOD_CLI         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_CLI         to CORP_CLIENT;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_CLI         to KOD_CLI;
grant INSERT,SELECT,UPDATE                                                   on KOD_CLI         to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KOD_CLI         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KOD_CLI         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_CLI.sql =========*** End *** =====
PROMPT ===================================================================================== 
