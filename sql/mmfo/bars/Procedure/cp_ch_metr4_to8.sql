

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_CH_METR4_TO8.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_CH_METR4_TO8 ***

  CREATE OR REPLACE PROCEDURE BARS.CP_CH_METR4_TO8 (p_dat date default null) is
-- *** v 1.4  від 27/04-15       prv 17/04-15
-- зміна методу нар-ня купонів metr 4 -> 8 
-- вставка та видалення %-карточок

r_int_ratn int_ratn%rowtype;
r_int_accn int_accn%rowtype;

begin
logger.info('CP_CH_METR4: start');
for k in
(select a.nls, a.kv, r.nls NLSR, 
        i.id id_int, i.metr, i.basey, i.freq, i.acra, i.acrb, i.acr_dat, i.stp_dat, i.tt, i.io,
        d.id, d.ref, d.acc, d.accr, d.dat_ug, d.ryn, 
        k.cp_id, k.dok, k.dnk, k.ir, k.metr K_METR
from cp_deal d, int_accn i, accounts a, cp_kod k, accounts r
where i.acc=d.accr and a.acc=d.acc and r.acc=d.accr
      and k.id=d.id  
      and nvl(k.metr,4)=23  
      and d.dazs is null and active=1
     -- and d.ref in (select ref from cp_v_deal where ostr=0 and ostr_f =0)
    and d.acc not in (select acc from int_accn where id=0)
       and a.dazs is null
       order by d.id, a.nls)

loop
logger.info('CP_CH_METR4: '||k.cp_id||' ref='||k.ref);
    
begin
insert into int_accn (acc,id,metr,basey,freq,acr_dat,stp_dat,tt,acra,acrb,io)
values
(k.acc,0,8,1,1,k.acr_dat,k.stp_dat,k.tt,k.acra,k.acrb,k.io);
logger.info('CP_CH_METR4: ins_8 nls='||k.nls||' / '||k.acc);
exception when dup_val_on_index then  null;
logger.error('CP_CH_METR4: error ins_8 nls='||k.nls||' / '||k.acc);
end;

begin
insert into int_ratn (acc,id,bdat,ir)
values (k.acc,0,gl.bd,k.ir);
logger.info('CP_CH_METR4: ins_ir nls='||k.nls||' / '||k.acc);
exception when dup_val_on_index then  null;
logger.error('CP_CH_METR4: error ins_ir nls='||k.nls||' / '||k.acc);
end;

begin
null;
-- delete from int_ratn where acc=k.accr and id=1;
-- delete from int_accn where acc=k.accr and id=1; 
 update int_accn set stp_dat=k.ACR_DAT, acra=null, acrb=null
 where acc=k.accr and id=k.id_int;
 exception when others then  null;
logger.error('CP_CH_METR4: error upd INT_ACCN nls='||k.nls||' / '||k.acc);
end;    

begin
update cp_kod set metr=8 where id=k.id and metr=23;
exception when others then  null;
logger.info('CP_CH_METR4: error upd metr nls='||k.nls||' / '||k.acc);
end;

begin
update accounts set ostf=0 where acc=k.accr and ostf!=0;
exception when others then  null;
logger.info('CP_CH_METR4: error upd OSTF nls='||k.nlsr||' / '||k.accr);
end;

end loop;
commit;
logger.info('CP_CH_METR4: endet');
end;
/
show err;

PROMPT *** Create  grants  CP_CH_METR4_TO8 ***
grant EXECUTE                                                                on CP_CH_METR4_TO8 to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CP_CH_METR4_TO8 to CP_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_CH_METR4_TO8.sql =========*** E
PROMPT ===================================================================================== 
