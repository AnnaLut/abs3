
update BARS.SPR_RNBO_CODES
   set TXT ='зупинення виконання економiчних та фінанс.операцiй (заборона'
 where CODE ='05';

delete from customerw
 where tag ='SANKC';

delete from customer_field
 where tag ='SANKC';

commit;


