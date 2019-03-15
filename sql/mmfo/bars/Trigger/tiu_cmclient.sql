
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/trigger/tiu_cmclient.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TRIGGER BARS.TIU_CMCLIENT 
instead of update ON BARS.CM_CLIENT for each row
declare 
l_add integer;
begin
   if :new.oper_status not in (2,3,10) then
      raise_application_error (-20000, 'Недопустимый статус операции ' || :new.oper_status);
   end if;
   update cm_client_que
      set datemod     = :new.datemod,
          oper_status = :new.oper_status,
          resp_txt    = :new.resp_txt
    where id = :new.id;

   select count(*) into l_check
     from cm_client_que q
    INNER JOIN accounts a
       on a.acc = q.acc
    inner join w4_card_ADD ad
       on ad.card_code = q.card_type
    where q.id = :new.id;

  if  l_check != 0 then
   if :new.oper_status = 3 then
   -- відкриття дод. Кр.картки, ящо це дозволено     зміна статусу 99>1 w4_card_add
      bars_ow.add_deal_to_cmque_dk(
            p_datemod  =>:new.datemod,
            p_resp_txt =>:new.resp_txt,
            p_reqid    =>:new.id
          ); 
   -------------------
      delete from cm_client_que where id = :new.id;
   end if;
  end if;
end;

/
ALTER TRIGGER BARS.TIU_CMCLIENT ENABLE;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/trigger/tiu_cmclient.sql =========*** End **
 PROMPT ===================================================================================== 
 
