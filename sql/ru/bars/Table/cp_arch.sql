

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_ARCH.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_ARCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_ARCH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ARCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_ARCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_ARCH 
   (	REF NUMBER(*,0), 
	DAT_UG DATE, 
	ID NUMBER(*,0), 
	DAT_OPL DATE, 
	DAT_ROZ DATE, 
	ACC NUMBER(*,0), 
	SUMB NUMBER, 
	N NUMBER, 
	D NUMBER, 
	P NUMBER, 
	R NUMBER, 
	S NUMBER, 
	Z NUMBER, 
	STR_REF VARCHAR2(200), 
	OP NUMBER(*,0), 
	STIKET LONG RAW, 
	SN NUMBER, 
	T NUMBER, 
	NOM NUMBER(*,0), 
	REF_MAIN NUMBER(*,0), 
	VD NUMBER, 
	VP NUMBER, 
	TQ NUMBER, 
	REF_REPO NUMBER(*,0), 
	DAT_SN DATE, 
	SN_1 NUMBER, 
	DAT_SN_1 DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_ARCH ***
 exec bpa.alter_policies('CP_ARCH');


COMMENT ON TABLE BARS.CP_ARCH IS '';
COMMENT ON COLUMN BARS.CP_ARCH.ID IS '��� ��';
COMMENT ON COLUMN BARS.CP_ARCH.DAT_OPL IS '���� ������';
COMMENT ON COLUMN BARS.CP_ARCH.DAT_ROZ IS '���� ����������';
COMMENT ON COLUMN BARS.CP_ARCH.ACC IS 'acc - ���-�� ���?����';
COMMENT ON COLUMN BARS.CP_ARCH.SUMB IS '���� �����';
COMMENT ON COLUMN BARS.CP_ARCH.N IS '���� ���i���� �����';
COMMENT ON COLUMN BARS.CP_ARCH.D IS '���� �������� �����';
COMMENT ON COLUMN BARS.CP_ARCH.P IS '���� ����i� �� ����i';
COMMENT ON COLUMN BARS.CP_ARCH.R IS '���� ������ �����';
COMMENT ON COLUMN BARS.CP_ARCH.S IS '���� ������i��� �����';
COMMENT ON COLUMN BARS.CP_ARCH.Z IS '���� �������';
COMMENT ON COLUMN BARS.CP_ARCH.STR_REF IS '������ ��������i� �����';
COMMENT ON COLUMN BARS.CP_ARCH.OP IS '��� ������i�';
COMMENT ON COLUMN BARS.CP_ARCH.STIKET IS '�i��� �����';
COMMENT ON COLUMN BARS.CP_ARCH.SN IS '���� ������?��� �������-�����';
COMMENT ON COLUMN BARS.CP_ARCH.T IS '�������� ��������� ����� �������';
COMMENT ON COLUMN BARS.CP_ARCH.NOM IS '�i���� ���i��� 1 �� �� ��� ������i�, ���i������� � ���i�i';
COMMENT ON COLUMN BARS.CP_ARCH.REF_MAIN IS '���.�������� ����� ';
COMMENT ON COLUMN BARS.CP_ARCH.VD IS '���� �i���������� ��������';
COMMENT ON COLUMN BARS.CP_ARCH.VP IS '���� �i�������� ����i�';
COMMENT ON COLUMN BARS.CP_ARCH.TQ IS '�������� ��������� ����� ������� (���. ���)';
COMMENT ON COLUMN BARS.CP_ARCH.REF IS '���.������i�, ���i������� � ���i�i';
COMMENT ON COLUMN BARS.CP_ARCH.DAT_UG IS '���� �����';
COMMENT ON COLUMN BARS.CP_ARCH.REF_REPO IS '���-� ��������� �����';
COMMENT ON COLUMN BARS.CP_ARCH.DAT_SN IS '���� �����. ����������';
COMMENT ON COLUMN BARS.CP_ARCH.SN_1 IS '���� �����. ���������� - 1';
COMMENT ON COLUMN BARS.CP_ARCH.DAT_SN_1 IS '���� �����. ���������� - 1';




PROMPT *** Create  constraint XPK_CP_ARCH_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ARCH ADD CONSTRAINT XPK_CP_ARCH_REF PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_ARCH_REF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_ARCH_REF ON BARS.CP_ARCH (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_ARCH ***
grant SELECT                                                                 on CP_ARCH         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ARCH         to CP_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_ARCH.sql =========*** End *** =====
PROMPT ===================================================================================== 
