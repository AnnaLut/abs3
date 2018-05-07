PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/type/T_ow_iicfiles_oper.sql =======*** Run *
PROMPT ===================================================================================== 
 
create or replace type T_ow_iicfiles_oper FORCE as object
(
-- Author  : OLEH.YAROSHENKO
-- Created : 4/20/2018 9:59:37 AM
-- Purpose : 

-- Attributes
   REF         number(22),
   dk          number(1),
   tt          char(3),
   mfoa        VARCHAR2(12),
   mfob        VARCHAR2(12),
   nlsa        VARCHAR2(15),
   nlsb        VARCHAR2(15),
   s           number(24),
   s2          number(24),
   vdat        date,
   nazn        varchar2(160),
   kv          integer,
	nextvisagrp varchar2(4),
	sos         number(2)
)
/

show err;
 
PROMPT *** Create  grants  T_ow_iicfiles_oper ***
grant EXECUTE  on T_ow_iicfiles_oper to WR_ALL_RIGHTS;
 
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/type/T_ow_iicfiles_oper.sql =======*** End *
PROMPT ===================================================================================== 
