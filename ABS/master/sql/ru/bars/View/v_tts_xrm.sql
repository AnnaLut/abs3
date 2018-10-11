create or replace view v_tts_xrm as
select tt,
       name,
       fli,
       case when dk=1 then kv else kvk end kva,
       case when dk=1 then kvk else kv end kvb,
       case when nazn like '%#%' then null else nazn end def,
       case when nlsa is not null and dk=1 then 1 when nlsb is not null and dk=0 then 1 else 0 end contracta_abs_sel,
       case when nlsb is not null and dk=1 then 1 when nlsa is not null and dk=0 then 1 else 0 end contractb_abs_sel,
       substr(flags,1,1) flag  
  from tts
 where (tt in (select tt from staff_tts s where date_is_valid (s.adate1, s.adate2, s.rdate1,s.rdate2) = 1 /*and substr(flags,1,1)=1*/)
        or
        exists (select null from dpt_tts_vidd d where d.tt = tts.tt ))
 and fli < 3;
/
grant select,delete,update,insert on bars.v_tts_xrm to bars_access_defrole;
grant select,delete,update,insert on bars.v_tts_xrm to bars_intgr;
/

