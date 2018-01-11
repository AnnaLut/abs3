

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SOCIAL_DPT_TYPES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SOCIAL_DPT_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SOCIAL_DPT_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SOCIAL_DPT_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SOCIAL_DPT_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SOCIAL_DPT_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SOCIAL_DPT_TYPES 
   (	TYPE_ID NUMBER(38,0), 
	NAME VARCHAR2(100), 
	ACC_TYPE CHAR(3), 
	DPT_VIDD NUMBER(38,0), 
	ACTIVITY NUMBER(1,0), 
	MASK_NUMBER CHAR(1), 
	CARD_TYPE NUMBER(1,0), 
	TIP_OSZ CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SOCIAL_DPT_TYPES ***
 exec bpa.alter_policies('SOCIAL_DPT_TYPES');


COMMENT ON TABLE BARS.SOCIAL_DPT_TYPES IS 'Типы договоров с пенсионерами и безработными';
COMMENT ON COLUMN BARS.SOCIAL_DPT_TYPES.TYPE_ID IS 'Код типа';
COMMENT ON COLUMN BARS.SOCIAL_DPT_TYPES.NAME IS 'Наименование типа';
COMMENT ON COLUMN BARS.SOCIAL_DPT_TYPES.ACC_TYPE IS 'Тип счета';
COMMENT ON COLUMN BARS.SOCIAL_DPT_TYPES.DPT_VIDD IS 'Код вида вклада';
COMMENT ON COLUMN BARS.SOCIAL_DPT_TYPES.ACTIVITY IS 'Признак активности';
COMMENT ON COLUMN BARS.SOCIAL_DPT_TYPES.MASK_NUMBER IS 'Код типа договора (маска счета)';
COMMENT ON COLUMN BARS.SOCIAL_DPT_TYPES.CARD_TYPE IS 'Ознака карткового договору';
COMMENT ON COLUMN BARS.SOCIAL_DPT_TYPES.TIP_OSZ IS 'Тип органа соц.защиты (для миграции АСВО)';




PROMPT *** Create  constraint CC_SOCIALDPTTYPES_ACTIVITY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_DPT_TYPES ADD CONSTRAINT CC_SOCIALDPTTYPES_ACTIVITY CHECK (activity IN (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALDPTTYPES_CARDTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_DPT_TYPES ADD CONSTRAINT CC_SOCIALDPTTYPES_CARDTYPE CHECK (card_type in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALDPTTYPES_ACCTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_DPT_TYPES ADD CONSTRAINT CC_SOCIALDPTTYPES_ACCTYPE CHECK (acc_type in (''PDM'', ''PCD'', ''ECD'', ''EMP'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SOCIALDPTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_DPT_TYPES ADD CONSTRAINT PK_SOCIALDPTTYPES PRIMARY KEY (TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALDPTTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_DPT_TYPES MODIFY (NAME CONSTRAINT CC_SOCIALDPTTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALDPTTYPES_ACCTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_DPT_TYPES MODIFY (ACC_TYPE CONSTRAINT CC_SOCIALDPTTYPES_ACCTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALDPTTYPES_DPTVIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_DPT_TYPES MODIFY (DPT_VIDD CONSTRAINT CC_SOCIALDPTTYPES_DPTVIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALDPTTYPES_ACTIVITY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_DPT_TYPES MODIFY (ACTIVITY CONSTRAINT CC_SOCIALDPTTYPES_ACTIVITY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALDPTTYPES_CARDTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_DPT_TYPES MODIFY (CARD_TYPE CONSTRAINT CC_SOCIALDPTTYPES_CARDTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SOCIALDPTTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SOCIALDPTTYPES ON BARS.SOCIAL_DPT_TYPES (TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_SOCIALDPTTYPES ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_SOCIALDPTTYPES ON BARS.SOCIAL_DPT_TYPES (ACC_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_SOCIALDPTTYPES ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_SOCIALDPTTYPES ON BARS.SOCIAL_DPT_TYPES (DPT_VIDD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SOCIAL_DPT_TYPES ***
grant SELECT                                                                 on SOCIAL_DPT_TYPES to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOCIAL_DPT_TYPES to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SOCIAL_DPT_TYPES to DPT_ADMIN;
grant SELECT                                                                 on SOCIAL_DPT_TYPES to KLBX;
grant SELECT                                                                 on SOCIAL_DPT_TYPES to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOCIAL_DPT_TYPES to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SOCIAL_DPT_TYPES to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SOCIAL_DPT_TYPES.sql =========*** End 
PROMPT ===================================================================================== 
