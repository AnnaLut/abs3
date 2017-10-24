

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SETTABROLE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SETTABROLE ***

  CREATE OR REPLACE PROCEDURE BARS.SETTABROLE ( table_name VARCHAR2, role_name VARCHAR2, sem VARCHAR2, dlg_name VARCHAR2 DEFAULT NULL ) IS

tab_cnt  NUMBER;
tab_id   NUMBER;

  FUNCTION FIND_FREE RETURN NUMBER IS
  cur_n	   NUMBER;
  found	   BOOLEAN;
  temp	   NUMBER;
  BEGIN
    cur_n := 0;
	  found := FALSE;
    WHILE NOT found LOOP
	    cur_n := cur_n + 1;
	    BEGIN
	      SELECT tabid INTO temp FROM meta_tables WHERE tabid=cur_n;
  	  EXCEPTION
	      WHEN NO_DATA_FOUND THEN
		      found := TRUE;
  	  END;
	  END LOOP;
  	RETURN cur_n;
  END;

BEGIN
  BEGIN
    SELECT tabid INTO tab_id FROM meta_tables WHERE UPPER(tabname)=UPPER(table_name);
    BEGIN
      SELECT tabid INTO tab_id FROM references WHERE tabid=tab_id;
      --Updating role
      UPDATE references SET
        role2edit=role_name
        WHERE tabid=tab_id;
      IF dlg_name IS NOT NULL THEN
        UPDATE references SET
          dlgname=dlg_name
          WHERE tabid=tab_id;
      END IF;
      DBMS_OUTPUT.PUT_LINE( 'Справочник <' || sem || '> обновлен!' );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
      BEGIN
        --Inserting into REFERENCES
        INSERT INTO references ( tabid, dlgname, role2edit )
          VALUES ( tab_id, role_name, dlg_name );
        DBMS_OUTPUT.PUT_LINE( 'Справочник <' || sem || '> добавлен!' );
      END;
    END;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
    BEGIN
      --Inserting into REFERENCES and META_TABLES
      tab_id := FIND_FREE;

      INSERT INTO meta_tables ( tabid, tabname, semantic )
        VALUES ( tab_id, UPPER(table_name), sem );
      DBMS_OUTPUT.PUT_LINE( 'Таблица <' || table_name || '> добавлена!' );

      INSERT INTO references ( tabid, dlgname, role2edit )
        VALUES ( tab_id, role_name, dlg_name );
      DBMS_OUTPUT.PUT_LINE( 'Справочник <' || sem || '> добавлен!' );
    END;
  END;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SETTABROLE.sql =========*** End **
PROMPT ===================================================================================== 
