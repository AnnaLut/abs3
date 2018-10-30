-- ======================================================================================
-- Module   : SOC - Вклады пенсионеров и безработных
-- Author   : INNA
-- Modifier : BAA
-- Date     : 24.07.2018
-- ======================================================================================
-- create table DPT_FILE_HEADER
-- ======================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        200
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table DPT_FILE_HEADER
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'DPT_FILE_HEADER', 'WHOLE',  Null, Null, Null, Null );
  BPA.ALTER_POLICY_INFO( 'DPT_FILE_HEADER', 'FILIAL',  'M',  'M',  'M',  'M' );
  BPA.ALTER_POLICY_INFO( 'DPT_FILE_HEADER', 'CENTER' , Null, 'E',  'E',  'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table DPT_FILE_HEADER
( KF              VARCHAR2(6)   DEFAULT sys_context('bars_context','user_mfo') 
                                constraint CC_DPTFILEHDR_KF_NN         NOT NULL
, HEADER_ID       NUMBER(38)    constraint CC_DPTFILEHDR_HDRID_NN      NOT NULL
, FILENAME        VARCHAR2(16)  constraint CC_DPTFILEHDR_FILENAME_NN   NOT NULL
, HEADER_LENGTH   NUMBER(3)     constraint CC_DPTFILEHDR_HDRLEN_NN     NOT NULL
, DAT             DATE          constraint CC_DPTFILEHDR_DAT_NN        NOT NULL
, INFO_LENGTH     NUMBER(6)
, MFO_A           VARCHAR2(15)  constraint CC_DPTFILEHDR_MFOA_NN       NOT NULL
, NLS_A           VARCHAR2(15)  constraint CC_DPTFILEHDR_NLSA_NN       NOT NULL
, MFO_B           VARCHAR2(15)  constraint CC_DPTFILEHDR_MFOB_NN       NOT NULL
, NLS_B           VARCHAR2(15)  constraint CC_DPTFILEHDR_NLSB_NN       NOT NULL
, DK              NUMBER(1)     constraint CC_DPTFILEHDR_DK_NN         NOT NULL
, SUM             NUMBER(19)
, TYPE            NUMBER(2)     constraint CC_DPTFILEHDR_TYPE_NN       NOT NULL
, NUM             VARCHAR2(12)
, HAS_ADD         VARCHAR2(1)
, NAME_A          VARCHAR2(27)  constraint CC_DPTFILEHDR_NAMEA_NN      NOT NULL
, NAME_B          VARCHAR2(27)  constraint CC_DPTFILEHDR_NAMEB_NN      NOT NULL
, NAZN            VARCHAR2(160)
, BRANCH_CODE     NUMBER(5)
, DPT_CODE        NUMBER(3)     constraint CC_DPTFILEHDR_DPTCODE_NN    NOT NULL
, EXEC_ORD        VARCHAR2(10)
, KS_EP           VARCHAR2(32)
, BRANCH          VARCHAR2(30)  DEFAULT sys_context('bars_context','user_branch')
                                constraint CC_DPTFILEHDR_BRANCH_NN     NOT NULL
, TYPE_ID         NUMBER(38)    constraint CC_DPTFILEHDR_TYPEID_NN     NOT NULL
, AGENCY_TYPE     NUMBER(38)
, FILE_VERSION    VARCHAR2(1)   DEFAULT '1'
, RECHECK_AGENCY  NUMBER(1)     DEFAULT  1
, USR_ID          NUMBER(38)    constraint CC_DPTFILEHEADER_USRID_NN   NOT NULL
, constraint PK_DPTFILEHDR primary key (HEADER_ID) using index tablespace BRSBIGI
, constraint FK_DPTFILEHDR_SOCIALFTYPES foreign key (TYPE_ID)     references SOCIAL_FILE_TYPES  (TYPE_ID)
, constraint FK_DPTFILEHDR_SOCAGNCTP    foreign key (AGENCY_TYPE) references SOCIAL_AGENCY_TYPE (TYPE_ID)
, constraint FK_DPTFILEHDR_BRANCH       foreign key (BRANCH)      references BRANCH             (BRANCH)
, constraint FK_DPTFILEHEADER_STAFF     foreign key ( USR_ID )    references STAFF$BASE         (ID)
) tablespace BRSBIGD ]';
  
  dbms_output.put_line( 'Table "DPT_FILE_HEADER" created.' );
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "DPT_FILE_HEADER" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

begin
  execute immediate q'[create unique index UK_DPTFILEHEADER on DPT_FILE_HEADER ( KF, HEADER_ID )
  TABLESPACE BRSBIGI
  PCTFREE 0
  COMPRESS 1 ]';
  dbms_output.put_line( 'Index "UK_DPTFILEHEADER" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "UK_DPTFILEHEADER" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line( 'Column(s) "KF", "HEADER_ID" already indexed.' );
      else raise;
    end case;
end;
/

begin
  execute immediate q'[create index DPTFILEHDR_BRANCH ON DPT_FILE_HEADER ( BRANCH )
  TABLESPACE BRSBIGI ]';
  dbms_output.put_line( 'Index "DPTFILEHDR_BRANCH" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "DPTFILEHDR_BRANCH" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line( 'Column "BRANCH" already indexed.' );
      else raise;
    end case;
end;
/

begin
  execute immediate q'[create index DPTFILEHDR_KF_DAT_TPID_USRID on DPT_FILE_HEADER ( KF, DAT, TYPE_ID, USR_ID ) tablespace BRSBIGI]';
  dbms_output.put_line( 'Index "DPTFILEHDR_KF_DAT_TPID_USRID" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "DPTFILEHDR_KF_DAT_TPID_USRID" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line( 'Columns "KF", "DAT", "TYPE_ID", "USR_ID" already indexed.' );
      else raise;
    end case;
end;
/

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate q'[create index DPTFILEHDR_FILENM_SUM_INFLEN on DPT_FILE_HEADER ( KF, FILENAME, SUM, INFO_LENGTH )
  tablespace BRSBIGI
  COMPRESS 1 ]';
  dbms_output.put_line( 'Index "DPTFILEHDR_FILENM_SUM_INFLEN" created.' );
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
  BPA.ALTER_POLICIES( 'DPT_FILE_HEADER' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  DPT_FILE_HEADER               IS 'Структура заголовку файла обміну';

COMMENT ON COLUMN DPT_FILE_HEADER.FILENAME      IS 'Найменування файлу';
COMMENT ON COLUMN DPT_FILE_HEADER.HEADER_LENGTH IS 'Довжина заголовка';
COMMENT ON COLUMN DPT_FILE_HEADER.DAT           IS 'Дата створення файлу';
COMMENT ON COLUMN DPT_FILE_HEADER.INFO_LENGTH   IS 'Кiлькiсть iнформацiйних рядкiв';
COMMENT ON COLUMN DPT_FILE_HEADER.MFO_A         IS 'МФО банку-платника';
COMMENT ON COLUMN DPT_FILE_HEADER.NLS_A         IS 'Рахунок платника';
COMMENT ON COLUMN DPT_FILE_HEADER.MFO_B         IS 'МФО банку-одержувача';
COMMENT ON COLUMN DPT_FILE_HEADER.NLS_B         IS 'Рахунок одержувача';
COMMENT ON COLUMN DPT_FILE_HEADER.DK            IS 'Ознака "дебет/кредит" платежу';
COMMENT ON COLUMN DPT_FILE_HEADER.SUM           IS 'Сума (в коп.) платежу';
COMMENT ON COLUMN DPT_FILE_HEADER.TYPE          IS 'Вид платежу';
COMMENT ON COLUMN DPT_FILE_HEADER.NUM           IS 'Номер (операцiйний) платежу';
COMMENT ON COLUMN DPT_FILE_HEADER.HAS_ADD       IS 'Ознака наявностi додатку до платежу';
COMMENT ON COLUMN DPT_FILE_HEADER.NAME_A        IS 'Найменування платника';
COMMENT ON COLUMN DPT_FILE_HEADER.NAME_B        IS 'Найменування одержувача';
COMMENT ON COLUMN DPT_FILE_HEADER.NAZN          IS 'Призначення платежу';
COMMENT ON COLUMN DPT_FILE_HEADER.BRANCH_CODE   IS 'Номер філії';
COMMENT ON COLUMN DPT_FILE_HEADER.DPT_CODE      IS 'Код вкладу';
COMMENT ON COLUMN DPT_FILE_HEADER.EXEC_ORD      IS 'Режими обробки';
COMMENT ON COLUMN DPT_FILE_HEADER.KS_EP         IS 'КС або ЕП';
COMMENT ON COLUMN DPT_FILE_HEADER.FILE_VERSION  IS 'Чи потрібно перепроставляти код органа соц. захисту при зміні відділення: 1 - так, 0 - ні';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT INSERT, SELECT, UPDATE ON DPT_FILE_HEADER TO BARS_ACCESS_DEFROLE;
GRANT SELECT                 ON DPT_FILE_HEADER TO BARS_DM;
GRANT SELECT                 ON DPT_FILE_HEADER TO BARSREADER_ROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
