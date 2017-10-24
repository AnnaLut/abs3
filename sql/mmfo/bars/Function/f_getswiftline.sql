
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_getswiftline.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GETSWIFTLINE (swref_ NUMBER, line NUMBER, obj VARCHAR2)
RETURN VARCHAR2
IS

    string  VARCHAR2(400);
    l_msg	VARCHAR2(8000);
    n_char1	NUMBER;
    n_char2	NUMBER;
    tag		VARCHAR2(5);
    opt		VARCHAR2(5);
    value	VARCHAR2(400);

BEGIN

    IF line = 0 OR obj = '' THEN
        RETURN '';
    END IF;

    BEGIN
        SELECT body INTO l_msg FROM sw_messages WHERE swref=swref_;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN '';
    END;

    n_char1 := instr(l_msg, '{4: ', 1, 1);
    n_char2 := instr(l_msg, '-}', 1, 1);

    l_msg := substr(l_msg, n_char1+4, n_char2-n_char1-5);

    n_char1 := instr(l_msg, ' :', 1, line);

    IF n_char1 = 0 THEN
    	RETURN '';
    END IF;

    n_char2 := instr(l_msg, ' :', n_char1+2, 1);
    IF n_char2 = 0 THEN
    	string := substr(l_msg, n_char1+2, length(l_msg));
    ELSE
        string := substr(l_msg, n_char1+2, n_char2-n_char1-3);
    END IF;

    n_char1 := instr(string, ':', 1, 1);
    tag := substr(string, 1, n_char1-1);
    IF length(tag) > 2 THEN
        opt := substr(tag, -1);
        tag := substr(tag, 1, length(tag)-1);
    END IF;
    value := substr(string, n_char1+1, length(string));

    IF UPPER(obj) = 'TAG' THEN
    	RETURN tag;
    ELSIF UPPER(obj) = 'OPT' THEN
        RETURN opt;
    ELSIF UPPER(obj) = 'VAL' THEN
        RETURN value;
    ELSE
        RETURN '';
    END IF;
END f_GetSwiftLine;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_getswiftline.sql =========*** End
 PROMPT ===================================================================================== 
 