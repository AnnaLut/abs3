-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 12.09.2016 (31.05.2016)
-- ======================================================================================
-- create table NBUR_DM_CUSTOMERS
-- ======================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        100
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table NBUR_DM_CUSTOMERS
prompt -- ======================================================

begin
  bars.bpa.alter_policy_info( 'NBUR_DM_CUSTOMERS_ARCH', 'WHOLE', Null, Null, Null, Null );
  bars.bpa.alter_policy_info( 'NBUR_DM_CUSTOMERS_ARCH', 'FILIAL', 'M',  'M',  'E',  'E' );
  bars.bpa.alter_policy_info( 'NBUR_DM_CUSTOMERS_ARCH', 'CENTER', NULL, 'E',  'E',  'E' );
end;
/

begin
  execute immediate q'[CREATE TABLE BARS.NBUR_DM_CUSTOMERS_ARCH
( REPORT_DATE     DATE         CONSTRAINT CC_DMCUSTOMERSARCH_REPORTDT_NN NOT NULL
, KF              VARCHAR2(6)  CONSTRAINT CC_DMCUSTOMERSARCH_KF_NN       NOT NULL
, VERSION_ID      NUMBER(3)    CONSTRAINT CC_DMCUSTOMERSARCH_VERSION_NN  NOT NULL
, CUST_ID         NUMBER(38)   CONSTRAINT CC_DMCUSTOMERSARCH_CUSTID_NN   NOT NULL
, CUST_TYPE       NUMBER(1)    CONSTRAINT CC_DMCUSTOMERSARCH_CUSTTP_NN   NOT NULL
, CUST_CODE       VARCHAR2(14)
, CUST_NAME       VARCHAR2(38)
, CUST_ADR        VARCHAR2(70)
, OPEN_DATE       DATE         CONSTRAINT CC_DMCUSTOMERSARCH_OPENDT_NN   NOT NULL
, CLOSE_DATE      DATE
, BRANCH          VARCHAR2(30) CONSTRAINT CC_DMCUSTOMERSARCH_BRANCH_NN   NOT NULL
, TAX_REG_ID      NUMBER(2)
, TAX_DST_ID      NUMBER(2)
, CRISK           CHAR(2)
, CUST_PID        NUMBER(38)
, BC              NUMBER(1)
, K030            CHAR(1)
, K040            CHAR(3)      CONSTRAINT CC_DMCUSTOMERSARCH_K040_NN     NOT NULL
, K041            CHAR(1)
, K050            CHAR(3)
, K051            CHAR(2)
, K060            CHAR(2)
, K070            CHAR(5)
, K072            CHAR(2)
, K073            CHAR(1)
, K074            CHAR(1)
, K080            CHAR(2)
, K081            CHAR(1)
, K090            CHAR(5)
, K110            CHAR(5)
, K111            CHAR(2)
, K112            CHAR(1)
) TABLESPACE BRSBIGD
COMPRESS BASIC 
PARALLEL 8
STORAGE( INITIAL 128K NEXT 128K )
PCTUSED   0
PCTFREE   0
PARTITION BY RANGE (REPORT_DATE) INTERVAL( NUMTODSINTERVAL(1,'DAY') )
SUBPARTITION BY LIST (KF)
SUBPARTITION TEMPLATE
( SUBPARTITION SP_300465 VALUES ('300465')
, SUBPARTITION SP_302076 VALUES ('302076')
, SUBPARTITION SP_303398 VALUES ('303398')
, SUBPARTITION SP_304665 VALUES ('304665')
, SUBPARTITION SP_305482 VALUES ('305482')
, SUBPARTITION SP_311647 VALUES ('311647')
, SUBPARTITION SP_312356 VALUES ('312356')
, SUBPARTITION SP_313957 VALUES ('313957')
, SUBPARTITION SP_315784 VALUES ('315784')
, SUBPARTITION SP_322669 VALUES ('322669')
, SUBPARTITION SP_323475 VALUES ('323475')
, SUBPARTITION SP_324805 VALUES ('324805')
, SUBPARTITION SP_325796 VALUES ('325796')
, SUBPARTITION SP_326461 VALUES ('326461')
, SUBPARTITION SP_328845 VALUES ('328845')
, SUBPARTITION SP_331467 VALUES ('331467')
, SUBPARTITION SP_333368 VALUES ('333368')
, SUBPARTITION SP_335106 VALUES ('335106')
, SUBPARTITION SP_336503 VALUES ('336503')
, SUBPARTITION SP_337568 VALUES ('337568')
, SUBPARTITION SP_338545 VALUES ('338545')
, SUBPARTITION SP_351823 VALUES ('351823')
, SUBPARTITION SP_352457 VALUES ('352457')
, SUBPARTITION SP_353553 VALUES ('353553')
, SUBPARTITION SP_354507 VALUES ('354507')
, SUBPARTITION SP_356334 VALUES ('356334') )
( PARTITION  P_MINVALUE VALUES LESS THAN ( TO_DATE('01/01/2016','DD/MM/YYYY') ) )]';
  
  dbms_output.put_line('Table "NBUR_DM_CUSTOMERS_ARCH" created.');
  
exception
  when OTHERS then
    if ( sqlcode = -00955 )
    then dbms_output.put_line( 'Table "NBUR_DM_CUSTOMERS_ARCH" already exists.' );
    else raise;
    end if;  
end;
/

prompt -- ======================================================
prompt -- Create index
prompt -- ======================================================

begin
  execute immediate q'[CREATE INDEX BARS.UK_DMCUSTOMERSARCH ON BARS.NBUR_DM_CUSTOMERS_ARCH ( REPORT_DATE, KF, VERSION_ID, CUST_ID )
  TABLESPACE BRSBIGI
  PCTFREE 0
  LOCAL
  COMPRESS 3 ]';
  dbms_output.put_line( 'Index "BARS.UK_DMCUSTOMERSARCH" created.' );
exception
  when OTHERS then 
    case
      when (sqlcode = -00955)
      then dbms_output.put_line('Index "UK_DMCUSTOMERSARCH" already exists in the table.');
      when (sqlcode = -01408)
      then dbms_output.put_line('Column(s) "REPORT_DATE", "KF", "VERSION_ID", "CUST_ID" already indexed.');
      else raise;
    end case;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies('NBUR_DM_CUSTOMERS_ARCH');
end;
/

commit;

CREATE OR REPLACE SYNONYM BARS.DM_CUSTOMERS FOR BARS.NBUR_DM_CUSTOMERS_ARCH;

prompt -- ======================================================
prompt -- table comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.NBUR_DM_CUSTOMERS_ARCH             IS '³����� �볺��� ��� � ����������� (����� �����)';
  
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.REPORT_DATE IS '����� ����';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.KF          IS '��� �i�i��� (���)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.VERSION_ID  IS 'I������i����� ����';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.CUST_ID     IS 'I������i����� �����������';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.CUST_TYPE   IS '��� �볺��� (����/��/��)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.CUST_CODE   IS '��� �볺���';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.CUST_NAME   IS '����� �볺���';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.CUST_ADR    IS '������ �볺���';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.BRANCH      IS '��� �i��i�����';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.CRISK       IS '�������� ������';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.OPEN_DATE   IS '���� ��������� �볺��� � ���';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.CLOSE_DATE  IS '���� �������� �볺���';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.TAX_REG_ID  IS '��. ���������� ��������� ���������';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.TAX_DST_ID  IS '��. ������� ��������� ���������';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.CUST_PID    IS '��� ������������ �볺��� (RNKP)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.BC          IS '������ ������/�������� �����';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.K030        IS '������������ (CODCAGENT)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.K040        IS '��� ����� (COUNTRY)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.K041        IS '����� ����';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.K050        IS '������������-������� ����� ��������������';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.K051        IS '���� ������������-�������� ���� �������������� (SED)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.K060        IS '��� ��������� (PRINSIDER)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.K070        IS '������������� ������ �������� (ISE)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.K072        IS '������ ��������';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.K073        IS '������ �������� 1-�� ����';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.K074        IS '������������ ������ �������� (��������� - �����������) ';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.K080        IS '����� �������� (FS)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.K081        IS '����� �������� 1-�� ����';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.K090        IS '������ ������i�� (OE)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.K110        IS '��� ��������� ��������  (VED)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.K111        IS '����� ���� ��������� ��������';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS_ARCH.K112        IS '������ ���� ��������� ��������';

prompt -- ======================================================
prompt -- table grants
prompt -- ======================================================

GRANT SELECT ON BARS.NBUR_DM_CUSTOMERS_ARCH TO BARSUPL;
GRANT SELECT ON BARS.NBUR_DM_CUSTOMERS_ARCH TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
