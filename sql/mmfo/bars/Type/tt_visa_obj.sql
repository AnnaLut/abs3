
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/tt_visa_obj.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.TT_VISA_OBJ as object(
  ref       number,
  err       number,
  erm       varchar2(2000),
  grp       number,
  f_pay     integer,
  f_sign    integer,
  sign_bufs tt_str_array
);
/

 show err;
 
PROMPT *** Create  grants  TT_VISA_OBJ ***
grant EXECUTE                                                                on TT_VISA_OBJ     to PUBLIC;
grant EXECUTE                                                                on TT_VISA_OBJ     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/tt_visa_obj.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 