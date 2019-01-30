
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_dpa2.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE BARS_DPA2 is

g_head_version constant varchar2(64)  := 'Version 1.0 29/01/2019';
g_head_defs    constant varchar2(512) := '';

/** header_version - возвращает версию заголовка пакета */
function header_version return varchar2;

/** body_version - возвращает версию тела пакета */
function body_version return varchar2;

-------------------------------------------------------------------------------
-- insert_to_temp
-- вставка во временную таблицу
--
procedure insert_data_to_temp(p_mfo varchar2, p_okpo varchar2, p_rp number, p_ot varchar2, p_odat date, p_nls varchar2, p_kv number, p_c_ag number , p_nmk varchar2,
                              p_adr varchar2, p_c_reg varchar2, p_c_dst varchar2, p_bic varchar2, p_country number);

-------------------------------------------------------------------------------
-- insert_to_temp
-- вставка во временную таблицу (@K)
--
procedure insert_data_to_temp(p_bic varchar2, p_nmk varchar2,p_ot varchar2, p_odat date, p_nls varchar2,p_kv number, p_c_ag number, p_country number, p_c_reg varchar2,p_okpo varchar2);

-------------------------------------------------------------------------------
-- insert_to_temp
-- вставка во временную таблицу
--
procedure insert_data_to_temp(p_ref number);

-------------------------------------------------------------------------------
-- get_cvk_file
-- Получить количество сформированных файлов ЦВК по типу файла
function get_cvk_file(p_filetype varchar2, p_file_number number, p_filename out varchar2) return clob;

-------------------------------------------------------------------------------
-- form_cvk_file
-- сформировать файлы и поместить во временное хранилище dpa_lob
-- в переменную p_file_count вернуть кол-во файлов

procedure form_cvk_file(p_filetype varchar2, p_filedate date, p_file_count out number, p_ids out number_list);

end;
/
CREATE OR REPLACE PACKAGE BODY BARS_DPA2 is

g_body_version constant varchar2(64)  := 'Version 1.1 29/01/2019';
g_body_defs    constant varchar2(512) := '';

g_modcode      constant varchar2(3)   := 'DPA';

/** header_version - возвращает версию заголовка пакета */
function header_version return varchar2 is
begin
  return 'Package header bars_dpa ' || g_head_version || chr(10) ||
         'AWK definition: ' || chr(10) || g_head_defs;
end header_version;

/** body_version - возвращает версию тела пакета */
function body_version return varchar2 is
begin
  return 'Package body bars_dpa ' || g_body_version ||  chr(10) ||
         'AWK definition: ' || chr(10) || g_body_defs;
end body_version;

-------------------------------------------------------------------------------
-- get_file_name
--
function get_file_name (
  p_filetype  in varchar2,
  p_filenum  out number ) return varchar2
is
  l_dps         params.val%type;
  l_filedate    date;
  l_filenum     number;
  l_filenumdef  number;
  l_filename    zag_f.fn%type := null;
  l_sab         varchar2(4);
  i number;
  p varchar2(100) := 'bars_dpa.get_file_name. ';
  l_kf varchar2(6) :=sys_context('bars_context','user_mfo');
begin

  bars_audit.info(p || 'Start.');

  l_dps := getglobaloption('DPA_REG');
  if l_dps is null then
     raise_application_error(-20000, 'Не вказано код органу ДПС регіонального рівня!', true);
  end if;
  begin
     select 1 into i from spr_obl where to_char(c_reg) = l_dps;
  exception when no_data_found then
     raise_application_error(-20000, 'Вказано неіснуючий код органу ДПС регіонального рівня!', true);
  end;


  begin
     select decode(p_filetype,
              'F', taxf_date,
              'P', taxp_date,
              'K', taxk_date,
              'CV', taxcv_date,
              'CA', taxca_date,
          null) file_date,
            decode(p_filetype,
               'F',    taxf_seq,
               'P',    taxp_seq,
               'K',    taxk_seq,
         'CV',   taxcv_seq,
               'CA',   taxca_seq,
          0) file_num,
            nvl(decode(p_filetype,
              'F',     taxf_seq_default,
              'P',     taxp_seq_default,
              'K',     taxk_seq_default,
          'CV',    taxcv_seq_default,
              'CA',    taxca_seq_default,
        0),0) file_numdef
       into l_filedate, l_filenum, l_filenumdef
       from dpa_file_counters where kf = l_kf;
  exception when no_data_found then
     l_filedate   := null;
     l_filenum    := null;
     l_filenumdef := null;
  end;

  if l_filenum is null or trunc(l_filedate) <> trunc(sysdate) then
     l_filenum := l_filenumdef;
  end if;

  l_filenum := l_filenum + 1;

  -- @АTDxCхххххRxxхххххMDnnn.XML, де:
  -- @ - ознака приналежност_ файла до файл_в обм_ну в_домостями щодо в_дкриття/закриття рахунк_в м_ж ДПС України та ф_нансовими установами;
  -- А - функц_ональний п_дтип файла;
  -- Т - цифра, що визначає належн_сть файла до Файл_в пов_домлень чи Файл_в-в_дпов_дей або квитанц_й: 0 - Файл пов_домлень або Файл-в_дпов_дь, 1 - квитанц_я про одержання (перша квитанц_я) Файла пов_домлень, 2 - квитанц_я про прийняття до оброблення (друга квитанц_я) Файла пов_домлень або Файла-в_дпов_д_;
  -- Dx - код органу ДПС рег_онального р_вня за м_сцем розташування ф_нансової установи (доповнюється зл_ва нулями до 2 символ_в) зг_дно з дов_дкою про взяття ф_нансової установи на обл_к у орган_ ДПС;
  -- Cххххх - код ф_нансової установи, з якої/до якої надсилається файл (доповнюється зл_ва нулями до 6 символ_в). Для банк_вських установ та установ Державної казначейської служби України зазначається код банку, для небанк_вських ф_нансових установ - код ф_нансової установи;
  -- Rxxххххх - код за ЄДРПОУ ф_нансової установи, з якої/до якої надсилається файл (доповнюється зл_ва нулями до 8 символ_в);
  -- MD - дата формування файла (м_сяць, день в 36-знаков_й систем_ числення);
  -- nnn - порядковий номер файла протягом дня. Нумерац_я в 36-знаков_й систем_ числення.



  if p_filetype = 'CV' or p_filetype = 'CA' then
       -- select substr(sab,2,3) into l_sab from banks$base where mfo = gl.amfo; --sys_context('bars_context','glb_mfo');
       select n_isep into l_sab from rcukru where mfo = gl.amfo;
     l_filename := p_filetype||'O'||l_sab||
                   f_chr36(extract(month from sysdate)) ||
                 f_chr36(extract(day from sysdate))||'.'|| lpad(f_conv36(l_filenum),3,'0');

  else
         l_filename := upper('@' || p_filetype || '0' ||
     lpad(l_dps,2,'0') ||
     lpad(f_ourmfo,6,'0') ||
     lpad(f_ourokpo,8,'0') ||
     f_chr36(extract(month from sysdate)) ||
     f_chr36(extract(day from sysdate)) ||
     lpad(f_conv36(l_filenum),3,'0') || '.XML');
  end if;

  p_filenum := l_filenum;

  bars_audit.info(p || 'Finish. l_filename=>' || l_filename);

  return l_filename;

end get_file_name;

-------------------------------------------------------------------------------
-- insert_to_temp
-- вставка во временную таблицу информации для @F фала
procedure insert_data_to_temp(p_mfo varchar2, p_okpo varchar2, p_rp number, p_ot varchar2, p_odat date,
                              p_nls varchar2, p_kv number, p_c_ag number , p_nmk varchar2,
                              p_adr varchar2, p_c_reg varchar2, p_c_dst varchar2, p_bic varchar2, p_country number)
is
begin
 bars_audit.info('insert_data_to_temp starts');

     if LENGTH(p_nmk) > 38 then
        raise_application_error(-20000, 'Длина имени клиента должна быть в рамках 38-х символов');
     end if;

     insert into dpa_acc_userid (mfo, okpo, rt, ot, odat, nls, kv, c_ag, nmk, adr, c_reg, c_dst, bic, country, userid)
     values(p_mfo, p_okpo, p_rp, p_ot, p_odat, p_nls, p_kv, p_c_ag, p_nmk, p_adr, p_c_reg, p_c_dst, p_bic, p_country, user_id);

 bars_audit.info('insert_data_to_temp finised');
end insert_data_to_temp;

-------------------------------------------------------------------------------
-- insert_to_temp
-- вставка во временную таблицу информации для @K фала
procedure insert_data_to_temp(p_bic varchar2, p_nmk varchar2,p_ot varchar2, p_odat date, p_nls varchar2,p_kv number, p_c_ag number, p_country number, p_c_reg varchar2,p_okpo varchar2)
is
begin
 bars_audit.info('insert_data_to_temp_k starts');
     insert into dpa_acc_userid (bic, nmk, ot, odat, nls, kv, c_ag, country, c_reg, okpo, userid)
     values(p_bic, p_nmk, p_ot, p_odat, p_nls, p_kv, p_c_ag, p_country, p_c_reg, p_okpo, user_id);

 bars_audit.info('insert_data_to_temp_k finised');
end insert_data_to_temp;

-------------------------------------------------------------------------------
-- insert_cvk_data_to_temp
-- вставка во временную таблицу информации для фалов CVK
procedure insert_data_to_temp(p_ref number)
is
begin

     insert into dpa_acc_userid (ref, userid)
     values(p_ref, user_id);
end insert_data_to_temp;


-------------------------------------------------------------------------------
-- form_cvk_file
-- сформировать файлы и поместить во временное хранилище dpa_lob
-- в переменную p_file_count вернуть кол-во файлов
procedure form_cvk_file(p_filetype varchar2, p_filedate date, p_file_count out number, p_ids out number_list)
is
   l_clob clob;
   l_file_line   varchar2(32000);
   l_file_name   varchar2(50);
   l_file_num    number;
   l_nl          varchar2(2) := chr(13)||chr(10);
   l_header_info varchar2(32000);
   l_system_info varchar2(32000);
   i  number := 0;
   l_lines_count number;
   l_trace       varchar2(1000) := 'form_cvk_file';
   l_iban        varchar2(29) := lpad(' ',29);
   l_kf          varchar2(6) :=sys_context('bars_context','user_mfo');
begin
   bars_audit.info(l_trace||'старт формирования файлов');

   p_ids := number_list();

   delete from dpa_lob where userid = user_id;

   if p_filetype = 'CA'  then

         for c in (


         select  row_number() over (order by nls) rown,
                            count(*)     over()  cnt,
                            MFO,   NB,   NLS,   DAOS,   VID,   TVO,   NAME_BLOK as name_block,   FIO_BLOK as fio_block,
                            FIO_ISP,   INF_ISP,   ADDR,   OKPO, INF_ISP2
                      from  v_cvk_ca
                      where daos = p_filedate
                   ) loop

          --првая запись
          if c.rown = 1 then
             bars_audit.info(l_trace||'старт формирования файла');
             l_file_name   := get_file_name(p_filetype, l_file_num);
             l_system_info  := lpad(' ', 100) || l_nl;
             l_header_info :=  substr(l_file_name,1,12)||to_char(sysdate,'yymmddhhmi')||lpadchr(c.cnt, '0', 6)||lpadchr('',' ', 166)||l_nl;
             bars_audit.info(l_trace||'сформировано имя файла '||l_file_name);
             -- вставка записи в заголовок
             insert into zag_tb(fn, dat, n) values(l_file_name, sysdate,c.cnt);
             dbms_lob.createtemporary(l_clob,FALSE);
             dbms_lob.append(l_clob, l_system_info||l_header_info);
          end if;

          l_file_line := rpad (coalesce(c.nb,' '), 38)||
                         lpad (coalesce(c.mfo,' '), 9)||
                         rpad (coalesce(c.addr,' '), 250)||
                         rpad (coalesce(c.vid,' '), 1)||
                         lpad (coalesce(c.nls,' '), 14)||
                         lpad (coalesce(c.tvo,' '), 3)||
                         rpad(coalesce(to_char(c.daos, 'yymmdd'),' '),6)||
                         rpad (coalesce(c.name_block,' '), 38)||
                         lpad (coalesce(c.okpo,' '), 10)||
                         rpad (coalesce(c.fio_block,' '), 76)||
                         rpad (coalesce(c.inf_isp,' '), 38)||
                         rpad (coalesce(c.inf_isp2,' '), 38)||l_nl;

           dbms_lob.append(l_clob, l_file_line);
           bars_audit.info(l_trace||'строка:'||l_file_line);
         end loop;

        p_ids.extend;

        insert into dpa_lob (file_data, file_name, userid)
        values (l_clob, l_file_name, user_id)
        returning id into p_ids(p_ids.last);

        update dpa_file_counters
           set taxca_date = trunc(sysdate), --trunc(p_filedate),
               taxca_seq  = l_file_num
         where kf = l_kf;

        bars_audit.trace(l_trace||'вставлен файл размером :'||dbms_lob.getlength(l_clob));
        p_file_count := 1;

   else

      for c in (
                 select --count(v.nls) over (partition by decode(vid, 13, '1', 14, '2', '3') ) cnt_vid,
                        --row_number() over (partition by decode(vid, 13, '1', 14, '2', '3') order by v.nls ) vid_rank,
                        -- відключив розбивку по типам рахунків. хз чого було так
                        count(v.nls) over () cnt_vid,
                        row_number() over (order by v.nls) vid_rank,
                        v.nls, decode(vid, 13, '1', 14, '2', '3') vid, fdat, mfo_d as mfoa, nls_d as nlsa, mfo_k as mfob, nls_k as nlsb,
                        dk, s, vob, nd,
                        v.kv, datd, datp, nam_a, nam_b, nazn, d_rec, naznk, nazns, id_d as id_a, id_k as id_b, v.ref, dat_a, dat_b
                   from v_dpa_cv v
                  where v.fdat = p_filedate
                  order by 2
                  --order     by vid, nls
               ) loop



          --новый вид счета, делаем новый файл
          if c.vid_rank = 1 then
             bars_audit.info(l_trace||'старт формирования файлов для группы '||c.vid);
             l_file_name   := replace(get_file_name(p_filetype, l_file_num),'*',c.vid);
             l_system_info  := lpad(' ', 100) || l_nl;
             l_header_info :=  substr(l_file_name,1,12)||to_char(sysdate,'yymmddhhmi')||lpadchr(c.cnt_vid, '0', 6)||lpadchr('',' ', 166)||l_nl;
             bars_audit.info(l_trace||'сформировано имя файла '||l_file_name);
             -- вставка записи в заголовок
             insert into zag_tb(fn, dat, n) values(l_file_name, sysdate,c.cnt_vid );

             -- кол-во файлов
             i := i+1;

             dbms_lob.createtemporary(l_clob,FALSE);
             dbms_lob.append(l_clob, l_system_info||l_header_info);
          end if;

          l_file_line :=  lpad(coalesce(c.mfoa,' '), 9) || lpad(coalesce(c.nlsa,' '),14) || lpad(coalesce(l_iban,' '),29) ||
                          lpad(coalesce(c.mfob,' '), 9) || lpad(coalesce(c.nlsb,' '),14) || lpad(coalesce(l_iban,' '),29) ||
                          to_char(c.dk)||
                          lpad(coalesce(c.s,' '),16) ||
                          lpad(coalesce(c.vob,' '), 2)||
                          rpad(coalesce(c.nd,' '),10) ||
                          lpad(coalesce(c.kv,' '), 3) ||
                          rpad(coalesce(to_char(c.datd, 'yyMMdd'),' '),6) ||
                          rpad(coalesce(to_char(c.datp, 'yyMMdd'),' '),6) ||
                          rpad(coalesce(c.nam_a,' '),38) ||
                          rpad(coalesce(c.nam_b,' '),38) ||
                          rpad(coalesce(c.nazn,' '),160)||
                          rpad(coalesce(c.d_rec,' '),60) ||
                          rpad(coalesce(c.naznk,' '),3) ||
                          rpad(coalesce(c.nazns,' '),2) ||
                          rpad(coalesce(c.id_a,' '),14)||
                          rpad(coalesce(c.id_b,' '),14)||
                          substr(lpad(coalesce(c.ref,' '),9),-9) ||
                          rpad(coalesce(to_char(c.dat_a, 'yyMMdd'),' '),6) ||
                          rpad(coalesce(to_char(c.dat_b, 'yyMMdd'),' '),6) || l_nl;
                      l_lines_count := l_lines_count + 1;
           dbms_lob.append(l_clob, l_file_line);


          --прочитали последню строку для данного вида счета
          if c.vid_rank = c.cnt_vid then
            p_ids.extend;

            insert into dpa_lob(file_data, file_name, userid)
            values(l_clob, l_file_name, user_id)
            returning id into p_ids(p_ids.last);

            update dpa_file_counters
               set taxcv_date = trunc(sysdate), --trunc(p_filedate),
                   taxcv_seq  = l_file_num
             where kf = l_kf;

            l_lines_count := 0;
          end if;

         end loop;

         --if dbms_lob.isopen(l_clob) = 1 then dbms_lob.close(l_clob); end if;

         -- навіть якщо нема руху то формуєм порожній файл
         -- (інформація від цвк)
         if i = 0 then
             l_file_name   := get_file_name(p_filetype, l_file_num);
             l_system_info  := lpad(' ', 100) || l_nl;
             l_header_info :=  substr(l_file_name,1,12)||to_char(sysdate,'yymmddhhmi')||lpadchr(/*c.cnt_vid*/0, '0', 6)||lpadchr('',' ', 166)||l_nl;

             dbms_lob.createtemporary(l_clob,FALSE);
             dbms_lob.append(l_clob, l_system_info||l_header_info);

             bars_audit.info(l_trace||'зформовано ім`я порожнього файла '||l_file_name);
             -- вставка записи в заголовок
             insert into zag_tb(fn, dat, n) values(l_file_name, sysdate,0);

             p_ids.extend;

             insert into dpa_lob(file_data, file_name, userid)
             values(l_clob, l_file_name, user_id)
             returning id into p_ids(p_ids.last);

             update dpa_file_counters
                set taxcv_date = trunc(sysdate), --trunc(p_filedate),
                    taxcv_seq  = l_file_num
              where kf = l_kf;

             l_lines_count := 0;

             i := i+1;
         end if;

         p_file_count := i;
         bars_audit.info(l_trace||'на выходе процедуры возвращаем кол-во файлов::'||p_file_count);


    end if;

end;
-------------------------------------------------------------------------------
-- get_cvk_file
-- Получить количество сформированных файлов ЦВК по типу файла
function get_cvk_file(p_filetype varchar2, p_file_number number, p_filename out varchar2) return clob
is
   l_clob clob;
   l_filename varchar2(4000);
begin
   select file_data, file_name
   into l_clob,  l_filename
   from dpa_lob
   where id = p_file_number and userid = user_id;

   p_filename := l_filename;

   return l_clob;
end;

end bars_dpa2;
/
 show err;
 
PROMPT *** Create  grants  BARS_DPA2 ***
grant EXECUTE                                                                on BARS_DPA2        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_DPA2        to RPBN002;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_dpa2.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 
