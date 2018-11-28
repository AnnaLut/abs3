create or replace package bill_reports
as
/* 
Векселя - отчетность (администрирование) 
created: 08.10.2018 lypskykh
*/

    g_header_version  constant varchar2(64)  := 'version 1.0.0 08/10/2018';

    --
    -- header_version - возвращает версию заголовка пакета
    --
    function header_version return varchar2;

    --
    -- body_version - возвращает версию тела пакета
    --
    function body_version return varchar2;

    --
    -- Создание отчета
    --
    procedure set_report (p_report_id     in out bill_report.report_id%type,     -- внутренний ид отчета (null при создании)
                          p_report_name   in     bill_report.report_name%type,   -- отображаемое имя отчета
                          p_frx_file_name in     bill_report.frx_file_name%type, -- имя файла-шаблона
                          p_description   in     bill_report.description%type);  -- описание отчета

    --
    -- Активация отчета
    --
    procedure enable_report (p_report_id in bill_report.report_id%type);  -- внутренний ид отчета

    --
    -- Деактивация отчета
    --
    procedure disable_report (p_report_id in bill_report.report_id%type); -- внутренний ид отчета

    --
    -- Создание / обновление параметра отчета
    --
    procedure set_report_param (p_param_id   in out bill_report_param.param_id%type,  -- внутренний ид параметра
                                p_report_id  in     bill_report_param.report_id%type, -- внутренний ид отчета
                                p_param_code in     bill_report_param.param_code%type,-- мнемонический код параметра
                                p_param_name in     bill_report_param.param_name%type,-- отображаемое имя параметра
                                p_param_type in     bill_report_param.param_type%type,-- тип параметра (SQL)
                                p_nullable   in     bill_report_param.nullable%type); -- допустимость пустого значения

    --
    -- Удаление параметра отчета
    --
    procedure remove_report_param (p_param_id in bill_report_param.param_id%type); -- внутренний ид параметра

    --
    -- Удаление параметра отчета
    --
    procedure remove_report_param (p_report_id  in bill_report_param.report_id%type,   -- внутренний ид отчета
                                   p_param_code in bill_report_param.param_code%type); -- мнемонический код параметра

    --
    -- Создание / обновление справочного значения параметра отчета
    --
    procedure set_param_value (p_kf       in bill_report_param_value.kf%type,        -- код филиала
                               p_param_id in bill_report_param_value.param_id%type,  -- внутренний ид параметра
                               p_value_id in bill_report_param_value.value_id%type,  -- относительный ид справочного значения
                               p_value    in bill_report_param_value.value%type);    -- справочное значение

    --
    -- Удаление справочного значения параметра отчета
    --
    procedure remove_param_value (p_kf       in bill_report_param_value.kf%type,        -- код филиала
                                  p_param_id in bill_report_param_value.param_id%type,  -- внутренний ид параметра
                                  p_value_id in bill_report_param_value.value_id%type); -- относительный ид справочного значения

end bill_reports;
/
create or replace package body bill_reports
as
    g_body_version      constant varchar2(64) := 'Version 1.0.1 18/10/2018';
    G_TRACE             constant varchar2(20) := 'bill_reports.';

--
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2 is
begin
    return 'Package header '||G_TRACE|| g_header_version;
end header_version;

--
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2 is
begin
    return 'Package body '||G_TRACE|| g_body_version;
end body_version;

--
-- Создание отчета
--
procedure set_report (p_report_id     in out bill_report.report_id%type,     -- внутренний ид отчета (null при создании)
                      p_report_name   in     bill_report.report_name%type,   -- отображаемое имя отчета
                      p_frx_file_name in     bill_report.frx_file_name%type, -- имя файла-шаблона
                      p_description   in     bill_report.description%type)   -- описание отчета
    is
c_action varchar2(150) := 'set_report';
l_params varchar2(256) := 'report_id='||p_report_id||', report_name='||p_report_name||', frx_file_name='||p_frx_file_name;
begin
    if p_report_id is null then
        insert into bill_report (report_id, report_name, frx_file_name, description, active)
        values (s_reports.nextval, p_report_name, p_frx_file_name, p_description, 0)
        returning report_id into p_report_id;
    else
        update bill_report
        set report_name = p_report_name,
            frx_file_name = p_frx_file_name,
            description = p_description
        where report_id = p_report_id;
    end if;
    bill_audit_mgr.log_action(p_action    => c_action,
                              p_key       => null,
                              p_params    => l_params,
                              p_result    => 'Звіт створено/оновлено');
exception
    when others then
        bill_audit_mgr.log_action(p_action    => c_action,
                                  p_key       => null,
                                  p_params    => l_params,
                                  p_result    => 'Помилка створення/оновлення: '||dbms_utility.format_error_stack||chr(10)||dbms_utility.format_error_backtrace);
        raise;
end set_report;

--
-- Активация отчета
--
procedure enable_report (p_report_id in bill_report.report_id%type) -- внутренний ид отчета
    is
c_action varchar2(150) := 'enable_report';
l_params varchar2(256) := 'report_id='||p_report_id;
begin
    update bill_report set active = 1 where report_id = p_report_id;
    bill_audit_mgr.log_action(p_action    => c_action,
                              p_key       => null,
                              p_params    => l_params,
                              p_result    => 'Звіт активовано');
exception
    when others then
        bill_audit_mgr.log_action(p_action    => c_action,
                                  p_key       => null,
                                  p_params    => l_params,
                                  p_result    => 'Помилка активації: '||dbms_utility.format_error_stack||chr(10)||dbms_utility.format_error_backtrace);
        raise;
end enable_report;

--
-- Деактивация отчета
--
procedure disable_report (p_report_id in bill_report.report_id%type) -- внутренний ид отчета
    is
c_action varchar2(150) := 'disable_report';
l_params varchar2(256) := 'report_id='||p_report_id;
begin
    update bill_report set active = 0 where report_id = p_report_id;
    bill_audit_mgr.log_action(p_action    => c_action,
                              p_key       => null,
                              p_params    => l_params,
                              p_result    => 'Звіт деактивовано');
exception
    when others then
        bill_audit_mgr.log_action(p_action    => c_action,
                                  p_key       => null,
                                  p_params    => l_params,
                                  p_result    => 'Помилка деактивації: '||dbms_utility.format_error_stack||chr(10)||dbms_utility.format_error_backtrace);
        raise;
end disable_report;

--
-- Создание / обновление параметра отчета
--
procedure set_report_param (p_param_id   in out bill_report_param.param_id%type,  -- внутренний ид параметра
                            p_report_id  in     bill_report_param.report_id%type, -- внутренний ид отчета
                            p_param_code in     bill_report_param.param_code%type,-- мнемонический код параметра
                            p_param_name in     bill_report_param.param_name%type,-- отображаемое имя параметра
                            p_param_type in     bill_report_param.param_type%type,-- тип параметра (SQL)
                            p_nullable   in     bill_report_param.nullable%type)  -- допустимость пустого значения
    is
c_action varchar2(150) := 'set_report_param';
l_params varchar2(256) := 'param_id='||p_param_id||', report_id='||p_report_id||', param_code='||p_param_code
                           ||', param_name='||p_param_name||', param_type='||p_param_type||', nullable='||p_nullable;
begin
    update bill_report_param
    set report_id = p_report_id,
        param_code = p_param_code,
        param_name = p_param_name,
        param_type = p_param_type,
        nullable = p_nullable
    where param_id = p_param_id;
    if sql%rowcount = 0 then
        insert into bill_report_param 
        (param_id, report_id, param_code, param_name, param_type, nullable)
        values
        (s_report_params.nextval, p_report_id, p_param_code, p_param_name, p_param_type, p_nullable)
        returning param_id into p_param_id;
    end if;
    bill_audit_mgr.log_action(p_action    => c_action,
                              p_key       => null,
                              p_params    => l_params,
                              p_result    => 'Параметр створено/оновлено');
exception
    when others then
        bill_audit_mgr.log_action(p_action    => c_action,
                                  p_key       => null,
                                  p_params    => l_params,
                                  p_result    => 'Помилка створення/оновлення: '||dbms_utility.format_error_stack||chr(10)||dbms_utility.format_error_backtrace);
        raise;
end set_report_param;

--
-- Удаление параметра отчета
--
procedure remove_report_param (p_param_id in bill_report_param.param_id%type) -- внутренний ид параметра
    is
c_action varchar2(150) := 'remove_report_param';
l_params varchar2(256) := 'param_id='||p_param_id;
begin
    -- удаляем справочные значения для параметра (~ delete cascade)
    for paramval in (select kf, param_id, value_id from bill_report_param_value where param_id = p_param_id)
    loop
        remove_param_value(p_kf       => paramval.kf,
                           p_param_id => paramval.param_id,
                           p_value_id => paramval.value_id);
    end loop;
    -- удаляем сам параметр
    delete from bill_report_param
    where param_id = p_param_id;
    bill_audit_mgr.log_action(p_action    => c_action,
                              p_key       => null,
                              p_params    => l_params,
                              p_result    => 'Параметр звіту видалено');
exception
    when others then
        bill_audit_mgr.log_action(p_action    => c_action,
                                  p_key       => null,
                                  p_params    => l_params,
                                  p_result    => 'Помилка видалення: '||dbms_utility.format_error_stack||chr(10)||dbms_utility.format_error_backtrace);
        raise;
end remove_report_param;

--
-- Удаление параметра отчета
--
procedure remove_report_param (p_report_id  in bill_report_param.report_id%type,   -- внутренний ид отчета
                               p_param_code in bill_report_param.param_code%type)  -- мнемонический код параметра
    is
l_param_id bill_report_param.param_id%type;
begin
    select param_id into l_param_id from bill_report_param where report_id = p_report_id and param_code = p_param_code;
    remove_report_param(l_param_id);
exception
    when no_data_found then
        raise_application_error(-20000, 'Параметра '||p_param_code||' звіту '||p_report_id||' не знайдено');
end remove_report_param;

--
-- Создание / обновление справочного значения параметра отчета
--
procedure set_param_value (p_kf       in bill_report_param_value.kf%type,        -- код филиала
                           p_param_id in bill_report_param_value.param_id%type,  -- внутренний ид параметра
                           p_value_id in bill_report_param_value.value_id%type,  -- относительный ид справочного значения
                           p_value    in bill_report_param_value.value%type)     -- справочное значение
    is
c_action varchar2(150) := 'set_param_value';
l_params varchar2(256) := 'kf='||p_kf||', param_id='||p_param_id||', value_id='||p_value_id||', value='||p_value;
l_new_value_id bill_report_param_value.value_id%type;
begin
    update bill_report_param_value
    set value = p_value
    where kf = p_kf
    and   param_id = p_param_id
    and   value_id = p_value_id;
    if sql%rowcount = 0 then
        if p_value_id is null then
            select nvl(max(value_id), 0)+1 into l_new_value_id from bill_report_param_value where kf = p_kf and param_id = p_param_id;
        end if;
        insert into bill_report_param_value (kf, param_id, value_id, value)
        values (p_kf, p_param_id, l_new_value_id, p_value);
    end if;
    bill_audit_mgr.log_action(p_action    => c_action,
                              p_key       => null,
                              p_params    => l_params,
                              p_result    => 'Довідникове значення параметра створено/оновлено');
exception
    when others then
        bill_audit_mgr.log_action(p_action    => c_action,
                                  p_key       => null,
                                  p_params    => l_params,
                                  p_result    => 'Помилка створення/оновлення: '||dbms_utility.format_error_stack||chr(10)||dbms_utility.format_error_backtrace);
        raise;
end set_param_value;

--
-- Удаление справочного значения параметра отчета
--
procedure remove_param_value (p_kf       in bill_report_param_value.kf%type,        -- код филиала
                              p_param_id in bill_report_param_value.param_id%type,  -- внутренний ид параметра
                              p_value_id in bill_report_param_value.value_id%type)  -- относительный ид справочного значения
    is
c_action varchar2(150) := 'remove_param_value';
l_params varchar2(256) := 'kf='||p_kf||', param_id='||p_param_id||', value_id='||p_value_id;
l_value bill_report_param_value.value%type;
begin
    delete from bill_report_param_value 
    where kf = p_kf 
    and param_id = p_param_id 
    and value_id = p_value_id
    returning value into l_value;
    bill_audit_mgr.log_action(p_action    => c_action,
                              p_key       => null,
                              p_params    => l_params,
                              p_result    => 'Довідникове значення параметра видалено, попереднє значення: ['||l_value||']');
exception
    when others then
        bill_audit_mgr.log_action(p_action    => c_action,
                                  p_key       => null,
                                  p_params    => l_params,
                                  p_result    => 'Помилка видалення: '||dbms_utility.format_error_stack||chr(10)||dbms_utility.format_error_backtrace);
        raise;
end remove_param_value;

begin
    null;
end bill_reports;
/
show errors;
grant execute on bill_reports to bars_access_defrole;