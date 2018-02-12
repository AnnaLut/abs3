declare
   tt   tips%rowtype;
begin
   bc.go ('/');
   tt.name := 'Зарплатний проект (2909)';
   tt.tip := 'ZRP';

   update tips
      set name = tt.name
    where tip = tt.tip;

   if sql%rowcount = 0
   then
      insert into tips (tip, name)
           values (tt.tip, tt.name);
   end if;
end;
/
commit;
/  