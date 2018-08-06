begin
update bars.op_field set browser=
  'TagBrowse("SELECT id as code, name as txt FROM p_l_2c where id in (''3'',''5'',''6'',''7'',''8'',''9'',''A'',''B'')")'
  where TAG='KOD2C';
end;
/

begin
insert into op_field (TAG, NAME, FMT, BROWSER, NOMODIFY, VSPO_CHAR, CHKR, DEFAULT_VALUE, TYPE, USE_IN_ARCH)
values ('DE#E2', 'код переказу по плат. календарю', null, 'TagBrowse("SELECT z301,txt FROM kl_z301 where d_close is null")', null, null, null, null, null, 1);
exception when others then 
	update bars.op_field 
	   set NAME = 'код переказу по плат. календарю', 
	       FMT = null, 
		   BROWSER = 'TagBrowse("SELECT z301,txt FROM kl_z301 where d_close is null")', 
		   NOMODIFY = null,
		   VSPO_CHAR = null,
		   CHKR = null,
		   DEFAULT_VALUE = null,
		   TYPE = null,
		   USE_IN_ARCH = 1
	 where TAG='DE#E2';
end;
/
COMMIT;


