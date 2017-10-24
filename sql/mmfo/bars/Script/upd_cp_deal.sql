declare
begin
  bc.go(300465);
  update cp_deal set erate = 22.6770922851563 where id = 326 and ref = 34305176701;
  commit;
  bc.home;
end;
/