
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_SPS_SPR.sql =========*** Run
PROMPT ===================================================================================== 

Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (0,'0','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (1,'C проверкой признака А/П по NBS','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (2,'2','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (3,'3','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (5,'5 тысяч','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (6,'Ощад + Надра','Сумма списания = Сумме на счёте минус значение поля PEREKR_B.Formula');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (7,'Надра (кратно 1 тыс. грн.)','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (8,'Ощад','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (10,'УКООП (фиксированно 10 грн.)','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (29,'Перекрытие по входящему остатку (списание ДТ)','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (39,'Сбербанк. Перекрытие с учетом неснижаемого остатка для списания по ДТ','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (40,'40 миллионов','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (86,'Перекрытие по входящему остатку (списание КТ)','РКО 8600');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (101,'ДЕМАРК сумма 55-го тарифа','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (112,'Перекрытие только дебетовых остатков','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (139,'Сбербанк. Перекрытие с учетом неснижаемого остатка для списания по ДТ по справочнику Ночной лимит','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (260,'Перекрытие счетов 3570 по ELT','PET, UPB, STL');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (763,'Перекрытие по исходящему остатку','Возможно и в локальном банк дне. С контролем равенства факт и план остатка. Используется в форексах.');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (2900,'AGI','Маржа между ГОУ и Казначейством банка');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (3570,'СберБанк','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (3579,'Для перекрытия счетов 3579','PET,UPB,STL');
    exception when dup_val_on_index then null;
end;
/
COMMIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_SPS_SPR.sql =========*** End
PROMPT ===================================================================================== 
