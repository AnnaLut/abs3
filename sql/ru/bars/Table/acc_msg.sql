

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_MSG.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_MSG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_MSG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_MSG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_MSG ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_MSG 
   (	MSG_ID NUMBER(*,0), 
	CHANGE_TIME DATE DEFAULT sysdate, 
	RNK NUMBER(*,0), 
	ACC NUMBER(*,0), 
	OSTC NUMBER, 
	DOS_DELTA NUMBER DEFAULT 0, 
	KOS_DELTA NUMBER DEFAULT 0, 
	VIPISKA VARCHAR2(1) DEFAULT ''N''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_MSG ***
 exec bpa.alter_policies('ACC_MSG');


COMMENT ON TABLE BARS.ACC_MSG IS '';
COMMENT ON COLUMN BARS.ACC_MSG.VIPISKA IS '';
COMMENT ON COLUMN BARS.ACC_MSG.MSG_ID IS '';
COMMENT ON COLUMN BARS.ACC_MSG.CHANGE_TIME IS '';
COMMENT ON COLUMN BARS.ACC_MSG.RNK IS '';
COMMENT ON COLUMN BARS.ACC_MSG.ACC IS '';
COMMENT ON COLUMN BARS.ACC_MSG.OSTC IS '';
COMMENT ON COLUMN BARS.ACC_MSG.DOS_DELTA IS '';
COMMENT ON COLUMN BARS.ACC_MSG.KOS_DELTA IS '';




PROMPT *** Create  constraint FK_ACCMSG_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_MSG ADD CONSTRAINT FK_ACCMSG_ACCOUNTS FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCMSG_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_MSG ADD CONSTRAINT FK_ACCMSG_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCMSG_MSGSUBMIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_MSG ADD CONSTRAINT FK_ACCMSG_MSGSUBMIT FOREIGN KEY (MSG_ID)
	  REFERENCES BARS.MSG_SUBMIT_DATA (MSG_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSG_KOSD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_MSG MODIFY (KOS_DELTA CONSTRAINT CC_ACCMSG_KOSD_NN NOT NULL DISABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSG_DOSD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_MSG MODIFY (DOS_DELTA CONSTRAINT CC_ACCMSG_DOSD_NN NOT NULL DISABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCMSG ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_MSG ADD CONSTRAINT PK_ACCMSG PRIMARY KEY (MSG_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSG_OSTC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_MSG MODIFY (OSTC CONSTRAINT CC_ACCMSG_OSTC_NN NOT NULL DISABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSG_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_MSG MODIFY (ACC CONSTRAINT CC_ACCMSG_ACC_NN NOT NULL DISABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSG_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_MSG MODIFY (RNK CONSTRAINT CC_ACCMSG_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSG_CHTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_MSG MODIFY (CHANGE_TIME CONSTRAINT CC_ACCMSG_CHTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSG_MSGID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_MSG MODIFY (MSG_ID CONSTRAINT CC_ACCMSG_MSGID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCMSG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCMSG ON BARS.ACC_MSG (MSG_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_MSG ***
grant SELECT                                                                 on ACC_MSG         to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_MSG.sql =========*** End *** =====
PROMPT ===================================================================================== 
