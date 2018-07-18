
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/branch_attribute_utl.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BRANCH_ATTRIBUTE_UTL is

 ---------------------------------------------------------
    --
    --  Пакет по работе с бранчами
    --
    ---------------------------------------------------------

    ----------------------------------------------
    --  константы
    ----------------------------------------------

    G_HEADER_VERSION    constant varchar2(64) := 'version 1.1  18.08.2016';


    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция возвращает строку с версией заголовка пакета
    --
    function header_version return varchar2;


    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция возвращает строку с версией тела пакета
    --
    function body_version return varchar2;

    --------------------------------------------------------------
    --
    --  CREATE_ATTRIBUTE
    --
    --  Создать новый аттрибут(параметр)
    --
    procedure create_attribute(p_attribute_code varchar2, p_attribute_name varchar2, p_attribute_datatype varchar2);


    function read_attribute(
        p_attribute_code in varchar2,
        p_raise_ndf in boolean default true)
    return branch_attribute%rowtype;

    --------------------------------------------------------------
    --
    --  GET_ATTRIBUTE_VALUE
    --
    --   Получить значение аттрибута(параметра) для бранча
    --  (стартовая функция поиска, на которую опираются все)
    --
    function get_attribute_value(
        p_branch_code    varchar2,           -- код бранча
        p_attribute_code varchar2,           -- код аттрибута
        p_raise_expt     number default 1,   -- выкидывать исключение при отсутствии параметра (1-да, 0-нет)
        p_parent_lookup  number default 1,   -- если не нашли параметр - продолжить поиск вверх по родителям (1-да, 0-нет)  В случае неудачной проверки - выкинуть исключение
        p_check_exist    number default 1,   -- проверка существования бранча, параметра и т.д. (1-да, 0-нет). В случае неудачной проверки - выкинуть исключение
        p_def_value      varchar2 default null)     -- умолчательное значение (для случая, когда не выкдываем исключение )
    return varchar2;

    --------------------------------------------------------------
     --
     --  DELETE_ATTRIBUTE
     --
     --   Видаляє налаштування атрибуту. Якщо для одного з бранчів задане значення атрибуту - генерує помилку.
     --   Якщо параметр p_cascade_delete_value = true, значення видаляються разом з параметром
     --
     procedure delete_attribute(
         p_attr_code in varchar2,
         p_cascade_delete_values in boolean default false);

    --------------------------------------------------------------
    --
    --  GET_VALUE
    --
    --   Получить значение аттрибута(параметра) для указанного бранча.
    --   при отсутствии значения параметра - не выкидывать исключение, отдать пустое значение
    --
    function get_value(
        p_branch_code varchar2,
        p_attribute_code varchar2)
    return varchar2;

    --------------------------------------------------------------
    --
    --  GET_VALUE
    --
    --   Получить значение аттрибута(параметра) для текущего бранча.
    --   при отсутствии значения параметра - не выкидывать исключение, отдать значение по-умолчанию
    --
    function get_value(
        p_attribute_code varchar2)
    return varchar2;

   --------------------------------------------------------------
    --
    --  ADD_NEW_ATTRIBUTE
    --
    --   Создать новый аттрибут для бранча
    --
    procedure add_new_attribute(
        p_attr_code     varchar2,
        p_attr_desc     varchar2,
        p_attr_datatype varchar2 default 'C',
        p_attr_format   varchar2 default null,
        p_attr_module   varchar2 default null,
        p_attr_group_id number default null); -- код группы для поддержки работы старых параметров


     --------------------------------------------------------------
     --
     --  ADD_NEW_ATTRIBUTE_WITH_SET
     --
     --   Создать новый аттрибут для бранча указать значение для указанного бранча
     --
     procedure add_new_attribute_with_set(
	    p_attr_code       varchar2,
		p_attr_desc       varchar2,
		p_attr_datatype   varchar2 default 'C',
		p_attr_format     varchar2 default null,
		p_attr_module     varchar2 default null,
		p_branch_code     varchar2,
		p_attr_value      varchar2);

    -----------------------------------------------------------
    --
    --  SET_ATTRIBUTE_VALUE
    --
    --   Установить значение аттрибута
    --
    procedure set_attribute_value(
        p_branch_code varchar2,
        p_attribute_code varchar2,
        p_attribute_value varchar2);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.BRANCH_ATTRIBUTE_UTL is

    ---------------------------------------------------------
    --
    --  Пакет по работе с параметрами бранчей, филиалов и корня '/'
    --
    ---------------------------------------------------------

    ----------------------------------------------
    --  константы
    ----------------------------------------------

    G_BODY_VERSION    constant varchar2(64) := 'version 1.1  18.08.2016';
    G_TRACE           constant varchar2(50) := 'branch_attribute_utl.';
    G_MODULE          constant varchar2(50) := 'BCH';


    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция возвращает строку с версией заголовка пакета
    --
    function header_version return varchar2
    is
    begin
        return 'package header branch_attribute_utl: ' || G_HEADER_VERSION;
    end header_version;


    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция возвращает строку с версией тела пакета
    --
    function body_version return varchar2
    is
    begin
        return 'package body branch_attribute_utl: ' || G_BODY_VERSION;
    end body_version;

    --------------------------------------------------------------
    --
    --  CREATE_ATTRIBUTE
    --
    --  Создать новый аттрибут(параметр)
    --
    procedure create_attribute(p_attribute_code varchar2, p_attribute_name varchar2, p_attribute_datatype varchar2)
    is
    begin
       insert into branch_attribute(attribute_desc, attribute_datatype, attribute_code)
       values (p_attribute_name, p_attribute_datatype, p_attribute_code);
    exception when dup_val_on_index then
       update branch_attribute set attribute_desc = p_attribute_name,  attribute_datatype = p_attribute_datatype where attribute_code =  p_attribute_code;
    end;

    --------------------------------------------------------------
    --
    --  READ_ATTRIBUTE
    --

    function read_attribute(
        p_attribute_code in varchar2,
        p_raise_ndf in boolean default true)
    return branch_attribute%rowtype
    is
        l_branch_attribute_row branch_attribute%rowtype;
    begin
        select *
        into   l_branch_attribute_row
        from   branch_attribute t
        where  t.attribute_code = p_attribute_code;

        return l_branch_attribute_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Параметр з кодом {' || p_attribute_code || '} не існує');
             else return null;
             end if;
    end;
    --------------------------------------------------------------
    --
    --  GET_ATTRIBUTE_VALUE
    --
    --   Получить значение аттрибута(параметра) для бранча
    --  (стартовая функция поиска, на которую опираются все)
    --
    function get_attribute_value(
        p_branch_code    varchar2,           -- код бранча
        p_attribute_code varchar2,           -- код аттрибута
        p_raise_expt     number default 1,   -- выкидывать исключение при отсутствии параметра (1-да, 0-нет)
        p_parent_lookup  number default 1,   -- если не нашли параметр - продолжить поиск вверх по родителям (1-да, 0-нет)  В случае неудачной проверки - выкинуть исключение
        p_check_exist    number default 1,   -- проверка существования бранча, параметра и т.д. (1-да, 0-нет). В случае неудачной проверки - выкинуть исключение
        p_def_value      varchar2 default null)  -- умолчательное значение (для случая, когда не выкдываем исключение )
    return varchar2
    is
        l_branch_row branch%rowtype;
        l_attribute_row branch_attribute%rowtype;
        l_value varchar2(4000 byte);
    begin
        if (p_check_exist = 1) then
            l_branch_row := branch_utl.read_branch(p_branch_code);
            l_attribute_row := read_attribute(p_attribute_code);
        end if;

        if (p_parent_lookup = 0) then
            begin
                select t.attribute_value
                into   l_value
                from   branch_attribute_value t
                where  t.attribute_code = p_attribute_code and
                       t.branch_code = p_branch_code;
            exception
                when no_data_found then
                     null;
            end;
        else
            select /*+ index(t IDX_BRANCH_ATTRIBUTE_VALUE)*/min(t.attribute_value) keep (dense_rank last order by length(t.branch_code))
            into   l_value
            from   branch_attribute_value t
            where  t.attribute_code = p_attribute_code and
                   p_branch_code like t.branch_code || '%';
        end if;

        if (l_value is null) then
            if (p_raise_expt = 1) then
                raise_application_error(-20000, 'Значення параметру {' || p_attribute_code || '} не заповнено для відділення {' || p_branch_code || '}');
            else
                return p_def_value;
            end if;
        end if;

        return l_value;
    end;


    --------------------------------------------------------------
    --
    --  GET_VALUE
    --
    --   Получить значение аттрибута(параметра) для указанного бранча.
    --   при отсутствии значения параметра - не выкидывать исключение, отдать пустое значение
    --
    function get_value(
        p_branch_code varchar2,             -- код бранча
        p_attribute_code varchar2)           -- код аттрибута
    return varchar2
    is
    begin
        return get_attribute_value(
                  p_branch_code    => p_branch_code,
                  p_attribute_code => p_attribute_code,
                  p_raise_expt     => 0,
                  p_parent_lookup  => 1,
                  p_check_exist    => 0,
                  p_def_value      => null);
    end;

    --------------------------------------------------------------
    --
    --  GET_VALUE
    --
    --   Получить значение аттрибута(параметра) для текущего бранча.
    --   при отсутствии значения параметра - не выкидывать исключение, отдать значение по-умолчанию
    --
    function get_value(
        p_attribute_code varchar2)
    return varchar2
    is
    begin
        return get_value(
                   p_branch_code    => sys_context('bars_context','user_branch'),
                   p_attribute_code => p_attribute_code);
    end;

     --------------------------------------------------------------
     --
     --  ADD_NEW_ATTRIBUTE
     --
     --   Создать новый аттрибут для бранча
     --
     procedure add_new_attribute(
         p_attr_code     varchar2,
         p_attr_desc     varchar2,
         p_attr_datatype varchar2 default 'C',
         p_attr_format   varchar2 default null,
         p_attr_module   varchar2 default null,
         p_attr_group_id number default null) -- код группы для поддержки работы старых параметров
     is
     begin
         update branch_attribute t
         set    t.attribute_desc = p_attr_desc,
                t.attribute_datatype = p_attr_datatype,
                t.attribute_format = p_attr_format,
                t.attribute_module = p_attr_module
         where  t.attribute_code = p_attr_code;

         if (sql%rowcount = 0) then
             insert into branch_attribute(attribute_code, attribute_desc, attribute_datatype, attribute_format, attribute_module)
             values(p_attr_code, p_attr_desc, p_attr_datatype, p_attr_format, p_attr_module);
         end if;
     exception
         when dup_val_on_index then
              bars_error.raise_nerror(G_MODULE, 'ATTR_ALREADY_EXISTS', p_attr_code);
     end;


     --------------------------------------------------------------
     --
     --  ADD_NEW_ATTRIBUTE_WITH_SET
     --
     --   Создать новый аттрибут для бранча указать значение для указанного бранча
     --
     procedure add_new_attribute_with_set(
         p_attr_code       varchar2,
         p_attr_desc       varchar2,
         p_attr_datatype   varchar2 default 'C',
         p_attr_format     varchar2 default null,
         p_attr_module     varchar2 default null,
 		 p_branch_code     varchar2,
         p_attr_value      varchar2)
     is
     begin
         add_new_attribute( p_attr_code => p_attr_code,
                            p_attr_desc => p_attr_desc,
                            p_attr_datatype => p_attr_datatype,
                            p_attr_format   => p_attr_format,
                            p_attr_module   => p_attr_module
						  );

		 set_attribute_value(p_branch_code     => p_branch_code,
                             p_attribute_code  => p_attr_code,
                             p_attribute_value => p_attr_value);
     end;

	 --------------------------------------------------------------
     --
     --  DELETE_ATTRIBUTE
     --
     --   Видаляє налаштування атрибуту. Якщо для одного з бранчів задане значення атрибуту - генерує помилку.
     --   Якщо параметр p_cascade_delete_value = true, значення видаляються разом з параметром
     --
     procedure delete_attribute(
         p_attr_code in varchar2,
         p_cascade_delete_values in boolean default false)
     is
         l_attribute_values varchar2_list;
     begin
         select t.attribute_value
         bulk collect into l_attribute_values
         from   branch_attribute_value t
         where  t.attribute_code = p_attr_code
         for update;

         if (l_attribute_values is not empty) then
             if (p_cascade_delete_values) then
                 delete branch_attribute_value t
                 where  t.attribute_code = p_attr_code;
             else
                 raise_application_error(-20000, 'Для атрибуту {' || p_attr_code || '} задані значення - видалити атрибут неможливо');
             end if;
         end if;

         delete branch_attribute t
         where  t.attribute_code = p_attr_code;
     end;

    --------------------------------------------------------------
    --
    --  SET_ATTRIBUTE_VALUE
    --
    --   Установить значение аттрибута
    --
    procedure set_attribute_value(
        p_branch_code varchar2,
        p_attribute_code varchar2,
        p_attribute_value varchar2)
    is
        l_branch_row branch%rowtype;
        l_attribute_row branch_attribute%rowtype;
    begin
        l_branch_row := branch_utl.read_branch(p_branch_code/*, p_lock => true*/);
        l_attribute_row := read_attribute(p_attribute_code);

        if (p_attribute_value is null) then
            delete branch_attribute_value t
            where  t.attribute_code = p_attribute_code and
                   t.branch_code = p_branch_code;
        else
            update branch_attribute_value
            set    attribute_value = p_attribute_value
            where  branch_code = p_branch_code and
                   attribute_code = p_attribute_code;

            if (sql%rowcount = 0) then
                insert into branch_attribute_value
                values (p_attribute_code, p_branch_code, p_attribute_value);
            end if;
        end if;
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  BRANCH_ATTRIBUTE_UTL ***
grant EXECUTE                                                                on BRANCH_ATTRIBUTE_UTL to BARSAQ;
grant EXECUTE                                                                on BRANCH_ATTRIBUTE_UTL to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/branch_attribute_utl.sql =========**
 PROMPT ===================================================================================== 
 