declare
 min_deal bars.deal.id%type;
begin
for cur in (
with t as (
          select *
            from bars.attribute_number_value av
           where av.attribute_id IN
                 (SELECT ak.id
                    FROM bars.attribute_kind ak
                   WHERE ak.attribute_code = 'DKBO_ACC_LIST')
             AND av.object_id in
                 (select d.id
                    from bars.deal d
                   where d.close_date is null
                     and d.customer_id in
                         (select d.customer_id
                            from bars.deal d
                           where d.close_date is null
                           group by (d.customer_id)
                          having count(d.customer_id) > 1))
         )
select * from t
 join bars.accounts a on a.acc = t.value
 )
 loop
 
 select min(d.id) into min_deal from bars.deal d where d.customer_id =cur.rnk and d.close_date is null;
 
 if min_deal = cur.object_id then null;
 else 
 update bars.attribute_number_value av
 set av.object_id = min_deal
 where av.attribute_id = (SELECT ak.id FROM bars.attribute_kind ak WHERE ak.attribute_code in ('DKBO_ACC_LIST' ))
   and av.value        = cur.acc;
   
 update bars.attribute_history t 
 set t.object_id = min_deal
 where t.object_id = cur.object_id and t.attribute_id = (SELECT ak.id FROM bars.attribute_kind ak WHERE ak.attribute_code in ('DKBO_ACC_LIST' ));
 
 delete from bars.deal dd where dd.id = cur.object_id;  
   
 end if;                         
end loop; 
end;   
/                     