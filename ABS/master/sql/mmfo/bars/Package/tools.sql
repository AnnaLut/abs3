create or replace package tools is
    -- Author  : Artem Yurchenko
    -- Created : 16.11.2010
    -- Version 2.0   01.10.2017

    ANNO_FIRST_DAY constant date := date '0001-01-01';

    -- gn_dummy   number;  -- Для возвратов функций

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

    function number_list_to_string_list(
        p_number_list in number_list,
        p_number_format in varchar2 default null,
        p_ignore_nulls in char default 'N')
    return string_list;

    function date_list_to_string_list(
        p_date_list in date_list,
        p_date_format in varchar2 default null,
        p_ignore_nulls in char default 'N')
    return string_list;

    function varchar2_list_to_string_list(
        p_varchar2_list in varchar2_list,
        p_ignore_nulls in char default 'N',
        p_truncate_long_values in char default 'N')
    return string_list;

    function string_list_to_number_list(
        p_string_list in string_list,
        p_number_format in varchar2 default null,
        p_nls_numeric_characters in varchar2 default null,
        p_ignore_nulls in char default 'N')
    return number_list;

    function string_list_to_date_list(
        p_string_list in string_list,
        p_date_format in varchar2 default null,
        p_ignore_nulls in char default 'N')
    return date_list;

    function string_list_to_varchar2_list(
        p_string_list in string_list,
        p_ignore_nulls in char default 'N')
    return varchar2_list;

    function words_to_string(
        p_words_list in string_list,
        p_splitting_symbol in varchar2 default ';',
        p_ceiling_length in integer default null,
        p_ignore_nulls in char default 'N')
    return varchar2;

    function words_to_clob(
        p_words in string_list,
        p_splitting_symbol in varchar2 default ';',
        p_ignore_nulls in char default 'N')
    return clob;

    function number_list_to_string(
        p_number_list in number_list,
        p_number_format in varchar2 default null,
        p_splitting_symbol in varchar2 default ';',
        p_ceiling_length in integer default null,
        p_ignore_nulls in char default 'N')
    return varchar2;

    function date_list_to_string(
        p_date_list in date_list,
        p_date_format in varchar2 default null,
        p_splitting_symbol in varchar2 default ';',
        p_ceiling_length in integer default null,
        p_ignore_nulls in char default 'N')
    return varchar2;

    function string_to_words(
        p_string in varchar2,
        p_splitting_symbol in varchar2 default ';',
        p_trim_words in char default 'N',
        p_ignore_nulls in char default 'N')
    return string_list;

    function string_to_number_list(
        p_string in varchar,
        p_number_format in varchar2 default null,
        p_nls_numeric_characters in varchar2 default null,
        p_splitting_symbol in varchar default ';',
        p_ignore_nulls in char default 'N')
    return number_list;

    function string_to_date_list(
        p_string in varchar,
        p_date_format in varchar2 default null,
        p_splitting_symbol in varchar default ';',
        p_ignore_nulls in char default 'N')
    return date_list;

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

    function date_to_number(
        p_date in date,
        p_replace_null_with_this_value in integer default null)
    return integer;

    function date_to_number2(
        p_date in date,
        p_replace_null_with_this_value in integer default null)
    return integer;

    function number_to_date(
        p_number in integer,
        p_replace_this_value_with_null in integer default null)
    return date;

    function number_to_date2(
        p_number in integer,
        p_replace_this_value_with_null in integer default null)
    return date;

    function number_to_base(
        p_number integer,
        p_base integer default 16)
    return varchar2;

    function clob_to_string_list(
        p_clob in clob)
    return string_list;

    function dimension_from_dictionary_list(
        p_dictionary_list in t_dictionary_list,
        p_key in varchar2,
        p_ignore_nulls in char default 'N',
        p_trim_values in char default 'N')
    return varchar2_list;

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
        p_one in string_list,
        p_another in string_list)
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

    -- якщо обидві колекції null або мають однаковий набір значень (порядок значень не важливий), то вони рівні: {1, 2, 2, 3} == {3, 2, 1, 2}
    -- при цьому, враховується кількість входжень одного і того самого значення: {1, 2, 2, 3} != {3, 2, 1, 3}
    -- якщо набори значень відрізняються, в першу чергу перевіряється розмір колекції - чим більше елементів в колекції, тим вона більша
    -- якщо кількість елементів однакова, останнім критерієм для порівняння залишається порядок входження значень:
    -- наприклад, {1, 2, 2, 3} < {3, 2, 1, 3}, оскільки 1 < 3
    -- решта перевантажених функцій для скалярних типів (число, дата, строка) працюють аналогічно - для колекцій LOB є особливості
    function compare(
        p_one in number_list,
        p_another in number_list,
        p_nulls_first in char default 'N')
    return signtype;

    function compare(
        p_one in string_list,
        p_another in string_list,
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
        p_patterns in string_list,
        p_case_sensitive in char default 'N')
    return char;

    function contains_at_least_one(
        p_text in clob,
        p_patterns in string_list,
        p_case_sensitive in char default 'N')
    return char;

    function get_first_contained_item(
        p_text in varchar2,
        p_patterns in string_list,
        p_case_sensitive in char default 'N')
    return varchar2;

    function get_first_contained_item(
        p_text in clob,
        p_patterns in string_list,
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

    function bitor(
        p_one in number,
        p_another in number)
    return number;

    function bitxor(
        p_one in number,
        p_another in number)
    return number;

    function bitand_vector(
        p_vector in number_list)
    return number;

    function bitor_vector(
        p_vector in number_list)
    return number;

    function bitxor_vector(
        p_vector in number_list)
    return number;
end;
/
create or replace package body tools as

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

    function number_list_to_string_list(
        p_number_list in number_list,
        p_number_format in varchar2 default null,
        p_ignore_nulls in char default 'N')
    return string_list
    is
        l integer;
        l_string_list string_list;
    begin
        if (p_number_list is null) then
            return null;
        end if;

        l_string_list := string_list();
        l := p_number_list.first;
        while (l is not null) loop

            if (p_number_list(l) is not null or nvl(p_ignore_nulls, 'N') <> 'Y') then
                l_string_list.extend(1);

                if (p_number_format is null) then
                    l_string_list(l_string_list.last) := to_char(p_number_list(l));
                else
                    l_string_list(l_string_list.last) := to_char(p_number_list(l), p_number_format);
                end if;
            end if;

            l := p_number_list.next(l);
        end loop;

        return l_string_list;
    end;

    function date_list_to_string_list(
        p_date_list in date_list,
        p_date_format in varchar2 default null,
        p_ignore_nulls in char default 'N')
    return string_list
    is
        l integer;
        l_string_list string_list;
    begin
        if (p_date_list is null) then
            return null;
        end if;

        l_string_list := string_list();
        l := p_date_list.first;
        while (l is not null) loop

            if (p_date_list(l) is not null or nvl(p_ignore_nulls, 'N') <> 'Y') then
                l_string_list.extend(1);

                if (p_date_format is null) then
                    l_string_list(l_string_list.last) := to_char(p_date_list(l));
                else
                    l_string_list(l_string_list.last) := to_char(p_date_list(l), p_date_format);
                end if;
            end if;

            l := p_date_list.next(l);
        end loop;

        return l_string_list;
    end;

    function varchar2_list_to_string_list(
        p_varchar2_list in varchar2_list,
        p_ignore_nulls in char default 'N',
        p_truncate_long_values in char default 'N')
    return string_list
    is
        l integer;
        l_string_list string_list;
    begin
        if (p_varchar2_list is null) then
            return null;
        end if;

        l_string_list := string_list();
        l := p_varchar2_list.first;
        while (l is not null) loop
            if (p_varchar2_list(l) is not null or nvl(p_ignore_nulls, 'N') <> 'Y') then
                if (lengthb(p_varchar2_list(l)) > 4000) then
                    if (p_truncate_long_values = 'Y') then
                        l_string_list.extend(1);
                        l_string_list(l_string_list.last) := substrb(p_varchar2_list(l), 4000);
                    else
                        raise_application_error(-20000, 'Довжина елемента {' || l || ' : ' || substr(p_varchar2_list(l), 200) ||
                                                        '...} перевищує максимально допустиму довжину в 4000 байт');
                    end if;
                else
                    l_string_list.extend(1);
                    l_string_list(l_string_list.last) := p_varchar2_list(l);
                end if;
            end if;

            l := p_varchar2_list.next(l);
        end loop;

        return l_string_list;
    end;

    function string_list_to_number_list(
        p_string_list in string_list,
        p_number_format in varchar2 default null,
        p_nls_numeric_characters in varchar2 default null,
        p_ignore_nulls in char default 'N')
    return number_list
    is
        l integer;
        l_number_list number_list;
    begin
        if (p_string_list is null) then
            return null;
        end if;

        l_number_list := number_list();
        l := p_string_list.first;
        while (l is not null) loop
            if (p_string_list(l) is not null or nvl(p_ignore_nulls, 'N') <> 'Y') then
                l_number_list.extend(1);
                if (p_number_format is null) then
                    l_number_list(l_number_list.last) := to_number(trim(p_string_list(l)));
                else
                    if (p_nls_numeric_characters is null) then
                        l_number_list(l_number_list.last) := to_number(trim(p_string_list(l)), p_number_format);
                    else
                        l_number_list(l_number_list.last) := to_number(trim(p_string_list(l)), p_number_format, p_nls_numeric_characters);
                    end if;
                end if;
            end if;
            l := p_string_list.next(l);
        end loop;

        return l_number_list;
    end;

    function string_list_to_date_list(
        p_string_list in string_list,
        p_date_format in varchar2 default null,
        p_ignore_nulls in char default 'N')
    return date_list
    is
        l integer;
        l_date_list date_list;
    begin
        if (p_string_list is null) then
            return null;
        end if;

        l_date_list := date_list();
        l := p_string_list.first;
        while (l is not null) loop
            if (p_string_list(l) is not null or nvl(p_ignore_nulls, 'N') <> 'Y') then
                l_date_list.extend(1);
                if (p_date_format is null) then
                    l_date_list(l_date_list.last) := to_date(trim(p_string_list(l)));
                else
                    l_date_list(l_date_list.last) := to_date(trim(p_string_list(l)), p_date_format);
                end if;
            end if;
            l := p_string_list.next(l);
        end loop;

        return l_date_list;
    end;

    function string_list_to_varchar2_list(
        p_string_list in string_list,
        p_ignore_nulls in char default 'N')
    return varchar2_list
    is
        l integer;
        l_varchar2_list varchar2_list;
    begin
        if (p_string_list is null) then
            return null;
        end if;

        l_varchar2_list := varchar2_list();
        l := p_string_list.first;
        while (l is not null) loop
            if (p_string_list(l) is not null or nvl(p_ignore_nulls, 'N') <> 'Y') then
                l_varchar2_list.extend(1);
                l_varchar2_list(l_varchar2_list.last) := p_string_list(l);
            end if;
            l := p_string_list.next(l);
        end loop;

        return l_varchar2_list;
    end;

    function words_to_string(
        p_words_list in string_list,
        p_splitting_symbol in varchar2 default ';',
        p_ceiling_length in integer default null,
        p_ignore_nulls in char default 'N')
    return varchar2
    is
        l integer;
        l_string varchar2(32767 byte);
        l_current_length integer;
        l_item_length integer;
        l_length_left integer;
        l_splitter_length integer;
        l_ceiling_length integer := nvl(p_ceiling_length, 32767);
    begin
        if (p_words_list is null) then
            return null;
        end if;

        if (p_splitting_symbol is null) then
            l_splitter_length := 0;
        else
            l_splitter_length := lengthb(p_splitting_symbol);
        end if;

        l := p_words_list.first;

        l_current_length := 0;
        while (l is not null) loop
            if (p_words_list(l) is not null or nvl(p_ignore_nulls, 'N') <> 'Y') then
                l_item_length := nvl(lengthb(p_words_list(l)), 0);-- + l_splitter_length;
                l_length_left := l_ceiling_length - l_current_length;

                if (l_item_length > l_length_left) then
                    -- досягли межі - можна повертати значення
                    return rtrim(l_string, p_splitting_symbol);
                elsif (l_item_length = l_length_left) then
                    l_string := l_string || substrb(p_words_list(l), 1, l_length_left);
                    -- досягли межі - можна повертати значення
                    return l_string;
                else
                    l_string := l_string || p_words_list(l) || p_splitting_symbol;
                end if;

                l_current_length := l_current_length + l_item_length + l_splitter_length;
            end if;

            l := p_words_list.next(l);
        end loop;

        return substrb(l_string, 1, l_current_length - l_splitter_length);
    end;

    function words_to_clob(
        p_words in string_list,
        p_splitting_symbol in varchar2 default ';',
        p_ignore_nulls in char default 'N')
    return clob
    is
        l integer;
        l_clob clob;
    begin
        if (p_words is null or p_words is empty) then
            return null;
        end if;

        dbms_lob.createtemporary(l_clob, false);

        l := p_words.first;
        while (l is not null) loop
            if (p_words(l) is not null or nvl(p_ignore_nulls, 'N') <> 'Y') then
                dbms_lob.append(l_clob, p_words(l) || p_splitting_symbol);
            end if;

            l := p_words.next(l);
        end loop;

        return rtrim(l_clob, p_splitting_symbol);
    end;

    function number_list_to_string(
        p_number_list in number_list,
        p_number_format in varchar2 default null,
        p_splitting_symbol in varchar2 default ';',
        p_ceiling_length in integer default null,
        p_ignore_nulls in char default 'N')
    return varchar2
    is
    begin
        return words_to_string(number_list_to_string_list(p_number_list, p_number_format, p_ignore_nulls), p_splitting_symbol, p_ceiling_length);
    end;

    function date_list_to_string(
        p_date_list in date_list,
        p_date_format in varchar2 default null,
        p_splitting_symbol in varchar2 default ';',
        p_ceiling_length in integer default null,
        p_ignore_nulls in char default 'N')
    return varchar2
    is
    begin
        return words_to_string(date_list_to_string_list(p_date_list, p_date_format, p_ignore_nulls), p_splitting_symbol, p_ceiling_length);
    end;

    function string_to_words(
        p_string in varchar2,
        p_splitting_symbol in varchar2 default ';',
        p_trim_words in char default 'N',
        p_ignore_nulls in char default 'N')
    return string_list
    is
        l_words_list      string_list := string_list();
        l_start_pos       pls_integer default 1;
        l_end_pos         pls_integer default 0;
        l_string_length   pls_integer default nvl(length(p_string), 0);
        l_splitter_length pls_integer default nvl(length(p_splitting_symbol), 0);
        l_value           varchar2(4000 byte);
    begin
        if (p_splitting_symbol is null) then
            raise_application_error(-20000, 'Не вказаний розділювач слів у рядку');
        end if;

        if (p_string is null) then
            return null;
        end if;

        l_end_pos := instr(p_string, p_splitting_symbol);
        loop
            l_value := substr(p_string, l_start_pos, (case when l_end_pos = 0 then l_string_length + 1 else l_end_pos end) - l_start_pos);
            if (p_trim_words = 'Y') then
                l_value := trim(l_value);
            end if;

            if (l_value is not null or nvl(p_ignore_nulls, 'N') <> 'Y') then
                l_words_list.extend(1);
                l_words_list(l_words_list.last) := l_value;
            end if;

            exit when l_end_pos = 0;

            l_start_pos := l_end_pos + l_splitter_length;
            l_end_pos := instr(p_string, p_splitting_symbol, l_start_pos);
        end loop;

        return l_words_list;
    end;

    function string_to_number_list(
        p_string in varchar,
        p_number_format in varchar2 default null,
        p_nls_numeric_characters in varchar2 default null,
        p_splitting_symbol in varchar default ';',
        p_ignore_nulls in char default 'N')
    return number_list
    is
    begin
        if (p_splitting_symbol is null) then
            raise_application_error(-20000, 'Не вказаний розділювач чисел у рядку');
        end if;

        if (p_string is null) then
            return null;
        end if;

        return string_list_to_number_list(
                   string_to_words(p_string,
                                   p_splitting_symbol => p_splitting_symbol,
                                   p_trim_words => 'Y',
                                   p_ignore_nulls => p_ignore_nulls),
                   p_number_format => p_number_format,
                   p_nls_numeric_characters => p_nls_numeric_characters);
    end;

    function string_to_date_list(
        p_string in varchar,
        p_date_format in varchar2 default null,
        p_splitting_symbol in varchar default ';',
        p_ignore_nulls in char default 'N')
    return date_list
    is
    begin
        if (p_splitting_symbol is null) then
            raise_application_error(-20000, 'Не вказаний розділювач чисел у рядку');
        end if;

        if (p_string is null) then
            return null;
        end if;

        return string_list_to_date_list(
                   string_to_words(p_string,
                                   p_splitting_symbol => p_splitting_symbol,
                                   p_trim_words => 'Y',
                                   p_ignore_nulls => p_ignore_nulls),
                   p_date_format => p_date_format);
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

    function date_to_number(
        p_date in date,
        p_replace_null_with_this_value in integer default null)
    return integer
    is
    begin
        return case when p_date is null then p_replace_null_with_this_value
                    else to_number(to_char(p_date, 'yyyymmdd'))
               end;
    end;

    function date_to_number2(
        p_date in date,
        p_replace_null_with_this_value in integer default null)
    return integer
    is
    begin
        return case when p_date is null then p_replace_null_with_this_value
                    else (trunc(p_date) - ANNO_FIRST_DAY) + 1
               end;
    end;

    function number_to_date(
        p_number in integer,
        p_replace_this_value_with_null in integer default null)
    return date
    is
    begin
        return case when p_number = p_replace_this_value_with_null then null
                    else to_date(to_char(p_number, 'fm99999999'), 'yyyymmdd')
               end;
    end;

    function number_to_date2(
        p_number in integer,
        p_replace_this_value_with_null in integer default null)
    return date
    is
    begin
        return case when p_number = p_replace_this_value_with_null then null
                    else ANNO_FIRST_DAY + p_number - 1
               end;
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

    function clob_to_string_list(
        p_clob in clob)
    return string_list
    is
        l_size integer;
        l_portion integer;
        l_offset integer default 1;
        l_string_list string_list;
        l_portion_ceiling_size constant integer := 2000;
    begin
        if (p_clob is null) then
            return null;
        end if;

        l_size := dbms_lob.getlength(p_clob);
        l_portion := least(l_size, l_portion_ceiling_size);

        l_string_list := string_list();
        while (l_portion > 0) loop
            l_string_list.extend(1);
            l_string_list(l_string_list.last) := dbms_lob.substr(p_clob, l_portion, l_offset);

            l_offset := l_offset + l_portion;
            l_size := l_size - l_portion;
            l_portion := least(l_size, l_portion_ceiling_size);
        end loop;

        return l_string_list;
    end;

    function dimension_from_dictionary_list(
        p_dictionary_list in t_dictionary_list,
        p_key in varchar2,
        p_ignore_nulls in char default 'N',
        p_trim_values in char default 'N')
    return varchar2_list
    is
        l_values varchar2_list;
        l_value varchar2(32767 byte);
        l_elements_count integer := 0;
        i integer;
        j integer;
    begin
        if (p_dictionary_list is null) then
            return null;
        elsif (p_dictionary_list is empty) then
            return varchar2_list();
        end if;

        l_values := varchar2_list();
        l_values.extend(p_dictionary_list.count);

        i := p_dictionary_list.first;
        while (i is not null) loop

            l_value := null;

            if (p_dictionary_list(i) is not null and p_dictionary_list(i) is not empty) then
                j := p_dictionary_list(i).first;
                while (j is not null) loop
                    if (p_dictionary_list(i)(j) is not null) then
                        if (p_dictionary_list(i)(j).key = p_key) then
                            if (p_trim_values = 'Y') then
                                l_value := trim(p_dictionary_list(i)(j).value);
                            else
                                 l_value := p_dictionary_list(i)(j).value;
                            end if;

                            exit;
                        end if;
                    end if;
                    j := p_dictionary_list(i).next(j);
                end loop;
            end if;

            if (l_value is null and p_ignore_nulls = 'Y') then
                null;
            else
                l_elements_count := l_elements_count + 1;
                l_values(l_elements_count) := l_value;
            end if;

            i := p_dictionary_list.next(i);
        end loop;

        if (l_values.count > l_elements_count) then
            l_values.trim(l_values.count - l_elements_count);
        end if;

        return l_values;
    end;

    function equals(p_one in varchar2, p_another in varchar2)
    return boolean is
    begin
        return case when p_one = p_another or (p_one is null and p_another is null) then true
                    else false
               end;
    end;

    function equals(p_one in number, p_another in number)
    return boolean is
    begin
        return case when p_one = p_another or (p_one is null and p_another is null) then true
                    else false
               end;
    end;

    function equals(p_one in date, p_another in date)
    return boolean is
    begin
        return case when p_one = p_another or (p_one is null and p_another is null) then true
                    else false
               end;
    end;

    function equals(p_one in number_list, p_another in number_list)
    return boolean is
    begin
        return case when p_one = p_another or (p_one is null and p_another is null) then true
                    else false
               end;
    end;

    function equals(p_one in string_list, p_another in string_list)
    return boolean is
    begin
        return case when p_one = p_another or (p_one is null and p_another is null) then true
                    else false
               end;
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
        k integer;
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
                    if (p_one.count = p_another.count) then
                        l := p_one.first;
                        k := p_another.first;
                        while (l is not null) loop
                            l_result := compare(p_one(l), p_another(k), p_nulls_first);
                            if (l_result <> 0) then
                                return l_result;
                            end if;
                            l := p_one.next(l);
                            k := p_another.next(k);
                        end loop;
                    else
                        -- якщо кількість значень в p_another більша за p_one, вважаємо p_another більшим.
                        return iif(p_another.count > p_one.count, -1, 1);
                    end if;
                end if;
            end if;
        end if;
    end;

    function compare(
        p_one in string_list,
        p_another in string_list,
        p_nulls_first in char default 'N')
    return signtype
    is
        l_ones_left string_list;
        l_anothers_left string_list;
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
        p_patterns in string_list,
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
        p_patterns in string_list,
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
        p_patterns in string_list,
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
        p_patterns in string_list,
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

    -- подякуємо http://www.orafaq.com/wiki/bit за ці дві функції
    function bitor(
        p_one in number,
        p_another in number)
    return number
    is
    begin
        return p_one + p_another - bitand(p_one, p_another);
    end;

    function bitxor(
        p_one in number,
        p_another in number)
    return number
    is
    begin
        return bitor(p_one, p_another) - bitand(p_one, p_another);
    end;

    function bitand_vector(
        p_vector in number_list)
    return number
    is
        l integer;
        l_bitand number;
    begin
        if (p_vector is null or p_vector is empty) then
            return null;
        end if;

        l := p_vector.first;
        if (l is not null) then
            l_bitand := p_vector(l);
            l := p_vector.next(l);
        end if;

        while (l is not null) loop
            l_bitand := bitand(l_bitand, p_vector(l));
            l := p_vector.next(l);
        end loop;

        return l_bitand;
    end;

    function bitor_vector(
        p_vector in number_list)
    return number
    is
        l integer;
        l_bitor number;
    begin
        if (p_vector is null or p_vector is empty) then
            return null;
        end if;

        l := p_vector.first;
        if (l is not null) then
            l_bitor := p_vector(l);
            l := p_vector.next(l);
        end if;

        while (l is not null) loop
            l_bitor := bitor(l_bitor, p_vector(l));
            l := p_vector.next(l);
        end loop;

        return l_bitor;
    end;

    function bitxor_vector(
        p_vector in number_list)
    return number
    is
        l integer;
        l_bitxor number;
    begin
        if (p_vector is null or p_vector is empty) then
            return null;
        end if;

        l := p_vector.first;
        if (l is not null) then
            l_bitxor := p_vector(l);
            l := p_vector.next(l);
        end if;

        while (l is not null) loop
            l_bitxor := bitxor(l_bitxor, p_vector(l));
            l := p_vector.next(l);
        end loop;

        return l_bitxor;
    end;
end;
/
