

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_PAYMENTS_SCHEDULE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_PAYMENTS_SCHEDULE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_PAYMENTS_SCHEDULE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INS_PAYMENTS_SCHEDULE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_PAYMENTS_SCHEDULE ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_PAYMENTS_SCHEDULE 
   (	ID NUMBER, 
	DEAL_ID NUMBER, 
	PLAN_DATE DATE, 
	FACT_DATE DATE, 
	PLAN_SUM NUMBER, 
	FACT_SUM NUMBER, 
	PMT_NUM VARCHAR2(100), 
	PMT_COMM VARCHAR2(500), 
	PAYED NUMBER DEFAULT 0, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_PAYMENTS_SCHEDULE ***
 exec bpa.alter_policies('INS_PAYMENTS_SCHEDULE');


COMMENT ON TABLE BARS.INS_PAYMENTS_SCHEDULE IS 'Графік платежів по страховим договорам';
COMMENT ON COLUMN BARS.INS_PAYMENTS_SCHEDULE.KF IS '';
COMMENT ON COLUMN BARS.INS_PAYMENTS_SCHEDULE.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_PAYMENTS_SCHEDULE.DEAL_ID IS 'Ідентифікатор договору страхування';
COMMENT ON COLUMN BARS.INS_PAYMENTS_SCHEDULE.PLAN_DATE IS 'Планова дата платежу';
COMMENT ON COLUMN BARS.INS_PAYMENTS_SCHEDULE.FACT_DATE IS 'Фактична дата платежу';
COMMENT ON COLUMN BARS.INS_PAYMENTS_SCHEDULE.PLAN_SUM IS 'Планова сума платежу';
COMMENT ON COLUMN BARS.INS_PAYMENTS_SCHEDULE.FACT_SUM IS 'Фактична сума платежу';
COMMENT ON COLUMN BARS.INS_PAYMENTS_SCHEDULE.PMT_NUM IS 'Номер платіжки';
COMMENT ON COLUMN BARS.INS_PAYMENTS_SCHEDULE.PMT_COMM IS 'Коментар (МФО, тип і тп)';
COMMENT ON COLUMN BARS.INS_PAYMENTS_SCHEDULE.PAYED IS 'Платіж сплачено';




PROMPT *** Create  constraint PK_INSPMTSSDL ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PAYMENTS_SCHEDULE ADD CONSTRAINT PK_INSPMTSSDL PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_INSPAYMENTSSCHEDULE ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PAYMENTS_SCHEDULE ADD CONSTRAINT UK_INSPAYMENTSSCHEDULE UNIQUE (DEAL_ID, PLAN_DATE, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSPMTSSDL_DID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PAYMENTS_SCHEDULE MODIFY (DEAL_ID CONSTRAINT CC_INSPMTSSDL_DID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSPMTSSDL_PDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PAYMENTS_SCHEDULE MODIFY (PLAN_DATE CONSTRAINT CC_INSPMTSSDL_PDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSPMTSSDL_PSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PAYMENTS_SCHEDULE MODIFY (PLAN_SUM CONSTRAINT CC_INSPMTSSDL_PSUM_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSPMTSSDL_PAYED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PAYMENTS_SCHEDULE MODIFY (PAYED CONSTRAINT CC_INSPMTSSDL_PAYED_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSPSCH_PAYED ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PAYMENTS_SCHEDULE ADD CONSTRAINT CC_INSPSCH_PAYED CHECK (payed in (0, 1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_INSPAYMENTSSCHEDULE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_INSPAYMENTSSCHEDULE ON BARS.INS_PAYMENTS_SCHEDULE (DEAL_ID, PLAN_DATE, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSPMTSSDL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSPMTSSDL ON BARS.INS_PAYMENTS_SCHEDULE (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_PAYMENTS_SCHEDULE ***
grant SELECT                                                                 on INS_PAYMENTS_SCHEDULE to BARSREADER_ROLE;
grant SELECT                                                                 on INS_PAYMENTS_SCHEDULE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INS_PAYMENTS_SCHEDULE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_PAYMENTS_SCHEDULE.sql =========***
PROMPT ===================================================================================== 
