

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_TYPES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_TYPES 
   (	TYPE_ID NUMBER(38,0), 
	TYPE_NAME VARCHAR2(100), 
	TYPE_CODE VARCHAR2(4), 
	SORT_ORD NUMBER(38,0), 
	FL_ACTIVE NUMBER(1,0) DEFAULT 0, 
	SUM_MIN NUMBER(24,0) DEFAULT 0, 
	SUM_MAX NUMBER(24,0), 
	SUM_ADD NUMBER(24,0), 
	STOP_ID NUMBER(38,0) DEFAULT 0, 
	BR_ID NUMBER(38,0), 
	SHABLON VARCHAR2(35), 
	COMPROC NUMBER(1,0) DEFAULT 0, 
	METR_ID NUMBER(2,0) DEFAULT 0, 
	EXTENSION_ID NUMBER(38,0), 
	TERM_TYPE NUMBER(1,0), 
	TERM_MIN NUMBER(6,4), 
	TERM_MAX NUMBER(6,4) DEFAULT 0, 
	TERM_ADD NUMBER(6,4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_TYPES ***
 exec bpa.alter_policies('DPU_TYPES');


COMMENT ON TABLE BARS.DPU_TYPES IS 'Типы депозитных договоров юр.лиц';
COMMENT ON COLUMN BARS.DPU_TYPES.TYPE_ID IS 'Числ.код типа договора';
COMMENT ON COLUMN BARS.DPU_TYPES.TYPE_NAME IS 'Наименование типа договора';
COMMENT ON COLUMN BARS.DPU_TYPES.TYPE_CODE IS 'Симв.код типа договора';
COMMENT ON COLUMN BARS.DPU_TYPES.SORT_ORD IS 'Порядок сортировки';
COMMENT ON COLUMN BARS.DPU_TYPES.FL_ACTIVE IS '';
COMMENT ON COLUMN BARS.DPU_TYPES.SUM_MIN IS 'Мінімальна сума депозиту';
COMMENT ON COLUMN BARS.DPU_TYPES.SUM_MAX IS 'Максимальна сума депозиту';
COMMENT ON COLUMN BARS.DPU_TYPES.SUM_ADD IS 'Мінімальна сума поповнення депозиту';
COMMENT ON COLUMN BARS.DPU_TYPES.STOP_ID IS 'Код штрафу за дострокове розторгнення договору';
COMMENT ON COLUMN BARS.DPU_TYPES.BR_ID IS 'Код базової % ставки';
COMMENT ON COLUMN BARS.DPU_TYPES.SHABLON IS 'Шаблон генерального договору';
COMMENT ON COLUMN BARS.DPU_TYPES.COMPROC IS 'Ознака капіталізації %%';
COMMENT ON COLUMN BARS.DPU_TYPES.METR_ID IS 'Код методу нарахування %%';
COMMENT ON COLUMN BARS.DPU_TYPES.EXTENSION_ID IS 'Код методу зміни % ставки при пролонгації';
COMMENT ON COLUMN BARS.DPU_TYPES.TERM_TYPE IS 'Тип терміну депозиту (1 - фікований, 2 - діапазон)';
COMMENT ON COLUMN BARS.DPU_TYPES.TERM_MIN IS 'Мінімальний термін дії депозиту';
COMMENT ON COLUMN BARS.DPU_TYPES.TERM_MAX IS 'Максимальний термін дії депозиту';
COMMENT ON COLUMN BARS.DPU_TYPES.TERM_ADD IS 'Термін протягом якого дозволено поповнення депозиту';




PROMPT *** Create  constraint CC_DPUTYPES_TERMTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES ADD CONSTRAINT CC_DPUTYPES_TERMTYPE CHECK ( TERM_TYPE in ( 1, 2 ) ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPUTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES ADD CONSTRAINT PK_DPUTYPES PRIMARY KEY (TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPES_TERMMAX_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES MODIFY (TERM_MAX CONSTRAINT CC_DPUTYPES_TERMMAX_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPES_METRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES MODIFY (METR_ID CONSTRAINT CC_DPUTYPES_METRID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPES_COMPROC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES MODIFY (COMPROC CONSTRAINT CC_DPUTYPES_COMPROC_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPES_STOPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES MODIFY (STOP_ID CONSTRAINT CC_DPUTYPES_STOPID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPES_SUMMIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES MODIFY (SUM_MIN CONSTRAINT CC_DPUTYPES_SUMMIN_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPES_TYPENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES MODIFY (TYPE_NAME CONSTRAINT CC_DPUTYPES_TYPENAME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPES_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES MODIFY (TYPE_ID CONSTRAINT CC_DPUTYPES_TYPEID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPES_AMNTLIMIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES ADD CONSTRAINT CC_DPUTYPES_AMNTLIMIT CHECK ( SUM_MIN <= SUM_MAX ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPES_FLACTIVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES ADD CONSTRAINT CC_DPUTYPES_FLACTIVE CHECK ( FL_ACTIVE in ( 0, 1 ) ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPES_FLACTIVE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES MODIFY (FL_ACTIVE CONSTRAINT CC_DPUTYPES_FLACTIVE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPES_COMPROC ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES ADD CONSTRAINT CC_DPUTYPES_COMPROC CHECK ( COMPROC in ( 0, 1 ) ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPES_TERMLIMIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES ADD CONSTRAINT CC_DPUTYPES_TERMLIMIT CHECK ( TERM_MIN <= TERM_MAX ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUTYPES ON BARS.DPU_TYPES (TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_TYPES ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_TYPES       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_TYPES       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_TYPES       to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_TYPES       to DPT_ADMIN;
grant SELECT                                                                 on DPU_TYPES       to DPT_ROLE;
grant SELECT                                                                 on DPU_TYPES       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPU_TYPES       to WR_REFREAD;



PROMPT *** Create SYNONYM  to DPU_TYPES ***

  CREATE OR REPLACE PUBLIC SYNONYM DPU_TYPES FOR BARS.DPU_TYPES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_TYPES.sql =========*** End *** ===
PROMPT ===================================================================================== 
