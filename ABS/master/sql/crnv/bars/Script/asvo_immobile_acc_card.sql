prompt update asvo_immobile acc_card
begin
  update asvo_immobile m
  set m.ACC_CARD = 'ä01'
  where m.ACC_CARD = 'ï¿½01';
  commit;
end;  
/
