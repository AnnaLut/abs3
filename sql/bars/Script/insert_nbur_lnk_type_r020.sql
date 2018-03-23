-- рахунки резерву для овердрафтів

exec bc.home;

delete from nbur_lnk_type_r020
where acc_r020 in ('2609','2619','2629','2659');

insert into NBUR_LNK_TYPE_R020
(acc_type, acc_r020, start_date, finish_date)
values 
('RZS', '2609', to_date('02/12/2017','dd/mm/yyyy'), null);

insert into NBUR_LNK_TYPE_R020
(acc_type, acc_r020, start_date, finish_date)
values 
('RZS', '2619', to_date('02/12/2017','dd/mm/yyyy'), null);

insert into NBUR_LNK_TYPE_R020
(acc_type, acc_r020, start_date, finish_date)
values 
('RZS', '2629', to_date('02/12/2017','dd/mm/yyyy'), null);

insert into NBUR_LNK_TYPE_R020
(acc_type, acc_r020, start_date, finish_date)
values 
('RZS', '2659', to_date('02/12/2017','dd/mm/yyyy'), null);

commit;



