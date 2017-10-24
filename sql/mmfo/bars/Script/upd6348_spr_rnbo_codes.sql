
update BARS.SPR_RNBO_CODES
   set TXT ='зупинення виконання економiчних та фінанс.операцiй (заборона'
 where CODE ='05';

begin
   for k in (select kf from MV_KF) loop
       bc.subst_mfo(k.kf);

       delete from customerw
        where tag ='SANKC';

       delete from customer_field
        where tag ='SANKC';
       
   end loop;

end;
/
exec bc.home;

commit;


