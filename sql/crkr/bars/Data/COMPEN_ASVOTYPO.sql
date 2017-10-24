

prompt Loading COMPEN_ASVOTYPO...
begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''%k'', ''cy'', ''Вид.к%% сп'', ''Видача капiталiзованих %% списанням'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''%m'', ''cD'', ''Сп.к%%наМК'', ''Списання на магн.карт.капiт.%%'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''%n'', ''%W'', ''Списан.н%%'', ''Списання накоплених %%'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''%s'', ''Wc'', ''Поверн.к%%'', ''Поверненя %% на вклад (для Арсенала)'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''%Z'', ''!c'', ''Капiт.зр.%'', ''Капиталiзацiя зарах.%%'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''%z'', ''%c'', ''Кап.нар.%%'', ''Капиталiзацiя нарах.%%'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''_B'', ''qa'', ''Вид.нац.в.'', ''Видача.нац.валюти'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''_H'', ''aq'', ''Перев.подл'', ''Перевiрка аутентичностi'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''_K'', ''fa'', ''Вид.вал.iн'', ''Видача валюти (пiсля iнкасо5)'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''_S'', ''aq'', ''Прийом н.в'', ''Прийом.нац.валюти'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''01'', ''  '', ''Дозв.Ф01/6'', ''Дозвiл на вивiз валюти'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''31'', ''ag'', ''Приб. Ф31 '', ''Сплата по формi 31'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''3Z'', ''  '', ''Ф143iнш.фл'', ''Прийняття Ф143 в iнший фiл.'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''5A'', ''  '', ''Ф190iнш.фл'', ''Прийняття Ф190 в iнший фiл.'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''7%'', ''k!'', ''Зарах.7 %%'', ''Зарахування %% з 7-го кл.'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''7b'', ''c7'', ''Сп.цн.к.Кп'', ''Сп.К97 за рах. центр. каси'', 0)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''7C'', ''c7'', ''Зк.цн.к.Кп'', ''Сп.К97 з закр. центр.'', 0)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''8F'', ''  '', ''Вiдм.Ф190 '', ''Вiдмiна довгострок.дор.на списання коштiв'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''A-'', ''  '', ''Розблокув.'', ''Розблокування'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''A%'', ''%a'', ''Зняття% ав'', ''Зняття процентiв авансом'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''A+'', ''  '', ''Блокування'', ''Блокування вкладу'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''A<'', ''Jw'', ''Арешт     '', ''Арешт вкладу'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''A='', ''cI'', ''Сп.ар.суми'', ''Списання арештованноi суми'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''A>'', ''wJ'', ''Знят.Арешт'', ''Зняття арешту зi вкладу'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''AD'', ''  '', ''Оф.Доручен'', ''Оформлення доручення'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''AG'', ''  '', ''Офm. опiки'', ''Оформлення опiки'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''AI'', ''  '', ''Оф.3-й ос.'', ''Оформлення 3-й особи'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''AS'', ''aa'', ''Авансуван.'', ''Авансування/Пiдкрiплення'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''AV'', ''ac'', ''Внес.кошт.'', ''Внесення коштiв'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''AW'', ''  '', ''Оф.Заповiт'', ''Оформлення заповiту'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''b%'', ''!y'', ''Вид.з%% сп'', ''Видача зарахованих %% списанням'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''B_'', ''af'', ''Купiвля   '', ''Купiвля валюти'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''BA'', ''%f'', ''Вик.зд.ав.'', ''Викуп здачi % вид.авансом'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''BE'', ''  '', ''Оф. Ф.190 '', ''Оформлення довгострок.дор.на списання коштiв'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''BG'', ''Tt'', ''Пл. ГЗ б/г'', ''Плата марки ГЗ безгот.'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''BH'', ''Jw'', ''Прийом цiн'', ''Прийом цiнностей'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''c%'', ''!D'', ''Сп.з%%наМК'', ''Списання на магн.карт.зарах.%%'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''C9'', ''c9'', ''Пов.кмп.зк'', ''Повернення компенсац. з закриттям'', 0)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''CC'', ''cl'', ''Чек.закр. '', ''Спис.на чек з закриттям'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''CK'', ''cu'', ''Зк.боргЖКУ'', ''Списання заборгованностi з закриттям'', 0)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''Cp'', ''cz'', ''Сп.пенс.зк'', ''Списання пенсii з закриттям'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''CR'', ''cf'', ''Вик.зд.зкр'', ''Викуп здачi з закриттям'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''CT'', ''cD'', ''П.наМКзЗак'', ''Переказ вкладу на магн.карт.з закриттям'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''D_'', ''aF'', ''Комiсiя '', ''Комiсiя'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''d_'', ''ai'', ''Ком.видт.г'', ''Комiсiя за видаток готiвки'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''DA'', ''  '', ''Анул.доруч'', ''Анул.доручення'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''DC'', ''ca'', ''Розрив дог'', ''Розрив догов.'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''DD'', ''  '', ''Вiд.рез.%%'', ''Вiд.рез.%%'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''DG'', ''  '', ''Анул.опiки'', ''Анул.пiклування'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''DL'', ''  '', ''Подовження'', ''Подовження догов.'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''DN'', ''  '', ''Деномiнац.'', ''Деномiнацiя'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''dP'', ''ci'', ''Пл.за.зар.'', ''Плата за вид.коштiв безгот'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''DQ'', ''Ja'', ''Сп.зiпс.КЧ'', ''Списання зiпсов. комп.чекiв з пачки'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''DR'', ''  '', ''Розр.б/кл.'', ''Розрив догов.без клиента'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''DW'', ''  '', ''Анул.запов'', ''Анул.заповiту'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''EL'', ''  '', ''Укл.д.уг.Е'', ''Укладання ДУ для пакета Ексклюзивний'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''FA'', ''  '', ''Вступ 3 ос'', ''Вступ у права 3-й особи'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''FI'', ''  '', ''Змiна  ПIБ'', ''Змiна ПIБ'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''FM'', ''  '', ''Ред.анкети'', ''Редагування анкети'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''GD'', ''Da'', ''Вид. з МПК'', ''Видача з МПК'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''GK'', ''wa'', ''Вид.книжки'', ''Видача книжки'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''GN'', ''wa'', ''Видач.карт'', ''Видача магнитноi карти'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''GO'', ''aH'', ''Прийом пер'', ''Прийом вал.переказу'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''GP'', ''Ra'', ''Виплат.пер'', ''Видача переказу в грн'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''GQ'', ''wa'', ''Вид.чк.кн.'', ''Видача чековоi книжки'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''GR'', ''wa'', ''Видач.чека'', ''Видача чека'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''GT'', ''aD'', ''Прин.на МК'', ''Прийом на МПК'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''GV'', ''aS'', ''Прийом пер'', ''Прийом переказу в грн'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''GZ'', ''Za'', ''Вид.застав'', ''Повернення застави'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''H_'', ''aq'', ''Розмiн    '', ''Розмiн'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''HB'', ''wa'', ''Видач. цiн'', ''Видача цiнностей'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''IA'', ''  '', ''Вiдм.3 ос.'', ''Вiдмова вiд прав 3-й особи'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''K_'', ''Jw'', ''Вал.iнкасс'', ''Валюта на iнкасо'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''KC'', ''cn'', ''Зк.центр.к'', ''Спис.з закр. центр.'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''KQ'', ''Ga'', ''Спл.Чек.iн'', ''Сплата чеков пiсля iнкасо'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''LA'', ''mc'', ''Зарахуван.'', ''Зарахування коштiв'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''LK'', ''Kc'', ''Зар.компн.'', ''Зар.компенсац.'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''LN'', ''zc'', ''Зарах.вн/б'', ''Зарахування внутрiшньобанкiвське'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''LO'', ''mc'', ''Вiдкр .б/г'', ''Вiдкриття б/г'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''MC'', ''cM'', ''Пер.вiд.мр'', ''Перек.комп97 вiдiсланi (мiжрег.)'', 0)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''MD'', ''  '', ''Замов.карт'', ''Замовлення магнитноi карти'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''MM'', ''  '', ''Оформ. БПК'', ''Оформлення магнитноi карти'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''N%'', ''!a'', ''Зняття %% '', ''Зняття процентiв'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''n%'', ''k%'', ''Нарах.  %%'', ''Нарахування %%'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''NC'', ''cz'', ''Сп.неоп.зк'', ''Списання внутрiшньобанк. з закриттям'', 0)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''NP'', ''ab'', ''Пiдкрiплен'', ''Пiдкрiпл. з комори'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''NS'', ''ba'', ''Здан.сумка'', ''Здано залишки готiвки в сховище'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''OK'', ''Kc'', ''Зр.кмп.вiд'', ''Зарах.компенсацii з вiдкриттям'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''OM'', ''Mc'', ''Пер.отр.мр'', ''Перек.комп97 отриманi (мiжрег.)'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''ON'', ''zc'', ''Вiдкр.вн/б'', ''Вiдкриття внутрiшньобанкiвське'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''OP'', ''Nc'', ''Пер.отр.вр'', ''Перек.комп97 отриманi (внтр.рег.)'', 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''OT'', ''ac'', ''Вiдкриття '', ''Внесення готiвки на вкладний (депозитний) рахунок з вiдкриттям'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''P_'', ''ar'', ''Пенс. сбiр'', ''Сбiр в пенс.фонд'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''pb'', ''ai'', ''Пл.о/к гот'', ''Гот.пл.за переоф.по втр.о/кн'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''PB'', ''ci'', ''Пл.о/к б/г'', ''Б/г.пл.за переоф.по втр.о/кн'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''PC'', ''cN'', ''Пер.вiд.вр'', ''Перек.комп97 вiдiсланi (внтр.рег.)'', 0)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''PG'', ''as'', ''Пл. ГЗ гот'', ''Плата марки ГЗ'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''PK'', ''ci'', ''Оплата МК '', ''Плата за МК'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''pp'', ''ai'', ''Пл.пер.гот'', ''Плата за переказ гот.'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''PP'', ''ci'', ''Пл.пер.б/г'', ''Плата за переказ безгот.'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''ps'', ''ai'', ''Пл.сп.гот.'', ''Плата за спис.гот.'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''PS'', ''ci'', ''Пл.с/з б/г'', ''Плата за спис./зарах.безгот.'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''Q_'', ''aF'', ''КомШвПерек'', ''Ком.за прийом перек по швидких пл.системам'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''QB'', ''da'', ''Оплат.чека'', ''Сплата дорожного чеку'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''QK'', ''Jw'', ''Чек.iнкасс'', ''Чеки на iнкасо'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''QS'', ''ad'', ''Продж.чека'', ''Продаж дорожного чеку'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''R%'', ''ca'', ''Зн.%%з кап'', ''Зняття процентiв з кап.'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''R_'', ''  '', ''Ввод курса'', ''Установка курсу'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''RA'', ''ca'', ''Видаток   '', ''Часткова видача вкладу'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''Rb'', ''na'', ''Вид.ц.к-си'', ''Видаток у центр.касi'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''RC'', ''ca'', ''Закриття  '', ''Видача готiвки з вкладного (депозитного) рахунку з закриттям'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''RK'', ''ca'', ''Випл. кмп.'', ''Виплата компенсац.'', 0)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''RQ'', ''Jw'', ''Повер.чека'', ''Повернення комп.чекiв '', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''rr'', ''  '', ''Переоф.EUR'', ''Переоформлення рахункiв (в ЕВРО)'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''RT'', ''aa'', ''Прийом над'', ''Прийом надлишкiв/Подкрiплення'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''s%'', ''!W'', ''Списан.з%%'', ''Списання зарахованих %%'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''S%'', ''c%'', ''Списан.к%%'', ''Списання %% зi вкладу'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''S_'', ''fa'', ''Продаж    '', ''Продаж валюти'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''SB'', ''ch'', ''Сп.на рах.'', ''Спис.на р/р органiзацiй'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''sb'', ''cn'', ''Сп.центр.к'', ''Спис.за рах. центр. каси'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''SC'', ''ch'', ''Сп.з закр.'', ''Спис.з закриттям'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''SH'', ''  '', ''Вiдк.змнiн'', ''Вiдкр.змiни'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''SK'', ''cu'', ''Сп.боргЖКУ'', ''Списання заборгованностi'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''Sn'', ''cy'', ''Сп.прочее '', ''Списання з вкладiв'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''SN'', ''cz'', ''Сп.неоплач'', ''Списання внутрiшньобанкiвське'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''Sp'', ''cz'', ''Сп.пенсии '', ''Списання пенсii'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''SQ'', ''zc'', ''Повер.суми'', ''Повернення суми на особ.рахунок'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''SS'', ''ai'', ''Посл. банк'', ''Послуги банку'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''TC'', ''cg'', ''Пер.з закр'', ''Переказ вкладу з закриттям'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''TI'', ''CK'', ''Прб.траншу'', ''Прибуток траншу (Комп.97)'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''TO'', ''KC'', ''Пов.траншу'', ''Повернення частини траншу (Комп.97)'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''TR'', ''cg'', ''Переказ   '', ''Переказ вкладу'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''UC'', ''cz'', ''Закр.втрат'', ''Закриття по втратi'', 0)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''V_'', ''aj'', ''Мит.iнкасо'', ''Миттеве iнкасо'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''VC'', ''cz'', ''Пер.закр.в'', ''Переказ внутрiшньобанкiвський'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''VG'', ''pa'', ''Пер.поVIGO'', ''Переказ по VIGO'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''VK'', ''Ka'', ''Вип.км.гот'', ''Виплата компенсацii готiвкою'', 0)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''VL'', ''  '', ''Укл.доп.уг'', ''Укладання доп.угоди'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''VO'', ''zc'', ''Пер.вiдк.в'', ''Вiд.за перек.внутрiшньобанкiвське'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''VV'', ''  '', ''Змiна умов'', ''Змiна умов вкладу'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''W-'', ''cz'', ''Сп.по чеку'', ''Спис.по чеку чековоi книжки'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''W_'', ''af'', ''Конверсiя '', ''Конверсiя'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''WA'', ''c%'', ''Сп.надлиш%'', ''Списання надлишково виплачених %'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''WK'', ''c9'', ''Повер.кмп.'', ''Повернення компенсац.'', 0)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''WP'', ''!f'', ''Вик.здачi%'', ''Викуп здачi процентiв'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''WQ'', ''cl'', ''Сп.на чек '', ''Спис.на чек'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''WR'', ''cf'', ''Вик. решти'', ''Викуп валюти зi вкладу'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''WU'', ''Pa'', ''Виплат.пер'', ''Видача вал.переказу '', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''X%'', '' c'', ''Перерах %%'', ''Перерах %% %%'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''XC'', ''ca'', ''Закриття *'', ''Спец. закриття'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''Y%'', ''kc'', ''Капiтал.%%'', ''Капиталiзацiя %%'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''YK'', ''ai'', ''Льгт.Пл.МК'', ''Льготна оплата за МК'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''z%'', ''%!'', ''Зарах.  %%'', ''Зарахування %%'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''Z%'', ''kc'', ''Капiтал.%%'', ''Капиталiзацiя %%'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''ZD'', ''ca'', ''Поховання '', ''Виплата на похорони'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''ZG'', ''aZ'', ''Застава   '', ''Прийом застави'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_ASVOTYPO (typo, code, comm10, txt, dk)
values (''ZV'', ''ca'', ''Вип.запов.'', ''Виплата заповiту'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

update COMPEN_ASVOTYPO
set    dk='0'
where  TYPO in ('7b','7C','C9','RK','WK','VK','CK','MC','NC','PC','UC');

update COMPEN_ASVOTYPO
set    dk='1'
where  TYPO in ('LA','LK','LN','LO','OM','ON','OP');

commit;
