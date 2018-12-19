
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/c_okpo.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.C_OKPO (id_b_ VARCHAR2,nls_ VARCHAR2) RETURN BOOLEAN
IS
--***************************************************************--
--                    Receiver's OKPO validation
--            (C) Unity-BARS Version 5.03 (02/11/2005)
--                ќщадбанк  мультић‘ќ
--***************************************************************--
okpo_    VARCHAR2(14);
c_ag_    NUMBER;
c_type_  NUMBER;
country_ VARCHAR2(4);

BEGIN
   BEGIN
      SELECT k.okpo,k.codcagent,k.custtype,k.country
        INTO   okpo_,   c_ag_,      c_type_, country_
        FROM customer k
        join cust_acc c on k.rnk = c.rnk
        join accounts a on a.acc = c.acc
       WHERE (
                (
                  a.nls = nls_
                  and ( -- COBUMMFO-10304
                        (regexp_like(a.nls, '^26[0,5]5') and dazs is null)
                        or not regexp_like(a.nls, '^26[0,5]5')
                      )
                )
                or (  -- COBUMMFO-10304
                      regexp_like(nls_, '^26[0,2,5]5')
                      and a.nlsalt = nls_
                      and a.tip like 'W4%'
                      and a.dat_alt is not null
                      and (
                             ( 
                                regexp_like(nls_, '^26[0,5]5')
                                and exists(select 1 from accounts where nls = nls_ and dazs is not null)
                             )
                             or not regexp_like(nls_, '^26[0,5]5')
                          )
                   )
             )
             AND a.kv=gl.BaseVal;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN RETURN TRUE;
   END;

   IF LTRIM(RTRIM(id_b_))=LTRIM(RTRIM(okpo_)) THEN RETURN TRUE; END IF;

-- —писок б/с непровер€емых на ќ ѕќ

     IF SUBSTR(nls_,1,4) IN ('3902','3903','3904','3905') THEN
        RETURN TRUE;
     END IF;

   IF MOD(c_ag_,2)=0 THEN -- NeresiDenty

   IF LTRIM(RTRIM(id_b_))=country_ THEN RETURN TRUE; END IF;
   ELSE
      IF id_b_='000000000'           THEN RETURN TRUE; END IF;
      IF c_type_=3 AND id_b_='99999' THEN RETURN TRUE; END IF;
   END IF;
   RETURN FALSE;
END;
/
 show err;
 
PROMPT *** Create  grants  C_OKPO ***
grant EXECUTE                                                                on C_OKPO          to ABS_ADMIN;
grant EXECUTE                                                                on C_OKPO          to BARS014;
grant EXECUTE                                                                on C_OKPO          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on C_OKPO          to TOSS;
grant EXECUTE                                                                on C_OKPO          to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/c_okpo.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 
