

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PLAY_INT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PLAY_INT ***

  CREATE OR REPLACE PROCEDURE BARS.PLAY_INT (p_DAT1 date, p_DAT2 date) is

/*
05.01.2014 Внурт табл
03.08.2012
      Просимо оптим_зувати процедуру "PLAY_INT" для швидшого формування наступних зв_т_в:
--------№ 32 "Прогноз нарахованих вiдсоткiв (Вал+Бал+ОБ22)"
        № 33 "Прогноз нарахованих вiдсоткiв (Вал+Бал)" ,
        № 34 "Прогноз нарахованих вiдсоткiв (Вал)" ,
-    № 36 "Прогноз нарахованих вiдсоткiв. Пiдсумки." ,
-    № 37 "Прогноз нарахованих вiдсоткiв (Гр.Бал/Рах)".
     Зараз зв_ти виконуються б_льше н_ж 48 годин.

 24.03.2010 Sta ОВР с метр=7
 22-03-2010 Sta отсечь 1 день для депозитов
 05-03-2010 Sta не только 2-й класс. а все с учетом стоп-даты
 24.09.2009     На старом пакедже начисления % ACRO
*/

 BRANCH_ accounts.BRANCH%type ; KV_ accounts.KV%type ; NBS_ accounts.NBS%type ; OB22_ specparam_int.OB22%type ;
 ID_     int_accn.ID%type     ; S_ number  := 0      ;  q_ number   := 0      ; IR_ number;
 dat1_ date ; a_NAME1  varchar2(17) := 'I'||to_char(p_DAT1,'YYYYMMDD') ||  to_char(p_DAT2,'YYYYMMDD') ; b_NAME1  varchar2(17) ;
-------------------------------
 TYPE r1 IS RECORD ( n1 number, n2 number, n3 number, n4 number)   ;
 TYPE m1 IS TABLE OF r1 INDEX BY VARCHAR2(32);
 tmp1 m1 ;
-------------------------------
 ind_ VARCHAR2(32) ;
begin

  begin  select NAME1 into b_NAME1 from CCK_AN_TMP where rownum=1;
     If b_NAME1 = a_NAME1 then    goto KIN  ; end if ;
     EXECUTE IMMEDIATE 'TRUNCATE TABLE CCK_AN_TMP'   ;
     tmp1.DELETE;
     dbms_stats.gather_table_stats('BARS', 'CCK_AN_TMP');   -- сбор статистики
  exception when no_data_found then  NULL;
  end;

logger.info ('PLAY_INT :p_DAT1='|| p_dat1 || ' , p_DAT2='|| p_dat2);
---------------------------------------------------------------------
  for k in (select BRANCH, i.id, a.kv, a.nbs, a.acc, least(nvl(i.STP_DAT,p_DAT2),p_DAT2) DAT2, a.daos, i.metr, nvl(a.ob22,'OB') ob22,
                   i.basey, a.dapp, a.ostc
            from accounts a, int_accn i
            where a.nbs > '2' and nbs < '4'  and a.acc=i.acc and i.id in (0,1)  and (a.dazs is null or a.dazs > p_DAT2 )  -- закрытые сч
--and a.nls='26354509039024'
              and NOT ( a.nbs = '2620' and a.ob22 in ('05','15','16','17','18','19','20','21','22','23','28','29') )
            )
  loop
    DAT1_   := greatest(k.daos, p_DAT1) ;
    If k.id  = 1 and DAT1_ > p_DAT1 then   DAT1_ := Dat1_ +1;  end if;
    If DAT1_<= k.DAT2   then

       If k.dapp <= DAT1_ then -- oстаток не менялся
          IR_ := acrn.fprocn ( k.acc, k.id, k.dapp); s_ := calp ( k.ostc, IR_, DAT1_, k.DAT2, k.basey );
       else
          If k.metr=7 then  update int_accn set metr = 1 where acc=k.acc and id = k.id; end if;
          acrN.p_int(k.acc, k.id, DAT1_, k.DAT2, S_, NULL, 2 );
          If k.metr=7 then  update int_accn set metr = 7 where acc=k.acc and id = k.id; end if;
       end if;

       S_ := round(S_,0);
       If S_ <> 0 then   If k.KV <> gl.baseval then Q_ := gl.p_icurval(k.KV,S_,k.DAT2); else q_ := S_;   end if;
          -- заполним колонки сумм внутренней табл-протокола ICCCCOOVVV/BBBBBB/BBBBBB/BBBBBB/
          --------  I ----CCCC ----  OO  ------------------ VVV -------/BBBBBB/BBBBBB/BBBBBB/---------------------------
          ind_ := k.id || k.nbs || k.ob22 || substr('000'||k.kv,-3) || k.branch ;
          If s_ > 0  then
             if tmp1.EXISTS (ind_) then                    tmp1(ind_).n3 := tmp1(ind_).n3 +S_; tmp1(ind_).n4 := tmp1(ind_).n4 +Q_;
             else  tmp1(ind_).n1 := 0; tmp1(ind_).n2 := 0; tmp1(ind_).n3 :=                S_; tmp1(ind_).n4 :=                Q_;
             end if;
          else
             if tmp1.EXISTS (ind_) then                    tmp1(ind_).n1 := tmp1(ind_).n1 -S_; tmp1(ind_).n2 := tmp1(ind_).n2 -Q_;
             else  tmp1(ind_).n3 := 0; tmp1(ind_).n4 := 0; tmp1(ind_).n1 :=               -S_; tmp1(ind_).n2 :=               -Q_;
             end if;
          end if;
       end if;
       S_ := 0;
    end if;
  end loop;

logger.info ('PLAY_INT :Расчет завершен.');
---------------------------------------------------------------------
  --- выгрузим все во внешнюю табл-протокол
  ind_ := tmp1.FIRST; -- установить курсор на  первую запись
  WHILE ind_   IS NOT NULL
  LOOP
     ID_     := to_number(substr(ind_, 1 , 1 ));
     NBS_    :=           substr(ind_, 2 , 4 ) ;
     if substr(ind_, 6 , 2 )='OB'
     then OB22_:=null;
     else
     OB22_   :=           substr(ind_, 6 , 2 ) ;
     end if;
     KV_     := to_number(substr(ind_, 8 , 3 ));
     branch_ :=           substr(ind_,11 ,22 ) ;
     insert into CCK_AN_TMP ( BRANCH ,KV ,NBS  ,CC_ID, PR ,            N1,           N2,            N3,            N4,   NAME1 )
                    values  ( BRANCH_,KV_,NBS_ ,OB22_, ID_, tmp1(ind_).n1,tmp1(ind_).n2, tmp1(ind_).n3, tmp1(ind_).n4, a_NAME1 );
     ind_    := tmp1.NEXT(ind_); -- установить курсор на след.вниз запись
  end loop;
logger.info ('PLAY_INT :Выгрузка завершена.');
---------------------------------------------------------------------
  <<KIN>> null;
end PLAY_INT;
/
show err;

PROMPT *** Create  grants  PLAY_INT ***
grant EXECUTE                                                                on PLAY_INT        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PLAY_INT        to RPBN001;
grant EXECUTE                                                                on PLAY_INT        to SALGL;
grant EXECUTE                                                                on PLAY_INT        to TECH001;
grant EXECUTE                                                                on PLAY_INT        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PLAY_INT.sql =========*** End *** 
PROMPT ===================================================================================== 
