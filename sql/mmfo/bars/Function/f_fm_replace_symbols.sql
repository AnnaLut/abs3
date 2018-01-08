prompt function f_fm_replace_symbols
create or replace function f_fm_replace_symbols(p_string in varchar2)
return varchar2
is
p_out_string varchar2(4000);
/* v. 1.0.0 17.05.2017
��� ������� RUHA/RUHC
��������� ������ �� ������������ ��� �������� � ���� � �������� ������������ ������� �� ������, ������� ������� - ���������� (" => "")
*/
begin
  select replace(regexp_replace(p_string, '[^][A-Za-z�-��-�0-9\\''!"#$%&()*+,./:;<=>?@^_`{|}���������������������-]', ' '), '"', '""""')
  into p_out_string
  from dual;
  return p_out_string;
end;
/
GRANT EXECUTE ON BARS.f_fm_replace_symbols TO BARS_ACCESS_DEFROLE;
GRANT EXECUTE ON BARS.f_fm_replace_symbols TO FINMON;
GRANT EXECUTE ON BARS.f_fm_replace_symbols TO START1;