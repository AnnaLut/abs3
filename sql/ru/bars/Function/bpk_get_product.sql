
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bpk_get_product.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BPK_GET_PRODUCT (p_code in varchar2) RETURN  varchar2
IS
  v_code varchar2(32);
  n pls_integer;
BEGIN
select upper(grp) into  v_code from (select decode(substr(f.code,1,3),'OBU',grp_code||'S',grp_code) grp  from W4_acc b, w4_card c , w4_product f  where  C.CODE=B.CARD_CODE   and c.product_code=f.code and B.ACC_PK=p_code) ;
   if n > 0 then
    v_code:=rtrim(substr(p_code,1,n-1),'_');
  end if;
  RETURN v_code ;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bpk_get_product.sql =========*** En
 PROMPT ===================================================================================== 
 