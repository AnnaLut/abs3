/*ТОМАС: параметри терміналу */
prompt Importing table ibx_tp_params_lst...

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('NLS_ACC', 'Номер рахунку обліку', '1004');

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('NLS_BR', 'Бранч, під яким відкрито рахунок обліку', '[MFO]');

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('COV_ACC', 'Номер рахунку покриття при операціях з пристроєм', '2920');

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('COV_BR', 'Бранч, під яким відкрито рахунок покриття', '[MFO]');

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('TRANS_ACC', 'Номер транзитного рахунку при операціях з пристроєм', '2902');

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('TRANS_BR', 'Бранч, під яким відкрито транзитний рахунок', '[MFO]');

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('FEE_ACC', 'Номер рахунку комісії при операціях з пристроєм', '6110');

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('FEE_BR', 'Бранч, під яким відкрито рахунок комісії', '[MFO]');

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('TRANS_CARD_ACC', 'Транзитний рахунок для операцій по картрахункам', '2924');

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('TRANS_CARD_BR', 'Бранч, під яким відкрито транзитний рахунок для операцій по картрахункам', '[MFO]');

prompt Done.
