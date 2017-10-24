

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/XZ_3800.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure XZ_3800 ***

  CREATE OR REPLACE PROCEDURE BARS.XZ_3800 
( p_MFO     accounts.kf%type,
  p_branch  accounts.branch%type,
  P_DAT     accounts.dapp%type -- дата, которой надо откр счета и выполнить переброс ост
 ) is

/*
 26-04-2012 Sta Замена оп 013 на 015, т.к. 013 стала оч.хитрой
 13-02-2012 Sta изъять 20 аналитику
 04-11-2011 Sta исправлено: "Дата закрытия 3800" = (Макс.дате в АБС)  + 1
 29-11-2010 сделать переброс остатков и закрытие сч3800.3801, кот нет в VP_LIST

*/

  dazs_ accounts.dazs%type ;
  dk_   oper.dk%type       ;
  ref_  oper.ref%type      ;
  absadm_    int           := 20094 ;
  s_    oper.s%type        ;
  nlsn_ oper.nlsb%type     ;
  tt_   oper.tt%type       := '015';
  nazn_ oper.nazn%type     := 'Згортання старих 3800/3801';

begin
  tuda ;

  select nvl( max(fdat), p_dat) + 1 into dazs_ from saldob;
--dazs_    := p_dat +1 ;

  gl.bdate := p_dat    ;

  for k in (select acc, kv, nls, substr( branch||'000000/',1,15) branch,
                   nbs, decode(ob22,'20','10',ob22) ob22,
                   fost (acc, p_dat) OST
            from accounts
            where nbs in ('3800','3801') and dazs is null
              and acc not in (select acc3800 from vp_list
                              union all
                              select acc3801 from vp_list)
                              )
  loop
     if k.OST<>0 then

        if k.ost>0 then dk_:=1; S_ :=   K.OST;
        else            dk_:=0; S_ := - K.OST;
        end if;

        -- ищем соотв по VP_LIST
        begin
          select decode( k.nbs, '3800', V.nls3800, V.nls6204 )
          into nlsn_
          from v_vplist  V
          where V.kv=decode( k.nbs,'3800',k.kv, decode(k.ob22,'09',959,840))
            and V.branCH = K.BRANCH
            AND V.OB3800 = K.OB22;
        EXCEPTION WHEN NO_DATA_FOUND THEN
           raise_application_error(-(20203),
          '      Не можл.устан вiдпов. мiж старим'||
          ' бранч=' || k.BRANCH ||
          ' вал='   || k.kv     ||
          ' рах='   || k.NLS    ||
          ' ob22='  || k.ob22   ||
          ' та нов.рах',  TRUE);
        END;
        If REF_ is null then
           GL.REF (REF_);
           GL.IN_DOC3( REF_, tt_, 6,to_char(ref_), SYSDATE, GL.BDATE, dk_,
              k.KV,S_,k.KV,S_, null, GL.BDATE, GL.BDATE,
              'Вал.поз.Старi', k.NLS, gl.AMFO ,'Вал.поз.Новi',  NLSN_ , gl.AMFO ,
               nazn_,  NULL,gl.aokpo,gl.aokpo,null, null,0,null, absadm_ );
        end if;
        GL.PAYV(0,REF_,GL.BDATE,TT_,dk_,k.KV,k.NLS,S_,k.KV,NLSn_,S_);
     end if;

     update accounts set dazs = dazs_ where acc=k.acc;

  end loop;

  If ref_ is not null then    gl.pay(2, REF_, gl.bdate); end if;
--  commit;
  ---------------------------------------------------------------

  -- Переоценка валютных ост (ТЕХНИЧЕСКАЯ), т.е. создание SALDOB
  for k in (select kv from tabval where d_close is null and kv<>980)
  loop
     tuda;
     p_rev( k.kv, gl.BDATE );
  end loop;
--  commit;

  --- Переоценка вал.поз. (БУХГАЛТЕРСКАЯ), т.е. выравнивание проводками гр.380_
  for k in (select kv from tabval where d_close is null and kv<>980)
  loop
     gl.p_pvp(k.kv, gl.BDATE  );
  end loop;
--  commit;

end XZ_3800 ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/XZ_3800.sql =========*** End *** =
PROMPT ===================================================================================== 
