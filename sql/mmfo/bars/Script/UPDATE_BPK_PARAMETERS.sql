begin
  bc.go(322669);
    update BPK_PARAMETERS  set value='AC'   where value = 'FVTPL' and tag='IFRS' and nd in(175858311,175858411,175858511,175858611);
    commit;
end;
/
