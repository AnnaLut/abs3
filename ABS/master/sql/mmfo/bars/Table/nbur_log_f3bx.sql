
PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Table/nbur_log_f3bx.sql ======= *** Run *** ===
PROMPT ===================================================================================== 


SET FEEDBACK     OFF

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F3BX', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F3BX', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_F3BX
( REPORT_DATE     date       constraint CC_NBURLOGF3BX_REPORTDT_NN		NOT NULL
, KF              char(6)    constraint CC_NBURLOGF3BX_KF_NN			NOT NULL
, NBUC            VARCHAR2(20 CHAR)     
, VERSION_ID	  NUMBER
, EKP             VARCHAR2(6 CHAR)  constraint CC_NBURLOGF3BX_EKP_NN		NOT NULL
, T100            NUMBER(38,3) --згідно XSD
, F059            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF3BX_F059_NN		NOT NULL 
, F060            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF3BX_F060_NN		NOT NULL 
, F061            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF3BX_F061_NN		NOT NULL 
, K111            VARCHAR2(2 CHAR)  constraint CC_NBURLOGF3BX_K111_NN		NOT NULL 
, K031            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF3BX_K031_NN		NOT NULL 
, F063            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF3BX_F063_NN		NOT NULL 
, F064            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF3BX_F064_NN		NOT NULL 
, S190            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF3BX_S190_NN		NOT NULL 
, F073            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF3BX_F073_NN		NOT NULL 
, F003            VARCHAR2(1 CHAR)  constraint CC_NBURLOGF3BX_F003_NN		NOT NULL 
, Q001            VARCHAR2(250 CHAR)  
, K020            VARCHAR2(10 CHAR) constraint CC_NBURLOGF3BX_K020_NN		NOT NULL 
, Q026            VARCHAR2(3 CHAR) 
, DESCRIPTION     VARCHAR2(250)
, CUST_ID         NUMBER(38)     
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

  dbms_output.put_line( 'Table "NBUR_LOG_F3BX" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F3BX" already exists.' );
end;
/
SET FEEDBACK ON

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F3BX' );
end;
/

commit;

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_F3BX                 Comments

comment on table  NBUR_LOG_F3BX is '3BX Фінансова звітність боржників банку';
comment on column NBUR_LOG_F3BX.REPORT_DATE	is 'Звiтна дата';
comment on column NBUR_LOG_F3BX.KF		is 'Фiлiя';
comment on column NBUR_LOG_F3BX.VERSION_ID	is 'Номер версії файлу';
comment on column NBUR_LOG_F3BX.NBUC		is 'Код МФО';
comment on column NBUR_LOG_F3BX.EKP		is 'Код показника';
comment on column NBUR_LOG_F3BX.T100 is 'Сума';
comment on column NBUR_LOG_F3BX.F059 is 'Код розміру боржника';
comment on column NBUR_LOG_F3BX.F060 is 'Код типу періоду';
comment on column NBUR_LOG_F3BX.F061 is 'Код ознаки операції';
comment on column NBUR_LOG_F3BX.K111 is 'Код розділів видів економічної діяльності (узагальнені)';
comment on column NBUR_LOG_F3BX.K031 is 'Код ознаки територіального розміщення';
comment on column NBUR_LOG_F3BX.F063 is 'Код зміни стандарту складання звітності';
comment on column NBUR_LOG_F3BX.F064 is 'Код належності до групи юридичних осіб під спільним контролем';
comment on column NBUR_LOG_F3BX.S190 is 'Код строку прострочення погашення боргу';
comment on column NBUR_LOG_F3BX.F073 is 'Код належності до боржників, кредити яким надані для реалізації інвестиційного проекту';
comment on column NBUR_LOG_F3BX.F003 is 'Код стану заборгованості';
comment on column NBUR_LOG_F3BX.Q001 is 'Офіційне скорочене найменування боржника';
comment on column NBUR_LOG_F3BX.K020 is 'ЄДРПОУ юридичної особи';
comment on column NBUR_LOG_F3BX.Q026 is 'Належність боржника до групи пов’язаних контрагентів';
comment on column NBUR_LOG_F3BX.DESCRIPTION	is 'Опис (коментар)';
comment on column NBUR_LOG_F3BX.CUST_ID		is 'Ід. клієнта';
comment on column NBUR_LOG_F3BX.BRANCH		is 'Код підрозділу';

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_F3BX                   Grants

grant SELECT on NBUR_LOG_F3BX to BARSUPL;
grant SELECT on NBUR_LOG_F3BX to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F3BX to BARSREADER_ROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Table/nbur_log_F3BX.sql ======= *** End *** ===
PROMPT ===================================================================================== 
