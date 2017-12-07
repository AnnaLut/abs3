
begin

for i in (select distinct branch from dpt_deposit where nls_p like '2635%' or nls_d like '2635%' ) loop
    bc.go(i.branch);
    update bars.dpt_deposit d set d.nls_p = coalesce((select a.nls from accounts a where a.nlsalt = d.nls_p and a.kv = d.kv), d.nls_p)
    where d.nls_p like '2635%' and branch = i.branch;    
    
    update bars.dpt_deposit d set d.nls_d = coalesce((select a.nls from accounts a where a.nlsalt = d.nls_d and a.kv = d.kv), d.nls_d)
    where d.nls_d like '2635%' and branch = i.branch;    
    
end loop;

commit;

end;
/
