PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/prvnix_7_OPERLIST.sql =========*
PROMPT ===================================================================================== 

PROMPT *** Create/replace  ARM  $RM_KREW ***
update operlist
  set funcname = '/barsroot/credit/cck_zay.aspx?CUSTTYPE=2'
  where funcname = '/barsroot/barsweb/references/refbook.aspx?tabid=2811'||chr(38)||'mode=ro'||chr(38)||'force=1';
  
update operlist
  set funcname = '/barsroot/credit/cck_zay.aspx?CUSTTYPE=3'
  where funcname = '/barsroot/barsweb/references/refbook.aspx?tabid=2810'||chr(38)||'mode=ro'||chr(38)||'force=1';


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/prvnix_7_OPERLIST.sql =========**
PROMPT ===================================================================================== 
