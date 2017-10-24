
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cust_survey.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CUST_SURVEY 
IS
  -- ----------------------------------- --
  --  ����� ��������� ����� ��������     --
  -- ----------------------------------- --

  -- ��������� ������������ ������
  g_header_version  CONSTANT VARCHAR2(64)  := 'version 2.00 27/03/2007';
  g_awk_header_defs CONSTANT VARCHAR2(512) := '';

  -- �������� ���� ������ � ����.����������� ��� ������� ���������
  g_errmsg        VARCHAR2(3000);
  g_errmsg_dim    CONSTANT NUMBER NOT NULL := 3000;

  -- ���������� ������������� ������ �� ��� ������������ ���� (����.)
  FUNCTION get_survey_id
    (p_surveycode  survey.survey_code%type)
  RETURN NUMBER;

  -- ��������� ����������� ���������� �������� ������
  FUNCTION fill_up_survey
    (p_rnk       customer.rnk%type,     -- ���.� �������
     p_surveyid  survey.survey_id%type  -- ��� ������
    )
  RETURN SMALLINT;

  -- ��������� ������  �������������
  PROCEDURE start_session
    (p_rnk        IN customer.rnk%type,              -- ���.� �������
     p_surveyid   IN survey.survey_id%type,          -- ��� ������
     p_decline	  IN survey_session.fl_decline%type, -- ���� ������ �� ������������� (1- �����)
     p_sessionid OUT survey_session.session_id%type  -- � ������
    );

  -- ��������� ����� �� ������ ������
  PROCEDURE fix_answer
    (p_sessionid    IN survey_answer.session_id%type,  -- ��� ������
     p_questid      IN survey_answer.quest_id%type,    -- ��� �������
     p_keyid        IN NUMBER,                         -- ��� �������� ������ ��� ���� �� ���.���-��
     p_answer_char  IN survey_answer.answer_char%type, -- ��������� ����� (�����)
     p_answer_numb  IN survey_answer.answer_numb%type, -- ��������� ����� (�����)
     p_answer_date  IN survey_answer.answer_date%type, -- ��������� ����� (����)
     p_errmsg       OUT g_errmsg%type	               -- ��������� �� ������
    );

  -- ��������� ����� �� ������ ������ (����� ��� �������� � ������ quest_id_p)
  PROCEDURE fix_answer_p
	(p_session_id  IN survey_answer.session_id%type,  -- ��� ������
	 p_quest_id_p  IN survey_answer.quest_id_p%type,  -- ��� �������
	 p_answer_pos  IN survey_answer.answer_pos%type,  -- answer_pos
	 p_answer_id  IN survey_answer.answer_id%type,
	 p_answer_opt  IN survey_answer.answer_opt%type,  -- ��� �������� ������ ��� ���� �� ���.���-��
	 p_answer_char IN survey_answer.answer_char%type, -- ��������� ����� (�����)
	 p_answer_numb IN survey_answer.answer_numb%type, -- ��������� ����� (�����)
	 p_answer_date IN survey_answer.answer_date%type);-- ��������� ����� (����)

  -- ���������� ������ �� ������ �� �������� ����������� (���. � v_surveyanswer)
  FUNCTION read_extrnl_tbl
    (p_tabname  VARCHAR2,  -- �������� �������� �����������
     p_tabkey   VARCHAR2,  -- ����
     p_tabvalue VARCHAR2   -- ���������
    )
  RETURN t_surveydict PIPELINED;

  -- ���������� �������� ������� � �� �������
  PROCEDURE child_questions
    (p_survey_id   IN   survey.survey_id%type,         -- ��� ������
	 p_quest_id    IN   survey_quest.quest_id%type,    -- ��� �������
     p_answer_opt  IN   survey_answer_opt.opt_id%type, -- ��� �������� ������
     p_child_quest OUT  SYS_REFCURSOR                  -- �������� ���.��������
    );

  -- ��������� ������ �������������
  PROCEDURE finish_session
    (p_sessionid IN survey_session.session_id%type);

  -- ���������� ���-� ���������� SQL-������� ��� ����������� �������
  FUNCTION get_default_answer
    (p_questid     survey_quest.quest_id%type,
     p_customerid  survey_session.rnk%type,
     p_sessionid   survey_session.session_id%type)
  RETURN VARCHAR2;

  -- ��������� �������: ���������� ������ ��������� ������
  FUNCTION header_version RETURN VARCHAR2;

  -- ��������� �������: ���������� ������ ���� ������
  FUNCTION body_version RETURN VARCHAR2;

END cust_survey;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.CUST_SURVEY 
IS

g_body_version  CONSTANT VARCHAR2(64)  := 'version 2.00 27/03/2007';
g_awk_body_defs CONSTANT VARCHAR2(512) := ' ';

MODCODE constant varchar2(3) := 'SRV';

/******************************************************************************
 ����      �����  ��������
 --------  ------ --------------------------------------------------------------
 26.03.07  ����   1. ����������� ����� ���������� WHEN OTHERS.
                  2. ��������� ������� get_survey_id.
                  3. ��������� ��������� finish_session.
                  4. ��������� ������� get_default_answer.
 06.03.07  Nata   ����� ���������� ������.
 07.11.06  ����   ��������� child_questions ������ ���������� �������� �������
                  � �� �������.
 02.11.06  ����   � ���������� start_session, fix_answer, child_questions
                  ������� RAISE; �������� �� RAISE_APPLICATION_ERROR.
 20.10.06  ����   1. ��������� start_session ���������� � �������� ������.
                  2. � ��������� fix_answer �� ����������� �������� ������������
                     ���������� ������ ������� ��� �������� 1 � 2 � ��� ������,
                     ����� ������ ������ �� ������� �� ������ (�.�. ����-������).
 12.10.06  ����   �������� ������
******************************************************************************/
FUNCTION get_survey_id
  (p_surveycode  survey.survey_code%type)
RETURN NUMBER
IS
   -- ������� ���������� ������������� ������ �� ��� ������������ ���� (����.)
  l_surveyid survey.survey_id%type := 0;
BEGIN
  bars_audit.trace('SURVEY(get_survey_code): ����������� ��� ������ = '||p_surveycode);

  BEGIN
    SELECT survey_id INTO l_surveyid
      FROM survey
     WHERE survey_code = p_surveycode
       AND activity = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_audit.trace('SURVEY(get_survey_code): ������ � ��������� ����� �� ���������� (��� ���������');
      l_surveyid := 0;
      RETURN l_surveyid;
  END;

  RETURN l_surveyid;

END get_survey_id;

FUNCTION fill_up_survey
  (p_rnk       customer.rnk%type,
   p_surveyid  survey.survey_id%type)
RETURN SMALLINT
IS
  l_cnt      SMALLINT;
  l_multi    NUMBER(1);
  l_allow    NUMBER(1);
  -- ������� ����������
  -- 1, ���� ������ ����� ��������� ������
  -- 0, ���� ������: �) ��� �������� ������, ������� ���. ������������
  --                 �) �����-�� ��������� �� ���������� ������, ������� ���.������������
  --                 �) ������ �� ������������� ��������
BEGIN
  bars_audit.trace('SURVEY(fill_up): ��� = '||to_char(p_rnk)||', � ������ = '||to_char(p_surveyid));

  -- ������ ������ ���� �������� � ��������������� ���� �������
  -- ������� �������� �� ������������ ������� ����������
  BEGIN
    SELECT survey_multi INTO l_multi
      FROM customer c, survey s
     WHERE c.rnk = p_rnk
       AND s.survey_id = p_surveyid
       AND c.custtype = s.custtype
       AND s.activity = 1
       AND c.date_off IS NULL;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      l_allow := 0;
      bars_audit.trace('SURVEY(fill_up-): ������ �� ������� ��� �� ������������� ���� �������');
      RETURN l_allow;
  END;

  -- ������� ��� ������ �������� ��� ������
  SELECT count(*) INTO l_cnt
    FROM survey_session
   WHERE rnk = p_rnk
     AND survey_id = p_surveyid;

  IF l_cnt > 0 AND l_multi = 0 THEN
     bars_audit.trace('SURVEY(fill_up-): ������ ������������, ������ ��� ��������/��������� �� ����������');
     l_allow := 0;
  ELSIF l_cnt > 0 THEN
     bars_audit.trace('SURVEY(fill_up+): ������ ������������, �������� ��� ��������� �� ����������');
     l_allow := 1;
  ELSE
     bars_audit.trace('SURVEY(fill_up+): ������ ������ �� ��������/�� ����������� �� ����������');
     l_allow := 1;
  END IF;

  RETURN l_allow;

END fill_up_survey;

PROCEDURE start_session
  (p_rnk        IN customer.rnk%type,
   p_surveyid   IN survey.survey_id%type,
   p_decline    IN survey_session.fl_decline%type,
   p_sessionid OUT survey_session.session_id%type)
IS
  l_sessionid NUMBER;
  l_branch    survey_session.branch%type;
  l_mfo       survey_session.kf%type;
  l_userid    survey_session.user_id%type;
  l_tmp       NUMBER(1);
  l_err       EXCEPTION;
  l_erm       g_errmsg%type;
  ern         number;
  e_par1      g_errmsg%type default null;
  e_par2      varchar2(80)  default null;
BEGIN
  bars_audit.trace('SURVEY(start_session): ��� = '||to_char(p_rnk)
                 ||', � ������ = '||to_char(p_surveyid)
                 ||', ����� = '||to_char(p_decline));

  IF fill_up_survey (p_rnk, p_surveyid) = 0 THEN
     l_erm := '����������� ���������� ������ � '||to_char(p_surveyid)||' �������� � ��� = '||to_char(p_rnk);
     ern := 1;
     e_par1 := to_char(p_surveyid);
     e_par2 := to_char(p_rnk);
     RAISE l_err;
  END IF;

  IF p_decline IS NULL OR p_decline NOT IN (0, 1) THEN
      l_erm := '����������� ����� ���� ������ �� ������������� ('||to_char(p_decline)||')';
      ern := 2;
      e_par1 := to_char(p_decline);
      RAISE l_err;
  END IF;

  l_mfo    := sys_context('bars_context','user_mfo');
  l_branch := sys_context('bars_context','user_branch');
  l_userid := gl.aUID;

  bars_audit.trace('SURVEY(start_session): ������������� = '||l_branch||', �����-�� = '||to_char(l_userid));

  BEGIN
    SELECT s_survey_session.nextval INTO l_sessionid FROM dual;
    INSERT INTO survey_session
       (session_id, rnk, survey_id, kf, branch, user_id, session_date, fl_decline)
    VALUES
       (l_sessionid, p_rnk, p_surveyid, l_mfo, l_branch, l_userid, sysdate, p_decline);
    bars_audit.trace('SURVEY(start_session): � ������ = '||to_char(l_sessionid));
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      l_erm := 'SURVEY(start_session): '||SUBSTR(SQLERRM, 1, g_errmsg_dim);
      ern := 3;
      e_par1 := SUBSTR(SQLERRM, 1, g_errmsg_dim);
      RAISE l_err;
  END;
  p_sessionid := l_sessionid;
EXCEPTION
  WHEN l_err THEN
    bars_audit.error(substr('SURVEY(start_session): '||l_erm, 1, g_errmsg_dim));
    bars_error.raise_error(MODCODE, ern, e_par1, e_par2);
END start_session;

PROCEDURE fix_answer
  (p_sessionid    IN survey_answer.session_id%type,
   p_questid      IN survey_answer.quest_id%type,
   p_keyid        IN NUMBER,
   p_answer_char  IN survey_answer.answer_char%type,
   p_answer_numb  IN survey_answer.answer_numb%type,
   p_answer_date  IN survey_answer.answer_date%type,
   p_errmsg       OUT g_errmsg%type)
IS
  l_questrec     survey_quest%rowtype;
  l_sessionrec   survey_session%rowtype;
  l_answer_pos   survey_answer.answer_pos%type;
  l_answer_id    survey_answer.answer_id%type;
  l_answer_opt   survey_answer.answer_opt%type;
  l_answer_char  survey_answer.answer_char%type;
  l_answer_numb  survey_answer.answer_numb%type;
  l_answer_date  survey_answer.answer_date%type;
  l_answer_null  survey_answer.answer_null%type;
  l_cnt          NUMBER;
  l_erm          g_errmsg%type;
  l_err          EXCEPTION;
  ern            number;
  e_par1         varchar2(80)  default null;
  e_par2         g_errmsg%type default null;
BEGIN

  bars_audit.trace('SURVEY(fix_answer): � ������ = '||to_char(p_sessionid)||', � ������� = '||to_char(p_questid));

  -- ��������� ������ �������������
  BEGIN
    SELECT * INTO l_sessionrec FROM survey_session WHERE session_id = p_sessionid;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      l_erm := '�� ������� ������ ������������� �'||to_char(p_sessionid);
      ern := 4;
      e_par1 := to_char(p_sessionid);
      RAISE l_err;
  END;
  bars_audit.trace('SURVEY(fix_answer): �������� ��������� ������, � ������ = '||to_char(l_sessionrec.survey_id));

  -- ��������� �������
  BEGIN
    SELECT * INTO l_questrec FROM survey_quest WHERE quest_id = p_questid;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      l_erm := '�� ������ ������ �'||to_char(p_questid);
      ern := 5;
      e_par1 := to_char(p_questid);
      RAISE l_err;
  END;
  bars_audit.trace('SURVEY(fix_answer): �������� ��������� �������, � ������ = '||to_char(l_questrec.survey_id));

  IF l_sessionrec.survey_id != l_questrec.survey_id THEN
     l_erm := '�������������� ����� ��� ������ � �������';
     ern := 6;
     RAISE l_err;
  END IF;

  IF l_sessionrec.fl_decline = 1 THEN
     l_erm := '������ ��������� �� �������������';
     ern := 7;
     RAISE l_err;
  END IF;

  -- ������������ ����
  l_answer_id   := NULL;
  l_answer_opt  := NULL;
  l_answer_char := NULL;
  l_answer_numb := NULL;
  l_answer_date := NULL;

  IF l_questrec.qfmt_id = 3 THEN
     bars_audit.trace('SURVEY(fix_answer): ������ ������������ ��������� ����� (�����)');
     l_answer_char := p_answer_char;
  ELSIF l_questrec.qfmt_id = 4 THEN
     bars_audit.trace('SURVEY(fix_answer): ������ ������������ ��������� ����� (�����)');
     l_answer_numb := p_answer_numb;
  ELSIF l_questrec.qfmt_id = 5 THEN
     bars_audit.trace('SURVEY(fix_answer): ������ ������������ ��������� ����� (����)');
     l_answer_date := p_answer_date;
  ELSIF l_questrec.qfmt_id = 1 THEN
     bars_audit.trace('SURVEY(fix_answer): ������ ������������ ����� ������ �� ���-�� ��������� �������');
     -- ��������� �� ������ �������� �������� ������
     IF p_keyid IS NOT NULL THEN
       BEGIN
         SELECT opt_id INTO l_answer_opt
           FROM survey_answer_opt
          WHERE list_id = l_questrec.list_id AND opt_id = p_keyid;
       EXCEPTION
         WHEN NO_DATA_FOUND THEN
           l_erm := '�� ������ ������� ������ � '||to_char(p_keyid)||' �� ������ �'||to_char(p_questid);
           ern := 8;
           e_par1 := to_char(p_keyid);
           e_par2 := to_char(p_questid);
           RAISE l_err;
       END;
     END IF;
     l_answer_opt := p_keyid;
  ELSE
     bars_audit.trace('SURVEY(fix_answer): ������ ������������ ����� �������� �� �������� ���-��');
     -- ��������� �� ������ �������� �������� ������
     IF p_keyid IS NOT NULL THEN
       BEGIN
         SELECT answer_key INTO l_answer_id
	       FROM v_surveyanswer
	      WHERE survey_id = l_sessionrec.survey_id
            AND quest_id = p_questid
            AND answer_key = p_keyid;
       EXCEPTION
         WHEN NO_DATA_FOUND THEN
           l_erm := '�� ������ ������� ������ � '||to_char(p_keyid)||' �� ������ �'||to_char(p_questid);
           ern := 8;
           e_par1 := to_char(p_keyid);
           e_par2 := to_char(p_questid);
           RAISE l_err;
       END;
     END IF;
     l_answer_id := p_keyid;
  END IF;

  -- ���������� ����� ������ �� �������� ������ ������� ������ �������������
  SELECT count(*) INTO l_cnt
    FROM survey_answer
   WHERE session_id = p_sessionid AND quest_id = p_questid;
  bars_audit.trace('SURVEY(fix_answer): �� ������ ������ ������ ������� '||to_char(l_cnt)||' ���');

  IF l_questrec.quest_multi = 0 AND l_cnt > 0 THEN
     l_erm := '�� ��������� ���������� ������������� ������ �� ������ �'||to_char(p_questid);
     ern := 9;
     e_par1 := to_char(p_questid);
     RAISE l_err;
  END IF;

  l_answer_pos := l_cnt + 1;
  bars_audit.trace('SURVEY(fix_answer): ���������� ����� ������ '||to_char(l_answer_pos));

  -- ������� ����, ��� ������ �� ������� �� ������
  IF  l_answer_id   IS NULL AND l_answer_opt  IS NULL AND l_answer_char IS NULL AND
      l_answer_numb IS NULL AND l_answer_date IS NULL THEN
	  l_answer_null := 1;
  ELSE
      l_answer_null := 0;
  END IF;

  BEGIN
    INSERT INTO survey_answer
      (session_id, quest_id, answer_pos,
       answer_opt, answer_id,
       answer_char, answer_numb, answer_date, branch, answer_null)
    VALUES
       (p_sessionid, p_questid, l_answer_pos,
        l_answer_opt, l_answer_id,
        l_answer_char, l_answer_numb, l_answer_date, l_sessionrec.branch, l_answer_null);
    bars_audit.trace('SURVEY(fix_answer): ��������� ����� � ���� ������');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      l_erm := substr('������ ������ ������ �� ������ �'||to_char(p_questid)||SQLERRM, 1, g_errmsg_dim);
      ern := 10;
      e_par1 := to_char(p_questid);
      e_par2 := SQLERRM;
      RAISE l_err;
  END;

EXCEPTION
  WHEN l_err THEN
    bars_audit.error(substr('SURVEY(fix_answer): '||l_erm, 1, g_errmsg_dim));
    bars_error.raise_error(MODCODE, ern, e_par1, e_par2);
END fix_answer;

PROCEDURE fix_answer_p
  (p_session_id  IN survey_answer.session_id%type,
   p_quest_id_p  IN survey_answer.quest_id_p%type,
   p_answer_pos  IN survey_answer.answer_pos%type,
   p_answer_id  IN survey_answer.answer_id%type,
   p_answer_opt  IN survey_answer.answer_opt%type,
   p_answer_char IN survey_answer.answer_char%type,
   p_answer_numb IN survey_answer.answer_numb%type,
   p_answer_date IN survey_answer.answer_date%type)
IS
BEGIN
	bars_audit.trace('SURVEY(fix_answer): � ������ = '||to_char(p_session_id)||', � ������� = '||to_char(p_quest_id_p));

	BEGIN
		INSERT INTO SURVEY_ANSWER(QUEST_ID_P,ANSWER_POS,ANSWER_ID,ANSWER_OPT,ANSWER_CHAR,ANSWER_NUMB,ANSWER_DATE,SESSION_ID)
		VALUES (p_quest_id_p, p_answer_pos, p_answer_id, p_answer_opt, p_answer_char, p_answer_numb, p_answer_date, p_session_id);
	EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
		UPDATE SURVEY_ANSWER SET ANSWER_ID = p_answer_id, ANSWER_OPT = p_answer_opt, ANSWER_CHAR = p_answer_char, ANSWER_NUMB = p_answer_numb, ANSWER_DATE = p_answer_date
		WHERE SESSION_ID = p_session_id and QUEST_ID_P = p_quest_id_p and ANSWER_POS = p_answer_pos;
	END;

END fix_answer_p;


FUNCTION read_extrnl_tbl
  (p_tabname  VARCHAR2,
   p_tabkey   VARCHAR2,
   p_tabvalue VARCHAR2)
RETURN
   t_surveydict PIPELINED
IS
   l_surveydict t_surveydictrec := t_surveydictrec(null, null);
   l_tabkey     VARCHAR2(3000);
   l_tabvalue   VARCHAR2(3000);
   l_sql        SYS_REFCURSOR;
BEGIN

  IF (p_tabname IS NULL OR p_tabkey IS NULL OR p_tabvalue IS NULL) THEN
    RETURN;
  END IF;

  OPEN l_sql FOR
    'SELECT '||p_tabkey||','||p_tabvalue||' FROM '||p_tabname;
  LOOP
    FETCH l_sql INTO l_surveydict.id, l_surveydict.name;
    EXIT WHEN l_sql%NOTFOUND;
    PIPE ROW (l_surveydict);
  END LOOP;

  RETURN;

END read_extrnl_tbl;

PROCEDURE child_questions
  (p_survey_id   IN   survey.survey_id%type,
   p_quest_id    IN   survey_quest.quest_id%type,
   p_answer_opt  IN   survey_answer_opt.opt_id%type,
   p_child_quest OUT  SYS_REFCURSOR)
IS
  l_fmt_id  survey_quest.qfmt_id%type;
  l_list_id survey_quest.list_id%type;
  l_child_quest SYS_REFCURSOR;
  l_erm         g_errmsg%type;
  l_err         EXCEPTION;
  ern           number;
  e_par1        varchar2(80)  default null;
  e_par2        varchar2(80)  default null;
BEGIN
  bars_audit.trace('SURVEY(child): � ������ = '||to_char(p_survey_id)
                 ||', � ������� = '||to_char(p_quest_id)
		 ||', � �������� ������ =  '||to_char(p_answer_opt));

  -- ��������� �� ����� ��� �������
  BEGIN
    SELECT qfmt_id, list_id
      INTO l_fmt_id, l_list_id
      FROM survey_quest
     WHERE quest_id = p_quest_id AND survey_id = p_survey_id;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      l_erm := '������ � '||to_char(p_quest_id)||'�� ���������� ��� �� ������������� ������ � '||to_char(p_survey_id);
      ern := 11;
      e_par1 := to_char(p_quest_id);
      e_par2 := to_char(p_survey_id);
      RAISE l_err;
  END;
  bars_audit.trace('SURVEY(child): ��� ������� = '||to_char(l_fmt_id));

  IF l_fmt_id != 1 THEN
     l_erm := '����������� ����� ������ ������������� ������� � '||to_char(p_quest_id);
     ern := 12;
     e_par1 := to_char(p_quest_id);
     RAISE l_err;
  END IF;

  -- ��������� �� ����� ��� �������� ������
  BEGIN
    SELECT list_id
      INTO l_list_id
      FROM survey_answer_opt
     WHERE list_id = l_list_id AND opt_id = p_answer_opt;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      l_erm := '����� � '||to_char(p_answer_opt)||' �� ���������� ��� �� ������������ ������� � '||to_char(p_quest_id);
      ern := 13;
      e_par1 := to_char(p_answer_opt);
      e_par2 := to_char(p_quest_id);
      RAISE l_err;
  END;
  bars_audit.trace('SURVEY(child): ��� ������ = '||to_char(l_list_id));

  -- ������ �� ���� ��������� ��������
  OPEN l_child_quest FOR
    SELECT child_id, 1 - child_state
      FROM survey_quest_dep
     WHERE quest_id = p_quest_id AND opt_id = p_answer_opt
     UNION ALL
    SELECT child_id, child_state
      FROM survey_quest_dep
     WHERE quest_id = p_quest_id AND opt_id <> nvl(p_answer_opt, 0);

  bars_audit.trace('SURVEY(child): �������� ������ l_child_quest');

  p_child_quest := l_child_quest;

EXCEPTION
  WHEN l_err THEN
    bars_audit.error(substr('SURVEY(child): '||l_erm, 1, g_errmsg_dim));
    bars_error.raise_error(MODCODE, ern, e_par1, e_par2);
END child_questions;

PROCEDURE finish_session
  (p_sessionid IN survey_session.session_id%type)
IS
  -- ��������� �������� ������ �������������
  l_completed survey_session.completed%type;
  l_err       EXCEPTION;
  ern         NUMBER;
  e_par1      VARCHAR2(80) DEFAULT NULL;
BEGIN
  bars_audit.trace('SURVEY(finish_session): ������ � = '||to_char(p_sessionid));

  BEGIN
    SELECT completed INTO l_completed FROM survey_session WHERE session_id = p_sessionid;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_audit.trace('SURVEY(finish_session): �� ������� ������ � = '||to_char(p_sessionid));
      ern := 4;
      e_par1 := to_char(p_sessionid);
      RAISE l_err;
  END;

  IF l_completed = 1 THEN
      bars_audit.trace('SURVEY(finish_session): ������ � = '||to_char(p_sessionid)||' ��� �������');
      ern := 14;
      e_par1 := to_char(p_sessionid);
      RAISE l_err;
  ELSE
    UPDATE survey_session
       SET completed = 1
     WHERE session_id = p_sessionid;
    IF SQL%ROWCOUNT = 0 THEN
      bars_audit.trace('SURVEY(finish_session): ���������� ������� ������ � = '||to_char(p_sessionid));
      ern := 15;
      e_par1 := to_char(p_sessionid);
      RAISE l_err;
    ELSE
      bars_audit.info('SURVEY(finish_session): ������� ������ � = '||to_char(p_sessionid));
    END IF;
  END IF;

EXCEPTION
  WHEN l_err THEN
     bars_error.raise_error(MODCODE, ern, e_par1);
END finish_session;

FUNCTION get_default_answer
  (p_questid     survey_quest.quest_id%type,
   p_customerid  survey_session.rnk%type,
   p_sessionid   survey_session.session_id%type)
RETURN VARCHAR2
IS
   -- ������� ���������� ���-� ���������� SQL-������� ��� ����������� �������
  l_c       INTEGER;
  l_r       INTEGER;
  l_sql     survey_quest.default_val%type;
  l_result  VARCHAR2(254);
BEGIN
  bars_audit.trace('SURVEY(get_default_answer): ��� ������� = '||to_char(p_questid)
                                           ||', ������ � '||to_char(p_questid)
                                           ||', ������ � '||to_char(p_sessionid));
  BEGIN
    SELECT trim(default_val) INTO l_sql
      FROM survey_quest
     WHERE quest_id = p_questid;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
  END;
  IF l_sql IS NULL OR LENGTH(l_sql) = 0 THEN
    RETURN NULL;
  END IF;

  l_c := DBMS_SQL.OPEN_CURSOR;

  DBMS_SQL.PARSE(l_c, l_sql, DBMS_SQL.NATIVE);

  BEGIN
    DBMS_SQL.BIND_VARIABLE(l_c, 'RNK', p_customerid);
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;

  BEGIN
    DBMS_SQL.BIND_VARIABLE(l_c, 'SESS', p_sessionid);
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;

  DBMS_SQL.DEFINE_COLUMN(l_c, 1, l_result, 254);

  l_r := DBMS_SQL.EXECUTE_AND_FETCH(l_c);

  DBMS_SQL.COLUMN_VALUE(l_c, 1, l_result);

  DBMS_SQL.CLOSE_CURSOR(l_c);

  RETURN l_result;

END get_default_answer;

FUNCTION header_version RETURN VARCHAR2
IS
BEGIN
  RETURN 'Package header CUST_SURVEY '
      || g_body_version|| '.'||chr(10)
      || 'AWK definition: '  ||chr(10)
      || g_awk_body_defs;
END header_version;

FUNCTION body_version RETURN VARCHAR2
IS
BEGIN
  RETURN 'Package body CUST_SURVEY '
      || g_body_version||'.' ||chr(10)
      || 'AWK definition: '  ||chr(10)
      || g_awk_body_defs;
END body_version;

END cust_survey;
/
 show err;
 
PROMPT *** Create  grants  CUST_SURVEY ***
grant EXECUTE                                                                on CUST_SURVEY     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CUST_SURVEY     to DPT_ADMIN;
grant EXECUTE                                                                on CUST_SURVEY     to DPT_ROLE;
grant EXECUTE                                                                on CUST_SURVEY     to SUR_ROLE;
grant EXECUTE                                                                on CUST_SURVEY     to WR_ALL_RIGHTS;
grant EXECUTE                                                                on CUST_SURVEY     to WR_CREDIT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cust_survey.sql =========*** End ***
 PROMPT ===================================================================================== 
 