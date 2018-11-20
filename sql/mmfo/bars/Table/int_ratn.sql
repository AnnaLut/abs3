

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_RATN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_RATN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_RATN'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''INT_RATN'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INT_RATN'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_RATN ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_RATN 
   (	ACC NUMBER(38,0), 
	ID NUMBER, 
	BDAT DATE, 
	IR NUMBER, 
	BR NUMBER(38,0), 
	OP NUMBER(4,0), 
	IDU NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_RATN ***
 exec bpa.alter_policies('INT_RATN');


COMMENT ON TABLE BARS.INT_RATN IS 'История % ставки';
COMMENT ON COLUMN BARS.INT_RATN.ACC IS 'acc счета';
COMMENT ON COLUMN BARS.INT_RATN.ID IS 'идентификатор типа начисления %';
COMMENT ON COLUMN BARS.INT_RATN.BDAT IS 'Дата установки';
COMMENT ON COLUMN BARS.INT_RATN.IR IS 'индивидуальная % ставка';
COMMENT ON COLUMN BARS.INT_RATN.BR IS 'базовая % ставка';
COMMENT ON COLUMN BARS.INT_RATN.OP IS 'операция, между IR и BR';
COMMENT ON COLUMN BARS.INT_RATN.IDU IS 'aвтор % ставки';
COMMENT ON COLUMN BARS.INT_RATN.KF IS '';




PROMPT *** Create  constraint PK_INTRATN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN ADD CONSTRAINT PK_INTRATN PRIMARY KEY (ACC, ID, BDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATN_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN MODIFY (ACC CONSTRAINT CC_INTRATN_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATN_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN MODIFY (ID CONSTRAINT CC_INTRATN_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATN_BDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN MODIFY (BDAT CONSTRAINT CC_INTRATN_BDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATN_IDU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN MODIFY (IDU CONSTRAINT CC_INTRATN_IDU_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATN_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN MODIFY (KF CONSTRAINT CC_INTRATN_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_INTRATN ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_INTRATN ON BARS.INT_RATN (BDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INTRATN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INTRATN ON BARS.INT_RATN (ACC, ID, BDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_INTRATN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_INTRATN ON BARS.INT_RATN (KF, ACC, ID, BDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index IDX_INTRATN_BR ***
begin   
 execute immediate '
CREATE INDEX BARS.IDX_INTRATN_BR ON BARS.INT_RATN (KF, BR) 
GLOBAL PARTITION BY RANGE (KF)
( PARTITION IDX_INTRATN_BR_MIN    values less than (''300465'')
, PARTITION IDX_INTRATN_BR_300465 values less than (''302076'')
, PARTITION IDX_INTRATN_BR_302076 values less than (''303398'')
, PARTITION IDX_INTRATN_BR_303398 values less than (''304665'')
, PARTITION IDX_INTRATN_BR_304665 values less than (''305482'')
, PARTITION IDX_INTRATN_BR_305482 values less than (''311647'')
, PARTITION IDX_INTRATN_BR_311647 values less than (''312356'')
, PARTITION IDX_INTRATN_BR_312356 values less than (''313957'')
, PARTITION IDX_INTRATN_BR_313957 values less than (''315784'')
, PARTITION IDX_INTRATN_BR_315784 values less than (''322669'')
, PARTITION IDX_INTRATN_BR_322669 values less than (''323475'')
, PARTITION IDX_INTRATN_BR_323475 values less than (''324805'')
, PARTITION IDX_INTRATN_BR_324805 values less than (''325796'')
, PARTITION IDX_INTRATN_BR_325796 values less than (''326461'')
, PARTITION IDX_INTRATN_BR_326461 values less than (''328845'')
, PARTITION IDX_INTRATN_BR_328845 values less than (''331467'')
, PARTITION IDX_INTRATN_BR_331467 values less than (''333368'')
, PARTITION IDX_INTRATN_BR_333368 values less than (''335106'')
, PARTITION IDX_INTRATN_BR_335106 values less than (''336503'')
, PARTITION IDX_INTRATN_BR_336503 values less than (''337568'')
, PARTITION IDX_INTRATN_BR_337568 values less than (''338545'')
, PARTITION IDX_INTRATN_BR_338545 values less than (''351823'')
, PARTITION IDX_INTRATN_BR_351823 values less than (''352457'')
, PARTITION IDX_INTRATN_BR_352457 values less than (''353553'')
, PARTITION IDX_INTRATN_BR_353553 values less than (''354507'')
, PARTITION IDX_INTRATN_BR_354507 values less than (''356334'')
, PARTITION IDX_INTRATN_BR_356334 values less than (maxvalue)
) COMPUTE STATISTICS 
  TABLESPACE BRSBIGI
  COMPRESS 2';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  INT_RATN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_RATN        to ABS_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_RATN        to BARS009;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_RATN        to BARS010;
grant SELECT                                                                 on INT_RATN        to BARSREADER_ROLE;
grant SELECT                                                                 on INT_RATN        to BARSUPL;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_RATN        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_RATN        to BARS_DM;
grant SELECT                                                                 on INT_RATN        to CC_DOC;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_RATN        to CUST001;
grant SELECT,UPDATE                                                          on INT_RATN        to DPT;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_RATN        to FOREX;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_RATN        to RCC_DEAL;
grant SELECT                                                                 on INT_RATN        to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_RATN        to TECH005;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_RATN        to TECH006;
grant SELECT                                                                 on INT_RATN        to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_RATN        to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_RATN        to WR_ALL_RIGHTS;
grant INSERT,UPDATE                                                          on INT_RATN        to WR_DEPOSIT_U;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_RATN        to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_RATN.sql =========*** End *** ====
PROMPT ===================================================================================== 
