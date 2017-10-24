--COBUMMFO-4396
declare
  l_ret varchar2(2);
begin
  bc.go(300465);
  cp.RMany(23680633401, 34356417501, to_date('21.05.2015','DD.MM.YYYY'), 20000000, 500200, l_ret);
  bc.home;
  commit;
  exception 
    when others then
      bc.home;
      raise;
end;  
/