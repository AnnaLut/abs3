
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_FIN_KOD.sql =========*** Run
PROMPT ===================================================================================== 

Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Інші витрати',13,'AZ13',11,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Інші довгострокові зобов''язання',11,'AP11',13,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Інші доходи',12,'AZ12',11,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Інші необоротні активи',6,'AB6',12,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Інші оборотні активи',12,'AB12',12,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Інші операційні витрати',7,'AZ7',11,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Інші операційні доходи',4,'AZ4',11,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Інші поточні зобов''язання',16,'AP16',13,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Адміністративні витрати',5,'AZ5',11,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Активи ',1,'AB1',12,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Амортизація',18,'AZ18',11,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Відкладені податкові активи',5,'AB5',12,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Відкладені податкові зобов''язання',10,'AP10',13,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Валовий прибуток / збиток',3,'AZ3',11,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Виручка від реалізації продукції',1,'AZ1',11,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Витрати на збут',6,'AZ6',11,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Власний капітал',6,'AP6',13,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Грошові кошти',11,'AB11',12,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Довгострокові зобов''язання',12,'AP12',13,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Запаси',8,'AB8',12,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Капітал',8,'AP8',13,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Кредити та запозичення',9,'AP9',13,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Неконтрольна частка',7,'AP7',13,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Нематеріальні активи',3,'AB3',12,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Необоротні активи',7,'AB7',12,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Нерозподілений прибуток / збиток',5,'AP5',13,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Оборотні активи',13,'AB13',12,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Операційний прибуток / збиток',8,'AZ8',11,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Основні засоби, нерухомість та обладнання ',2,'AB2',12,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Пасиви',1,'AP1',13,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Податки',16,'AZ16',11,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Податкові зобов''язання',15,'AP15',13,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Поточні зобов''язання',17,'AP17',13,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Поточні кредити та запозичення',13,'AP13',13,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Поточні податкові активи',10,'AB10',12,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Поточна дебіторська заборгованість',9,'AB9',12,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Прибуток / збиток до оподаткування',15,'AZ15',11,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Резерв накопичених курсових різниць',4,'AP4',13,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Результат від участі в капіталі',11,'AZ11',11,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Собівартість реалізованої продукції',2,'AZ2',11,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Статутний капітал',2,'AP2',13,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Торгова та інша дебіторська заборгованість',4,'AB4',12,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Торгова та інша кредиторська заборгованість',14,'AP14',13,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Фінансові витрати',10,'AZ10',11,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Фінансові доходи',9,'AZ9',11,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Фонд переоцінки',3,'AP3',13,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Чистий прибуток / збиток',17,'AZ17',11,'F');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_KOD(NAME,ORD,KOD,IDF,FM) VALUES ('Чистий прибуток / збиток від курсових різниць',14,'AZ14',11,'F');
    exception when dup_val_on_index then null;
end;
/
COMMIT;

begin
 for x in ( 
         select *
          from BARS.FIN_QUESTION
          where kod in ('KR2', 'KR4', 'BO1' )
            and idf in (72, 73)
          )
loop
delete from BARS.FIN_QUESTION_REPLY where kod = x.kod and idf = x.idf;
delete from BARS.FIN_QUESTION where kod = x.kod and idf = x.idf;
end loop;
commit;
end;
/ 


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_FIN_KOD.sql =========*** End
PROMPT ===================================================================================== 
