
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_rko_posfio.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_RKO_POSFIO (p_par NUMBER, p_rnk NUMBER, p_row NUMBER)
   RETURN VARCHAR
IS
   l_name_r       v_rko_cust_signatory.name_r%TYPE;
   l_position_r   v_rko_cust_signatory.position_r%TYPE;
   l_doc_tp       v_rko_cust_signatory.doc_tp%TYPE;
   l_doc_tp_id    v_rko_cust_signatory.doc_tp_id%TYPE;
   l_position     v_rko_cust_signatory.position%TYPE;
   l_trust_regnum v_rko_cust_signatory.trust_regnum%TYPE;
   l_trust_regdat varchar2(20);
   l_shot_fio     VARCHAR2 (100);
   l_txt          VARCHAR2 (4000);

BEGIN
    IF p_par=0 THEN

                SELECT  name_r, position_r, doc_tp, doc_tp_id, trust_regnum, f_dat_lit(trust_regdat)
                INTO    l_name_r, l_position_r,  l_doc_tp, l_doc_tp_id, l_trust_regnum, l_trust_regdat
                FROM    v_rko_cust_signatory
                WHERE   rnk=p_rnk
                AND     rw_num=p_row;

                if l_doc_tp_id=1 then
                 l_txt:=substr(l_position_r||' '|| l_name_r||', яка(ий) діє на підставі '||l_doc_tp,1,4000);
                else l_txt:=substr(l_position_r||' '|| l_name_r||', яка(ий) діє на підставі '||l_doc_tp||' '||l_trust_regnum||' від '||l_trust_regdat,1,4000);
                end if;

    ELSIF  p_par=1 THEN

                SELECT
                        CASE
                          WHEN last_name IS NOT NULL THEN
                             CASE
                                WHEN first_name IS NOT NULL AND LENGTH (last_name) >= 3 THEN
                                   CASE
                                      WHEN middle_name IS NOT NULL THEN
                                           last_name ||' '|| SUBSTR (first_name, 1, 1) || '. ' || SUBSTR (middle_name, 1, 1) || '.'
                                      ELSE last_name ||' '|| SUBSTR (first_name, 1, 1) || '. '
                                   END
                                 ELSE last_name
                             END
                        END  shot_fio, position
                INTO    l_shot_fio, l_position
                FROM    v_rko_cust_signatory
                WHERE   rnk=p_rnk
                AND     rw_num=p_row;

                l_txt:=SUBSTR(l_position||' '||l_shot_fio,1,100);
               -- l_txt:=SUBSTR(l_shot_fio,1,100);

    END IF;
RETURN  (l_txt);

END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_rko_posfio.sql =========*** E
 PROMPT ===================================================================================== 
 