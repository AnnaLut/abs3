
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/tt_visa_ecp_data_obj.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.TT_VISA_ECP_DATA_OBJ as object(
  ref       number,
  sign_bufs tt_str_array,
  sign_bufs_ecp tt_str_array
);
/

 show err;
 
PROMPT *** Create  grants  TT_VISA_ECP_DATA_OBJ ***
grant EXECUTE                                                                on TT_VISA_ECP_DATA_OBJ to PUBLIC;
grant EXECUTE                                                                on TT_VISA_ECP_DATA_OBJ to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/tt_visa_ecp_data_obj.sql =========*** E
 PROMPT ===================================================================================== 
 