

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_IR_KPROLOG.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_IR_KPROLOG ***

  CREATE OR REPLACE TRIGGER BARS.TAU_IR_KPROLOG 
AFTER UPDATE OF ir ON BARS.INT_RATN
FOR EACH ROW
 WHEN ( NEW.IR <> OLD.IR ) DECLARE
  l_tip  accounts.tip%type;
  l_nd   nd_acc.nd%type;
  l_id   staff.id%type;
  l_fio  staff.fio%type;
  l_npp  cc_prol.npp%type;
  l_txt  cc_prol.txt%type;
  l_type cc_prol.prol_type%type := 1;  -- зм≥на % ставки
BEGIN

  select a.tip
    into l_tip
    from ACCOUNTS a
   where acc = :NEW.ACC;

  if ( l_tip = 'SS ' )
  then

    select max(n.nd)
      into l_nd
      from ND_ACC n
     where n.acc = :NEW.ACC;

    if ( l_nd is Not Null )
    then

      begin
        select s.id, s.fio
          into l_id, l_fio
          from STAFF$BASE s
         where s.logname = USER;
      exception
        when NO_DATA_FOUND then
          l_id  := null;
          l_fio := null;
      end;

      l_txt := '«мiни  ƒ:' || case when :NEW.IR > :OLD.IR then ' «бiльшенн€' else ' «меншенн€' end ||
               ' % ст. з ' || to_char(:OLD.IR, 'FM990D009') || ' на ' || to_char(:NEW.IR, 'FM990D009') ||
               ' (вик.'    || l_id || ' - ' || l_fio || ')';

      update CC_DEAL
         set kprolog = nvl(kprolog,0) + 1
       where nd = l_nd
         and sos > 0
         and sos < 15
      returning kprolog into l_npp;

      if (l_npp is Not Null)
      then
        insert into cc_prol
          ( ND, FDAT, NPP, acc, TXT, PROL_TYPE )
        values
          ( l_nd, gl.bdate, l_npp, :NEW.acc, l_txt, l_type );
      else
        null;
      end if;

     end if;

  end if;

END TAU_IR_KPROLOG;
/
ALTER TRIGGER BARS.TAU_IR_KPROLOG ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_IR_KPROLOG.sql =========*** End 
PROMPT ===================================================================================== 
