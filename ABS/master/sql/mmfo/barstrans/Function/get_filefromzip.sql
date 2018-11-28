create or replace function get_filefromzip(p_zipped_blob blob) return blob is
     t_tmp    blob;
     t_ind    integer;
     t_hd_ind integer;
     t_fl_ind integer;
     t_len    integer;
     c_END_OF_CENTRAL_DIRECTORY constant raw(4) := hextoraw('504B0506'); -- End of central directory signature for zip
     function blob2num(p_blob blob, p_len integer, p_pos integer) return number is
         rv number;
     begin
         rv := utl_raw.cast_to_binary_integer(dbms_lob.substr(p_blob,
                                                              p_len,
                                                              p_pos),
                                              utl_raw.little_endian);
         if rv < 0 then
             rv := rv + 4294967296;
         end if;
         return rv;
     end;
     --little_endian------------------------------------------------------------------------------
     function little_endian(p_big number, p_bytes pls_integer := 4) return raw is
         t_big number := p_big;
     begin
         if t_big > 2147483647 then
             t_big := t_big - 4294967296;
         end if;
         return utl_raw.substr(utl_raw.cast_from_binary_integer(t_big,
                                                                utl_raw.little_endian),
                               1,
                               p_bytes);
     end;
 
 begin
     t_ind := nvl(dbms_lob.getlength(p_zipped_blob), 0) - 21;
     loop
         exit when t_ind < 1 or dbms_lob.substr(p_zipped_blob, 4, t_ind) = c_end_of_central_directory;
         t_ind := t_ind - 1;
     end loop;
     --
     if t_ind <= 0 then
         return null;
     end if;
     --
     t_hd_ind := blob2num(p_zipped_blob, 4, t_ind + 16) + 1;
     for i in 1 .. blob2num(p_zipped_blob, 2, t_ind + 8) loop
         t_len := blob2num(p_zipped_blob, 4, t_hd_ind + 24); -- uncompressed length
         if t_len = 0 then
             -- empty file
             return empty_blob();
         end if;
         --
         if dbms_lob.substr(p_zipped_blob, 2, t_hd_ind + 10) in
            (hextoraw('0800') -- deflate
            ,
             hextoraw('0900') -- deflate64
             ) then
             t_fl_ind := blob2num(p_zipped_blob, 4, t_hd_ind + 42);
             t_tmp    := hextoraw('1F8B0800000000000003'); -- gzip header
             dbms_lob.copy(t_tmp,
                           p_zipped_blob,
                           blob2num(p_zipped_blob, 4, t_hd_ind + 20),
                           11,
                           t_fl_ind + 31 +
                           blob2num(p_zipped_blob, 2, t_fl_ind + 27) -- File name length
                           + blob2num(p_zipped_blob, 2, t_fl_ind + 29) -- Extra field length
                           );
             dbms_lob.append(t_tmp,
                             utl_raw.concat(dbms_lob.substr(p_zipped_blob,
                                                            4,
                                                            t_hd_ind + 16) -- CRC32
                                           ,
                                            little_endian(t_len) -- uncompressed length
                                            ));
             return utl_compress.lz_uncompress(t_tmp);
         end if;
         --
         if dbms_lob.substr(p_zipped_blob, 2, t_hd_ind + 10) =
            hextoraw('0000') -- The file is stored (no compression)
          then
             t_fl_ind := blob2num(p_zipped_blob, 4, t_hd_ind + 42);
             dbms_lob.createtemporary(t_tmp, true);
             dbms_lob.copy(t_tmp,
                           p_zipped_blob,
                           t_len,
                           1,
                           t_fl_ind + 31 +
                           blob2num(p_zipped_blob, 2, t_fl_ind + 27) -- File name length
                           + blob2num(p_zipped_blob, 2, t_fl_ind + 29) -- Extra field length
                           );
             return t_tmp;
         end if;
         t_hd_ind := t_hd_ind + 46 +
                     blob2num(p_zipped_blob, 2, t_hd_ind + 28) -- File name length
                     + blob2num(p_zipped_blob, 2, t_hd_ind + 30) -- Extra field length
                     + blob2num(p_zipped_blob, 2, t_hd_ind + 32); -- File comment length
     end loop;
     --
     return null;
 end;
/
