

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_VPLIST_SPOT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_VPLIST_SPOT ***

  CREATE OR REPLACE TRIGGER BARS.TBI_VPLIST_SPOT 
BEFORE INSERT ON BARS.VP_LIST FOR EACH ROW
DECLARE
    nTmp_ int;
    ern          CONSTANT POSITIVE := 746;    -- Trigger err code
    err          EXCEPTION;
    erm          VARCHAR2(80);
BEGIN

 /*
  Для новой методики расчета реализ.результата необходимо следующее:

  Для каждого acc3800 (Только для БС 3800)
  acc3801, ACC6204 (он же  ACC_RRD, ACC_RRR ),  ACC_RRS  д.б. уникальны
 */

 -- ACC6204 = ACC_RRD = ACC_RRR
 If    :new.ACC6204 is not null then
       :new.ACC_RRD := :new.ACC6204;
       :new.ACC_RRR := :new.ACC6204;

 ElsIf :new.ACC_RRD is not null then
       :new.ACC6204 := :new.ACC_RRD;
       :new.ACC_RRR := :new.ACC_RRD;

 ElsIf :new.ACC_RRR is not null then
       :new.ACC6204 := :new.ACC_RRR;
       :new.ACC_RRD := :new.ACC_RRR;

 end if;

 -- Для каждого acc3800 (Только для БС 3800)
 -- acc3801, ACC6204, ACC_RRS  д.б. уникальными
 erm:='';
 begin
   select 1 into nTmp_ from accounts where acc=:new.acc3800 and nbs='3800';

   select 1 into ntmp_ from vp_list  where acc3801=:new.acc3801;
   erm :=  ' 3801';

   select 1 into ntmp_ from vp_list  where acc6204=:new.acc6204;
   erm := erm || ' 6204(n/r)';

   select 1 into ntmp_ from vp_list  where acc_RRS=:new.acc_RRS;
   erm := erm || ' 6204(r/r)';


 EXCEPTION  WHEN NO_DATA_FOUND THEN null;
 end;

 If length(erm) > 1 then
    erm := 'VP_LIST: not UNIQUE'|| erm;
    RAISE_APPLICATION_ERROR(-(20000+ern),'\'||erm,TRUE);
 end if;

END ; 
/
ALTER TRIGGER BARS.TBI_VPLIST_SPOT DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_VPLIST_SPOT.sql =========*** End
PROMPT ===================================================================================== 
