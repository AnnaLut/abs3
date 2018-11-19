
begin
execute immediate 'create table tmp_rko_signatory as select * from rko_signatory';
exception when others then null;
end;
/

comment on table tmp_rko_signatory is 'Тимчасова таблиця, можна грохнуть після устновки COBUMMFO-9136';


DROP SEQUENCE BARS.S_RKO_SIGNATORY;

CREATE SEQUENCE BARS.S_RKO_SIGNATORY
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  CACHE 20
  NOORDER;

begin
for k in (select KF from MV_KF)

loop
  bc.go (k.kf);
   update rko_signatory
   set id= bars_sqnc.get_nextval('s_rko_signatory');
end loop; 
bc.home;
end;
/

commit;



