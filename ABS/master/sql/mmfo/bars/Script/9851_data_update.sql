
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_CCK_CPROD.sql =========*** R
PROMPT ===================================================================================== 

begin
bars_policy_adm.disable_policies('CCK_CPROD');
bc.go('/');
end;
/

delete from cck_cprod where 1=1;

   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (1,'На купівлю транспортних засобів/Кредит на оновлення ТЗ','С107.0.01');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (2,'Кредит під 100% депозит','С102.0.01');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (3,'Здійснення витрат капітального характеру','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (4,'На поповнення обігових коштів','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (5,'Інвестиційні проекти','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (6,'На придбання нерухомості з іпотекою цієї нерухомості','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (7,'Гарантія, покрита грошима на депозиті','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (8,'Гарантія, непокрита грошима на депозиті','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (9,'Аваль векселів','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (10,'Врахування векселів','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (11,'Інше','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (12,'Непокриті акредитиви','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (13,'«Овердрафт»','С103.0.01');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (14,'«Овердрафт Холдингу»','С104.0.01');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (15,'«NATIONAL POOLING PLUS»','С105.0.01');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (16,'Рефінансування витрат на спорудження ОЕ','С108.0.01');

COMMIT;

begin
bars_policy_adm.enable_policies('CCK_CPROD');
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_CCK_CPROD.sql =========*** E
PROMPT ===================================================================================== 
