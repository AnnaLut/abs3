create or replace package bars.xrm_maintenance
is
   g_head_version   constant varchar2 (64) := 'version 1.0 10.10.2017';

   --
   -- ïàêåò îáñëóæèâàíèÿ ôóíêöèîíàëà ñåğâèñà  XRMIntegrationCreateDocuments
   --

   function add_ru_tail (p_id number, p_mfo varchar2 default null)
      return number;

   function cut_off_ru_tail (p_id number)
      return number;

   function packing (p_body in clob)
      return clob;

   function unpacking (p_body in clob)
      return clob;
end xrm_maintenance;
/

create or replace package body bars.xrm_maintenance
is
   g_body_version   constant varchar2 (64) := 'version 1.0 10.10.2017';

   g_p_name         constant varchar2 (15) := 'xrm_maintenance';

   g_err_mod        constant varchar2 (3) := 'XRM';

   g_engname_char   constant varchar2 (100) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890/-.';
   g_fio_char       constant varchar2 (100)
      :=    'ÀÁÂÃÄÅ¨ÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞß'
         || 'ÀÁÂÃ¥ÄÅªÆÇÈ²¯ÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÜŞß'
         || chr (39)
         || '-'
         || ' '
         || 'ABCDEFGHIJKLMNOPQRSTUVWXYZ''"`' ;
   g_email_char     constant varchar2 (100) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@-._';
   g_digit          constant varchar2 (100) := '1234567890';


   procedure init
   is
   begin
      null;
   end;

   function add_ru_tail (p_id number, p_mfo varchar2 default null)
      return number
   is
      l_ru_tail   varchar2 (2);
      l_mfo       varchar2 (6);
   begin
      if getglobaloption ('IS_MMFO') = '1'
      then
         if p_mfo is null
         then
            l_mfo := f_ourmfo;
         else
            l_mfo := p_mfo;
         end if;

         select ru
           into l_ru_tail
           from kf_ru
          where kf = l_mfo;

         return p_id || l_ru_tail;
      else
         return p_id;
      end if;
   end add_ru_tail;

   function cut_off_ru_tail (p_id number)
      return number
   is
   begin
      if getglobaloption ('IS_MMFO') = '1'
      then
         return substr (p_id, 1, length (p_id) - 2);
      else
         return p_id;
      end if;
   end cut_off_ru_tail;


   function unpacking (p_body in clob)
      return clob
   is
      l_blob   blob;
   begin
      l_blob := lob_utl.decode_base64 (p_body);
      l_blob := utl_compress.lz_uncompress (l_blob);
      return lob_utl.blob_to_clob (l_blob);
   end;

   function packing (p_body in clob)
      return clob
   is
      l_blob   blob;
   begin
      l_blob := lob_utl.clob_to_blob (p_body);
      l_blob := utl_compress.lz_compress (l_blob);
      return lob_utl.encode_base64 (l_blob);
   end packing;
begin
   init;
end xrm_maintenance;
/

show err;
/

grant execute on xrm_maintenance to bars_access_defrole;
/