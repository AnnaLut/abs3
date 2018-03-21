create or replace type t_core_person_address force as object
(
       codregion           varchar2(2 char),       -- код регіону
       area                varchar2(100 char),     -- район
       zip                 varchar2(10 char),      -- поштовий індекс
       city                varchar2(254 char),     -- назва населеного пункту 
       streetaddress       varchar2(254 char),     -- вулиця
       houseno             varchar2(50 char),      -- будинок
       adrkorp             varchar2(10 char),      -- корпус (споруда)
       flatno              varchar2(10 char),      -- квартира

       member function equals(
           p_core_person_address in t_core_person_address)
       return boolean,

       member function get_json
       return varchar2,

       member procedure perform_check(
           p_is_valid out boolean,
           p_validation_message out varchar2)
);
/
create or replace type body t_core_person_address is

    member function equals(
        p_core_person_address in t_core_person_address)
    return boolean
    is
    begin
        if (p_core_person_address is null) then
            return false;
        end if;

        return bars.tools.equals(codregion    , p_core_person_address.codregion    ) and
               bars.tools.equals(area         , p_core_person_address.area         ) and
               bars.tools.equals(zip          , p_core_person_address.zip          ) and
               bars.tools.equals(city         , p_core_person_address.city         ) and
               bars.tools.equals(streetaddress, p_core_person_address.streetaddress) and
               bars.tools.equals(houseno      , p_core_person_address.houseno      ) and
               bars.tools.equals(adrkorp      , p_core_person_address.adrkorp      ) and
               bars.tools.equals(flatno       , p_core_person_address.flatno       );
    end;

    member function get_json
    return varchar2
    is
        l_string varchar2(32767 byte);
        l_address_keys bars.string_list := bars.string_list();
    begin
        l_address_keys.extend(8);
        l_address_keys(1) := json_utl.make_json_string('codRegion', codRegion, p_mandatory => true);
        l_address_keys(2) := json_utl.make_json_string('area', nvl(area, city), p_mandatory => true);
        l_address_keys(3) := json_utl.make_json_string('zip', zip, p_mandatory => true);
        l_address_keys(4) := json_utl.make_json_string('city', city, p_mandatory => true);
        l_address_keys(5) := json_utl.make_json_string('streetAddress', streetAddress, p_mandatory => true);
        l_address_keys(6) := json_utl.make_json_string('houseNo', houseNo, p_mandatory => true);
        l_address_keys(7) := json_utl.make_json_string('adrKorp', adrKorp);
        l_address_keys(8) := json_utl.make_json_string('flatNo', flatNo);

        l_string := '{ ' || bars.tools.words_to_string(l_address_keys, p_splitting_symbol => ', ', p_ignore_nulls => 'Y') || ' }';

        return l_string;
    end;

    member procedure perform_check(
        p_is_valid out boolean,
        p_validation_message out varchar2)
    is
    begin
        p_is_valid := true;

        if (codRegion is null) then
            p_is_valid := false;
            p_validation_message := 'Код області не вказаний';
        end if;

        if (area is null and city is null) then
            p_is_valid := false;
            p_validation_message := case when p_validation_message is null then null else p_validation_message || ', ' end ||
                                    'Район не заповнений';
        end if;

        if (city is null) then
            p_is_valid := false;
            p_validation_message := case when p_validation_message is null then null else p_validation_message || ', ' end ||
                                    'Місто не вказано';
        end if;

        if (zip is null) then
            p_is_valid := false;
            p_validation_message := case when p_validation_message is null then null else p_validation_message || ', ' end ||
                                    'Поштовий індекс не вказаний';
        elsif (not regexp_like(zip, '^[0-9]{5}$')) then
            p_is_valid := false;
            p_validation_message := case when p_validation_message is null then null else p_validation_message || ', ' end ||
                                    'Поштовий індекс повинен містити 5 цифр';
        end if;

        if (streetaddress is null) then
            p_is_valid := false;
            p_validation_message := case when p_validation_message is null then null else p_validation_message || ', ' end ||
                                    'Вулиця не вказана';
        elsif (regexp_substr(streetaddress, '[0-9а-яіїєґА-ЯІЇЄҐ''’ ./-]') is not null) then
            p_is_valid := false;
            p_validation_message := case when p_validation_message is null then null else p_validation_message || ', ' end ||
                                    'Назва вулиці містить недопустимі символи: ' || regexp_substr(streetaddress, '[0-9а-яіїєґА-ЯІЇЄҐ''’ ./-]');
        end if;

        if (houseno is null) then
            p_is_valid := false;
            p_validation_message := case when p_validation_message is null then null else p_validation_message || ', ' end ||
                                    'Номер будинку не вказаний';
        end if;
    end;
end;
/
create or replace type t_core_person_addresses force as table of t_core_person_address;
/
