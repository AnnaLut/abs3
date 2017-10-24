

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BS_2620.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BS_2620 ***

  CREATE OR REPLACE PROCEDURE BARS.BS_2620 ( mode_ int, p_dat date) is

/*
/*
 16.02.2015 Sta Убираем табл TEST+TMP - заменила на ANI
  Обновления должны быть выложены в заявку http://jira.unity-bars.com.ua:11000/browse/PABS-441 с соответствующим комментарием.

 11-01-2014 Sta  Разные гляделки по 3800-3801 : тек, за день, за мес
 23-04-2012 Львовское РУ NADRA просит  в функцию  "Матриця 2620,2625,2630,2635; Вал=980,840,978"  добавить еще золото.
 12-07-2011  Матриця Бал.Рах. 6*, 7* по Бранч-2 (з корр).
             Ежели по счету входящий остаток "0.00", и был коррект. оборот,
             то такой счет в отчет не попадает   - ИСПРАВЛЕНО.
 05-07-2011 "Звiт про рах.3800" - добавлено колонки "Разом"
 17-06-2011 6-7 с корр
 10-04-2011 По умолчанию - банковская дата
 12-02-2011 ОБ22 переехало в accounts
 18-01-2011 Sta mode_ = 0,6  Если бранч Счета = 1 уровень, то учитываем на 2-м уровне /000000/
 13-11-2010 + спецификация по КД
 09-06-2010 общая процедура для
            построения специализированнх динамических аналитических форм
 mode_=0      Депозитные счета 2620 2630 2635
 mode_=6      6+7 класс
 mode_=16     6+7 класс с корр
 mode_=3800   вал.поз
 mode_ < 0    спецификация по КД
*/

  l_dat  date := p_dat ;   l_dat1  date ;

  di_    ACCM_CALENDAR.bankdt_id%type  ;
  NBS_   accounts.NBS%type    :='****' ;
  k_NBS  accounts.NBS%type    ;
  OB22_  accounts.OB22%type   :='**'   ;
  k_OB22 accounts.OB22%type   ;
  k_KV   accounts.KV%type     ;
  k_BR   accounts.BRANCH%type ;
  k_N    NUMBER(24,2)         ;
  k_Q    NUMBER(24,2)         ;

  ColN_   varchar2(30)  ;
  ColQ_   varchar2(30)  ;
  CozN_   varchar2(30)  ;
  CozQ_   varchar2(30)  ;
  CorQ_   varchar2(30)  ;

  sSql_ varchar2 (4000) ;

  TEST_ varchar2 (30)   :='ANI_xxxx';
  accM_ SYS_REFCURSOR   ;
  ND_   cc_deal.ND%type ;
  aa    accounts%rowtype;
  bb    accounts%rowtype;
  dat31_ date;

begin

if l_dat is null  then
   l_dat := to_date ( pul.Get_Mas_Ini_Val('sFdat1'), 'dd.mm.yyyy') ;
   l_dat := nvl ( l_dat, gl.bdate );
end if;

PUL.Set_Mas_Ini( 'sFdat1', to_char( l_dat,'dd.mm.yyyy') , 'Пар.sFdat1' );

l_dat1 := to_date('01.'|| to_char(l_dat,'mm.yyyy'),'dd.mm.yyyy');

  -- имя результат-таблицы
  If    mode_ = 0      then TEST_ := 'ANI_2620' ; -- кат.запрос pkey = \SBR\BRS\DPT\016  "Матриця БР=2620,2625,2630,2635; Вал=980,840,978"
  elsIf mode_ in(6,16) then TEST_ := 'ANI_67'   ; -- кат.запрос pkey = \SBR\BRS\DPT\017  "Матриця Бал.Рах. 6*, 7* по Бранч-2"
  elsIf mode_ = 16     then TEST_ := 'ANI_67'   ; -- кат.запрос pkey = \SBR\BRS\DPT\019  "Матриця Бал.Рах. 6*, 7* по Бранч-2 (з корр)"
  elsIf mode_ = 3800   then TEST_ := 'ANI_3800' ; -- ??? - похоже, уже не используется. Очевидно,  разовый
  elsIf mode_ < 0      then TEST_ := 'ANI_SP_KD'; -- кат.запрос pkey = \SBR\BRS\CCK\ND   "Специфiкацiя (виписка) по КД"
        ND_ := - mode_;
  elsIf mode_ in (380,381,382)  then   --  11-01-2014 Sta  Разные гляделки по 3800-3801 : тек-380, за день-381, за мес-382,
        delete from CCK_AN_TMP;

        If mode_ = 382 then
           select Dat_last (p_dat - 4, p_dat -1 ) into dat31_ from dual;  -- последний рабочий день месяца
        end if;

        for k in (select * from vp_list where acc3800 is not null and acc3801 is not null)
        loop
           select * into aa from accounts where acc=k.acc3800;
           select * into bb from accounts where acc=k.acc3801;

           If    mode_ = 380 then null;                            -- текущ день - 380,
                 aa.ostq := gl.p_icurval( aa.kv, aa.ostc, gl.bdate);
           ElsIf mode_ = 381 then                                  -- любой день - 381
                 aa.ostc := fost(aa.acc, p_dat);
                 aa.ostq := gl.p_icurval( aa.kv, aa.ostc, p_dat   );
                 bb.ostc := fost(bb.acc, p_dat);
           ElsIf mode_ = 382 then                                  -- за мес-382,
                 aa.ostc := ost_korr(aa.acc,dat31_, null, aa.nbs  );
                 aa.ostq := gl.p_icurval( aa.kv, aa.ostc, dat31_  );
                 bb.ostc := ost_korr(bb.acc,dat31_, null, bb.nbs  );
           end if;

           If bb.ostc<> 0 or aa.ostq <> 0 then
              insert into CCK_AN_TMP (kv, nls, nlsalt, branch, name, n1,n2,n3,n4) values
                  (aa.kv, aa.nls, bb.nls, aa.branch, aa.ob22, aa.ostc/100, aa.ostq/100, bb.ostc/100, (aa.ostq+bb.ostc)/100 );
           end if;
        end loop;

  else  RETURN;
  end if;

  -- выражение для создания результат-таблицы
  If mode_=0 then
     sSql_ :=
      'create table '||TEST_||'(NBS char(4),ob22 char(2),Q_ALL number(24,2),'||
             'N_980 number(24,2),'||
             'N_840 number(24,2),'||
             'Q_840 number(24,2),'||
             'N_978 number(24,2),'||
             'Q_978 number(24,2),'||
             'N_959 number(24,2),'||
             'Q_959 number(24,2) )' ;

  elsIf mode_ in  (6,16)  then
     sSql_ := 'create table '||TEST_||'(NBS char(4),ob22 char(2),Q_ALL number(24,2))';

  elsIf mode_=3800 then
     sSql_ := 'create table '||TEST_||
      '(branch varchar2(15),kv int,n_03 number, n_09 number, n_10 number,
                                   n_16 number, n_20 number, n_22 number,
                                   N_AA number, n_PP number  )';
  elsIf mode_ < 0  then
       sSql_ := 'create table '||TEST_|| '(fdat date)';
  else
     RETURN;
  end if;

  If mode_ <= 0    then
     begin     EXECute immediate 'drop table '|| TEST_;         -- дропнуть таблицу
     exception  when others then  if sqlcode = -00942 then   null;  else      raise;     end if;         --ORA-00942: table or view does not exist
     end;
  end if;


  begin   EXECute immediate sSql_;      -- создать результат-таблицу - если ее еще нет
     sSql_ := 'grant select  on '|| TEST_ || ' to SALGL';
     execute immediate  sSql_;
  exception  when others then  if sqlcode = -00955 then   null;  else      raise;     end if;      --ORA-00955: name is already used by an existing object
  end;

  EXECute immediate 'truncate table '|| TEST_ ;

If mode_ < 0    then
   for s in (select a.nls, a.kv from accounts a, nd_acc n
             where a.nls not like '6%'  and a.nls not like '8999%'
               and a.acc=n.acc          and n.nd= ND_
             union all
             select a.nls, a.kv from accounts a, cc_accp p
             where p.acc=a.acc and p.accs in
                  (select acc from nd_acc where nd=ND_)
             order by 1)
   loop
     sSql_ := 'alter table '|| TEST_ ||
              ' add (d_' || s.nls || '_' || s.kv || ' number(24,2),' ||
                    'k_' || s.nls || '_' || s.kv || ' number(24,2),' ||
                    's_' || s.nls || '_' || s.kv || ' number(24,2)   )';

     --добавить колонки по счетам
     begin        EXECute immediate sSql_;
     exception  when others then    if sqlcode = -01430 then   null;  else      raise;     end if;         --ORA-01430: column being added already exists in table
     end;
   end loop;

   for k in (select s.fdat, s.dos, s.kos, s.ostf-s.dos+s.kos OST, a.nls, a.kv
             from accounts a, nd_acc n, saldoa s
             where a.nls not like '6%'  and a.nls not like '8999%'
               and a.acc=n.acc          and n.nd= ND_ and a.acc= s.acc
             union all
             select s.fdat, s.dos, s.kos, s.ostf-s.dos+s.kos OST, a.nls, a.kv
             from accounts a, cc_accp p, saldoa s
             where p.acc=a.acc and p.accs in
                  (select acc from nd_acc where nd=ND_)
               and a.acc= s.acc
             )

   loop
     sSql_ :=
        'update ' || TEST_ || ' set ' ||
        ' d_' || k.nls || '_' || k.kv || ' = ' || to_char(k.dos) || '/100,' ||
        ' k_' || k.nls || '_' || k.kv || ' = ' || to_char(k.kos) || '/100,' ||
        ' s_' || k.nls || '_' || k.kv || ' = ' || to_char(k.ost) || '/100 ' ||
        ' where fdat=to_date(''' || to_char(k.fdat,'dd-MM-yyyy') ||
        ''',''dd-MM-yyyy'') ';

     EXECute immediate sSql_;

     if SQL%rowcount = 0 then
        sSql_ :=
        'INSERT INTO ' || TEST_  || ' (FDAT,'   ||
           ' d_' || k.nls || '_' || k.kv || ', '||
           ' k_' || k.nls || '_' || k.kv || ', '||
           ' s_' || k.nls || '_' || k.kv || ')  VALUES ( to_date(''' ||
            to_char(k.fdat,'dd-MM-yyyy') ||  ''',''dd-MM-yyyy''),'   ||
            to_char(k.dos) || '/100, '   ||
            to_char(k.Kos) || '/100, '   ||
            to_char(k.OST) || '/100) '  ;

        EXECute immediate sSql_;
     END IF;

   end loop;

   return;

end if;

  If mode_ = 3800 then

     begin  sSql_ := 'alter table ' || TEST_ || ' add (N_AA number, n_PP number )';   execute immediate  sSql_ ;
     exception  when others then  if sqlcode = -01430 then   null;  else      raise;     end if;        ---ORA-01430: column being added already exists in table
     end;

     -- только для єтого режима - 3800 - очень простой
     sSql_ :=
      'insert into '||TEST_||'(branch, kv, n_03, n_09, n_10 , n_16, n_20, n_22, N_AA, N_PP )
       select substr(a.branch,1,15), a.kv,
         sum(decode (a.ob22,''03'', fost(a.acc,:l_dat),0))/100,
         sum(decode (a.ob22,''09'', fost(a.acc,:l_dat),0))/100,
         sum(decode (a.ob22,''10'', fost(a.acc,:l_dat),0))/100,
         sum(decode (a.ob22,''16'', fost(a.acc,:l_dat),0))/100,
         sum(decode (a.ob22,''20'', fost(a.acc,:l_dat),0))/100,
         sum(decode (a.ob22,''22'', fost(a.acc,:l_dat),0))/100,
         sum(decode (sign(fost(a.acc,:l_dat)),-1, fost(a.acc,:l_dat),0))/100,
         sum(decode (sign(fost(a.acc,:l_dat)), 1, fost(a.acc,:l_dat),0))/100
       from accounts a  where a.nbs =''3800''   and fost(a.acc,:l_dat) <> 0   group by substr(a.branch,1,15), a.kv ';

     execute immediate  sSql_   using  l_dat, l_dat, l_dat, l_dat, l_dat, l_dat, l_dat, l_dat, l_dat, l_dat, l_dat ;

     commit;
     RETURN;
  end if;
---

  for b in (select substr(branch,9,6)  BR  from branch where length(branch)=15       order by 1)
  loop
    If mode_=0 then
       sSql_ :=
         'alter table '|| TEST_ ||' add (N_980_'||b.BR||' number(24,2),'||
         'N_840_'||b.BR||' number(24,2),'||
         'Q_840_'||b.BR||' number(24,2),'||
         'N_978_'||b.BR||' number(24,2),'||
         'Q_978_'||b.BR||' number(24,2),'||
         'N_959_'||b.BR||' number(24,2),'||
         'Q_959_'||b.BR||' number(24,2),'||
         'Q_RES_'||b.BR||' number(24,2) )';
    elsIf mode_ in (6,16) then        sSql_ :=   'alter table ' || TEST_||' add (N_980_'||b.BR||' number(24,2))';
    else  RETURN;
    end if;

    --добавить колонки по бранчам
    begin  EXECute immediate sSql_;
    exception  when others then if sqlcode = -01430 then   null;  else  raise; end if;     --ORA-01430: column being added already exists in table

    end;

  end loop;
  ---------------------------------------
  begin  select caldt_id into di_ from ACCM_CALENDAR   where caldt_date = decode ( mode_,16, l_dat1,l_dat ) ;
  exception  when others then RETURN;
  end;

  If MODE_ = 0 then
          OPEN accM_ FOR
          select c.nbs,c.ob22,c.kv,c.br,sum(m.ost)/100 N,sum(m.ostQ)/100 Q
          from
              (select decode(length(branch),8,'000000',substr(branch,9,6) ) BR, acc, nbs, kv, ob22 from accounts where nbs in ('2620','2625','2630','2635') ) c,
              (select acc, ost, ostq from ACCM_SNAP_BALANCES  where  ost<>0 and  caldt_ID = Di_    ) m
          where c.acc=m.acc      group by c.nbs,c.ob22,c.kv,c.br
          union all
          select '9999','',0,'', 0,0 from dual      order by 1,2 ;

  elsIf MODE_ = 6 then   OPEN accM_ FOR
          select c.nbs,c.ob22,c.kv,c.br,sum(m.ost)/100 N,sum(m.ostQ)/100 Q
          from
              (select decode(length(branch),8,'000000',substr(branch,9,6)) BR, acc, nbs, kv, ob22 from accounts where nbs >'5999' and nbs<'8' ) c,
              (select acc, ost, ostq from ACCM_SNAP_BALANCES    where  ost<>0 and  caldt_ID = Di_  ) m
          where c.acc=m.acc     group by c.nbs,c.ob22,c.kv,c.br
          union all             select '9999','',0,'', 0,0 from dual
          order by 1,2 ;

  elsIf MODE_ = 16 then  OPEN accM_ FOR
          select c.nbs,c.ob22,c.kv,c.br,sum(m.ost)/100 N,sum(m.ostQ)/100 Q
          from
              (select decode(length(branch),8, '000000', substr(branch,9,6)) BR, acc, nbs, kv, ob22 from accounts where nbs > '5999' and nbs < '8' ) c,
              (select acc, (ost-CRDOS+CRKOS) ost, (ostq-CRDOSQ+CRKOSQ)  ostq from ACCM_agg_monBALS where (ost-CRDOS+CRKOS )<>0 and  caldt_ID = Di_ ) m
          where c.acc=m.acc
          group by c.nbs,c.ob22,c.kv,c.br
          union all
          select '9999','',0,'', 0,0 from dual
          order by 1,2 ;

  else
     RETURN;
  end if;

  -- курсор д.б.открыть к моменту вызова процедуры
  IF NOT accM_%ISOPEN THEN     RETURN;  END IF;

  LOOP
  <<nextrec>> -- переход на другую строку курсора
    FETCH accM_ INTO k_NBS, k_OB22, k_KV, k_BR, k_N, k_Q  ;    EXIT WHEN accM_%NOTFOUND;

   If nbs_     <> k_NBS or OB22_ <> k_OB22  then

      If NBS_   = '****' then   ------------------------------------------------------------------- для общей итоговой строки
         sSql_ := 'insert into ' || TEST_ || '(NBS,ob22) values (''****'',''**'')';                 EXECute immediate sSql_;
      end if;

      If nbs_  <> k_NBS AND K_NBS <> '9999' then  ------------------------------------------------ для итоговой строки по БС
         sSql_ := 'insert into ' || TEST_ || '(NBS,ob22) values ('''||k_NBS||''',''**'')';         EXECute immediate sSql_;
      end if;
      If k_NBS <> '9999' then ----------------------------------------------------------------------- Рабочая строка
         sSql_ := 'insert into ' || TEST_ || '(NBS,ob22) values ('''||k_NBS||''','''||k_ob22||''')';  EXECute immediate sSql_;
      end if;
      ---------------------------------
      nbs_ := k_NBS ; OB22_ := k_OB22 ;
      ---------------------------------
   end if;

   If k_NBS <> '9999' then
      -- Рабочая строка = накопить сумму
      ColN_ := 'N_'||k_KV||'_'|| k_BR;
      ColQ_ := 'Q_'||k_KV||'_'|| k_BR;
      CorQ_ := 'Q_RES'   ||'_'|| k_BR;
      CozN_ := 'N_'||k_KV;
      CozQ_ := 'Q_'||k_KV;

      If mode_=0 then

         If k_kv in (980) then /*  ГРН ном = екв   */

            sSql_ :=
              'update ' || TEST_ || ' set '  ||
                'Q_ALL   = NVL(Q_ALL,      0) + ' || k_Q  || ', '  ||
                 colN_||'= NVL('||colN_||',0) + ' || k_N  || ', '  ||
                 cozN_||'= NVL('||cozN_||',0) + ' || k_N  ||
              ' where nbs  IN ('''|| k_nbs||''',''****'')'||
                ' and ob22 IN ('''|| k_ob22||''',''**'') ' ;

         elsIf k_kv in (840,978,959) then /* базовi ВАЛ  */

            sSql_ :=
              'update ' || TEST_ || ' set '  ||
                'Q_ALL   = NVL(Q_ALL,      0) + ' || k_Q  || ', '  ||
                 colN_||'= NVL('||colN_||',0) + ' || k_N  || ', '  ||
                 cozN_||'= NVL('||cozN_||',0) + ' || k_N  || ', '  ||
                 colQ_||'= NVL('||colQ_||',0) + ' || k_Q  || ', '  ||
                 cozQ_||'= NVL('||cozQ_||',0) + ' || k_Q  ||
              ' where nbs  IN ('''|| k_nbs||''',''****'')'||
                ' and ob22 IN ('''|| k_ob22||''',''**'') ' ;

         else /* Iнши валюти */

            sSql_ :=
              'update ' || TEST_ || ' set '||
                 'Q_ALL= NVL(Q_ALL,0)+' || k_Q || ', '||
               corQ_||'= NVL('||corQ_||',0)+'  || k_Q  ||
              ' where nbs  IN ('''|| k_nbs||''',''****'')'||
                ' and ob22 IN ('''|| k_ob22||''',''**'') ' ;

         end if;

      elsIf mode_ in (6,16) then

         -- ГРН  1) по БС+ОБ22, 2) по БС, 3) по всем  БС
         sSql_ :=
              'update ' || TEST_ || ' set '  ||
                'Q_ALL   = NVL(Q_ALL,      0) + ' || k_Q  || ', '  ||
                 colN_||'= NVL('||colN_||',0) + ' || k_N  ||
              ' where nbs  IN ('''|| k_nbs||''',''****'')'||
                ' and ob22 IN ('''|| k_ob22||''',''**'') ' ;

      else null;

      end if;

      begin    EXECute immediate  sSql_;   exception  when others then    raise_application_error(-20100, 'Тело SQL=' || sSql_ );     end;

   end if;

end loop;

  commit;

end BS_2620;
/
show err;

PROMPT *** Create  grants  BS_2620 ***
grant EXECUTE                                                                on BS_2620         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BS_2620         to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BS_2620.sql =========*** End *** =
PROMPT ===================================================================================== 
