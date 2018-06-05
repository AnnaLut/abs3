SET DEFINE OFF; 

begin
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, OPT, STATUS, 
    EMPTY, SEQSTAT, SPEC, DTMTAG, MTDTAG, 
    NAME, EDITVAL, TAG)
 Values
   (202, 12, 'A', 'a', 'M', 
    'N', 'M', 'Y', '50a  ', '50a  ', 
    'Ordering Customer', 'Y', '50');
  exception when dup_val_on_index then null;  
end;
/    
COMMIT
/

begin
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, STATUS, EMPTY, 
    SEQSTAT, TRANS, SPEC, DTMTAG, MTDTAG, 
    NAME, EDITVAL, TAG)
 Values
   (202, 13, 'A', 'O', 'N', 
    'M', 'Y', 'Y', '70   ', '70   ', 
    'Remittance Information', 'Y', '70');
  exception when dup_val_on_index then null;  
end;
/    
COMMIT
/

begin
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, OPT, STATUS, EMPTY, 
    SEQSTAT, DTMTAG, MTDTAG, NAME, EDITVAL, 
    TAG)
 Values
   (202, 14, 'A', 'a', 'M', 'N', 
    'M', '59a  ', '59a  ', 'Beneficiary Customer - BIC', 'Y', 
    '59');
  exception when dup_val_on_index then null;  
end;
/    
COMMIT
/

begin
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 12, 'F', 'Y', 'Ordering customer - ID');
  exception when dup_val_on_index then null;  
end;
/    
COMMIT
/
begin   
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 14, 'A', 'Y', 'Beneficiary Customer BIC');
  exception when dup_val_on_index then null;  
end;
/    
COMMIT
/

update sw_model s
set status='O'
where mt='202' and tag='72';

commit;




DELETE FROM SW_MODEL_OPT
WHERE MT=202;

delete from sw_model
where mt=202;

Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, STATUS, EMPTY, 
    SEQSTAT, DTMTAG, MTDTAG, NAME, EDITVAL, 
    TAG)
 Values
   (202, 1, 'A', 'M', 'N', 
    'M', '20   ', '20   ', 'Transaction Reference Number', 'Y', 
    '20');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, STATUS, EMPTY, 
    SEQSTAT, SPEC, DTMTAG, MTDTAG, NAME, 
    EDITVAL, TAG)
 Values
   (202, 2, 'A', 'M', 'N', 
    'M', 'Y', '21   ', '21   ', 'Related Reference', 
    'Y', '21');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, OPT, STATUS, 
    EMPTY, SEQSTAT, RPBLK, DTMTAG, MTDTAG, 
    NAME, EDITVAL, TAG)
 Values
   (202, 3, 'A', 'C', 'O', 
    'N', 'M', 'RI', '13C  ', '13C  ', 
    'Time indication', 'Y', '13');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, OPT, STATUS, 
    EMPTY, SEQSTAT, SPEC, DTMTAG, MTDTAG, 
    NAME, EDITVAL, TAG)
 Values
   (202, 4, 'A', 'A', 'M', 
    'N', 'M', 'Y', '32A  ', '32A  ', 
    'Value Date, Currency Code, Amount', 'Y', '32');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, OPT, STATUS, 
    EMPTY, SEQSTAT, DTMTAG, MTDTAG, NAME, 
    EDITVAL, TAG)
 Values
   (202, 5, 'A', 'a', 'O', 
    'N', 'M', '52a  ', '52a  ', 'Ordering Institution', 
    'Y', '52');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, OPT, STATUS, 
    EMPTY, SEQSTAT, DTMTAG, MTDTAG, NAME, 
    EDITVAL, TAG)
 Values
   (202, 6, 'A', 'a', 'O', 
    'N', 'M', '53a  ', '53a  ', 'Sender''s Correspondent', 
    'Y', '53');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, OPT, STATUS, 
    EMPTY, SEQSTAT, DTMTAG, MTDTAG, NAME, 
    EDITVAL, TAG)
 Values
   (202, 7, 'A', 'a', 'O', 
    'N', 'M', '54a  ', '54a  ', 'Receiver''s Correspondent', 
    'Y', '54');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, OPT, STATUS, 
    EMPTY, SEQSTAT, DTMTAG, MTDTAG, NAME, 
    EDITVAL, TAG)
 Values
   (202, 8, 'A', 'a', 'O', 
    'N', 'M', '56a  ', '56a  ', 'Intermediary', 
    'Y', '56');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, OPT, STATUS, 
    EMPTY, SEQSTAT, DTMTAG, MTDTAG, NAME, 
    EDITVAL, TAG)
 Values
   (202, 9, 'A', 'a', 'O', 
    'N', 'M', '57a  ', '57a  ', 'Account With Institution', 
    'Y', '57');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, OPT, STATUS, 
    EMPTY, SEQSTAT, DTMTAG, MTDTAG, NAME, 
    EDITVAL, TAG)
 Values
   (202, 10, 'A', 'a', 'M', 
    'N', 'M', '58a  ', '58a  ', 'Beneficiary Institution', 
    'Y', '58');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, OPT, STATUS, 
    EMPTY, SEQSTAT, SPEC, DTMTAG, MTDTAG, 
    NAME, EDITVAL, TAG)
 Values
   (202, 11, 'A', 'a', 'M', 
    'N', 'M', 'Y', '50a  ', '50a  ', 
    'Ordering Customer', 'Y', '50');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, OPT, STATUS, 
    EMPTY, SEQSTAT, DTMTAG, MTDTAG, NAME, 
    EDITVAL, TAG)
 Values
   (202, 12, 'A', 'a', 'M', 
    'N', 'M', '59a  ', '59a  ', 'Beneficiary Customer - BIC', 
    'Y', '59');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, STATUS, EMPTY, 
    SEQSTAT, TRANS, SPEC, DTMTAG, MTDTAG, 
    NAME, EDITVAL, TAG)
 Values
   (202, 13, 'A', 'O', 'N', 
    'M', 'Y', 'Y', '70   ', '70   ', 
    'Remittance Information', 'Y', '70');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, STATUS, EMPTY, 
    SEQSTAT, TRANS, DTMTAG, MTDTAG, NAME, 
    EDITVAL, TAG)
 Values
   (202, 14, 'A', 'O', 'N', 
    'M', 'Y', '72   ', '72   ', 'Sender to Receiver Information', 
    'Y', '72');
COMMIT;

Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 5, 'D', 'Y', 'Name & Address');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 11, 'F', 'Y', 'Ordering customer - ID');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 10, 'D', 'Y', 'Name & Address');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 9, 'D', 'Y', 'Name & Address');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 9, 'B', 'Y', 'Location');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 8, 'D', 'Y', 'Name & Address');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 12, 'A', 'Y', 'Beneficiary Customer BIC');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 6, 'B', 'Y', 'Location');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 6, 'D', 'Y', 'Name & Address');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 7, 'B', 'Y', 'Location');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 7, 'D', 'Y', 'Name & Address');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, SUBNAME)
 Values
   (202, 7, 'A', 'BIC');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, SUBNAME)
 Values
   (202, 8, 'A', 'BIC');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, SUBNAME)
 Values
   (202, 9, 'A', 'BIC');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, SUBNAME)
 Values
   (202, 6, 'A', 'BIC');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, SUBNAME)
 Values
   (202, 10, 'A', 'BIC');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, SUBNAME)
 Values
   (202, 5, 'A', 'BIC');
COMMIT;


--Вставка нових додаткових реквізитів клієнта для автоформування номеру та дати договору в МТ300/320
begin
Insert into BARS.CUSTOMER_FIELD
   (TAG, NAME, B, U, F, 
    TYPE, CODE, NOT_TO_EDIT, U_NREZ, F_NREZ, 
    F_SPD)
 Values
   ('BGD  ', 'FX.Номер генеральної угоди', 1, 0, 0, 
    'S', 'GENERAL', 0, 0, 0, 
    0);
  exception when dup_val_on_index then null;  
end;
/    
COMMIT
/
begin
Insert into BARS.CUSTOMER_FIELD
   (TAG, NAME, B, U, F, 
    TYPE, CODE, NOT_TO_EDIT, U_NREZ, F_NREZ, 
    F_SPD)
 Values
   ('DGD  ', 'FX.Дата генеральної угоди', 1, 0, 0, 
    'D', 'GENERAL', 0, 0, 0, 
    0);
  exception when dup_val_on_index then null;  
end;
/    
COMMIT
/
COMMIT;



SET DEFINE on; 