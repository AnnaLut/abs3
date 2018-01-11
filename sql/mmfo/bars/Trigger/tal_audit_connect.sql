

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAL_AUDIT_CONNECT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAL_AUDIT_CONNECT ***

  CREATE OR REPLACE TRIGGER BARS.TAL_AUDIT_CONNECT 
after logon on database
/*
  ������� �������� ������ ��������� ������ ��� ������ ����������, 
  �� ����� proxy-������������. 
  ���������� ��������� ��������������� � ������� ���������� ������.
  ����� ������� ������������� ���������� � ��. 
  ������� ������ �-�� AUDIT SESSION �� ��������, 
  �.�. ���������� ����� ����� ���������� ����� proxy-������������ ��� ������ �� WEB.   
*/
begin
  if sys_context ('userenv', 'proxy_user') is null and ora_login_user<>'APPSERVER' then
  	 audit_me;
  end if;  
end; 




/
ALTER TRIGGER BARS.TAL_AUDIT_CONNECT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAL_AUDIT_CONNECT.sql =========*** E
PROMPT ===================================================================================== 
