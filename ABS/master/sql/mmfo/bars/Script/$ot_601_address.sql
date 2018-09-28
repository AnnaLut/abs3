---+++
begin
bc.go('302076');
update customer_address set region= replace (region,'i','і') 
 where rnk in (77188903) and type_id=1;
end;
/
----+++
begin
bc.go('312356');
update customerw set value= replace (value,'i','і')
where tag ='FGADR' and rnk=1818808;
update customer_address set street='Залізнична', home='80'
where rnk=1818808 and type_id=1;
end;
----+++
/
begin
bc.go('312356');
update customer_address set locality= replace (locality,'`','’') 
 where rnk in (1720608) and type_id=1;
end;
/
----+++
begin
bc.go('312356');
update customer_address set region= replace (region,'i','і') 
 where rnk in (33141408) and type_id=1;
end;
/
---+++
begin
bc.go('312356');
update customer_address set locality='Київ' 
 where rnk in (51596408) and type_id=1;
end;
/
---+++
----!!!!! нет zip!!!!!
begin
bc.go('312356');
update customer_address set locality= replace (locality,'i','і'),street='Будівельна', home='16'
 where rnk in (2432608) and type_id=1;
end;
/
---+++
begin
bc.go('312356');
update customer_address set locality='Київ', region='Київ' 
 where rnk in (56793108) and type_id=1;
end;
/
---+++
begin
bc.go('312356');
update customer_address set region= replace (region,'i','і') 
 where rnk in (7953108) and type_id=1;
end;
/
---+++
begin
bc.go('312356');
update customer_address set street= replace (street,'i','і') 
 where rnk in (7206508) and type_id=1;
end;
/
---+++
begin
bc.go('312356');
update customer_address set street= replace (street,'i','і') 
 where rnk in (3879408) and type_id=1;
end;
/
---+++!!! street!!!!
begin
bc.go('312356');
update customer_address set region= replace (region,'I','І'),locality= replace (locality,'i','і') 
 where rnk in (1993108) and type_id=1;
end;
/
---+++
begin
bc.go('312356');
update customer_address set region= replace (region,'i','і'), street='Санаторна', home='4' 
 where rnk in (7665808)and type_id=1;
end;
/
---+++
begin
bc.go('312356');
update customer_address set street= replace (street,'i','і') 
 where rnk in (30252008) and type_id=1;
end;
/
---+++
begin
bc.go('312356');
update customer_address set locality= replace (locality,'`','’'), street='Незалежності',  home='28'
 where rnk in (487708) and type_id=1;
end;
/
---+++
begin
bc.go('312356');
update customer_address set locality= replace (locality,'`','’'), street='Хустська',  home='27'
 where rnk in (1717208) and type_id=1;
end;
/
---22222222222222222
---+++
begin
bc.go('312356');
update customer_address set locality= replace (locality,'`','’'), street='Волошина',  home='67' 
 where rnk in (1741608) and type_id=1;
end;
/
---+++
begin
bc.go('312356');
update customer_address set region= replace (region,'i','і'), street='Кольки',  home='59'  
 where rnk in (195408) and type_id=1;
end;
/
---+++
begin
bc.go('312356');
update customer_address set street= replace (street,'i','і') 
 where rnk in (2372908) and type_id=1;
end;
/
---+++
begin
bc.go('312356');
update customer_address set address= replace (address,'I','І'), street='І Франка',home='121' 
 where rnk in (2780008) and type_id=1;
end;
/
---+++
begin
bc.go('322669');
update customer_address set street= replace(street,'i','і')  
 where rnk in (51122311) and type_id=1;
end;
/
---+++
begin
bc.go('326461');
update customer_address set street= replace(street,'i','і')  
 where rnk in (34026415) and type_id=1;
end;
/
---+++ уже исправлено баанком
---begin
---bc.go('328845');
---update customer_address set locality='А-Іванівка'
---where rnk in (16467716);
---end;
---/
---+++
begin
bc.go('328845');
update customer_address set street= replace(street,'i','і')  
 where rnk in (60174216) and type_id=1;
end;
/
---+++
begin
bc.go('331467');
update customer_address set street= replace(street,'i','і')  
 where rnk in (2240317) and type_id=1;
end;
/
---+++
begin
bc.go('331467');
update customer_address set region= replace (region,'i','і') , locality= replace (locality,'i','і') 
 where rnk in (2219517) and type_id=1;
end;
---+++
/
begin
bc.go('331467');
update customer_address set street='Бiрюзова',home='90' 
 where rnk in (80917) and type_id=1;
end;
/
---+++
begin
bc.go('331467');
update customer_address set street= replace(street,'i','і')  
 where rnk in (12256817) and type_id=1;
end;
/
---+++
begin
bc.go('331467');
update customer_address set home='14' 
 where rnk in (76613917) and type_id=1;
end;
/
---+++
begin
bc.go('331467');
update customer_address set locality='Іванівка' 
 where rnk in (46606017) and type_id=1;
end;
/
---+++
begin
bc.go('336503');
update customer_address set street='Косiвська',home='3' 
 where rnk in (72928010) and type_id=1;
end;
/
---+++
begin
bc.go('336503');
update customer_address set locality='с.Потічок'
 where rnk in (22986310) and type_id=1;
end;
/
---+++
begin
bc.go('336503');
update customer_address set locality= replace (locality,'`','’')
 where rnk in (92110710) and type_id=1;
end;
/
---+++
begin
bc.go('336503');
update customer_address set street= replace(street,'i','і')
 where rnk in (21299710) and type_id=1;
end;
/
---+++
begin
bc.go('336503');
update customer_address set street= replace(street,'i','і')
 where rnk in (84697910) and type_id=1;
end;
/
---+++
begin
bc.go('336503');
update customer_address set street= replace(street,'i','і')
 where rnk in (27240410) and type_id=1;
end;
/
---+++
begin
bc.go('336503');
update customer_address set street='Молодiжна',home='43' 
 where rnk in (27111510) and type_id=1;
end;-- 
/
---+++
begin
bc.go('336503');
update customer_address set street= replace(street,'i','і')
 where rnk in (77646010) and type_id=1;
end;
/
---+++
begin
bc.go('336503');
update customer_address set street= replace(street,'i','і')
 where rnk in (62468410) and type_id=1;
end;
/
---+++
begin
bc.go('336503');
update customer_address set homepart= replace(homepart,'a','а')
 where rnk in (38666410) and type_id=1;
end;
/
---+++!!!!----
begin
bc.go('336503');
update customer_address set address= replace(address,'i','і')
 where rnk in (27034410) and type_id=1;
end;
/
---+++
begin
bc.go('336503');
update customer_address set locality= replace(locality,'i','і')
 where rnk in (68784010) and type_id=1;
end;
/
---+++!!!!-----
begin
bc.go('336503');
update customer_address set address= replace(address,'i','і')
 where rnk in (26753910) and type_id=1;
end;
/
---+++
begin
bc.go('336503');
update customer_address set street='Пp.Незалежності', home='8а' 
 where rnk in (42767610) and type_id=1;
end;
/
---+++
begin
bc.go('351823');
update customer_address set address='Сериківська, 36-А, 18', locality='Харків',street='Сериківська', home='36-А' 
 where rnk in (2001721) and type_id=1;
end;
/
---+++
begin
bc.go('351823');
update customer_address set locality='Ст. Мерчик'
 where rnk in (157217321) and type_id=1;
end;
/
---+++
begin
bc.go('354507');
update customer_address set locality=replace(locality,'i','і')
 where rnk in (59804124) and type_id=1;
end;
/
---+++!!!!---- OBJECT_ID 199476
--begin
--bc.go('336503');
--update customer_address set zip=78600
--where rnk in (62972510) and type_id=1;
--end;
--/
---+++
begin
bc.go('322669');
update customer_address set home='6/6а'
 where rnk in (205524711) and type_id=1;
end;
/
---+++
begin
bc.go('333368');
update customer_address set region='Городищенська с.р'
 where rnk in (91706018) and type_id=1;
bc.go('/');
end;
/
commit;
/
