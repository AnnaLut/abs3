-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 31.10.2016 (30.05.2016)
-- ======================================================================================
-- create table NBUR_DETAIL_PROTOCOLS
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_DETAIL_PROTOCOLS
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DETAIL_PROTOCOLS', 'WHOLE' , NULL, NULL, NULL, NULL );
end;
/

begin
  EXECUTE IMMEDIATE 'drop table BARS.NBUR_DETAIL_PROTOCOLS purge';
  dbms_output.put_line('Table dropped.');
exception
  when OTHERS then
    if ( sqlcode = -00942 )
    then dbms_output.put_line( 'Table "NBUR_DETAIL_PROTOCOLS" does not exist.' );
    else raise;
    end if;
end;
/

begin
  execute immediate q'[CREATE GLOBAL TEMPORARY TABLE BARS.NBUR_DETAIL_PROTOCOLS
( REPORT_DATE     DATE              CONSTRAINT CC_DTLPROTOCOLS_REPORTDT_NN  NOT NULL
, KF              CHAR(6)           CONSTRAINT CC_DTLPROTOCOLS_KF_NN        NOT NULL
, REPORT_CODE     CHAR(3)           CONSTRAINT CC_DTLPROTOCOLS_REPORTCD_NN  NOT NULL
, NBUC            VARCHAR2(20)      CONSTRAINT CC_DTLPROTOCOLS_NBUC_NN      NOT NULL
, FIELD_CODE      VARCHAR2(35)      CONSTRAINT CC_DTLPROTOCOLS_FIELDCOD_NN  NOT NULL
, FIELD_VALUE     VARCHAR2(256)     CONSTRAINT CC_DTLPROTOCOLS_FIELDVAL_NN  NOT NULL
, DESCRIPTION     VARCHAR2(250)
, ACC_ID          NUMBER(38)
, ACC_NUM         VARCHAR2(20)
, KV              NUMBER(3)
, MATURITY_DATE   DATE
, CUST_ID         NUMBER(38)
, REF             NUMBER(38)
, ND              NUMBER(38)
, BRANCH          VARCHAR2(30)
) 
ON COMMIT PRESERVE ROWS
PARALLEL 8]';
  
  dbms_output.put_line('table "NBUR_DETAIL_PROTOCOLS" created.');
  
exception
  when OTHERS then
    if ( sqlcode = -00955 )
    then dbms_output.put_line( 'Table "NBUR_DETAIL_PROTOCOLS" already exists.' );
    else raise;
    end if;  
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Table comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.NBUR_DETAIL_PROTOCOLS               IS '��������� �������� ������������ �����';

COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.REPORT_DATE   IS '����� ����';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.KF            IS '��� �i�i��� (���)';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.REPORT_CODE   IS '��� ����';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.NBUC          IS '��� ������ ����� � ������� ���� (Code section data)';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.FIELD_CODE    IS '��� ���������';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.FIELD_VALUE   IS '�������� ���������';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.DESCRIPTION   IS '���� (��������)';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.ACC_ID        IS '��. �������';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.ACC_NUM       IS '����� �������';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.KV            IS '��. ������';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.MATURITY_DATE IS '���� ���������';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.CUST_ID       IS '��. �볺���';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.REF           IS '��. ��������� ���������';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.ND            IS '��. ��������';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.BRANCH        IS '��� ��������';

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
