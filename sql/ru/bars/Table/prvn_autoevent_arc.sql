

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_AUTOEVENT_ARC.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_AUTOEVENT_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRVN_AUTOEVENT_ARC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PRVN_AUTOEVENT_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRVN_AUTOEVENT_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_AUTOEVENT_ARC 
   (	REPORTING_DATE DATE, 
	REF_AGR NUMBER, 
	RNK NUMBER(38,0), 
	EVENT_TYPE NUMBER, 
	EVENT_DATE DATE, 
	OBJECT_TYPE VARCHAR2(5), 
	CREATE_DATE DATE, 
	CREATE_USER NUMBER, 
	RESTR_END_DAT DATE, 
	ZO NUMBER(*,0), 
	VIDD NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRVN_AUTOEVENT_ARC ***
 exec bpa.alter_policies('PRVN_AUTOEVENT_ARC');


COMMENT ON TABLE BARS.PRVN_AUTOEVENT_ARC IS '';
COMMENT ON COLUMN BARS.PRVN_AUTOEVENT_ARC.ZO IS '=0 ��� ����, =1-� ����';
COMMENT ON COLUMN BARS.PRVN_AUTOEVENT_ARC.KF IS '��� �i�i��� (���)';
COMMENT ON COLUMN BARS.PRVN_AUTOEVENT_ARC.VIDD IS '';
COMMENT ON COLUMN BARS.PRVN_AUTOEVENT_ARC.REPORTING_DATE IS '����� ����';
COMMENT ON COLUMN BARS.PRVN_AUTOEVENT_ARC.REF_AGR IS '�������� �����';
COMMENT ON COLUMN BARS.PRVN_AUTOEVENT_ARC.RNK IS '��� �볺���';
COMMENT ON COLUMN BARS.PRVN_AUTOEVENT_ARC.EVENT_TYPE IS '��� ��䳿 �������';
COMMENT ON COLUMN BARS.PRVN_AUTOEVENT_ARC.EVENT_DATE IS '���� ���������� ��䳿 �������';
COMMENT ON COLUMN BARS.PRVN_AUTOEVENT_ARC.OBJECT_TYPE IS '';
COMMENT ON COLUMN BARS.PRVN_AUTOEVENT_ARC.CREATE_DATE IS '���� ��������� ������';
COMMENT ON COLUMN BARS.PRVN_AUTOEVENT_ARC.CREATE_USER IS '����������, �� ������� �����';
COMMENT ON COLUMN BARS.PRVN_AUTOEVENT_ARC.RESTR_END_DAT IS '���� ��������� ����������������';




PROMPT *** Create  constraint CC_PRVNAUTOEVENTARC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_AUTOEVENT_ARC MODIFY (KF CONSTRAINT CC_PRVNAUTOEVENTARC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_AUTOEVENT_ARC.sql =========*** En
PROMPT ===================================================================================== 
