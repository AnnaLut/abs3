/*
�    ��������
�볺���    ��� �����    ������� ��� �����    ��� �������    ������ �������
����� ����� �������
        ������������    ���    ������������    ���    ������������    ���    
1    2    3    4    6    7    8    9    10
1    ������������� �볺��    ����� ��������� �������    pr_uo    ����    ����    �������� �������    pr_uo    2512, 2513, 2520, 2523, 2526, 2530, 2531, 2541, 2542, 2544, 2545, 2550, 2551, 2552, 2553, 2554, 2555, 2556, 2560, 2561, 2562, 2565, 2570, 2571, 2572, 2600, 2601, 2602, 2603, 2604, 2606, 2640, 2641, 2642, 2643, 2644, 2650
2        ��������� �����    dep_uo    ����    ����    ���������� �������    dep_uo    2525, 2546, 2610, 2615, 2651, 2652
3        ���    kpk_uo    ����    ����    ���    kpk_uo    2605, 2655
4        ���    dbo_uo    ����    ����    �������� �������    pr_uo    2512, 2513, 2520, 2523, 2526, 2530, 2531, 2541, 2542, 2544, 2545, 2550, 2551, 2552, 2553, 2554, 2555, 2556, 2560, 2561, 2562, 2565, 2570, 2571, 2572, 2600, 2601, 2602, 2603, 2604, 2606, 2640, 2641, 2642, 2643, 2644, 2650
5                ����    ����    ���    kpk_uo    2605, 2655
6    Գ����� �����    ���    deposit    ����    ����    ���    deposit    2630, 2635
7        ���     bpk_fo    ����    ����    ���    bpk_fo    2625
8        ����    dkbo_fo    ����    ����    ���    deposit    2630, 2635
9                ����    ����    ���    bpk_fo    2625
10                ������� ������    dep_online_fo    ������� ������    dep_online_fo    2630, 2635

*/

begin 
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (2,null,'������������� �볺��', null, null, 'pr_uo', '����� ��������� �������', 'pr_uo', '�������� �������', 
 '''2512'', ''2513'', ''2520'', ''2523'', ''2526'', ''2530'', ''2531'', ''2541''
 ,''2542'', ''2544'', ''2545'', ''2550'', ''2551'', ''2552'', ''2553'', ''2554'', ''2555'', ''2556'', ''2560'', ''2561'', ''2562'', ''2565'', ''2570'', ''2571'', ''2572'', ''2600'', ''2601''
 ,''2602'', ''2603'', ''2604'', ''2606'', ''2640'', ''2641'', ''2642'', ''2643'', ''2644'', ''2650''', null);
 
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (3,'91','������������� �볺�� ���', null, null, 'pr_uo', '����� ��������� �������', 'pr_uo', '�������� �������', 
 '''2512'', ''2513'', ''2520'', ''2523'', ''2526'', ''2530'', ''2531'', ''2541''
 ,''2542'', ''2544'', ''2545'', ''2550'', ''2551'', ''2552'', ''2553'', ''2554'', ''2555'', ''2556'', ''2560'', ''2561'', ''2562'', ''2565'', ''2570'', ''2571'', ''2572'', ''2600'', ''2601''
 ,''2602'', ''2603'', ''2604'', ''2606'', ''2640'', ''2641'', ''2642'', ''2643'', ''2644'', ''2650''', null);
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (2,null,'������������� �볺��', null, null, 'dep_uo', '��������� �����', 'dep_uo', '���������� �������',
 '''2525'', ''2546'', ''2610'', ''2615'', ''2651'', ''2652''', null);
 
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (3,'91','������������� �볺�� ���', null, null, 'dep_uo', '��������� �����', 'dep_uo', '���������� �������', 
 '''2525'', ''2546'', ''2610'', ''2615'', ''2651'', ''2652''', null);
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (2,null,'������������� �볺��', null, null, 'kpk_uo', '���', 'kpk_uo', '���',
 '''2605'', ''2655''', null);
 
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (3,'91','������������� �볺�� ���', null, null, 'kpk_uo', '���', 'kpk_uo', '���', 
 '''2605'', ''2655''', null);
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (2,null,'������������� �볺��', null, null, 'dbo_uo', '���', 'pr_uo', '�������� �������',
 '''2512'', ''2513'', ''2520'', ''2523'', ''2526'', ''2530'', ''2531'', ''2541''
 ,''2542'', ''2544'', ''2545'', ''2550'', ''2551'', ''2552'', ''2553'', ''2554'', ''2555'', ''2556'', ''2560'', ''2561'', ''2562'', ''2565'', ''2570'', ''2571'', ''2572'', ''2600'', ''2601''
 ,''2602'', ''2603'', ''2604'', ''2606'', ''2640'', ''2641'', ''2642'', ''2643'', ''2644'', ''2650''', null);
 
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (3,'91','������������� �볺�� ���', null, null, 'dbo_uo', '���', 'pr_uo', '�������� �������', 
 '''2512'', ''2513'', ''2520'', ''2523'', ''2526'', ''2530'', ''2531'', ''2541''
 ,''2542'', ''2544'', ''2545'', ''2550'', ''2551'', ''2552'', ''2553'', ''2554'', ''2555'', ''2556'', ''2560'', ''2561'', ''2562'', ''2565'', ''2570'', ''2571'', ''2572'', ''2600'', ''2601''
 ,''2602'', ''2603'', ''2604'', ''2606'', ''2640'', ''2641'', ''2642'', ''2643'', ''2644'', ''2650''', null); 
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (2,null,'������������� �볺��', null, null, 'dbo_uo', '���', 'kpk_uo', '���',
 '''2605'', ''2655''', null);
 
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (3,'91','������������� �볺�� ���', null, null, 'dbo_uo', '���', 'kpk_uo', '���',
 '''2605'', ''2655''', null);
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (3,null,'Գ����� �����', null, null, 'deposit', '���', 'deposit', '���',
 '''2630'', ''2635''', null);
 
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (3,null,'Գ����� �����', null, null, 'bpk_fo', '��� ', 'bpk_fo', '��� ',
 '''2625''', null); 

 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (3,null,'Գ����� �����',  null, null, 'dkbo_fo', '����', 'bpk_fo', '��� ',
 '''2625''', null); 
 insert into EAD_MAIN_SETTINGS  (CUSTTYPE, SED, CUSTNAME, PARENT_AGR_TYPE, PARENT_AGR_NAME, AGR_TYPE, AGR_NAME, ACCOUNT_TYPE, ACCOUNT_NAME, NBS, OB22)
 values (3,null,'Գ����� �����',  'dkbo_fo', '����', 'dep_online_fo', '������� ������', 'dep_online_fo', '������� ������',
 '''2630'', ''2635''', null);
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
end;
/
commit; 
/

 