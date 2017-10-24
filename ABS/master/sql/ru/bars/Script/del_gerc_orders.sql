declare 
/*щоб була можливість накотити унікальний індекс*/
begin
  delete from gerc_orders where ref is null;
  commit;
  for cur in (select externaldocumentid, count(*) as cnd
              from bars.gerc_orders t1
              group by t1.externaldocumentid
              having count(*) > 1
              )
  loop
    for cur_del in (select o.ref, o.rowid from gerc_orders o where o.externaldocumentid = cur.externaldocumentid and rownum < cur.cnd)
    loop
      delete from gerc_orders where rowid = cur_del.rowid; 
    end loop;    
  end loop;         
  commit;  
end;  
/