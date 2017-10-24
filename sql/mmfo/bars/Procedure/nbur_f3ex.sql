

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_F3EX.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_F3EX ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_F3EX 
( p_rpt_dt      in     date
, p_kf          in     varchar2
, p_scheme      in     varchar2 default 'C'
) is
  /*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % DESCRIPTION : Процедура формирования @75 для Ощадного банку
  % COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
  %
  % VERSION     : v.1  20.12.2016
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  l_nbuc          varchar2(20);
  l_type          number;
--l_datez         date;
  l_file_code     varchar2(2) := '3E';
BEGIN
  
  bars_audit.info( $$PLSQL_UNIT||' begin for date = '||to_char(p_rpt_dt,'dd.mm.yyyy') );
  
  bars_audit.info( $$PLSQL_UNIT||' end for date = '||to_char(p_rpt_dt, 'dd.mm.yyyy') );
  
end NBUR_F3EX;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_F3EX.sql =========*** End ***
PROMPT ===================================================================================== 
