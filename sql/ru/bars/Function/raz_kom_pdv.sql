
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/raz_kom_pdv.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.RAZ_KOM_PDV (NLS_ varchar2, mode_ int)  RETURN number IS

/*
17.08.2015 Sta Mode_ =7 : добавлен режим вычисления счета гашеения SG


 новая SQL-функция для формулы счета (оп.K20 K21)
 и формулы суммы (оп.K2K, K2P)
  Mode_ =0 возвращает счет (оп.K20 K21)
  Mode_ =1 возвращает сумму     ПДВ (ПДВ до комiсiї) (оп.K2P)
  Mode_ =2 возвращает сумму без ПДВ (Чиста комiсiя ) (оп.K2K)

  Mode_ =7 возвращает счет сгашения SG по доп. реквизиту ND
*/

 nTmp_ int;
 S_ number := 0;
BEGIN
 If mode_ = 7 then

    begin select d.nd into nTmp_ from cc_deal d, operw w where d.nd = to_number (w.VALUE) and  w.ref = gl.aRef  and w.TAG = 'ND'  ;
    EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-(20203),'\8999 - RAZ_KOM1: Не знайдено угоду по дод.реквiзиту ND') ;
    END;

    begin select nlssg into S_ from(
 			select to_number(a.nls) as NLSSG
 			from accounts a, nd_acc n where (a.tip ='SG ' or substr(a.nls,1,4) = '2620')
 			and a.dazs is null and a.acc= n.acc and n.nd = nTmp_  order by CASE when  a.tip = 'SG ' then 1 end)
 			where  rownum =1 ;
    EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-(20203),'\8999 - RAZ_KOM2: Не знайдено рах.погашення по дод.реквiзиту ND='|| nTmp_) ;
    END;

  else
    begin     select 1 into nTmp_    from operw where ref = gl.aRef and tag='PDV' and value ='1';
      If      Mode_ =0    then  s_:= to_number( nbs_ob22 ('3739','03') );
      elsif   Mode_ =3    then  s_:= to_number (tobopack.get_branch_param2('TR3739_03',0));
      else    select s    into  S_   from oper where ref=gl.aRef;
              If Mode_ =1 then  S_:=      Round(S_/6,0) ;
              else              S_:= S_ - Round(S_/6,0) ;
              end if;
      end if;
    EXCEPTION WHEN NO_DATA_FOUND THEN s_:= to_number(NLS_);
    END ;
  end if;

  Return S_;

end RAZ_KOM_PDV;
/
 show err;
 
PROMPT *** Create  grants  RAZ_KOM_PDV ***
grant EXECUTE                                                                on RAZ_KOM_PDV     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on RAZ_KOM_PDV     to PYOD001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/raz_kom_pdv.sql =========*** End **
 PROMPT ===================================================================================== 
 