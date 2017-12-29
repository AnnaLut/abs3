-- ======================================================================================
-- Module : PRVN
-- Author : BAA
-- Date   : 29.12.2017
-- ===================================== <Comments> =====================================
-- create table BPK_CREDIT_DEAL_VAR
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
set echo         Off
set lines        500
set pages        500
set termout      On
set timing       Off
set trimspool    On

SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- == create table BPK_CREDIT_DEAL_VAR
prompt -- ======================================================

begin
  bpa.alter_policy_info( 'BPK_CREDIT_DEAL_VAR', 'WHOLE',  null, null, null, null );
  bpa.alter_policy_info( 'BPK_CREDIT_DEAL_VAR', 'FILIAL', null, null, null, null );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate
  'create table BARS.BPK_CREDIT_DEAL_VAR
   ( REPORT_DT  date        constraint CC_BPKCRDTDEALVAR_REPDT_NN   not Null,
     ADJ_FLG    number(1)   constraint CC_BPKCRDTDEALVAR_ADJFLG_NN  not Null,
     DEAL_ND    number(24)  constraint CC_BPKCRDTDEALVAR_DEALND_NN  not Null,
     DEAL_SUM   number(24)  constraint CC_BPKCRDTDEALVAR_DEALSUM_NN not Null,
     DEAL_RNK   number(24)  constraint CC_BPKCRDTDEALVAR_DEALRNK_NN not Null,
     RATE       number(5,3) constraint CC_BPKCRDTDEALVAR_RATE_NN    not Null,
     MATUR_DT   date,
     SS         number(24),
     SN         number(24),
     SP         number(24),
     SPN        number(24),
     CR9        number(24),
     CREATE_DT  date        constraint CC_BPKCRDTDEALVAR_CREATDT_NN not Null,
     constraint PK_BPKCRDTDEALVAR primary key ( REPORT_DT, ADJ_FLG, DEAL_ND ) using index tablespace BRSMDLI,
     constraint FK_BPKCRDTDEALVAR_BPKCRDTDEAL foreign key ( DEAL_ND ) references BPK_CREDIT_DEAL (deal_nd)
   ) tablespace BRSMDLD';

  dbms_output.put_line( 'Table "BPK_CREDIT_DEAL_VAR" created.' );

exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "BPK_CREDIT_DEAL_VAR" already exists.' );
end; 
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bpa.alter_policies( 'BPK_CREDIT_DEAL_VAR' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BPK_CREDIT_DEAL_VAR           IS '�������� ��������� ���.��������� ���� ��� �� ����� ����';

COMMENT ON COLUMN BPK_CREDIT_DEAL_VAR.REPORT_DT IS '����� ����';
COMMENT ON COLUMN BPK_CREDIT_DEAL_VAR.DEAL_ND   IS '����� �������� ���������� ����';
COMMENT ON COLUMN BPK_CREDIT_DEAL_VAR.DEAL_SUM  IS '���� �������� (��������� ���)';
COMMENT ON COLUMN BPK_CREDIT_DEAL_VAR.DEAL_RNK  IS '���';
COMMENT ON COLUMN BPK_CREDIT_DEAL_VAR.RATE      IS '³�������� ������ �� ��������';
COMMENT ON COLUMN BPK_CREDIT_DEAL_VAR.MATUR_DT  IS '���� ��������� (�� ����� ����)';
COMMENT ON COLUMN BPK_CREDIT_DEAL_VAR.SS        IS '���� ������������� ���������� ����';
COMMENT ON COLUMN BPK_CREDIT_DEAL_VAR.SN        IS '���� ����������� �������';
COMMENT ON COLUMN BPK_CREDIT_DEAL_VAR.SP        IS '���� ������������� �����';
COMMENT ON COLUMN BPK_CREDIT_DEAL_VAR.SPN       IS '���� ������������ �������';
COMMENT ON COLUMN BPK_CREDIT_DEAL_VAR.CR9       IS '���� ��������������� ���������� ����';
COMMENT ON COLUMN BPK_CREDIT_DEAL_VAR.CREATE_DT IS '���� ��������� ������';
COMMENT ON COLUMN BPK_CREDIT_DEAL_VAR.ADJ_FLG   IS '������ ��������� ���������� ������� (0-ͳ/1-���)';
COMMENT ON COLUMN BPK_CREDIT_DEAL_VAR.KF        IS '��� �i�i��� (���)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BPK_CREDIT_DEAL_VAR TO BARSUPL, UPLD;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
