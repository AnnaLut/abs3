
PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Table/nbur_log_f95x.sql ======= *** Run *** ===
PROMPT ===================================================================================== 


SET FEEDBACK     OFF

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F95X', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F95X', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );      
begin
  execute immediate q'[create table NBUR_LOG_F95X
( REPORT_DATE	date       		constraint CC_NBURLOGF95X_REPORTDT_NN	NOT NULL
, KF		char(6)			constraint CC_NBURLOGF95X_KF_NN		NOT NULL
, NBUC		VARCHAR2(20 CHAR)     
, VERSION_ID	NUMBER
, EKP		VARCHAR2(6 CHAR)	constraint CC_NBURLOGF95X_EKP_NN	NOT NULL
, K030		VARCHAR2(1 CHAR)	constraint CC_NBURLOGF95X_K030_NN	NOT NULL 
, F051		VARCHAR2(1 CHAR)	constraint CC_NBURLOGF95X_F051_NN	NOT NULL 
, K020		VARCHAR2(10 CHAR)	constraint CC_NBURLOGF95X_K020_NN	NOT NULL 
, Q001		VARCHAR2(135 CHAR)	constraint CC_NBURLOGF95X_Q001_NN	NOT NULL 
, Q002		VARCHAR2(135 CHAR)
, Q003		VARCHAR2(3 CHAR)	constraint CC_NBURLOGF95X_Q003_NN	NOT NULL 
, Q007		date			constraint CC_NBURLOGF95X_Q007_NN	NOT NULL 
, T070		NUMBER(38)		constraint CC_NBURLOGF95X_T070_NN	NOT NULL	
, T090_1	NUMBER			constraint CC_NBURLOGF95X_T090_1_NN	NOT NULL	
, T090_2	NUMBER			constraint CC_NBURLOGF95X_T090_2_NN	NOT NULL	
, T090_3	NUMBER			constraint CC_NBURLOGF95X_T090_3_NN	NOT NULL	
, T090_4	NUMBER			constraint CC_NBURLOGF95X_T090_4_NN	NOT NULL	
, DESCRIPTION     VARCHAR2(250)
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

  dbms_output.put_line( 'Table "NBUR_LOG_F95X" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F95X" already exists.' );
end;
/
SET FEEDBACK ON

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F95X' );
end;
/

commit;

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_F95X                 Comments

comment on table  NBUR_LOG_F95X is '95X Дані про афілійовані особи банку';
comment on column NBUR_LOG_F95X.REPORT_DATE	is 'Звiтна дата';
comment on column NBUR_LOG_F95X.KF		is 'Фiлiя';
comment on column NBUR_LOG_F95X.VERSION_ID	is 'Номер версії файлу';
comment on column NBUR_LOG_F95X.NBUC		is 'Код МФО';
comment on column NBUR_LOG_F95X.EKP		is 'Код показника';
comment on column NBUR_LOG_F95X.K030	 	is 'Код резидентності афілійованої особи';
comment on column NBUR_LOG_F95X.F051	 	is 'Код відношення афілійованої особи до банку';
comment on column NBUR_LOG_F95X.K020	 	is 'Ідентифікаційний код афілійованої особи';
comment on column NBUR_LOG_F95X.Q001	 	is 'Найменування афілійованої особи';
comment on column NBUR_LOG_F95X.Q002	 	is 'Місцезнаходження афілійованої особи';
comment on column NBUR_LOG_F95X.Q003	 	is 'Порядковий номер афілійованої особи';
comment on column NBUR_LOG_F95X.Q007	 	is 'Дата реєстрації статутного фонду або змін до нього';
comment on column NBUR_LOG_F95X.T070	 	is 'Розмір зареєстрованого статутного фонду афілійованої особи';
comment on column NBUR_LOG_F95X.T090_1 		is 'Відсоток прямої участі на дату набуття статусу афілійованої особи';
comment on column NBUR_LOG_F95X.T090_2 		is 'Відсоток опосередкованої участі на дату набуття статусу афілійованої особи';
comment on column NBUR_LOG_F95X.T090_3 		is 'Відсоток прямої участі на звітну дату';
comment on column NBUR_LOG_F95X.T090_4 		is 'Відсоток опосередкованої участі на звітну дату';
comment on column NBUR_LOG_F95X.DESCRIPTION	is 'Опис (коментар)';
comment on column NBUR_LOG_F95X.BRANCH		is 'Код підрозділу';

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_F95X                   Grants

grant SELECT on NBUR_LOG_F95X to BARSUPL;
grant SELECT on NBUR_LOG_F95X to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F95X to BARSREADER_ROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Table/nbur_log_F95X.sql ======= *** End *** ===
PROMPT ===================================================================================== 
