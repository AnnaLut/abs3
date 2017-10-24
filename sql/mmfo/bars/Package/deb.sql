
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/deb.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.DEB IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FILE NAME   :	deb_head.sql
%
% DESCRIPTION :	debugging module
%
% COPYRIGHT   :	Copyright Synopsys Limited, 1994.  All Rights Reserved.
%
% HISTORY     :	ROD 22-Feb-94 original version
%		JCS 08-Mar-94 work around Oracle AS bug
%		ROD 23-Mar-94 add dbms_ouput routines
%		ROD 19-Mar-94 add (error) trap
%		ROD 30-Apr-94 add dynamic debugging
%		ROD 06-May-94 parameterise debug buffer size
%		ROD 12-May-94 MSG in LOG_MSG is now 128 characters;
%                             add MSG_SEQ message sequence
%		ROD 14-May-94 Message lengths now 180 characters
%		ROD 10-Jun-94 Add HH:MM:SS to date display in deb.trace
%		ROD 24-Jun-94 Wildcard trap
%		PAD 13-Oct-94 make sccs_id a variable
%               AM  30-Mar-95 SCCSID variable removed
%		ROD 11-Mar-96 Rewrite trap (again) !!
%		ROD 15-May-96 Remove spurious local variables
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION 	: enable_debug,
%		  disable_debug
%
% DESCRIPTION	: Used to enable and disable debug messages
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
	PROCEDURE
	    enable_debug(buffer_size	IN	NUMBER);
	PROCEDURE
	    disable_debug;
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION 	: trap
%
% DESCRIPTION	: Used to trap specific application error
%
% EXAMPLE  	: deb.trap(sqlerrm,module,message,status);
%
% WHERE		: sqlerrm is the message string. Usually SQLERRM or equivalent.
%
%		  module  is the module number to trap. NULL means match on
%			  any module number (wildcard).
%
%		  message is the error message to trap. NULL means match on
%			  any message (wildcard). This is treated as NULL if
%			  module is NULL. A match will take place even if
%			  message is a substring of sqlerrm.
%
%		  status  is one of the following indicators :
%
%		    N     No error, or error not raised either by
%			  application or ORACLE. This status is returned
%			  if the error code within sqlerrm doesn't have ORA-.
%		    O	  ORACLE error within application; no match with the
%			  error number/message passed in module/message.
%		    A	  Application error; no match with the number/mesage
%			  passed in module/message.
%		    M	  Error matched the number/message passed.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
	PROCEDURE
	    trap
		(trap_sqlerrm	IN	VARCHAR2,
		 trap_code	IN OUT	INTEGER,
		 trap_message	IN OUT	VARCHAR2,
		 trap_status	   OUT	VARCHAR2);
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION 	: trace
%
% DESCRIPTION	: Used to display output
%
% EXAMPLE 1	: Usage where your_variable is readable, NOT NULL
%		  and of type DATE, NUMBER, VARCHAR2 or BOOLEAN
%
% 	deb.trace(module_number,'your debug message',your_variable);
%
% EXAMPLE 2	: Usage where your_variable is readable, NULL
%		  and of type DATE, NUMBER, VARCHAR2 or BOOLEAN
%
% 	deb.trace(module_number,'your debug message',deb.date_null);
% 	deb.trace(module_number,'your debug message',deb.number_null);
% 	deb.trace(module_number,'your debug message',deb.varchar2_null);
% 	deb.trace(module_number,'your debug message',deb.boolean_null);
%
% EXAMPLE 3	: Usage where your_variable is not readable, NOT NULL
%		  and of type DATE, NUMBER, VARCHAR2 or BOOLEAN
%
% 	deb.trace_date := readable_date;
% 	deb.trace(module_number,'your debug message',deb.trace_date);
%
%	deb.trace_varchar2 := readable_varchar2;
% 	deb.trace(module_number,'your debug message',deb.trace_varchar2);
%
% 	deb.trace_number := readable_number;
% 	deb.trace(module_number,'your debug message',deb.trace_number);
%
% 	deb.trace_boolean := readable_boolean;
% 	deb.trace(module_number,'your debug message',deb.trace_boolean);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

	PROCEDURE
	     trace
		(ern_in	IN	POSITIVE,
		 var	IN	VARCHAR2,
		 thing	IN	NUMBER);
        PRAGMA RESTRICT_REFERENCES ( trace, WNDS, RNDS );
	PROCEDURE
	     trace
		(ern_in	IN	POSITIVE,
		 var	IN	VARCHAR2,
		 thing	IN	VARCHAR2);
        PRAGMA RESTRICT_REFERENCES ( trace, WNDS, RNDS );
	PROCEDURE
	     trace
		(ern_in	IN	POSITIVE,
		 var	IN	VARCHAR2,
		 thing	IN	DATE);
        PRAGMA RESTRICT_REFERENCES ( trace, WNDS, RNDS );
	PROCEDURE
	     trace
		(ern_in	IN	POSITIVE,
		 var	IN	VARCHAR2,
		 thing	IN	BOOLEAN);

        PRAGMA RESTRICT_REFERENCES ( trace, WNDS, RNDS );

	deb_sqlerrm		VARCHAR2(2000);

	debug			BOOLEAN := FALSE;
	trace_ern		INTEGER ;
	sequence		INTEGER := 0;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION 	: INPUT
%
% DESCRIPTION	: Used to assign input
%
% EXAMPLE	: Assign to a BOOLEAN.	Type 'TRUE' 'FALSE' or 'NULL'.
% 		: Assign to a NUMBER.	Type number or 'NULL'.
% 		: Assign to a DATE.	Type date or 'NULL'.
% 		: Assign to a VARCHAR2.	Type character string or 'NULL'.
%
%	your_variable := deb.input(module_number,&&typed_input,your_variable);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

	FUNCTION
	     input
		(ern_in	IN	POSITIVE,
		 string	IN	VARCHAR2,
		 thing	IN	BOOLEAN)
	RETURN BOOLEAN;
	FUNCTION
	     input
		(ern_in	IN	POSITIVE,
		 string	IN	VARCHAR2,
		 thing	IN	NUMBER)
	RETURN NUMBER;
	FUNCTION
	     input
		(ern_in	IN	POSITIVE,
		 string	IN	VARCHAR2,
		 thing	IN	VARCHAR2)
	RETURN VARCHAR2;
	FUNCTION
	     input
		(ern_in	IN	POSITIVE,
		 string	IN	VARCHAR2,
		 thing	IN	DATE)
	RETURN DATE;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTIONS 	: ENABLE_LOG
%		  DISABLE_LOG
%		  GET_LOG
%		  LOG_MESSAGE
%
% DESCRIPTION	: Used to save/recall messages from SQL/PLUS routines.
%
%		  Based on dbms_output package.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  TYPE chararr IS
	TABLE OF VARCHAR2(255)
		INDEX BY BINARY_INTEGER;
  PROCEDURE enable_log
	(messages IN OUT INTEGER);
  PROCEDURE
	disable_log;
  PROCEDURE
	get_log(lines		OUT	INTEGER,
		messages 	OUT	chararr);
  PROCEDURE
	log_message(ern_in	IN	POSITIVE,
		    severity	IN	VARCHAR2,
		    message	IN	VARCHAR2);
  FUNCTION
	dummy_load
		(package_name	IN	VARCHAR2)
			RETURN VARCHAR2;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Modules added by APO
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE
	open_log;

PROCEDURE
	open_log
        	( op_mode    IN		VARCHAR2,
         	  call_count IN OUT     NATURAL    );
PROCEDURE
	close_log;

PROCEDURE
	tolog
        	( line	     IN		VARCHAR2   );

PROCEDURE
        tolog
		(ern_in	IN	POSITIVE,
		 var	IN	VARCHAR2,
		 thing	IN	NUMBER);
PROCEDURE
        tolog
		(ern_in	IN	POSITIVE,
		 var	IN	VARCHAR2,
		 thing	IN	VARCHAR2);
PROCEDURE
        tolog
		(ern_in	IN	POSITIVE,
		 var	IN	VARCHAR2,
		 thing	IN	DATE);
PROCEDURE
        tolog
		(ern_in	IN	POSITIVE,
		 var	IN	VARCHAR2,
		 thing	IN	BOOLEAN);


END deb;

 
/
CREATE OR REPLACE PACKAGE BODY BARS.DEB IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FILE NAME   :	deb_pack.sql
%
% DESCRIPTION :	debugging module
%
% COPYRIGHT   :	Copyright Synopsys Limited, 1994.  All Rights Reserved.
%
% HISTORY     :	PAD 13-Oct-94 make sccs_id a variable
%               AM  30-Mar-95 SCCSID variable removed
%		ROD 11-Mar-96 Rewrite trap (again) !
%		ROD 03-May-96 Remove NUMBER( declarations
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

	deb_step	NUMBER;
	deb_ern         NUMBER;
	deb_trace	VARCHAR2(3);

	TYPE deb_names IS TABLE OF VARCHAR2(16)
		  INDEX BY BINARY_INTEGER;

	deb_name        deb_names;

/***********************************************************************

 (Added by APO)

************************************************************************/

        handle		UTL_FILE.FILE_TYPE;
        log_opened	BOOLEAN		:= FALSE;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTIONS 	: ENABLE_LOG
%		  DISABLE_LOG
%		  LOG_MESSAGE
%		  GET_LOG
%		  PUT_LINE
%		  GET_LINE
%		  GET_LINES
%
% DESCRIPTION	: Used to save/recall messages from SQL/PLUS routines.
%
%		  Based on dbms_output package.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

  type char_arr is table of varchar2(512)
		  index by binary_integer;

  enabled         boolean        := FALSE;
  buf_size        binary_integer;
  tmpbuf          varchar2(500)  := '';
  putidx          binary_integer := 1;
  amtleft         binary_integer := 0;
  getidx          binary_integer := 2;
  getpos          binary_integer := 1;
  get_in_progress boolean := TRUE;
  buf             char_arr;
  idxlimit        binary_integer;

  procedure enable_log
	(messages IN OUT INTEGER) IS
    ern     constant positive := 990;
    lstatus integer;
    lockid  integer;
  begin
    enabled  := TRUE;
    messages := NVL(messages,30);
    IF messages < 5 THEN
	messages := 5;
    ELSIF messages > 300 THEN
	messages := 300;
    END IF;
    idxlimit := messages;
    buf_size := idxlimit*500;
  exception
    when others then raise_application_error(-(20000+ern),sqlerrm,true);
  end enable_log;

  procedure disable_log is
    ern constant positive := 991;
  begin
    enabled := FALSE;
  exception
    when others then raise_application_error(-(20000+ern),sqlerrm,true);
  end disable_log;

  procedure new_line is
    strlen binary_integer;
    ern    constant positive := 993;
    erm	   varchar2(80);
    err	   exception;
  begin
    if enabled then
      if get_in_progress then
        get_in_progress := FALSE;
        putidx := 1;
        amtleft := 500;
        buf(putidx) := '';
      end if;

      strlen := lengthb(tmpbuf);

      if strlen > 255 then
        tmpbuf := '';
  	erm := 'Line length overflow. Limit of 255 bytes per line.';
  	raise err;
      end if;

      if strlen > amtleft then
        if putidx >= idxlimit then
          tmpbuf := '';
          erm    := 'Buffer overflow. Limit of '||to_char(buf_size)||'/'||
					to_char(idxlimit)||' bytes/messages';
	  raise err;
        end if;
        buf(putidx) := buf(putidx) || '  -1';
        putidx := putidx + 1;
        amtleft := 500;
        buf(putidx) := '';
      end if;

      buf(putidx) := buf(putidx) || to_char(strlen,'999') || tmpbuf;
      amtleft := amtleft - strlen - 4;
      tmpbuf := '';
    end if;
  exception
    when err    then raise_application_error(-(20000+ern),'\'||erm,true);
    when others then raise_application_error(-(20000+ern),sqlerrm,true);
  end new_line;

  procedure put_line(line in varchar2) is
    ern constant positive := 992;
  begin
    if enabled then
      tmpbuf := tmpbuf || line;
      new_line;
    end if;
  exception
    when others then raise_application_error(-(20000+ern),sqlerrm,true);
  end put_line;

  procedure get_line(line out varchar2, status out integer) is
    strlen binary_integer;
    ern    constant positive := 994;
  begin
    if not enabled then
      status := 1;
      return;
    end if;

    if not get_in_progress then
      -- terminate last line
      buf(putidx) := buf(putidx) || '  -1';
      putidx := putidx + 1;
      get_in_progress := TRUE;
      -- initialize for reading
      getidx := 1;
      getpos := 1;
      tmpbuf := '';  -- don't leave any leftovers
    end if;

    while getidx < putidx loop
      strlen := to_number(substrb(buf(getidx),getpos,4)); --**--
      if strlen >= 0 then
        line := substrb(buf(getidx), getpos+4, strlen);
        getpos := getpos + strlen + 4;
        status := 0;
        return;
      else
        getidx := getidx + 1;
        getpos := 1;
      end if;
    end loop;
    status := 1;
  exception
    when others then raise_application_error(-(20000+ern),sqlerrm,true);
  end get_line;

  procedure get_lines(lines out chararr, numlines in out integer) is
    linecnt integer := 1;
    status  integer;
    ern     constant positive := 995;
  begin
    if not enabled then
      numlines := 0;
      return;
    end if;
    while linecnt <= numlines loop
      get_line(lines(linecnt), status);
      if status = 1 then		-- no more data
        numlines := linecnt - 1;
        return;
      end if;
      linecnt := linecnt + 1;		-- successfully got a line
    end loop;
    numlines := linecnt - 1;
    return;
  exception
    when others then raise_application_error(-(20000+ern),sqlerrm,true);
  end get_lines;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION NAME   :	get_log
%
% DESCRIPTION     :	retrieve messages logged
%
% EXAMPLE         :     deb.get_log(messages,text_array);
%
% WHERE           :     messages is the number of messages got
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
	PROCEDURE
	     get_log
		(lines		OUT	INTEGER,
		 messages 	OUT	chararr) IS


		ern		CONSTANT POSITIVE := 997;

		got_lines	INTEGER;
	BEGIN
		/* ask for the maximum number limit */
		got_lines := idxlimit;
		/* get messages out of the package */
		get_lines(messages,got_lines);
		/* send back the number we got */
		lines := got_lines;

	EXCEPTION
		WHEN OTHERS THEN
		    raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END get_log;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION NAME   :	log_message
%
% DESCRIPTION     :	Log a message to temporary log
%
% EXAMPLE         :     deb.log_message(mod_num,severity,'your message');
%
% WHERE           :     mod_num is the number of your module or zero
%
%			severity is the (single character)
%			message severity indicator.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
	PROCEDURE
	     log_message
		(ern_in		IN	POSITIVE,
		 severity	IN	VARCHAR2,
		 message	IN	VARCHAR2) IS

		ern	CONSTANT POSITIVE := 996;
		ern_out	VARCHAR2(3);
		erm	VARCHAR2(80);
		err	EXCEPTION;
	BEGIN
	     IF ern_in IS NULL THEN
		ern_out := '???';
	     ELSIF ern_in = 0 THEN
		ern_out := 'TOP';
	     ELSIF ern_in not between 1 and 999 THEN
		erm := 'Module number outside permitted range';
		RAISE err;
	     ELSE
		ern_out := LPAD(TO_CHAR(ern_in),3,'0');
	     END IF;
	     put_line('%'||TO_CHAR(sysdate,'DD-MON-YYYY HH24:MI:SS')||
			'.00%'||NVL(SUBSTR(severity,1,1),'W')||
				'%SQL Plus '||ern_out||'%'||message);
	EXCEPTION
		WHEN OTHERS THEN
		    raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END log_message;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION NAME   :	debug_msg,
%			enable_debug,
%			disable_debug
%
% DESCRIPTION     :	Output message and write to log_file
%			Enable this facility
%			Disable this facility
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

	PROCEDURE
	    enable_debug(buffer_size	IN	NUMBER) IS
	    ern		CONSTANT POSITIVE := 887;
	BEGIN
	    dbms_output.enable(buffer_size);
	    debug := TRUE;
	EXCEPTION
	    WHEN OTHERS THEN
		raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END;
	PROCEDURE
	    disable_debug IS
	    ern		CONSTANT POSITIVE := 886;
	BEGIN
	    dbms_output.disable;
	    debug := FALSE;
	EXCEPTION
	    WHEN OTHERS THEN
		raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END;

	PROCEDURE
	    debug_msg
		(ern_in IN	INTEGER,
		 msg_in	IN	VARCHAR2) IS

		ern_		NUMBER;

		deb_num		INTEGER;

		deb_init	BOOLEAN;

		ern		CONSTANT POSITIVE := 888;
		erm		VARCHAR2(80);
		err		EXCEPTION;
	BEGIN

	    ern_ := NVL(ern_in,-1);

	    IF ern_ NOT BETWEEN -1 AND 999 THEN
		erm := 'Module number '||TO_CHAR(ern_in)||
					' outside permitted range';
		RAISE err;
	    END IF;

	    -- stop numeric overflow
	    IF NVL(deb_step,0) IN (0,999) THEN
		deb_step := 0;
	    END IF;
	    -- reset when module changes
	    IF NVL(deb_ern,ern_) != ern_ THEN
		deb_step := 0;
	    END IF;
	    -- save module number
	    deb_ern  := ern_;
	    -- increment step
	    deb_step := deb_step + 1;

	    -- deb_name table initialised ?
	    BEGIN

		IF deb_name(0) = 'TOP' THEN
		    deb_init := TRUE;
		END IF;

	    EXCEPTION
		WHEN NO_DATA_FOUND THEN
		    deb_init := FALSE;
	    END;

	    -- initialise deb_name table
	    IF deb_init = FALSE THEN

		deb_name(-1) := '???';
		deb_name(0)  := 'TOP';

		FOR i IN 1..999 LOOP
		    deb_name(i) := LPAD(TO_CHAR(i),3,'0');
		END LOOP;

	    END IF;

	    -- save module name
	    IF deb_step = 1 THEN
		IF NVL(ern_in,0) > 0 THEN
		    IF UPPER(SUBSTR(msg_in,4,6)) = 'MODULE' THEN
			deb_name(ern_in) :=
			    UPPER(SUBSTR(msg_in,
				INSTR(msg_in,'VARCHAR2> ')+10,16));
		    END IF;
		END IF;
	    END IF;

	    IF NVL(trace_ern,ern_) = ern_ THEN
	    -- output message if debug enabled for this module

		IF ern_ < 1 THEN
		-- module name TOP or ???; display module_name.step_number
		    deb_num := deb_step;
		ELSIF deb_name(ern_) = LPAD(TO_CHAR(ern_),3,'0') THEN
		-- module name unknown; display module_number.step_number
		    deb_num := deb_step;
		ELSE
		-- module name known; display module_name.module_number
		    deb_num := ern_;
		END IF;

		dbms_output.put_line
		    (SUBSTR(deb_name(ern_)||
			LTRIM(TO_CHAR(deb_num/1000,'.900'))||msg_in,1,180));
	    END IF;

	EXCEPTION
		WHEN err THEN
		    raise_application_error(-(20000+ern),'\'||erm,TRUE);
		WHEN OTHERS THEN
		    raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END debug_msg;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION NAME   :	trace
%
% DESCRIPTION     :	Output value of variable within program.
%
% EXAMPLE         :     deb.trace(mod_num,'debug message',var_nam)
%
% WHERE           :     mod_num is the number of your module or zero
%
%			var_nam is the name of your variable which can
%			be a BOOLEAN,NUMBER,VARCHAR2 or DATE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

	PROCEDURE
	     trace
		(ern_in	IN	POSITIVE,
		 var	IN	VARCHAR2,
		 thing	IN	NUMBER)	IS

		ern	CONSTANT POSITIVE := 999;
	BEGIN
	     debug_msg(ern_in,' : '||var||' NUMBER> '||
				NVL(TO_CHAR(thing),'NULL'));
	EXCEPTION
		WHEN OTHERS THEN
		    raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END trace;
	PROCEDURE
	     trace
		(ern_in	IN	POSITIVE,
		 var	IN	VARCHAR2,
		 thing	IN	VARCHAR2) IS

		ern	CONSTANT POSITIVE := 999;
	BEGIN
	     debug_msg(ern_in,' : '||var||' VARCHAR2> '||NVL(thing,'NULL'));
	EXCEPTION
		WHEN OTHERS THEN
		    raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END trace;
	PROCEDURE
	     trace
		(ern_in	IN	POSITIVE,
		 var	IN	VARCHAR2,
		 thing	IN	DATE) IS

		ern	CONSTANT POSITIVE := 999;
	BEGIN
	     debug_msg(ern_in,' : '||var||' DATE> '||
			NVL(TO_CHAR(thing,'DD-MON-YYYY HH24:MI:SS'),'NULL'));
	EXCEPTION
		WHEN OTHERS THEN
		    raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END trace;
	PROCEDURE
	     trace
		(ern_in	IN	POSITIVE,
		 var	IN	VARCHAR2,
		 thing	IN	BOOLEAN) IS

		msg	VARCHAR2(5);
		ern	CONSTANT POSITIVE := 999;
	BEGIN
	    IF thing IS NULL THEN
		msg := 'NULL';
	    ELSIF thing = TRUE THEN
		msg := 'TRUE';
	    ELSE
		msg := 'FALSE';
	    END IF;

	    debug_msg(ern_in,' : '||var||' BOOLEAN> '||msg);

	EXCEPTION
		WHEN OTHERS THEN
		    raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END trace;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION NAME   :  input
%
% DESCRIPTION     :  input value to a variable within a test call
%
% EXAMPLE         :  var_nam := deb.input('sub_var',arg_typ)
%
% WHERE           :  mod_num is the number of your module or zero
%
%		     var_nam is the name of a variable which can
%		     be a BOOLEAN,NUMBER,VARCHAR2 or DATE
%
%		     sub_var is the substitution variable including
%		     ampersand(s). To obtain a NULL value set to 'NULL'.
%
%		     arg_typ is any BOOLEAN, VARCHAR2 or NUMBER
%
% RETURNS	  :  converts sub_var value to BOOLEAN, VARCHAR2, DATE or
%		     NUMBER depending on what type of variable arg_typ was.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
	FUNCTION
	     input
		(ern_in	IN	POSITIVE,
		 string	IN	VARCHAR2,
		 thing	IN	BOOLEAN)	RETURN BOOLEAN IS

		ern_out	VARCHAR2(3);

		ern	CONSTANT POSITIVE := 998;
		erm	VARCHAR2(80);
		err	EXCEPTION;
	BEGIN

	    IF ern_in IS NULL THEN
		ern_out := '???';
	    ELSIF ern_in = 0 THEN
		ern_out := 'TOP';
	    ELSIF ern_in NOT BETWEEN 1 AND 999 THEN
		erm := 'Module number '||TO_CHAR(ern_in)||
					' outside permitted range';
		RAISE err;
	    ELSE
		ern_out := LPAD(TO_CHAR(ern_in),3,'0');
	    END IF;

	    IF UPPER(NVL(string,'NULL')) = 'NULL' THEN
	     	RETURN NULL;
	    ELSIF UPPER(string) = 'FALSE' THEN
		RETURN FALSE;
	    ELSIF UPPER(string) = 'TRUE' THEN
		RETURN TRUE;
	    ELSE
		erm := 'BOOLEAN input in module '||ern_out||
				' must be NULL, TRUE or FALSE';
	     	raise err;
	    END IF;

	EXCEPTION
	    WHEN err THEN
		raise_application_error(-(20000+ern),'\'||erm);
	    WHEN OTHERS THEN
		raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END input;

	FUNCTION
	     input
		(ern_in	IN	POSITIVE,
		 string	IN	VARCHAR2,
		 thing	IN	NUMBER)		RETURN NUMBER IS

		result	NUMBER;

		ern	POSITIVE := 998;
	BEGIN

	    IF NVL(UPPER(string),'NULL') != 'NULL' THEN
		result := TO_NUMBER(string);
	    END IF;

	    RETURN result;

	EXCEPTION
	    WHEN OTHERS THEN
		raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END input;

	FUNCTION
	     input
		(ern_in	IN	POSITIVE,
		 string	IN	VARCHAR2,
		 thing	IN	VARCHAR2)	RETURN VARCHAR2 IS

		ern	POSITIVE := 998;
	BEGIN

	     IF UPPER(string) = 'NULL' THEN
	     	RETURN NULL;
	     ELSE
		RETURN string;
	     END IF;

	EXCEPTION
	    WHEN OTHERS THEN
		raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END input;

	FUNCTION
	     input
		(ern_in	IN	POSITIVE,
		 string	IN	VARCHAR2,
		 thing	IN	DATE)		RETURN DATE IS

		result	DATE;

		ern	POSITIVE := 998;
	BEGIN

	    IF ern_in > 0 THEN
		ern := ern_in;
	    END IF;

	    IF NVL(UPPER(string),'NULL') = 'NULL' THEN
	        NULL;
	    ELSIF LENGTH(string) = 11 THEN
		result := TO_DATE(string,'DD-MON-YYYY');
	    ELSE
		result := TO_DATE(string,'DD-MON-RR');
	    END IF;

	    RETURN result;

	EXCEPTION
	    WHEN OTHERS THEN
		raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END input;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION 	: trap
%
% DESCRIPTION	: Used to trap specific application error
%
% EXAMPLE  	: deb.trap(sqlerrm,module,message,status);
%
% WHERE		: sqlerrm is the message string. Usually SQLERRM or equivalent.
%
%		  module  is the module number to trap. NULL means match on
%			  any module number (wildcard).
%
%		  message is the error message to trap. NULL means match on
%			  any message (wildcard). This is treated as NULL if
%			  module is NULL. A match will take place even if
%			  message is a substring of sqlerrm.
%
%		  status  is one of the following indicators :
%
%		    N     No error, or error not raised either by
%			  application or ORACLE. This status is returned
%			  if the error code within sqlerrm doesn't have ORA-.
%		    O	  ORACLE error within application; no match with the
%			  error number/message passed in module/message.
%		    A	  Application error; no match with the number/mesage
%			  passed in module/message.
%		    M	  Error matched the number/message passed.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
	PROCEDURE
	    trap
		(trap_sqlerrm	IN	VARCHAR2,
		 trap_code	IN OUT	INTEGER,
		 trap_message	IN OUT	VARCHAR2,
		 trap_status	   OUT	VARCHAR2) IS


	    module		INTEGER;

	    string		VARCHAR2(2000);
	    message		VARCHAR2(180);
	    indicator		VARCHAR2(1);

	    split1		NATURAL;
	    split2		NATURAL;

	    ern			POSITIVE := 989;

	BEGIN

	    IF deb.debug THEN
		deb.trace(ern,'module/0','trap');
		deb.trace(ern,'trap_code/0',trap_code);
		deb.trace(ern,'trap_message/0',trap_message);
	    END IF;

	    split1 := INSTR(trap_sqlerrm,CHR(10));

	    IF split1 > 0 THEN
	    -- cut off any rubbish after LF character
		string := SUBSTR(trap_sqlerrm,1,split1-1);
	    ELSE
	    -- take the thing as it is
		string := trap_sqlerrm;
	    END IF;

	    IF deb.debug THEN
		deb.trace(ern,'string/1',string);
	    END IF;

	    -- get the rightmost occurrence of 'ORA-'
	    split1 := 0;

	    LOOP

		split2 := split1;
		split1 := INSTR(string,'ORA-',split1+1);
		EXIT WHEN split1 = 0;

	    END LOOP;

	    IF deb.debug THEN
		deb.trace(ern,'split1/2',split1);
		deb.trace(ern,'split2/2',split2);
	    END IF;

	    split1 := INSTR(string,': \',split2);

	    IF deb.debug THEN
		deb.trace(ern,'split1/3',split1);
	    END IF;

	    IF split1 > 0 THEN

		message := SUBSTR(string,split1+3);
		string  := SUBSTR(string,1,split1-1);

	    ELSE

		split1 := INSTR(string,': ',split2);

		IF deb.debug THEN
		    deb.trace(ern,'split1/4',split1);
		END IF;

		IF split1 > 0 THEN

		    message := SUBSTR(string,split1+2);
		    string  := SUBSTR(string,1,split1-1);

		ELSE

		    message := string;
		    string  := NULL;

		END IF;

	    END IF;

	    IF deb.debug THEN
		deb.trace(ern,'string/5',string);
		deb.trace(ern,'message/5',message);
	    END IF;

	    IF split2 > 0 THEN

		BEGIN

		    module := TO_NUMBER(SUBSTR(string,split2+3));

		EXCEPTION
		    WHEN OTHERS THEN
			NULL;
		END;

	    END IF;

	    IF deb.debug THEN
		deb.trace(ern,'module/6',module);
	    END IF;

	    IF message IS NULL OR module IS NULL THEN
	    -- no application error condition
		indicator := 'N';
	    ELSIF trap_code IS NULL THEN
	    -- application error; module not specified
		indicator := 'X';
	    ELSIF trap_code != module THEN
	    -- application error; module specified; did not match
		indicator := 'X';
	    ELSIF trap_message IS NULL THEN
	    -- module matched, message not specified
		indicator := 'M';
	    ELSIF INSTR(message,trap_message) > 0 THEN
	    -- module matched, message matched
		indicator := 'M';
	    ELSE
	    -- module matched, message did not match
		indicator := 'X';
	    END IF;

	    IF deb.debug THEN
		deb.trace(ern,'indicator/7',indicator);
	    END IF;

	    IF indicator = 'X' THEN
	    -- application error;
		IF module BETWEEN -20999 AND -20000 THEN
		-- application error
		    indicator := 'A';
		ELSE
		-- ORACLE error
		    indicator := 'O';
		END IF;
	    END IF;

	    IF deb.debug THEN
		deb.trace(ern,'indicator/8',indicator);
	    END IF;

	    trap_status  := indicator;
	    trap_code    := module;
	    trap_message := message;

	    IF deb.debug THEN
		deb.trace(ern,'indicator/9',indicator);
		deb.trace(ern,'trap_code/9',trap_code);
		deb.trace(ern,'trap_message/9',trap_message);
	    END IF;

	EXCEPTION
	    WHEN OTHERS THEN
		raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END trap;

	FUNCTION
		dummy_load
			(package_name	IN	VARCHAR2)
				RETURN VARCHAR2 IS
	BEGIN
		RETURN package_name;
	END;

/***********************************************************************

 Modules added by APO

\***********************************************************************
%
% PROCEDURE NAME  :	open_log
%
% CALLED BY       :	client's application
%
% DESCRIPTION     :
%
% TABLES ACCESSED :	none
%
% HISTORY         :	APO 16-Jul-98 Original version
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE open_log IS

        call_count	NATURAL		:= 0;
        op_mode		VARCHAR2 (1)	:= 'a';

BEGIN

    open_log ( op_mode, call_count);
    log_opened := TRUE;

END open_log;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE open_log

		( op_mode		IN	VARCHAR2,
                  call_count		IN OUT  NATURAL    ) IS

	---------  Path to the LOG file $ORACLE_HOME/dbs ('.') -------

        log_dir		VARCHAR2 (80)   	:= '.'		;
        log_file	VARCHAR2 (80)		:= 'bars.log'	;

	erm		VARCHAR2 (80)				;
        ern		CONSTANT POSITIVE       := 700		;
        err		EXCEPTION				;
BEGIN

    IF deb.debug THEN
	deb.trace(ern, 'module/0', 'open_log');
        deb.trace(ern, 'mode',     op_mode );
	deb.trace(ern, 'call_count',call_count);
    END IF;

    IF call_count > 1 THEN
       erm := 'OPEN_LOG: Could not open log file for 2 attempts';
       RAISE err;
    END IF;

    IF deb.debug THEN
       deb.trace(ern, 'Loc dir', log_dir);
       deb.trace(ern, 'Loc file',log_file);
    END IF;

    handle := utl_file.fopen ( log_dir, log_file, op_mode);

EXCEPTION
     	WHEN UTL_FILE.INVALID_PATH
     	     THEN
        	erm := 'OPEN_LOG: invalid path';
        	raise err;
     	WHEN UTL_FILE.INVALID_MODE
     	THEN
        	erm := 'OPEN_LOG: invalid mode';
        	raise err;
     	WHEN UTL_FILE.INVALID_OPERATION
     	THEN
    	    IF deb.debug THEN
  	        deb.trace(ern, 'Could not open in mode', op_mode);
    	    END IF;

       	    call_count := call_count +1;
	    open_log ( 'w', call_count );

        WHEN OTHERS THEN

            erm := 'OPEN_LOG: Just another error ...(1)';
            RAISE err;

END open_log;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE NAME  :	close_log
%
% CALLED BY       :	client's application
%
% DESCRIPTION     :
%
% TABLES ACCESSED :	none
%
% HISTORY         :	APO 16-Jul-98 Original version
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE close_log IS

	erm		VARCHAR2 (80)				;
        ern		CONSTANT POSITIVE       := 701		;
        err		EXCEPTION				;

BEGIN

    IF deb.debug THEN
	deb.trace(ern, 'module/0','close_log');
    END IF;

    utl_file.fclose ( handle );
    log_opened := FALSE;

EXCEPTION
    WHEN UTL_FILE.INVALID_FILEHANDLE
    THEN
            erm := 'CLOSE_LOG: INVALID_FILEHANDLE';
            RAISE err;
    WHEN UTL_FILE.WRITE_ERROR
    THEN
            erm := 'CLOSE_LOG: WRITE_ERROR';
            RAISE err;
   WHEN OTHERS THEN
	raise_application_error( -(20000+ern), SQLERRM, TRUE);

END close_log;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE NAME  :	tolog
%
% CALLED BY       :	client's application
%
% DESCRIPTION     :	Puts a line into a LOG
%
% TABLES ACCESSED :	none
%
% HISTORY         :	APO 16-Jul-98 Original version
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE tolog
		( line	IN	VARCHAR2 )
IS

	erm		VARCHAR2 (80)				;
        ern		CONSTANT POSITIVE       := 702		;
        err		EXCEPTION				;

BEGIN

    IF deb.debug THEN
	deb.trace(ern, 'module/0','tolog');
        deb.trace(ern, 'line:',line);
        deb.trace(ern, 'log_opened:',log_opened);
    END IF;

    IF NOT log_opened THEN

       open_log;

    END IF;

    utl_file.put_line ( handle, line );

    IF deb.debug THEN
	deb.trace(ern, 'module/10','put_line');
    END IF;

EXCEPTION
   WHEN UTL_FILE.INVALID_FILEHANDLE
   THEN
           erm := 'PUT_LINE: INVALID_FILEHANDLE';
           RAISE err;

   WHEN UTL_FILE.WRITE_ERROR
   THEN
           erm := 'PUTLINE: WRITE_ERROR';
           RAISE err;

   WHEN UTL_FILE.INVALID_OPERATION
   THEN
           erm := 'PUTLINE: INVALID_OPERATION';
           RAISE err;
   WHEN OTHERS THEN
	raise_application_error( -(20000+ern), SQLERRM, TRUE);

END tolog;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION NAME   :	log_msg
%
% DESCRIPTION     :	Log a message to temporary log
%
% EXAMPLE         :     lg.log_msg(mod_num,'your message');
%
% WHERE           :     mod_num is the number of your module or zero
%
%			message severity indicator.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE
          log_msg
		(ern_in		IN	POSITIVE,
		 message	IN	VARCHAR2) IS

		ern	CONSTANT POSITIVE := 796;
		ern_out	VARCHAR2(3);
		erm	VARCHAR2(80);
		err	EXCEPTION;
	BEGIN
	     IF ern_in IS NULL THEN
		ern_out := '???';
	     ELSIF ern_in = 0 THEN
		ern_out := 'TOP';
	     ELSIF ern_in not between 1 and 999 THEN
		erm := 'Module number outside permitted range';
		RAISE err;
	     ELSE
		ern_out := LPAD(TO_CHAR(ern_in),3,'0');
	     END IF;
	     tolog('#'||TO_CHAR(sysdate,'DD-MON-YYYY HH24:MI:SS')||
			'#'||ern_out||'#'||message);
	EXCEPTION
		WHEN OTHERS THEN
		    raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END log_msg;


/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION NAME   :	tolog
%
% DESCRIPTION     :	Output value of variable to a log file.
%
% EXAMPLE         :     lg.tolog(mod_num,'debug message',var_nam)
%
% WHERE           :     mod_num is the number of your module or zero
%
%			var_nam is the name of your variable which can
%			be a BOOLEAN,NUMBER,VARCHAR2 or DATE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

	PROCEDURE
	     tolog
		(ern_in	IN	POSITIVE,
		 var	IN	VARCHAR2,
		 thing	IN	NUMBER)	IS

		ern	CONSTANT POSITIVE := 799;
	BEGIN
	     log_msg(ern_in,' : '||var||' NUMBER> '||
				NVL(TO_CHAR(thing),'NULL'));
	EXCEPTION
		WHEN OTHERS THEN
		    raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END tolog;
	PROCEDURE
	     tolog
		(ern_in	IN	POSITIVE,
		 var	IN	VARCHAR2,
		 thing	IN	VARCHAR2) IS

		ern	CONSTANT POSITIVE := 799;
	BEGIN
	     log_msg(ern_in,' : '||var||' VARCHAR2> '||NVL(thing,'NULL'));
	EXCEPTION
		WHEN OTHERS THEN
		    raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END tolog;
	PROCEDURE
	     tolog
		(ern_in	IN	POSITIVE,
		 var	IN	VARCHAR2,
		 thing	IN	DATE) IS

		ern	CONSTANT POSITIVE := 799;
	BEGIN
	     log_msg(ern_in,' : '||var||' DATE> '||
			NVL(TO_CHAR(thing,'DD-MON-YYYY HH24:MI:SS'),'NULL'));
	EXCEPTION
		WHEN OTHERS THEN
		    raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END tolog;
	PROCEDURE
	     tolog
		(ern_in	IN	POSITIVE,
		 var	IN	VARCHAR2,
		 thing	IN	BOOLEAN) IS

		msg	VARCHAR2(5);
		ern	CONSTANT POSITIVE := 799;
	BEGIN
	    IF thing IS NULL THEN
		msg := 'NULL';
	    ELSIF thing = TRUE THEN
		msg := 'TRUE';
	    ELSE
		msg := 'FALSE';
	    END IF;

	    log_msg(ern_in,' : '||var||' BOOLEAN> '||msg);

	EXCEPTION
		WHEN OTHERS THEN
		    raise_application_error(-(20000+ern),SQLERRM,TRUE);
	END tolog;

END deb;
/
 show err;
 
PROMPT *** Create  grants  DEB ***
grant EXECUTE                                                                on DEB             to ABS_ADMIN;
grant EXECUTE                                                                on DEB             to BARS014;
grant EXECUTE                                                                on DEB             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DEB             to PUBLIC;
grant EXECUTE                                                                on DEB             to START1;
grant EXECUTE                                                                on DEB             to TOSS;
grant EXECUTE                                                                on DEB             to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/deb.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 