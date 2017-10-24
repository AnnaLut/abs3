

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_OTC_VE9.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_OTC_VE9 ***

  CREATE OR REPLACE PROCEDURE BARS.P_OTC_VE9 
    (p_DAT    DATE,         -- отчетная дата
     p_KODF   VARCHAR2      --код файла IS
     )
IS
----------------------------------------------------------
---  VERSION : 05/08/2014 (28/02/2014)    ---
----------------------------------------------------------
--   28.02.2014 изменил p_KODF = 37 на p_KODF = '37'
--              (возникала ошибка в ГОУ)
--   20.01.2014 для файлов #25, #81, #A4 по счетам тех.
--              переоценки для 9 класса будем формировать
--              только показатели по остаткам
--   08.08.2013 для файла @37 обнуляем показатель или актива
--              или пассива (Дт или Кт оборотов)
--              (ранее обнулялись все показатели по счету
--               технической переоценки)
--   03.06.2013 для файла @37 обнуляем показатель для счетов
--   тех.переоценки 9910 если нет номинала в данной валюте
--   добавили код файла 37 (@37)
--   для включения счетов тех.переоценки 9 класса
--   из предыдущего периода не формировалось поле NBUC
----------------------------------------------------------
   mfou_    varchar2(12);
   mfo_     varchar2(12);
   pr_      number;

   kodp_    varchar2(30);

   kodpN_   varchar2(30);
   znapN_   rnbu_trace.znap%type;

   accO_    rnbu_trace.acc%type;
   nlsO_    rnbu_trace.nls%type;
   kvO_     rnbu_trace.kv%type;
   odateO_  rnbu_trace.odate%type;
   kodpO_   rnbu_trace.kodp%type;
   znapO_   rnbu_trace.znap%type;
   l_nbuc   VARCHAR2(20);
   l_typ    NUMBER;
   p_SHM    VARCHAR2(1) := 'C';

   XX_      varchar2(2);
   X1_      varchar2(2);
   X8_      varchar2(9);
   poz_kv   number;

   fl_PZP   number := 0;
   datp_    date;
   fl_      number;
   fl_minus number;
   fl_not_kor   number;
 begin
   mfo_ := gl.aMfo;

   BEGIN
      SELECT NVL(trim(mfou), mfo_)  INTO mfou_  FROM BANKS   WHERE mfo = mfo_;
   EXCEPTION WHEN NO_DATA_FOUND THEN mfou_ := mfo_;
   END;

   -- по просьбе ОПЕРУ СБ для счетов тех.переоценки изменяем код валюты на 978
   -- при отсутствии номинала для данной валюты с 01.03.2008

   if mfou_ <> 300465 then
      p_SHM := 'G';
   end if;

   IF mfou_ not in (300465, 380764) OR P_DAT < to_date('01032008','ddmmyyyy') then
      RETURN;
   end if;

   -- для #?
   If p_KODF not in ('01', '02', '25', 'A4', '81', '37') THEN
      return;
   end if;

   delete from OTCN_ARCH_PEREOC where datf = p_DAT and kodf = p_KODF;

   -- попередня зв_тна дата
   if p_KODF = '37' then
      select max(fdat)
         into datp_
      from fdat
      where fdat <= p_DAT - 1;
   else
       select max(fdat)
          into datp_
       from fdat
       where fdat <= trunc(p_DAT, 'mm') - 1;
   end if;

   -- чи були коригування в попередньому пер_од_?
   select count(*)
   into fl_PZP
   from OTCN_ARCH_PEREOC
   where datf = datp_ and
         kodf = p_KODF;

    if fl_PZP > 0 then
       for k in (select ACC, NLS, KV, ODATE, KODP, ZNAP, SKOR
                 from OTCN_ARCH_PEREOC
                 where datf = datp_ and
                       kodf = p_KODF and
                       substr(kodp,1,1) in ('5', '6') and
                       nls LIKE '9%')
       loop
            if k.skor > 0 then
               kodpO_ := (case when substr(k.kodp,1,1) = '5' then '6' else '5' end ) || substr(k.kodp,2);
            else
               kodpO_ := k.kodp;
            end if;

            begin
                select acc, nls, kv, odate, kodp, znap
                into accO_, nlsO_, kvO_, odateO_, kodpO_, znapO_
                from (select * from rnbu_trace where kodp = kodpO_ order by to_number(znap) desc)
                where rownum = 1;

                update rnbu_trace
                set znap=to_char(to_number(znap) + abs(k.skor)),
                comm=comm||'* коригування з попереднього періоду на '||to_char(k.skor)||' (було '||to_char(znapO_)||')'
                where acc = accO_ AND KODP = kodpO_;
            exception
               when no_data_found then
                   if p_KODF = '37' then
                      P_Proc_Set_Int( p_KODF, p_SHM, L_nbuc, l_typ );
                   else
                      P_Proc_Set( p_KODF, p_SHM, L_nbuc, l_typ );
                   end if;

                   insert into rnbu_trace (NLS, KV, odate, KODP, ZNAP, ACC, COMM, NBUC)
                   values (k.nls, k.kv, k.odate, kodpO_, k.skor, k.acc, '* сумма з попереднього періоду '||to_char(abs(k.skor)), L_nbuc);
            end;
       end loop;
    end if;

    for k in (select acc, nls, kv, odate, kodp, to_number(znap) znap, nbuc
                from rnbu_trace
              where ( (nls LIKE '9900_999999999%' and kv <> 980)
                 or (nls LIKE '9910_999999999%' and kv <> 980))
                 and substr(kodp,1,2) in ('10','20')
              order by 2,3,4
              )
    loop
       XX_:= substr(k.kodp,1,2);

       fl_minus := 0;

       -- для #01
       If p_KODF ='01' and XX_ <>'10'  and XX_ <> '20' and k.znap < 100
       THEN
          GOTO RecNext;
       end if;

       -- для #02
       If p_KODF in ('02', '25', 'A4', '81') and XX_ <>'10'  and XX_ <> '20' and k.znap < 100
       THEN
          GOTO RecNext;
       end if;

       -- для @37
       If p_KODF ='37' and k.nls not like '9910%' and XX_  not in ('10','20','50','60') and k.znap < 100
       THEN
          GOTO RecNext;
       end if;

       if p_KODF = '37' then
          X1_:= substr(k.kodp,1,1)||'1';
          X8_:= substr(k.kodp,3,9);
          poz_kv := 9;
          --update rnbu_trace set znap='0', comm=comm||' обнуляємо показник(1)'
          --       where nls=k.nls and kv=k.kv;

       else
          X1_:= substr(k.kodp,1,1)||'1';
          X8_:= substr(k.kodp,3,8);
          poz_kv := 7;
       end if;

       LOGGER.INFO('HB -1 ' || K.nls || ',' || K.kv || ',' || K.kodp || ','|| K.znap );
       LOGGER.INFO('HB -2 ' || X1_ || ',' || X8_ );

       -- если есть родной номинал,  ОК
       begin
          if p_KODF = '37' then
             select 1 into pr_  from rnbu_trace
             where nls <> k.nls
               and nbuc=k.nbuc and substr(kodp,1,2)=X1_
               and substr(kodp,3,9)=X8_ and rownum=1;
          else
             select 1 into pr_  from rnbu_trace
             where nls <> k.nls
               and nbuc=k.nbuc and substr(kodp,1,2)=X1_
               and substr(kodp,3,8)=X8_ and rownum=1;
          end if;

          LOGGER.INFO('HB -3 ok' );

          GOTO RecNext;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
       end;

       if p_KODF not in ('01', '37') then
          select count(*)
          into fl_not_kor
          from OTCN_ARCH_PEREOC
          where datf = p_DAT and
                kodf = '01' and
                acc = k.acc and
                kodp like substr(k.kodp,1,2)||'____'||substr(k.kodp,7);

          if fl_not_kor = 0 then
             LOGGER.INFO('HB - 6 Begin');

             declare
                fl_kor  number;
                kodpP_  varchar2(200);
                kodpK1_ varchar2(200);
                kodpK2_ varchar2(200);
             begin
                -- шукаємо протилежний знак по залишках
                if substr(k.kodp, 1, 1) = '1' then
                    X1_:= '20';
                else
                    X1_:= '10';
                end if;

                X8_:= substr(k.kodp,3,8);

                select count(*)
                into fl_kor
                from rnbu_trace
                where nbuc = k.nbuc and
                      kodp = X1_ || X8_ and
                      rownum=1;

                if fl_kor > 0 then
                   kodpP_ := X1_ || X8_;
                end if;

                -- шукаємо коригуючі по цьому знаку
                if substr(k.kodp, 1, 1) = '1' then
                    X1_:= '70';
                else
                    X1_:= '80';
                end if;

                X8_:= substr(k.kodp,3,8);

                select count(*)
                into fl_kor
                from rnbu_trace
                where nbuc = k.nbuc and
                      kodp = X1_ || X8_ and
                      rownum=1;

                if fl_kor > 0 then
                   kodpK1_ := X1_ || X8_;
                end if;

                -- шукаємо коригуючі по цпротилежному знаку
                if substr(k.kodp, 1, 1) = '1' then
                    X1_:= '80';
                else
                    X1_:= '70';
                end if;

                X8_:= substr(k.kodp,3,8);

                select count(*)
                into fl_kor
                from rnbu_trace
                where nbuc = k.nbuc and
                      kodp = X1_ || X8_ and
                      rownum=1;

                if fl_kor > 0 then
                   kodpK2_ := X1_ || X8_;
                end if;

                if kodpP_ is not null and kodpK1_ is not null and kodpK2_ is not null then
                   LOGGER.INFO('HB - 6-1');

                   update rnbu_trace
                   set kodp = kodpP_,
                       znap = to_char(-1 * k.znap),
                       comm=comm||'* (15) зменшуємо на '||to_char(-1 * k.znap)||' разом з '||k.kodp
                   where nbuc=k.nbuc and nls=k.nls and kv=k.kv AND KODP=K.KODP;

                   insert into rnbu_trace(USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC,  COMM)
                   values (user_id, k.nls, k.kv, p_dat, kodpK1_, k.znap, k.nbuc, '* (16) додаємо обороти до екв коригуючих');

                   insert into rnbu_trace(USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC,  COMM)
                   values (user_id, k.nls, k.kv, p_dat, kodpK2_, k.znap, k.nbuc, '* (17) додаємо обороти до екв коригуючих');
                else
                   LOGGER.INFO('HB - 6-2 ');
                end if;
             end;

             LOGGER.INFO('HB - 6 End');

             GOTO RecNext;
          end if;
       end if;

       -- для ВНЕбаланса
       begin
         --1) Если есть - переводим на др.бал счет в своей валюте
          if k.nls LIKE '9900%' then
             BEGIN
                select kodpN
                into kodpN_
                from (
                   select SUBSTR(kodp,1,1) || '0' || SUBSTR(KODP,3) kodpN
                   from rnbu_trace
                   where nbuc=k.nbuc
                     and substr(kodp,1,3)=X1_||'9' and substr(kodp,poz_kv,3)=substr('00'||k.kv,-3)
                     and substr(nls,1,2) in ('90','91','92','93','94','95')
                     and substr(nls,1,4) not in ('9023', '9100', '9129') -- для С5 файла
                     and znap >100
                   order by to_number(znap) desc)
                where rownum=1;

                LOGGER.INFO('HB - 4-1 ' || kodpN_ );
             exception when no_data_found then
                 BEGIN
                    X1_:= (case when substr(k.kodp,1,1) = '1' then '2' else '1' end)||'1';

                    select kodpN
                    into kodpN_
                    from (
                       select SUBSTR(kodp,1,1) || '0' || SUBSTR(KODP,3) kodpN
                       from rnbu_trace
                       where nbuc=k.nbuc
                         and substr(kodp,1,6)=X1_||'9900'
                         and substr(kodp,poz_kv,3)=substr('00'||k.kv,-3)
                         and znap >100
                       order by to_number(znap) desc)
                    where rownum=1;

                    fl_minus := 1;

                    LOGGER.INFO('HB - 4-2 ' || kodpN_ );
                 exception when no_data_found then
                    kodpN_ := k.kodp; --null;
                 END;
             END;
          else
             BEGIN
                select kodpN, znap
                into kodpN_, znapN_
                from (
                   select SUBSTR(kodp,1,1) || '0' || SUBSTR(KODP,3) kodpN, znap
                   from rnbu_trace
                   where nbuc=k.nbuc
                     and substr(kodp,1,3)=X1_||'9' and substr(kodp,poz_kv,3)=substr('00'||k.kv,-3)
                     and substr(nls,1,2) not in ('90','91','92','93','94','95')
                     and substr(nls,1,4) <> '9900'
                     and substr(nls,1,4) not in ('9023', '9100', '9129') -- для С5 файла
                     and znap >100
                   order by to_number(znap) desc)
                where rownum=1;

                LOGGER.INFO('HB - 4-3 ' || kodpN_ );
             exception when no_data_found then
                kodpN_ := k.kodp; --null;
             END;

          end if;

          if k.kodp <> kodpN_ then
             if fl_minus = 0 then
                 update rnbu_trace set kodp=kodpN_,comm=comm||'* (11) переносимо '||to_char(k.znap)||' з '||k.kodp
                 where nbuc=k.nbuc and nls=k.nls and kv=k.kv AND KODP=K.KODP;

                 IF SQL%ROWCOUNT = 1 THEN
                    insert into OTCN_ARCH_PEREOC (DATF, KODF, ACC, NLS, KV, ODATE, KODP, ZNAP, SKOR, COMM)
                    values (P_DAT, p_KODF, k.acc, k.NLS, k.KV, k.ODATE, kodpN_, k.ZNAP,  k.ZNAP, '* (12) переносимо '||to_char(k.znap)||' з '||k.kodp);
                 END IF;

                 LOGGER.INFO('HB - 4-4 ' || kodpN_ );
             else
                insert into rnbu_trace(USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC,  COMM)
                values (user_id, substr(kodpN_,3, 4)||'XXX', k.kv, p_dat, kodpN_, -1 * k.znap, k.nbuc, '* (Z1) зменшуємо показник');

                insert into OTCN_ARCH_PEREOC (DATF, KODF, ACC, NLS, KV, ODATE, KODP, ZNAP, SKOR, COMM)
                values (P_DAT, p_KODF, k.acc, substr(kodpN_,3, 4)||'XXX', k.KV, k.ODATE, kodpN_, znapN_,
                    -1*k.ZNAP, '* (Z1_1) зменшуємо на '||to_char(k.znap));

                update rnbu_trace set znap = '0',comm=comm||'* (Z1) зменшуємо показник на '||to_char(k.znap)
                where nbuc=k.nbuc and nls=k.nls and kv=k.kv AND KODP=K.KODP;

                insert into OTCN_ARCH_PEREOC (DATF, KODF, ACC, NLS, KV, ODATE, KODP, ZNAP, SKOR, COMM)
                values (P_DAT, p_KODF, k.acc, k.NLS, k.KV, k.ODATE, k.kodp, k.ZNAP,
                    -1*k.ZNAP, '* (Z1_2) зменшуємо на '||to_char(k.znap));

                LOGGER.INFO('HB - 4-5 ' || kodpN_ );
             end if;
          end if;

          select count(*)
             into pr_
          from otcn_arch_pereoc
          where datf=p_Dat and kodf=p_kodf and substr(kodp,1,2)=substr(k.kodp,1,2) and nls=k.nls and kv=k.kv;

          if p_KODF = '37' and pr_ = 0 then
             if substr(k.kodp,1,2)='10' then
                update rnbu_trace set znap='0', comm=comm ||' обнуляємо показник (1)'
                where substr(kodp,1,2) in ('10','50') and nls=k.nls and kv=k.kv ;
             else
                update rnbu_trace set znap='0', comm=comm ||' обнуляємо показник (1)'
                where substr(kodp,1,2) in ('20','60') and nls=k.nls and kv=k.kv ;
             end if;
          end if;

          if p_KODF in ('02', '37') and k.kodp <> kodpN_ then
            if substr(kodpN_,1,1) = '1' then
               kodpO_ := '5'||substr(kodpN_,2);
            else
               kodpO_ := '6'||substr(kodpN_,2);
            end if;

            kvO_ := substr(kodpO_, poz_kv, 3);

            fl_ := 1;

            begin
                select acc, nls, kv, odate, kodp, znap
                into accO_, nlsO_, kvO_, odateO_, kodpO_, znapO_
                from rnbu_trace
                where acc = k.acc and
                    kodp = kodpO_;
            exception
                when no_data_found then
                    begin
                        select acc, nls, kv, odate, kodp, znap
                        into accO_, nlsO_, kvO_, odateO_, kodpO_, znapO_
                        from (select * from rnbu_trace where nbuc=k.nbuc and kodp = kodpO_ order by to_number(znap) desc)
                        where rownum = 1;
                    exception
                        when no_data_found then
                            fl_ := 0;
                    end;
            end;

            if fl_ = 1 then
                update rnbu_trace
                set znap=to_char(to_number(znap)+k.znap),
                    comm=comm||'* (10) збільшуємо на '||to_char(k.znap)
                where acc = accO_ AND KODP = kodpO_;

                insert into OTCN_ARCH_PEREOC (DATF, KODF, ACC, NLS, KV, ODATE, KODP, ZNAP, SKOR, COMM)
                values (P_DAT, p_KODF, accO_, nlsO_, kvO_, odateO_, kodpO_, znapO_,  k.znap, '* (1) збільшуємо на '||to_char(k.znap));
            else
                insert into rnbu_trace(USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC,  COMM)
                values (user_id, substr(kodpO_,3, 4)||'XXX', k.kv, p_dat, kodpO_, k.znap, k.nbuc, '* (2) додаємо показник');

                insert into OTCN_ARCH_PEREOC (DATF, KODF, ACC, NLS, KV, ODATE, KODP, ZNAP, SKOR, COMM)
                values (P_DAT, p_KODF, k.acc, substr(kodpO_,3, 4)||'XXX', k.kv, p_dat, kodpO_, k.znap,  k.znap, '* (3) додаємо показник ');
            end if;

            if substr(kodpN_,1,1) = '1' then
               kodpO_ := '5'||substr(k.kodp,2);
            else
               kodpO_ := '6'||substr(k.kodp,2);
            end if;

            kvO_ := substr(kodpO_, poz_kv, 3);

            fl_ := 1;

            begin
                select acc, nls, kv, odate, kodp, znap
                into accO_, nlsO_, kvO_, odateO_, kodpO_, znapO_
                from rnbu_trace
                where acc = k.acc and
                    kodp = kodpO_;
            exception
                when no_data_found then
                    begin
                        select acc, nls, kv, odate, kodp, znap
                        into accO_, nlsO_, kvO_, odateO_, kodpO_, znapO_
                        from (select * from rnbu_trace where nbuc=k.nbuc and kodp = kodpO_ order by to_number(znap) desc)
                        where rownum = 1;
                    exception
                        when no_data_found then
                            fl_ := 0;
                    end;
            end;

            if to_number(znapO_) < k.znap or fl_ = 0 then
                kodpO_ := (case substr(kodpN_,1,1) when '1' then '6' else '5' end)||substr(k.kodp,2);

                if fl_ = 1 then
                    update rnbu_trace
                    set znap=to_char(to_number(znap)+k.znap),
                        comm=comm||'* (9) збільшуємо на '||to_char(k.znap)
                    where acc = accO_ AND KODP = kodpO_;

                    if sql%rowcount = 0 then
                       insert into rnbu_trace(USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC,  COMM)
                       values (user_id, nlsO_, kvO_, p_dat, kodpO_, k.znap, k.nbuc, '* (91) збільшуємо на '||to_char(k.znap));
                    end if;

                    insert into OTCN_ARCH_PEREOC (DATF, KODF, ACC, NLS, KV, ODATE, KODP, ZNAP, SKOR, COMM)
                    values (P_DAT, p_KODF, accO_, nlsO_, kvO_, odateO_, kodpO_, znapO_,  k.znap, '* (4) збільшуємо на '||to_char(k.znap));
                else
                    insert into rnbu_trace(USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC,  COMM)
                    values (user_id, substr(kodpO_,3, 4)||'XXX', k.kv, p_dat, kodpO_, k.znap, k.nbuc, '* (5) додаємо показник');

                    insert into OTCN_ARCH_PEREOC (DATF, KODF, ACC, NLS, KV, ODATE, KODP, ZNAP, SKOR, COMM)
                    values (P_DAT, p_KODF, k.acc, substr(kodpO_,3, 4)||'XXX', k.kv, p_dat, kodpO_, k.znap,  k.znap, '* (6) додаємо показник ');
                end if;
            else
                update rnbu_trace
                set znap=to_char(to_number(znap)-k.znap),
                    comm=comm||'* (13) зменшуємо на '||to_char(k.znap)
                where acc = accO_ AND KODP = kodpO_;

                begin
                    insert into OTCN_ARCH_PEREOC (DATF, KODF, ACC, NLS, KV, ODATE, KODP, ZNAP, SKOR, COMM)
                    values (P_DAT, p_KODF, accO_, nlsO_, kvO_, odateO_, kodpO_, znapO_,  -k.znap, '* (7) зменшуємо на '||to_char(k.znap));
                exception
                    when others then
                        if sqlcode = -1 then
                           update OTCN_ARCH_PEREOC
                           set znap = znap - k.znap,
                               comm=comm||' * (8) зменшуємо на '||to_char(k.znap)
                           where datf = P_DAT and
                                kodf = p_KODF and
                                acc = accO_ and
                                kodp = kodpO_;
                        end if;
                end;
            END IF;

          end if;

          LOGGER.INFO('HB -5 '|| kodpn_);

          GOTO RecNext;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
       end;

       <<RecNext>> null;
    end loop;

END P_OTC_VE9;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_OTC_VE9.sql =========*** End ***
PROMPT ===================================================================================== 
