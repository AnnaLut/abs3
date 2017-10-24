
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_xmlklb_que.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_XMLKLB_QUE is

   --***************************************************************--
   --
   --  ����� ��������� �������� ��������� �� ������ � KLBX
   --
   --  DMSU - ��� ����. ����. ������
   --  KAZ  - �����������
   --  SBR  - ��������
   --  MKF  - �������. ����� (��������)
   --***************************************************************--


  G_HEADER_VERSION  constant varchar2(64) := 'version 3.0 23.12.2008';

   -----------------------------------------------------------------
   --   ����
   -----------------------------------------------------------------



   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     ������� ���������� ������ � ������� ��������� ������
   --
   --
   --
   function header_version return varchar2;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     ������� ���������� ������ � ������� ���� ������
   --
   --
   --
   function body_version return varchar2;



   -----------------------------------------------------------------
   --   GET_REPLY
   --
   --   ������ ����� �� ������ � �������
   --   ������ ������� �� ������� � �������� �������, ���������� �������� �������
   --   � ����� �� �������. �.�. � ������� �������� XML ��������, �����������
   --   ��������� �������. ���� ��������� ������ ������ blobXMLReply -
   --   ����� ��� ������������ ���������
   --
   --   p_gateid     - ����� ���������       (���� =0 - ������� �����)
   --   p_clo        - ��������� ����� ������
   --   p_packname   - ��� ���������� ����� ��� ������
   --   p_partcnt    - ���-�� ��������
   --
   procedure get_reply(
                  p_gateid           out number,
                  p_reply          out nocopy clob,
                  p_partcnt          out number,
                  p_packname         out varchar2);



   -----------------------------------------------------------------
   --  GET_REPLY_PARTITION
   --
   --   ������ ��������� �������� ������
   --
   --   p_msgtype
   --   p_gateid   - ����� ���������       (���� = 0 - ����� �������� ����)
   --   p_partid   - ����� ��������
   --   p_reply    - �����
   --
   procedure get_reply_partition(
                  p_gateid        number,
                  p_partid        number,
                  p_reply     out clob);



   -----------------------------------------------------------------
   --
   --    GET_MODULE_REQUEST()
   --
   --    �������� �� ������� ������
   --
   --

   procedure get_module_request(
                  p_clob_out  out clob );






   -----------------------------------------------------------------
   --   GET_REPLY_PACKNAME
   --
   --   ������ ����� �� ������ � �������
   --
   --   p_messtype  - ��� ���������
   --   p_servdate  - �������� ���� ��� ������� �������
   --   p_receiver  - ���������. ����������
   --   p_prfx      - ������� �����
   --
   function get_reply_packname(
                  p_messtype   varchar2,
                  p_servparam  varchar2  default null,
                  p_receiver   varchar2,
                  p_prfx       varchar2 )    return varchar2;


   -----------------------------------------------------------------
   --   POST_MODULE_REQUEST()
   --
   --   ������� ������� ������� �� ������ � ���������� �����������
   --   �� ������ ��������� ������ 4-� ����������
   --
   --   p_messtype   -- ��� ���������
   --   p_messtype   -- ������
   --   p_param1     -- ��� ��������� ���������� � ���� ��������� ��������
   --   p_param2
   --   p_param3
   --   p_param4
   --

   procedure post_module_request(
                   p_servicename  varchar2,
                   p_sab          varchar2,
                   p_param1       varchar2 default null,
       		   p_param2       varchar2 default null,
                   p_param3       varchar2 default null,
   		   p_param4       varchar2 default null);





   -----------------------------------------------------------------
   --   POST_MODULE_REQUEST_AUTO()
   --
   --   ������� ������� ������� �� ������ � �������������� ���������� ����������
   --
   --   p_servicename  -- ��� ���������
   --   p_sab          -- ������
   --
   procedure post_module_request_auto(
                   p_servicename  varchar2,
                   p_sab          varchar2);

   -----------------------------------------------------------------
   --   POST_MODULE_REQUEST_ALL()
   --
   --   ������� ������� ���� �������� ��� �������
   --
   --   p_sab          -- ������
   --
   procedure post_module_request_all(p_sab  varchar2);


   -----------------------------------------------------------------
   --   GET_DEF_SERVICE_PARAMS()
   --
   --   �������� �������� �� -��������� ���������� ��� �������
   --
   --
   procedure get_def_service_params(
                   p_service     varchar2,
                   p_parnam1  out varchar2,
                   p_parval1  out varchar2,
                   p_parnam2  out varchar2,
                   p_parval2  out varchar2,
                   p_parnam3  out varchar2,
                   p_parval3  out varchar2,
                   p_parnam4  out varchar2,
                   p_parval4  out varchar2);



end;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_XMLKLB_QUE is


   ------------------------------------------------------------
   --
   --  ����� ��������� �������� ��������� �� ������ � KLBX
   --
   --  DMSU - ��� ����. ����. ������
   --  KAZ  - �����������
   --  SBR  - ��������
   --  MKF  - �������. ����� (��������)
   --
   ------------------------------------------------------------


   G_BODY_DEFS constant varchar2(512) := ''
  	||'SBR - ��������'    || chr(10)
  	||'MKF - ���������������� ������'
  ;


   ----------------------------------------------
   --  ���������
   ----------------------------------------------

   G_BODY_VERSION    constant varchar2(64) := 'version 2.0 09.09.2008';
   G_TRACE           constant varchar2(20) := 'xmlklb_que.';
   G_REPLY_PRFX      constant varchar2(1)  := 'T'; --  ������� �����;


   type array_varchar2 is table of varchar2(500) index by binary_integer;

   -- ���������� � �� ������������
   type type_service_param  is record
     (  pardesc  xml_servlist_params.pardesc%type,
        parval   varchar2(200)
     );

   type array_params is table of type_service_param index by binary_integer;

   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     ������� ���������� ������ � ������� ��������� ������
   --
   --
   --
   function header_version return varchar2
   is
   begin
       return 'package header BARS_XMLKLB_QUE: ' || G_BODY_VERSION;
   end header_version;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     ������� ���������� ������ � ������� ���� ������
   --
   --
   --
   function body_version return varchar2
   is
   begin
       return 'package body BARS_XMLKLB_QUE ' || G_BODY_VERSION || chr(10) ||
              'package body definition(s):' || chr(10) || G_BODY_DEFS;
   end body_version;



   -----------------------------------------------------------------
   --    H2_RRP()
   --
   --   -- Decimal --> 32-imal
   --
   --
   function h2_rrp(i smallint) return char is
     x char(1);
   begin
      if i>=0 and i<=9 then  x := chr(i+48);
      elsif i>=10 and i<=35 then  x := chr(i+55);
      else x := '0';
      end if;
      return x;
   end h2_rrp;



   -----------------------------------------------------------------
   --   GET_SERVICE_PARAM_VALUE
   --
   --   �� ������ ���������� ������� - �������� �������� ���������
   --
   --   l_params     -  ������ ����������
   --   l_paramnum   -  ����� ���������
   --
   function get_service_param_value(
                  p_params     varchar2,
                  p_paramnum   smallint)
   return varchar2
   is
      l_pos1    smallint;
      l_pos2    smallint;
      l_rez     varchar2(1000);
      l_trace    varchar2(1000):=G_TRACE||'get_service_param_value: ';
   begin

      l_pos1 := instr(upper(p_params),'P'||p_paramnum||'="') + 4;

      if l_pos1 > 0 then
         l_pos2  := instr(upper(p_params),'"', l_pos1);
         l_rez   := substr(p_params, l_pos1, (l_pos2 - l_pos1) );
      else return null;
      end if;

      return  l_rez;
   end;







   -----------------------------------------------------------------
   --   INIT_SERVICE_PARAMS
   --
   --   ��������� ��������� - ���������� �������
   --
   --   p_service  -  ��������� �������
   --   p_params   -  ������ ���������
   --
   procedure init_service_params(
                  p_message        xml_servlist.snam%type,
                  p_params         varchar2,
                  p_service in out bars_xmlklb.t_service)
   is
   begin
      p_service.name   := p_message;
      p_service.param1 := get_service_param_value(p_params,1);
      p_service.param2 := get_service_param_value(p_params,2);
      p_service.param3 := get_service_param_value(p_params,3);
      p_service.param4 := get_service_param_value(p_params,4);

   end;




   -----------------------------------------------------------------
   --   GET_REPLY_PACKNAME
   --
   --   ������ ����� �� ������ � �������
   --
   --   p_messtype  - ��� ���������
   --   p_servdate  - �������� ���� ��� ������� �������
   --   p_receiver  - ���������. ����������
   --   p_prfx      - ������� �����
   --
   function get_reply_packname(
                  p_messtype   varchar2,
                  p_servparam  varchar2  default null,
                  p_receiver   varchar2,
                  p_prfx       varchar2 )
   return varchar2
   is
      l_messnbr   number;
      l_chrnbr    varchar2(3);
      l_date      date;
      l_div       number;
      l_mod       number;
      l_packname  varchar2(20);
      l_trace     varchar2(1000):=G_TRACE||'get_reply_packname: ';
   begin


      /* ������� */
      bars_audit.trace('����� ����� �����, ��� ��������� '||p_messtype);
      if p_messtype = 'DMVP' or p_messtype =  'DMVF' or p_messtype = 'REQB' then

          l_chrnbr := substr(p_messtype, -3);
          -- ���� � ����� ����� ������ ���� ����� �� ������� ������� �������
          -- ������ �������� ������  �������� ���� �������
          begin
             l_date   := to_date(p_servparam, 'yyyy-mm-dd');
          exception when others then
             bars_error.raise_error('KLB', 47, p_messtype, p_servparam);
          end;

      else

          l_date   := gl.bd;
          begin
             select to_number(val) + 1 into l_messnbr
             from params
             where par = 'MNumCB';

             if (l_messnbr >= 46655) then
                l_messnbr := 1;
             end if;
       	  exception when no_data_found then
                l_messnbr := 1;
                insert into params$base(par, val, comm)
     	        values ('MNumCB', l_messnbr, '���������� ����� �������-�����  ��-�����');
          end;


          l_chrnbr := '';
          l_div := l_messnbr;
          while (l_div > 0) loop
              l_mod     := mod(l_div, 36);
              l_div    := trunc(l_div/36);
              l_chrnbr := h2_rrp( l_mod )||l_chrnbr;
          end loop;

          l_chrnbr := lpadchr(l_chrnbr, '0', 3);

          update params$base
          set val = l_messnbr
          where par = 'MNumCB';
          bars_audit.trace('��������� ������ - '||l_messnbr);

      end if;
          l_packname :=  h2_rrp( to_char(l_date,'MM'))||h2_rrp( to_char(l_date,'DD'))||'.'||l_chrnbr;
          l_packname := p_prfx||substr(p_receiver, -5)||l_packname;
          bars_audit.trace('���� - '||l_packname);
          return l_packname;

   end;




   -----------------------------------------------------------------
   --    SAVE_REQUEST
   --
   --    ��������� � ���� ��������� ������ ��� ��������� ������
   --
   --    p_gateid   -  ����� �������
   --
   function save_request return number
   is
      l_newid number;
   begin

      select s_xml_gate.nextval into l_newid from dual;

      insert into xml_gate (id,pnam,datf)  values (l_newid, dbms_flashback.get_system_change_number, sysdate);
      return l_newid;
   end save_request;




   -----------------------------------------------------------------
   --   SERVICE_TOSTRING
   --
   --   �������� ��������� � ������
   --
   --   p_service
   --
   function service_tostring(
                  p_srv  bars_xmlklb.t_service)
   return varchar2
   is
   begin
      return '������: '||p_srv.name||' p1='||p_srv.param1||' p2='||p_srv.param2||' p3='||p_srv.param3||' p4='||p_srv.param4;
   end;




   -----------------------------------------------------------------
   --   GET_RECEIVER
   --
   --   �� ����� �� ������� ������� �������� ��� ����������
   --
   --   p_params
   --
   function get_receiver(
                  p_quetxt  varchar2)
   return varchar2
   is
      l_pos2 number;
      l_pos1 number;
   begin
      l_pos1 := instr(p_quetxt,'|',1,1);
      l_pos2 := instr(p_quetxt,'|',1,2);

      if l_pos2 = 0 then
         return substr(p_quetxt, l_pos1 + 1);
      else
         return substr(p_quetxt, l_pos1 + 1, l_pos2 - l_pos1 - 1);
      end if;
   end;



   -----------------------------------------------------------------
   --  GET_REPLY_PARTITION
   --
   --   ������ ��������� �������� ������
   --
   --   p_msgtype
   --   p_gateid   - ����� ���������       (���� = 0 - ����� �������� ����)
   --   p_partid   - ����� ��������
   --   p_reply    - �����
   --
   procedure get_reply_partition(
                  p_gateid        number,
                  p_partid        number,
                  p_reply     out clob)

   is
   begin
      bars_xmlklb.get_reply_partition(
                   p_gateid  => p_gateid,
                   p_partid  => p_partid,
                   p_reply   => p_reply);
   end;





   -----------------------------------------------------------------
   --   GET_REPLY
   --
   --   ������ ����� �� ������ � �������
   --   ������ ������� �� ������� � �������� �������, ���������� �������� �������
   --   � ����� �� �������. �.�. � ������� �������� XML ��������, �����������
   --   ��������� �������. ���� ��������� ������ ������ blobXMLReply -
   --   ����� ��� ������������ ���������
   --
   --   p_gateid     - ����� ���������       (���� =0 - ������� �����)
   --   p_reply      - ��������� ����� ������
   --   p_packname   - ��� ���������� ����� ��� ������
   --   p_partcnt    - ���-�� ��������
   --
   procedure get_reply(
                  p_gateid           out number,
                  p_reply            out nocopy clob,
                  p_partcnt          out number,
                  p_packname         out varchar2)
   is
      l_trace    varchar2(1000):=G_TRACE||'get_reply: ';
      l_queText      varchar2(4096);
      l_cur          sys_refcursor;
      l_service      bars_xmlklb.t_service;
      l_rplhdr       bars_xmlklb.t_rplheader;
      l_rqvmess      xml_servlist.snam%type;
      l_gateid       number;
      l_receiver     varchar2(6);
   begin


      bars_audit.trace(l_trace||'������ ������������ ������ �� ������');

      -- ����� �� ������� ������
      get_module_request(l_queText);


      bars_audit.trace(l_trace||'������ ���������� �������-'||l_queText);
      if (l_queText is null) then
         bars_audit.trace(l_trace||'����� � ������� - ������');
         p_gateid   := 0;
   	 p_reply  := null;
   	 p_packname := null;
         return;
      end if;



      -- �������� ����� �������
      -- ��� ������ ������� - ������������ �� SCN
      l_rqvmess  := substr(l_queText,1,  instr(l_queText,'|',1,1)-1 );


       -- ���������������� ��������� �������
      init_service_params(
                  p_message  => l_rqvmess,
                  p_params   => substr(l_queText, instr(l_queText,'|',1,2)+1),
                  p_service  => l_service);
      bars_audit.trace(l_trace||'��������� �������-'||service_tostring(l_service));


      l_receiver := get_receiver(l_quetext);

      bars_xmlklb.pretend_branch(l_receiver);
      bars_audit.trace(l_trace||'����� ����������� header-�: ���������� -'|| l_receiver||' ���� ����-'||to_char(gl.bd,'dd-mm-yyyy') );
      l_rplhdr.mess      := 'RCPT';
      l_rplhdr.pack_date := gl.bd + ( sysdate - trunc(sysdate));
      l_rplhdr.sender    := null;
      l_rplhdr.receiver  := l_receiver;
      l_rplhdr.rqv_mess  := l_rqvmess;
      l_rplhdr.rqv_pack  := null;
      l_rplhdr.rqv_date  := null;

      bars_audit.trace(l_trace||'��������� ������:'||bars_xmlklb.rplheader_tostring(l_rplhdr));


       -- ���������
      bars_xmlklb.exec_service(
                  p_service  => l_service,
   	          p_cur      => l_cur);


      -- �������������� ��������� ��������� ���������� �������
      l_rplhdr.pack_name := get_reply_packname
                 ( p_messtype   => l_service.name,
                   p_servparam  => l_service.param1,
                   p_receiver   => l_rplhdr.receiver,
                   p_prfx       => G_REPLY_PRFX);


      -- ������� ����� ���������� �������
      l_gateid := save_request();


      -- ������� � ��������� � ���� �������� ������ �� ������ ������
      bars_xmlklb.create_reply_partitions(
                   p_gateid    => l_gateid,
                   p_partcnt   => p_partcnt,
                   p_service   => l_service,
                   p_cur       => l_cur,
                   p_rplhdr    => l_rplhdr);





      dbms_lob.createtemporary(p_reply, false);
      -- �������� � ������ ������ ��������

      get_reply_partition(
                   p_gateid    => l_gateid,
                   p_partid    => 1,
                   p_reply     => p_reply);


      if ( p_reply is null ) then
         bars_audit.trace(l_trace||'������ ���� ���������');
         p_gateid   := 0;
         p_reply    := null;
         p_packname := null;
      else
         p_gateid   := l_gateid;
         p_packname := l_rplhdr.pack_name;
      end if;




      bars_context.set_context();


   exception when others then
      bars_audit.error(l_trace||'������ ��������� ������ �� �������: '||sqlerrm);
      if dbms_lob.istemporary(p_reply) = 1 then
         dbms_lob.freetemporary(p_reply);
      end if;
      raise;
   end;



   -----------------------------------------------------------------
   --
   --    GET_MODULE_REQUEST()
   --
   --    �������� �� ������� ������
   --
   --

   procedure get_module_request(
                   p_clob_out  out clob )
   is
      l_deqopt	        dbms_aq.dequeue_options_t;
      l_mprop           dbms_aq.message_properties_t;
      l_deq_eventid     raw(16);
      l_text            varchar2(500);
      l_message         sys.aq$_jms_text_message;
      l_tmpclob         clob;

      mq_empty_or_timeout_exception exception;
      pragma exception_init(mq_empty_or_timeout_exception, -25228);

   begin

     l_deqopt.wait := 1;

     begin
         dbms_aq.dequeue (
         queue_name		=> 'bars.module_request_queue',
         dequeue_options	=> l_deqopt,
         message_properties	=> l_mprop,
         payload		=> l_message,
         msgid			=> l_deq_eventid);

         l_message.get_text(l_text);

         dbms_lob.createtemporary(l_tmpclob,FALSE);
         dbms_lob.writeappend(l_tmpclob, length(l_text),  l_text);
         p_clob_out := l_tmpclob;


     exception when mq_empty_or_timeout_exception then  return;

     end;
   end get_module_request;





   -----------------------------------------------------------------
   --   ENQUE_MESSAGE
   --
   --   ��������� � ������� ���������
   --
   --
   procedure enque_message(
                   p_message  varchar2)

   is
      l_enqopt 	    dbms_aq.enqueue_options_t;
      l_mprop 	    dbms_aq.message_properties_t;
      l_message     sys.aq$_jms_text_message;
      l_enqeventid  raw(16);
      l_trace       varchar2(1000) := G_TRACE||'enque_message: ';
   begin

      bars_audit.trace(l_trace||'���������� ������-'||p_message);
      l_message := sys.aq$_jms_text_message.construct;
      l_message.set_text(p_message);
      dbms_aq.enqueue(
              queue_name => 'bars.module_request_queue',
              enqueue_options    => l_enqopt,
              message_properties => l_mprop,
              payload            => l_message,
              msgid              => l_enqeventid);


   end;


   -----------------------------------------------------------------
   --   GET_DEF_VALUES()
   --
   --   �?������� �������� ��-��������� ���������� ��� �������
   --   �� ��������� �������
   --
   function get_def_value(p_formula   varchar2) return varchar2
   is
      l_sql       varchar2(500);
      l_paramval  varchar2(200);
   begin

      if p_formula is null then
         return null;
      end if;

      if substr(p_formula,1,1) = '#' then
         l_sql := substr(p_formula,3, length(p_formula) - 3 );
      else
         l_sql := ''''||p_formula||'''';
      end if;

      l_sql := 'select '||l_sql||' from dual ';
      execute immediate l_sql into l_paramval;
      return l_paramval;
   end;



   -----------------------------------------------------------------
   --   GET_DEF_SERVICE_PARAMS()
   --
   --   �������� �������� �� -��������� ���������� ��� �������
   --
   --
   procedure get_def_service_params(
                   p_service     varchar2,
                   p_parnam1  out varchar2,
                   p_parval1  out varchar2,
                   p_parnam2  out varchar2,
                   p_parval2  out varchar2,
                   p_parnam3  out varchar2,
                   p_parval3  out varchar2,
                   p_parnam4  out varchar2,
                   p_parval4  out varchar2)
   is
      l_parlst      array_params;
      l_paramscnt   number := 4 ;
   begin

      l_parlst.delete;

      for  c in ( select s.num, defvalue, pardesc
                  from   xml_servlist_params p,
                         (select level num from dual connect by level <= l_paramscnt) s
                  where  snam(+) = p_service and s.num = parnum (+)
                  order by s.num) loop

           l_parlst(c.num-1).pardesc := c.pardesc;
           l_parlst(c.num-1).parval  := get_def_value(c.defvalue);
      end loop;

      p_parnam1 := l_parlst(0).pardesc;
      p_parval1 := l_parlst(0).parval;
      p_parnam2 := l_parlst(1).pardesc;
      p_parval2 := l_parlst(1).parval;
      p_parnam3 := l_parlst(2).pardesc;
      p_parval3 := l_parlst(2).parval;
      p_parnam4 := l_parlst(3).pardesc;
      p_parval4 := l_parlst(3).parval;


   end;



   -----------------------------------------------------------------
   --   POST_MODULE_REQUEST()
   --
   --   ������� ������� ������� �� ������ � ���������� �����������
   --   �� ������ ��������� ������ 4-� ����������
   --
   --   p_messtype   -- ��� ���������
   --   p_messtype   -- ������
   --   p_param1     -- ��� ��������� ���������� � ���� ��������� ��������
   --   p_param2
   --   p_param3
   --   p_param4
   --

   procedure post_module_request(
                   p_servicename  varchar2,
                   p_sab          varchar2,
                   p_param1       varchar2 default null,
       		   p_param2       varchar2 default null,
                   p_param3       varchar2 default null,
   		   p_param4       varchar2 default null)
   is
       l_parlst    array_varchar2;
       l_params    varchar2(500);
       l_paramval  varchar2(500);
       l_text      varchar2(1000);
       l_trace     varchar2(1000) := G_TRACE||'module_request: ';
   begin

       bars_audit.trace(l_trace||'� �����');

       l_parlst.delete;
       l_parlst(0) := p_param1;
       l_parlst(1) := p_param2;
       l_parlst(2) := p_param3;
       l_parlst(3) := p_param4;

       bars_audit.trace(l_trace||'���������� ��� '||p_sab||' ������ '||p_servicename);
       for c in (select parnum num, defvalue
                 from   xml_servlist_params
                 where snam = p_servicename
                 order by parnum) loop

          bars_audit.trace(l_trace||'�������� - '||c.num||' def val='||c.defvalue);

          -- �����e�� ���������� ��-���������
          if l_parlst(c.num -1) is null then
             bars_audit.trace(l_trace||'l_parlst(c.num -1) ='||l_parlst(c.num -1)||' is null ');
             l_paramval := get_def_value(c.defvalue);
          else
             bars_audit.trace(l_trace||'l_parlst(c.num -1) ='||l_parlst(c.num -1)||' is not  null ');
             l_paramval := l_parlst(c.num-1);
          end if;

          l_params := l_params||'P'||c.num||'="'||l_paramval||'" ';

     end loop;

     l_text   := concat(concat(concat(concat( p_servicename, '|'), p_sab),'|'),l_params);
     bars_audit.trace(l_trace||'������ ������ '||l_text);
     enque_message(l_text);

   end;





   -----------------------------------------------------------------
   --   POST_MODULE_REQUEST_AUTO()
   --
   --   ������� ������� ������� �� ������ � �������������� ���������� ����������
   --
   --   p_servicename  -- ��� ���������
   --   p_sab          -- ������
   --
   procedure post_module_request_auto(
                   p_servicename  varchar2,
                   p_sab          varchar2)
   is
   begin
      post_module_request(
                 p_servicename => p_servicename,
                 p_sab         => p_sab,
                 p_param1      => null,
                 p_param2      => null,
                 p_param3      => null,
                 p_param4      => null);
   end;



   -----------------------------------------------------------------
   --   POST_MODULE_REQUEST_ALL()
   --
   --   ������� ������� ���� �������� ��� �������
   --
   --   p_sab          -- ������
   --
   procedure post_module_request_all(p_sab  varchar2)
   is
   begin
      for c in (select snam from xml_servlist where auto_gen = 1) loop
          post_module_request_auto(c.snam, p_sab);
      end loop;
   end;






end;
/
 show err;
 
PROMPT *** Create  grants  BARS_XMLKLB_QUE ***
grant EXECUTE                                                                on BARS_XMLKLB_QUE to JBOSS_USR;
grant EXECUTE                                                                on BARS_XMLKLB_QUE to KLBX;
grant EXECUTE                                                                on BARS_XMLKLB_QUE to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_xmlklb_que.sql =========*** End
 PROMPT ===================================================================================== 
 