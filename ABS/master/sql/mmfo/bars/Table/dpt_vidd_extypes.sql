

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_EXTYPES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD_EXTYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VIDD_EXTYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_EXTYPES'', ''FILIAL'' , null, null, null, ''E'');
               bpa.alter_policy_info(''DPT_VIDD_EXTYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD_EXTYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD_EXTYPES 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(100), 
	BONUS_PROC VARCHAR2(3000), 
	BONUS_RATE VARCHAR2(3000), 
	EXT_CONDITION VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VIDD_EXTYPES ***
 exec bpa.alter_policies('DPT_VIDD_EXTYPES');


COMMENT ON TABLE BARS.DPT_VIDD_EXTYPES IS 'Методы расчета ставки при переоформлении вклада';
COMMENT ON COLUMN BARS.DPT_VIDD_EXTYPES.ID IS 'Код метода';
COMMENT ON COLUMN BARS.DPT_VIDD_EXTYPES.NAME IS 'Описание метода';
COMMENT ON COLUMN BARS.DPT_VIDD_EXTYPES.BONUS_PROC IS 'Процедура расчета и начисления бонуса';
COMMENT ON COLUMN BARS.DPT_VIDD_EXTYPES.BONUS_RATE IS 'Выражение для расчета бонусной ставки + проверка допустимости получения бонуса';
COMMENT ON COLUMN BARS.DPT_VIDD_EXTYPES.EXT_CONDITION IS 'SQL-выражение для проверки допустимости переоформления';




PROMPT *** Create  constraint CC_DPTVIDDEXTYPES_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_EXTYPES MODIFY (ID CONSTRAINT CC_DPTVIDDEXTYPES_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDEXTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_EXTYPES MODIFY (NAME CONSTRAINT CC_DPTVIDDEXTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTVIDDEXTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_EXTYPES ADD CONSTRAINT PK_DPTVIDDEXTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTVIDDEXTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTVIDDEXTYPES ON BARS.DPT_VIDD_EXTYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_VIDD_EXTYPES ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_EXTYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_VIDD_EXTYPES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_EXTYPES to DPT_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_EXTYPES to VKLAD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_EXTYPES to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_VIDD_EXTYPES to WR_REFREAD;



PROMPT *** Create SYNONYM  to DPT_VIDD_EXTYPES ***

  CREATE OR REPLACE PUBLIC SYNONYM DPT_VIDD_EXTYPES FOR BARS.DPT_VIDD_EXTYPES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_EXTYPES.sql =========*** End 
PROMPT ===================================================================================== 
