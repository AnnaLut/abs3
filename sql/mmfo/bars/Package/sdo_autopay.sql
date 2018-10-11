  CREATE OR REPLACE PACKAGE BARS.sdo_autopay is
  -----------------------------------------------------------------
  --
  --    Константы
  --
  -----------------------------------------------------------------

  G_HEADER_VERSION  constant varchar2(64) := 'version 1.0 29.05.2018';

  ----------------------------------------------
  --  переменные
  ----------------------------------------------
  G_OSCHAD_MFO_LIST          varchar2_list;  -- список МФО Ощадного банка
  G_FM_FORBIDEN_WORDS_LIST   varchar2_list;  -- список слов, для исключения документа из автообробки
  

   
  
  -----------------------------------------------------------------
  --
  --    Типы
  --
  -----------------------------------------------------------------
  -----------------------------------------------------------------
  --    compile_sdo_autopay_check_func
  --
  --    Компиляция функции проверки документов для автооплаты на основании откорректированных значений
  --
  --
  procedure compile_sdo_autopay_check_func;
  
  -----------------------------------------------------------------
  --    replace_templates_for_column
  --
  function replace_templates_for_column ( p_field_dbname varchar2, p_field_operator varchar2, p_rule_text varchar2) return varchar2  ; 
   -----------------------------------------------------------------
   --    like_in_list
   --
   --    если значение похохоже на одно из списка, тогда = 1, если нет, тогда - 0
   function like_in_list ( p_values varchar2, p_list  varchar2_list) return number;

END;
/


CREATE OR REPLACE PACKAGE BODY BARS.sdo_autopay is

   ----------------------------------------------
   --  константы
   ----------------------------------------------

   G_BODY_VERSION    constant varchar2(64) := 'version 1.0 29.05.2018';

   G_ERRMOD          constant char(3)      := 'DOC';    -- код модуля
   G_TRACE           constant varchar2(50) := 'sdo_autopay.';

   -----------------------------------------------------------------
   --    INIT_PACK
   --
   --    Функция для инициализации пакета
   --
   procedure init_pack
   is
   begin
      --G_OSCHAD_MFO_LIST := varchar2_list('');
      -- инициализация массива значениями мфо ощадного банка
      --if G_OSCHAD_MFO_LIST.count  = 0 then
         select kf             bulk collect into G_OSCHAD_MFO_LIST        from regions;
         select word_template  bulk collect into G_FM_FORBIDEN_WORDS_LIST from sdo_autopay_nazn_templ;
      --end if;
   end;
   -----------------------------------------------------------------


   -----------------------------------------------------------------
   --    IF_OUR_MMFO
   --
   --    Проверка принадлежности ммфо ощадного банка
   --

   -----------------------------------------------------------------
   --    like_in_list
   --
   --    если значение похохоже на одно из списка, тогда = 1, если нет, тогда - 0
   function like_in_list ( p_values varchar2, p_list  varchar2_list) return number
   is
      l_res smallint;
   begin
      begin
         select 1 into l_res from dual where 1 = ( select max(1) from table(p_list) t where upper(p_values) like '%'||upper(t.column_value)||'%' );
      exception when no_data_found then
         l_res := 0;
      end;
      return l_res;
   end;
   -----------------------------------------------------------------
   --    replace_templates_for_column
   --
   function replace_templates_for_column ( p_field_dbname varchar2, p_field_operator varchar2, p_rule_text varchar2) return varchar2
   is
      l_str  varchar2(2000);
   begin
      -- если условие 'поле похоже на одно из значений в списке'
      if upper(p_field_operator) = upper('not like in list') then
          l_str := '0 = bars.sdo_autopay.like_in_list('||p_field_dbname ||','||p_rule_text||')';
      else
          l_str := p_field_dbname||' '||p_field_operator||' '||p_rule_text;
      end if;
      return l_str;
   end;

   -----------------------------------------------------------------
   --    compile_sdo_autopay_check_func
   --
   --    Компиляция функции проверки документов для автооплаты на основании откорректированных значений
   --
   --
   procedure compile_sdo_autopay_check_func
   is
      l_rule_text   varchar2(4000);
      l_func_text   varchar2(4000);
      l_rule2_text  varchar2(4000);
      l_func2_text  varchar2(4000);
      l_compile_err varchar2(4000);
      l_trace       varchar2(4000) :=  G_TRACE||'compile_sdo_autopay_check_func: ';
      nl char(2) := chr(13)||chr(10);
      l_corp2_function  varchar2(100) := 'sdo_autopay_check_corp2';
      l_cl_function     varchar2(100) := 'sdo_autopay_check_cl';
   begin
     
      select listagg  (  rule_text,      nl||' or '||nl)
             within group (order by rule_id)
        into l_rule_text
        from ( select r.rule_id, listagg (replace_templates_for_column( replace(rf.field_dbname_copr2, ':', 'p_ext_doc.') , rd.field_operator,  replace(rd.rule_text,':', 'p_ext_doc.')), chr(10)||'       and ' ) within group ( order by rf.field_id) rule_text
                 from sdo_autopay_rules r, sdo_autopay_rules_desc rd, sdo_autopay_rules_fields rf
                where r.rule_id = rd.rule_id
                  and r.is_active = 1
                  and rd.field_id = rf.field_id
                  and rf.field_dbname_copr2 is not null
                  and rd.field_operator is not null
                  and rd.rule_text is not null
                group by r.rule_id
          );

      bars_audit.info(l_trace||'Условие для отбора платежей: '||l_rule_text);

      l_func_text := 'create or replace function '||l_corp2_function||'(p_ext_doc doc_import%rowtype) return smallint is '||nl||
                     '    l_trace varchar2(500) := ''sdo_autopay_check_corp2:'';'||nl||
                     '    l_mfo_lst varchar2(4000) ;'||nl||
                     '    l_res   number;'           ||nl||
                     '    nl  char(2) := chr(13)||chr(10);' ||nl||
                     'begin'||nl||
                     '   bars_audit.info(l_trace||''nlsa=''||p_ext_doc.nls_a||'', mfoa=''||p_ext_doc.mfo_a||'', nlsb=''||p_ext_doc.nls_b||'', mfob=''||p_ext_doc.mfo_b||'', s=''||p_ext_doc.s);'||nl||
                     '   if ('||l_rule_text||nl||
                           ') then l_res := 1;'||nl||
                     '   else l_res := 0;'||nl||
                     '   end if;'||nl||
                     '   bars_audit.info(l_trace||''l_res=''||l_res);'||nl||
                     '   return l_res;'||nl||
                     'end;';
      begin
         execute immediate  l_func_text;
      exception when others then
         select listagg(  'line: '||line||', pos: '||position||', text:'||text, chr(13)||chr(10)) within group (order by line)
           into l_compile_err
           from user_errors
          where name = upper(l_corp2_function);
         bars_audit.error('compile_sdo_autopay_check: cannot compile sdo_autopay_check_corp2 - '||l_compile_err);
         bars.bars_error.raise_nerror(G_ERRMOD, 'ERROR_COMPILE', l_corp2_function, l_compile_err);
      end;
      

      -----------------------------------
      -- компиляция функи для корплайт
      -----------------------------------

      select listagg  (  rule_text,      nl||' or '||nl)
             within group (order by rule_id)
        into l_rule2_text
        from ( select r.rule_id, listagg (replace_templates_for_column( replace(rf.field_dbname_cl, ':', 'p_') ,rd.field_operator,replace(rd.rule_text,':', 'p_')), chr(10)||'       and ' ) within group ( order by rf.field_id) rule_text
                 from sdo_autopay_rules r, sdo_autopay_rules_desc rd, sdo_autopay_rules_fields rf
                where r.rule_id = rd.rule_id
                  and r.is_active = 1
                  and rd.field_id = rf.field_id
                  and rf.field_dbname_copr2 is not null
                  and rd.field_operator is not null
                  and rd.rule_text is not null
                group by r.rule_id
          );

      bars_audit.info(l_trace||'Условие для отбора платежей: '||l_rule2_text);

      l_func2_text := 'create or replace function '||l_cl_function||'(p_nls_a oper.nlsa%type,
                                                                      p_mfo_a oper.mfoa%type,
                                                                      p_nls_b oper.nlsa%type,
                                                                      p_mfo_b oper.mfoa%type,
                                                                      p_s     oper.s%type,
                                                                      p_nazn  oper.nazn%type,
                                                                      p_id_a  oper.id_a%type,
                                                                      p_id_b  oper.id_b%type
                                                                     ) return smallint is '||nl||
                     '    l_trace varchar2(500) := ''sdo_autopay_check_cl:'';'||nl||
                     '    l_mfo_lst varchar2(4000) ;'||nl||
                     '    l_res   number;'           ||nl||
                     '    nl  char(2) := chr(13)||chr(10);' ||nl||
                     'begin'||nl||
                     '   bars_audit.info(l_trace||''nlsa=''||p_nls_a||'', mfoa=''||p_mfo_a||'', nlsb=''||p_nls_b||'', mfob=''||p_mfo_b||'', s=''||p_s);'||nl||
                     '   if ('||l_rule2_text||nl||
                           ') then l_res := 1;'||nl||
                     '   else l_res := 0;'||nl||
                     '   end if;'||nl||
                     '   bars_audit.info(l_trace||''l_res=''||l_res);'||nl||
                     '   return l_res;'||nl||
                     'end;';
         dbms_output.put_line(l_func2_text);
      begin
         execute immediate  l_func2_text;


      exception when others then

        dbms_output.put_line(sqlerrm);
/*         select listagg(  'line: '||line||', pos: '||position||', text:'||text, chr(13)||chr(10)) within group (order by line)
           into l_compile_err
           from user_errors
          where name = upper(l_cl_function);
         bars_audit.error('compile_sdo_autopay_check: cannot compile sdo_autopay_check_cl - '||l_compile_err);
         bars.bars_error.raise_nerror(G_ERRMOD, 'ERROR_COMPILE', l_cl_function, l_compile_err);*/
      end;
   end;


begin
   init_pack;
end;
/

show err;
 
grant EXECUTE                                                                on sdo_autopay     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on sdo_autopay     to barsaq;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_xmlklb.sql =========*** End ***
 PROMPT ===================================================================================== 
 