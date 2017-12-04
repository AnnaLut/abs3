--=============================================================================
-- Module : KRN
-- Author : SERG
-- Date   : 02.02.2012
--============ <Comments> =====================================================
/*
  Синхронизируем таблицу состояний снимков балансов с реально существующими снимками
*/
--=============================================================================

declare
    l_hv    number;
    l_cnt   number;
begin
    for c in (
                select * 
                  from user_tab_partitions 
                 where table_name='ACCM_SNAP_BALANCES'
                   and partition_position>1
                 order by partition_position
             )
    loop        
        l_hv := to_number(substr(c.high_value,1,4000))-1;
        select count(*)
          into l_cnt
          from accm_state_snap          
         where caldt_id = l_hv;
        if l_cnt = 0
        then
            insert
              into accm_state_snap(caldt_id, snap_balance)
            values (l_hv, 'Y');
        end if;        
    end loop;
end;    
/

commit
/