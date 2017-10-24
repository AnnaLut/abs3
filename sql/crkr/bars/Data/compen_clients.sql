update COMPEN_CLIENTS set open_cl = sysdate where open_cl is null; 

declare
begin
  for cur in  (select c.rnk, p.passp, p.eddr_id, p.numdoc from compen_clients c, person p where c.rnk = p.rnk and p.passp = 7)
    loop
      update compen_clients c 
      set c.dbcode = crkr_compen_web.f_dbcode(7, cur.eddr_id, cur.numdoc)
      where c.rnk = cur.rnk;
    end loop;  
end; 
/