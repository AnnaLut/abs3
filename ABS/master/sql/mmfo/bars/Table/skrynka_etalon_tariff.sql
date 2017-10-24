

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ETALON_TARIFF.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_ETALON_TARIFF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_ETALON_TARIFF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ETALON_TARIFF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ETALON_TARIFF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_ETALON_TARIFF ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_ETALON_TARIFF 
   (	ID NUMBER(10,0), 
	ETALON_ID NUMBER(5,0), 
	DAYS_COUNT NUMBER(5,0), 
	CLOSE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_ETALON_TARIFF ***
 exec bpa.alter_policies('SKRYNKA_ETALON_TARIFF');


COMMENT ON TABLE BARS.SKRYNKA_ETALON_TARIFF IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ETALON_TARIFF.ID IS 'Ідентифікатор еталонного тарифу';
COMMENT ON COLUMN BARS.SKRYNKA_ETALON_TARIFF.ETALON_ID IS 'Ідентифікатор еталонної групи сейфів';
COMMENT ON COLUMN BARS.SKRYNKA_ETALON_TARIFF.DAYS_COUNT IS 'Верхня межа тривалості аренди сейфа (в днях)';
COMMENT ON COLUMN BARS.SKRYNKA_ETALON_TARIFF.CLOSE_DATE IS 'Дата припинення дії еталонного тарифу';




PROMPT *** Create  constraint PK_SKRYNKA_ETALON_TARIFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ETALON_TARIFF ADD CONSTRAINT PK_SKRYNKA_ETALON_TARIFF PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint AK_KEY_2_SKRYNKA_ ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ETALON_TARIFF ADD CONSTRAINT AK_KEY_2_SKRYNKA_ UNIQUE (ETALON_ID, DAYS_COUNT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYN_TARIF_REF_ETALON ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ETALON_TARIFF ADD CONSTRAINT FK_SKRYN_TARIF_REF_ETALON FOREIGN KEY (ETALON_ID)
	  REFERENCES BARS.SKRYNKA_TIP_ETALON (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRETALTARIFF_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ETALON_TARIFF MODIFY (ID CONSTRAINT CC_SKRETALTARIFF_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRETALTARIFF_OSK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ETALON_TARIFF MODIFY (ETALON_ID CONSTRAINT CC_SKRETALTARIFF_OSK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRETALTARIFF_DAYSCOUNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ETALON_TARIFF MODIFY (DAYS_COUNT CONSTRAINT CC_SKRETALTARIFF_DAYSCOUNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKA_ETALON_TARIFF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKA_ETALON_TARIFF ON BARS.SKRYNKA_ETALON_TARIFF (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index AK_KEY_2_SKRYNKA_ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.AK_KEY_2_SKRYNKA_ ON BARS.SKRYNKA_ETALON_TARIFF (ETALON_ID, DAYS_COUNT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ETALON_TARIFF.sql =========***
PROMPT ===================================================================================== 
