

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CH_SK_INT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CH_SK_INT ***

  CREATE OR REPLACE PROCEDURE BARS.P_CH_SK_INT (kodf_ varchar2,dat_ date,dat1_ date,userid_ number) is
-- проверка допустимых символов по kl_d010
n_ number:=0;
begin
   delete from otcn_log where userid = userid_ and kodf = kodf_;

   insert into otcn_log (kodf, userid, txt)
   values (kodf_, userid_, 'Перевiрка файлу @12 за '||to_char(dat_, 'dd.mm.yyyy'));
   
   insert into otcn_log (kodf,userid,txt)
   values(kodf_,userid_,'');

   insert into otcn_log (kodf, userid, txt)
   values (kodf_, userid_, 'Перевiрка вiдповiдностi рахункiв типу "KAS" ');

   for k in ( select a.nls, a.kv, a.nms
              from accounts a, saldoa s
              where a.acc=s.acc
                AND s.fdat=Dat_
                AND a.tip <> 'KAS'
                AND a.nbs in ('1001','1002','1003','1004')
                AND a.kv=980
                AND (a.dazs is null or a.dazs > Dat1_)
                AND ((s.dos+s.kos) <> 0 or
                      s.ostf <> 0       or
                      s.ostf-s.dos+s.kos <> 0) )

      loop
         n_:=1;
         insert into otcn_log (kodf,userid,txt)
         values(kodf_, userid_,
         'Рахунок = '||k.nls||' валюта = '|| k.kv || k.nms || ' не TIP="KAS" ' );

   end loop;

   for k in ( select nls, kv, nms
              from accounts
              where tip = 'KAS'             AND
                    nbs not in ('1001','1002','1003','1004') AND
                    kv=980 and
                    (dazs is null or dazs > Dat1_) )
      loop

         n_:=1;

         insert into otcn_log (kodf,userid,txt)
         values(kodf_, userid_,
         'Рахунок = '||k.nls||' валюта = '|| k.kv || k.nms || ' не повинен бути TIP="KAS" ' );

   end loop;

   if n_ = 0 then
      insert into otcn_log (kodf,userid,txt)
      values(kodf_,userid_,'OK');
      insert into otcn_log (kodf, userid, txt)
      values (kodf_, userid_, ' ');
   end if;

   if n_ = 1 then
      insert into otcn_log (kodf, userid, txt)
      values (kodf_, userid_, ' ');
   end if;

   insert into otcn_log (kodf,userid,txt)
   values(kodf_,userid_,'Перевірка можливих значень D010');

   insert into otcn_log (kodf,userid,txt)
   values(kodf_,userid_,'');

   n_:=0;

   for k in ( select  s.acc,o.nlsa,o.nlsb, o.kv, p.fdat, p.ref,
              nvl(decode(p.tt, o.tt, o.sk, t.sk),0) sk, p.s
              from oper o, opldok p, accounts s, tts t   
              where p.acc=s.acc
			    and s.tip='KAS'
				and p.fdat between  dat1_ and  dat_
				and o.ref=p.ref
				and p.sos=5
				and decode(p.tt, o.tt, o.sk, t.sk) not in
				     (select k.d010 from kl_d010 k where k.d_close is null or k.d_close > dat_ )
				and p.tt=t.tt )
   loop
   n_:=1;
    insert into otcn_log (kodf,userid,txt)
      values(kodf_,userid_,'sk='||to_char(k.sk)||' '||
	                       'ref='||to_char(k.ref)||' '||
	                       'nlsa='||k.nlsa||' '||
						   'nlsb='||k.nlsb||' '||
						   's='||to_char(k.s));
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
         if k.sk0 not in (39, 66) then
             n_:=1;

             insert into otcn_log (kodf,userid,txt)
             values(kodf_, userid_,
             'Референс = '||k.pref||' дата = '|| k.fdat || ' сума = ' || k.s || ' помилковий СКП '||to_char(k.sk0) );
         end if;
   end loop;

   if n_ = 0 then
      insert into otcn_log (kodf,userid,txt)
      values(kodf_,userid_,'OK');
   end if;

   if n_ =1 then
      insert into otcn_log (kodf, userid, txt)
      values (kodf_, userid_, ' ');
   end if;

   n_:=0;

   insert into otcn_log (kodf, userid, txt)
   values (kodf_, userid_, 'Перевiрка балансу по СКП ');

   for k in (
             select NBUC, sum(iif_n(to_number(kodp),40,to_number(znap),0,0)) SP,
                    sum(iif_n(to_number(kodp),39,0,0,to_number(znap))) SR
             from tmp_irep
             where kodf=kodf_ and datf=Dat_
             group by nbuc )
      loop
         if k.sp <> k.sr then
            n_:=1;
            insert into otcn_log (kodf,userid,txt)
            values(kodf_, userid_,
            'Код обл. = ' || k.nbuc || ' Сума надходжень = ' || k.sp ||
            ' не вiдповiдає сумi видаткiв = '|| k.sr || ' рiзниця = ' || (k.sp-k.sr) );
         end if;

   end loop;

   if n_ = 0 then
      insert into otcn_log (kodf,userid,txt)
      values(kodf_,userid_,'OK');
      insert into otcn_log (kodf, userid, txt)
      values (kodf_, userid_, ' ');
   end if;

end p_ch_sk_int;
/
show err;

PROMPT *** Create  grants  P_CH_SK_INT ***
grant EXECUTE                                                                on P_CH_SK_INT     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CH_SK_INT.sql =========*** End *
PROMPT ===================================================================================== 
