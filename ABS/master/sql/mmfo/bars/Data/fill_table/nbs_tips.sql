-- ======================================================================================
-- Module : DPU
-- Author : BAA
-- Date   : 26.10.2016
-- ===================================== <Comments> =====================================
-- add allowed types for R020 of deposit accounts
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF
SET ECHO         OFF
SET FEEDBACK     ON
SET LINES        500
SET PAGES        500
SET TIMING       OFF

prompt -- ======================================================
prompt -- fill table NBS_TIPS
prompt -- ======================================================

exec BC.HOME;

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '2610', 'DEP' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '2615', 'DEP' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '2618', 'DEN' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '2651', 'DEP' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '2652', 'DEP' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '2658', 'DEN' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '2525', 'DEP' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '2528', 'DEN' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '2546', 'DEP' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert
    into NBS_TIPS ( NBS, TIP ) Values ( '2548', 'DEN' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

COMMIT;

begin
  -- special values for deposit line accounts
  for k in ( select distinct NBS_DEP, OB22_DEP
               from DPU_TYPES_OB22
              where ( TYPE_ID, NBS_DEP ) in ( select TYPE_ID, BSD
                                                from DPU_VIDD
                                               where FL_EXTEND = 2 )
           )
  loop
    begin
      Insert
        into NBS_TIPS
           ( NBS, OB22, TIP )
      Values
           ( k.NBS_DEP, k.OB22_DEP, 'NL8' );
    exception
      when DUP_VAL_ON_INDEX then
        null;
    end;
  end loop;
end;
/

commit;

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '1623', 'DEP' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '2701', 'DEP' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '3660', 'DEP' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '1628', 'DEN' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '2708', 'DEN' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '3668', 'DEN' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '1626', 'SDI' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '2706', 'SDI' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '3666', 'SDI' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert 
    into NBS_TIPS ( NBS, TIP ) Values ( '9510', 'ZAL' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

commit;

begin
  Insert
    into NBS_TIPS ( NBS, TIP, OB22 ) Values ( '3578', 'SK0', '24' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert
    into NBS_TIPS ( NBS, TIP, OB22 ) Values ( '3578', 'SK0', '19' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert
    into NBS_TIPS ( NBS, TIP, OB22 ) Values ( '3578', 'SK0', '30' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert
    into NBS_TIPS ( NBS, TIP, OB22 ) Values ( '3578', 'SK0', '37' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert
    into NBS_TIPS ( NBS, TIP, OB22 ) Values ( '3578', 'SK9', '48' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert
    into NBS_TIPS ( NBS, TIP, OB22 ) Values ( '3578', 'SK9', '46' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert
    into NBS_TIPS ( NBS, TIP, OB22 ) Values ( '3578', 'SK9', '51' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert
    into NBS_TIPS ( NBS, TIP, OB22 ) Values ( '3578', 'SK9', '56' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

commit;

begin
  -- special values for accounts of financial receivables
  for k in ( select t1.R020, t1.OB22
--                , t1.TIP
              from ( select substr(NBS_P,1,4) as R020
                          , substr(NBS_P,5,2) as OB22
--                        , case when ( MOD_ABS in (2,3) ) then 'SK9' else 'OFR' end TIP
                       from FIN_DEBT
                      where NBS_P like '357___'
                   ) t1
              left
              join NBS_TIPS t2
                on ( t2.NBS = t1.R020 and t2.OB22 = t1.OB22 )
             where t2.NBS Is Null
           )
  loop
    begin
      Insert
        into NBS_TIPS
           ( NBS, OB22, TIP )
      Values
           ( k.R020, k.OB22, 'OFR' );
    exception
      when DUP_VAL_ON_INDEX then
        null;
    end;
  end loop;
end;
/

commit;
