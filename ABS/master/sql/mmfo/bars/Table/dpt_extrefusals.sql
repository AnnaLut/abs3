

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_EXTREFUSALS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_EXTREFUSALS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_EXTREFUSALS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_EXTREFUSALS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_EXTREFUSALS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_EXTREFUSALS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_EXTREFUSALS 
   (	DPTID NUMBER(38,0), 
	BRANCH VARCHAR2(30), 
	REQ_USERID NUMBER(38,0), 
	REQ_BNKDAT DATE, 
	REQ_SYSDAT DATE, 
	REQ_MACHINE VARCHAR2(254), 
	REQ_STATE NUMBER(1,0), 
	VRF_USERID NUMBER(38,0), 
	VRF_BNKDAT DATE, 
	VRF_SYSDAT DATE, 
	VRF_MACHINE VARCHAR2(254), 
	VRF_REASON VARCHAR2(100), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_EXTREFUSALS ***
 exec bpa.alter_policies('DPT_EXTREFUSALS');


COMMENT ON TABLE BARS.DPT_EXTREFUSALS IS 'Вклады, владельцы которых отказались от переоформления';
COMMENT ON COLUMN BARS.DPT_EXTREFUSALS.DPTID IS 'Идентификатор вклада';
COMMENT ON COLUMN BARS.DPT_EXTREFUSALS.BRANCH IS 'Подразделение';
COMMENT ON COLUMN BARS.DPT_EXTREFUSALS.REQ_USERID IS 'Исполнитель-фиксатор запроса на отказ';
COMMENT ON COLUMN BARS.DPT_EXTREFUSALS.REQ_BNKDAT IS 'Банк.дата фиксации запроса на отказ';
COMMENT ON COLUMN BARS.DPT_EXTREFUSALS.REQ_SYSDAT IS 'Календ.дата фиксации запроса на отказ';
COMMENT ON COLUMN BARS.DPT_EXTREFUSALS.REQ_MACHINE IS 'Раб.станция фиксатора';
COMMENT ON COLUMN BARS.DPT_EXTREFUSALS.REQ_STATE IS 'Статус запроса на отказ';
COMMENT ON COLUMN BARS.DPT_EXTREFUSALS.VRF_USERID IS 'Исполнитель-верификатор запроса на отказ';
COMMENT ON COLUMN BARS.DPT_EXTREFUSALS.VRF_BNKDAT IS 'Банк.дата верификации запроса на отказ';
COMMENT ON COLUMN BARS.DPT_EXTREFUSALS.VRF_SYSDAT IS 'Календ.дата верификации запроса на отказ';
COMMENT ON COLUMN BARS.DPT_EXTREFUSALS.VRF_MACHINE IS 'Раб.станция верификатора';
COMMENT ON COLUMN BARS.DPT_EXTREFUSALS.VRF_REASON IS 'Причина сторнирования запроса на отказ';
COMMENT ON COLUMN BARS.DPT_EXTREFUSALS.KF IS '';




PROMPT *** Create  constraint CC_DPTEXTREFUSALS_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTREFUSALS MODIFY (DPTID CONSTRAINT CC_DPTEXTREFUSALS_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXTREFUSALS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTREFUSALS MODIFY (BRANCH CONSTRAINT CC_DPTEXTREFUSALS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXTREFUSALS_REQUSERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTREFUSALS MODIFY (REQ_USERID CONSTRAINT CC_DPTEXTREFUSALS_REQUSERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXTREFUSALS_REQBNKDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTREFUSALS MODIFY (REQ_BNKDAT CONSTRAINT CC_DPTEXTREFUSALS_REQBNKDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXTREFUSALS_REQSYSDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTREFUSALS MODIFY (REQ_SYSDAT CONSTRAINT CC_DPTEXTREFUSALS_REQSYSDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPT_EXTREFUSALS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTREFUSALS MODIFY (KF CONSTRAINT CC_DPT_EXTREFUSALS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTEXTREFUSALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTREFUSALS ADD CONSTRAINT PK_DPTEXTREFUSALS PRIMARY KEY (DPTID, REQ_SYSDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXTREFUSALS_REQSTATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTREFUSALS ADD CONSTRAINT CC_DPTEXTREFUSALS_REQSTATE CHECK (req_state in (1,-1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTEXTREFUSALS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTEXTREFUSALS ON BARS.DPT_EXTREFUSALS (DPTID, REQ_SYSDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_DPT_EXTREFUSALS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_DPT_EXTREFUSALS ON BARS.DPT_EXTREFUSALS (REQ_BNKDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTEXTREFUSALS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTEXTREFUSALS ON BARS.DPT_EXTREFUSALS (DPTID, DECODE(REQ_STATE,(-1),REQ_SYSDAT,NULL)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_EXTREFUSALS ***
grant SELECT                                                                 on DPT_EXTREFUSALS to BARSREADER_ROLE;
grant SELECT                                                                 on DPT_EXTREFUSALS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_EXTREFUSALS to BARS_DM;
grant SELECT                                                                 on DPT_EXTREFUSALS to RPBN001;
grant SELECT                                                                 on DPT_EXTREFUSALS to UPLD;



PROMPT *** Create SYNONYM  to DPT_EXTREFUSALS ***

  CREATE OR REPLACE PUBLIC SYNONYM DPT_EXTREFUSALS FOR BARS.DPT_EXTREFUSALS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_EXTREFUSALS.sql =========*** End *
PROMPT ===================================================================================== 
