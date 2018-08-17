begin
  for k in (select kf from mv_kf) 
  loop
     bc.go(k.kf);
    for c in (select a.* from accounts a  where a.nbs = '2630' and a.ob22 = 'D3' and a.dazs is null and a.ostc = 0) 
    loop
     update accounts set dazs = gl.BD+1 where acc = c.acc;
    end loop;
  end loop; 
bc.home;
end;
/
commit;