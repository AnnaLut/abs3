merge into bars.ins_mapping_purpose a
     using (select '31650052' as okpo_ic,
                   'Cтраховий платіж;=#contract.externalId#;=#contract.code#;=#contract.date#;=#contract.customer.nameLast#=#contract.customer.nameFirst#=#contract.customer.nameMiddle#;=#contract.customer.code#;=#contract.customer.phone#;=#payment.payment#;=#contract.salePoint.code#'
                      as mask
              from dual) b
        on (a.okpo_ic = b.okpo_ic)
when not matched
then
   insert     (okpo_ic, mask)
       values (b.okpo_ic, b.mask)
when matched
then
   update set a.mask = b.mask;
/
commit;
/
