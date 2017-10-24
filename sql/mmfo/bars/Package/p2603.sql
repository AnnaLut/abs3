
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/p2603.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.P2603 IS
/*  04.02.2016 Sta COBUSUPABS-4180 Спец.перекриття для 2603
               18.12.2015р. №1086 «Про внесення змін до постанови Каб.Мін.Укр. від 18 червня 2014р. №217» (далі – Постанова №1086),
*/


 procedure UPD  (p_acc number, p_sa number) ;
 procedure PREV (p_IDG int) ;
end p2603;
/
CREATE OR REPLACE PACKAGE BODY BARS.P2603 IS
/*
   21-04-2016 Сухова - исправила процедуру по расчету план-суммы ручного вмешательства, в ней
•    плановая сумма ручного вмешательства зависит не только от сч.плательщика (как было раньше),  но и от получателя № 1 (его коеф)
•    фактическая сумма ручного вмешательства тоже зависит от получателя № 1, но эта зависимость учитывалась и рашее)

   17.02.2016 Сухова - Без Sel023
   ------------------------------------------------------------------------------------------------------
   09.02.2016 Sta COBUSUPABS-4180 Спец.перекриття для 2603
   18.12.2015р. №1086 «Про внесення змін до постанови Каб.Мін.Укр. від 18 червня 2014р. №217» (далі – Постанова №1086),
*/

 -------------------------------------------
 procedure UPD (p_acc number, p_sa number)  is
 begin update T2603 set sr = nvl(sr, 0), sa = nvl(p_sa,0) *100 where acc = p_acc;
       if SQL%rowcount = 0 then insert into t2603 (acc, sr, sa) values ( p_acc, 0, p_sa *100 ) ;  end if;
 end ;
 -------------------------------------------
 procedure PREV (p_IDG int) is
    l_IDG int    ;
    S_    number ;
    Del_  number ;
    PLN_  number ;
    FKT_  number ;
    REF_  number ;
 begin
    logger.info ('P2603 IDG'||to_char(p_IDG));
    If p_idg is null then   l_IDG := to_number ( pul.Get_Mas_Ini_Val('IDG') );
    else                    l_IDG := p_IDG ;
    end if;

    EXECUTE IMMEDIATE ' truncate  table   KRYM_GAZT ';

    --- курсор по счету -А - платнику
    For A in ( select s.ACC, s.IDS, KAZ(s.sps,s.acc) OST, u.nls, u.kv, substr(u.nms,1,38) nms, c.okpo
               from specparam s, accounts u , customer c
               where c.rnk = u.rnk  and u.acc = s.acc and s.idg = l_IDG
                 and U.OSTB > 0     and KAZ(s.sps,s.acc) > 0
                 and u.OSTB >= KAZ(s.sps,s.acc)
              )

    loop

       --дельта округления
       select A.OST - sum ( round ( ( A.ost * nvl(koef,0) ) , 0) ) into Del_ from perekr_b where ids = A.ids ;

       FKT_ := 0 ;  -- фактическая сумма ручн вмеш
       PLN_ := 0 ;  -- плановая сумма ручного вмешательства
       --- курсор по счету -Б - получателю
       For B in (select * from perekr_b where ids = A.ids  order by Nvl(ord,3), koef )
       loop
          S_ := round( nvl(B.koef,0) * A.OST ,0 ) ; ---- сумма к оплате без ручного вмешательства

          If    B.ORD  = 1 then                     ---- если № 1, то надо снять сумму ручного вмешательства

                -- плановая сумма ручного вмешательства
                begin  select nvl(sa,0)*( 1-B.koef) + nvl(sr,0) into PLN_ from T2603 where acc = A.acc;
                exception when no_data_found then        PLN_ := 0 ;
                end ;

                FKT_  := least ( S_, PLN_ ) ;       ---- фактически-возможная  сумма ручн вмеш
                S_    := S_ - FKT_ ;

          elsIf B.ORD  = 2 then                     ---- если № 2, то надо добавить сумму ручного вмешательства
                S_    := S_ + FKT_ ;
                update t2603 set sr = PLN_ - FKT_, sa = 0 where acc = A.acc ;  ---- разницу между плaн и факт запомнить "на завтра"
                FKT_  := 0;                         ---- и продолжить спокойно работу по всем остальным
          end if;
----------------------
          If S_ <> 0 and Del_ <> 0 then             ---- добавить дельту округления первому ненулевому
             S_  := S_ + Del_;
             Del_:= 0 ;
          End if;
            
          If S_ > 0 then                            ---- вставить проводку
             gl.REF(REF_);
             gl.in_doc3
              (ref_  => REF_,   tt_   => B.tt  , vob_ => 6   , nd_  => substr(B.id,1,10), pdat_=> SYSDATE , vdat_=> gl.BDATE,  dk_=> 1,
               kv_   => a.KV,   s_    => S_    , kv2_ => a.KV, s2_  => s_,   sk_ => null, data_=> gl.BDATE, datp_=> gl.bdate,
               nam_a_=> a.nms,  nlsa_ => a.nls , mfoa_=> gl.aMfo,
               nam_b_=> B.polu, nlsb_ => B.nlsb, mfob_=> B.mfob , nazn_ => B.nazn,
               d_rec_=> null  , id_a_ => A.okpo, id_b_=> B.okpo , id_o_ => null, sign_=> null, sos_=> 1, prty_=> null, uid_=> null);
             paytt (0, REF_,  gl.bDATE, B.TT,  1, a.kv, a.nls, s_, a.kv, B.nlsb, s_  );
          end if;
          logger.info ('P2603 REF: '||to_char(REF_));  
       end loop; -- курсор B
    end loop; -- курсор A

end PREV;
------------------------------------

end p2603;
/
 show err;
 
PROMPT *** Create  grants  P2603 ***
grant EXECUTE                                                                on P2603           to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/p2603.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 