
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bpk_get_tip.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BPK_GET_TIP (p_code in varchar2) RETURN  varchar2
IS
  v_code varchar2(100);
  n pls_integer;
BEGIN

SELECT f.name into  v_code  from  W4_acc b, w4_card c , w4_subproduct f  where  C.CODE=B.CARD_CODE  and b.ACC_PK=p_code  and c.sub_code=f.code and rownum=1;

v_code := regexp_replace(v_code,'([0-9]|[[:punct:]]|[à-ÿ]|[À-ß]|[¿³º²])','');
v_code := trim(v_code);
v_code := rtrim(v_code,'MU');
v_code := replace(v_code,'PP','PayPass');

  RETURN v_code ;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bpk_get_tip.sql =========*** End **
 PROMPT ===================================================================================== 
 