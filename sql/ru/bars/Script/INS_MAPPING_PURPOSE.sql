delete from BARS.INS_MAPPING_PURPOSE
where  okpo_ic in ('34538696','24175269');
/
Insert into BARS.INS_MAPPING_PURPOSE
   (OKPO_IC, MASK, EXT_ID, EXT_CODE)
 Values
   ('34538696', 'Страховий платіж;=#contract.externalId#;Н;17/02/01/01/=#contract.code#;=#contract.dateFrom#;=#contract.customer.nameLast#=#contract.customer.nameFirst#=#contract.customer.nameMiddle#;=#contract.customer.code#;=#payment.payment#', 4806, 'РІР');
/
Insert into BARS.INS_MAPPING_PURPOSE
   (OKPO_IC, MASK, EXT_ID, EXT_CODE)
 Values
   ('34538696', 'Страховий платіж;=#contract.externalId#;Н;17/02/02/01/=#contract.code#;=#contract.dateFrom#;=#contract.customer.nameLast#=#contract.customer.nameFirst#=#contract.customer.nameMiddle#;=#contract.customer.code#;=#payment.payment#', 4804, 'РІР');
/
Insert into BARS.INS_MAPPING_PURPOSE
   (OKPO_IC, MASK, EXT_ID, EXT_CODE)
 Values
   ('24175269', 'Страховий платіж;=#contract.externalId#;Н;21/01-22/=#contract.code#;=#contract.dateFrom#;=#contract.customer.nameLast#=#contract.customer.nameFirst#=#contract.customer.nameMiddle#;=#payment.payment#', 4802, 'ВЗР');
/
Insert into BARS.INS_MAPPING_PURPOSE
   (OKPO_IC, MASK, EXT_ID, EXT_CODE)
 Values
   ('24175269', 'Страховий платіж;=#contract.externalId#;Н;21/01-21/=#contract.code#;=#contract.dateFrom#;=#contract.customer.nameLast#=#contract.customer.nameFirst#=#contract.customer.nameMiddle#;=#payment.payment#', 4800, 'ВЗР');
/
COMMIT;
/