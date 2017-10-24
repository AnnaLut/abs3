

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SPD_15.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SPD_15 ***

  CREATE OR REPLACE PROCEDURE BARS.SPD_15 ( p_mode int, p_isp int ) IS
   l_tax_nls varchar2(14) ;  l_tax number;    l_s15 number := 0 ; l_s15q number := 0 ;   nTmp_  int  ;
   oo oper%rowtype;  dat01_ date := to_date('01-09-2014','dd-mm-yyyy');  dat31_ date := to_date('30-09-2014','dd-mm-yyyy');
begin

If p_mode = 0 then -- Инга, начисление
   l_tax            :=  15/100 ;                 -- % налога
   for k in (select sum(o.S) s, a.KV, a.rnk, a.nbs, a.nls, a.acc , a.ostc , a.branch, a.isp, a.nms   -- выборка необходимых
             from  (select * from opldok where tt IN ( '%%1','DU%') and dk  = 1 and fdat >= dat01_ and fdat <= dat31_
                   ) o,
                   (select * from accounts where nbs in ('2608','2618') and dazs is null ) a
             where o.acc = a.acc
             group by a.KV, a.rnk, a.nbs, a.nls, a.acc , a.ostc , a.branch, a.isp, a.nms
            )
   loop
      begin
         select 1 into nTmp_ from customer where rnk = k.rnk and ise = '14200' and sed = '91' ;  -- только СПД
         l_s15  := ROUND( k.s*l_tax , 0 );      l_s15q := p_icurval( k.kv, l_s15, dat31_)     ;  -- расч сумма
         if l_s15 > 0 then
            If length (k.branch) = 15 then k.branch := k.branch || '06'|| substr(k.branch,-5) ; end if;  -- подбор сч 3622 на 3-м уровне
            l_tax_nls := nbs_ob22_null('3622','37',k.branch );
            gl.ref(oo.ref);
            gl.in_doc3(oo.ref, '%15', 6, to_char(oo.ref),  SYSDATE,  gl.bdate, 1, k.kv, l_s15, 980,  l_s15q,
                       null, gl.bdate, gl.bdate,
                       substr(k.nms,1,38), k.nls, gl.amfo,
                      'ПДФО з проц.доходiв поточ.рах. ФО', l_tax_nls, gl.amfo,
                      'ПДФО з проц.доходiв за вересень 2014 р.', null, null, null, null, null, 0, null, p_isp);
            gl.payv(0, oo.ref, gl.bdate,'%15', 1, k.kv, k.nls, l_s15, gl.baseval , l_tax_nls, l_s15q );    -- доч.проводка
            If k.ostc  >= l_s15  then  gl.pay(2, oo.ref, gl.bdate);   end if;
         end if;
      exception when no_data_found then   null;
      end;
   end loop;
end if;

If p_mode = 2 then -- Сухова, перечисление
   for k in (select substr( branch || '06'|| substr(branch,11,5), 1, 22) branch3, sum(f15) P
             from ( select  a.branch , (select sum(sq) from opldok where acc= s.acc AND FDAT = gl.bd AND DK=0 AND TT='%15' AND SOS=5) f15
                    from accounts a, customer c, saldoa s
                    where a.nbs in ('2608','2618') and a.rnk = c.rnk and c.ise = '14200' and c.sed = '91' and a.acc= s.acc
                      and s.fdat >= dat01_ and s.fdat <= dat31_  and s.Kos>0 and a.dazs is  null
                  ) where  f15 > 0
            group by substr( branch || '06'|| substr(branch,11,5), 1, 22)
           )
    loop
       begin
         select substr(val,1,06) into oo.mfob  from BRANCH_PARAMETERS where branch=k.branch3 and tag='PDFOMFO' and val is not null;
         select substr(val,1,14) into oo.nlsb  from BRANCH_PARAMETERS where branch=k.branch3 and tag='PDFONLS' and val is not null;
         select substr(val,1,38) into oo.nam_b from BRANCH_PARAMETERS where branch=k.branch3 and tag='PDFONAM' and val is not null;
         select substr(val,1,08) into oo.id_b  from BRANCH_PARAMETERS where branch=k.branch3 and tag='PDFOID'  and val is not null;
         select substr('. '|| name, 1, 160) into oo.nazn from branch  where branch=k.branch3;

         gl.ref (oo.REF);
         oo.nd    := trim(substr('     ' ||to_char(oo.ref), -10)) ;
         oo.nlsa  := nbs_ob22_null ('3622','37', k.branch3) ;
         oo.nam_a := 'ПДФО з процентних доходів';
         oo.tt   :='PS2';
         oo.nazn := substr('*;101;'||gl.aOkpo||';ПДФО з процентних доходів СПД за серпень 2014 р.;;;', 1, 160);
         gl.in_doc3(ref_=> oo.ref  , tt_   => oo.tt   , vob_  => 1       , nd_   => oo.nd  , pdat_ => SYSDATE, vdat_ => gl.bdate,
                    dk_ => 1       , kv_   => 980     , s_    => k.p     , kv2_  => 980    , s2_   => k.p    , sk_   => null    ,
                  data_ => gl.bdate, datp_ => gl.bdate, nam_a_=> oo.nam_a, nlsa_ => oo.nlsa, mfoa_ => oo.Mfoa, nam_b_=> oo.nam_b,
                  nlsb_ => oo.nlsb , mfob_ => oo.mfob , nazn_ => oo.nazn , d_rec_=> null   , id_a_ => gl.aOkpo, id_b_ => oo.id_b ,
                  id_o_ => null    , sign_ => null    , sos_  => 1       , prty_ => null   , uid_  => p_isp     );
         PAYTT (0, oo.ref, gl.bdate, oo.tt, 1, 980, oo.nlsa, k.p, 980, oo.nlsb, k.p );
       EXCEPTION when NO_DATA_FOUND THEN null; -- raise_application_error(-20000,'Не знайдено пл.реквiзити для ПДФО для бранчу='|| k.branch);
       end;
    end loop;
    Return;
 end if;
 ---------------------------------------------------------------------------




end spd_15;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SPD_15.sql =========*** End *** ==
PROMPT ===================================================================================== 
