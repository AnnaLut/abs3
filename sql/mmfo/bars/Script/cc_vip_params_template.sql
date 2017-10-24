begin
  execute immediate 
    'ALTER TABLE BARS.VIP_PARAMS_TEMPLATE MODIFY 
     ID_PAR CONSTRAINT CC_VPT_IDPAR_NN NOT NULL
      ENABLE VALIDATE';
exception when others then
  if sqlcode = -01442 then null; else raise; end if;
end;
/

begin
  execute immediate 
    'ALTER TABLE BARS.VIP_PARAMS_TEMPLATE ADD 
        CONSTRAINT UK_VIPPARAMSTEMPLATE
        UNIQUE (ID_PAR)
        ENABLE
        VALIDATE';
exception when others then
  if sqlcode = -02261 then null; else raise; end if;
end;
/


begin
Insert into BARS.VIP_PARAMS_TEMPLATE
   (ID_PAR, NAME_PAR, TXT, DAY)
 Values
   ('DPT_C', 'Депозити ФО закінчення', ' - останній день вкладу', '0');
EXCEPTION
              WHEN DUP_VAL_ON_INDEX
              THEN
              null;
end;
/
COMMIT;