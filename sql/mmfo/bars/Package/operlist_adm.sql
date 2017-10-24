
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/operlist_adm.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.OPERLIST_ADM is

   ---------------------------------------------------------
   --
   --  Пакет по работе с бранчами
   --
   ---------------------------------------------------------

   ----------------------------------------------
   --  константы
   ----------------------------------------------

   G_HEADER_VERSION    constant varchar2(64) := 'version 1.0  08.02.2016';


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
  --  READ_FUNCTION
  --
  --    Отримання rowtype функції за її ідентифікатором
  --
  --    p_function_id       -  ідентифікатор функції (operlist.codeoper%type)
  --    p_lock              -  ознака необхідності заблокувати функцію перед оновленням її налаштувань
  --    p_raise_ndf         -  ознака того, чи генерувати exception, якщо функція з заданим ідентифікатором не знайдена
  --
  function read_function(
      p_function_id in integer,
      p_lock in boolean default false,
      p_raise_ndf in boolean default true)
  return operlist%rowtype;

  --------------------------------------------------------------
  --
  --  READ_FUNCTION
  --
  --    Отримання rowtype функції за її ідентифікатором
  --
  --    p_function_code     -  код функції (operlist.funcname%type)
  --    p_lock              -  ознака необхідності заблокувати функцію перед оновленням її налаштувань
  --    p_raise_ndf         -  ознака того, чи генерувати exception, якщо функція з заданим кодом не знайдена
  --
  function read_function(
      p_function_code in varchar2,
      p_lock in boolean default false,
      p_raise_ndf in boolean default true)
  return operlist%rowtype;


  --------------------------------------------------------------
  --
  --  GET_FUNCTION_ID
  --
  --    Отримання ідентфикатора функції за її кодом
  --
  --    p_function_code     -  код функції (operlist.funcname%type)
  --
  function get_function_id(
      p_function_code in varchar2)
  return integer;

  --------------------------------------------------------------
  --
  --  ADD_NEW_FUNC
  --
  --    Добавление новой функции в operlist.
  --
  --    p_name       -  Описание функции
  --    p_funcname   -  строка вызова функции
  --    p_rolename   -  имя роли для функции
  --    p_usearc     -  использовани в архиве
  --    p_frontend   -  интерфейс с которым работает ф-ция
  --    p_forceupd   -  если такая функция уже есть
  --                    (найден такой же вызов ф-ции), заменить все параметры
  --    p_forcerole  -  если такой роли нету или роль была другая, тогда, создать
  --                    такую роль и загрантить всех
  --                    пользователей если такая функа уже существовала.
  --    p_parent_function_id - идентификатор родительской функции: для автоматической
  --                           привязки функций веб-контроллеров (runable = 3) к их
  --                           ведущей страничной функции
  --
  function add_new_func
                   (p_name      operlist.name%type,
                    p_funcname  operlist.funcname%type,
                    p_usearc    smallint default 0,
                    p_frontend  smallint default 0,
                    p_forceupd  smallint default 1,
                    p_runnable  smallint default 1,
                    p_parent_function_id integer default null) return number;

  --------------------------------------------------------------
  --
  --  ADD_FUNC_TO_ARM
  --
  --    Добавление функции в ARM
  --
  --    p_func_id    -  Код функции
  --    p_arm_code   -  Код АРМ-а
  --
  procedure add_func_to_arm(
      p_codeoper in integer,
      p_codeapp in varchar2,
      p_approve in boolean default false);



 --------------------------------------------------------------
  --
  --  MODIFY_FUNC_BY_PATH
  --
  --    Изменение функции по коду вызова
  --
  --    p_funcpath      -  строка вызова функции
  --    p_new_funcpath  -  новая строка вызова
  --    p_new_name      -  новое имя функции
  --
  procedure modify_func_by_path
                   (p_funcpath       operlist.funcname%type,
                    p_new_funcpath   operlist.funcname%type  default null,
					p_new_name       operlist.name%type   default null);

  --------------------------------------------------------------
  --
  --  MODIFY_FUNC_BY_NAME
  --
  --    Изменение функции по коду вызова
  --
  --    p_funcpath      -  строка вызова функции
  --    p_new_funcpath  -  новая строка вызова
  --    p_new_name      -  новое имя функции
  --
  procedure modify_func_by_name
                   (p_name           operlist.name%type,
                    p_new_funcpath   operlist.funcname%type default null,
					p_new_name       operlist.name%type default null);

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.OPERLIST_ADM is


   ---------------------------------------------------------
   --
   --  Пакет по работе со строковыми переменными
   --
   ---------------------------------------------------------

   ----------------------------------------------
   --  константы
   ----------------------------------------------

   g_awk_body_defs     constant varchar2(512)  := '';
   G_BODY_VERSION      constant varchar2(64) := 'version 1.0  29.01.2016';
   G_TRACE             constant varchar2(50) := 'operlist_adm.';
   G_START_DAY_GROUP   constant number := 0;
   G_FINISH_DAY_GROUP  constant number := 1;
   G_ERRMOD            constant varchar2(10) := 'FNC';

   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     Функция возвращает строку с версией заголовка пакета
   --
   --
   --
   function header_version return varchar2
   is
   begin
       return 'package header operlist_adm: ' || G_HEADER_VERSION;
   end header_version;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     Функция возвращает строку с версией тела пакета
   --
   --
   --
   function body_version return varchar2
   is
   begin
       return 'package body operlist_adm: ' || G_BODY_VERSION;
   end body_version;

  --------------------------------------------------------------
  --
  --    NEW_FUNC_ID
  --
  --    Найти новый номер для функции (учитывая пустые номера)
  --
  --
  function new_func_id return  number
  is
     l_newid number;
  begin
      select min(codeoper) + 1
      into l_newid
      from operlist o1
      where not exists ( select codeoper from operlist
                         where codeoper=o1.codeoper + 1);
      return l_newid;
  end;


  function read_function(
      p_function_id in integer,
      p_lock in boolean default false,
      p_raise_ndf in boolean default true)
  return operlist%rowtype
  is
      l_function_row operlist%rowtype;
  begin
      if (p_lock) then
          select *
          into   l_function_row
          from   operlist t
          where  t.codeoper = p_function_id
          for update wait 60;
      else
          select *
          into   l_function_row
          from   operlist t
          where  t.codeoper = p_function_id;
      end if;

      return l_function_row;
  exception
      when no_data_found then
           if (p_raise_ndf) then
               bars_error.raise_nerror(G_ERRMOD, 'FUNC_NOT_FOUND', p_function_id);
           else return null;
           end if;
  end;

  function read_function(
      p_function_code in varchar2,
      p_lock in boolean default false,
      p_raise_ndf in boolean default true)
  return operlist%rowtype
  is
      l_function_row operlist%rowtype;
  begin
      if (p_lock) then
          select *
          into   l_function_row
          from   operlist t
          where  t.funcname = p_function_code
          for update wait 60;
      else
          select *
          into   l_function_row
          from   operlist t
          where  t.funcname = p_function_code;
      end if;

      return l_function_row;
  exception
      when no_data_found then
           if (p_raise_ndf) then
               bars_error.raise_nerror(G_ERRMOD, 'FUNCNAME_NOT_FOUND', p_function_code);
           else return null;
           end if;
  end;

  function get_function_id(
      p_function_code in varchar2)
  return integer
  is
  begin
      return read_function(p_function_code, p_raise_ndf => false).codeoper;
  end;

  procedure set_child_functions(
      p_parent_function_id in integer,
      p_child_function_ids in number_list)
  is
  begin
      if (p_child_function_ids is null or p_child_function_ids is empty) then
          return;
      end if;

      delete operlist_deps a where a.id_parent = p_parent_function_id;

      insert into operlist_deps a
      select p_parent_function_id parent_function_id, t.column_value child_function_id
      from   table(p_child_function_ids) t;
  end;

  procedure add_child_function(
      p_parent_function_id in integer,
      p_child_function_id in integer)
  is
  begin
      insert into operlist_deps
      select p_parent_function_id, p_child_function_id
      from DUAL
      where not exists (select 1
                        from   operlist_deps t
                        where  t.id_parent = p_parent_function_id and
                               t.id_child = p_child_function_id);
  end;

  --------------------------------------------------------------
  --
  --  MODIFY_FUNC_BY_PATH
  --
  --    Изменение функции по коду вызова
  --
  --    p_funcpath      -  строка вызова функции
  --    p_new_funcpath  -  новая строка вызова
  --    p_new_name      -  новое имя функции
  --
  procedure modify_func_by_path
                   (p_funcpath       operlist.funcname%type,
                    p_new_funcpath   operlist.funcname%type default null,
					p_new_name       operlist.name%type default null)
  is
  begin
     update operlist set funcname = nvl(p_new_funcpath, funcname),  name = nvl(p_new_name, name) where funcname like p_funcpath;
  end;

  --------------------------------------------------------------
  --
  --  MODIFY_FUNC_BY_NAME
  --
  --    Изменение функции по коду вызова
  --
  --    p_funcpath      -  строка вызова функции
  --    p_new_funcpath  -  новая строка вызова
  --    p_new_name      -  новое имя функции
  --
  procedure modify_func_by_name
                   (p_name           operlist.name%type,
                    p_new_funcpath   operlist.funcname%type default null,
					p_new_name       operlist.name%type default null)
  is
  begin
     update operlist set funcname = nvl(p_new_funcpath, funcname),  name = nvl(p_new_name, name) where name like p_name;
  end;



  --------------------------------------------------------------
  --
  --  ADD_NEW_FUNC
  --
  --    Добавление новой функции в operlist.
  --
  --    p_name       -  Описание функции
  --    p_funcname   -  строка вызова функции
  --    p_usearc     -  использовани в архиве
  --    p_frontend   -  интерфейс с которым работает ф-ция
  --    p_forceupd   -  если такая функция уже есть
  --                    (найден такой же вызов ф-ции), заменить все параметры
  --
  function add_new_func
                   (p_name      operlist.name%type,
                    p_funcname  operlist.funcname%type,
                    p_usearc    smallint default 0,
                    p_frontend  smallint default 0,
                    p_forceupd  smallint default 1,
                    p_runnable  smallint default 1,
                    p_parent_function_id integer default null) return number
  is
      l_trace varchar2(100) := G_TRACE||'add_new_func: ';
      l_function_row operlist%rowtype;
  begin
      l_function_row := read_function(p_funcname, p_lock => true, p_raise_ndf => false);

      if (l_function_row.codeoper is null) then
          -- функция не существует
          l_function_row.codeoper := new_func_id();

          insert into operlist
            (codeoper,
             name,
             dlgname,
             funcname,
             runable,
             frontend,
             usearc)
          values
            (l_function_row.codeoper,
             p_name,
             'N/A',
             p_funcname,
             p_runnable,
             p_frontend,
             p_usearc);

           bars_audit.info(l_trace||'Функцiю №' || l_function_row.codeoper || ' <' || p_name ||'> - добавлено');
      else
          if (p_forceupd = 1) then
              update operlist
                 set name     = p_name,
                     frontend = p_frontend,
                     usearc   = p_usearc
               where codeoper = l_function_row.codeoper;

              bars_audit.info(l_trace||' Функцiя №' || l_function_row.codeoper || ' <' || p_name ||'> - поновлена');
          end if;
      end if;

      if (p_parent_function_id is not null) then
          add_child_function(p_parent_function_id, l_function_row.codeoper);
      end if;

      return l_function_row.codeoper;
  end;


  --------------------------------------------------------------
  --
  --  ADD_FUNC_TO_ARM
  --
  --    Добавление функции в ARM
  --
  --    p_func_id    -  Код функции
  --    p_arm_code   -  Код АРМ-а
  --
  procedure add_func_to_arm(
      p_codeoper in integer,
      p_codeapp in varchar2,
      p_approve in boolean default false)
  is
  begin
     umu.add_func2arm(p_codeoper, p_codeapp, case when  p_approve then 1 else 0 end);
  end;


end operlist_adm;
/
 show err;
 
PROMPT *** Create  grants  OPERLIST_ADM ***
grant EXECUTE                                                                on OPERLIST_ADM    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/operlist_adm.sql =========*** End **
 PROMPT ===================================================================================== 
 