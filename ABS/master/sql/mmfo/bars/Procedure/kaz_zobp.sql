

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/KAZ_ZOBP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure KAZ_ZOBP ***

  CREATE OR REPLACE PROCEDURE BARS.KAZ_ZOBP 
( p_mode int  -- = 0 за попереднiй банк.день
              -- = 1 за поточний банк.день

 )  is

--21.10.2013 - за прош день

  NLS_29r varchar2(14);  NmS_29r varchar2(38);
  NLS_28V varchar2(14);  NmS_28V varchar2(38);
  NLS_28K varchar2(14);  NmS_28K varchar2(38);
  NLS_28N varchar2(14);  NmS_28N varchar2(38);

  ro KAZ_ZOBT%rowtype;

  kaz_ob cp_kaz_ob%rowtype;
  kv_ CP_KAZ.kv%type;

  br0_ branch.branch%type;

  VDAT_ oper.VDAT%type;
  opr   oper%rowtype; 
  l_sos number;
procedure f_search_nls (nbs_      accounts.nbs%type,
                        ob22_     accounts.ob22%type,
                        branch_   accounts.branch%type,
                        kv        accounts.kv%type,
					    nls_    out accounts.nls%type,
						nms_    out accounts.nms%type
                        )
is
lng_ int;
--nls_ accounts.nls%type;
l_branch_ accounts.branch%type;
begin
l_branch_ := branch_;
Lng_ :=  length(l_branch_);

 FOR i in 0..2 loop   l_branch_ := substr(l_branch_, 1, Lng_ - i*7);
    begin
       select nls, substr(nms,1,38) into nls_, nms_ from accounts where acc=(select max(a.acc) from accounts a where a.ob22=OB22_ and a.nbs=NBS_ and a.dazs is null and kv = kv_ and a.branch=l_branch_);
    exception when no_data_found then null;
    end;
 end loop;

 if nls_ is null
 then
   raise_application_error(-20100,  'Для '|| branch_ ||CHR(13)||CHR(10)||' HE вiдкрито рах.'||nbs_||'/'||ob22_||'/'||kv_);
 end if;

end;


begin

  if  p_mode = 1 then       VDAT_  := gl.BDATE;  -- за сег
  elsIf gl.bdate = to_date('03/01/2013','dd/mm/yyyy') then      VDAT_  :=  to_date('29/12/2012','dd/mm/yyyy');
  else
      select max(fdat) into VDAT_ from fdat
      where fdat < gl.bdate and fdat not in (select holiday from holiday) ; -- за вчера
  end if;
  ----------------------
/*
  begin
    br0_  := '/' || gl.kf || '/000000/060000/';
    select nls, substr(nms,1,38) into NLS_29R,NmS_29R from accounts where kv=840
       and rownum=1 and dazs is null and nbs='2901' and ob22='13' and branch=br0_;
    select nls, substr(nms,1,38) into NLS_28V,NmS_28V from accounts where kv=840
       and rownum=1 and dazs is null and nbs='2801' and ob22='02' and branch=br0_;
    select nls, substr(nms,1,38) into NLS_28k,NmS_28k from accounts where kv=840
       and rownum=1 and dazs is null and nbs='2801' and ob22='03' and branch=br0_;
    select nls, substr(nms,1,38) into NLS_28n,NmS_28n from accounts where kv=840
       and rownum=1 and dazs is null and nbs='2801' and ob22='04' and branch=br0_;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     raise_application_error(-20100,
     'Для '|| br0_ ||
     ' HE вiдкрито рах.2901.13.840, 2801.02.840, 2801.03.840, 2801.04.840');
  end;
  ----
*/

  ro.grp := f_ourmfo;

  begin
    select 0 into ro.ref  from kaz_zobt where  DATD = VDAT_ and grp = ro.grp and rownum=1;
     raise_application_error(-20100,'Повторне виконання за '||to_char(VDAT_,'dd.mm.yyyy') );
  EXCEPTION WHEN NO_DATA_FOUND THEN
    delete from KAZ_ZOBT where grp = ro.grp;
  end;

  ro.ref := 0  ;
  

  for k in (select trunc(pdat) PDAT, tt, kv, dk,  nlsb, nam_b ,  sum(s) S, f_dop(REF, 'KODCP') as ser
            from oper o
            where vdat = VDAT_
              and sos  = 5
              and tt in ('$RN','$VN','$PK','$00')
             -- and nlsa not in ( NLS_29r, NLS_28V, NLS_28K, NLS_28N )
             -- and nlsb not in ( NLS_29r, NLS_28V, NLS_28K, NLS_28N )
            group by trunc(pdat), tt, kv, dk, nlsb, nam_b, f_dop(REF, 'KODCP')
            )
  loop

           begin
            select NLS_98R,          NLS_29r,          NLS_98V,          NLS_28V,
                   NLS_98K,          NLS_28K,          NLS_98N,          NLS_28N,          c.kv
            into   kaz_ob.NLS_98R,   kaz_ob.NLS_29r,   kaz_ob.NLS_98V,   kaz_ob.NLS_28V,
                   kaz_ob.NLS_98K,   kaz_ob.NLS_28K,   kaz_ob.NLS_98N,   kaz_ob.NLS_28N,   kv_
            from  cp_kaz_ob cc, CP_KAZ c
           where  cc.id = k.ser and cc.id = c.id;
           exception when NO_DATA_FOUND
            THEN raise_application_error(-20100, 'Для '|| k.nlsb ||' HE визначено код КЗ'||k.ser);
           end;


              begin
                br0_  := '/' || gl.kf || '/000000/060000/';
				f_search_nls('2901',kaz_ob.NLS_29R ,br0_, kv_, NLS_29R, NmS_29R);
                f_search_nls('2801',kaz_ob.NLS_28V ,br0_, kv_, NLS_28V, NmS_28V);
                f_search_nls('2801',kaz_ob.NLS_28k ,br0_, kv_, NLS_28k, NmS_28k);
                f_search_nls('2801',kaz_ob.NLS_28n ,br0_, kv_, NLS_28n, NmS_28n);

              EXCEPTION WHEN NO_DATA_FOUND THEN
                 raise_application_error(-20100,
                 'Для '|| br0_ ||CHR(13)||CHR(10)||
                 ' HE вiдкрито рах.2901'||kaz_ob.NLS_29R||'/'||kv_||'('||NLS_29R||'),'||CHR(13)||CHR(10)||
                 '             рах.2801'||kaz_ob.NLS_28V||'/'||kv_||'('||NLS_28V||'),'||CHR(13)||CHR(10)||
                 '             рах.2801'||kaz_ob.NLS_28k||'/'||kv_||'('||NLS_28k||'),'||CHR(13)||CHR(10)||
                 '             рах.2801'||kaz_ob.NLS_28n||'/'||kv_||'('||NLS_28n||')');
              end;



      If    k.tt='$RN' then ro.nlsa  :=NLS_29r; ro.nam_a := NmS_29r;
            ro.nazn :=
               'Акумуляцiя коштiв вiд розмiщення КЗ ' ||
               to_char( k.PDAT,'dd.mm.yyyy') ||
               ' , для проведення розрахункiв';

      elsIf k.tt='$VN' then ro.nlsa  :=NLS_28V; ro.nam_a := NmS_28V;
            ro.nazn :=
               'Акумуляцiя коштiв вiд Викупу КЗ ' ||
               to_char( k.PDAT,'dd.mm.yyyy') ||
               ' , для проведення розрахункiв';

      elsIf k.tt='$PK' then ro.nlsa  :=NLS_28K; ro.nam_a := NmS_28K;
            ro.nazn :=
               'Акумуляцiя коштiв вiд сплати купону КЗ ' ||
               to_char( k.PDAT,'dd.mm.yyyy') ||
               ' , для проведення розрахункiв';

      elsIf k.tt='$00' then ro.nlsa  :=NLS_28N; ro.nam_a := NmS_28N;
            ro.nazn :=
               'Акумуляцiя коштiв вiд сплати ном+ост купону КЗ ' ||
               to_char( k.PDAT,'dd.mm.yyyy') ||
               ' , для проведення розрахункiв';

      end if;

      ro.DATD  := VDAT_   ; ro.S     := k.s     ;
      ro.ref   := ro.ref+1; ro.kva   := k.kv    ;
      ro.kvb   := k.kv    ; ro.mfob  := gl.aMfo ;
      ro.tt    := 'PS1'   ; ro.vob   := 6       ;
      ro.OKPOA := gl.AOkpo; ro.OKPOB := gl.Aokpo;
      ro.nlsb  := k.nlsb  ; ro.nam_b := k.nam_b ;
      ro.dk    := 1 - k.dk; ro.ND    := to_char(ro.ref);

    if ro.nlsa != ro.nlsb then

      insert into KAZ_ZOBT
          (grp,REF,sos,ID,nlsa,kva,mfob,nlsb,kvb,tt,vob,nd,
                           datd,s,nam_a,nam_b,nazn,okpoa,okpob, dk  )
      values
      (ro.grp  , ro.REF, 0,ro.ref, ro.nlsa, ro.kva, ro.mfob , ro.nlsb , ro.kvb,
       ro.tt   , ro.vob,   ro.nd , ro.datd, ro.s,   ro.nam_a, ro.nam_b, ro.nazn,
       ro.okpoa, ro.okpob ,ro.dk ) ;
   end if;


  end loop;
  ----

  for k in (select trunc(pdat) PDAT, tt, kv, sum(s) S,
              sum((select value from operw where ref=o.ref and tag='S_KIL')) K,  f_dop(REF, 'KODCP') as ser
            from oper o
            where vdat = VDAT_
              and sos  = 5
              and tt in ('$RN','$VN','$PK','$00')
            group by trunc(pdat) , tt, kv,  f_dop(REF, 'KODCP')
            )
  loop
           kv_ := k.kv;

           begin
            select  cc.*
            into    kaz_ob
            from  cp_kaz_ob cc, CP_KAZ c
           where  cc.id = k.ser and cc.id = c.id;
           exception when NO_DATA_FOUND
            THEN raise_application_error(-20100, ' HE визначено код КЗ'||k.ser);
           end;



                begin
                br0_  := '/' || gl.kf || '/000000/060000/';
				f_search_nls('2901',kaz_ob.NLS_29R ,br0_, kv_, NLS_29R, NmS_29R);
                f_search_nls('2801',kaz_ob.NLS_28V ,br0_, kv_, NLS_28V, NmS_28V);
                f_search_nls('2801',kaz_ob.NLS_28k ,br0_, kv_, NLS_28k, NmS_28k);
                f_search_nls('2801',kaz_ob.NLS_28n ,br0_, kv_, NLS_28n, NmS_28n);
              EXCEPTION WHEN NO_DATA_FOUND THEN
                 raise_application_error(-20100,
                 'Для '|| br0_ ||CHR(13)||CHR(10)||
                 ' HE вiдкрито рах.2901'||kaz_ob.NLS_29R||'/'||kv_||'('||NLS_29R||'),'||CHR(13)||CHR(10)||
                 '             рах.2801'||kaz_ob.NLS_28V||'/'||kv_||'('||NLS_28V||'),'||CHR(13)||CHR(10)||
                 '             рах.2801'||kaz_ob.NLS_28k||'/'||kv_||'('||NLS_28k||'),'||CHR(13)||CHR(10)||
                 '             рах.2801'||kaz_ob.NLS_28n||'/'||kv_||'('||NLS_28n||')');
              end;

      If    k.tt='$RN' then
            ro.nlsa  := NLS_29r               ; ro.nam_a := NmS_29r;
            ro.nlsb  :=kaz_ob.NLS_29r_gou     ; ro.nam_b := 'Кошти за розмiщенz КЗ';
            ro.tt    := 'PS2'                 ; ro.dk    := 1 ;   ro.vob   := 6       ;
            ro.nazn  := 'Перерахування коштiв вiд розмiщення КЗ ' ||
                         to_char(k.PDAT,'dd.mm.yyyy') || ';'||kaz_ob.ser||';'||k.k||';'||
                         to_char( (k.S/100) / k.K )   || ';';

      elsIf k.tt='$VN' then
            ro.nlsa  := NLS_28V             ; ro.nam_a :=NmS_28V;
            ro.nlsb  :=kaz_ob.NLS_28V_gou   ; ro.nam_b := 'Деб. заборг. за ЦП для клiєнтiв';
            ro.tt    := '014'               ; ro.dk    := 2 ;  ro.vob   := 41       ;
            ro.nazn  := 'Вiдшкодування '|| ro.nam_b   ||to_char(k.PDAT,'dd.mm.yyyy') || ';'||kaz_ob.ser||';'||k.k||';'||to_char( (k.S/100) / k.K )   || ';';
      elsIf k.tt='$PK' then
            ro.nlsa  :=NLS_28K              ; ro.nam_a :=NmS_28K;
            ro.nlsb  :=kaz_ob.NLS_28K_gou   ; ro.nam_b := 'Розрахунки (купон/погашення) по КЗ';
            ro.tt    := '014'               ; ro.dk    := 2 ;  ro.vob   := 41       ;
            ro.nazn  := 'Вiдшкодування '|| ro.nam_b   ||to_char(k.PDAT,'dd.mm.yyyy') || ';'||kaz_ob.ser||';'||k.k||';'||to_char( (k.S/100) / k.K )   || ';';

      elsIf k.tt='$00' then
            ro.nlsa  :=NLS_28N              ; ro.nam_a := NmS_28N;
            ro.nlsb  :=kaz_ob.NLS_28N_gou   ; ro.nam_b := 'Розрахунки (купон/погашення) по КЗ';
            ro.tt    := '014'               ; ro.dk    := 2 ;  ro.vob   := 41       ;
            ro.nazn  := 'Вiдшкодування '|| ro.nam_b   ||to_char(k.PDAT,'dd.mm.yyyy') || ';'||kaz_ob.ser||';'||k.k||';'||to_char( (k.S/100) / k.K )   || ';';
      end if;

      ro.ref   := ro.ref+1 ; ro.kva  := k.kv          ; ro.kvb := k.kv     ;
      ro.mfob  := '300465' ; ro.ND  := to_char(ro.ref);
      ro.DATD  := VDAT_    ; ro.S    := k.s      ;
      ro.OKPOA := gl.AOkpo ; ro.OKPOB:='00032129';

      ro.D_REC :='#C'||to_char(k.k)||'#';
      insert into KAZ_ZOBT
          (grp,REF,sos,ID,nlsa,kva,mfob,nlsb,kvb,tt,vob,nd,
                           datd,s,nam_a,nam_b,nazn,okpoa,okpob,dk,D_REC )
      values
      (ro.grp  , ro.REF, 0,ro.ref, ro.nlsa, ro.kva, ro.mfob , ro.nlsb , ro.kvb,
       ro.tt   , ro.vob,   ro.nd , ro.datd, ro.s,   ro.nam_a, ro.nam_b, ro.nazn,
       ro.okpoa, ro.okpob ,ro.dk , ro.D_REC) ;

  end loop;

  -- оплата
  
  for x0 in (
         select DK, D_REC, NLSA, KVA, MFOB, NLSB, KVB, TT, VOB, ND, DATD, S, NAM_A, NAM_B, NAZN, OKPOA, OKPOB, GRP, REF, SOS, ID
		   from KAZ_ZOBT
		  where grp = ro.grp
            ) 
  loop
  
    
                gl.ref (opr.REF);

                gl.in_doc3 (ref_   => opr.REF,
                            tt_    => x0.tt,
                            vob_   => 6,
                            nd_    => substr(to_char(opr.REF), 1, 9),
                            pdat_  => sysdate,
                            vdat_  => gl.bdate,
                            dk_    => x0.dk,
                            kv_    => x0.KVA,
                            s_     => x0.s,
                            kv2_   => x0.KVB,
                            s2_    => x0.s,
                            sk_    => null,
                            data_  => gl.bdate,
                            datp_  => gl.bdate,
                            nam_a_ => substr(x0.nam_a, 1, 38),
                            nlsa_  => x0.nlsa,
                            mfoa_  => gl.amfo,
                            nam_b_ => substr(x0.nam_b, 1, 38),
                            nlsb_  => x0.nlsb,
                            mfob_  => x0.MFOB,
                            nazn_  => x0.NAZN,
                            d_rec_ => x0.d_rec,
                            id_a_  => x0.OKPOA,
                            id_b_  => x0.OKPOB,
                            id_o_  => null,
                            sign_  => null,
                            sos_   => 1,
                            prty_  => null,
                            uid_   => null);

                gl.dyntt2(sos_   => l_sos,
                          mod1_  => 0,
                          mod2_  => 0,
                          ref_   => opr.REF,
                          vdat1_ => gl.bdate,
                          vdat2_ => null,
                          tt0_   => x0.tt,
                          dk_    => x0.dk,
                          kva_   => x0.KVA,
                          mfoa_  => gl.amfo,
                          nlsa_  => x0.nlsa,
                          sa_    => x0.s,
                          kvb_   => x0.KVB,
                          mfob_  => x0.MFOB,
                          nlsb_  => x0.nlsb,
                          sb_    => x0.s,
                          sq_    => null,
                          nom_   => null);

  
  
  
  end loop;  
  
  
  
end KAZ_ZOBP;
/
show err;


grant execute on KAZ_ZOBP to BARS_ACCESS_DEFROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/KAZ_ZOBP.sql =========*** End *** 
PROMPT ===================================================================================== 
