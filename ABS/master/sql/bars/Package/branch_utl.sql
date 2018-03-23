
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/branch_utl.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BRANCH_UTL is

---------------------------------------------------------
   --
   --  Пакет по работе с бранчами
   --
   ---------------------------------------------------------



   ----------------------------------------------
   --  константы
   ----------------------------------------------

   G_HEADER_VERSION    constant varchar2(64) := 'version 1.0  08.02.2016';

   G_KF_LENGTH constant number:= 6; -- xxxxxx
   G_BRANCH_LV1_CODE_LENGTH constant number:= 8; -- /xxxxxx/
   G_BRANCH_LV2_CODE_LENGTH constant number:= 15; -- /xxxxxx/xxxxxx/
   G_BRANCH_LV3_CODE_LENGTH constant number:= 22; -- /xxxxxx/xxxxxx/xxxxxx/

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
  --  ADD_BRANCH
  --
  --   Добавление бранча
  procedure add_branch(
                 p_branch      branch.branch%type,
                 p_name        branch.name%type,
                 p_b040        branch.b040%type,
                 p_branch_type branch_tip.tip%type,
                 p_opendate    date,
                 p_closedate   date);


    --------------------------------------------------------------
    --
    --  UPDATE_BRANCH
    --
    --   Изменение базовых значений для  бранча
    --
    procedure update_branch(
                   p_branch      branch.branch%type,
                   p_name        branch.name%type,
                   p_b040        branch.b040%type,
                   p_branch_type branch_tip.tip%type,
                   p_opendate    date,
                   p_closedate   date);
    --------------------------------------------------------------
    --
    --  READ_BRANCH
    --
    --   Вычитать строку таблицы Branch
    --
    function read_branch(
        p_branch_code in varchar2,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return branch%rowtype;
    --------------------------------------------------------------
    --
    --  GET_BRANCH_NAME
    --
    --   Получить имя бранча
    --
    function get_branch_name( p_branch_code in varchar2)  return varchar2;

    --------------------------------------------------------------
    --
    --  CONSTRUCT_PARENT_BRANCH_CODE
    --
    --  Сконструировать бранч родителя
    --
    function construct_parent_branch_code(p_branch_code varchar2) return varchar;

    --------------------------------------------------------------
    --
    --  GET_KF_FROM_BRANCH_CODE
    --
    --   Извлечть из значения бранча код филиала
    --
    function get_kf_from_branch_code(p_branch_code varchar2) return varchar2;
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.BRANCH_UTL is


   ---------------------------------------------------------
   --
   --  Пакет по работе с бранчами
   --
   ---------------------------------------------------------

   ----------------------------------------------
   --  константы
   ----------------------------------------------

   G_BODY_VERSION    constant varchar2(64) := 'version 1.0  08.02.2016';
   G_TRACE           constant varchar2(50) := 'branch_utl.';
   G_MODULE          constant varchar2(50) := 'BCH';



   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     Функция возвращает строку с версией заголовка пакета
   --
   function header_version return varchar2
   is
   begin
       return 'package header branch_utl: ' || G_HEADER_VERSION;
   end header_version;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     Функция возвращает строку с версией тела пакета
   --
   function body_version return varchar2
   is
   begin
       return 'package body branch_utl: ' || G_BODY_VERSION;
   end body_version;


  --------------------------------------------------------------
  --
  --  CONSTRUCT_PARENT_BRANCH_CODE
  --
  --  Сконструировать бранч родителя
  --
    function construct_parent_branch_code(p_branch_code varchar2) return varchar
    is
       l_res branch.branch%type;
    begin
       if length(p_branch_code) = 1 then l_res := null;
       else
         l_res :=  substr(p_branch_code,1,length(p_branch_code)-  G_BRANCH_LV1_CODE_LENGTH + 1);
       end if;
       return l_res;
    end;


  --------------------------------------------------------------
  --
  --  ADD_BRANCH
  --
  --   Добавление бранча c указанием его родителя
  --
  procedure add_branch(
      p_branch      branch.branch%type ,
      p_name        branch.name%type   ,
      p_b040        branch.b040%type   ,
      p_branch_type branch_tip.tip%type,
      p_opendate    date,
      p_closedate   date)
  is
  begin
     if p_name is null then
         bars_error.raise_nerror(G_MODULE, 'BRANCH_NAME_IS_EMPTY', p_branch);
     end if;

     insert into branch(branch, name, b040, date_opened, date_closed, description)
     values(p_branch,
            p_name, p_b040, p_opendate,
            p_closedate, p_branch_type);

      bars_audit.info(G_TRACE||'add_branch: добален новый бранч ' || p_branch);
  exception
      when dup_val_on_index then
           bars_error.raise_nerror(G_MODULE, 'BRANCH_ALREDY_EXISTS', p_branch);
  end;


  --------------------------------------------------------------
  --
  --  UPDATE_BRANCH
  --
  --   Изменение базовых значений для  бранча
  --
  procedure update_branch(
                 p_branch      branch.branch%type,
                 p_name        branch.name%type,
                 p_b040        branch.b040%type,
                 p_branch_type branch_tip.tip%type,
                 p_opendate    date,
                 p_closedate   date)
  is
  begin
     update branch set
          name =  p_name ,
          b040 =  p_b040   ,
          description =  p_branch_type,
          date_opened   =  p_opendate    ,
          date_closed  =  p_closedate
     where branch = p_branch;
  end;

  --------------------------------------------------------------
  --
  --  READ_BRANCH
  --
  --   Вычитать строку таблицы Branch
  --
    function read_branch(
        p_branch_code in varchar2,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return branch%rowtype
    is
        l_branch_row branch%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_branch_row
            from   branch
            where  branch = p_branch_code
            for update wait 60;
        else
            select *
            into   l_branch_row
            from   branch
            where  branch = p_branch_code;
        end if;

        return l_branch_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Відділення з кодом {' || p_branch_code || '} не знайдено');
             else return null;
             end if;
    end;

    --------------------------------------------------------------
    --
    --  GET_BRANCH_NAME
    --
    --   Получить имя бранча
    --
    function get_branch_name(p_branch_code in varchar2) return varchar2
    is
    begin
        return read_branch(p_branch_code, p_raise_ndf => false).name;
    end;


    --------------------------------------------------------------
    --
    --  GET_KF_FROM_BRANCH_CODE
    --
    --   Извлечть из значения бранча код филиала
    --
    function get_kf_from_branch_code(
        p_branch_code varchar2)
    return varchar2
    is
    begin
        return substr(p_branch_code, 2, G_KF_LENGTH);
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  BRANCH_UTL ***
grant EXECUTE                                                                on BRANCH_UTL      to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/branch_utl.sql =========*** End *** 
 PROMPT ===================================================================================== 
 