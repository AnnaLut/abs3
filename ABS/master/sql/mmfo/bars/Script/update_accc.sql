begin

for k in (select * from mv_kf  where kf= '300465') loop bc.go (k.KF);

  for x in (select rowid RI from accounts  where kv = 980 and nls in ('89986009463054','89980009463049','89981009463048','89982009463519','89982009463047','89984009463045'))

  loop  Update accounts set accc= null   where rowid = x.RI;  Update accounts set ostc=0, ostb=0,  dazs = gl.bdate +1  where rowid = x.RI; end loop;

end loop; 

bc.go('/');

end;

/

commit ;