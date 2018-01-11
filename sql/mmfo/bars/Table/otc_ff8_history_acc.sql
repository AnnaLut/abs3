

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTC_FF8_HISTORY_ACC.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTC_FF8_HISTORY_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTC_FF8_HISTORY_ACC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTC_FF8_HISTORY_ACC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OTC_FF8_HISTORY_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTC_FF8_HISTORY_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTC_FF8_HISTORY_ACC 
   (	DATF DATE, 
	ACC NUMBER, 
	ACCC NUMBER(*,0), 
	NBS VARCHAR2(4), 
	SGN VARCHAR2(1), 
	NLS VARCHAR2(15), 
	KV NUMBER(*,0), 
	KV_DOG NUMBER(*,0), 
	NMS VARCHAR2(70), 
	DAOS DATE, 
	DAZS DATE, 
	OST NUMBER, 
	OSTQ NUMBER, 
	DOSQ NUMBER, 
	KOSQ NUMBER, 
	ND NUMBER, 
	NKD VARCHAR2(100), 
	SDATE DATE, 
	WDATE DATE, 
	SOS NUMBER(*,0), 
	RNK NUMBER, 
	STAFF NUMBER, 
	TOBO VARCHAR2(30), 
	S260 VARCHAR2(2), 
	K110 VARCHAR2(5), 
	K111 VARCHAR2(5), 
	S031 VARCHAR2(2), 
	S032 VARCHAR2(2), 
	S080 VARCHAR2(1), 
	S270 VARCHAR2(2), 
	CC VARCHAR2(3), 
	TIP CHAR(3), 
	S370 VARCHAR2(1), 
	SUM_R013_1 NUMBER, 
	R013 VARCHAR2(1), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTC_FF8_HISTORY_ACC ***
 exec bpa.alter_policies('OTC_FF8_HISTORY_ACC');


COMMENT ON TABLE BARS.OTC_FF8_HISTORY_ACC IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.KF IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.DATF IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.ACC IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.ACCC IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.NBS IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.SGN IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.NLS IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.KV IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.KV_DOG IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.NMS IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.DAOS IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.DAZS IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.OST IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.OSTQ IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.DOSQ IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.KOSQ IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.ND IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.NKD IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.SDATE IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.WDATE IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.SOS IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.RNK IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.STAFF IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.TOBO IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.S260 IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.K110 IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.K111 IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.S031 IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.S032 IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.S080 IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.S270 IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.CC IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.TIP IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.S370 IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.SUM_R013_1 IS '';
COMMENT ON COLUMN BARS.OTC_FF8_HISTORY_ACC.R013 IS '';




PROMPT *** Create  constraint OTC_FF8_HISTORY_ACC_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_FF8_HISTORY_ACC ADD CONSTRAINT OTC_FF8_HISTORY_ACC_PK PRIMARY KEY (DATF, ND, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCFF8HISTORYACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_FF8_HISTORY_ACC MODIFY (KF CONSTRAINT CC_OTCFF8HISTORYACC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006417 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_FF8_HISTORY_ACC MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006418 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_FF8_HISTORY_ACC MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index OTC_FF8_HISTORY_ACC_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.OTC_FF8_HISTORY_ACC_PK ON BARS.OTC_FF8_HISTORY_ACC (DATF, ND, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index OTC_FF8_HISTORY_ACC_I1 ***
begin   
 execute immediate '
  CREATE INDEX BARS.OTC_FF8_HISTORY_ACC_I1 ON BARS.OTC_FF8_HISTORY_ACC (KF, DATF, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index OTC_FF8_HISTORY_ACC_I2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.OTC_FF8_HISTORY_ACC_I2 ON BARS.OTC_FF8_HISTORY_ACC (KF, DATF, ND, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTC_FF8_HISTORY_ACC ***
grant SELECT                                                                 on OTC_FF8_HISTORY_ACC to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTC_FF8_HISTORY_ACC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTC_FF8_HISTORY_ACC to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTC_FF8_HISTORY_ACC to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTC_FF8_HISTORY_ACC to RPBN002;
grant SELECT                                                                 on OTC_FF8_HISTORY_ACC to UPLD;
grant FLASHBACK,SELECT                                                       on OTC_FF8_HISTORY_ACC to WR_REFREAD;



PROMPT *** Create SYNONYM  to OTC_FF8_HISTORY_ACC ***

  CREATE OR REPLACE SYNONYM BARS.S_OTC_FF8_HISTORY_ACC FOR BARS.OTC_FF8_HISTORY_ACC;


PROMPT *** Create SYNONYM  to OTC_FF8_HISTORY_ACC ***

  CREATE OR REPLACE PUBLIC SYNONYM OTC_FF8_HISTORY_ACC FOR BARS.OTC_FF8_HISTORY_ACC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTC_FF8_HISTORY_ACC.sql =========*** E
PROMPT ===================================================================================== 
