CREATE OR REPLACE FUNCTION BARS.swi_get_acc (p_nbs varchar2, p_nbs_alt varchar2 default null) return varchar2
is
  l_nls  accounts.nls%type;
  l_ob22 accounts.ob22%type;
  l_date_tran date default sysdate;
  l_nbs  accounts.nbs%type;

  l_6110 accounts.nbs%type := '6510' ;
  l_7109 accounts.nbs%type := '7509' ;

/*
  -- 22.11.2017 Трансфер-2017 7109.02 ===> 7509.02	за операціями з клієнтами
                              6110.xx ===> 6510.xx
*/



begin    If NVL(newnbs.g_state,0)  = 1 then null;  Else l_6110 := '6110';  l_7109 := '7109';  end if; 

  l_nbs := p_nbs;
  if p_nbs_alt is not null then
  begin
      -- если пришла дата DATT, подставляем альтернативный счет
      begin select to_date (w.value, 'DD/MM/YYYY' ) into l_date_tran from operw w where w.ref = gl.aRef and w.tag  = 'DATT';
      exception when others then l_date_tran := trunc(sysdate);
      end;
      if l_date_tran != trunc(sysdate)  then    l_nbs := p_nbs_alt;    end if;
  end;
  end if;
  -------------------------------------------------------------------
  barsweb_session.set_session_id(sys_context('bars_global','session_id'));
  case (l_nbs)
        when '2909' then l_ob22 :=  barsweb_session.get_varchar2('swi_ob22_2909');
        when '2809' then l_ob22 :=  barsweb_session.get_varchar2('swi_ob22_2809');
        when l_6110 then l_ob22 :=  barsweb_session.get_varchar2('swi_ob22_kom');
        when l_7109 then l_ob22 := '02';
  end case;

  -- не нашли в сесии информации об ОБ22, берем умолчательные значения
  if l_ob22 is null then
      case (l_nbs)
        when '2909' then l_ob22 := '64';
        when '2809' then l_ob22 := '27';
        when l_6110 then l_ob22 := 'B3';
        when l_7109 then l_ob22 := '02';
      end case;
  end if;

  l_nls := nbs_ob22 (l_nbs, l_ob22);

  return l_nls;
end;
/