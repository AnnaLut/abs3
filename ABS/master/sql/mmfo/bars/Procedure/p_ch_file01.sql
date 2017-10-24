

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILE01.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CH_FILE01 ***

  CREATE OR REPLACE PROCEDURE BARS.P_CH_FILE01 (kodf_ varchar2,dat_ date,userid_ number) is

c_ number;
kol_ number :=0;
s3559_ number :=0;

begin

delete from otcn_log
where userid = userid_
  and kodf = kodf_;

insert into otcn_log (kodf,userid,txt)
 values(kodf_,userid_,'Перевiрка файлу  #'||kodf_);

select count(*) INTO kol_
from v_banks_report
where kodf=kodf_ and datf=dat_ and file_id<>0 ;

IF kol_=0 THEN
-- перевiрка на вiдсутнiсть еквiвалента для валютних бал.рах.
insert into otcn_log (kodf,userid,txt)
 values(kodf_,userid_,'   *** Звiт банку ***');

for k in
(
 select substr(t.kodp,1,2) dk, substr(t.kodp,3,4) nbs,
        substr(t.kodp,7,3) kv, nvl(to_number(t.znap),0) s1,
        substr(t.kodp,10,1) k030, t.nbuc ko
 from tmp_nbu t
 where t.KODF=kodf_
   and t.DATF=dat_
   and substr(t.kodp,1,2) in ('11','21','51','61','71','81'))

   loop

   BEGIN
      select nvl(to_number(znap),0) into c_
      from tmp_nbu
      where kodf=kodf_
        and datf=dat_
        and substr(kodp,3,4)=k.nbs
        and substr(kodp,7,3)=k.kv
        and substr(kodp,1,2)=to_char(to_number(k.dk)-1)
        and substr(kodp,10,1)=k.k030
        and nbuc=k.ko;
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
      insert into otcn_log (kodf,userid,txt)
      values(kodf_,userid_,
      'Помилка !!! Вiдсутнiй еквiвалент для NBS='||k.nbs||' KV='||k.kv);
   END;

end loop;


for k in
(
 select nvl(t1.s1,0) s1, t3.txt1 ,nvl(t2.s2,0) s2, t3.txt2
 from
  ( select decode(substr(t.kodp,1,6),'103800',1,'107080',2,'103801',3,
           '103900',4,'103902',5,'103904',6,'101811',7,8) id,
     nvl(sum(to_number(znap)),0) s1
     from tmp_nbu t
     where t.KODF=kodf_
       and t.DATF=dat_
	   and substr(kodp,1,6) in ('103800','107080','103801','103900',
	                            '103902','103904','101811')
     group by decode(substr(t.kodp,1,6),'103800',1,'107080',2,'103801',3,
                                        '103900',4,'103902',5,'103904',6,
                                        '101811',7,8)
  	  ) t1,
  ( select decode(substr(t.kodp,1,6),'203801',1,'206080',2,'203800',3,
            '203901',4,'203903',5,'203905',6,'201911',7,8) id,
     nvl(sum(to_number(znap)),0) s2
     from tmp_nbu t
     where t.KODF=kodf_
       and t.DATF=dat_
	   and substr(kodp,1,6) in ('203801','206080','203800','203901',
	                            '203903','203905','201911')
     group by decode(substr(t.kodp,1,6),'203801',1,'206080',2,'203800',3,
                                        '203901',4,'203903',5,'203905',6,
                                        '201911',7,8)
    	  ) t2,
  ( select 1 id,'<А 3800> = ' txt1,'<П 3801> = ' txt2
    from dual
	union
	select 2 id,'<А 7080> = ' txt1,'<П 6080> = ' txt2
    from dual
	union
	select 3 id,'<А 3801> = ' txt1,'<П 3800> = ' txt2
    from dual
	union
	select 4 id,'<А 3900> = ' txt1,'<П 3901> = ' txt2
    from dual
	union
	select 5 id,'<А 3902> = ' txt1,'<П 3903> = ' txt2
    from dual
	union
	select 6 id,'<А 3904> = ' txt1,'<П 3905> = ' txt2
    from dual
	union
	select 7 id,'<А 1811> = ' txt1,'<П 1911> = ' txt2
    from dual	) t3
 where t3.id = t1.id(+)
   and t3.id = t2.id(+)
) loop

 insert into otcn_log (kodf,userid,txt)
  values(kodf_,userid_,'');
 insert into otcn_log (kodf,userid,txt)
  values(kodf_,userid_,k.txt1||to_char(k.s1));
 insert into otcn_log (kodf,userid,txt)
  values(kodf_,userid_,k.txt2||to_char(k.s2));

 if k.s1-k.s2 = 0 then
   insert into otcn_log (kodf,userid,txt)
    values(kodf_,userid_,'ОК');
 else
   insert into otcn_log (kodf,userid,txt)
    values(kodf_,userid_,'Помилка !!! В_дхилення = '||to_char(abs(k.s1-k.s2)));

 end if;

end loop;

END IF;

-- *** Консолiдований звiт ***
IF kol_<>0 THEN

-- перевiрка на вiдсутнiсть еквiвалента для валютних бал.рах.
insert into otcn_log (kodf,userid,txt)
 values(kodf_,userid_,' ');

insert into otcn_log (kodf,userid,txt)
 values(kodf_,userid_,'   *** Консолiдований звiт ***');

for k in
(
 select substr(kodp,1,2) dk, substr(kodp,3,4) nbs,
        substr(kodp,7,3) kv,
        substr(kodp,10,1) k030,
        nbuc ko,
        nvl(SUM(to_number(znap)),0) s1
 from v_banks_report
 where KODF=kodf_
   and DATF=dat_
   and substr(kodp,1,2) in ('11','21','51','61','71','81')
 group by substr(kodp,1,2), substr(kodp,3,4), substr(kodp,7,3),
        substr(kodp,10,1), nbuc )

   loop

   BEGIN
      select nvl(sum(to_number(znap)),0) into c_
      from v_banks_report
      where kodf=kodf_
        and datf=dat_
        and substr(kodp,3,4)=k.nbs
        and substr(kodp,7,3)=k.kv
        and substr(kodp,1,2)=to_char(to_number(k.dk)-1)
        and substr(kodp,10,1)=k.k030
        and nbuc=k.ko;
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
      insert into otcn_log (kodf,userid,txt)
      values(kodf_,userid_,
      'Помилка !!! Вiдсутнiй еквiвалент для KODOBL='||k.ko||' NBS='||k.nbs||' KV='||k.kv);
   END;

end loop;

-- перевiрки на рiвнiсть залишкiв по бал. рахунках
for k in
(
 select nvl(t1.s1,0) s1, t3.txt1 ,nvl(t2.s2,0) s2, t3.txt2
 from
  (
     select decode(substr(t.kodp,1,6),
           '101005',1,'101811',2,'103800',3,'103801',4,'103900',5,'103902',6,
           '103904',7,'107080',8,'107180',9,'107380',10,'107480',11,
           '109781',12,'103928',13,14) id,
     nvl(sum(to_number(znap)),0) s1
     from v_banks_report t
     where t.KODF=kodf_
       and t.DATF=dat_
       and substr(kodp,1,6) in ('101005','101811','103800','103801','103900',
                                '103902','103904','107080','107180','107380',
                                '107480','109781','103928')
     group by decode(substr(t.kodp,1,6),
             '101005',1,'101811',2,'103800',3,'103801',4,'103900',5,'103902',6,
             '103904',7,'107080',8,'107180',9,'107380',10,'107480',11,
             '109781',12,'103928',13,14) ) t1,
  (  select decode(substr(t.kodp,1,6),
           '202560',1,'201911',2,'203801',3,'203800',4,'203901',5,'203903',6,
           '203905',7,'206080',8,'206180',9,'206380',10,'206480',11,
           '202601',12,'203929',13,14) id,
     nvl(sum(to_number(znap)),0) s2
     from v_banks_report t
     where t.KODF=kodf_
       and t.DATF=dat_
       and substr(kodp,1,6) in ('202560','201911','203801','203800','203901',
                                '203903','203905','206080','206180','206380',
                                '206480','202601','203929')
     group by decode(substr(t.kodp,1,6),
             '202560',1,'201911',2,'203801',3,'203800',4,'203901',5,'203903',6,
             '203905',7,'206080',8,'206180',9,'206380',10,'206480',11,
             '202601',12,'203929',13,14) ) t2,

  ( select 1 id,'<А 1005> = ' txt1,'<П 2560> = ' txt2
    from dual
    UNION
    select 2 id,'<А 1811> = ' txt1,'<П 1911> = ' txt2
    from dual
    UNION
    select 3 id,'<А 3800> = ' txt1,'<П 3801> = ' txt2
    from dual
    UNION
    select 4 id,'<А 3801> = ' txt1,'<П 3800> = ' txt2
    from dual
    UNION
    select 5 id,'<А 3900> = ' txt1,'<П 3901> = ' txt2
    from dual
    UNION
    select 6 id,'<А 3902> = ' txt1,'<П 3903> = ' txt2
    from dual
    UNION
    select 7 id,'<А 3904> = ' txt1,'<П 3905> = ' txt2
    from dual
    UNION
    select 8 id,'<А 7080> = ' txt1,'<П 6080> = ' txt2
    from dual
    UNION
    select 9 id,'<А 7180> = ' txt1,'<П 6180> = ' txt2
    from dual
    UNION
    select 10 id,'<А 7380> = ' txt1,'<П 6380> = ' txt2
    from dual
    UNION
    select 11 id,'<А 7480> = ' txt1,'<П 6480> = ' txt2
    from dual
    UNION
    select 12 id,'<А 9781> = ' txt1,'<П 2601> = ' txt2
    from dual
    UNION
    select 13 id,'<А 3928> = ' txt1,'<П 3929> = ' txt2
    from dual
    ) t3
    where t3.id = t1.id(+)
      and t3.id = t2.id(+)
) loop

 insert into otcn_log (kodf,userid,txt)
  values(kodf_,userid_,'');
 insert into otcn_log (kodf,userid,txt)
  values(kodf_,userid_,k.txt1||to_char(k.s1));
 insert into otcn_log (kodf,userid,txt)
  values(kodf_,userid_,k.txt2||to_char(k.s2));

 if k.s1-k.s2 = 0 then
   insert into otcn_log (kodf,userid,txt)
    values(kodf_,userid_,'ОК');
 else
   insert into otcn_log (kodf,userid,txt)
    values(kodf_,userid_,'Помилка !!! В_дхилення = '||to_char(abs(k.s1-k.s2)));
 end if;

end loop;

--группы 978,979
for k in
(
 select nvl(t1.s1,0) s1, t3.txt1 ,nvl(t2.s2,0) s2, t3.txt2
 from
  (
     select decode(substr(t.kodp,1,5),
           '10978',1,2) id,
     nvl(sum(to_number(znap)),0) s1
     from v_banks_report t
     where t.KODF=kodf_
       and t.DATF=dat_
       and substr(kodp,1,5) in ('10978')
     group by decode(substr(t.kodp,1,5),
              '10978',1,2) ) t1,
  (  select decode(substr(t.kodp,1,5),
            '20979',1,2) id,
     nvl(sum(to_number(znap)),0) s2
     from v_banks_report t
     where t.KODF=kodf_
       and t.DATF=dat_
       and substr(kodp,1,5) in ('20979')
     group by decode(substr(t.kodp,1,5),
              '20979',1,2) ) t2,

  ( select 1 id,'<А 978> = ' txt1,'<П 979> = ' txt2
    from dual
    ) t3
    where t3.id = t1.id(+)
      and t3.id = t2.id(+)
) loop

 insert into otcn_log (kodf,userid,txt)
  values(kodf_,userid_,'');
 insert into otcn_log (kodf,userid,txt)
  values(kodf_,userid_,k.txt1||to_char(k.s1));
 insert into otcn_log (kodf,userid,txt)
  values(kodf_,userid_,k.txt2||to_char(k.s2));

 if k.s1-k.s2 = 0 then
   insert into otcn_log (kodf,userid,txt)
    values(kodf_,userid_,'ОК');
 else
   insert into otcn_log (kodf,userid,txt)
    values(kodf_,userid_,'Помилка !!! В_дхилення = '||to_char(abs(k.s1-k.s2)));

 end if;

end loop;

   select nvl(sum(to_number(t.znap)),0)
   INTO s3559_
   from v_banks_report t
   where t.KODF=kodf_
     and t.DATF=dat_
     and substr(t.kodp,3,4)='3559';

    insert into otcn_log (kodf,userid,txt)
     values(kodf_,userid_,'');
    insert into otcn_log (kodf,userid,txt)
     values(kodf_,userid_,'<А 3559> = '||to_char(s3559_));

   if s3559_ = 0 then
      insert into otcn_log (kodf,userid,txt)
       values(kodf_,userid_,'ОК');
   end if;
   if s3559_ <> 0 then
      insert into otcn_log (kodf,userid,txt)
       values(kodf_,userid_,'Помилка !!! В_дхилення = '||to_char(abs(s3559_)));
   end if;
END IF;

end p_ch_file01;
 
/
show err;

PROMPT *** Create  grants  P_CH_FILE01 ***
grant EXECUTE                                                                on P_CH_FILE01     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILE01.sql =========*** End *
PROMPT ===================================================================================== 
