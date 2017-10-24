-- ======================================================================================
-- Module : 
-- Author : 
-- Date   : 11.07.2017
-- ======================================================================================
-- create table SOCIAL_AGENCY
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
prompt -- create table SOCIAL_AGENCY
prompt -- ======================================================

begin
  bpa.alter_policy_info( 'SOCIAL_AGENCY', 'CENTER', null, null, null, null );
  bpa.alter_policy_info( 'SOCIAL_AGENCY', 'FILIAL',  'F',  'F',  'F',  'F' );
  bpa.alter_policy_info( 'SOCIAL_AGENCY', 'WHOLE',  null, null, null, null );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate 'create table SOCIAL_AGENCY
(	AGENCY_ID  NUMBER(38)
, NAME       VARCHAR2(100) constraint CC_SOCIALAGENCY_NAME_NN      NOT NULL 
, BRANCH     VARCHAR2(30)  default sys_context(''bars_context'',''user_branch'')
                           constraint CC_SOCIALAGENCY_BRANCH_NN    NOT NULL
, DEBIT_ACC  NUMBER(38)
, CREDIT_ACC NUMBER(38)    constraint CC_SOCIALAGENCY_CREDITACC_NN NOT NULL
, CARD_ACC   NUMBER(38)    constraint CC_SOCIALAGENCY_CARDACC_NN   NOT NULL
, CONTRACT   VARCHAR2(30)
, DATE_ON    DATE          default trunc(sysdate)
, DATE_OFF   DATE
, ADDRESS    VARCHAR2(100)
, PHONE      VARCHAR2(20)
, DETAILS    VARCHAR2(100)
, TYPE_ID    NUMBER(38)    constraint CC_SOCIALAGENCY_TYPEID_NN    NOT NULL
, COMISS_ACC NUMBER(38)
, constraint PK_SOCIALAGENCY PRIMARY KEY ( AGENCY_ID ) using index tablespace BRSSMLI
, constraint CC_SOCIALAGENCY_DATES check ( DATE_ON <= DATE_OFF )
, constraint FK_SOCIALAGENCY_SOCAGNTYPE foreign key (TYPE_ID) references SOCIAL_AGENCY_TYPE (TYPE_ID)
, constraint FK_SOCIALAGENCY_BRANCH     foreign key (BRANCH)  references BRANCH (BRANCH) deferrable
) tablespace BRSSMLD';
  
  dbms_output.put_line( 'Table "SOCIAL_AGENCY" created.');
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "SOCIAL_AGENCY" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
 execute immediate q'[create index IDX_SOCIALAGENCY_TPID_BR on SOCIAL_AGENCY ( TYPE_ID, BRANCH )
  tablespace BRSSMLI
  compress 1 ]';
  dbms_output.put_line( 'Index "IDX_SOCIALAGENCY_TPID_BR" created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'SOCIAL_AGENCY' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  SOCIAL_AGENCY            IS 'Органы социальной защиты (ОСЗ)';

COMMENT ON COLUMN SOCIAL_AGENCY.AGENCY_ID  IS 'Уникальный номер ОСЗ';
COMMENT ON COLUMN SOCIAL_AGENCY.NAME       IS 'Название ОСЗ';
COMMENT ON COLUMN SOCIAL_AGENCY.BRANCH     IS 'Код подразделения';
COMMENT ON COLUMN SOCIAL_AGENCY.DEBIT_ACC  IS 'Внутр. номер счета дебеторской  задолженности';
COMMENT ON COLUMN SOCIAL_AGENCY.CREDIT_ACC IS 'Внутр. номер счета кредиторской задолженности';
COMMENT ON COLUMN SOCIAL_AGENCY.CARD_ACC   IS 'Внутр. номер карточного счета';
COMMENT ON COLUMN SOCIAL_AGENCY.CONTRACT   IS '№ договора';
COMMENT ON COLUMN SOCIAL_AGENCY.DATE_ON    IS 'Дата начала действия договора';
COMMENT ON COLUMN SOCIAL_AGENCY.DATE_OFF   IS 'Дата завершения договора';
COMMENT ON COLUMN SOCIAL_AGENCY.ADDRESS    IS 'Адрес органа соц. защиты';
COMMENT ON COLUMN SOCIAL_AGENCY.PHONE      IS 'Телефон ОСЗ';
COMMENT ON COLUMN SOCIAL_AGENCY.DETAILS    IS 'Коментар';
COMMENT ON COLUMN SOCIAL_AGENCY.TYPE_ID    IS 'Тип ОСЗ';
COMMENT ON COLUMN SOCIAL_AGENCY.COMISS_ACC IS 'Внутр. номер счета доходов от РКО';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant DELETE,INSERT,SELECT,UPDATE on SOCIAL_AGENCY to BARS_ACCESS_DEFROLE;
grant SELECT                      on SOCIAL_AGENCY to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE on SOCIAL_AGENCY to DPT_ROLE;
grant DELETE,INSERT,SELECT,UPDATE on SOCIAL_AGENCY to WR_ALL_RIGHTS;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
