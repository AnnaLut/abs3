update  PAP_ZVT t set t.prn = 4 where t.tema in (13,15,19,20,29,30,35,36,45,2, 6, 7, 8);
commit;
/

update PAP_ZVT t set t.name = 'Доходи за операціями з клієнтами' where t.tema = 26;
commit;
/

update PAP_ZVT t set t.name = 'Витрати за операціями з клієнтами' where t.tema = 27;
commit;
/