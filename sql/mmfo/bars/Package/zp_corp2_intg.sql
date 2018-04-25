PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/package/zp_corp2_intg.sql =========*** Run *** 
PROMPT ===================================================================================== 

create or replace package zp_corp2_intg
is
   g_head_version   constant varchar2 (64) := 'version 1.1 11.12.2017';

   --
   -- пакет интеграции с Corp2
   --
   -- определение версии заголовка пакета
   function header_version
      return varchar2;

   -- определение версии тела пакета
   function body_version
      return varchar2;

   function get_db_charset return varchar2;
     
   -- запрос информации о ЗП проекте из корпа2
   procedure get_zp_deal_par (p_rnk       in     customer.rnk%type,
                              p_amount    in     number,
                              p_mfo       in     number,
                              p_debt         out number,
                              p_commiss      out number,
                              p_premium      out number);

   -- отправка справочника карточных продуктов в корп2
   procedure send_cards_dictionary;

   -- пакетное открытие карт по запросу  корп2
   procedure imp_salary_cards_order (p_blob_data in blob, p_response out blob, p_mfo in varchar2, p_errmsg out varchar2);

   --импорт ведомостей
   procedure set_payrolls (p_clob_data in clob, p_clob_out out clob);

   function form_cards_dictionary return clob;

   procedure send_payrolls_result;
end;
/

create or replace package body zp_corp2_intg
is
   g_body_version   constant varchar2 (64) := 'version 1.27 26.03.2018';

   g_p_name         constant varchar2 (13) := 'zp_corp2_intg';

   g_err_mod        constant varchar2 (3) := 'PZP';

   g_engname_char   constant varchar2 (100) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890/-.';
   g_fio_char       constant varchar2 (100)
      :=    'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ'
         || 'АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯ'
         || chr (39)
         || '-' ;
   g_email_char     constant varchar2 (100) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@-.';
   g_digit          constant varchar2 (100) := '1234567890';


   type t_rec_card_order is record
   (
      id               number,
      nls_2625         varchar2 (16),
      okpo             varchar2 (14),
      first_name       varchar2 (70),
      last_name        varchar2 (70),
      middle_name      varchar2 (70),
      type_doc         number (22),
      paspseries       varchar2 (16),
      paspnum          varchar2 (16),
      paspissuer       varchar2 (128),
      paspdate         date,
      bday             date,
      country          varchar2 (3),
      resident         varchar2 (1),
      gender           varchar2 (1),
      phone_home       varchar2 (13),
      phone_mob        varchar2 (13),
      email            varchar2 (30),
      eng_first_name   varchar2 (30),
      eng_last_name    varchar2 (30),
      mname            varchar2 (20),
      addr1_cityname   varchar2 (100),
      addr1_pcode      varchar2 (10),
      addr1_domain     varchar2 (48),
      addr1_region     varchar2 (48),
      addr1_street     varchar2 (100),
      addr2_cityname   varchar2 (100),
      addr2_pcode      varchar2 (10),
      addr2_domain     varchar2 (48),
      addr2_region     varchar2 (48),
      addr2_street     varchar2 (100),
      work             varchar2 (254),
      office           varchar2 (32),
      date_w           date,
      card_code        varchar2 (32),
      okpo_w           varchar2 (32),
      rnk              number,
      rnk_proect       number,
      bpk_proect_id    number,
      str_err          varchar2 (4000),
      flag_kk          number,
      branch           varchar2 (50),
      nd               number,
      reqid            number,
      term             number
   );

   -- определение версии заголовка пакета
   function header_version
      return varchar2
   is
   begin
      return 'Package header: ' || g_head_version;
   end header_version;

   -- определение версии тела пакета
   function body_version
      return varchar2
   is
   begin
      return 'Package body  : ' || g_body_version;
   end body_version;

   procedure init
   is
   begin
      null;
   end;

   function get_db_charset return varchar2
   is 
     l_charset varchar2(256);
   begin
     select value into l_charset from nls_database_parameters where parameter = 'NLS_CHARACTERSET';
     return l_charset;
   end;

   function check_permitted_char (p_str varchar2, p_permitted_char varchar2)
      return boolean
   is
      b_check   boolean := false;
      l_char    varchar2 (1);
   begin
      for i in 1 .. length (p_str)
      loop
         b_check := false;
         l_char := substr (p_str, i, 1);

         for j in 1 .. length (p_permitted_char)
         loop
            if l_char = substr (p_permitted_char, j, 1)
            then
               b_check := true;
               exit;
            end if;
         end loop;

         if not b_check
         then
            exit;
         end if;
      end loop;

      return b_check;
   end check_permitted_char;

   -------------------------------------------------------------------------------
   function check_eng (p_str varchar2)
      return boolean
   is
   begin
      return check_permitted_char (p_str, g_engname_char);
   end check_eng;

   -------------------------------------------------------------------------------
   function check_fio (p_str varchar2)
      return boolean
   is
   begin
      return check_permitted_char (p_str, g_fio_char);
   end check_fio;

   -------------------------------------------------------------------------------
   function check_email (p_str varchar2)
      return boolean
   is
   begin
      if instr (p_str, '@') = 0
      then
         return false;
      end if;

      return check_permitted_char (p_str, g_email_char);
   end check_email;

   -------------------------------------------------------------------------------
   function check_digit (p_str varchar2)
      return boolean
   is
   begin
      return check_permitted_char (p_str, g_digit);
   end check_digit;

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

   function check_phone (p_phone varchar2)
      return varchar2
   is
      l_ret   varchar2 (100) := null;
   begin
      if p_phone is not null
      then
         for j in 1 .. length (p_phone)
         loop
            if substr (p_phone, j, 1) in ('+',
                                          '0',
                                          '1',
                                          '2',
                                          '3',
                                          '4',
                                          '5',
                                          '6',
                                          '7',
                                          '8',
                                          '9')
            then
               l_ret := l_ret || substr (p_phone, j, 1);
            end if;
         end loop;

         l_ret := substr (l_ret, 1, 13);
      end if;

      return l_ret;
   end check_phone;

   function check_pcode (p_pcode varchar2)
      return varchar2
   is
      l_ret   varchar2 (100) := null;
   begin
      l_ret := substr (trim (p_pcode), 1, 10);

      if l_ret is not null
      then
         if length (l_ret) < 5
         then
            l_ret := substr ('0000' || l_ret, -5);
         end if;
      end if;

      return l_ret;
   end check_pcode;

   function encodebase64 (inclearchar in clob)
      return clob
   is
      dest_lob       blob;
      lang_context   integer := dbms_lob.default_lang_ctx;
      dest_offset    integer := 1;
      src_offset     integer := 1;
      read_offset    integer := 1;
      warning        integer;
      cloblen        integer := dbms_lob.getlength (inclearchar);

      amount         integer := 1440;

      buffer         raw (1440);
      res            clob := empty_clob ();
   begin
      if inclearchar is null or nvl (cloblen, 0) = 0
      then
         return null;
      elsif cloblen <= 24000
      then
         return utl_raw.cast_to_varchar2 (
                   utl_encode.base64_encode (utl_raw.cast_to_raw (inclearchar)));
      end if;



      dbms_lob.createtemporary (dest_lob, true);
      dbms_lob.converttoblob (dest_lob,
                              inclearchar,
                              dbms_lob.lobmaxsize,
                              dest_offset,
                              src_offset,
                              dbms_lob.default_csid,
                              lang_context,
                              warning);

      loop
         exit when read_offset >= dest_offset;
         dbms_lob.read (dest_lob,
                        amount,
                        read_offset,
                        buffer);
         res := res || utl_raw.cast_to_varchar2 (utl_encode.base64_encode (buffer));
         read_offset := read_offset + amount;
      end loop;

      dbms_lob.freetemporary (dest_lob);
      return res;
   end encodebase64;

   function decodebase64 (inbase64char in clob)
      return clob
   is
      blob_loc       blob;
      clob_trim      clob;
      res            clob;

      lang_context   integer := dbms_lob.default_lang_ctx;
      dest_offset    integer := 1;
      src_offset     integer := 1;
      read_offset    integer := 1;
      warning        integer;
      cloblen        integer := dbms_lob.getlength (inbase64char);

      amount         integer := 1440;
      buffer         raw (1440);
      stringbuffer   varchar2 (1440);
   begin
      if inbase64char is null or nvl (cloblen, 0) = 0
      then
         return null;
      elsif cloblen <= 32000
      then
         return utl_raw.cast_to_varchar2 (
                   utl_encode.base64_decode (utl_raw.cast_to_raw (inbase64char)));
      end if;

      dbms_lob.createtemporary (clob_trim, true);

      loop
         exit when read_offset > cloblen;
         stringbuffer :=
            replace (replace (dbms_lob.substr (inbase64char, amount, read_offset), chr (13), null),
                     chr (10),
                     null);
         dbms_lob.writeappend (clob_trim, length (stringbuffer), stringbuffer);
         read_offset := read_offset + amount;
      end loop;

      read_offset := 1;
      cloblen := dbms_lob.getlength (clob_trim);
      dbms_lob.createtemporary (blob_loc, true);

      loop
         exit when read_offset > cloblen;
         buffer :=
            utl_encode.base64_decode (
               utl_raw.cast_to_raw (dbms_lob.substr (clob_trim, amount, read_offset)));
         dbms_lob.writeappend (blob_loc, dbms_lob.getlength (buffer), buffer);
         read_offset := read_offset + amount;
      end loop;

      dbms_lob.createtemporary (res, false);
      dbms_lob.converttoclob (res,
                              blob_loc,
                              dbms_lob.lobmaxsize,
                              dest_offset,
                              src_offset,
                              dbms_lob.default_csid,
                              lang_context,
                              warning);

      dbms_lob.freetemporary (blob_loc);
      dbms_lob.freetemporary (clob_trim);

      return res;
   end decodebase64;

   function unpacking (p_body in blob)
      return clob
   is
      l_blob           blob;
      l_clob           clob;
      l_warning        integer;
      l_dest_offset    integer := 1;
      l_src_offset     integer := 1;
      l_blob_csid      number := dbms_lob.default_csid;
      l_lang_context   number := dbms_lob.default_lang_ctx;

      l_act            varchar2 (400) := '.unpacking.';
   begin
      l_blob := utl_compress.lz_uncompress (p_body);
      dbms_lob.createtemporary (l_clob, false);

      dbms_lob.converttoclob (dest_lob       => l_clob,
                              src_blob       => l_blob,
                              amount         => dbms_lob.lobmaxsize,
                              dest_offset    => l_dest_offset,
                              src_offset     => l_src_offset,
                              blob_csid      => l_blob_csid,
                              lang_context   => l_lang_context,
                              warning        => l_warning);

      return decodebase64 (l_clob);
   end unpacking;

   function packing (p_body in clob)
      return blob
   is
      l_blob           blob;
      l_clob           clob;
      l_warning        integer;
      l_dest_offset    integer := 1;
      l_src_offset     integer := 1;
      l_blob_csid      number := dbms_lob.default_csid;
      l_lang_context   number := dbms_lob.default_lang_ctx;
   begin
      l_clob := encodebase64 (p_body);

      dbms_lob.createtemporary (l_blob, false);

      dbms_lob.converttoblob (dest_lob       => l_blob,
                              src_clob       => l_clob,
                              amount         => dbms_lob.getlength (l_clob),
                              dest_offset    => l_dest_offset,
                              src_offset     => l_src_offset,
                              blob_csid      => l_blob_csid,
                              lang_context   => l_lang_context,
                              warning        => l_warning);

      return utl_compress.lz_compress (l_blob);
   end packing;

   -- запрос информации о ЗП проекте из корпа2
   procedure get_zp_deal_par (p_rnk       in     customer.rnk%type,
                              p_amount    in     number,
                              p_mfo       in     number,
                              p_debt         out number,
                              p_commiss      out number,
                              p_premium      out number)
   is
      l_rnk        customer.rnk%type;
      l_nls2909    accounts.nls%type;
      l_kodtarif   number;
      l_act        varchar2 (100) := '.get_zp_deal_par.';
   begin
      bc.go (p_mfo);

      if nvl (getglobaloption ('IS_MMFO'), 0) = 1
      then
         --приделываем хвост;
         l_rnk := add_ru_tail (p_rnk, p_mfo);
      else
         l_rnk := p_rnk;
      end if;

      select deal_premium,
             nvl (ostc_3570, 0) * -1,
             nls_2909,
             kod_tarif
        into p_premium,
             p_debt,
             l_nls2909,
             l_kodtarif
        from v_zp_deals
       where rnk = l_rnk and sos >= 0;

      p_commiss :=
         nvl (  f_tarif (l_kodtarif,
                         980,
                         l_nls2909,
                         p_amount * 100)
              / 100,
              0);

      bars_audit.info (
            g_p_name
         || l_act
         || ' rnk - '
         || p_rnk
         || ', amount -'
         || p_amount
         || ', mfo  - '
         || p_mfo);
   exception
     when others then
         bars_error.raise_nerror (g_err_mod, g_p_name || l_act || dbms_utility.format_error_backtrace || ' ' || sqlerrm || 'p_rnk='||p_rnk);
   end;

   function form_cards_dictionary return clob
   is
      l_xml_tmp     xmltype := null;
      l_clob_data   clob;
      l_act         varchar2 (100) := '.form_cards_dictionary.';
   begin
      bars_audit.info (g_p_name || l_act || ' start.');

      dbms_lob.createtemporary (l_clob_data, false);
      dbms_lob.append (l_clob_data, '<ROWSET>');

      for j in (select * from mv_kf)
      loop
         bc.go (j.kf);

         for c
            in (select b.id proect_id,
                       b.okpo proect_okpo,
                       b.rnk proect_rnk,
                       bb.card_code,
                       p.code product_code,
                       p.name product_name,
                       b.kf
                  from w4_product_groups g,
                       w4_product p,
                       w4_subproduct s,
                       w4_card c,
                       bpk_scheme m,
                       cm_product d,
                       bpk_proect b,
                       bpk_proect_card bb
                 where     g.code = 'SALARY'
                       and g.code = p.grp_code
                       and p.code = b.product_code
                       and nvl (b.used_w4, 0) = 1
                       and b.okpo = bb.okpo
                       and nvl (b.okpo_n, 0) = nvl (bb.okpo_n, 0)
                       and bb.card_code = c.code
                       and c.sub_code = s.code
                       and g.scheme_id = m.id
                       and p.code = d.product_code(+)
                       and nvl (g.date_open, bankdate) <= bankdate
                       and nvl (p.date_open, bankdate) <= bankdate
                       and nvl (c.date_open, bankdate) <= bankdate
                       and nvl (g.date_close, bankdate + 1) > bankdate
                       and nvl (p.date_close, bankdate + 1) > bankdate
                       and nvl (c.date_close, bankdate + 1) > bankdate
                       and s.flag_kk <> 1)                                   -- без карты киевлянина
         loop
            c.proect_rnk := cut_off_ru_tail (c.proect_rnk);

            select xmlelement ("ROW",
                               xmlelement ("PROECT_ID", c.proect_id),
                               xmlelement ("PROECT_OKPO", c.proect_okpo),
                               xmlelement ("PROECT_RNK", c.proect_rnk),
                               xmlelement ("CARD_CODE", c.card_code),
                               xmlelement ("PRODUCT_CODE", c.product_code),
                               xmlelement ("KF", c.kf))
              into l_xml_tmp
              from dual;

            dbms_lob.append (l_clob_data, l_xml_tmp.getclobval ());
         end loop;

         bc.go ('/');
      end loop;

      dbms_lob.append (l_clob_data, '</ROWSET>');

      bars_audit.info (g_p_name || l_act || ' finish.' || substr (l_clob_data, 1, 100));

      if dbms_lob.getlength (l_clob_data) > 0
      then
         return encodebase64 (l_clob_data);
      else
         return empty_clob();
      end if;
   end;

   -- отправка справочника карточных продуктов в корп2
   procedure send_cards_dictionary
   is
      l_method         varchar2 (400) := 'UploadDictToCorp2';
      l_request        soap_rpc.t_request;
      l_response       soap_rpc.t_response;
      l_url            params$global.val%type
         :=    getglobaloption ('ABSBARS_WEBSERVER_PROTOCOL')
            || '://'
            || getglobaloption ('ABSBARS_WEBSERVER_IP_ADRESS')
            || getglobaloption ('ZPCENTRAL');
      l_dir            varchar2 (256) := getglobaloption ('PATH_FOR_ABSBARS_WALLET');
      l_pass           varchar2 (256) := getglobaloption ('PASS_FOR_ABSBARS_WALLET');

      l_clob           clob;
      l_error          varchar2 (4000);
      l_parser         dbms_xmlparser.parser;
      l_doc            dbms_xmldom.domdocument;
      l_reslist        dbms_xmldom.domnodelist;
      l_res            dbms_xmldom.domnode;
      l_str            varchar2 (4000);
      l_status         varchar2 (4000);
      l_tmp            xmltype;

      l_act            varchar2 (256) := '.send_cards_dictionary.';

      l_buff           clob;

      l_corp2_url      varchar2 (400) := getglobaloption ('ZPCORP2URL');

      l_warning        integer;
      l_dest_offset    integer := 1;
      l_src_offset     integer := 1;
      l_blob_csid      number := dbms_lob.default_csid;
      l_lang_context   number := dbms_lob.default_lang_ctx;
   begin
      bars_audit.info (g_p_name || l_act || ' start.');


      l_buff := form_cards_dictionary();

      l_request :=
         soap_rpc.new_request (p_url           => l_url,
                               p_namespace     => 'http://ws.unity-bars-utl.com.ua/',
                               p_method        => l_method,
                               p_wallet_dir    => l_dir,
                               p_wallet_pass   => l_pass);

      soap_rpc.add_parameter (l_request, 'url', l_corp2_url);

      soap_rpc.add_parameter (l_request, 'dictContent', l_buff);

      l_response := soap_rpc.invoke(l_request);

      l_clob := l_response.doc.getclobval();

      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, l_clob);
      l_doc := dbms_xmlparser.getdocument (l_parser);
      l_reslist := dbms_xmldom.getelementsbytagname (l_doc, l_method || 'Result');
      l_res := dbms_xmldom.item (l_reslist, 0);
      dbms_xslprocessor.valueof (l_res, 'status/text()', l_str);
      l_status := substr (l_str, 1, 200);

      if upper (trim (l_status)) = 'OK'
      then
         bars_audit.info (g_p_name || l_act || ' finish.status - ok');
      else
         dbms_xslprocessor.valueof (l_res, 'message/text()', l_str);
         l_error := substr (l_str, 1, 4000);

         bars_audit.info (
               g_p_name
            || l_act
            || 'finish with error.message -'
            || l_error
            || ' received status - '
            || l_status);
      end if;

      dbms_xmlparser.freeparser (l_parser);
      dbms_xmldom.freedocument (l_doc);
   exception
      when others
      then
         dbms_xmlparser.freeparser (l_parser);
         dbms_xmldom.freedocument (l_doc);

         l_error := dbms_utility.format_error_stack ()
                  || chr (10)
                  || dbms_utility.format_error_backtrace ();

         bars_error.raise_nerror (g_err_mod,
                                  g_p_name || l_act || 'finish with error.error -' || l_error);
   end;

   procedure alter_client (p_clientdata t_rec_card_order)
   is
      l_customer        customer%rowtype;
      l_person          person%rowtype;
      l_custadr1        customer_address%rowtype;
      l_custadr2        customer_address%rowtype;
      l_cust_fn         customerw.value%type;
      l_cust_ln         customerw.value%type;
      l_cust_mn         customerw.value%type;
      l_cust_mname      customerw.value%type;
      l_cust_phonemob   customerw.value%type;
      l_cust_email      customerw.value%type;
      l_cust_k013       customerw.value%type;
      l_cust_fgidx      customerw.value%type;
      l_cust_fgobl      customerw.value%type;
      l_cust_fgdst      customerw.value%type;
      l_cust_fgtwn      customerw.value%type;
      l_cust_fgadr      customerw.value%type;
   begin
      if p_clientdata.rnk is not null
      then
         -- данные клиента
         begin
            select *
              into l_customer
              from customer
             where rnk = p_clientdata.rnk;
         exception
            when no_data_found
            then
               null;
         end;

         begin
            select *
              into l_person
              from person
             where rnk = p_clientdata.rnk;
         exception
            when no_data_found
            then
               l_person.pdate := null;
               l_person.organ := null;
               l_person.bday := null;
               l_person.sex := null;
               l_person.teld := null;
         end;

         begin
            select *
              into l_custadr1
              from customer_address
             where rnk = p_clientdata.rnk and type_id = 1;
         exception
            when no_data_found
            then
               l_custadr1.zip := null;
               l_custadr1.domain := null;
               l_custadr1.region := null;
               l_custadr1.locality := null;
               l_custadr1.address := null;
         end;

         begin
            select *
              into l_custadr2
              from customer_address
             where rnk = p_clientdata.rnk and type_id = 2;
         exception
            when no_data_found
            then
               l_custadr2.zip := null;
               l_custadr2.domain := null;
               l_custadr2.region := null;
               l_custadr2.locality := null;
               l_custadr2.address := null;
         end;

         begin
            select min (decode (tag, 'SN_FN', value, null)),
                   min (decode (tag, 'SN_LN', value, null)),
                   min (decode (tag, 'SN_MN', value, null)),
                   min (decode (tag, 'PC_MF', value, null)),
                   min (decode (tag, 'MPNO ', value, null)),
                   min (decode (tag, 'EMAIL', value, null)),
                   min (decode (tag, 'K013 ', value, null)),
                   min (decode (tag, 'FGIDX', value, null)),
                   min (decode (tag, 'FGOBL', value, null)),
                   min (decode (tag, 'FGDST', value, null)),
                   min (decode (tag, 'FGTWN', value, null)),
                   min (decode (tag, 'FGADR', value, null))
              into l_cust_fn,
                   l_cust_ln,
                   l_cust_mn,
                   l_cust_mname,
                   l_cust_phonemob,
                   l_cust_email,
                   l_cust_k013,
                   l_cust_fgidx,
                   l_cust_fgobl,
                   l_cust_fgdst,
                   l_cust_fgtwn,
                   l_cust_fgadr
              from customerw
             where rnk = p_clientdata.rnk;
         exception
            when no_data_found
            then
               l_cust_phonemob := null;
               l_cust_email := null;
         end;

         -- обновляем незаполненные данные
         if    (    l_customer.nmkv is null
                and (   p_clientdata.eng_first_name is not null
                     or p_clientdata.eng_last_name is not null))
            or (l_customer.country is null and p_clientdata.country is not null)
            or l_customer.crisk is null
         then
            update customer
               set nmkv =
                      nvl (nmkv,
                           trim (p_clientdata.eng_last_name || ' ' || p_clientdata.eng_first_name)),
                   country = nvl (country, p_clientdata.country),
                   crisk = nvl (crisk, 1)
             where rnk = p_clientdata.rnk;
         end if;

         if     (   l_person.pdate is null
                 or l_person.organ is null
                 or l_person.bday is null
                 or l_person.sex is null
                 or l_person.teld is null)
            and (   p_clientdata.paspissuer is not null
                 or p_clientdata.paspdate is not null
                 or p_clientdata.bday is not null
                 or p_clientdata.gender is not null
                 or p_clientdata.phone_home is not null)
         then
            update person
               set pdate = nvl (pdate, p_clientdata.paspdate),
                   organ = nvl (organ, substr (trim (p_clientdata.paspissuer), 1, 70)),
                   bday = nvl (bday, p_clientdata.bday),
                   sex = nvl (sex, p_clientdata.gender),
                   teld = nvl (teld, p_clientdata.phone_home)
             where rnk = p_clientdata.rnk;
         end if;

         if     (   l_custadr1.zip is null
                 or l_custadr1.domain is null
                 or l_custadr1.region is null
                 or l_custadr1.locality is null
                 or l_custadr1.address is null)
            and (   p_clientdata.addr1_cityname is not null
                 or p_clientdata.addr1_pcode is not null
                 or p_clientdata.addr1_domain is not null
                 or p_clientdata.addr1_region is not null
                 or p_clientdata.addr1_street is not null)
         then
            update customer_address
               set zip = nvl (zip, p_clientdata.addr1_pcode),
                   domain = nvl (domain, p_clientdata.addr1_domain),
                   region = nvl (region, p_clientdata.addr1_region),
                   locality = nvl (locality, p_clientdata.addr1_cityname),
                   address = nvl (address, p_clientdata.addr1_street)
             where rnk = p_clientdata.rnk and type_id = 1;

            if sql%rowcount = 0
            then
               insert into customer_address (rnk,
                                             type_id,
                                             country,
                                             zip,
                                             domain,
                                             region,
                                             locality,
                                             address)
                    values (p_clientdata.rnk,
                            1,
                            804,
                            p_clientdata.addr1_pcode,
                            p_clientdata.addr1_domain,
                            p_clientdata.addr1_region,
                            p_clientdata.addr1_cityname,
                            p_clientdata.addr1_street);
            end if;
         end if;

         if l_cust_fgidx is null and p_clientdata.addr1_pcode is not null
         then
            kl.setcustomerelement (rnk_   => p_clientdata.rnk,
                                   tag_   => 'FGIDX',
                                   val_   => trim (p_clientdata.addr1_pcode),
                                   otd_   => 0);
         end if;

         if l_cust_fgobl is null and p_clientdata.addr1_domain is not null
         then
            kl.setcustomerelement (rnk_   => p_clientdata.rnk,
                                   tag_   => 'FGOBL',
                                   val_   => trim (p_clientdata.addr1_domain),
                                   otd_   => 0);
         end if;

         if l_cust_fgdst is null and p_clientdata.addr1_region is not null
         then
            kl.setcustomerelement (rnk_   => p_clientdata.rnk,
                                   tag_   => 'FGDST',
                                   val_   => trim (p_clientdata.addr1_region),
                                   otd_   => 0);
         end if;

         if l_cust_fgtwn is null and p_clientdata.addr1_cityname is not null
         then
            kl.setcustomerelement (rnk_   => p_clientdata.rnk,
                                   tag_   => 'FGTWN',
                                   val_   => trim (p_clientdata.addr1_cityname),
                                   otd_   => 0);
         end if;

         if l_cust_fgadr is null and p_clientdata.addr1_street is not null
         then
            kl.setcustomerelement (rnk_   => p_clientdata.rnk,
                                   tag_   => 'FGADR',
                                   val_   => trim (p_clientdata.addr1_street),
                                   otd_   => 0);
         end if;

         if     (   l_custadr2.zip is null
                 or l_custadr2.domain is null
                 or l_custadr2.region is null
                 or l_custadr2.locality is null
                 or l_custadr2.address is null)
            and (   p_clientdata.addr2_cityname is not null
                 or p_clientdata.addr2_pcode is not null
                 or p_clientdata.addr2_domain is not null
                 or p_clientdata.addr2_region is not null
                 or p_clientdata.addr2_street is not null)
         then
            update customer_address
               set zip = nvl (zip, p_clientdata.addr2_pcode),
                   domain = nvl (domain, p_clientdata.addr2_domain),
                   region = nvl (region, p_clientdata.addr2_region),
                   locality = nvl (locality, p_clientdata.addr2_cityname),
                   address = nvl (address, p_clientdata.addr2_street)
             where rnk = p_clientdata.rnk and type_id = 2;

            if sql%rowcount = 0
            then
               insert into customer_address (rnk,
                                             type_id,
                                             country,
                                             zip,
                                             domain,
                                             region,
                                             locality,
                                             address)
                    values (p_clientdata.rnk,
                            2,
                            804,
                            p_clientdata.addr2_pcode,
                            p_clientdata.addr2_domain,
                            p_clientdata.addr2_region,
                            p_clientdata.addr2_cityname,
                            p_clientdata.addr2_street);
            end if;
         end if;

         if l_cust_fn is null
         then
            begin
               insert into customerw (rnk,
                                      tag,
                                      value,
                                      isp)
                    values (p_clientdata.rnk,
                            'SN_FN',
                            p_clientdata.first_name,
                            0);
            exception
               when dup_val_on_index
               then
                  update customerw
                     set value = p_clientdata.first_name
                   where rnk = p_clientdata.rnk and tag = 'SN_FN';
            end;
         end if;

         if l_cust_ln is null
         then
            begin
               insert into customerw (rnk,
                                      tag,
                                      value,
                                      isp)
                    values (p_clientdata.rnk,
                            'SN_LN',
                            p_clientdata.last_name,
                            0);
            exception
               when dup_val_on_index
               then
                  update customerw
                     set value = p_clientdata.last_name
                   where rnk = p_clientdata.rnk and tag = 'SN_LN';
            end;
         end if;

         if l_cust_mn is null
         then
            begin
               insert into customerw (rnk,
                                      tag,
                                      value,
                                      isp)
                    values (p_clientdata.rnk,
                            'SN_MN',
                            p_clientdata.middle_name,
                            0);
            exception
               when dup_val_on_index
               then
                  update customerw
                     set value = p_clientdata.middle_name
                   where rnk = p_clientdata.rnk and tag = 'SN_MN';
            end;
         end if;

         if l_cust_mname is null
         then
            begin
               insert into customerw (rnk,
                                      tag,
                                      value,
                                      isp)
                    values (p_clientdata.rnk,
                            'PC_MF',
                            p_clientdata.mname,
                            0);
            exception
               when dup_val_on_index
               then
                  update customerw
                     set value = p_clientdata.mname
                   where rnk = p_clientdata.rnk and tag = 'PC_MF';
            end;
         end if;

         if l_cust_phonemob is null
         then
            begin
               insert into customerw (rnk,
                                      tag,
                                      value,
                                      isp)
                    values (p_clientdata.rnk,
                            'MPNO ',
                            p_clientdata.phone_mob,
                            0);
            exception
               when dup_val_on_index
               then
                  update customerw
                     set value = p_clientdata.phone_mob
                   where rnk = p_clientdata.rnk and tag = 'MPNO ';
            end;
         end if;

         if l_cust_email is null
         then
            begin
               insert into customerw (rnk,
                                      tag,
                                      value,
                                      isp)
                    values (p_clientdata.rnk,
                            'EMAIL',
                            p_clientdata.email,
                            0);
            exception
               when dup_val_on_index
               then
                  update customerw
                     set value = p_clientdata.email
                   where rnk = p_clientdata.rnk and tag = 'EMAIL';
            end;
         end if;

         if l_cust_k013 is null
         then
            begin
               insert into customerw (rnk,
                                      tag,
                                      value,
                                      isp)
                    values (p_clientdata.rnk,
                            'K013',
                            '5',
                            0);
            exception
               when dup_val_on_index
               then
                  update customerw
                     set value = '5'
                   where rnk = p_clientdata.rnk and tag = 'K013';
            end;
         end if;
      end if;
   exception
      when others
      then
         raise_application_error (
            -20000,
               'Помилка поновлення реквізитів клієнта РНК '
            || p_clientdata.rnk
            || ' : '
            || sqlerrm,
            true);
   end alter_client;

   procedure create_customer (p_client in out t_rec_card_order)
   is
      l_rnk         number := null;
      l_nmk         varchar2 (70);
      l_nmkv        varchar2 (70);
      l_nmkk        varchar2 (38);
      l_adr         varchar2 (70);
      l_codcagent   customer.codcagent%type;
      l_ise         customer.ise%type;
   begin
      -- LastName - фамилия, FirstName - имя
      l_nmk :=
         substr (
            trim (p_client.last_name || ' ' || p_client.first_name || ' ' || p_client.middle_name),
            1,
            70);
      l_nmkv := substr (f_translate_kmu (trim (l_nmk)), 1, 70);
      l_nmkk := substr (p_client.last_name || ' ' || p_client.first_name, 1, 38);

      select substr (
                   trim (p_client.addr1_domain)
                || nvl2 (trim (p_client.addr1_region), ' ' || trim (p_client.addr1_region), '')
                || nvl2 (trim (p_client.addr1_cityname), ' ' || trim (p_client.addr1_cityname), '')
                || nvl2 (trim (p_client.addr1_street), ' ' || trim (p_client.addr1_street), ''),
                1,
                70)
        into l_adr
        from dual;

      if p_client.resident = '1'
      then
         l_codcagent := 5;
         l_ise := '14300';
      else
         l_codcagent := 6;
         l_ise := '00000';
      end if;

      kl.setcustomerattr (rnk_         => l_rnk,                                  -- Customer number
                          custtype_    => 3,           -- Тип клиента: 1-банк, 2-юр.лицо, 3-физ.лицо
                          nd_          => null,                                        -- № договора
                          nmk_         => l_nmk,                             -- Наименование клиента
                          nmkv_        => l_nmkv,              -- Наименование клиента международное
                          nmkk_        => l_nmkk,                    -- Наименование клиента краткое
                          adr_         => l_adr,                                    -- Адрес клиента
                          codcagent_   => l_codcagent,                             -- Характеристика
                          country_     => p_client.country,                                -- Страна
                          prinsider_   => 99,                                   -- Признак инсайдера
                          tgr_         => 2,                                      -- Тип гос.реестра
                          okpo_        => trim (p_client.okpo),                              -- ОКПО
                          stmt_        => 0,                                       -- Формат выписки
                          sab_         => null,                                            -- Эл.код
                          dateon_      => bankdate,                              -- Дата регистрации
                          taxf_        => null,                                     -- Налоговый код
                          creg_        => -1,                                          -- Код обл.НИ
                          cdst_        => -1,                                        -- Код район.НИ
                          adm_         => null,                                       -- Админ.орган
                          rgtax_       => null,                                    -- Рег номер в НИ
                          rgadm_       => null,                                  -- Рег номер в Адм.
                          datet_       => null,                                     -- Дата рег в НИ
                          datea_       => null,                         -- Дата рег. в администрации
                          ise_         => l_ise,                             -- Инст. сек. экономики
                          fs_          => null,                               -- Форма собственности
                          oe_          => null,                                 -- Отрасль экономики
                          ved_         => null,                              -- Вид эк. деятельности
                          sed_         => null,                              -- Форма хозяйствования
                          notes_       => null,                                        -- Примечание
                          notesec_     => null,                -- Примечание для службы безопасности
                          crisk_       => 1,                                      -- Категория риска
                          pincode_     => null,                                                   --
                          rnkp_        => null,                               -- Рег. номер холдинга
                          lim_         => null,                                       -- Лимит кассы
                          nompdv_      => null,                             -- № в реестре плат. ПДВ
                          mb_          => 9,                              -- Принадл. малому бизнесу
                          bc_          => 0,                              -- Признак НЕклиента банка
                          tobo_        => p_client.branch,           -- Код безбалансового отделения
                          isp_         => null              -- Менеджер клиента (ответ. исполнитель)
                                              );

      kl.setcustomeren (p_rnk    => l_rnk,
                        p_k070   => nvl (getglobaloption ('CUSTK070'), '00000'),              -- ise
                        p_k080   => nvl (getglobaloption ('CUSTK080'), '00'),                  -- fs
                        p_k110   => '00000',                                                  -- ved
                        p_k090   => '00000',                                                   -- oe
                        p_k050   => '000',                                                   -- k050
                        p_k051   => '00'                                                      -- sed
                                        );

      kl.setcustomerelement (rnk_   => l_rnk,
                             tag_   => 'FGIDX',
                             val_   => trim (p_client.addr1_pcode),
                             otd_   => 0);

      kl.setcustomerelement (rnk_   => l_rnk,
                             tag_   => 'FGOBL',
                             val_   => trim (p_client.addr1_domain),
                             otd_   => 0);

      kl.setcustomerelement (rnk_   => l_rnk,
                             tag_   => 'FGDST',
                             val_   => trim (p_client.addr1_region),
                             otd_   => 0);

      kl.setcustomerelement (rnk_   => l_rnk,
                             tag_   => 'FGTWN',
                             val_   => trim (p_client.addr1_cityname),
                             otd_   => 0);

      kl.setcustomerelement (rnk_   => l_rnk,
                             tag_   => 'FGADR',
                             val_   => trim (p_client.addr1_street),
                             otd_   => 0);

      kl.setcustomeraddressbyterritory (
         rnk_           => l_rnk,
         typeid_        => 1,
         country_       => p_client.country,
         zip_           => substr (trim (p_client.addr1_pcode), 1, 20),
         domain_        => substr (trim (p_client.addr1_domain), 1, 30),
         region_        => substr (trim (p_client.addr1_region), 1, 30),
         locality_      => substr (trim (p_client.addr1_cityname), 1, 30),
         address_       => substr (trim (p_client.addr1_street), 1, 100),
         territoryid_   => null);

      if    p_client.addr2_pcode is not null
         or p_client.addr2_domain is not null
         or p_client.addr2_region is not null
         or p_client.addr2_cityname is not null
         or p_client.addr2_street is not null
      then
         kl.setcustomeraddressbyterritory (
            rnk_           => l_rnk,
            typeid_        => 2,
            country_       => p_client.country,
            zip_           => substr (trim (p_client.addr2_pcode), 1, 20),
            domain_        => substr (trim (p_client.addr2_domain), 1, 30),
            region_        => substr (trim (p_client.addr2_region), 1, 30),
            locality_      => substr (trim (p_client.addr2_cityname), 1, 30),
            address_       => substr (trim (p_client.addr2_street), 1, 100),
            territoryid_   => null);
      end if;

      kl.setpersonattr (rnk_           => l_rnk,
                        sex_           => p_client.gender,
                        passp_         => nvl (p_client.type_doc, 1),
                        ser_           => trim (p_client.paspseries),
                        numdoc_        => trim (p_client.paspnum),
                        pdate_         => trim (p_client.paspdate),
                        organ_         => substr (trim (p_client.paspissuer), 1, 70),
                        bday_          => p_client.bday,
                        bplace_        => null,
                        teld_          => p_client.phone_home,
                        telw_          => null,
                        actual_date_   => null,
                        eddr_id_       => null);

      kl.setcustomerelement (rnk_   => l_rnk,
                             tag_   => 'SN_FN',
                             val_   => p_client.first_name,
                             otd_   => 0);

      kl.setcustomerelement (rnk_   => l_rnk,
                             tag_   => 'SN_LN',
                             val_   => p_client.last_name,
                             otd_   => 0);

      if p_client.middle_name is not null
      then
         kl.setcustomerelement (rnk_   => l_rnk,
                                tag_   => 'SN_MN',
                                val_   => p_client.middle_name,
                                otd_   => 0);
      end if;

      if p_client.phone_mob is not null
      then
         kl.setcustomerelement (rnk_   => l_rnk,
                                tag_   => 'MPNO ',
                                val_   => p_client.phone_mob,
                                otd_   => 0);
      end if;

      kl.setcustomerelement (rnk_   => l_rnk,
                             tag_   => 'K013',
                             val_   => '5',
                             otd_   => 0);

      p_client.rnk := l_rnk;
   end create_customer;

   procedure check_project (p_project in out t_rec_card_order)
   is
      l_msg   varchar2 (254) := null;
      n       number;

      procedure append_msg (p_txt varchar2)
      is
      begin
         if l_msg is not null
         then
            l_msg := substr (l_msg || ';' || p_txt, 1, 254);
         else
            l_msg := substr (p_txt, 1, 254);
         end if;
      end;
   begin
      p_project.str_err := null;

      if p_project.eng_first_name is null
      then
         p_project.eng_first_name := substr (f_translate_kmu (p_project.first_name), 1, 30);
      else
         p_project.eng_first_name := upper (p_project.eng_first_name);
      end if;

      if p_project.eng_last_name is null
      then
         p_project.eng_last_name := substr (f_translate_kmu (p_project.last_name), 1, 30);
      else
         p_project.eng_last_name := upper (p_project.eng_last_name);
      end if;

      if p_project.paspseries is not null
      then
         p_project.paspseries := kl.recode_passport_serial (p_project.paspseries);
      end if;

      if    p_project.okpo is null
         or p_project.first_name is null
         or p_project.last_name is null
         or p_project.type_doc is null
         or p_project.paspseries is null
         or p_project.paspnum is null
         or p_project.paspissuer is null
         or p_project.paspdate is null
         or p_project.bday is null
         or p_project.country is null
         or p_project.resident is null
         or p_project.gender is null
         or p_project.mname is null
         or p_project.addr1_cityname is null
         or p_project.addr1_street is null
         or p_project.okpo_w is null
      then
         append_msg ('Не заповнено обов''язкові поля');
      end if;

      if length (trim (p_project.eng_first_name || ' ' || p_project.eng_last_name)) > 24
      then
         append_msg (
            'Кількість знаків Прізвище та І''мя для ембосування перевищує 24 символи');
      end if;

      if not check_eng (p_project.eng_first_name)
      then
         append_msg (
            'Ім''я що ембосується - недопустимі символи');
      end if;

      if not check_eng (p_project.eng_last_name)
      then
         append_msg (
            'Прізвище що ембосується - недопустимі символи');
      end if;

      if months_between (bankdate, p_project.bday) / 12 < 14
      then
         append_msg ('Клієнту менше 14 років');
      end if;

      if p_project.addr1_pcode is not null and length (p_project.addr1_pcode) <> 5
      then
         append_msg ('Довжина поля Індекс повинна бути 5 знаків');
      end if;

      if p_project.addr2_pcode is not null and length (p_project.addr2_pcode) <> 5
      then
         append_msg ('Довжина поля Індекс повинна бути 5 знаків');
      end if;

      if p_project.paspdate >= sysdate
      then
         append_msg (
            'Дата видачі паспорту повинна бути менше поточної дати');
      end if;

      if p_project.paspdate < p_project.bday
      then
         append_msg (
            'Дата видачі паспорту повинна бути більше дати народження');
      end if;

      if instr (p_project.paspseries, ' ') > 0
      then
         append_msg ('Серія паспорту містить пробіли');
      end if;

      if     nvl (p_project.type_doc, 0) = 1
         and (   p_project.paspseries <> upper (p_project.paspseries)
              or length (p_project.paspseries) <> 2)
      then
         append_msg ('Невірно заповнено серію паспорту');
      end if;

      if     nvl (p_project.type_doc, 0) = 1
         and (not check_digit (p_project.paspnum) or length (p_project.paspnum) <> 6)
      then
         append_msg ('Невірно заповнено номер паспорту');
      end if;

      if p_project.email is not null and not check_email (upper (p_project.email))
      then
         append_msg ('Невірний e-mail');
      end if;

      if p_project.phone_home is not null
      then
         if length (p_project.phone_home) <> 13
         then
            append_msg (
               'Довжина номеру телефону повинна дорівнювати 13 символів');
         elsif substr (p_project.phone_home, 1, 3) <> '+38'
         then
            append_msg ('Номер телефону повинен починатись з +38');
         elsif not check_digit (substr (p_project.phone_home, 2))
         then
            append_msg ('Нецифри в номері телефону');
         end if;
      end if;

      if p_project.phone_mob is not null
      then
         if length (p_project.phone_mob) <> 13
         then
            append_msg (
               'Довжина номеру телефону повинна дорівнювати 13 символів');
         elsif substr (p_project.phone_mob, 1, 3) <> '+38'
         then
            append_msg ('Номер телефону повинен починатись з +38');
         elsif not check_digit (substr (p_project.phone_mob, 2))
         then
            append_msg ('Нецифри в номері телефону');
         end if;
      end if;

      if not check_fio (upper (p_project.first_name))
      then
         append_msg (
            'Ім''я повинно містити тільки українські/російські літери');
      end if;

      if not check_fio (upper (p_project.last_name))
      then
         append_msg (
            'Прізвище повинно містити тільки українські/російські літери');
      end if;

      if p_project.middle_name is not null and not check_fio (upper (p_project.middle_name))
      then
         append_msg (
            'По-батькові повинно містити тільки українські/російські літери');
      end if;

      begin
         select 1
           into n
           from bpk_proect
          where id = p_project.bpk_proect_id;
      exception
         when no_data_found
         then
            append_msg ('Не знайдено З/П проект');
      end;


      begin
         select s.flag_kk
           into p_project.flag_kk
           from w4_card c, w4_subproduct s
          where c.code = p_project.card_code and c.sub_code = s.code;
      exception
         when no_data_found
         then
            append_msg ('Не знайдено картковий продукт');
      end;


      p_project.str_err := l_msg;
   end check_project;

   -- TODO: стара версія - не використовується
   -- found_client2 - оптимізована версія пошуку клієнта з (11.12.2017)
   function found_client (p_okpo       varchar2,
                          p_paspser    varchar2,
                          p_paspnum    varchar2,
                          p_spd        number default 0)
      return number
   is
      l_rnk           number := null;
      l_count_okpo    number;
      l_count_passp   number;
      l_date_off      date;
   begin
      if    p_okpo is null
         or substr (p_okpo, 1, 5) = '99999'
         or substr (p_okpo, 1, 5) = '00000'
         or p_paspser is null
         or p_paspnum is null
      then
         l_rnk := null;
      else
         -- ищем клиентов с ОКПО
         select count (*)
           into l_count_okpo
           from customer c
          where     c.okpo = p_okpo
                and (   p_spd = 0 and nvl (trim (c.sed), '00') <> '91'
                     or p_spd = 1 and nvl (trim (c.sed), '00') = '91');

         -- ищем клиентов с паспортными данными
         select /*+ index(p I1_PERSON) index(c PK_CUSTOMER) */ count (*)
           into l_count_passp
           from person p, customer c
          where     p.ser = p_paspser
                and p.numdoc = p_paspnum
                and p.rnk = c.rnk
                and (   p_spd = 0 and nvl (trim (c.sed), '00') <> '91'
                     or p_spd = 1 and nvl (trim (c.sed), '00') = '91');

         -- есть клиенты с ОКПО и паспортными данными
         if l_count_okpo > 0 and l_count_passp > 0
         then
            -- в банкке зарегистрирован один клиент с такими данными
            if l_count_okpo = 1 or l_count_passp = 1
            then
               -- в customer и person это должен быть один клиент
               begin
                  select c.rnk, c.date_off
                    into l_rnk, l_date_off
                    from customer c, person p
                   where     c.okpo = p_okpo
                         and p.ser = p_paspser
                         and p.numdoc = p_paspnum
                         and c.rnk = p.rnk
                         and (   p_spd = 0 and nvl (trim (c.sed), '00') <> '91'
                              or p_spd = 1 and nvl (trim (c.sed), '00') = '91');

                  -- если клиент закрыт, реанимируем его
                  if l_date_off is not null
                  then
                     update customer
                        set date_off = null
                      where rnk = l_rnk;
                  end if;
               exception
                  when no_data_found
                  then
                     null;
               end;
            -- нашли нескольких клиентов с таким ОКПО
            elsif l_count_okpo > 1
            then
               -- ищем среди открытых клиентов
               select max (c.rnk)
                 into l_rnk
                 from customer c, person p
                where     c.okpo = p_okpo
                      and p.ser = p_paspser
                      and p.numdoc = p_paspnum
                      and c.rnk = p.rnk
                      and c.date_off is null
                      and (   p_spd = 0 and nvl (trim (c.sed), '00') <> '91'
                           or p_spd = 1 and nvl (trim (c.sed), '00') = '91');

               -- среди открытых клиентов не нашли, ищем среди закрытых
               if l_rnk is null
               then
                  select max (c.rnk)
                    into l_rnk
                    from customer c, person p
                   where     c.okpo = p_okpo
                         and p.ser = p_paspser
                         and p.numdoc = p_paspnum
                         and c.rnk = p.rnk
                         and c.date_off is not null
                         and (   p_spd = 0 and nvl (trim (c.sed), '00') <> '91'
                              or p_spd = 1 and nvl (trim (c.sed), '00') = '91');

                  -- реанимируем клиента
                  if l_rnk is not null
                  then
                     update customer
                        set date_off = null
                      where rnk = l_rnk;
                  end if;
               end if;
            end if;
         end if;
      end if;

      return l_rnk;
   end found_client;

  -- Нова версія функції пошуку клієнта
  function found_client2(p_okpo       customer.okpo%type,
                         p_paspser    person.ser%type,
                         p_paspnum    person.numdoc%type
                         ) return number
  is
    l_rnk customer.rnk%type := null;
  begin
    for i in (
              select c.date_off, c.rnk
              from customer c, person p
              where c.okpo = p_okpo
                    and p.ser = p_paspser
                    and p.numdoc = p_paspnum
                    and c.rnk = p.rnk
                    and nvl (trim (c.sed), '00') <> '91'
              order by date_off desc nulls first)
    loop
      -- если первый найденный клиент не закрыт берем его
      if i.date_off is null then
        l_rnk := i.rnk;
      else
        -- отсортированный курсор, сначала открытые клиенты
        -- если все клиенты закрыты, берем первого и реанимируем его
        update customer set date_off = null where rnk = i.rnk returning rnk into l_rnk;
      end if;

      return l_rnk;
    end loop;

    return l_rnk;
  end found_client2;

   -- пакетное открытие карт по запросу  корп2
   procedure imp_salary_cards_order (p_blob_data in blob, p_response out blob, p_mfo in varchar2, p_errmsg out varchar2)
   is
      l_act            varchar2 (256) := '.imp_salary_cards_order.';
      l_rec            t_rec_card_order := null;

      l_parser         dbms_xmlparser.parser;
      l_doc            dbms_xmldom.domdocument;
      l_analyticlist   dbms_xmldom.domnodelist;
      l_analytic       dbms_xmldom.domnode;
      l_xml_body       clob := empty_clob ();
      l_xml_tmp        xmltype := null;
      l_data           xmltype := null;
      l_tmp            varchar2 (4000);
      l_clob_data      clob;
      l_in_encoding    varchar2 (256);
      l_our_encoding   varchar2 (256);
      l_doc_clob       clob := empty_clob ();
   begin
      bars_audit.info (g_p_name || l_act || ' start.');

      bc.go (p_mfo);

      select value
        into l_our_encoding
        from nls_database_parameters
       where parameter = 'NLS_CHARACTERSET';

      dbms_lob.createtemporary (l_clob_data, false);
      dbms_lob.append (l_clob_data, '<?xml version="1.0" encoding="windows-1251"?>');
      dbms_lob.append (l_clob_data, '<rowset>');

      l_xml_body := unpacking (p_blob_data);

      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob (l_parser, l_xml_body);
      l_doc := dbms_xmlparser.getdocument (l_parser);
      dbms_xmlparser.freeparser (l_parser);

      dbms_xslprocessor.valueof (dbms_xmldom.makenode (l_doc),
                                 'rowset/nls_characterset/text()',
                                 l_in_encoding);

      if l_in_encoding <> l_our_encoding
      then
         dbms_lob.createtemporary (l_doc_clob, true);
         dbms_xmldom.writetoclob (dbms_xmldom.makenode (l_doc), l_doc_clob);
         l_xml_body := convert (l_doc_clob, l_our_encoding, l_in_encoding);
         l_parser := dbms_xmlparser.newparser;
         dbms_xmlparser.parseclob (l_parser, l_xml_body);
         l_doc := dbms_xmlparser.getdocument (l_parser);
         dbms_xmlparser.freeparser (l_parser);
      end if;



      l_analyticlist := dbms_xslprocessor.selectnodes (dbms_xmldom.makenode (l_doc), 'rowset/row');

      for i in 1 .. dbms_xmldom.getlength (l_analyticlist)
      loop
         begin
            l_analytic := dbms_xmldom.item (l_analyticlist, i - 1);

            dbms_xslprocessor.valueof (l_analytic, 'id/text()', l_rec.id);
            dbms_xslprocessor.valueof (l_analytic, 'okpo/text()', l_rec.okpo);
            dbms_xslprocessor.valueof (l_analytic, 'first_name/text()', l_rec.first_name);
            dbms_xslprocessor.valueof (l_analytic, 'last_name/text()', l_rec.last_name);
            dbms_xslprocessor.valueof (l_analytic, 'middle_name/text()', l_rec.middle_name);
            dbms_xslprocessor.valueof (l_analytic, 'type_doc/text()', l_rec.type_doc);
            dbms_xslprocessor.valueof (l_analytic, 'paspseries/text()', l_rec.paspseries);
            dbms_xslprocessor.valueof (l_analytic, 'paspnum/text()', l_rec.paspnum);
            dbms_xslprocessor.valueof (l_analytic, 'paspissuer/text()', l_rec.paspissuer);
            dbms_xslprocessor.valueof (l_analytic, 'paspdate/text()', l_tmp);
            l_rec.paspdate := to_date (l_tmp, 'yyyy-dd-mm');
            dbms_xslprocessor.valueof (l_analytic, 'bday/text()', l_tmp);
            l_rec.bday := to_date (l_tmp, 'yyyy-dd-mm');
            dbms_xslprocessor.valueof (l_analytic, 'country/text()', l_rec.country);
            dbms_xslprocessor.valueof (l_analytic, 'resident/text()', l_rec.resident);
            dbms_xslprocessor.valueof (l_analytic, 'gender/text()', l_rec.gender);
            dbms_xslprocessor.valueof (l_analytic, 'phone_home/text()', l_tmp);
            l_rec.phone_home := check_phone (l_tmp);
            dbms_xslprocessor.valueof (l_analytic, 'phone_mob/text()', l_tmp);
            l_rec.phone_mob := check_phone (l_tmp);
            dbms_xslprocessor.valueof (l_analytic, 'email/text()', l_rec.email);
            dbms_xslprocessor.valueof (l_analytic, 'eng_first_name/text()', l_rec.eng_first_name);
            dbms_xslprocessor.valueof (l_analytic, 'eng_last_name/text()', l_rec.eng_last_name);
            dbms_xslprocessor.valueof (l_analytic, 'mname/text()', l_rec.mname);
            dbms_xslprocessor.valueof (l_analytic, 'addr1_cityname/text()', l_rec.addr1_cityname);
            dbms_xslprocessor.valueof (l_analytic, 'addr1_pcode/text()', l_rec.addr1_pcode);
            dbms_xslprocessor.valueof (l_analytic, 'addr1_domain/text()', l_rec.addr1_domain);
            dbms_xslprocessor.valueof (l_analytic, 'addr1_region/text()', l_rec.addr1_region);
            dbms_xslprocessor.valueof (l_analytic, 'addr1_street/text()', l_rec.addr1_street);
            dbms_xslprocessor.valueof (l_analytic, 'addr2_cityname/text()', l_rec.addr1_cityname);
            dbms_xslprocessor.valueof (l_analytic, 'addr2_pcode/text()', l_rec.addr1_pcode);
            dbms_xslprocessor.valueof (l_analytic, 'addr2_domain/text()', l_rec.addr1_domain);
            dbms_xslprocessor.valueof (l_analytic, 'addr2_region/text()', l_rec.addr1_region);
            dbms_xslprocessor.valueof (l_analytic, 'addr2_street/text()', l_rec.addr1_street);
            dbms_xslprocessor.valueof (l_analytic, 'work/text()', l_rec.work);
            dbms_xslprocessor.valueof (l_analytic, 'office/text()', l_rec.office);
            dbms_xslprocessor.valueof (l_analytic, 'date_w/text()', l_tmp);
            l_rec.date_w := to_date (l_tmp, 'yyyy-dd-mm');
            dbms_xslprocessor.valueof (l_analytic, 'okpo_w/text()', l_rec.okpo_w);
            dbms_xslprocessor.valueof (l_analytic, 'rnk_proect/text()', l_tmp);
            l_rec.rnk_proect := add_ru_tail (l_tmp, p_mfo);
            dbms_xslprocessor.valueof (l_analytic, 'card_code/text()', l_rec.card_code);
            dbms_xslprocessor.valueof (l_analytic, 'proect_id/text()', l_rec.bpk_proect_id);

            l_tmp := null;
            bars_audit.info (
               g_p_name || l_act || ' parse finish. order_id from corp2 - ' || l_rec.id);


            check_project (l_rec);

            bars_audit.info (
               g_p_name || l_act || ' client check finish. order_id from corp2 - ' || l_rec.id);

            if     l_rec.str_err is null
               and l_rec.okpo is not null
               and l_rec.okpo <> '000000000'
               and l_rec.okpo <> '0000000000'
            then
               --l_rec.rnk := found_client (l_rec.okpo, l_rec.paspseries, l_rec.paspnum);
               l_rec.rnk := found_client2(l_rec.okpo, l_rec.paspseries, l_rec.paspnum);
            else
               l_rec.rnk := null;
            end if;

            bars_audit.info (
               g_p_name || l_act || ' clients search finish. order_id from corp2 - ' || l_rec.id);

            --бранч для открытия клиента и карточки берем по бранчу предприятия
            select branch
              into l_rec.branch
              from customer
             where rnk = l_rec.rnk_proect;


            if l_rec.str_err is null
            then
               if l_rec.rnk is null
               then
                  -- регистрация клиента
                  create_customer (l_rec);
                  bars_audit.info (
                        g_p_name
                     || l_act
                     || ' create_customer finish. order_id from corp2 - '
                     || l_rec.id);
               else
                  -- обновление реквизитов клиента
                  alter_client (l_rec);
                  bars_audit.info (
                        g_p_name
                     || l_act
                     || ' alter_client finish. order_id from corp2 - '
                     || l_rec.id);
               end if;


               select nvl (c.maxterm, t.term_max)
                 into l_rec.term
                 from w4_product_groups a,
                      w4_product b,
                      w4_card c,
                      w4_subproduct s,
                      w4_tips t
                where     c.sub_code = s.code
                      and c.product_code = b.code
                      and b.grp_code = a.code
                      and b.tip = t.tip
                      and c.code = l_rec.card_code;


               bars_ow.open_card (p_rnk            => l_rec.rnk,
                                  p_nls            => null,
                                  p_cardcode       => l_rec.card_code,
                                  p_branch         => l_rec.branch,
                                  p_embfirstname   => l_rec.eng_first_name,
                                  p_emblastname    => l_rec.eng_last_name,
                                  p_secname        => l_rec.mname,
                                  p_work           => l_rec.work,
                                  p_office         => l_rec.office,
                                  p_wdate          => l_rec.date_w,
                                  p_salaryproect   => l_rec.bpk_proect_id,
                                  p_term           => l_rec.term,
                                  p_branchissue    => l_rec.branch,
                                  p_nd             => l_rec.nd,
                                  p_reqid          => l_rec.reqid);

               bars_audit.info (
                  g_p_name || l_act || ' open card finish . order_id from corp2 - ' || l_rec.id);

               select nls
                 into l_rec.nls_2625
                 from accounts
                where acc = (select acc_pk
                               from w4_acc
                              where nd = l_rec.nd);
            end if;
         exception
            when others
            then
               l_rec.str_err :=
                     l_rec.str_err
                  || '. ERORR - '
                  || dbms_utility.format_error_stack ()
                  || chr (10)
                  || dbms_utility.format_error_backtrace ();

               bars_error.raise_nerror ('PZP', l_rec.str_err);
         end;

         if l_in_encoding <> l_our_encoding
         then
            l_rec.str_err := convert (l_rec.str_err, l_in_encoding, l_our_encoding);
         end if;

         select xmlelement ("row",
                            xmlelement ("id", l_rec.id),
                            xmlelement ("str_err", l_rec.str_err),
                            xmlelement ("nls_2625", l_rec.nls_2625))
           into l_xml_tmp
           from dual;

         dbms_lob.append (l_clob_data, l_xml_tmp.getclobval ());


         bars_audit.info (
            g_p_name || l_act || ' answer is formed . order_id from corp2 - ' || l_rec.id);

         l_rec := null;
      end loop;

      dbms_lob.append (l_clob_data, '</rowset>');

      p_response := packing (l_clob_data);

      bars_audit.info (g_p_name || l_act || 'finish.');

      dbms_xmldom.freedocument (l_doc);
      dbms_lob.freetemporary (l_doc_clob);
   exception
      when others then
        p_errmsg   := 'Системна помилка в процедурі відкриття карт: ' || sqlerrm || chr(10) || dbms_utility.format_error_backtrace;
        p_response := p_blob_data;
         /*bars_error.raise_nerror (
            'PZP',
               g_p_name
            || l_act
            || '. ERORR - '
            || dbms_utility.format_error_stack ()
            || chr (10)
            || dbms_utility.format_error_backtrace ());*/
   end;

    function utf8todeflang(p_clob in    clob) return clob is
      l_blob blob;
      l_clob clob;
      l_dest_offset   integer := 1;
      l_source_offset integer := 1;
      l_lang_context  integer := DBMS_LOB.DEFAULT_LANG_CTX;
      l_warning       integer := DBMS_LOB.WARN_INCONVERTIBLE_CHAR;
    BEGIN
      DBMS_LOB.CREATETEMPORARY(l_blob, FALSE);
      DBMS_LOB.CONVERTTOBLOB
      (
       dest_lob    =>l_blob,
       src_clob    =>p_clob,
       amount      =>DBMS_LOB.LOBMAXSIZE,
       dest_offset =>l_dest_offset,
       src_offset  =>l_source_offset,
       blob_csid   =>0,
       lang_context=>l_lang_context,
       warning     =>l_warning
      );
      l_dest_offset   := 1;
      l_source_offset := 1;
      l_lang_context  := DBMS_LOB.DEFAULT_LANG_CTX;
      DBMS_LOB.CREATETEMPORARY(l_clob, FALSE);
      DBMS_LOB.CONVERTTOCLOB
      (
       dest_lob    =>l_clob,
       src_blob    =>l_blob,
       amount      =>DBMS_LOB.LOBMAXSIZE,
       dest_offset =>l_dest_offset,
       src_offset  =>l_source_offset,
       blob_csid   =>NLS_CHARSET_ID ('UTF8'),
       lang_context=>l_lang_context,
       warning     =>l_warning
      );
      return l_clob;
    end;

   procedure set_payrolls (p_clob_data in clob, p_clob_out out clob)
   is
      l_parser              dbms_xmlparser.parser;
      l_doc                 dbms_xmldom.domdocument;
      l_analyticlist        dbms_xmldom.domnodelist;
      l_analyticlist_docs   dbms_xmldom.domnodelist;
      l_analyticlist_attr   dbms_xmldom.domnodelist;
      l_analytic            dbms_xmldom.domnode;
      l_analytic_attr       dbms_xmldom.domnode;
      l_analytic_sign       dbms_xmldom.domnode;
      l_xmldocelement       dbms_xmldom.domelement;

      l_act                 varchar2 (256) := '.set_payrolls ';

      l_tmp                 varchar2 (4000);

      type l_rec_payroll is record
      (
         rnk            number,
         mfo            varchar2 (12),
         payroll_id     number,
         payroll_num    varchar2 (64),
         payroll_date   date,
         nazn           varchar2 (160),
         nls_2909       varchar2 (15),
         err            varchar2 (4000)
      );


      type l_tab_docs is table of zp_payroll_doc%rowtype;

      l_payroll_row         l_rec_payroll;

      l_payroll_docs        l_tab_docs := l_tab_docs ();

      l_zp_payroll          zp_payroll%rowtype;
      l_zp_deals            zp_deals%rowtype;

      n                     number;
      l_zp_payroll_doc      zp_payroll_doc%rowtype;
      l_rnk                 customer.rnk%type;
      l_acc                 accounts.acc%type;

      l_clob_data           clob;
      l_buff                clob;
   begin
     bars_audit.info (g_p_name || l_act || 'start');
      dbms_lob.createtemporary (l_clob_data, false);
      dbms_lob.append (l_clob_data, '<payrolls>');

      l_buff := decodebase64(p_clob_data);

      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob (l_parser, l_buff);
      l_doc := dbms_xmlparser.getdocument (l_parser);
      dbms_xmlparser.freeparser (l_parser);
      l_analytic := dbms_xmldom.makenode (l_doc);
      l_analyticlist := dbms_xslprocessor.selectnodes (l_analytic, 'payrolls/payroll');

      for j in 1 .. dbms_xmldom.getlength (l_analyticlist)
      loop
         l_analytic := dbms_xmldom.item (l_analyticlist, j - 1);

         dbms_xslprocessor.valueof (l_analytic, 'mfo/text()', l_payroll_row.mfo);

         bc.go(l_payroll_row.mfo);

         dbms_xslprocessor.valueof (l_analytic, 'rnk/text()', l_tmp);
         l_payroll_row.rnk := add_ru_tail (l_tmp);

         --bars_audit.info ('zp_corp2_intg.set_payrolls l_payroll_row.rnk='||to_char(l_payroll_row.rnk));

         dbms_xslprocessor.valueof (l_analytic, 'payroll_id/text()', l_payroll_row.payroll_id);
         dbms_xslprocessor.valueof (l_analytic, 'payroll_num/text()', l_tmp);
         l_payroll_row.payroll_num := substr (l_tmp, 1, 64);
         dbms_xslprocessor.valueof (l_analytic, 'payroll_date/text()', l_tmp);
         l_payroll_row.payroll_date := to_date (l_tmp, 'DD-MON-YY');
         dbms_xslprocessor.valueof (l_analytic, 'nazn/text()', l_tmp);
         l_payroll_row.nazn := substr (l_tmp, 1, 160);
         dbms_xslprocessor.valueof (l_analytic, 'nls_2909/text()', l_payroll_row.nls_2909);

         l_analyticlist_docs := dbms_xslprocessor.selectnodes (l_analytic, 'docs/doc');

         --проверяем ,есть ли зп договор
         begin
            select z.*
              into l_zp_deals
              from zp_deals z
             where rnk = l_payroll_row.rnk and sos >= 0;
         exception
            when no_data_found
            then
               l_payroll_row.err := 'zp_deal_not_found';
         end;

         --bars_audit.info ('zp_corp2_intg.set_payrolls l_payroll_row.err='||l_payroll_row.err);

         --проверяем ,не  записана ли эта ведомость
         begin
            select 1
              into n
              from zp_payroll
             where corp2_id = l_payroll_row.payroll_id;

            if n = 1
            then
               l_payroll_row.err := 'payroll_was_exported_early';
            end if;
         exception
            when no_data_found
            then
               null;
         end;

         --bars_audit.info ('zp_corp2_intg.set_payrolls l_payroll_row.err='||l_payroll_row.err);

         --проверяем счет 2909
         begin
           --bars_audit.info ('zp_corp2_intg.set_payrolls l_payroll_row.nls_2909='||to_char(l_payroll_row.nls_2909));
            select acc
              into l_acc
              from accounts a
             where a.nls = l_payroll_row.nls_2909 and kv = 980 and kf = l_payroll_row.mfo;

            if l_acc <> l_zp_deals.acc_2909
            then
               l_payroll_row.err := '2909_not_match_with_deal';
            end if;
         exception
            when no_data_found
            then
               l_payroll_row.err := '2909_not_found';
         end;

         --bars_audit.info ('zp_corp2_intg.set_payrolls l_payroll_row.err='||l_payroll_row.err);

         if l_payroll_row.err is null
         then
            l_zp_payroll.id := bars_sqnc.get_nextval ('s_zp_payroll');
            l_zp_payroll.rnk := l_zp_deals.rnk;
            l_zp_payroll.zp_id := l_zp_deals.id;
            l_zp_payroll.zp_deal_id := l_zp_deals.deal_id;
            l_zp_payroll.sos := 2;
            l_zp_payroll.source := 5;
            l_zp_payroll.crt_date := sysdate;
            l_zp_payroll.branch := l_zp_deals.branch;
            l_zp_payroll.kf := l_payroll_row.mfo;
            l_zp_payroll.user_id := l_zp_deals.user_id;
            l_zp_payroll.upd_date := sysdate;
            l_zp_payroll.corp2_id := l_payroll_row.payroll_id;
            l_zp_payroll.pr_date := l_payroll_row.payroll_date;
            l_zp_payroll.payroll_num := l_payroll_row.payroll_num;
            l_zp_payroll.nazn := l_payroll_row.nazn;

            insert into zp_payroll
                 values l_zp_payroll;

            for q in 1 .. dbms_xmldom.getlength (l_analyticlist_docs)
            loop
               l_payroll_docs.extend;

               l_analytic := dbms_xmldom.item (l_analyticlist_docs, q - 1);

               dbms_xslprocessor.valueof (l_analytic,
                                          'doc_id/text()',
                                          l_payroll_docs (l_payroll_docs.last).corp2_id);

               l_analyticlist_attr :=
                  dbms_xslprocessor.selectnodes (
                     l_analytic,
                     'doc_body/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES/ATTRIBUTE');

               for w in 1 .. dbms_xmldom.getlength (l_analyticlist_attr)
               loop
                  l_analytic_attr := dbms_xmldom.item (l_analyticlist_attr, w - 1);

                  l_xmldocelement := dbms_xmldom.makeelement (l_analytic_attr);

                  l_tmp := dbms_xmldom.getattribute (l_xmldocelement, 'ATTR_ID');


                  if l_tmp = 'PAYER_ACCOUNT'
                  then
                     l_payroll_docs (l_payroll_docs.last).corp2_nlsa :=
                        substr (
                           dbms_xmldom.getnodevalue (dbms_xmldom.getfirstchild (l_analytic_attr)),
                           1,
                           15);
                  elsif l_tmp = 'PAYEE_ACCOUNT'
                  then
                     l_payroll_docs (l_payroll_docs.last).nlsb :=
                        substr (
                           dbms_xmldom.getnodevalue (dbms_xmldom.getfirstchild (l_analytic_attr)),
                           1,
                           15);
                  elsif l_tmp = 'PAYEE_BANK_CODE'
                  then
                     l_payroll_docs (l_payroll_docs.last).mfob :=
                        substr (
                           dbms_xmldom.getnodevalue (dbms_xmldom.getfirstchild (l_analytic_attr)),
                           1,
                           12);
                  elsif l_tmp = 'PAYEE_NAME'
                  then
                     l_payroll_docs (l_payroll_docs.last).namb :=
                        substr (
                           dbms_xmldom.getnodevalue (dbms_xmldom.getfirstchild (l_analytic_attr)),
                           1,
                           38);
                  elsif l_tmp = 'PAYEE_TAX_CODE'
                  then
                     l_payroll_docs (l_payroll_docs.last).okpob :=
                        substr (
                           dbms_xmldom.getnodevalue (dbms_xmldom.getfirstchild (l_analytic_attr)),
                           1,
                           14);
                  elsif l_tmp = 'DOC_SUM'
                  then
                     l_payroll_docs (l_payroll_docs.last).s :=
                        to_number (
                           dbms_xmldom.getnodevalue (dbms_xmldom.getfirstchild (l_analytic_attr)))*100;
                  elsif l_tmp = 'DOC_NARRATIVE'
                  then
                     l_payroll_docs (l_payroll_docs.last).nazn :=
                        substr (
                           dbms_xmldom.getnodevalue (dbms_xmldom.getfirstchild (l_analytic_attr)),
                           1,
                           160);
                  elsif l_tmp = 'DOC_SER_PASS'
                  then
                     l_payroll_docs (l_payroll_docs.last).passp_serial :=
                        substr (
                           dbms_xmldom.getnodevalue (dbms_xmldom.getfirstchild (l_analytic_attr)),
                           1,
                           2);
                  elsif l_tmp = 'DOC_NUM_PASS'
                  then
                     l_payroll_docs (l_payroll_docs.last).passp_num :=
                        substr (
                           dbms_xmldom.getnodevalue (dbms_xmldom.getfirstchild (l_analytic_attr)),
                           1,
                           6);
                  end if;
               end loop;

               l_payroll_docs (l_payroll_docs.last).sign :=
                  dbms_xmldom.getnodevalue (
                     dbms_xmldom.getfirstchild (
                        dbms_xslprocessor.selectsinglenode (
                           l_analytic,
                           'doc_body/SIGNED_DOCUMENT/SIGNATURES/SIGNATURE')));
               l_payroll_docs (l_payroll_docs.last).signed := 'Y';


               l_analytic_sign :=
                  dbms_xslprocessor.selectsinglenode (
                     l_analytic,
                     'doc_body/SIGNED_DOCUMENT/SIGNATURES/SIGNATURE');
               l_xmldocelement := dbms_xmldom.makeelement (l_analytic_sign);
               l_payroll_docs (l_payroll_docs.last).key_id :=
                  dbms_xmldom.getattribute (l_xmldocelement, 'KEY_ID');

               l_analytic_sign :=
                  dbms_xslprocessor.selectsinglenode (l_analytic,
                                                      'doc_body/SIGNED_DOCUMENT/DOCUMENT/HEADER');
               l_xmldocelement := dbms_xmldom.makeelement (l_analytic_sign);
               l_payroll_docs (l_payroll_docs.last).signed_user :=
                  dbms_xmldom.getattribute (l_xmldocelement, 'USER_ID');

               l_payroll_docs (l_payroll_docs.last).id := bars_sqnc.get_nextval ('s_zp_payroll_doc');
               l_payroll_docs (l_payroll_docs.last).id_pr := l_zp_payroll.id;
               l_payroll_docs (l_payroll_docs.last).source := 5;
               l_payroll_docs (l_payroll_docs.last).crt_date := sysdate;
               l_payroll_docs (l_payroll_docs.last).id_file := null;
               l_payroll_docs (l_payroll_docs.last).ref := null;
            end loop;

            forall k in l_payroll_docs.first .. l_payroll_docs.last
               insert into zp_payroll_doc
                    values l_payroll_docs (k);
         end if;

         dbms_lob.append (l_clob_data, '<payroll>');
         dbms_lob.append (l_clob_data,
                          '<payroll_id>' || l_payroll_row.payroll_id || '</payroll_id>');
         dbms_lob.append (
            l_clob_data,
               '<payroll_response>'
            || case when l_payroll_row.err is not null then l_payroll_row.err else 'ok' end
            || '</payroll_response>');
         dbms_lob.append (l_clob_data, '</payroll>');

         l_payroll_docs.delete ();
         l_payroll_row := null;
      end loop;

      dbms_lob.append (l_clob_data, '</payrolls>');

      dbms_xmldom.freedocument (l_doc);

      p_clob_out := l_clob_data;
      bars_audit.info (g_p_name || l_act || 'finish');
   exception
      when others
      then
         dbms_xmldom.freedocument (l_doc);
         bars_error.raise_nerror (
            'PZP',
               g_p_name
            || l_act
            || '. ERORR - '
            || dbms_utility.format_error_stack ()
            || chr (10)
            || dbms_utility.format_error_backtrace ());
   end;

   function form_payrolls_result return clob
   is
      l_xml_tmp     xmltype := null;
      l_clob_data   clob;
      l_act         varchar2 (100) := '.form_payrolls_result.';
   begin
      bars_audit.info (g_p_name || l_act || ' start.');

      dbms_lob.createtemporary (l_clob_data, false);
      dbms_lob.append (l_clob_data, '<rowset>');

      --for j in (select * from mv_kf)
      --loop

         for l in (select log.*
                     from zp_payroll_log log
                    where send_status = 0)
         loop


            dbms_lob.append (l_clob_data, '<row>');
            dbms_lob.append (l_clob_data, '<payroll_id>' || l.corp2_id || '</payroll_id>');
            dbms_lob.append (l_clob_data, '<payroll_status>' || l.status || '</payroll_status>');
            dbms_lob.append (l_clob_data, '<payroll_err>' || l.err || '</payroll_err>');
            dbms_lob.append (l_clob_data, '<docs>');

            for c
               in (select d.corp2_id,
                          log.status,
                          log.err,
                          o.ref,
                          o.sos,
                          d.doc_comment
                     from zp_payroll_log log, zp_payroll_doc d, oper o
                    where     send_status = 0
                          and d.id_pr = log.id
                          and d.ref = o.ref(+)
                          and log.corp2_id = l.corp2_id)
            loop
               dbms_lob.append (l_clob_data, '<doc>');
               dbms_lob.append (l_clob_data, '<doc_id>' || c.corp2_id || '</doc_id>');
               dbms_lob.append (l_clob_data, '<ref>' || c.ref || '</ref>');
               dbms_lob.append (l_clob_data, '<doc_sos>' || c.sos || '</doc_sos>');
               dbms_lob.append (l_clob_data, '<doc_comm>' || c.doc_comment || '</doc_comm>');
               dbms_lob.append (l_clob_data, '</doc>');
            end loop;

            dbms_lob.append (l_clob_data, '</docs>');
            dbms_lob.append (l_clob_data, '</row>');
            /*
            update zp_payroll_log
               set send_status = 1
             where corp2_id = l.corp2_id;
             */
         end loop;

      --end loop;

      dbms_lob.append (l_clob_data, '</rowset>');

      bars_audit.info (g_p_name || l_act || ' finish.' || substr (l_clob_data, 1, 100));

      if dbms_lob.getlength (l_clob_data) > 0
      then
         return encodebase64(l_clob_data);
      else
         return empty_clob ();
      end if;
   end;

  procedure set_payroll_log_result(p_result in clob)
  is
    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_res         dbms_xmldom.domnode;
    l_analyticlist        dbms_xmldom.domnodelist;
    l_analytic            dbms_xmldom.domnode;

    type t_payroll_row is record
    (
       payroll_id       varchar2(38),
       payroll_status   varchar2(1),
       payroll_err      varchar2(4000)
    );
   
    type t_payroll is table of t_payroll_row;
    
    l_payroll_tb t_payroll := t_payroll();
    l_satatus    varchar2(255);
    l_message    clob;
    l_act        varchar2 (256) := '.set_payroll_log_result.';
  begin
    dbms_lob.createtemporary (l_message, false);

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob (l_parser, p_result);
    l_doc := dbms_xmlparser.getdocument (l_parser);
    dbms_xmlparser.freeparser (l_parser);
    l_analytic := dbms_xmldom.makenode (l_doc);
    l_analyticlist := dbms_xslprocessor.selectnodes (l_analytic, 'SendPayrollResultToCorp2Response/SendPayrollResultToCorp2Result', 'xmlns="http://ws.unity-bars-utl.com.ua/"');

    for j in 1 .. dbms_xmldom.getlength (l_analyticlist)
    loop
       l_analytic := dbms_xmldom.item (l_analyticlist, j - 1);
       dbms_xslprocessor.valueof (l_analytic, 'status/text()', l_satatus);
       dbms_xslprocessor.valueof (l_analytic, 'message/text()', l_message);
    end loop;

    if upper(l_satatus) = 'OK' and l_message is not null then  
      l_message := decodebase64(l_message);
      
      if upper(l_message) not in ('NULL','ERR') then
        l_parser := dbms_xmlparser.newparser;
        dbms_xmlparser.parseclob (l_parser, l_message);
        l_doc := dbms_xmlparser.getdocument (l_parser);
        l_analyticlist := dbms_xslprocessor.selectnodes (dbms_xmldom.makenode (l_doc), 'root/payroll');

        for i in 1 .. dbms_xmldom.getlength (l_analyticlist)
        loop
          l_analytic := dbms_xmldom.item (l_analyticlist, i - 1);
          l_payroll_tb.extend; 
          dbms_xslprocessor.valueof (l_analytic, 'id/text()', l_payroll_tb(i).payroll_id);
          dbms_xslprocessor.valueof (l_analytic, 'st/text()', l_payroll_tb(i).payroll_status);
          --dbms_xslprocessor.valueof (l_analytic, 'err/text()', l_payroll_tb(i).payroll_err);
        end loop;
        
        forall i in l_payroll_tb.first..l_payroll_tb.last
          update zp_payroll_log
             set send_status = 1
           where corp2_id = to_number(l_payroll_tb(i).payroll_id)
                 and l_payroll_tb(i).payroll_status = '1';
      else
        bars_audit.info (g_p_name || l_act || ' l_satatus='||l_satatus || ', l_message='||substr(l_message,1,2000));
      end if;
    else
      bars_audit.info (g_p_name || l_act || ' l_satatus='||l_satatus || ', l_message='||substr(l_message,1,2000));
    end if;
    
    dbms_xmlparser.freeparser (l_parser);
    dbms_xmldom.freedocument (l_doc);
  exception
    when others then
      dbms_xmlparser.freeparser (l_parser);
      dbms_xmldom.freedocument (l_doc);
      raise;
  end set_payroll_log_result;
    
   procedure send_payrolls_result
   is
      l_method      varchar2 (400) := 'SendPayrollResultToCorp2';
      l_request     soap_rpc.t_request;
      l_response    soap_rpc.t_response;
      l_url         params$global.val%type
         --:= 'http://10.10.10.44:18000/barsroot/webservices/SalaryBagServices/ZPServiceMain.asmx';
         :=    getglobaloption ('ABSBARS_WEBSERVER_PROTOCOL')
            || '://'
            || getglobaloption ('ABSBARS_WEBSERVER_IP_ADRESS')
            || getglobaloption ('ZPCENTRAL');
      l_dir         varchar2 (256) := getglobaloption ('PATH_FOR_ABSBARS_WALLET');
      l_pass        varchar2 (256) := getglobaloption ('PASS_FOR_ABSBARS_WALLET');

      l_clob        clob;
      l_error       varchar2 (2000);
      l_act         varchar2 (256) := '.send_payrolls_result.';
      l_buff        clob;
      l_corp2_url   varchar2 (400) := getglobaloption ('ZPCORP2URL');
      --l_corp2_url   varchar2 (400) := 'http://10.10.10.44:18777/ibank/webservices/ZPIntrWebService.asmx';
   begin
      bars_audit.info (g_p_name || l_act || ' start.');

      if l_corp2_url is null then 
        raise_application_error(-20001, 'Не задано параметр ZPCORP2URL');
      end if;

      if l_url is null then 
        raise_application_error(-20001, 'Не задано параметр ZPCENTRAL');
      end if;

      l_buff := form_payrolls_result();

      l_request :=
         soap_rpc.new_request (p_url           => l_url,
                               p_namespace     => 'http://ws.unity-bars-utl.com.ua/',
                               p_method        => l_method,
                               p_wallet_dir    => l_dir,
                               p_wallet_pass   => l_pass);

      soap_rpc.add_parameter (l_request, 'url', l_corp2_url);

      soap_rpc.add_parameter (l_request, 'data', l_buff);

      l_response := soap_rpc.invoke (l_request);

      l_clob := l_response.doc.getclobval ();

      set_payroll_log_result(l_clob);
      
      bars_audit.info (g_p_name || l_act || ' finish.');
      
      commit;

   exception
     when others then
       rollback;
       bars_audit.info (g_p_name || l_act || 'l_clob=' || substr(l_clob,1,2000));
       l_error := substr (dbms_utility.format_error_backtrace || ' ' || sqlerrm, 1, 2000);
       bars_error.raise_nerror (g_err_mod,
                                g_p_name || l_act || 'finish with error.error -' || l_error);
   end;
begin
   init;
end zp_corp2_intg;
/

show err;
/

grant execute on zp_corp2_intg to bars_access_defrole;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/package/zp_corp2_intg.sql =========*** End *** 
PROMPT ===================================================================================== 
