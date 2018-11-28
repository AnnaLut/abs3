create or replace package transp_lob is

  -- Author  : OLEKSANDR.IVANENKO
  -- Created : 13.06.2018 16:33:47
  -- Purpose : 
  
 function encode_base64(p_blob in blob) return clob;
 function decode_base64(p_clob_in in clob) return blob;
 function blob_to_clob(p_blob in blob) return clob;
 function clob_to_blob(p_clob in clob) return blob;
 function unpacking(p_body in blob, c_type varchar2 default 'GZIP') return blob;
 function packing(p_body in blob, c_type varchar2 default null) return blob;
  procedure req_to_data(p_req_body  in clob,
                       p_data_type in varchar2,
                       p_json2xml  in number,
                       p_pack_type in varchar2,
                       p_compress  in number,
                       p_base64    in number,
                       p_c_data    out nocopy clob,
                       p_b_data    out nocopy blob); 
 procedure data_to_req(p_c_data    in clob,
                       p_b_data    in blob,
                       p_data_type in varchar2,
                       p_xml2json  in number,
                       p_pack_type in varchar2,
                       p_compress  in number,
                       p_base64    in number,
                       p_req_body  out nocopy clob);

end transp_lob;
/
create or replace package body transp_lob is
 --encode_base64------------------------------------------------------------------------------
 function encode_base64(p_blob in blob) return clob is
            l_clob           clob;
            l_result         clob;
            l_offset         integer;
            l_chunk_size     binary_integer := 23808;
            l_buffer_varchar varchar2(32736);
            l_buffer_raw     raw(32736);
          begin
            if (p_blob is null) then
              return null;
            end if;

            dbms_lob.createtemporary(l_clob, false);

            l_offset := 1;
            for i in 1 .. ceil(dbms_lob.getlength(p_blob) / l_chunk_size) loop
              dbms_lob.read(p_blob, l_chunk_size, l_offset, l_buffer_raw);
              l_buffer_raw     := utl_encode.base64_encode(l_buffer_raw);
              l_buffer_varchar := utl_raw.cast_to_varchar2(l_buffer_raw);
              l_buffer_varchar :=regexp_replace(l_buffer_varchar, '\s', '');
              dbms_lob.writeappend(l_clob, length(l_buffer_varchar), l_buffer_varchar);
              l_offset := l_offset + l_chunk_size;
            end loop;

            l_result := l_clob;
            dbms_lob.freetemporary(l_clob);

            return l_result;
        end;
 --decode_base64------------------------------------------------------------------------------
 function decode_base64(p_clob_in in clob) return blob is
     l_blob           blob;
     l_result         blob;
     l_offset         integer;
     l_buffer_size    binary_integer := 29568;
     l_buffer_varchar varchar2(32736);
     l_buffer_raw     raw(32736);
 begin
     if p_clob_in is null then
         return null;
     end if;

     dbms_lob.createtemporary(l_blob, false);
     l_offset := 1;

     for i in 1 .. ceil(dbms_lob.getlength(p_clob_in) / l_buffer_size) loop
         dbms_lob.read(p_clob_in,
                       l_buffer_size,
                       l_offset,
                       l_buffer_varchar);
         l_buffer_raw := utl_raw.cast_to_raw(l_buffer_varchar);
         l_buffer_raw := utl_encode.base64_decode(l_buffer_raw);
         dbms_lob.writeappend(l_blob,
                              utl_raw.length(l_buffer_raw),
                              l_buffer_raw);
         l_offset := l_offset + l_buffer_size;
     end loop;

     l_result := l_blob;
     dbms_lob.freetemporary(l_blob);

     return l_result;
 end;
 --blob_to_clob-------------------------------------------------------------------------------
 function blob_to_clob(p_blob in blob) return clob is
     l_clob         clob;
     l_warning      integer;
     l_dest_offset  integer := 1;
     l_src_offset   integer := 1;
     l_blob_csid    number := dbms_lob.default_csid;
     l_lang_context number := dbms_lob.default_lang_ctx;
 begin
            if (p_blob is null) then
              return null;
            end if;
            
     dbms_lob.createtemporary(l_clob, false);

     dbms_lob.converttoclob(dest_lob     => l_clob,
                            src_blob     => p_blob,
                            amount       => dbms_lob.lobmaxsize,
                            dest_offset  => l_dest_offset,
                            src_offset   => l_src_offset,
                            blob_csid    => l_blob_csid,
                            lang_context => l_lang_context,
                            warning      => l_warning);
     return l_clob;
 end;
 --clob_to_blob-------------------------------------------------------------------------------
 function clob_to_blob(p_clob in clob) return blob is
     l_blob         blob;
     l_warning      integer;
     l_dest_offset  integer := 1;
     l_src_offset   integer := 1;
     l_blob_csid    number := dbms_lob.default_csid;
     l_lang_context number := dbms_lob.default_lang_ctx;
 begin
            if (p_clob is null) then
              return null;
            end if;
            
     dbms_lob.createtemporary(l_blob, false);

     dbms_lob.converttoblob(dest_lob     => l_blob,
                            src_clob     => p_clob,
                            amount       => dbms_lob.lobmaxsize,
                            dest_offset  => l_dest_offset,
                            src_offset   => l_src_offset,
                            blob_csid    => l_blob_csid,
                            lang_context => l_lang_context,
                            warning      => l_warning);
     return l_blob;
 end;
  --unpacking----------------------------------------------------------------------------------
  function unpacking(p_body in blob, c_type varchar2 default 'GZIP')
     return blob is
     l_blob blob;
 begin
     if p_body is not null and c_type = 'GZIP' then
         l_blob := utl_compress.lz_uncompress(p_body);
     elsif p_body is not null and c_type = 'ZIP' then
         l_blob := get_filefromzip(p_body);
     end if;
     return l_blob;
 end;
 --packing------------------------------------------------------------------------------------
 function packing(p_body in blob, c_type varchar2 default null) return blob is
     l_blob blob;
 begin
    if p_body is not null then
     l_blob := utl_compress.lz_compress(p_body);
    end if;
     return l_blob;
 end packing;
 
  procedure req_to_data(p_req_body  in clob,
                       p_data_type in varchar2,
                       p_json2xml  in number,
                       p_pack_type in varchar2,
                       p_compress  in number,
                       p_base64    in number,
                       p_c_data    out nocopy clob,
                       p_b_data    out nocopy blob) is
     l_clob clob;
     l_blob blob;
 begin
     if p_data_type = 'BLOB' then
         l_clob := transp_lob.blob_to_clob(transp_lob.decode_base64(p_req_body));
     else
         l_clob := p_req_body;
     end if;

     if p_base64 = 1 and p_json2xml = 0 then
         l_blob := transp_lob.decode_base64(l_clob);
     elsif p_compress = 1 then
         l_blob := transp_lob.clob_to_blob(l_clob);
     end if;

     if p_compress = 1 and p_json2xml = 0 then
         l_blob := unpacking(l_blob);
     end if;

     if (p_base64 = 1 or p_compress = 1) and p_json2xml = 0 then
         if p_data_type = 'CLOB' then
             p_c_data := transp_lob.blob_to_clob(l_blob);
             p_b_data := null;
         else
             p_c_data := null;
             p_b_data := l_blob;
         end if;
     else
         l_blob := transp_lob.clob_to_blob(l_clob);
         if p_data_type = 'CLOB' then
             p_c_data := l_clob;
             p_b_data := null;
         else
             p_c_data := null;
             p_b_data := transp_lob.clob_to_blob(l_clob);
         end if;
     end if;
 end;

 procedure data_to_req(p_c_data    in clob,
                       p_b_data    in blob,
                       p_data_type in varchar2,
                       p_xml2json  in number,
                       p_pack_type in varchar2,
                       p_compress  in number,
                       p_base64    in number,
                       p_req_body  out nocopy clob) is
     l_clob clob;
     l_blob blob;
 begin
     if p_compress = 1 and p_xml2json = 0 then
         if p_data_type = 'BLOB' then
             l_blob := packing(p_b_data);
         else
             l_blob := packing(transp_lob.clob_to_blob(p_c_data));
         end if;
     end if;

     if p_base64 = 1 and p_xml2json = 0 then
         if p_compress = 1 then
             l_clob := transp_lob.encode_base64(l_blob);
         elsif p_compress = 0 and p_data_type = 'BLOB' then
             l_clob := transp_lob.encode_base64(p_b_data);
         elsif p_compress = 0 and p_data_type = 'CLOB' then
             l_clob := transp_lob.encode_base64(transp_lob.clob_to_blob(p_c_data));
         end if;
     end if;

     if p_base64 = 1 and p_xml2json = 0 then
         p_req_body := l_clob;
     elsif p_base64 = 0 and p_compress = 1 and p_xml2json = 0 then
             p_req_body := transp_lob.blob_to_clob(l_blob);
     else
         if p_data_type = 'CLOB' then
             p_req_body := p_c_data;
         else
             p_req_body := transp_lob.blob_to_clob(p_b_data);
         end if;
     end if;
 end;
 
end transp_lob;
/
