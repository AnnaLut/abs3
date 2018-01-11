
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_date_run.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_DATE_RUN (p_date in date default gl.bd,
                                       p_last_day in number, -- 1=��������� ������� ����
                                       p_day in varchar2 ) --���������� ���� (��� ��������� ������� �� ���)
return number
----�������� !!! ������� DAT_NEXT_U ������ ��������� ���� ��� �������, ����� ����
is
l_to_do    number(1):=0;  --1-���������/0-������ �� ������
l_day date;
begin
  if p_last_day = 1 then --������� ���������� �������� ���
      if to_number(to_char(p_date,'DD'))  > to_number(to_char(DAT_NEXT_U(p_date,1),'DD')) --���������� ���� � ��������� ������� � ������ �������
         and trunc(p_date,'DD') = trunc(DAT_NEXT_U(p_date,0),'DD') --���������� ���� - ��� ������� ����
      then l_to_do:= 1;
      else l_to_do:= 0;
      end if;
  else --���������� ���� (��� ��������� ������� �� ���)
     l_day := to_date(p_day||'.'||to_char (p_date,'mm.yyyy'),'dd.mm.yyyy');
      if trunc(p_date,'DD') = trunc(DAT_NEXT_U(l_day,0),'DD') --���������� ���� - ��� ������� ����
      then l_to_do:= 1;
      else l_to_do:= 0;
      end if;
  end if;
  return l_to_do;
end;
/
 show err;
 
PROMPT *** Create  grants  F_DATE_RUN ***
grant EXECUTE                                                                on F_DATE_RUN      to ABS_ADMIN;
grant EXECUTE                                                                on F_DATE_RUN      to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_date_run.sql =========*** End ***
 PROMPT ===================================================================================== 
 