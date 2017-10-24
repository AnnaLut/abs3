

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_REQ_DELDEALS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_REQ_DELDEALS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_REQ_DELDEALS'', ''FILIAL'' , ''B'', ''B'', ''B'', ''E'');
               bpa.alter_policy_info(''DPT_REQ_DELDEALS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_REQ_DELDEALS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_REQ_DELDEALS 
   (	REQ_ID NUMBER(38,0), 
	USER_ID NUMBER(38,0), 
	USER_BDATE DATE, 
	USER_DATE DATE, 
	USER_STATE NUMBER(1,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_REQ_DELDEALS ***
 exec bpa.alter_policies('DPT_REQ_DELDEALS');


COMMENT ON TABLE BARS.DPT_REQ_DELDEALS IS '���������� ��������. ������������� ������� �� �������� ��������';
COMMENT ON COLUMN BARS.DPT_REQ_DELDEALS.REQ_ID IS '������������� �������';
COMMENT ON COLUMN BARS.DPT_REQ_DELDEALS.USER_ID IS '������������� ������������';
COMMENT ON COLUMN BARS.DPT_REQ_DELDEALS.USER_BDATE IS '���������� ���� �������������/������';
COMMENT ON COLUMN BARS.DPT_REQ_DELDEALS.USER_DATE IS '���� � ����� �������������/������';
COMMENT ON COLUMN BARS.DPT_REQ_DELDEALS.USER_STATE IS '�������������/�����';
COMMENT ON COLUMN BARS.DPT_REQ_DELDEALS.KF IS '';
COMMENT ON COLUMN BARS.DPT_REQ_DELDEALS.BRANCH IS '';




PROMPT *** Create  constraint FK_DPTREQDELDEALS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_DELDEALS ADD CONSTRAINT FK_DPTREQDELDEALS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTREQDELDEALS_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_DELDEALS ADD CONSTRAINT FK_DPTREQDELDEALS_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTREQDELDEALS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_DELDEALS ADD CONSTRAINT FK_DPTREQDELDEALS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTREQDELDEALS_DPTREQS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_DELDEALS ADD CONSTRAINT FK_DPTREQDELDEALS_DPTREQS2 FOREIGN KEY (KF, REQ_ID)
	  REFERENCES BARS.DPT_REQUESTS (KF, REQ_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQDELDEALS_USERSTATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_DELDEALS ADD CONSTRAINT CC_DPTREQDELDEALS_USERSTATE CHECK (user_state in (-1, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTREQDELDEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_DELDEALS ADD CONSTRAINT PK_DPTREQDELDEALS PRIMARY KEY (REQ_ID, USER_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQDELDEALS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_DELDEALS MODIFY (BRANCH CONSTRAINT CC_DPTREQDELDEALS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQDELDEALS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_DELDEALS MODIFY (KF CONSTRAINT CC_DPTREQDELDEALS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQDELDEALS_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_DELDEALS MODIFY (USER_ID CONSTRAINT CC_DPTREQDELDEALS_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQDELDEALS_REQID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_DELDEALS MODIFY (REQ_ID CONSTRAINT CC_DPTREQDELDEALS_REQID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTREQDELDEALS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTREQDELDEALS ON BARS.DPT_REQ_DELDEALS (REQ_ID, USER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_REQ_DELDEALS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_REQ_DELDEALS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_REQ_DELDEALS.sql =========*** End 
PROMPT ===================================================================================== 
