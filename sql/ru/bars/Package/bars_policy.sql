
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_policy.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_POLICY as
/*
  BARS_POLICY - пакет содержащий перечень политик для разграничения прав к DML операциям
                в условиях хранения в одной схеме множества балансов и наличия 3 уровней
                стурктурных подразделений банка
*/

g_header_version  constant varchar2(64)  := 'version 2.8 10/12/2008';

g_awk_header_defs constant varchar2(512) := ''

  ||'общая схема'||chr(10)
;

--
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2;

--
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2;

--
--  Реализация политики доступа по коду группы политик
--
function set_group_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  Реализация политики доступа к подразделению (подразделение + подчитенные
--  подразделения)
--
function set_branch_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  Реализация политики доступа к подразделению (только свое подразделение)
--
function set_equal_branch_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  Реализация политики разделения балансов (по МФО, по полю KF)
--
function set_mfo_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  Реализация политики разделения балансов по коду филиала(МФО)
--
function set_filial_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  Реализация политики по доступа 2-х подразделений к одной сущности
--  (подразделение + подчитенные подразделения)
--
function set_dual_branch_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  Реализация политики отсутствия доступа
--
function set_no_access_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  Устанавливает политику, выбрасывающую ошибку доступа
--
function set_error_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  Ф-ция выбрасывает ошибку: Модификация объекта "BARS.TABLE_NAME" запрещена в группе политик "FILIAL/WHOLE"
--
function raise_error(p_schema in varchar2, p_name in varchar2)
return number;

--
--  Реализация политики доступа только головного подразделения
--
function set_center_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  Реализация политики доступа только к даным подчиненных подразделений
--
function set_subling_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  Реализация политики доступа только к даным головного подразделения и его дочерних
--  подразделений
--
function set_parent_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  Реализация политики по удаленным записям (логическое удаление)
--
function set_deleted_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  Реализация политики доступа к целому региону по полю branch
--
function set_region_branch_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  Реализация политики доступа к целому региону по полю kf
--
function set_region_mfo_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

end bars_policy;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_POLICY 
is
/*
  BARS_POLICY - пакет содержащий перечень политик для разграничения прав к DML операциям
                в условиях хранения в одной схеме множества балансов и наличия 3 уровней
                стурктурных подразделений банка
*/

g_body_version  constant varchar2(64)  := 'version 2.9 03/02/2009';

g_awk_body_defs constant varchar2(512) := ''

  ||'общая схема'||chr(10)
;


--
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2 is
begin
  return 'Package header BARS_POLICY '||g_header_version||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||g_awk_header_defs;
end header_version;

--
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2 is
begin
  return 'Package body BARS_POLICY '||g_body_version||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||g_awk_body_defs;
end body_version;

--
--  Реализация политики доступа по коду группы политик
--
function set_group_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'policy_group = sys_context(''bars_context'',''policy_group'')';
end;


--
--  Реализация политики доступа по подразделению (подразделение + подчитенные
--  подразделения)
--
function set_branch_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'branch like sys_context(''bars_context'',''user_branch_mask'')';
end;

--
--  Реализация политики доступа к подразделению (только свое подразделение)
--
function set_equal_branch_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'branch = sys_context(''bars_context'',''user_branch'')';
end;


--
--  Реализация политики разделения балансов по коду филиала(МФО)
--
function set_filial_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'branch like sys_context(''bars_context'',''user_mfo_mask'')';
end;

--
--  Реализация политики разделения балансов (по МФО, по полю KF)
--
function set_mfo_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'kf = sys_context(''bars_context'',''user_mfo'')';
end;

--
--  Реализация политики по доступа 2-х подразделений к одной сущности
--  (подразделение + подчитенные подразделения)
--
function set_dual_branch_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'branch_a like sys_context(''bars_context'',''user_branch_mask'')'
   ||' or branch_b like sys_context(''bars_context'',''user_branch_mask'')';
end;

--
--  Реализация политики отсутствия доступа
--
function set_no_access_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return '1=0';
end;

--
--  Устанавливает политику, выбрасывающую ошибку доступа
--
function set_error_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'bars_policy.raise_error('''||p_schema||''', '''||p_name||''')=1';
end;

--
--  Ф-ция выбрасывает ошибку: Модификация объекта "BARS.TABLE_NAME" запрещена в группе политик "FILIAL/WHOLE"
--
function raise_error(p_schema in varchar2, p_name in varchar2)
return number is
begin
  bars_error.raise_nerror('BRS', 'MODIFICATION_DISABLED', p_schema||'.'||p_name);
  return 0;
end raise_error;

--
--  Реализация политики доступа только головного подразделения
--
function set_center_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'sys_context(''bars_context'',''params_mfo'')=sys_context(''bars_context'',''glb_mfo'')';
end;

--
--  Реализация политики доступа только к даным подчиненных подразделений
--
function set_subling_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'branch <> sys_context(''bars_context'',''user_branch'') AND branch like sys_context(''bars_context'',''user_branch_mask'')';
end;

--
--  Реализация политики доступа только к даным головного подразделения и его дочерних
--  подразделений
--
function set_parent_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'sys_context(''bars_context'',''user_branch'') like branch || ''%''';
end;
--
--  Реализация политики по удаленным записям (логическое удаление)
--
function set_deleted_policy(p_schema in varchar2, p_name in varchar2) return varchar2
is
begin
    return 'deleted is null';
end set_deleted_policy;

--
--  Реализация политики доступа к целому региону по полю branch
--
function set_region_branch_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
    return 'substr(branch,2,6) in ('
                ||' select sys_context(''bars_context'',''user_mfo'') from dual'
                ||' union all'
                ||' select mfo from banks where mfop=sys_context(''bars_context'',''user_mfo'')'
                ||' )';
end;

--
--  Реализация политики доступа к целому региону по полю kf
--
function set_region_mfo_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
    return 'kf in ('
                ||' select sys_context(''bars_context'',''user_mfo'') from dual'
                ||' union all'
                ||' select mfo from banks where mfop=sys_context(''bars_context'',''user_mfo'')'
                ||' )';
end;

end bars_policy;
/
 show err;
 
PROMPT *** Create  grants  BARS_POLICY ***
grant EXECUTE                                                                on BARS_POLICY     to ABS_ADMIN;
grant EXECUTE                                                                on BARS_POLICY     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_POLICY     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_policy.sql =========*** End ***
 PROMPT ===================================================================================== 
 