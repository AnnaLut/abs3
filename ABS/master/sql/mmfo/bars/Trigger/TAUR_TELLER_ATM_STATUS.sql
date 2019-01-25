
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/trigger/taur_teller_atm_status.sql =========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TRIGGER BARS.TAUR_TELLER_ATM_STATUS 
  before update  of AMOUNT on TELLER_ATM_STATUS
  for each row
declare
begin
  for r in (select prev.cur_code, sum(prev.nominal * (curr.pieces-prev.pieces))  amn
              from xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                          'http://www.glory.co.jp/gsr.xsd' as "n"),
                           'soapenv:Envelope/soapenv:Body/n:InventoryResponse/Cash/Denomination' passing :old.amount
                           columns
                             cur_code varchar2(3) path '@n:cc',
                             nominal  number      path '@n:fv',
                             pieces   number      path 'n:Piece') prev,
                   xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                          'http://www.glory.co.jp/gsr.xsd' as "n"),
                           'soapenv:Envelope/soapenv:Body/n:InventoryResponse/Cash/Denomination' passing :new.amount
                           columns
                             cur_code varchar2(3) path '@n:cc',
                             nominal  number      path '@n:fv',
                             pieces   number      path 'n:Piece') curr
              where prev.cur_code = curr.cur_code
                and prev.nominal = curr.nominal
                and prev.pieces != curr.pieces
              group by prev.cur_code)
  loop
    teller_soap_api.save_atm_oper(r.cur_code, r.amn);
  end loop;
  
end taur_teller_atm_status;

/
ALTER TRIGGER BARS.TAUR_TELLER_ATM_STATUS ENABLE;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/trigger/taur_teller_atm_status.sql =========
 PROMPT ===================================================================================== 
 