CREATE OR REPLACE PACKAGE BARS.CIN IS

/*
26-09-2016 Коррекция вюшки 
17.12.2014 Процедура предварительной подготовки даннях для расчета за прошлый кал.месяц
 11.03.2013
 Заявка № 719. Возможность расчетов комиссии (прогноз+финиш) по одному или всем  клиентам
 Заявка № 721. Расчет абонплаты
 Заявка № 722. Расширить  тариф Б1.
*/

 cRnk    number;
 DAT_BEG date  ;
 DAT_END date  ;

 FUNCTION B return date   ;
 FUNCTION E return date   ;
 FUNCTION R return number ;

 --- корректировка сумм комисии по протоколу 
 procedure UPD1 ( p_RI varchar2, p_kc0 number,  p_ka1 number,  p_ka2 number,  p_kb1 number, p_kb2 number, p_kb3 number); 
--------------------------------------------------------------------
-- SK_A1 : Pасчет суммы (или комиссии)  по одному доп реквизиту
--------------------------------------------------------------------
 FUNCTION SK_A1
 ( p_REF   IN operw.ref%type,
   p_TAG   IN operw.TAG%type,
   p_mode  in int
 ) return  number;


--------------------------------------------------------------------
-- K_A2 : Pасчет комиссии за доставку
--------------------------------------------------------------------
 FUNCTION K_A2  (p_REF IN oper.ref%type ) return number;

-------------------------------------
 PROCEDURE PREV_DOK ( p_dat1 date, p_dat2 date ) ; -- процедура предварительного среза информации из таблиц OPER +ARC_RRP за прошлый календарный мес
-------------------------------------

 PROCEDURE KOM_ALL
( p_mode int,
  s_Dat1 varchar2,
  s_Dat2 varchar2,
  p_RNK cin_cust.rnk%type
) ;
--------------
 PROCEDURE  KOM_GOU( p_mode int);

END CIN;

/


CREATE OR REPLACE PACKAGE BODY BARS.CIN IS
  k_branch  varchar2(30);

--A1 : Pасчет комиссии за доставку - покупюрный учет, расчет выполняется по реквизитам заявки
--A2 : Pасчет комиссии за доставку - за выезд, расчет выполняется по кол-ву заявок, константа
--Б1 : Pасчет комиссии за вывоз    - за персчет, %  от суммы документа, из arc_rrp
--Б2 : Pасчет комиссии за вывоз    - за выезд, расчет выполняется по кол-ву документов из arc_rrp, константа
--В0 : Абонплата

/*
 15.11.2017 Пееход на нов.план счетов
r020 = '6119'; ob22 = '16'  ;  TRANSFER_2017 : 6119 =>6519 , об22 не изм в новом



 20.09.2016 Переменные пакеджа - в пул гл.переменных. т.к. в ВЕБ обрывается сессия.
 20.01.2015 Расчет комис Б3 за холостой выезд - c Выводом в конечную таблицу CIN_TKR
 12.01.2015 Перекриття 3739 та 3578
 25.12.2014 Штрафы. Предвар Оброр док через таблицу
 ------------------------------------
 19.12.2014 Sta PREV_DOK  процедура предварительного среза информации из таблиц OPER +ARC_RRP за прошлый календарный мес
                Ид.код отправителя всегда = наше ОКПО
                Если пров в след мес. то корр
 12.09.2014 Sta Заменнит транзтник в ГОУ 3739 на  нач.комиссию 3578 в моммент рассыла на РУ PROCEDURE  KOM_GOU
                Это будет собственно начисление. а сплата отдельно
 11.03.2013
 Заявка № 719. Возможность расчетов комиссии (прогноз+финиш) по одному или всем  клиентам
 Заявка № 721. Расчет абонплаты
 Заявка № 722. Расширить  тариф Б1.

  14-01-2013 Шевченко С.И. <SchevchenkoSI@oschadnybank.com>
             рахунки 6119/16 рахунки відкриті по невірному шаблону.
             Функція генерить платежі на суму ком. винагороди для бранчів  за невірними рахунками.
             Структура рахунку має бути така:        АААА К 0ННН NN FFF      6119_001600RRR      де,
                  АААА – балансовий рахунок
                  0ННН – значення „0” + значення ОВ22 (відсутні значення заповнюються нулями зліва)
                    NN - 00 для ТВБВ, в т.ч. ОПЕРв
                   FFF - код ТВБВ”.
              /mmmmmm/rrrRRR/bbbbbb/
 22-08-2012 Д.Хихлуха  операции PS1 и PS2 заменили на CI1 и CI2 соответственно.

*/

 FUNCTION B return date   is begin   return to_date   (pul.Get_Mas_Ini_Val('sFdat1'), 'dd.mm.yyyy'); end B;
 FUNCTION E return date   is begin   return to_date   (pul.Get_Mas_Ini_Val('sFdat2'), 'dd.mm.yyyy'); end E;
 FUNCTION R return number is begin   return to_number (pul.Get_Mas_Ini_Val('RNK'   )              ); end R;

 --- корректировка сумм комисии по протоколу 
 procedure UPD1 ( p_RI varchar2, p_kc0 number,  p_ka1 number,  p_ka2 number,  p_kb1 number, p_kb2 number, p_kb3 number) is
begin   update CIN_TKR set  kc0 = p_kc0 , ka1 = p_ka1 , ka2 = p_ka2 , kb1=p_kb1 , kb2 = p_kb2 , kb3 = p_kb3 where rowid = p_RI;
end UPD1;

--------------------------------------------------------------------
-- SK_A1 : Pасчет суммы (или комиссии)  по одному доп реквизиту
--------------------------------------------------------------------
 FUNCTION SK_A1
 ( p_REF   IN operw.ref%type,
   p_TAG   IN operw.TAG%type,
   p_mode  in int
 ) return  number  IS
  l_s    oper.s%type     :=0 ;
begin

  begin
    If p_mode = 1 then  select a1*100 into l_s from cin_operw where ref= p_REF and tag = p_TAG;
    else                select  to_number(substr(value, instr( value,':',1)+1,5 )) * c.nom * c.kol*100     into l_s
       from cin_tag c, operw w  where c.tag = p_tag and w.tag = c.tag and w.ref=p_ref;
    end if;
  exception when others  then null;
  end;
  RETURN l_s;
end SK_A1;

--------------------------------------------------------------------
-- K_A2 : Pасчет комиссии за доставку
--------------------------------------------------------------------
FUNCTION K_A2  (p_REF IN oper.ref%type ) return number IS
   l_oper oper%rowtype   ;
   l_tk   cin_TK%rowtype ;
   l_s    oper.s%type    :=0 ;
begin
  begin
    select * into l_oper from oper where sos= 5 and ref = p_ref ;
    select * into l_tk from cin_TK where mfo= l_oper.MFOB and nls = l_oper.nlsb;
    If l_tk.S_A2 is null  then   select Nvl(s_a2,0) into l_tk.S_A2 from cin_cust where rnk = l_tk.RNK;  end if;
    l_s :=  l_tk.S_A2 * 100;
  exception when no_data_found then null;
  end;
  RETURN l_s;
end K_A2 ;
-----------------------------------------------------

PROCEDURE PREV_DOK ( p_dat1 date, p_dat2 date ) is -- процедура предварительного среза информации из таблиц OPER +ARC_RRP за прошлый календарный мес
 l_dat1 date; l_dat2 date ; l_dat11 date;

begin

 If p_dat1 is null or p_dat2 is null then  l_dat1 := add_months( trunc(sysdate,'MM'), - 1 ) ;    l_dat2 := last_day (l_dat1);  -- 01.12.2013
 else                                      l_dat1 := p_dat1;                                     l_dat2 := p_dat2 ;            -- 31.12.3012
 end if;

 l_dat11 := l_dat2 + 1;

 bc.GO ('300465');

 logger.info ('CIN.PREV_DOK/1-начало: dat1='|| to_char(l_dat1, 'dd.mm.yyyy') || ' , dat2= ' || to_char(l_dat2, 'dd.mm.yyyy') );

 execute immediate 'truncate TABLE cin_ref' ;
 insert into cin_ref (ref, nlsa, mfob, nlsb, s , vdat )
               select ref, nlsa, mfob, nlsb, s , vdat
               from oper o where o.sos = 5 and o.tt  in ('IB1','IB2') and o.vdat >= l_dat1  and o.vdat < l_dat11  and mfoa = '300465'
                 and exists (select 1 from cin_cust u where u.NLS_2909 = o.nlsa );
 commit;
 logger.info ('CIN.PREV_DOK/2-OK. Oper' )   ;
 -------------------------------------------
 execute immediate 'truncate TABLE cin_rec' ;  ------- for Б1 + Б2 + Б3 --- arc_rrp.REC
 insert into cin_rec (rec, dk, mfoa, nlsa, mfob, nlsb, s , dat_a  )
               select rec, dk, mfoa, nlsa, mfob, nlsb, s , dat_a
               from   arc_rrp  a
               where a.dk in (1,3)     and a.sos >= 5 and a.s >= 0
                 and a.dat_a >= l_dat1 and a.dat_a  < l_dat11   -- (l_dat2 + 1) ---- 01.12.2013 09:00:00  - 31.12.3012 23:00:00
                 and exists (select 1 from cin_cust u, cin_tk t
                             where u.rnk = t.rnk  and t.mfo = a.mfoa and t.nlsr = a.nlsa and u.mfo_2600 = a.mfob and u.nls_2600= a.nlsb
                             );
 commit;
 logger.info ('CIN.PREV_DOK/3-OK. Arc_Rrp' );

 logger.info ('CIN.PREV_DO4/4-завершение формирование таблиц');

 -- сбор статистики
 dbms_stats.gather_table_stats('BARS', 'cin_ref');
 dbms_stats.gather_table_stats('BARS', 'cin_rec');
 logger.info ('CIN.PREV_DOK/3-завершение сбор статистики');

end PREV_DOK;

--------------
 PROCEDURE KOM_ALL
( p_mode int,
  s_Dat1 varchar2,
  s_Dat2 varchar2,
  p_RNK cin_cust.rnk%type
) is

--p_mode = 1    - F1. Фінальний Розрахунок + Перегляд/Корег протокола
--p_mode = 3    - F2.Перегл/Корег Фінал-протоколу
--p_mode = 0....- 1.Прогноз-Розрахунок + Перегляд рез.(від Кл)


  p_Dat1 date   :=  to_date(s_Dat1,'dd.mm.yyyy');
  p_Dat2 date   :=  to_date(s_Dat2,'dd.mm.yyyy');
  l_DNIM int    ;
  l_DNI1 int    ;
  l_DNIK number ;

  l_rnk cin_cust.rnk%type := nvl(p_rnk,0);

  l_kolm number ; -- кол месяцев в расчетном периоде.
                  -- Если расчет  делается строго за 1 месяц,
                  -- то комиссис В0 = строго абонплате, независимо от начальной даты
begin
  cin.cRNK    := l_rnk   ;
  cin.DAT_BEG := p_Dat1  ;
  cin.DAT_END := p_Dat2  ;

  PUL.Set_Mas_Ini( 'RNK'   , to_char(l_RNK), 'RNK' );
  PUL.Set_Mas_Ini( 'sFdat1', s_Dat1,  'sFdat1' );
  PUL.Set_Mas_Ini( 'sFdat2', s_Dat2,  'sFdat1' );

  ---------------------------------------------------------------
  If p_mode = 3 then RETURN; end if;  --Холостой вход в процедуру. Использовать для отложенной корректировки протокола
  ----------------------------------------------------------------
  l_DNIM := trunc( add_months(p_dat2,1),'MM') - trunc( p_dat2,'MM');
  l_DNI1 := p_dat2 - p_dat1 + 1;
  l_DNIK := l_DNI1/ l_DNIM;
  l_kolM := months_between(  p_Dat2 + 1 , p_Dat1  ) ;
-------------
--If p_mode = 0 then

   -- 0. Расчет  :  детали - документы
   If l_rnk = 0 then      execute immediate 'truncate TABLE cin_kom0 ';  else   delete from cin_kom0 where rnk = l_rnk ;   end if;

   insert into CIN_KOM0 (
          rnk,  id,   mfo,  branch,  --  Код~ТК
          ref,  -- REF АБС~докум А~cплач.~заявки
          s  ,  -- Сума~докум А~cплач.~заявки
          a2 ,  -- А2:ТАРИФ
          KA2,  -- А2~СУМА комiс за~виїзд по доставцi~готiвки
          KA1,  -- А1~СУМА комiс за~доставлену~готiвку
          b2 ,  -- Б2~ТАРИФ за~виїзд по вивозу~готiвки
          KB2,  -- Б2~СУМА комiс за~виїзд по вивозу~готiвки
          b1 ,  -- Б1~ТАРИФ(%)~за вивiз~готiвки
          KB1,  -- Б1~СУМА комiс~за вивiз~готiвки
          SB1_MIN, --Б1~ТАРИФ-Min~за мiсяць~за вивiз
          B3 ,  -- Б3~Штраф-конст~в  грн~за хол/вивiз
          KB3 , -- Б3~СУМА штрафу~за хол/вивiз
          rec,  -- REC СЕП~докум Б~перерах~клiєнту
          sr ,  -- Сума~СЕП-докум Б~перерах~клiєнту
          s3 ,  -- Кол холост.выездов
         dat1, dat2, vdat )
   select u.rnk,  t.id,  t.mfo,   t.branch ,   ---- Код~ТК  --------------------------------------------- A1+A2
          s.REF    , -- REF АБС~докум А~cплач.~заявки
          s.s/100 S, -- Сума~докум А~cплач.~заявки
          nvl(nvl(t.S_A2,u.S_A2),0) A2,  -- А2:ТАРИФ
          nvl(nvl(t.S_A2,u.S_A2),0) KA2, -- А2~СУМА комiс за~виїзд по доставцi~готiвки
          s.KA1,                         -- А1~СУМА комiс за~доставлену~готiвку
          0 B2 , -- Б2~ТАРИФ за~виїзд по вивозу~готiвки
          0 KB2, -- Б2~СУМА комiс за~виїзд по вивозу~готiвки
          0 B1 , -- Б1~ТАРИФ(%)~за вивiз~готiвки
          0 KB1, -- Б1~СУМА комiс~за вивiз~готiвки
          0 B1_MIN, -- Б1~ТАРИФ-Min~за мiсяць~за вивiз
          0 B3    , -- Б3~Штраф-конст~в  грн~за хол/вивiз
          0 KB3   , -- Б3~СУМА штрафу~за хол/вивiз
          to_number(null) Rec, -- REC СЕП~докум Б~перерах~клiєнту
          to_number(null) sr , -- Сума~СЕП-докум Б~перерах~клiєнту
          to_number(null) s3 , -- Кол холост.выездов
          p_dat1, p_dat2, s.vdat
   from cin_cust u, cin_tk t,
        (select o.ref, o.vdat, o.nlsa, o.mfob, o.nlsb, o.s, sum(cin.SK_A1(w.ref,w.tag, 1 ) )/100 KA1,  0 KB2, 0 KB1
         from cin_ref o, operw w where o.ref = w.ref group by o.ref, o.vdat, o.nlsa, o.mfob, o.nlsb, o.s    ) s
   where u.rnk = t.rnk and s.nlsa = u.nls_2909 and s.mfob = t.mfo and s.nlsb = t.nls  and l_RNK in (0, u.rnk)
   union all                                    ---------------------------------------------------------- Б1 + Б2 + Б3
   select u.rnk,  t.id ,   t.mfo,   t.branch, ---- Код~ТК
          to_number(null) REF, -- REF АБС~докум А~cплач.~заявки
          to_number(null) S  , -- Сума~докум А~cплач.~заявки
          0 A2 , -- А2:ТАРИФ
          0 KA2, -- А2~СУМА комiс за~виїзд по доставцi~готiвки
          0 KA1, -- А1~СУМА комiс за~доставлену~готiвку
          nvl( nvl( t.S_b2 ,u.S_b2  ), 0) b2 , -- Б2~ТАРИФ за~виїзд по вивозу~готiвки
                 decode(a.dk,1,1      ,0) * nvl( nvl( t.S_b2 ,u.S_b2  ), 0 ) Kb2, -- Б2~СУМА комiс за~честный виїзд по вивозу~готiвки
          nvl( nvl( t.PR_B1,u.PR_B1 ), 0) B1 , -- Б1~ТАРИФ(%)~за вивiз~готiвки
          round( decode(a.dk,1,a.s/100,0) * nvl(nvl(t.PR_B1,u.PR_B1),0) /100, 2)  KB1, -- Б1~СУМА комiс~за вивiз~готiвки
          t.SB1_MIN,                            -- Б1~ТАРИФ-Min~за мiсяць~за вивiз
          nvl( nvl( t.S_b3 ,u.S_b3  ), 0 ) b3 , -- Б3~Штраф-конст~в  грн~за хол/вивiз
                 decode(a.dk,3,a.s/100,0) *  nvl(nvl(t.S_b3 ,u.S_b3 ),0)  Kb3, -- Б3~СУМА штрафу~за хол/вивiз
          a.rec    ,  -- REC СЕП~докум Б~перерах~клiєнту
          decode(a.dk,1,a.s/100,0) SR, -- Сума~СЕП-докум Б~перерах~клiєнту
          decode(a.dk,3,a.s/100,0) S3, -- Сума~СЕП-инф.докум = кол хол выездов
         p_dat1,p_dat2, trunc(a.dat_a)
   from cin_cust u, cin_tk t, cin_rec a
   where u.rnk = t.rnk and a.mfoa = t.mfo and a.nlsa = t.nlsr and a.mfob = u.mfo_2600  and a.nlsb = u.nls_2600  and l_RNK in (0, u.rnk) ;
---------------------------------------------------------------------------------------------------------------------------------------------
   If l_rnk = 0 then      execute immediate 'truncate TABLE cin_kom1 ';
   else                   delete from cin_kom1 where rnk = l_rnk;
   end if;

   -- 1. Расчет  :  Начислено по ТК ( документы + тарифы)
   insert into CIN_KOM1 ( rnk, id , mfo, branch,  KC0,      ref,  s ,      KA1, KA2,
                          rec,  sr, s3, KB1, KB2, KB3,      c0 ,   a2,      b1,  b2,  b3, SB1_MIN,  dat1, dat2 )
   select RNK, ID, MFO, branch,          Sum(KC0) KC0,  Sum(ref) REF, sum(S)  S ,      SUM(KA1) KA1, sum(KA2) KA2,
          Sum(rec) REc, sum(Sr) Sr, sum(S3) S3,   SUM(KB1) KB1, sum(KB2) KB2,  SUM(KB3) KB3 ,
          Sum(C0)  C0 , sum(A2) A2, sum(b1) b1,   sum(b2)  b2 , sum(b3 )  b3,  sum(SB1_MIN) ,  p_dat1, p_dat2
   from ( --реальные док
         select RNK, ID, MFO, branch ,    0 KC0, -- сумма абонплаты
         count(REF) REF, sum(nvl(S ,0) ) S , SUM(KA1) KA1, sum(KA2) KA2, -- завоз
         count(REC) REC, sum(nvl(sr,0) ) SR, sum(nvl(s3,0) ) S3, greatest( SUM(KB1) , max(SB1_MIN) ) KB1, sum(KB2) KB2, max(b3)*sum(s3) KB3, -- вывоз + холост выезд
         0 C0, 0 a2, 0 B1, 0 B2, 0 B3, 0 SB1_MIN  -- тарифы
         from cin_kom0
         where l_RNK in (0, rnk)
         group by  RNK, ID, MFO, branch
         -- все тариф по А2+Б2+Б1
         union all
         select t.RNK, t.ID, t.MFO, t.branch,   decode ( l_kolM,  1,  nvl(nvl(t.s_c0,u.s_c0),0) , round(nvl(nvl(t.s_c0,u.s_c0),0)*l_DNIK,2) )  KC0, --  сумма абонплаты
                0 ref, 0 s , 0 ka1, 0 ka2,                         -- завоз
                0 REC, 0 SR, 0 s3 , 0 KB1, 0 KB2,       0 KB3,     -- вывоз
                nvl(nvl(t.s_c0    , u.s_c0  ),0) c0 ,   nvl(nvl(t.s_a2   , u.s_a2  ),0) a2,
                nvl(nvl(t.PR_B1   , u.PR_B1 ),0) B1 ,   nvl(nvl(t.S_b2   , u.S_b2  ),0) b2,  nvl(nvl(t.S_b3   , u.S_b3  ),0) b3,
                nvl(nvl(t.SB1_MIN,u.SB1_MIN),0) SB1_MIN
         from cin_cust u, cin_tk t
         where u.rnk = t.rnk and l_RNK in (0, u.rnk)
        )
   group by RNK, ID, MFO, branch   ;

   -- 2. Расчет  :  Начислено по Кл ( итого ТК)
   If l_rnk = 0 then      execute immediate 'truncate TABLE cin_kom2 ';
   else                   delete from cin_kom2 where rnk = l_rnk;
   end if;

   insert into  CIN_KOM2 ( dat1,  dat2, rnk,     KC0 ,       id ,     ref,      s ,     KA2 ,     KA1 ,     rec ,     sr,     s3 ,      kb2 ,     kb1 ,     kb3  )
                select   p_dat1,p_dat2, RNK, sum(KC0), count(id), Sum(Ref), sum(S), sum(KA2), SUM(KA1), sum(rec), sum(sr),sum(s3),  sum(Kb2), SUM(Kb1), sum(kb3)
                from cin_kom1
                where l_RNK in (0, rnk)
                group by RNK;

If p_mode = 1 then
   execute immediate 'truncate TABLE cin_tkr ' ;
   --архив расчетов
   insert into cin_tkr
         (RNK,NMK,NLS_2909,ID,NAME,MFO,NLS,REF,S,KA2,KA1,KB2,KB1,DAT1,DAT2,VDAT,KC0,A2,B1, SB1_MIN, B2,C0,NLSR,REC,SR,BRANCH,  b3,kb3,s3 )
   select RNK,NMK,NLS_2909,ID,NAME,MFO,NLS,REF,S,KA2,KA1,KB2,KB1,DAT1,DAT2,VDAT,KC0,A2,B1, SB1_MIN, B2,C0,NLSR,REC,SR,BRANCH,  b3,kb3,s3 
   from cin_kom1 u   where l_RNK in (0, u.rnk);

end if;

end KOM_ALL;
----------------------------------

PROCEDURE  KOM_GOU( p_mode int) is
  S_all  number   ;
  s_GOU  number   ;
  s_RU   number   ;
  ---------------------------
  p_Dat2 cin_tkr.dat2%type  ;
  r_cust cin_cust%rowtype   ;
  r_BR   cin_branch_ru%rowtype     ;
  r_oper oper%rowtype       ;
  l_tt1  oper.tt%type       := 'CS1';
  l_tt2  oper.tt%type       := 'CS2';
  aa61   accounts%rowtype   ;
  ----------------------------
  SBO sb_ob22%Rowtype       ; --   r020 = '6119'; ob22 = '16'  ;  TRANSFER_2017 : 6119 =>6519 , об22 не изм в новом
  ---------------------------
  l_rec  arc_rrp.REC%type   ;
  l_sos  oper.sos%type      ;
  n_Tmp  int                ;
  l_id_o oper.id_o%type     := '******';
  ---------------------------
begin

  If p_mode = 37 then -- перекрытие 3739 и 3578
     for k in (select a.nls nlsA, substr(a.nms,1,38) nam_A, least ( a.ostc, - b.ostc) S,
                      b.nls nlsB, substr(b.nms,1,38) nam_B, c.okpo, u.txt6
               from accounts a, accounts b, cin_cust u, customer c
               where a.kv = 980 and a.ostc = a.ostb and a.ostc > 0 and a.nls = u.nls_3739 and u.rnk = c.rnk
                 and b.kv = 980 and b.ostc = b.ostb and b.ostc < 0 and b.nls = u.nls_3578 and  least ( a.ostc, - b.ostc) > 0
               )
     loop
       gl.ref(r_oper.REF);
       r_oper.nd    := Substr ('0000000000'|| r_oper.REF, -10);
       r_oper.nazn  := Substr ('Сплата комісії за послуги інкасації. Згідно дог ' || k.TXT6 , 1, 160 ) ;
       gl.in_doc3( ref_ => r_oper.REF, tt_   => l_tt1   , vob_ => 6       , nd_   => r_oper.nd, pdat_ => SYSDATE,
                   vdat_=> gl.bdate  , dk_   => 1       , kv_  => 980     , s_    => k.s      , kv2_  => 980    , s2_=> k.s,
                   sk_  => null      , data_ => gl.BDATE, datp_=> gl.bdate, nam_a_=> k.nam_A  , nlsa_ => k.nlsA ,
                  mfoa_ => gl.aMfo   , nam_b_=> k.nam_B , nlsb_=> k.nlsB  , mfob_ => gl.aMfo  , nazn_ => r_oper.nazn,
                  d_rec_=> null      ,                    id_a_=> k.OKPO  , id_b_ => gl.aOKPO , id_o_ => null   ,
                  sign_ => null      , sos_  => 1       , prty_=> null    , uid_  => null     )  ;
       gl.payv(0, r_oper.REF, gl.bDATE , l_TT1, 1 , 980 , k.nlsA, k.s, 980, k.nlsB , k.S   )  ;
    ---gl.pay (2, r_oper.REF, gl.bDATE ) ;
     end loop;
     RETURN;
  end if ;
  ------------------------------------------------------

  select max(dat2) into p_Dat2 from cin_tkr where ref_kom is null;
  If p_dat2 is null then      raise_application_error(-20100, 'Не выполнен финальный расчет' ) ;  end if;

  If to_number ( to_char( gl.bdate, 'DD') ) < 10 and to_char (p_dat2, 'yyyymm') < to_char ( gl.bdate, 'yyyymm') then
     select max(fdat) into  r_oper.vdat from fdat where fdat <= p_dat2;  r_oper.vob := 96 ;
  else                      r_oper.vdat := gl.bdate ;                    r_oper.vob :=  6 ;
  end if;


  ------------------------------- TRANSFER_2017 : 6119 =>6519 , об22 не изм в новом
  begin select * into SBO from sb_ob22 where r020 = '6519' and ob22 ='16' and d_close is null;  
  EXCEPTION WHEN NO_DATA_FOUND THEN 
        begin select * into SBO from sb_ob22 where r020 = '6119' and ob22 ='16' and d_close is null;
        EXCEPTION WHEN NO_DATA_FOUND then raise_application_error(-20100, 'Не знайдено аналітики в SB_Ob22 рах R020=6519(6119), Ob22=16 ' ) ;
        end;
  end ;

  begin select * into aa61 from accounts where kv=980 and nbs = SBO.r020 and dazs is null and ob22 = SBO.ob22 and rownum = 1;
      aa61.nms := substr(aa61.nms,1,38);
  EXCEPTION WHEN NO_DATA_FOUND       THEN raise_application_error(-20100, 'Не знайдено особового рах. "За послуги служби інкасації" '|| SBO.R020 || '.'|| SBO.OB22 || '  в ГОУ ' ) ;
  end;

  r_cust.rnk  := -1  ;
  r_BR.branch := '*' ;
  for k in (select rowid RI, c.* from cin_tkr c where c.dat2=p_dat2 and c.ref_kom is null order by c.rnk, c.branch, c.id )
  loop
    S_all := (k.KC0 + k.KA1 + k.KA2 + k.KB1 + k.KB2 + k.KB3 ) * 100;
    If S_all <= 0 then GOTO HET_; end if;
    -------------------------------------
    k_branch := k.branch;

    -- Счет - A
    If r_cust.rnk <> k.rnk then

       begin select *                into r_cust        from cin_cust where rnk = k.rnk;
             select substr(nmk,1,38) into r_oper.nam_a  from customer where rnk = k.rnk;
       EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20100, 'Не найден клиент RNK='||k.rnk  ) ;
       end;

       -- Начисление на счетах 3578:
       If p_mode = 3 then
          If r_cust.nls_3578 is not null then
             r_cust.nls_3739 := r_cust.nls_3578 ;
          else
             begin ----------------------------------------------------------------------------------- найти 3578
                select nls into r_cust.nls_3739 from accounts where rnk = k.rnk and nbs= '3578' and ob22='09' and dazs is null and kv= 980 and rownum =1;
             EXCEPTION WHEN NO_DATA_FOUND THEN
                declare aa37  accounts%rowtype ;  ---------------------------------------------------- открыть 3578
                begin select * into aa37 from accounts where nls = r_cust.nls_3739 and kv =980;
                      r_cust.nls_3739 := '357800109'|| substr('00000'||k.RNK, - 5) ;
                      r_cust.nls_3739 := VKRZN ( substr( gl.aMfo,1,5), r_cust.nls_3739 ) ;
                      op_reg ( 99, 0, 0, aa37.grp, n_Tmp, k.rnk, r_cust.nls_3739 , 980, 'Нарах.ком. за Центр.IHкасацiю', 'ODB', aa37.isp, aa37.acc );
                      insert into specparam_int (acc, ob22) values (aa37.ACC,'09');
                EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20100, 'Не найден счет 3739 Для кл='||k.rnk  ) ;
                end;
             end ;
             update cin_cust set nls_3578 = r_cust.nls_3739  where rnk = r_cust.rnk; ----------------- запомнить 3578
          end if;
       end if ; -- p_mode = 3
    end if;

    -- Счет Б
    If r_BR.branch <> k.branch then
       begin   select * into r_BR from cin_branch_ru where branch = k.branch;
       EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20100, 'Не найден в справочнике branch ='||k.branch  ) ;
       end;

       r_oper.nam_b := substr(r_br.name,1,38);

--- OLD:  Структура рахунку має бути така:        ААААК00НН00FFF-    r_oper.nlsb  := vkrzn( substr(k.MFO,1,5), '6119000'|| l_ob22 ||'00'||substr (k.branch,12,3)  );
--- 10.11.2017  Теперь все доходы должны поступать на один счет:  6519К001600000 ( 6119*001600000 )
       r_oper.nlsb  := vkrzn( substr(k.MFO,1,5), SBO.R020 ||'000'|| SBO.ob22 ||'00000' );

    end if;
    s_GOU := round( k.KC0 * r_cust.PC0
                  + k.KA1 * r_cust.PA1
                  + k.KA2 * r_cust.PA2
                  + k.KB1 * r_cust.PB1
                  + (k.KB2+k.KB3) * r_cust.PB2 ,
                   0 ) ;
    s_RU  := S_All - S_GOU ;
    gl.ref(r_oper.REF);
    update cin_tkr set ref_kom = r_oper.REF where rowid = k.RI;
    r_oper.nd := substr(to_char(r_oper.REF), 1, 10);
    begin select substr(
             'Комiсiя за послуги Центр.Iнкасацiї. '||k.branch||' '   || name ||
             '. Перiод з ' || to_char(k.dat1,'dd.mm.yyyy')   ||' по '|| to_char(k.dat2,'dd.mm.yyyy'),   1, 160 )
      into r_oper.nazn   from cin_tk where id = k.id;
    EXCEPTION WHEN NO_DATA_FOUND THEN      raise_application_error(-20100, 'Не найдена ТК='||k.id  ) ;
    end;

    begin  select okpo into r_oper.id_b from BANKS_RU where mfo = k.mfo;
    EXCEPTION WHEN NO_DATA_FOUND THEN   r_oper.id_b := gl.aOkpo;
    end;

    If s_RU >0 and k.mfo <> gl.aMfo then
                               r_oper.d_rec := '#CBRANCH:'  ||k_branch|| '#';
       If r_oper.vob = 96 then r_oper.d_rec := r_oper.d_rec || 'D'    || to_char (r_oper.vdat, 'YYMMDD') ||'#' ;  end if;

       gl.in_doc3( ref_ => r_oper.REF  , tt_   => l_tt2       , vob_  => r_oper.vob , nd_   => r_oper.nd   , pdat_ => SYSDATE,
                   vdat_=> r_oper.vdat , dk_   =>  1          , kv_   => 980        , s_    => s_RU        , kv2_  =>  980   , s2_=> s_RU,
                    sk_ => null        , data_ => gl.BDATE    , datp_ => gl.bdate   , nam_a_=> r_oper.nam_a, nlsa_ => r_cust.nls_3739,
                   mfoa_=> gl.aMfo     , nam_b_=> r_oper.nam_b, nlsb_ => r_oper.nlsb, mfob_ => k.mfo       , nazn_ => r_oper.nazn    ,
                  d_rec_=> r_oper.d_rec, id_a_=> gl.aOKPO     , id_b_ => r_oper.id_b, id_o_ => l_id_o      ,
                  sign_ => null        , sos_  =>  1          , prty_ => null       , uid_  => NULL        )      ;

        paytt(0, r_oper.REF, gl.bDATE, l_TT2, 1, 980, r_cust.nls_3739, s_RU , 980, r_oper.nlsb   , S_ru) ;

    Else
       gl.in_doc3( ref_ => r_oper.REF , tt_   => l_tt1       ,  vob_ => r_oper.vob, nd_   => r_oper.nd   , pdat_ => SYSDATE,
                   vdat_=> r_oper.vdat, dk_   => 1           ,  kv_  => 980       , s_    => s_ALL       , kv2_  => 980    , s2_=> s_ALL,
                   sk_  => null       , data_ => gl.BDATE    ,  datp_=> gl.bdate  , nam_a_=> r_oper.nam_a, nlsa_ => r_cust.nls_3739 ,
                  mfoa_ => gl.aMfo    , nam_b_=> aa61.nms    ,  nlsb_=> aa61.nls  , mfob_ => gl.aMfo     , nazn_ => r_oper.nazn,
                  d_rec_=> null       ,                         id_a_=> gl.aOKPO  , id_b_ => gl.aOKPO    , id_o_ => null   ,
                  sign_ => null       , sos_  => 1           ,  prty_=> null      , uid_  => null        )     ;

       If s_RU >0 then  gl.payv(0, r_oper.REF, gl.bDATE, l_TT1, 1, 980, r_cust.nls_3739, s_RU, 980, aa61.nls  , S_RU );
          update opldok set txt ='Комiciя служби iнкасацiї площадки ОБ' where ref = gl.aRef and stmt= gl.astmt;
       end if;

    end if;

    If s_GOU >0 then
       gl.payv(0, r_oper.REF, gl.bDATE, l_TT1, 1, 980, r_cust.nls_3739, s_GOU , 980, aa61.nls , S_GOU );
       update opldok set txt ='Процент комiciї ЦА Ощадбанку за послуги iнкасацiї' where ref = gl.aRef and stmt= gl.astmt;
    end if;
    ---------------------
    <<HET_>>  null;

  end loop;

end KOM_GOU;

END CIN;
/

GRANT execute ON BARS.CIN TO BARS_ACCESS_DEFROLE;