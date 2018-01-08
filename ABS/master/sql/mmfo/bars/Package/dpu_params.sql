declare
  l_pks   varchar2(4096);
  l_qty   number(2);
  l_mfo   varchar2(6);
begin
  
  select count(1), min(SubStr(BRANCH,2,6))
    into l_qty, l_mfo
    from BRANCH 
   where BRANCH like '/______/'
     and DATE_CLOSED Is Null;
  
  select MFOU
    into l_mfo
    from BARS.BANKS$BASE
   where MFO = l_mfo;
  
  l_pks := q'[create or replace package DPU_PARAMS 
is
  /*
  A typical usage of these boolean constants is

         $if DPU_PARAMS.SBER $then
           --
         $else
           --
         $end
  */

  VERSION      constant pls_integer := 2;
  SBER         constant boolean     := ]' || case when l_mfo = '300465' then 'TRUE' else 'FALSE' end || q'[; -- Ощадбанк
  MMFO         constant boolean     := ]' || case when l_qty > 1        then 'TRUE' else 'FALSE' end || q'[; -- БД мульти МФО
  LINE8        constant boolean     := TRUE;
  HOLI         constant boolean     := FALSE; -- перенесення дати закінчення, якщо вона випадає на вихідний
  IRR          constant boolean     := FALSE; -- ефективна ставка

end DPU_PARAMS;]';
  
  execute immediate l_pks;
  
end;
/
