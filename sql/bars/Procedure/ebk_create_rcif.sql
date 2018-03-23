CREATE OR REPLACE procedure BARS.EBK_CREATE_RCIF
is
-- Дописываем те записи по которым ещё нет данных в RCIF и нет дублей
begin
  
  insert 
    into BARS.EBK_RCIF
       ( KF, RCIF, SEND )
  select KF
$if EBK_PARAMS.CUT_RNK $then
       , trunc(RNK/100)
$else
       , RNK
$end
       , 0
    from BARS.CUSTOMER c
    left
    join ( select RCIF
             from BARS.EBK_RCIF
            union 
           select M_RNK
             from BARS.EBK_DUPLICATE_GROUPS
            union 
           select D_RNK
             from BARS.EBK_DUPLICATE_GROUPS
         ) r
      on ( r.RCIF = c.RNK )
   where c.CUSTTYPE = 3
     and (c.BC = 0 or c.BC is null)
     and c.DATE_OFF is null
     and r.RCIF Is Null;
  
  commit;
  
end EBK_CREATE_RCIF;
/

show err
