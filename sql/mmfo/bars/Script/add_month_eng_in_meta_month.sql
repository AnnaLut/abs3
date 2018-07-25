begin
    execute immediate 'alter table meta_month 
        add  NAME_ENG varchar(10)';
    exception when others then 
     if sqlcode = -1430 then null; else raise; 
     end if; 
end;
/ 

update meta_month
 set name_eng ='january'
where n=1;

update meta_month
 set name_eng ='february'
where n=2;

update meta_month
 set name_eng ='march'
where n=3;

update meta_month
 set name_eng ='april'
where n=4;

update meta_month
 set name_eng ='may'
where n=5;

update meta_month
 set name_eng ='june'
where n=6;

update meta_month
 set name_eng ='july'
where n=7;

update meta_month
 set name_eng ='august'
where n=8;

update meta_month
 set name_eng ='september'
where n=9;

update meta_month
 set name_eng ='october'
where n=10;

update meta_month
 set name_eng ='november'
where n=11;

update meta_month
 set name_eng ='december'
where n=12;

commit;
