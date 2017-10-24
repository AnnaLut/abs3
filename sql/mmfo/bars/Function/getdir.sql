
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/getdir.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETDIR ( mfo_  varchar2 ) RETURN VARCHAR2 IS
mfou_ VARCHAR2(14);
mfop_ VARCHAR2(14);
x_    NUMBER;
dir_  varchar2(38);
BEGIN
  dir_:='External';
  BEGIN
      SELECT mfou,mfop
      INTO mfou_,mfop_
      FROM banks
      WHERE mfo=mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN RETURN dir_;
   END;
   if mfou_<>'300465' THEN RETURN dir_; end if;
   if mfop_='300465' THEN mfop_:=mfo_; END IF;

   if mfop_='300465' then dir_:='ГРЦ'; END IF;
   if mfop_='323475' then dir_:='Кіровоград'; END IF;
   if mfop_='322669' then dir_:='Киів-обл.'; END IF;
   if mfop_='333368' then dir_:='Рівне'; END IF;
   if mfop_='331467' then dir_:='Полтава'; END IF;
   if mfop_='328845' then dir_:='Одеса'; END IF;
   if mfop_='305482' then dir_:='Дніпропетровськ'; END IF;
   if mfop_='326461' then dir_:='Миколаїв'; END IF;
   if mfop_='325796' then dir_:='Львів'; END IF;
   if mfop_='324805' then dir_:='Крим'; END IF;
   if mfop_='304665' then dir_:='Луганськ'; END IF;
   if mfop_='313957' then dir_:='Запоріжжя'; END IF;
   if mfop_='303398' then dir_:='Волинь'; END IF;
   if mfop_='302076' then dir_:='Вінниця'; END IF;
   if mfop_='311647' then dir_:='Житомир'; END IF;
   if mfop_='315784' then dir_:='Хмельницьк'; END IF;
   if mfop_='312356' then dir_:='Закарпаття'; END IF;
   if mfop_='356334' then dir_:='Чернівці'; END IF;
   if mfop_='354507' then dir_:='Черкаси'; END IF;
   if mfop_='337568' then dir_:='Суми'; END IF;
   if mfop_='338545' then dir_:='Тернопіль'; END IF;
   if mfop_='336503' then dir_:='Івано-Франківськ'; END IF;
   if mfop_='352457' then dir_:='Херсон'; END IF;
   if mfop_='351823' then dir_:='Харків'; END IF;
   if mfop_='335106' then dir_:='Донецьк'; END IF;
   if mfop_='353553' then dir_:='Чернігів'; END IF;

RETURN dir_;
END getdir;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/getdir.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 