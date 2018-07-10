begin
update sparam_list s set s.nsisqlwhere='bus_mod_id=15'  where s.tag='BUS_MOD';
update sparam_list s set s.nsisqlwhere='sppi_value=1'  where s.tag='SPPI';
update sparam_list s set s.nsisqlwhere='IFRS_ID=''AC'''  where s.tag='IFRS';
commit;
end;
/