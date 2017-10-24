

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DENOM_KV.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DENOM_KV ***

  CREATE OR REPLACE PROCEDURE BARS.DENOM_KV ( p_KVO int, p_KVN int, p_dat01 date, p_K number ) is

/* ***************************
http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-4613  белорусский рубль дорожает, демонетизация.
Я на эту тему говорила с Притупом. Полностью уточнили алгоритм :
•	Все счета , где есть стар. бел.руб, дооткрываем синхронно, типа мультивалютно в новый бел.руб.
•	В том числе и счета вал поз.
•	остатки перебрсываем через ВАЛ, деноминировав номинал и сохранив экв.
•	Все по стар.бел.руб должно обнулиться.
•	Закрываем счета стар. бел.руб.
Скрипт сделаю я сама.

 Постанова НБУ від 19.04.2016 р. №269  з 01.07.2016 р. буде змінено цифровий та літерний коди  білоруського рубля.
 Указ Президента Республіки Білорусь від 04.11.2015 р. №450.
 замінити цифровий та літерний коди  білоруського рубля з 974 (BYR)   на  933 (BYN) .
 Вимагає  реалізації до 29 червня
 Вик. Старкова К.Б.	 (044) 247-86-90  вн. 76-90



Предварительно НЕОБХОДИМО
1) урегулировать все остатки ( план = факт. форв = 0)
   Select * from accounts where kv = 974 and (ostc <> ostb or ostf <>0 ) ;
2) Взять на контроль кассу       - провести обмен купюр в новой валюте
3) Взять на контроль ностро 1500 - получить выписку в новой валюте из ИНОБАНКА
4) Взять на контроль ностро 3900 - получить выписку в новой валюте из ГРЦ
5) Взять на контроль незакрытых Дебиторов/Кредиторов  - вы их будете закрывать уже в новой валюте !

***************************
*/

  nTmp_ number;  sTmp_ varchar2(100); dTmp_ date;  ACC_ number ;  aa accounts%rowtype; bb accounts%rowtype;  oo oper%rowtype ;
  nls_3800 varchar2(15);
begin

  begin  SUDA ;
     Insert into TABVAL$GLOBAL   (KV, GRP, NAME, LCV, NOMINAL,          SV, DIG, UNIT, COUNTRY, BASEY,   GENDER, DENOM, PRV, COIN)
                      Values ( p_KVN, 3, 'Білоруський рубль', 'BYN', 1, '1', 2, 'коп', 112,     3,      'M',     100,    0,   1);
     update TABVAL$GLOBAL set sv = null where kv = p_kvO;
  exception when dup_val_on_index then null;
  end;

  -- а есть ли необходимость это вообще делать ?
  begin Select * into aa from accounts where kv = p_KVO and ostc <> 0 and rownum =1 ;
  exception when no_data_found then      raise_application_error(-20203, ' Відсутні залишки по '|| p_kvo);
  end;

  -- а готовы ли мы это вообще делать ?
  begin Select * into aa from accounts where kv = p_KVO and (ostc <> ostb or ostf <>0 ) and rownum =1 ;
        raise_application_error(-20203, aa.nls||' Не врегульовано залишки (ostc <> ostb or ostf <>0 )' ) ;
  exception when no_data_found then null;
  end;

  bc.go(f_ourmfo_g); -- TUDA;  gl.aUID := 20094;

  nTmp_ := p_k * gl.p_icurval(p_kvO, 10000000000, gl.bdate) / 10000000000 ;
  begin Insert into TABVAL$LOCAL   (KV, SKV, S0009) select p_KVN , skv, S0009 from TABVAL$LOCAL where kv = p_KVO;
        Insert into CUR_RATES$BASE (KV,VDATE,BSUM,RATE_O,BRANCH,OTM,OFFICIAL) Values  (p_KVN,gl.bdate,1,nTmp_,'/'||gl.Amfo||'/', 'Y', 'Y');
  exception when dup_val_on_index then null;
  end;

-- 1) Открыть счета co спец.пар
For k in (select * from accounts where kv = p_KVO and dazs is null)
loop

  if k.OStC = 0 and (k.dapp is null or k.dapp < p_dat01) then  -- Закрыть недвижимые
     update accounts set dazs = gl.bdate where acc = k.acc;
  Else ---------------------------------------------------- Открыть новые
     --1) откытие счетов - accounts

     If k.nbs is null then sTmp_ := null; else sTmp_:= '1'; end if;
     Op_Reg_Ex (99,0,0,k.grp, nTmp_, k.rnk, k.nls, p_KVN, k.nms, k.tip, k.isp, ACC_,
                sTmp_, k.pap, k.vid, k.pos, null, null, null, k.blkd, k.blkk,   ROUND(k.lim/p_k,0), ROUND(k.ostx/p_k,0), k.nlsalt, k.branch, k.accc );

     -- разные параметры
     Update accounts set mdate = k.mdate where acc =  ACC_;
     update cc_add   set  accS = ACC_    where accs = k.acc;
     update cc_add   set  accP = ACC_    where accP = k.acc;

     begin  insert into nd_acc    (acc,nd )                   select ACC_, ND                    from nd_acc    where acc = k.acc;
     exception when dup_val_on_index then null;
     end;

     begin insert into ACCOUNTSP (ACC,DAT1,DAT2,PARID,VAL)   select ACC_, DAT1,DAT2,PARID,VAL   from ACCOUNTSP where acc = k.acc and DAT2  >= gl.Bdate  ;
     exception when dup_val_on_index then null;
     end;

     begin insert into BIC_ACC   (ACC,bic,TRANSIT,THEIR_ACC) select ACC_, bic,TRANSIT,THEIR_ACC from BIC_ACC   where acc = k.acc;
     exception when dup_val_on_index then null;
     end;

     begin insert into BANK_ACC  (ACC,MFO)                   select ACC_, mfo                   from BANK_ACC  where acc = k.acc;
     exception when dup_val_on_index then null;
     end;

     begin insert into ACCOUNTSW (ACC,TAG,VALUE) select ACC_, TAG, VALUE from ACCOUNTSW where acc = k.acc ;
     exception when dup_val_on_index then null;
     end;

     If k.ostc < 0 then -- создать дату возникновения реальной деб задолж
        dTmp_ :=  DAT_SPZ( k.acc, null, 0) ;
        sTmp_ :=  to_char( dTmp_, 'dd/mm/yyyy');
        update ACCOUNTSW Set value = sTmp_ where acc = ACC_ and  tag = 'DATVZ' ;
        if SQL%rowcount = 0 then  insert into ACCOUNTSW (ACC,TAG,VALUE) values (ACC_, 'DATVZ', sTmp_ ) ; end if ;
     end if;

     begin insert into pawn_acc (ACC ,PAWN,MPAWN,NREE,IDZ,NDZ,DEPOSIT_ID,SV, CC_IDZ,SDATZ)
                     select ACC_,PAWN,MPAWN,NREE,IDZ,NDZ,DEPOSIT_ID,SV, CC_IDZ,SDATZ from pawn_acc where acc= k.acc ;
     exception when dup_val_on_index then null;
     end;


     begin INSERT INTO specparam(ACC ,R011,R013,S080,S180,S181,S190,S200,S230,S240,D020 ,S120 ,S130,S250,NKD ,S031,S182,ISTVAL,R014,K072,S090,S270,S260,K150,R114,S280,S290,S370,D1#F9,NF#F9,Z290,DP1 ,R012,S580,R016 )
                          select ACC_,R011,R013,S080,S180,S181,S190,S200,S230,S240,D020 ,S120 ,S130,S250,NKD ,S031,S182,ISTVAL,R014,K072,S090,S270,S260,K150,R114,S280,S290,S370,D1#F9,NF#F9,Z290,DP1 ,R012,S580,R016
                          from  specparam      where acc = k.acc;
     exception when dup_val_on_index then null;
     end;

     begin INSERT INTO specparam_int(ACC ,P080,OB22,MFO,R020_FA,KOR,DEB01,DEB02,DEB03,DEB04,DEB05,DEB06,DEB07,F_11,OB88,DD,RR,TYPNLS )
                              select ACC_,P080,OB22,MFO,R020_FA,KOR,DEB01,DEB02,DEB03,DEB04,DEB05,DEB06,DEB07,F_11,OB88,DD,RR,TYPNLS from  specparam_int  where acc = k.acc;
     exception when dup_val_on_index then null;
     end;

  end if ;

  -- ностро-портфель
  begin  If k.nbs ='1500' then prvn_flow.NOS_INS ( p_KVn, k.NLS ); end if;  exception when others then null; end;


END LOOP ;

INSERT INTO CORPS_ACC(ID,RNK,MFO,NLS,   KV,COMMENTS,SW56_NAME,SW56_ADR,SW56_CODE,SW57_NAME,SW57_ADR,SW57_CODE,SW57_ACC,SW59_NAME,SW59_ADR,SW59_ACC)
               select S_CORPS_ACC.NEXTVAL,
                         RNK,MFO,NLS,p_KVn,COMMENTS,SW56_NAME,SW56_ADR,SW56_CODE,SW57_NAME,SW57_ADR,SW57_CODE,SW57_ACC,SW59_NAME,SW59_ADR,SW59_ACC
               from  CORPS_ACC
               where kv =p_kvo and not exists (select 1 from CORPS_ACC where kv = p_kvn);
-------------------------------------------

-- Связи между АСС по в конец. когда уже все сч открыты

-- зaлоги
INSERT INTO cc_accp ( ND,   ACCS,   pr_12,         ACC )
             select p.nd, p.accs, p.pr_12, (select ACC from accounts where kv=p_KVN and nls=z.nls)  ACC
             FROM (select * from accounts where kv= p_KVO) z, (select * from accounts where kv<>p_KVO) s, cc_accp p where p.acc=z.acc and p.accs=s.acc
union all    select p.nd, (select ACC from accounts where kv=p_KVN and nls=s.nls) ACCS, p.pr_12, p.ACC
             FROM (select * from accounts where kv<>p_KVO) z, (select * from accounts where kv= p_KVO) s, cc_accp p where p.acc=z.acc and p.accs =s.acc
union all    select p.nd, (select ACC from accounts where kv=p_KVN and nls=s.nls) ACCS, p.pr_12, (select ACC from accounts where kv=p_KVN and nls=z.nls) ACC
             FROM (select * from accounts where kv= p_KVO) z, (select * from accounts where kv= p_KVO) s, cc_accp p where p.acc=z.acc and p.accs =s.acc ;

--проц. карточки
insert    into INT_ACCN (ACC,ACRA,ID,METR,BASEM,BASEY,FREQ,STP_DAT,ACR_DAT,APL_DAT,TT,ACRB,TTB,KVB,NLSB,MFOB,NAMB,NAZN,IO,IDU,IDR,OKPO)
          select (select ACC from accounts where kv=p_KVN and nls=T.nls) ACC,
                             ACRA,ID,METR,BASEM,BASEY,FREQ,STP_DAT,ACR_DAT,APL_DAT,TT,ACRB,TTB,KVB,NLSB,MFOB,NAMB,NAZN,IO,IDU,IDR,OKPO
          from int_accn i, (select * from accounts where kv= p_KVO and dazs is null) T, (select * from accounts where kv<>p_KVO and dazs is null) a
          where i.acc = t.acc and i.acra = a.acc
union all select       i.ACC,  (select ACC from accounts where kv=p_KVN and nls=A.nls) ACRA,
                                  ID,METR,BASEM,BASEY,FREQ,STP_DAT,ACR_DAT,APL_DAT,TT,ACRB,TTB,KVB,NLSB,MFOB,NAMB,NAZN,IO,IDU,IDR,OKPO
          from int_accn i, (select * from accounts where kv<>p_KVO and dazs is null) T, (select * from accounts where kv= p_KVO and dazs is null) a
          where i.acc = t.acc and i.acra = a.acc
union all select (select ACC from accounts where kv=p_KVN and nls=T.nls) ACC, (select ACC from accounts where kv=p_KVN and nls=A.nls) ACRA,
                                  ID,METR,BASEM,BASEY,FREQ,STP_DAT,ACR_DAT,APL_DAT,TT,ACRB,TTB,KVB,NLSB,MFOB,NAMB,NAZN,IO,IDU,IDR,OKPO
          from int_accn i, (select * from accounts where kv= p_KVO and dazs is null) T, (select * from accounts where kv= p_KVO and dazs is null) a
          where i.acc = t.acc and i.acra = a.acc ;

insert into INT_RATN(ACC,   ID,   BDAT,   IR,   BR,   OP,   IDU )
            select n.acc, r.id, r.bdat, r.ir, r.br, r.op, r.idu
            from int_ratn R, (select * from accounts where kv=p_KVN and dazs is null) n , (select * from accounts where kv=p_KVO and dazs is null) o
            where r.acc = o.acc and n.nls = o.nls;
-----------


-- Открыть новые экв вал поз
for k in (select v.* from  vp_list v, accounts b, accounts a where v.acc3800=a.acc and a.kv=p_kvo and v.acc3801=b.acc and a.dazs is null and b.dazs is null and b.kv=gl.baseval)
loop
    select * into aa from  accounts where acc = k.acc3800;   select * into aa from  accounts where kv = p_kvn and nls = aa.nls;
    select * into bb from  accounts where acc = k.acc3801;   bb.nls := vkrzn( substr( gl.aMfo,1,5), replace ( bb.nls, p_kvo, p_kvn) ) ;
    op_reg_ex(mod_=>99, p1_=>0, p2_=>0, p3_=>bb.grp, p4_=>nTmp_,
              rnk_=>bb.rnk, nls_=>bb.nls, kv_=>bb.kv, nms_=>bb.nms, tip_=>bb.tip, isp_=>bb.isp, accR_=>bb.ACC, tobo_=>bb.branch );
    Accreg.setAccountSParam(bb.ACC, 'OB22', bb.ob22 ) ;
    insert into vp_list (ACC3800, ACC3801, ACC6204, COMM, ACC_RRD, ACC_RRR, ACC_RRS) values (aa.acc, bb.acc, k.ACC6204, k.COMM, k.ACC_RRD, k.ACC_RRR, k.ACC_RRS );
    insert into spot ( KV,   VDATE ,  ACC ,  branch,  RATE_K ,  RATE_P  )
             select aa.kv, gl.bdate, aa.acc, aa.branch, x.RATE_K * p_k,  x.RATE_P * p_k
             from spot x
             where acc = k.acc3800 and VDATE = (select max(VDATE) from spot where acc = k.acc3800);
end loop;
-----------------------------------------------

-- переbрос бал/внебал и несист остатков

begin select nls into nls_3800 from accounts where nbs ='3800' and kv = p_kvo and rownum = 1 and dazs is null;
exception when no_data_found then nls_3800 := null;
end;
oo.tt :='013';

for k in (Select * from accounts where kv=p_KVO and dazs is null ) loop update  accounts set opt = 0 where acc = k.acc  ;  end loop;
-------------------
for k in (Select * from accounts where kv = p_KVO and ostc <> 0 and nls <> nls_3800 and  nbs <'4000'  )
loop

   If k.ostc > 0 then   oo.dk := 1; oo.s :=   k.ostc;
   else                 oo.dk := 0; oo.s := - k.ostc;
   end if ;
   oo.s2  :=        round( oo.s/p_k, 0)     ;

   gl.ref (oo.REF);   oo.nd  := 'НБУ №269';
   oo.nazn:='Постанова НБУ від 19.04.2016 р. №269: з 01.07.2016 р. Зміна коду білоруського рубля та деномінація 1:10000';
   k.nms  := substr(k.nms,1,38);   select okpo into oo.id_a from customer where rnk = k.rnk;

   gl.in_doc3 (ref_=>oo.REF,  tt_ =>oo.tt  ,  vob_=>16     ,    nd_=>oo.nd, pdat_=>SYSDATE, vdat_=>gl.BDATE,  dk_ => oo.dk,
               kv_ =>p_kvO ,  s_  =>oo.S   ,  kv2_=> p_kvN ,    s2_=>oo.S2, sk_  => null  , data_=>gl.BDATE, datp_=> gl.bdate,
             nam_a_=>k.nms , nlsa_=>k.nls  , mfoa_=>gl.aMfo, nam_b_=>k.nms, nlsb_=>k.nls  , mfob_=>gl.aMfo , nazn_=> oo.nazn,
             d_rec_=>null  , id_a_=>oo.id_a, id_b_=>oo.id_a,  id_o_=>null , sign_=>null   , sos_ =>1, prty_=>null, uid_=>null );

   gl.payv(0, oo.ref, gl.BDATE, oo.tt,   oo.dk, p_kvO, k.nls, oo.s,  p_kvO, nls_3800, oo.s );
   gl.payv(0, oo.ref, gl.BDATE, oo.tt, 1-oo.dk, p_kvN, k.nls, oo.s2, p_kvN, nls_3800, oo.s2);
   gl.pay (2, oo.ref, gl.BDATE );

end loop;

end DENOM_KV;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DENOM_KV.sql =========*** End *** 
PROMPT ===================================================================================== 
