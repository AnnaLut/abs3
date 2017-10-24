

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CC_ISG.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CC_ISG ***

  CREATE OR REPLACE PROCEDURE BARS.CC_ISG ( p_nd int, p_tip varchar2 ) is

  -- разбор счета с типом ISG (3600) - ХЛОПУШКА

  -- p_nd = 0 - для всех КД, у которых есть условия для хлопушки
  -- p_nd = реф.КД - для одного, если у него есть условия для хлопушки

  -- p_tip - указываются типы в последовательности в которой необходимо
  --         их разбирать. Вид строки - SPN,SN ,SK9,SK0
  --         Можно указать до 5 вкл типов счетов


  SA_ number;
  -----------
  ref_  oper.REF%type  ;
  S_    oper.S%type    ;
  NAZk_ oper.NAZN%type :=
--       'Погашення нарахованих та сплачених вiдсоткiв згiдно з умовами КД ';
         'Погашення нарахованих доходів згiдно з умовами КД ';
  NAZN_ oper.NAZN%type ;
  id_a_ oper.id_a%type ;
  tt_   oper.tt%type   := 'ASG';
  vob_  oper.vob%type  := 6    ;
  L_VIDD number;
  FLG_  int;
begin


   begin
   select substr(flags,38,1)
      into FLG_
      from tts
      where tt='ASG';
   EXCEPTION WHEN NO_DATA_FOUND THEN
    raise_application_error(-(20000+17),'\8999 CCK.CC_ISG: не найдена операция ASG', TRUE );
    logger.trace('CCK.CC_ISG: не найдена операция ASG');
   end;



If      p_ND = -1   then   L_VIDD :=  1  ;
 elsIf  p_ND = -11 then    L_VIDD := 11  ;
 else                      L_VIDD := null;
 end if;

  --цикл-1 . По КД
  for d in (select n.nd, a.NLS, a.kv, substr(a.nms,1,38) NMS, a.ostc
            from nd_acc n, accounts a ,cc_deal d
            where
              ( L_VIDD= 1 and D.VIDD in ( 1, 2, 3)
                OR   L_VIDD=11 and D.VIDD in (11,12,13) OR d.nd=decode (p_nd, 0, n.nd, p_nd))
              and d.nd=n.nd
              and a.acc  = n.acc
              and a.tip  = 'ISG'
              and a.ostc = a.ostb
              and a.ostc > 0
--              and not exists (select 1 from nd_acc n,accounts a
--                               where n.acc=a.acc and a.tip='SG ' and a.ostc!=0)
              )
  loop
     -- имеем счет-дебет
     SA_  := d.OSTC;
     ref_ := null;

     -- цикл-2. ищем счета нач.процентов (кредит). Их м.б несколько по одному КД
     for k in (select  a.tip, a.NLS, substr(a.nms,1,38) NMS, a.ostc
               from nd_acc n, accounts a, specparam s
               where n.nd  = d.nd
                 and a.acc = n.acc
                 and a.kv  = d.kv
                 and a.tip in (substr(p_TIP,1, 3),substr(p_TIP,5, 3),substr(p_TIP,9, 3),substr(p_TIP,13,3),substr(p_TIP,17,3))
                 and a.ostc = a.ostb
                 and a.ostc < 0
                 and a.acc=s.acc(+)
               order by decode(a.tip,substr(p_TIP,1, 3),1,
                                     substr(p_TIP,5, 3),2,
                                     substr(p_TIP,9, 3),3,
                                     substr(p_TIP,13,3),4,
                                     substr(p_TIP,17,3),5
                               ,9),
                        decode(a.tip,'SPN',s.r013,'SN ',s.r013,null) desc nulls last,
                        a.nlsalt nulls last,
                        a.nls desc
                )
     loop

        S_ := least ( SA_, -k.ostc );

        if S_ > 0 then

           If REF_ is  null then
              begin
                select '№ '||e.CC_ID||' вiд ' || to_char(e.SDATE,'dd.mm.yyyy'),
                       c.okpo
                into NAZN_, id_a_
                from cc_deal e, customer c
                where e.nd = d.ND and e.rnk=c.rnk ;
              EXCEPTION WHEN NO_DATA_FOUND THEN
                NAZN_ := null; id_a_ := null;
              end;
              NAZN_ := substr( nazk_ || nazn_, 1, 160) ;

              GL.REF (REF_);
              GL.IN_DOC3 ( REF_,  TT_,  vob_,  REF_,SYSDATE, GL.BDATE,1,
                          d.KV, S_, d.KV, S_, null,GL.BDATE,GL.BDATE,
                          d.NMS, d.NLS, gl.AMFO, k.NMS, k.NLS, gl.AMFO, NAZn_,
                          NULL,id_a_,id_a_,null, null,0,null, null );
           end if;

           -- обычная плоская проводка
           GL.PAYV(FLG_,REF_,GL.BDATE, TT_,1, d.KV, d.NLS, S_, d.KV, k.NLS, S_);
           SA_ := SA_ - S_;
        end if;

     end loop;  -- цикл k по счетам долга

     -- оплата по факту
--     If REF_ is not null then
--        gl.pay(2,REF_,gl.bDATE);
--     end if;

  end loop;

end CC_ISG;
/
show err;

PROMPT *** Create  grants  CC_ISG ***
grant EXECUTE                                                                on CC_ISG          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_ISG          to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CC_ISG.sql =========*** End *** ==
PROMPT ===================================================================================== 
