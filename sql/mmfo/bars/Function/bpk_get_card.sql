
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bpk_get_card.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BPK_GET_CARD (p_code in varchar2) RETURN  varchar2
IS
  v_code varchar2(100);

BEGIN
 select upper(sub_code) into  v_code from W4_acc b, w4_card c , w4_product f  where  C.CODE=B.CARD_CODE   and c.product_code=f.code and B.ACC_PK=p_code ;

 if instr(v_code,'_') <> 0 then
   v_code:=substr(v_code,1,instr(v_code,'_')-1);
 END if;


 if (v_code like '%CC') or (v_code like '%PP') or (v_code like '%PW') then
   v_code:=substr(v_code,1,length(v_code)-2);
 END if;

 RETURN v_code ;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bpk_get_card.sql =========*** End *
 PROMPT ===================================================================================== 
 