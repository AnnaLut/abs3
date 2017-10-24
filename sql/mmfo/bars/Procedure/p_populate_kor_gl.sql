

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_POPULATE_KOR_GL.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_POPULATE_KOR_GL ***

  CREATE OR REPLACE PROCEDURE BARS.P_POPULATE_KOR_GL (p_datb_ IN DATE, p_date_ IN DATE,
                                           sql_doda_ IN VARCHAR2 DEFAULT '',
                                           tp_ IN NUMBER DEFAULT 0) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    ѕроцедура выбора корректирующих проводок и по закрытию года
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 12.02.2008 (12.01.2008,05.03.2007)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% -- tp_ = 0 - только корректирующие проводки (мес. и годовые)
% -- tp_ = 1 - корректирующие проводки (мес. и годовые) + обороты ZG
% -- tp_ = 2 - только обороты ZG
% 12.01.2008 - изменил условие SUBSTR(nlsa,1,1) in ('6','7') ....
%              на (nlsa LIKE '6%' OR nlsa LIKE '7%' ....     )
%              (12.01.08 передал в ƒемарк но не внес в SourceSafe)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   txt_sql_ VARCHAR2(1000);
   dato_    DATE:=ADD_MONTHS(p_datb_, -1);
BEGIN
   DELETE FROM REF_KOR;
   DELETE FROM KOR_PROV;

   IF p_date_ < TO_DATE('0107'||to_char(p_date_, 'yyyy'), 'ddmmyyyy') THEN
         dato_    :=ADD_MONTHS(TRUNC(p_datb_, 'YEAR'), -1);
   END IF;

   IF tp_ <= 1 THEN -- корректирующие проводки
      txt_sql_ := 'INSERT INTO ref_kor (REF, VOB, VDAT) '||
                  'SELECT ref, vob, vdat '||
                  'FROM oper o '||
                  'WHERE vdat between :d1 and :d2 and '||
                  '      vob in (96, 99) and '||
                  '      ref in (select p.ref '||
                  '              from opldov_gl p '||
                  '              where p.fdat BETWEEN :p_datb_ AND :p_date_) '||sql_doda_;

      EXECUTE IMMEDIATE txt_sql_ USING dato_, p_date_, p_datb_, p_date_;
   END IF;

   IF tp_ >= 1 THEN -- обороты по перекрытию 6-7 класса на 5040 (5041)
      INSERT INTO REF_KOR (REF, VOB, VDAT)
      SELECT REF, 100+VOB, vdat
      FROM OPER o
      WHERE vdat BETWEEN dato_ AND p_date_ AND
           (TT LIKE 'ZG%' OR
            (((nlsa LIKE '6%' or nlsa LIKE '7%') AND
              (nlsb LIKE '5040%' OR nlsb LIKE '5041%')) OR
             ((nlsa LIKE '5040%' OR nlsa LIKE '5041%') AND
              (nlsb LIKE '6%' OR nlsb LIKE '7%')))) and
            ref in (select ref
                    from opldov_gl p
                    where p.fdat BETWEEN p_datb_ AND p_date_);
   END IF ;

   INSERT INTO KOR_PROV (REF,  DK,  ACC , S,  FDAT , VDAT, SOS,  VOB)
   SELECT o.REF, o.DK, o.acc, o.s, o.FDAT, p.vdat, o.SOS, p.VOB
   FROM opldov_gl o, REF_KOR p
   WHERE o.SOS=5 AND
         o.FDAT BETWEEN p_datb_ AND p_date_ and
         o.ref=p.ref;

EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
   WHEN OTHERS THEN
   RAISE_APPLICATION_ERROR(-20001,'Error in procedure p_populate_kor: '||SQLERRM,TRUE);
END;
/
show err;

PROMPT *** Create  grants  P_POPULATE_KOR_GL ***
grant EXECUTE                                                                on P_POPULATE_KOR_GL to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_POPULATE_KOR_GL to RPBN001;
grant EXECUTE                                                                on P_POPULATE_KOR_GL to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_POPULATE_KOR_GL.sql =========***
PROMPT ===================================================================================== 
