PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/type/T_ow_iicfiles_form.sql =======*** Run *
PROMPT ===================================================================================== 
 
create or replace type T_ow_iicfiles_form  FORCE as object
(
-- Author  : OLEH.YAROSHENKO
-- Created : 4/20/2018 9:59:37 AM
-- Purpose : 

-- Attributes
	acc        number(22),
	REF        number(22),
	dk         number(1),
	tt         char(3),
	mfoa       VARCHAR2(12),
	nlsa       VARCHAR2(15),
	nlsb       VARCHAR2(15),
	s          number(24),
	vdat       date,
	nazn       varchar2(160),
	w4_msgcode varchar2(220),
	tt_asg     char(3),
	kv         integer

)
/

show err;
 
PROMPT *** Create  grants  T_ow_iicfiles_form ***
grant EXECUTE  on T_ow_iicfiles_form to WR_ALL_RIGHTS;
 
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/type/T_ow_iicfiles_form.sql =======*** End *
PROMPT ===================================================================================== 
