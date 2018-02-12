prompt ... 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''300465'', ''ГУ Ощадбанк'', ''https://10.7.98.11/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''352457'', ''ОУ Херсон'', ''https://web-khrsn.ho.obu/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''325796'', ''ОУ Львів'', ''https://web.lviv.obu/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''351823'', ''ОУ Харків'', ''https://web-khrv.ho.obu/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''302076'', ''ОУ Вінниця'', ''https://web-vinn.ho.obu/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''311647'', ''ОУ Житомир'', ''https://web05.oschadbank.ua/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''336503'', ''ОУ Івано-Франківськ'', ''https://web-08-00.oschadbank.ua/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''333368'', ''ОУ Рівне'', ''https://web-rivne.ho.obu/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''353553'', ''ОУ Чернігів'', ''https://web-cngv.ho.obu/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''328845'', ''ОУ Одесса'', ''https://web-odes.ho.obu/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''354507'', ''ОУ Черкаси'', ''https://barsweb.cherkasy.obu/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''303398'', ''ОУ Волинь'', ''https://web-volyn.oschadbank.ua/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''305482'', ''ОУ Дніпропетровськ'', ''https://web-dnpr.ho.obu/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''312356'', ''ОУ Закарпаття'', ''https://zakweb.zakarpat.obu/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''326461'', ''ОУ Миколаїв'', ''https://web-mklv.ho.obu/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''337568'', ''ОУ Суми'', ''https://web-sumy.ho.obu/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''338545'', ''ОУ Тернопіль'', ''https://bars.ternopil.obu/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''323475'', ''ОУ Кіровоград'', ''https://SRVF-10-WEB01.oschadbank.ua/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''356334'', ''ОУ Чернівці'', ''https://barschvweb.oschadbank.ua/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''315784'', ''ОУ Хмельницький'', ''https://bars.khmelnytsk.obu/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''322669'', ''ГУ по м. Києву та Київській обл.'', ''https://10.7.98.11/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''304665'', ''ОУ Луганськ'', ''https://web-lugn.oschadbank.ua/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''331467'', ''ОУ Полтава'', ''https://bars16.oschadbank.ua/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''313957'', ''ОУ Запоріжжя'', ''https://web-zprz.ho.obu/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''335106'', ''Філія-ДОУ АТ Ощадбанк'', ''https://web-dnck.ho.obu/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

