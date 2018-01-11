

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CM_CREDITS_UPDATE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CM_CREDITS_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CM_CREDITS_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CM_CREDITS_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CM_CREDITS_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CM_CREDITS_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CM_CREDITS_UPDATE 
   (	ID NUMBER, 
	ND NUMBER, 
	BRANCH VARCHAR2(400), 
	KV NUMBER(3,0), 
	NLS VARCHAR2(400), 
	DCLASS VARCHAR2(2), 
	DVKR VARCHAR2(3), 
	DSUM NUMBER, 
	DDATE DATE, 
	CHANGE_DATE DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CM_CREDITS_UPDATE ***
 exec bpa.alter_policies('CM_CREDITS_UPDATE');


COMMENT ON TABLE BARS.CM_CREDITS_UPDATE IS '';
COMMENT ON COLUMN BARS.CM_CREDITS_UPDATE.ID IS '';
COMMENT ON COLUMN BARS.CM_CREDITS_UPDATE.ND IS '';
COMMENT ON COLUMN BARS.CM_CREDITS_UPDATE.BRANCH IS '';
COMMENT ON COLUMN BARS.CM_CREDITS_UPDATE.KV IS '';
COMMENT ON COLUMN BARS.CM_CREDITS_UPDATE.NLS IS '';
COMMENT ON COLUMN BARS.CM_CREDITS_UPDATE.DCLASS IS '';
COMMENT ON COLUMN BARS.CM_CREDITS_UPDATE.DVKR IS '';
COMMENT ON COLUMN BARS.CM_CREDITS_UPDATE.DSUM IS '';
COMMENT ON COLUMN BARS.CM_CREDITS_UPDATE.DDATE IS '';
COMMENT ON COLUMN BARS.CM_CREDITS_UPDATE.CHANGE_DATE IS '';
COMMENT ON COLUMN BARS.CM_CREDITS_UPDATE.KF IS '';




PROMPT *** Create  constraint PK_CM_CREDITS_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CREDITS_UPDATE ADD CONSTRAINT PK_CM_CREDITS_UPDATE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CMCREDITSUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CREDITS_UPDATE MODIFY (KF CONSTRAINT CC_CMCREDITSUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CM_CREDITS_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CM_CREDITS_UPDATE ON BARS.CM_CREDITS_UPDATE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CM_CREDITS_UPDATE ***
grant SELECT                                                                 on CM_CREDITS_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on CM_CREDITS_UPDATE to BARS_DM;
grant SELECT                                                                 on CM_CREDITS_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CM_CREDITS_UPDATE.sql =========*** End
PROMPT ===================================================================================== 
