

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ETALON_TARIFF_VALUE.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_ETALON_TARIFF_VALUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_ETALON_TARIFF_VALUE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ETALON_TARIFF_VALUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ETALON_TARIFF_VALUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_ETALON_TARIFF_VALUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_ETALON_TARIFF_VALUE 
   (	TARIFF_ID NUMBER(10,0), 
	APPLY_DATE DATE, 
	TARIFF_AMOUNT NUMBER(22,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_ETALON_TARIFF_VALUE ***
 exec bpa.alter_policies('SKRYNKA_ETALON_TARIFF_VALUE');


COMMENT ON TABLE BARS.SKRYNKA_ETALON_TARIFF_VALUE IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ETALON_TARIFF_VALUE.TARIFF_ID IS 'Ідентифікатор еталонного тарифу';
COMMENT ON COLUMN BARS.SKRYNKA_ETALON_TARIFF_VALUE.APPLY_DATE IS 'Дата початку дії тарифу';
COMMENT ON COLUMN BARS.SKRYNKA_ETALON_TARIFF_VALUE.TARIFF_AMOUNT IS 'Сума тарифу за один день аренди сейфу (в гривнях)';




PROMPT *** Create  constraint CC_SKRETALTARIFFVAL_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ETALON_TARIFF_VALUE MODIFY (TARIFF_ID CONSTRAINT CC_SKRETALTARIFFVAL_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRETALTARIFFVAL_APLDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ETALON_TARIFF_VALUE MODIFY (APPLY_DATE CONSTRAINT CC_SKRETALTARIFFVAL_APLDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRETALTARIFFVAL_TARIFA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ETALON_TARIFF_VALUE MODIFY (TARIFF_AMOUNT CONSTRAINT CC_SKRETALTARIFFVAL_TARIFA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SKR_TARIFF_VALUE_IDX ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SKR_TARIFF_VALUE_IDX ON BARS.SKRYNKA_ETALON_TARIFF_VALUE (TARIFF_ID, APPLY_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_ETALON_TARIFF_VALUE ***
grant SELECT                                                                 on SKRYNKA_ETALON_TARIFF_VALUE to BARSREADER_ROLE;
grant SELECT                                                                 on SKRYNKA_ETALON_TARIFF_VALUE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ETALON_TARIFF_VALUE.sql ======
PROMPT ===================================================================================== 
