begin
 for m in (select kf from mv_kf)
  loop
    bc.go(m.kf);
    update ACCOUNTSW set value='FVTPL/Other' where value = 'FVTPL' and tag='IFRS';
    end loop;
    commit;
    bc.home;
end;
/