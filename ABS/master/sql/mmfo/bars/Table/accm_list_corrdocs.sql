

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCM_LIST_CORRDOCS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCM_LIST_CORRDOCS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCM_LIST_CORRDOCS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_LIST_CORRDOCS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_LIST_CORRDOCS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCM_LIST_CORRDOCS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCM_LIST_CORRDOCS 
   (	CALDT_ID NUMBER(38,0), 
	CORDT_ID NUMBER(38,0), 
	COR_TYPE NUMBER(1,0), 
	ACC NUMBER(38,0), 
	DOS NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOS NUMBER(24,0), 
	KOSQ NUMBER(24,0), 
	REF NUMBER(38,0)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSACCM 
  PARTITION BY RANGE (CORDT_ID) INTERVAL (1) 
 (PARTITION P0  VALUES LESS THAN (1) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSACCM ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCM_LIST_CORRDOCS ***
 exec bpa.alter_policies('ACCM_LIST_CORRDOCS');


COMMENT ON TABLE BARS.ACCM_LIST_CORRDOCS IS 'Подсистема накопления. Список корректирующих документов';
COMMENT ON COLUMN BARS.ACCM_LIST_CORRDOCS.CALDT_ID IS 'Ид. даты выполнения проводки';
COMMENT ON COLUMN BARS.ACCM_LIST_CORRDOCS.CORDT_ID IS 'Ид. даты корректировки';
COMMENT ON COLUMN BARS.ACCM_LIST_CORRDOCS.COR_TYPE IS 'Тип корректирующей проводки';
COMMENT ON COLUMN BARS.ACCM_LIST_CORRDOCS.ACC IS 'Ид. счета';
COMMENT ON COLUMN BARS.ACCM_LIST_CORRDOCS.DOS IS 'Сумма дебетовых оборотов (номинал)';
COMMENT ON COLUMN BARS.ACCM_LIST_CORRDOCS.DOSQ IS 'Сумма дебетовых оборотов (эквивалент)';
COMMENT ON COLUMN BARS.ACCM_LIST_CORRDOCS.KOS IS 'Сумма кредитовых оборотов (номинал)';
COMMENT ON COLUMN BARS.ACCM_LIST_CORRDOCS.KOSQ IS 'Сумма кредитовых оборотов (эквивалент)';
COMMENT ON COLUMN BARS.ACCM_LIST_CORRDOCS.REF IS 'Реф. документа';




PROMPT *** Create  constraint PK_ACCMLISTCRDOCS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_LIST_CORRDOCS ADD CONSTRAINT PK_ACCMLISTCRDOCS PRIMARY KEY (REF, CALDT_ID, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSACCM  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMLISTCRDOCS_CORTP ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_LIST_CORRDOCS ADD CONSTRAINT CC_ACCMLISTCRDOCS_CORTP CHECK (cor_type in (1, 2, 3, 4)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMLISTCRDOCS_CALDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_LIST_CORRDOCS MODIFY (CALDT_ID CONSTRAINT CC_ACCMLISTCRDOCS_CALDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMLISTCRDOCS_CORDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_LIST_CORRDOCS MODIFY (CORDT_ID CONSTRAINT CC_ACCMLISTCRDOCS_CORDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMLISTCRDOCS_CORTP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_LIST_CORRDOCS MODIFY (COR_TYPE CONSTRAINT CC_ACCMLISTCRDOCS_CORTP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMLISTCRDOCS_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_LIST_CORRDOCS MODIFY (ACC CONSTRAINT CC_ACCMLISTCRDOCS_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMLISTCRDOCS_DOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_LIST_CORRDOCS MODIFY (DOS CONSTRAINT CC_ACCMLISTCRDOCS_DOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMLISTCRDOCS_DOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_LIST_CORRDOCS MODIFY (DOSQ CONSTRAINT CC_ACCMLISTCRDOCS_DOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMLISTCRDOCS_KOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_LIST_CORRDOCS MODIFY (KOS CONSTRAINT CC_ACCMLISTCRDOCS_KOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMLISTCRDOCS_KOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_LIST_CORRDOCS MODIFY (KOSQ CONSTRAINT CC_ACCMLISTCRDOCS_KOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMLISTCRDOCS_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_LIST_CORRDOCS MODIFY (REF CONSTRAINT CC_ACCMLISTCRDOCS_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_ACCMLISTCRDOCS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_ACCMLISTCRDOCS ON BARS.ACCM_LIST_CORRDOCS (CALDT_ID, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSACCM ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_ACCMLISTCRDOCS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_ACCMLISTCRDOCS ON BARS.ACCM_LIST_CORRDOCS (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSACCM ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCMLISTCRDOCS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCMLISTCRDOCS ON BARS.ACCM_LIST_CORRDOCS (REF, CALDT_ID, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSACCM ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCM_LIST_CORRDOCS ***
grant SELECT                                                                 on ACCM_LIST_CORRDOCS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCM_LIST_CORRDOCS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCM_LIST_CORRDOCS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCM_LIST_CORRDOCS to START1;
grant SELECT                                                                 on ACCM_LIST_CORRDOCS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCM_LIST_CORRDOCS.sql =========*** En
PROMPT ===================================================================================== 
