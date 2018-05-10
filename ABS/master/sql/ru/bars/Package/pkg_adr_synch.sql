CREATE OR REPLACE PACKAGE BARS.pkg_adr_synch IS


  function pfu_encode_base64(p_blob_in in blob) return clob;

  function pfu_decode_base64(p_clob_in in clob) return blob;

  --конвертируем клоб в блоб и пишем в талицу фалов ЦА
  procedure write_files (p_fileid    in number,
                         p_sign      in raw default null,

                         p_file_data in clob,
                         p_message   in VARCHAR2,
                         p_state     out NUMBER);

   --РУ ищет свой последний загруженный файл
  procedure find_max_files(p_fileid    out ADR_RU_FILES.ID%type);


  --РУ запрашивает файл в ЦА
  procedure response_files(p_fileid      in ADR_CA_FILES.ID%type, --РУ передает свой последний загруженный
                          p_request_mfo in varchar2,
                          p_file_data   out clob);

 --пишем в талицу фалов РУ
  procedure import_files(p_fileid    in number,
                         p_sign      in raw default null,
                         p_file_data in clob,
                         p_state     out number);

  --РУ обрабатывает файл
  procedure processing_files;

  --запрос и обработка файлов
  procedure update_data;

END pkg_adr_synch;
/

CREATE OR REPLACE PACKAGE BODY pkg_adr_synch IS

  --TYPE t_tablelist             IS TABLE OF varchar2(100);
  TYPE t_ADR_REGIONS           IS TABLE OF ADR_REGIONS%ROWTYPE;
  TYPE t_ADR_AREAS             IS TABLE OF ADR_AREAS%ROWTYPE;
  TYPE t_ADR_SETTLEMENT_TYPES  IS TABLE OF ADR_SETTLEMENT_TYPES%ROWTYPE;
  TYPE t_ADR_SETTLEMENTS       IS TABLE OF ADR_SETTLEMENTS%ROWTYPE;
  TYPE t_ADR_CITY_DISTRICTS    IS TABLE OF ADR_CITY_DISTRICTS%ROWTYPE;
  TYPE t_ADR_STREET_TYPES      IS TABLE OF ADR_STREET_TYPES%ROWTYPE;
  TYPE t_ADR_STREETS           IS TABLE OF ADR_STREETS%ROWTYPE;
  TYPE t_ADR_HOUSES            IS TABLE OF ADR_HOUSES%ROWTYPE;
  TYPE t_ADR_PHONE_CODES       IS TABLE OF ADR_PHONE_CODES%ROWTYPE;


    function pfu_encode_base64(
         p_blob_in in blob)
    return clob
    is
        v_clob clob;
        v_result clob;
        v_offset integer;
        v_chunk_size binary_integer := (48 / 4) * 3;
        v_buffer_varchar varchar2(48);
        v_buffer_raw raw(48);
    begin
        if p_blob_in is null then
            return null;
        end if;
        dbms_lob.createtemporary(v_clob, true);
        v_offset := 1;
        for i in 1 .. ceil(dbms_lob.getlength(p_blob_in) / v_chunk_size) loop
            dbms_lob.read(p_blob_in, v_chunk_size, v_offset, v_buffer_raw);
            v_buffer_raw := utl_encode.base64_encode(v_buffer_raw);
            v_buffer_varchar := utl_raw.cast_to_varchar2(v_buffer_raw);
            dbms_lob.writeappend(v_clob, length(v_buffer_varchar), v_buffer_varchar);
            v_offset := v_offset + v_chunk_size;
        end loop;

        v_result := v_clob;
        dbms_lob.freetemporary(v_clob);
        return v_result;
    end;


    function pfu_decode_base64(
        p_clob_in in clob)
    return blob
    is
        v_blob blob;
        v_result blob;
        v_offset integer;
        v_buffer_size binary_integer := 48;
        v_buffer_varchar varchar2(48);
        v_buffer_raw raw(48);
    begin
        if p_clob_in is null then
            return null;
        end if;

        dbms_lob.createtemporary(v_blob, true);
        v_offset := 1;

        for i in 1 .. ceil(dbms_lob.getlength(p_clob_in) / v_buffer_size) loop
            dbms_lob.read(p_clob_in, v_buffer_size, v_offset, v_buffer_varchar);
            v_buffer_raw := utl_raw.cast_to_raw(v_buffer_varchar);
            v_buffer_raw := utl_encode.base64_decode(v_buffer_raw);
            dbms_lob.writeappend(v_blob, utl_raw.length(v_buffer_raw), v_buffer_raw);
            v_offset := v_offset + v_buffer_size;
        end loop;

        v_result := v_blob;
        dbms_lob.freetemporary(v_blob);

        return v_result;
    end;


  --конвертируем клоб в блоб и пишем в талицу фалов ЦА
  procedure write_files (p_fileid    in number,
                         p_sign      in raw default null,
                         p_file_data in clob,
                         p_message   in VARCHAR2,
                         p_state     out NUMBER) is
    l_blob      blob;
    l_warning    integer;
    l_dest_offset integer := 1;
    l_src_offset integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;

    title        varchar2(100) := 'pkg_adr_synch.write_files. ';
  begin
      dbms_lob.createtemporary(lob_loc => l_blob,
                               cache   => true,
                               dur     => dbms_lob.call);

      dbms_lob.converttoblob(dest_lob     => l_blob,
                             src_clob     => p_file_data,
                             amount       => dbms_lob.lobmaxsize,
                             dest_offset  => l_dest_offset,
                             src_offset   => l_src_offset,
                             blob_csid    => l_blob_csid,
                             lang_context => l_lang_context,
                             warning      => l_warning);

       l_blob := utl_compress.lz_compress(l_blob);


    bars_audit.info(title || 'Start. Fileid=' || p_fileid);
      p_state:=0;
      insert into adr_ca_files
        (id, file_data , state,message ,sign, ddate )
      values
        (p_fileid, l_blob, p_state, null,null, sysdate);
      bars_audit.info(title || 'File written. Fileid=' || p_fileid);

  exception
    when others   then
      p_state:=99;--ошибка
      bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                              chr(10) || dbms_utility.format_error_backtrace() );
  end;

  --парсим XML
  PROCEDURE p_xml_parse
  (
    p_file_id     in  NUMBER DEFAULT NULL,
    p_err          out NUMBER,
    p_message      out varchar2
  ) IS
    l_doc         dbms_xmldom.domdocument;
    title         VARCHAR2(100) := 'bars.pkg_adr_synch.p_xml_parse.';
    l_parser      dbms_xmlparser.parser;
    l_reg_xml     CLOB;
    l_tablelist   dbms_xmldom.domnodelist;
    l_rowlist     dbms_xmldom.domnodelist;
    l_columnlist  dbms_xmldom.domnodelist;
    l_table       dbms_xmldom.domnode;
    l_row         dbms_xmldom.domnode;
    l_table_name  VARCHAR2(100);
    l_str         VARCHAR2(2000);

    --типы
    --l_tl                     t_tablelist              := t_tablelist();
    l_ADR_REGIONS            t_ADR_REGIONS            :=t_ADR_REGIONS();
    l_ADR_AREAS              t_ADR_AREAS              :=t_ADR_AREAS();
    l_ADR_SETTLEMENT_TYPES   t_ADR_SETTLEMENT_TYPES   :=t_ADR_SETTLEMENT_TYPES();
    l_ADR_SETTLEMENTS        t_ADR_SETTLEMENTS        :=t_ADR_SETTLEMENTS();
    l_ADR_CITY_DISTRICTS     t_ADR_CITY_DISTRICTS     :=t_ADR_CITY_DISTRICTS();
    l_ADR_STREET_TYPES       t_ADR_STREET_TYPES       :=t_ADR_STREET_TYPES();
    l_ADR_STREETS            t_ADR_STREETS            :=t_ADR_STREETS();
    l_ADR_HOUSES             t_ADR_HOUSES             :=t_ADR_HOUSES();
    l_ADR_PHONE_CODES        t_ADR_PHONE_CODES        :=t_ADR_PHONE_CODES();

    v_Attr_Node      Dbms_Xmldom.Domnode;
    v_Attr_Nodes     Dbms_Xmldom.Domnamednodemap;
    p_err_loc        NUMBER(10);
  BEGIN
     p_err:=0;
      BEGIN
        SELECT t.file_data
          INTO l_reg_xml
          FROM ADR_RU_FILES t
         WHERE t.id = p_file_id;
      EXCEPTION
        WHEN no_data_found THEN
           bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                              chr(10) || dbms_utility.format_error_backtrace() );
      END;

    bars_audit.trace(title || 'Started');
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, l_reg_xml);
    bars_audit.trace(title || 'clob loaded');

    l_doc := dbms_xmlparser.getdocument(l_parser);
    bars_audit.trace(title || 'getdocument done');

------------------------------------------
  --формируем список таблиц
    l_tablelist := dbms_xmldom.getelementsbytagname(l_doc,'table');

   FOR i IN 0 .. dbms_xmldom.getlength(l_tablelist) - 1
   LOOP
      l_table := dbms_xmldom.item(l_tablelist, i);

      --l_tl.extend;

      v_Attr_Nodes :=Dbms_Xmldom.Getattributes(l_table);
      v_Attr_Node  := Dbms_Xmldom.Item(v_Attr_Nodes,0);
      l_table_name :=Dbms_Xmldom.Getnodevalue(v_Attr_Node);

      --l_tl(l_tl.last):= l_table_name;

    --  dbms_output.put_line(i+1||' - '||l_table_name);
    if l_table_name = 'ADR_REGIONS' then
          --формируем список строк
          l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,l_table_name);
          FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
          LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_ADR_REGIONS.extend;

             dbms_xslprocessor.valueof(l_row, 'REGION_ID/text()', l_str);
             l_ADR_REGIONS(l_ADR_REGIONS.last).region_id  := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'REGION_NAME/text()', l_str);
             l_ADR_REGIONS(l_ADR_REGIONS.last).region_name  := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'REGION_NAME_RU/text()', l_str);
             l_ADR_REGIONS(l_ADR_REGIONS.last).region_name_ru  := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'COUNTRY_ID/text()', l_str);
             l_ADR_REGIONS(l_ADR_REGIONS.last).country_id  := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'KOATUU/text()', l_str);
             l_ADR_REGIONS(l_ADR_REGIONS.last).koatuu  := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ISO3166_2/text()', l_str);
             l_ADR_REGIONS(l_ADR_REGIONS.last).iso3166_2  := trim(l_str);

           END LOOP;

             BEGIN
               EXECUTE IMMEDIATE ' delete from  ERR$_ADR_REGIONS';
             END;

             if l_ADR_REGIONS IS NOT EMPTY then
              --обновление данных
              BEGIN
                FOR j IN l_ADR_REGIONS.first .. l_ADR_REGIONS.last
                loop
                  insert into ADR_REGIONS_HIST select S_ADR_REGIONS_HIST.NEXTVAL,sysdate,A.* from ADR_REGIONS A where a.region_id=l_ADR_REGIONS(j).region_id;

                  UPDATE ADR_REGIONS A
                  set A.REGION_NAME      =  l_ADR_REGIONS(j).REGION_NAME,
                      A.region_name_ru   =  l_ADR_REGIONS(j).region_name_ru
                  where A.REGION_ID = l_ADR_REGIONS(j).REGION_ID
                  log errors INTO ERR$_ADR_REGIONS
                    ('UPDATE') reject LIMIT unlimited;


                 if sql%rowcount = 0 then
                  INSERT INTO ADR_REGIONS(region_id,
                                          region_name,
                                          region_name_ru)
                  VALUES (  l_ADR_REGIONS(j).region_id,
                            l_ADR_REGIONS(j).REGION_NAME,
                            l_ADR_REGIONS(j).region_name_ru

                   )
                     log errors INTO ERR$_ADR_REGIONS
                    ('INSERT') reject LIMIT unlimited;

                 end if;
               end loop;
             END;
           end if;
     BEGIN
       SELECT count(*) into p_err_loc  from  ERR$_ADR_REGIONS;
       p_err:=p_err+p_err_loc;
       if p_err_loc> 0 then
         p_message:=p_message||'ERR$_ADR_REGIONS'||'; ';
       end if;
     END;
     --очистка,якщо виникли помилки
    l_ADR_REGIONS.delete();
    l_ADR_REGIONS := NULL;

    elsif l_table_name = 'ADR_AREAS' then
          --формируем список строк
          l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,l_table_name);
          FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
          LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_ADR_AREAS.extend;

             dbms_xslprocessor.valueof(l_row, 'AREA_ID/text()', l_str);
             l_ADR_AREAS(l_ADR_AREAS.last).area_id  := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'SPIU_AREA_ID/text()', l_str);
             l_ADR_AREAS(l_ADR_AREAS.last).spiu_area_id  := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'AREA_NAME/text()', l_str);
             l_ADR_AREAS(l_ADR_AREAS.last).area_name  := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'AREA_NAME_RU/text()', l_str);
             l_ADR_AREAS(l_ADR_AREAS.last).area_name_ru  := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'REGION_ID/text()', l_str);
             l_ADR_AREAS(l_ADR_AREAS.last).region_id  := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'KOATUU/text()', l_str);
             l_ADR_AREAS(l_ADR_AREAS.last).koatuu  := trim(l_str);
          END LOOP;

             BEGIN
               EXECUTE IMMEDIATE ' delete from  ERR$_ADR_AREAS';
             END;


             if l_ADR_AREAS IS NOT EMPTY then
              --обновление данных
              BEGIN
                FOR j IN l_ADR_AREAS.first .. l_ADR_AREAS.last
                loop
                  insert into ADR_AREAS_HIST select S_ADR_AREAS_HIST.NEXTVAL,sysdate,A.* from ADR_AREAS A where a.area_id=l_ADR_AREAS(j).area_id;

                  UPDATE ADR_AREAS A
                  set A.SPIU_AREA_ID  = l_ADR_AREAS(j).SPIU_AREA_ID,
                      A.AREA_NAME     = l_ADR_AREAS(j).AREA_NAME,
                      A.AREA_NAME_RU  = l_ADR_AREAS(j).AREA_NAME_RU,
                      A.REGION_ID     = l_ADR_AREAS(j).REGION_ID,
                      A.KOATUU        = l_ADR_AREAS(j).KOATUU
                  where A.AREA_ID  = l_ADR_AREAS(j).AREA_ID
                  log errors INTO ERR$_ADR_AREAS
                    ('UPDATE') reject LIMIT unlimited;


                 if sql%rowcount = 0 then
                  INSERT INTO ADR_AREAS(area_id,
                                        spiu_area_id,
                                        area_name,
                                        area_name_ru,
                                        region_id,
                                        koatuu
                                        )
                  VALUES (  l_ADR_AREAS(j).area_id,
                            l_ADR_AREAS(j).spiu_area_id,
                            l_ADR_AREAS(j).area_name,
                            l_ADR_AREAS(j).area_name_ru,
                            l_ADR_AREAS(j).region_id,
                            l_ADR_AREAS(j).koatuu
                   )
                     log errors INTO ERR$_ADR_AREAS
                    ('INSERT') reject LIMIT unlimited;

                 end if;
               end loop;
             END;
           end if;
     BEGIN
       SELECT count(*) into p_err_loc  from  ERR$_ADR_AREAS;
       p_err:=p_err+p_err_loc;
       if p_err_loc> 0 then
         p_message:=p_message||'ERR$_ADR_AREAS'||'; ';
       end if;
     END;

    --очистка,якщо виникли помилки
    l_ADR_AREAS.delete();
    l_ADR_AREAS := NULL;

    elsif l_table_name = 'ADR_SETTLEMENT_TYPES' then
          --формируем список строк
          l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,l_table_name);
          FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
          LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_ADR_SETTLEMENT_TYPES.extend;

             dbms_xslprocessor.valueof(l_row, 'SETTLEMENT_TP_ID/text()', l_str);
             l_ADR_SETTLEMENT_TYPES(l_ADR_SETTLEMENT_TYPES.last).settlement_tp_id   := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'SETTLEMENT_TP_NM/text()', l_str);
             l_ADR_SETTLEMENT_TYPES(l_ADR_SETTLEMENT_TYPES.last).settlement_tp_nm   := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'SETTLEMENT_TP_NM_RU/text()', l_str);
             l_ADR_SETTLEMENT_TYPES(l_ADR_SETTLEMENT_TYPES.last).settlement_tp_nm_ru   := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'SETTLEMENT_TP_CODE/text()', l_str);
             l_ADR_SETTLEMENT_TYPES(l_ADR_SETTLEMENT_TYPES.last).settlement_tp_code   := trim(l_str);

          END LOOP;

             BEGIN
               EXECUTE IMMEDIATE ' delete from  ERR$_ADR_SETTLEMENT_TYPES';
             END;


             if l_ADR_SETTLEMENT_TYPES IS NOT EMPTY then
              --обновление данных
              BEGIN
                FOR j IN l_ADR_SETTLEMENT_TYPES.first .. L_ADR_SETTLEMENT_TYPES.last
                loop
                  insert into ADR_SETTLEMENT_TYPES_HIST select S_ADR_SETTLEMENT_TYPES_HIST.NEXTVAL,sysdate,A.* from ADR_SETTLEMENT_TYPES A where a.settlement_tp_id  =l_ADR_SETTLEMENT_TYPES(j).settlement_tp_id;

                  UPDATE ADR_SETTLEMENT_TYPES A
                  set A.SETTLEMENT_TP_NM    = L_ADR_SETTLEMENT_TYPES(j).SETTLEMENT_TP_NM,
                      A.SETTLEMENT_TP_NM_RU = L_ADR_SETTLEMENT_TYPES(j).SETTLEMENT_TP_NM_RU,
                      A.SETTLEMENT_TP_CODE  = L_ADR_SETTLEMENT_TYPES(j).SETTLEMENT_TP_CODE
                  where A.SETTLEMENT_TP_ID = L_ADR_SETTLEMENT_TYPES(j).SETTLEMENT_TP_ID
                  log errors INTO ERR$_ADR_SETTLEMENT_TYPES
                    ('UPDATE') reject LIMIT unlimited;


                 if sql%rowcount = 0 then
                  INSERT INTO ADR_SETTLEMENT_TYPES( settlement_tp_id,
                                                    settlement_tp_nm,
                                                    settlement_tp_nm_ru,
                                                    settlement_tp_code
                                                    )
                  VALUES (  L_ADR_SETTLEMENT_TYPES(j).settlement_tp_id,
                            L_ADR_SETTLEMENT_TYPES(j).settlement_tp_nm,
                            L_ADR_SETTLEMENT_TYPES(j).settlement_tp_nm_ru,
                            L_ADR_SETTLEMENT_TYPES(j).settlement_tp_code
                   )
                     log errors INTO ERR$_ADR_SETTLEMENT_TYPES
                    ('INSERT') reject LIMIT unlimited;

                 end if;
               end loop;
             END;
           end if;
     BEGIN
       SELECT count(*) into p_err_loc  from  ERR$_ADR_SETTLEMENT_TYPES;
         p_err:=p_err+p_err_loc;
     if p_err_loc> 0 then
       p_message:=p_message||'ERR$_ADR_SETTLEMENT_TYPES'||'; ';
     end if;
     END;

    --очистка,якщо виникли помилки
    L_ADR_SETTLEMENT_TYPES.delete();
    L_ADR_SETTLEMENT_TYPES := NULL;

    elsif l_table_name = 'ADR_SETTLEMENTS' then
          --формируем список строк
          l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,l_table_name);
          FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
          LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_ADR_SETTLEMENTS.extend;

             dbms_xslprocessor.valueof(l_row, 'SETTLEMENT_ID/text()', l_str);
             l_ADR_SETTLEMENTS(l_ADR_SETTLEMENTS.last).settlement_id  := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'SETTLEMENT_NAME/text()', l_str);
             l_ADR_SETTLEMENTS(l_ADR_SETTLEMENTS.last).settlement_name  := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'SETTLEMENT_NAME_RU/text()', l_str);
             l_ADR_SETTLEMENTS(l_ADR_SETTLEMENTS.last).settlement_name_ru  := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'SETTLEMENT_TYPE_ID/text()', l_str);
             l_ADR_SETTLEMENTS(l_ADR_SETTLEMENTS.last).settlement_type_id  := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'POSTAL_CODE_MIN/text()', l_str);
             l_ADR_SETTLEMENTS(l_ADR_SETTLEMENTS.last).postal_code_min  := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'POSTAL_CODE_MAX/text()', l_str);
             l_ADR_SETTLEMENTS(l_ADR_SETTLEMENTS.last).postal_code_max  := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'PHONE_CODE_ID/text()', l_str);
             l_ADR_SETTLEMENTS(l_ADR_SETTLEMENTS.last).phone_code_id  := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'REGION_CENTER_F/text()', l_str);
             l_ADR_SETTLEMENTS(l_ADR_SETTLEMENTS.last).region_center_f  := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'AREA_CENTER_F/text()', l_str);
             l_ADR_SETTLEMENTS(l_ADR_SETTLEMENTS.last).area_center_f  :=to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'REGION_ID/text()', l_str);
             l_ADR_SETTLEMENTS(l_ADR_SETTLEMENTS.last).region_id  := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, ' SPIU_AREA_ID/text()', l_str);
             l_ADR_SETTLEMENTS(l_ADR_SETTLEMENTS.last).area_id  := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, ' KOATUU/text()', l_str);
             l_ADR_SETTLEMENTS(l_ADR_SETTLEMENTS.last).koatuu  := trim(l_str);

             dbms_xslprocessor.valueof(l_row, ' TERRSTATUS/text()', l_str);
             l_ADR_SETTLEMENTS(l_ADR_SETTLEMENTS.last).terrstatus  := trim(l_str);

             dbms_xslprocessor.valueof(l_row, ' EFF_DT/text()', l_str);
             l_ADR_SETTLEMENTS(l_ADR_SETTLEMENTS.last).eff_dt  := to_date(substr(l_str, 1, 10),'yyyy-mm-dd');

             dbms_xslprocessor.valueof(l_row, ' END_DT/text()', l_str);
             l_ADR_SETTLEMENTS(l_ADR_SETTLEMENTS.last).end_dt  := to_date(substr(l_str, 1, 10),'yyyy-mm-dd');

             dbms_xslprocessor.valueof(l_row, ' SETTLEMENT_PID/text()', l_str);
             l_ADR_SETTLEMENTS(l_ADR_SETTLEMENTS.last).settlement_pid  := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, ' SPIU_CITY_ID/text()', l_str);
             l_ADR_SETTLEMENTS(l_ADR_SETTLEMENTS.last).spiu_city_id  := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, ' SPIU_SUBURB_ID/text()', l_str);
             l_ADR_SETTLEMENTS(l_ADR_SETTLEMENTS.last).spiu_suburb_id  := to_number(l_str);

           END LOOP;

             BEGIN
               EXECUTE IMMEDIATE ' delete from  ERR$_ADR_SETTLEMENTS';
             END;
            --  dbms_output.put_line('Attrs: '||l_str);


            if l_ADR_SETTLEMENTS IS NOT EMPTY then
              --обновление данных
              BEGIN
                FOR j IN l_ADR_SETTLEMENTS.first .. l_ADR_SETTLEMENTS.last
                loop
                  insert into ADR_SETTLEMENTS_HIST select S_ADR_SETTLEMENTS_HIST.NEXTVAL,sysdate,A.* from ADR_SETTLEMENTS A where a.settlement_id=l_ADR_SETTLEMENTS(j).settlement_id;

                  UPDATE ADR_SETTLEMENTS A
                  set A.settlement_name      =  l_ADR_SETTLEMENTS(j).settlement_name,
                      A.settlement_name_ru   =  l_ADR_SETTLEMENTS(j).settlement_name_ru,
                      A.settlement_type_id   =  l_ADR_SETTLEMENTS(j).settlement_type_id,
                      A.postal_code_min      =  l_ADR_SETTLEMENTS(j).postal_code_min,
                      A.postal_code_max      =  l_ADR_SETTLEMENTS(j).postal_code_max,
                      A.phone_code_id        =  l_ADR_SETTLEMENTS(j).phone_code_id,
                      A.region_center_f      =  l_ADR_SETTLEMENTS(j).region_center_f,
                      A.area_center_f        =  l_ADR_SETTLEMENTS(j).area_center_f,
                      A.region_id            =  l_ADR_SETTLEMENTS(j).region_id,
                      A.area_id              =  (select r.area_id from adr_areas r where r.spiu_area_id= l_ADR_SETTLEMENTS(j).area_id and r.region_id = l_ADR_SETTLEMENTS(j).region_id ),
                      A.koatuu               =  l_ADR_SETTLEMENTS(j).koatuu,
                      A.terrstatus           =  l_ADR_SETTLEMENTS(j).terrstatus,
                      A.eff_dt               =  l_ADR_SETTLEMENTS(j).eff_dt,
                      A.end_dt               =  l_ADR_SETTLEMENTS(j).end_dt,
                      A.settlement_pid       =  l_ADR_SETTLEMENTS(j).settlement_pid,
                      A.spiu_city_id         =  l_ADR_SETTLEMENTS(j).spiu_city_id,
                      A.spiu_suburb_id       =  l_ADR_SETTLEMENTS(j).spiu_suburb_id
                  where A.SETTLEMENT_ID = l_ADR_SETTLEMENTS(j).settlement_id
                  log errors INTO ERR$_ADR_SETTLEMENTS
                    ('UPDATE') reject LIMIT unlimited;

                 if sql%rowcount = 0 then
                  INSERT INTO ADR_SETTLEMENTS(settlement_id,
                                              settlement_name,
                                              settlement_name_ru,
                                              settlement_type_id,
                                              postal_code_min,
                                              postal_code_max,
                                              phone_code_id,
                                              region_center_f,
                                              area_center_f,
                                              region_id,
                                              area_id,
                                              koatuu,
                                              terrstatus,
                                              eff_dt,
                                              end_dt,
                                              settlement_pid,
                                              spiu_city_id,
                                              spiu_suburb_id
                                              )
                  VALUES (l_ADR_SETTLEMENTS(j).settlement_id,
                         l_ADR_SETTLEMENTS(j).settlement_name,
                         l_ADR_SETTLEMENTS(j).settlement_name_ru,
                         l_ADR_SETTLEMENTS(j).settlement_type_id,
                         l_ADR_SETTLEMENTS(j).postal_code_min,
                         l_ADR_SETTLEMENTS(j).postal_code_max,
                         l_ADR_SETTLEMENTS(j).phone_code_id,
                         l_ADR_SETTLEMENTS(j).region_center_f,
                         l_ADR_SETTLEMENTS(j).area_center_f,
                         l_ADR_SETTLEMENTS(j).region_id,
                         (select r.area_id from adr_areas r where r.spiu_area_id= l_ADR_SETTLEMENTS(j).area_id and r.region_id = l_ADR_SETTLEMENTS(j).region_id ),
                         l_ADR_SETTLEMENTS(j).koatuu,
                         l_ADR_SETTLEMENTS(j).terrstatus,
                         l_ADR_SETTLEMENTS(j).eff_dt,
                         l_ADR_SETTLEMENTS(j).end_dt,
                         l_ADR_SETTLEMENTS(j).settlement_pid,
                         l_ADR_SETTLEMENTS(j).spiu_city_id,
                         l_ADR_SETTLEMENTS(j).spiu_suburb_id )
                     log errors INTO ERR$_ADR_SETTLEMENTS
                    ('INSERT') reject LIMIT unlimited;
                 end if;
               end loop;
             END;
           end if;
     BEGIN
       SELECT count(*) into p_err_loc  from  ERR$_ADR_SETTLEMENTS;
       p_err:=p_err+p_err_loc;
       if p_err_loc> 0 then
         p_message:=p_message||'ERR$_ADR_SETTLEMENTS'||'; ';
       end if;
     END;

    --очистка,якщо виникли помилки
    l_ADR_SETTLEMENTS.delete();
    l_ADR_SETTLEMENTS := NULL;

   elsif l_table_name = 'ADR_CITY_DISTRICTS' then
          --формируем список строк
          l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,l_table_name);
          FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
          LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_ADR_CITY_DISTRICTS.extend;

             dbms_xslprocessor.valueof(l_row, 'DISTRICT_ID/text()', l_str);
             l_ADR_CITY_DISTRICTS(l_ADR_CITY_DISTRICTS.last).district_id   := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'DISTRICT_NAME/text()', l_str);
             l_ADR_CITY_DISTRICTS(l_ADR_CITY_DISTRICTS.last).district_name   := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'DISTRICT_NAME_RU/text()', l_str);
             l_ADR_CITY_DISTRICTS(l_ADR_CITY_DISTRICTS.last).district_name_ru   := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'SETTLEMENT_ID/text()', l_str);
             l_ADR_CITY_DISTRICTS(l_ADR_CITY_DISTRICTS.last).settlement_id   := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'SPIU_DISTRICT_ID/text()', l_str);
             l_ADR_CITY_DISTRICTS(l_ADR_CITY_DISTRICTS.last).spiu_district_id   := to_number(l_str);

           END LOOP;

             BEGIN
               EXECUTE IMMEDIATE ' delete from  ERR$_ADR_CITY_DISTRICTS';
             END;


             if l_ADR_CITY_DISTRICTS IS NOT EMPTY then
              --обновление данных
              BEGIN
                FOR j IN l_ADR_CITY_DISTRICTS.first .. l_ADR_CITY_DISTRICTS.last
                loop
                  insert into ADR_CITY_DISTRICTS_HIST select S_ADR_CITY_DISTRICTS_HIST.NEXTVAL,sysdate,A.* from ADR_CITY_DISTRICTS A where a.district_id=l_ADR_CITY_DISTRICTS(j).district_id;

                  UPDATE ADR_CITY_DISTRICTS A
                  set A.DISTRICT_NAME     = l_ADR_CITY_DISTRICTS(j).DISTRICT_NAME,
                      A.DISTRICT_NAME_RU  = l_ADR_CITY_DISTRICTS(j).DISTRICT_NAME_RU,
                      A.SETTLEMENT_ID     = l_ADR_CITY_DISTRICTS(j).SETTLEMENT_ID,
                      A.SPIU_DISTRICT_ID  = l_ADR_CITY_DISTRICTS(j).SPIU_DISTRICT_ID
                  where A.DISTRICT_ID = l_ADR_CITY_DISTRICTS(j).DISTRICT_ID
                  log errors INTO ERR$_ADR_CITY_DISTRICTS
                    ('UPDATE') reject LIMIT unlimited;


                 if sql%rowcount = 0 then
                  INSERT INTO ADR_CITY_DISTRICTS( district_id,
                                                  district_name,
                                                  district_name_ru,
                                                  settlement_id,
                                                  spiu_district_id
                                                  )
                  VALUES (  l_ADR_CITY_DISTRICTS(j).DISTRICT_ID,
                            l_ADR_CITY_DISTRICTS(j).district_name,
                            l_ADR_CITY_DISTRICTS(j).district_name_ru,
                            l_ADR_CITY_DISTRICTS(j).settlement_id,
                            l_ADR_CITY_DISTRICTS(j).spiu_district_id
                   )
                     log errors INTO ERR$_ADR_CITY_DISTRICTS
                    ('INSERT') reject LIMIT unlimited;

                 end if;
               end loop;
             END;
           end if;
     BEGIN
       SELECT count(*) into p_err_loc  from  ERR$_ADR_CITY_DISTRICTS;
       p_err:=p_err+p_err_loc;
       if p_err_loc> 0 then
         p_message:=p_message||'ERR$_ADR_CITY_DISTRICTS'||'; ';
       end if;
     END;

    --очистка,якщо виникли помилки
    l_ADR_CITY_DISTRICTS.delete();
    l_ADR_CITY_DISTRICTS := NULL;

   elsif l_table_name = 'ADR_STREET_TYPES' then
          --формируем список строк
          l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,l_table_name);
          FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
          LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_ADR_STREET_TYPES.extend;

             dbms_xslprocessor.valueof(l_row, 'STR_TP_ID/text()', l_str);
             l_ADR_STREET_TYPES(l_ADR_STREET_TYPES.last).str_tp_id    := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'STR_TP_NM/text()', l_str);
             l_ADR_STREET_TYPES(l_ADR_STREET_TYPES.last).str_tp_nm    := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'STR_TP_NM_RU/text()', l_str);
             l_ADR_STREET_TYPES(l_ADR_STREET_TYPES.last).str_tp_nm_ru    := trim(l_str);

           END LOOP;

             BEGIN
               EXECUTE IMMEDIATE ' delete from  ERR$_ADR_STREET_TYPES';
             END;


             if l_ADR_STREET_TYPES IS NOT EMPTY then
              --обновление данных
              BEGIN
                FOR j IN l_ADR_STREET_TYPES.first .. l_ADR_STREET_TYPES.last
                loop
                  insert into ADR_STREET_TYPES_HIST select S_ADR_STREET_TYPES_HIST.NEXTVAL,sysdate,A.* from ADR_STREET_TYPES A where a.str_tp_id=l_ADR_STREET_TYPES(j).str_tp_id;


                  UPDATE ADR_STREET_TYPES A
                  set A.STR_TP_NM     = l_ADR_STREET_TYPES(j).STR_TP_NM,
                      A.STR_TP_NM_RU  = l_ADR_STREET_TYPES(j).STR_TP_NM_RU
                  where A.STR_TP_ID = l_ADR_STREET_TYPES(j).STR_TP_ID
                  log errors INTO ERR$_ADR_STREET_TYPES
                    ('UPDATE') reject LIMIT unlimited;



                 if sql%rowcount = 0 then
                  INSERT INTO ADR_STREET_TYPES( str_tp_id,
                                                str_tp_nm,
                                                str_tp_nm_ru
                                                  )
                  VALUES (  l_ADR_STREET_TYPES(j).str_tp_id,
                            l_ADR_STREET_TYPES(j).str_tp_nm,
                            l_ADR_STREET_TYPES(j).str_tp_nm_ru
                   )
                     log errors INTO ERR$_ADR_STREET_TYPES
                    ('INSERT') reject LIMIT unlimited;

                 end if;
               end loop;
             END;
           end if;
     BEGIN
       SELECT count(*) into p_err_loc  from  ERR$_ADR_STREET_TYPES;
       p_err:=p_err+p_err_loc;
       if p_err_loc> 0 then
         p_message:=p_message||'ERR$_ADR_STREET_TYPES'||'; ';
       end if;
     END;

    --очистка,якщо виникли помилки
    l_ADR_STREET_TYPES.delete();
    l_ADR_STREET_TYPES := NULL;

  elsif l_table_name = 'ADR_STREETS' then
          --формируем список строк
          l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,l_table_name);
          FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
          LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_ADR_STREETS.extend;

             dbms_xslprocessor.valueof(l_row, 'STREET_ID/text()', l_str);
             l_ADR_STREETS(l_ADR_STREETS.last).street_id  := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'STREET_NAME/text()', l_str);
             l_ADR_STREETS(l_ADR_STREETS.last).street_name  := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'STREET_NAME_RU/text()', l_str);
             l_ADR_STREETS(l_ADR_STREETS.last).street_name_ru  := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'STREET_TYPE/text()', l_str);
             l_ADR_STREETS(l_ADR_STREETS.last).street_type  := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'SETTLEMENT_ID/text()', l_str);
             l_ADR_STREETS(l_ADR_STREETS.last).settlement_id  := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'EFF_DT/text()', l_str);
             l_ADR_STREETS(l_ADR_STREETS.last).eff_dt  := to_date(substr(l_str, 1, 10),'yyyy-mm-dd');

             dbms_xslprocessor.valueof(l_row, 'END_DT/text()', l_str);
             l_ADR_STREETS(l_ADR_STREETS.last).end_dt  := to_date(substr(l_str, 1, 10),'yyyy-mm-dd');

           END LOOP;

             BEGIN
               EXECUTE IMMEDIATE ' delete from  ERR$_ADR_STREETS';
             END;


             if l_ADR_STREETS IS NOT EMPTY then
              --обновление данных
              BEGIN
                FOR j IN l_ADR_STREETS.first .. l_ADR_STREETS.last
                loop
                  insert into ADR_STREETS_HIST select S_ADR_STREETS_HIST.NEXTVAL,sysdate,A.* from ADR_STREETS A where a.street_id=l_ADR_STREETS(j).street_id;

                  UPDATE ADR_STREETS A
                  set A.STREET_NAME      =  l_ADR_STREETS(j).STREET_NAME,
                      A.STREET_NAME_RU   =  l_ADR_STREETS(j).STREET_NAME_RU,
                      A.STREET_TYPE      =  l_ADR_STREETS(j).STREET_TYPE,
                      A.SETTLEMENT_ID    =  l_ADR_STREETS(j).SETTLEMENT_ID,
                      A.EFF_DT           =  l_ADR_STREETS(j).EFF_DT,
                      A.END_DT           =  l_ADR_STREETS(j).END_DT
                  where A.STREET_ID = l_ADR_STREETS(j).STREET_ID
                  log errors INTO ERR$_ADR_STREETS
                    ('UPDATE') reject LIMIT unlimited;


                 if sql%rowcount = 0 then
                  INSERT INTO ADR_STREETS(street_id,
                                          street_name,
                                          street_name_ru,
                                          street_type,
                                          settlement_id,
                                          eff_dt,
                                          end_dt
                                          )
                  VALUES (  l_ADR_STREETS(j).street_id,
                            l_ADR_STREETS(j).street_name,
                            l_ADR_STREETS(j).street_name_ru,
                            l_ADR_STREETS(j).street_type,
                            l_ADR_STREETS(j).settlement_id,
                            l_ADR_STREETS(j).eff_dt,
                            l_ADR_STREETS(j).end_dt
                   )
                     log errors INTO ERR$_ADR_STREETS
                    ('INSERT') reject LIMIT unlimited;

                 end if;
               end loop;
             END;
           end if;
     BEGIN
       SELECT count(*) into p_err_loc  from  ERR$_ADR_STREETS;
       p_err:=p_err+p_err_loc;
       if p_err_loc> 0 then
         p_message:=p_message||'ERR$_ADR_STREETS'||'; ';
       end if;
     END;

    --очистка,якщо виникли помилки
    l_ADR_STREETS.delete();
    l_ADR_STREETS := NULL;

  elsif l_table_name = 'ADR_HOUSES' then
          --формируем список строк
          l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,l_table_name);
          FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
          LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_ADR_HOUSES.extend;

             dbms_xslprocessor.valueof(l_row, 'HOUSE_ID/text()', l_str);
             l_ADR_HOUSES(l_ADR_HOUSES.last).house_id   := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'STREET_ID/text()', l_str);
             l_ADR_HOUSES(l_ADR_HOUSES.last).street_id   := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'SPIU_DISTRICT_ID/text()', l_str);
             l_ADR_HOUSES(l_ADR_HOUSES.last).district_id   := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'HOUSE_NUM/text()', l_str);
             l_ADR_HOUSES(l_ADR_HOUSES.last).house_num   := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'HOUSE_NUM_ADD/text()', l_str);
             l_ADR_HOUSES(l_ADR_HOUSES.last).house_num_add   := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'POSTAL_CODE/text()', l_str);
             l_ADR_HOUSES(l_ADR_HOUSES.last).postal_code   := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'LATITUDE/text()', l_str);
             l_ADR_HOUSES(l_ADR_HOUSES.last).latitude   := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'LONGITUDE/text()', l_str);
             l_ADR_HOUSES(l_ADR_HOUSES.last).longitude   := trim(l_str);

           END LOOP;

             BEGIN
               EXECUTE IMMEDIATE ' delete from  ERR$_ADR_HOUSES';
             END;

             if l_ADR_HOUSES IS NOT EMPTY then
              --обновление данных
              BEGIN
                FOR j IN l_ADR_HOUSES.first .. l_ADR_HOUSES.last
                loop
                  insert into ADR_HOUSES_HIST select S_ADR_HOUSES_HIST.NEXTVAL,sysdate,A.* from ADR_HOUSES A where a.house_id=l_ADR_HOUSES(j).house_id;


                  UPDATE ADR_HOUSES A
                  set A.STREET_ID     =  l_ADR_HOUSES(j).STREET_ID,
                      --A.DISTRICT_ID   =  l_ADR_HOUSES(j).DISTRICT_ID,
                      A.DISTRICT_ID   = (select r.district_id  from ADR_CITY_DISTRICTS r,
                                                                    Adr_Streets        s
                                          where s.street_id        = l_ADR_HOUSES(j).STREET_ID
                                            and s.settlement_id    = r.settlement_id
                                            and r.spiu_district_id = l_ADR_HOUSES(j).DISTRICT_ID),
                      A.HOUSE_NUM     =  l_ADR_HOUSES(j).HOUSE_NUM,
                      A.HOUSE_NUM_ADD =  l_ADR_HOUSES(j).HOUSE_NUM_ADD,
                      A.POSTAL_CODE   =  l_ADR_HOUSES(j).POSTAL_CODE,
                      A.LATITUDE      =  l_ADR_HOUSES(j).LATITUDE,
                      A.LONGITUDE     =  l_ADR_HOUSES(j).LONGITUDE
                  where A.HOUSE_ID = l_ADR_HOUSES(j).HOUSE_ID
                  log errors INTO ERR$_ADR_HOUSES
                    ('UPDATE') reject LIMIT unlimited;



                 if sql%rowcount = 0 then
                  INSERT INTO ADR_HOUSES( HOUSE_ID,
                                          STREET_ID,
                                          DISTRICT_ID,
                                          HOUSE_NUM,
                                          HOUSE_NUM_ADD,
                                          POSTAL_CODE,
                                          LATITUDE,
                                          LONGITUDE
                                        )
                  VALUES (  l_ADR_HOUSES(j).HOUSE_ID,
                            l_ADR_HOUSES(j).STREET_ID,
                            /*l_ADR_HOUSES(j).DISTRICT_ID*/
                            (select r.district_id  from ADR_CITY_DISTRICTS r,
                                                        Adr_Streets        s
                            where s.street_id        = l_ADR_HOUSES(j).STREET_ID
                              and s.settlement_id    = r.settlement_id
                              and r.spiu_district_id = l_ADR_HOUSES(j).DISTRICT_ID),
                            l_ADR_HOUSES(j).HOUSE_NUM,
                            l_ADR_HOUSES(j).HOUSE_NUM_ADD,
                            l_ADR_HOUSES(j).POSTAL_CODE,
                            l_ADR_HOUSES(j).LATITUDE,
                            l_ADR_HOUSES(j).LONGITUDE
                          )
                     log errors INTO ERR$_ADR_HOUSES
                    ('INSERT') reject LIMIT unlimited;
                 end if;
               end loop;
             END;
           end if;
     BEGIN
       SELECT count(*) into p_err_loc  from  ERR$_ADR_HOUSES;
       p_err:=p_err+p_err_loc;
       if p_err_loc> 0 then
         p_message:=p_message||'ERR$_ADR_HOUSES'||'; ';
       end if;
     END;

    --очистка,якщо виникли помилки
    l_ADR_HOUSES.delete();
    l_ADR_HOUSES := NULL;

   elsif l_table_name = 'ADR_PHONE_CODES' then

          --формируем список строк
          l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,l_table_name);
          FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
          LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_ADR_PHONE_CODES.extend;

             dbms_xslprocessor.valueof(l_row, 'PHONE_CODE_ID/text()', l_str);
             l_ADR_PHONE_CODES(l_ADR_PHONE_CODES.last).phone_code_id    := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'PHONE_CODE/text()', l_str);
             l_ADR_PHONE_CODES(l_ADR_PHONE_CODES.last).phone_code    := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'PHONE_ADD_NUM/text()', l_str);
             l_ADR_PHONE_CODES(l_ADR_PHONE_CODES.last).phone_add_num    := trim(l_str);

           END LOOP;

             BEGIN
               EXECUTE IMMEDIATE ' delete from  ERR$_ADR_PHONE_CODES';
             END;


             if l_ADR_PHONE_CODES IS NOT EMPTY then
              --обновление данных
              BEGIN
                FOR j IN l_ADR_PHONE_CODES.first .. l_ADR_PHONE_CODES.last
                loop
                  insert into ADR_PHONE_CODES_HIST select S_ADR_PHONE_CODES_HIST.NEXTVAL,sysdate,A.* from ADR_PHONE_CODES A where a.phone_code_id=l_ADR_PHONE_CODES(j).phone_code_id;

                  UPDATE ADR_PHONE_CODES A
                  set A.PHONE_CODE      =  l_ADR_PHONE_CODES(j).PHONE_CODE,
                      A.PHONE_ADD_NUM   =  l_ADR_PHONE_CODES(j).PHONE_ADD_NUM
                  where A.PHONE_CODE_ID = l_ADR_PHONE_CODES(j).PHONE_CODE_ID
                  log errors INTO ERR$_ADR_PHONE_CODES
                    ('UPDATE') reject LIMIT unlimited;

                 if sql%rowcount = 0 then
                  INSERT INTO ADR_PHONE_CODES( phone_code_id ,
                                               phone_code ,
                                               phone_add_num
                                             )
                  VALUES (  l_ADR_PHONE_CODES(j).phone_code_id ,
                            l_ADR_PHONE_CODES(j).phone_code ,
                            l_ADR_PHONE_CODES(j).phone_add_num
                          )
                     log errors INTO ERR$_ADR_PHONE_CODES
                    ('INSERT') reject LIMIT unlimited;

                 end if;
               end loop;
             END;
           end if;
     BEGIN
       SELECT count(*) into p_err_loc  from  ERR$_ADR_PHONE_CODES;
       p_err:=p_err+p_err_loc;
       if p_err_loc> 0 then
         p_message:=p_message||'ERR$_ADR_PHONE_CODES'||'; ';
       end if;
     END;

    --очистка,якщо виникли помилки
    l_ADR_PHONE_CODES.delete();
    l_ADR_PHONE_CODES := NULL;

     end if;
    --  dbms_output.put_line(dbms_xmldom.getlength(l_rowlist));

   END LOOP;

  --   dbms_output.put_line(dbms_xmldom.getlength(l_tablelist));
   --  dbms_output.put_line('Attrs: '||l_sattrs);

    dbms_xmlparser.freeparser(l_parser);
    dbms_xmldom.freedocument(l_doc);


  END p_xml_parse;



   --РУ ищет свой последний загруженный файл
  procedure find_max_files(p_fileid    out ADR_RU_FILES.ID%type) is

  title        varchar2(100) := 'pkg_adr_synch.find_max_files. ';

  begin
  bars_audit.info(title || 'Start.');
   begin
     select nvl(max(AA.ID),0)
     into   p_fileid
       from ADR_RU_FILES AA;
/*   exception when NO_DATA_FOUND then
                  p_fileid:=0;  */
   end;

  bars_audit.info(title || 'Find max file: = '||p_fileid);

  end;


   --ЦА возвращает нужный РУ файл (эта процедура вызывается вебсервисом на стороне ЦА )
  procedure response_files(p_fileid        in ADR_CA_FILES.ID%type, --РУ передает свой последний загруженный
                           p_request_mfo   in varchar2,
                           p_file_data      out clob) is  --ЦА возвращает следующий после максимального для РУ

    p_fileid_REQ    ADR_CA_FILES.ID%type;
    p_file_data_REQ blob;
    title           varchar2(100) := 'pkg_adr_synch.request_files. ';
  begin
  bars_audit.info(title || 'Start.');
   begin
     select AA.FILE_DATA, AA.ID
     into   p_file_data_REQ,  p_fileid_REQ
       from ADR_CA_FILES AA
      where AA.ID =(select min(a.id) from ADR_CA_FILES A where a.id > p_fileid);
   exception when NO_DATA_FOUND then
                  null;
             when others then
                   bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                              chr(10) || dbms_utility.format_error_backtrace() );
   end;
   if p_fileid_REQ is not null then
     insert into ADR_CA_FILES_TRACK (id,state,message,sign,ddate ,request_mfo ,id_file )
     values (S_ADR_CA_FILES_TRACK.NEXTVAL,0,null,null,sysdate,p_request_mfo,p_fileid_REQ);

    p_file_data:= pfu_encode_base64(p_file_data_REQ);

   end if;
  bars_audit.info(title || 'Finish. ');

  end;

  ----пишем в талицу фалов РУ
  procedure import_files(p_fileid    in number,
                         p_sign      in raw default null,
                         p_file_data in clob,
                         p_state     out number) is
    l_filetype  number;
    l_tmpb      blob;
    l_file_data clob;
    l_warning    integer;
    l_dest_offset integer := 1;
    l_src_offset integer := 1;
    l_blob_csid number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;

    title        varchar2(100) := 'pkg_adr_synch.import_files. ';
  begin

      bars_audit.info(title || 'Start. Fileid=' || p_fileid);
      insert into adr_ru_files
        (id, file_data, state, sign , ddate  )
      values
        (p_fileid, p_file_data, 0, p_sign, sysdate);

      p_state   := 0;
      bars_audit.info(title || 'File written. Fileid=' || p_fileid);

  exception
    when dup_val_on_index then
      p_state   := 1;
    when others then
      p_state   := 99;
     bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                              chr(10) || dbms_utility.format_error_backtrace() );

  end;


  --РУ обрабатывает файл
  procedure processing_files is

    title        varchar2(100) := 'pkg_adr_synch.processing_filesis. ';
    l_err        number(10);
    l_state      ADR_RU_FILES.STATE%TYPE:=1;
    p_message    VARCHAR2(4000);
  begin
  bars_audit.info(title || 'Start. ');
    for cur in (select * from  ADR_RU_FILES F where f.state<>1 order by f.id)
    loop
      p_xml_parse(p_file_id  => cur.id,
                  p_err      => l_err,
                  p_message  => p_message);

    if l_err>0 then l_state:=2; end if;
    update ADR_RU_FILES a
    set a.state   =l_state,
        a.message =p_message
    where a.id=cur.id;
    exit when  l_state <> 1; --если хоть один прошел неудачно, то прерываемся
    end loop;

  bars_audit.info(title || 'Finish. ');

  end;


  procedure prepare_transport_request(p_fileid       in ADR_RU_FILES.ID%type,
                                      p_our_endpoint in varchar2/*,
                                      p_receiver_endpoint in varchar2*/) is
    l_url         varchar2(4000 byte);
    l_wallet_path varchar2(4000 byte);
    l_wallet_pass varchar2(4000 byte);
  begin
    l_url         := getglobaloption('LINK_FOR_ABSBARS_WEBAPISERVICES');
    l_wallet_path := getglobaloption('TMS_WALLET_PATH');
    l_wallet_pass := getglobaloption('TMS_WALLET_PASS');

    bars.wsm_mgr.prepare_request(p_url          => l_url || p_our_endpoint,
                                 p_action       => null,
                                 p_http_method  => bars.wsm_mgr.G_HTTP_POST,
                                 p_content_type => bars.wsm_mgr.G_CT_XML,
                                 p_wallet_path  => l_wallet_path,
                                 p_wallet_pwd   => l_wallet_pass);

    bars.wsm_mgr.add_parameter(p_name  => 'p_fileid',p_value => to_char(p_fileid));
    bars.wsm_mgr.add_parameter(p_name  => 'p_mfo',p_value => to_char(sys_context('bars_gl', 'mfo')));
  end;


  procedure request_data (p_fileid    in  ADR_RU_FILES.ID%type) is
    l_response      bars.wsm_mgr.t_response;
    l_xml           xmltype;
    p_fileid_out    ADR_RU_FILES.ID%type;
    p_state         ADR_RU_FILES.STATE%type;
    p_file_data     blob;
    l_warning       integer;
    l_dest_offset   integer := 1;
    l_src_offset    integer := 1;
    l_blob_csid     number := dbms_lob.default_csid;
    l_lang_context  number := dbms_lob.default_lang_ctx;
    l_tmpb          blob;
    l_file_data     clob;
    title           varchar2(100) := 'pkg_adr_synch.send_data';
  begin
    bars_audit.info(title || 'Start. ');
    savepoint before_request;

    prepare_transport_request(p_fileid,'/pfuredirect/sendpackage');

    bars.wsm_mgr.execute_api(l_response);

    p_file_data := pfu_decode_base64(l_response.cdoc );


    l_tmpb      := utl_compress.lz_uncompress(p_file_data);

    dbms_lob.createtemporary(l_file_data, false);

    dbms_lob.converttoclob(dest_lob     => l_file_data,
                           src_blob     => l_tmpb,
                           amount       => dbms_lob.lobmaxsize,
                           dest_offset  => l_dest_offset,
                           src_offset   => l_src_offset,
                           blob_csid    => l_blob_csid,
                           lang_context => l_lang_context,
                           warning      => l_warning);

   l_xml := xmltype(l_file_data);


/*    select t.am.extract('root/@FILE_ID').getstringval()
    into
    p_fileid_out
    from(
    select l_xml am from dual
    ) t;*/

   p_fileid_out:=l_xml.extract('root/@FILE_ID').getstringval();

   if p_fileid_out is not null then
     import_files(p_fileid     => p_fileid_out,
                  p_sign       => null,
                  p_file_data  => l_file_data,
                  p_state      => p_state);
   end if;
  exception
    when others then
      bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                              chr(10) || dbms_utility.format_error_backtrace() );
      rollback to before_request;
  bars_audit.info(title || 'Finish. ');
  end;

  --запрос и обработка файлов
  procedure update_data is

    p_fileid     ADR_RU_FILES.ID%type;
    title        varchar2(100) := 'pkg_adr_synch.update_data. ';

  begin
  bars_audit.info(title || 'Start. ');
  --ищем максимальный принятый
  find_max_files(p_fileid);

  --запрос на новый файл. В случае получения пишем в adr_ru_files
  request_data(p_fileid);

  --обрабатываем файлы из adr_ru_files
  pkg_adr_synch.processing_files;

  bars_audit.info(title || 'Finish. ');

  end;


begin
  -- Initialization
  null;
END pkg_adr_synch;

/