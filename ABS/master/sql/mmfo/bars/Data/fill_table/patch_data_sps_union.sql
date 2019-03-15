
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_SPS_UNION.sql =========*** R
PROMPT ===================================================================================== 

Begin
   INSERT INTO SPS_UNION(UNION_ID,UNION_NAME,SPS) VALUES (1,'1',null);
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_UNION(UNION_ID,UNION_NAME,SPS) VALUES (2,'2',null);
    exception when dup_val_on_index then null;
end;
/
COMMIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_SPS_UNION.sql =========*** E
PROMPT ===================================================================================== 
