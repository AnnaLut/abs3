
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_FIN_FORMA2.sql =========*** 
PROMPT ===================================================================================== 

Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('ФІНАНСОВІ РЕЗУЛЬТАТИ',0,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Доход (виручка) від реалізації продукції (товарів, робіт, послуг)',10,'010',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Податок на додану вартість ',15,'015',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Акцизний збір ',20,'020',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('',25,'025',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші вирахування з доходу ',30,'030',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Чистий доход (виручка) від реалізації продукції (товарів, робіт, послу',35,'035',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Собівартість реалізованої продукції (товарів, робіт, послуг)',40,'040',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Валовий:',49,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('прибуток',50,'050',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('збиток ',55,'055',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші операційні доходи',60,'060',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('у т. ч. дохід від первісного визнання біологічних активів і сільського',61,'061',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Адміністративні витрати ',70,'070',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Витрати на збут ',80,'080',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші операційні витрати ',90,'090',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('у т. ч. витрати від первісного визнання біологічних активів сільського',91,'091',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Фінансові результати від операційної діяльності:',99,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('прибуток',100,'100',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('збиток ',105,'105',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Доход від участі в капіталі',110,'110',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші фінансові доходи',120,'120',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші доходи1',130,'130',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Фінансові витрати ',140,'140',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Втрати від участі в капіталі ',150,'150',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші витрати ',160,'160',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Прибуток (збиток) від впливу інфляції на монетарні статті',165,'165',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Фінансові результати від звичайної діяльності до оподаткування:',169,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('прибуток',170,'170',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('збиток ',175,'175',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('у т. ч. прибуток від припиненої діяльності та/або прибуток від переоці',176,'176',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('у т. ч. збиток від припиненої діяльності та/або збиток від переоцінки ',177,'177',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Податок на прибуток від звичайної діяльності ',180,'180',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дохід з податку на прибуток від звичайної діяльності',185,'185',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Фінансові результати від звичайної діяльності:',189,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('прибуток',190,'190',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('збиток ',195,'195',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Надзвичайні:',199,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('доходи',200,'200',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('витрати ',205,'205',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Податки з надзвичайного прибутку ',210,'210',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Частка меншості ',215,'215',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Чистий:',219,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('прибуток',220,'220',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('збиток ',225,'225',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Забезпечення матеріального заохочення',226,'226',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('II. ЕЛЕМЕНТИ ОПЕРАЦІЙНИХ ВИТРАТ ',229,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Матеріальні затрати',230,'230',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Витрати на оплату праці',240,'240',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Відрахування на соціальні заходи',250,'250',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Амортизація',260,'260',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші операційні витрати',270,'270',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Разом',280,'280',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('III. РОЗРАХУНОК ПОКАЗНИКІВ ПРИБУТКОВОСТІ АКЦІЙ ',299,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Середньорічна кількість простих акцій',300,'300',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Скоригована середньорічна кількість простих акцій',310,'310',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Чистий прибуток (збиток) на одну просту акцію',320,'320',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Скоригований чистий прибуток (збиток) на одну просту акцію',330,'330',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дивіденди на одну просту акцію',340,'340',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('ФІНАНСОВІ РЕЗУЛЬТАТИ',0,'',1,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Чистий дохід від реалізації продукції (товарів, робіт, послуг)',10,'2000',null,'N','case when FM = ''M'' then #(030) else #(035) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Чисті зароблені страхові премії',11,'2010',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Премії підписані, валова сума',12,'2011',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Премії, передані у перестрахування',13,'2012',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Зміна резерву незароблених премій, валова сума',14,'2013',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Зміна частки перестраховиків у резерві незароблених премій',15,'2014',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Собівартість реалізованої продукції (товарів, робіт, послуг)',20,'2050',null,'N','case when FM = ''M'' then #(080) else #(040) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Чисті понесені збитки за страховими виплатами',21,'2070',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Валовий:',30,'',null,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('прибуток',40,'2090',null,'N','case when FM = ''M'' and #(030)-#(080)>0 then #(030)-#(080) when FM = ''M'' and #(030)-#(080)<=0 then 0 else #(050) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('збиток',50,'2095',null,'N','case when FM = ''M'' and #(030)-#(080)<0 then #(030)-#(080) when FM = ''M'' and #(030)-#(080)>=0 then 0 else #(055) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дохід (витрати) від зміни у резервах довгострокових зобов`язань',51,'2105',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дохід (витрати)  від зміни інших страхових резервах',52,'2110',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Зміна інших страхових резервів, валова сума',53,'2111',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Зміна частки перестраховиків в інших страхових резервів',54,'2112',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші операційні доходи',60,'2120',null,'N','case when FM = ''M'' then #(040) else #(060) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дохід від зміни вартості активів, які оцінюються за справ. вартістю',61,'2121',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дохід від первісного визначення визначення біолог. активів і СГ прод.',62,'2122',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дохід від використання коштів, вивільнених від оподаткування',63,'2123',null,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Адміністративні витрати',70,'2130',null,'N','case when FM = ''M'' then 0 else #(070) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Витрати на збут',80,'2150',null,'N','case when FM = ''M'' then 0 else #(080) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші операційні витрати',90,'2180',null,'N','#(090)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Витрати від зміни вартості активів, які оцін. за справедливою вартістю',91,'2181',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Витрат від первісного визначення визначення біолог. активів і СГ прод.',92,'2182',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Фінансовий результат від операційної діяльності:',100,'',null,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('прибуток',110,'2190',null,'N','case when FM = ''M'' and #(030)-#(080)+#(040)-#(090)>0 then #(030)-#(080)+#(040)-#(090) when FM = ''M'' and #(030)-#(080)+#(040)-#(090)<=0 then 0 else #(100) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('збиток',120,'2195',null,'N','case when FM = ''M'' and #(030)-#(080)+#(040)-#(090)<0 then #(030)-#(080)+#(040)-#(090) when FM = ''M'' and #(030)-#(080)+#(040)-#(090)>=0 then 0 else #(105) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дохід від участі в капіталі',130,'2200',null,'N','case when FM = ''M'' then 0 else #(110) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші фінансові доходи',140,'2220',null,'N','case when FM = ''M'' then 0 else #(120) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші доходи',150,'2240',null,'N','case when FM = ''M'' then #(050) else #(130) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дохід від благодійної допомоги',151,'2241',null,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Фінансові витрати',160,'2250',null,'N','case when FM = ''M'' then 0 else #(140) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Втрати від участі в капіталі',170,'2255',null,'N','case when FM = ''M'' then 0 else #(150) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші витрати',180,'2270',null,'N','case when FM = ''M'' then #(100) else #(160) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Прибуток(збиток) від впливу інфляції на монетарні статті',181,'2275',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Фінансовий результат до оподаткування:',190,'',null,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('прибуток',200,'2290',null,'N','case when FM = ''M'' and #(030)-#(080)+#(040)-#(090)+#(050)-#(100)>0 then #(030)-#(080)+#(040)-#(090)+#(050)-#(100) when FM = ''M'' and #(030)-#(080)+#(040)-#(090)+#(050)-#(100)<=0 then 0 else #(170) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('збиток',210,'2295',null,'N','case when FM = ''M'' and #(030)-#(080)+#(040)-#(090)+#(050)-#(100)<0 then #(030)-#(080)+#(040)-#(090)+#(050)-#(100) when FM = ''M'' and #(030)-#(080)+#(040)-#(090)+#(050)-#(100)>=0 then 0 else #(175) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Витрати (дохід) з податку на прибуток',220,'2300',null,'N','case when FM = ''M'' then #(140) else #(180) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Прибуток (збиток) від припиненої діяльності після оподаткування',230,'2305',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Чистий фінансовий результат:',240,'',null,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('прибуток',250,'2350',null,'N','case when FM = ''M'' and #(030)-#(080)+#(040)-#(090)+#(050)-#(100)-#(140)>0 then #(030)-#(080)+#(040)-#(090)+#(050)-#(100)-#(140) when FM = ''M'' and #(030)-#(080)+#(040)-#(090)+#(050)-#(100)-#(140)<=0 then 0 else #(190) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('збиток',260,'2355',null,'N','case when FM = ''M'' and #(030)-#(080)+#(040)-#(090)+#(050)-#(100)-#(140)<0 then #(030)-#(080)+#(040)-#(090)+#(050)-#(100)-#(140) when FM = ''M'' and #(030)-#(080)+#(040)-#(090)+#(050)-#(100)-#(140)>=0 then 0 else #(195) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дооцінка (уцінка) необоротних активів',270,'2400',null,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дооцінка (уцінка) фінансових інструментів',280,'2405',null,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Накопичені курсові різниці',290,'2410',null,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Частка іншого сукупного доходу асоційованих та спільних підприємств',300,'2415',null,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інший сукупний дохід',310,'2445',null,'N','case when FM = ''M'' then 0 else #(200)-#(205) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інший сукупний дохід до оподаткування',320,'2450',null,'N','case when FM = ''M'' then 0 else #(200)-#(205) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Податок на прибуток, пов''язаний з іншим сукупним доходом',330,'2455',null,'N','case when FM = ''M'' then 0 else #(210) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інший сукупний дохід після оподаткування',340,'2460',null,'N','case when FM = ''M'' then 0 else #(200)-#(205)-#(210) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Сукупний дохід (сума рядків 2350, 2355 та 2460)',350,'2465',null,'N','case when FM = ''M'' then #(030)-#(080)+#(040)-#(090)+#(050)-#(100)-#(140) else #(220)-#(225) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Матеріальні затрати',360,'2500',null,'N','case when FM = ''M'' then 0 else #(230) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Витрати на оплату праці',370,'2505',null,'N','case when FM = ''M'' then 0 else #(240) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Відрахування на соціальні заходи',380,'2510',null,'N','case when FM = ''M'' then 0 else #(250) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Амортизація',390,'2515',null,'N','case when FM = ''M'' then 0 else #(260) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші операційні витрати',400,'2520',null,'N','case when FM = ''M'' then 0 else #(270) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Разом',410,'2550',null,'N','case when FM = ''M'' then 0 else #(280) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Середньорічна кількість простих акцій',420,'2600',null,'N','case when FM = ''M'' then 0 else #(300) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Скоригована середньорічна кількість простих акцій',430,'2605',null,'N','case when FM = ''M'' then 0 else #(310) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Чистий прибуток (збиток) на одну просту акцію',440,'2610',null,'N','case when FM = ''M'' then 0 else #(320) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Скоригований чистий прибуток (збиток) на одну просту акцію',450,'2615',null,'N','case when FM = ''M'' then 0 else #(330) end');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дивіденди на одну просту акцію',460,'2650',null,'N','case when FM = ''M'' then 0 else #(340) end');
    exception when dup_val_on_index then null;
end;
/
COMMIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_FIN_FORMA2.sql =========*** 
PROMPT ===================================================================================== 
