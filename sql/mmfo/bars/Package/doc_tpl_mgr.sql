
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/doc_tpl_mgr.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.DOC_TPL_MGR is

  --
  -- Автор  : OLEG
  -- Создан : 21.03.2011
  --
  -- Purpose : Управління шаблонами документів
  --

  -- Public constant declarations
  g_header_version  constant varchar2(64)  := 'version 1.0 21/03/2011';
  g_awk_header_defs constant varchar2(512) := '';

  --------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  --------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

   --------------------------------------------------------------------------------
   -- upload_template - добавляет новый или обновляет существующий шаблон
   --
   -- @p_id - ідентифікатор шаблона
   -- @p_name - назва шаблона
   -- @p_pob - флаг друку на бланку (0/1)
   -- @p_template - шаблон
   --
   procedure upload_template(
     p_id in doc_scheme.id%type,
     p_name in doc_scheme.name%type,
     p_pob in doc_scheme.print_on_blank%type,
     p_template in clob);

   -- uplins_tbl - добавляет новый или обновляет существующий 
   --
   -- @p_id - ідентифікатор шаблона
   -- @p_name - назва шаблона
   -- @p_pob - флаг друку на бланку (0/1)
   -- @p_file_name - Имя файла шаблона из папки TEMPLATE.RPT
   --
   procedure uplins_tbl(
     p_id   in doc_scheme.id%type,
     p_name in doc_scheme.name%type,
     p_pob  in doc_scheme.print_on_blank%type,
     p_file_name in doc_scheme.file_name%type);
  --------------------------------------------------------------------------------
  -- disable_template - изымает шаблон с работы
  --
  -- @p_id - ідентифікатор шаблона
  --
  procedure disable_template(p_id in doc_scheme.id%type);

  --------------------------------------------------------------------------------
  -- change_tpl_name - процедура для смены имени шаблона
  --
  -- @p_id - ідентифікатор шаблона
  -- @p_name - нова назва шаблону
  --
  procedure change_tpl_name(
    p_id in doc_scheme.id%type,
    p_name in doc_scheme.name%type);

  --------------------------------------------------------------------------------
  -- delete_template - удаляет шаблон
  --
  -- @p_id - ідентифікатор шаблона
  --
  procedure delete_template(p_id in doc_scheme.id%type);


  Procedure get_template ( p_id       in doc_scheme.id%type,
                           p_template out doc_scheme.template%type);

end doc_tpl_mgr;
/
CREATE OR REPLACE PACKAGE BODY BARS.DOC_TPL_MGR is

  --
  -- Автор  : OLEG
  -- Создан : 21.03.2011
  --
  -- Purpose : Управління шаблонами документів
  --

  -- Private constant declarations
  g_body_version  constant varchar2(64)  := 'version 1.0 21/03/2011';
  g_awk_body_defs constant varchar2(512) := '';
  g_dbgcode constant varchar2(12) := 'doc_tpl_mgr.';
  g_modcode constant varchar2(3) := 'TPL';

  --------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header doc_tpl_mgr '||g_header_version||'.'||chr(10)
  	   ||'AWK definition: '||chr(10)
  	   ||g_awk_header_defs;
  end header_version;

  --------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body doc_tpl_mgr '||g_body_version||'.'||chr(10)
	     ||'AWK definition: '||chr(10)
	     ||g_awk_body_defs;
  end body_version;

   --------------------------------------------------------------------------------
   -- upload_template - добавляет новый или обновляет существующий шаблон
   --
   -- @p_id - ідентифікатор шаблона
   -- @p_name - назва шаблона
   -- @p_pob - флаг друку на бланку (0/1)
   -- @p_template - шаблон
   --
   procedure upload_template(
     p_id in doc_scheme.id%type,
     p_name in doc_scheme.name%type,
     p_pob in doc_scheme.print_on_blank%type,
     p_template in clob)
   is
     l_th constant varchar2(100) := g_dbgcode || 'upload_template';
   begin
     bars_audit.trace('%s: entry point', l_th);
     bars_audit.trace('%s: p_id=> %s, p_name=>%s, p_pob=>%s', l_th,
       p_id, p_name, to_char(p_pob));
     update doc_scheme set
       name = nvl(p_name,name),
       print_on_blank = nvl(p_pob,print_on_blank),
       template = p_template
     where id = p_id;
     if sql%rowcount = 0 then
       insert into doc_scheme (id, name, print_on_blank, template, fr)
         values (p_id, nvl(p_name,'noname'), nvl(p_pob,0), p_template, 1);
     end if;
     bars_audit.trace('%s: done', l_th);
   end upload_template;

   -- uplins_tbl - добавляет новый или обновляет существующий 
   --
   -- @p_id - ідентифікатор шаблона
   -- @p_name - назва шаблона
   -- @p_pob - флаг друку на бланку (0/1)
   -- @p_file_name - Имя файла шаблона из папки TEMPLATE.RPT
   --
   procedure uplins_tbl(
     p_id   in doc_scheme.id%type,
     p_name in doc_scheme.name%type,
     p_pob  in doc_scheme.print_on_blank%type,
     p_file_name in doc_scheme.file_name%type)
   is
     l_th constant varchar2(100) := g_dbgcode || 'uplins_tbl';
	 l_fr pls_integer;
   begin
     bars_audit.trace('%s: entry point', l_th);
     bars_audit.trace('%s: p_id=> %s, p_name=>%s, p_pob=>%s', l_th, p_id, p_name, to_char(p_pob));
	 
	  if length(p_file_name) = 0
              then 	 l_fr := 0;
              else 	 l_fr := 1;		  
	  END IF;
	  
     update doc_scheme set
       name = p_name,
       print_on_blank = p_pob,
       file_name = p_file_name,
	   FR = l_fr
     where id = p_id;
     if sql%rowcount = 0 then
       insert into doc_scheme (id, name, print_on_blank, file_name, fr)
         values (p_id, p_name, p_pob, p_file_name, l_fr);
     end if;
     bars_audit.trace('%s: done', l_th);
   end uplins_tbl;  
  
  --------------------------------------------------------------------------------
  -- disable_template - изымает шаблон с работы
  --
  -- @p_id - ідентифікатор шаблона
  --
  procedure disable_template(p_id in doc_scheme.id%type) is
    l_th constant varchar2(100) := g_dbgcode || 'disable_template';
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_id=>%s', l_th, p_id);
    update doc_scheme set d_close = sysdate where id = p_id;
    if sql%rowcount = 0 then
      bars_error.raise_nerror(g_modcode, 'TPL_NOTFOUND', p_id);
    end if;
    bars_audit.trace('%s: done', l_th);
  end disable_template;

  --------------------------------------------------------------------------------
  -- change_tpl_name - процедура для смены имени шаблона
  --
  -- @p_id - ідентифікатор шаблона
  -- @p_name - нова назва шаблону
  --
  procedure change_tpl_name(
    p_id in doc_scheme.id%type,
    p_name in doc_scheme.name%type)
  is
    l_th constant varchar2(100) := g_dbgcode || 'change_tpl_name';
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_id=>%s, p_name=>%s', l_th, p_id, p_name);
    update doc_scheme set name = p_name where id = p_id;
    if sql%rowcount = 0 then
      bars_error.raise_nerror(g_modcode, 'TPL_NOTFOUND', p_id);
    end if;
    bars_audit.trace('%s: done', l_th);
  end change_tpl_name;

  --------------------------------------------------------------------------------
  -- delete_template - удаляет шаблон
  --
  -- @p_id - ідентифікатор шаблона
  --
  procedure delete_template(p_id in doc_scheme.id%type) is
    l_th constant varchar2(100) := g_dbgcode || 'delete_template';
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_id=>%s', l_th, p_id);
    delete from doc_scheme where id = p_id;
    if sql%rowcount = 0 then
      bars_error.raise_nerror(g_modcode, 'TPL_NOTFOUND', p_id);
    end if;
    bars_audit.trace('%s: done', l_th);
  end delete_template;

  
Procedure get_template ( p_id       in doc_scheme.id%type,
                         p_template out doc_scheme.template%type)
is
	l_th constant varchar2(100) := g_dbgcode || 'get_template';
begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.trace('%s: p_id=>%s', l_th, p_id);
   
   Select template
     into p_template
     from doc_scheme
    where id = p_id;
  	
exception when no_data_found then
     bars_error.raise_nerror(g_modcode, 'TPL_NOTFOUND', p_id);
end get_template;  
  
begin
  -- Initialization
  null;
end doc_tpl_mgr;
/
 show err;
 
PROMPT *** Create  grants  DOC_TPL_MGR ***
grant EXECUTE                                                                on DOC_TPL_MGR     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/doc_tpl_mgr.sql =========*** End ***
 PROMPT ===================================================================================== 
 