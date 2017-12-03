declare
kf number :=300465 ;
l_pawn number :=933;
begin 
 for n in (select acc from accounts a where  a.nbs='9510' and a.dazs is null 
and a.acc not in (select acc from pawn_acc))
    loop
      insert into pawn_acc  (acc, pawn,kf) values (n.acc,l_pawn,kf);
      end loop;
      end;  
/
commit;	 

