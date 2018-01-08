

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/REZ_PAY_OB22.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure REZ_PAY_OB22 ***

  CREATE OR REPLACE PROCEDURE BARS.REZ_PAY_OB22 (dat_ DATE, mode_ NUMBER DEFAULT 0, p_user number default null)  IS

/* Версія   1.0   13-11-2017
   13-11-2017(1.0) - Убран rez.p_unload_data;
*/

  doform_nazn varchar2(100) := 'Формування резерву під ';
  doform_nazn_korr varchar2(100) := 'Кор. проводка по формуванню резерву під ';

  rasform_nazn varchar2(100) := 'Зменшення резерву під ';
  rasform_nazn_korr varchar2(100) := 'Кор. проводка по зменшенню резерву під ';


  r7702_acc number;
  r7702_ varchar2(20);
  vob_ number;
  nazn_ varchar2(500);
  otvisp_ number;
  fl number(1);
  tt_ varchar2(3);
  s_old_ number;
  s_old_q number;
  s_new_ number;
  nam_a_ varchar2(50);
  nam_b_ varchar2(50);
  r7702_bal varchar2(50);
  ref_ number;
  kurs_ varchar2(500);
  b_date date;
  okpoa_ varchar2(500);
  userid_ number;
  diff_ number;
  e_nofound_7form exception;
  e_nofound_7rasform exception;
  error_str varchar2(1000);


  procedure p_error( p_error_type  NUMBER,
                     p_nbs         VARCHAR2,
                     p_s080        VARCHAR2,
                     p_custtype    VARCHAR2,
                     p_kv          VARCHAR2,
                     p_branch      VARCHAR2,
                     p_nbs_rez     VARCHAR2,
                     p_nbs_7f      VARCHAR2,
                     p_nbs_7r      VARCHAR2,
                     p_sz          NUMBER,
                     p_error_txt   VARCHAR2,
                     p_desrc       VARCHAR2)
  is
  PRAGMA AUTONOMOUS_TRANSACTION;
  begin
     insert into srezerv_errors
     ( dat,userid, error_type, nbs, s080, custtype, kv, branch,
      nbs_rez,nbs_7f,  nbs_7r, sz, error_txt, desrc)
     values (dat_, userid_, p_error_type, p_nbs, p_s080, p_custtype, p_kv, p_branch,
            p_nbs_rez, p_nbs_7f, p_nbs_7r, p_sz, p_error_txt, p_desrc) ;
     COMMIT;
  end;



BEGIN

--dbms_output.put_line(' mode_ = '|| mode_);
     rez.p_unload_data;
    -- Возвращает код тек. пользователя STAFF.ID
    /*  BEGIN
         SELECT ID
           INTO userid_
           FROM staff
          WHERE UPPER (logname) = USER;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            userid_ := 1;
      END;*/
      userid_ := nvl(p_user, user_id);--user_id;

--raise_application_error(-20001, 'userid_ = '||userid_||'     p_user = '||p_user);

--insert into cp_rez_log (userid,rownumber,val, txt) values (user_id,0,null,'userid_ = '||userid_||'     p_user = '||p_user);


    --проверка, есть ли за текущую дату расчета непроведенные проводки по резервам
    s_new_ := 0;

    --выбираем не оплаченные документы
    SELECT count(*)
        INTO s_new_
        FROM oper
       WHERE tt IN ('ARE', 'AR*') AND sos not in (5, -1) --выбираем не оплаченные документы
             --and pdat > trunc(sysdate)
             --and pdat < trunc(sysdate) + 1
             and vdat = dat_
    ;
    if s_new_ > 0 then
        bars_error.raise_error('REZ',4);
    end if;

    delete from srezerv_errors s where s.userid = userid_;

--dbms_output.put_line(' mode_ = '|| mode_);

    --выборка счетов для которых нет информации в справочнике
    insert into srezerv_errors
    (dat,userid, error_type, nbs, s080, custtype, kv, branch,  sz, error_txt, nbs_7f)
    select dat_, userid_, 1,
           ac.nbs||'/'||s.ob22, null,null ,r.kv,
           rtrim(substr(r.tobo||'/',1,instr(r.tobo||'/','/',1,3)-1),'/')||'/' branch,
           sum(nvl(r.sz1, sz)) sz
           ,'S080 = '||r.s080||', Тип клієнта - '||decode(r.custtype,2, 'Юр.ос.',3, 'Фіз.ос.','')||'. Рахунки - '
           ||ConcatStr(r.nls)
           ,r.kv
    from tmp_rez_risk r,
         accounts ac,
         specparam_int s
    where id = nvl(p_user, user_id) and dat = dat_
          and r.acc = ac.acc
          and r.acc = s.acc(+)
          and nvl(r.sz1, sz) <> 0
          and not exists
          (select 1
           from srezerv_ob22 o
           where ac.nbs = o.nbs and
                 s.ob22 = decode(o.ob22,'0',s.ob22,o.ob22) and
                 decode(r.s080,1,1,2) = decode(o.s080,'0',decode(r.s080,1,1,2),o.s080) and
                 r.custtype = decode(o.custtype,'0',r.custtype,o.custtype) and
                 r.kv = decode(o.kv,'0',r.kv,o.kv)
          )
    --      and r.acc = 280633
    group by ac.nbs,s.ob22, r.s080,r.custtype ,r.kv,
             rtrim(substr(r.tobo||'/',1,instr(r.tobo||'/','/',1,3)-1),'/')||'/'
    ;

    commit;
--dbms_output.put_line(' mode_ = '|| mode_);
    --IF mode_ = 1
   -- THEN
     DELETE FROM rez_doc_maket s where s.userid = userid_;
  --COMMIT;
   -- END IF;

    b_date := bankdate;

   otvisp_ := nvl(GetGlobalOption('REZ_ISP'),userid_);


--dbms_output.put_line(' mode_ = '|| mode_);
   BEGIN
     SELECT SUBSTR (val, 1, 14)
       INTO okpoa_
       FROM params
      WHERE par = 'OKPO';
   EXCEPTION
     WHEN NO_DATA_FOUND
     THEN
        okpoa_ := '';
   END;
--dbms_output.put_line(' mode_ = '|| mode_);
    --dat_form :=
    --выборка данных для проводок
  for k in
    (select t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r,  t.OB22_7r,t.kv, t.branch, t.sz,t.s080,t.pr,
           t.r_s080,
           ConcatStr(ar.acc) r_acc,    ConcatStr(ar.nls) r_nls,    --ConcatStr(t.OB22_REZ) r_ob22,
           ConcatStr(a7_f.acc) f7_acc, ConcatStr(a7_f.nls) f7_nls, --ConcatStr(t.OB22_7f) f7_ob22,
           ConcatStr(a7_r.acc) r7_acc, ConcatStr(a7_r.nls) r7_nls, --ConcatStr(t.OB22_7r) r7_ob22,
           count(*) cnt
    from
    (
        select  --выборка сумм резерва в разрезе счетов резервного фонда каждого бранча (по справочнику)
               o.NBS_REZ, o.OB22_REZ, o.NBS_7f, o.OB22_7f, o.NBS_7r,  o.OB22_7r,o.pr,
               r.KV, rtrim(substr(r.tobo||'/',1,instr(r.tobo||'/','/',1,3)-1),'/')||'/' branch,
               sum(nvl(r.sz1, sz)) sz
               --,decode(r.s080,1,1,9,1,2) s080
               ,decode(r.s080,1,1,9,9,2) s080
               ,decode(r.s080,1,0,9,0,r.s080) r_s080
        from tmp_rez_risk r
             join accounts ac on r.acc = ac.acc
             join specparam_int s on r.acc = s.acc
             join srezerv_ob22 o on (ac.nbs = o.nbs and
                                     s.ob22 = decode(o.ob22,'0',s.ob22,o.ob22) and
                                     decode(r.s080,1,1,2) = decode(o.s080,'0',decode(r.s080,1,1,2),o.s080) and
                                     r.custtype = decode(o.custtype,'0',r.custtype,o.custtype) and
                                     r.kv = decode(o.kv,'0',r.kv,o.kv) )
        where id = nvl(p_user, user_id) and dat = dat_
              and nvl(r.sz1, sz) <> 0
          --    and o.NBS_REZ = '2400' and o.OB22_REZ = '03'  and ac.kv = 980
        group by o.NBS_REZ, o.OB22_REZ, o.NBS_7f, o.OB22_7f, o.NBS_7r,  o.OB22_7r,o.pr,
                r.KV, rtrim(substr(r.tobo||'/',1,instr(r.tobo||'/','/',1,3)-1),'/')||'/'
                --,decode(r.s080,1,1,9,1,2)
                ,decode(r.s080,1,1,9,9,2)
                ,decode(r.s080,1,0,9,0,r.s080)
    ) t
     --счет резерва
     left join accounts ar on (t.NBS_REZ = ar.nbs and
                               t.OB22_REZ = (select ob22 from specparam_int s where s.acc = ar.acc)  and
                               t.KV = ar.kv and
                               t.branch = ar.BRANCH
                               --and nvl(ar.dazs, to_date('01014999','ddmmyyyy')) > dat_
                               and ar.dazs is null
                               and t.r_s080 = decode(t.r_s080,0,t.r_s080, (select s080 from specparam s where s.acc = ar.acc))
                               )
     --счет 7 класса формирования
     left join accounts a7_f on (t.NBS_7f = a7_f.nbs and
                               t.OB22_7f = (select ob22 from specparam_int s where s.acc = a7_f.acc)  and
                               '980' = a7_f.kv and
                               t.branch = a7_f.BRANCH
                               --and nvl(a7_f.dazs, to_date('01014999','ddmmyyyy')) > dat_
                               and a7_f.dazs is null
                               )
     --счет 7 класса уменьшения
     left join accounts a7_r on (t.NBS_7r = a7_r.nbs and
                                 t.OB22_7r = (select ob22 from specparam_int s where s.acc = a7_r.acc)  and
                                 '980' = a7_r.kv and
                                 t.branch = a7_r.BRANCH
                                -- and nvl(a7_r.dazs, to_date('01014999','ddmmyyyy')) > dat_
                                 and a7_r.dazs is null
                                 )
    group by t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r,  t.OB22_7r,t.kv, t.branch, t.sz,t.s080,t.pr
             ,t.r_s080
  )
  loop
--if k.r_nls = '2400291116' then
       dbms_output.put_line('----------------------------------------------------------');
       dbms_output.put_line('k.r_nls = '||k.r_nls||'  '||'k.s080 = '|| k.s080);
       nazn_ := null;
       fl :=0;

       --проверка корректности данных
       if k.cnt > 1 then
          -- для одного счета резерва найдено несколько лицевых счетов
          if instr(k.r_nls,',') > 0 then
            p_error( 2, k.NBS_REZ||'/'||k.OB22_REZ,null, null, k.kv, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
                     k.kv, null, k.sz,k.r_nls||(case k.r_s080 when 0 then '' else ' s080='||k.r_s080 end), null);
            fl := 1;

          end if;
          -- для одного счета 7 класса (для формирования) найдено несколько лицевых счетов
          if instr(k.f7_nls,',') > 0 then
             p_error( 2, k.NBS_7f||'/'|| k.OB22_7f,null, null, 980, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
                     k.kv, null, k.sz,k.f7_nls, 'Рахунок резерву - '||k.r_nls);
             fl := 2;

          end if;
          -- для одного счета 7 класса (для уменьшения) найдено несколько лицевых счетов
          if instr(k.r7_nls,',') > 0 then
             p_error( 2, k.NBS_7r||'/'|| k.OB22_7r,null, null, 980, k.branch,  k.NBS_REZ||'/'||k.OB22_REZ,
                     k.kv, null, k.sz,k.r7_nls, 'Рахунок резерву - '||k.r_nls);
             fl := 3;

          end if;
       end if;

       --проверка открыты ли необходимые счета в базе
       if k.r_acc is null then
          p_error( 3, k.NBS_REZ||'/'||k.OB22_REZ,k.r_s080, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ,
                      k.kv, null, k.sz,
                     k.NBS_REZ||'/'||k.OB22_REZ||(case k.r_s080 when 0 then '' else ' s080='||k.r_s080 end),
                     null);
          fl := 4;

       end if;

       --проверка открыт ли нужный счет 7 класса
       if k.f7_acc is null then
            p_error( 3, k.NBS_7f||'/'|| k.OB22_7f,null, null, 980, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
                     k.kv, null, k.sz, k.NBS_7f||'/'|| k.OB22_7f,  'Рахунок резерву - '||k.r_nls);
            fl := 4;
       end if;

        --проверка открыт ли нужный счет 7 класса
        if k.r7_acc is null then
            p_error( 3, k.NBS_7r||'/'|| k.OB22_7r,null, null, 980, k.branch,  k.NBS_REZ||'/'||k.OB22_REZ,
                     k.kv, null,  k.sz, k.NBS_7r||'/'|| k.OB22_7r,  'Рахунок резерву - '||k.r_nls);
             fl := 4;
        end if;

    --   if fl <> 0 then
      --   continue;
       --end if;

     --  Соответствие параметров
     if fl = 0 then
       for rr in
       (  select r013 from specparam p
          where p.acc = to_number(k.r_acc)
       )
       loop
          if (k.pr = 9 and rr.r013 <> 3) or (k.pr <> 9 and rr.r013 = 3) then
            p_error( 4, k.NBS_REZ||'/'||k.OB22_REZ,k.r_s080, null, k.kv, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
                       k.kv, null, k.sz,
                       k.r_nls||' (R013='||rr.r013||', OB22='||k.OB22_REZ||')',
                       null);
             fl := 4;
          end if;
       end loop;
     end if;


   dbms_output.put_line('fl = '||fl);

    begin
       savepoint sp;

       error_str :=null;
    --формирование проводок
       if fl = 0 then

           -- dbms_output.put_line('k.s080 = '|| k.s080);
           --тип операции
           IF k.s080 = '1'
           THEN
              tt_ := 'ARE';                                   --для стандартных
              nazn_ := 'станд.';
           ELSE
              tt_ := 'AR*';                                 --для НЕстандартных
              if k.s080 = '2' then nazn_ := 'нестанд.';
              end if;
           END IF;

           -- Определяем необходимый вид VOB
           IF TO_CHAR (b_date, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
           THEN
              vob_ := 96;
           ELSE
              vob_ := 6;
           END IF;
           -- узнать предыдущие остатки
           SELECT NVL (SUM (rez.ostc96 (k.r_acc, dat_)), 0) --T 16.01.2009
           INTO s_old_
           from dual;
            dbms_output.put_line('s_old = '||to_char(s_old_));

           --новая сумма резерва
           s_new_ := k.sz;
            dbms_output.put_line('s_new_ = '||to_char(s_new_));

           error_str := error_str||'1';
           --резерв изменился
           if s_new_ - s_old_ <> 0 then

              if s_new_ > s_old_ then-- увеличение резерва

                r7702_acc := k.f7_acc;
                r7702_ := k.f7_nls;
                r7702_bal := k.NBS_7f||'/'||k.OB22_7f;

              else--уменьшение резерва

                r7702_acc := k.r7_acc;
                r7702_ := k.r7_nls;
                r7702_bal := k.NBS_7r||'/'||k.OB22_7r;
              end if;
              error_str := error_str||'2';
               -- dbms_output.put_line('r7702_acc = '||to_char(r7702_acc));

              -- узнать название нужных счетов для вставки в OPER
              SELECT SUBSTR (a.nms, 1, 38), SUBSTR (b.nms, 1, 38)
                  INTO nam_a_, nam_b_
                  FROM accounts a, accounts b
              WHERE a.acc = k.r_acc and
                    b.acc = r7702_acc;

               -- dbms_output.put_line('nam_b_ = '||to_char(nam_b_));
              error_str := error_str||'3';
              -- проводка по расформированию резерва
              IF mode_ = 0
              THEN
                gl.REF (ref_);
              END IF;

              error_str := error_str||'4';

               error_str := error_str||'5';


               nazn_ := nazn_||' заборг. за ';
               if k.pr = 2 then
                 nazn_ := nazn_ || 'наданими кредитами СГД ';
               elsif k.pr = 3 then
                 nazn_ := nazn_ || 'наданими кредитами фіз. особам ';
               elsif k.pr = 9 then
                 nazn_ := nazn_ || 'нарахованими доходами ';
               end if;

               IF k.s080 = '2' then
                  nazn_ := nazn_ || 'за рахунок валових витрат';
               END IF;


              if s_new_ > s_old_ then
                diff_ := (-s_old_ + s_new_);
                error_str := error_str||'6';
                -- увеличение резерва
                IF vob_ <> 96
                THEN
                    nazn_ := doform_nazn || nazn_;
                ELSE
                    nazn_ := doform_nazn_korr || nazn_;
                END IF;
                --dbms_output.put_line('mode_ = '||mode_ );
                error_str := error_str||'7';

                IF mode_ = 0
                THEN
                   -- dbms_output.put_line('11111111111111   '||diff_ );
                    INSERT INTO oper
                             (REF, tt, vob, nd, dk, pdat, vdat,
                              datd, datp, nam_a, nlsa, mfoa,
                              id_a, nam_b, nlsb, mfob, id_b,
                              kv, s,
                              kv2, s2,
                              nazn, userid
                             )
                      VALUES (ref_, tt_, vob_, ref_, 0, SYSDATE, dat_,
                               b_date,  b_date, nam_a_, k.r_nls, gl.amfo,
                              okpoa_, nam_b_, r7702_, gl.amfo, okpoa_,
                              k.kv, diff_,
                              980, gl.p_icurval (k.kv, diff_, dat_),
                              nazn_, otvisp_
                             );
                     error_str := error_str||'8';

                    paytt (0,
                          ref_,
                          dat_,
                          tt_,
                          0,
                          k.kv,
                          k.r_nls,
                          diff_,
                          980,
                          r7702_,
                          gl.p_icurval (k.kv, diff_, dat_)

                         );

                  error_str := error_str||'9';
                --ELSIF mode_ = 1
               --THEN
                end if;

                     INSERT INTO rez_doc_maket
                                 (tt, vob, pdat, vdat, datd, datp,
                                  nam_a, nlsa, mfoa, id_a, nam_b,
                                  nlsb, mfob, id_b,
                                  kv, s,
                                  kv2, s2,
                                  nazn, userid, dk, branch_a
                                 )
                          VALUES (tt_, k.s080, SYSDATE, dat_, b_date, b_date,
                                  nam_a_, k.r_nls, k.nbs_rez||'/'||k.ob22_rez, /*okpoa_*/s_new_,
                                  nam_b_,
                                  r7702_, r7702_bal, /*okpoa_*/gl.p_icurval (k.kv,  s_new_, dat_),
                                  k.kv, diff_,
                                  980, gl.p_icurval (k.kv, diff_, dat_),
                                  nazn_, userid_, 1, k.branch
                                 );

                 dbms_output.put_line('Увеличение   '||diff_ );
                 error_str := error_str||' 10';
               -- END IF;--IF mode_ = 0

              else
                --уменьшение резерва
                diff_ := (s_old_ - s_new_);
                error_str := error_str||' 11';
                IF vob_ <> 96
                THEN
                    nazn_ := rasform_nazn || nazn_;
                ELSE
                    nazn_ := rasform_nazn_korr || nazn_;
                END IF;


                error_str := error_str||' 12';
                IF mode_ = 0
                THEN
                     INSERT INTO oper
                                 (REF, tt, vob, nd, dk, pdat, vdat,
                                  datd, datp, nam_a, nlsa, mfoa,
                                  id_a, nam_b, nlsb, mfob, id_b,
                                  kv, s,
                                  kv2, s2,
                                  nazn, userid
                                 )
                          VALUES (ref_, tt_, vob_, ref_, 1, SYSDATE, dat_,
                                  b_date, b_date, nam_a_, k.r_nls, gl.amfo,
                                  okpoa_, nam_b_, r7702_, gl.amfo, okpoa_,
                                  k.kv, diff_,
                                  980, gl.p_icurval (k.kv, diff_, dat_),
                                  nazn_, otvisp_

                                 );

                     error_str := error_str||' 13';

                     paytt (0,
                            ref_,
                            dat_,
                            tt_,
                            1,
                            k.kv,
                            k.r_nls,
                            diff_,
                            980,
                            r7702_,
                            gl.p_icurval (k.kv, diff_, dat_)
                           );


                error_str := error_str||' 14';
               -- ELSIF mode_ = 1
               -- THEN
                end if;

                     INSERT INTO rez_doc_maket
                                 (tt, vob, pdat, vdat, datd, datp,
                                  nam_a, nlsa, mfoa, id_a, nam_b,
                                  nlsb, mfob, id_b,
                                  kv, s,
                                  kv2, s2,
                                  nazn, userid, dk, branch_a
                                 )
                          VALUES (tt_, k.s080, SYSDATE, dat_, b_date, b_date,
                                  nam_a_, k.r_nls, k.nbs_rez||'/'||k.ob22_rez, /*okpoa_*/s_new_,
                                  nam_b_,
                                  r7702_, r7702_bal, /*okpoa_*/gl.p_icurval (k.kv, s_new_, dat_),
                                  k.kv, diff_,
                                  980,  gl.p_icurval (k.kv, diff_, dat_),
                                  nazn_, userid_, 0, k.branch
                                 );
                  dbms_output.put_line('Уменьшение : -s_old_ + s_new_ = '||to_char(s_old_ - s_new_));
                 error_str := error_str||' 15';
                --END IF;--IF mode_ = 0
              END IF;-- if s_new_ > s_old_

           -- резерв не поменялся - все равно запишем в rez_doc_maket с признаком dk = -1
           -- чтобы впоследствии при полном расформировании не учитывать этот счет
           else
                 INSERT INTO rez_doc_maket
                             (tt, vob, pdat, vdat, datd, datp,
                              nam_a, nlsa, mfoa, id_a, nam_b,
                              nlsb, mfob, id_b,
                              kv, s,
                              kv2, s2,
                              nazn, userid, dk, branch_a
                             )
                      VALUES (tt_, k.s080, SYSDATE, dat_, b_date, b_date,
                              null, k.r_nls, k.nbs_rez||'/'||k.ob22_rez, /*okpoa_*/s_new_, null,
                              null, r7702_bal, /*okpoa_*/gl.p_icurval (k.kv, s_new_, dat_),
                              k.kv, diff_,
                              980,  gl.p_icurval (k.kv, diff_, dat_),
                              null, userid_, -1, k.branch
                             );
                  dbms_output.put_line('Резерв не изменился = '||to_char(s_old_ - s_new_));
                  error_str := error_str||' 16';
           end if; --if s_new_ - s_old_ <> 0
        end if; --if fl = 0

    exception

    when others then
      rollback to sp;
      p_error( 5, null,null, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ,
                  k.kv, null, k.sz,
                 k.NBS_REZ||'/'||k.OB22_REZ||','||k.NBS_7f||'/'|| k.OB22_7f||','||k.NBS_7r||'/'|| k.OB22_7r||
                 substr(sqlerrm,instr(sqlerrm,':')+1),
                 error_str
             );
      dbms_output.put_line('ошибка - '|| k.sz||' '||sqlerrm);

    end;
--end if;
  end loop;

  dbms_output.put_line('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');

--РАСФОРМИРОВАНИЕ ДЛЯ ТЕХ СЧЕТОВ ПО КОТОРЫМ ТЕКУЩИЙ РЕЗЕРВ НЕ ФОРМИРОВАЛСЯ (т.е. = 0)
--(НЕТ В TMP_REZ_RISK)
 for k in
  ( select a.acc r_acc, s.ob22 OB22_REZ, a.nbs NBS_REZ,
           rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' branch,
           a.nls r_nls, a.kv,
           rez.ostc96(to_number(a.acc), dat_) sz,
           o.NBS_7R, o.OB22_7R
           ,ConcatStr(a7.acc) r7_acc, ConcatStr(a7.nls) r7_nls
           ,o.pr
    from accounts a
         left join specparam_int s on a.acc = s.acc
         left join srezerv_ob22 o on a.nbs = o.nbs_rez and s.ob22 = o.ob22_rez
         left join accounts a7 on (o.NBS_7R = a7.nbs and
                                   o.OB22_7R = (select ob22 from specparam_int s where s.acc = a7.acc)  and
                                    '980' = a7.kv and
                                    rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' = a7.BRANCH
                                    --and nvl(a7.dazs, to_date('01014999','ddmmyyyy')) > dat_
                                    and a7.dazs is null
                                    )
    where a.nbs in ('2400','2401','3690','3599')
         -- and dat_ between a.daos and nvl(a.dazs, to_date('01014999','ddmmyyyy'))
         --and nvl(a.dazs, to_date('01014999','ddmmyyyy')) > dat_
         and a.dazs is null
          and rez.ostc96(to_number(a.acc), dat_) <> 0
          --не формировались проводки
          and not exists
           (select 1
            from rez_doc_maket r
            where r.userid = userid_ and
                  r.nlsa = a.nls and
                  r.kv = a.kv
           )
           --нет ошибок
           and not exists
           (select 1
            from srezerv_errors r
            where r.error_type <> 1 and
                  r.nbs_rez = a.nbs||'/'||s.ob22 and
                 -- r.kv = a.kv and
                   r.nbs_7f = a.kv and
                  r.userid = userid_ and
                  r.branch = rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/'
           )
    group by a.acc, s.ob22, a.nbs,
           rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' ,
           a.nls, a.kv, o.NBS_7R, o.OB22_7R,o.pr
  ) loop
    --Проверки
    fl := 0;
    nazn_ := null;
--if k.r_nls in ('3599991603','3599091604','3599191605') and k.kv = 980 then

dbms_output.put_line('----------------------------------------------------------');
dbms_output.put_line(k.branch||'   '||k.r_nls||' '|| k.kv||' === '||k.sz);

    if k.NBS_7R is null then
       p_error( 6, k.NBS_rez||'/'|| k.OB22_rez,null, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ,
                k.kv, null, k.sz,k.r7_nls,  'Рахунок резерву - '||k.r_nls);
       fl := 5;

    --end if;
    -- для одного счета 7 класса (для уменьшения) найдено несколько лицевых счетов
    elsif instr(k.r7_nls,',') > 0 then
       p_error( 7, k.NBS_7r||'/'|| k.OB22_7r,null, null, 980, k.branch,  k.NBS_REZ||'/'||k.OB22_REZ,
               k.kv, null, k.sz,k.r7_nls,  'Рахунок резерву - '||k.r_nls);
       fl := 5;

    --end if;
    --счета не найдены
    elsif k.r7_acc is null then
       p_error( 8, k.NBS_7r||'/'|| k.OB22_7r,null, null, 980, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
                  k.kv, null,  k.sz,
                 k.NBS_7r||'/'|| k.OB22_7r, 'Рахунок резерву - '||k.r_nls);
        fl := 5;

    end if;

   /* if fl <> 0 then
      continue;
    end if;*/

     --  Соответствие параметров
    if fl = 0 then
       for rr in
       (  select r013 from specparam p
          where p.acc = k.r_acc
       )
       loop
          if (k.pr = 9 and rr.r013 <> 3) or (k.pr <> 9 and rr.r013 = 3) then
            p_error( 7, k.NBS_REZ||'/'||k.OB22_REZ, null, null, k.kv, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
                        k.kv, null, k.sz,
                       k.r_nls||' (R013='||rr.r013||', OB22='||k.OB22_REZ||')',
                       null);
             fl := 4;
            -- continue;
          end if;
       end loop;
   end if;

   dbms_output.put_line(' fl = '|| fl);

    begin
       savepoint sp;

       error_str :=null;


       --формирование проводок
       if fl = 0 then

           --тип операции
           IF k.NBS_REZ = '2401'
           THEN
              tt_ := 'ARE';                                   --для стандартных
              nazn_ := 'станд.';
           ELSE
              tt_ := 'AR*';                                 --для НЕстандартных
              if k.pr <> 9 then nazn_ := 'нестанд.';
              end if;
           END IF;
           -- dbms_output.put_line('2222222222222222222222222');

           -- Определяем необходимый вид VOB
           IF TO_CHAR (b_date, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
           THEN
              vob_ := 96;
           ELSE
              vob_ := 6;
           END IF;
           -- dbms_output.put_line('33333333333333333333333333');
           -- узнать предыдущие остатки

           s_old_ := k.sz;
            dbms_output.put_line('s_old = '||to_char(s_old_));

           --новая сумма резерва
           s_new_ := 0;
            dbms_output.put_line('s_new_ = '||to_char(s_new_));

           error_str := error_str||'1';
           r7702_acc := k.r7_acc;
           r7702_ := k.r7_nls;

           -- узнать название нужных счетов для вставки в OPER
           SELECT SUBSTR (a.nms, 1, 38), SUBSTR (b.nms, 1, 38)
              INTO nam_a_, nam_b_
              FROM accounts a, accounts b
           WHERE a.acc = k.r_acc and
                 b.acc = r7702_acc;

            --dbms_output.put_line('nam_b_ = '||to_char(nam_b_));
           error_str := error_str||'2';
           -- проводка по расформированию резерва
           IF mode_ = 0
           THEN
              gl.REF (ref_);
           END IF;

           error_str := error_str||'3';

           error_str := error_str||'4';

              --уменьшение резерва
              diff_ := (s_old_ - s_new_);
              dbms_output.put_line('diff_ = '||diff_ );
              error_str := error_str||'5';

              nazn_ := nazn_||' заборг. за ';
               if k.pr = 2 then
                 nazn_ := nazn_ || 'наданими кредитами СГД ';
               elsif k.pr = 3 then
                 nazn_ := nazn_ || 'наданими кредитами фіз. особам ';
               elsif k.pr = 9 then
                 nazn_ := nazn_ || 'нарахованими доходами ';
               end if;

              IF vob_ <> 96
              THEN
                  nazn_ := rasform_nazn || nazn_;
              ELSE
                  nazn_ := rasform_nazn_korr || nazn_;
              END IF;
                --dbms_output.put_line('mode_ = '||mode_ );
              error_str := error_str||'6';

              IF mode_ = 0 then

                   INSERT INTO oper
                               (REF, tt, vob, nd, dk, pdat, vdat,
                                datd, datp, nam_a, nlsa, mfoa,
                                id_a, nam_b, nlsb, mfob, id_b,
                                kv, s,
                                kv2, s2,
                                nazn, userid
                               )
                        VALUES (ref_, tt_, vob_, ref_, 1, SYSDATE, dat_,
                                b_date, b_date, nam_a_, k.r_nls, gl.amfo,
                                okpoa_, nam_b_, r7702_, gl.amfo, okpoa_,
                                k.kv, diff_,---(s_old_ - s_new_),
                                980, gl.p_icurval (k.kv, diff_, dat_),
                                nazn_, otvisp_

                               );
                   error_str := error_str||'7';

                   paytt (0,
                          ref_,
                          dat_,
                          tt_,
                          1,
                          k.kv,
                          k.r_nls,
                          diff_,--(s_old_ - s_new_),
                          980,
                          r7702_,
                          gl.p_icurval (k.kv, diff_, dat_)
                         );
                error_str := error_str||'8';

             -- ELSIF mode_ = 1
             -- THEN
              end if;

               INSERT INTO rez_doc_maket
                           (tt, vob, pdat, vdat, datd, datp,
                            nam_a, nlsa, mfoa, id_a, nam_b,
                            nlsb, mfob, id_b,
                            kv, s,
                            kv2, s2,
                            nazn, userid, dk, branch_a
                           )
                    VALUES (tt_, nvl(k.pr,0), SYSDATE, dat_, b_date, b_date,
                            nam_a_, k.r_nls, k.nbs_rez||'/'||k.ob22_rez, okpoa_, nam_b_,
                            r7702_, k.NBS_7R||'/'||k.OB22_7R, okpoa_,
                            k.kv, diff_,--(s_old_ - s_new_),
                            980,  gl.p_icurval (k.kv, diff_, dat_),
                            nazn_, userid_, 2, k.branch
                           );
                dbms_output.put_line('Уменьшение : -s_old_ + s_new_ = '||to_char(diff_));
                 error_str := error_str||'9';
                --END IF;--IF mode_ = 0



        end if; --if fl = 0

    exception when others then
      rollback to sp;
    p_error( 9, null,null, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ,
                      k.kv, null, k.sz,
                     k.NBS_REZ||'/'||k.OB22_REZ||','||k.NBS_7r||'/'|| k.OB22_7r||
                     substr(sqlerrm,instr(sqlerrm,':')+1),
                     error_str
                 );
                 dbms_output.put_line('ERROR '||substr(sqlerrm,instr(sqlerrm,':')+1));
                 dbms_output.put_line('ERROR '||error_str);
    end;
--end if;
  end loop;

  --commit;
  s_new_ := 0;
  select count(*) into s_new_
  from  srezerv_errors;

  IF mode_ = 0
      THEN
         UPDATE rez_protocol
            SET userid = nvl(p_user, user_id)--userid_
          WHERE dat = dat_;

         IF SQL%ROWCOUNT = 0
         THEN
            INSERT INTO rez_protocol
                        (userid, dat
                        )
                 VALUES (/*userid_*/nvl(p_user, user_id), dat_
                        );
         END IF;
  END IF;

  --rez.p_unload_data;

END REZ_PAY_OB22  ;
/
show err;

PROMPT *** Create  grants  REZ_PAY_OB22 ***
grant EXECUTE                                                                on REZ_PAY_OB22    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on REZ_PAY_OB22    to RCC_DEAL;
grant EXECUTE                                                                on REZ_PAY_OB22    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/REZ_PAY_OB22.sql =========*** End 
PROMPT ===================================================================================== 
