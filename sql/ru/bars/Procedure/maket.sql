

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MAKET.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MAKET ***

  CREATE OR REPLACE PROCEDURE BARS.MAKET ( nAlg_ int, DAT1_ date, DAt2_ date ) IS

/*
 06.04.2012 ISPRO.dbf отриц сумма
 04.04.2012 Sta Повторный прийом проводок из ISPRO.dbf
 27-02-2012 Sta Обробка файла из вн.бух.
 12-02-2011 Sta OB22 -> Accounts
 09-11-2010 Sta.  Добавлены расчеты-вытяжки из XML- файла

 Инсталляция состоит из (скрипт во вложениях) :
1. t_maket_rec - структура для хранения записи макета
2. t_maket_table - массив структур записей макета
3. f_get_maket_records - функция получения масива записей загруженных макетов

при переносе этих объетов в пакет,
необходимо типы t_maket_rec, t_maket_table
добавить в заголовок пакета убрав "create or replace".
функция возвращает записи из всех xml файлов загруженых в tmp_lob.strdata.

функция возвращает набор структур типа
(с функцией можно работать обращаяськ ней как к таблице со след полями):

create or replace type t_maket_rec as object
(
     cps         varchar2(10), -- оригинальное поле cps
     cps_decoded varchar2(100),  -- декодированно поле cps
     term_id     varchar2(10),
     br3         varchar2(100), -- оригинальный код отделения
     br3_decoded varchar2(30), -- декодированный код отделения
     tran_amt    number,
     tran_cnt    number(10),
     tot_amt     number,
     fee_amt_i   number,
     fee_amt_a   number,
     fee_amt     number
);


пример обращения к функции:
barsbegin
  for cur in (select * from table(f_get_maket_records)) loop
    dbms_output.put_line('cps = ' || cur.cps_decoded || ' br3 = ' ||
                         cur.br3_decoded || ' fee_amt_a = ' ||
                         cur.fee_amt_a);
  end loop;
end;
*/

 -------------------------
 ref_    oper.ref%type    ;
 c0      SYS_REFCURSOR    ;
 c1      SYS_REFCURSOR    ;
 nlsa_   oper.nlsa%type   ;
 nlsb_   oper.nlsb%type   ;
 s_      oper.s%type      ;
 dk_     oper.dk%type     ;
 nazn_   oper.nazn%type   ;
 nmsa_   oper.nam_a%type  ;
 nmsb_   oper.nam_b%type  ;
 branch_ oper.branch%type ;
 ri_     varchar2(100)    ;
 -------------------------
BEGIN
   delete from CCK_AN_TMP;

if nAlg_ =   0 then
   --Прийом проводок из ISPRO.dbf
   begin
     execute immediate 'alter table isPRO add (ref int, stmt int)';
   exception when others then
     --ORA-01430: column being added already exists in table
     if sqlcode = -01430 then
        raise_application_error(-20100,'Повторная обработка принятого файла');
     else
        raise;
     end if;
   end;
   ------------------------

   OPEN c0 FOR
  'select i.DEBET, i.KREDIT, i.s, i.nazn, substr(d.nms,1,38), substr(c.nms,1,38)
   from accounts d, accounts c,
       (select  DEBET, KREDIT, sum(SUMMA*100) s, min(NAZN) nazn
        from isPRO group by DEBET, KREDIT) i
        where d.nls=i.DEBET  and d.kv = 980 and d.dazs is null
          and c.nls=i.KREDIT and c.kv = 980 and c.dazs is null';
   LOOP
     FETCH c0 INTO  nlsa_, nlsb_, s_, nazn_, nmsa_, nmsb_ ;
     EXIT WHEN c0%NOTFOUND;


     gl.ref (REF_);
     gl.in_doc3(ref_  => REF_,
               tt_    => 'SMO',
               vob_   => -6,
               nd_    => substr(to_char(REF_),1,10),
               pdat_  => SYSDATE ,
               vdat_  => gl.BDATE,
               dk_    => 1,
               kv_    => gl.baseval,
               s_     => S_,
               kv2_   => gl.baseval,
               s2_    => S_,
               sk_    => null,
               data_  => gl.BDATE,
               datp_  => gl.bdate,
               nam_a_ => nmsa_,
               nlsa_  => nlsa_ ,
               mfoa_  => gl.aMfo,
               nam_b_ => nmsb_,
               nlsb_  => nlsb_ ,
               mfob_  => gl.aMfo,
               nazn_  => nazn_,
               d_rec_ => null,
               id_a_  => null,
               id_b_  => null,
               id_o_  => null,
               sign_  => null,
               sos_   => 1,
               prty_  => null,
               uid_   => null  );

     OPEN c1 FOR
       'select SUMMA*100, BRANCH, rowid ' ||
       'from isPRO '  ||
       'where DEBET=' || nlsa_ || ' and KREDIT=' || nlsb_ ;
     LOOP
        FETCH c1 INTO  s_, branch_, ri_ ;
        EXIT WHEN c1%NOTFOUND;

        If s_ <0 then  dk_ := 0 ; s_ := - s_;
        else           dk_ := 1 ;
        end if;



        gl.payv(flg_  => 0,
                ref_  => REF_ ,
                dat_  => gl.bDATE ,
                tt_   => 'SMO',
                dk_   => dk_  ,
                kv1_  => gl.baseval,
                nls1_ => nlsa_,
                sum1_ => s_   ,
                kv2_  => gl.baseval,
                nls2_ => nlsb_,
                sum2_ => S_ );

        update opldok set txt = branch_ where ref= gl.aRef and stmt=gl.astmt;

        execute immediate
         'update isPRO set ref=' || gl.aref || ', stmt=' || gl.astmt ||
         ' where rowid ='''||ri_ ||'''';

     end loop;
     CLOSE c1;

   end loop;
   CLOSE c0;

   execute immediate   'grant select on isPRO to pyod001';

   return;

Elsif nAlg_ =   26 then
   -- Послуги ПЦ за обслуговування кл_єнт_в в _нших банках Master Card
   null;

Elsif nAlg_ =27 then
   -- Послуги ПЦ за обслуговування кл_єнт_в в _нших банках VISA
   null;

Elsif nAlg_ =  -28 then
   /* перевод  "Юнистрим "-  макет  -28. Алгоритм : берем проводку В ВАЛ+НАЦ
      Дт 100%      Кт 2909/60 (принятые переводы)
      Дт 2809/24   Кт 100%    (выплаченые переводы)   и считаем  по  шкалам,
   */
  For k in (select p.BRANCH, o.s, o.sq, a.kv
            from opldok o, oper p, accounts a
            where o.sos=5   and o.ref=p.ref and a.acc=o.acc
              and a.kv in (840,978,643)
              and (a.nbs='2909' and a.ob22='60' and o.dk=1  OR
                   a.nbs='2809' and a.ob22='24' and o.dk=0  )
              and o.fdat>= dat1_  and o.fdat <= dat2_
            )
  loop
     s_ := 0 ;

     if k.kv = 643 then
        If    k.s < 5000000 then             S_:=  k.SQ *1/100/2;
        else                                 S_:=  k.SQ *5/1000/2;
        end if;
     elsif k.kv = 840 then
        If    k.s < 200000  then             S_:=  k.SQ *1/100/2;
        else                                 S_:=  k.SQ *5/1000/2;
        end if;
     else
        If    k.s < 120000  then             S_:=  k.SQ *1/100/2;
        else                                 S_:=  k.SQ *5/1000/2;
        end if;

     end if;

     insert into CCK_AN_TMP (branch,n1) values (k.BRANCH,s_);
  end LOOP;
-------------------------------------
ElsIf nAlg_ = -9 then
     /*  Комiсiя за переказ по СТП "Швидка копiйка"
          Алгоритм  : проводкa Дт 100%    Кт 2909/60 (принятые переводы)
                               Дт 2809/24 Кт 100%    (выплаченые переводы)
         по шкалам,
         суму делим на 2, т.к. Киев дает нам только половину. Вал - ГРН
     */
  For k in (select p.BRANCH, o.s
            from opldok o, oper p, accounts a
            where o.sos=5   and o.ref=p.ref and a.acc=o.acc
              and a.kv =980
              and (a.nbs='2909' and a.ob22='60' and o.dk=1  OR
                   a.nbs='2809' and a.ob22='24' and o.dk=0  )
              and o.fdat>= dat1_  and o.fdat <= dat2_
			  and p.tt not in ('457')
             )
  LOOP
     s_ := 0 ;
    /* If    k.s <=  10000   THEN  S_:=   300;
     elsIf k.S <=  20000   THEN  S_:=   600;
     ElsIf k.S <=  30000   THEN  S_:=   800;
     ElsIf k.S <=  40000   THEN  S_:=   900;
     ElsIf k.S <=  50000   THEN  S_:=  1000;
     ElsIf k.S <=  60000   THEN  S_:=  1200;
     ElsIf k.S <=  80000   THEN  S_:=  1600;
     ElsIf k.S <= 100000   THEN  S_:=  1700;
     ElsIf k.S <= 150000   THEN  S_:=  1800;
     ElsIf k.s <= 200000   THEN  S_:=  1900;
     ElsIf k.S <= 250000   THEN  S_:=  2000;
     else  S_ :=  2000 + 400 * Round( (k.S  - 250001)/50000 + 0.5, 0);
     end if;*/

     if    k.S <= 100000 then S_ := greatest( k.S*0.02, 1000 );
     else                     S_ := (k.S*0.01) + 1000;
     end if;

     insert into CCK_AN_TMP (branch,n1) values (k.BRANCH,s_/2);
  end LOOP;
end if;
  RETURN ;
END maket;
/
show err;

PROMPT *** Create  grants  MAKET ***
grant EXECUTE                                                                on MAKET           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MAKET           to PYOD001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MAKET.sql =========*** End *** ===
PROMPT ===================================================================================== 
