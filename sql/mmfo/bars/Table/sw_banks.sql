

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_BANKS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_BANKS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_BANKS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_BANKS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SW_BANKS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_BANKS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_BANKS 
   (	BIC CHAR(11), 
	NAME VARCHAR2(254), 
	OFFICE VARCHAR2(254), 
	CITY VARCHAR2(35), 
	COUNTRY VARCHAR2(64), 
	CHRSET VARCHAR2(5), 
	TRANSBACK NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_BANKS ***
 exec bpa.alter_policies('SW_BANKS');


COMMENT ON TABLE BARS.SW_BANKS IS 'SWT. Справочник участников';
COMMENT ON COLUMN BARS.SW_BANKS.BIC IS 'Код участника';
COMMENT ON COLUMN BARS.SW_BANKS.NAME IS 'Наименование участника';
COMMENT ON COLUMN BARS.SW_BANKS.OFFICE IS 'Офис';
COMMENT ON COLUMN BARS.SW_BANKS.CITY IS 'Город';
COMMENT ON COLUMN BARS.SW_BANKS.COUNTRY IS 'Страна';
COMMENT ON COLUMN BARS.SW_BANKS.CHRSET IS 'Используемая таблица перекодировки';
COMMENT ON COLUMN BARS.SW_BANKS.TRANSBACK IS 'Признак возможности обратной перекодировки';




PROMPT *** Create  constraint PK_SWBANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_BANKS ADD CONSTRAINT PK_SWBANKS PRIMARY KEY (BIC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWBANKS_TRANSBACK ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_BANKS ADD CONSTRAINT CC_SWBANKS_TRANSBACK CHECK (transback in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWBANKS_SWCHRSETS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_BANKS ADD CONSTRAINT FK_SWBANKS_SWCHRSETS FOREIGN KEY (CHRSET)
	  REFERENCES BARS.SW_CHRSETS (SETID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWBANKS_BIC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_BANKS MODIFY (BIC CONSTRAINT CC_SWBANKS_BIC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWBANKS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWBANKS ON BARS.SW_BANKS (BIC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_BANKS ***
grant SELECT                                                                 on SW_BANKS        to BARS013;
grant FLASHBACK,REFERENCES,SELECT                                            on SW_BANKS        to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on SW_BANKS        to BARSAQ_ADM with grant option;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_BANKS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_BANKS        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_BANKS        to INSPECTOR;
grant SELECT                                                                 on SW_BANKS        to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_BANKS        to SWIFT001;
grant SELECT                                                                 on SW_BANKS        to SWTOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_BANKS        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SW_BANKS        to WR_REFREAD;



PROMPT *** Create SYNONYM  to SW_BANKS ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_BANKS FOR BARS.SW_BANKS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_BANKS.sql =========*** End *** ====
PROMPT ===================================================================================== 
