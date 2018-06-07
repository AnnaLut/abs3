

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMERW_UPDATE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMERW_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMERW_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CUSTOMERW_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CUSTOMERW_UPDATE'', ''WHOLE'' , null, null, ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMERW_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMERW_UPDATE 
   (	RNK NUMBER, 
	TAG VARCHAR2(5), 
	VALUE VARCHAR2(500), 
	ISP NUMBER, 
	CHGDATE DATE, 
	CHGACTION NUMBER, 
	DONEBY VARCHAR2(64), 
	IDUPD NUMBER, 
	EFFECTDATE DATE, 
	KF VARCHAR2(6) DEFAULT NULL
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMERW_UPDATE ***
 exec bpa.alter_policies('CUSTOMERW_UPDATE');


COMMENT ON TABLE BARS.CUSTOMERW_UPDATE IS 'История изменения доп. реквизитов клиентов';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.RNK IS 'РНК клиента';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.TAG IS 'Доп. реквизит';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.VALUE IS 'Значение доп. реквизита';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.ISP IS '№ отдела';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.CHGDATE IS 'Дата изменения';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.CHGACTION IS 'Тип изменения';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.DONEBY IS 'Кто изменил';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.IDUPD IS 'Id';
COMMENT ON COLUMN BARS.CUSTOMERW_UPDATE.EFFECTDATE IS 'Банковская датат изменений';




PROMPT *** Create  constraint C_CUSTOMERWUPDATE_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE MODIFY (DONEBY CONSTRAINT C_CUSTOMERWUPDATE_DONEBY_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERWUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE ADD CONSTRAINT CC_CUSTOMERWUPDATE_KF_NN CHECK (KF IS NOT NULL) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUSTOMERWUPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE ADD CONSTRAINT PK_CUSTOMERWUPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERWUPDATE_CHGACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE ADD CONSTRAINT CC_CUSTOMERWUPDATE_CHGACTION CHECK (chgaction in (1,2,3)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERWUPDATE_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE ADD CONSTRAINT FK_CUSTOMERWUPDATE_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_CUSTOMERWUPDATE_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE MODIFY (IDUPD CONSTRAINT C_CUSTOMERWUPDATE_IDUPD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_CUSTOMERWUPDATE_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE MODIFY (TAG CONSTRAINT C_CUSTOMERWUPDATE_TAG_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_CUSTOMERWUPDATE_ISP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE MODIFY (ISP CONSTRAINT C_CUSTOMERWUPDATE_ISP_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_CUSTOMERWUPDATE_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE MODIFY (CHGDATE CONSTRAINT C_CUSTOMERWUPDATE_CHGDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_CUSTOMERWUPDATE_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE MODIFY (CHGACTION CONSTRAINT C_CUSTOMERWUPDATE_CHGACTION_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint C_CUSTOMERWUPDATE_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE MODIFY (RNK CONSTRAINT C_CUSTOMERWUPDATE_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CUSTOMERWUPD_TAG_VALUE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CUSTOMERWUPD_TAG_VALUE ON BARS.CUSTOMERW_UPDATE (TAG, VALUE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CUSTOMERWUPD_EFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CUSTOMERWUPD_EFFDAT ON BARS.CUSTOMERW_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CUSTOMERWUPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_CUSTOMERWUPD ON BARS.CUSTOMERW_UPDATE (RNK, TAG, ISP, CHGDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERWUPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMERWUPDATE ON BARS.CUSTOMERW_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

prompt CREATE UQ INDEX CUSTOMERW_UPDATE : I_KF_IDUPD_RNK_CUSTWSUPD (KF, IDUPD, RNK)
begin
    execute immediate q'[
create unique index I_KF_IDUPD_RNK_CUSTWSUPD on customerw_update (kf, idupd, rnk) 
GLOBAL PARTITION BY RANGE (KF)
( PARTITION CUSTWUPD_MIN values less than ('300465')
, PARTITION CUSTWUPD_300465 values less than ('302076')
, PARTITION CUSTWUPD_302076 values less than ('303398')
, PARTITION CUSTWUPD_303398 values less than ('304665')
, PARTITION CUSTWUPD_304665 values less than ('305482')
, PARTITION CUSTWUPD_305482 values less than ('311647')
, PARTITION CUSTWUPD_311647 values less than ('312356')
, PARTITION CUSTWUPD_312356 values less than ('313957')
, PARTITION CUSTWUPD_313957 values less than ('315784')
, PARTITION CUSTWUPD_315784 values less than ('322669')
, PARTITION CUSTWUPD_322669 values less than ('323475')
, PARTITION CUSTWUPD_323475 values less than ('324805')
, PARTITION CUSTWUPD_324805 values less than ('325796')
, PARTITION CUSTWUPD_325796 values less than ('326461')
, PARTITION CUSTWUPD_326461 values less than ('328845')
, PARTITION CUSTWUPD_328845 values less than ('331467')
, PARTITION CUSTWUPD_331467 values less than ('333368')
, PARTITION CUSTWUPD_333368 values less than ('335106')
, PARTITION CUSTWUPD_335106 values less than ('336503')
, PARTITION CUSTWUPD_336503 values less than ('337568')
, PARTITION CUSTWUPD_337568 values less than ('338545')
, PARTITION CUSTWUPD_338545 values less than ('351823')
, PARTITION CUSTWUPD_351823 values less than ('352457')
, PARTITION CUSTWUPD_352457 values less than ('353553')
, PARTITION CUSTWUPD_353553 values less than ('354507')
, PARTITION CUSTWUPD_354507 values less than ('356334')
, PARTITION CUSTWUPD_356334 values less than (maxvalue)
)
tablespace brsbigi compress 1
online]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/


PROMPT *** Create  grants  CUSTOMERW_UPDATE ***
grant SELECT                                                                 on CUSTOMERW_UPDATE to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMERW_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMERW_UPDATE to BARS_DM;
grant SELECT                                                                 on CUSTOMERW_UPDATE to CC_DOC;
grant INSERT,SELECT                                                          on CUSTOMERW_UPDATE to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMERW_UPDATE to CUSTOMERW;
grant SELECT                                                                 on CUSTOMERW_UPDATE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMERW_UPDATE to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CUSTOMERW_UPDATE to WR_REFREAD;



PROMPT *** Create SYNONYM  to CUSTOMERW_UPDATE ***

  CREATE OR REPLACE PUBLIC SYNONYM CUSTOMERW_UPDATE FOR BARS.CUSTOMERW_UPDATE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMERW_UPDATE.sql =========*** End 
PROMPT ===================================================================================== 
