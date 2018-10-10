

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_OPER_BPK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_OPER_BPK ***

  CREATE OR REPLACE TRIGGER BARS.TAI_OPER_BPK 
after insert or update of nlsa, nlsb on oper
for each row
declare
  l_acc  number;
  l_ob22 varchar2(2);
  l_tip  varchar2(3);
  l_ost  number;
  l_rnk  number;
begin

  if inserting
  or updating and ( :new.tt <> 'R01'
                 or :new.tt =  'R01' and :old.nlsb is null ) then

     -- 1. Запрет выполнения операций по счетам моб.сбережений
     if :new.tt not in ('OW1', 'OW2', 'OW3') and
        (  :new.mfoa = f_ourmfo and :new.nlsa like '2625%'
        or :new.mfob = f_ourmfo and :new.nlsb like '2625%' ) then
        if :new.mfoa = f_ourmfo and :new.nlsa like '2625%' then
           begin
              select a.acc into l_acc
                from w4_acc o, accounts a
               where o.acc_2625d = a.acc
                 and a.nls = :new.nlsa
                 and a.kv  = :new.kv;
              -- Заборонено виконання операцій по рахунках мобільних заощаджень!
              bars_error.raise_nerror('BPK', 'ERROR_NLS2625D_PAY');
           exception when no_data_found then null;
           end;
        end if;
        if :new.mfob = f_ourmfo and :new.nlsb like '2625%' then
           begin
              select a.acc into l_acc
                from w4_acc o, accounts a
               where o.acc_2625d = a.acc
                 and a.nls = :new.nlsb
                 and a.kv  = nvl(:new.kv2,:new.kv);
              -- Заборонено виконання операцій по рахунках мобільних заощаджень!
              bars_error.raise_nerror('BPK', 'ERROR_NLS2625D_PAY');
           exception when no_data_found then null;
           end;
        end if;
     end if;

     -- 2. Добавление документа в очередь на отправку в ПЦ
     -- определяем, интересует ли нас операция
     for z in ( select dk
                  from obpc_trans_out
                 where tt = :new.tt )
     loop

        begin

           -- определяем, интересует ли нас счет
           select a.acc, a.ob22, a.tip, a.ostc, a.rnk
            into l_acc, l_ob22, l_tip, l_ost, l_rnk
             from accounts a
            where a.nls = decode(z.dk,:new.dk,:new.nlsb,:new.nlsa)
              and a.kv  = decode(z.dk,:new.dk,nvl(:new.kv2,:new.kv),:new.kv)
              and a.tip like 'W4%';

           -- контроль на дебетовое сальдо по счетам НК:
           --   запрещено списание с карт.счета оп. PKF,
           --   если на счете остаток меньше суммы документа
           if :new.tt = 'PKF' and l_ob22 = '22' and :new.s > l_ost then
              -- Контроль на дебетовое сальдо: запрещено проведение операции
              bars_error.raise_nerror('BPK', 'CHECK_DEBIT_BALANCE');
           end if;

           -- контроль на обов’язковість наявності в картці клієнта номеру мобільного телефону
           --   при здійсненні по клієнту Операції PKF (Видача готівки по БПК через касу банку)
           if :new.tt = 'PKF' and verify_cellphone_byrnk(l_rnk) = 0 then
              -- В картці клієнта не заповнено або невірно заповнено мобільний телефон
              bars_error.raise_nerror('CAC', 'ERROR_MPNO');
           end if;

           -- добавляем документ в очередь на отправку в ПЦ
           begin
              insert into ow_pkk_que (ref, dk, acc)
              values (:new.ref, z.dk, l_acc);
           exception when dup_val_on_index then null;
           end;

        exception when no_data_found then null;
        end;

     end loop;

  end if;

end tau_oper_sos_bpk;


/
ALTER TRIGGER BARS.TAI_OPER_BPK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_OPER_BPK.sql =========*** End **
PROMPT ===================================================================================== 
