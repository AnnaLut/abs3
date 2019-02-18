
PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Table/nbur_log_f6Fx.sql ======= *** Run *** ===
PROMPT ===================================================================================== 

SET FEEDBACK     OFF

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F6FX', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F6FX', 'FILIAL',  'M', NULL,  NULL,  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_F6FX
( REPORT_DATE     date       constraint CC_NBURLOGF6FX_REPORTDT_NN         NOT NULL
, KF              char(6)    constraint CC_NBURLOGF6FX_KF_NN               NOT NULL
, NBUC            VARCHAR2(20 CHAR)     
, VERSION_ID	  NUMBER
, VERSION_D8	  NUMBER
, EKP             VARCHAR2(6 CHAR)   constraint CC_NBURLOGF6FX_EKP_NN          NOT NULL
, K020		  VARCHAR2(10 CHAR) constraint CC_NBURLOGF6FX_K020_NN          NOT NULL
, K021		  VARCHAR2(1 CHAR)  constraint CC_NBURLOGF6FX_K021_NN          NOT NULL
, Q001		  VARCHAR2(250 CHAR)
, F084		  VARCHAR2(1 CHAR)  constraint CC_NBURLOGF6FX_F084_NN          NOT NULL
, K040		  VARCHAR2(3 CHAR)  constraint CC_NBURLOGF6FX_K040_NN          NOT NULL
, KU_1		  VARCHAR2(3 CHAR)  constraint CC_NBURLOGF6FX_KU_1_NN          NOT NULL
, K110		  VARCHAR2(5 CHAR)  constraint CC_NBURLOGF6FX_K110_NN          NOT NULL
, K074		  VARCHAR2(1 CHAR)  constraint CC_NBURLOGF6FX_K074_NN          NOT NULL
, K140		  VARCHAR2(1 CHAR)  constraint CC_NBURLOGF6FX_K140_NN          NOT NULL
, Q020		  VARCHAR2(27 CHAR) constraint CC_NBURLOGF6FX_Q020 check (regexp_like(Q020,'([0-9]{2})([;][0-9]{2})*'))
, Q003_1	  VARCHAR2(3 CHAR)
, Q029            VARCHAR2(50 CHAR)
, FLAG_XML        NUMBER(1)         constraint CC_NBURLOGF6FX_FLAG_XML check (regexp_like(FLAG_XML,'([01])'))
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

  dbms_output.put_line( 'Table "NBUR_LOG_F6FX" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F6FX" already exists.' );
end;
/
SET FEEDBACK ON

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F6FX' );
end;
/

commit;

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_f6Fx                 Comments

comment on table  NBUR_LOG_F6FX is '6FX Данi про концентрацію ризиків за активними операціями банку (Інформація про контрагентів/ПО)';
comment on column NBUR_LOG_F6FX.REPORT_DATE is 'Звiтна дата';
comment on column NBUR_LOG_F6FX.KF 	is 'Фiлiя';
comment on column NBUR_LOG_F6FX.VERSION_ID is 'Номер версії файлу';
comment on column NBUR_LOG_F6FX.VERSION_D8 is 'Номер версії файлу #D8';
comment on column NBUR_LOG_F6FX.NBUC 	is 'Код МФО';
comment on column NBUR_LOG_F6FX.EKP	is 'Код показника';
comment on column NBUR_LOG_F6FX.K020	is 'Ідентифікаційний/реєстраційний код/номер контрагента/пов?язаної з банком особи';
comment on column NBUR_LOG_F6FX.K021	is 'Код ознаки ідентифікаційного/реєстраційного коду/номера';
comment on column NBUR_LOG_F6FX.Q001	is 'Найменування контрагента/пов’язаної з банком особи';
comment on column NBUR_LOG_F6FX.F084	is 'Код щодо належності контрагента до компанії спеціального призначення (SPE)';
comment on column NBUR_LOG_F6FX.K040	is 'Код країни';
comment on column NBUR_LOG_F6FX.KU_1	is 'Код регіону';
comment on column NBUR_LOG_F6FX.K110	is 'Код виду економічної діяльності';
comment on column NBUR_LOG_F6FX.K074	is 'Код інституційного сектору економіки';
comment on column NBUR_LOG_F6FX.K140	is 'Код розміру суб’єкта господарювання';
comment on column NBUR_LOG_F6FX.Q020	is 'Код типу пов’язаної з банком особи';
comment on column NBUR_LOG_F6FX.Q003_1	is 'Порядковий номер групи контрагентів';
comment on column NBUR_LOG_F6FX.Q029  	is 'Код контрагента/ПО банку нерезидента або серія і номер свідоцтва про народження неповнолітньої дитини';
comment on column NBUR_LOG_F6FX.FLAG_XML        is 'Флаг попадання у XML файл (1-так, 0-ні)';
comment on column NBUR_LOG_F6FX.DESCRIPTION 	is 'Опис (коментар)';
comment on column NBUR_LOG_F6FX.KV		is 'Ід. валюти';
comment on column NBUR_LOG_F6FX.CUST_ID 	is 'Ід. клієнта';
comment on column NBUR_LOG_F6FX.CUST_CODE       is 'Код клієнта';
comment on column NBUR_LOG_F6FX.CUST_NAME	is 'Назва клієнта';
comment on column NBUR_LOG_F6FX.ND		is 'Ід. договору';
comment on column NBUR_LOG_F6FX.AGRM_NUM	is 'Номер договору';
comment on column NBUR_LOG_F6FX.BEG_DT		is 'Дата початку договору';
comment on column NBUR_LOG_F6FX.END_DT		is 'Дата закінчення договору';
comment on column NBUR_LOG_F6FX.BRANCH		is 'Код підрозділу';

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_f6Fx                   Grants

grant SELECT on NBUR_LOG_F6FX to BARSUPL;
grant SELECT on NBUR_LOG_F6FX to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F6FX to BARSREADER_ROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Table/nbur_log_f6Fx.sql ======= *** End *** ===
PROMPT ===================================================================================== 
