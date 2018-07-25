SET DEFINE OFF;

delete from sw_model_opt  where mt='202';
delete from sw_model where mt='202';
delete from sw_model_opt  where mt='202';
commit; 

Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, STATUS, 
    EMPTY, SEQSTAT, DTMTAG, MTDTAG, NAME, 
    EDITVAL)
 Values
   (202, 1, 'A', '20', 'M', 
    'N', 'M', '20   ', '20   ', 'Transaction Reference Number', 
    'Y');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, STATUS, 
    EMPTY, SEQSTAT, SPEC, DTMTAG, MTDTAG, 
    NAME, EDITVAL)
 Values
   (202, 2, 'A', '21', 'M', 
    'N', 'M', 'Y', '21   ', '21   ', 
    'Related Reference', 'Y');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, OPT, 
    STATUS, EMPTY, SEQSTAT, RPBLK, DTMTAG, 
    MTDTAG, NAME, EDITVAL)
 Values
   (202, 3, 'A', '13', 'C', 
    'O', 'N', 'M', 'RI', '13C  ', 
    '13C  ', 'Time indication', 'Y');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, OPT, 
    STATUS, EMPTY, SEQSTAT, SPEC, DTMTAG, 
    MTDTAG, NAME, EDITVAL)
 Values
   (202, 4, 'A', '32', 'A', 
    'M', 'N', 'M', 'Y', '32A  ', 
    '32A  ', 'Value Date, Currency Code, Amount', 'Y');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, OPT, 
    STATUS, EMPTY, SEQSTAT, DTMTAG, MTDTAG, 
    NAME, EDITVAL)
 Values
   (202, 5, 'A', '52', 'a', 
    'O', 'N', 'M', '52a  ', '52a  ', 
    'Ordering Institution', 'Y');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, OPT, 
    STATUS, EMPTY, SEQSTAT, DTMTAG, MTDTAG, 
    NAME, EDITVAL)
 Values
   (202, 6, 'A', '53', 'a', 
    'O', 'N', 'M', '53a  ', '53a  ', 
    'Sender''s Correspondent', 'Y');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, OPT, 
    STATUS, EMPTY, SEQSTAT, DTMTAG, MTDTAG, 
    NAME, EDITVAL)
 Values
   (202, 7, 'A', '54', 'a', 
    'O', 'N', 'M', '54a  ', '54a  ', 
    'Receiver''s Correspondent', 'Y');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, OPT, 
    STATUS, EMPTY, SEQSTAT, DTMTAG, MTDTAG, 
    NAME, EDITVAL)
 Values
   (202, 8, 'A', '56', 'a', 
    'O', 'N', 'M', '56a  ', '56a  ', 
    'Intermediary', 'Y');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, OPT, 
    STATUS, EMPTY, SEQSTAT, DTMTAG, MTDTAG, 
    NAME, EDITVAL)
 Values
   (202, 9, 'A', '57', 'a', 
    'O', 'N', 'M', '57a  ', '57a  ', 
    'Account With Institution', 'Y');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, OPT, 
    STATUS, EMPTY, SEQSTAT, DTMTAG, MTDTAG, 
    NAME, EDITVAL)
 Values
   (202, 10, 'A', '58', 'a', 
    'M', 'N', 'M', '58a  ', '58a  ', 
    'Beneficiary Institution', 'Y');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, OPT, 
    STATUS, EMPTY, SEQSTAT, DTMTAG, MTDTAG, 
    NAME, EDITVAL)
 Values
   (202, 11, 'A', '50', 'a', 
    'O', 'N', 'M', '50a  ', '50a  ', 
    'Ordering Customer', 'Y');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, STATUS, 
    EMPTY, SEQSTAT, DTMTAG, MTDTAG, NAME, 
    EDITVAL)
 Values
   (202, 12, 'A', '59', 'O', 
    'N', 'M', '59   ', '59   ', 'Beneficiary Customer - BIC', 
    'Y');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, STATUS, 
    EMPTY, SEQSTAT, TRANS, DTMTAG, MTDTAG, 
    NAME, EDITVAL)
 Values
   (202, 13, 'A', '70', 'O', 
    'N', 'M', 'Y', '70   ', '70   ', 
    'Remittance Information', 'Y');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, STATUS, 
    EMPTY, SEQSTAT, TRANS, DTMTAG, MTDTAG, 
    NAME, EDITVAL)
 Values
   (202, 14, 'A', '72', 'O', 
    'N', 'M', 'Y', '72   ', '72   ', 
    'Sender to Receiver Information', 'Y');
COMMIT;

Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, SUBNAME)
 Values
   (202, 5, 'A', 'BIC');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 5, 'D', 'Y', 'Name & Address');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, SUBNAME)
 Values
   (202, 6, 'A', 'BIC');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 6, 'B', 'Y', 'Location');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 6, 'D', 'Y', 'Name & Address');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, SUBNAME)
 Values
   (202, 7, 'A', 'BIC');
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
   (202, 8, 'A', 'BIC');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 8, 'D', 'Y', 'Name & Address');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, SUBNAME)
 Values
   (202, 9, 'A', 'BIC');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 9, 'B', 'Y', 'Location');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 9, 'D', 'Y', 'Name & Address');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, SUBNAME)
 Values
   (202, 10, 'A', 'BIC');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 10, 'D', 'Y', 'Name & Address');
Insert into BARS.SW_MODEL_OPT
   (MT, NUM, OPT, TRANS, SUBNAME)
 Values
   (202, 11, 'F', 'Y', 'Ordering customer - ID');
COMMIT;


SET DEFINE on;