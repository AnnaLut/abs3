prompt update asvo_immobile acc_card
begin
  update asvo_immobile m
  set m.ACC_CARD = '�01'
  where m.ACC_CARD = '�01';
  commit;
end;  
/
