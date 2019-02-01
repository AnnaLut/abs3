-- ======================================================================================
-- Module : NBUR
-- Author : 
-- Date   : 11.05.2018
-- ======================================================================================
-- create table NBUR_LOG_F4PX
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_LOG_F4PX
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F4PX', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F4PX', 'FILIAL',  'M', NULL,  'E',  'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F4PX', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_F4PX
( REPORT_DATE     date       constraint CC_NBURLOGF4PX_REPORTDT_NN NOT NULL
, KF              char(6)    constraint CC_NBURLOGF4PX_KF_NN       NOT NULL
, NBUC            VARCHAR2(20 CHAR)     
, VERSION_ID	  NUMBER
, EKP             VARCHAR2(6 CHAR)
, B040            VARCHAR2(20 CHAR)
, R020            VARCHAR2(4 CHAR)
, R030_1          VARCHAR2(3 CHAR)
, R030_2          VARCHAR2(3 CHAR)
, K040            VARCHAR2(3 CHAR)
, S050            VARCHAR2(1 CHAR)
, S184            VARCHAR2(1 CHAR)
, F028            VARCHAR2(1 CHAR)
, F045            VARCHAR2(1 CHAR)
, F046            VARCHAR2(1 CHAR)
, F047            VARCHAR2(1 CHAR)
, F048            VARCHAR2(1 CHAR)
, F049            VARCHAR2(1 CHAR)
, F050            VARCHAR2(2 CHAR)
, F052            VARCHAR2(1 CHAR)
, F053            VARCHAR2(1 CHAR)
, F054            VARCHAR2(1 CHAR)
, F055            VARCHAR2(1 CHAR)
, F056            VARCHAR2(1 CHAR)
, F057            VARCHAR2(3 CHAR)
, F070            VARCHAR2(1 CHAR)
, K020            VARCHAR2(10 CHAR)
, Q001_1          VARCHAR2(255 CHAR)
, Q001_2          VARCHAR2(255 CHAR)
, Q003_1          VARCHAR2(255 CHAR)
, Q003_2          VARCHAR2(5 CHAR)
, Q003_3          VARCHAR2(1 CHAR)
, Q006            VARCHAR2(255 CHAR)
, Q007_1          VARCHAR2(10 CHAR)
, Q007_2          VARCHAR2(10 CHAR)
, Q007_3          VARCHAR2(10 CHAR)
, Q010_1          VARCHAR2(1 CHAR)
, Q010_2          VARCHAR2(4 CHAR)
, Q012            VARCHAR2(15 CHAR)
, Q013            VARCHAR2(255 CHAR)
, Q021            NUMBER(38)
, Q022            NUMBER(38)
, T071            NUMBER          
, DESCRIPTION     VARCHAR2(250)
, ACC_ID          NUMBER(38)
, ACC_NUM         VARCHAR2(20)
, KV              NUMBER(3)
, MATURITY_DATE   DATE
, CUST_ID         NUMBER(38)     
, REF             NUMBER(38)
, ND              NUMBER(38)
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

  dbms_output.put_line( 'Table "NBUR_LOG_F4PX" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F4PX" already exists.' );
end;
/
SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F4PX' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table NBUR_LOG_F4PX is '4PX Дані про стан заборгованості, розрахунки та планові операції за кредитами та іншими зобов''язаннями з нерезидентами';

comment on column NBUR_LOG_F4PX.REPORT_DATE is 'Звiтна дата';
comment on column NBUR_LOG_F4PX.KF is 'Код фiлiалу (МФО)';
comment on column NBUR_LOG_F4PX.NBUC is 'Код областi розрiзу юридичної особи';
comment on column NBUR_LOG_F4PX.VERSION_ID is 'Ід. версії файлу';
comment on column NBUR_LOG_F4PX.EKP is 'Код показника';
comment on column NBUR_LOG_F4PX.B040 is 'Структурний підрозділ';
comment on column NBUR_LOG_F4PX.R020 is 'Балансовий рахунок';
comment on column NBUR_LOG_F4PX.R030_1 is 'Валюта кредиту';
comment on column NBUR_LOG_F4PX.R030_2 is 'Валюта розрахунку за кредитом';
comment on column NBUR_LOG_F4PX.K040 is 'Країни';
comment on column NBUR_LOG_F4PX.S050 is 'Код типу строковості';
comment on column NBUR_LOG_F4PX.S184 is 'Узагальнені коди';
comment on column NBUR_LOG_F4PX.F028 is 'Вид заборгованості';
comment on column NBUR_LOG_F4PX.F045 is 'Ознака кредита';
comment on column NBUR_LOG_F4PX.F046 is 'Стан розрахунків за кредитом';
comment on column NBUR_LOG_F4PX.F047 is 'Узагальнений тип позичальника';
comment on column NBUR_LOG_F4PX.F048 is 'Тип відсоткової ставки за кредитом';
comment on column NBUR_LOG_F4PX.F049 is 'Код пояснення щодо внесення змін до договору';
comment on column NBUR_LOG_F4PX.F050 is 'Цілі використання кредиту';
comment on column NBUR_LOG_F4PX.F052 is 'Тип кредитора';
comment on column NBUR_LOG_F4PX.F053 is 'Можливості дострокового погашення заборгованості';
comment on column NBUR_LOG_F4PX.F054 is 'Періодичність здійснення платежів';
comment on column NBUR_LOG_F4PX.F055 is 'Тип кредиту (інструмент кредитування)';
comment on column NBUR_LOG_F4PX.F056 is 'Підстави подання звіту';
comment on column NBUR_LOG_F4PX.F057 is 'Вид запозичення';
comment on column NBUR_LOG_F4PX.F070 is 'Код типу реорганізації';
comment on column NBUR_LOG_F4PX.K020 is 'Код позичальника';
comment on column NBUR_LOG_F4PX.Q001_1 is 'назва позичальника/клієнта банку';
comment on column NBUR_LOG_F4PX.Q001_2 is 'назва кредитора/кредитної лінії для гарантованих, негарантованих кредитів і кредитів у гривнях від ЄБРР';
comment on column NBUR_LOG_F4PX.Q003_1 is 'номер кредитної угоди';
comment on column NBUR_LOG_F4PX.Q003_2 is 'номер реєстрації договору Національним банком україни';
comment on column NBUR_LOG_F4PX.Q003_3 is 'порядковий номер траншу в межах відновлювальної кредитної лінії';
comment on column NBUR_LOG_F4PX.Q006 is 'примітка, що містить додаткову інформацію стосовно внесення змін до договору';
comment on column NBUR_LOG_F4PX.Q007_1 is 'дата підписання кредитної угоди';
comment on column NBUR_LOG_F4PX.Q007_2 is 'дата реєстрації договору Національним банком України';
comment on column NBUR_LOG_F4PX.Q007_3 is 'строк погашення кредиту';
comment on column NBUR_LOG_F4PX.Q010_1 is 'період по місяцях, на які надається прогноз платежів за заборгованістю перед нерезидентами';
comment on column NBUR_LOG_F4PX.Q010_2 is 'період по роках, на які надається прогноз платежів за заборгованістю перед нерезидентами';
comment on column NBUR_LOG_F4PX.Q012 is 'база для обчислення плаваючої ставки за кредитом';
comment on column NBUR_LOG_F4PX.Q013 is 'розмір маржі процентної ставки за кредитом';
comment on column NBUR_LOG_F4PX.Q021 is 'загальна сума кредиту за договором з нерезидентом';
comment on column NBUR_LOG_F4PX.Q022  is 'величина процентної ставки за основною сумою боргу';
comment on column NBUR_LOG_F4PX.T071 is 'сума';
comment on column NBUR_LOG_F4PX.DESCRIPTION is 'Опис (коментар)';
comment on column NBUR_LOG_F4PX.ACC_ID is 'Ід. рахунка';
comment on column NBUR_LOG_F4PX.ACC_NUM is 'Номер рахунка';
comment on column NBUR_LOG_F4PX.KV is 'Ід. валюти';
comment on column NBUR_LOG_F4PX.MATURITY_DATE is 'Дата Погашення';
comment on column NBUR_LOG_F4PX.CUST_ID is 'Ід. клієнта';
comment on column NBUR_LOG_F4PX.REF is 'Ід. платіжного документа';
comment on column NBUR_LOG_F4PX.ND is 'Ід. договору';
comment on column NBUR_LOG_F4PX.BRANCH is 'Код підрозділу';

begin
    execute immediate 'alter table bars.nbur_log_f4px add (Q022A  VARCHAR2(15))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
comment on column NBUR_LOG_F4PX.Q022A is 'процентна ставка за основною сумою боргу';


prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on NBUR_LOG_F4PX to BARSUPL;
grant SELECT on NBUR_LOG_F4PX to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F4PX to BARSREADER_ROLE;
