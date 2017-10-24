
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dat_next_u.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DAT_NEXT_U 
( datb_  DATE,
  next_  INT
) RETURN DATE
  RESULT_CACHE RELIES_ON ( HOLIDAY )
IS
-------------------------------------------------------------------------------
-- Универсальная функция поиска банковской даты, отстоящей от заданной (datb_)
-- на расстоянии  next_ шагов вперед (next_ > 0) или назад (next_ < 0)
--
-- Author   : неизвестный гений.
-- Modifier : Inna (12/09/2005)
--            BAA  (08/04/2014) - при великих значеннях next_ падала з помилкою: returned without value

/*
02.06.2014 Сухова.
  Существует потребность вычислить ближайший РАБ день. т.е.
  Если сегодня рабочий  (например, 02/06/2014), то он же
  Если сегодня выходной (например, 31/05/2014 или 01/06/2014), то ближайший рабочий
  что-то типа    параметра next_ = 0

Надо  !!!!!!!
select :dat , Dat_Next_U ( ( :dat)  , 0 ) from dual; -- 31/05/2014    02/06/2014
select :dat , Dat_Next_U ( ( :dat)  , 0 ) from dual; -- 01/06/2014    02/06/2014
select :dat , Dat_Next_U ( ( :dat)  , 0 ) from dual; -- 02/06/2014    02/06/2014

То что было. этой возможности не давало !
Было ?????????
              И ни так
select :dat , Dat_Next_U ( ( :dat)  , 0 ) from dual; -- 31/05/2014    31/05/2014
select :dat , Dat_Next_U ( ( :dat)  , 0 ) from dual; -- 01/06/2014    01/06/2014
select :dat , Dat_Next_U ( ( :dat)  , 0 ) from dual; -- 02/06/2014    02/06/2014
              И ни так
select :dat , Dat_Next_U ( ( :dat)  , 1 ) from dual; -- 31/05/2014    02/06/2014
select :dat , Dat_Next_U ( ( :dat)  , 1 ) from dual; -- 01/06/2014    02/06/2014
select :dat , Dat_Next_U ( ( :dat)  , 1 ) from dual; --02/06/2014    03/06/2014
*/

-------------------------------------------------------------------------------
  l_next  int;
  l_dat  date;
  dat_   DATE;
  dat1_ DATE;
  kol_  INT;  -- к-ть вихідних
  i_    INT;
  prev_ INT;
--  ern   CONSTANT POSITIVE := 208;  err   EXCEPTION;    erm   VARCHAR2(80);
BEGIN

  If NEXT_ = 0 then l_next := 1    ; l_dat := datb_ - 1 ; -- 02.06.2014 Сухова.
  else              l_next := NEXT_; l_dat := datb_     ;
  end if;

  IF l_next > 0 THEN
     dat_ := l_dat + l_next;
     SELECT COUNT(*) INTO kol_ FROM holiday WHERE kv = 980 AND holiday > l_dat AND holiday <= dat_;
     WHILE kol_ > 0
     LOOP
       dat_ := dat_ + 1 ;
       begin
          SELECT holiday  INTO dat1_ FROM holiday  WHERE kv = 980 AND holiday = dat_;
       exception  when NO_DATA_FOUND then kol_ := kol_ - 1;
      end;
    END LOOP;
    RETURN (dat_);
  end if;
  -------------
  prev_ := ABS(l_next);
  dat_  := l_dat - prev_;
  SELECT COUNT(*) INTO kol_ FROM holiday WHERE kv = 980 AND holiday >= dat_    AND holiday < l_dat ;
  IF kol_ = 0 THEN RETURN(dat_); END IF;

  FOR i_ IN 1..10
  LOOP
    BEGIN
       dat_ := dat_ - 1;
       SELECT holiday INTO dat1_   FROM holiday  WHERE kv = 980  AND holiday = dat_;
       kol_ := kol_ + 1;
    EXCEPTION  WHEN NO_DATA_FOUND THEN
       IF l_dat - dat_ = prev_ + kol_ THEN  RETURN (dat_) ; END IF;
    END;
  END LOOP;
  RETURN (dat_);

END;
/
 show err;
 
PROMPT *** Create  grants  DAT_NEXT_U ***
grant EXECUTE                                                                on DAT_NEXT_U      to ABS_ADMIN;
grant EXECUTE                                                                on DAT_NEXT_U      to BARS009;
grant EXECUTE                                                                on DAT_NEXT_U      to BARSUPL;
grant EXECUTE                                                                on DAT_NEXT_U      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DAT_NEXT_U      to RPBN001;
grant EXECUTE                                                                on DAT_NEXT_U      to UPLD;
grant EXECUTE                                                                on DAT_NEXT_U      to WR_ALL_RIGHTS;
grant EXECUTE                                                                on DAT_NEXT_U      to ZAY;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dat_next_u.sql =========*** End ***
 PROMPT ===================================================================================== 
 