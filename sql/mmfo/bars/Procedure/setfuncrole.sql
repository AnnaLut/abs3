

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SETFUNCROLE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SETFUNCROLE ***

  CREATE OR REPLACE PROCEDURE BARS.SETFUNCROLE ( func_name VARCHAR2, role_name VARCHAR2, sem VARCHAR2, full_name VARCHAR2 DEFAULT NULL ) IS

func_cnt  NUMBER;
func_id   NUMBER;

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
	      SELECT codeoper INTO temp FROM operlist WHERE codeoper=cur_n;
  	  EXCEPTION
	      WHEN NO_DATA_FOUND THEN
		    found := TRUE;
  	  END;
	  END LOOP;
  	RETURN cur_n;
  END;

BEGIN
  SELECT COUNT(*) INTO func_cnt FROM operlist WHERE SUBSTR(funcname,1, Length( func_name ) )=func_name;
  IF func_cnt > 0 THEN
    UPDATE operlist SET rolename = role_name WHERE SUBSTR(funcname,1, Length( func_name ) )=func_name;
    DBMS_OUTPUT.PUT_LINE( 'Функция <' || sem || '> обновлена!' );
  ELSE
    func_id := FIND_FREE;
    IF full_name IS NOT NULL THEN
      INSERT INTO operlist
        (codeoper, name, dlgname, funcname, runable, rolename)
      VALUES
        (func_id, sem, 'N/A', full_name, 1, role_name);
    ELSE
      INSERT INTO operlist
        (codeoper, name, dlgname, funcname, runable, rolename)
      VALUES
        (func_id, sem, 'N/A', func_name, 1, role_name);
    END IF;
    DBMS_OUTPUT.PUT_LINE( 'Функция <' || sem || '> добавлена!' );
  END IF;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SETFUNCROLE.sql =========*** End *
PROMPT ===================================================================================== 
