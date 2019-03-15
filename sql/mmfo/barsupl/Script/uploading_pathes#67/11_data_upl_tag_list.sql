-- ***************************************************************************
set verify off

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_TAG_LISTS');
end;
/

delete
  from barsupl.upl_tag_ref 
 where ref_id in (5);
--регистрация нового справочника 
Insert into barsupl.upl_tag_ref  (REF_ID, FILE_ID, DESCRIPTION) Values (5, 391, 'НБУ: Ознака приналежност_ до малого б_знесу');


-- ======================================================================================
-- TSK-0003171 UPL - здійснити вивантаження з АБС доп.парметр платіжного документу (DOCVALS - TAG='REF92'  - РЕФ. ПЕРВИННОГО ДОКУМЕНТА)
-- добавляется новый тег 'REF92'. Для остальных заполняется описание.
-- ======================================================================================
delete
  from barsupl.upl_tag_lists
 where trim(tag_table) in ('OP_FIELD');

Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'REF92', 1, 0, 'РЕФ. ПЕРВИННОГО ДОКУМЕНТА');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'PASPN', 1, 0, 'Серія і номер документу');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'CP_IN', 1, 0, 'ІНІЦІАТОР');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'OW_DS', 1, 0, 'OW. Опис документа Way4');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'OW_SC', 1, 0, 'OW. Код синтетичної проводки');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'SOCTP', 1, 0, 'Вид зарахування');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'D#73 ', 1, 0, 'Показник для файлу  #73');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'TAROB', 1, 0, 'Код тарифу по рах.6110');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'TARON', 1, 0, 'Назва комісії');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'BM__C', 1, 0, 'Код зливку/монети');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'BM__K', 1, 0, 'Кількість зливків/монет');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'BM__R', 1, 0, 'Ціна зливку/монети');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'DATN ', 1, 0, 'Дата народження');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'MTSC ', 1, 0, 'Money transfer system code');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'KTAR ', 1, 0, 'Код тарифу');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'BM_22', 1, 0, 'ОБ22 для операц_й з _нвест.монетами');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'BM_CM', 1, 0, 'Код монети');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'BM__Z', 1, 0, 'Комiсiя');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'W4MSG', 1, 0, 'Way4. Код транзакції');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'EWATN', 1, 0, 'Ідентификатор продавця (EWA)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'EWCOM', 1, 0, 'Комісія по договору страхування');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'EWAML', 1, 0, 'Email кор-ча, що створ. дог(EWA)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'EWEXT', 1, 0, 'Зовн. ідент. стр. продукту (EWA)');


-- ======================================================================================
-- TSK-0003337 UPL - здійснити вивантаження параметру K 140
--      добавляется новый тег 'K140'. Для остальных заполняется описание.
--      Необходимо создать новый файл выгрузки cusvalsr
--      Изменить структуру справочника klk140 (добавить поле REF_ID)
-- ======================================================================================


delete
  from barsupl.upl_tag_lists
 where trim(tag_table) in ('CUST_FIELD');

Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'K140' , 1, 5, 'Код розміру суб''єкта господарювання (K140)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'ADRP' , 1, 0, 'Поштова адреса');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'BUSSL', 1, 0, 'Бізнес-напрямок');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'BUSSS', 1, 0, 'Бізнес-сектор');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'CHORN', 1, 0, 'Категорiя громадян, якi постраждали внаслiдок Чорноб.катастрофи');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'CIGPO', 1, 0, 'Статус зайнятості особи');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'DATVR', 1, 0, 'Дата відкриття першого рахунку');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'DATZ' , 1, 0, 'Дата первинного заповнення анкети');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'DDBO' , 1, 0, 'Дата ДБО');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'DR'   , 1, 0, 'Місце державної реєстрації');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'ELT_D', 1, 0, 'ELT: Дата договору Клієнт-Банк і т.п.');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'ELT_N', 1, 0, 'ELT: № договору Клієнт-Банк і т.п.');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'EMAIL', 1, 0, 'Адреса електронної пошти');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'FADR' , 1, 0, 'Адреса тимчасового перебування (ФО-нерезидент)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'FGADR', 1, 0, 'Фонд~гарантирования.~Адрес');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'FGDST', 1, 0, 'Фонд~гарантирования.~Район');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'FGIDX', 1, 0, 'Адрес: Индекс');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'FGOBL', 1, 0, 'Фонд~гарантирования.~Область');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'FGTWN', 1, 0, 'Фонд~гарантирования.~Населенный пункт');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'FIN23', 1, 0, 'Фінстан постанова НБУ 23');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'FSKPR', 1, 0, 'Оцінка фiн.стану: Кiлькість штатних працiвникiв');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'FSOVR', 1, 0, 'Оцінка фiн.стану: Обсяг виручки за останній фінансовий рік');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'HIST' , 1, 0, 'Історія діяльності(інф. про реорг-ю, зміни, фін.проблеми та репутац.)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'IDDPD', 1, 0, 'Дата внесення до анкети останніх змін');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'IDDPL', 1, 0, 'Дата планової iдентифiкацiї');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'IDDPR', 1, 0, 'Дата проведеної iдентифiкацiї/уточнення інформації');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'IDPIB', 1, 0, 'ПІБ та тел. працівника, відповідальн. за ідент-цію і вивчення клієнта');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'IDPPD', 1, 0, 'ПIБ та тел працiвника, що вніс до анкети останні зміни');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'INZAS', 1, 0, 'Iншi засновники');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'ISP'  , 1, 0, 'Працівник, який прийняв рішення про відкриття рахунку');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'K013' , 1, 0, 'Код відокремленого підрозділу корп. клієнта');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'KVPKK', 1, 0, 'Код виду клiєнта');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'LINKG', 1, 0, 'Код групи пов''язаності');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'LINKK', 1, 0, 'Код групи пов''язаності-назва');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'MPNO' , 1, 0, 'Мобільний телефон (для SMS)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'MS_FS', 1, 0, 'КП-г.05 Орг-прав.форма клиента');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'MS_GR', 1, 0, 'КП-г.53 Принадлежность к группе');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'MS_KL', 1, 0, 'КП-г.08 Расширенный Тип клиента');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'MS_VD', 1, 0, 'КП-г.50 Отр.вид деят.заемщика');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'N_REE', 1, 0, 'ДБО Номер договору');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'N_RPD', 1, 0, 'Данi про реєстрацiю як платника ПДВ (номер, дата, орган)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'N_RPN', 1, 0, 'Країна реєстрації ЮО-нерезидента');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'N_RPP', 1, 0, 'Дата реєстрації як платника податку на прибуток');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'N_SVD', 1, 0, 'Номер реєстрації як платника податку на прибуток');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'N_SVI', 1, 0, 'Дані про реєстрацію як платника податку на прибуток');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'N_SVO', 1, 0, 'Дата реєстрації ЮО-нерезидента');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'NDBO' , 1, 0, 'Реквізити свідоцтва про реєстрацію ЮО-нерезидента');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'NPDV' , 1, 0, 'Орган реєстрації ЮО-нерезидента');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'OSN'  , 1, 0, 'Інформація про засновників, власників майна юр. особи');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'OSOBA', 1, 0, 'Інф. про особу, яка відкриває рахунок на ім''я клієнта');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'PLPPR', 1, 0, 'Дані про реєстрацію як платника податку на прибуток ');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'PODR' , 1, 0, 'Вiдокремленi пiдроздiли юридичної особи');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'PODR2', 1, 0, 'Вiдокремленi пiдроздiли юридичної особи(продовж)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'RCOMM', 1, 0, 'Комментарий для связанного лица');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'SDBO',  1, 0, 'Відмітка підпису ДБО');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'SUBS' , 1, 0, 'Наявність субсидії');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'SUTD' , 1, 0, 'Характеристика суті діяльності');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'UADR' , 1, 0, 'Місцезнаходження юридичної справи');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'UPFO' , 1, 0, 'Вiдомостi про фiз.осiб, уповноважених дiяти вiд iменi клієнта');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'UUCG' , 1, 0, 'Обсяг чистого доходу за календарний рік, що закінчився');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'UUDV' , 1, 0, 'Частка державної власності');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'VIDKL', 1, 0, 'Вид клієнта');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'VIP_K', 1, 0, 'Признак VIP-клиента');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'VNCRP', 1, 0, 'Первинний ВКР');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'VNCRR', 1, 0, 'Поточний ВКР');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'VPD'  , 1, 0, 'Вид підприємницької діяльності (ФО)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'VYDPP', 1, 0, 'Вид підприємства (фінансування)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'WORK' , 1, 0, 'Місце роботи, посада');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'WORKB', 1, 0, 'Приналежнiсть до працiвникiв банку');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'WORKU', 1, 0, 'Посада керiвника');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'Y_ELT', 1, 0, 'Авто взыскание тарифа абонплаты (по умолч= Y)');




