

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_INT_QUEUE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_INT_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_INT_QUEUE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_INT_QUEUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_INT_QUEUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_INT_QUEUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_INT_QUEUE 
   (	ID NUMBER(38,0), 
	KF VARCHAR2(12), 
	BRANCH VARCHAR2(30), 
	INT_ID NUMBER(1,0), 
	ACC_ID NUMBER(38,0), 
	ACC_NUM VARCHAR2(15), 
	ACC_CUR NUMBER(3,0), 
	ACC_NBS CHAR(4), 
	ACC_NAME VARCHAR2(38), 
	ACC_ISO CHAR(3), 
	ACC_OPEN DATE, 
	ACC_AMOUNT NUMBER(38,0), 
	INT_DETAILS VARCHAR2(160), 
	INT_TT CHAR(3), 
	DEAL_ID NUMBER(38,0), 
	DEAL_NUM VARCHAR2(35), 
	DEAL_DAT DATE, 
	CUST_ID NUMBER(38,0), 
	MOD_CODE CHAR(3), 
	INS_TIME DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_INT_QUEUE ***
 exec bpa.alter_policies('DPT_INT_QUEUE');


COMMENT ON TABLE BARS.DPT_INT_QUEUE IS '������������� ������� � ������� �� ���%%';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.ID IS '';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.KF IS '���';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.BRANCH IS '��� ������������� �����';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.INT_ID IS '��� ���������� ��������';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.ACC_ID IS '�����.����� �����';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.ACC_NUM IS '����� �����';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.ACC_CUR IS '��� ������ �����';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.ACC_NBS IS '���.����';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.ACC_NAME IS '������������ �����';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.ACC_ISO IS '��� ������ ISO';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.ACC_OPEN IS '���� �������� �����';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.ACC_AMOUNT IS '������� ��� ����������';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.INT_DETAILS IS '���������� �������';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.INT_TT IS '��� ��������';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.DEAL_ID IS '������������� ��������';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.DEAL_NUM IS '����� ��������';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.DEAL_DAT IS '���� ��������';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.CUST_ID IS '���.� �������';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.MOD_CODE IS '��� ������';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.INS_TIME IS '';




PROMPT *** Create  constraint PK_DPTINTQUEUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INT_QUEUE ADD CONSTRAINT PK_DPTINTQUEUE PRIMARY KEY (ID, ACC_ID, INT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTINTQUEUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTINTQUEUE ON BARS.DPT_INT_QUEUE (ID, ACC_ID, INT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_INT_QUEUE ***
grant INSERT,SELECT                                                          on DPT_INT_QUEUE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_INT_QUEUE   to BARS_DM;
grant SELECT                                                                 on DPT_INT_QUEUE   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_INT_QUEUE   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_INT_QUEUE.sql =========*** End ***
PROMPT ===================================================================================== 
