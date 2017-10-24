
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cck_report.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CCK_REPORT IS

---------------------------------------
PROCEDURE COUNT_CCk ( p_mode int, p_dat1 date, p_dat2 date) ;
END CCK_REPORT;
/
CREATE OR REPLACE PACKAGE BODY BARS.CCK_REPORT IS
 l_dat1 date;          l_dat2 date;
 s_dat1 varchar2(10);  s_dat2 varchar2(10);
---------------------------------------
PROCEDURE COUNT_CCk ( p_mode int, p_dat1 date, p_dat2 date) is

  -- 06.02.2014 Обновлена логика отбора закрытых счетов в КП и БПК

  -- 21.11.2013 Sta+Nata

/*
P PR     = 1 КРЕДИТИ ФІЗИЧНИХ ОСІБ  БЕЗ урахування  БПК
         = 2 КРЕДИ ФІЗИЧНИХ ОСІБ під БПК
         = 3 РАЗОМ  КРЕДИТИ ФІЗИЧНИХ ОСІБ з урахуванням  БПК

S PRS    = 1 Довгострокові кредити
         = 2 Короткострокові кредити
         = 3 Прострочені кредити

V KV     = 1 в національній валюті
         = 2 в іноземній валюті

  N1 = станом на початок звітного періода
  N2 = наданих у звітному місяці (за новими угодами)
  N3 = заборгованість за основним боргом за якими у повному обсязі
       перенесено на рахунки простроченої заборгованості протягом звітного місяця
  N4 = виконаних (закритих) за звітний місяць
  N5 = кількість угод за якими наявна заборгованість
  UV = станом на кінець звітного періода	      всього угод
------------
*/

----------------------------------------
  TYPE many1 IS RECORD ( N1 number, N2 number, N3 number, N4 number, n5 number, UV number, kod varchar2(7) );
  TYPE MANY  IS TABLE  OF many1 INDEX BY VARCHAR2(3);
  tmp  MANY;
  PSV        VARCHAR2(3);
  P3V        VARCHAR2(3);
  P_ char(1);
  S_ char(1);
  V_ char(1);
  aa accounts%rowtype;

  name_ varchar2(30);
  l_nbs      varchar2(4);
  l_ost_2207 number;
  l_dapp     date  ;
  l_ost      number;
---------------------------------------
begin
 l_dat2 := nvl (  nvl(p_dat2,gl.bd) , trunc(sysdate    ) ) ;
 l_dat1 := nvl (      p_dat1        , trunc(l_dat2,'MM') ) ;
 s_dat1 := to_char(l_dat1, 'dd.mm.yyyy')    ;
 s_dat2 := to_char(l_dat2, 'dd.mm.yyyy')    ;

 PUL_DAT ( s_dat1, s_dat2 );
 EXECUTE IMMEDIATE 'truncate TABLE CCK_AN_TMP ';
 tmp.DELETE;

 tmp('111').n1:=0; tmp('111').n2:=0; tmp('111').n3:=0; tmp('111').n4:=0; tmp('111').n5:=0; tmp('111').uv:=0; tmp('111').kod:='1.1.1';
 tmp('112').n1:=0; tmp('112').n2:=0; tmp('112').n3:=0; tmp('112').n4:=0; tmp('112').n5:=0; tmp('112').uv:=0; tmp('112').kod:='1.1.2';

 tmp('121').n1:=0; tmp('121').n2:=0; tmp('121').n3:=0; tmp('121').n4:=0; tmp('121').n5:=0; tmp('121').uv:=0; tmp('121').kod:='1.2.1';
 tmp('122').n1:=0; tmp('122').n2:=0; tmp('122').n3:=0; tmp('122').n4:=0; tmp('122').n5:=0; tmp('122').uv:=0; tmp('122').kod:='1.2.2';

 tmp('131').n1:=0; tmp('131').n2:=0; tmp('131').n3:=0; tmp('131').n4:=0; tmp('131').n5:=0; tmp('131').uv:=0; tmp('131').kod:='1.3.1';
 tmp('132').n1:=0; tmp('132').n2:=0; tmp('132').n3:=0; tmp('132').n4:=0; tmp('132').n5:=0; tmp('132').uv:=0; tmp('132').kod:='1.3.2';

 tmp('211').n1:=0; tmp('211').n2:=0; tmp('211').n3:=0; tmp('211').n4:=0; tmp('211').n5:=0; tmp('211').uv:=0; tmp('211').kod:='1.4.1';
 tmp('212').n1:=0; tmp('212').n2:=0; tmp('212').n3:=0; tmp('212').n4:=0; tmp('212').n5:=0; tmp('212').uv:=0; tmp('212').kod:='1.4.2';

 tmp('221').n1:=0; tmp('221').n2:=0; tmp('221').n3:=0; tmp('221').n4:=0; tmp('221').n5:=0; tmp('221').uv:=0; tmp('221').kod:='1.5.1';
 tmp('222').n1:=0; tmp('222').n2:=0; tmp('222').n3:=0; tmp('222').n4:=0; tmp('222').n5:=0; tmp('222').uv:=0; tmp('222').kod:='1.5.2';

 tmp('231').n1:=0; tmp('231').n2:=0; tmp('231').n3:=0; tmp('231').n4:=0; tmp('231').n5:=0; tmp('231').uv:=0; tmp('231').kod:='1.6.1';
 tmp('232').n1:=0; tmp('232').n2:=0; tmp('232').n3:=0; tmp('232').n4:=0; tmp('232').n5:=0; tmp('232').uv:=0; tmp('232').kod:='1.6.2';

 ------------- STA P = 1 КРЕДИТИ ФІЗИЧНИХ ОСІБ  БЕЗ урахування  БПК
 P_  := '1';
 for dd in (select * from cc_deal where vidd in (11,12,13) and sos>9  )
 loop
    begin
      select * into aa from accounts where tip='LIM' and daos <= l_dat2 and (dazs is null or dazs >= l_dat1)
               and acc in (select acc from nd_acc where nd= dd.nd);
    EXCEPTION WHEN NO_DATA_FOUND THEN   goto NextRec;
    end;

    If aa.kv= gl.baseval then V_ := '1';
    else                      V_ := '2';
    end if;

    If dd.wdate < l_dat1 then                       S_ := '3';
    else
       If months_between(dd.wdate,dd.sdate)>12 then S_ := '1';
       else                                         S_ := '2';
       end if;
    end if;
    l_ost := fost( aa.acc, l_dat2) ; --остаток тела
    psv := P_ ||  S_ || V_;
    P3V := P_ || '3' || V_;

    If dd.sdate < l_dat1 then                           tmp(psv).n1 := tmp(psv).n1 + 1; -- входящие
    else                                                tmp(psv).n2 := tmp(psv).n2 + 1; -- выданные (приход новых)
    end if;

    -- нулевой остаток
    If l_ost=0 then
       If  aa.dazs >= l_dat1 and aa.dazs <= l_dat2 then
           tmp(psv).n4 := tmp(psv).n4 + 1; -----------------погашенные
       end if;
       tmp(psv).uv := tmp(psv).uv + 1;     -----------------исходящие ВСЕГО
       goto NextRec;
    end if;

    -- НЕ нулевой остаток
    if dd.wdate >= l_dat1 and dd.wdate <= l_dat2 then
       -- новая просрочка
       tmp(psv).n3 := tmp(psv).n3 + 1;     -----------------вынос на просрочку
       tmp(p3v).n3 := tmp(p3v).n3 + 1;     -----------------приняты на просрочку(приход новых)*************!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
       tmp(p3v).uv := tmp(p3v).uv + 1;     -----------------исходящие по просрочке ВСЕГО
       tmp(p3v).n5 := tmp(p3v).n5 + 1;     -----------------исходящие по просрочке в тч c остатком
       goto NextRec;
    end if;
    tmp(psv).n5 := tmp(psv).n5 + 1;        -----------------исходящие обычны c остатком
    tmp(psv).uv := tmp(psv).uv + 1;        -----------------исходящие обычны

    <<NextRec>> null;
 end loop;

 -------------NATA P = 2 КРЕДИ ФІЗИЧНИХ ОСІБ під БПК
 P_  := '2';
 for dd in ( select o.acc_ovr, o.acc_2207, a.* from bpk_all_accounts o, accounts a
              where o.acc_pk = a.acc and a.nls like '2625%' and a.daos <= l_dat2 and (a.dazs is null or a.dazs >= l_dat1)
                and (o.acc_ovr is not null or o.acc_9129 is not null) )
 loop
    If dd.kv = gl.baseval then V_:='1'; else  V_ := '2';   end if;

    if dd.acc_2207 is not null then    l_ost_2207 := fost(dd.acc_2207, l_dat2);
    else                               l_ost_2207 := 0;
    end if;
    if l_ost_2207 < 0 and l_ost_2207 = -dd.lim then     S_:='3';
    else
       if dd.tip = 'W4C' or dd.tip like 'PK%' then
          S_:='2';
       else
          S_:='1';
       end if;
    end if;
    psv := P_ ||  S_ || V_;
    P3V := P_ || '3' || V_;

    if dd.acc_ovr is not null then
       l_ost := fost(dd.acc_ovr, l_dat2) ; --остаток тела
    else
       l_ost := 0;
    end if;

    If dd.daos < l_dat1 then                            tmp(psv).n1 := tmp(psv).n1 + 1; -- входящие
    else                                                tmp(psv).n2 := tmp(psv).n2 + 1; -- выданные (приход новых)
    end if;

    -- нулевой остаток
    If l_ost = 0 and l_ost_2207 = 0 then
       If  dd.dazs >= l_dat1 and dd.dazs <= l_dat2 then
           tmp(psv).n4 := tmp(psv).n4 + 1; -----------------погашенные
       end if;
       tmp(psv).uv := tmp(psv).uv + 1;     -----------------исходящие ВСЕГО
       goto NextRec;
    end if;

    -- НЕ нулевой остаток
    if l_ost_2207 < 0 then
       -- новая просрочка
       tmp(psv).n3 := tmp(psv).n3 + 1;     -----------------вынос на просрочку
       tmp(p3v).n3 := tmp(p3v).n3 + 1;     -----------------приняты на просрочку(приход новых)
       tmp(p3v).uv := tmp(p3v).uv + 1;     -----------------исходящие по просрочке ВСЕГО
       tmp(p3v).n5 := tmp(p3v).n5 + 1;     -----------------исходящие по просрочке в тч c остатком
       goto NextRec;
    end if;
    tmp(psv).n5 := tmp(psv).n5 + 1;        -----------------исходящие обычны c остатком
    tmp(psv).uv := tmp(psv).uv + 1;        -----------------исходящие обычны

    <<NextRec>> null;
 end loop;

 ------------- ALL P = 3 РАЗОМ  КРЕДИТИ ФІЗИЧНИХ ОСІБ з урахуванням  БПК
 -- выгрузить в таблицу (сверху -> вниз)

 PSV := tmp.FIRST; -- установить курсор на  первую запись
 WHILE PSV IS NOT NULL
 LOOP
   If substr(psv,3,1) = '1'  then name_:= '    в національній валюті'; else name_:= '    в іноземній валюті'; end if;
   insert into CCK_AN_TMP  (pr, prs, kv, n1, n2, n3, n4, n5, uv, name, nlsalt )
                   values  (substr(psv,1,1),
                            substr(psv,2,1),
                            substr(psv,3,1),
                            tmp(psv).n1,
                            tmp(psv).n2,
                            tmp(psv).n3,
                            tmp(psv).n4,
                            tmp(psv).n5,
                            --tmp(psv).uv,
                            decode(substr(psv,2,1),'3',tmp(psv).n1+tmp(psv).n3-tmp(psv).n4,tmp(psv).n1+tmp(psv).n2-tmp(psv).n3-tmp(psv).n4),
                            name_,
                            tmp(psv).kod
                            );
   PSV := tmp.NEXT(PSV); -- установить курсор на след.вниз запись
 end loop;

 --- итого
 insert into CCK_AN_TMP (pr, prs, kv,     n1 ,     n2 ,     n3 ,     n4 ,     n5 ,     uv,      name , nlsalt )
                   select 3, prs, kv, sum(n1), sum(n2), sum(n3), sum(n4), sum(n5), sum(uv), min(name),
                          '1.'||decode (prs,'1','7', '2','8', '9')|| '.'|| kv
                   from CCK_AN_TMP    group by prs, kv;
 ---- заголовки --------

 insert into CCK_AN_TMP (pr,  n1 ,     n2 ,     n3 ,     n4 ,     n5 ,     uv,      name  )
                   select pr,  sum(n1), sum(n2), sum(decode(prs,3,n3,0)), sum(n4), sum(n5), sum(uv),
                          decode( pr,1, 'КРЕДИТИ ФО БЕЗ урахування БПК',
                                     2, 'КРЕДИТИ ФО під БПК',
                                        'РАЗОМ КРЕДИТИ ФО з урахув.БПК'
                                )
                   from CCK_AN_TMP  where kv in (1,2) group by pr ;

 insert into CCK_AN_TMP (nlsalt, pr, prs,     name ) values ('1.1', 1, 1,'  Довгострокові кредити');
 insert into CCK_AN_TMP (nlsalt, pr, prs,     name ) values ('1.2', 1, 2,'  Короткострокові кредити');
 insert into CCK_AN_TMP (nlsalt, pr, prs,     name ) values ('1.3', 1, 3,'  Прострочені кредити');
 insert into CCK_AN_TMP (nlsalt, pr, prs,     name ) values ('1.4', 2, 1,'  Довгострокові кредити');
 insert into CCK_AN_TMP (nlsalt, pr, prs,     name ) values ('1.5', 2, 2,'  Короткострокові кредити');
 insert into CCK_AN_TMP (nlsalt, pr, prs,     name ) values ('1.6', 2, 3,'  Прострочені кредити');
 insert into CCK_AN_TMP (nlsalt, pr, prs,     name ) values ('1.7', 3, 1,'  Довгострокові кредити');
 insert into CCK_AN_TMP (nlsalt, pr, prs,     name ) values ('1.8', 3, 2,'  Короткострокові кредити');
 insert into CCK_AN_TMP (nlsalt, pr, prs,     name ) values ('1.9', 3, 3,'  Прострочені кредити');

end COUNT_CCk;

end CCK_REPORT  ;
/
 show err;
 
PROMPT *** Create  grants  CCK_REPORT ***
grant EXECUTE                                                                on CCK_REPORT      to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cck_report.sql =========*** End *** 
 PROMPT ===================================================================================== 
 