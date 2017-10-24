

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/W4_R_IICFILES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure W4_R_IICFILES ***

  CREATE OR REPLACE PROCEDURE BARS.W4_R_IICFILES (p_type in int) -- 0 R)IIC, 1 - OIC
is
    v_lob clob;
    v_offset number := 1;
    v_file bfile;
    v_lob_length number;
    nId number;
    sErr varchar2(1000);
    l_clob         clob;
    l_clob2        clob;
    l_lob_size     number;
    l_mask varchar2(30);
    l_id int;
    l_offset       number := 1;
    l_resp         clob;
    l_warning      integer;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;
    l_blob         blob;
begin
    l_mask := case when p_type = 0 then 'R_IIC%'
                   when p_type = 1 then 'OIC%'
                   when p_type = 2 then 'OIC_ATRANSFERS%'
              end;
    get_dir_list( '/u02/upl/net/mmfo/r_iic_doc' );
    for k in (SELECT FILENAME FROM TMP_WAY4_LIST where filename like l_mask)
    loop
        v_file := bfilename('R_IIC_DOCUMENTS',k.filename);
        dbms_lob.fileopen(v_file);
        v_lob_length := dbms_lob.getlength(v_file);
        bars_audit.info('W4_R_IICFILES:'||v_lob_length);
        if (v_lob_length >0 )
        then
            dbms_lob.createtemporary(v_lob,TRUE);
            dbms_lob.createtemporary(l_blob, false);
            dbms_lob.loadfromfile(v_lob,v_file,v_lob_length);

            select max(id) +1
              into l_id
              from ow_files;
              
            dbms_lob.converttoblob(dest_lob     => l_blob,
                                       src_clob     => v_lob,
                                       amount       => dbms_lob.lobmaxsize,
                                       dest_offset  => l_dest_offset,
                                       src_offset   => l_src_offset,
                                       blob_csid    => l_blob_csid,
                                       lang_context => l_lang_context,
                                       warning      => l_warning); 
                          
            l_blob := utl_compress.lz_compress(l_blob);
            
            begin
            insert into ow_impfile (ID, FILE_BLOB) values (l_id, l_blob);
            exception when others then bars_audit.info('W4_R_IICFILES:'||sqlerrm);
            end;
            commit;
            dbms_lob.fileclose(v_file);

            bars_ow.import_file(k.filename, l_id, sErr);
            if (l_id is not null)
            then
             p_job_w4importfiles(l_id);
            end if;
        end if;
    end loop;

end;
/
show err;

PROMPT *** Create  grants  W4_R_IICFILES ***
grant EXECUTE                                                                on W4_R_IICFILES   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/W4_R_IICFILES.sql =========*** End
PROMPT ===================================================================================== 
