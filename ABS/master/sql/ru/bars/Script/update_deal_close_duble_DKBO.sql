begin

  for rec in (
    select d.id, cc.rnk, cc.date_off, aaa.*
                from (SELECT count(*), a.value
                        FROM attribute_number_value a
                        JOIN deal d
                          ON d.id = a.object_id
                         and d.CLOSE_DATE is null
                        JOIN attribute_kind k
                          ON k.id = a.attribute_id
                         AND k.attribute_code = 'DKBO_ACC_LIST'
                        JOIN object_type t
                          ON t.id = d.deal_type_id
                         AND t.type_code = 'DKBO'
                       group by a.value
                      having count(*) > 1
                       order by a.value) aa, --
                     attribute_number_value aaa, --
                     deal d, --
                     (select c.rnk, c.date_off
                        from customer c
                       where c.date_off is not null) cc --
               where aa.value = aaa.value
                 and d.id = aaa.object_id
                 and d.customer_id = cc.rnk 
) loop
    update deal d set d.close_date = rec.date_off where d.id = rec.id;
  end loop;
commit;
end; 
/
