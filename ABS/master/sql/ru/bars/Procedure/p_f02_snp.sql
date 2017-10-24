

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F02_SNP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F02_SNP ***

  CREATE OR REPLACE PROCEDURE BARS.P_F02_SNP 
(p_DAT    DATE,                   -- отчетная дата
 p_SHM    VARCHAR2 DEFAULT 'G',   -- схема
 p_TIP    VARCHAR2 DEFAULT 'S',   --тип остатков
 p_KODF   VARCHAR2 DEFAULT '02'  --код файла IS
 ) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   процедура формирования 02 файла из SNAP-таблиц
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 11,01,2012 (09/08/2011)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

01.11.2011 Вирко
        По счету в валюте были только корректирующие деб.обороты =  кредитовым.
        в месяце сдедующем неправильно сформировались показатели 50 и 60 (отрицательные)

02.06.2011 SERG
        При синхронизации снимков баланса убрал флаг безусловного накопления
        добавил наполнение recid, userid при вставке в rnbu_trace

13/05/2011 Virko
        Заменила частичное обновление на полное,
        т.к. в некоторых случаях не отрабатывало (было расхождение с балансом).

28-02-2010 Virko
        учет внесистемных вешалок

РАНЕЕ Sta 	 Процедура формирования #02 на SNP-табл
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */
  l_DAT01d_ date      ;
  l_DAT01t_ date      ;
  Di_          number ;   -- accm_calendar.caldt_id%type
  l_caldt_DATE date   ;   -- accm_calendar.caldt_DATE%type
  l_nbuc  VARCHAR2(12);  l_typ   NUMBER;
  l_userid	number := user_id;

BEGIN

logger.info('STA -0 начало ');

  --1) Id отч.даты
  l_DAT01t_ := last_day  ( p_DAT) +  1 ; --01 число отчетного месяца   - ТОЛЯ
  l_DAT01d_ := add_months(l_DAT01t_,-1); --01 число след.за отч месяца - ДИМА

  select caldt_ID into Di_ from accm_calendar where caldt_DATE=l_DAT01d_;

  --2) Пока отключена страховочная синхронизация
  bars_accm_sync.sync_AGG('MONBAL', l_DAT01d_);

  -- переоц?нка кориуючих
  P_REV_SNP (p_DAT);

  --3) Очистка протокола форм.файлa (по aн.счетам)
  EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';

  --4) определение начальных параметров (код области)
  P_Proc_Set( p_KODF, p_SHM, L_nbuc, l_typ );
------------------------------------------------------------------------
  --5) формирование протокола в табл. RNBU_TRACE

INSERT INTO RNBU_TRACE (recid, userid, nbuc, nls, kv, acc, odate, znap, kodp)
select s_rnbu_record.nextval, l_userid, L_nbuc, d.NLS, d.KV, d.acc1, d.DAOS, d.value,
       SUBSTR(d.colname,2,2) ||
       d.nbs                 ||
       substr('000'||d.kv,-3)|| d.K041    KODP
from (select K041, decode(nbs, null, substr(nls,1,4), nbs) nbs,nls, KV, acc1, daos, colname, value
      from (select a.nls,a.kv, a.daos, a.nbs,
                   substr(F_K041 (c.country),1,1) K041,
                   b.*
            from (select ACC1,RNK,
            decode( sign(ostq),1, 0, -ostq) P10,
            decode( sign(ostq),1, ostq, 0 ) P20,
            decode( sign(ost ),1, 0, -ost ) P11,
            decode( sign(ost ),1, ost , 0 ) P21, P50,P60,P51,P61,P70,P80,P71,P81
                  from (   select ACC1, RNK, OST, OSTQ,
                                (case when p60<0 then p50 + abs(p60) else p50 end) P50,
                                (case when p50<0 then p60 + abs(p50) else p60 end) P60,
                                P51,P61,P70,P80,P71,P81
                           from ( select acc ACC1,RNK, ost -CRdos +CRkos  OST,
                                         ostq-CRdosq+CRkosq OSTQ,
                                         dosQ - CUdosQ P50,kosQ - CUkosQ P60,
                                         dos  - CUdos  P51,kos  - CUkos  P61,
                                         CRdosQ        P70,CRkosQ        P80,
                                         CRdos         P71,CRkos         P81
                                    from ACCM_AGG_MONBALS where caldt_ID=Di_
                                 )
                        )
                  ) b,
                  accounts a , customer c
            where b.rnk=c.rnk and b.ACC1=a.acc and (a.nbs not like '8%')
           )
      unpivot (value for colname in (P10,P20,P11,P21,P50,P60,P51,P61,P70,P80,P71,P81))
     ) d
where  (d.kv<>980 or d.colname like 'P_0' ) and d.value <>0;

  --6) Манипуляции с вешалками
 P_OTC_VE9 (p_DAT, p_KODF);

  -- готовый отчет в таблицу.
  DELETE FROM TMP_NBU WHERE kodf=p_KODF AND datf= p_DAT;
  INSERT INTO TMP_NBU (kodf, datf, nbuc, kodp, znap)
  select p_KODF, p_DAT, nbuc, KODP, SUM(znap)
  from  RNBU_TRACE   GROUP BY nbuc, kodp ;


  -- ВСЕ.
  commit;
--------------------------------------------------------
END P_F02_SNP;
/
show err;

PROMPT *** Create  grants  P_F02_SNP ***
grant EXECUTE                                                                on P_F02_SNP       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F02_SNP       to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F02_SNP.sql =========*** End ***
PROMPT ===================================================================================== 
