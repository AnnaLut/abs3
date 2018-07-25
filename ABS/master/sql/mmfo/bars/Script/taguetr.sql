begin
Insert into BARS.OP_FIELD
   (TAG, NAME, VSPO_CHAR, USE_IN_ARCH)
 Values
   ('UETR ', 'SWT.Unique End2End Transaction Ref', 'F', 1);
exception when dup_val_on_index then null;
end;
/
COMMIT;
