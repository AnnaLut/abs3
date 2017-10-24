

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILE13.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CH_FILE13 ***

  CREATE OR REPLACE PROCEDURE BARS.P_CH_FILE13 (kodf_ varchar2,dat_ date,userid_ number) is

c_ number;
kol_ number :=0;
s3559_ number :=0;

begin

delete from otcn_log
where userid = userid_
  and kodf = kodf_;

insert into otcn_log (kodf,userid,txt)
 values(kodf_,userid_,'Перевiрка файлу  #'||kodf_ || ' iз файлом #02 ');

insert into otcn_log (kodf, userid, txt)
 values (kodf_, userid_, ' ');

select count(*) INTO kol_
from v_banks_report
where kodf=kodf_ and datf=dat_ and file_id<>0 ;

--IF kol_=0 THEN

-- перевiрка сум оборотiв по б/р 2620,2622,2630,2635 в #02 i сум символiв
-- касового плану по Дт (16,84-88) по Кт (55,94,95)

 insert into otcn_log (kodf, userid, txt)
 values (kodf_, userid_, '   *** Звiт банку ***');

insert into otcn_log (kodf, userid, txt)
 values (kodf_, userid_, ' ');

for k in
(
 select t.nbuc ko, substr(t.nls,1,4) nbs, nvl(sum(to_number(t.znap)),0) s1
 from rnbu_trace t
 where t.kodp in ('16','84','85','86','87','88')
 group by t.nbuc, substr(t.nls,1,4) )

   loop

   BEGIN
      select sum(nvl(to_number(znap),0)) into c_
      from tmp_nbu
      where kodf='02'
        and datf=dat_
        and substr(kodp,3,4)=k.nbs
        and substr(kodp,1,2)='60'
        and substr(kodp,7,3)='980'
        and trim(nbuc)=trim(k.ko);

       insert into otcn_log (kodf,userid,txt)
       values(kodf_, userid_,
       'Код обл.='||k.ko||' Б/р '|| k.nbs ||' сума символiв 16,84-88 = '||to_char(k.s1)||
       ' Кт оборот #02 = '||to_char(c_)||' Рiзниця = '||to_char(c_-k.s1) );
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
      insert into otcn_log (kodf,userid,txt)
      values(kodf_,userid_,
      'Код обл.='||k.ko||' Помилка !!! Вiдсутнiй Дт оборот в файлi #02  по NBS='||k.nbs);
   END;

end loop;

insert into otcn_log (kodf, userid, txt)
 values (kodf_, userid_, ' ');

for k in
(
 select t.nbuc ko, substr(t.nls,1,4) nbs, nvl(sum(to_number(t.znap)),0) s1
 from rnbu_trace t
 where t.kodp in ('55','94','95')
 group by t.nbuc, substr(t.nls,1,4) )

   loop

   BEGIN
      select sum(nvl(to_number(znap),0)) into c_
      from tmp_nbu
      where kodf='02'
        and datf=dat_
        and substr(kodp,3,4)=k.nbs
        and substr(kodp,1,2)='50'
        and substr(kodp,7,3)='980'
        and trim(nbuc)=trim(k.ko);

       insert into otcn_log (kodf,userid,txt)
       values(kodf_, userid_,
       'Код обл.='||k.ko||' Б/р '|| k.nbs ||' сума символiв 55,94,95 = '||to_char(k.s1)||
       ' Дт оборот #02 = '||to_char(c_)||' Рiзниця = '||to_char(c_-k.s1) );
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
      insert into otcn_log (kodf,userid,txt)
      values(kodf_,userid_,
      'Код обл.='||k.ko||' Помилка !!! Вiдсутнiй Дт оборот в файлi #02  по NBS='||k.nbs);
   END;

end loop;

-- insert into otcn_log (kodf,userid,txt)
--  values(kodf_,userid_,'');
-- insert into otcn_log (kodf,userid,txt)
--  values(kodf_,userid_,k.txt1||to_char(k.s1));
-- insert into otcn_log (kodf,userid,txt)
--  values(kodf_,userid_,k.txt2||to_char(k.s2));

-- if k.s1-k.s2 = 0 then
--   insert into otcn_log (kodf,userid,txt)
--    values(kodf_,userid_,'ОК');
-- else
--   insert into otcn_log (kodf,userid,txt)
--    values(kodf_,userid_,'Помилка !!! В_дхилення = '||to_char(abs(k.s1-k.s2)));

-- end if;

--end loop;

--END IF;

-- *** Консолiдований звiт ***
IF kol_<>0 THEN
   null;
END IF;

end p_ch_file13;
 
/
show err;

PROMPT *** Create  grants  P_CH_FILE13 ***
grant EXECUTE                                                                on P_CH_FILE13     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_CH_FILE13     to RPBN002;
grant EXECUTE                                                                on P_CH_FILE13     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILE13.sql =========*** End *
PROMPT ===================================================================================== 
