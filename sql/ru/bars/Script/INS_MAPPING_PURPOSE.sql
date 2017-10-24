delete from BARS.INS_MAPPING_PURPOSE
where  okpo_ic in ('34538696','24175269');
/
Insert into BARS.INS_MAPPING_PURPOSE
   (OKPO_IC, MASK, EXT_ID, EXT_CODE)
 Values
   ('34538696', '��������� �����;=#contract.externalId#;�;17/02/01/01/=#contract.code#;=#contract.dateFrom#;=#contract.customer.nameLast#=#contract.customer.nameFirst#=#contract.customer.nameMiddle#;=#contract.customer.code#;=#payment.payment#', 4806, 'в�');
/
Insert into BARS.INS_MAPPING_PURPOSE
   (OKPO_IC, MASK, EXT_ID, EXT_CODE)
 Values
   ('34538696', '��������� �����;=#contract.externalId#;�;17/02/02/01/=#contract.code#;=#contract.dateFrom#;=#contract.customer.nameLast#=#contract.customer.nameFirst#=#contract.customer.nameMiddle#;=#contract.customer.code#;=#payment.payment#', 4804, 'в�');
/
Insert into BARS.INS_MAPPING_PURPOSE
   (OKPO_IC, MASK, EXT_ID, EXT_CODE)
 Values
   ('24175269', '��������� �����;=#contract.externalId#;�;21/01-22/=#contract.code#;=#contract.dateFrom#;=#contract.customer.nameLast#=#contract.customer.nameFirst#=#contract.customer.nameMiddle#;=#payment.payment#', 4802, '���');
/
Insert into BARS.INS_MAPPING_PURPOSE
   (OKPO_IC, MASK, EXT_ID, EXT_CODE)
 Values
   ('24175269', '��������� �����;=#contract.externalId#;�;21/01-21/=#contract.code#;=#contract.dateFrom#;=#contract.customer.nameLast#=#contract.customer.nameFirst#=#contract.customer.nameMiddle#;=#payment.payment#', 4800, '���');
/
COMMIT;
/