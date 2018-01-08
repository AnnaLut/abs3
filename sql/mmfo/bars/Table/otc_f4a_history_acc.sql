

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTC_F4A_HISTORY_ACC.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTC_F4A_HISTORY_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTC_F4A_HISTORY_ACC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTC_F4A_HISTORY_ACC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTC_F4A_HISTORY_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTC_F4A_HISTORY_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTC_F4A_HISTORY_ACC 
   (	DATF DATE, 
	ACC NUMBER, 
	ISP NUMBER(*,0), 
	NBS VARCHAR2(4), 
	SGN VARCHAR2(1), 
	NLS VARCHAR2(15), 
	KV NUMBER(*,0), 
	NMS VARCHAR2(70), 
	DAOS DATE, 
	DAZS DATE, 
	OST NUMBER, 
	OSTQ NUMBER, 
	DOSQ NUMBER, 
	KOSQ NUMBER, 
	ND VARCHAR2(100), 
	NKD VARCHAR2(100), 
	SDATE DATE, 
	WDATE DATE, 
	SOS NUMBER(*,0), 
	RNK NUMBER, 
	PRINSIDER NUMBER, 
	STAFF NUMBER, 
	TOBO VARCHAR2(30), 
	S080 VARCHAR2(2), 
	R011 VARCHAR2(1), 
	CC VARCHAR2(2), 
	TIP CHAR(3), 
	CC_ID VARCHAR2(100), 
	S280 VARCHAR2(3), 
	S290 VARCHAR2(3), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTC_F4A_HISTORY_ACC ***
 exec bpa.alter_policies('OTC_F4A_HISTORY_ACC');


COMMENT ON TABLE BARS.OTC_F4A_HISTORY_ACC IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.DATF IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.ACC IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.ISP IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.NBS IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.SGN IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.NLS IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.KV IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.NMS IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.DAOS IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.DAZS IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.OST IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.OSTQ IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.DOSQ IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.KOSQ IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.ND IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.NKD IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.SDATE IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.WDATE IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.SOS IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.RNK IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.PRINSIDER IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.STAFF IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.TOBO IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.S080 IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.R011 IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.CC IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.TIP IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.CC_ID IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.S280 IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.S290 IS '';
COMMENT ON COLUMN BARS.OTC_F4A_HISTORY_ACC.KF IS '';




PROMPT *** Create  constraint CC_OTCF4AHISTORYACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_F4A_HISTORY_ACC MODIFY (KF CONSTRAINT CC_OTCF4AHISTORYACC_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008334 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_F4A_HISTORY_ACC MODIFY (DATF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008335 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_F4A_HISTORY_ACC MODIFY (ACC NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008336 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_F4A_HISTORY_ACC MODIFY (NLS NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008337 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_F4A_HISTORY_ACC MODIFY (KV NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint OTC_F4A_HISTORY_ACC_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_F4A_HISTORY_ACC ADD CONSTRAINT OTC_F4A_HISTORY_ACC_PK PRIMARY KEY (DATF, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_OTC_F4A_HISTORY_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_OTC_F4A_HISTORY_ACC ON BARS.OTC_F4A_HISTORY_ACC (DATF, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index OTC_F4A_HISTORY_ACC_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.OTC_F4A_HISTORY_ACC_PK ON BARS.OTC_F4A_HISTORY_ACC (DATF, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTC_F4A_HISTORY_ACC ***
grant SELECT                                                                 on OTC_F4A_HISTORY_ACC to BARSREADER_ROLE;
grant SELECT                                                                 on OTC_F4A_HISTORY_ACC to BARS_DM;
grant SELECT                                                                 on OTC_F4A_HISTORY_ACC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTC_F4A_HISTORY_ACC.sql =========*** E
PROMPT ===================================================================================== 
