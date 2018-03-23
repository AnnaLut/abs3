merge into bars.INS_TYPES a
     using (select '26' as id,
                   'Страхування від нещасного випадку (billprotect) ФО' as name,
                   'CL' as object_type
              from dual) b
        on (a.id = b.id)
when not matched
then
   insert     (id, name,object_type)
       values (b.id, b.name,b.object_type)
/
merge into bars.INS_EWA_TYPES a
     using (select 'БП' as id,
                   'Моє здоров''я' as name,
                   '26' as ext_id
              from dual) b
        on (a.id = b.id)
when not matched
then
   insert     (id,name,ext_id)
       values (b.id, b.name,b.ext_id)
/
commit;
/
delete ins_mapping_purpose
where okpo_ic=32109907;
/
merge into bars.ins_mapping_purpose a
     using (select '32109907' as okpo_ic,
                   '/= 168;СП;=#contract.code#/=#contract.date#;=#contract.date#;=#contract.customer.nameLast#=#contract.customer.nameFirst#=#contract.customer.nameMiddle#;=#contract.customer.code#;=#contract.customer.series#=#contract.customer.number#;=#contract.customer.birthDate#;=#contract.customer.phone#;=#payment.payment#;в т.ч. =#payment.commission#;=#contract.salePoint.code#;=#contract.user.externalId#'
                      as mask,
                      'ОБ' as ewa_type_id
              from dual) b
        on (a.okpo_ic = b.okpo_ic and a.mask=b.mask)
when not matched
then
   insert     (okpo_ic, mask, ewa_type_id)
       values (b.okpo_ic, b.mask, b.ewa_type_id)
when matched
then
   update set a.ewa_type_id = b.ewa_type_id;
/
commit;
/

merge into bars.ins_mapping_purpose a
     using (select '32109907' as okpo_ic,
                   '/= 169;СП;=#contract.code#/=#contract.date#;=#contract.date#;=#contract.customer.nameLast#=#contract.customer.nameFirst#=#contract.customer.nameMiddle#;=#contract.customer.code#;=#contract.customer.series#=#contract.customer.number#;=#contract.customer.birthDate#;=#contract.customer.phone#;=#payment.payment#;в т.ч. =#payment.commission#;=#contract.salePoint.code#;=#contract.user.externalId#'
                      as mask,
                      'БП' as ewa_type_id
              from dual) b
        on (a.okpo_ic = b.okpo_ic and a.ewa_type_id=b.ewa_type_id)
when not matched
then
   insert     (okpo_ic, mask, ewa_type_id)
       values (b.okpo_ic, b.mask, b.ewa_type_id)
when matched
then
   update set a.mask = b.mask;
/
commit;
/