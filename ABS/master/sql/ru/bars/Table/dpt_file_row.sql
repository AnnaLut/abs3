-- ======================================================================================
-- Module   : SOC - Вклады пенсионеров и безработных
-- Author   : INNA
-- Modifier : BAA
-- Date     : 25.05.2015
-- ======================================================================================
-- create table DPT_FILE_ROW
-- ======================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        500
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table DPT_FILE_ROW
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'DPT_FILE_ROW', 'WHOLE',  Null, Null, Null, Null );
  BPA.ALTER_POLICY_INFO( 'DPT_FILE_ROW', 'FILIAL',  'M',  'M',  'M',  'M' );
  BPA.ALTER_POLICY_INFO( 'DPT_FILE_ROW', 'CENTER' , Null, 'E',  'E',  'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table DPT_FILE_ROW
( INFO_ID           number(18)    constraint CC_DPTFILEROW_INFOID_NN      NOT NULL
, KF                varchar2(6)   default SYS_CONTEXT('BARS_CONTEXT','USER_MFO')
                                  CONSTRAINT CC_DPTFILEROW_KF_NN          NOT NULL
, HEADER_ID         number(38)    CONSTRAINT CC_DPTFILEROW_HDRID_NN       NOT NULL
, FILENAME          varchar2(16)  CONSTRAINT CC_DPTFILEROW_FILENAME_NN    NOT NULL
, DAT               date          CONSTRAINT CC_DPTFILEROW_DAT_NN         NOT NULL
, NLS               varchar2(19)  CONSTRAINT CC_DPTFILEROW_NLS_NN         NOT NULL
, BRANCH_CODE       number(5)     CONSTRAINT CC_DPTFILEROW_BRANCHCODE_NN  NOT NULL
, DPT_CODE          number(3)     CONSTRAINT CC_DPTFILEROW_DPTCODE_NN     NOT NULL
, SUM               number(19)
, FIO               varchar2(100) CONSTRAINT CC_DPTFILEROW_FIO_NN         NOT NULL
, PASP              varchar2(16)
, BRANCH            varchar2(30)  DEFAULT sys_context('bars_context','user_branch')
                                  CONSTRAINT CC_DPTFILEROW_BRANCH_NN      NOT NULL
, REF               number(38)
, INCORRECT         number(1)     default 0
                                  CONSTRAINT CC_DPTFILEROW_INCORRECT_NN   NOT NULL
, CLOSED            number(1)     default 0
                                  CONSTRAINT CC_DPTFILEROW_CLOSED_NN      NOT NULL
, EXCLUDED          number(1)     default 0
                                  CONSTRAINT CC_DPTFILEROW_EXCLUDED_NN    NOT NULL
, AGENCY_ID         number(38)
, AGENCY_NAME       varchar2(100)
, ID_CODE           varchar2(10)
, FILE_PAYOFF_DATE  varchar2(2)
, PAYOFF_DATE       date
, MARKED4PAYMENT    number(1)     default 0
                                  CONSTRAINT CC_DPTFILEROW_MARKED4PYMT_NN NOT NULL
, DEAL_CREATED      number(1)     default 0
                                  CONSTRAINT CC_DPTFILEROW_DEALCREATED_NN NOT NULL
, ACC_TYPE          char(3)
, ERR_MSG           varchar2(256)
, constraint CC_DPTFILEROW_DEALCREATED    check ( DEAL_CREATED   in ( 0, 1 ) )
, constraint CC_DPTFILEROW_MARKED4PAYMENT check ( MARKED4PAYMENT in ( 0, 1 ) )
, constraint PK_DPTFILEROW               primary key ( INFO_ID   ) using index tablespace BRSBIGI
, constraint FK_DPTFILEROW_AGENCYID      foreign key ( AGENCY_ID ) references SOCIAL_AGENCY (AGENCY_ID)
, constraint FK_DPTFILEROW_BRANCH        foreign key ( BRANCH    ) references BRANCH (BRANCH) deferrable initially immediate
, constraint FK_DPTFILEROW_DPTFILEHEADER foreign key ( HEADER_ID ) references DPT_FILE_HEADER (HEADER_ID)
, constraint FK_DPTFILEROW_OPER          foreign key ( REF       ) references OPER (REF)
, constraint FK_DPTFILEROW_TIPS          foreign key ( ACC_TYPE  ) references TIPS (TIP)
) tablespace BRSBIGD ]';
  
  dbms_output.put_line( 'Table "DPT_FILE_ROW" created.' );
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "DPT_FILE_ROW" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

begin
  execute immediate q'[create unique index UK_DPTFILEROW ON DPT_FILE_ROW ( KF, INFO_ID )
  tablespace BRSBIGI ]';
  dbms_output.put_line( 'Index "UK_DPTFILEROW" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "UK_DPTFILEROW" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line( 'Column "KF", "INFO_ID" already indexed.' );
      else raise;
    end case;
end;
/

begin
  execute immediate q'[create index IDX_DPTFILEROW_KF_HDRID on DPT_FILE_ROW ( HEADER_ID, KF ) tablespace BRSBIGI]';
  dbms_output.put_line( 'Index "IDX_DPTFILEROW_KF_HDRID" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "IDX_DPTFILEROW_KF_HDRID" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line( 'Column(s) "HEADER_ID", "KF" already indexed.' );
      else raise;
    end case;
end;
/

begin
  execute immediate q'[create unique index UK_DPTFILEROW_REF ON DPT_FILE_ROW ( REF )
  tablespace BRSBIGI ]';
  dbms_output.put_line( 'Index "UK_DPTFILEROW_REF" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "UK_DPTFILEROW_REF" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line( 'Column "REF" already indexed.' );
      else raise;
    end case;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  BPA.ALTER_POLICIES( 'DPT_FILE_ROW' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  DPT_FILE_ROW                  is 'Структура тела файла зачисления пенсий и мат.помощи';

comment on column DPT_FILE_ROW.KF               is 'Код фiлiалу (МФО)';
comment on column DPT_FILE_ROW.INFO_ID          is 'Код рядка';
comment on column DPT_FILE_ROW.REF              is 'Референс породженого документа';
comment on column DPT_FILE_ROW.INCORRECT        is '0 - коректный; 1 - некоректный';
comment on column DPT_FILE_ROW.CLOSED           is '0 - діючий; 1 - закритий';
comment on column DPT_FILE_ROW.EXCLUDED         is '0 - не исключенный; 1 - исключенный';
comment on column DPT_FILE_ROW.FILENAME         is 'Найменування файлу';
comment on column DPT_FILE_ROW.DAT              is 'Дата створення файлу';
comment on column DPT_FILE_ROW.NLS              is 'Номер рахунку вкладника';
comment on column DPT_FILE_ROW.BRANCH_CODE      is 'Номер філії';
comment on column DPT_FILE_ROW.DPT_CODE         is 'Код вкладу';
comment on column DPT_FILE_ROW.SUM              is 'Сума (в коп.)';
comment on column DPT_FILE_ROW.FIO              is 'Прiзвище,iм`я, по батьковi';
comment on column DPT_FILE_ROW.PASP             is 'Серiя та номер паспорта';
comment on column DPT_FILE_ROW.ID_CODE          is 'Ідентифікаційний код (для перевірок НЕ використовується)';
comment on column DPT_FILE_ROW.FILE_PAYOFF_DATE is 'Дата проплати з файла (2 символи)';
comment on column DPT_FILE_ROW.PAYOFF_DATE      is 'Дата проплати фактична';
comment on column DPT_FILE_ROW.MARKED4PAYMENT   is 'Відмічений до оплати ( 0 - ні, 1 - так)';
comment on column DPT_FILE_ROW.DEAL_CREATED     is 'Ознака того, що при прийомі стрічки було створеного нового клієнта та новий договір (1 - так, 0 - ні)';
comment on column DPT_FILE_ROW.ERR_MSG          is 'Повідомлення про помилку';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT DELETE, INSERT, SELECT, UPDATE ON DPT_FILE_ROW TO BARS_ACCESS_DEFROLE;
GRANT                 SELECT         ON DPT_FILE_ROW TO BARS_DM;
GRANT DELETE, INSERT, SELECT, UPDATE ON DPT_FILE_ROW TO DPT_ROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
