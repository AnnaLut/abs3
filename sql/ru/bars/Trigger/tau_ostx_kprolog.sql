

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_OSTX_KPROLOG.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_OSTX_KPROLOG ***

  CREATE OR REPLACE TRIGGER BARS.TAU_OSTX_KPROLOG 
AFTER UPDATE OF ostx ON accounts
FOR EACH ROW
 WHEN ( NEW.TIP = 'LIM' AND NEW.OSTX IS NOT NULL AND OLD.OSTX IS NOT NULL AND NEW.OSTX != OLD.OSTX ) DECLARE
  l_nd   nd_acc.nd%type;
  l_id   staff.id%type;
  l_fio  staff.fio%type;
  l_npp  cc_prol.npp%type;
  l_txt  cc_prol.txt%type;
  l_type cc_prol.prol_type%type := 2;  -- зм≥на л≥м≥ту
BEGIN

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

    l_txt := '«мiни  ƒ: ' || case when :NEW.OSTX > :OLD.OSTX then '«бiльшенн€' else '«меншенн€' end ||
             ' лiмiту з ' || to_char(abs(:old.ostx/100),'FM999G999G999G990D00') ||
             ' на '       || to_char(abs(:new.ostx/100),'FM999G999G999G990D00') || ' (вик.' || l_id || ' - ' || l_fio || ')';

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

END TAU_OSTX_KPROLOG;
/
ALTER TRIGGER BARS.TAU_OSTX_KPROLOG ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_OSTX_KPROLOG.sql =========*** En
PROMPT ===================================================================================== 
