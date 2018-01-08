
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/tt_visa_ecp_data_array.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.TT_VISA_ECP_DATA_ARRAY is table of tt_visa_ECP_data_obj;
/

 show err;
 
PROMPT *** Create  grants  TT_VISA_ECP_DATA_ARRAY ***
grant EXECUTE                                                                on TT_VISA_ECP_DATA_ARRAY to PUBLIC;
grant EXECUTE                                                                on TT_VISA_ECP_DATA_ARRAY to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/tt_visa_ecp_data_array.sql =========***
 PROMPT ===================================================================================== 
 