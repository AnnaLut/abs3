

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILE4A.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CH_FILE4A ***

  CREATE OR REPLACE PROCEDURE BARS.P_CH_FILE4A (kodf_      VARCHAR2,
                                         dat_       DATE,
                                         userid_    NUMBER)
   --  AUTHOR: AlexY
   -- VERSION: 25/03/2013
IS
   kol_       NUMBER := 0;
   pr1_       number := 0;
   pr2_       number := 0;
   p_datzv    date := add_months(trunc(dat_, 'mm'),1);
   p_lpmd     date := lastd_prev_month(dat_);
BEGIN
   DELETE FROM otcn_log
         WHERE userid = userid_ AND kodf = kodf_;

   INSERT INTO otcn_log (kodf, userid, txt)
        VALUES (kodf_, userid_, 'Перевiрка файлу  #' || kodf_ ||' за '|| to_char(dat_,'dd.mm.yyyy')||'р.');

   INSERT INTO otcn_log (kodf, userid, txt)
        VALUES (kodf_, userid_, ' ');

   SELECT COUNT (*)
     INTO kol_
     FROM v_banks_report
    WHERE kodf = kodf_ AND datf = dat_;

IF kol_ >= 0 THEN

      INSERT INTO otcn_log (kodf, userid, txt) VALUES (kodf_, userid_, ' Перевірка значень показників "усього" та "у тому числі"');
      INSERT INTO otcn_log (kodf, userid, txt) VALUES (kodf_, userid_, '---------------------------------------------');

  for t in(
         select *
           from (select substr(kodp, 3, 6) k,
                        sum(decode(substr(kodp, 1, 2), '03', znap, 0)) s03,
                        sum(decode(substr(kodp, 1, 2), '15', znap, 0)) s15,
                        sum(decode(substr(kodp, 1, 2), '16', znap, 0)) s16
                   from (select kodp, znap
                           from tmp_nbu
                          where kodf = kodf_
                            and datf = dat_)
                  group by substr(kodp, 3, 6))
          where s03 < s15 + s16)
     loop
        pr1_:=1;
        INSERT INTO otcn_log (kodf, userid, txt) VALUES (kodf_, userid_,'EK_POK= 03'||t.k||' '||to_char(nvl(t.s03,0))||'(усього) не може бути менше '||to_char(nvl(t.s15+t.s16,0))||'(у т.ч.)');
     end loop;
  for t in(
         select *
           from (select substr(kodp, 3, 6) k,
                        sum(decode(substr(kodp, 1, 2), '08', znap, 0)) s08,
                        sum(decode(substr(kodp, 1, 2), '09', znap, 0)) s09
                   from (select kodp, znap
                           from tmp_nbu
                          where kodf = kodf_
                            and datf = dat_)
                  group by substr(kodp, 3, 6))
          where s08 < s09)
     loop
        pr1_:=1;
        INSERT INTO otcn_log (kodf, userid, txt) VALUES (kodf_, userid_,'EK_POK=08'||t.k||' '||to_char(nvl(t.s08,0))||'(усього) не може бути менше '||to_char(nvl(t.s09,0))||'(у т.ч.)');
     end loop;
  for t in(
         select *
           from (select substr(kodp, 3, 6) k,
                        sum(decode(substr(kodp, 1, 2), '07', znap, 0)) s07,
                        sum(decode(substr(kodp, 1, 2), '08', znap, 0)) s08,
                        sum(decode(substr(kodp, 1, 2), '10', znap, 0)) s10,
                        sum(decode(substr(kodp, 1, 2), '11', znap, 0)) s11,
                        sum(decode(substr(kodp, 1, 2), '13', znap, 0)) s13,
                        sum(decode(substr(kodp, 1, 2), '14', znap, 0)) s14
                   from (select kodp, znap
                           from tmp_nbu
                          where kodf = kodf_
                            and datf = dat_)
                  group by substr(kodp, 3, 6))
          where s07+s08+s10+s11 <> s13+s14)
     loop
        pr1_:=1;
        INSERT INTO otcn_log (kodf, userid, txt) VALUES (kodf_, userid_,'EK_POK=13'||t.k||' '||to_char(nvl(t.s07+t.s08+t.s10+t.s11,0))||'(усього) не дорівнює '||to_char(nvl(t.s13+t.s14,0))||'(у т.ч.)');
     end loop;

     if pr1_=0 then
        INSERT INTO otcn_log (kodf, userid, txt) VALUES (kodf_, userid_, 'Помилок не знайдено');
     else
	    INSERT INTO otcn_log (kodf, userid, txt) VALUES (kodf_, userid_, '---------------------------------------------');
     end if;

      INSERT INTO otcn_log (kodf, userid, txt) VALUES (kodf_, userid_, ' Перевірка обсягів безнадійної заборгованості на звітну та попередню звітну дату ');
      INSERT INTO otcn_log (kodf, userid, txt) VALUES (kodf_, userid_, '---------------------------------------------');

  for t in(
         select a.k k,
                nvl(a.s03p, 0) s03p,
                nvl(b.s03, 0) s03,
                nvl(b.s06, 0) + nvl(b.s12, 0) - nvl(b.s07, 0) - nvl(b.s08, 0) -
                nvl(b.s10, 0) - nvl(b.s11, 0) raz
           from (select substr(kodp, 3, 6) k,
                        sum(decode(substr(kodp, 1, 2), '03', znap, 0)) s03p
                   from (select kodp, znap
                           from tmp_nbu
                          where kodf = kodf_
                            and datf = p_lpmd)
                  group by substr(kodp, 3, 6)) a
           left join (select *
                        from (select substr(kodp, 3, 6) k,
                                     sum(decode(substr(kodp, 1, 2), '03', znap, 0)) s03,
                                     sum(decode(substr(kodp, 1, 2), '06', znap, 0)) s06,
                                     sum(decode(substr(kodp, 1, 2), '12', znap, 0)) s12,
                                     sum(decode(substr(kodp, 1, 2), '07', znap, 0)) s07,
                                     sum(decode(substr(kodp, 1, 2), '08', znap, 0)) s08,
                                     sum(decode(substr(kodp, 1, 2), '10', znap, 0)) s10,
                                     sum(decode(substr(kodp, 1, 2), '11', znap, 0)) s11
                                from (select kodp, znap
                                        from tmp_nbu
                                       where kodf = kodf_
                                         and datf = dat_)
                               group by substr(kodp, 3, 6))) b
             on a.k = b.k)
    loop
        if t.s03p+t.raz<>t.s03 then
           pr2_:=1;
           INSERT INTO otcn_log (kodf, userid, txt) VALUES (kodf_, userid_,'EK_POK=03'||t.k||' > передано '||to_char(nvl(t.s03,0))||', підраховано '||to_char(nvl(t.s03p+t.raz,0))||', різниця '||to_char(nvl(t.s03-(t.s03p+t.raz),0)));
        end if;
	end loop;

     if pr2_=0 then
        INSERT INTO otcn_log (kodf, userid, txt) VALUES (kodf_, userid_, 'Помилок не знайдено');
     else
	    INSERT INTO otcn_log (kodf, userid, txt) VALUES (kodf_, userid_, '---------------------------------------------');
     end if;

  END IF;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILE4A.sql =========*** End *
PROMPT ===================================================================================== 
