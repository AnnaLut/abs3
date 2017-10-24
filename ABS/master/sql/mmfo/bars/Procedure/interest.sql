

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/INTEREST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure INTEREST ***

  CREATE OR REPLACE PROCEDURE BARS.INTEREST (p_dat0 date, p_acc number, p_id number
--,  p_Par varchar2  -- костя
) is
  -- Аналог Sel010 Interest
  -- ver 2.3  15/03-17
  --  metr=4 + бухмодель для валютних + id_a

  l_dat1 date := p_dat0 + 1;
  l_dat2 date ;
  xx int_GL%rowtype;
  aa acr_intn%rowtype;
  Int_ number ;
  oo oper%rowtype;
  rem1_ number;
  rem2_ number;
  k980 int ;
begin
--l_dat2 :=  NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'), gl.bdate);
  l_dat2 :=       TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy')           ;  -- олег
--l_dat2 :=       TO_DATE ( p_Par , 'dd.mm.yyyy')           ;  -- костя

logger.info('INT*'|| l_dat2);

  If l_dat2 is null then raise_application_error(-22222,'Не визначено Дат_2' ); end if;


  If p_dat0  >=  l_Dat2 then RETURN; end if;

  select * into xx from int_gl where acc = p_acc and id = p_id ;

--начисление
  acrn.p_int( p_Acc, p_Id, l_dat1, l_Dat2, Int_, Null, 0 );
  SELECT s iNTO rem1_ FROM int_accN WHERE acc = p_Acc and id = p_Id FOR UPDATE OF acc NOWAIT;
  int_ := int_ +rem1_;
  oo.s := round (int_);
  rem2_:= int_ - oo.S;

  k980 := nvl( gl.baseval, 980) ;

  UPDATE int_accN SET acr_dat = l_Dat2, s= Rem2_ WHERE acc =p_Acc and id = p_Id;
  If    oo.s < 0 then oo.dk := 1 ;      oo.s := - oo.s;
  Elsif oo.s > 0 then oo.Dk := 0 ;
  else  RETURN;
  end if;
  --------------------

  If    xx.KV = xx.KVA and xx.KVA = xx.KVB  then oo.s2 := oo.s;
  ElsIf xx.KV = xx.KVA and xx.KVB = k980    then oo.s2 := gl.p_icurval(xx.KV, oo.s, gl.bdate) ;
  Else
     -- теоритически тут могут быть другие расклады по валютам. Их надо бы рассмотреть.
     -- но пока не делаем. т.к. реально в ОБ таких нет
     oo.s2:= oo.s ;
  end if;

  oo.nazn := 'Нарах.%% по рах.'||xx.Nls ||' з ' || to_char(l_Dat1,'dd.MM.yy') ||' по '||to_char(l_Dat2, 'dd.MM.yy') ||' вкл.';
  oo.tt   := nvl(xx.tt, '%%1');

  if xx.metr in (4) then
     oo.Dk := 1 - oo.Dk;
     oo.nazn := 'Амортизація (пропорц) рах.'||xx.Nls ||' з ' || to_char(l_Dat1,'dd.MM.yy') ||' по '||to_char(l_Dat2, 'dd.MM.yy') ||' вкл.';
  end if;

  gl.ref (oo.REF);
  oo.nd := trim (Substr( '          '||to_char(oo.ref) , -10 ) ) ;

  select okpo into oo.id_a from customer where rnk=xx.rnk;

  gl.in_doc3 (oo.REF, oo.tt, 6, oo.nd, SYSDATE, gl.bdate, oo.dk,  xx.kv, oo.S , xx.kvb ,oo.S2, null, gl.BDATE, gl.bdate,
              substr(xx.nmsa,1,38) , xx.nlsa,  gl.aMfo ,
              substr(xx.nmsb,1,38) , xx.nlsb,  gl.amfo ,
              oo.nazn ,null, oo.id_a, gl.Aokpo, null, null, 1, null, null );
  gl.payv(0, oo.ref, gl.bdate, oo.tt, oo.dk, xx.kv, xx.nlsa, oo.s, xx.kvb, xx.nlsb, oo.s2);
  --- gl.pay(2, oo.ref, gl.bd);  -- !?
  --------------------
  -- Вставка записи-истории о начислении процентов, если, в будущем будет необходимость СТОРНО или персчета процентов.
  ACRN.acr_dati ( p_ACC, p_ID , oo.REF,  p_Dat0, rem1_ );
  -----------------------
end Interest ;
/
show err;

PROMPT *** Create  grants  INTEREST ***
grant EXECUTE                                                                on INTEREST        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/INTEREST.sql =========*** End *** 
PROMPT ===================================================================================== 
