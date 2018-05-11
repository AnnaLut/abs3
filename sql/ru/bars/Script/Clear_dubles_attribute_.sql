begin
  for rec in ( 
select  rn, ro_wid 
 from  (
select  row_number() over (partition by aa.value order by aa.value) rn,
        aa.rowid   ro_wid        
     from attribute_number_value aa,
(SELECT count(1) as n, a.value, a.object_id, a.attribute_id
          FROM attribute_number_value a
          JOIN deal d
            ON d.id = a.object_id
          JOIN attribute_kind k
            ON k.id = a.attribute_id
           AND k.attribute_code = 'DKBO_ACC_LIST'
          JOIN object_type t
            ON t.id = d.deal_type_id
           AND t.type_code = 'DKBO'
         group by a.value,a.object_id,a.attribute_id
      having count(1) > 1)aaa   
 where aa.value = aaa.value  
  and aa.object_id = aaa.object_id
  and aa.attribute_id  =aaa.attribute_id ) aaaa
  where aaaa.rn > 1
         ) loop 
  delete attribute_number_value aaa  where aaa.rowid = rec.ro_wid;   
  end loop;  
  commit;
end;
/
