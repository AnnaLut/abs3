

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OVR_INTX.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OVR_INTX ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OVR_INTX'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OVR_INTX'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OVR_INTX ***
begin 
  execute immediate '
  CREATE TABLE BARS.OVR_INTX 
   (	CDAT DATE, 
	ACC8 NUMBER, 
	SAL8 NUMBER, 
	IP8 NUMBER, 
	IA8 NUMBER, 
	PAS8 NUMBER, 
	AKT8 NUMBER, 
	ACC NUMBER, 
	OST2 NUMBER, 
	IP2 NUMBER, 
	IA2 NUMBER, 
	KP NUMBER(38,10), 
	KA NUMBER(38,10), 
	S2 NUMBER(38,10), 
	S8 NUMBER(38,10), 
	PR2 NUMBER(38,10), 
	PR8 NUMBER(38,10), 
	PR NUMBER(38,10), 
	NPP NUMBER(*,0), 
	VN NUMBER(*,0), 
	RNK NUMBER, 
	MOD1 NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OVR_INTX ***
 exec bpa.alter_policies('OVR_INTX');


COMMENT ON TABLE BARS.OVR_INTX IS '�������� ���������� ���� �� ���������� ���';
COMMENT ON COLUMN BARS.OVR_INTX.CDAT IS '������.����';
COMMENT ON COLUMN BARS.OVR_INTX.ACC8 IS '���-���������';
COMMENT ON COLUMN BARS.OVR_INTX.SAL8 IS '������ ������.';
COMMENT ON COLUMN BARS.OVR_INTX.IP8 IS '������ �� 8999 ���= �8 (�������� ������)';
COMMENT ON COLUMN BARS.OVR_INTX.IA8 IS '������ �� 8999 ��� = A8 (�������� ������)';
COMMENT ON COLUMN BARS.OVR_INTX.PAS8 IS '���� ��� ���';
COMMENT ON COLUMN BARS.OVR_INTX.AKT8 IS '���� ��� ���';
COMMENT ON COLUMN BARS.OVR_INTX.ACC IS '���-�������� 2600';
COMMENT ON COLUMN BARS.OVR_INTX.OST2 IS '������ ������ ��������';
COMMENT ON COLUMN BARS.OVR_INTX.IP2 IS '������ �� ��� 2600.i �2 (����������� ������)';
COMMENT ON COLUMN BARS.OVR_INTX.IA2 IS '������ �� ��� 2600.i �2 (����������� ������)';
COMMENT ON COLUMN BARS.OVR_INTX.KP IS '����=������ ���/���� ���';
COMMENT ON COLUMN BARS.OVR_INTX.KA IS '����=������ ���/���� ���';
COMMENT ON COLUMN BARS.OVR_INTX.S2 IS '������� ����� ��� ����� (����������� ������)';
COMMENT ON COLUMN BARS.OVR_INTX.S8 IS '������� ����� ��� �������.(�������� ������)';
COMMENT ON COLUMN BARS.OVR_INTX.PR2 IS '���� ���� �� ����� (����������� ������)';
COMMENT ON COLUMN BARS.OVR_INTX.PR8 IS '���� ���� �� �������.(�������� ������)';
COMMENT ON COLUMN BARS.OVR_INTX.PR IS '��� ���� ���� �� ����';
COMMENT ON COLUMN BARS.OVR_INTX.NPP IS '0,1,2 - ������������� ��� ��������� �����';
COMMENT ON COLUMN BARS.OVR_INTX.VN IS '��� ��� 0-����. 1 - �������� ��� 1 ���';
COMMENT ON COLUMN BARS.OVR_INTX.RNK IS '��� ��������';
COMMENT ON COLUMN BARS.OVR_INTX.MOD1 IS '=1-������� ��������� ����������';



PROMPT *** Create  grants  OVR_INTX ***
grant SELECT                                                                 on OVR_INTX        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OVR_INTX        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OVR_INTX.sql =========*** End *** ====
PROMPT ===================================================================================== 
