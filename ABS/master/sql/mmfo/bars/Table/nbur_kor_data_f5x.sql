
PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Table/NBUR_KOR_DATA_F5X.sql ======= *** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_KOR_DATA_F5X ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_KOR_DATA_F5X'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_KOR_DATA_F5X'', ''FILIAL'' , null, ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBUR_KOR_DATA_F5X'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_KOR_DATA_F5X ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_KOR_DATA_F5X 
   (	REPORT_DATE     DATE, 
        KF NUMBER DEFAULT sys_context(''bars_context'',''user_mfo''), 
        EKP       VARCHAR2(6), 
        Z230      VARCHAR2(2),
        Z350      VARCHAR2(1),
        K045      VARCHAR2(1),
        Z130      VARCHAR2(2),
        Z140      VARCHAR2(1),
        Z150      VARCHAR2(2),
        KU        VARCHAR2(3),
        T070      NUMBER,
        T080      NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** ALTER_POLICIES to NBUR_KOR_DATA_F5X ***
 exec bpa.alter_policies('NBUR_KOR_DATA_F5X');


COMMENT ON TABLE  BARS.NBUR_KOR_DATA_F5X IS 'F5X -��� ��� ������ ����� ����� c����� �������� � ��������� ��������';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F5X.REPORT_DATE IS '��i��� ����';
comment on column BARS.NBUR_KOR_DATA_F5X.KF  is '��� ��볿';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F5X.EKP     IS '��� ���������';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F5X.Z230    IS '��� ������� �������';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F5X.Z350    IS '��� ������� ������� ������';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F5X.K045    IS '��� �������, �� �������� ��������� ��/������� ��������';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F5X.Z130    IS '��� ��������� 䳿 ��� ������� �������� � ��������� ��������';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F5X.Z140    IS '��� �������� �������� � ��������� ��������';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F5X.Z150    IS '��� ���� ��������� �������� � �������� �������';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F5X.KU      IS '��� �������������-������������ ������� ������ ������������ ��������� ��������';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F5X.T070    IS '���� ������ �� ���������� �� � ��������� ��������';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F5X.T080    IS 'ʳ������ �������� �������� � ��������� ��������';

PROMPT *** Create  grants  NBUR_KOR_DATA_F5X ***
grant SELECT                                          on NBUR_KOR_DATA_F5X   to BARSREADER_ROLE;
grant SELECT                                          on NBUR_KOR_DATA_F5X   to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                     on NBUR_KOR_DATA_F5X   to BARS_ACCESS_DEFROLE;
grant SELECT                                          on NBUR_KOR_DATA_F5X   to RPBN002;
grant SELECT                                          on NBUR_KOR_DATA_F5X   to UPLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Table/NBUR_KOR_DATA_F5X.sql ======= *** End ***
PROMPT ===================================================================================== 

