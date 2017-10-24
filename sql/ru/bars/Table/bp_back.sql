

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BP_BACK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BP_BACK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BP_BACK'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BP_BACK'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BP_BACK ***
begin 
  execute immediate '
  CREATE TABLE BARS.BP_BACK 
   (	REC_IN NUMBER(38,0), 
	REC_OUT NUMBER(38,0), 
	ID NUMBER(38,0), 
	USERID NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BP_BACK ***
 exec bpa.alter_policies('BP_BACK');


COMMENT ON TABLE BARS.BP_BACK IS '���������, ������������ �����������';
COMMENT ON COLUMN BARS.BP_BACK.REC_IN IS '���� ������';
COMMENT ON COLUMN BARS.BP_BACK.REC_OUT IS '�������. ������';
COMMENT ON COLUMN BARS.BP_BACK.ID IS 'ID';
COMMENT ON COLUMN BARS.BP_BACK.USERID IS 'ID ������������';
COMMENT ON COLUMN BARS.BP_BACK.KF IS '';




PROMPT *** Create  constraint FK_BPBACK_ARCRRP3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_BACK ADD CONSTRAINT FK_BPBACK_ARCRRP3 FOREIGN KEY (KF, REC_IN)
	  REFERENCES BARS.ARC_RRP (KF, REC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPBACK_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_BACK ADD CONSTRAINT FK_BPBACK_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPBACK_BPREASON ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_BACK ADD CONSTRAINT FK_BPBACK_BPREASON FOREIGN KEY (ID)
	  REFERENCES BARS.BP_REASON (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPBACK_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_BACK ADD CONSTRAINT FK_BPBACK_STAFF FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPBACK_ARCRRP4 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_BACK ADD CONSTRAINT FK_BPBACK_ARCRRP4 FOREIGN KEY (KF, REC_OUT)
	  REFERENCES BARS.ARC_RRP (KF, REC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BPBACK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_BACK ADD CONSTRAINT PK_BPBACK PRIMARY KEY (REC_IN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPBACK_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_BACK MODIFY (KF CONSTRAINT CC_BPBACK_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009350 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_BACK MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPBACK_RECOUT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_BACK MODIFY (REC_OUT CONSTRAINT CC_BPBACK_RECOUT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009348 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_BACK MODIFY (REC_IN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPBACK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPBACK ON BARS.BP_BACK (REC_IN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BP_BACK ***
grant INSERT                                                                 on BP_BACK         to BARS014;
grant INSERT,SELECT                                                          on BP_BACK         to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on BP_BACK         to CHCK002;
grant INSERT                                                                 on BP_BACK         to PYOD001;
grant SELECT                                                                 on BP_BACK         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BP_BACK         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BP_BACK.sql =========*** End *** =====
PROMPT ===================================================================================== 
