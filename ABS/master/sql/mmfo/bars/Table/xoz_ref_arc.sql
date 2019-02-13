

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XOZ_REF_ARC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XOZ_REF_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XOZ_REF_ARC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''XOZ_REF_ARC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XOZ_REF_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.XOZ_REF_ARC 
   (	ACC NUMBER, 
	REF1 NUMBER, 
	STMT1 NUMBER, 
	REF2 NUMBER, 
	MDATE DATE, 
	S NUMBER, 
	FDAT DATE, 
	S0 NUMBER, 
	NOTP NUMBER(*,0), 
	PRG NUMBER(*,0), 
	BU VARCHAR2(30), 
	DATZ DATE, 
	REFD NUMBER, 
	ID NUMBER(38,0), 
	MDAT DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XOZ_REF_ARC ***
 exec bpa.alter_policies('XOZ_REF_ARC');


COMMENT ON TABLE BARS.XOZ_REF_ARC IS '����� ��������� ��������� (������� �� ������� ��� ���.���)';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.ACC IS '������������� ����� ���������';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.REF1 IS '�������� ���������� ���������  �����';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.STMT1 IS 'stmt ���������� ���������  �����';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.REF2 IS '�������� ����������������� ��� ������';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.MDATE IS '����-���� ��������';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.S IS '����-���� ��������';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.FDAT IS '����-���� ����.���.';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.S0 IS '���� �������� (�����)';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.NOTP IS '������� "���.���". 1 = � ���-23 �� ��������� ��������� �� ����, ��� ���������';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.PRG IS '��� �������';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.BU IS '��� �������� �������';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.DATZ IS '����� ���� �������� ���.���.';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.REFD IS '�������� ���.������ �� �� �� �������� �������';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.ID IS '';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.MDAT IS '';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.KF IS '';

begin
 execute immediate   'alter table XOZ_REF_ARC add (CHGDATE date ) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN XOZ_REF_ARC.CHGDATE  IS '���� ����������';

PROMPT *** Create  constraint SYS_C00138857 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_REF_ARC MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138858 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_REF_ARC MODIFY (REF1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138859 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_REF_ARC MODIFY (STMT1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138860 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_REF_ARC MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_XOZREFARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_REF_ARC ADD CONSTRAINT PK_XOZREFARC PRIMARY KEY (MDAT, REF1, STMT1)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XOZREFARC_REF2DATZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_REF_ARC ADD CONSTRAINT CC_XOZREFARC_REF2DATZ CHECK (REF2 IS NULL AND DATZ IS NULL
                                                                     OR
                                                                   REF2 IS NOT NULL AND DATZ IS NOT NULL
                                                           ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XOZREFARC_FDAT_MDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_REF_ARC ADD CONSTRAINT CC_XOZREFARC_FDAT_MDATE CHECK (FDAT <= MDATe) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint CC_XOZREFARC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_REF_ARC MODIFY (KF CONSTRAINT CC_XOZREFARC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index PK_XOZREFARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_XOZREFARC ON BARS.XOZ_REF_ARC (MDAT, REF1, STMT1) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index I1_XOZ_REF_ARC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_XOZ_REF_ARC ON BARS.XOZ_REF_ARC (MDAT, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index I2_XOZ_REF_ARC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_XOZ_REF_ARC ON BARS.XOZ_REF_ARC (MDAT, chgdate) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  XOZ_REF_ARC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on XOZ_REF_ARC     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on XOZ_REF_ARC     to START1;
grant SELECT                                                                 on XOZ_REF_ARC     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XOZ_REF_ARC.sql =========*** End *** =
PROMPT ===================================================================================== 
