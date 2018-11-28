BEGIN
   insert into ow_oic_atransfers_mask
     (
        mask
        , nbs
        , ob22
        , nms
        , tip
        , vid
        , s180
        , r011
        , r013
        , field_name
     )
   select 
        '357055'
        , '3570'
        , '55'
        , 'Нарах.дох.від фікс.коміс.винагороди банку за еквайр.обслуговування'
        , 'ODB'
        , 0
        , '1'
        , '1'
        , '2'
        , 'ACC_FEE'
   from dual
   where not exists (select 1 from ow_oic_atransfers_mask where mask = '357055');

   insert into ow_oic_atransfers_mask
     (
        mask
        , nbs
        , ob22
        , nms
        , tip
        , vid
        , s180
        , r011
        , r013
        , field_name
     )
   select 
        '357056'
        , '3570'
        , '56'
        , 'Прострочені нарах.дох.від фікс.коміс.винагороди банку за еквайр.обслуг'
        , 'OFR'
        , 0
        , '1'
        , '1'
        , '3'
        , 'ACC_FEE_OVERDUE'
   from dual
   where not exists (select 1 from ow_oic_atransfers_mask where mask = '357056');
   
   commit;
END; 
/ 
