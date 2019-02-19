begin
for i in (select nbs, spid from bars.PS_SPARAM where spid=383 and nbs not in (select nbs from bars.PS_SPARAM where spid=384)) loop
  delete bars.PS_SPARAM where  nbs=i.nbs and spid=i.spid;
  end loop;
  commit;
end;
/