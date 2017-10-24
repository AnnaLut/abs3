

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_EXPORT_TO_DBF_WEB.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_EXPORT_TO_DBF_WEB ***

  CREATE OR REPLACE PROCEDURE BARS.P_EXPORT_TO_DBF_WEB (p_kodz number, p_stmt varchar2 default null, p_encoding varchar2 default 'WIN')
is
  l_txt          zapros.txt%type;
  l_create_stmt  zapros.create_stmt%type;
  l_clob         clob;
  l_clob2        clob;
  l_lob_size     number;
  l_offset       number := 1;
  l_resp         clob;
  l_warning      integer;
  l_dest_offset  integer := 1;
  l_src_offset   integer := 1;
  l_blob_csid    number := dbms_lob.default_csid;
  l_lang_context number := dbms_lob.default_lang_ctx;
  l_blob         blob;
  l_length number;
  l_name varchar2(32767);
  l_val varchar2(32767);
  l_tmp varchar2(32767);
  l_str varchar2(32767);
procedure parse_str(p_str varchar2, p_name out varchar2, p_val out varchar2)
        is
        begin
          p_name := substr(p_str,0,instr(p_str,'=')-1);
          p_val := substr(p_str,instr(p_str,'=')+1);
        end;
begin
  select z.txt, z.create_stmt
    into l_txt, l_create_stmt
    from zapros z
   where z.kodz = p_kodz;

--для выгрузки в txt. 15/03/2017.Антон Стеценко
if l_create_stmt='COLUMNSELECT'  and  instr(p_stmt,':KODK=%')>0   then

for c in (select kod_cli  from KOD_CLI  )
loop
p_export_to_dbf_web_txt (p_kodz, replace(p_stmt,':KODK=%',':KODK='||c.kod_cli));
end loop;

elsif l_create_stmt='COLUMNSELECT'
then
p_export_to_dbf_web_txt (p_kodz,p_stmt);
else

if p_stmt is not null
then
 l_length := length(p_stmt) - length(replace(p_stmt,';'));
                  l_str :=p_stmt;
                  for i in 0..l_length - 1 loop
                    l_tmp := substr(l_str, 0, instr(l_str,';')-1);
                    l_str := substr(l_str, instr(l_str,';')+1);
                    parse_str(l_tmp,l_name,l_val);
                    l_txt:=replace(l_txt, l_name, ''''||l_val||'''');
                  end loop;

 end if;

logger.info('DBF:'||l_txt);

  bars_dbf.dbf_from_sqldesc(p_sqldesc  => l_txt,
                            p_coldescr => l_create_stmt,
                            p_encode   => p_encoding);

  loop
    bars_dbf.get_buffer(p_buff    => l_clob,
                        p_bufflen => l_lob_size,
                        p_offset  => l_offset,
                        p_amount  => 4000);
    l_offset := l_offset + 4000;
    l_clob2  := l_clob2 || l_clob;
    if l_lob_size = 0 then
      exit;
    end if;
  end loop;

  dbms_lob.createtemporary(l_blob, false);

  dbms_lob.converttoblob(dest_lob     => l_blob,
                         src_clob     => l_clob2,
                         amount       => dbms_lob.lobmaxsize,
                         dest_offset  => l_dest_offset,
                         src_offset   => l_src_offset,
                         blob_csid    => l_blob_csid,
                         lang_context => l_lang_context,
                         warning      => l_warning);

  insert into tmp_export_to_dbf(id,
                                kodz,
                                userid,
                                creating_date,
                                data)
                                values(s_tmp_export_to_dbf.nextval,p_kodz, user_id, sysdate, l_blob);
end if;
end;
/
show err;

PROMPT *** Create  grants  P_EXPORT_TO_DBF_WEB ***
grant EXECUTE                                                                on P_EXPORT_TO_DBF_WEB to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_EXPORT_TO_DBF_WEB.sql =========*
PROMPT ===================================================================================== 
