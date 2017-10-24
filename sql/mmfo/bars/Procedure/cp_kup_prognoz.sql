

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_KUP_PROGNOZ.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_KUP_PROGNOZ ***

  CREATE OR REPLACE PROCEDURE BARS.CP_KUP_PROGNOZ (p_dat date, p_rnk int default -5, p_reg int default 1) is
-- v 1.9  7/05-14  8/10-10   24/09-13
s_dos number; s_kos number;
l_dat1 date;  l_dat_t date;  l_dat2 date;
f_dat_d date; f_dat_k date;
l_dn int;  l_ostf number;  l_sum30 number;
fl_d int;  fl_k int;
l_id int;  l_fl int;
l_kol int;
l_kup number; kup_ number;
l_dnk date; k int; k1 int; k2 int;
l_uid int;  l_dok date;

tr tmp_cp_prgn%rowtype;

type t_dprg_ is record
  (
  dat date,
  dos number,
  s30 number,
  ost number,
  kup_g number
  );
 type t_mas_prg_ is table of t_dprg_ index by binary_integer;
 i int;
 mas_prg_  t_mas_prg_;

begin
l_dat1:=p_dat; l_uid := user_id;
if p_dat is null then l_dat1:=bankdate; end if;
logger.info('CP_KUP_PR: Старт '||l_dat1);
l_dat2:=l_dat1; l_dat1:=l_dat1+31;
l_dn:=0; l_ostf:=0; fl_d:=0; fl_k:=0;
l_id:=-1; k:=0;  l_dok:=null;
if p_reg=0 then goto KON; end if;
delete from tmp_cp_prgn where u_id=l_uid;   -- and rnk = p_rnk
commit;
tr:=null;
for c1 in
   (select v.cp_id, ref, v.nd, v.accr ACC,
           v.ostr OST, v.ostaf,
           a.mdate, v.dapp, v.vidd, k.datp, nvl(v.rnk,50) RNK, 'R' R,
           k.id, k.cena, k.dnk, k.ir, k.cena_kup,
           a.nls, a.kv, nvl(p.r013,'?') r03
    from cp_v v, cp_kod k, accounts a, specparam p
    where k.id=v.id and k.datp > l_dat1-31
                  --  and k.dox > 1
                    and k.kv=980 and v.accr is not null
                    and v.ostaf < 0 and k.tip=1 and v.sos=5
                  --  and v.dapp > to_date('01-jul-2012')
                  --  and (v.vidd in (3110) or v.vidd=1410 and k.emi!=0)
                    and k.rnk = decode(nvl(p_rnk,-5),-5,k.rnk,p_rnk)
                    and v.accr=a.acc and a.acc=p.acc
                    and
                    (1=2 or a.nls like '1408%' and p.r013='2' or     -- !?
                     a.nls like '1408%' and p.r013='8' or
                     a.nls like '1418%' and p.r013='2' or
                     a.nls like '1418%' and p.r013='8' or
                     a.nls like '1428%' and p.r013='2' or
                     a.nls like '1428%' and p.r013='8' or
                     a.nls like '3008%' and p.r013='3' or
                     a.nls like '3018%' and p.r013='3' or
                     a.nls like '3018%' and p.r013='7' or
                     a.nls like '3018%' and p.r013='D' or
                     a.nls like '3108%' and p.r013='3' or
                     a.nls like '3118%' and p.r013='3' or
                     a.nls like '3118%' and p.r013='7' or
                     a.nls like '3118%' and p.r013='B' or
                     a.nls like '3118%' and p.r013='D' or
                     a.nls like '3128%' and p.r013='3' or
                     a.nls like '3138%' and p.r013='3' or
                     a.nls like '3218%' and p.r013='3' or
                     a.nls like '3218%' and p.r013='7' or
                     a.nls like '3218%' and p.r013='B' or
                     a.nls like '3218%' and p.r013='D' or
                     a.nls like '4108%' and p.r013='3' or
                     a.nls like '4208%' and p.r013='3')
    UNION ALL
    select v.cp_id, ref, v.nd, v.accr2 ACC,
           v.ostr2 OST, v.ostaf,
           a.mdate, v.dapp, v.vidd, k.datp, nvl(v.rnk,50), 'R2',
           k.id, k.cena, k.dnk, k.ir, k.cena_kup,
           a.nls, a.kv, nvl(p.r013,'?')
    from cp_v v, cp_kod k, accounts a, specparam p
    where k.id=v.id and k.datp > l_dat1-31
                  --  and k.dox > 1
                    and k.kv=980 and v.accr2 is not null
                    and v.ostaf < 0 and k.tip=1 and v.sos=5
                  --  and v.dapp > to_date('01-jul-2012')
                  --  and (v.vidd in (3110) or v.vidd=1410 and k.emi!=0)
                    and k.rnk = decode(nvl(p_rnk,-5),-5,k.rnk,p_rnk)
                    and v.accr2=a.acc and a.acc=p.acc
                    and
                    (1=2 or a.nls like '1408%' and p.r013='2' or     -- !?
                     a.nls like '1408%' and p.r013='8' or
                     a.nls like '1418%' and p.r013='2' or
                     a.nls like '1418%' and p.r013='8' or
                     a.nls like '1428%' and p.r013='2' or
                     a.nls like '1428%' and p.r013='8' or
                     a.nls like '3008%' and p.r013='3' or
                     a.nls like '3018%' and p.r013='3' or
                     a.nls like '3018%' and p.r013='7' or
                     a.nls like '3018%' and p.r013='D' or
                     a.nls like '3108%' and p.r013='3' or
                     a.nls like '3118%' and p.r013='3' or
                     a.nls like '3118%' and p.r013='7' or
                     a.nls like '3118%' and p.r013='B' or
                     a.nls like '3118%' and p.r013='D' or
                     a.nls like '3128%' and p.r013='3' or
                     a.nls like '3138%' and p.r013='3' or
                     a.nls like '3218%' and p.r013='3' or
                     a.nls like '3218%' and p.r013='7' or
                     a.nls like '3218%' and p.r013='B' or
                     a.nls like '3218%' and p.r013='D' or
                     a.nls like '4108%' and p.r013='3' or
                     a.nls like '4208%' and p.r013='3')
    order by 11,2,12)
loop
tr:=null;
--logger.info('CP_KUP_PR: '||c1.cp_id||'*'||c1.ref);
l_ostf:=c1.ost; l_sum30:=0; s_dos:=0; s_kos:=0; f_dat_d:=null;
l_kup:=0; kup_:=0;  l_dok:=null;
l_dnk:=nvl(c1.dnk,to_date('01/01/1900','dd/mm/yyyy'));
if c1.ost = 0 then goto EX; end if;
--tr.dat15:=l_dnk; tr.s_n15:=l_kup;
   l_kol := round(-c1.ostaf/c1.cena,0);
if 1=1 or l_id != c1.id then l_id:=c1.id;
   -- кіл-ть та повний купон
   l_kup := nvl(c1.cena_kup,0.0)*l_kol;   -- !?

   begin
   l_fl :=0 ;
   select 1 into l_fl from dual
   where exists (select 1 from cp_dat where id = l_id);
   exception when NO_DATA_FOUND then l_fl:=0;
   NULL;
 --  log('ISIN='||l_ISIN||' '||ID_||' Не внесена iсторiя купонiв ','ERROR',0);
   end;

   if l_fl = 1 then
   begin
   select nvl(kup,0), dok  into kup_, l_dok      --
   from cp_dat
   where id=c1.id
         and dok = (select min(dok) from cp_dat where id=c1.id and dok>=l_dat2);

   l_kup:=kup_*l_kol;
  -- LOG('ISIN='||l_ISIN||' ref='||REF_||' kup='||kup_||' ');
   exception when NO_DATA_FOUND then kup_:=0;
  -- LOG('ISIN='||l_ISIN||' ref='||REF_||' '_,'INFO',1);
   end;
   end if;
   --- зафіксувати l_DNK, l_KUP

null;
end if;
logger.info('CP_KUP_PR: '||c1.cp_id||'*'||c1.ref
                         ||' '||c1.ostaf||' '||l_kol||' '||KUP_||' '||l_dok
                         ||' '||l_kup);

-- fill sysdate
for i_ in 1..65
 LOOP
 BEGIN
 k:=i_; l_dat_t := l_dat1 + i_ - 62;
 mas_prg_(i_).dat:=l_dat_t;
 mas_prg_(i_).dos:=0;
 mas_prg_(i_).s30:=0;
 mas_prg_(i_).ost:=c1.ost;
 mas_prg_(i_).kup_g:=0;
 if l_dnk>bankdate and l_dat_t >= l_dnk then mas_prg_(i_).kup_g:=l_kup; end if;
 END;
 if (i_ = 15 or i_=15) and c1.cp_id like '%148548'     --'%50199'
    and 1=2  then
 logger.info('CP_KUP_PR:-'||i_||' dnk='||l_dnk||' '||mas_prg_(i_).dat
             ||' '||mas_prg_(i_).s30||' '||mas_prg_(i_).ost
             ||' '||mas_prg_(i_).kup_g||' kol='||l_kol);
 null;
 end if;
 END LOOP;

--logger.info('CP_KUP_PR: '||c1.cp_id||'*'||c1.ref||' '||c1.ost||' '||c1.dapp);

for c2 in (select acc, fdat, dos/100 dos, kos/100 kos
           from saldoa
           where acc=c1.acc and fdat < l_dat1 and fdat >=l_dat1 - 62
           order by fdat desc)
loop

l_dn:=l_dat1 - c2.fdat;
if l_dn !=0 /*< 61*/ then    null;  s_dos:=s_dos+c2.dos;
if c2.dos!=0 then f_dat_d := c2.fdat; end if;
          l_sum30:=l_sum30 + c2.dos;
s_kos:=s_kos+c2.kos;
if c2.kos!=0 then f_dat_k := c2.fdat; end if;

-- fill ....
for i_ in reverse 1..63-l_dn
 LOOP
 BEGIN
-- mas_prg_(i_).dat:=l_dat1+i_-31; --  f_dat_t  ?
 mas_prg_(i_).dos:=c2.dos;
 mas_prg_(i_).s30:=l_sum30;
 mas_prg_(i_).ost:=c1.ost;
-- if mas_prg_(i_).dat >= l_dnk  then mas_prg_(i_).kup_g:=l_kup;   end if;
 END;
 END LOOP;

end if;

<<INS>> NULL;
<<EX1>> NULL;
end loop;

null;
tr.rnk :=c1.rnk; tr.cp_id:=c1.cp_id;
tr.ref:=c1.ref; tr.nd:=c1.nd;
tr.acc:=c1.acc; tr.u_id:=l_uid; tr.v_kup:=c1.r;
tr.d_kup:=l_dok; tr.s_kup:=l_kup;
-- put record
  /*
logger.info('CP_KUP_PR:+'||c1.rnk||' 10*'||c1.cp_id||'*'||c1.ref||' '
                         ||' '||mas_prg_(10).dat||' '||mas_prg_(10).dos
                         ||' '||mas_prg_(10).s30
                         ||' '||mas_prg_(10).kup_g||' '||tr.v_kup);
  */

 if 1=1        or c1.cp_id like '%148548'  then      --'%50199'
 for i_ in 30..61
 LOOP
 BEGIN
 null;   k2:=i_ - 29;
 if 1=2  and c1.cp_id like '%148548' then   -- %50199
 logger.info('CP_KUP_PR: '||i_||' '||mas_prg_(i_).dat||'*'||mas_prg_(k2).dos||'*'
                          ||mas_prg_(k2).s30||'*'
                          ||mas_prg_(i_).ost||'*'||mas_prg_(i_).kup_g);
 null;
 end if;
 k:=i_-29; k1:=i_;
 if k=1 then tr.dat01:=mas_prg_(k1).dat; --tr.s_n01:=mas_prg_(k).s30;
            tr.s_n01:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=2  then tr.dat02:=mas_prg_(k1).dat; --tr.s_n02:=mas_prg_(k).s30;
                 tr.s_n02:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=3  then tr.dat03:=mas_prg_(k1).dat; --tr.s_n03:=mas_prg_(k).s30;
                 tr.s_n03:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=4  then tr.dat04:=mas_prg_(k1).dat; --tr.s_n04:=mas_prg_(k).s30;
                 tr.s_n04:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=5  then tr.dat05:=mas_prg_(k1).dat; --tr.s_n05:=mas_prg_(k).s30;
                 tr.s_n05:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=6  then tr.dat06:=mas_prg_(k1).dat; --tr.s_n06:=mas_prg_(k).s30;
                 tr.s_n06:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=7  then tr.dat07:=mas_prg_(k1).dat; --tr.s_n07:=mas_prg_(k).s30;
                 tr.s_n07:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=8  then tr.dat08:=mas_prg_(k1).dat; --tr.s_n08:=mas_prg_(k).s30;
                 tr.s_n08:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=9  then tr.dat09:=mas_prg_(k1).dat; --tr.s_n09:=mas_prg_(k).s30;
                 tr.s_n09:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=10 then tr.dat10:=mas_prg_(k1).dat; --tr.s_n10:=mas_prg_(k).s30;
                 tr.s_n10:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=11 then tr.dat11:=mas_prg_(k1).dat; --tr.s_n11:=mas_prg_(k).s30;
                 tr.s_n11:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=12 then tr.dat12:=mas_prg_(k1).dat; --tr.s_n12:=mas_prg_(k).s30;
                 tr.s_n12:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=13 then tr.dat13:=mas_prg_(k1).dat; --tr.s_n13:=mas_prg_(k).s30;
                 tr.s_n13:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=14 then tr.dat14:=mas_prg_(k1).dat; --tr.s_n14:=mas_prg_(k).s30;
                 tr.s_n14:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=15 then tr.dat15:=mas_prg_(k1).dat; --tr.s_n15:=mas_prg_(k).s30;
                 tr.s_n15:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=16 then tr.dat16:=mas_prg_(k1).dat; --tr.s_n16:=mas_prg_(k).s30;
                 tr.s_n16:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=17 then tr.dat17:=mas_prg_(k1).dat; --tr.s_n17:=mas_prg_(k).s30;
                 tr.s_n17:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=18 then tr.dat18:=mas_prg_(k1).dat; --tr.s_n18:=mas_prg_(k).s30;
                 tr.s_n18:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=19 then tr.dat19:=mas_prg_(k1).dat; --tr.s_n19:=mas_prg_(k).s30;
                 tr.s_n19:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=20 then tr.dat20:=mas_prg_(k1).dat; --tr.s_n20:=mas_prg_(k).s30;
                 tr.s_n20:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=21 then tr.dat21:=mas_prg_(k1).dat; --tr.s_n21:=mas_prg_(k).s30;
                 tr.s_n21:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=22 then tr.dat22:=mas_prg_(k1).dat; --tr.s_n22:=mas_prg_(k).s30;
                 tr.s_n22:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=23 then tr.dat23:=mas_prg_(k1).dat; --tr.s_n23:=mas_prg_(k).s30;
                 tr.s_n23:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=24 then tr.dat24:=mas_prg_(k1).dat; --tr.s_n24:=mas_prg_(k).s30;
                 tr.s_n24:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=25 then tr.dat25:=mas_prg_(k1).dat; --tr.s_n25:=mas_prg_(k).s30;
                 tr.s_n25:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=26 then tr.dat26:=mas_prg_(k1).dat; --tr.s_n26:=mas_prg_(k).s30;
                 tr.s_n26:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=27 then tr.dat27:=mas_prg_(k1).dat; --tr.s_n27:=mas_prg_(k).s30;
                 tr.s_n27:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=28 then tr.dat28:=mas_prg_(k1).dat; --tr.s_n28:=mas_prg_(k).s30;
                 tr.s_n28:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=29 then tr.dat29:=mas_prg_(k1).dat; --tr.s_n29:=mas_prg_(k).s30;
                 tr.s_n29:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=30 then tr.dat30:=mas_prg_(k1).dat; --tr.s_n30:=mas_prg_(k).s30;
                 tr.s_n30:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 elsif k=31 then tr.dat31:=mas_prg_(k1).dat; --tr.s_n31:=mas_prg_(k).s30;
                 tr.s_n31:=greatest(0,-mas_prg_(k1).ost - mas_prg_(k).s30 - mas_prg_(k1).kup_g);
 else null;
 end if;
 END;
 END LOOP;
-- logger.info('CP_KUP_PR: '||c1.cp_id);
 end if;

 insert into tmp_cp_prgn values tr;

<<EX>> NULL;
null;
end loop;
commit;
<<KON>> NULL;
logger.info('CP_KUP_PR: END');
end;
/
show err;

PROMPT *** Create  grants  CP_KUP_PROGNOZ ***
grant EXECUTE                                                                on CP_KUP_PROGNOZ  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CP_KUP_PROGNOZ  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_KUP_PROGNOZ.sql =========*** En
PROMPT ===================================================================================== 
