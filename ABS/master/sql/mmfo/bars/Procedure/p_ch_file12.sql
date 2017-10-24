

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILE12.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CH_FILE12 ***

  CREATE OR REPLACE PROCEDURE BARS.P_CH_FILE12 (kodf_ varchar2, dat_ date, dat1_ date, userid_ number) is

c_ number;
n_ number;
kol_ number :=0;
s3559_ number :=0;

begin

delete from otcn_log
where userid = userid_
  and kodf = kodf_;

insert into otcn_log (kodf,userid,txt)
 values(kodf_,userid_,'Перевiрка файлу  #'||kodf_ );

insert into otcn_log (kodf, userid, txt)
 values (kodf_, userid_, ' ');

select count(*) INTO kol_
from v_banks_report
where kodf=kodf_ and datf=dat_ and file_id<>0 ;

IF kol_>=0 THEN

 insert into otcn_log (kodf, userid, txt)
 values (kodf_, userid_, '   *** Звiт банку ***');

insert into otcn_log (kodf, userid, txt)
 values (kodf_, userid_, ' ');

insert into otcn_log (kodf, userid, txt)
 values (kodf_, userid_, 'Перевiрка вiдповiдностi рахункiв типу "KAS" ');

for k in ( select nls, kv, nms
           from accounts
           where tip <> 'KAS'             AND
                 nbs in ('1001','1002','1003','1004') AND
                 kv=980 and
                 (dazs is null or dazs < Dat1_) )
   loop

      n_:=1;

      insert into otcn_log (kodf,userid,txt)
      values(kodf_, userid_,
      'Счет = '||k.nls||' валюта = '|| k.kv || k.nms || ' не TIP="KAS" ' );

end loop;

for k in ( select nls, kv, nms
           from accounts
           where tip = 'KAS'             AND
                 nbs not in ('1001','1002','1003','1004') AND
                 kv=980  and
                 (dazs is null or dazs < Dat1_) )
   loop

   n_:=1;

      insert into otcn_log (kodf,userid,txt)
      values(kodf_, userid_,
      'Счет = '||k.nls||' валюта = '|| k.kv || k.nms || ' не должен быть TIP="KAS" ' );

end loop;

if n_ = 0 then
   insert into otcn_log (kodf,userid,txt)
   values(kodf_,userid_,'OK');
   insert into otcn_log (kodf, userid, txt)
   values (kodf_, userid_, ' ');
end if;
if n_ =1 then
   insert into otcn_log (kodf, userid, txt)
   values (kodf_, userid_, ' ');
end if;

n_:=0;

insert into otcn_log (kodf, userid, txt)
values (kodf_, userid_, 'Перевiрка вiдповiдностi СКП типу проводок ');

for k in (
          select pref, fdat, sk0, sk1, sk2, nlsa, kv, dk2, s, ptt, ott
          from (
                SELECT  nvl(DECODE(p.TT, o.TT, o.SK, t.SK),TO_NUMBER(SUBSTR(w.value,1,2))) sk0,
                        o.SK sk1, t.sk sk2, TO_NUMBER(SUBSTR(w.value,1,2)) sk3,
                        s.acc, s.nls, o.nlsa NLSA, o.kv KV, o.dk dk1,
                        p.FDAT FDAT, p.REF pref, p.dk dk2, p.tt ptt,
                        o.tt ott, p.s S
                FROM OPER o, OPLDOK p, ACCOUNTS s, TTS t, OPERW w
                WHERE p.acc=s.acc             AND
                      s.tip='KAS'             AND
                      s.nbs in ('1001','1002','1003','1004') AND
                      s.kv=980                AND
                      p.FDAT between Dat1_ and Dat_ and
                      o.REF=p.REF             AND
                      p.SOS=5                 AND
                      p.TT=t.TT               and
                      p.ref=w.ref(+)          and
                      w.tag(+)='SK')
          where  sk0<40 and dk2=1 or
                 sk0>=40 and dk2=0
          order by 1 )
   loop

      n_:=1;

      insert into otcn_log (kodf,userid,txt)
      values(kodf_, userid_,
      'Референс = '||k.pref||' дата = '|| k.fdat || ' сума = ' || k.s || ' помилковий СКП '|| k.sk0 );

end loop;

if n_ = 0 then
   insert into otcn_log (kodf,userid,txt)
   values(kodf_,userid_,'OK');
   insert into otcn_log (kodf, userid, txt)
   values (kodf_, userid_, ' ');
end if;

n_:=0;

insert into otcn_log (kodf, userid, txt)
values (kodf_, userid_, 'Перевiрка балансу по СКП ');

for k in (
          select NBUC, sum(iif_n(to_number(kodp),40,to_number(znap),0,0)) SP,
                 sum(iif_n(to_number(kodp),39,0,0,to_number(znap))) SR
          from tmp_nbu
          where kodf=kodf_ and datf=Dat_
          group by nbuc )
    loop
    if k.sp <> k.sr then
       n_:=1;
       insert into otcn_log (kodf,userid,txt)
       values(kodf_, userid_,
       'Код обл. = ' || k.nbuc || ' Сума надходжень = ' || k.sp ||
       ' не вiдповiдаe сумi видаткiв = '|| k.sr || ' рiзниця = ' || (k.sp-k.sr) );
    end if;

end loop;

if n_ = 0 then
   insert into otcn_log (kodf,userid,txt)
   values(kodf_,userid_,'OK');
   insert into otcn_log (kodf, userid, txt)
   values (kodf_, userid_, ' ');
end if;

END IF;

-- *** Консолiдований звiт ***
--IF kol_>=0 THEN
-- проверка баланса по символам
--   null;
--END IF;

end p_ch_file12;
 
/
show err;

PROMPT *** Create  grants  P_CH_FILE12 ***
grant EXECUTE                                                                on P_CH_FILE12     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_CH_FILE12     to RPBN002;
grant EXECUTE                                                                on P_CH_FILE12     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILE12.sql =========*** End *
PROMPT ===================================================================================== 
