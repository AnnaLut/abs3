

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_EXTDESC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD_EXTDESC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VIDD_EXTDESC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_EXTDESC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_EXTDESC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD_EXTDESC ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD_EXTDESC 
   (	TYPE_ID NUMBER(38,0), 
	EXT_NUM NUMBER(38,0), 
	TERM_MNTH NUMBER(38,0) DEFAULT 0, 
	TERM_DAYS NUMBER(38,0) DEFAULT 0, 
	INDV_RATE NUMBER(20,4), 
	OPER_ID NUMBER(38,0), 
	BASE_RATE NUMBER(38,0), 
	METHOD_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VIDD_EXTDESC ***
 exec bpa.alter_policies('DPT_VIDD_EXTDESC');


COMMENT ON TABLE BARS.DPT_VIDD_EXTDESC IS 'Описание методов расчета ставки при переоформлении вклада';
COMMENT ON COLUMN BARS.DPT_VIDD_EXTDESC.TYPE_ID IS 'Код метода';
COMMENT ON COLUMN BARS.DPT_VIDD_EXTDESC.EXT_NUM IS 'Порядк.№ переоформления';
COMMENT ON COLUMN BARS.DPT_VIDD_EXTDESC.TERM_MNTH IS 'Срок действия ставки (мес.)';
COMMENT ON COLUMN BARS.DPT_VIDD_EXTDESC.TERM_DAYS IS 'Срок действия ставки (дней)';
COMMENT ON COLUMN BARS.DPT_VIDD_EXTDESC.INDV_RATE IS 'Значение индивид.ставки';
COMMENT ON COLUMN BARS.DPT_VIDD_EXTDESC.OPER_ID IS 'Код арифмет.операции';
COMMENT ON COLUMN BARS.DPT_VIDD_EXTDESC.BASE_RATE IS 'Код базовой ставки';
COMMENT ON COLUMN BARS.DPT_VIDD_EXTDESC.METHOD_ID IS 'Метод расчета значения базовой ставки';




PROMPT *** Create  constraint PK_DPTVIDDEXTDESC ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_EXTDESC ADD CONSTRAINT PK_DPTVIDDEXTDESC PRIMARY KEY (TYPE_ID, EXT_NUM, TERM_MNTH, TERM_DAYS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDEXTDESC_EXTNUM ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_EXTDESC ADD CONSTRAINT CC_DPTVIDDEXTDESC_EXTNUM CHECK (ext_num > 0) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDEXTDESC_TERMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_EXTDESC ADD CONSTRAINT CC_DPTVIDDEXTDESC_TERMS CHECK (term_mnth >= 0 and term_days >= 0) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDEXTDESC_INDVRATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_EXTDESC ADD CONSTRAINT CC_DPTVIDDEXTDESC_INDVRATE CHECK (nvl(indv_rate, 0) >= 0 and nvl(indv_rate, 1) <= 100) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDEXTDESC_BASERATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_EXTDESC ADD CONSTRAINT CC_DPTVIDDEXTDESC_BASERATE CHECK (base_rate is null or (base_rate is not null and method_id is not null)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDEXTDESC_RATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_EXTDESC ADD CONSTRAINT CC_DPTVIDDEXTDESC_RATES CHECK ( (nvl2(indv_rate, 1, 0) + nvl2(base_rate, 1, 0) = 1 and oper_id is null)
                              or
                             (base_rate is not null and indv_rate is not null and oper_id is not null)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDEXTDESC_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_EXTDESC MODIFY (TYPE_ID CONSTRAINT CC_DPTVIDDEXTDESC_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDEXTDESC_EXTNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_EXTDESC MODIFY (EXT_NUM CONSTRAINT CC_DPTVIDDEXTDESC_EXTNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDEXTDESC_TERMMNTH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_EXTDESC MODIFY (TERM_MNTH CONSTRAINT CC_DPTVIDDEXTDESC_TERMMNTH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDEXTDESC_TERMDAYS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_EXTDESC MODIFY (TERM_DAYS CONSTRAINT CC_DPTVIDDEXTDESC_TERMDAYS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTVIDDEXTDESC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTVIDDEXTDESC ON BARS.DPT_VIDD_EXTDESC (TYPE_ID, EXT_NUM, TERM_MNTH, TERM_DAYS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_VIDD_EXTDESC ***
grant SELECT                                                                 on DPT_VIDD_EXTDESC to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_EXTDESC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_VIDD_EXTDESC to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_EXTDESC to DPT_ADMIN;
grant SELECT                                                                 on DPT_VIDD_EXTDESC to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_EXTDESC to VKLAD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_EXTDESC to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_VIDD_EXTDESC to WR_REFREAD;



PROMPT *** Create SYNONYM  to DPT_VIDD_EXTDESC ***

  CREATE OR REPLACE PUBLIC SYNONYM DPT_VIDD_EXTDESC FOR BARS.DPT_VIDD_EXTDESC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_EXTDESC.sql =========*** End 
PROMPT ===================================================================================== 
