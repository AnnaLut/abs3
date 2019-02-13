

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FM_SET_STATUS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FM_SET_STATUS ***

  CREATE OR REPLACE PROCEDURE BARS.P_FM_SET_STATUS (
  p_ref       number,
  p_rec       number,
  p_status    varchar2,
  p_comments  varchar2,
  p_blk       number )
is
  l_status varchar2(100);
  l_id number;
  l_opr_vid1 finmon_que.opr_vid1%type;
begin

  begin
     case 
       when p_ref is null then 
         select q.status into l_status
           from finmon_que q
          where q.rec = p_rec;
       else
         select q.status into l_status
           from finmon_que q
          where q.ref = p_ref;
      end case;          
  exception when no_data_found then
     l_status := null;
  end;

  -- дію «Повідомити» дозволяти лише для документів зі статусом
  --   «Очікує», «Вилучена» або без встановленого статусу.
  if p_status = 'I' and l_status is not null and l_status not in ('S', 'B') then
     -- ФИНАНСОВЫЙ МОНИТОРИНГ: Запрещено изменение статуса с %s на %s для документа %s
     bars_error.raise_nerror('DOC', 'FM_ERROR_STATUS', l_status, p_status, nvl(p_ref,p_rec));
  end if;

  --автоматическое определение opr_vid1, если операция поступает через "Сообщить" от операциониста
  if p_status = 'I' and l_status is null then
     select '99999999999999' || case when t.mfoa = f_ourmfo then '9' else '8' end
     into l_opr_vid1 
     from oper t 
     where t.ref = p_ref;
     select bars_sqnc.get_nextval('s_finmon_que') into l_id from dual;
     insert into finmon_que (id, ref, rec, status, agent_id, comments, opr_vid1)
     values (l_id, p_ref, p_rec, p_status, user_id, p_comments, l_opr_vid1);
     return;
  end if;

  if l_status is null then
     select bars_sqnc.get_nextval('s_finmon_que') into l_id from dual;
     insert into finmon_que (id, ref, rec, status, agent_id, comments)
     values (l_id, p_ref, p_rec, p_status, user_id, p_comments);
  else
    case
      when p_ref is null then
           update finmon_que q
              set q.status = p_status,
                  q.comments = p_comments
            where q.rec = p_rec;
      else
           update finmon_que q
              set q.status = p_status,
                  q.comments = p_comments
            where q.ref = p_ref;
      end case;
  end if;

  -- если устанавливается статус N (к отправке) - меняем код блокировки
  if p_rec is not null and p_blk = 131313 and p_status = 'N' then
     update arc_rrp set blk = 131312 where rec = p_rec;
  end if;

end p_fm_set_status;
/
show err;

PROMPT *** Create  grants  P_FM_SET_STATUS ***
grant EXECUTE                                                                on P_FM_SET_STATUS to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FM_SET_STATUS to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FM_SET_STATUS.sql =========*** E
PROMPT ===================================================================================== 
