begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('0', 'Kупівля іноземної валюти за іншими операціями');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('1', 'Купівля іноземної валюти для оплати за фактом поставки');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('2', 'Купівля іноземної валюти з метою попередньої оплати');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('3', 'Переказ іноземної валюти з метою попередньої оплати');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('4', 'Купівля іноземної валюти з метою попередньої оплати за імпорт товару з використанням акредитивної форми розрахунків відповідно до умов, визначених підпунктом 2 пункту 1 постанови Правління НБУ від 23 лютого 2015 року N 124 "Про особливості здійснення деяких валютних операцій"');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('5', 'Переказ іноземної валюти за іншими операціями');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('6', 'Перерахування коштів у гривнях з метою попередньої оплати за дорученням клієнта-резидента на користь нерезидента через кореспондентськийрахунок банка-нерезидента у гривнях, відкритий в уповноваженому банку');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('7', 'Перерахування коштів у гривнях за іншими операціями за дорученням клієнта-резидента на користь нерезидента через кореспондентський рахунок банку-нерезидента в гривнях, відкритий в уповноваженому банку');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('8', 'Перерахування коштів, що здійснюється на користь нерезидентів через філії уповноважених банків, відкриті на території інших держав');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('9', 'Купівля/перерахування іноземної валюти з метою повернення за кордон іноземному інвестору дивідендів');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('A', 'Купівля/перерахування коштів для оплати лікування фізичних осіб за кордоном');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('B', 'Купівля/перерахування іноземної валюти з метою повернення за кордон іноземному інвестору коштів, отриманих від продажу цінних паперів'
||' (крім продажу державних облігацій України на фондових біржах та поза їх межами, а також продажу боргових/лістингових цінних паперів на фондових біржах),' 
||' корпоративних прав, коштів, отриманих унаслідок зменшення статутних капіталів юридичних осіб, виходу з господарських товариств іноземних інвесторів');       
exception when dup_val_on_index then null;
          when others then raise;
end;
/

COMMIT;