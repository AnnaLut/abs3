
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/rates.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.RATES 
is
  version_header  constant   varchar2(64) := 'version 1.01 01.08.2016 12:51';
--типы
  TYPE            tbl_record IS record(rel VARCHAR2(4000));
  TYPE            tbl_file   IS TABLE OF tbl_record;

  procedure kurs_val       (p_id  in  int,
                            p_ret out varchar2);

  function get_table       (p_source varchar2) return tbl_file pipelined;

  function header_version   return varchar2;

  function body_version     return varchar2;

   procedure parse_body(p_filename cur_rates_backup.filename%type, p_file_body clob);

   function get_filetype(p_filename cur_rates_backup.filename%type) return varchar2;

  procedure load_file(p_filename cur_rates_backup.filename%type, p_file_body CLOB, p_return out varchar2);

end rates;
/
CREATE OR REPLACE PACKAGE BODY BARS.RATES 
as
  version_body  constant  varchar2(64) := 'version 1.02 06.03.2017 13:03';

  function get_table (p_source varchar2) return tbl_file pipelined
  is
  --drop   TYPE   tbl_record;
  --drop   TYPE   tbl_file;
  --create TYPE   tbl_record AS OBJECT(rel VARCHAR2(4000));
  --create TYPE   tbl_file   IS TABLE OF tbl_record;
    l_tbl_record  tbl_record;
    l_source      varchar2(4000);
    i             int;
  begin
    l_source := p_source;
    loop
      i := instr(l_source,chr(13)||chr(10));
      if i>0 then
        l_tbl_record.rel := substr(l_source,1,i-1);
        PIPE ROW(l_tbl_record);
        l_source := substr(l_source,i+2);
      else
        if length(l_source)>0 then
          l_tbl_record.rel := l_source;
          PIPE ROW(l_tbl_record);
        end if;
        exit;
      end if;
    end loop;
    return;
  end get_table;

--

  procedure kurs_val (p_id  in  int,
                      p_ret out varchar2)
  is
    l_source   varchar2(4000);
    l_first    varchar2(4000);
    l_bran     varchar2(4000);
    l_datk     date;
    TYPE       bran      IS record (branch varchar2(30));
    TYPE       wher      IS record (wherec varchar2(4000));
    TYPE       tbl_bran  IS TABLE OF bran;
    TYPE       tbl_where IS TABLE OF wher;
    l_branchs  tbl_bran  := tbl_bran();
    l_where    tbl_where := tbl_where();
    type       cur is ref cursor;
    cur_       cur;
    sql_       varchar2(4000);
    l_branch   varchar2(30);
    l_mumu     varchar2(4000);
    l_kuku     varchar2(4000);
    l_elem     varchar2(4000);
    l_mfo      varchar2(6);
    i          int;
    l_n        int;
    l_KV       number;
    l_bsum     number;
    l_rate_o   number;
    l_rate_b   number;
    l_rate_s   number;
  begin
    bars_audit.info('rates.kurs_val: begin');
    select to_char(txt_data)
    into   l_source
    from   tmp_sgi
    where  id=p_id;
--  bars_audit.info('rates.kurs_val: '||substr(l_source,1,80));
--  заглавная строка
    begin
      select rt.rel
      into   l_first
      from   table(rates.get_table(l_source)) rt
      where  substr(rt.rel,3,1)='.' and substr(rt.rel,6,1)='.';
    exception when no_data_found then
      p_ret := 'Порушена структура файлу (відсутній заголовний рядок)';
      return;
              when too_many_rows then
      p_ret := 'Порушена структура файлу (більше одного заголовного рядку)';
      return;
              when others then
      p_ret := sqlerrm;
      return;
    end;
--  bars_audit.info('rates.kurs_val: l_first = '||substr(l_first,1,80));
    begin
      l_datk := to_date(substr(l_first,1,16),'DD.MM.YYYY HH24:MI');
    exception when others then
      p_ret := 'Помилка дати в заголовному рядку';
      return;
    end;
    l_bran := substr(l_first,18);
    loop
      i := instr(l_bran,' ');
      if i>0 then
        l_elem := substr(l_bran,1,i-1);
        l_bran := substr(l_bran,i+1);
        if instr(l_elem,'/')=0 and length(l_elem)=6 then -- мфо
          l_mfo := l_elem;
          l_where.extend;
          l_where(l_where.last).wherec := 'branch like ''/' || l_mfo || '/%''';
        else
          if substr(l_elem,1,1)='-' then
            l_where(l_where.last).wherec := l_where(l_where.last).wherec ||
                                            ' and name not like ''%' ||
                                            substr(l_elem,2) || ' %''';
          else
            if substr(l_where(l_where.last).wherec,-3)='/%''' then
              l_where(l_where.last).wherec := l_where(l_where.last).wherec ||
                                              ' and name like ''%' || l_elem || ' %''';
            else
              l_where.extend;
              l_where(l_where.last).wherec := 'branch like ''/' || l_mfo ||
                                              '/%'' and name like ''%' || l_elem ||
                                              ' %''';
            end if;
          end if;
        end if;
      else
        if length(l_bran)>0 then
          l_elem := l_bran;
          if instr(l_elem,'/')=0 and length(l_elem)=6 then -- мфо
            l_mfo := l_elem;
            l_where.extend;
            l_where(l_where.last).wherec := 'branch like ''/' || l_mfo || '/%''';
          else
            if substr(l_elem,1,1)='-' then
              l_where(l_where.last).wherec := l_where(l_where.last).wherec ||
                                              ' and name not like ''%' ||
                                              substr(l_elem,2) || ' %''';
            else
              if substr(l_where(l_where.last).wherec,-3)='/%''' then
                l_where(l_where.last).wherec := l_where(l_where.last).wherec ||
                                                ' and name like ''%' || l_elem || ' %''';
              else
                l_where.extend;
                l_where(l_where.last).wherec := 'branch like ''/' || l_mfo ||
                                                '/%'' and name like ''%' || l_elem ||
                                                ' %''';
              end if;
            end if;
          end if;
        end if;
        exit;
      end if;
    end loop;

    sql_ := 'select branch
             from   branch
             where  length(branch)>=8 and
                    branch like '''||sys_context('bars_context','user_branch')||'%''';

    for i in 1..l_where.count
    loop
      if i>1 then
        sql_ := sql_ || ' or ';
      else
        sql_ := sql_ || ' and (';
      end if;

      sql_ := sql_ || '(' || l_where(i).wherec || ')';
      if i=l_where.count then
        sql_ := sql_ || ')';
      end if;
    end loop;

    bars_audit.info('rates.kurs_val: sql_ = '||substr(sql_,1,3000));

    open cur_ for sql_;
    loop
      fetch cur_ into l_branch;
      exit when cur_%notfound;

      for k in (select rt.rel
                from   table(rates.get_table(l_source)) rt
                where  instr(rt.rel,'|')>0)
      loop
        l_kuku := k.rel;
--      bars_audit.info('rates.kurs_val: l_kuku = '||substr(l_kuku,1,3000));
        l_mumu := '';
        l_n    := 1;
        loop
          i := instr(l_kuku,'|');
          if i>0 then
            l_mumu := substr(l_kuku,1,i-1);
            l_kuku := substr(l_kuku,i+1);
          else
            if length(l_kuku)>0 then
              l_mumu := l_kuku;
              l_kuku := '';
            end if;
          end if;
          if    l_n=2 then
            l_KV     := to_number(replace(l_mumu,',','.'));
          elsif l_n=3 then
            l_bsum   := to_number(replace(l_mumu,',','.'));
          elsif l_n=5 then
            l_rate_b := to_number(replace(l_mumu,',','.'));
          elsif l_n=6 then
            l_rate_s := to_number(replace(l_mumu,',','.'));
          end if;
          if length(l_kuku) is null then
            exit;
          end if;
          l_n := l_n+1;
        end loop;
--
        if l_datk>=trunc(sysdate) then -- принимаем только для дат >= текущей
          begin
            update cur_rates$base
            set    bsum=l_bsum    ,
                   rate_b=l_rate_b,
                   rate_s=l_rate_s
            where  kv=l_KV      and
                   vdate=l_datk and
                   branch=l_branch;
            if sql%rowcount=0 then
              begin
                select rate_o
                into   l_rate_o
                from   cur_rates$base
                where  branch=l_branch and
                       kv=l_KV         and
                       vdate=(select max(vdate)
                              from   cur_rates$base
                              where  branch=l_branch and
                                     kv=l_KV and
                                     vdate <= l_datk);
              exception when no_data_found then
                p_ret := 'Відсутній офіційний курс '||to_char(l_KV)||' для '||l_branch;
                return;
              end;
--            if l_rate_o_ is null then
--              p_ret := 'Відсутній офіційний курс '||to_char(l_KV)||' для '||l_branch||
--                       ' за '||to_char(trunc(l_datk),'DD.MM.YYYY');
--              return;
--            end if;
              begin
                insert
                into   cur_rates$base (kv    ,
                                       vdate ,
                                       bsum  ,
                                       rate_o,
                                       rate_b,
                                       rate_s,
                                       branch)
                               values (l_KV    ,
                                       l_datk  ,
                                       l_bsum  ,
                                       l_rate_o,
                                       l_rate_b,
                                       l_rate_s,
                                       l_branch);
              exception when others then
                p_ret := sqlerrm;
                return;
              end;
            end if;
          exception when others then
            bars_audit.info('rates.kurs_val:'||
                            '  l_KV = '      ||l_KV                                   ||
                            ', l_datk = '    ||to_char(l_datk,'DD.MM.YYYY HH24:MI:SS')||
                            ', l_bsum = '    ||l_bsum                                 ||
                            ', l_rate_o = '  ||l_rate_o                               ||
                            ', l_rate_b = '  ||l_rate_b                               ||
                            ', l_rate_s = '  ||l_rate_s                               ||
                            ', l_branch = '  ||l_branch);
            p_ret := sqlerrm;
            return;
          end;
        else
          p_ret := 'Курси за '||to_char(trunc(l_datk),'DD.MM.YYYY')||
                   ' не прийняті, оскільки дата встановлення МЕНШЕ поточної дати.';
          return;
        end if;
      end loop;
    end loop;
    close cur_;
    p_ret := 'Ok';
    bars_audit.info('rates.kurs_val: end');

  end kurs_val;

  function get_filetype(p_filename cur_rates_backup.filename%type) return varchar2
  is
  l_type cur_rates_backup.file_type%type;
  begin
    l_type:=case
                when upper(substr(p_filename,1,3))= '#99' then 'NBU'
                when upper(substr(p_filename, length(p_filename)-2))='VAL' then 'COMMERC'
                when upper(substr(p_filename, length(p_filename)-2))='BMT' then 'METAL'
                else 'UNDEFINED'
            end;
     if l_type='UNDEFINED' then
     raise_application_error(-20000, 'Не вдалося визначити тип файлу!');
     end if;
    return l_type;
  end get_filetype;

  procedure parse_body(p_filename cur_rates_backup.filename%type, p_file_body clob)
is
  cl clob;
  l_amount pls_integer:= 1;
  l_length pls_integer;
  token varchar2(4000);
  sobch varchar2(4000);
  l_date date;
  l_kv number;
  l_bsum number;
  l_rate_o number;
  l_name_metal varchar2(4000);
  l_kod_metal varchar2(4000);
  l_ves_metal varchar2(4000);
  l_empty_metal varchar2(4000);
  l_buy_metal varchar2(4000);
  l_sale_metal varchar2(4000);
  l_ret_metal int;
  l_ret varchar2(4000);
begin

  if get_filetype(p_filename)= 'NBU' then
    l_date:= to_date(substr(p_file_body,instr(p_file_body,'=',1,1)+1,8),'dd.mm.yyyy');
    cl:= substr(p_file_body,instr(p_file_body,chr(10),1,2)+1);
  elsif  get_filetype(p_filename) = 'METAL' then
    l_date:= to_date(substr(p_file_body,1,16), 'dd.mm.yyyy HH24:MI:SS');
    cl:= substr(p_file_body,instr(p_file_body,chr(10),1,1)+1);
    cl:=substr(cl, 1, length(cl)-10);
  elsif  get_filetype(p_filename) ='COMMERC' then
    l_date:= to_date(substr(p_file_body,1,10), 'dd.mm.yyyy');
    cl:= substr(p_file_body,instr(p_file_body,chr(10),1,1)+1);
    cl:=substr(cl, 1, length(cl)-10);
  end if;


 l_length := dbms_lob.getlength(cl);

  for i in 1..l_length loop
    dbms_lob.read
    ( lob_loc => cl
    , amount => l_amount
    , offset => i
    , buffer => token
    );
    if token = chr(10) then
     if get_filetype(p_filename)= 'NBU' then
           l_kv:=to_number(substr(sobch,instr(sobch, '=',1,2)+1,3));
           l_bsum:=to_number(substr(sobch,instr(sobch, '=',1,4)+1,instr(sobch,'=',1,5)-instr(sobch, '=',1,4)-1));
           l_rate_o:=to_number(substr(sobch,instr(sobch, '=',1,5)+1));
           p_rates(to_char(l_date,'dd/mm/yyyy'), l_kv, l_bsum, l_rate_o);
     elsif get_filetype(p_filename)= 'METAL' then
          l_name_metal:= substr(sobch,1,instr(sobch,'|',1,1)-1);
          l_kod_metal:=substr(sobch,instr(sobch, '|',1,1)+1,instr(sobch,'|',1,2)-instr(sobch, '|',1,1)-1);
          l_ves_metal:=substr(sobch,instr(sobch, '|',1,2)+1,instr(sobch,'|',1,3)-instr(sobch, '|',1,2)-1);
          l_empty_metal:=substr(sobch,instr(sobch, '|',1,3)+1,instr(sobch,'|',1,4)-instr(sobch, '|',1,3)-1);
          l_buy_metal:=substr(sobch,instr(sobch, '|',1,4)+1,instr(sobch,'|',1,5)-instr(sobch, '|',1,4)-1);
          l_sale_metal:=substr(sobch,instr(sobch, '|',1,5)+1);
          CENTR_KUBM(l_date, l_kod_metal,l_ves_metal,l_name_metal, l_buy_metal, l_sale_metal, l_ret);
     elsif get_filetype(p_filename)= 'COMMERC' then
        delete from tmp_sgi;
        insert into tmp_sgi(id, txt_data)
        values(1, p_file_body);
        rates.kurs_val(1,l_ret);
       begin
            if l_ret!='Ok' then
             raise_application_error(-20000,l_ret);
            end if;
       end;
     else
        raise_application_error(-20000, 'Не вдалося визначити тип файлу!');
     end if;

         sobch:= null;
    elsif token=chr(13) then
        null;
    elsif i = l_length then
      sobch:= sobch||token;

    else
      sobch:= sobch||token;
    end if;



  end loop;
end;


   procedure load_file(p_filename cur_rates_backup.filename%type, p_file_body CLOB, p_return out varchar2)
    is
     l_msg varchar2(4000);
    begin
        bars_audit.log_info('rates.load_file',
                            'p_file_name : ' || p_filename,
                            p_auxiliary_info => p_file_body,
                            p_make_context_snapshot => true);
        insert into cur_rates_backup(FILENAME, DATE_LOAD, FILE_TYPE, FILE_BODY, USERID_LOAD)
        values (p_filename, sysdate, get_filetype(p_filename), p_file_body, user_id());
       parse_body(p_filename, p_file_body);
        bars_audit.log_info('rates.load_file',
                            'p_file_name : ' || p_filename || chr(10) ||
                            'result      : ' || 'success');
     exception when others then
        bars_audit.log_info('rates.load_file (exception)',
                            'p_file_name   : ' || p_filename || chr(10) ||
                            'error message : ' || sqlerrm || dbms_utility.format_error_backtrace());
        l_msg:=substr(sqlerrm, 1, 4000);
        p_return:=l_msg;
    end load_file;

--

  function header_version return varchar2 is
  begin
    return 'Package header rates ' || version_header;
  end header_version;

--

  function body_version return varchar2 is
  begin
    return 'Package body rates ' || version_body;
  end body_version;

--

begin
--инициализация пакета
  null;
end rates;
/
 show err;
 
PROMPT *** Create  grants  RATES ***
grant EXECUTE                                                                on RATES           to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/rates.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 