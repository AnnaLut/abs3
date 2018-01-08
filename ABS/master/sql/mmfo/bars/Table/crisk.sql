

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CRISK.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CRISK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CRISK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CRISK'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CRISK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CRISK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CRISK 
   (	CRISK VARCHAR2(1), 
	NAME VARCHAR2(35), 
	REZ NUMBER(10,3), 
	REZ2 NUMBER(10,3), 
	REZ3 NUMBER, 
	REZ4 NUMBER, 
	REZ5 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CRISK ***
 exec bpa.alter_policies('CRISK');


COMMENT ON TABLE BARS.CRISK IS 'Категория риска';
COMMENT ON COLUMN BARS.CRISK.CRISK IS 'Категория риска';
COMMENT ON COLUMN BARS.CRISK.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.CRISK.REZ IS 'Коэффициент резервирования крединтных операций в ин.вал. для клиентов имеющих источников валютной выручки';
COMMENT ON COLUMN BARS.CRISK.REZ2 IS 'Коэффициент резервирования крединтных операций в ин.вал. для клиентов не имеющих источников валютной выручки';
COMMENT ON COLUMN BARS.CRISK.REZ3 IS 'процент резервирования для валютных кредитов у которых есть источниками валютной выручки ';
COMMENT ON COLUMN BARS.CRISK.REZ4 IS 'процент резервирования для портфеля однородных кредитов';
COMMENT ON COLUMN BARS.CRISK.REZ5 IS '';




PROMPT *** Create  constraint PK_CRISK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CRISK ADD CONSTRAINT PK_CRISK PRIMARY KEY (CRISK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CRISK_CRISK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CRISK MODIFY (CRISK CONSTRAINT CC_CRISK_CRISK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CRISK_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CRISK MODIFY (NAME CONSTRAINT CC_CRISK_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CRISK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CRISK ON BARS.CRISK (CRISK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CRISK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CRISK           to ABS_ADMIN;
grant SELECT                                                                 on CRISK           to BARS009;
grant SELECT                                                                 on CRISK           to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CRISK           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CRISK           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CRISK           to RCC_DEAL;
grant SELECT                                                                 on CRISK           to START1;
grant SELECT                                                                 on CRISK           to TECH005;
grant SELECT                                                                 on CRISK           to TECH006;
grant SELECT                                                                 on CRISK           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CRISK           to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CRISK           to WR_REFREAD;



PROMPT *** Create SYNONYM  to CRISK ***

  CREATE OR REPLACE PUBLIC SYNONYM CRISK FOR BARS.CRISK;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CRISK.sql =========*** End *** =======
PROMPT ===================================================================================== 
