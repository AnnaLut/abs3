create or replace type t_core_person under t_core_object
(
    person_code           varchar2(30 char),                       -- унікальний код фізичної особи, що базується на ІПН, а за його відсутності використовуються паспортні дані
                                                                   -- або автоматично згенерований ідентифікатор для нерезидентів

    codman                varchar2(4000 byte),                     -- кнікальний код боржника, наданий реєстром під час першого успішного прийому інформації про боржника
                                                                   -- (0 – якщо інформація про боржника надається вперше)

    lastname              varchar2(100 char),                      -- прізвище
    firstname             varchar2(100 char),                      -- ім’я
    middlename            varchar2(100 char),                      -- по-батькові (у разі відсутності зазначається null)

    isrez                 varchar2(5 char),                        -- ознака резидентності особи (true або false)
    inn                   varchar2(20 char),                       -- ідентифікаційний код
    birthday              date,                                    -- дата народження

    documents             t_core_person_documents,                 -- документ що посвідчує особу (структура document). Якщо документів кілька, поля з 6.1. по 6.4. повторюються
    addresses             t_core_person_addresses,                 -- адреса реєстрації (структура address). Якщо боржник є нерезидентом, структура address не вказується

    countrycodnerez       varchar2(3 char),                        -- країна реєстрації боржника – нерезидента

    workplaces            t_core_person_workplaces,                -- місце роботи боржника (структура organization). Якщо місць роботи кілька, поля з 10.1. по 10.3. повторюються
                                                                   -- якщо у боржника не має місця роботи, структура organization не вказується

    real6month            number(32),                              -- підтверджений дохід боржника в сотих частках валюти (структура profit)
                                                                   -- інформація про середньомісячний дохід боржника надається під час надання кредиту та оновлюється щороку
                                                                   -- в разі наявності інформації в банку за кредитами, за якими визначення розміру кредитного ризику
                                                                   -- здійснюється на індивідуальній основі
    noreal6month          number(32),                              -- непідтверджений дохід боржника у копійках. Якщо у боржника немає доходу, то зазначається цифра 0,
                                                                   -- якщо дохід боржника невідомий, то зазначається значення null

    status                varchar2(5 char),                        -- сімейний стан боржника: true – одружений /заміжня; false – неодружений /незаміжня
                                                                   -- якщо інформація невідома, то зазначається значення null

    members               number(2),                               -- кількість осіб, що перебувають на утриманні боржника
                                                                   -- якщо інформація невідома, то зазначається значення null
    k060                  bars.string_list,                        -- тип пов’язаної з банком особи
	k020                  VARCHAR2(20),
    coddocum              number(2),
    isKr                  number(1), 

    constructor function t_core_person(
        p_report_id in integer,
        p_person_id in integer,
        p_person_kf in varchar2)
    return self as result,

    overriding member function get_json
    return clob,

    overriding member function equals(
        p_core_object in t_core_object)
    return boolean,

    overriding member procedure perform_check(
        p_is_valid out boolean,
        p_validation_message out varchar2)
)
/
create or replace type body t_core_person is

 constructor function t_core_person(
         p_report_id in integer,
         p_person_id in integer,
         p_person_kf in varchar2)
     return self as result
     is
         l_object_row nbu_reported_object%rowtype;
         l_customer_object_row nbu_reported_customer%rowtype;
         l_person_row core_person_fo%rowtype;
         l_person_income_row core_profit_fo%rowtype;
         l_person_family_row core_family_fo%rowtype;
     begin

         l_person_row := nbu_core_service.get_core_person_row(p_report_id, p_person_id, p_person_kf);

         if (l_person_row.rnk is null) then
             return;
         end if;

         l_person_income_row := nbu_core_service.get_core_person_income_row(p_report_id, p_person_id, p_person_kf);
         l_person_family_row := nbu_core_service.get_core_person_family_row(p_report_id, p_person_id, p_person_kf);
         l_customer_object_row := nbu_object_utl.read_customer(l_person_row.person_code, p_raise_ndf => false);

         if (l_customer_object_row.id is not null) then
             l_object_row := nbu_object_utl.read_object(l_customer_object_row.id);
         end if;

         lastname        := l_person_row.lastname;
         firstname       := l_person_row.firstname;
         middlename      := l_person_row.middlename;

         isrez           := l_person_row.isrez;
         inn             := l_person_row.inn;
         birthday        := l_person_row.birthday;

         documents       := nbu_core_service.get_core_person_documents(p_report_id, p_person_id, p_person_kf);

         addresses       := nbu_core_service.get_core_person_addresses(p_report_id, p_person_id, p_person_kf);

         countrycodnerez := l_person_row.countrycodnerez;

         workplaces      := nbu_core_service.get_core_person_workplaces(p_report_id, p_person_id, p_person_kf);

         real6month      := l_person_income_row.real6month;

         noreal6month    := l_person_income_row.noreal6month;

         status          := l_person_family_row.status_f;

         members         := l_person_family_row.members;

         k060            := bars.string_list(lpad(l_person_row.k060, 2, '0'));

         k020            :=l_person_row.k020;
         coddocum        :=l_person_row.coddocum;
         isKR            :=l_person_row.iskr;

         core_object_kf  := p_person_kf;
         core_object_id  := p_person_id;

         codman          := l_object_row.external_id;
         person_code     := l_person_row.person_code;

         reported_object_id := l_object_row.id;

         return;
     end;

     overriding member function get_json
     return clob
     is
         l_clob clob;
         l_attributes bars.string_list := bars.string_list();
         l_document_attributes bars.string_list := bars.string_list();
         l_address_attributes bars.string_list := bars.string_list();
         l_document_keys bars.string_list := bars.string_list();
         l_address_keys bars.string_list := bars.string_list();
         l integer;
     begin
         l_attributes.extend(100);
         l_attributes(1) := json_utl.make_json_value('codMan', nvl(codman, '0'));
         l_attributes(2) := json_utl.make_json_value('isRez', isrez);
         l_attributes(3) := json_utl.make_json_string('inn', inn);
         l_attributes(4) := json_utl.make_json_value('fio', '{ ' ||
                                                                 json_utl.make_json_string('firstName', firstName, p_mandatory => true) || ', ' ||
                                                                 json_utl.make_json_string('lastName', lastName, p_mandatory => true) || ', ' ||
                                                                 json_utl.make_json_string('middleName', middleName, p_mandatory => true) ||
                                                            ' }');
         l_attributes(5) := json_utl.make_json_date('birthDay', birthDay);
         l_attributes(6):=json_utl.make_json_value('codDocum',coddocum);
         l_attributes(7):=json_utl.make_json_string('codK020',k020);
         if (documents is not null and documents is not empty) then
             l := documents.first;
             l_document_attributes.extend(documents.count);
             while (l is not null) loop
                 l_document_keys.delete();
                 l_document_keys.extend(4);
                 l_document_keys(1) := json_utl.make_json_value('typeD', documents(l).typed, p_mandatory => true);
                 l_document_keys(2) := json_utl.make_json_string('seriya', documents(l).seriya, p_mandatory => true);
                 l_document_keys(3) := json_utl.make_json_string('nomerD', documents(l).nomerd, p_mandatory => true);
                 l_document_keys(4) := json_utl.make_json_date('dtD', documents(l).dtd, p_mandatory => true);

                 l_document_attributes(l) := '{ ' || bars.tools.words_to_string(l_document_keys, p_splitting_symbol => ', ', p_ignore_nulls => 'Y') || ' }';
                 l := documents.next(l);
             end loop;

             l_attributes(8) := json_utl.make_json_value('document', '[' || bars.tools.words_to_string(l_document_attributes, p_splitting_symbol => ', ', p_ignore_nulls => 'Y') || ']');
         end if;

         if (addresses is not null and addresses is not empty) then
             l := addresses.first;
             l_address_attributes.extend(addresses.count);
             while (l is not null) loop
                 l_address_keys.delete();
                 l_address_keys.extend(8);
                 l_address_keys(1) := json_utl.make_json_string('codRegion', addresses(l).codRegion, p_mandatory => true);
                 l_address_keys(2) := json_utl.make_json_string('area', nvl(addresses(l).area, addresses(l).city), p_mandatory => true);
                 l_address_keys(3) := json_utl.make_json_string('zip', addresses(l).zip, p_mandatory => true);
                 l_address_keys(4) := json_utl.make_json_string('city', addresses(l).city, p_mandatory => true);
                 l_address_keys(5) := json_utl.make_json_string('streetAddress', addresses(l).streetAddress, p_mandatory => true);
                 l_address_keys(6) := json_utl.make_json_string('houseNo', addresses(l).houseNo, p_mandatory => true);
                 l_address_keys(7) := json_utl.make_json_string('adrKorp', addresses(l).adrKorp);
                 l_address_keys(8) := json_utl.make_json_string('flatNo', addresses(l).flatNo);

                 l_address_attributes(l) := '{ ' || bars.tools.words_to_string(l_address_keys, p_splitting_symbol => ', ', p_ignore_nulls => 'Y') || ' }';

                 l := null; -- addresses.next(l);
             end loop;

             -- if (l_address_attributes.count = 1) then
                 l_attributes(9) := json_utl.make_json_value('address', bars.tools.words_to_string(l_address_attributes, p_splitting_symbol => ', ', p_ignore_nulls => 'Y'));
             /*else
                 l_attributes(7) := json_utl.make_json_value('address', '[' || bars.tools.words_to_string(l_address_attributes, p_splitting_symbol => ', ', p_ignore_nulls => 'Y') || ']');
             end if;*/
         end if;

         l_attributes(10) := json_utl.make_json_value('profit', '{ ' ||
                                                                    json_utl.make_json_value('real6month', real6month, p_mandatory => true) || ', ' ||
                                                                    json_utl.make_json_value('noreal6month', noreal6month, p_mandatory => true) ||
                                                               ' }');

         l_attributes(11) := json_utl.make_json_value('family', '{ ' ||
                                                                     json_utl.make_json_value('status', status, p_mandatory => true) || ', ' ||
                                                                     json_utl.make_json_value('members', members, p_mandatory => true) ||
                                                                ' }');

         l_attributes(12) := json_utl.make_json_value('k060',
                                                      '["' || nvl(bars.tools.words_to_string(k060, p_splitting_symbol => '", "', p_ignore_nulls => 'Y'), '99') || '"]',
                                                      p_mandatory => true);

         l_attributes(13) := json_utl.make_json_value('isKr', isKr);
         dbms_lob.createtemporary(l_clob, false);

         dbms_lob.append(l_clob, '{ "data": { ');

         l := l_attributes.first;
         while (l is not null) loop
             if (l_attributes(l) is not null) then
                 dbms_lob.append(l_clob, l_attributes(l) || ', ');
             end if;
             l := l_attributes.next(l);
         end loop;

         l_clob := rtrim(l_clob, ', ');
         dbms_lob.append(l_clob, '} }');

         return l_clob;
     end;

     overriding member function equals(
         p_core_object in t_core_object)
     return boolean
     is
         l_equals boolean;
         l_core_person t_core_person;
         l integer;
     begin
         if (p_core_object is null) then
             return false;
         end if;

         if (p_core_object is of (t_core_person)) then
             l_core_person := treat(p_core_object as t_core_person);
         else
             raise_application_error(-20000, 'Тип об''єкта з ідентифікатором {' || p_core_object.core_object_id || '/' || p_core_object.core_object_kf || '} не є Юридичною особою');
         end if;

         l_equals := bars.tools.equals(l_core_person.person_code    , person_code    ) and
                     bars.tools.equals(l_core_person.lastname       , lastname       ) and
                     bars.tools.equals(l_core_person.firstname      , firstname      ) and
                     bars.tools.equals(l_core_person.middlename     , middlename     ) and
                     bars.tools.equals(l_core_person.isrez          , isrez          ) and
                     bars.tools.equals(l_core_person.inn            , inn            ) and
                     bars.tools.equals(l_core_person.birthday       , birthday       ) and
                     bars.tools.equals(l_core_person.countrycodnerez, countrycodnerez) and
                     bars.tools.equals(l_core_person.real6month     , real6month     ) and
                     bars.tools.equals(l_core_person.noreal6month   , noreal6month   ) and
                     bars.tools.equals(l_core_person.status         , status         ) and
                     bars.tools.equals(l_core_person.members        , members        );

         if (l_equals) then
             if ((l_core_person.documents is null or l_core_person.documents is empty) and (documents is null or documents is empty)) then
                 l_equals := true;
             else
                 -- для порівняння вмісту колекцій таким чином їх значення повинні бути відсортовані в одному і тому самому порядку
                 if (l_core_person.documents is not null and documents is not null) then
                     if (l_core_person.documents.count = documents.count) then
                         l := l_core_person.documents.first;
                         while (l_equals and l is not null) loop
                             l_equals := bars.tools.equals(l_core_person.documents(l).typed , documents(l).typed ) and
                                         bars.tools.equals(l_core_person.documents(l).seriya, documents(l).seriya) and
                                         bars.tools.equals(l_core_person.documents(l).nomerd, documents(l).nomerd) and
                                         bars.tools.equals(l_core_person.documents(l).dtd   , documents(l).dtd   );
                             l := l_core_person.documents.next(l);
                         end loop;
                     else
                         l_equals := false;
                     end if;
                 else
                     l_equals := false;
                 end if;
             end if;
         end if;

         if (l_equals) then
             if ((l_core_person.addresses is null or l_core_person.addresses is empty) and (addresses is null or addresses is empty)) then
                 l_equals := true;
             else
                 -- для порівняння вмісту колекцій таким чином їх значення повинні бути відсортовані в одному і тому самому порядку
                 if (l_core_person.addresses is not null and addresses is not null) then
                     if (l_core_person.addresses.count = addresses.count) then
                         l := l_core_person.addresses.first;
                         while (l_equals and l is not null) loop
                             l_equals := addresses(l).equals(l_core_person.addresses(l));
                             l := l_core_person.addresses.next(l);
                         end loop;
                     else
                         l_equals := false;
                     end if;
                 else
                     l_equals := false;
                 end if;
             end if;
         end if;

         if (l_equals) then
             if ((l_core_person.workplaces is null or l_core_person.workplaces is empty) and (workplaces is null or workplaces is empty)) then
                 l_equals := true;
             else
                 -- для порівняння вмісту колекцій таким чином їх значення повинні бути відсортовані в одному і тому самому порядку
                 if (l_core_person.workplaces is not null and workplaces is not null) then
                     if (l_core_person.workplaces.count = workplaces.count) then
                         l := l_core_person.workplaces.first;
                         while (l_equals and l is not null) loop
                             l_equals := bars.tools.equals(l_core_person.workplaces(l).typew    , workplaces(l).typew    ) and
                                         bars.tools.equals(l_core_person.workplaces(l).codedrpou, workplaces(l).codedrpou) and
                                         bars.tools.equals(l_core_person.workplaces(l).namew    , workplaces(l).namew    );

                             l := l_core_person.workplaces.next(l);
                         end loop;
                     else
                         l_equals := false;
                     end if;
                 else
                     l_equals := false;
                 end if;
             end if;
         end if;

         if (l_equals) then
             if ((l_core_person.k060 is null or l_core_person.k060 is empty) and (k060 is null or k060 is empty)) then
                 l_equals := true;
             else
                 -- для порівняння вмісту колекцій таким чином їх значення повинні бути відсортовані в одному і тому самому порядку
                 if (l_core_person.k060 is not null and k060 is not null) then
                     if (l_core_person.k060.count = k060.count) then
                         l := l_core_person.k060.first;
                         while (l_equals and l is not null) loop
                             l_equals := bars.tools.equals(l_core_person.k060(l), k060(l));

                             l := l_core_person.k060.next(l);
                         end loop;
                     else
                         l_equals := false;
                     end if;
                 else
                     l_equals := false;
                 end if;
             end if;
         end if;

         return l_equals;
     end;

     overriding member procedure perform_check(
         p_is_valid out boolean,
         p_validation_message out varchar2)
     is
         l_valid_addresses_count integer;
         l integer;
         l_address_is_valid boolean;
         l_address_validation_message varchar2(32767 byte);
     begin
         p_is_valid := true;

         if (person_code is null) then
             p_is_valid := false;
             p_validation_message := 'Не дійсне значення ідентифікаційного коду: ' || inn;
         end if;

         if (inn is null) then
             p_is_valid := false;
             p_validation_message := 'Ідентифікаційний код клієнта не вказаний';
         end if;

         if (addresses is not null and addresses is not empty) then
             l := addresses.first;
             while (l is not null) loop
                 addresses(l).perform_check(l_address_is_valid, l_address_validation_message);

                 if (l_address_is_valid) then
                     l_valid_addresses_count := l_valid_addresses_count + 1;
                 end if;

                 l := addresses.next(l);
             end loop;

             if (l_valid_addresses_count = 0) then
                 p_is_valid := false;
                 p_validation_message := 'Адреса клієнта не пройшла перевірку';
             end if;
         else
             p_is_valid := false;
             p_validation_message := 'Адреса клієнта не заповнена';
         end if;
     end;
 end;
/
