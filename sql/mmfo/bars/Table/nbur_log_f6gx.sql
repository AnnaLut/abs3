
PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Table/nbur_log_f6Gx.sql ======= *** Run *** ===
PROMPT ===================================================================================== 

SET FEEDBACK     OFF

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F6GX', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F6GX', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_F6GX
( REPORT_DATE     date       constraint CC_NBURLOGF6GX_REPORTDT_NN         NOT NULL
, KF              char(6)    constraint CC_NBURLOGF6GX_KF_NN               NOT NULL
, NBUC            VARCHAR2(20 CHAR)     
, VERSION_ID	  NUMBER
, VERSION_D8	  NUMBER
, EKP             VARCHAR2(6 CHAR)   constraint CC_NBURLOGF6GX_EKP_NN          NOT NULL
, K020		  VARCHAR2(10 CHAR) constraint CC_NBURLOGF6GX_K020_NN          NOT NULL
, K021		  VARCHAR2(1 CHAR)  constraint CC_NBURLOGF6GX_K021_NN          NOT NULL
, Q003_2	  VARCHAR2(4 CHAR)  
, Q003_3	  VARCHAR2(256 CHAR)  
, Q007		  date              constraint CC_NBURLOGF6GX_Q007_NN          NOT NULL
, B040		  VARCHAR2(20 CHAR) constraint CC_NBURLOGF6GX_B040_NN          NOT NULL
, T070_1	  NUMBER            constraint CC_NBURLOGF6GX_T070_1_NN        NOT NULL
, DESCRIPTION     VARCHAR2(250)
, KV              NUMBER(3)
, CUST_ID         NUMBER(38)     
, CUST_CODE	  VARCHAR2(14)
, CUST_NAME	  VARCHAR2(70)
, ND              NUMBER(38)
, AGRM_NUM	  VARCHAR2(50)
, BEG_DT	  date
, END_DT          date
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

  dbms_output.put_line( 'Table "NBUR_LOG_F6GX" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F6GX" already exists.' );
end;
/
SET FEEDBACK ON

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F6GX' );
end;
/

commit;

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_f6Gx                 Comments

comment on table  NBUR_LOG_F6GX is '6GX Данi про концентрацію ризиків за активними операціями банку';
comment on column NBUR_LOG_F6GX.REPORT_DATE is 'Звiтна дата';
comment on column NBUR_LOG_F6GX.KF 	is 'Фiлiя';
comment on column NBUR_LOG_F6GX.VERSION_ID is 'Номер версії файлу';
comment on column NBUR_LOG_F6GX.VERSION_D8 is 'Номер версії файлу #D8';
comment on column NBUR_LOG_F6GX.NBUC 	is 'Код МФО';
comment on column NBUR_LOG_F6GX.EKP	is 'Код показника';
comment on column NBUR_LOG_F6GX.K020	is 'Ідентифікаційний/реєстраційний код/номер контрагента/пов?язаної з банком особи';
comment on column NBUR_LOG_F6GX.K021	is 'Код ознаки ідентифікаційного/реєстраційного коду/номера';
comment on column NBUR_LOG_F6GX.Q003_2	is 'Умовний порядковий номер договору';
comment on column NBUR_LOG_F6GX.Q003_3	is 'Номер основного договору';
comment on column NBUR_LOG_F6GX.Q007	is 'Дата основного договору';
comment on column NBUR_LOG_F6GX.B040	is 'Код підрозділу банку, де зберігається документація по договору';
comment on column NBUR_LOG_F6GX.T070_1	is 'Сума інших надходжень (RC)';
comment on column NBUR_LOG_F6GX.DESCRIPTION 	is 'Опис (коментар)';
comment on column NBUR_LOG_F6GX.KV		is 'Ід. валюти';
comment on column NBUR_LOG_F6GX.CUST_ID 	is 'Ід. клієнта';
comment on column NBUR_LOG_F6GX.CUST_CODE       is 'Код клієнта';
comment on column NBUR_LOG_F6GX.CUST_NAME	is 'Назва клієнта';
comment on column NBUR_LOG_F6GX.ND		is 'Ід. договору';
comment on column NBUR_LOG_F6GX.AGRM_NUM	is 'Номер договору';
comment on column NBUR_LOG_F6GX.BEG_DT		is 'Дата початку договору';
comment on column NBUR_LOG_F6GX.END_DT		is 'Дата закінчення договору';
comment on column NBUR_LOG_F6GX.BRANCH		is 'Код підрозділу';

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_f6Gx                   Grants

grant SELECT on NBUR_LOG_F6GX to BARSUPL;
grant SELECT on NBUR_LOG_F6GX to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F6GX to BARSREADER_ROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Table/nbur_log_f6Gx.sql ======= *** End *** ===
PROMPT ===================================================================================== 
