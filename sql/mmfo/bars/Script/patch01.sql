update tts
  set nazn = null
where tt = '061';
commit;  



begin
Insert into BARS.TIPS (TIP, NAME, ORD)
 Values ('NLG', 'NLG Рахунки для картотеки WEB', 701);
exception when dup_val_on_index then null;
end;

/
COMMIT;
