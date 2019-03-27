
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_dyn_filter_cond_line.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_DYN_FILTER_COND_LINE as object
/**
  *  Filename: <b>\KRN\Sql\Bars\Type\t_dyn_filter_cond_list.sql </b>    <br/>
  *  Project : <b>ALL</b>  			                                        <br/>
  *  Module  : <b>BMD </b>                                              <br/>
  *  Description: <em>��'��� ��� �������� ���������� �� �������</em>    <br/>
  *  Developer(s): <em>vitalii.khomida</em><br/>                        <br/>
  *  Copyright (c) 2016, unity-bars, Inc. All rights reserved.          <br/>
*/
(
  logical_op    varchar2(24),
  colname       varchar2(30),
  relational_op varchar2(24),
  value         varchar2(200)
);
/

 show err;
 
PROMPT *** Create  grants  T_DYN_FILTER_COND_LINE ***
grant EXECUTE                                                                on T_DYN_FILTER_COND_LINE to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_dyn_filter_cond_line.sql =========***
 PROMPT ===================================================================================== 
 