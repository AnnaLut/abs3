PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/package/mbm_sallary.sql =========*** Run *** 
PROMPT ===================================================================================== 

create or replace package bars.mbm_sallary is
  g_head_version  constant varchar2(64)  := 'version 1.0 20.09.2018';

  --
  -- определение версии заголовка пакета
  --
  function header_version return varchar2;
  --
  -- определение версии тела пакета
  --
  function body_version   return varchar2;

   -- імпорт ЗП відомостей із XML файла
   procedure create_payrolls(p_in_file in clob, p_out_file out clob);

end;
/

create or replace package body bars.mbm_sallary
is

g_body_version   constant varchar2(64)   := 'version 1.0 20.09.2018';

g_modcode        constant varchar2(3)   := 'CL';
g_pkg_name       constant varchar2(30)   := 'MBM_SALLARY';

  -- Версія заголовка пакета
  function header_version return varchar2 is
  begin
    return 'Package header: '||g_head_version;
  end header_version;
  --
  -- Версія тіла пекета
  --
  function body_version return varchar2 is
  begin
    return 'Package body  : '||g_body_version;
  end body_version;

  -- імпорт ЗП відомостей із XML файла
  procedure create_payrolls(p_in_file in clob, p_out_file out clob)
    is
    l_act varchar2(15 char) := 'CREATE_PAYROLLS';
  begin
    bars_audit.info (g_modcode || '.' || g_pkg_name || '.' || l_act || ' start');

    -- імпорт ЗП відомостей із XML файла (api zp)
    bars.zp_corp2_intg.set_payrolls(p_clob_data => p_in_file,
                                    p_clob_out  => p_out_file,
                                    p_source    => 6); -- ознака що відомість надійшла із CorpLite

    bars_audit.info (g_modcode || '.' || g_pkg_name || '.' || l_act || ' finish');
  exception
    when others then
      bars_error.raise_nerror (
        g_modcode,
        g_pkg_name
        || l_act
        || '. ERORR - '
        || dbms_utility.format_error_stack ()
        || chr (10)
        || dbms_utility.format_error_backtrace ());
  end create_payrolls;

begin
  null;
end mbm_sallary;
/

show err;

grant execute on bars.mbm_sallary to  bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/package/mbm_sallary.sql =========*** End *** 
PROMPT ===================================================================================== 
