delete from sw_model where mt='299';

Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, STATUS, 
    EMPTY, SEQSTAT, DTMTAG, MTDTAG, NAME, 
    EDITVAL)
 Values
   (299, 1, 'A', '20', 'M', 
    'N', 'M', '20   ', '20   ', 'Transaction Reference Number', 
    'Y');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, STATUS, 
    EMPTY, SEQSTAT, DTMTAG, MTDTAG, NAME, 
    EDITVAL)
 Values
   (299, 2, 'A', '21', 'O', 
    'N', 'M', '21   ', '21   ', 'Related Reference', 
    'Y');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, STATUS, 
    EMPTY, SEQSTAT, TRANS, DTMTAG, MTDTAG, 
    NAME, EDITVAL)
 Values
   (299, 3, 'A', '71', 'M', 
    'N', 'M', 'Y', '71   ', '71   ', 
    'Details of Charges', 'Y');
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, STATUS, 
    EMPTY, SEQSTAT, TRANS, DTMTAG, MTDTAG, 
    NAME, EDITVAL)
 Values
   (299, 4, 'A', '79', 'M', 
    'N', 'M', 'Y', '79   ', '79   ', 
    'Narrative', 'Y');
COMMIT;
