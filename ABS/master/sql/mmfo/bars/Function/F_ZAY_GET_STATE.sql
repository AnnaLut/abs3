CREATE OR REPLACE function BARS.f_zay_get_state (p_sos number,
                                           p_viza number,p_priority number) return varchar2
is
 v_priority varchar2(10);
begin
 v_priority:=0;
 
 
 case
   when v_priority=1 then v_priority:='ZAY3';
   else v_priority:='ділера';
 end case;
 case
   when p_sos=0 then  case
                      when p_viza=0  then return 'Створена НЕвізована';
                      when p_viza=1  then return 'Завізована ZAY21.Очікує '||v_priority ;
                      when p_viza=2  then return 'Завізована ZAY3.Очікує ділера';
                      when p_viza=-1 then return 'Знята з візи';
                      else return '';
                      end case;
   when p_sos=0.5 then return 'Задовол.ділером НЕвізована';
   when p_sos=1   then return 'Задовол.ділером візована';
   when p_sos=2   then return 'Сплачена';
   when p_sos=-1  then return 'Видалена';
   else return '';
 end case;
end;
/