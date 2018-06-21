
begin
 bc.go('/300465/');
 update STO_grp set idg=12 where idg like '12__';
end;
/
commit;

begin
 for rec in (SELECT * FROM  mv_kf) 
   loop
     bc.go('/'||rec.kf||'/');
     update STO_lst set idg=12 where idg like '12__';
   end loop;
end ;
/
commit;

begin
  bc.home;
end;
/



