update ps_tts set ob22='40' where tt='050' and nbs='7399';
update ps_tts set ob22='04' where tt='051' and nbs='9618';
commit; 
begin
Insert into BARS.TTSAP
   (TTAP, TT, DK)
 Values
   ('051', '050', 0);
   exception when dup_val_on_index then null; 
   end; 
/   
COMMIT;
begin
Insert into BARS.PS_TTS
   ( TT, NBS, DK)
 Values
   ('124', '1001', 1);
      exception when dup_val_on_index then null; 
   end; 
/ 
COMMIT;
begin
Insert into BARS.PS_TTS
   ( TT, NBS, DK, OB22)
 Values
   ( 'D3N', '6399', 1, 'D2');
         exception when dup_val_on_index then null; 
   end; 
/ 
COMMIT;
begin
Insert into BARS.TTSAP
   (TTAP, TT, DK)
 Values
   ('MVN', 'MUN', 0);
            exception when dup_val_on_index then null; 
   end; 
/ 
COMMIT;
begin
Insert into BARS.TTSAP
   (TTAP, TT, DK)
 Values
   ('MVN', 'MUO', 1);
            exception when dup_val_on_index then null; 
   end; 
/ 
COMMIT;
delete from ps_tts where tt='439' and nbs='3739' and ob22='03';
commit;