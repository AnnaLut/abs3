
PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Table/nbur_log_f6Ix.sql ======= *** Run *** ===
PROMPT ===================================================================================== 

SET FEEDBACK     OFF

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F6IX', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_LOG_F6IX', 'FILIAL',  'M', NULL,  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_LOG_F6IX
( REPORT_DATE     date       constraint CC_NBURLOGF6IX_REPORTDT_NN         NOT NULL
, KF              char(6)    constraint CC_NBURLOGF6IX_KF_NN               NOT NULL
, NBUC            VARCHAR2(20 CHAR)     
, VERSION_ID	  NUMBER
, VERSION_D8	  NUMBER
, EKP             VARCHAR2(6 CHAR)   constraint CC_NBURLOGF6IX_EKP_NN          NOT NULL
, K020		  VARCHAR2(10 CHAR) constraint CC_NBURLOGF6IX_K020_NN          NOT NULL
, K021		  VARCHAR2(1 CHAR)  constraint CC_NBURLOGF6IX_K021_NN          NOT NULL
, Q003_2	  VARCHAR2(4 CHAR)
, Q003_4	  VARCHAR2(2 CHAR)
, R030		  VARCHAR2(3 CHAR)  constraint CC_NBURLOGF6IX_R030_NN          NOT NULL
, R020		  VARCHAR2(4 CHAR)  constraint CC_NBURLOGF6IX_R020_NN          NOT NULL
, F081		  VARCHAR2(1 CHAR)  constraint CC_NBURLOGF6IX_F081_NN          NOT NULL
, S031		  VARCHAR2(2 CHAR)  constraint CC_NBURLOGF6IX_S0#1_NN          NOT NULL
, T070_DTL	  NUMBER(38) 
, T070		  NUMBER(38) 
, DESCRIPTION     VARCHAR2(250)
, ACC_ID          NUMBER(38)
, ACC_NUM         VARCHAR2(20)
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

  dbms_output.put_line( 'Table "NBUR_LOG_F6IX" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_LOG_F6IX" already exists.' );
end;
/
SET FEEDBACK ON

begin
  bars.bpa.alter_policies( 'NBUR_LOG_F6IX' );
end;
/

commit;

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_f6Ix                 Comments

comment on table  NBUR_LOG_F6IX 		is '6IX Данi про концентрацію ризиків за активними операціями банку з контрагентами і ПО (Інформація за валютами та траншами)';
comment on column NBUR_LOG_F6IX.REPORT_DATE 	is 'Звiтна дата';
comment on column NBUR_LOG_F6IX.KF 		is 'Фiлiя';
comment on column NBUR_LOG_F6IX.VERSION_ID 	is 'Номер версії файлу';
comment on column NBUR_LOG_F6IX.VERSION_D8 	is 'Номер версії файлу #D8';
comment on column NBUR_LOG_F6IX.NBUC 		is 'Код МФО';
comment on column NBUR_LOG_F6IX.EKP		is 'Код показника';
comment on column NBUR_LOG_F6IX.K020		is 'Ідентифікаційний/реєстраційний код/номер контрагента/пов?язаної з банком особи';
comment on column NBUR_LOG_F6IX.K021		is 'Код ознаки ідентифікаційного/реєстраційного коду/номера';
comment on column NBUR_LOG_F6IX.Q003_2  	is 'Умовний порядковий номер договору';
comment on column NBUR_LOG_F6IX.Q003_4		is 'Умовний порядковий номер траншу';
comment on column NBUR_LOG_F6IX.R030		is 'Код валюти';
comment on column NBUR_LOG_F6IX.R020		is 'Номер рахунку';
comment on column NBUR_LOG_F6IX.F081		is 'Код щодо включення до розрахунку нормативів кредитного ризику';
comment on column NBUR_LOG_F6IX.S031		is 'Код виду забезпечення кредитної операції за договором';
comment on column NBUR_LOG_F6IX.T070_DTL 	is 'Сума для деталізації';
comment on column NBUR_LOG_F6IX.T070		is 'Сума';
comment on column NBUR_LOG_F6IX.DESCRIPTION 	is 'Опис (коментар)';
comment on column NBUR_LOG_F6IX.ACC_ID		is 'Ід. рахунка';
comment on column NBUR_LOG_F6IX.ACC_NUM 	is 'Номер рахунка';
comment on column NBUR_LOG_F6IX.KV		is 'Ід. валюти';
comment on column NBUR_LOG_F6IX.CUST_ID 	is 'Ід. клієнта';
comment on column NBUR_LOG_F6IX.CUST_CODE       is 'Код клієнта';
comment on column NBUR_LOG_F6IX.CUST_NAME	is 'Назва клієнта';
comment on column NBUR_LOG_F6IX.ND		is 'Ід. договору';
comment on column NBUR_LOG_F6IX.AGRM_NUM	is 'Номер договору';
comment on column NBUR_LOG_F6IX.BEG_DT		is 'Дата початку договору';
comment on column NBUR_LOG_F6IX.END_DT		is 'Дата закінчення договору';
comment on column NBUR_LOG_F6IX.BRANCH		is 'Код підрозділу';

prompt  ======================================================
prompt  /Sql/BARS/Table/nbur_log_f6Ix                   Grants

grant SELECT on NBUR_LOG_F6IX to BARSUPL;
grant SELECT on NBUR_LOG_F6IX to BARS_ACCESS_DEFROLE;
grant SELECT on NBUR_LOG_F6IX to BARSREADER_ROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Table/nbur_log_f6Ix.sql ======= *** End *** ===
PROMPT ===================================================================================== 
