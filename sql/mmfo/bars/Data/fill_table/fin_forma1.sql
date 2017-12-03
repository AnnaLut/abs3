
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_FIN_FORMA1.sql =========*** 
PROMPT ===================================================================================== 

Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('АКТИВ',0,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('I. Необоротні активи',8,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Нематеріальні активи:',9,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('залишкова вартість',10,'010',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('первісна вартість',11,'011',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('накопичена амортизація ',12,'012',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Незавершені капітальні інвестиції',20,'020',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Основні засоби:',29,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('залишкова вартість',30,'030',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('первісна вартість',31,'031',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('знос',32,'032',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Довгострокові біологічні активи:',34,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('справедлива (залишкова) вартість',35,'035',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('первісна вартість',36,'036',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('накопичена амортизація',37,'037',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Довгострокові фінансові інвестиції:',39,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('які обліковуються за методом участі в капіталі інших підприємств',40,'040',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('інші фінансові інвестиції',45,'045',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Довгострокова дебіторська заборгованість',50,'050',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Справедлива (залишкова) вартість інвестиційної нерухомості',55,'055',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Первісна вартість інвестиційної нерухомості',56,'056',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Знос інвестиційної нерухомості',57,'057',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Відстрочені податкові активи',60,'060',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Гудвіл',65,'065',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші необоротні активи',70,'070',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Гудвіл при консолідації',75,'075',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом I',80,'080',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('II. Оборотні активи',98,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Виробничі запаси',100,'100',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточні біологічні активи',110,'110',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Незавершене виробництво',120,'120',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Готова продукція',130,'130',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Товари',140,'140',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Векселі одержані',150,'150',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дебіторська заборгованість за товари, роботи, послуги:',159,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('чиста реалізаційна вартість',160,'160',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('первісна вартість',161,'161',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('резерв сумнівних боргів',162,'162',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дебіторська заборгованість за розрахунками:',169,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('з бюджетом',170,'170',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('за виданими авансами',180,'180',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('з нарахованих доходів',190,'190',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('із внутрішніх розрахунків',200,'200',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інша поточна дебіторська заборгованість',210,'210',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточні фінансові інвестиції',220,'220',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Грошові кошти та їх еквіваленти:',229,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('в національній валюті',230,'230',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('у тому числі в касі',231,'231',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('в іноземній валюті',240,'240',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші оборотні активи',250,'250',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом II',260,'260',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('III. Витрати майбутніх періодів',270,'270',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('IV. Необоротні активи та групи вибуття',275,'275',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Баланс',280,'280',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('ПАСИВ',298,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('I. Власний капітал',299,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Статутний капітал',300,'300',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Пайовий капітал',310,'310',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Додатковий вкладений капітал',320,'320',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інший додатковий капітал',330,'330',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Резервний капітал',340,'340',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Нерозподілений прибуток (непокритий збиток)',350,'350',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Неоплачений капітал',360,'360',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Вилучений капітал ',370,'370',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Накопичена курсова різниця',375,'375',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом I',380,'380',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Частка меншості',385,'385',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('II. Забезпечення майбутніх витрат і платежів',399,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Забезпечення виплат персоналу',400,'400',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші забезпечення',410,'410',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Сума страхових резервів',415,'415',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Сума часток перестраховиків у страхових резервах ',416,'416',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Залишок сформованого призового фонду, що підлягає виплаті переможцям л',417,'417',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Залишок сформованого резерву на виплату джек-поту, не забезпеченого сп',418,'418',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Цільове фінансування',420,'420',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом II',430,'430',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('III. Довгострокові зобов''язання',439,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Довгострокові кредити банків',440,'440',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші довгострокові фінансові зобов''язання',450,'450',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Відстрочені податкові зобов''язання',460,'460',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші довгострокові зобов''язання',470,'470',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом III',480,'480',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('IV. Поточні зобов''язання',499,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Короткострокові кредити банків',500,'500',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточна заборгованість за довгостроковими зобов''язаннями',510,'510',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Векселі видані',520,'520',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Кредиторська заборгованість за товари, роботи, послуги',530,'530',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточні зобов''язання за розрахунками:',539,'',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('з одержаних авансів',540,'540',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('з бюджетом',550,'550',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('з позабюджетних платежів',560,'560',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('зі страхування',570,'570',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('з оплати праці',580,'580',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('з учасниками',590,'590',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('із внутрішніх розрахунків',600,'600',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Зобов''язання, пов''язані з необоротними активами та групами вибуття, ут',605,'605',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші поточні зобов''язання',610,'610',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом IV',620,'620',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('V. Доходи майбутніх періодів',630,'630',null,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Баланс',640,'640',1,' ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('I. Необоротні активи',10,'',1,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Нематеріальні активи',20,'1000',1,'N','#(010)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('первісна вартість',30,'1001',null,'N','#(011)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('накопичена амортизація',40,'1002',null,'N','#(012)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Незавершені капітальні інвестиції',50,'1005',null,'N','#(020)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Основні засоби',60,'1010',1,'N','#(030)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('первісна вартість',70,'1011',null,'N','#(031)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('знос',80,'1012',null,'N','#(032)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інвестиційна нерухомість',90,'1015',null,'N','#(055)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Первісна вартість інвестиційної нерухомості',91,'1016',null,'N','#(056)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Знос інвестиційної нерухомості',92,'1017',null,'N','#(057)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Довгострокові біологічні активи',100,'1020',null,'N','#(035)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Первісна вартість довгострокових біологічних активів',101,'1021',null,'N','#(036)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Накопичена амортизація довгострокових біологічних активів',102,'1022',null,'N','#(037)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Довг. фінан. інвест. які обліковуються за методом участі в капіталі ін',110,'1030',null,'N','#(040)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('інші фінансові інвестиції',130,'1035',null,'N','#(045)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Довгострокова дебіторська заборгованість',140,'1040',null,'N','#(050)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Відстрочені податкові активи',150,'1045',null,'N','#(060)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Гудвіл',152,'1050',null,'N','#(065)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Відстрочені аквізиційні витрати',153,'1060',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Залишок коштів у централізованих страхових резервних фондах',154,'1065',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші необоротні активи',160,'1090',null,'N','#(070)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом I',170,'1095',1,'N','#(080)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('II. Оборотні активи',180,'',1,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Запаси',190,'1100',null,'N','#(100)+#(120)+#(130)+#(140)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Виробничі запаси',191,'1101',null,'N','#(100)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Незавершене будівництво',192,'1102',null,'N','#(120)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Готова продукція',193,'1103',null,'N','#(130)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Товари',194,'1104',null,'N','#(140)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточні біологічні активи',200,'1110',null,'N','#(110)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Депозити перестрахування',205,'1115',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Векселі одержані',206,'1120',null,'N','#(150)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дебіторська заборгованість за продукцію, товари, роботи, послуги',210,'1125',null,'N','#(160)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дебіторська заборгованість за розрахунками:',220,'',null,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('за виданими авансами',230,'1130',null,'N','#(180)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('з бюджетом',240,'1135',null,'N','#(170)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('у тому числі з податку на прибуток',250,'1136',null,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дебіторська заборгованість за розрахунками з нарахованих доходів',252,'1140',null,'N','#(190)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дебіторська заборгованість за розрахунками із внутрішніх джерел',253,'1145',null,'N','#(200)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інша поточна дебіторська заборгованість',260,'1155',null,'N','#(210)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточні фінансові інвестиції',270,'1160',null,'N','#(220)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Гроші та їх еквіваленти',280,'1165',null,'N','#(230)+#(240)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Готівка',281,'1166',null,'N','#(231)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Рахунки в банках',282,'1167',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Витрати майбутніх періодів',290,'1170',null,'N','#(270)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Частка перестраховика у страхових резервах',291,'1180',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('у тому числі в:  резервах довгострокових зобов`язань',292,'1181',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('резервах збитків або резервах належних виплат',293,'1182',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('резервах незароблених премій',294,'1183',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('інших страхових резервах',295,'1184',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші оборотні активи',300,'1190',null,'N','#(250)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом II',310,'1195',1,'N','#(260)+#(270)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('III. Необоротні активи, утримувані для продажу, та групи вибуття',320,'1200',1,'N','#(275)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Баланс',330,'1300',1,'N','#(280)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('I. Власний капітал',340,'',1,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Зареєстрований (пайовий) капітал ',350,'1400',1,'N','#(300)+#(310)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Внески до незареєстрованого статутного капіталу ',351,'1401',null,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Капітал у дооцінках',360,'1405',null,'N','#(330)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Додатковий капітал',370,'1410',null,'N','#(320)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Емісійний дохід',371,'1411',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Накопичені курсові різниці',372,'1412',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Резервний капітал',380,'1415',null,'N','#(340)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Нерозподілений прибуток (непокритий збиток)',390,'1420',null,'N','#(350)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Неоплачений капітал',400,'1425',null,'N','#(360)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Вилучений капітал',410,'1430',null,'N','#(370)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші резерви',411,'1435',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Неконтрольна частка',418,'1490',1,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом I',420,'1495',1,'N','#(380)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('II. Довгострокові зобов''язання і забезпечення',430,'',1,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Відстрочені податкові зобов''язання',440,'1500',null,'N','#(460)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Пенсійні зобов`язання',441,'1505',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Довгострокові кредити банків',450,'1510',null,'N','#(440)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші довгострокові зобов''язання',460,'1515',null,'N','#(470)+#(450)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Довгострокові забезпечення',470,'1520',null,'N','#(410)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Довгострокові забезпечення витрат персоналу',471,'1521',null,'N','#(400)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Цільове фінансування',480,'1525',null,'N','#(420)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Благодійна допомога',481,'1526',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Страхові резерви',482,'1530',2,'N','#(415)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('у тому числі: резерв довгострокових зобов`язань',483,'1531',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('резерв збитків або резерв  належних витрат',484,'1532',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('резерв незароблених премій',485,'1533',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('інші страхові резерви',486,'1534',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('інвестиційні контракти',487,'1535',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Призовий фонд',488,'1540',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Резерв на виплату джек-поту',489,'1545',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом II',490,'1595',1,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('IІІ. Поточні зобов''язання і забезпечення',500,'',1,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Короткострокові кредити банків',510,'1600',null,'N','#(500)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Векселі видані',515,'1605',null,'N','#(520)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточна кредиторська заборгованість за:',520,'',1,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('довгостроковими зобов''язаннями',530,'1610',null,'N','#(510)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('товари, роботи, послуги',540,'1615',null,'N','#(530)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('розрахунками з бюджетом',550,'1620',null,'N','#(550)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('у тому числі з податку на прибуток',560,'1621',null,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('розрахунками зі страхування',570,'1625',null,'N','#(570)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('розрахунками з оплати праці',580,'1630',null,'N','#(580)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточна кредиторська заборгованість за одержаними авансами',581,'1635',null,'N','#(540)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточна кредиторська заборгованість за розрахунками з учасниками',582,'1640',null,'N','#(590)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточна кредиторська заборгованість  із внутрішніми розрахунками',583,'1645',null,'N','#(600)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточна кредиторська заборгованість за страховою діяльністю',584,'1650',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточні забезпечення',590,'1660',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Доходи майбутніх періодів',600,'1665',null,'N','#(630)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Відстрочені комісійні доходи від перестраховика',601,'1670',2,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші поточні зобов''язання',610,'1690',null,'N','#(610)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом IІІ',620,'1695',1,'N','#(620)-#(630)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('ІV.Зобов`язання, пов`язані з необор.акт.,утр.для прод.,та груп.вибуття',630,'1700',1,'N','#(605)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('V.Чиста вартість активів недержавного пенсійного фонду',631,'1800',1,'N','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Баланс',650,'1900',1,'N','#(640)');
    exception when dup_val_on_index then null;
end;
/
COMMIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_FIN_FORMA1.sql =========*** 
PROMPT ===================================================================================== 
