

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NOAKT2620.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NOAKT2620 ***

  CREATE OR REPLACE PROCEDURE BARS.NOAKT2620 (p_dat date) is

--15.11.2017 Трансфер-2017  6110.F1 => 6510.F1

  nbs_  accounts.nbs%type  := '6110';
  ob22_ accounts.ob22%type := 'F1'  ;

  ss_   number             := 3000  ;  --  30 грн за "неактивность"
  nn_   integer :=0;
  vob_kv integer   ;

  dat01_ date      ;
  ref_   number    ;
  oo oper%rowtype  ;
  yyyy_  char(4)   ;
  Ndat_  date      ;

  br_ varchar2(15) := '****';
  kv_ int          := -1    ;

  l_Bdat_Real date ;
  l_Bdat_Next date ;
  mes    varchar2(10) ;
  god    varchar2(4 ) ;
  n_mes  int          ;
  okpoA_ varchar2(12) ;
  Itog_     number    ;
  Itog_val  number    ;
  n_Count number := 0 ;
  l_deposit_id dpt_deposit.deposit_id%type;

BEGIN

   begin select r020, ob22 into nbs_, ob22_  from sb_ob22 where r020||ob22 in ('6110F1','6510F1') and d_close is null and rownum = 1 ;
   EXCEPTION WHEN NO_DATA_FOUND then     raise_application_error( -20100,'Не знайдено діючої аналітики для 6_10.F1')  ;
   END ;



-------   1.  Ежедневно-выполняемая часть:   ----------------------


---  Внесение вновь-открытых счетов 2620/05 в ACC262005:

 For k in ( Select ACC,DAPP From ACCOUNTS
            WHERE  NBS='2620'   and  OB22='05'
               and DAZS is NULL
               and ACC not in (Select ACC from ACC262005)
          )
 Loop
    INSERT INTO ACC262005 (ACC,DAPP_REAL) values (k.ACC,k.DAPP);
 End Loop;


---  Корректируем в ACC262005 поле DAPP_REAL по счетам, которые
---  сегодня имели "клиентские" движения:

-- For k in ( Select a1.ACC acc2620,  a2.NLS,  o2.TT
--            from   opldok o1, opldok o2, accounts a2, accounts a1
--            where    o1.acc=a1.acc and a1.NBS='2620' and a1.OB22='05' and a1.DAPP=gl.BDATE
--                 and o2.acc=a2.acc
--                 and o1.stmt=o2.stmt
--                 and o1.dk=0 and o1.SOS=5
--                 and o2.dk=1 and o2.SOS=5
--                 and o1.fdat=gl.BDATE
--                 and o2.fdat=gl.BDATE
--                 and a2.NLS not like '6%'      ----  a2.NLS - счет-корреспондент
--                 and a2.NLS not like '2628%'
--                 and a2.NLS not like '2638%'
--                 and o2.TT  <> 'N12'
--                         union all
--            Select a1.ACC acc2620,  a2.NLS,  o2.TT
--            from   opldok o1, opldok o2, accounts a2, accounts a1
--            where    o1.acc=a1.acc and a1.NBS='2620' and a1.OB22='05' and a1.DAPP=gl.BDATE
--                 and o2.acc=a2.acc
--                 and o1.stmt=o2.stmt
--                 and o1.dk=1 and o1.SOS=5
--                 and o2.dk=0 and o2.SOS=5
--                 and o1.fdat=gl.BDATE
--                 and o2.fdat=gl.BDATE
--                 and a2.NLS not like '6%'
--                 and a2.NLS not like '2628%'
--                 and a2.NLS not like '2638%'
--                 and o2.TT  <> 'N12'
--         )
--
-- Loop
--
--    Update ACC262005 set DAPP_REAL = gl.BDATE where ACC = k.acc2620;
--
-- End Loop;


-------   2.  Выполняется в посл.раб.день месяца:      --------------
-------       (порождение проводок по комис. и закр.счетов)


  l_Bdat_Real := nvl( p_dat,gl.BDATE);
  l_Bdat_Next := DAT_NEXT_U (l_Bdat_Real,1); -- cледующий раб.день


---- Контроль на посл.раб.день месяца:
  If not to_number(to_char(l_Bdat_Next,'YYMM')) > to_number(to_char(l_Bdat_Real,'YYMM')) then
     RETURN ;
  End If;


---- Защита от повторного выполнения в один и тот же день:
  Select count (*) into nn_
  from   OPER
  where  VDAT=gl.BDATE and TT='N12' and SOS=5 ;
  if nn_ > 0 then
     Return ;
  end if;


  Select to_char(l_Bdat_Real, 'MM')   into n_mes from dual;
  Select to_char(l_Bdat_Real, 'YYYY') into god   from dual;

  if     n_mes='01' then  mes:='СIЧЕНЬ'  ;
  elsif  n_mes='02' then  mes:='ЛЮТИЙ'   ;
  elsif  n_mes='03' then  mes:='БЕРЕЗЕНЬ';
  elsif  n_mes='04' then  mes:='КВIТЕНЬ' ;
  elsif  n_mes='05' then  mes:='ТРАВЕНЬ' ;
  elsif  n_mes='06' then  mes:='ЧЕРВЕНЬ' ;
  elsif  n_mes='07' then  mes:='ЛИПЕНЬ'  ;
  elsif  n_mes='08' then  mes:='СЕРПЕНЬ' ;
  elsif  n_mes='09' then  mes:='ВЕРЕСЕНЬ';
  elsif  n_mes='10' then  mes:='ЖОВТЕНЬ' ;
  elsif  n_mes='11' then  mes:='ЛИСТОПАД';
  elsif  n_mes='12' then  mes:='ГРУДЕНЬ' ;
  end if;


 --------------------------------------
 OP_BS_OB  (P_BBBOO => NBS_||OB22_ ) ; -- заведомое открытие 6110/F1
 --------------------------------------
 dat01_  := trunc( gl.bdate, 'yyyy');
 yyyy_   := to_char( dat01_, 'yyyy');
 oo.nazn := 'Списання комісійної винагороди за обслуговування неактивних поточних рахунків фізичних осіб за '||mes||' '||god||' р';
 oo.tt   := 'N12';
 oo.nd   := nbs_||ob22_||yyyy_;
 Ndat_   := DAT_NEXT_U (gl.bdate,1) ;
 oo.ref  := null;




 Execute immediate 'Alter trigger TBIU_ACCOUNTS_DESTRUCT_PASSP Disable';
---- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

----  a.KV not in (959,961) and


 FOR k in (Select a.* from Accounts a, Acc262005 b, Person p
            Where  a.ACC = b.ACC  and
                   a.NBS = '2620' and a.OB22='05' and  a.KV = 980  and
                   a.DAZS is null and                  ----------
                   nvl(b.DAPP_REAL,a.DAOS) < gl.BDATE - 365 and
                   a.rnk=p.rnk           and
                   a.OSTC > 0  and  a.BLKD = 0  and  a.LIM = 0  and
                   case when p.BDAY<sysdate then sysdate-p.BDAY else 6571 end
                   >6570
            Order by substr(a.BRANCH,1,15), a.KV
          )
 LOOP

   BEGIN

      If k.kv = 980 then
         oo.s  := least(ss_ , k.ostc);
         oo.s2 := oo.s ;
      else
         oo.s  := least(gl.p_Ncurval(k.kv,ss_,gl.bdate), k.ostc);
         oo.s2 := gl.p_Icurval(k.kv, oo.s, gl.bdate);
         if oo.s2 > ss_ then
            oo.s  := least(gl.p_Ncurval(k.kv,ss_,gl.bdate), k.ostc)-1;
            oo.s2 := gl.p_Icurval(k.kv, oo.s, gl.bdate);
         end if;
      end if;

      --- k.ostc := k.ostc - oo.s;   -- будет остаток после снятия штрафа

      If br_ <> substr(k.branch,1,15) OR kv_ <> k.kv then

         -- Сформировать итог по бранчу-2 и вал. завизировать
         If oo.ref is not null then
            update OPER set s2 = Itog_ , s = Itog_val, kv = kv_, nlsa ='2620/05',
                            nam_a = 'Поточні рахунки фізичних осіб',
                            TOBO = br_
                   where  ref = oo.ref;
            gl.pay  (2, oo.REF, gl.bDATE );
         end if;

         oo.ref := null;
         br_    := substr(k.branch,1,15) ;
         KV_    := k.kv ;
         Begin select nls, substr(nms,1,38) into oo.nlsb, oo.nam_b from accounts
               where nbs = nbs_ and ob22= ob22_ and branch like br_||'%' and dazs is null and kv =gl.baseval and rownum = 1;
         EXCEPTION WHEN NO_DATA_FOUND then  null;
         end ;
      end if ;

      Begin  select OKPO into okpoA_  from Customer where RNK=k.rnk;
      EXCEPTION WHEN NO_DATA_FOUND then     okpoA_ := null;
      end ;

      if oo.ref is null then
         -- приготовиться к новому референсу = итогу то бранчу-2 +вал
         Itog_val := 0 ;
         Itog_    := 0 ;
         gl.ref (oo.REF);

         if k.kv = 980 then
            vob_kv :=  6 ;
         else
            vob_kv := 13 ;
         end if;

         gl.in_doc3(ref_=> oo.REF ,tt_=> oo.tt, vob_=> vob_kv,  nd_ => oo.nd,  pdat_ => SYSDATE,  vdat_=> gl.BDATE,  dk_ => 1,
                    kv_ => k.kv   ,s_ => oo.S , kv2_=> gl.baseval, s2_=> oo.S2  ,sk_ => null,data_=> gl.BDATE, datp_=> gl.bdate  ,
                  nam_a_=> substr(k.nms,1,38), nlsa_=> k.nls,   mfoa_ => gl.aMfo,
                  nam_b_=> oo.nam_b,           nlsb_=> oo.nlsb, mfob_ => gl.aMfo,nazn_ => oo.nazn,d_rec_=> null,
                  id_a_ => okpoA_, id_b_=> gl.aOKPO, id_o_=> null, sign_=>null, sos_=>1, prty_=> null,  uid_  => null );

      end if;

      Itog_val :=  Itog_val + oo.S ;
      Itog_    :=  Itog_    + oo.S2;

      savepoint DO_OPLATA;
      --------------------
      begin
         gl.payv( 0, oo.REF, gl.bDATE, oo.tt, 1, k.kv, k.nls, oo.s, gl.baseval,  oo.nlsb, oo.s2);
         n_Count :=  n_Count + 1 ;
      exception when others then
         rollback to DO_OPLATA;
         ----------------------
      end;

      If n_Count >= 200 then  COMMIT;  n_Count := 0 ;  end if;


   EXCEPTION when OTHERS then
     BARS_AUDIT.INFO('NoAkt2620 дата: '||p_dat||' помилка сплати за рахунком: '||k.nls);  --  вставить запись в LOG о "пропуске" счета
   END;

 End LOOP;


 -- Итог по последней
 Update OPER set s2 = Itog_ , s = Itog_val, kv = kv_, nlsa ='2620/05',
        nam_a = 'Поточні рахунки фізичних осіб',
        TOBO = br_
      where  ref = oo.REF;

 gl.pay  (2, oo.REF, gl.bDATE );


 COMMIT;

 ------------------------------------------------------------------------------------------------
 ---  Проставляем метку на ЗАКРЫТИЕ ДОГОВОРА по тем счетам, по которым
 ---  OSTC=0 и не было клиентских оборотов больше 3-ех лет (3*365=1095)
 ---  Если cчета нет в DPT_DEPOSIT, то просто проставляем DAZS=BDATE.


 For k in ( Select a.ACC, a.NLS, a.KV, nvl(b.DAPP_REAL,a.DAOS) D_REAL
            from   Accounts a, Acc262005 b
            Where  a.ACC = b.ACC  and
                   a.NBS='2620'   and  a.OB22='05' and  a.KV = 980  and
                   a.DAZS is null and                   ----------
                   a.OSTC=0       and  a.OSTB=0    and
                   nvl(b.DAPP_REAL,a.DAOS) < gl.BDATE - 3*365
          )
 Loop


   bars_audit.info('NOAKT2620_05: закрывается '||k.NLS||'/'||to_char(k.KV)||', D_REAL='||to_char(k.D_REAL,'dd.mm.yyyy')||', gl.BDATE='||to_char(gl.BDATE,'dd.mm.yyyy') );

   BEGIN

     Select deposit_id
       into l_deposit_id
       from DPT_DEPOSIT
      where acc = k.acc;

     Begin

       Update DPT_DEPOSITw
          set value = 'Y'
        where dpt_id = l_deposit_id
          and tag = '2CLOS';

       if sql%rowcount = 0  then
           Insert into DPT_DEPOSITw (dpt_id, tag, value)
                             values (l_deposit_id, '2CLOS', 'Y');
       end if;

     End;

   EXCEPTION when OTHERS then

     Update Accounts set DAZS = gl.BDATE where ACC = k.ACC and  DAPP < gl.BDATE;

   END;

 End Loop;


 Execute immediate 'Alter trigger TBIU_ACCOUNTS_DESTRUCT_PASSP Enable';
---- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

END NoAkt2620;
/
show err;

PROMPT *** Create  grants  NOAKT2620 ***
grant EXECUTE                                                                on NOAKT2620       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NOAKT2620       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NOAKT2620.sql =========*** End ***
PROMPT ===================================================================================== 
