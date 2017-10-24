PROMPT *** Run *** ========== Scripts SQL\Data\fin_forma2m.sql  =========*** Run *** =====
truncate table FIN_FORMA2M;

Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('ФІНАНСОВІ РЕЗУЛЬТАТИ', 1, '', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Дохід (виручка) від реалізації продукції (товарів, робіт, послуг)', 10, '010', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Непрямі податки та інші вирахування з доходу', 20, '020', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Чистий дохід (виручка) від реалізації продукції (товарів, робіт, послу', 30, '030', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Інші операційні доходи', 40, '040', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Інші доходи', 50, '050', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Разом чисті доходи (030 + 040 + 050)', 70, '070', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Собівартість реалізованої продукції (товарів, робіт, послуг)', 80, '080', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Інші операційні витрати', 90, '090', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('   у тому числі:', 91, '091', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('', 92, '092', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Інші витрати', 100, '100', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Разом витрати (080 + 090 + 100)', 120, '120', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Фінансовий результат до оподаткування (070 - 120)', 130, '130', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Податок на прибуток', 140, '140', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Витр/дох., які зменш/збільш. фінансовий результат після оподаткування', 145, '145', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('150) Чистий прибуток (збиток) (130–140(-/+) 145)', 150, '150', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Забезпечення матеріального заохочення', 160, '160', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Дохід від первісного визнання біологічних активів і сільськогосподарсь', 201, '201', 'M', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Витрати від первісного визнання біологічних активів і сільськогосподар', 202, '202', 'M', '');


Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('ФІНАНСОВІ РЕЗУЛЬТАТИ', 10, '', 'R', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Чистий дохід (виручка) від реалізації продукції (товарів, робіт, послу', 20, '2000', 'R', '#(030)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Інші операційні доходи (ряд 2160 форми 2-мс)', 30, '2120', 'R', '#(040)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Інші доходи', 40, '2240', 'R', '#(050)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Разом доходи (2000 + 2120 + 2240)', 50, '2280', 'R', '#(070)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Собівартість реалізованої продукції (товарів, робіт, послуг)', 60, '2050', 'R', '#(080)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Інші операційні витрати', 70, '2180', 'R', '#(090)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Інші витрати (ряд 2165 форми 2-мс)', 80, '2270', 'R', '#(100)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Разом витрати (2050 + 2180 + 2270)', 90, '2285', 'R', '#(120)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Фінансовий результат до оподаткування (2280 - 2285)', 100, '2290', 'R', '#(130)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Податок на прибуток', 110, '2300', 'R', '#(140)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Витрати (доходи), які зменшують (збільшують) фінансовий результат післ', 120, '2310', 'R', '#(145)');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, FM, KOD_OLD)  Values ('Чистий прибуток (збиток) (2290 - 2300)', 130, '2350', 'R', '#(150)');

-- Додаткові показники з розшифровки Боржника
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, pob, FM, KOD_OLD)  Values ('Додаткові показники з розшифровки Боржника', 3000, null, 3, 'R', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, pob, FM, KOD_OLD)  Values ('Фінансові витрати', 3001, '3001', 4, 'R', '');


INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші витрати (ряд 2165 форми 2-мс)',80,'2270',null,'C','#(100)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші доходи',40,'2240',null,'C','#(050)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші операційні витрати',70,'2180',null,'C','#(090)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Інші операційні доходи (ряд 2160 форми 2-мс)',30,'2120',null,'C','#(040)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Витрати (доходи), які зменшують (збільшують) фінансовий результат післ',120,'2310',null,'C','#(145)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Податок на прибуток',110,'2300',null,'C','#(140)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Разом витрати (2050 + 2180 + 2270)',90,'2285',null,'C','#(120)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Разом доходи (2000 + 2120 + 2240)',50,'2280',null,'C','#(070)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Собівартість реалізованої продукції (товарів, робіт, послуг)',60,'2050',null,'C','#(080)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('ФІНАНСОВІ РЕЗУЛЬТАТИ',10,'',null,'C','');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Фінансовий результат до оподаткування (2280 - 2285)',100,'2290',null,'C','#(130)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Чистий дохід (виручка) від реалізації продукції (товарів, робіт, послу',20,'2000',null,'C','#(030)');
INSERT INTO FIN_FORMA2M(NAME,ORD,KOD,POB,FM,KOD_OLD) VALUES ('Чистий прибуток (збиток) (2290 - 2300)',130,'2350',null,'C','#(150)');

-- Додаткові показники з розшифровки Боржника
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, pob, FM, KOD_OLD)  Values ('Додаткові показники з розшифровки Боржника', 3000, null, 3, 'C', '');
Insert into BARS.FIN_FORMA2M    (NAME, ORD, KOD, pob, FM, KOD_OLD)  Values ('Фінансові витрати', 3001, '3001', 4, 'C', '');



commit;