PROMPT ===================================================================================== 
PROMPT *** Run *** ===== Scripts /Sql/BARS/Table/NBUR_REF_EKP_3BX.sql ==== *** Run *** ===
PROMPT ===================================================================================== 
-- Таблиця для відповідності показників EKP файлів # та XML
SET FEEDBACK     OFF

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_REF_EKP_3BX', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_REF_EKP_3BX', 'FILIAL',  NULL, 'E',  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate 'create table NBUR_REF_EKP_3BX
( ZKP		VARCHAR2(4 CHAR)	constraint CC_NBURREFEKP3BX_ZKP_NN		NOT NULL
, F061		VARCHAR2(1 CHAR)	default NULL
, EKPXML	VARCHAR2(6 CHAR)	constraint CC_NBURREFEKP3BX_EKPXML_NN		NOT NULL
) tablespace BRSMDLD';

  dbms_output.put_line( 'Table "NBUR_REF_EKP_3BX" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_REF_EKP_3BX" already exists.' );
end;
/


prompt  ======================================================
prompt	/Sql/BARS/Table/NBUR_REF_EKP_3BX	constraints
prompt  ======================================================
PROMPT  ==== Create  constraint UK_NBURREFEKP3BX  ============
begin
    execute immediate 'alter table NBUR_REF_EKP_3BX
  add constraint UK_NBURREFEKP3BX UNIQUE (ZKP, F061,EKPXML)';
 exception when others then
--    if sqlcode = -2275 then null; else raise; 
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
--    end if; 
end;
/                                	  

SET FEEDBACK ON

begin
  bars.bpa.alter_policies( 'NBUR_REF_EKP_3BX' );
end;
/

commit;

prompt  ======================================================
prompt  /Sql/BARS/Table/NBUR_REF_EKP_3BX	Comments
prompt  ======================================================

comment on table  NBUR_REF_EKP_3BX 		is 'Таблиця відповідності сегменту DDDDD файлу #3B та EKP 3BX';
comment on column NBUR_REF_EKP_3BX.ZKP		is '4-и останні символи сегменту DDDDD файлу #3B';
comment on column NBUR_REF_EKP_3BX.F061		is 'Код ознаки операції, довідник F061';
comment on column NBUR_REF_EKP_3BX.EKPXML	is 'Код показника EKP файлу 3BX';

prompt  ======================================================
prompt  /Sql/BARS/Table/NBUR_REF_EKP_3BX	Grants
prompt  ======================================================

-- grant SELECT on NBUR_REF_EKP_3BX to BARSUPL;
grant SELECT on NBUR_REF_EKP_3BX to BARS_ACCESS_DEFROLE;
-- grant SELECT on NBUR_REF_EKP_3BX to BARSREADER_ROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ==== Scripts /Sql/BARS/Table/NBUR_REF_EKP_3BX.sql ===== *** End *** ===
PROMPT ===================================================================================== 
