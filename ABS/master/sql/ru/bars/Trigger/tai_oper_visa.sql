

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_OPER_VISA.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_OPER_VISA ***

  CREATE OR REPLACE TRIGGER BARS.TAI_OPER_VISA 
/*
 * триггер для населенеия информации по последней визе
 * для сбербанка (мульти МФО) для кассовых документов
 * author anny
 * V.1.9 (08.12.2011)
 */
for insert ON BARS.OPER_VISA  COMPOUND TRIGGER
l_tt oper.tt%type;

    Before each Row
    is
     begin

          begin
           select tt into l_tt from oper where ref = :new.REF;
          exception
            when no_data_found then null;
          end;

          if
              :new.status  = 0 and l_tt = 'AA6'
               and CHK.GETNEXTVISAGROUP(:new.REF,  CHK.GETNEXTVISAGROUP(:new.REF,  lpad(lpad(chk.to_hex(:new.groupid),2,'0'),2,'0'))    )  = '!!'
               then
               :new.status := 2;

          end if;

         end
    Before each Row;

    After each Row
    is
        begin
          begin
           select tt into l_tt from oper where ref = :new.REF;
          exception
            when no_data_found then null;
          end;

          if
              :new.status  = 0 and l_tt = 'AA6'
               and CHK.GETNEXTVISAGROUP(:new.REF,  CHK.GETNEXTVISAGROUP(:new.REF,  lpad(lpad(chk.to_hex(:new.groupid),2,'0'),2,'0'))    )  = '!!'
               then

                bars_cash.enque_ref(:new.ref, :new.userid);
                if bars_cash.G_ISUSECASH = 1 and bars_cash.G_CURRSHIFT = 0 then
                 -- змiну ще не було выдкрито
                 bars_cash.open_cash(p_shift => 1, p_force => 1);
              end if;

          end if;

           if :new.status  = 0  or          -- введен (невизирован)
              :new.groupid = 77 or          -- упрвление коррсч.
              :new.groupid = 80 or          -- from params where par = 'NU_CHCK'   (налоговый учет)
              :new.groupid = 81 or          -- from params where par = 'NU_CHCKN'  (налоговый учет)
              :new.groupid = 30 or          -- Условная группа визирования при квитовке с процессинга
              :new.groupid = 94 then null;  -- Контролер БИс строк

           else
           -- или последняя(может быть и не кассовая)
           -- или кассовая (неважно последняя или нет)
           if :new.status = 2  or bars_cash.is_cashvisa(:new.groupid) = 1
               or (     lpad(lpad(chk.to_hex(:new.groupid),2,'0'),2,'0')= '05'
                    and CHK.GETNEXTVISAGROUP(:new.REF,  lpad(lpad(chk.to_hex(:new.groupid),2,'0'),2,'0')) = '07'
                    and CHK.GETNEXTVISAGROUP(:new.REF,  CHK.GETNEXTVISAGROUP(:new.REF,  lpad(lpad(chk.to_hex(:new.groupid),2,'0'),2,'0'))    )  = '!!'
                  )
               then

              bars_cash.enque_ref(:new.ref, :new.userid);
              -- Для работы с кассой в операционном дне - нужно проверить открыта ли
              -- смена в операционном дне
              if bars_cash.G_ISUSECASH = 1 and bars_cash.G_CURRSHIFT = 0 then
                 -- змiну ще не було выдкрито
                 bars_cash.open_cash(p_shift => 1, p_force => 1);
              end if;

           end if;

             end if;

        end
    After each Row;

end TAI_OPER_VISA;
/
ALTER TRIGGER BARS.TAI_OPER_VISA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_OPER_VISA.sql =========*** End *
PROMPT ===================================================================================== 
