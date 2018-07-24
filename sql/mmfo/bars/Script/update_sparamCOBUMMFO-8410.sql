begin
update SPARAM_LIST t
   set pkname = 'ID',
       editable = 0
where spid = 348;
end;
/
commit;
/


begin
for kv in (select * from mv_kf)
loop
  bc.go(kv.kf);
  begin
  for cur in (
            select distinct t.acc, case when t.sv = 0 then 0 else decode(z.a8,'Так',1,0) end a8 from PAWN_ACC t
            join accounts a on a.acc= t.acc 
            /*left*/ join TMP_Z_POLIS z on z.a1 = t.pawn and z.a3  = a.nbs)
  loop
    accreg.setAccountwParam(cur.acc, 'Z_POLIS', cur.a8);
  end loop;
  end;
end loop;
bc.home;  
exception when others then bc.home;
end;
/
commit;
/
