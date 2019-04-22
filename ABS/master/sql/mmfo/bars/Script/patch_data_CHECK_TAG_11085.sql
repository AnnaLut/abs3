PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Script/patch_data_CHECK_TAG_11085.sql=======
PROMPT ===================================================================================== 

Begin
	UPDATE BARS.CHECK_TAG
	   SET REQUIRED = 'N'
	 WHERE TAG_CHILD = 'DJNR ' and tt in ('CAA', 'CAB', 'CAS','CN1');
end;
/
COMMIT;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Script/patch_data_CHECK_TAG_11085.sql=======
PROMPT ===================================================================================== 
