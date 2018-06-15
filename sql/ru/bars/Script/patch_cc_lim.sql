-- ================================================================================
-- Module : CCK
-- Author : BAA
-- Date   : 14.06.2018
-- ================================== <Comments> ==================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK OFF

begin
  for c in ( select KF from MV_KF )
  loop
    bc.go( c.KF );
    begin
      DBMS_OUTPUT.PUT_LINE( 'KF='||c.KF );
      update CC_LIM
         set SUMO = SUMG
       where FDAT >= to_date('01/06/2018','dd/mm/yyyy')
         and SUMO < SUMG;
      DBMS_OUTPUT.PUT_LINE( 'CC_LIM: '||to_char(sql%rowcount)||' row(s) updated.' );
      commit;
    exception
      when OTHERS then
        DBMS_OUTPUT.PUT_LINE( sqlerrm );
    end;
  end loop;
  bc.home();
end;
/

begin
  for c in ( select KF from MV_KF )
  loop
    bc.go( c.KF );
    begin
      DBMS_OUTPUT.PUT_LINE( 'KF='||c.KF );
      update CC_LIM
         set SUMO = nvl(SUMO,0)
           , SUMG = nvl(SUMG,0)
       where FDAT >= to_date('01/06/2018','dd/mm/yyyy')
         and ( SUMO Is Null or SUMG Is Null );
      DBMS_OUTPUT.PUT_LINE( 'CC_LIM: '||to_char(sql%rowcount)||' row(s) updated.' );
      commit;
    exception
      when OTHERS then
        DBMS_OUTPUT.PUT_LINE( sqlerrm );
    end;
  end loop;
  bc.home();
end;
/

declare
  e_col_already_nn  exception;
  pragma exception_init( e_col_already_nn, -01442 );
begin
  -- When adding a column on compressed tables, DO NOT SPECIFY a default value.
  execute immediate 'alter table CC_LIM modify SUMO constraint CC_CCLIM_SUMO_NN not null enable novalidate';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_already_nn
  then null;
end;
/

declare
  e_col_already_nn  exception;
  pragma exception_init( e_col_already_nn, -01442 );
begin
  -- When adding a column on compressed tables, DO NOT SPECIFY a default value.
  execute immediate 'alter table CC_LIM modify SUMG constraint CC_CCLIM_SUMG_NN not null enable novalidate';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_already_nn
  then null;
end;
/

declare
  E_CHK_CNSTRN_EXISTS exception;
  pragma exception_init( E_CHK_CNSTRN_EXISTS, -02264 );
begin
  execute immediate 'alter table CC_LIM add constraints CC_CCLIM_SUM check( SUMO >= SUMG ) enable novalidate';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_CHK_CNSTRN_EXISTS
  then null;
end;
/

SET FEEDBACK ON

alter table CC_LIM modify SUMG default 0;

alter table CC_LIM modify SUMO default 0;
