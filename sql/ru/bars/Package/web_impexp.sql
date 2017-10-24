
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/web_impexp.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.WEB_IMPEXP is
/**
  ѕакет web_impexp содержит процедуры дл€ импорта/экспорта файлов платежей по Ёнергорынку
        (—бербанк)
*/

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.0 19/12/2006';

G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := '';

/**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2;

/**
 * store_file_header - сохран€ет заголовок файла
 */
procedure store_file_header(p_fn in varchar2);

/**
 * get_file_md - возвращает текущий мес€ц, день в формате MD
 */
function get_file_md return varchar2;

/**
 * make_export_file_name - создает им€ файла экспорта документов
 */
function make_export_file_name return varchar2;

/**
 * export_documents
 */
procedure export_documents(p_date_start in date, p_date_finish in date);

end web_impexp;
/
CREATE OR REPLACE PACKAGE BODY BARS.WEB_IMPEXP is
/**
  ѕакет web_impexp содержит процедуры дл€ импорта/экспорта файлов платежей по Ёнергорынку
        (—бербанк)
*/

G_BODY_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.0 19/12/2006';

G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := '';

/**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2 is
begin
  return 'Package header web_IMPEXP '||G_HEADER_VERSION||'.'||chr(10)
     ||'AWK definition: '||chr(10)
     ||G_AWK_HEADER_DEFS;
end header_version;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2 is
begin
  return 'Package body web_IMPEXP '||G_BODY_VERSION||'.'||chr(10)
     ||'AWK definition: '||chr(10)
     ||G_AWK_BODY_DEFS;
end body_version;

/**
 * store_file_header - сохран€ет заголовок файла
 */
procedure store_file_header(p_fn in varchar2) is
  erm     varchar2 (200);
  ern     constant positive := 001;
  err     exception;
  l_yr      integer;
begin
  l_yr := extract(year from gl.bd);
  begin
    insert into web_import_files(yr,fn,bdt,sdt)
    values(l_yr,p_fn,gl.bd,sysdate);
  exception when dup_val_on_index then
    erm := '0001 - ‘айл '||p_fn||' уже принималс€';
    raise err;
  end;
exception
    when err then
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
end store_file_header;

/**
 * get_file_md - возвращает текущий мес€ц, день в формате MD
 */
function get_file_md return varchar2 is
begin
  return sep.MD32;
end get_file_md;

/**
 * make_export_file_name - создает им€ файла экспорта документов
 */
function make_export_file_name return varchar2 is
begin
  return '$A'||'C102'||sep.MD32||'.000';
end make_export_file_name;

/**
 * export_documents
 */
procedure export_documents(p_date_start in date, p_date_finish in date) is
    dt          opldok%rowtype;
    kt          opldok%rowtype;
    doc         oper%rowtype;
    min_stmt    number;
    l_parent    integer;  -- признак родительской проводки (1-parent,0-child)
    l_kv_a      accounts.kv%type;
    l_nls_a     accounts.nls%type;
    l_nms_a     accounts.nms%type;
    l_nls_b     accounts.nls%type;
    l_nms_b     accounts.nms%type;
    l_okpo_a    customer.okpo%type;
    l_okpo_b    customer.okpo%type;
    l_dk        oper.dk%type;
    l_mb        integer; -- признак межбанка
    l_npp       number;
    l_id_o      oper.id_o%type;

    ex          tmp_web_export_docs%rowtype;
begin
    bars_audit.trace('web_impexp.export_documents(p_date_start=>'
    ||to_char(p_date_start,'DD.MM.YYYY')||', p_date_finish=> '
    ||to_char(p_date_finish,'DD.MM.YYYY')||')');

    l_npp := 0;
    for c in (select unique ref,stmt from opldok
            where acc in (select acc from saldo) and fdat between p_date_start and p_date_finish
            and sos=5
           )
    loop
        -- читаем половинки проводок
        select * into dt from opldok where ref=c.ref and stmt=c.stmt and dk=0;
        select * into kt from opldok where ref=c.ref and stmt=c.stmt and dk=1;
        -- читаем сам документ
        select * into doc from oper where ref=c.ref;
        -- дополнительные данные
        select kv,nls,nms into l_kv_a,l_nls_a,l_nms_a from accounts where acc=dt.acc;
        select nls,nms    into l_nls_b,l_nms_b        from accounts where acc=kt.acc;
        select nvl(okpo,'99999') into l_okpo_a        from customer c, cust_acc ca
        where c.rnk=ca.rnk and ca.acc=dt.acc;
        select nvl(okpo,'99999') into l_okpo_b        from customer c, cust_acc ca
        where c.rnk=ca.rnk and ca.acc=kt.acc;
        l_dk := case when doc.dk is not null then doc.dk else 1 end;
        if doc.mfoa is not null and doc.mfob is not null and doc.mfoa<>doc.mfob then
            l_mb := 1;
        else
            l_mb := 0;
        end if;
        -- получим врем€ последней визы
        begin
            select to_char(max(dat),'HH24MISS') into l_id_o from oper_visa where ref=c.ref;
        exception when no_data_found then
            l_id_o := '000000';
        end;
        if l_id_o is null then
            l_id_o := to_char(doc.pdat,'HH24MISS');
        end if;
        -- поехали
        ex := null;
        -- вы€сним: проводка родительска€ или дочерн€€
        select min(stmt) into min_stmt from opldok where ref=c.ref and tt=doc.tt;
        if c.stmt=min_stmt then
            l_parent            := 1;  -- родительска€ операци€
            ex.ref              := c.ref;
            ex.stmt             := c.stmt;
            ex.mfoa             := doc.mfoa;
            ex.nlsa             := doc.nlsa;
            ex.mfob             := doc.mfob;
            ex.nlsb             := doc.nlsb;
            ex.dk               := l_dk;
            ex.s                := dt.s;
            ex.vob              := case
                                   when doc.vob is not null and doc.vob between 1 and 99 then doc.vob
                                   else 6
                                   end;
            ex.nd               := case when doc.nd is not null then doc.nd else substr(c.ref,1,10) end;
            ex.kv               := l_kv_a;
            ex.datd             := case when doc.datd is not null then doc.datd else dt.fdat end;
            ex.datp             := case when doc.datp is not null then doc.datp else dt.fdat end;
            ex.nam_a            := case
                                   when doc.nam_a is not null then doc.nam_a
                                   else l_nms_a
                                   end;
            ex.nam_b            := case
                                   when doc.nam_b is not null then doc.nam_b
                                   else l_nms_b
                                   end;
            ex.nazn             := case
                                   when doc.nazn is not null then doc.nazn
                                   else case when dt.txt is not null then dt.txt else dt.tt end
                                   end;
            ex.d_rec            := doc.d_rec;
            ex.nazns            := case when doc.d_rec is not null then '11' else '10' end;
            ex.id_a             := case
                                   when doc.id_a is not null then doc.id_a
                                   else l_okpo_a
                                   end;
            ex.id_b             := case
                                   when doc.id_b is not null then doc.id_b
                                   else l_okpo_b
                                   end;
            ex.ref_a            := c.ref;
            ex.id_o             := l_id_o;
            ex.bis              := case when doc.d_rec like '#B%' then 1 else 0 end;
        else
            l_parent            := 0;  -- дочерн€€ операци€
            ex.ref              := c.ref;
            ex.stmt             := c.stmt;
            ex.mfoa             := gl.aMFO;
            ex.nlsa             := l_nls_a;
            ex.mfob             := gl.aMFO;
            ex.nlsb             := l_nls_b;
            ex.dk               := l_dk;
            ex.s                := dt.s;
            ex.vob              := 6;
            ex.nd               := case when doc.nd is not null then doc.nd else substr(c.ref,1,10) end;
            ex.kv               := l_kv_a;
            ex.datd             := case when doc.datd is not null then doc.datd else dt.fdat end;
            ex.datp             := case when doc.datp is not null then doc.datp else dt.fdat end;
            ex.nam_a            := l_nms_a;
            ex.nam_b            := l_nms_b;
            ex.nazn             := case
                                   when dt.txt is not null then dt.txt
                                   else dt.tt
                                   end;
            ex.d_rec            := null;
            ex.nazns            := '10';
            ex.id_a             := l_okpo_a;
            ex.id_b             := l_okpo_b;
            ex.ref_a            := c.ref;
            ex.id_o             := l_id_o;
            ex.bis              := 0;
        end if;
        -- ставим номер по-пор€дку
        l_npp := l_npp + 1;
        ex.npp := l_npp;
        bars_audit.trace('web_impexp.export_documents(): вставка документа, ref='||ex.ref||', stmt='||ex.stmt||', bis='||ex.bis);
        -- перекодировка:
        ex.nd       := TranslateWin2Dos(ex.nd);
        ex.nam_a    := TranslateWin2Dos(ex.nam_a);
        ex.nam_b    := TranslateWin2Dos(ex.nam_b);
        ex.nazn     := TranslateWin2Dos(ex.nazn);
        ex.d_rec    := TranslateWin2Dos(ex.d_rec);
        -- пишем во временную таблицу
        insert into tmp_web_export_docs values ex;
        -- если это была перва€ строка Ѕ»—ов, добавл€ем остальные строки
        if ex.bis=1 then
            for b in (select * from arc_rrp where ref=ex.ref and bis>1)
            loop
                l_npp               := l_npp + 1;
                ex.npp              := l_npp;
                ex.mfoa             := b.mfoa;
                ex.nlsa             := b.nlsa;
                ex.mfob             := b.mfob;
                ex.nlsb             := b.nlsb;
                ex.dk               := b.dk;
                ex.s                := b.s;
                ex.vob              := b.vob;
                ex.nd               := b.nd;
                ex.kv               := l_kv_a;
                ex.datd             := b.datd;
                ex.datp             := b.datp;
                ex.nam_a            := b.nam_a;
                ex.nam_b            := b.nam_b;
                ex.nazn             := b.nazn;
                ex.d_rec            := b.d_rec;
                ex.nazns            := b.nazns;
                ex.id_a             := b.id_a;
                ex.id_b             := b.id_b;
                ex.ref_a            := c.ref;
                ex.id_o             := l_id_o;
                ex.bis              := b.bis;
                -- перекодировка:
                ex.nd       := TranslateWin2Dos(ex.nd);
                ex.nam_a    := TranslateWin2Dos(ex.nam_a);
                ex.nam_b    := TranslateWin2Dos(ex.nam_b);
                ex.nazn     := TranslateWin2Dos(ex.nazn);
                ex.d_rec    := TranslateWin2Dos(ex.d_rec);
                bars_audit.trace('web_impexp.export_documents(): вставка документа, ref='||ex.ref||', stmt='||ex.stmt||', bis='||ex.bis);
                insert into tmp_web_export_docs values ex;
            end loop;
        end if;
    end loop;
    bars_audit.trace('web_impexp.export_documents() finished');
end export_documents;

end;
/
 show err;
 
PROMPT *** Create  grants  WEB_IMPEXP ***
grant EXECUTE                                                                on WEB_IMPEXP      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on WEB_IMPEXP      to WR_ALL_RIGHTS;
grant EXECUTE                                                                on WEB_IMPEXP      to WR_IMPEXP;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/web_impexp.sql =========*** End *** 
 PROMPT ===================================================================================== 
 