
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_FIN_FORMA2M.sql =========***
PROMPT ===================================================================================== 

Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('ФІНАНСОВІ РЕЗУЛЬТАТИ',10,'',null,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Чистий дохід (виручка) від реалізації продукції (товарів, робіт, послу',20,'2000',null,'C','#(030)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші операційні доходи (ряд 2160 форми 2-мс)',30,'2120',null,'C','#(040)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші доходи',40,'2240',null,'C','#(050)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Разом доходи (2000 + 2120 + 2240)',50,'2280',null,'C','#(070)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Собівартість реалізованої продукції (товарів, робіт, послуг)',60,'2050',null,'C','#(080)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші операційні витрати',70,'2180',null,'C','#(090)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Фінансові витрати',75,'2250',null,'C','#(3001)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші витрати (ряд 2165 форми 2-мс)',80,'2270',null,'C','#(100)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Разом витрати (2050 + 2180 + 2270)',90,'2285',null,'C','#(120)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Фінансовий результат до оподаткування (2280 - 2285)',100,'2290',null,'C','#(130)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Податок на прибуток',110,'2300',null,'C','#(140)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Витрати (доходи), які зменшують (збільшують) фінансовий результат післ',120,'2310',null,'C','#(145)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Чистий прибуток (збиток) (2290 - 2300)',130,'2350',null,'C','#(150)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Додаткові показники з розшифровки Боржника',3000,'',3,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Фінансові витрати',3001,'3001',4,'C','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('ФІНАНСОВІ РЕЗУЛЬТАТИ',1,'',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дохід (виручка) від реалізації продукції (товарів, робіт, послуг)',10,'010',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Непрямі податки та інші вирахування з доходу',20,'020',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Чистий дохід (виручка) від реалізації продукції (товарів, робіт, послу',30,'030',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші операційні доходи',40,'040',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші доходи',50,'050',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Разом чисті доходи (030 + 040 + 050)',70,'070',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Собівартість реалізованої продукції (товарів, робіт, послуг)',80,'080',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші операційні витрати',90,'090',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('   у тому числі:',91,'091',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('',92,'092',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші витрати',100,'100',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Разом витрати (080 + 090 + 100)',120,'120',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Фінансовий результат до оподаткування (070 - 120)',130,'130',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Податок на прибуток',140,'140',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Витр/дох., які зменш/збільш. фінансовий результат після оподаткування',145,'145',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('150) Чистий прибуток (збиток) (130–140(-/+) 145)',150,'150',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Забезпечення матеріального заохочення',160,'160',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Дохід від первісного визнання біологічних активів і сільськогосподарсь',201,'201',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Витрати від первісного визнання біологічних активів і сільськогосподар',202,'202',null,'M','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('ФІНАНСОВІ РЕЗУЛЬТАТИ',10,'',null,'R','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Чистий дохід (виручка) від реалізації продукції (товарів, робіт, послу',20,'2000',null,'R','#(030)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші операційні доходи (ряд 2160 форми 2-мс)',30,'2120',null,'R','#(040)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші доходи',40,'2240',null,'R','#(050)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Разом доходи (2000 + 2120 + 2240)',50,'2280',null,'R','#(070)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Собівартість реалізованої продукції (товарів, робіт, послуг)',60,'2050',null,'R','#(080)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші операційні витрати',70,'2180',null,'R','#(090)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Фінансові витрати',75,'2250',null,'R','#(3001)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші витрати (ряд 2165 форми 2-мс)',80,'2270',null,'R','#(100)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Разом витрати (2050 + 2180 + 2270)',90,'2285',null,'R','#(120)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Фінансовий результат до оподаткування (2280 - 2285)',100,'2290',null,'R','#(130)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Податок на прибуток',110,'2300',null,'R','#(140)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Витрати (доходи), які зменшують (збільшують) фінансовий результат післ',120,'2310',null,'R','#(145)');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Чистий прибуток (збиток) (2290 - 2300)',130,'2350',null,'R','#(150)');
    exception when dup_val_on_index then null;
end;
/
Begin
  delete from  FIN_FORMA2M where ORD=3000;
end;
/
Begin
  delete from  FIN_FORMA2M where ORD=3001;
end;
/
COMMIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_FIN_FORMA2M.sql =========***
PROMPT ===================================================================================== 
