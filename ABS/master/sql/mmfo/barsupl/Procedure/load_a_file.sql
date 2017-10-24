

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Procedure/LOAD_A_FILE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure LOAD_A_FILE ***

  CREATE OR REPLACE PROCEDURE BARSUPL.LOAD_A_FILE 
   ( p_dir_name   VARCHAR2,
     p_file_name  VARCHAR2,
     p_tip        VARCHAR2
   ) IS
  l_bfile   BFILE;
  l_clob    CLOB;
  l_blob    BLOB;
  l_len     NUMBER;
BEGIN
   l_bfile := BFILENAME(p_dir_name, p_file_name);
   IF (dbms_lob.fileexists(l_bfile) = 1) THEN
      l_len := dbms_lob.getlength(l_bfile);
      dbms_output.put_line('File Exists');
      case upper(p_tip)
         when 'CLOB' then
              INSERT INTO tmp_clob_file(filename, load_date, len, text)
                VALUES (p_file_name, 
                        sysdate, 
                        l_len,
                        EMPTY_CLOB()
              ) RETURN text INTO l_clob;
              --L_BFILE := bfilename(p_dir_name, p_file_name);
              dbms_lob.fileopen( l_bfile, dbms_lob.FILE_READONLY );
              dbms_lob.loadfromfile( l_clob, l_bfile, dbms_lob.getlength(l_bfile) );
              dbms_lob.fileclose( l_bfile );
         when 'BLOB' then
              INSERT INTO tmp_clob_file(filename, load_date, len, bin)
                VALUES (p_file_name, 
                        sysdate, 
                        l_len,
                        EMPTY_BLOB()
              ) RETURN bin INTO l_blob;
              --L_BFILE := bfilename(p_dir_name, p_file_name);
              dbms_lob.fileopen( l_bfile, dbms_lob.FILE_READONLY );
              dbms_lob.loadfromfile( l_blob, l_bfile, dbms_lob.getlength(l_bfile) );
              dbms_lob.fileclose( l_bfile );
         when 'BFILE' then
              INSERT INTO tmp_clob_file(filename, load_date, len, bf)
                VALUES (p_file_name, 
                        sysdate, 
                        l_len,
                        l_bfile
              );
         else
              raise_application_error (-20000,'Не определен тип данных. Передан ' || upper(p_tip) || '. Возможные значения CLOB, BLOB, BFILE.');
      end case;
   ELSE 
      INSERT INTO tmp_clob_file(filename, load_date)
        VALUES (p_file_name || ' in ' || p_dir_name || ' does not exist' , 
                sysdate
      ) RETURN bin INTO l_blob;

     dbms_output.put_line('File does not exist');

   END IF;   
   COMMIT;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Procedure/LOAD_A_FILE.sql =========*** En
PROMPT ===================================================================================== 
