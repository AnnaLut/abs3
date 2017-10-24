
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_policy_adm.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_POLICY_ADM is
--
--  BARS_POLICY_ADM - пакет администрирования политик на объектах схемы BARS
--

g_header_version  constant varchar2(64)  := 'version 1.9 05/12/2008';

g_awk_header_defs constant varchar2(512) := '';

--
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2;

--
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2;


--
-- Модифицирует запись в policy_table
-- для таблицы схемы BARS
--
procedure alter_policy_info(
	p_table_name 		in policy_table.table_name%type,
	p_policy_group		in policy_table.policy_group%type,
	p_select_policy 	in policy_table.select_policy%type,
	p_insert_policy 	in policy_table.insert_policy%type,
	p_update_policy 	in policy_table.update_policy%type,
        p_delete_policy 	in policy_table.delete_policy%type);

--
-- Модифицирует запись в policy_table
--
procedure alter_policy_info(
	p_owner 		in policy_table.owner%type,
	p_table_name 		in policy_table.table_name%type,
	p_policy_group		in policy_table.policy_group%type,
	p_select_policy 	in policy_table.select_policy%type,
	p_insert_policy 	in policy_table.insert_policy%type,
	p_update_policy 	in policy_table.update_policy%type,
        p_delete_policy 	in policy_table.delete_policy%type);

--
-- Устанавливает групповые политики для таблицы(схема BARS) по данным из policy_table
--
procedure add_policies(p_table_name in varchar2);

--
-- Устанавливает групповые политики для таблицы по данным из policy_table
--
procedure add_policies(p_owner in varchar2, p_table_name in varchar2);

--
-- Пересчитывает значение функций политик для статических политик(схема BARS)
--
procedure refresh_policies(p_table_name in varchar2);

--
-- Пересчитывает значение функций политик для статических политик
--
procedure refresh_policies(p_owner in varchar2, p_table_name in varchar2);

--
-- Удаляет групповые политики на таблицы(схема BARS)
--
procedure remove_policies(p_table_name in varchar2);

--
-- Удаляет групповые политики на таблицы
--
procedure remove_policies(p_owner in varchar2, p_table_name in varchar2);

--
-- Изменяет групповые политики таблицы(схема BARS)
--
procedure alter_policies(p_table_name in varchar2, p_enable in boolean default true);

--
-- Изменяет групповые политики таблицы
--
procedure alter_policies(p_owner in varchar2, p_table_name in varchar2,  p_enable in boolean default true);

--
-- Добавляет политики на все объекты, описанные в POLICY_TABLE
--
procedure add_all_policies;

--
-- Обновляет значение функций политик на всех объектах
--
procedure refresh_all_policies;

--
-- Удаляет политики на все объекты, описанные в POLICY_TABLE
--
procedure remove_all_policies;

--
-- Изменяет политики на все объекты, описанные в POLICY_TABLE
--
procedure alter_all_policies;

--
-- Включает политики на таблице(схема BARS)
--
procedure enable_policies(p_table_name in varchar2);

--
-- Включает политики на таблице
--
procedure enable_policies(p_owner in varchar2, p_table_name in varchar2);

--
-- Выключает политики на таблице(схема BARS)
--
procedure disable_policies(p_table_name in varchar2);

--
-- Выключает политики на таблице
--
procedure disable_policies(p_owner in varchar2, p_table_name in varchar2);

--
-- Включает все политики, описанные в POLICY_TABLE
--
procedure enable_all_policies;

--
-- Выключает все политики, описанные в POLICY_TABLE
--
procedure disable_all_policies;

--
-- Добавляет к таблице колонку BRANCH(схема BARS)
--
procedure add_column_branch(p_table_name in varchar2);

--
-- Добавляет к таблице колонку BRANCH
--
procedure add_column_branch(p_owner in varchar2, p_table_name in varchar2);

--
-- Добавляет к таблице колонки BRANCH_A и BRANCH_B(схема BARS)
--
procedure add_column_branch_ab(p_table_name in varchar2);

--
-- Добавляет к таблице колонки BRANCH_A и BRANCH_B
--
procedure add_column_branch_ab(p_owner in varchar2, p_table_name in varchar2);

--
-- Добавляет к таблице колонку KF(схема BARS)
--
procedure add_column_kf(p_table_name in varchar2);

--
-- Добавляет к таблице колонку KF
--
procedure add_column_kf(p_owner in varchar2, p_table_name in varchar2);

--
-- Добавляет внешний ключ на accounts(acc,branch) по одноименным полям на таблицу схемы BARS
--
procedure add_fk_acc_branch(p_table_name in varchar2);

--
-- Добавляет внешний ключ на accounts(acc,branch) по одноименным полям
--
procedure add_fk_acc_branch(p_owner in varchar2, p_table_name in varchar2);

--
-- Добавляет внешний ключ на oper(ref,branch) по одноименным полям на таблицу схемы BARS
--
procedure add_fk_ref_branch(p_table_name in varchar2);

--
-- Добавляет внешний ключ на oper(ref,branch) по одноименным полям
--
procedure add_fk_ref_branch(p_owner in varchar2, p_table_name in varchar2);

--
-- Модифицирует все все дочерние таблицы(поле branch), сылающиеся на accounts
--
procedure update_accounts_child_tables(p_acc in number, p_new_branch in varchar2);


--
-- Добавляет поле KF к первичному ключу
-- В схеме BARS
procedure add_kf2pk(p_table_name in varchar2);

--
-- Добавляет поле KF к первичному ключу
--
procedure add_kf2pk(p_owner in varchar2, p_table_name in varchar2);

--
-- Добавляет поле KF к уникальному ключу
-- В схеме BARS
procedure add_kf2uk(p_table_name in varchar2);

--
-- Добавляет поле KF к первичному ключу
--
procedure add_kf2uk(p_owner in varchar2, p_table_name in varchar2);

--
-- Добавляет поле KF ко внешним ключам, если они ссылаются на PK или UK таблицы с полем KF
-- В схеме BARS
procedure alter_kf_cons(p_table_name in varchar2);

--
-- Добавляет поле KF ко внешним ключам, если они ссылаются на PK или UK таблицы с полем KF
--
procedure alter_kf_cons(p_owner in varchar2, p_table_name in varchar2);

--------------------------------------------------------------------------------
-- Процедуры для работы с триггерами политик доступа
--------------------------------------------------------------------------------

--
-- Добавляет триггера по policy_table_triggers(схема BARS)
--
procedure add_triggers(p_table_name in varchar2);

--
--  Добавляет триггера по policy_table_triggers
--
procedure add_triggers(p_owner in varchar2, p_table_name in varchar2);

--
--  Добавляет все триггера по policy_table_triggers
--
procedure add_all_triggers;

--
-- Удаляет триггера по policy_table_triggers(схема BARS)
--
procedure remove_triggers(p_table_name in varchar2);

--
-- Удаляет триггера по policy_table_triggers
--
procedure remove_triggers(p_owner in varchar2, p_table_name in varchar2);

--
-- Удаляет триггера по policy_table_triggers
--
procedure remove_all_triggers;

--
-- Модифицирует триггера по policy_table_triggers(схема BARS)
--
procedure alter_triggers(p_table_name in varchar2);

--
-- Модифицирует триггера по policy_table_triggers
--
procedure alter_triggers(p_owner in varchar2, p_table_name in varchar2);

--
-- Модифицирует все триггера по policy_table_triggers
--
procedure alter_all_triggers;

--------------------------------------------------------------------------------

end bars_policy_adm;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_POLICY_ADM wrapped
a000000
ab
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
b
905f 26d0
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
tR0noLpZ
/
 show err;
 
PROMPT *** Create  grants  BARS_POLICY_ADM ***
grant EXECUTE                                                                on BARS_POLICY_ADM to BARSAQ with grant option;
grant EXECUTE                                                                on BARS_POLICY_ADM to BARSAQ_ADM with grant option;
grant EXECUTE                                                                on BARS_POLICY_ADM to BARSDWH_ACCESS_USER;
grant EXECUTE                                                                on BARS_POLICY_ADM to BARS_DM;
grant EXECUTE                                                                on BARS_POLICY_ADM to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_policy_adm.sql =========*** End
 PROMPT ===================================================================================== 
 