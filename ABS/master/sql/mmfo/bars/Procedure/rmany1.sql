

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RMANY1.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RMANY1 ***

  CREATE OR REPLACE PROCEDURE BARS.RMANY1 
(p_REF1 number , -- Реф начальной сделки по покупке
 p_REF2 number  -- Реф вторичной сделки по продаже/перемещению
) is
-- v.1.1  22/11-12
  Id_    cp_deal.id%type  ;
  l_vdat date   ;
  SUMB_ NUMBER  ; -- ОБЩ.СУММА ПРОДАЖИ
  n0_   NUMBER  ; -- ПРОДАЛИ НОМИНАЛА
  n_    NUMBER  ; -- ОСТАТОК НОМИНАЛА
  N1_   number  := 0 ; -- номинал к погащению в последнюю дату
  -------------
  DATE_       cp_kod.DAT_em%type    ;
  DATP_       cp_kod.DATP%type      ;
  CENA_       cp_kod.CENA%type      ;
  PERIOD_KUP_ cp_kod.PERIOD_KUP%type;
  DOK_        cp_kod.DOK%type       ;
  KY_         cp_kod.KY%type        ;
  IR_         cp_kod.IR%type        ;
  ---------------------------------
  nKol_  int    ;
  nInt1_ number ;
  ----------------


BEGIN
  -- а надо ли это делать вообще ?
  begin
     -- есть ли номинал
     select e.id ,  o.vdat,  O.s,   ( fost(e.acc,o.vdat) - fost(e.acc,(o.vdat-1)) ) , fost(e.acc,o.vdat)
     into     ID_,  l_vdat, SUMB_, N0_,    N_
     from  cp_deal e, oper o
     where o.ref  = p_REF2 and  e.ref = p_REF1  and fost( e.acc, o.vdat) < 0 ;
  EXCEPTION WHEN NO_DATA_FOUND THEN  RETURN ;
  end;
  -----------
  --Есть ли последняя дата в графике купонных платежей ?
  begin
    select k.PERIOD_KUP ,k.dok ,k.KY ,k.cena ,nvl(k.IR,0), k.datp, k.dat_em
    into     PERIOD_KUP_,  DOK_,  KY_,  CENA_,  IR_,  DATP_, DATE_
    from  cp_kod k, cp_dat d
    where k.id=ID_ and d.id=k.ID and d.dok=k.DATP;
  EXCEPTION WHEN NO_DATA_FOUND THEN   raise_application_error(-(20000+333),
    '\ Нет графика купонных платежей для ЦБ id=' || ID_ ||' , ref='||p_REF1,TRUE);
  end;

  --перемещение в архив
  insert into CP_MANY_upd (REF,FDAT,SS1,SDP,SN2)  select REF,FDAT,SS1,SDP,SN2 from cp_many where ref=p_REF1;

  -- удаление из рабочих потоков измененного будущего
  delete from cp_many where ref=p_ref1 and fdat >= l_vdat;

  --построение нового раб.потока
  nKol_ := Abs(N_ /(100*CENA_)); -- ОСТАЛОСЬ ШТУК

  -- Сумма нач.проц по % ставке в целых (типа 28.67)
  If KY_ > 0          then nInt1_ := Round( CENA_*IR_/KY_,0) / 100;
  ElsIf PERIOD_KUP_>0 then nInt1_ := Round( CENA_*IR_*PERIOD_KUP_/365,0) / 100;
  Else                     nInt1_ := 0;
  end if;

  -- номинал к погащению в последнюю дату  в целіх гг.кк
  select -N_/100 - sum(nvl(a.nom,0)) * nkol_  into N1_ from cp_dat A  where a.id=ID_ and a.DOK > l_VDAT;


  -- пост табл потоков (в цел)
  insert into cp_many(REF ,FDAT  , SS1             , SDP   , SN2          )
             select p_REF1,l_VDAT, N0_/100        , (SUMB_-N0_)/100, 0           from dual    -- день-1 ("выдачи" средств) частичного погаш.
   union all select P_REF1,DOK   , nKol_*nvl(nom,0), 0     , nKol_*Nvl (KUP,nInt1_) from cp_dat  where id=ID_ and DOK>l_VDAT and DOK<DATp_ -- день-i погаш купона и част.номинала
   union all select P_REF1,DOK   , N1_             , 0     , nKol_*Nvl (KUP,nInt1_) from cp_dat  where id=ID_ and dOK=DATp_ ;-- день-к погаш посл.купона и ост.номинала

END RMany1;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RMANY1.sql =========*** End *** ==
PROMPT ===================================================================================== 
