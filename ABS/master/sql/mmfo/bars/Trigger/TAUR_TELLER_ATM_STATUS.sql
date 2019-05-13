
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/trigger/taur_teller_atm_status.sql =========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TRIGGER BARS.TAUR_TELLER_ATM_STATUS 
  before update on TELLER_ATM_STATUS
  for each row
declare
  v_num number;
begin
logger.info('Teller : '||:new.amount_time||', old=  '||:old.amount_time);
  select sum(t.nominal * t.pieces) 
    into v_num
    from xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                          'http://www.glory.co.jp/gsr.xsd' as "n"),
                           'soapenv:Envelope/soapenv:Body/n:InventoryResponse/Cash[@n:type=3]/Denomination' passing :old.amount
                           columns
                             cur_code varchar2(3) path '@n:cc',
                             nominal  number      path '@n:fv',
                             pieces   number      path 'n:Piece') t;
logger.info('Teller.atm.old = '||v_num);
  select sum(t.nominal * t.pieces) 
    into v_num
    from xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                          'http://www.glory.co.jp/gsr.xsd' as "n"),
                           'soapenv:Envelope/soapenv:Body/n:InventoryResponse/Cash[@n:type=3]/Denomination' passing :new.amount
                           columns
                             cur_code varchar2(3) path '@n:cc',
                             nominal  number      path '@n:fv',
                             pieces   number      path 'n:Piece') t;

logger.info('Teller.atm.new = '||v_num);
                             
  for r in (select prev.cur_code, sum(prev.nominal * (curr.pieces-prev.pieces))  amn, sum(prev.nominal * prev.pieces) old_amn,
                                  sum(prev.nominal * curr.pieces) new_amn
              from xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                          'http://www.glory.co.jp/gsr.xsd' as "n"),
                           'soapenv:Envelope/soapenv:Body/n:InventoryResponse/Cash[@n:type=3]/Denomination' passing :old.amount
                           columns
                             cur_code varchar2(3) path '@n:cc',
                             nominal  number      path '@n:fv',
                             pieces   number      path 'n:Piece') prev,
                   xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                          'http://www.glory.co.jp/gsr.xsd' as "n"),
                           'soapenv:Envelope/soapenv:Body/n:InventoryResponse/Cash[@n:type=3]/Denomination' passing :new.amount
                           columns
                             cur_code varchar2(3) path '@n:cc',
                             nominal  number      path '@n:fv',
                             pieces   number      path 'n:Piece') curr
              where prev.cur_code = curr.cur_code
                and prev.nominal = curr.nominal
                and prev.pieces != curr.pieces
              group by prev.cur_code)
  loop
    logger.info('Teller ATM old = '||r.old_amn||', new = '||r.new_amn);
    teller_soap_api.save_atm_oper(r.cur_code, r.amn);
  end loop;

end taur_teller_atm_status;

/
ALTER TRIGGER BARS.TAUR_TELLER_ATM_STATUS ENABLE;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/trigger/taur_teller_atm_status.sql =========
 PROMPT ===================================================================================== 
 