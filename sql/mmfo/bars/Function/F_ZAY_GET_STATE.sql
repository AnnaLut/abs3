CREATE OR REPLACE function BARS.f_zay_get_state (p_sos number,
                                           p_viza number,p_priority number) return varchar2
is
 v_priority varchar2(10);
begin
 v_priority:=0;
 
 
 case
   when v_priority=1 then v_priority:='ZAY3';
   else v_priority:='�����';
 end case;
 case
   when p_sos=0 then  case
                      when p_viza=0  then return '�������� ���������';
                      when p_viza=1  then return '��������� ZAY21.����� '||v_priority ;
                      when p_viza=2  then return '��������� ZAY3.����� �����';
                      when p_viza=-1 then return '����� � ���';
                      else return '';
                      end case;
   when p_sos=0.5 then return '�������.������ ���������';
   when p_sos=1   then return '�������.������ �������';
   when p_sos=2   then return '��������';
   when p_sos=-1  then return '��������';
   else return '';
 end case;
end;
/