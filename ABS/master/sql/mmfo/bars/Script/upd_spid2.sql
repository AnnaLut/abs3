update SPARAM_LIST s set S.NSISQLWHERE = 'R020=substr(:NLS,1,4) and d_close is null' where s.spid = 2 and s.name = 'R013';

commit;