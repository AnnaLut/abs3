
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/file_utl.sql =========*** Run
 PROMPT ===================================================================================== 
 
create or replace package BARSTRANS.file_utl is

  -- Author  : VITALII.KHOMIDA
  -- Created : 08.02.2017 15:38:27
  -- Purpose :

  function decode_base64(p_clob_in in clob) return blob;
  function encode_base64(p_blob_in in blob) return clob;
  
  function get_md5(p_src in raw) return raw;

  function get_md5(p_src in blob) return raw;

  function get_md5(p_src in clob) return raw; 
  
  function check_hash(p_src  in raw,
                      p_hash in raw) return boolean;

  function check_hash(p_src  in blob,
                      p_hash in raw) return boolean;

  function check_hash(p_src  in clob,
                      p_hash in raw) return boolean;  
  
end;
/
grant execute on BARSTRANS.file_utl to BARS;
grant execute on BARSTRANS.file_utl to BARS_ACCESS_DEFROLE;
/

create or replace package body file_utl is

  function decode_base64(p_clob_in in clob) return blob is
    v_blob           blob;
    v_result         blob;
    v_offset         integer;
    v_buffer_size    binary_integer := 48;
    v_buffer_varchar varchar2(48);
    v_buffer_raw     raw(48);
  begin
    if p_clob_in is null then
      return null;
    end if;

    dbms_lob.createtemporary(v_blob, true);
    v_offset := 1;

    for i in 1 .. ceil(dbms_lob.getlength(p_clob_in) / v_buffer_size)
    loop
      dbms_lob.read(p_clob_in, v_buffer_size, v_offset, v_buffer_varchar);
      v_buffer_raw := utl_raw.cast_to_raw(v_buffer_varchar);
      v_buffer_raw := utl_encode.base64_decode(v_buffer_raw);
      dbms_lob.writeappend(v_blob,
                           utl_raw.length(v_buffer_raw),
                           v_buffer_raw);
      v_offset := v_offset + v_buffer_size;
    end loop;

    v_result := v_blob;
    dbms_lob.freetemporary(v_blob);

    return v_result;
  end;

  function encode_base64(p_blob_in in blob) return clob is
    v_clob           clob;
    v_result         clob;
    v_offset         integer;
    v_chunk_size     binary_integer := (48 / 4) * 3;
    v_buffer_varchar varchar2(48);
    v_buffer_raw     raw(48);
  begin
    if p_blob_in is null then
      return null;
    end if;
    dbms_lob.createtemporary(v_clob, true);
    v_offset := 1;
    for i in 1 .. ceil(dbms_lob.getlength(p_blob_in) / v_chunk_size)
    loop
      dbms_lob.read(p_blob_in, v_chunk_size, v_offset, v_buffer_raw);
      v_buffer_raw     := utl_encode.base64_encode(v_buffer_raw);
      v_buffer_varchar := utl_raw.cast_to_varchar2(v_buffer_raw);
      dbms_lob.writeappend(v_clob,
                           length(v_buffer_varchar),
                           v_buffer_varchar);
      v_offset := v_offset + v_chunk_size;
    end loop;
  
    v_result := v_clob;
    dbms_lob.freetemporary(v_clob);
    return v_result;
  end;
  
  function get_md5(p_src in raw) return raw is
  begin
    return dbms_crypto.hash(p_src, dbms_crypto.hash_md5);
  end;
  
  function get_md5(p_src in blob) return raw is
  begin
    return dbms_crypto.hash(p_src, dbms_crypto.hash_md5);
  end;
  
  function get_md5(p_src in clob) return raw is
  begin
    return dbms_crypto.hash(p_src, dbms_crypto.hash_md5);
  end;
  
  function check_hash(p_src  in raw,
                      p_hash in raw) return boolean is
  begin
    if get_md5(p_src) = p_hash then
      return true;
    else
      return false;
    end if;
  
  exception
    when others then
      return false;
  end;
  
  function check_hash(p_src  in blob,
                      p_hash in raw) return boolean is
  begin
    if get_md5(p_src) = p_hash then
      return true;
    else
      return false;
    end if;
  
  exception
    when others then
      return false;
  end;

  function check_hash(p_src  in clob,
                      p_hash in raw) return boolean is
  begin
    if get_md5(p_src) = p_hash then
      return true;
    else
      return false;
    end if;
  
  exception
    when others then
      return false;
  end;
  
end file_utl;
/

 show err;
 
grant execute on BARSTRANS.file_utl to BARS;
grant execute on BARSTRANS.file_utl to BARS_ACCESS_DEFROLE; 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/file_utl.sql =========*** End
 PROMPT ===================================================================================== 
 