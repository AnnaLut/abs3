begin
 insert into PS_SPARAM(NBS, SPID,OPT) values (3540,382,1);
 insert into PS_SPARAM(NBS, SPID,OPT) values (3540,383,1);
 insert into PS_SPARAM(NBS, SPID,OPT) values (3540,384,1);
exception when others then null;
end;
/
update sparam_list s set s.nsisqlwhere='bus_mod_id=15', s.tabcolumn_check='15' where s.tag='BUS_MOD';
update sparam_list s set s.nsisqlwhere='sppi_value=1',  s.tabcolumn_check='Так' where s.tag='SPPI';
update sparam_list s set s.nsisqlwhere='IFRS_ID=''AC''',s.tabcolumn_check='AC' where s.tag='IFRS';
update PS_SPARAM  set opt=1 where spid in (382,383,384);
commit;
/