CREATE OR REPLACE PROCEDURE BARS.SPOT_p ( Mode_ int, dat_ date DEFAULT gl.bdate) IS
 /*
  13.09.2017 Sta COBUMMFO-4222.sql 
   Середньо-зважені курси НЕ можуть бути одночасно і Купівлі, і Продажу. 
   Бо це повинно відповідати знакові рах.ВАЛ.поз. за цей день. а він лише ОДИН.
   Очевидно, колись було зроблено проводку, що змінила знак, а курс не було перекраховано.

   1) Скриваємо в довіднику одну колонку. залишаємо тільки ОДНУ і називаємо її просто "СЕРДНЬО_зважений курс надбанні вал.поз"
   2) для того. щоб ВСІ програми спрацьвували коректно дублюємо обидві колонки однаковим значенням
   скриптом    - минулі дати.   в процедурі - майбутні дати
  -----------------
  15.11.2016 Sta Для ММФО. Поддержка по своему МФО
  31-07-2009 Специально для ОБ
   Без учета операций БМ*   Без проводки при изменении знака (или обнуления) ВАЛ.Поз.
  05.11.2007 По методике НБУ, которая начинает действовать с 01.01.2006
*/

  like_ varchar2(9);
  SN_   number; SN1_ number; SI_  number; KV1_ int; KV2_ int;  S1_   number; S2_  number;   DK_ int; 
  K980 int :=gl.baseval;  NLS_3800 varchar2(15);
BEGIN
  like_ := '/' || gl.aMfo || '/%' ;

  If Mode_ = 0 then   DELETE from SPOT where vdate = DAT_ and branch like like_ ; end if ;  -- Поддержка по своему МФО

  -- Превентивно доплатити пакетні проводки
  gl.paysos0;
  commit;
   
  FOR X IN (select a.kv, c.acc, nvl(GREATEST(c.rate_k, c.rate_p),0)  RATE, s.ostf VX, s.DOS, s.KOS, s.ostf-s.dos+s.kos ISX , a.NLS, a.branch 
             from spot C, saldoa s, accounts a 
             where c.branch like like_ and c.vdate = (select max(vdate) from SPOT  where acc=c.acc AND vdate < DAT_ ) and s.acc= c.ACC and s.fdat = DAT_ and a.acc = c.ACC )
  LOOP  -- Если изменился знак ВП или если были операции, которые увеличили ВП
     If x.ISX <> 0 then
        if sign (x.VX) <> sign(x.ISX) OR x.VX > 0 and x.ISX > 0 and x.KOS > 0 OR  x.VX < 0 and x.ISX < 0 and x.DOS > 0   then
           SN_ := 0 ; SI_ := 0 ; SN1_ := 0 ;    If x.ISX > 0 then  DK_ := 1 ; else  DK_ := 0 ;  end if ;

           FOR k in (select o.tt, o.dk, o.nlsa, o.nlsb,  p.S, o.kv KV1, o.kv2, o.s S1, o.S2, o.REF
                     from opldok p, oper o  where p.acc = X.ACC and p.ref = o.ref and p.sos = 5 and p.fdat = DAT_ and p.dk = DK_ and p.S > 0 )
           LooP
              If    k.S not in (k.S1,k.S2) or X.KV not in (k.KV1,k.KV2) or 960 in (k.KV1,k.KV2)   then  SN1_ := gl.p_icurval(x.kv,k.S,DAT_) ;  -- дочерняя валютооб операция
              ElsIf X.KV = k.KV1 and k.kv2 = K980                                                 then  SN1_ := k.S2  ;                        -- родительская покупка-продажа за грн
              ElsIf X.KV = k.KV2 and k.kv1 = K980                                                 then  SN1_ := k.S1  ;                        -- родительская покупка-продажа за грн
              Else  If x.KV = k.KV1  then  KV2_ := k.KV2 ; S2_ := k.S2 ;  else   KV2_ := k.KV1 ; S2_ := k.S1 ; end if ;                        -- конверсия
                    If x.VX = 0 and x.ISX > 0 OR x.VX < 0 and x.ISX < 0                           then  SN1_ := gl.p_Icurval(x.KV,k.S,DAT_);   -- з закритої перейшла в довгу  або залишилась короткою 
                    else  begin select Round(S2_*c.rate_k,0)                                      into  SN1_    from spot c, accounts a
                                where a.nls=NLS_3800 and a.kv=c.kv and c.acc=a.acc and c.rate_k>0 and c.kv=KV2_ and c.vdate = (select max(vdate) from SPOT where kv=c.kv and acc=c.acc AND vdate<DAT_);
                          EXCEPTION  WHEN NO_DATA_FOUND THEN                                            SN1_ := gl.p_Icurval(x.KV,k.S,DAT_);
                          end;
                    end if;
              end if;
                SI_ := SI_ + k.S ;  SN_ := SN_ + SN1_ ;
           end loop;  -- k
           ---------------------------
           If    x.VX > 0 and x.ISX >  0  then x.RATE := (x.RATE*x.VX + SN_)/ (x.VX+SI_);         -- сохран длинная  ++ 
           elsIf x.VX = 0 and x.ISX >  0  then x.RATE := SN_/ SI_;                                -- от 0 к длинной  0+  
           elsIf x.VX < 0 and x.ISX >= 0  then 
              If x.ISX> 0                 then x.RATE := SN_/ SI_;  else  x.RATE := 0 ; end if ;  -- изменилась из короткой на длин -+ 
           ElsIf x.VX < 0 and x.ISX <  0  then x.RATE := (x.RATE*(-x.VX) + SN_)/ (-x.VX+SI_) ;    -- сохран короткая   --   
           elsIf x.VX = 0 and x.ISX <  0  then x.RATE := SN_/ SI_;                                -- от 0 к короткой   0- 
           elsIf x.VX > 0 and x.ISX <= 0  then 
              If x.ISX< 0                 then x.RATE := SN_/ SI_;  else  x.RATE := 0 ;  end if ; -- изменилась из длин на короткую +-  
           end if;
        end if;
     else                                      x.RATE := 0;          
     end if;

     if mode_= 0 then  INSERT into SPOT (kv,acc,vdate,RATE_k,rate_p, branch)  values (x.KV,X.acc,DAT_,x.RATE,x.RATE, x.branch );    end if;

  END LOOp;  -- x
------------
END SPOT_p;
/
Show err;
