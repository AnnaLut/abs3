

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ANI34.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ANI34 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ANI34 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ANI34 
   (  B DATE, 
  E DATE, 
  G01 VARCHAR2(9), 
  G02 NUMBER, 
  G03 VARCHAR2(15), 
  G04 NUMBER, 
  G05 VARCHAR2(70), 
  G06 DATE, 
  G07 DATE, 
  G08 DATE, 
  G08A NUMBER, 
  G08B NUMBER, 
  G09 NUMBER, 
  G10 NUMBER, 
  G11 NUMBER, 
  G12 NUMBER, 
  G13 NUMBER, 
  G14 NUMBER, 
  G15 NUMBER, 
  G16 NUMBER, 
  G17 NUMBER, 
  G18 NUMBER, 
  G19 NUMBER, 
  G20 NUMBER, 
  G21 NUMBER, 
  G22 VARCHAR2(9), 
  G23 VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** add column G23 ***
begin 
  execute immediate '
  alter table tmp_ani34 add G23 VARCHAR2(2)';
exception when others then       
  if sqlcode=-01430 then null; else raise; end if; 
end; 
/


PROMPT *** ALTER_POLICIES to TMP_ANI34 ***
 exec bpa.alter_policies('TMP_ANI34');


COMMENT ON TABLE BARS.TMP_ANI34 IS '�3. Գ�.��������� �� ����� �� �������� ���.������������';
COMMENT ON COLUMN BARS.TMP_ANI34.B IS '���� �������~���i��� ���i��~Beg';
COMMENT ON COLUMN BARS.TMP_ANI34.E IS '���� �i���~���i��� ���i��~End';
COMMENT ON COLUMN BARS.TMP_ANI34.G01 IS '���~�����~01';
COMMENT ON COLUMN BARS.TMP_ANI34.G02 IS '��. ~� �����~02';
COMMENT ON COLUMN BARS.TMP_ANI34.G03 IS '�~������~03';
COMMENT ON COLUMN BARS.TMP_ANI34.G04 IS '���~~04';
COMMENT ON COLUMN BARS.TMP_ANI34.G05 IS '������������~�����������~05    ';
COMMENT ON COLUMN BARS.TMP_ANI34.G06 IS '����~�����~06';
COMMENT ON COLUMN BARS.TMP_ANI34.G07 IS '����~����������� ~07';
COMMENT ON COLUMN BARS.TMP_ANI34.G08 IS '����~����������~08';
COMMENT ON COLUMN BARS.TMP_ANI34.G08A IS '���~�~0A';
COMMENT ON COLUMN BARS.TMP_ANI34.G08B IS '���~�~0�';
COMMENT ON COLUMN BARS.TMP_ANI34.G09 IS '���� ��� �~�� ���� �����~09';
COMMENT ON COLUMN BARS.TMP_ANI34.G10 IS '���� ��� �~�� ���� �����~10';
COMMENT ON COLUMN BARS.TMP_ANI34.G11 IS '���� ��� �~�� ���� �����~11';
COMMENT ON COLUMN BARS.TMP_ANI34.G12 IS 'C��� ��� �~�� ���� �����~12';
COMMENT ON COLUMN BARS.TMP_ANI34.G13 IS '6204~����������~13';
COMMENT ON COLUMN BARS.TMP_ANI34.G14 IS '6204~�������. �-�~14';
COMMENT ON COLUMN BARS.TMP_ANI34.G15 IS '6204~�����. �-�~15';
COMMENT ON COLUMN BARS.TMP_ANI34.G16 IS '6209~����������~16';
COMMENT ON COLUMN BARS.TMP_ANI34.G17 IS '6209~�������. �-�~17';
COMMENT ON COLUMN BARS.TMP_ANI34.G18 IS '6209~�����. �-�~18';
COMMENT ON COLUMN BARS.TMP_ANI34.G19 IS '������ ~�������. �-�~19';
COMMENT ON COLUMN BARS.TMP_ANI34.G20 IS '������ ~�����. �-�~20';
COMMENT ON COLUMN BARS.TMP_ANI34.G21 IS '������~���. �-� ~21';
COMMENT ON COLUMN BARS.TMP_ANI34.G22 IS '������~�����~22';
COMMENT ON COLUMN BARS.TMP_ANI34.G23 IS '��������~23';



PROMPT *** Create  grants  TMP_ANI34 ***
grant SELECT                                                                 on TMP_ANI34       to START1;
grant SELECT                                                                 on TMP_ANI34       to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_ANI34       to BARS_DM;
grant SELECT                                                                 on TMP_ANI34       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_ANI34       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ANI34.sql =========*** End *** ===
PROMPT ===================================================================================== 
