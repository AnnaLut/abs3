

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/COUNTRY.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to COUNTRY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''COUNTRY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''COUNTRY'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''COUNTRY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table COUNTRY ***
begin 
  execute immediate '
  CREATE TABLE BARS.COUNTRY 
   (	COUNTRY NUMBER(3,0), 
	NAME VARCHAR2(70), 
	GRP NUMBER(1,0), 
	FATF NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to COUNTRY ***
 exec bpa.alter_policies('COUNTRY');


COMMENT ON TABLE BARS.COUNTRY IS 'Справочник стран-эмитентов валют';
COMMENT ON COLUMN BARS.COUNTRY.COUNTRY IS 'Код страны';
COMMENT ON COLUMN BARS.COUNTRY.NAME IS 'Наименование страны';
COMMENT ON COLUMN BARS.COUNTRY.GRP IS 'Группа';
COMMENT ON COLUMN BARS.COUNTRY.FATF IS '';




PROMPT *** Create  constraint CC_COUNTRY_FATF ***
begin   
 execute immediate '
  ALTER TABLE BARS.COUNTRY ADD CONSTRAINT CC_COUNTRY_FATF CHECK (fatf in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_COUNTRY_FATF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.COUNTRY ADD CONSTRAINT CC_COUNTRY_FATF_NN CHECK (fatf is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_COUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.COUNTRY ADD CONSTRAINT PK_COUNTRY PRIMARY KEY (COUNTRY)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_COUNTRY_COUNTRY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.COUNTRY MODIFY (COUNTRY CONSTRAINT CC_COUNTRY_COUNTRY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_COUNTRY_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.COUNTRY MODIFY (NAME CONSTRAINT CC_COUNTRY_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_COUNTRY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_COUNTRY ON BARS.COUNTRY (COUNTRY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  COUNTRY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on COUNTRY         to ABS_ADMIN;
grant REFERENCES,SELECT                                                      on COUNTRY         to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on COUNTRY         to BARSAQ_ADM with grant option;
grant SELECT                                                                 on COUNTRY         to BARSREADER_ROLE;
grant SELECT                                                                 on COUNTRY         to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on COUNTRY         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on COUNTRY         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on COUNTRY         to COUNTRY;
grant SELECT                                                                 on COUNTRY         to CUST001;
grant SELECT                                                                 on COUNTRY         to DPT;
grant SELECT                                                                 on COUNTRY         to DPT_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on COUNTRY         to FINMON;
grant SELECT                                                                 on COUNTRY         to PYOD001;
grant SELECT                                                                 on COUNTRY         to START1;
grant SELECT                                                                 on COUNTRY         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on COUNTRY         to WR_ALL_RIGHTS;
grant SELECT                                                                 on COUNTRY         to WR_CUSTLIST;
grant SELECT                                                                 on COUNTRY         to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on COUNTRY         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/COUNTRY.sql =========*** End *** =====
PROMPT ===================================================================================== 
