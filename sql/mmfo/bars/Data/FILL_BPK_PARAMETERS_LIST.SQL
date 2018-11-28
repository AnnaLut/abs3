prompt Importing table bpk_parameters_list...

BEGIN
insert into bpk_parameters_list (PARAM_CODE, PARAM_NAME, CONTROLL_TYPE, DATA_TYPE, DATA_SOURCE, COMM)
values ('BUS_MOD', 'Тип бізнес моделі для договору', 'handbook', null, 'BUS_MOD', null);
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/
BEGIN
insert into bpk_parameters_list (PARAM_CODE, PARAM_NAME, CONTROLL_TYPE, DATA_TYPE, DATA_SOURCE, COMM)
values ('IFRS', 'Класифікаіція за МСФЗ', 'handbook', null, 'IFRS', null);
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/
BEGIN
insert into bpk_parameters_list (PARAM_CODE, PARAM_NAME, CONTROLL_TYPE, DATA_TYPE, DATA_SOURCE, COMM)
values ('SPPI', 'Відповідність критерію SPPI', 'handbook', null, 'SPPI', null);
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/
BEGIN
insert into bpk_parameters_list (PARAM_CODE, PARAM_NAME, CONTROLL_TYPE, DATA_TYPE, DATA_SOURCE, COMM)
values ('FLAGINSURANCE', 'Страхування кредиту', 'dropdown', null, '"[
  {"text":"Так","value":1},
  {"text":"Ні","value":0}
]"', null);
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/
BEGIN
insert into bpk_parameters_list (PARAM_CODE, PARAM_NAME, CONTROLL_TYPE, DATA_TYPE, DATA_SOURCE, COMM)
values ('NAMEW', 'найменування роботодавця', 'input', 'C:254', null, null);
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/
BEGIN
insert into bpk_parameters_list (PARAM_CODE, PARAM_NAME, CONTROLL_TYPE, DATA_TYPE, DATA_SOURCE, COMM)
values ('TYPEW', 'тип роботодавця', 'dropdown', null, '"[
  {"text":"Юридична особа","value":1},
  {"text":"Фізична особа-суб''єкт підприємницької діяльності","value":0}
]"', null);
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/
BEGIN
insert into bpk_parameters_list (PARAM_CODE, PARAM_NAME, CONTROLL_TYPE, DATA_TYPE, DATA_SOURCE, COMM)
values ('CODEDRPOU', 'Ідентифікатор роботодавця', 'input', 'C:10', null, null);
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/
BEGIN
insert into bpk_parameters_list (PARAM_CODE, PARAM_NAME, CONTROLL_TYPE, DATA_TYPE, DATA_SOURCE, COMM)
values ('EDUCATION', 'Освіта', 'dropdown', null, '"[
  {"text":"Початкова освіта","value":1},
  {"text":"Базова загальна середня освіта","value":2}
  {"text":"Повна загальна середня освіта","value":3}
  {"text":"Професійно-технічна освіта","value":4}
  {"text":"Вища освіта","value":5}      
]"', null);
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/
BEGIN
insert into bpk_parameters_list (PARAM_CODE, PARAM_NAME, CONTROLL_TYPE, DATA_TYPE, DATA_SOURCE, COMM)
values ('REAL6MONTH', 'Підтверджений дохід боржника', 'input', 'N:32', null, null);
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/
BEGIN
insert into bpk_parameters_list (PARAM_CODE, PARAM_NAME, CONTROLL_TYPE, DATA_TYPE, DATA_SOURCE, COMM)
values ('NOREAL6MONTH', 'Непідтверджений дохід боржника', 'input', 'N:32', null, null);
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/
BEGIN
insert into bpk_parameters_list (PARAM_CODE, PARAM_NAME, CONTROLL_TYPE, DATA_TYPE, DATA_SOURCE, COMM)
values ('STATUS', 'Сімейний стан боржника', 'dropdown', null, '"[
  {"text":"Одружений/заміжня","value":1},
  {"text":"Неодружений/незаміжня","value":0}
]"', null);
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/
BEGIN
insert into bpk_parameters_list (PARAM_CODE, PARAM_NAME, CONTROLL_TYPE, DATA_TYPE, DATA_SOURCE, COMM)
values ('MEMBERS', 'Кількість осіб, що перебувають на утриманні боржника', 'input', 'N:2', null, null);
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/
