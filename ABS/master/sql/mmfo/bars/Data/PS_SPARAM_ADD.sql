begin
  for k in (select  distinct  substr(from_prod,1,4) FROM_NBS, substr(to_prod,1,4) TO_NBS from   RECLASS9)
  loop insert into PS_SPARAM  (NBS,   SPID,   OPT,   SQLVAL )
                   select k.TO_NBS, f.SPID, f.OPT, f.SQLVAL 
                   from  PS_SPARAM  f
                   where f.NBS = k.FROM_NBS and not exists ( select 1 from PS_SPARAM x where x.NBS = k.TO_NBS and x.SPID = f.SPID) ;
  end loop;
  commit;
end ;
/

