

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_ACT_BOUND.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_ACT_BOUND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_ACT_BOUND'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_ACT_BOUND'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_ACT_BOUND ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_ACT_BOUND 
   (	BOUND_ID NUMBER, 
	DIRECT NUMBER, 
	ACT_ID NUMBER, 
	CONTR_ID NUMBER, 
	S_VT NUMBER DEFAULT 0, 
	RATE_VK NUMBER(30,8), 
	S_VK NUMBER, 
	COMMENTS VARCHAR2(4000), 
	JOURNAL_NUM NUMBER, 
	JOURNAL_ID NUMBER, 
	CREATE_DATE DATE, 
	MODIFY_DATE DATE, 
	DELETE_DATE DATE, 
	UID_DEL_BOUND NUMBER, 
	UID_DEL_JOURNAL NUMBER, 
	BORG_REASON NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_ACT_BOUND ***
 exec bpa.alter_policies('CIM_ACT_BOUND');


COMMENT ON TABLE BARS.CIM_ACT_BOUND IS '����`���� ���� �� ��������� ��� �� ���������';
COMMENT ON COLUMN BARS.CIM_ACT_BOUND.BOUND_ID IS '������������� ��������';
COMMENT ON COLUMN BARS.CIM_ACT_BOUND.DIRECT IS '�������� (0 - �����, 1 - ������)';
COMMENT ON COLUMN BARS.CIM_ACT_BOUND.ACT_ID IS '������������� ����';
COMMENT ON COLUMN BARS.CIM_ACT_BOUND.CONTR_ID IS '������������� ���������';
COMMENT ON COLUMN BARS.CIM_ACT_BOUND.S_VT IS '���� ���`���� � ����� ������';
COMMENT ON COLUMN BARS.CIM_ACT_BOUND.RATE_VK IS '���� ������ ������ ������� ������ ��������� S��/S��';
COMMENT ON COLUMN BARS.CIM_ACT_BOUND.S_VK IS '���� ���`���� � ����� ���������';
COMMENT ON COLUMN BARS.CIM_ACT_BOUND.COMMENTS IS '��������';
COMMENT ON COLUMN BARS.CIM_ACT_BOUND.JOURNAL_NUM IS '����� �������';
COMMENT ON COLUMN BARS.CIM_ACT_BOUND.JOURNAL_ID IS '����� � ������';
COMMENT ON COLUMN BARS.CIM_ACT_BOUND.CREATE_DATE IS '��������� ���� ���������';
COMMENT ON COLUMN BARS.CIM_ACT_BOUND.MODIFY_DATE IS '��������� ���� �����������';
COMMENT ON COLUMN BARS.CIM_ACT_BOUND.DELETE_DATE IS '���� ��������� ��������';
COMMENT ON COLUMN BARS.CIM_ACT_BOUND.UID_DEL_BOUND IS 'ID �����������, ���� ������� ��`����';
COMMENT ON COLUMN BARS.CIM_ACT_BOUND.UID_DEL_JOURNAL IS 'ID �����������, ���� ������� ����� � �������';
COMMENT ON COLUMN BARS.CIM_ACT_BOUND.BORG_REASON IS '������� �������������';
COMMENT ON COLUMN BARS.CIM_ACT_BOUND.BRANCH IS '����� �������';




PROMPT *** Create  constraint FK_CIMACTBOUND_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACT_BOUND ADD CONSTRAINT FK_CIMACTBOUND_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIMACTBOUND_BORGREASON ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACT_BOUND ADD CONSTRAINT FK_CIMACTBOUND_BORGREASON FOREIGN KEY (BORG_REASON)
	  REFERENCES BARS.CIM_BORG_REASON (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIMACTBOUND_CONTRID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACT_BOUND ADD CONSTRAINT FK_CIMACTBOUND_CONTRID FOREIGN KEY (CONTR_ID)
	  REFERENCES BARS.CIM_CONTRACTS (CONTR_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIMACTBOUND_ACTID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACT_BOUND ADD CONSTRAINT FK_CIMACTBOUND_ACTID FOREIGN KEY (ACT_ID)
	  REFERENCES BARS.CIM_ACTS (ACT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMACTBOUND_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACT_BOUND MODIFY (BRANCH CONSTRAINT CC_CIMACTBOUND_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMACTBOUND_MDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACT_BOUND MODIFY (MODIFY_DATE CONSTRAINT CC_CIMACTBOUND_MDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMACTBOUND_CDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACT_BOUND MODIFY (CREATE_DATE CONSTRAINT CC_CIMACTBOUND_CDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMACTBOUND_SVT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACT_BOUND MODIFY (S_VT CONSTRAINT CC_CIMACTBOUND_SVT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMACTBOUND_CONTRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACT_BOUND MODIFY (CONTR_ID CONSTRAINT CC_CIMACTBOUND_CONTRID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMACTBOUND_ACTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACT_BOUND MODIFY (ACT_ID CONSTRAINT CC_CIMACTBOUND_ACTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMACTBOUND_DIRECT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACT_BOUND MODIFY (DIRECT CONSTRAINT CC_CIMACTBOUND_DIRECT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CIMACTBOUND ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_ACT_BOUND ADD CONSTRAINT PK_CIMACTBOUND PRIMARY KEY (BOUND_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMACTBOUND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMACTBOUND ON BARS.CIM_ACT_BOUND (BOUND_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_ACT_BOUND ***
grant SELECT                                                                 on CIM_ACT_BOUND   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_ACT_BOUND   to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_ACT_BOUND.sql =========*** End ***
PROMPT ===================================================================================== 
