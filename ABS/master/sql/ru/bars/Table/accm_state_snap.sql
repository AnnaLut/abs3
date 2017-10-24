

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCM_STATE_SNAP.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCM_STATE_SNAP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCM_STATE_SNAP'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCM_STATE_SNAP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCM_STATE_SNAP 
   (	CALDT_ID NUMBER(38,0), 
	SNAP_BALANCE CHAR(1) DEFAULT ''N'', 
	LOCKED VARCHAR2(1), 
	SNAP_SCN NUMBER, 
	SID NUMBER, 
	SERIAL# NUMBER, 
	SNAP_DATE DATE, 
	CALL_SCN NUMBER, 
	CALL_DATE DATE, 
	CALL_FLAG VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSACCM  ENABLE ROW MOVEMENT ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCM_STATE_SNAP ***
 exec bpa.alter_policies('ACCM_STATE_SNAP');


COMMENT ON TABLE BARS.ACCM_STATE_SNAP IS '���������� ����������. ������������ ��������� ������� � ������� ���';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.LOCKED IS '���� ���������� ������ �������';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.SNAP_SCN IS 'SCN �������� ������ �������';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.SID IS '������������� ������';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.SERIAL# IS '�������� ����� ������';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.SNAP_DATE IS '����+����� �������� ������ �������';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.CALL_SCN IS 'SCN ���������� ��������� � ������ �������';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.CALL_DATE IS '����+����� ���������� ��������� � ������ �������';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.CALL_FLAG IS '���� ��������� � ������ �������: CREATED-������, RECREATED-����������, REUSED-�������� �����������';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.CALDT_ID IS '��. ����������� ����';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.SNAP_BALANCE IS '������� ������� ������ �������';




PROMPT *** Create  constraint PK_ACCMSTATESNAP ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_STATE_SNAP ADD CONSTRAINT PK_ACCMSTATESNAP PRIMARY KEY (CALDT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSACCM  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSTATESNAP_SNAPBAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_STATE_SNAP MODIFY (SNAP_BALANCE CONSTRAINT CC_ACCMSTATESNAP_SNAPBAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSTATESNAP_CALID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_STATE_SNAP MODIFY (CALDT_ID CONSTRAINT CC_ACCMSTATESNAP_CALID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSTATESNAP_SNAPBAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_STATE_SNAP ADD CONSTRAINT CC_ACCMSTATESNAP_SNAPBAL CHECK (snap_balance in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSTATESNAP_LOCKED_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_STATE_SNAP ADD CONSTRAINT CC_ACCMSTATESNAP_LOCKED_CC CHECK (locked=''Y'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSTATESNAP_CALLFLAG_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_STATE_SNAP ADD CONSTRAINT CC_ACCMSTATESNAP_CALLFLAG_CC CHECK (call_flag in (''CREATED'',''RECREATED'',''REUSED'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCMSTATESNAP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCMSTATESNAP ON BARS.ACCM_STATE_SNAP (CALDT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSACCM ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCM_STATE_SNAP.sql =========*** End *
PROMPT ===================================================================================== 
