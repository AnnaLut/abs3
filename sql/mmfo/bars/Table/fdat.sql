

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FDAT.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FDAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FDAT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FDAT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FDAT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FDAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.FDAT 
   (	FDAT DATE, 
	STAT NUMBER(1,0), 
	CHGDATE DATE DEFAULT sysdate
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FDAT ***
 exec bpa.alter_policies('FDAT');


COMMENT ON TABLE BARS.FDAT IS 'Справочник банковских дат';
COMMENT ON COLUMN BARS.FDAT.CHGDATE IS '';
COMMENT ON COLUMN BARS.FDAT.FDAT IS 'Банковская дата';
COMMENT ON COLUMN BARS.FDAT.STAT IS 'Состояние банк. даты (9-закрыт; 0-открыт)';




PROMPT *** Create  constraint CC_FDAT_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FDAT MODIFY (FDAT CONSTRAINT CC_FDAT_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FDAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.FDAT ADD CONSTRAINT PK_FDAT PRIMARY KEY (FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_FDAT_STAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_FDAT_STAT ON BARS.FDAT (NVL(STAT,0)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FDAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FDAT ON BARS.FDAT (FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FDAT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FDAT            to ABS_ADMIN;
grant SELECT                                                                 on FDAT            to BARSAQ with grant option;
grant SELECT                                                                 on FDAT            to BARSAQ_ADM with grant option;
grant SELECT                                                                 on FDAT            to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on FDAT            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FDAT            to BARS_DM;
grant SELECT                                                                 on FDAT            to BASIC_INFO;
grant SELECT                                                                 on FDAT            to RPBN001;
grant SELECT                                                                 on FDAT            to START1;
grant SELECT                                                                 on FDAT            to TOSS;
grant SELECT                                                                 on FDAT            to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FDAT            to WR_ALL_RIGHTS;
grant SELECT                                                                 on FDAT            to WR_CUSTLIST;
grant SELECT                                                                 on FDAT            to WR_DEPOSIT_U;
grant SELECT                                                                 on FDAT            to WR_ND_ACCOUNTS;
grant SELECT                                                                 on FDAT            to WR_TOBO_ACCOUNTS_LIST;
grant SELECT                                                                 on FDAT            to WR_USER_ACCOUNTS_LIST;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FDAT.sql =========*** End *** ========
PROMPT ===================================================================================== 
