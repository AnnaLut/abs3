

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VIP_FLAGS_ARC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VIP_FLAGS_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VIP_FLAGS_ARC'', ''FILIAL'', null, null, null, null);
               bpa.alter_policy_info(''VIP_FLAGS_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VIP_FLAGS_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.VIP_FLAGS_ARC 
   (	MFO VARCHAR2(6), 
	RNK VARCHAR2(20), 
	VIP VARCHAR2(10), 
	KVIP VARCHAR2(10), 
	DATBEG DATE, 
	DATEND DATE, 
	COMMENTS VARCHAR2(500), 
	CM_FLAG NUMBER(1,0), 
	CM_TRY NUMBER(10,0), 
	FIO_MANAGER VARCHAR2(250), 
	PHONE_MANAGER VARCHAR2(30), 
	MAIL_MANAGER VARCHAR2(100), 
	ACCOUNT_MANAGER NUMBER(10,0), 
	IDUPD NUMBER(38,0), 
	FDAT DATE DEFAULT sysdate, 
	IDU NUMBER(38,0), 
	VID CHAR(1), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	EFFECTDATE DATE, 
	GLOBAL_BDATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VIP_FLAGS_ARC ***
 exec bpa.alter_policies('VIP_FLAGS_ARC');


COMMENT ON TABLE BARS.VIP_FLAGS_ARC IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.MFO IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.RNK IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.VIP IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.KVIP IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.DATBEG IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.DATEND IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.COMMENTS IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.CM_FLAG IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.CM_TRY IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.FIO_MANAGER IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.PHONE_MANAGER IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.MAIL_MANAGER IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.ACCOUNT_MANAGER IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.IDUPD IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.FDAT IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.IDU IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.VID IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.KF IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.VIP_FLAGS_ARC.GLOBAL_BDATE IS '';




PROMPT *** Create  constraint CC_VIPFLAGSARC_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_FLAGS_ARC MODIFY (IDUPD CONSTRAINT CC_VIPFLAGSARC_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VIPFLAGSARC_IDU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_FLAGS_ARC MODIFY (IDU CONSTRAINT CC_VIPFLAGSARC_IDU_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VIPFLAGSARC_VID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_FLAGS_ARC MODIFY (VID CONSTRAINT CC_VIPFLAGSARC_VID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VIPFLAGSARC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_FLAGS_ARC MODIFY (KF CONSTRAINT CC_VIPFLAGSARC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VIPFLAGSARC_GLBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_FLAGS_ARC MODIFY (GLOBAL_BDATE CONSTRAINT CC_VIPFLAGSARC_GLBD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint PK_VIPFLAGSARC_IDUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_FLAGS_ARC ADD CONSTRAINT PK_VIPFLAGSARC_IDUPD PRIMARY KEY (IDUPD)
  USING INDEX COMPUTE STATISTICS TABLESPACE BRSMDLI  ENABLE VALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index IDX_VIPFLAGSARC_MFO_GL_EF ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_VIPFLAGSARC_MFO_GL_EF ON BARS.VIP_FLAGS_ARC (MFO, GLOBAL_BDATE, EFFECTDATE)
  COMPUTE STATISTICS TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index IDX_VIPFLAGSARC_MFO_RNK  ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_VIPFLAGSARC_MFO_RNK ON BARS.VIP_FLAGS_ARC (MFO, RNK)
  COMPUTE STATISTICS TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VIP_FLAGS_ARC ***
grant SELECT                                                                 on VIP_FLAGS_ARC   to BARSREADER_ROLE;
grant SELECT                                                                 on VIP_FLAGS_ARC   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VIP_FLAGS_ARC.sql =========*** End ***
PROMPT ===================================================================================== 
