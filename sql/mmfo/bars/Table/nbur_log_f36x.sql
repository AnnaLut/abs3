-- ======================================================================================
-- Module : NBUR
-- Author : Virko
-- Date   : 24/10/2018
-- ======================================================================================
-- create table NBUR_LOG_F36X
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_LOG_F36X
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F36X', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F36X', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table NBUR_LOG_F36X';
exception
  when e_tab_not_exists then null;  
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_F36X
( REPORT_DATE     date       constraint CC_NBURLOGF36X_REPORTDT_NN NOT NULL
, KF              char(6)    constraint CC_NBURLOGF36X_KF_NN       NOT NULL
, VERSION_ID      NUMBER
, NBUC            VARCHAR2(20 CHAR)     
, EKP             char(6)
, KU              number(3)
, B040            varchar2(20 CHAR)      
, F021            varchar2(1 CHAR)      
, K020            varchar2(10 CHAR)      
, K021            varchar2(1 CHAR)  
, Q001_1          varchar2(135 CHAR)
, Q001_2          varchar2(135 CHAR)
, Q002            varchar2(135 CHAR)
, Q003_2          varchar2(4 CHAR)
, Q003_3          varchar2(35 CHAR)
, Q007_1          date
, Q007_2          date
, Q007_3          date
, Q007_4          date
, Q007_5          date
, K040            varchar2(3 CHAR)      
, D070            varchar2(1 CHAR)      
, F008            varchar2(1 CHAR)      
, K112            varchar2(1 CHAR)      
, F019            varchar2(1 CHAR)      
, F020            varchar2(1 CHAR)      
, R030            varchar2(3 CHAR)      
, Q023            varchar2(20 CHAR)      
, Q006            varchar2(3 CHAR)
, T070            number(24)
, T071            number(24)
, ACC_ID          number(38)
, ACC_NUM         VARCHAR2(20)
, KV              NUMBER(3)
, CUST_ID         number(38)
, BRANCH          VARCHAR2(30)     
) tablespace BRSBIGD
COMPRESS BASIC
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
( PARTITION P_MINVALUE VALUES LESS THAN ( TO_DATE('01/01/2018','DD/MM/YYYY') ) )]';

  dbms_output.put_line( 'Table "NBUR_LOG_F36X" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F36X" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table NBUR_LOG_F36X add ACC_ID number(38)]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists
  then null;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F36X' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  NBUR_LOG_F36X             is 'Щомісячні знімки балансу РУ на звітну дату  (архів версій)';

comment on column NBUR_LOG_F36X.REPORT_DATE is 'Звітна дата';
comment on column NBUR_LOG_F36X.KF          is 'Код фiлiалу (МФО)';
comment on column NBUR_LOG_F36X.VERSION_ID  is 'Ідентифікатор версії';
comment on column NBUR_LOG_F36X.EKP         is 'Код показника';
comment on column NBUR_LOG_F36X.KU          is 'Код областi розрiзу юридичної особи';
comment on column NBUR_LOG_F36X.B040        is 'Код стуктурного підрозділу';
comment on column NBUR_LOG_F36X.F021        is 'Код повідомлення про взяття на контроль/зняття з контролю';        
comment on column NBUR_LOG_F36X.K020        is 'Код резидента';        
comment on column NBUR_LOG_F36X.K021        is 'Ознака коду';        
comment on column NBUR_LOG_F36X.Q001_1      is 'Повне найменування резидента';        
comment on column NBUR_LOG_F36X.Q001_2      is 'Повне найменування нерезидента (згідно з контрактом)';        
comment on column NBUR_LOG_F36X.Q002        is 'Місцезнаходження резидента';        
comment on column NBUR_LOG_F36X.Q003_2      is 'Умовний порядковий номер контракта';        
comment on column NBUR_LOG_F36X.Q003_3      is 'Номер зовнішньоекономічного контракту';        
comment on column NBUR_LOG_F36X.Q007_1      is 'Дата укладення зовнішньоекономічного контракту';        
comment on column NBUR_LOG_F36X.Q007_2      is 'Дата першого дня перевищення строку розрахунків';        
comment on column NBUR_LOG_F36X.Q007_3      is 'Дата внесення змін до інформації';        
comment on column NBUR_LOG_F36X.Q007_4      is 'Дата зняття резидента з контролю';        
comment on column NBUR_LOG_F36X.Q007_5      is 'Дата відвантаження продукції відповідно до митних декларацій або дата виконання відповідного платіжного доручення';        
comment on column NBUR_LOG_F36X.K040        is 'Код країни нерезидента';        
comment on column NBUR_LOG_F36X.D070        is 'Код зовнішньоекономічної операції клієнта';        
comment on column NBUR_LOG_F36X.F008        is 'Код  змісту зовнішньоекономічної операції клієнта';        
comment on column NBUR_LOG_F36X.K112        is 'Код секції виду економічної діяльності';        
comment on column NBUR_LOG_F36X.F019        is 'Код причини виникнення заборгованості';        
comment on column NBUR_LOG_F36X.F020        is 'Код відмітки про безнадійну заборгованість резидентів за зовнішньоекономічним контрактом';        
comment on column NBUR_LOG_F36X.R030        is 'Код валюти розрахунку';        
comment on column NBUR_LOG_F36X.Q023        is 'Код підрозділу банку, який ліквідовано';        
comment on column NBUR_LOG_F36X.T071        is 'Сума неповернених коштів у валюті';        
comment on column NBUR_LOG_F36X.T070        is 'Сума неповернених коштів у гривневому еквіваленті';        
comment on column NBUR_LOG_F36X.Q006        is 'Примітка';        

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on NBUR_LOG_F36X to BARSUPL;
grant SELECT on NBUR_LOG_F36X to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F36X to BARSREADER_ROLE;
