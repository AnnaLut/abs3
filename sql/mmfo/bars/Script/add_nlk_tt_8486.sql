
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_NLK_TT.sql =========*** Run 
PROMPT ===================================================================================== 

Begin
   INSERT INTO NLK_TT(ID,TT) VALUES ('NLL','009');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO NLK_TT(ID,TT) VALUES ('NLL','024');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO NLK_TT(ID,TT) VALUES ('NLL','PKR');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO NLK_TT(ID,TT) VALUES ('NLL','PKS');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO NLK_TT(ID,TT) VALUES ('NLL','PKX');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO NLK_TT(ID,TT) VALUES ('NLL','PS1');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO NLK_TT(ID,TT) VALUES ('NLL','PS2');
    exception when dup_val_on_index then null;
end;
/
COMMIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_NLK_TT.sql =========*** End 
PROMPT ===================================================================================== 
