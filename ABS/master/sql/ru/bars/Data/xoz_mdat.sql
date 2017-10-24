----------------------------------------------------------------
----------------------------------------------------------------
begin
  tuda;
update xoz_ref x
set mdate = (select XOZ_MDATE (a.acc, x.fdat, a.nbs, a.ob22, a.mdate )
             from accounts a where a.acc = x.acc)
where mdate is null;
  suda;
end; 
/
commit;

begin
  tuda;
update  xoz_ref x
set mdate = XOZ_MDATE (acc, fdat, (select nbs  from accounts where acc = x.acc), 
                                  (select ob22 from accounts where acc = x.acc),
                                  (select mdate from accounts where acc = x.acc)
                                  )  where mdate < fdat;
  suda;
end;
/
commit;