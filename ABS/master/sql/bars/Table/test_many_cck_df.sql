PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/Table/TEST_MANY_CCK_DF.sql =====*** Run *** ====
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to TEST_MANY_CCK_DF ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TEST_MANY_CCK_DF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TEST_MANY_CCK_DF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TEST_MANY_CCK_DF ***
begin 
  execute immediate '
      CREATE TABLE BARS.TEST_MANY_CCK_DF 
            (ND        NUMBER,
             PV        NUMBER,
             IRR0      NUMBER,
             IRR       NUMBER,
             SERR      VARCHAR2(100 BYTE),
             BRANCH    VARCHAR2(22 BYTE),
             VIDD      INTEGER,
             SDATE     DATE,
             WDATE     DATE,
             IR        NUMBER,
             BV        NUMBER,
             RNK       NUMBER,
             K         NUMBER,
             KAT       NUMBER,
             NLS       VARCHAR2(15 BYTE),
             KV        INTEGER,
             OBS       INTEGER,
             FIN       INTEGER,
             FINN      VARCHAR2(35 BYTE),
             OBESP     NUMBER,
             REZ       NUMBER,
             DAT       DATE,
             ID        NUMBER,
             BASEY     INTEGER,
             KOL_P     INTEGER,
             KOL_VZ    INTEGER,
             D_P       DATE,
             D_V       DATE,
             REZQ      NUMBER,
             OB22      CHAR(2 BYTE),
             BVQ       NUMBER,
             S180      VARCHAR2(1 BYTE),
             R011      VARCHAR2(1 BYTE),
             OKPO      VARCHAR2(14 BYTE),
             NMS       VARCHAR2(70 BYTE),
             ZAXODY    VARCHAR2(70 BYTE),
             NBS       VARCHAR2(4 BYTE),
             R013      VARCHAR2(1 BYTE),
             PVQ       NUMBER,
             NBS_REZ   CHAR(4 BYTE),
             OB22_REZ  CHAR(2 BYTE)
           ) SEGMENT CREATION IMMEDIATE 
             PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
             NOCOMPRESS LOGGING
             TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to TEST_MANY_CCK_DF ***
 exec bpa.alter_policies('TEST_MANY_CCK_DF');

COMMENT ON TABLE BARS.TEST_MANY_CCK_DF          IS '������ �� ��������� ���������� ��������������';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.ND      IS '�������� ����� �������';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.PV      IS '�������� ������� (BV*K)';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.SERR    IS '��������';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.BRANCH  IS '����� ��������';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.VIDD    IS '��� (8 - ������ ���, 9 - ���������';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.SDATE   IS '���� �������';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.WDATE   IS '���� ���������';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.BV      IS '��������� ������� ���.';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.RNK     IS '������������ ����� �볺���';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.K       IS '�������� ������';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.KAT     IS '�������� �����';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.NLS     IS '����� �������';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.KV      IS '��� ������';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.REZ     IS '������ ���.';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.DAT     IS '�������� ����';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.ID      IS '����������';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.KOL_P   IS '�-�� ��� ����������';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.KOL_VZ  IS '�-�� ��� �������� ��������������';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.D_P     IS '���� ����������';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.D_V     IS '���� ���������� ��������������';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.REZQ    IS '������ ���.';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.OB22    IS '��22 �������';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.BVQ     IS '��������� ������� ���.';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.S180    IS 'S180 - ��� �����';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.NMS     IS '���� ��������������(��������.�����)';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.ZAXODY  IS '���� ������';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.R011    IS 'R011';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.OKPO    IS 'OKPO';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.NBS     IS '���������� �������';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.R013    IS '�������� R013';
COMMENT ON COLUMN BARS.TEST_MANY_CCK_DF.PVQ     IS '�������� ������� ���.';

PROMPT *** Create  constraint PK_TESTMANYCCK_DF ***

begin
  EXECUTE IMMEDIATE 
   'ALTER TABLE BARS.TEST_MANY_CCK_DF DROP PRIMARY KEY CASCADE';
 exception when others then
  -- ORA-02260:  Cannot drop nonexistent primary key
  if SQLCODE = -02441 then null;   else raise; end if; 
end;
/

PROMPT *** Create  grants  TEST_MANY_CCK_DF ***

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.TEST_MANY_CCK_DF TO BARS_ACCESS_DEFROLE;
GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.TEST_MANY_CCK_DF TO RCC_DEAL;
GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.TEST_MANY_CCK_DF TO START1;
GRANT SELECT                         ON BARS.TEST_MANY_CCK_DF TO UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ====== Scripts /Sql/BARS/Table/TEST_MANY_CCK_DF.sql =====*** End *** ====
PROMPT ===================================================================================== 
