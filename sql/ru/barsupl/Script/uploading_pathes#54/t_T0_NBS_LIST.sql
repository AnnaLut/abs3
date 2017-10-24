-- ======================================================================================
-- Module : UPL
-- Author : KVA
-- Date   : 11.07.2017
-- ======================================================================================

-- ETL-19329 UPL - выгрузить договора хоз. дебеторки (файл договоро + t0 + справочники)
-- 1. В выгрузке Т0 таблицу acntadjbal0 (скорректированные остатки по счетам в экв. и номинале) расширить счетами ХДЗ, а именно 3510, 3519 и 355 группы 
prompt -- ======================================================
prompt -- add new row to T0_NBS_LIST
prompt -- ======================================================

begin  insert into BARSUPL.T0_NBS_LIST values ( '3510', '__' );
       exception  when DUP_VAL_ON_INDEX then    null;
end;
/
begin  insert into BARSUPL.T0_NBS_LIST values ( '3519', '__' );
       exception  when DUP_VAL_ON_INDEX then    null;
end;
/
begin  insert into BARSUPL.T0_NBS_LIST values ( '3550', '__' );
       exception  when DUP_VAL_ON_INDEX then    null;
end;
/
begin  insert into BARSUPL.T0_NBS_LIST values ( '3551', '__' );
       exception  when DUP_VAL_ON_INDEX then    null;
end;
/
begin  insert into BARSUPL.T0_NBS_LIST values ( '3552', '__' );
       exception  when DUP_VAL_ON_INDEX then    null;
end;
/
begin  insert into BARSUPL.T0_NBS_LIST values ( '3553', '__' );
       exception  when DUP_VAL_ON_INDEX then    null;
end;
/
begin  insert into BARSUPL.T0_NBS_LIST values ( '3554', '__' );
       exception  when DUP_VAL_ON_INDEX then    null;
end;
/
begin  insert into BARSUPL.T0_NBS_LIST values ( '3555', '__' );
       exception  when DUP_VAL_ON_INDEX then    null;
end;
/
begin  insert into BARSUPL.T0_NBS_LIST values ( '3556', '__' );
       exception  when DUP_VAL_ON_INDEX then    null;
end;
/
begin  insert into BARSUPL.T0_NBS_LIST values ( '3557', '__' );
       exception  when DUP_VAL_ON_INDEX then    null;
end;
/
begin  insert into BARSUPL.T0_NBS_LIST values ( '3558', '__' );
       exception  when DUP_VAL_ON_INDEX then    null;
end;
/
begin  insert into BARSUPL.T0_NBS_LIST values ( '3559', '__' );
       exception  when DUP_VAL_ON_INDEX then    null;
end;
/

commit;
