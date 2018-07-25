PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_TAG(CL_ERR) .sql =========*** Run *** =====
PROMPT ===================================================================================== 

begin
   Insert into BARS.CC_TAG  (TAG, NAME, NOT_TO_EDIT) Values ('CL_ERR', 'МБДК: Проблеми автомат.закриття договору ', 0);
exception when dup_val_on_index then null;
          when others then raise;
end;
/
COMMIT;

