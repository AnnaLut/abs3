declare
l_cn integer;
begin
   select count(*) into l_cn from cck_ob22_9;
   if l_cn = 0 THEN
      begin 
         EXECUTE IMMEDIATE ' insert into cck_ob22_9 (nbs, ob22)        select nbs, ob22 from cck_ob22 where  D_CLOSE is null';
      end;
   end if;
end;
/

insert into cck_ob22_9(nbs,ob22) select distinct x.nbs, x.ob22   from cck_ob22 x where  x.D_CLOSE is null  and not exists ( select 1 from cck_ob22_9 where nbs||ob22 = x.NBS||x.OB22)    ;
insert into cck_ob22_9(nbs,ob22) select distinct substr(x.SS,1,4), substr(x.SS,5,2) from mbdk_ob22 x where ss is not null and not exists ( select 1 from cck_ob22_9 where nbs||ob22 = x.SS) ;
commit;

update CCK_OB22_9 
   set SNA = decode( substr( nbs,1,3),  '152','152915',  '202','202915',  '203','203911',  '206','206973',  '207','207936',  '208','208939',	
                                        '210','210923',  '211','211924',  '212','212939',  '213','213939',  '220','2209J1',  '223','223970',    null)
where SNA is null; 

commit; 

declare  mfo_ varchar2(6);
begin 
  for k in ( select min (kf) KF from mv_KF  union all  select kf KF from mv_KF where kf ='322669') 
  loop bc.go ( k.KF); 
     update cck_ob22_9 x 
        set  n6a  = 
                 (select min (b.nbs||b.ob22) 
                  from  int_accn i, accounts a, accounts b
                  where id = 0 and A.ACC = i.acc and i.acrb = b.acc and a.dazs is null and a.nbs = x.nbs and a.ob22 = x.ob22)
                  where n6a is null ;
     commit;
  end loop;

  suda;
  update cck_ob22_9 set n7a = n6a;
end ;
/

  