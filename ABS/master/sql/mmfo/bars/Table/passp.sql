

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PASSP.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PASSP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PASSP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PASSP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PASSP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PASSP ***
begin 
  execute immediate '
  CREATE TABLE BARS.PASSP 
   (	PASSP NUMBER(*,0), 
	NAME VARCHAR2(35), 
	PSPTYP CHAR(2) DEFAULT ''  '', 
	NRF VARCHAR2(64), 
	REZID NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PASSP ***
 exec bpa.alter_policies('PASSP');


COMMENT ON TABLE BARS.PASSP IS 'Удостоверения физических лиц';
COMMENT ON COLUMN BARS.PASSP.PASSP IS 'Вид';
COMMENT ON COLUMN BARS.PASSP.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.PASSP.PSPTYP IS 'Тип документа';
COMMENT ON COLUMN BARS.PASSP.NRF IS 'Полное название документа';
COMMENT ON COLUMN BARS.PASSP.REZID IS 'Резидентність';




PROMPT *** Create  constraint PK_PASSP ***
begin   
 execute immediate '
  ALTER TABLE BARS.PASSP ADD CONSTRAINT PK_PASSP PRIMARY KEY (PASSP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PASSP_PASSP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PASSP MODIFY (PASSP CONSTRAINT CC_PASSP_PASSP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PASSP_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PASSP MODIFY (NAME CONSTRAINT CC_PASSP_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PASSP_PSPTYP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PASSP MODIFY (PSPTYP CONSTRAINT CC_PASSP_PSPTYP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PASSP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PASSP ON BARS.PASSP (PASSP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PASSP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PASSP           to ABS_ADMIN;
grant SELECT                                                                 on PASSP           to BARSAQ with grant option;
grant SELECT                                                                 on PASSP           to BARSAQ_ADM with grant option;
grant SELECT                                                                 on PASSP           to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PASSP           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PASSP           to BARS_DM;
grant SELECT                                                                 on PASSP           to CUST001;
grant SELECT                                                                 on PASSP           to DPT;
grant SELECT                                                                 on PASSP           to DPT_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PASSP           to PASSP;
grant SELECT                                                                 on PASSP           to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PASSP           to WR_ALL_RIGHTS;
grant SELECT                                                                 on PASSP           to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on PASSP           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PASSP.sql =========*** End *** =======
PROMPT ===================================================================================== 
