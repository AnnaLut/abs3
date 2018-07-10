begin
  tuda;
  update accounts t
     set t.nbs = substr(t.nls, 1, 4)
   where t.daos >= date '2018-07-09'
     and tip like 'W4%' and nbs is not null 
     and t.nbs <> substr(t.nls, 1, 4)
     ;
  suda;
  commit;
end;
/
