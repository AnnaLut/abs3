
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/swi_get_acc.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SWI_GET_ACC (p_nbs varchar2, p_nbs_alt varchar2 default null) return varchar2
is
  l_nls  accounts.nls%type;
  l_ob22 accounts.ob22%type;
  l_date_tran date default sysdate;
  l_nbs accounts.nbs%type;
begin
  l_nbs := p_nbs;

  if p_nbs_alt is not null then
  begin
      -- если пришла дата DATT, подставляем альтернативный счет
      begin
           select to_date (w.value, 'DD/MM/YYYY' ) into l_date_tran from operw w where w.ref = gl.aRef and w.tag  = 'DATT';
      exception when others then l_date_tran := trunc(sysdate);
      end;
      if l_date_tran != trunc(sysdate)  then
             l_nbs := p_nbs_alt;
      end if;
  end;
  end if;
  -------------------------------------------------------------------
  barsweb_session.set_session_id(sys_context('bars_global','session_id'));
  case (l_nbs)
        when '2909' then l_ob22 :=  barsweb_session.get_varchar2('swi_ob22_2909');
        when '2809' then l_ob22 :=  barsweb_session.get_varchar2('swi_ob22_2809');
        when '6110' then l_ob22 :=  barsweb_session.get_varchar2('swi_ob22_kom');
        when '7109' then l_ob22 := '02';
  end case;

  -- не нашли в сесии информации об ОБ22, берем умолчательные значения
  if l_ob22 is null then
      case (l_nbs)
        when '2909' then l_ob22 := '64';
        when '2809' then l_ob22 := '27';
        when '6110' then l_ob22 := 'B3';
        when '7109' then l_ob22 := '02';
      end case;
  end if;

  l_nls := nbs_ob22 (l_nbs, l_ob22);

  return l_nls;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/swi_get_acc.sql =========*** End **
 PROMPT ===================================================================================== 
 