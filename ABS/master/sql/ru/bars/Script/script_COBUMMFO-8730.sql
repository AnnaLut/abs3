begin
for cur in (
            select c.id, o.kf, t.systemcode st, o.MTSC, op.id op, c.PRN_FILE_IMPORT
            from sw_compare c, sw_own o, SW_SYSTEM T, SW_TT_OPER op
            where o.compare_id = c.id
              and c.CAUSE_ERR <>5
            and C.KOD_NBU = T.KOD_NBU
            and op.tt= o.tt
            and not exists (select null from sw_import I where i.compare_id = c.id)
            )
loop            
    update sw_import I
      set i.compare_id = cur.id 
    where i.kf=cur.kf
      and i.systemcode = cur.st
      and i.transactionid = cur.MTSC
      and i.operation = cur.op
      and i.prn_file =  cur.PRN_FILE_IMPORT
      and i.compare_id =0;
end loop;
end;
/
commit;
/
begin
for cur in (
            select c.id, o.kf, decode(t.kod_nbu ,'94','97','95','97','96','97',t.kod_nbu ) st, o.transactionid MTSC, op.tt op, c.PRN_FILE_own
            from sw_compare c, sw_import o, SWI_MTI_LIST T, SW_TT_OPER op
            where o.compare_id = c.id
              and c.CAUSE_ERR <>5
            and o.systemcode  = T.id
            and op.id= o.operation 
            and not exists (select null from sw_own I where i.compare_id = c.id)
            )
loop            
  
update sw_own I
 set i.compare_id = cur.id 
where i.kf=cur.kf
  and i.kod_nbu = cur.st
  and i.MTSC = cur.MTSC
  and i.tt = cur.op
  and i.prn_file =  cur.PRN_FILE_own
  and i.compare_id =0;
end loop;
end;  
/
commit;
/
