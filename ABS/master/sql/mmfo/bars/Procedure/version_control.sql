

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/VERSION_CONTROL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure VERSION_CONTROL ***

  CREATE OR REPLACE PROCEDURE BARS.VERSION_CONTROL 
  ( in_string  IN	VARCHAR2)
IS

  TYPE component_tab_type IS TABLE OF VARCHAR2(100)
       INDEX BY BINARY_INTEGER;

  component		 component_tab_type;

  start_pos 		 NUMBER;
  end_pos 		 NUMBER;

  input_string           VARCHAR2(100);
  invalid_what_string    EXCEPTION;
  errm                   VARCHAR2(100);


BEGIN

  input_string := LTRIM(in_string) || ' ';
  end_pos      := 0;

 /* Extract each component (filename, sccsid, date) from input string */

  start_pos    := 1;
  end_pos      := INSTR(input_string, ' ', start_pos, 1);

  component(0) := SUBSTR(input_string,
			 start_pos,
	 	         end_pos - start_pos);

  IF component(0) != '@(#)'
  THEN
     RAISE invalid_what_string;
  END IF;

  FOR i IN 1..3 LOOP
    start_pos    := end_pos + 1;
    end_pos      := INSTR(input_string, ' ', start_pos, 1);
    component(i) := SUBSTR(input_string,
			   start_pos,
	 	           end_pos - start_pos);
  END LOOP;


 /* Break down sccsid into individual components */

  input_string := component(2) || '.';
  end_pos      := 0;

  FOR i IN 4..7 LOOP
    start_pos    := end_pos + 1;
    end_pos      := INSTR(input_string, '.', start_pos, 1);
    IF end_pos = 0
    THEN
       component(i) := 0;
       end_pos      := end_pos -1;
    ELSE
       component(i) := SUBSTR(input_string,
  	     		      start_pos,
	 	              end_pos - start_pos);
    END IF;
  END LOOP;

  IF to_number(component(4)) = 0
  OR to_number(component(5)) = 0
  THEN
     RAISE invalid_what_string;
  END IF;

 /* Insert a row into the BARS_VERSION table */

  INSERT INTO bars_version
	 (MODULE_NAME,
	  SCCS_RELEASE,
	  SCCS_LEVEL,
	  SCCS_BRANCH,
	  SCCS_SEQ,
	  DELTA_DATE,
	  TIMESTAMP)
  VALUES
	 (component(1),
	  TO_NUMBER(component(4)),
	  TO_NUMBER(component(5)),
	  TO_NUMBER(component(6)),
	  TO_NUMBER(component(7)),
	  TO_DATE(component(3),'yy/mm/dd'),
	  SYSDATE);

  IF SQL%ROWCOUNT = 1
  THEN
     COMMIT;
  ELSE
     RAISE invalid_what_string;
  END IF;

EXCEPTION
  WHEN invalid_what_string
  THEN
       dbms_output.put_line
	  ('VERSION CONTROL WARNING: Invalid or Non-Expanded What String');

  WHEN OTHERS
  THEN errm := sqlerrm;
       ROLLBACK;
       dbms_output.put_line('VERSION CONTROL ERROR: ' || errm);

END VERSION_CONTROL;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/VERSION_CONTROL.sql =========*** E
PROMPT ===================================================================================== 
