
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_teller_atm_status.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_TELLER_ATM_STATUS ("CUR_CODE", "NOMINAL", "REV", "COUNT") AS 
  select x."CUR_CODE",x."NOMINAL",x."REV",x."COUNT"
from teller_atm_status t,
     xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                            'http://www.glory.co.jp/gsr.xsd' as "n"),
                             'soapenv:Envelope/soapenv:Body/n:InventoryResponse/Cash[@n:type=4]/Denomination' passing t.amount
                             columns
                             cur_code varchar2(3)  path '@n:cc',
                             nominal  varchar2(10) path '@n:fv',
                             rev      varchar2(1)  path '@n:rev',
                             count    number       path 'n:Piece'
--                             ,type     number       path '../@n:type'
             ) x
where work_date = gl.bd
  and t.equip_ip = teller_utils.get_device_url
  and x.count != 0
;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_teller_atm_status.sql =========*** En
 PROMPT ===================================================================================== 
 