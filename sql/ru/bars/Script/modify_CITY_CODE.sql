update meta_columns t
    set t.showretval = decode(t.colname, 'CITY_CODE', 1, 0)
  where t.tabid in
        (select tabid from meta_tables tt where tt.tabname = 'PHONE_CITY_CODE');
commit;        
