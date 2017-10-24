 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/tools.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.TOOLS is
    -- Author  : Artem Yurchenko
    -- Created : 16.11.2010
    -- Version 2.0   01.10.2017

    lf constant char(1 byte) := chr(10);
    cr constant char(1 byte) := chr(13);
    crlf constant char(2 byte) := cr || lf;

    invalid_number exception;
    numeric_or_value_error exception;
    pragma exception_init(invalid_number, -1722);
    pragma exception_init(numeric_or_value_error, -6502);

    procedure hide_hint(
        p_number in number);

    procedure hide_hint(
        p_bool in boolean);

    procedure hide_hint(
        p_string in varchar2);

    procedure hide_hint(
        p_date in date);

    procedure hide_hint(
        p_blob in blob);

    procedure hide_hint(
        p_clob in clob);

    function string_to_number_list(
        p_string in varchar,
        p_splitting_symbol in varchar default ';')
    return number_list;

    function string_to_words(
        p_string in varchar,
        p_splitting_symbol in varchar default ';')
    return varchar2_list;

    function words_to_string(
        p_words_list in varchar2_list,
        p_splitting_symbol in varchar2 default ';')
    return varchar2;

    function number_list_to_string(
        p_numbers_list in number_list,
        p_splitting_symbol in varchar2 default ';')
    return varchar2;

    function date_list_to_string(
        p_dates_list in date_list,
        p_splitting_symbol in varchar2 default ';',
        p_date_format in varchar2 default 'dd.mm.yyyy')
    return varchar2;

    function boolean_to_int(
        p_boolean in boolean)
    return integer;

    function boolean_to_string(
        p_boolean in boolean)
    return varchar2;

    function boolean_to_char(
        p_boolean in boolean)
    return char;

    function int_to_boolean(
        p_integer in integer)
    return boolean;

    function string_to_boolean(
        p_string in varchar2)
    return boolean;

    function char_to_boolean(
        p_char in char)
    return boolean;

    function number_to_base(
        p_number integer,
        p_base integer default 16)
    return varchar2;

    function equals(
        p_one in varchar2,
        p_another in varchar2)
    return boolean;

    function equals(
        p_one in number,
        p_another in number)
    return boolean;

    function equals(
        p_one in date,
        p_another in date)
    return boolean;

    function equals(
        p_one in number_list,
        p_another in number_list)
    return boolean;

    function equals(
        p_one in varchar2_list,
        p_another in varchar2_list)
    return boolean;

    function iif(p_condition in boolean, p_true_statement in number, p_else_statement in number default null) return number;
    function iif(p_condition in boolean, p_true_statement in varchar2, p_else_statement in varchar2 default null) return varchar2;
    function iif(p_condition in boolean, p_true_statement in date, p_else_statement in date default null) return date;
    function iif(p_condition in boolean, p_true_statement in blob, p_else_statement in blob default null) return blob;
    function iif(p_condition in boolean, p_true_statement in clob, p_else_statement in clob default null) return clob;

    function compare(
        p_one in number,
        p_another in number,
        p_nulls_first in char default 'N')
    return signtype;

    function compare(
        p_one in varchar2,
        p_another in varchar2,
        p_nulls_first in char default 'N')
    return signtype;

    function compare(
        p_one in date,
        p_another in date,
        p_nulls_first in char default 'N')
    return signtype;

    function compare(
        p_one in blob,
        p_another in blob,
        p_nulls_first in char default 'N')
    return signtype;

    function compare(
        p_one in clob,
        p_another in clob,
        p_nulls_first in char default 'N')
    return signtype;

    -- якщо обидві колекції null або мають однаковий набір значень (порядок значень не важливий), то вони однакові: {1, 2, 2, 3} == {3, 2, 1, 2}
    -- при цьому, враховується кількість входжень одного і того самого значення: {1, 2, 2, 3} != {3, 2, 1, 3}
    -- якщо набори значень відрізняються, порядок входження значень використовується для визначення того яка з колекцій більша:
    -- наприклад, {1, 2, 2, 3} < {3, 2, 1}, оскільки 1 < 3, незважаючи на те що кількість елементів в першій колекції більша,
    -- але {1, 2, 2, 3} > {1, 2, 2}, оскільки перші значення співпадають, а кількість елементів в першій колекції більша
    -- решта перевантажених функцій для скалярних типів (число, дата, строка) працюють аналогічно - для колекцій LOB є особливості
    function compare(
        p_one in number_list,
        p_another in number_list,
        p_nulls_first in char default 'N')
    return signtype;

    function compare(
        p_one in varchar2_list,
        p_another in varchar2_list,
        p_nulls_first in char default 'N')
    return signtype;

    function compare(
        p_one in date_list,
        p_another in date_list,
        p_nulls_first in char default 'N')
    return signtype;

    -- оскільки оператор multiset не доступний для LOB-колекцій, то при порівнянні таких колекцій, на відміну від скалярних типів,
    -- порядок елементів колекції завжди має значення: {'FF0101', 'EE0101'} > {'EE0101', 'FF0101'}
    function compare(
        p_one in blob_list,
        p_another in blob_list,
        p_nulls_first in char default 'N')
    return signtype;

    function compare(
        p_one in clob_list,
        p_another in clob_list,
        p_nulls_first in char default 'N')
    return signtype;

    function compare_range_borders(
        p_one in date,
        p_another in date)
    return integer;

    function contains_at_least_one(
        p_text in varchar2,
        p_patterns in varchar2_list,
        p_case_sensitive in char default 'N')
    return char;

    function contains_at_least_one(
        p_text in clob,
        p_patterns in varchar2_list,
        p_case_sensitive in char default 'N')
    return char;

    function get_first_contained_item(
        p_text in varchar2,
        p_patterns in varchar2_list,
        p_case_sensitive in char default 'N')
    return varchar2;

    function get_first_contained_item(
        p_text in clob,
        p_patterns in varchar2_list,
        p_case_sensitive in char default 'N')
    return varchar2;

    function is_valid_date(
        p_text in varchar2,
        p_format in varchar2 default 'yyyy-mm-dd')
    return char;

    function is_valid_number(
        p_text in varchar2,
        p_format in varchar2 default '99999999999999999999D999999999999',
        p_numeric_characters in varchar2 default '.''')
    return char;
end;
/
show errors



CREATE OR REPLACE PACKAGE BODY BARS.TOOLS as

   -- Version 2.0   01.10.2017


    procedure hide_hint(p_bool in boolean)
    is
    begin
        null;
    end;

    procedure hide_hint(p_number in number)
    is
    begin
        null;
    end;

    procedure hide_hint(p_string in varchar2)
    is
    begin
        null;
    end;

    procedure hide_hint(p_date in date)
    is
    begin
        null;
    end;

    procedure hide_hint(p_blob in blob)
    is
    begin
        null;
    end;

    procedure hide_hint(p_clob in clob)
    is
    begin
        null;
    end;

    function string_to_number_list(
        p_string in varchar,
        p_splitting_symbol in varchar default ';')
    return number_list
    is
        l_number_list   number_list := number_list();
        l_start_pos     pls_integer default 1;
        l_end_pos       pls_integer default 0;
        l_string_length pls_integer default length(p_string);
        l_split_length  pls_integer default length(p_splitting_symbol);
        l_value         varchar(50);
    begin
        if (p_splitting_symbol is null) then
            raise_application_error(-20000, 'Не вказаний разділювач чисел у рядку');
        end if;

        if (p_string is null) then
            return null;
        end if;

        l_end_pos := instr(p_string, p_splitting_symbol);
        loop
            l_value := substr(p_string, l_start_pos, (case when l_end_pos = 0 then l_string_length + 1 else l_end_pos end) - l_start_pos);

            l_number_list.extend(1);
            l_number_list(l_number_list.last) := to_number(trim(l_value), '99999999999999999999D999999999999', 'nls_numeric_characters = '',.''');

            exit when l_end_pos = 0;

            l_start_pos := l_end_pos + l_split_length;
            l_end_pos := instr(p_string, p_splitting_symbol, l_start_pos);
        end loop;

        return l_number_list;
    end;

    function string_to_words(
        p_string in varchar,
        p_splitting_symbol in varchar default ';')
    return varchar2_list
    is
        l_words_list    varchar2_list := varchar2_list();
        l_start_pos     pls_integer default 1;
        l_end_pos       pls_integer default 0;
        l_string_length pls_integer default length(p_string);
        l_split_length  pls_integer default length(p_splitting_symbol);
        l_value         varchar2(2000 char);
    begin
        if (p_splitting_symbol is null) then
            raise_application_error(-20000, 'Не вказаний разділювач слів у рядку');
        end if;

        if (p_string is null) then
            return null;
        end if;

        l_end_pos := instr(p_string, p_splitting_symbol);
        loop
            l_value := substr(p_string, l_start_pos, (case when l_end_pos = 0 then l_string_length + 1 else l_end_pos end) - l_start_pos);

            l_words_list.extend(1);
            l_words_list(l_words_list.last) := l_value;

            exit when l_end_pos = 0;

            l_start_pos := l_end_pos + l_split_length;
            l_end_pos := instr(p_string, p_splitting_symbol, l_start_pos);
        end loop;

        return l_words_list;
    end;

    function words_to_string(
        p_words_list in varchar2_list,
        p_splitting_symbol in varchar2 default ';')
    return varchar2
    is
        l integer;
        l_string varchar2(32767 byte);
    begin
        if (p_splitting_symbol is null) then
            raise_application_error(-20000, 'Не вказаний разділювач слів у рядку');
        end if;

        if (p_words_list is null) then
            return null;
        end if;

        l := p_words_list.first;
        while (l is not null) loop
            l_string := l_string || p_splitting_symbol || p_words_list(l);
            l := p_words_list.next(l);
        end loop;

        return substr(l_string, length(p_splitting_symbol) + 1);
    end;

    function number_list_to_string(
        p_numbers_list in number_list,
        p_splitting_symbol in varchar2 default ';')
    return varchar2
    is
        l integer;
        l_string varchar2(32767 byte);
    begin
        if (p_splitting_symbol is null) then
            raise_application_error(-20000, 'Не вказаний разділювач чисел у рядку');
        end if;

        if (p_numbers_list is null) then
            return null;
        end if;

        l := p_numbers_list.first;
        while (l is not null) loop
            l_string := l_string || p_splitting_symbol || to_char(p_numbers_list(l));
            l := p_numbers_list.next(l);
        end loop;

        return substr(l_string, length(p_splitting_symbol) + 1);
    end;

    function date_list_to_string(
        p_dates_list in date_list,
        p_splitting_symbol in varchar2 default ';',
        p_date_format in varchar2 default 'dd.mm.yyyy')
    return varchar2
    is
        l integer;
        l_string varchar2(32767 byte);
    begin
        if (p_splitting_symbol is null) then
            raise_application_error(-20000, 'Не вказаний разділювач дат у рядку');
        end if;

        if (p_dates_list is null) then
            return null;
        end if;

        l := p_dates_list.first;
        while (l is not null) loop
            l_string := l_string || p_splitting_symbol || to_char(p_dates_list(l), p_date_format);
            l := p_dates_list.next(l);
        end loop;

        return substr(l_string, length(p_splitting_symbol) + 1);
    end;

    function boolean_to_int(
        p_boolean in boolean)
    return integer
    is
    begin
        if (p_boolean is null) then
            return null;
        elsif (p_boolean) then
            return 1;
        elsif (not p_boolean) then
            return 0;
        end if;
    end;

    function boolean_to_string(
        p_boolean in boolean)
    return varchar2
    is
    begin
        if (p_boolean is null) then
            return null;
        elsif (p_boolean) then
            return 'true';
        elsif (not p_boolean) then
            return 'false';
        end if;
    end;

    function boolean_to_char(
        p_boolean in boolean)
    return char
    is
    begin
        if (p_boolean is null) then
            return null;
        elsif (p_boolean) then
            return 'Y';
        elsif (not p_boolean) then
            return 'N';
        end if;
    end;

    function int_to_boolean(
        p_integer in integer)
    return boolean
    is
    begin
        if (p_integer is null) then
            return null;
        elsif (p_integer = 1) then
            return true;
        elsif (p_integer = 0) then
            return false;
        else
            raise_application_error(-20000, 'Недійсне значення {' || p_integer || '} для приведення до логічного типу');
        end if;
    end;

    function string_to_boolean(
        p_string in varchar2)
    return boolean
    is
    begin
        if (p_string is null) then
            return null;
        elsif (lower(trim(p_string)) = 'true') then
            return true;
        elsif (lower(trim(p_string)) = 'false') then
            return false;
        else
            raise_application_error(-20000, 'Недійсне значення {' || p_string || '} для приведення до логічного типу');
        end if;
    end;

    function char_to_boolean(
        p_char in char)
    return boolean
    is
    begin
        if (p_char is null) then
            return null;
        elsif (upper(p_char) = 'Y') then
            return true;
        elsif (upper(p_char) = 'N') then
            return false;
        else
            raise_application_error(-20000, 'Недійсне значення {' || p_char || '} для приведення до логічного типу');
        end if;
    end;

    function number_to_base(
        p_number integer,
        p_base integer default 16)
    return varchar2
    is
        l_base char(62) := '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
        l_rest integer := p_number;
        l_remainder integer;
        l_hex_char char;
        l_hex varchar2(100);
    begin
        if (p_number is null) then
            return null;
        end if;

        if (p_number < 0) then
            raise_application_error(-20000, 'Значення не може бути від''ємним');
        end if;

        if p_base <= 62 then
            loop
                l_remainder := mod(l_rest, p_base);
                l_rest := trunc(l_rest / p_base);
                l_hex_char := substr(l_base, l_remainder + 1, 1);
                l_hex := l_hex_char || l_hex;
                exit when l_rest = 0;
            end loop;
        else
            raise_application_error(-20000, 'База системи числення не може перевищувати 62');
        end if;

        return l_hex;
    end;

    function equals(p_one in varchar2, p_another in varchar2)
    return boolean is
    begin
        case when p_one = p_another or (p_one is null and p_another is null) then return true;
             else return false;
        end case;
    end;

    function equals(p_one in number, p_another in number)
    return boolean is
    begin
        case when p_one = p_another or (p_one is null and p_another is null) then return true;
             else return false;
        end case;
    end;

    function equals(p_one in date, p_another in date)
    return boolean is
    begin
        case when p_one = p_another or (p_one is null and p_another is null) then return true;
             else return false;
        end case;
    end;

    function equals(p_one in number_list, p_another in number_list)
    return boolean is
    begin
        case when p_one = p_another or (p_one is null and p_another is null) then return true;
            else return false;
        end case;
    end;

    function equals(p_one in varchar2_list, p_another in varchar2_list)
    return boolean is
    begin
        case when p_one = p_another or (p_one is null and p_another is null) then return true;
            else return false;
        end case;
    end;

    function iif(p_condition in boolean, p_true_statement in number, p_else_statement in number default null) return number
    is
    begin
        if (p_condition) then
            return p_true_statement;
        else return p_else_statement;
        end if;
    end;

    function iif(p_condition in boolean, p_true_statement in varchar2, p_else_statement in varchar2 default null) return varchar2
    is
    begin
        if (p_condition) then
            return p_true_statement;
        else return p_else_statement;
        end if;
    end;

    function iif(p_condition in boolean, p_true_statement in date, p_else_statement in date default null) return date
    is
    begin
        if (p_condition) then
            return p_true_statement;
        else return p_else_statement;
        end if;
    end;

    function iif(p_condition in boolean, p_true_statement in blob, p_else_statement in blob default null) return blob
    is
    begin
        if (p_condition) then
            return p_true_statement;
        else return p_else_statement;
        end if;
    end;

    function iif(p_condition in boolean, p_true_statement in clob, p_else_statement in clob default null) return clob
    is
    begin
        if (p_condition) then
            return p_true_statement;
        else return p_else_statement;
        end if;
    end;

    function compare(
        p_one in number,
        p_another in number,
        p_nulls_first in char default 'N')
    return signtype
    is
    begin
        if (p_one is null) then
            if (p_another is null) then
                return 0;
            else
                return iif(p_nulls_first = 'Y', 1, -1);
            end if;
        else
            if (p_another is null) then
                return iif(p_nulls_first = 'Y', -1, 1);
            else
                if (p_one > p_another) then
                    return 1;
                elsif (p_one < p_another) then
                    return -1;
                else
                    return 0;
                end if;
            end if;
        end if;
    end;

    function compare(
        p_one in varchar2,
        p_another in varchar2,
        p_nulls_first in char default 'N')
    return signtype
    is
    begin
        if (p_one is null) then
            if (p_another is null) then
                return 0;
            else
                return iif(p_nulls_first = 'Y', 1, -1);
            end if;
        else
            if (p_another is null) then
                return iif(p_nulls_first = 'Y', -1, 1);
            else
                if (p_one > p_another) then
                    return 1;
                elsif (p_one < p_another) then
                    return -1;
                else
                    return 0;
                end if;
            end if;
        end if;
    end;

    function compare(
        p_one in date,
        p_another in date,
        p_nulls_first in char default 'N')
    return signtype
    is
    begin
        if (p_one is null) then
            if (p_another is null) then
                return 0;
            else
                return iif(p_nulls_first = 'Y', 1, -1);
            end if;
        else
            if (p_another is null) then
                return iif(p_nulls_first = 'Y', -1, 1);
            else
                if (p_one > p_another) then
                    return 1;
                elsif (p_one < p_another) then
                    return -1;
                else
                    return 0;
                end if;
            end if;
        end if;
    end;

    function compare(
        p_one in blob,
        p_another in blob,
        p_nulls_first in char default 'N')
    return signtype
    is
        l_result integer;
    begin
        if (p_one is null) then
            if (p_another is null) then
                return 0;
            else
                return iif(p_nulls_first = 'Y', 1, -1);
            end if;
        else
            if (p_another is null) then
                return iif(p_nulls_first = 'Y', -1, 1);
            else
                l_result := dbms_lob.compare(p_one, p_another);
                if (l_result = 0) then
                    return l_result;
                else
                    -- оскільки, згідно документації, dbms_lob.compare повертає не 1 або -1, а певний невідомий нам INTEGER
                    -- "COMPARE returns zero if the data exactly matches over the range specified by the offset and amount parameters. Otherwise, a nonzero INTEGER is returned",
                    -- то поділимо значення саме на себе для приведення його до SIGNTYPE (від -1 до 1)
                    return l_result / abs(l_result);
                end if;
            end if;
        end if;
    end;

    function compare(
        p_one in clob,
        p_another in clob,
        p_nulls_first in char default 'N')
    return signtype
    is
        l_result integer;
    begin
        if (p_one is null) then
            if (p_another is null) then
                return 0;
            else
                return iif(p_nulls_first = 'Y', 1, -1);
            end if;
        else
            if (p_another is null) then
                return iif(p_nulls_first = 'Y', -1, 1);
            else
                l_result := dbms_lob.compare(p_one, p_another);
                if (l_result = 0) then
                    return l_result;
                else
                    -- аналогічно до функції з blob, поділимо значення саме на себе для приведення його до SIGNTYPE (від -1 до 1)
                    return l_result / abs(l_result);
                end if;
            end if;
        end if;
    end;

    function compare(
        p_one in number_list,
        p_another in number_list,
        p_nulls_first in char default 'N')
    return signtype
    is
        l_ones_left number_list;
        l_anothers_left number_list;
        l_result signtype;
        l integer;
    begin
        if (p_one is null) then
            if (p_another is null) then
                return 0;
            else
                return iif(p_nulls_first = 'Y', 1, -1);
            end if;
        else
            if (p_another is null) then
                return iif(p_nulls_first = 'Y', -1, 1);
            else
                l_ones_left := p_one multiset except all p_another;
                l_anothers_left := p_another multiset except all p_one;

                if (l_ones_left is empty and l_anothers_left is empty) then
                    return 0;
                else
                    l := p_one.first;
                    while (l is not null) loop
                        if (p_another.exists(l)) then
                            l_result := compare(p_one(l), p_another(l), p_nulls_first);
                            if (l_result <> 0) then
                                return l_result;
                            end if;
                        else
                            -- в p_another закінчилися значення - вважаємо p_one більшим за p_another
                            return 1;
                        end if;
                        l := p_one.next(l);
                    end loop;
                    -- дійшли до цієї точки, значить в p_one закінчились значення
                    -- якщо при цьому кількість значень в p_another більша за p_one, вважаємо p_another більшим.
                    return iif(p_another.count > p_one.count, -1, 0);
                end if;
            end if;
        end if;
    end;

    function compare(
        p_one in varchar2_list,
        p_another in varchar2_list,
        p_nulls_first in char default 'N')
    return signtype
    is
        l_ones_left varchar2_list;
        l_anothers_left varchar2_list;
        l_result signtype;
        l integer;
    begin
        if (p_one is null) then
            if (p_another is null) then
                return 0;
            else
                return iif(p_nulls_first = 'Y', 1, -1);
            end if;
        else
            if (p_another is null) then
                return iif(p_nulls_first = 'Y', -1, 1);
            else
                l_ones_left := p_one multiset except all p_another;
                l_anothers_left := p_another multiset except all p_one;

                if (l_ones_left is empty and l_anothers_left is empty) then
                    return 0;
                else
                    l := p_one.first;
                    while (l is not null) loop
                        if (p_another.exists(l)) then

                            l_result := compare(p_one(l), p_another(l), p_nulls_first);

                            if (l_result <> 0) then
                                return l_result;
                            end if;
                        else
                            return 1;
                        end if;
                        l := p_one.next(l);
                    end loop;

                    return iif(p_another.count > p_one.count, -1, 0);
                end if;
            end if;
        end if;
    end;

    function compare(
        p_one in date_list,
        p_another in date_list,
        p_nulls_first in char default 'N')
    return signtype
    is
        l_ones_left date_list;
        l_anothers_left date_list;
        l_result signtype;
        l integer;
    begin
        if (p_one is null) then
            if (p_another is null) then
                return 0;
            else
                return iif(p_nulls_first = 'Y', 1, -1);
            end if;
        else
            if (p_another is null) then
                return iif(p_nulls_first = 'Y', -1, 1);
            else
                l_ones_left := p_one multiset except all p_another;
                l_anothers_left := p_another multiset except all p_one;

                if (l_ones_left is empty and l_anothers_left is empty) then
                    return 0;
                else
                    l := p_one.first;
                    while (l is not null) loop
                        if (p_another.exists(l)) then

                            l_result := compare(p_one(l), p_another(l), p_nulls_first);

                            if (l_result <> 0) then
                                return l_result;
                            end if;
                        else
                            return 1;
                        end if;
                        l := p_one.next(l);
                    end loop;

                    return iif(p_another.count > p_one.count, -1, 0);
                end if;
            end if;
        end if;
    end;

    function compare(
        p_one in blob_list,
        p_another in blob_list,
        p_nulls_first in char default 'N')
    return signtype
    is
        l_result signtype;
        l integer;
    begin
        if (p_one is null) then
            if (p_another is null) then
                return 0;
            else
                return iif(p_nulls_first = 'Y', 1, -1);
            end if;
        else
            if (p_another is null) then
                return iif(p_nulls_first = 'Y', -1, 1);
            else
                l := p_one.first;
                while (l is not null) loop
                    if (p_another.exists(l)) then

                        l_result := compare(p_one(l), p_another(l), p_nulls_first);

                        if (l_result <> 0) then
                            return l_result;
                        end if;
                    else
                        return 1;
                    end if;
                    l := p_one.next(l);
                end loop;

                return iif(p_another.count > p_one.count, -1, 0);
            end if;
        end if;
    end;

    function compare(
        p_one in clob_list,
        p_another in clob_list,
        p_nulls_first in char default 'N')
    return signtype
    is
        l_result signtype;
        l integer;
    begin
        if (p_one is null) then
            if (p_another is null) then
                return 0;
            else
                return iif(p_nulls_first = 'Y', 1, -1);
            end if;
        else
            if (p_another is null) then
                return iif(p_nulls_first = 'Y', -1, 1);
            else
                l := p_one.first;
                while (l is not null) loop
                    if (p_another.exists(l)) then

                        l_result := compare(p_one(l), p_another(l), p_nulls_first);

                        if (l_result <> 0) then
                            return l_result;
                        end if;
                    else
                        return 1;
                    end if;
                    l := p_one.next(l);
                end loop;

                return iif(p_another.count > p_one.count, -1, 0);
            end if;
        end if;
    end;

    function compare_range_borders(
        p_one in date,
        p_another in date)
    return integer
    is
    begin
        if (p_one is null) then
            return -1;
        end if;
        if (p_another is null) then
            return -1;
        end if;

        if (p_one > p_another) then
            return 1;
        elsif (p_one < p_another) then
            return -1;
        else
            return 0;
        end if;
    end;

    function contains_at_least_one(
        p_text in varchar2,
        p_patterns in varchar2_list,
        p_case_sensitive in char default 'N')
    return char
    is
        l binary_integer;
        l_result boolean default false;
        l_case_sensitive char(1 byte) default case when (p_case_sensitive = 'Y') then 'c' else 'i' end;
    begin
        if (p_text is null or p_patterns is null) then
            return null;
        end if;

        l := p_patterns.first;
        while (l is not null and not l_result) loop
            l_result :=  regexp_like(p_text, p_patterns(l), l_case_sensitive);

            l := p_patterns.next(l);
        end loop;

        return boolean_to_char(l_result);
    end;

    function contains_at_least_one(
        p_text in clob,
        p_patterns in varchar2_list,
        p_case_sensitive in char default 'N')
    return char
    is
        l binary_integer;
        l_result boolean default false;
        l_case_sensitive char(1 byte) default case when (p_case_sensitive = 'Y') then 'c' else 'i' end;
    begin
        if (p_text is null or p_patterns is null) then
            return null;
        end if;

        l := p_patterns.first;
        while (l is not null and not l_result) loop
            l_result :=  regexp_like(p_text, p_patterns(l), l_case_sensitive);

            l := p_patterns.next(l);
        end loop;

        return boolean_to_char(l_result);
    end;

    function get_first_contained_item(
        p_text in varchar2,
        p_patterns in varchar2_list,
        p_case_sensitive in char default 'N')
    return varchar2
    is
        l binary_integer;
        l_result varchar2(4000 byte);
        l_case_sensitive char(1 byte) default case when (p_case_sensitive = 'Y') then 'c' else 'i' end;
    begin
        if (p_text is null or p_patterns is null) then
            return null;
        end if;

        l := p_patterns.first;
        while (l is not null and l_result is null) loop
            if (regexp_like(p_text, '(^|\s|\W)' || p_patterns(l) || '($|\s|\W)', l_case_sensitive)) then
                l_result := p_patterns(l);
            end if;
            l := p_patterns.next(l);
        end loop;

        return l_result;
    end;

    function get_first_contained_item(
        p_text in clob,
        p_patterns in varchar2_list,
        p_case_sensitive in char default 'N')
    return varchar2
    is
        l binary_integer;
        l_result varchar2(4000 byte);
        l_case_sensitive char(1 byte) default case when (p_case_sensitive = 'Y') then 'c' else 'i' end;
    begin
        if (p_text is null or p_patterns is null) then
            return null;
        end if;

        l := p_patterns.first;
        while (l is not null and l_result is null) loop
            if (regexp_like(p_text, '(^|\s|\W)' || p_patterns(l) || '($|\s|\W)', l_case_sensitive)) then
                l_result := p_patterns(l);
            end if;
            l := p_patterns.next(l);
        end loop;

        return l_result;
    end;

    function is_valid_date(
        p_text in varchar2,
        p_format in varchar2 default 'yyyy-mm-dd')
    return char
    is
    begin
        if (p_text is null) then
            return null;
        end if;

        hide_hint(to_date(p_text, p_format));

        return 'Y';
    exception
        when others then
             return 'N';
    end;

    function is_valid_number(
        p_text in varchar2,
        p_format in varchar2 default '99999999999999999999D999999999999',
        p_numeric_characters in varchar2 default '.''')
    return char
    is
        invalid_number exception;
        numeric_or_value_error exception;
        pragma exception_init(invalid_number, -1722);
        pragma exception_init(numeric_or_value_error, -6502);
    begin
        if (p_text is null) then
            return null;
        end if;

        hide_hint(to_number(trim(p_text), p_format, 'nls_numeric_characters = ''' || p_numeric_characters || ''''));

        return 'Y';
    exception
        when invalid_number then
             return 'N';
        when numeric_or_value_error then
             return 'N';
    end;
end;
/
show errors
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/tools.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 
