prompt upl_sql Transfers for XRM
declare
l_descript varchar2(128) := 'Перекази для XRM';
l_sql_text clob := to_clob(q'[
select -- дані відправника
   (select bars.fio(substr(trim(value),1,70), 1) from bars.operw where tag = 'FIO' and ref = s.ref) fio1_1,
   (select bars.fio(substr(trim(value),1,70),2) from bars.operw where tag = 'FIO' and ref = s.ref) fio1_2,
   (select bars.fio(substr(trim(value),1,70),3) from bars.operw where tag = 'FIO' and ref = s.ref) fio1_3,
   (select value from bars.operw where tag = 'IDA' and ref = s.ref) ida,
   (select value from bars.operw where tag = 'NAMET' and ref = s.ref) pasp,
   (select substr(value,1,instr(value,' ')-1) from bars.operw where tag = 'PASPN' and ref = s.ref)  pasp_s,
   (select substr(value,instr(value,' ')+1) from bars.operw where tag = 'PASPN' and ref = s.ref)  pasp_n,
   (select value from bars.operw where tag = 'ATRT' and ref = s.ref)  pasp_vyd,
   (select value from bars.operw where tag = 'DATN' and ref = s.ref)  bdate,
   (select value from bars.operw where tag = 'D6#70' and ref = s.ref)  country1,
   null rnk,
   (select bars.fio(substr(trim(value),1,70),1) from bars.operw where tag = 'FIO2' and ref = s.ref)  fio2_1, -- дані отримувача
   (select bars.fio(substr(trim(value),1,70),2) from bars.operw where tag = 'FIO2' and ref = s.ref)  fio2_2,
   (select bars.fio(substr(trim(value),1,70),3) from bars.operw where tag = 'FIO2' and ref = s.ref)  fio2_3,
   (select value from bars.operw where tag = 'D6#71' and ref = s.ref)  country_r,
   (select value from bars.operw where tag = 'META' and ref = s.ref)  meta,          -- переказ (деталі)
   null mfoin,
   s.branch,
   s.tt,
   s.fdat,
   s.s_nom/100 s_nom,
   s.kv,
   cast (null as number) kp,
   cast (null as number) ok,
   case when s.tt in ('CFO', 'CFS', 'CFB') then 1 else 0 end swift,
   (select value from bars.operw where tag = 'LCSFT' and ref = s.ref)  lcsft,
   s.s_eqv/100 s_eqv,
   s.ref,
   (select substr(trim(value),1,60) from bars.operw where tag = 'MTSC' and ref = s.ref)  mtsc,
   case when lcs.type in (1, 3) then (select substr(trim(value),1,20) from bars.operw where tag = 'MTEL' and ref = s.ref) end mtel_1,
   case when lcs.type in (2)    then (select substr(trim(value),1,20) from bars.operw where tag = 'MTEL' and ref = s.ref) end mtel_2
from bars_dm.d_lcs_tt_type lcs,
( -- алгоритм взято з P_FF1_nn (F1 файл звітності)
SELECT   1 ko, -- відправка
                       o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       bars.gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                       o.nazn, o.branch
                  FROM bars.provodki_otc o
                  WHERE o.fdat = TO_DATE (:param1, 'dd/mm/yyyy')
                    AND (o.nbsd IN ('2620','2902','2924')  AND
                         o.nbsk IN ('1500','1919','2909')
                         or
                         o.nbsd IN ('1001','1002') AND
                         o.nbsk IN ('1919','2909')
                         )
              UNION
                  SELECT   1 ko,
                       o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       bars.gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                       o.nazn, o.branch
                  FROM bars.provodki_otc o, bars.kl_ff1 k
                  WHERE o.fdat = TO_DATE (:param1, 'dd/mm/yyyy')
                    AND (o.nbsd IN ('1001','1002') AND
                         o.nbsk = '2909'
                            or
                         o.nbsd IN ('2620','2902','2924') AND
                         o.nbsk IN ('1500','1919','2909'))
                    AND o.nlsd LIKE k.nlsd || '%'
                    AND o.nlsk LIKE k.nlsk || '%'
                    AND trim(k.ob22) is null
              UNION
                  SELECT   1 ko, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       bars.gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                       o.nazn, o.branch
                  FROM bars.provodki_otc o, bars.kl_ff1 k
                  WHERE o.fdat = TO_DATE (:param1, 'dd/mm/yyyy')
                    AND o.nbsd IN ('1001','1002')
                    AND o.nbsk = '2909'
                    AND o.nlsd LIKE k.nlsd || '%'
                    AND o.nlsk LIKE k.nlsk || '%'
                    AND NVL(k.ob22, o.ob22k) = o.ob22k
              UNION
              -- надходження переказiв (видача переказiв)
              SELECT   2 ko, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       bars.gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                       o.nazn, o.branch
                  FROM bars.provodki_otc o
                  WHERE o.fdat = TO_DATE (:param1, 'dd/mm/yyyy')
                    AND (o.nbsd IN ('1500','1600','2603','3720','3739','3900',
                                    '2809','2909','1919')
                    AND o.nbsk IN ('2620','2625','2924') )
              UNION
              SELECT   2 ko, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       bars.gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                       o.nazn, o.branch
                  FROM bars.provodki_otc o
                  WHERE o.fdat = TO_DATE (:param1, 'dd/mm/yyyy')
                    AND (o.nbsd IN ('2809','2909') AND
                         o.nbsk IN ('1001','1002') )
              UNION
                  SELECT   2 ko, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       bars.gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                       o.nazn, o.branch
                  FROM bars.provodki_otc o, bars.kl_ff1 k
                  WHERE o.fdat = TO_DATE (:param1, 'dd/mm/yyyy')
                    AND o.nbsd IN ('2809', '2909')
                    AND o.nbsk IN ('1001','1002')
                    AND o.nlsd LIKE k.nlsd || '%'
                    AND o.nlsk LIKE k.nlsk || '%'
                    AND trim(k.ob22) is null
              UNION
                  SELECT   2 ko, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       bars.gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                       o.nazn, o.branch
                  FROM bars.provodki_otc o, bars.kl_ff1 k
                  WHERE o.fdat = TO_DATE (:param1, 'dd/mm/yyyy')
                    AND o.nbsd IN ('1500','1600','2603', '3720','3739','3900',
                                   '2809','2909','1919')
                    AND o.nbsk IN ('2620','2625','2924')
                    AND o.nlsd LIKE k.nlsd || '%'
                    AND o.nlsk LIKE k.nlsk || '%'
                    AND trim(k.ob22) is null
              UNION
                  SELECT   2 ko, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       bars.gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                       o.nazn, o.branch
                  FROM bars.provodki_otc o, bars.kl_ff1 k
                  WHERE o.fdat = TO_DATE (:param1, 'dd/mm/yyyy')
                    -- включаем проводки вида Дт 2809, 2909 Кт 1001,1002 по значению OB22 для СБ
                    AND o.nbsd IN ('2809', '2909')
                    AND o.nbsk IN ('1001','1002','2620','2625','2902','2909','2924')
                    AND o.nlsd LIKE k.nlsd || '%'
                    AND o.nlsk LIKE k.nlsk || '%'
                    AND NVL(k.ob22,o.ob22d) = o.ob22d
                union
                     SELECT   1 ko, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       bars.gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                       o.nazn, o.branch
                  FROM bars.provodki_otc o, bars.kl_ff1 k
                  WHERE o.fdat = TO_DATE (:param1, 'dd/mm/yyyy')
                    -- включаем проводки вида Дт 1001,1002 Кт 2909 по параметру OB22 для СБ
                    AND o.nlsd LIKE k.nlsd || '%'
                    AND o.nlsk LIKE k.nlsk || '%'
                    and k.ob22 is not null
                    AND k.ob22 = o.ob22k
                    AND NVL(k.tt,o.tt) = o.tt
              UNION
                  -- надходження переказiв (видача переказiв)
                  SELECT   2 ko, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       bars.gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                       o.nazn, o.branch
                  FROM bars.provodki_otc o, bars.kl_ff1 k
                  WHERE o.fdat = TO_DATE (:param1, 'dd/mm/yyyy')
                    -- включаем проводки вида Дт 2809, 2909 Кт 1001,1002 по значению OB22 для СБ
                    AND o.nlsd LIKE k.nlsd || '%'
                    AND o.nlsk LIKE k.nlsk || '%'
                    and k.ob22 is not null
                    AND k.ob22 = o.ob22d
                    AND NVL(k.tt,o.tt) = o.tt
              UNION
              SELECT   2 ko, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       bars.gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                       o.nazn, o.branch
                  FROM bars.provodki_otc o
                  WHERE o.fdat = TO_DATE (:param1, 'dd/mm/yyyy')
                    AND o.tt = 'CNB'
                    ) s
where s.tt = lcs.tt]');
begin
    insert into upl_sql(sql_id, sql_text, descript, vers)
    values (84, l_sql_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            descript = l_descript,
            vers = '1.2'
        where sql_id = 84;
end;
/
commit;