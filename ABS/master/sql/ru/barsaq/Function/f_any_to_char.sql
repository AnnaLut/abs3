
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/function/f_any_to_char.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARSAQ.F_ANY_TO_CHAR (data in sys.anydata) return clob
is
   tn     varchar2 (61);
   str    varchar2 (32767);
   CH     char (2000);
   num    number;
   dat    date;
   rw     raw (4000);
   res    number;
   clb    clob;
begin
   clb := '';
   if data is null
   then
      clb := 'NULL value' || chr(10);
      return clb;
   end if;

   tn := data.gettypename ();

   if tn = 'SYS.VARCHAR2'
   then
      res := data.getvarchar2 (str);
      clb := clb || str || chr(10);
   elsif tn = 'SYS.CHAR'
   then
      res := data.getchar (CH);
      clb := clb || CH || chr(10);
   elsif tn = 'SYS.VARCHAR'
   then
      res := data.getvarchar (CH);
      clb := clb || CH || chr(10);
   elsif tn = 'SYS.NUMBER'
   then
      res := data.getnumber (num);
      clb := clb || num || chr(10);
   elsif tn = 'SYS.DATE'
   then
      res := data.getdate (dat);
      clb := clb || dat || chr(10);
   elsif tn = 'SYS.RAW'
   then
      res := data.getraw (rw);
      clb := clb || RAWTOHEX (rw) || chr(10);
   else
      clb := clb || 'typename is ' || tn || chr(10);
   end if;
   return clb;
end f_any_to_char;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/function/f_any_to_char.sql =========*** En
 PROMPT ===================================================================================== 
 