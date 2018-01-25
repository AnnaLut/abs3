BEGIN

 

FOR k IN (SELECT kf FROM BARS.mv_kf)

 

loop

bc.go(k.kf);

insert into br_normal_edit (br_id, bdate, rate, kf, kv)

 

select 100, to_date('26012018','ddmmyyyy'),16.0,k.kf,  kv from tabval$global  where kv in  (980,978,643,840);

bc.home;

end loop;

 

end;
/
commit;  