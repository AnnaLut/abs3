

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SWAP_OTCN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SWAP_OTCN ***

  CREATE OR REPLACE PROCEDURE BARS.SWAP_OTCN ( p_dat date ) is 
xx fx_deal%rowtype ;  

-- 06.05.2016
-- при наполнении табл. TMP_VPKLB (поле REF) будем
-- вместо пол¤ DEAL_TAG из FX_DEAL будем выбырать поле REF

dat1_ date ;

begin  delete from TMP_VPKLB;

-- цикл по счетам
for A in ( select * from accounts 
           where nbs in  ('3041','3351')  
             and fost(acc, p_dat) <>0 
         )

loop
    -- найти последнюю датуЅ когда ост был = 0
    select max(fdat)  
       into dat1_ 
    from saldoa 
    where  acc = A.acc 
       and ostf = 0 
       and fdat <= p_dat
    group by acc;
 
    -- найти суммы по каждой сделке 
    for O in ( select ref, sum ( decode(dk,0, -1, 1)*s) S 
               from opldok 
               where acc= A.acc 
                 and fdat >= dat1_ 
                 and fdat <= p_dat and sos = 5
               group by ref 
             )

    loop 

       If O.S <> 0 then 
          BEGIN 
             select * into xx from fx_deal where ref = O.ref;
 
             insert into TMP_VPKLB ( ACC,   NLS,   KV, ref,             SK, 
                                     datp, ost,   mfo,  nlsk, namk )
                            select A.acc, A.nls, A.kv, xx.ref, xx.rnk, 
                                     decode ( A.kv, xx.kva, xx.dat_a, xx.dat_b), O.S, b.mfo, b.bic, substr(c.nmk ,1,38) 
                            from customer c, custbank b 
                            where c.rnk = xx.rnk 
                              and c.rnk = b.rnk (+);
          EXCEPTION WHEN NO_DATA_FOUND THEN 
             null;
          end;

       end if ;

    end loop  ;  -- O
end loop     ;  -- A
 
end  SWAP_OTCN ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SWAP_OTCN.sql =========*** End ***
PROMPT ===================================================================================== 
