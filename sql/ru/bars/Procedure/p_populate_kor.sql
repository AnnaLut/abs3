

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_POPULATE_KOR.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_POPULATE_KOR ***

  CREATE OR REPLACE PROCEDURE BARS.P_POPULATE_KOR (p_datb_ IN DATE, p_date_ IN DATE,
                                           sql_doda_ IN VARCHAR2 DEFAULT '',
                                           tp_ IN NUMBER DEFAULT 0) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура выбора корректирующих проводок и по закрытию года
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 06/04/2015 (24/03/2015)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% -- tp_ = 0 - только корректирующие проводки (мес. и годовые)
% -- tp_ = 1 - корректирующие проводки (мес. и годовые) + обороты ZG
% -- tp_ = 2 - только обороты ZG
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 06.02.2012 - для перекрытия добавил проводки вида Дт 504* Кт 504*
%              (были в ОПЕРУ СБ)
% 30.01.2012 - для перекрытия 5040(5041) в Ощадбанке используются бал.счета
%              3902,3903. Данные бал.счета добавлены в условие перекрытия
% 12.01.2008 - изменил условие SUBSTR(nlsa,1,1) in ('6','7') ....
%              на (nlsa LIKE '6%' OR nlsa LIKE '7%' ....     )
%              (12.01.08 передал в Демарк но не внес в SourceSafe)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   txt_sql_ VARCHAR2(1000);
   dato_	DATE:=ADD_MONTHS(p_datb_, -1);
BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE REF_KOR';
   EXECUTE IMMEDIATE 'TRUNCATE TABLE KOR_PROV';

   IF p_datb_ > TO_DATE('0101'||to_char(p_date_, 'yyyy'), 'ddmmyyyy') and
      p_date_ < TO_DATE('0107'||to_char(p_date_, 'yyyy'), 'ddmmyyyy')
   THEN
   	  dato_	:=ADD_MONTHS(TRUNC(p_datb_, 'YEAR'), -1);
   END IF;

   IF tp_ <= 1 THEN -- корректирующие проводки
     txt_sql_ := 'INSERT /*+APPEND PARALLEL */ INTO ref_kor (REF, VOB, VDAT) '||
                 'SELECT ref, vob, vdat '||
                 'FROM oper o '||
                 'WHERE SOS=5 AND '||
                 '      vob in (96, 99) and '||
                 '      vDAT = any (select max(fdat) from fdat f where fdat BETWEEN :datb_ AND :date_ group by trunc(fdat, ''mm'')) '|| sql_doda_;

      EXECUTE IMMEDIATE txt_sql_ USING dato_, p_date_;
      commit;
   END IF;

   IF tp_ >= 1 THEN -- обороты по перекрытию 6-7 класса на 5040 (5041)
      INSERT /*+APPEND PARALLEL */
          INTO REF_KOR (REF, VOB, VDAT)
          SELECT REF, 100+VOB, vdat
          FROM OPER o
          WHERE SOS=5 AND
               vdat = any (select fdat from fdat t where fdat between dato_ and p_date_) AND
               (TT LIKE 'ZG%' OR
                (((nlsa LIKE '6%' or nlsa LIKE '7%') AND
                  (nlsb LIKE '5040%' OR nlsb LIKE '5041%')) OR
                 ((nlsa LIKE '5040%' OR nlsa LIKE '5041%') AND
                  (nlsb LIKE '6%' OR nlsb LIKE '7%')) OR
                 ((nlsa LIKE '3902%' or nlsa LIKE '3903%') AND
                  (nlsb LIKE '5040%' OR nlsb LIKE '5041%')) OR
                 ((nlsa LIKE '5040%' OR nlsa LIKE '5041%') AND
                  (nlsb LIKE '3902%' OR nlsb LIKE '3903%')) OR
                  (nlsa LIKE '504%' AND nlsb LIKE '504%')));
      commit;
   END IF ;

   INSERT /*+APPEND PARALLEL */
   INTO KOR_PROV (REF,  DK,  ACC , S,  FDAT , VDAT, SOS,  VOB)
   SELECT o.REF, o.DK, o.acc, o.s, o.FDAT, p.vdat, o.SOS, p.VOB
   FROM opldov o, REF_KOR p
   WHERE o.SOS=5 AND
         o.FDAT BETWEEN p_datb_ AND p_date_  AND
         o.REF=p.REF;
   commit;

EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
   WHEN OTHERS THEN
   RAISE_APPLICATION_ERROR(-20001,'Error in procedure p_populate_kor: '||SQLERRM,TRUE);
END;
/
show err;

PROMPT *** Create  grants  P_POPULATE_KOR ***
grant EXECUTE                                                                on P_POPULATE_KOR  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_POPULATE_KOR.sql =========*** En
PROMPT ===================================================================================== 
