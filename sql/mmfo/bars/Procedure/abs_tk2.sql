

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ABS_TK2.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ABS_TK2 ***

  CREATE OR REPLACE PROCEDURE BARS.ABS_TK2 (
 mfo_    IN     varchar2,  -- МФО места вклада           :  303398
 branch_ IN     varchar2,  -- полный BRANCH места вклада : /303398/020036/
 VALW_   IN     INT     ,  -- заказанный код вал для выплаты   NULL = 840 , 0 - любая валюта
 kv_     IN OUT INT     ,  -- IN - вал.вклада(980), OUT - вал.компенсации
 S_      IN OUT number  ,  -- IN - сумма к выпл.(980), OUT - сумма к выпл.(вал)
 bday_   IN     date    ,  -- дата рожд.( пока резерв)
 NLS_       OUT varchar2,  -- Счет 2906(TK) в ГОУ для дебета.
 NMS_       OUT varchar2,  -- Наименование Счета 2906(TK) в ГОУ для дебета.
 OKPO_      OUT varchar2   -- ОКПО Счета 2906(TK) в ГОУ для дебета.
 )       IS
  ---
  MFO_RU_ varchar2(12); rnk_ int ;  sn_ number; dat_ date; si_ number;
BEGIN

/*
функция подбора счета (главный 2906501202) по коду валюты=980
для перечисления в МФО суммы 500 грн
Компенсацiя по вкладах вкладникiв, померлих в 2005-2008 рр.
*/

  if s_ <=0 then
     RAISE_APPLICATION_ERROR (-20001, 'ABS_TK2: Sum ='|| S_ );
     return;
  end if;

  BEGIN
     SELECT decode (mfop,gl.aMFO, MFO, MFOP ) into MFO_RU_
     from banks where mfo=MFO_;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     RAISE_APPLICATION_ERROR (-20001,
     'ABS_TK2: MFO_RU_NOT_FOUND for MFO='|| MFO_);
     return;
  END;
  -------------
-- logger.info('TK-1: mfo_ru='||mfo_ru_);

  BEGIN
     SELECT a.rnk into rnk_
     from accounts a, bank_acc b
     where a.tip='L00' and a.kv=980 and a.acc=b.acc and b.mfo=MFO_RU_;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     RAISE_APPLICATION_ERROR (-20001,
     'ABS_TK2: RNK_NOT_FOUND for MFO_RU='|| MFO_RU_);
     return;
  END;
  --------
-- logger.info('TK-2: rnk_='||rnk_);

  -- Дата для курсов валют
  DAT_:= gl.BDATE;  kv_:= nvl(kv_,980);
  --
  If   kv_=980 then sn_:=                   S_;
  else              sn_:= gl.p_icurval(kv_, S_, DAT_);
  end if;
  --------
  Si_:=0; NLS_:=to_char(null); NMS_:=to_char(null); OKPO_:=to_char(null);

  -- Ищем первый счет (840, 978, 980 ) с достаточной суммой.
  --                Сортируем по валюте

  -- nvl(VALW_,840) заказанный код вал для выплаты   NULL = 840 , 0 - любая валюта

  for k in (select KV,NLS,substr(nms,1,38) NMS
            from accounts where tip='TK2' and rnk=rnk_ and ostb>SN_ AND kv=980 )
  loop
    If si_ = 0 then
-- logger.info('TK-3: '||k.kv||' '||k.nls);

       -- Округление по правилам арифметики
       If   kv_ = k.kv then si_:= S_;
       else kv_:= k.kv;     si_:= gl.p_ncurval(k.kv, SN_, DAT_);
       end if;

/*
          любую дробь отрбасываем
       If   kv_ = k.kv then si_:= S_;
       else kv_:= k.kv;     si_:=   ROUND (GL.P_NCURVAL(k.kv,SN_*100, GL.BD) / 100 - 0.5 ,0) ;
       end if;
*/

       NLS_:=k.nls;
       NMS_:=k.nms;
       select okpo into OKPO_ from customer where rnk=rnk_;
    end if;
  end loop;
  S_:= si_;
END ABS_TK2;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ABS_TK2.sql =========*** End *** =
PROMPT ===================================================================================== 
