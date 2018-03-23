create or replace force view bars.v_tts_vob_xrm
(
   tt,
   vob,
   name,
   ord
)
as
   select t.tt,
          t.vob,
          v.name,
          t.ord
     from tts_vob t, vob v
    where v.vob = t.vob;
/    
grant select,delete,update,insert on bars.v_tts_vob_xrm to bars_access_defrole;
/
grant select,delete,update,insert on bars.v_tts_vob_xrm to bars_intgr;
/
