
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_zay_rtf_rar.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ZAY_RTF_RAR (p_dat1 date
                                         ,p_dat2 date)
                                          return blob
as

  l_blob blob;
  function little_endian( p_big number, p_bytes pls_integer := 4 )
  return raw
  is
  begin
    return utl_raw.substr( utl_raw.cast_from_binary_integer( p_big, utl_raw.little_endian ), 1, p_bytes );
  end;

 procedure add1file
    ( p_zipped_blob in out nocopy blob
    , p_name varchar2
    , p_content blob
    )
  is
    t_now date;
    t_blob blob;
    t_clen integer;
  begin
    t_now := sysdate;
    t_blob := utl_compress.lz_compress( p_content );
    t_clen := dbms_lob.getlength( t_blob );
    if p_zipped_blob is null
    then
      dbms_lob.createtemporary( p_zipped_blob, true );
    end if;
    dbms_lob.append( p_zipped_blob
                   , utl_raw.concat( hextoraw( '504B0304' ) -- Local file header signature
                                   , hextoraw( '1400' )     -- version 2.0
                                   , hextoraw( '0000' )     -- no General purpose bits
                                   , hextoraw( '0800' )     -- deflate
                                   , little_endian( to_number( to_char( t_now, 'ss' ) ) / 2
                                                  + to_number( to_char( t_now, 'mi' ) ) * 32
                                                  + to_number( to_char( t_now, 'hh24' ) ) * 2048
                                                  , 2
                                                  ) -- File last modification time
                                   , little_endian( to_number( to_char( t_now, 'dd' ) )
                                                  + to_number( to_char( t_now, 'mm' ) ) * 32
                                                  + ( to_number( to_char( t_now, 'yyyy' ) ) - 1980 ) * 512
                                                  , 2
                                                  ) -- File last modification date
                                   , dbms_lob.substr( t_blob, 4, t_clen - 7 )         -- CRC-32
                                   , little_endian( t_clen - 18 )                     -- compressed size
                                   , little_endian( dbms_lob.getlength( p_content ) ) -- uncompressed size
                                   , little_endian( length( p_name ), 2 )             -- File name length
                                   , hextoraw( '0000' )                               -- Extra field length
                                   , utl_raw.cast_to_raw( p_name )                    -- File name
                                   )
                   );
    dbms_lob.copy( p_zipped_blob, t_blob, t_clen - 18, dbms_lob.getlength( p_zipped_blob ) + 1, 11 ); -- compressed content
    dbms_lob.freetemporary( t_blob );
  end;
--
  procedure finish_zip( p_zipped_blob in out nocopy blob )
  is
    t_cnt pls_integer := 0;
    t_offs integer;
    t_offs_dir_header integer;
    t_offs_end_header integer;
    t_comment raw(32767) := utl_raw.cast_to_raw( 'Rar-implementation by Unity-BARS'||chr(13)||chr(10)||' www.unity-bars.com' );
  begin
    t_offs_dir_header := dbms_lob.getlength( p_zipped_blob );
    t_offs := dbms_lob.instr( p_zipped_blob, hextoraw( '504B0304' ), 1 );
    while t_offs > 0
    loop
      t_cnt := t_cnt + 1;
      dbms_lob.append( p_zipped_blob
                     , utl_raw.concat( hextoraw( '504B0102' )      -- Central directory file header signature
                                     , hextoraw( '1400' )          -- version 2.0
                                     , dbms_lob.substr( p_zipped_blob, 26, t_offs + 4 )
                                     , hextoraw( '0000' )          -- File comment length
                                     , hextoraw( '0000' )          -- Disk number where file starts
                                     , hextoraw( '0100' )          -- Internal file attributes
                                     , hextoraw( '2000B681' )      -- External file attributes
                                     , little_endian( t_offs - 1 ) -- Relative offset of local file header
                                     , dbms_lob.substr( p_zipped_blob
                                                      , utl_raw.cast_to_binary_integer( dbms_lob.substr( p_zipped_blob, 2, t_offs + 26 ), utl_raw.little_endian )
                                                      , t_offs + 30
                                                      )            -- File name
                                     )
                     );
      t_offs := dbms_lob.instr( p_zipped_blob, hextoraw( '504B0304' ), t_offs + 32 );
    end loop;
    t_offs_end_header := dbms_lob.getlength( p_zipped_blob);
    if nvl(t_offs_end_header,0) = 0 then null;
        else
            dbms_lob.append( p_zipped_blob
                           , utl_raw.concat( hextoraw( '504B0506' )                                    -- End of central directory signature
                                           , hextoraw( '0000' )                                        -- Number of this disk
                                           , hextoraw( '0000' )                                        -- Disk where central directory starts
                                           , little_endian( t_cnt, 2 )                                 -- Number of central directory records on this disk
                                           , little_endian( t_cnt, 2 )                                 -- Total number of central directory records
                                           , little_endian( t_offs_end_header - t_offs_dir_header )    -- Size of central directory
                                           , little_endian( t_offs_dir_header )                        -- Relative offset of local file header
                                           , little_endian( nvl( utl_raw.length( t_comment ), 0 ), 2 ) -- ZIP file comment length
                                           , t_comment
                                           )
                           );
   end if;
  end;



begin

for x in (
             Select ref, 'card_'||tt||'('||ref||').rtf' filename, v.pdat, doc_desc
               from v_corp2_docs v
              where v.kv != 980 and v.pdat between p_dat1 and p_dat2+1
            )
     LOOP
     add1file(l_blob, x.filename, x.doc_desc );
     END LOOP;

 finish_zip(l_blob);

 return l_blob;


end;
/
 show err;
 
PROMPT *** Create  grants  F_ZAY_RTF_RAR ***
grant EXECUTE                                                                on F_ZAY_RTF_RAR   to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_zay_rtf_rar.sql =========*** End 
 PROMPT ===================================================================================== 
 