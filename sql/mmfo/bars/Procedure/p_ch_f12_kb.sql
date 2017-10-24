

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CH_F12_KB.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CH_F12_KB ***

  CREATE OR REPLACE PROCEDURE BARS.P_CH_F12_KB (kodf_ varchar2,dat1_ date,dat_ date,userid_ number) is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   : p_ch_sk_int
% DESCRIPTION : Отчетность СберБанка: проверки по файлу @12
% COPYRIGHT   : Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     : 12/12/2011
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    s1007_b  Number;
    s1007_e  Number;
    s_01     Number;
    s_37     Number := 0;
    s_72     Number := 0;
    s_39     Number := 0;
    s_66     Number := 0;
    s_16     Number;
    s_17     Number;
    s_05     Number;
    f_57     Number;
    s_57d    Number;
    s_57k    Number;
    s_70     Number;
    nbs_     Varchar2(4);
begin
   insert into otcn_log (kodf,userid,txt)
    values(kodf_,userid_,'Перевiрка файлу #12 (символiв 39 и 66)');

   select nvl(sum(ABS(ost+dos-kos)),0)
      into s1007_b
   from sal
   where nbs='1007'
     and kv=980
     and fdat=Dat1_;

   select nvl(sum(ABS(ost)),0)
      into s1007_e
   from sal
   where nbs='1007'
     and kv=980
     and fdat=Dat_;

   select NVL(sum(decode(kodp,'39',to_number(znap),0)),0),
          NVL(sum(decode(kodp,'66',to_number(znap),0)),0),
          NVL(sum(decode(kodp,'37',to_number(znap),0)),0),
          NVL(sum(decode(kodp,'72',to_number(znap),0)),0)
      into s_39, s_66, s_37, s_72
   from tmp_nbu
   where KODF=kodf_
     and DATF=dat_
     and kodp in ('37','39','66','72');

   insert into otcn_log (kodf,userid,txt)
    values(kodf_,userid_,'');

   insert into otcn_log (kodf,userid,txt)
    values(kodf_,userid_,'Остаток 1007 вихiдний '||to_char(Abs(s1007_e))||
    ' + сим. 39 '||to_char(s_39)||' - 1007 вхiдний '||
    to_char(Abs(s1007_b))||' =  сим. 66 '||to_char(s_66));

   if s_39+s1007_e-s1007_b <> s_66 THEN
      insert into otcn_log (kodf,userid,txt)
       values(kodf_,userid_,'Вiдхилення = '||to_char(s_39+s1007_e-s1007_b-s_66));

      for k in (select /*+ NO_MERGE(a) */
                       a.ref, a.fdat, a.nlsd, a.nlsk, a.s*100 s,
                       substr(a.nazn,1,100), r.kodp sk
                from provodki a, rnbu_trace r
                where a.fdat between Dat1_ and Dat_
                  and a.kv=980
                  and substr(a.nlsd,1,4) in ('1001','1002','1003','1004','1007')
                  and substr(a.nlsk,1,4) in ('1001','1002','1003','1004','1007')
                  and to_number(r.kodp) not in (39,66)
                  and a.ref = r.ref)

      loop
          insert into otcn_log (kodf,userid,txt)
          values
          (kodf_,userid_,'Референс = '||to_char(k.ref)||
                         ' СК = '||to_char(k.sk)||
                         ' Дт= '||k.nlsd||
                         ' Кт= '||k.nlsk||' сума ='||to_char(k.s/100,'9999999990D00'));
      end loop;

      for k in (select /*+ NO_MERGE(a) */
                       a.ref, a.fdat, a.nlsd, a.nlsk, a.s*100 s,
                       substr(a.nazn,1,100), r.kodp sk
                from provodki a, rnbu_trace r
                where a.fdat between Dat1_ and Dat_
                  and a.kv=980
                  and a.nlsd like '100%'
                  and substr(a.nlsk,1,4) not in ('1001','1002','1003','1004','1007')
                  and r.kodp in ('39','66')
                  and a.ref = r.ref
                UNION
                select /*+ NO_MERGE(a) */
                       a.ref, a.fdat, a.nlsd, a.nlsk, a.s*100 s,
                       substr(a.nazn,1,100), r.kodp sk
                from provodki a, rnbu_trace r
                where a.fdat between Dat1_ and Dat_
                  and a.kv=980
                  and a.nlsk like '100%'
                  and substr(a.nlsd,1,4) not in ('1001','1002','1003','1004','1007')
                  and r.kodp in ('39','66')
                  and a.ref = r.ref)

      loop
          insert into otcn_log (kodf,userid,txt)
          values
          (kodf_,userid_,'Референс = '||to_char(k.ref)||
                         ' СК = '||to_char(k.sk)||
                         ' Дт= '||k.nlsd||
                         ' Кт= '||k.nlsk||
                         ' сума ='||to_char(k.s/100,'9999999990D00'));

      end loop;

      for k in (select /*+ NO_MERGE(a) */
                      a.ref, a.fdat, a.nlsd, a.nlsk, a.s*100 s,
                      substr(a.nazn,1,100), b.sk
                from provodki a, oper b
                where a.fdat between Dat1_ and Dat_
                  and a.kv=980
                  and a.nlsd like '1007%'
                  and substr(a.nlsk,1,4) not in ('1001','1002','1003','1004')
                  and a.ref=b.ref
                UNION
                select /*+ NO_MERGE(a) */
                       a.ref, a.fdat, a.nlsd, a.nlsk, a.s*100 s,
                       substr(a.nazn,1,100), b.sk
                from provodki a, oper b
                where a.fdat between Dat1_ and Dat_
                  and a.kv=980
                  and a.nlsk like '1007%'
                  and substr(a.nlsd,1,4) not in ('1001','1002','1003','1004')
                  and a.ref=b.ref )
      loop
          insert into otcn_log (kodf,userid,txt)
          values
          (kodf_,userid_,'Референс = '||to_char(k.ref)||
                         ' СК = '||to_char(k.sk)||
                         ' Дт= '||k.nlsd||
                         ' Кт= '||k.nlsk||
                         ' сума ='||to_char(k.s/100,'9999999990D00'));
      end loop;
   else
      insert into otcn_log (kodf,userid,txt)
       values(kodf_,userid_,'ОК ');
   end if;

   s_39 := 0;
   f_57 := 0;
   insert into otcn_log (kodf,userid,txt)
   values(kodf_,userid_,'Перевiрка файлу #12 (символiв 37 i 72)');

   for k in (select a.ref, a.fdat, a.nlsd, a.nlsk, a.s*100 s,
                    substr(a.nazn,1,100), b.sk, '37' sk_p
             from provodki a, oper b
             where a.fdat between Dat1_ and Dat_
               and a.kv=980
               and substr(a.nlsd,1,4) in ('1001','1002','1003','1004')
               and substr(a.nlsk,1,4) in ('1811','1911','3906','3907')
               and a.ref=b.ref and b.sk not in (37)
             UNION
             select a.ref, a.fdat, a.nlsd, a.nlsk, a.s*100 s,
                    substr(a.nazn,1,100), b.sk, '72' sk_p
             from provodki a, oper b
             where a.fdat between Dat1_ and Dat_
               and a.kv=980
               and substr(a.nlsd,1,4) in ('1811','1911','3906','3907')
               and substr(a.nlsk,1,4) in ('1001','1002','1003','1004')
               and a.ref=b.ref and b.sk not in (72) )

        loop

           insert into otcn_log (kodf,userid,txt)
           values
           (kodf_,userid_,'Референс = '||to_char(k.ref)||
                          ' СК = '||to_char(k.sk)||' ('||k.sk_p||'?) '||
                          ' Дт= '||k.nlsd||
                          ' Кт= '||k.nlsk||' сума ='||to_char(k.s/100,'9999999990D00'));

           s_39 := s_39 +1;
   end loop;

   if s_39 = 0 then
      insert into otcn_log (kodf,userid,txt)
      values(kodf_,userid_,'ОК ');
   end if;

   s_16 := 0;

   insert into otcn_log (kodf,userid,txt)
   values(kodf_,userid_,'');
   insert into otcn_log (kodf,userid,txt)
   values(kodf_,userid_,'Перевiрка файлу #12 (символiв 16 i 55)');

   for k in (select a.ref, a.fdat, a.nlsd, a.nlsk, a.s*100 s,
                    substr(a.nazn,1,100), b.sk, '16' sk_p, substr(a.nazn,1,80) nazn
             from provodki a, oper b
             where a.fdat between Dat1_ and Dat_
               and a.kv=980
               and substr(a.nlsd,1,4) in ('1001','1002','1003','1004')
               and substr(a.nlsk,1,4) in ('2620','2622','2630','2635')
               and a.ref=b.ref and b.sk not in (16)
             UNION
             select a.ref, a.fdat, a.nlsd, a.nlsk, a.s*100 s,
                    substr(a.nazn,1,100), b.sk, '55' sk_p, substr(a.nazn,1,80) nazn
             from provodki a, oper b
             where a.fdat between Dat1_ and Dat_
               and a.kv=980
               and substr(a.nlsd,1,4) in ('2620','2622','2628','2630','2635','2638')
               and substr(a.nlsk,1,4) in ('1001','1002','1003','1004')
               and a.ref=b.ref and b.sk not in (55)
             UNION
             select a.ref, a.fdat, a.nlsd, a.nlsk, a.s*100 s,
                    substr(a.nazn,1,100), b.sk, '55' sk_p, substr(a.nazn,1,80) nazn
             from provodki a, oper b
             where a.fdat between Dat1_ and Dat_
               and a.kv=980
               and a.nlsd LIKE '2809%'
               and exists (select 1
                           from specparam_int
                           where acc=a.accd
                             and ob22='09')
               and substr(a.nlsk,1,4) in ('1001','1002')
               and a.ref=b.ref and b.sk not in (55)  )

        loop
           insert into otcn_log (kodf,userid,txt)
           values
           (kodf_,userid_,'Референс = '||to_char(k.ref)||
                          ' СК = '||to_char(k.sk)||' ('||k.sk_p||'?) '||
                          ' Дт= '||k.nlsd||
                          ' Кт= '||k.nlsk||' сума ='||to_char(k.s/100,'9999999990D00')||' '||k.nazn);

           s_16 := s_16 +1;
   end loop;

   if s_16 = 0 then
      insert into otcn_log (kodf,userid,txt)
      values(kodf_,userid_,'ОК ');
   end if;

   s_17 := 0;
   insert into otcn_log (kodf,userid,txt)
   values(kodf_,userid_,'');
   insert into otcn_log (kodf,userid,txt)
   values(kodf_,userid_,'Перевiрка файлу #12 (символiв 17 i 59)');

   for k in (select a.ref, a.fdat, a.nlsd, a.nlsk, a.s*100 s,
                    substr(a.nazn,1,100), b.sk, '17' sk_p, substr(a.nazn,1,80) nazn
             from provodki a, oper b
             where a.fdat between Dat1_ and Dat_
               and a.kv=980
               and substr(a.nlsd,1,4) in ('1001','1002')
               and (a.nlsk like '2600____2121%' or a.nlsk like '2604____2121%')
               and a.ref=b.ref and b.sk not in (17)
             UNION
             select a.ref, a.fdat, a.nlsd, a.nlsk, a.s*100 s,
                    substr(a.nazn,1,100), b.sk, '59' sk_p, substr(a.nazn,1,80) nazn
             from provodki a, oper b
             where a.fdat between Dat1_ and Dat_
               and a.kv=980
               and (a.nlsd like '2604____2121%')
               and substr(a.nlsk,1,4) in ('1001','1002')
               and a.ref=b.ref and b.sk not in (59) )

        loop
           insert into otcn_log (kodf,userid,txt)
           values
           (kodf_,userid_,'Референс = '||to_char(k.ref)||
                          ' СК = '||to_char(k.sk)||' ('||k.sk_p||'?) '||
                          ' Дт= '||k.nlsd||
                          ' Кт= '||k.nlsk||' сума ='||to_char(k.s/100,'9999999990D00')||' '||k.nazn);

           s_17 := s_17 +1;
   end loop;

   if s_17 = 0 then
      insert into otcn_log (kodf,userid,txt)
      values(kodf_,userid_,'ОК ');
   end if;


   s_05 := 0;
   insert into otcn_log (kodf,userid,txt)
   values(kodf_,userid_,'');
   insert into otcn_log (kodf,userid,txt)
   values(kodf_,userid_,'Перевiрка файлу #12 (символiв 05, 12, 29, 32 i 61)');

   for k in (select a.ref, a.fdat, a.nlsd, a.nlsk, a.s*100 s,
                    substr(a.nazn,1,100), b.sk, '5' sk_p, substr(a.nazn,1,80) nazn
             from provodki a, oper b
             where a.fdat between Dat1_ and Dat_
               and a.kv=980
               and substr(a.nlsd,1,4) in ('1001','1002')
               and (a.nlsk like '2905%' or
                    (a.nlsk like '2902%' and exists (select 1 from specparam_int
                                                     where acc=a.acck
                                                       and ob22='03')))
               and a.ref=b.ref
               and b.sk not in (5)
             UNION
             select a.ref, a.fdat, a.nlsd, a.nlsk, a.s*100 s,
                    substr(a.nazn,1,100), b.sk, '12' sk_p, substr(a.nazn,1,80) nazn
             from provodki a, oper b
             where a.fdat between Dat1_ and Dat_
               and a.kv=980
               and substr(a.nlsd,1,4) in ('1001','1002')
               and a.nlsk like '2902%'
               and exists (select 1
                           from specparam_int
                           where acc=a.acck
                             and ob22='01')
               and a.ref=b.ref and b.sk not in (12)
             UNION
             select a.ref, a.fdat, a.nlsd, a.nlsk, a.s*100 s,
                    substr(a.nazn,1,100), b.sk, '29' sk_p, substr(a.nazn,1,80) nazn
             from provodki a, oper b
             where a.fdat between Dat1_ and Dat_
               and a.kv=980
               and substr(a.nlsd,1,4) in ('1001','1002')
               and substr(a.nlsk,1,4) in ('2625','2924')
               and a.ref=b.ref and b.sk not in (29)
             UNION
             select a.ref, a.fdat, a.nlsd, a.nlsk, a.s*100 s,
                    substr(a.nazn,1,100), b.sk, '32' sk_p, substr(a.nazn,1,80) nazn
             from provodki a, oper b
             where a.fdat between Dat1_ and Dat_
               and a.kv=980
               and substr(a.nlsd,1,4) in ('1001','1002')
               and a.nlsk like '2902%'
               and exists (select 1
                           from specparam_int
                           where acc=a.acck
                             and ob22='02')
               and a.ref=b.ref and b.sk not in (32)
             UNION
             select a.ref, a.fdat, a.nlsd, a.nlsk, a.s*100 s,
                    substr(a.nazn,1,100), b.sk, '61' sk_p, substr(a.nazn,1,80) nazn
             from provodki a, oper b
             where a.fdat between Dat1_ and Dat_
               and a.kv=980
               and substr(a.nlsd,1,4) in ('2805','2905')
               and substr(a.nlsk,1,4) in ('1001','1002')
               and a.ref=b.ref and b.sk not in (61) )

        loop
           insert into otcn_log (kodf,userid,txt)
           values
           (kodf_,userid_,'Референс = '||to_char(k.ref)||
                          ' СК = '||to_char(k.sk)||' ('||k.sk_p||'?) '||
                          ' Дт= '||k.nlsd||
                          ' Кт= '||k.nlsk||' сума ='||to_char(k.s/100,'9999999990D00')||' '||k.nazn);

           s_05 := s_05 +1;
   end loop;

   if s_05 = 0 then
      insert into otcn_log (kodf,userid,txt)
      values(kodf_,userid_,'ОК ');
   end if;

   insert into otcn_log (kodf,userid,txt)
   values(kodf_,userid_,'');
   insert into otcn_log (kodf,userid,txt)
   values(kodf_,userid_,'Перевiрка символу 70 ф.#12  i залишкiв бал.рах. 1001,1002,1003,1004 вал.980 ф.#01 ');

   select nvl(sum(to_number(znap)),0)
      into s_70
   from tmp_nbu
   where KODF=kodf_
     and DATF=dat_
     and kodp='70';

   select count(*)
       into f_57
   from tmp_nbu
   where kodf='01'
     and datf=dat_;

   if f_57 = 0 then
      insert into otcn_log (kodf,userid,txt)
      values(kodf_,userid_,'Файл #01 за звiтну дату не сформований !!! ');
   else
      select SUM(DECODE(substr(kodp,1,2),'10',to_number(znap),0))
         into s_01
      from tmp_nbu
      where kodf='01'
        and datf=dat_
        and substr(kodp,3,4) in ('1001','1002','1003','1004')
        and substr(kodp,7,3)='980';
   end if;

   if s_70 != 0 then
      if s_70 != s_01 then
         insert into otcn_log (kodf,userid,txt)
         values(kodf_,userid_,
               'Символ 70 <> Дт залишкам 1001,1002,1003,1004 @57 Рiзниця = '||to_char(s_70-s_01));
      else
         insert into otcn_log (kodf,userid,txt)
         values(kodf_,userid_,'Символ 70 i Дт залишки 1001,1002,1003,1004 вал.980 - ОК ');
      end if;
   end if;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CH_F12_KB.sql =========*** End *
PROMPT ===================================================================================== 
