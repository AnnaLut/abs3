-- ================================================================================
-- Module : CCK
-- Author : BAA
-- Date   : 14.06.2018
-- ================================== <Comments> ==================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED

begin
  for c in ( select KF from MV_KF )
  loop
    bc.go( c.KF );
    begin
      DBMS_OUTPUT.PUT_LINE( 'KF='||c.KF );
      update CC_LIM_ARC
         set SUMO = SUMG
       where mdat = to_date('01/06/2018','dd/mm/yyyy')
         and fdat >= to_date('01/06/2018','dd/mm/yyyy')
         and SUMO < SUMG;
      DBMS_OUTPUT.PUT_LINE( 'CC_LIM_ARC: '||to_char(sql%rowcount)||' row(s) updated.' );
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
      update CC_LIM_ARC
         set SUMO = nvl(SUMO,0)
           , SUMG = nvl(SUMG,0)
       where MDAT = to_date('01/06/2018','dd/mm/yyyy')
         and FDAT >= to_date('01/06/2018','dd/mm/yyyy')
         and ( SUMO Is Null or SUMG Is Null );
      DBMS_OUTPUT.PUT_LINE( to_char(sql%rowcount)||' row(s) updated.' );
      commit;
    exception
      when OTHERS then
        DBMS_OUTPUT.PUT_LINE( sqlerrm );
    end;
  end loop;
  bc.home();
end;
/
