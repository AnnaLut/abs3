

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_F98_TMP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CIM_F98_TMP ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CIM_F98_TMP 
before insert on cim_f98_tmp
for each row
declare
begin
  :new.line_hash:=sys.DBMS_CRYPTO.HASH(
     utl_raw.cast_to_raw(:new.np||to_char(:new.dt,'yyyy.mm.dd.hh24:mi:ss')||:new.ek_pok||:new.ko||:new.mfo||:new.nkb||:new.ku||:new.prb||
                         to_char(:new.k030)||to_char(:new.v_sank)||:new.ko_1||:new.r1_1||:new.r2_1||:new.k020||to_char(:new.datapod,'yyyy.mm.dd.hh24:mi:ss')||
                         :new.nompod||:new.djerpod||:new.nakaz||to_char(:new.datanak,'yyyy.mm.dd.hh24:mi:ss')||:new.nomnak||
                         to_char(:new.datpodsk,'yyyy.mm.dd.hh24:mi:ss')||:new.nompodsk||:new.djerpods||to_char(:new.datnaksk,'yyyy.mm.dd.hh24:mi:ss')||
                         :new.nomnaksk||:new.sanksia1||to_char(:new.srsank11,'yyyy.mm.dd.hh24:mi:ss')||to_char(:new.srsank12,'yyyy.mm.dd.hh24:mi:ss')||
                         :new.r4||:new.r030||to_char(:new.t071)||:new.k040||:new.bankin||:new.adrin||to_char(:new.data_m,'yyyy.mm.dd.hh24:mi:ss')),sys.dbms_crypto.hash_sh1);
end;


/
ALTER TRIGGER BARS.TBI_CIM_F98_TMP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_F98_TMP.sql =========*** End
PROMPT ===================================================================================== 
