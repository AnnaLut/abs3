

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TII_TRUSTEE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TII_TRUSTEE ***

  CREATE OR REPLACE TRIGGER BARS.TII_TRUSTEE 
instead of insert ON BARS.TRUSTEE 
for each row
declare
  l_id number;
begin

    l_id := bars_sqnc.get_nextval('s_customer');

  insert into customer_extern (
    id, name, doc_type, doc_serial, doc_number, doc_date, doc_issuer,
    birthday, birthplace, sex, adr, tel, email,
    custtype, okpo, country, region, fs, ved, sed, ise, notes )
  values ( l_id,
    nvl(:new.fio, trim(substr(:new.last_name || ' ' || :new.first_name || ' ' || :new.middle_name,1,70))),
    :new.doc_type, :new.doc_serial, :new.doc_number,
    :new.doc_date, :new.doc_issuer, :new.birthday, :new.birthplace,
    nvl(:new.sex,0), :new.adr, :new.tel, null,
    2, null, 804, -1, '00', '00000', '00', '00000', null );

  insert into customer_rel (
    rnk, rel_id, rel_rnk,
    type_id, position, first_name, middle_name, last_name,
    document_type_id, document, trust_regnum, trust_regdat,
    bdate, edate, notary_name, notary_region,
    sign_privs, sign_id, name_r )
  values ( :new.rnk, 20, l_id,
    :new.type_id, :new.position,
    :new.first_name, :new.middle_name, :new.last_name,
    :new.document_type_id, :new.document,
    :new.trust_regnum, :new.trust_regdat, :new.bdate, :new.edate,
    :new.notary_name, :new.notary_region,
    nvl(:new.sign_privs,0), :new.sign_id, :new.name_r );

end;

/
ALTER TRIGGER BARS.TII_TRUSTEE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TII_TRUSTEE.sql =========*** End ***
PROMPT ===================================================================================== 
