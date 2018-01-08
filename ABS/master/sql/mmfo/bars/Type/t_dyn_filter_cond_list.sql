
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_dyn_filter_cond_list.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_DYN_FILTER_COND_LIST as table of t_dyn_filter_cond_line
/**
  *  Filename: <b>\KRN\Sql\Bars\Type\t_dyn_filter_cond_list.sql </b>    <br/>
  *  Project : <b>ALL</b>  			                                        <br/>
  *  Module  : <b>BMD </b>                                              <br/>
  *  Description: <em>Колекція для формування фільтру користувача</em>  <br/>
  *  Developer(s): <em>vitalii.khomida</em><br/>                        <br/>
  *  Copyright (c) 2016, unity-bars, Inc. All rights reserved.          <br/>
*/;
/

 show err;
 
PROMPT *** Create  grants  T_DYN_FILTER_COND_LIST ***
grant EXECUTE                                                                on T_DYN_FILTER_COND_LIST to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_dyn_filter_cond_list.sql =========***
 PROMPT ===================================================================================== 
 