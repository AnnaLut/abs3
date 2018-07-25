begin
Insert into BARS.SW_IORULE
   (MT, IO_IND)
 Values
   (199, 'I');
exception when dup_val_on_index then null;
end;
/
begin    
Insert into BARS.SW_IORULE
   (MT, IO_IND)
 Values
   (199, 'O');
   exception when dup_val_on_index then null;
end;
/
COMMIT;
delete from sw_model where mt='199';
begin
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, STATUS, 
    EMPTY, SEQSTAT, DTMTAG, MTDTAG, NAME, 
    EDITVAL)
 Values
   (199, 1, 'A', '20', 'M', 
    'N', 'M', '20   ', '20   ', 'Transaction Reference Number', 
    'Y');
   exception when dup_val_on_index then null;
end;
/
begin    
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, STATUS, 
    EMPTY, SEQSTAT, DTMTAG, MTDTAG, NAME, 
    EDITVAL)
 Values
   (199, 2, 'A', '21', 'O', 
    'N', 'M', '21   ', '21   ', 'Related Reference', 
    'Y');
    exception when dup_val_on_index then null;
end;
/
begin
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, OPT, 
    STATUS, EMPTY, SEQSTAT, TRANS, DTMTAG, 
    MTDTAG, NAME, EDITVAL)
 Values
   (199, 3, 'A', '71', 'F', 
    'M', 'N', 'M', 'Y', '71   ', 
    '71   ', 'Details of Charges', 'Y');
    exception when dup_val_on_index then null;
end;
/
begin
Insert into BARS.SW_MODEL
   (MT, NUM, SEQ, TAG, STATUS, 
    EMPTY, SEQSTAT, TRANS, DTMTAG, MTDTAG, 
    NAME, EDITVAL)
 Values
   (199, 4, 'A', '79', 'M', 
    'N', 'M', 'Y', '79   ', '79   ', 
    'Narrative', 'Y');
    exception when dup_val_on_index then null;
end;
/
COMMIT;
