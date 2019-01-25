begin
Insert into bars.VOB
   (VOB, NAME, FLV, REP_PREFIX)
 Values
   (940, 'ГЕРЦ-Касова квитанція', 1, 'GERCKS');
exception when dup_val_on_index then null;  
end;
/
COMMIT;

update tts_vob set vob=940 where tt = 'G01';
commit;