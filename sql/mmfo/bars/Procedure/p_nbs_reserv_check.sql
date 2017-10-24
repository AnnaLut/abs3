

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_NBS_RESERV_CHECK.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_NBS_RESERV_CHECK ***

  CREATE OR REPLACE PROCEDURE BARS.P_NBS_RESERV_CHECK (
  p_acc in  accounts.acc%type,
  p_nbs in  ps.nbs%type,
  p_rez out integer,  -- 0 - помилка; 1 - відкривати/редагувати; 2 - резервувати/переглядати
  p_msg out varchar2
) is
  l_flag     integer;
  l_nbs      ps.nbs%type;
  l_cnt_nbs  integer;
  l_user_id  staff$base.id%type;
  l_cnt_f    integer;
  l_cnt_b    integer;
begin
  begin
    select to_number(GET_GLOBAL_PARAM('ACC_REZ')) into l_flag from dual;
  exception when others then
    l_flag := 0;
  end;
  if l_flag = 0 then
    p_rez := 1;
    p_msg := '';
    return;
  end if;

  if p_acc > 0 then
    begin
	  select nbs into l_nbs from accounts where acc = p_acc;
	exception when no_data_found then
	  select substr(nls, 1, 4) into l_nbs from accounts where acc = p_acc;
	end;
  else
    l_nbs := p_nbs;
  end if;

  select count(nbs) into l_cnt_nbs from nbs_front_office where nbs = l_nbs;
  if l_cnt_nbs = 0 then -- рахунок що аналізується не входить в перелік
    p_rez := 1;
    p_msg := '';
  else
    l_user_id := user_id;
    select count(*)
      into l_cnt_f -- належить до фронт-офісу: 1 - так/ 0 - ні
      from groups_staff
     where idu = l_user_id
       and idg = 1026
       and nvl(approve, 0) = 1
       and date_is_valid(adate1, adate2, rdate1, rdate2) = 1;
    select count(*)
      into l_cnt_b -- належить до бек-офісу: 1 - так/ 0 - ні
      from groups_staff
     where idu = l_user_id
       and idg = 1025
       and nvl(approve, 0) = 1
       and date_is_valid(adate1, adate2, rdate1, rdate2) = 1;

    case
      when l_cnt_f = 0 and l_cnt_b = 0 then
        p_rez := 0;
        p_msg := 'Помилка: користувача не належить до жодної з груп (Фронт-офіс, Бек-офіс).';
      when l_cnt_f = 1 and l_cnt_b = 1 then
        p_rez := 0;
        p_msg := 'Помилка: користувача належить до обох груп (Фронт-офіс, Бек-офіс).';
      when l_cnt_f = 0 and l_cnt_b = 1 then
        p_rez := 1;
        p_msg := '';
      when l_cnt_f = 1 and l_cnt_b = 0 then
        p_rez := 2;
        p_msg := '';
      else
        p_rez := 0;
        p_msg := 'Невизначення помилка, зверніться до розробника.';
    end case;

  end if;
end p_nbs_reserv_check;
/
show err;

PROMPT *** Create  grants  P_NBS_RESERV_CHECK ***
grant EXECUTE                                                                on P_NBS_RESERV_CHECK to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_NBS_RESERV_CHECK.sql =========**
PROMPT ===================================================================================== 
