
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/nada.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.NADA 
 is
--17.07.2012 Убрала проц. DAY7 совсем \ перенесено в процедуру CCKGL
--26-06-2012 Убрала проц. MES2 совсем /
-----------------------------------------------
function OSTS8
 (acc_  saldoa.acc%type,
  d1_   saldoa.fdat%type,
  d2_   saldoa.fdat%type
 ) return number;
-- получение среднего остатка по saldoa

function OSTS (p_acc ACCM_SNAP_BALANCES.acc%type,
 p_dat1 ACCM_CALENDAR.CALDT_DATE%type,
 p_dat2 ACCM_CALENDAR.CALDT_DATE%type
 )
 return ACCM_SNAP_BALANCES.ost%type;
-- получение среднего остатка по ежедневным снимкам

-----------------------------------------------------
PROCEDURE RU_1007 ( p_mode int, s_DAT1 varchar2 , s_DAT2 varchar2) ;
-- отчета по межобласному перемещению наличности.
-- Это стандартный отчет НБУ, подаваемый банком на едином МФО.
-----------------------------------------------------

PROCEDURE NB8 ( p_mode int, s_DAT1 varchar2 , s_DAT2 varchar2) ;
--BARS.NADA8 Просроченная_задолженность/
--Информация о просроченной задолженности за период
-----------------------------------------------------


PROCEDURE NB7 ( p_rnk int, s_DAT1 varchar2 , s_DAT2 varchar2) ;
--BARS.NADA7 Отчет об оборотах клиента за период
------------------------------------------------------

PROCEDURE cck5
( p_mode int, -- = 1- по горизонталиЮ, =0 - по вертикали
 S_dat11 VARCHAR2,
 S_dat12 VARCHAR2,
 S_dat21 VARCHAR2,
 S_dat22 VARCHAR2,
 S_dat31 VARCHAR2,
 S_dat32 VARCHAR2,
 S_dat41 VARCHAR2,
 S_dat42 VARCHAR2,
 S_dat51 VARCHAR2,
 S_dat52 VARCHAR2
) ;

PROCEDURE cck51
( p_mode int, --по вертикали: 0 = реальное погашение, 1- реструктуризация
 -- только по КП БАРСА
 S_dat11 VARCHAR2,
 S_dat12 VARCHAR2,
 S_dat21 VARCHAR2,
 S_dat22 VARCHAR2,
 S_dat31 VARCHAR2,
 S_dat32 VARCHAR2,
 S_dat41 VARCHAR2,
 S_dat42 VARCHAR2,
 S_dat51 VARCHAR2,
 S_dat52 VARCHAR2
) ;
-----------
PROCEDURE cckGL
( p_mode int,

 --0 = реальное погашение, 1- реструктуризация
 --328	ДЕФ:Вiдомiсть РЕАЛЬНИХ погаш.,до 5-ти перiодiв, ПРОВОДКИ FunNSIEditF("TMPV_CCK5[PROC=>NADA.cckGL(0,:B1,:E1,:B2,:E2,:B3,:E3,:B4,:E4,:B5,:E5)][PAR=>:B1(SEM=B1),:E1(SEM=E1),:B2(SEM=B2),:E2(SEM=E2),:B3(SEM=B3),:E3(SEM=E3),:B4(SEM=B4),:E4(SEM=E4),:B5(SEM=B5),:E5(SEM=E5)][EXEC=>BEFORE]",1)
 --977	ДЕФ:Вiдомiсть РЕСТРУКТ-погаш.,до 5-ти перiодiв, ПРОВОДКИ FunNSIEditF("TMPR_CCK5[PROC=>BARS.NADA.cckGL(1,:B1,:E1,:B2,:E2,:B3,:E3,:B4,:E4,:B5,:E5)][PAR=>:B1(SEM=B1),:E1(SEM=E1),:B2(SEM=B2),:E2(SEM=E2),:B3(SEM=B3),:E3(SEM=E3),:B4(SEM=B4),:E4(SEM=E4),:B5(SEM=B5),:E5(SEM=E5)][EXEC=>BEFORE]",1)
  --
  --
  --2 = ( вместо процедуры MES2 )
  --1041 КП(XLS-800) Розгор., Погашення за 2 сумiжнi мiс.,ПРОВОДКИ ExportCatQuery( 800,"",8,"",TRUE)
  --
  --
  --7 = ( вместо процедуры DAY7 )
  --835	?? DAY7 КП Розгорнен: Звiт за  Мiсяць	N/A	FunNSIEditF("TEST_MART7[PROC=>NADA.day7(:D,:N)][PAR=>:D(SEM= Дата_ПО,TYPE=S),:N(SEM=Реф_КД)][EXEC=>BEFORE]",1)
  --989	?? DAY7 КП Згорнений: Звiт за  Мiсяць	N/A	FunNSIEditF("V_TEST_MART7[PROC=>NADA.day7(:D,:N)][PAR=>:D(SEM= Дата_ПО,TYPE=S),:N(SEM=Реф_КД)][EXEC=>BEFORE]",1)
  --1079?? DAY7 КП(XLS-810) Розгорнений: Звiт за  Мiсяць	N/A	ExportCatQuery( 810,"",8,"",TRUE)
  --
  S_dat11   VARCHAR2,
  S_dat12   VARCHAR2,
  S_dat21   VARCHAR2,
  S_dat22   VARCHAR2,
  S_dat31   VARCHAR2,
  S_dat32   VARCHAR2,
  S_dat41   VARCHAR2,
  S_dat42   VARCHAR2,
  S_dat51   VARCHAR2,
  S_dat52   VARCHAR2
)   ;
------------------------
--КП Розгорнений: Звiт за  Квартал
--КП Згорнений: Звiт за  Квартал
procedure QWT
(Y_ char,  --- ГОД     = yyyy -- по умолч = 2012
 Q_ char,   --- Квартал = Q    -- по умолч = 1
 s_ND varchar2
 ) ;
-------------------------------------

end nada;
/
CREATE OR REPLACE PACKAGE BODY BARS.NADA IS

/*
--30.08.2012
exec BARS.NADA30.cckGL(2, '31.07.2012','','','','','','','','','');
exec NADA30.cckGL(7, '31.07.2012','','','','','','','','','');
полностью совпадают в части сумм погашения за текущий мес
kol_sp перевела на таблицу cc_kol_sp

*/

 dat_01m date :=to_date('01-04-2012','dd-mm-yyyy'); -- мес мигр Киева и львова
 dat_lvv date :=to_date('02.04.2012','dd-mm-yyyy'); -- дата мирг львова
 dat_kie date :=to_date('06.04.2012','dd-mm-yyyy'); -- дата мигр киева

 t_POG_p number ; p_POG_p number ; k_POG_p number ; p_dos0 number ;
 t_POG_t number ; p_POG_t number ; k_POG_t number ; t_dos0 number;

-----------------------------------------------
function OSTS8
 (acc_  saldoa.acc%type,
  d1_   saldoa.fdat%type,
  d2_   saldoa.fdat%type
 )
 return number IS

-- получение среднего остатка по saldoa
 s_ number := 0;  dm_ date;  dx_ date ; kd_ int; k1_ int; k2_ int; k3_ int;
begin

-- ошибка
If d1_ > d2_ then return 0; end if;

-- одна дата
If d1_ = d2_ then
   select ostf-dos+kos into s_ from saldoa
   where acc  = acc_
     and fdat = (select max(fdat) from saldoa where acc=acc_ and fdat<= d1_);
   RETURN s_;
end if;
------------------------
-- период
select min(fdat), max(fdat), count(*) into dm_, dx_ , kd_
from saldoa where acc = acc_ and fdat >= d1_ and fdat <= d2_;

begin
  -- в периоде не было изменений
  If kd_ = 0 then
     select ostf-dos+kos into s_ from saldoa
      where acc  = acc_
        and fdat = (select max(fdat) from saldoa where acc=acc_ and fdat< d1_);
     RETURN s_;
  end if;

  k1_ := dm_ - d1_ ;
  k2_ := d2_ - dx_ ;
  k3_ := d2_ - d1_ + 1;

  -- в периоде было 1 изменение
  If KD_  = 1 then
     select ostf*k1_ + (ostf-dos+kos) *(k2_+1) into s_ from saldoa
      where acc  = acc_  and fdat = dm_;
     RETURN   round ( S_ / k3_, 0 );
  end if;
---------

  -- в периоде было более 1-го изменения
  select
  sum( CASE WHEN fdat= dm_              THEN ostf*(dm_ -d1_ )
            WHEN dm_< fdat and fdat<dx_ THEN ostf*(fdat-pdat)
            WHEN fdat= dx_              THEN ostf*(fdat-pdat)+(ostf-dos+kos)*(d2_-dx_+1)
            ELSE                              0
       end
       ) into s_
  from saldoa
  where acc= acc_ and fdat >= dm_ and fdat<= dx_;

  s_ := round ( S_ / k3_, 0 );

EXCEPTION WHEN NO_DATA_FOUND THEN s_:=0;
end;

 return nvl(s_,0);

end OSTS8;
-----------

function OSTS (p_acc ACCM_SNAP_BALANCES.acc%type,
 p_dat1 ACCM_CALENDAR.CALDT_DATE%type,
 p_dat2 ACCM_CALENDAR.CALDT_DATE%type
 )
 return ACCM_SNAP_BALANCES.ost%type IS
-- получение среднего остатка по ежедневным снимкам

 l_ost ACCM_SNAP_BALANCES.ost%type := 0;

begin
 select NVL( sum(m.ost)/(max(k.caldt_id) - min (k.caldt_id) +1), 0)
 into l_ost
 from ACCM_SNAP_BALANCES m, ACCM_CALENDAR k
 where m.acc = p_acc
 and m.caldt_id = k.bankdt_id
 and k.caldt_date >= p_dat1
 and k.caldt_date <= p_dat2;

 RETURN l_ost;

end OSTS;
-----------------------------------------------------

PROCEDURE RU_1007 ( p_mode int, s_DAT1 varchar2 , s_DAT2 varchar2) IS
-- отчета по межобласному перемещению наличности.
-- Это стандартный отчет НБУ, подаваемый банком на едином МФО.
 dat1_ date := to_date( s_DAT1,'dd.mm.yyyy');
 dat2_ date := to_date( s_DAT2,'dd.mm.yyyy');
begin

 -- отобрать счета
 delete from CCK_AN_TMP;
 insert into CCK_AN_TMP (acc, BRANCH, N1, N2)
 select a.acc, substr(a.branch,1,15), fost(a.acc, dat1_-1), fost(a.acc, dat2_)
 from accounts a
 where a.nbs ='1007' and a.ob22='04' and a.dapp>= dat1_ and a.kv = 980 ;

 -- все отправки/получения
 delete from TMP_CRTX;
 insert into TMP_CRTX (REF, ACC , DK, S, FDAT, tip)
 select ref, acc, dk, s, fdat, stmt
 from opldok
 where acc in (select acc from CCK_AN_TMP)
 and sos = 5 and fdat >= dat1_ and fdat <= dat2_;

 PUL_DAT(s_DAT1,s_DAT2);

end RU_1007;
-----------------------------------------------------

PROCEDURE NB8 ( p_mode int, s_DAT1 varchar2 , s_DAT2 varchar2) is

 ---03-02-2012 Перед поездкой в Лондон

 ---BARS.NADA8 Просроченная_задолженность/
 --Информация о просроченной задолженности за период

 p_DAT1 opldok.fdat%type :=
 NVL( to_date (s_DAT1, 'dd.mm.yyyy'), trunc(gl.BD,'MM'));
 p_DAT2 opldok.fdat%type :=
 NVL( to_date (s_DAT2, 'dd.mm.yyyy'), gl.BD);
 -------------------------
 kor_ int := 10 ;
 l_nd nd_acc.acc%type ;
 l_NBS accounts.NBS%type ;
 -------------------------
begin

 EXECUTE IMMEDIATE 'truncate TABLE tmp_NADA8 ';

 insert into tmp_nada8
  (DAT1,DAT2, BRANCH,PROD,KV,NLS,CC_ID,ND,ID1,ID2,SPOK,FIN,OBS,NMK,OST,acc,OSTQS)
 select p_dat1, p_dat2, d.BRANCH,
   substr(d.prod,1,6) PROD,
   nvl(a.KV, aa.KV )  kv ,
   nvl(a.NLS,aa.nls)  nls,
   d.CC_ID, d.ND, d.SKARB_ID ID1,
   substr( cck_app.get_nd_txt(d.ND, 'LOANS'),1,40) ID2,
   substr( cck_app.get_nd_txt(d.ND, 'SPOK' ),1,40) SPOK,
   nvl(d.fin,c.crisk) FIN, d.obs OBS, c.NMK,
 - gl.p_icurval( aa.kv, nada.OSTS8(aa.acc, p_dat2, p_dat2), p_DAT2) /100,
   aa.ACC,
 - gl.p_icurval( aa.kv, nada.OSTS8(aa.acc, p_dat1, p_dat2), p_DAT2) /100
 from cc_deal d, cc_add ad, ACCOUNTS A , customer c, nd_acc nn, v_gl aa
 where d.sdate < p_dat2 and d.sos>=10 and d.sos < 15
   and aa.tip = 'LIM' and aa.acc = nn.acc     and nn.nd = d.nd and d.nd = ad.nd
   and aD.ADDS = 0    AND AD.ACCS = A.ACC (+) and d.rnk = c.rnk
 union all
 select p_dat1, p_dat2,a.branch,a.nbs||a.ob22, a.kv, a.nls, '?', 0,
   null, null,null,c.crisk, null,c.nmk,
 - gl.p_icurval( a.kv, nada.OSTS8 (a.acc, p_dat2, p_dat2), p_DAT2) /100,
   a.ACC,
 - gl.p_icurval( a.kv, nada.OSTS8 (a.acc, p_dat1, p_dat2), p_DAT2) /100
 from v_gl a, customer c
 where c.rnk = a.rnk
   and (a.nbs like '22_3' or a.nbs like '22_2' or a.nbs like '22_7' or a.nbs like '2220'
     or a.nbs like '20_3' or a.nbs like '20_2' or a.nbs like '20_7' or a.nbs like '2020'
        )
   and accc is null
   and fost(a.acc,p_dat2) <> 0;

  update tmp_nada8 t
     set t.mfo_old = (select val from BRANCH_PARAMETERS
                      where tag= 'MFO_OLD' and branch= substr(t.branch,1,15) ),
         t.zn50    = (select zn50 from  sb_ob22 where r020||ob22 = t.prod),
         t.FINS    = decode ( t.fin, 1,'А',
                                     2,'Б',
                                     3,'В',
                                     4,'Г',
                                     5,'Д', '?');
  commit;
---------------------
  If to_char(p_DAT2,'MM') = '12' then   kor_   := 20 ;  end if;

  for k in (
    select a.NBS, o.tt, o.sQ, o.ref, o.stmt, p.VOB , p.VDAT, o.fdat
    from opldok o, v_gl a, oper p
    where a.acc=o.acc and p.ref= o.ref and o.dk=1 and o.tt not like 'ZG_'
     and ( a.nbs like '602_'  or a.nbs like '604_'  or a.nbs in
           ('6110','6111','6113','6114','6116','6118','6119','6397','6399'))
     and o.fdat >= p_DAT1 and o.fdat <= (p_DAT2+ kor_)
            )
  loop

    If k.vob in (96,99)   then  -- это коррект прошлого периода
       If k.vdat < p_DAT1 then  goto NextRec;     end if;
    else                        -- это обычные будущего периода
       If k.fdat > p_DAT2 then  goto NextRec;     end if;
    end if;

    l_nd := null;

    If k.nbs like '60__' then  l_NBS := substr(k.nbs,1,3) ||'0';
    else                       l_NBS := k.NBS;
    end if;

    If l_nbs like '60%' or k.tt ='%%1' or l_nbs ='6111' then
       -- это доходы начисленные / Ищем КД по счету-корреспонденту
       begin
         select n.nd into l_nd from opldok o, nd_acc n
         where o.acc  = n.acc and o.ref = k.ref and o.stmt = k.stmt and o.dk = 0
           and rownum = 1;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
       end;
    end if;

    If l_nd is null then
       -- это доходы кассовым методом  / Ищем КД по доп.реквизиту
       begin
        select to_number(value) into l_nd from operw where TAG='ND' and ref=k.REF;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
       end;
    end if;

    If l_nd is not null then

       EXECUTE IMMEDIATE
       'update tmp_NADA8 set s' || l_nbs || ' = nvl(s'|| l_nbs ||
       ',0) + '|| k.sq || '/100 where nd = ' || l_nd ;
    end if;

   <<NextRec>> null;
  end loop;

  commit;

end NB8;
---------------------------------

-----------------------------
-- NB7 для WEB i Centura
-----------------------------
PROCEDURE NB7 ( p_rnk int,  s_DAT1 varchar2 ,  s_DAT2 varchar2)  is
  p_DAT1   opldok.fdat%type     :=
           NVL( to_date (s_DAT1, 'dd.mm.yyyy'), trunc(gl.BD,'MM'));
  p_DAT2   opldok.fdat%type     :=
           NVL( to_date (s_DAT2, 'dd.mm.yyyy'), gl.BD);
  r_oper   oper%rowtype         ;
  o_ed     accounts.dos%type    ; -- Внешний оборот ДЕБЕТ
  o_id     accounts.dos%type    ; -- Внутренний оборот ДЕБЕТ
  o_ek     accounts.kos%type    ; -- Внешний оборот КРЕДИТ
  o_ik     accounts.kos%type    ; -- Внутренний оборот КРЕДИТ
  l_nls    accounts.nls%type    := '0' ;
  l_kv     accounts.kv%type     :=  0  ;
  l_branch accounts.branch%type ;
  l_rnk    accounts.rnk%type    ;
  l_nbs    accounts.nbs%type    ;
  l_nb2    char(2)              ;
  l_mfo    banks.mfo%type       ;

begin


  delete from nada_nd7_web where userid=user_id;

  FOR k in ( select a.nls, a.rnk, a.acc, a.branch, a.kv, o.ref, o.dk, o.sq, o.stmt
             from opldok o, accounts a
             where  a.acc  = o.acc
               and o.fdat >= p_dat1 and o.fdat<=p_dat2
               and  a.nbs in ('2600','2650')
               and  exists (select 1 from customerw  where  value like '1%'
                              and  rnk = a.rnk    and  tag ='SEGM '       )
               and a.RNK = decode (p_rnk,0, a.rnk, p_rnk)
             union all
             select '9', 0, 0, '/', 0, 0, 0, 0, 0  from dual
             order by 1,2)

  loop

     If l_nls <> k.nls or l_kv <> k.KV then

        If l_nls  <> '0' and ( o_ed+o_id+o_ek+o_ik ) > 0 then
           -- выложить итоги по l_nls
           insert into nada_nd7_web
            (SDATE, WDATE, TOBO, RNK, NLS, KV, SUMG, SUM_RATN, SG_OSTC, SG_RATN, USERID )
            values
            (p_DAT1,p_DAT2, l_branch, l_rnk, l_NLS, l_KV, o_ed, o_id, o_ek, o_ik, user_id);
        end if;

        If k.nls = '9' then RETURN; end if;

        l_nls := k.nls ;  l_kv := k.kv; l_rnk := k.rnk ;  l_branch := k.branch;
        o_ed  := 0     ;  o_id := 0   ;  o_ek  := 0 ;  o_ik  := 0 ;

     end if;

     begin

       -- БС-корреспондент
       select a.nbs into l_nbs from opldok o, accounts a
       where a.acc = o.acc and o.ref = k.ref and o.stmt = k.stmt and o.dk = 1-k.dk;

       l_nb2 := substr( l_nbs,1,2);

       -- не бизнес-платежи
       If NOT ( l_nb2 < '20' Or l_nb2 in ( '25','26','37','39') ) then goto RecNext ;  end if;

       select * into r_oper from oper where ref = k.ref;

       -- сам-себе
       If nvl(r_oper.id_A,'*') =  nvl(r_oper.id_B,'*') then goto RecNext ;  end if;

     EXCEPTION WHEN NO_DATA_FOUND THEN goto RecNext;
     end;

     If r_oper.mfoa  !=  r_oper.mfob then

        begin

           -- временно, до окончания внедрения. В Мульти-МФО банка НАДРА!
           select mfo into l_mfo from banks
           where mfo  = decode(r_oper.mfoa, gl.aMfo, r_oper.mfob, r_oper.mfoa )
             and mfou NOT in ('320003', gl.aMfo);

           If k.dk = 0 then o_ed := o_ed + k.sq;
           else             o_ek := o_ek + k.sq;
           end if;

           GOTO RecNext;

        EXCEPTION WHEN NO_DATA_FOUND THEN  null;
        end;

     end if;

     If k.dk = 0 then o_id := o_id + k.sq;
     else             o_ik := o_ik + k.sq;
     end if;

     <<RecNext>> null;

  end loop;

end NB7;



-----------------------------

PROCEDURE cck5
( p_mode   int, -- = 1- по горизонталиЮ, =0 - по вертикали
  S_dat11   VARCHAR2,
  S_dat12   VARCHAR2,
  S_dat21   VARCHAR2,
  S_dat22   VARCHAR2,
  S_dat31   VARCHAR2,
  S_dat32   VARCHAR2,
  S_dat41   VARCHAR2,
  S_dat42   VARCHAR2,
  S_dat51   VARCHAR2,
  S_dat52   VARCHAR2   ) IS

  p_dat1    date ;  p_dat2 date ;
  -----------------
  l_segm   sb_ob22.SEGMENT%type := 999;
  l_branch cc_deal.branch%type  :='*******';
  l_spok   CC_NF_SPOK.id%type   :=0 ; -- Признак структурного подразделения
  l_kv     accounts.kv%type     :=0;   --по валюте (или все)
--l_tip    accounts.tip%type    ;
  l_sq     number(18,2)         ;
  -------------------------------
  TYPE   vectorD IS VARRAY(5) OF date ;
  p_B vectorD := vectorD( TO_DATE(S_DAT11,'DD.MM.YYYY'),
                          TO_DATE(S_DAT21,'DD.MM.YYYY'),
                          TO_DATE(S_DAT31,'DD.MM.YYYY'),
                          TO_DATE(S_DAT41,'DD.MM.YYYY'),
                          TO_DATE(S_DAT51,'DD.MM.YYYY') );

  p_E vectorD := vectorD( TO_DATE(S_DAT12,'DD.MM.YYYY'),
                          TO_DATE(S_DAT22,'DD.MM.YYYY'),
                          TO_DATE(S_DAT32,'DD.MM.YYYY'),
                          TO_DATE(S_DAT42,'DD.MM.YYYY'),
                          TO_DATE(S_DAT52,'DD.MM.YYYY') );
  --------------------------------

  TYPE vectorN IS VARRAY(7) OF NUMBER ;  -- по видам задолженностей
  TYPE matrixN IS VARRAY(7) OF vectorN;  -- по интервалам дат

-- сводно по бранчам
  i_S number   := 0;
  l_s  matrixN := matrixN(vectorN(0, 0, 0, 0, 0, 0, 0),
                          vectorN(0, 0, 0, 0, 0, 0, 0),
                          vectorN(0, 0, 0, 0, 0, 0, 0),
                          vectorN(0, 0, 0, 0, 0, 0, 0),
                          vectorN(0, 0, 0, 0, 0, 0, 0),
                          vectorN(0, 0, 0, 0, 0, 0, 0),
                          vectorN(0, 0, 0, 0, 0, 0, 0)
                          );


  v    INTEGER;                        -- вид задолженности 7 штук
  p    INTEGER;                        -- период            5 штук

  x_dat date := to_date('01-01-2000','dd-mm-yyyy');
  m_dat date := to_date('01-01-2099','dd-mm-yyyy');


begin
  p_dat1 := least    ( nvl(p_B(1),gl.bdate),
                       NVL(p_B(2),m_dat)   ,
                       NVL(p_B(3),m_dat)   ,
                       NVL(p_B(4),m_dat)   ,
                       NVL(p_B(5),m_dat)
                      ) ;
  p_dat2 := greatest ( nvl(p_E(1),gl.bdate),
                       NVL(p_E(2),x_dat)   ,
                       NVL(p_E(3),x_dat)   ,
                       NVL(p_E(4),x_dat)   ,
                       NVL(p_E(5),x_dat)
                      ) ;

  execute immediate 'truncate TABLE TMP_CCK5 ';
  ---------------
  l_s  := matrixN(vectorN(null, null, null, null, null, null, null),
                  vectorN(null, null, null, null, null, null, null),
                  vectorN(null, null, null, null, null, null, null),
                  vectorN(null, null, null, null, null, null, null),
                  vectorN(null, null, null, null, null, null, null),
                  vectorN(null, null, null, null, null, null, null),
                  vectorN(null, null, null, null, null, null, null)
                  );

  for k in (select  d.BRANCH,
                    nvl(s.SEGMENT,0) segm,
                    nvl(trim(cck_app.get_nd_txt(d.nd,'SPOK')),'0')  spok,
                    a.kv, a.acc, a.nls, a.tip, a.nbs
            from cc_deal d, v_gl a, nd_acc n, sb_ob22 s
            where d.vidd in (1,2,3,11,12,13)
              and d.nd   =  n.nd
              and n.acc  =  a.acc
              and a.pap  =  1
              and a.nbs  < '4'
              and a.kos  >  0
              and a.dapp >= p_dat1
              and s.r020 =  substr(d.prod,1,4)
              and s.ob22 =  substr(d.prod,5,2)
--and d.nd = 52864
            union all
            select '1',0,'0', 0, 0, '0','000','9999' from dual
            order by 1,2,3,4
            )
  loop

    If l_segm <> k.segm or l_branch <> k.branch or l_spok <> to_number(k.spok)
                        or l_kv     <> k.kv then
       If i_S  > 0 then

          If p_mode = 1 then
             -- выложить итоги по горизонтали в 1 строку
             insert into  TMP_CCK5 (branch,spok,kv,SEGM,
                 B1, E1, s11, s12, s13, s14, s15, s16, s17,
                 B2, E2, s21, s22, s23, s24, s25, s26, s27,
                 B3, E3, s31, s32, s33, s34, s35, s36, s37,
                 B4, E4, s41, s42, s43, s44, s45, s46, s47,
                 B5, E5, s51, s52, s53, s54, s55, s56, s57)
             values ( l_branch, l_spok, l_kv, l_segm,
                 p_B(1),p_E(1),l_s(1)(1),l_s(2)(1),l_s(3)(1),l_s(4)(1),l_s(5)(1),l_s(6)(1),l_s(7)(1),
                 p_B(2),p_E(2),l_s(1)(2),l_s(2)(2),l_s(3)(2),l_s(4)(2),l_s(5)(2),l_s(6)(2),l_s(7)(2),
                 p_B(3),p_E(3),l_s(1)(3),l_s(2)(3),l_s(3)(3),l_s(4)(3),l_s(5)(3),l_s(6)(3),l_s(7)(3),
                 p_B(4),p_E(4),l_s(1)(4),l_s(2)(4),l_s(3)(4),l_s(4)(4),l_s(5)(4),l_s(6)(4),l_s(7)(4),
                 p_B(5),p_E(5),l_s(1)(5),l_s(2)(5),l_s(3)(5),l_s(4)(5),l_s(5)(5),l_s(6)(5),l_s(7)(5)
                );
          elsIf p_mode = 0  then
             -- выложить итоги по вертикали до 5 строк
             FOR p IN 1..5
             loop
                If nvl(l_s(1)(p),0) + nvl(l_s(2)(p),0) +
                   nvl(l_s(3)(p),0) + nvl(l_s(4)(p),0) +
                   nvl(l_s(5)(p),0) + nvl(l_s(6)(p),0) + nvl(l_s(7)(p),0) > 0 then
                   insert into  TMP_CCK5 (branch,spok,kv,SEGM,
                                          B1, E1, s11, s12, s13, s14, s15, s16, s17)
                   values ( l_branch, l_spok, l_kv, l_segm,
                            p_B(p),p_E(p),l_s(1)(p),l_s(2)(p),l_s(3)(p),l_s(4)(p),
                                          l_s(5)(p),l_s(6)(p),l_s(7)(p) );
                end if;
             end loop;
          end if;

       end if;

       -- обнуление сумм
       i_S  := 0;
       l_s  := matrixN(vectorN(null, null, null, null, null, null, null),
                       vectorN(null, null, null, null, null, null, null),
                       vectorN(null, null, null, null, null, null, null),
                       vectorN(null, null, null, null, null, null, null),
                       vectorN(null, null, null, null, null, null, null),
                       vectorN(null, null, null, null, null, null, null),
                       vectorN(null, null, null, null, null, null, null)
                       );

       --запомнить новые ключи смены итога
       l_segm   := k.segm    ;
       l_branch := k.branch  ;
       l_kv     := k.kv      ;
       l_spok   := to_number(k.spok);

    END IF;

    for g in (select * from opldok
              where acc= k.acc and fdat >= p_dat1 and fdat <= p_dat2 and dk=1)
    loop
       begin
          select o.sq/100 into l_sq
          from opldok o, accounts a
    	      where o.acc  = a.acc
            and o.ref  = g.ref
            and o.stmt = g.stmt
            and o.dk   = 1-g.dk
            and a.nbs not like '20%'
            and a.nbs not like '21%'
            and a.nbs not like '22%'
            and a.nbs not like '35%'
            and a.tip not in
            ('SS ' ,'SN ','SK0','SP ','SPN','SK9','SLN', 'SLK') ;

          -- определить  вид задорлженности
          If    k.tip = 'SS '                      then v:=1;  --норм тело
          elsIf k.tip = 'SN ' or k.nbs like '2__8' then v:=2;  --норм проц
          elsIf k.tip = 'SK0' or k.nbs like '3578' then v:=3;  --норм ком
          elsIf k.tip = 'SP ' or k.nbs like '2__7' then v:=4;  --прос тело
          elsIf k.tip in ('SPN','SLN')
                              or k.nbs like '2__9' then v:=5;  --прос проц
          elsIf k.tip in ('SK9','SLK')
             or k.nbs in ('3579')                  then v:=6;  --прос ком
          else                                          v:=7;  --Другое
          end if;

          i_S := i_S + l_sq;
          -- просуммировать в периоды
          FOR p IN 1..5
          loop
             If g.fdat between p_B(p) and p_E(p) then
                l_s(v)(p) := nvl( l_s(v)(p), 0) + l_sq;
             end if;
          end loop;

      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end;

    end loop;

  end loop;
  return;
end cck5;


PROCEDURE cck51
( p_mode   int, --по вертикали:  0 = реальное погашение, 1- реструктуризация
  S_dat11   VARCHAR2,
  S_dat12   VARCHAR2,
  S_dat21   VARCHAR2,
  S_dat22   VARCHAR2,
  S_dat31   VARCHAR2,
  S_dat32   VARCHAR2,
  S_dat41   VARCHAR2,
  S_dat42   VARCHAR2,
  S_dat51   VARCHAR2,
  S_dat52   VARCHAR2
)    is
  p_dat1    date ;  p_dat2 date ;
  -----------------
  TYPE   vectorD IS VARRAY(5) OF date ;
  p_B vectorD := vectorD( TO_DATE(S_DAT11,'DD.MM.YYYY'),
                          TO_DATE(S_DAT21,'DD.MM.YYYY'),
                          TO_DATE(S_DAT31,'DD.MM.YYYY'),
                          TO_DATE(S_DAT41,'DD.MM.YYYY'),
                          TO_DATE(S_DAT51,'DD.MM.YYYY') );

  p_E vectorD := vectorD( TO_DATE(S_DAT12,'DD.MM.YYYY'),
                          TO_DATE(S_DAT22,'DD.MM.YYYY'),
                          TO_DATE(S_DAT32,'DD.MM.YYYY'),
                          TO_DATE(S_DAT42,'DD.MM.YYYY'),
                          TO_DATE(S_DAT52,'DD.MM.YYYY') );
  --------------------------------

  TYPE vectorN IS VARRAY(7) OF NUMBER ;  -- по видам задолженностей
  TYPE matrixN IS VARRAY(7) OF vectorN;  -- по интервалам дат
-- по КД
  l_sq number;
  i_K  number := 0;
  l_K  matrixN := matrixN(vectorN(0, 0, 0, 0, 0, 0, 0),
                          vectorN(0, 0, 0, 0, 0, 0, 0),
                          vectorN(0, 0, 0, 0, 0, 0, 0),
                          vectorN(0, 0, 0, 0, 0, 0, 0),
                          vectorN(0, 0, 0, 0, 0, 0, 0),
                          vectorN(0, 0, 0, 0, 0, 0, 0),
                          vectorN(0, 0, 0, 0, 0, 0, 0)
                          );
  l_s  number;
  l_v  matrixN := matrixN(vectorN(0, 0, 0, 0, 0, 0, 0),
                          vectorN(0, 0, 0, 0, 0, 0, 0),
                          vectorN(0, 0, 0, 0, 0, 0, 0),
                          vectorN(0, 0, 0, 0, 0, 0, 0),
                          vectorN(0, 0, 0, 0, 0, 0, 0),
                          vectorN(0, 0, 0, 0, 0, 0, 0),
                          vectorN(0, 0, 0, 0, 0, 0, 0)
                          );

  v    INTEGER;                        -- вид задолженности 7 штук
  p    INTEGER;                        -- период            5 штук
  x_dat date  := to_date('01-01-2000','dd-mm-yyyy');
  m_dat date  := to_date('01-01-2099','dd-mm-yyyy');

begin

  If p_mode not in (0,1) then RETURN; end if;

  p_dat1 := least    ( nvl(p_B(1),gl.bdate) ,
                       NVL(p_B(2),m_dat)    ,
                       NVL(p_B(3),m_dat)    ,
                       NVL(p_B(4),m_dat)    ,
                       NVL(p_B(5),m_dat)
                      ) ;
  p_dat2 := greatest ( nvl(p_E(1),gl.bdate) ,
                       NVL(p_E(2),x_dat)    ,
                       NVL(p_E(3),x_dat)    ,
                       NVL(p_E(4),x_dat)    ,
                       NVL(p_E(5),x_dat)
                      ) ;
If    p_mode = 0 then
      execute immediate 'truncate TABLE TMP_CCK51 ';
elsIf p_mode = 1 then
      execute immediate 'truncate TABLE TMP_CCK5R ';
end if ;
  ---------------
  for k in (select  d.BRANCH, nvl(s.SEGMENT,0) segm,
                    nvl(trim(cck_app.get_nd_txt(d.nd,'SPOK')),'0')  spok,
                    a.kv, a.acc, a.nls, a.tip, a.nbs,
                    d.nd, d.cc_id, d.rnk, d.sdate, d.wdate
            from cc_deal d, v_gl a, nd_acc n, sb_ob22 s
            where d.vidd in (1,2,3,11,12,13)
              and d.nd   =  n.nd and n.acc  =  a.acc     and a.pap  =  1
              and a.nbs  < '4'
              and exists
       (select 1 from saldoa where     kos > 0 and fdat >= p_dat1 and fdat<= p_dat2)
--     (select 1 from saldoa where dos+kos > 0 and fdat >= p_dat1 and fdat<= p_dat2)
              and a.dapp >= p_dat1
              and s.r020 =  substr(d.prod,1,4)  and s.ob22 =  substr(d.prod,5,2)
--and d.nd = 52864
            )
  loop
    i_k := 0 ;

    l_k := matrixN
                (vectorN( 0, 0, 0, 0, 0, 0, 0),
                 vectorN( 0, 0, 0, 0, 0, 0, 0),
                 vectorN( 0, 0, 0, 0, 0, 0, 0),
                 vectorN( 0, 0, 0, 0, 0, 0, 0),
                 vectorN( 0, 0, 0, 0, 0, 0, 0),
                 vectorN( 0, 0, 0, 0, 0, 0, 0),
                 vectorN( 0, 0, 0, 0, 0, 0, 0)
                 );
    l_v := matrixN
                (vectorN( 0, 0, 0, 0, 0, 0, 0),
                 vectorN( 0, 0, 0, 0, 0, 0, 0),
                 vectorN( 0, 0, 0, 0, 0, 0, 0),
                 vectorN( 0, 0, 0, 0, 0, 0, 0),
                 vectorN( 0, 0, 0, 0, 0, 0, 0),
                 vectorN( 0, 0, 0, 0, 0, 0, 0),
                 vectorN( 0, 0, 0, 0, 0, 0, 0)
                 );


    for g in (select * from opldok
              where acc= k.acc and fdat >= p_dat1 and fdat <= p_dat2 and dk=1)
    loop
      begin

        If p_mode = 0 then --- реальное погашение, 1- реструктуризация

           select o.sq/100, o.s/100
           into l_sq, l_s
           from opldok o, accounts a
           where o.acc= a.acc and o.ref= g.ref and o.stmt= g.stmt
             and o.dk= 1-g.dk
             and a.nbs not like '20%' and a.nbs not like '21%'
             and a.nbs not like '22%' and a.nbs not like '35%' and a.tip not in
               ('SS ' ,'SN ','SK0','SP ','SPN','SK9','SLN', 'SLK') ;

        ElsIf p_mode = 1 then --- реструктуризация

           select o.sq/100, o.s/100
           into l_sq, l_s
           from opldok o, accounts a
           where o.acc = a.acc and o.ref= g.ref and o.stmt= g.stmt
             and o.dk  = 1-g.dk
             and (    a.nbs like '20%' OR a.nbs like '21%'
                   OR a.nbs like '22%' OR a.nbs like '35%'
                  )
             and a.tip in ('SS ' ,'SN ','SK0' ) ;

        end if;

        -- определить  вид задорлженности
        If    k.tip = 'SS '                      then v:=1;  --норм тело
        elsIf k.tip = 'SN ' or k.nbs like '2__8' then v:=2;  --норм проц
        elsIf k.tip = 'SK0' or k.nbs like '3578' then v:=3;  --норм ком
        elsIf k.tip = 'SP ' or k.nbs like '2__7' then v:=4;  --прос тело
        elsIf k.tip in ('SPN','SLN')
                            or k.nbs like '2__9' then v:=5;  --прос проц
        elsIf k.tip in ('SK9','SLK') or
                        k.nbs in ('3579')        then v:=6;  --прос ком
        else                                          v:=7;  --Другое
        end if;

        i_k := i_k + l_sq;
        -- просуммировать в периоды
        FOR p IN 1..5
        loop
           If g.fdat between p_B(p) and p_E(p) then
              l_k(v)(p) := l_k(v)(p) + l_sq; l_v(v)(p) := l_v(v)(p) + l_s ;
           end if;
        end loop;

      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end;

    end loop;

    if i_k > 0 then
       -- выложить итоги по вертикали до 5 строк
       FOR p IN 1..5
       loop
         If l_k(1)(p) + l_k(2)(p) + l_k(3)(p) + l_k(4)(p) +
            l_k(5)(p) + l_k(6)(p) + l_k(7)(p) > 0 then

            If p_mode = 0 then
               -- реальное погаш
               Update TMP_CCK51
                      set s11 = s11 + l_k(1)(p), v11 = v11 + l_v(1)(p),
                          s12 = s12 + l_k(2)(p), v12 = v12 + l_v(2)(p),
                          s13 = s13 + l_k(3)(p), v13 = v13 + l_v(3)(p),
                          s14 = s14 + l_k(4)(p), v14 = v14 + l_v(4)(p),
                          s15 = s15 + l_k(5)(p), v15 = v15 + l_v(5)(p),
                          s16 = s16 + l_k(6)(p), v16 = v16 + l_v(6)(p),
                          s17 = s17 + l_k(7)(p), v17 = v17 + l_v(7)(p)
                    where nd  = k.nd;

               if SQL%rowcount = 0 then
                  insert into  TMP_CCK51 ( branch,spok,kv,SEGM,
                                        nd, rnk, cc_id, sdate, wdate, B1, E1,
                                        s11, s12, s13, s14, s15, s16, s17,
                                        v11, v12, v13, v14, v15, v16, v17
                                       )
                  values ( k.branch, k.spok, k.kv, k.segm,
                    k.nd, k.rnk,  substr(k.cc_id,1,20), k.sdate, k.wdate, p_B(p),p_E(p),
                    l_k(1)(p),l_k(2)(p),l_k(3)(p),l_k(4)(p),l_k(5)(p),l_k(6)(p),l_k(7)(p),
                    l_v(1)(p),l_v(2)(p),l_v(3)(p),l_v(4)(p),l_v(5)(p),l_v(6)(p),l_v(7)(p)
                   );
               end if;

            elsIf p_mode = 1 then
               -- реструк погаш
               Update TMP_CCK5R
                      set s11 = s11 + l_k(1)(p), v11 = v11 + l_v(1)(p),
                          s12 = s12 + l_k(2)(p), v12 = v12 + l_v(2)(p),
                          s13 = s13 + l_k(3)(p), v13 = v13 + l_v(3)(p),
                          s14 = s14 + l_k(4)(p), v14 = v14 + l_v(4)(p),
                          s15 = s15 + l_k(5)(p), v15 = v15 + l_v(5)(p),
                          s16 = s16 + l_k(6)(p), v16 = v16 + l_v(6)(p),
                          s17 = s17 + l_k(7)(p), v17 = v17 + l_v(7)(p)
                    where nd  = k.nd;
               if SQL%rowcount = 0 then
                  insert into  TMP_CCK5R ( branch,spok,kv,SEGM,
                                        nd, rnk, cc_id, sdate, wdate, B1, E1,
                                        s11, s12, s13, s14, s15, s16, s17,
                                        v11, v12, v13, v14, v15, v16, v17
                                       )
                  values ( k.branch, k.spok, k.kv, k.segm,
                    k.nd, k.rnk,  substr(k.cc_id,1,20), k.sdate, k.wdate, p_B(p),p_E(p),
                    l_k(1)(p),l_k(2)(p),l_k(3)(p),l_k(4)(p),l_k(5)(p),l_k(6)(p),l_k(7)(p),
                    l_v(1)(p),l_v(2)(p),l_v(3)(p),l_v(4)(p),l_v(5)(p),l_v(6)(p),l_v(7)(p)
                   );
               end if;


            end if;


         end if;
       end loop;
    end if;

  end loop;

  return;

end cck51;
--------------

PROCEDURE cckGL
( p_mode   int,

  --0 = реальное погашение, 1- реструктуризация
  --328	ДЕФ:Вiдомiсть РЕАЛЬНИХ погаш.,до 5-ти перiодiв, ПРОВОДКИ FunNSIEditF("TMPV_CCK5[PROC=>NADA.cckGL(0,:B1,:E1,:B2,:E2,:B3,:E3,:B4,:E4,:B5,:E5)][PAR=>:B1(SEM=B1),:E1(SEM=E1),:B2(SEM=B2),:E2(SEM=E2),:B3(SEM=B3),:E3(SEM=E3),:B4(SEM=B4),:E4(SEM=E4),:B5(SEM=B5),:E5(SEM=E5)][EXEC=>BEFORE]",1)
  --977	ДЕФ:Вiдомiсть РЕСТРУКТ-погаш.,до 5-ти перiодiв, ПРОВОДКИ FunNSIEditF("TMPR_CCK5[PROC=>NADA.cckGL(1,:B1,:E1,:B2,:E2,:B3,:E3,:B4,:E4,:B5,:E5)][PAR=>:B1(SEM=B1),:E1(SEM=E1),:B2(SEM=B2),:E2(SEM=E2),:B3(SEM=B3),:E3(SEM=E3),:B4(SEM=B4),:E4(SEM=E4),:B5(SEM=B5),:E5(SEM=E5)][EXEC=>BEFORE]",1)
  --
  --
  --2 = за 2 месяца ПРОШЛыЙ + ТЕКУЩИй
  --1041 КП(XLS-800) Розгор., Погашення за 2 сумiжнi мiс.,ПРОВОДКИ ExportCatQuery( 800,"",8,"",TRUE)
  --
  --7 = за 1 месяц            ТЕКУЩИй
  --1079 КП(XLS-810) Розгорнений: Звiт за  Мiсяць	N/A	ExportCatQuery( 810,"",8,"",TRUE)
------------------------------- --
  S_dat11   VARCHAR2,
  S_dat12   VARCHAR2,
  S_dat21   VARCHAR2,
  S_dat22   VARCHAR2,
  S_dat31   VARCHAR2,
  S_dat32   VARCHAR2,
  S_dat41   VARCHAR2,
  S_dat42   VARCHAR2,
  S_dat51   VARCHAR2,
  S_dat52   VARCHAR2
)  IS
-------------------------------
  p_dat1  date ;
  p_dat2  date ;
  l_spok  varchar2(7)         ;
  l_nbs accounts.NBS%type     ;
  R_nd    cc_deal%rowtype     ;
  R_ob    sb_ob22%rowtype     ;
  s1_     TMP_CCK51.s11%type  ; v1_ TMP_CCK51.v11%type ; --норм тело
  s2_     TMP_CCK51.s12%type  ; v2_ TMP_CCK51.v12%type ; --норм проц
  s3_     TMP_CCK51.s13%type  ; v3_ TMP_CCK51.v13%type ; --норм ком
  s4_     TMP_CCK51.s14%type  ; v4_ TMP_CCK51.v14%type ; --прос тело
  s5_     TMP_CCK51.s15%type  ; v5_ TMP_CCK51.v15%type ; --прос проц
  s6_     TMP_CCK51.s16%type  ; v6_ TMP_CCK51.v16%type ; --прос комис
  -----------------
  TYPE   vectorD IS VARRAY(5) OF date ;
  p_B vectorD := vectorD( TO_DATE(S_DAT11,'DD.MM.YYYY'),
                          TO_DATE(S_DAT21,'DD.MM.YYYY'),
                          TO_DATE(S_DAT31,'DD.MM.YYYY'),
                          TO_DATE(S_DAT41,'DD.MM.YYYY'),
                          TO_DATE(S_DAT51,'DD.MM.YYYY') );

  p_E vectorD := vectorD( TO_DATE(S_DAT12,'DD.MM.YYYY'),
                          TO_DATE(S_DAT22,'DD.MM.YYYY'),
                          TO_DATE(S_DAT32,'DD.MM.YYYY'),
                          TO_DATE(S_DAT42,'DD.MM.YYYY'),
                          TO_DATE(S_DAT52,'DD.MM.YYYY') );
  --------------------------------
  p    INTEGER;                        -- период            5 штук
  x_dat date  := to_date('01-01-2000','dd-mm-yyyy');
  m_dat date  := to_date('01-01-2099','dd-mm-yyyy');
  -----------

  l_tab varchar2(15);
  nTmp_ int;

  id_t number;  -- ид.01числа месяца
  l_OST_SS number :=0 ;  l_OST_SN  number :=0 ;
  l_OST_SP number :=0 ;  l_OST_SPN number :=0 ;   l_all_pr number :=0 ;
  t_NOM    number :=0 ;  l_kol_SP  int        ;   l_dat_sp date   ;

  ND_ cc_deal.nd%type := 58372;
  ost_  number ;
  ostq_ number ;
  bbbb_ char(4);
begin

  If S_DAT11 is null  OR   p_mode not in (0,1,2,7)    then
     RETURN;
  end if;

  p_dat1 := p_B(1) ;
  p_dat2 := p_E(1) ;
  ----------------------------------------------
  If p_mode = 2 then
     l_tab  := 'TMP_mes2'  ;

     p_dat1 := trunc( p_B(1),'MM');
     p_dat2 := trunc( p_B(1),'MM');

     p_dat1 := add_months( p_dat1, -1) ;
     p_dat2 := last_day  ( p_dat2 );

--   p_dat1                                    p_dat2
--   01.04.2012 - 30.04.2012 - 01.05.2012 - 31.05.2012
  ---------------------------------------------
  elsIf p_mode = 7 then

     l_tab  := 'test_mart'  ;

     p_dat1 := trunc( p_B(1),'MM');
     p_dat2 := last_day  ( p_dat1 );

--   p_dat1        p_dat2
--   01.05.2012  - 31.05.2012

  --------------------------------------------
  ElsIf p_mode = 0 then l_tab := 'TMP_CCK51' ;
  --------------------------------------------
  else                  l_tab := 'TMP_CCK5R' ;
  --------------------------------------------
  end if;

  p_dat1 := least (p_dat1,NVL(p_B(2),m_dat), NVL(p_B(3),m_dat),
                          NVL(p_B(4),m_dat), NVL(p_B(5),m_dat)
                  ) ;

  p_dat2 := greatest( p_dat2, NVL(p_E(2),x_dat), NVL(p_E(3),x_dat),
                              NVL(p_E(4),x_dat), NVL(p_E(5),x_dat)
                      ) ;

  execute immediate  'truncate table '||l_tab  ;


  If p_mode = 7 then

     -- занести параметры КД
     insert into test_mart
       (NAME_RU, NAME_PP, branch, SEGMENT, prod, txt, nmk,
        IDL1, IDL2, ND, SPOK, WDATE, kv,
        sumG, sumK, sumP, IR,  sdog, ost_nom, kol_sp,  tPOG_03,pPOG_03,kPOG_03      )
     select b2.name , b3.name, d.branch, o.SEGMENT, d.prod, o.txt, c.nmk,
        d.SKARB_ID, substr( cck_app.get_nd_txt(d.ND, 'LOANS'),1,40) ,
        d.ND, substr( cck_app.get_nd_txt(d.ND, 'SPOK'),1,40) SPOK, d.WDATE, a8.kv,
        NVL(gl.p_icurval(a8.kv,l.sumg, p_dat2),0) /100,
        NVL(gl.p_icurval(a8.kv,l.sumK, p_dat2),0) /100,
        NVL(gl.p_icurval(a8.kv,l.sumP, p_dat2),0) /100,
        acrn.fproc (a8.acc,p_dat2),
        d.sdog, 0 ,0, 0,0,0
    from cc_deal D, branch B2, branch B3, sb_ob22 O, customer C,  nd_acc N,
       (select kv, acc from accounts  where tip='LIM' ) a8,
       (select nd, sum(sumg) sumg,   sum(sumk) sumk, sum(sumo-sumg-sumk) sump
        from cc_lim where fdat >= p_dat1 and fdat <= p_dat2 group by nd  ) L
    where d.rnk = c.rnk and substr(d.prod,1,6) = o.r020 || o.ob22
      and d.nd  = n.nd  and n.acc   = a8.acc
      and substr(d.branch,1,15) = b2.branch(+)
      and d.branch = b3.branch (+)
      and d.vidd in (1,2,3,11,12,13)   and d.nd   = l.nd (+)
--      and d.sos >= 10   and d.sos <  15
--and d.branch like '/380764/000250/'
      ;

    -- замести параметры остатки тек мес
    select caldt_id into id_t from  ACCM_CALENDAR where CALDT_date = p_dat1;
    for k in (select nd, rowid RI from test_mart)
    loop
      l_OST_SS := 0 ;  l_OST_SN := 0 ;  l_OST_SP := 0 ;  l_OST_SPN := 0 ;
      t_NOM    := 0 ;  l_kol_SP := 0 ;  l_all_pr := 0 ;

      for p in (select a.nbs, a.tip, a.acc, m.OSTQ, m.ost  OSTN
                from accounts a, nd_acc n,
                     (select * from ACCM_AGG_MONBALS where caldt_id=id_t) m
                where n.nd = k.ND and n.acc= a.acc and a.acc = m.acc
                  and (a.nbs like '2%' or  a.nbs like '3%')
                  and a.tip in
('SS ','SP ','SL ','SN ','SPN','SLN','S9N','SK0','SK9','SLK','S9K')
             )
      loop

         If p.tip in ('SS ','SP ','SL ') then t_NOM := t_NOM   + p.ostn; -- тело

            If p.tip ='SS ' then  l_OST_SS := l_OST_SS + p.ostq ;
            else                  l_OST_SP := l_OST_SP + p.ostq ;
                                  l_all_pr := l_all_pr + p.ostq ;
               -- посчитать кол-во дней просрочки
               begin
                 select sp into l_kol_SP   from cc_kol_sp
                 where nd= k.nd and fdat=p_dat2;
               EXCEPTION WHEN NO_DATA_FOUND THEN null;
--               If l_kol_SP = 0 and p.tip ='SP ' and p.ostn <0  then
--                  select max(fdat ) into l_dat_sp from saldoa where acc = p.acc
--                     and fdat < p_dat1  and ostf >= 0;
--                  l_kol_SP := p_dat1 -l_dat_sp;
--               end if;
               end;

            end if;

         elsIf p.tip in ('SN ','SPN', 'SLN','S9N') then  -- процент

            If p.tip ='SN ' then  l_OST_SN := l_OST_SN + p.ostq ;
            else                  l_OST_SPN:= l_OST_SPN+ p.ostq ;
                                  l_all_pr := l_all_pr + p.ostq ;
            end if ;

         elsIf p.tip in ('SK0','SK9','SLK','S9K') then  -- комиссия

            if p.tip in ('SK9','SLK','S9K') then
               l_all_pr := l_all_pr + p.ostq ;
            end if;

         end if;

      end loop ;  -- p

      l_OST_SS := l_OST_SS  /100 ;
      t_nom    := t_NOM     /100 ;
      l_OST_SN := l_OST_SN  /100 ;
      l_OST_SP := l_OST_SP  /100 ;
      l_OST_SPN:= l_OST_SPN /100 ;
      l_all_pr := l_all_pr  /100 ;

      update test_mart
         set OST_SS  = l_OST_SS, ost_nom = t_NOM     , OST_SN  = l_OST_SN,
             OST_SP  = l_OST_SP, OST_SPN = l_OST_SPN , kol_sp  = l_kol_SP,
             all_pr  = l_all_pr
       where rowid = k.RI;

    end loop; ---- kkk

  end if;

  -------анализ проводок по погашению и рескт --------
  for k in (select a.BRANCH, a.KV, a.acc, a.nls, a.nbs, a.rnk, a.ob22,
                   a.daos, a.mdate, a.nms,
                   o.ref, o.stmt,  o.s/100 S, o.sq/100 SQ, o.FDAT
            from accounts a, opldok o
            where a.acc = o.acc
--and a.branch like '/380764/000250/'
              and o.dk  = 1
              and o.fdat >= p_dat1 and o.fdat <= p_dat2
              and exists (select 1 from NBS_KRD_POGP where nbs = a.NBS
                          union all
                          select 1 from NBS_KRD_POGT where nbs = a.NBS
                          union all
                          select 1 from NBS_KRD_POGK where nbs = a.NBS)
           )
  loop -------- курсор K

    begin
      -- дебет-сторона проводки
      select a.NBS into l_NBS from opldok o, accounts a
      where a.acc = o.acc and o.ref = k.ref and o.stmt = k.stmt and o.dk   = 0
        and exists
           (select 1 from NBS_DEB_POG where nbs = a.NBS and p_mode in (0,2,7)
            union all
            select 1 from NBS_DEB_RES where nbs = a.NBS and p_mode = 1 );
    EXCEPTION WHEN NO_DATA_FOUND THEN goto HET_;
    end;

    If k.NBS like '35%' and l_NBS not like '2909' then
       goto HET_;
    end if;

    -- КД в портфеле БАРСА

    begin

      select d.* into R_ND   from cc_deal d, nd_acc n
      where n.acc = k.ACC and n.nd = d.ND and rownum =1;

      If p_mode = 7 then  NULL;
      else
         l_spok := nvl(trim(cck_app.get_nd_txt(R_ND.nd,'SPOK')),'0') ;
         -- сегмент
         begin
           select * into R_ob from sb_ob22
           where r020= substr(r_nd.prod,1,4) and ob22=substr(r_nd.prod,5,2);
         EXCEPTION WHEN NO_DATA_FOUND THEN  R_ob.SEGMENT := 0; R_ob.ZN50 := '0';
         end;
      end if;

    EXCEPTION WHEN NO_DATA_FOUND THEN
      l_spok     := null     ;
      r_nd.ND    := -k.acc   ;
      r_nd.cc_id :=  k.nls   ;
      r_nd.sdate :=  k.DAOS  ;
      r_nd.wdate :=  k.MDATE ;
      r_nd.prod  :=  k.nbs || k.ob22;
      -- сегмент
      begin
        select * into r_ob from sb_ob22 where r020=k.NBS and ob22=k.ob22;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        r_ob.SEGMENT:= 0; r_ob.ZN50 := '0';
      end;

    end;

    s1_ := 0 ;  v1_ := 0 ; --норм тело
    s2_ := 0 ;  v2_ := 0 ; --норм проц
    s3_ := 0 ;  v3_ := 0 ; --норм ком
    s4_ := 0 ;  v4_ := 0 ; --прос тело
    s5_ := 0 ;  v5_ := 0 ; --прос проц
    s6_ := 0 ;  v6_ := 0 ; --прос комис

    If    k.NBS like '3579' then s6_ := k.Sq; v6_ := k.S;  --прос ком
    elsIf k.NBS like '3578' then s3_ := k.Sq; v3_ := k.S;  --норм ком
    elsIf k.NBS like '26__'
       OR k.NBS like '2__8' then s2_ := k.Sq; v2_ := k.S;  --норм проц
    elsIf k.NBS like '2__9' then s5_ := k.Sq; v5_ := k.S;  --прос проц
    elsIf k.NBS like '2__7' then s4_ := k.Sq; v4_ := k.S;  --прос тело
    else                         s1_ := k.Sq; v1_ := k.S;  --норм тело
    end if;

If p_mode = 7 then

   update test_mart
      set tPOG_03 = tPOG_03 + s4_+s1_,
          pPOG_03 = pPOG_03 + s5_+s2_,
          kPOG_03 = kPOG_03 + s6_+s3_
    where nd = r_nd.ND;

   if SQL%rowcount = 0 then

      l_OST_SS := 0 ;  l_OST_SN := 0 ;  l_OST_SP := 0 ;  l_OST_SPN := 0 ;
      t_NOM    := 0 ;  l_kol_SP := 0 ;  l_all_pr := 0 ;

      begin
         select OSTQ, ost into ostq_, ost_
         from  ACCM_AGG_MONBALS where caldt_id=id_t and acc = k.acc;
      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end;

      bbbb_ := substr(k.nbs,1,1)||'__'||substr(k.nbs,4,1);

         If bbbb_ in ('2__7') then l_OST_SP := ostq_; l_all_pr:= ostq_; -- SP
      elsIf bbbb_ in ('2__8') then l_OST_SN := ostq_;                   -- SN
      elsIf bbbb_ in ('2__9') then l_OST_SPN:= ostq_; l_all_pr:= ostq_; -- SPN
      elsIf bbbb_ in ('3__9') then                    l_all_pr:= ostq_; -- SK9
      elsIf bbbb_ in ('3__8') then                    null            ; -- SK0
      else                         l_OST_SS := ostq_; t_NOM   := ost_ ; -- SS
      end if;

      l_OST_SP := l_OST_SP  /100 ;      l_all_pr := l_all_pr  /100 ;
      l_OST_SN := l_OST_SN  /100 ;      l_OST_SPN:= l_OST_SPN /100 ;
      l_OST_SS := l_OST_SS  /100 ;      t_nom    := t_NOM     /100 ;

     insert into test_mart
       (NAME_RU, NAME_PP, branch, SEGMENT, prod, txt, nmk,
        ND, WDATE, kv,  tPOG_03 , pPOG_03, kPOG_03 ,
        OST_SS, ost_nom, OST_SN , OST_SP , OST_SPN, all_pr)
      select b2.name , b3.name, k.branch , r_ob.SEGMENT, r_nd.prod, r_ob.txt, k.nms,
        r_nd.ND,r_nd.wdate, k.kv, (s4_+s1_), (s5_+s2_), (s6_+s3_),
        l_OST_SS,  t_nom, l_OST_SN, l_OST_SP, l_OST_SPN,  l_all_pr
      from branch B2, branch B3
      where 1=1
        and substr(k.branch,1,15) = b2.branch (+)
        and k.branch = b3.branch (+);

    end if;

elsIf p_mode = 2 then

   ----- реальное погаш */
   If to_char(k.fdat,'MMYYYY') = to_char(p_dat2,'MMYYYY') then

      -- тек мес
      Update TMP_mes2 set t_t = t_t + s4_+s1_,
                          t_p = t_p + s5_+s2_,
                          t_k = t_k + s6_+s3_ where nd=r_nd.ND;
      if SQL%rowcount = 0 then
         insert into TMP_mes2
           (ND , IDL1, IDL2, BRANCH, NAME_RU, NAME_PP, SEGMENT, TXT, NMK,
            t_t, t_p , t_k ,   p_t ,   p_p  ,   p_k  )
         select r_nd.nd, r_nd.SKARB_ID,
            substr( cck_app.get_nd_txt(r_nd.ND, 'LOANS'),1,40),
            k.branch, b2.name, b3.name, r_ob.SEGMENT, r_ob.txt, c.nmk,
            s4_+s1_, s5_+s2_, s6_+s3_,0, 0, 0
           from branch B2, branch B3, customer C
           where k.rnk=c.RNK
             and substr(k.branch,1,15)=b2.branch (+)
             and k.branch=b3.branch (+);
      end if;

   else
      -- прош мес
      Update TMP_mes2 set p_t = p_t + s4_+s1_,
                          p_p = p_p + s5_+s2_,
                          p_k = p_k + s6_+s3_ where nd=r_nd.ND;
      if SQL%rowcount = 0 then
         insert into TMP_mes2
           (ND , IDL1, IDL2, BRANCH, NAME_RU, NAME_PP, SEGMENT, TXT, NMK,
            t_t, t_p , t_k ,   p_t ,   p_p  ,   p_k  )
         select r_nd.nd, r_nd.SKARB_ID,
            substr( cck_app.get_nd_txt(r_nd.ND, 'LOANS'),1,40),
            k.branch, b2.name, b3.name, r_ob.SEGMENT, r_ob.txt, c.nmk,
            0, 0, 0, s4_+s1_, s5_+s2_, s6_+s3_
           from branch B2, branch B3, customer C
           where k.rnk=c.RNK
             and substr(k.branch,1,15)=b2.branch (+)
             and k.branch=b3.branch (+);
      end if;
   end if;
--------------------------------------------------------
else
--p_mode = 0 , 1
   -- Разложить в периоды
   FOR p IN 1..5
   loop
     If k.fdat between p_B(p) and p_E(p) then

        If p_mode = 0 then  /* ----- реальное погаш */
           Update TMP_CCK51
              set s11 = s11+S1_, v11 = v11+v1_, s12 = s12+s2_, v12 = v12 +v2_,
                  s13 = s13+s3_, v13 = v13+v3_, s14 = s14+s4_, v14 = v14 +v4_,
                  s15 = s15+s5_, v15 = v15+v5_, s16 = s16+s6_, v16 = v16 +v6_
            where nd  = r_nd.ND and B1 = p_B(p) and E1 = p_E(p);

           if SQL%rowcount = 0 then
              insert into  TMP_CCK51
                (branch,spok,kv,SEGM,nd,rnk,cc_id,sdate,wdate,B1,E1,prod,ZN50,
                 s11, s12, s13, s14, s15, s16, v11, v12, v13, v14, v15, v16 )
              values (k.branch, l_spok,  k.kv,
                      r_ob.SEGMENT, r_nd.nd,  k.rnk, substr(r_nd.cc_id,1,20),
                      r_nd.sdate,  r_nd.wdate, p_B(p),p_E(p), r_nd.prod,r_ob.ZN50,
                      s1_,s2_,s3_,s4_,s5_,s6_, v1_,v2_,v3_,v4_,v5_,v6_  );
           end if;

        elsIf p_mode = 1 then  /*   ------ реструк погаш  */

           Update TMP_CCK5R
              set s11 = s11+S1_, v11 = v11+v1_, s12 = s12+s2_, v12 = v12 +v2_,
                  s13 = s13+s3_, v13 = v13+v3_, s14 = s14+s4_, v14 = v14 +v4_,
                  s15 = s15+s5_, v15 = v15+v5_, s16 = s16+s6_, v16 = v16 +v6_
            where nd  = r_nd.ND and B1 = p_B(p) and E1 = p_E(p);

           if SQL%rowcount = 0 then
              insert into  TMP_CCK5R
                (branch,spok,kv,SEGM,nd,rnk,cc_id,sdate,wdate,B1,E1,prod,ZN50,
                 s11, s12, s13, s14, s15, s16, v11, v12, v13, v14, v15, v16)
              values (k.branch, l_spok,  k.kv,
                      r_ob.SEGMENT, r_nd.nd,  k.rnk, substr(r_nd.cc_id,1,20),
                      r_nd.sdate,  r_nd.wdate, p_B(p),p_E(p), r_nd.prod, r_ob.ZN50,
                      s1_,s2_,s3_,s4_,s5_,s6_, v1_,v2_,v3_,v4_,v5_,v6_  );
           end if;

        end if;

     end if;
   end loop;
END IF;

    <<HET_>> null;

  end loop;  -------- курсор K

  --  сбор статистики
  dbms_stats.gather_table_stats('bars', l_tab );

  return;

end cckGL;
---------------------------------------------------------------

--КП Розгорнений: Звiт за  Квартал
--КП Згорнений: Звiт за  Квартал

procedure QWT
(Y_ char,  --- ГОД     = yyyy -- по умолч = 2012
 Q_ char,   --- Квартал = Q    -- по умолч = 1
 s_ND varchar2
 ) IS

  l_nd  cc_deal.nd%type;  dos_1 number;  dos_2 number;  dos_3 number;

  p_y int := to_number( NVL(Y_,'2012') );
  p_q int := to_number( NVL(Q_, '1'  ) );

  dat_0101 date ; id_01    int ;
  dat_0102 date ; id_02    int ;
  dat_0103 date ; id_03    int ;
  dat_3103 date ;
  --
  t_NOM    number :=0;  l_kol_SP  int       ;   l_dat_sp date  ;
  l_all_pr number :=0; -- итог просрочки
  -------------------------------------------------
  l_OST_SS number :=0;  l_OST_SN  number :=0;
  l_OST_SP number :=0;  l_OST_SPN number :=0;
  t_POG_01 number :=0;  p_POG_01  number :=0;   k_POG_01 number :=0;
  t_POG_02 number :=0;  p_POG_02  number :=0;   k_POG_02 number :=0;
  t_POG_03 number :=0;  p_POG_03  number :=0;   k_POG_03 number :=0;
  -------------------------------------------------
begin
  If y_ is null or q_ is null then     RETURN;  end if;

  l_ND := nvl(to_number(trim(s_ND)),0);

  -- определение месячных дат квартала
  If    p_q = 1 then dat_0101 := to_date('01.01.'||p_y,'dd-mm-yyyy');
                     dat_0102 := to_date('01.02.'||p_y,'dd-mm-yyyy');
                     dat_0103 := to_date('01.03.'||p_y,'dd-mm-yyyy');
                     dat_3103 := to_date('31.03.'||p_y,'dd-mm-yyyy');

  ElsIf p_q = 2 then dat_0101 := to_date('01.04.'||p_y,'dd-mm-yyyy');
                     dat_0102 := to_date('01.05.'||p_y,'dd-mm-yyyy');
                     dat_0103 := to_date('01.06.'||p_y,'dd-mm-yyyy');
                     dat_3103 := to_date('30.06.'||p_y,'dd-mm-yyyy');

  ElsIf p_q = 3 then dat_0101 := to_date('01.07.'||p_y,'dd-mm-yyyy');
                     dat_0102 := to_date('01.08.'||p_y,'dd-mm-yyyy');
                     dat_0103 := to_date('01.09.'||p_y,'dd-mm-yyyy');
                     dat_3103 := to_date('30.09.'||p_y,'dd-mm-yyyy');

  ElsIf p_q = 4 then dat_0101 := to_date('01.10.'||p_y,'dd-mm-yyyy');
                     dat_0102 := to_date('01.11.'||p_y,'dd-mm-yyyy');
                     dat_0103 := to_date('01.12.'||p_y,'dd-mm-yyyy');
                     dat_3103 := to_date('31.12.'||p_y,'dd-mm-yyyy');
  end If;
 -------------------------------
  tuda;
  delete from test_mart ;

 insert into test_mart (NAME_RU, NAME_PP, branch, SEGMENT, prod, txt, nmk,
   IDL1, IDL2, ND, SPOK, WDATE, kv,  sumG, sumK, sumP, IR,sdog, ost_nom, kol_sp )
 select b2.name , b3.name, d.branch, o.SEGMENT, d.prod, o.txt, c.nmk,
       d.SKARB_ID, substr( cck_app.get_nd_txt(d.ND, 'LOANS'),1,40) ,
       d.ND, substr( cck_app.get_nd_txt(d.ND, 'SPOK'),1,40) SPOK, d.WDATE, a8.kv,
       NVL(gl.p_icurval(a8.kv,l.sumg, dat_3103),0) /100,
       NVL(gl.p_icurval(a8.kv,l.sumK, dat_3103),0) /100,
       NVL(gl.p_icurval(a8.kv,l.sumP, dat_3103),0) /100,
       acrn.fproc (a8.acc,dat_3103) , d.sdog, 0 ,0
 from cc_deal  d, branch b2, branch b3,  sb_ob22  o,   customer c,  nd_acc   n,
      (select kv, acc from accounts where tip='LIM' ) a8,
      (select nd, sum(sumg) sumg,   sum(sumk) sumk, sum(sumo-sumg-sumk) sump
       from cc_lim where fdat >= dat_0103 and fdat <= dat_3103 group by nd  ) L
 where d.rnk = c.rnk and substr(d.prod,1,6) = o.r020 || o.ob22
   and d.nd  = n.nd  and n.acc   = a8.acc
   and substr(d.branch,1,15) = b2.branch and d.branch = b3.branch
   and d.vidd in (1,2,3,11,12,13) and d.nd   = l.nd (+) and d.sos >= 10
   and d.sos <  15    and l_ND in (0, d.nd)
--and d.nd =  157510
   ;
 --------------------------------------------------------
 select caldt_id into id_01 from  ACCM_CALENDAR where CALDT_date = dat_0101;
 select caldt_id into id_02 from  ACCM_CALENDAR where CALDT_date = dat_0102;
 select caldt_id into id_03 from  ACCM_CALENDAR where CALDT_date = dat_0103;
 -------------------------------------------------
 for k in (select nd, branch, rowid RI from test_mart)
 loop
   l_OST_SS  :=0 ;  l_OST_SN  :=0 ;   l_OST_SP  :=0 ;  l_OST_SPN := 0 ;
   t_POG_01  :=0 ;  p_POG_01  :=0 ;   k_POG_01  :=0 ;  t_NOM     := 0 ;
   t_POG_02  :=0 ;  p_POG_02  :=0 ;   k_POG_02  :=0 ;  l_kol_SP  := 0 ;
   t_POG_03  :=0 ;  p_POG_03  :=0 ;   k_POG_03  :=0 ;  l_all_pr  := 0 ;

   for p in (select a.nbs,a.tip, a.acc,
                    nvl(m3.ostq,nvl(m2.ostq,nvl(m1.ostq,0))) OSTQ,
                    nvl(m3.ost ,nvl(m2.ost ,nvl(m1.ost ,0))) OSTN,
                    decode(nvl(m3.kos,0), 0, 0, m3.kosq) kos3,
                    decode(nvl(m3.dos,0), 0, 0, m3.dosq) dos3,
                    decode(nvl(m2.kos,0), 0, 0, m2.kosq) kos2,
                    decode(nvl(m2.dos,0), 0, 0, m2.dosq) dos2,
                    decode(nvl(m1.kos,0), 0, 0, m1.kosq) kos1,
                    decode(nvl(m1.dos,0), 0, 0, m1.dosq) dos1
             from accounts a, nd_acc n,
                  (select * from ACCM_AGG_MONBALS where caldt_id=id_03) m3,
                  (select * from ACCM_AGG_MONBALS where caldt_id=id_02) m2,
                  (select * from ACCM_AGG_MONBALS where caldt_id=id_01) m1
             where n.nd = k.ND and n.acc= a.acc
               and (a.nbs like '2%' or  a.nbs like '3%')
               and a.tip in  ('SS ','SP ','SL ',
                              'SN ','SPN','SLN','S9N',
                              'SK0','SK9','SLK','S9K')
               and a.acc = m3.acc(+)
               and a.acc = m2.acc(+)
               and a.acc = m1.acc(+)
             )
   loop

      --миграционные обороты
      dos_3 := 0;
      dos_2 := 0;
      dos_1 := 0;
      If    k.branch like '/380764/000130/%'        and dat_01m = dat_0101 then
            dos_1 := fdosQ(p.acc,dat_lvv,dat_lvv);
      elsIf k.branch like '/380764/000130%'         and dat_01m = dat_0102 then
            dos_2 := fdosQ(p.acc,dat_lvv,dat_lvv);
      elsIf k.branch like '/380764/000130%'         and dat_01m = dat_0103 then
            dos_3 := fdosQ(p.acc,dat_lvv,dat_lvv);
      elsIf k.branch like '/380764/000260/%'        and dat_01m = dat_0101 then
            dos_1 := fdosQ(p.acc,dat_kie,dat_kie);
      elsIf k.branch like '/380764/000260%'         and dat_01m = dat_0102 then
            dos_2 := fdosQ(p.acc,dat_kie,dat_kie);
      elsIf k.branch like '/380764/000260%'         and dat_01m = dat_0103 then
            dos_3 := fdosQ(p.acc,dat_kie,dat_kie);
      end if;

   If p.tip in ('SS ','SP ','SL ') then  -- тело

      t_NOM   := t_NOM   + p.ostn;
      t_POG_03 := t_POG_03 + p.kos3;
      t_POG_02 := t_POG_02 + p.kos2;
      t_POG_01 := t_POG_01 + p.kos1;

      If p.tip in ('SP ','SL ') then
         t_POG_03 := t_POG_03 - p.dos3 + dos_3;
         t_POG_02 := t_POG_02 - p.dos2 + dos_2;
         t_POG_01 := t_POG_01 - p.dos1 + dos_1;
      end if;

      If p.tip ='SS ' then
         l_OST_SS := l_OST_SS + p.ostq ;
      else
         l_OST_SP := l_OST_SP + p.ostq ;
         l_all_pr := l_all_pr + p.ostq ;

         -- посчитать кол-во дней просрочки
         begin
            select sp into l_kol_SP  from cc_kol_sp
            where nd= k.nd and fdat=dat_3103;
         EXCEPTION WHEN NO_DATA_FOUND THEN null;
--          If l_kol_SP = 0 and p.tip ='SP ' and p.ostn <0  then
--             select max(fdat ) into l_dat_sp  from saldoa   where acc = p.acc
--                and fdat < dat_3103 and ostf >= 0;
--             l_kol_SP := dat_3103 -l_dat_sp;
--          end if;
         end;

      end if;

elsIf p.tip in ('SN ','SPN', 'SLN','S9N') then  -- процент

      p_POG_03 := p_POG_03 + p.kos3;
      p_POG_02 := p_POG_02 + p.kos2;
      p_POG_01 := p_POG_01 + p.kos1;

      If p.tip in ('SPN','SLN') then
         p_POG_03 := p_POG_03 - p.dos3 + dos_3;
         p_POG_02 := p_POG_02 - p.dos2 + dos_2;
         p_POG_01 := p_POG_01 - p.dos1 + dos_1;
      end if;

      If p.tip ='SN ' then
         l_OST_SN := l_OST_SN + p.ostq ;
      else
         l_OST_SPN:= l_OST_SPN+ p.ostq ;
         l_all_pr := l_all_pr + p.ostq ;
      end if ;

elsIf p.tip in ('SK0','SK9','SLK','S9K') then  -- комиссия

      k_POG_03 := k_POG_03 + p.kos3;
      k_POG_02 := k_POG_02 + p.kos2;
      k_POG_01 := k_POG_01 + p.kos1;

      If p.tip in ('SK9','SLK') then
         k_POG_03 := k_POG_03 - p.dos3 + dos_3;
         k_POG_02 := k_POG_02 - p.dos2 + dos_2;
         k_POG_01 := k_POG_01 - p.dos1 + dos_1;
      end if;

      if p.tip in ('SK9','SLK','S9K') then
         l_all_pr := l_all_pr + p.ostq ;
      end if;


end if;
    end loop ;  -- p

   t_POG_03  := greatest( 0, t_POG_03 )/100 ;
   p_POG_03  := greatest( 0, p_POG_03 )/100 ;
   k_POG_03  := greatest( 0, k_POG_03 )/100 ;
   t_POG_02  := greatest( 0, t_POG_02 )/100 ;
   p_POG_02  := greatest( 0, p_POG_02 )/100 ;
   k_POG_02  := greatest( 0, k_POG_02 )/100 ;
   t_POG_01  := greatest( 0, t_POG_01 )/100 ;
   p_POG_01  := greatest( 0, p_POG_01 )/100 ;
   k_POG_01  := greatest( 0, k_POG_01 )/100 ;
   l_OST_SS  := l_OST_SS  /100 ;
   l_OST_SN  := l_OST_SN  /100 ;
   l_OST_SP  := l_OST_SP  /100 ;
   l_OST_SPN := l_OST_SPN /100 ;
   t_nom     := t_NOM     /100 ;
   l_all_pr  := l_all_pr  /100 ;

  update test_mart
      set OST_SS  = l_OST_SS, OST_SN  = l_OST_SN  ,
          ost_nom = t_NOM   ,
          kol_sp  = l_kol_SP, all_pr  = l_all_pr  ,
          OST_SP  = l_OST_SP, OST_SPN = l_OST_SPN ,
          tPOG_03 = t_POG_03, pPOG_03 = p_POG_03, kPOG_03 = k_POG_03,
          tPOG_02 = t_POG_02, pPOG_02 = p_POG_02, kPOG_02 = k_POG_02,
          tPOG_01 = t_POG_01, pPOG_01 = p_POG_01, kPOG_01 = k_POG_01
     where rowid = k.RI;

end loop;
end QWT ;

--------------------


---Аномимный блок --------------
begin
   null;

END nada;
/
 show err;
 
PROMPT *** Create  grants  NADA ***
grant EXECUTE                                                                on NADA            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NADA            to SALGL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/nada.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 