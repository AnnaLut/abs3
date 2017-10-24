/*
№    Категорія
клієнта    Тип угоди    Дочірній тип угоди    Тип рахунка    Номера рахунків
згідно плану рахунків
        Найменування    Код    Найменування    Код    Найменування    Код    
1    2    3    4    6    7    8    9    10
1    Корпоративний клієнт    Угода поточного рахунку    pr_uo    намає    намає    Поточний рахунок    pr_uo    2512, 2513, 2520, 2523, 2526, 2530, 2531, 2541, 2542, 2544, 2545, 2550, 2551, 2552, 2553, 2554, 2555, 2556, 2560, 2561, 2562, 2565, 2570, 2571, 2572, 2600, 2601, 2602, 2603, 2604, 2606, 2640, 2641, 2642, 2643, 2644, 2650
2        Депозитна угода    dep_uo    намає    намає    Депозитний рахунок    dep_uo    2525, 2546, 2610, 2615, 2651, 2652
3        КПК    kpk_uo    намає    намає    КПК    kpk_uo    2605, 2655
4        ДБО    dbo_uo    намає    намає    Поточний рахунок    pr_uo    2512, 2513, 2520, 2523, 2526, 2530, 2531, 2541, 2542, 2544, 2545, 2550, 2551, 2552, 2553, 2554, 2555, 2556, 2560, 2561, 2562, 2565, 2570, 2571, 2572, 2600, 2601, 2602, 2603, 2604, 2606, 2640, 2641, 2642, 2643, 2644, 2650
5                намає    намає    КПК    kpk_uo    2605, 2655
6    Фізична особа    ДФО    deposit    намає    намає    ДФО    deposit    2630, 2635
7        БПК     bpk_fo    намає    намає    БПК    bpk_fo    2625
8        ДКБО    dkbo_fo    намає    намає    ДФО    deposit    2630, 2635
9                намає    намає    БПК    bpk_fo    2625
10                Депозит онлайн    dep_online_fo    Депозит онлайн    dep_online_fo    2630, 2635

*/

begin 
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (2,null,'Корпоративний клієнт', null, null, 'pr_uo', 'Угода поточного рахунку', 'pr_uo', 'Поточний рахунок', 
 '''2512'', ''2513'', ''2520'', ''2523'', ''2526'', ''2530'', ''2531'', ''2541''
 ,''2542'', ''2544'', ''2545'', ''2550'', ''2551'', ''2552'', ''2553'', ''2554'', ''2555'', ''2556'', ''2560'', ''2561'', ''2562'', ''2565'', ''2570'', ''2571'', ''2572'', ''2600'', ''2601''
 ,''2602'', ''2603'', ''2604'', ''2606'', ''2640'', ''2641'', ''2642'', ''2643'', ''2644'', ''2650''', null);
 
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (3,'91','Корпоративний клієнт СПД', null, null, 'pr_uo', 'Угода поточного рахунку', 'pr_uo', 'Поточний рахунок', 
 '''2512'', ''2513'', ''2520'', ''2523'', ''2526'', ''2530'', ''2531'', ''2541''
 ,''2542'', ''2544'', ''2545'', ''2550'', ''2551'', ''2552'', ''2553'', ''2554'', ''2555'', ''2556'', ''2560'', ''2561'', ''2562'', ''2565'', ''2570'', ''2571'', ''2572'', ''2600'', ''2601''
 ,''2602'', ''2603'', ''2604'', ''2606'', ''2640'', ''2641'', ''2642'', ''2643'', ''2644'', ''2650''', null);
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (2,null,'Корпоративний клієнт', null, null, 'dep_uo', 'Депозитна угода', 'dep_uo', 'Депозитний рахунок',
 '''2525'', ''2546'', ''2610'', ''2615'', ''2651'', ''2652''', null);
 
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (3,'91','Корпоративний клієнт СПД', null, null, 'dep_uo', 'Депозитна угода', 'dep_uo', 'Депозитний рахунок', 
 '''2525'', ''2546'', ''2610'', ''2615'', ''2651'', ''2652''', null);
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (2,null,'Корпоративний клієнт', null, null, 'kpk_uo', 'КПК', 'kpk_uo', 'КПК',
 '''2605'', ''2655''', null);
 
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (3,'91','Корпоративний клієнт СПД', null, null, 'kpk_uo', 'КПК', 'kpk_uo', 'КПК', 
 '''2605'', ''2655''', null);
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (2,null,'Корпоративний клієнт', null, null, 'dbo_uo', 'ДБО', 'pr_uo', 'Поточний рахунок',
 '''2512'', ''2513'', ''2520'', ''2523'', ''2526'', ''2530'', ''2531'', ''2541''
 ,''2542'', ''2544'', ''2545'', ''2550'', ''2551'', ''2552'', ''2553'', ''2554'', ''2555'', ''2556'', ''2560'', ''2561'', ''2562'', ''2565'', ''2570'', ''2571'', ''2572'', ''2600'', ''2601''
 ,''2602'', ''2603'', ''2604'', ''2606'', ''2640'', ''2641'', ''2642'', ''2643'', ''2644'', ''2650''', null);
 
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (3,'91','Корпоративний клієнт СПД', null, null, 'dbo_uo', 'ДБО', 'pr_uo', 'Поточний рахунок', 
 '''2512'', ''2513'', ''2520'', ''2523'', ''2526'', ''2530'', ''2531'', ''2541''
 ,''2542'', ''2544'', ''2545'', ''2550'', ''2551'', ''2552'', ''2553'', ''2554'', ''2555'', ''2556'', ''2560'', ''2561'', ''2562'', ''2565'', ''2570'', ''2571'', ''2572'', ''2600'', ''2601''
 ,''2602'', ''2603'', ''2604'', ''2606'', ''2640'', ''2641'', ''2642'', ''2643'', ''2644'', ''2650''', null); 
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (2,null,'Корпоративний клієнт', null, null, 'dbo_uo', 'ДБО', 'kpk_uo', 'КПК',
 '''2605'', ''2655''', null);
 
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (3,'91','Корпоративний клієнт СПД', null, null, 'dbo_uo', 'ДБО', 'kpk_uo', 'КПК',
 '''2605'', ''2655''', null);
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (3,null,'Фізична особа', null, null, 'deposit', 'ДФО', 'deposit', 'ДФО',
 '''2630'', ''2635''', null);
 
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (3,null,'Фізична особа', null, null, 'bpk_fo', 'БПК ', 'bpk_fo', 'БПК ',
 '''2625''', null); 

 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (3,null,'Фізична особа',  null, null, 'dkbo_fo', 'ДКБО', 'bpk_fo', 'БПК ',
 '''2625''', null); 
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (3,null,'Фізична особа',  'dkbo_fo', 'ДКБО', 'dep_online_fo', 'Депозит онлайн', 'dep_online_fo', 'Депозит онлайн',
 '''2630'', ''2635''', null);
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
end;
/
commit; 
/

 