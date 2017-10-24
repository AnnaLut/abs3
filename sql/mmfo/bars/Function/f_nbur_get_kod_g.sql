
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nbur_get_kod_g.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NBUR_GET_KOD_G (p_ref in number) return varchar2
is
    l_kod_g     varchar2(3);
    l_swift_k   varchar2 (12);
begin
   for k in (select * from operw where ref = p_ref)
   loop

      -- с 01.08.2012 добавляется код страны отправителя или получателя перевода
      if k.tag like 'n%' and substr(trim(k.value),1,1) in ('O','P','О','П')
      then
         l_kod_g := substr(trim(k.value),2,3);
      end if;

      if l_kod_g is null and k.tag like 'n%' and substr(trim(k.value),1,1) not in ('O','P','О','П')
      then
         l_kod_g := substr(trim(k.value),1,3);
      end if;

      if l_kod_g is null and k.tag like 'D6#70%' and substr(trim(k.value),1,1) in ('O','P','О','П')
      then
         l_kod_g := substr(trim(k.value),2,3);
      end if;

      if l_kod_g is null and k.tag like 'D6#70%' and substr(trim(k.value),1,1) not in ('O','P','О','П')
      then
         l_kod_g := substr(trim(k.value),1,3);
      end if;

      if l_kod_g is null and k.tag like 'D6#E2%' and substr(trim(k.value),1,1) in ('O','P','О','П')
      then
         l_kod_g := substr(trim(k.value),2,3);
      end if;

      if l_kod_g is null and k.tag like 'D6#E2%' and substr(trim(k.value),1,1) not in ('O','P','О','П')
      then
         l_kod_g := substr(trim(k.value),1,3);
      end if;

      if l_kod_g is null and k.tag like 'D1#E9%' and substr(trim(k.value),1,1) in ('O','P','О','П')
      then
         l_kod_g := substr(trim(k.value),2,3);
      end if;

      if l_kod_g is null and k.tag like 'D1#E9%' and substr(trim(k.value),1,1) not in ('O','P','О','П')
      then
         l_kod_g := substr(trim(k.value),1,3);
      end if;

      if l_kod_g is null and k.tag like 'KOD_G'
      then
         l_kod_g := substr(trim(k.value),1,3);
      end if;

      if l_kod_g is null and k.tag like '50F' then
          if instr(upper(trim(k.value)),'3/UA') > 0
          then
             l_kod_g := '804';
          else
             l_swift_k := substr(trim(k.value), instr(UPPER(trim(k.value)),'3/')+2, 2);

             BEGIN
                 SELECT k040
                    INTO l_kod_g
                 FROM RC_BNK
                 WHERE SWIFT_CODE LIKE l_swift_k||'%'
                   AND ROWNUM = 1;
             exception
                when no_data_found then
                    null;
             end;
          end if;
      end if;

      if l_kod_g is null and k.tag like '52A' then
          if length(trim(k.value)) between 3 and 10 then
             l_swift_k := substr(trim(k.value), 1, 10);
          elsif length(trim(k.value)) > 10 then
             l_swift_k := substr(trim(k.value), 10, 10);
          end if;

          BEGIN
             SELECT k040
                INTO l_kod_g
             FROM RC_BNK
             WHERE SWIFT_CODE LIKE l_swift_k||'%'
               AND ROWNUM = 1;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             l_swift_k := substr(l_swift_k,1,4)||' '||substr(l_swift_k,5,2)||
                       ' '||substr(l_swift_k,7,2);
             BEGIN
                SELECT k040
                   INTO l_kod_g
                FROM RC_BNK
                WHERE SWIFT_CODE LIKE l_swift_k||'%'
                  AND ROWNUM = 1;
             EXCEPTION WHEN NO_DATA_FOUND THEN
                null;
             END;
          end;
      end if;
   end loop;

-- if p_value_ is null
-- then
--    begin
--       SELECT substr(trim(value), 6, 11)
--           INTO bic_code
--        FROM OPERW
--        WHERE REF = REFD_
--          AND value like '%52A%'
--          AND length(trim(value)) > 3
--          AND instr(trim(value),'F52A:/') = 0 AND
--              ROWNUM = 1;
--
--      SELECT trim(b.k040)
--      INTO p_value_
--        from SW_BANKS a, kl_k040 b
--        where a.bic = bic_code and
--            b.A2(+) = substr(a.bic, 5,2) AND
--            ROWNUM = 1;
--    EXCEPTION WHEN NO_DATA_FOUND THEN
--            null;
--    end;
-- end if;
--
-- if p_value_ is null
-- then
--    BEGIN
--      SELECT substr(trim(value), 8, 2)
--         INTO swift_k_
--      FROM OPERW
--      WHERE REF = REFD_
--      AND value like '%52D:/%'
--      AND length(trim(value)) > 3
--      AND ROWNUM = 1;
--
--      BEGIN
--         SELECT k040
--            INTO p_value_
--         FROM KL_K040
--         WHERE A2 = swift_k_
--           AND ROWNUM = 1;
--      EXCEPTION WHEN NO_DATA_FOUND THEN
--            null;
--      end;
--    EXCEPTION WHEN NO_DATA_FOUND THEN
--        null;
--    end;
-- end if;

   return trim(lpad(l_kod_g, 3, '0'));
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nbur_get_kod_g.sql =========*** E
 PROMPT ===================================================================================== 
 