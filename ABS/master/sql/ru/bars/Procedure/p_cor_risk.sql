

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_COR_RISK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_COR_RISK ***

  CREATE OR REPLACE PROCEDURE BARS.P_COR_RISK (
    p_par       number, -- 1 - update, 2 - delete
    p_rnk       number,
    p_chgdate   date,
    p_idupd     number,
    p_value     varchar2)
is
    max_idupd_  number;
    dt_on_      date;
    max_dt_     date;
    chgdate_    date;
    value_      varchar2(500);
begin
  select max(idupd)
    into max_idupd_
    from customerw_update
   where rnk = p_rnk
     and tag = 'RIZIK';

  select max(chgdate)
    into max_dt_
    from customerw_update
   where rnk = p_rnk
     and tag = 'RIZIK';

  select date_on
    into dt_on_
    from customer
   where rnk = p_rnk;

  if p_par in (1,2) and max_idupd_ = p_idupd then
     bars_error.RAISE_NERROR('FMN', 'FM_PARAM_NOT_EDIT');
  end if;

  if p_chgdate is null then
     bars_error.RAISE_NERROR('FMN', 'FM_PARAM_NOT_FILLED_DT');
  end if;

  if p_chgdate is not null and (trunc(p_chgdate) < dt_on_ or trunc(p_chgdate) > trunc(max_dt_) or trunc(p_chgdate) > to_date('01.01.2012','dd.mm.yyyy')) then
     bars_error.RAISE_NERROR('FMN', 'FM_PARAM_INCORREC_DATE');
  end if;

  select chgdate, value
    into chgdate_, value_
    from customerw_update
   where idupd = p_idupd;

  if p_par = 1 then
    begin
      CASE
        WHEN chgdate_ <> p_chgdate AND value_ <> p_value THEN
          update customerw_update set value = p_value, chgdate = p_chgdate where rnk = p_rnk and tag = 'RIZIK' and idupd = p_idupd;
          logger.info('FMN: Выполнено изменение истории уровня риска по клиенту rnk='||p_rnk||'. Изменено '||to_char(chgdate_,'dd.mm.yyyy hh24:mi:ss')||' => '||to_char(p_chgdate,'dd.mm.yyyy hh24:mi:ss')||', '||value_ ||' => '|| p_value);
        WHEN chgdate_ <> p_chgdate THEN
          update customerw_update set chgdate = p_chgdate where rnk = p_rnk and tag = 'RIZIK' and idupd = p_idupd;
          logger.info('FMN: Выполнено изменение истории уровня риска по клиенту rnk='||p_rnk||'. Изменено '||to_char(chgdate_,'dd.mm.yyyy hh24:mi:ss')||' => '||to_char(p_chgdate,'dd.mm.yyyy hh24:mi:ss'));
        WHEN value_ <> p_value THEN
          update customerw_update set value = p_value where rnk = p_rnk and tag = 'RIZIK' and idupd = p_idupd;
          logger.info('FMN: Выполнено изменение истории уровня риска по клиенту rnk='||p_rnk||'. Изменено '||value_ ||' => '|| p_value);
      END CASE;
    end;
  elsif p_par = 2 then
    begin
      delete from customerw_update where idupd = p_idupd;
      logger.info('FMN: Выполнено изменение истории уровня риска по клиенту rnk='||p_rnk||'. Удалено значение id_upd='||p_idupd||', уровень риска = '||value_ ||', дата='||to_char(chgdate_,'dd.mm.yyyy hh24:mi:ss'));
    end;
  end if;
end;
/
show err;

PROMPT *** Create  grants  P_COR_RISK ***
grant EXECUTE                                                                on P_COR_RISK      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_COR_RISK      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_COR_RISK.sql =========*** End **
PROMPT ===================================================================================== 
