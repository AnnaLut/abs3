-- ======================================================================================
-- Module : NBUR
-- Author : 
-- Date   : 18.12.2018
-- ======================================================================================
-- create table NBUR_LOG_F3PX
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_LOG_F3PX
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F3PX', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F3PX', 'FILIAL',  'M', NULL,  'E',  'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F3PX', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_F3PX
( REPORT_DATE     date       constraint CC_NBURLOGF3PX_REPORTDT_NN NOT NULL
, KF              char(6)    constraint CC_NBURLOGF3PX_KF_NN       NOT NULL
, NBUC            VARCHAR2(20 CHAR)     
, VERSION_ID	  NUMBER
, EKP             VARCHAR2(6 CHAR)
, KU              NUMBER(3)
, K020            VARCHAR2(10 CHAR)
, K040            VARCHAR2(3 CHAR)
, R030_1          VARCHAR2(3 CHAR)
, R030_2          VARCHAR2(3 CHAR)
, S050            VARCHAR2(1 CHAR)
, S184            VARCHAR2(1 CHAR)
, F009            VARCHAR2(1 CHAR)
, F010            VARCHAR2(1 CHAR)
, F011            VARCHAR2(1 CHAR)
, F012            VARCHAR2(1 CHAR)
, F014            VARCHAR2(1 CHAR)
, F028            VARCHAR2(1 CHAR)
, F036            VARCHAR2(1 CHAR)
, F045            VARCHAR2(1 CHAR)
, F047            VARCHAR2(1 CHAR)
, F048            VARCHAR2(1 CHAR)
, F050            VARCHAR2(2 CHAR)
, F052            VARCHAR2(1 CHAR)
, F054            VARCHAR2(1 CHAR)
, F055            VARCHAR2(1 CHAR)
, F070            VARCHAR2(1 CHAR)
, Q001_1          VARCHAR2(255 CHAR)
, Q001_2          VARCHAR2(255 CHAR)
, Q001_3          VARCHAR2(255 CHAR)
, Q001_4          VARCHAR2(255 CHAR)
, Q003_1          VARCHAR2(64 CHAR)
, Q003_2          VARCHAR2(5 CHAR)
, Q003_3          VARCHAR2(1 CHAR)
, Q006            VARCHAR2(255 CHAR)
, Q007_1          VARCHAR2(10 CHAR)
, Q007_2          VARCHAR2(10 CHAR)
, Q007_3          VARCHAR2(10 CHAR)
, Q007_4          VARCHAR2(10 CHAR)
, Q007_5          VARCHAR2(10 CHAR)
, Q007_6          VARCHAR2(10 CHAR)
, Q007_7          VARCHAR2(10 CHAR)
, Q007_8          VARCHAR2(10 CHAR)
, Q007_9          VARCHAR2(10 CHAR)
, Q009            VARCHAR2(255 CHAR)
, Q010_1          VARCHAR2(2 CHAR)
, Q010_2          VARCHAR2(1 CHAR)
, Q010_3          VARCHAR2(4 CHAR)
, Q011_1          VARCHAR2(2 CHAR)
, Q011_2          VARCHAR2(2 CHAR)
, Q012_1          VARCHAR2(15 CHAR)
, Q012_2          VARCHAR2(15 CHAR)
, Q013            VARCHAR2(10 CHAR)
, Q021            NUMBER(38)
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

  dbms_output.put_line( 'Table "NBUR_LOG_F3PX" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F3PX" already exists.' );
end;
/
SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F3PX' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table NBUR_LOG_F3PX is '3PX Дані про окремий зовнішній державний борг та приватний борг, що гарантований державою';

comment on column NBUR_LOG_F3PX.REPORT_DATE is 'Звiтна дата';
comment on column NBUR_LOG_F3PX.KF is 'Код фiлiалу (МФО)';
comment on column NBUR_LOG_F3PX.NBUC is 'Код областi розрiзу юридичної особи';
comment on column NBUR_LOG_F3PX.VERSION_ID is 'Ід. версії файлу';
comment on column NBUR_LOG_F3PX.EKP   is 'Код показника';
comment on column NBUR_LOG_F3PX.KU    is 'Територія';
comment on column NBUR_LOG_F3PX.K020 is 'Код позичальника';
comment on column NBUR_LOG_F3PX.K040 is 'Код країни';
comment on column NBUR_LOG_F3PX.R030_1 is 'Валюта (кредиту)';
comment on column NBUR_LOG_F3PX.R030_2 is 'Валюта (розрахунку)';
comment on column NBUR_LOG_F3PX.S050 is 'Код типу строковості';
comment on column NBUR_LOG_F3PX.S184 is 'Початковий строк погашення';
comment on column NBUR_LOG_F3PX.F009 is 'Код  типу джерела фінансування';        
comment on column NBUR_LOG_F3PX.F010 is 'Код типу угоди';
comment on column NBUR_LOG_F3PX.F011 is 'Код графіка погашення платежів';
comment on column NBUR_LOG_F3PX.F012 is 'Код типу форми власності';
comment on column NBUR_LOG_F3PX.F014 is 'Код виду подання звіту';
comment on column NBUR_LOG_F3PX.F028   is 'Вид заборгованості';
comment on column NBUR_LOG_F3PX.F036   is 'Код використання процентної ставки';
comment on column NBUR_LOG_F3PX.F045   is 'Ознака кредита';
comment on column NBUR_LOG_F3PX.F047   is 'Код виду позичальника';
comment on column NBUR_LOG_F3PX.F048   is 'Тип відсоткової ставки за кредитом';
comment on column NBUR_LOG_F3PX.F050   is 'Цілі використання кредиту';
comment on column NBUR_LOG_F3PX.F052   is 'Тип кредитора';
comment on column NBUR_LOG_F3PX.F054   is 'Періодичність здійснення платежів';
comment on column NBUR_LOG_F3PX.F055   is 'Код типу кредиту';
comment on column NBUR_LOG_F3PX.F070   is 'Код типу реорганізації';
comment on column NBUR_LOG_F3PX.Q001_1 is 'назва позичальника/клієнта банку';
comment on column NBUR_LOG_F3PX.Q001_2 is 'назва організації, установи, що гарантує обслуговування зобов’язання з боку позичальника';
comment on column NBUR_LOG_F3PX.Q001_3 is 'назва кредитора';
comment on column NBUR_LOG_F3PX.Q001_4 is 'назва організації, установи, що виступає гарантом обслуговування зобов’язання з боку кредитора';
comment on column NBUR_LOG_F3PX.Q003_1 is 'номер  договору';
comment on column NBUR_LOG_F3PX.Q003_2 is 'номер реєстраційного свідоцтва, видане НБУ';
comment on column NBUR_LOG_F3PX.Q003_3 is 'порядковий номер траншу (операції з одержання кредиту в межах кредитної лінії)';
comment on column NBUR_LOG_F3PX.Q006   is 'примітка з додатковими роз’ясненнями у разі потреби';
comment on column NBUR_LOG_F3PX.Q007_1 is 'дата першого амортизаційного платежу';
comment on column NBUR_LOG_F3PX.Q007_2 is 'дата останнього амортизаційного платежу';
comment on column NBUR_LOG_F3PX.Q007_3 is 'початкова дата періоду консолідації';
comment on column NBUR_LOG_F3PX.Q007_4 is 'кінцева дата періоду консолідації';            
comment on column NBUR_LOG_F3PX.Q007_5 is 'дата укладання угоди про надання кредиту';
comment on column NBUR_LOG_F3PX.Q007_6 is 'дата першого платежу за процентами';
comment on column NBUR_LOG_F3PX.Q007_7 is 'дата останнього платежу за процентами';
comment on column NBUR_LOG_F3PX.Q007_8 is 'дата, починаючи з якої проценти сплачуються за другою процентною ставкою або використовується друге значення маржі';
comment on column NBUR_LOG_F3PX.Q007_9 is 'дата реєстрації договору в Національному банку';
comment on column NBUR_LOG_F3PX.Q009   is 'мета позики';
comment on column NBUR_LOG_F3PX.Q010_1 is 'період часу (у місяцях) між одержанням кожної частини кредиту та першим амортизаційним платежем';
comment on column NBUR_LOG_F3PX.Q010_2 is 'період по місяцях, на які надається прогноз платежів за заборгованістю перед нерезидентами';
comment on column NBUR_LOG_F3PX.Q010_3 is 'період по роках, на які надається прогноз платежів за заборгованістю перед нерезидентами';
comment on column NBUR_LOG_F3PX.Q011_1 is 'кількість амортизаційних платежів за кожним надходженням за борговим зобов’язанням за рік';
comment on column NBUR_LOG_F3PX.Q011_2 is 'кількість платежів за рік (за основною сумою та відсотками залежно від типу платежу за класифікатором-параметром)';
comment on column NBUR_LOG_F3PX.Q012_1 is 'база 1 для обчислення плаваючої процентної ставки за кредитом';
comment on column NBUR_LOG_F3PX.Q012_2 is 'база 2 для обчислення плаваючої процентної ставки за кредитом';
comment on column NBUR_LOG_F3PX.Q013   is 'розмір маржі процентної ставки за кредитом';
comment on column NBUR_LOG_F3PX.Q021   is 'сума угоди за договором з нерезидентом';
comment on column NBUR_LOG_F3PX.T071   is 'сума';
comment on column NBUR_LOG_F3PX.DESCRIPTION is 'Опис (коментар)';
comment on column NBUR_LOG_F3PX.ACC_ID is 'Ід. рахунка';
comment on column NBUR_LOG_F3PX.ACC_NUM is 'Номер рахунка';
comment on column NBUR_LOG_F3PX.KV is 'Ід. валюти';
comment on column NBUR_LOG_F3PX.MATURITY_DATE is 'Дата Погашення';
comment on column NBUR_LOG_F3PX.CUST_ID is 'Ід. клієнта';
comment on column NBUR_LOG_F3PX.REF is 'Ід. платіжного документа';
comment on column NBUR_LOG_F3PX.ND is 'Ід. договору';
comment on column NBUR_LOG_F3PX.BRANCH is 'Код підрозділу';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on NBUR_LOG_F3PX to BARSUPL;
grant SELECT on NBUR_LOG_F3PX to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F3PX to BARSREADER_ROLE;
