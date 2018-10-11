create or replace function sdo_autopay_check_cl (p_nls_a oper.nlsa%type,
                                                 p_mfo_a oper.mfoa%type,
                                                 p_nls_b oper.nlsa%type,
                                                 p_mfo_b oper.mfoa%type,
                                                 p_s     oper.s%type,
                                                 p_nazn  oper.nazn%type,
                                                 p_id_a  oper.id_a%type,
                                                 p_id_b  oper.id_b%type) return smallint is
begin
 return 0;
end;
/