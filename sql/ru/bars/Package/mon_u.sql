
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/mon_u.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.MON_U as

-- �������� ��� �������� � ����� ��
-- ������ ��������� ������ MONITOR_USER (�������������� �� ���������ײ�)
-- ���� ���������� � ���� ����� ����� ��������� � �������� �.�.

PROCEDURE TO_LOG (p_reg int, p_lev char default 'TRACE',
                       p_modul char default '', p_stroka char);

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.MON_U IS

-- �������� ��� �������� � ����� ��

-------------------------------------------------------
PROCEDURE TO_LOG (p_reg int, p_lev char default 'TRACE',
                  p_modul char default '', p_stroka char) IS
pragma autonomous_transaction;
begin
if p_reg =1 or p_lev='ERROR' then
logger.error(substr(p_stroka,1,100));
else
NULL;
end if;
end;
---------------------------------
procedure MON_INI (p_date date) is
begin
--- User Monitoring
logger.trace('MON_U: ���������������� � ������ ����������� MONITOR_USER_LOG '
             ||'- �� ��������������');
NULL;
end;

BEGIN /* �������� ���� */
MON_INI(bankdate);
END MON_U;
/
 show err;
 
PROMPT *** Create  grants  MON_U ***
grant EXECUTE                                                                on MON_U           to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/mon_u.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 