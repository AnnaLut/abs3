

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_VMD_BOUND.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_VMD_BOUND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_VMD_BOUND'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_VMD_BOUND'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_VMD_BOUND'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_VMD_BOUND ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_VMD_BOUND 
   (	BOUND_ID NUMBER, 
	DIRECT NUMBER, 
	VMD_ID NUMBER, 
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
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	BORG_REASON NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_VMD_BOUND ***
 exec bpa.alter_policies('CIM_VMD_BOUND');


COMMENT ON TABLE BARS.CIM_VMD_BOUND IS '����`���� ��� �� ���������';
COMMENT ON COLUMN BARS.CIM_VMD_BOUND.BOUND_ID IS '������������� ��������';
COMMENT ON COLUMN BARS.CIM_VMD_BOUND.DIRECT IS '�������� (0 - �����, 1 - ������)';
COMMENT ON COLUMN BARS.CIM_VMD_BOUND.VMD_ID IS '�������� ���';
COMMENT ON COLUMN BARS.CIM_VMD_BOUND.CONTR_ID IS '������������� ���������';
COMMENT ON COLUMN BARS.CIM_VMD_BOUND.S_VT IS '���� ���`���� � ����� ������';
COMMENT ON COLUMN BARS.CIM_VMD_BOUND.RATE_VK IS '���� ������� ������ ���������';
COMMENT ON COLUMN BARS.CIM_VMD_BOUND.S_VK IS '���� ���`���� � ����� ���������';
COMMENT ON COLUMN BARS.CIM_VMD_BOUND.COMMENTS IS '��������';
COMMENT ON COLUMN BARS.CIM_VMD_BOUND.JOURNAL_NUM IS '����� �������';
COMMENT ON COLUMN BARS.CIM_VMD_BOUND.JOURNAL_ID IS '����� � ������';
COMMENT ON COLUMN BARS.CIM_VMD_BOUND.CREATE_DATE IS '��������� ���� ���������';
COMMENT ON COLUMN BARS.CIM_VMD_BOUND.MODIFY_DATE IS '��������� ���� �������� �����������';
COMMENT ON COLUMN BARS.CIM_VMD_BOUND.DELETE_DATE IS '���� ��������� ��������';
COMMENT ON COLUMN BARS.CIM_VMD_BOUND.UID_DEL_BOUND IS 'ID �����������, ���� ������� ��`����';
COMMENT ON COLUMN BARS.CIM_VMD_BOUND.UID_DEL_JOURNAL IS 'ID �����������, ���� ������� ����� � �������';
COMMENT ON COLUMN BARS.CIM_VMD_BOUND.BRANCH IS '����� �������';
COMMENT ON COLUMN BARS.CIM_VMD_BOUND.BORG_REASON IS '������� �������������';




PROMPT *** Create  constraint PK_CIMVMDBOUND ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_VMD_BOUND ADD CONSTRAINT PK_CIMVMDBOUND PRIMARY KEY (BOUND_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMVMDBOUND_DIRECT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_VMD_BOUND MODIFY (DIRECT CONSTRAINT CC_CIMVMDBOUND_DIRECT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMVMDBOUND_VMDID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_VMD_BOUND MODIFY (VMD_ID CONSTRAINT CC_CIMVMDBOUND_VMDID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMVMDBOUND_CONTRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_VMD_BOUND MODIFY (CONTR_ID CONSTRAINT CC_CIMVMDBOUND_CONTRID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMVMDBOUND_SVT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_VMD_BOUND MODIFY (S_VT CONSTRAINT CC_CIMVMDBOUND_SVT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMVMDBOUND_CDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_VMD_BOUND MODIFY (CREATE_DATE CONSTRAINT CC_CIMVMDBOUND_CDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMVMDBOUND_MDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_VMD_BOUND MODIFY (MODIFY_DATE CONSTRAINT CC_CIMVMDBOUND_MDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMVMDBOUND_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_VMD_BOUND MODIFY (BRANCH CONSTRAINT CC_CIMVMDBOUND_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMVMDBOUND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMVMDBOUND ON BARS.CIM_VMD_BOUND (BOUND_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index IDX_CIMVMD_CONTRID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CIMVMD_CONTRID ON BARS.CIM_VMD_BOUND (CONTR_ID)';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint FK_CIMVMD_CONTRID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_VMD_BOUND ADD CONSTRAINT FK_CIMVMD_CONTRID FOREIGN KEY (CONTR_ID)
	  REFERENCES BARS.CIM_CONTRACTS (CONTR_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  CIM_VMD_BOUND ***
grant SELECT                                                                 on CIM_VMD_BOUND   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_VMD_BOUND   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_VMD_BOUND   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_VMD_BOUND   to CIM_ROLE;
grant SELECT                                                                 on CIM_VMD_BOUND   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_VMD_BOUND.sql =========*** End ***
PROMPT ===================================================================================== 
