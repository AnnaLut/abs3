prompt ... 


-- Create table
begin
    execute immediate 'create table TMP_Z_POLIS
(
  a1 VARCHAR2(20),
  a2 VARCHAR2(500),
  a3 VARCHAR2(20),
  a4 VARCHAR2(20),
  a5 VARCHAR2(20),
  a6 VARCHAR2(20),
  a7 VARCHAR2(20),
  a8 VARCHAR2(20)
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 




prompt ... 

SET DEFINE OFF;

begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''11'', ''11.Безумовні та безвідкличні гарантії/безвідкличні резервні акредитиви, що виконують функції фінансової гарантії Кабінету Міністрів України'', ''9030'', ''9030'', ''9030'', 
    ''11'', ''1'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''15'', ''36.Грошове покриття, що розміщене в банку-кредиторі на строк, не менший, ніж строк користування активом, за умови забезпечення безперечного контролю та доступу банку-кредитора до цих коштів у разі невиконання боржником зобов’язань за кредитною операц'', ''9500'', ''9500'', ''9500'', 
    ''36'', ''1'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''21'', ''21.Банківські метали, що перебувають на зберіганні в банку-кредиторі, чи майнові права на банківські метали, які розміщені на вкладному (депозитному) рахунку в банку-кредиторі на строк, не менший, ніж строк користування активом, за умови безперешкодн'', ''9500'', ''9500'', ''9500'', 
    ''21'', ''1'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''23'', ''23.Цінні папери, емітовані центральними органами виконавчої влади України або гарантовані Кабінетом Міністрів України'', ''9500'', ''9500'', ''9500'', 
    ''23'', ''1'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''25'', ''25.Нерухоме майно, що належить до житлового фонду (квартири)'', ''9521'', ''9521'', ''9521'', 
    ''25'', ''0.75'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''26'', ''72.Майнові права на нерухоме майно, що належатиме до житлового фонду (багатоквартирний будинок)'', ''9521'', ''9521'', ''9521'', 
    ''72'', ''0'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''28'', ''28.Товари в обороті або в переробці'', ''9500'', ''9500'', ''9500'', 
    ''28'', ''0.4'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''30'', ''30.Iнше рухоме майно'', ''9500'', ''9500'', ''9500'', 
    ''30'', ''0'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''31'', ''31.Інше нерухоме майно'', ''9523'', ''9523'', ''9523'', 
    ''31'', ''0'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''33'', ''331.Цінні папери іншi'', ''9500'', ''9500'', ''9500'', 
    ''33'', ''0'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''34'', ''334.Порука'', ''9031'', ''9031'', ''9031'', 
    ''33'', ''0'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''38'', ''38.Транспортні засоби (крім легкових автомобілів)'', ''9500'', ''9500'', ''9500'', 
    ''38'', ''0.5'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''39'', ''39.Облігації міжнародних фінансових організацій, які на умовах, визначених своїм установчим актом, та/або відповідно до міжнародного договору України здійснюють емісію облігацій на території України'', ''9500'', ''9500'', ''9500'', 
    ''39'', ''1'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''50'', ''50.Об’єкт у формі цілісного майнового комплексу'', ''9523'', ''9523'', ''9523'', 
    ''50'', ''0.5'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''56'', ''333.Майн. права на нерухоме майно нежитл.фонду'', ''9523'', ''9523'', ''9523'', 
    ''33'', ''0'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''58'', ''58.Іпотечні облігації, емітовані фінансовою установою, більше ніж 50 відсотків корпоративних прав якої належить державі та/або державним банкам, якість іпотечного покриття за якими відповідає вимогам законодавства України'', ''9500'', ''9500'', ''9500'', 
    ''58'', ''0.6'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''61'', ''61.Безумовні та безвідкличні гарантії/безвідкличні резервні акредитиви, що виконують функції фінансової гарантії урядів країн, що мають інвестиційний кредитний рейтинг згідно з міжнародною шкалою, підтверджений агентством (компанією) Standard&Poor’s '', ''9031'', ''9031'', ''9031'', 
    ''61'', ''1'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''62'', ''62.Безумовні та безвідкличні гарантії/безвідкличні резервні акредитиви, що виконують функції фінансової гарантії банків та інших установ, що мають інвестиційний кредитний рейтинг згідно з міжнародною шкалою, підтверджений агентством (компанією) Stand'', ''9031'', ''9031'', ''9031'', 
    ''62'', ''1'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''63'', ''63.Безумовні та безвідкличні гарантії/безвідкличні резервні акредитиви, що виконують функції фінансової гарантії міжнародних багатосторонніх банків (МБРР, ЄБРР, МФК, ЄІБ, ЄІФ)'', ''9031'', ''9031'', ''9031'', 
    ''63'', ''1'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''90'', ''90.Без забезпечення (бланкові)'', ''9500'', ''9500'', ''9500'', 
    ''90'', ''0'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''156'', ''18.Майнові права на грошові кошти, розміщені на вкладному (депозитному) рахунку в банку, який має інвестиційний кредитний рейтинг, за умови, що строк розміщення коштів не менший, ніж строк користування активом'', ''9500'', ''9500'', ''9500'', 
    ''18'', ''1'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''231'', ''57.Державні цінні папери за операціями репо, які ґрунтуються на двосторонньому договорі між банком та його контрагентом про купівлю державних цінних паперів із одночасним зобов"язанням контрагента викупити державні цінні папери за обумовленою в догов'', ''9500'', ''9500'', ''9500'', 
    ''57'', ''1'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''233'', ''19.Цінні папери, емітовані Національним банком України'', ''9500'', ''9500'', ''9500'', 
    ''19'', ''1'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''235'', ''53.Цінні папери, емітовані органами місцевого самоврядування'', ''9500'', ''9500'', ''9500'', 
    ''53'', ''0.4'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''244'', ''24.Цінні папери емітентів, які мають інвестиційний кредитний рейтинг згідно з міжнародною шкалою, підтверджений агентством (компанією) Standard&Poor’s або аналогічний рейтинг інших провідних світових рейтингових агентств (компаній), визначених Положе'', ''9500'', ''9500'', ''9500'', 
    ''24'', ''1'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''245'', ''67 – цінні папери (крім цінних паперів інститутів спільного інвестування), емітовані резидентами, які внесені до першого рівня лістингу та перебувають у ньому не менше трьох місяців поспіль до дати розрахунку розміру кредитного ризику за активом'', ''9500'', ''9500'', ''9500'', 
    ''67'', ''0.4'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''250'', ''71.Нерухоме майно, що належить до житлового фонду (будинки)'', ''9521'', ''9521'', ''9521'', 
    ''71'', ''0.55'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''283'', ''66.Товари, прийняті на зберігання за подвійним складським свідоцтвом (протягом строку зберігання товару на підставі застави цього свідоцтва)'', ''9503'', ''9503'', ''9503'', 
    ''66'', ''0.4'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''301'', ''35.Легкові автомобілі'', ''9500'', ''9500'', ''9500'', 
    ''35'', ''0.75'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''302'', ''513.Машини / сільгосптехніка'', ''9500'', ''9500'', ''9500'', 
    ''51'', ''0.5'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''303'', ''55.Біологічні активи'', ''9500'', ''9500'', ''9500'', 
    ''55'', ''0.4'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''304'', ''511.Устаткування'', ''9500'', ''9500'', ''9500'', 
    ''51'', ''0.5'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''305'', ''512.Техніка (комп’ютери і оргтехніка)'', ''9500'', ''9500'', ''9500'', 
    ''51'', ''0.5'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''307'', ''335.Майбутній урожай'', ''9500'', ''9500'', ''9500'', 
    ''33'', ''0'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''309'', ''70.Земельні ділянки [крім земельних ділянок, за якими їх купівля, продаж та зміна цільового призначення (використання) обмежені на законодавчому рівні] без земельних поліпшень, оформлених на правах власності'', ''9520'', ''9520'', ''9520'', 
    ''70'', ''0.35'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''310'', ''69.Земельні ділянки, оформлені на правах власності, на яких розташоване нерухоме майно, що належить до житлового фонду (будинки), і площа яких безпосередньо використовується у функціонуванні об’єкта'', ''9520'', ''9520'', ''9520'', 
    ''69'', ''0.55'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''311'', ''68.Земельні ділянки, оформлені на правах власності, на яких розташоване нерухоме майно, що не належить до житлового фонду, і площа яких безпосередньо використовується у функціонуванні об’єкта'', ''9520'', ''9520'', ''9520'', 
    ''68'', ''0.6'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''312'', ''371. Нерухоме майно, що не належить до житлового фонду (крім земельних ділянок та нерухомості у складі ЦМК)'', ''9523'', ''9523'', ''9523'', 
    ''37'', ''0.6'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''313'', ''372.Нерухомість у складі ЦМК'', ''9523'', ''9523'', ''9523'', 
    ''37'', ''0.6'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''321'', ''336.Майн.права на вироби, товари (за дог.СПД)'', ''9500'', ''9500'', ''9500'', 
    ''33'', ''0'', ''Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''322'', ''337.Майн.права на гр.кошти за дог.'', ''9500'', ''9500'', ''9500'', 
    ''33'', ''0'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''323'', ''338.Майн.права на кошти за дог.суб.природн.моноп.'', ''9500'', ''9500'', ''9500'', 
    ''33'', ''0'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''339'', ''339.Інші види забезпечення (9500)'', ''9500'', ''9500'', ''9500'', 
    ''33'', ''0'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''591'', ''591.Іменні ощадні (деп) сертиф, випущені банком-кредитором'', ''9500'', ''9500'', ''9500'', 
    ''59'', ''1'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''592'', ''592.Майн права на грош кош, розм на вкл (деп) рах в банку-кредиторі'', ''9500'', ''9500'', ''9500'', 
    ''59'', ''1'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''640'', ''64.Безумовні та безвідкличні місцеві гарантії міських рад, що мають клас не нижче ніж 2'', ''9031'', ''9031'', ''9031'', 
    ''33'', ''0.5'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''832'', ''Майнові права на кредитні договори'', ''9510'', ''9510'', ''9510'', 
    ''73'', ''0'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''919'', ''Депозитні сертифікати НБУ'', ''9510'', ''9510'', ''9510'', 
    ''19'', ''0'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''920'', ''Облігації Державної Іпотечної Установи'', ''9510'', ''9510'', ''9510'', 
    ''58'', ''0'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''923'', ''Державні облігації України'', ''9510'', ''9510'', ''9510'', 
    ''23'', ''0'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''932'', ''Майнові права на майбутні надходження на кореспондентський рахунок'', ''9510'', ''9510'', ''9510'', 
    ''33'', ''0'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''933'', ''Інші види забеспечення (9510)'', ''9510'', ''9510'', ''9510'', 
    ''33'', ''0'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''952'', ''Облігації підприємств'', ''9510'', ''9510'', ''9510'', 
    ''33'', ''0'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''3214'', ''332.Майн.права на корпорат.права'', ''9500'', ''9500'', ''9500'', 
    ''33'', ''0'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''999999'', ''Для МБК'', ''9510'', ''9510'', ''9510'', 
    ''33'', ''0'', ''Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

COMMIT;
/