

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_PRIOCOM_RESTRICT_ACCESS.sql ====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_PRIOCOM_RESTRICT_ACCESS ***

  CREATE OR REPLACE PROCEDURE BARS.P_PRIOCOM_RESTRICT_ACCESS (object_schema varchar2,object_name varchar2,policy_name varchar2) is
/**
 * Процедура для обмеження доступу за відповідною політикою FGA
 */
 l_msg   varchar2(256);
begin
  l_msg := 'Користувач запитує конфіденційну інформацію. Заборонено.';
  priocom_audit.error(l_msg||chr(10)||sys_context('userenv','current_sql'));
  raise_application_error(-20001,l_msg,TRUE);
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_PRIOCOM_RESTRICT_ACCESS.sql ====
PROMPT ===================================================================================== 
