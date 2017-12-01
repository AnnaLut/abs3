
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_FIN_FORMA1M.sql =========***
PROMPT ===================================================================================== 

Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('АКТИВ',10,'',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('I. Необоротні активи',20,'',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Незавершені капітальні інвестиції',30,'1005',null,'C','#(020)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Основні засоби:',40,'1010',null,'C','#(030)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('первісна вартість',50,'1011',null,'C','#(031)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('знос',60,'1012',null,'C','#(032)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Довгострокові біологічні активи',70,'1020',null,'C','#(035)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Довгострокові фінансові інвестиції',80,'1030',null,'C','#(040) + #(045)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші необоротні активи',90,'1090',null,'C','#(050) + #(055) + #(060) + #(065) + #(070) + #(075)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом I',100,'1095',null,'C','#(080)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('II. Оборотні активи',110,'',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Запаси:',120,'1100',null,'C','#(100) + #(130) + #(140) + #(120)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('у тому числі готова продукція',130,'1103',null,'C','#(130)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточні біологічні активи',140,'1110',null,'C','#(110)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дебіторська заборгованість за товари, роботи, послуги',150,'1125',null,'C','#(160)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дебіторська заборгованість за розрахунками з бюджетом',160,'1135',null,'C','#(170)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('у тому числі з податку на прибуток',170,'1136',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інша поточна дебіторська заборгованість',180,'1155',null,'C','#(210)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточні фінансові інвестиції',190,'1160',null,'C','#(220)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Гроші та їх еквіваленти',200,'1165',null,'C','#(230) + #(240)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Витрати майбутніх періодів',210,'1170',null,'C','#(270)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші оборотні активи',220,'1190',null,'C','#(250) + #(200) + #(190)  + #(150)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом II',230,'1195',null,'C','#(260) + #(270)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('III. Необоротні активи, утримувані для продажу, та групи вибуття',240,'1200',null,'C','#(275)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Баланс',250,'1300',null,'C','#(280)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('I. Власний капітал',260,'',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Зареєстрований (пайовий) капітал',270,'1400',null,'C','#(300) + #(310)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Додатковий капітал',280,'1410',null,'C','#(320) + #(330)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Резервний капітал',290,'1415',null,'C','#(340)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Нерозподілений прибуток (непокритий збиток)',300,'1420',null,'C','#(350)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Неоплачений капітал',310,'1425',null,'C','#(360) + #(370) + #(375)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Неконтрольна частка',318,'1490',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом I',320,'1495',null,'C','#(380)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Кредити та запозичення',322,'1510',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('II. Довгострокові зобов''язання, цільове фінансування та забезпечення',330,'1595',null,'C','#(430) + #(480)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('III. Поточні зобов''язання',340,'',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Короткострокові кредити банків',350,'1600',null,'C','#(500)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточна кредиторська заборгованість за:',360,'',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('довгостроковими зобов''язаннями',370,'1610',null,'C','#(510)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('товари, роботи, послуги',380,'1615',null,'C','#(530)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('розрахунками з бюджетом',390,'1620',null,'C','#(550)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('  у тому числі з податку на прибуток',400,'1621',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('розрахунками зі страхування',410,'1625',null,'C','#(570)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('розрахунками з оплати праці',420,'1630',null,'C','#(580)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Доходи майбутніх періодів',430,'1665',null,'C','#(630)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші поточні зобов''язання',440,'1690',null,'C','#(610) + #(600) + #(590) + #(540) + #(520)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом III',450,'1695',null,'C','#(620) + #(630)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('IV. Зобов''язання, пов''язані з необоротними активами, утримуваними для ',460,'1700',null,'C','#(605)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Баланс',470,'1900',null,'C','#(640)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('АКТИВ',0,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('I. Необоротні активи',8,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Нематеріальні активи:',9,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('залишкова вартість',10,'010',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('первісна вартість',11,'011',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('накопичена амортизація ',12,'012',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Незавершені капітальні інвестиції',20,'020',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Основні засоби:',29,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('залишкова вартість',30,'030',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('первісна вартість',31,'031',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('знос',32,'032',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Довгострокові біологічні активи:',34,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('справедлива (залишкова) вартість',35,'035',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('первісна вартість',36,'036',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('накопичена амортизація',37,'037',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Довгострокові фінансові інвестиції:',39,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('які обліковуються за методом участі в капіталі інших підприємств',40,'040',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('інші фінансові інвестиції',45,'045',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Довгострокова дебіторська заборгованість',50,'050',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Справедлива (залишкова) вартість інвестиційної нерухомості',55,'055',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Первісна вартість інвестиційної нерухомості',56,'056',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Знос інвестиційної нерухомості',57,'057',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Відстрочені податкові активи',60,'060',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Гудвіл',65,'065',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші необоротні активи',70,'070',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Гудвіл при консолідації',75,'075',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом I',80,'080',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('II. Оборотні активи',98,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Виробничі запаси',100,'100',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточні біологічні активи',110,'110',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Незавершене виробництво',120,'120',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Готова продукція',130,'130',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Товари',140,'140',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Векселі одержані',150,'150',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дебіторська заборгованість за товари, роботи, послуги:',159,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('чиста реалізаційна вартість',160,'160',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('первісна вартість',161,'161',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('резерв сумнівних боргів',162,'162',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дебіторська заборгованість за розрахунками:',169,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('з бюджетом',170,'170',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('за виданими авансами',180,'180',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('з нарахованих доходів',190,'190',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('із внутрішніх розрахунків',200,'200',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інша поточна дебіторська заборгованість',210,'210',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточні фінансові інвестиції',220,'220',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Грошові кошти та їх еквіваленти:',229,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('в національній валюті',230,'230',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('у тому числі в касі',231,'231',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('в іноземній валюті',240,'240',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші оборотні активи',250,'250',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом II',260,'260',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('III. Витрати майбутніх періодів',270,'270',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('IV. Необоротні активи та групи вибуття',275,'275',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Баланс',280,'280',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('ПАСИВ',298,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('I. Власний капітал',299,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Статутний капітал',300,'300',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Пайовий капітал',310,'310',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Додатковий вкладений капітал',320,'320',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інший додатковий капітал',330,'330',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Резервний капітал',340,'340',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Нерозподілений прибуток (непокритий збиток)',350,'350',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Неоплачений капітал',360,'360',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Вилучений капітал ',370,'370',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Накопичена курсова різниця',375,'375',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом I',380,'380',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Частка меншості',385,'385',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('II. Забезпечення майбутніх витрат і платежів',399,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Забезпечення виплат персоналу',400,'400',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші забезпечення',410,'410',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Сума страхових резервів',415,'415',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Сума часток перестраховиків у страхових резервах ',416,'416',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Залишок сформованого призового фонду, що підлягає виплаті переможцям л',417,'417',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Залишок сформованого резерву на виплату джек-поту, не забезпеченого сп',418,'418',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Цільове фінансування',420,'420',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом II',430,'430',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('III. Довгострокові зобов''язання',439,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Довгострокові кредити банків',440,'440',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші довгострокові фінансові зобов''язання',450,'450',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Відстрочені податкові зобов''язання',460,'460',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші довгострокові зобов''язання',470,'470',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом III',480,'480',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('IV. Поточні зобов''язання',499,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Короткострокові кредити банків',500,'500',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточна заборгованість за довгостроковими зобов''язаннями',510,'510',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Векселі видані',520,'520',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Кредиторська заборгованість за товари, роботи, послуги',530,'530',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточні зобов''язання за розрахунками:',539,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('з одержаних авансів',540,'540',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('з бюджетом',550,'550',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('з позабюджетних платежів',560,'560',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('зі страхування',570,'570',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('з оплати праці',580,'580',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('з учасниками',590,'590',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('із внутрішніх розрахунків',600,'600',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Зобов''язання, пов''язані з необоротними активами та групами вибуття, ут',605,'605',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші поточні зобов''язання',610,'610',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом IV',620,'620',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('V. Доходи майбутніх періодів',630,'630',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Баланс',640,'640',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('АКТИВ',10,'',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('I. Необоротні активи',20,'',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Незавершені капітальні інвестиції',30,'1005',null,'R','#(020)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Основні засоби:',40,'1010',null,'R','#(030)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('первісна вартість',50,'1011',null,'R','#(031)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('знос',60,'1012',null,'R','#(032)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Довгострокові біологічні активи',70,'1020',null,'R','#(035)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Довгострокові фінансові інвестиції',80,'1030',null,'R','#(040) + #(045)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші необоротні активи',90,'1090',null,'R','#(050) + #(055) + #(060) + #(065) + #(070) + #(075)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом I',100,'1095',null,'R','#(080)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('II. Оборотні активи',110,'',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Запаси:',120,'1100',null,'R','#(100) + #(130) + #(140) + #(120)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('у тому числі готова продукція',130,'1103',null,'R','#(130)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточні біологічні активи',140,'1110',null,'R','#(110)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дебіторська заборгованість за товари, роботи, послуги',150,'1125',null,'R','#(160)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дебіторська заборгованість за розрахунками з бюджетом',160,'1135',null,'R','#(170)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('у тому числі з податку на прибуток',170,'1136',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інша поточна дебіторська заборгованість',180,'1155',null,'R','#(210)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточні фінансові інвестиції',190,'1160',null,'R','#(220)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Гроші та їх еквіваленти',200,'1165',null,'R','#(230) + #(240)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Витрати майбутніх періодів',210,'1170',null,'R','#(270)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші оборотні активи',220,'1190',null,'R','#(250) + #(200) + #(190)  + #(150)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом II',230,'1195',null,'R','#(260) + #(270)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('III. Необоротні активи, утримувані для продажу, та групи вибуття',240,'1200',null,'R','#(275)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Баланс',250,'1300',null,'R','#(280)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('I. Власний капітал',260,'',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Зареєстрований (пайовий) капітал',270,'1400',null,'R','#(300) + #(310)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Додатковий капітал',280,'1410',null,'R','#(320) + #(330)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Резервний капітал',290,'1415',null,'R','#(340)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Нерозподілений прибуток (непокритий збиток)',300,'1420',null,'R','#(350)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Неоплачений капітал',310,'1425',null,'R','#(360) + #(370) + #(375)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Неконтрольна частка',318,'1490',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом I',320,'1495',null,'R','#(380)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Кредити та запозичення',322,'1510',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('II. Довгострокові зобов''язання, цільове фінансування та забезпечення',330,'1595',null,'R','#(430) + #(480)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('III. Поточні зобов''язання',340,'',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Короткострокові кредити банків',350,'1600',null,'R','#(500)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Поточна кредиторська заборгованість за:',360,'',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('довгостроковими зобов''язаннями',370,'1610',null,'R','#(510)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('товари, роботи, послуги',380,'1615',null,'R','#(530)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('розрахунками з бюджетом',390,'1620',null,'R','#(550)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('  у тому числі з податку на прибуток',400,'1621',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('розрахунками зі страхування',410,'1625',null,'R','#(570)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('розрахунками з оплати праці',420,'1630',null,'R','#(580)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Доходи майбутніх періодів',430,'1665',null,'R','#(630)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші поточні зобов''язання',440,'1690',null,'R','#(610) + #(600) + #(590) + #(540) + #(520)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Усього за розділом III',450,'1695',null,'R','#(620) + #(630)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('IV. Зобов''язання, пов''язані з необоротними активами, утримуваними для ',460,'1700',null,'R','#(605)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA1M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Баланс',470,'1900',null,'R','#(640)');
    exception when dup_val_on_index then null;
end;
/
COMMIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_FIN_FORMA1M.sql =========***
PROMPT ===================================================================================== 
