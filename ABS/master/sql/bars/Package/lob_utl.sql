CREATE OR REPLACE package BARS.lob_utl is

  function encode_base64(p_blob in blob) return clob;

  function decode_base64(p_clob_in in clob) return blob;

  function blob_to_clob(p_blob in blob) return clob;

  function clob_to_blob(p_clob in clob) return blob;

end;
/
CREATE OR REPLACE package body BARS.lob_utl is

  function encode_base64(p_blob in blob) return clob is
    l_clob           clob;
    l_result         clob;
    l_offset         integer;
    l_chunk_size     binary_integer := (48 / 4) * 3;
    l_buffer_varchar varchar2(48);
    l_buffer_raw     raw(48);
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
      dbms_lob.writeappend(l_clob, length(l_buffer_varchar), l_buffer_varchar);
      l_offset := l_offset + l_chunk_size;
    end loop;

    l_result := l_clob;
    dbms_lob.freetemporary(l_clob);

    return l_result;
  end;

  function decode_base64(p_clob_in in clob) return blob is
    l_blob           blob;
    l_result         blob;
    l_offset         integer;
    l_buffer_size    binary_integer := 48;
    l_buffer_varchar varchar2(48);
    l_buffer_raw     raw(48);
  begin
    if p_clob_in is null then
      return null;
    end if;

    dbms_lob.createtemporary(l_blob, false);
    l_offset := 1;

    for i in 1 .. ceil(dbms_lob.getlength(p_clob_in) / l_buffer_size) loop
      dbms_lob.read(p_clob_in, l_buffer_size, l_offset, l_buffer_varchar);
      l_buffer_raw := utl_raw.cast_to_raw(l_buffer_varchar);
      l_buffer_raw := utl_encode.base64_decode(l_buffer_raw);
      dbms_lob.writeappend(l_blob, utl_raw.length(l_buffer_raw), l_buffer_raw);
      l_offset := l_offset + l_buffer_size;
    end loop;

    l_result := l_blob;
    dbms_lob.freetemporary(l_blob);

    return l_result;
  end;

  function blob_to_clob(p_blob in blob) return clob is
    l_clob         clob;
    l_warning      integer;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;
  begin

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

  function clob_to_blob(p_clob in clob) return blob is
    l_blob         blob;
    l_warning      integer;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;
  begin

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
end;
/
grant execute on lob_utl to bars_access_defrole;
/