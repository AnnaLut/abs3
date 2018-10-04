CREATE OR REPLACE PACKAGE BARS.bars_swift_msg
IS
   --**************************************************************--
   --*                    SWIFT message package                   *--
   --*                  (C) Copyright Unity-Bars                  *--
   --*                                                            *--
   --**************************************************************--


   VERSION_HEADER        CONSTANT VARCHAR2 (64) := 'version 1.22 04.10.2018';
   VERSION_HEADER_DEFS   CONSTANT VARCHAR2 (512) := '';

   -- ���������� ����
   SUBTYPE t_recdoc IS oper%ROWTYPE;

   TYPE t_listdocw IS TABLE OF operw.VALUE%TYPE
      INDEX BY VARCHAR2 (5);



   SUBTYPE t_docref IS oper.REF%TYPE;

   SUBTYPE t_docwtag IS VARCHAR2 (5); -- !!! ��� �� ��������� � �������� ��������

   SUBTYPE t_docwval IS operw.VALUE%TYPE;

   SUBTYPE t_docrec IS oper%ROWTYPE;

   TYPE t_docwrec IS RECORD (VALUE operw.VALUE%TYPE);

   TYPE t_docwlist IS TABLE OF t_docwrec
      INDEX BY VARCHAR2 (5);

   TYPE t_doc IS RECORD
   (
      docrec     t_docrec,
      doclistw   t_docwlist
   );

   SUBTYPE t_swmt IS sw_mt.mt%TYPE;


   --**************************************************************--
   --*            Generate SWIFT message from document            *--
   --**************************************************************--

   -----------------------------------------------------------------
   -- DOCMSG_PROCESS_DOCUMENT()
   --
   --     ��������� �������� ��������� �� ���������
   --
   --
   --
   --
   --     ���������:
   --
   --         p_ref      �������� ���������
   --
   --         p_flag     ����� ���������
   --
   --         p_errque   ������� ���������� ���������
   --                    � ������� ���������, ��� �������������
   --                    ������ ��� ������������ ���������
   --
   --
   PROCEDURE docmsg_process_document (p_ref      IN oper.REF%TYPE,
                                      p_flag     IN CHAR,
                                      p_errque   IN BOOLEAN DEFAULT FALSE);

   -----------------------------------------------------------------
   -- DOCMSG_PROCESS_DOCUMENT2()
   --
   --     ��������� �������� ��������� �� ���������
   --
   --
   --
   --
   --     ���������:
   --
   --         p_ref      �������� ���������
   --
   --         p_flag     ����� ���������
   --
   --
   PROCEDURE docmsg_process_document2 (p_ref    IN oper.REF%TYPE,
                                       p_flag   IN CHAR);

   --------------------------------------------------------------
   -- ENQUEUE_DOCUMENT()
   --
   --     ������� ���������� � ������� ���������, �� ��������
   --     ���������� ����� ������������ SWIFT ���������.  ���
   --     ���������� � ������� � ���������  �����������  ���.
   --     �������� - ���� ������������ SWIFT ���������
   --
   --     ���������:
   --
   --         p_ref      �������� ���������, ��� ���������� �
   --                    �������
   --         p_flag     ����� ��� �������� ���������, �����-
   --                    ������ ��� ������� ���� ���������
   --
   --         p_priority ��������� ���������
   --

   PROCEDURE enqueue_document (p_ref        IN oper.REF%TYPE,
                               p_flag       IN CHAR DEFAULT NULL,
                               p_priority   IN NUMBER DEFAULT NULL);


   --------------------------------------------------------------
   -- PROCESS_DOCUMENT()
   --
   --     ��������� ������������ SWIFT ���������  ��  ������
   --     ��������� �� ������� ����������.  ������ ���������
   --     ������������� ��� ����������� ��� CallBack �������
   --     ��������� ��������� �������.
   --
   --     ���������:
   --
   --
   --
   PROCEDURE process_document;


   --------------------------------------------------------------
   -- PROCESS_DOCUMENT_QUEUE()
   --
   --     ��������� ������� ������� ���������� ��� ������������
   --     SWIFT ���������.
   --
   --
   --
   --
   --
   PROCEDURE process_document_queue;


   --**************************************************************--
   --*           Generate SWIFT statement from document           *--
   --**************************************************************--

   --------------------------------------------------------------
   -- ENQUEUE_STMT_DOCUMENT()
   --
   --     ������� ���������� � ������� ���������, �� ��������
   --     ����������  �����  ������������  SWIFT  ������� (��
   --     ������ ������ MT900/MT910)
   --
   --
   --     ���������:
   --
   --         p_stmt     ����� �������, ��� ������������ ����-
   --                    ��� ����������� ��������
   --
   --         p_ref      �������� ���������, ��� ���������� �
   --                    �������
   --
   --         p_flag     ����� ��� �������� ���������, �����-
   --                    ������ ��� ������� ���� �������
   --
   --         p_priority ��������� ���������
   --

   PROCEDURE enqueue_stmt_document (p_stmt       IN sw_stmt.mt%TYPE,
                                    p_ref        IN oper.REF%TYPE,
                                    p_flag       IN CHAR DEFAULT NULL,
                                    p_priority   IN NUMBER DEFAULT NULL);


   -----------------------------------------------------------------
   -- PROCESS_STMT_QUEUE()
   --
   --     ��������� ������� ������� ���������� ��� ������������
   --     ������� SWIFT.
   --
   --
   --
   --
   --
   PROCEDURE process_stmt_queue;


   --**************************************************************--
   --*    Validate document req                                   *--
   --**************************************************************--

   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_VLDLISTRST()
   --
   --     ��������� ������� ������ ���������� ��� ��������
   --
   --
   --
   --
   PROCEDURE docmsg_document_vldlistrst;


   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_VLDLISTADD()
   --
   --     ��������� ���������� ��������� � ������ ���������� ���
   --     ��������
   --
   --
   --
   PROCEDURE docmsg_document_vldlistadd (p_docref IN t_docref);


   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_VLDLISTPRC()
   --
   --     ��������� ���������� �������� ��� ����������� � ������
   --     ���������� ��� ��������
   --
   --
   --
   PROCEDURE docmsg_document_vldlistprc;



   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_VALIDATE()
   --
   --     ��������� �������� ������������ ���. ���������� ���������
   --     �� �������� ����� ������������� ��������� SWIFT
   --
   --
   --
   --
   --
   PROCEDURE docmsg_document_validate (p_doc IN t_doc);

   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_VALIDATE()
   --
   --     ��������� �������� ������������ ���. ���������� ���������
   --     �� �������� ����� ������������� ��������� SWIFT
   --
   --
   --
   --
   --
   PROCEDURE docmsg_document_validate (p_ref IN oper.REF%TYPE);

   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_VLDTRANS()
   --
   --     ��������� �������� ������������ ���. ���������� ���������
   --     ����� ���������� �������������� �����
   --
   --
   --
   --
   --
   PROCEDURE docmsg_document_vldtrans (p_ref IN oper.REF%TYPE);


   -----------------------------------------------------------------
   -- ������������ ��103 � ���������                              --
   -----------------------------------------------------------------


   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_GET103COVHDR()
   --
   --     ��������� ������������/����������� ��103 � ��202
   --
   --     ���������:
   --
   --         p_docref        �������� ���������
   --
   --         p_senderbic     BIC-��� �����������
   --
   --         p_sendername    ������������ �����������
   --
   --         p_rcv103bic     BIC-��� ���������� ��103
   --
   --         p_rcv103name    ������������ ���������� ��103
   --
   --         p_rcv202bic     BIC-��� ���������� ��202
   --
   --         p_rcv202name    ������������ ���������� ��202
   --
   --
   PROCEDURE docmsg_document_get103covhdr (p_docref       IN     oper.REF%TYPE,
                                           p_senderbic       OUT VARCHAR2,
                                           p_sendername      OUT VARCHAR2,
                                           p_rcv103bic       OUT VARCHAR2,
                                           p_rcv103name      OUT VARCHAR2,
                                           p_rcv202bic       OUT VARCHAR2,
                                           p_rcv202name      OUT VARCHAR2);


   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_SET103COVHDR()
   --
   --     ��������� ����������� ��� ��������� ��103 � ��202
   --
   --     ���������:
   --
   --         p_docref        �������� ���������
   --
   --         p_rcv103bic     BIC-��� ���������� ��103
   --
   --         p_rcv202bic     BIC-��� ���������� ��202
   --
   --
   PROCEDURE docmsg_document_set103covhdr (p_docref      IN oper.REF%TYPE,
                                           p_rcv103bic   IN VARCHAR2,
                                           p_rcv202bic   IN VARCHAR2);

   -----------------------------------------------------------------
   -- GENMSG_MT199()
   --
   --     ��������� MT199 - ������ ����� ��������� � GPI
   --
   --     ���������:
   --
   --         p_swref        �������� ������������ ���������
   --
   --         p_statusid     �� ������� �� ����������� SW_STATUSES
   --

   PROCEDURE genmsg_mt199 (p_swref      IN sw_journal.swref%TYPE,
                           p_statusid   IN NUMBER);
    -----------------------------------------------------------------
   -- GENMSG_MT299()
   --
   --     ��������� MT299 - ������ ����� ��������� � GPI
   --
   --     ���������:
   --
   --         p_swref        �������� ������������ ���������
   --

   PROCEDURE genmsg_mt299 (p_swref      IN sw_journal.swref%TYPE);

   PROCEDURE generate_reject (p_uetr IN sw_journal.uetr%TYPE);
   
   PROCEDURE generate_mt192 (p_uetr IN sw_journal.uetr%TYPE, p_status_code varchar2, p_indm number, p_20 varchar2);
   
   PROCEDURE generate_mt196 (p_uetr IN sw_journal.uetr%TYPE, p_status_code varchar2, p_20 varchar2);
   
   PROCEDURE generate_acsc (p_uetr IN sw_journal.uetr%TYPE);
   
   PROCEDURE generate_manual_status (p_uetr IN sw_journal.uetr%TYPE, p_status_id sw_statuses.id%type);
   
   PROCEDURE job_send_reject;

   PROCEDURE job_send_mt199;

   PROCEDURE job_send_mt199_ru;

   PROCEDURE job_send_status_004;

   PROCEDURE job_send_mt199_tr;

   PROCEDURE job_send_mt199_ru_tr;

   PROCEDURE job_send_mt199_tr2client;

   PROCEDURE job_send_mt199_ru_tr2client;
   
   PROCEDURE job_send_mt199_tr2tr2client;
   
   PROCEDURE job_send_mt199_ru_tr2tr2client;

   PROCEDURE job_mt199_tr2tr2client2;
   
   PROCEDURE job_mt199_ru_tr2tr2client2;
   
   PROCEDURE job_mt199_ru_tr2tr2client3;
   
   PROCEDURE job_mt199_claims;
   
   PROCEDURE job_mt199_send_sms;


   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     ������� ���������� ������ � ������� ��������� ������
   --
   --
   --
   FUNCTION header_version
      RETURN VARCHAR2;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     ������� ���������� ������ � ������� ���� ������
   --
   --
   --
   FUNCTION body_version
      RETURN VARCHAR2;
END bars_swift_msg;
/
CREATE OR REPLACE PACKAGE BODY BARS.bars_swift_msg
IS
   VERSION_BODY              CONSTANT VARCHAR2 (64) := 'version 1.61 04.10.2018';
   VERSION_BODY_DEFS         CONSTANT VARCHAR2 (512) := '';

   TYPE t_strlist IS TABLE OF sw_operw.VALUE%TYPE;

   TYPE t_reflist IS TABLE OF oper.REF%TYPE;

   -- ����
   SUBTYPE t_swmsg_tag IS VARCHAR2 (2);

   SUBTYPE t_swmsg_tagopt IS VARCHAR2 (1);

   SUBTYPE t_swmsg_tagrpblk IS VARCHAR2 (10);

   SUBTYPE t_swmsg_tagvalue IS VARCHAR2 (1024);

   SUBTYPE t_swmsg_tagvallist IS t_strlist;


   SUBTYPE t_swmodelrec IS sw_model%ROWTYPE;



   CRLF                      CONSTANT CHAR (2) := CHR (13) || CHR (10);

   MODCODE                   CONSTANT VARCHAR2 (3) := 'SWT';
   PKG_CODE                  CONSTANT VARCHAR2 (100) := 'swtmsg';

   TAGSTATE_MANDATORY        CONSTANT VARCHAR2 (1) := 'M';
   TAGSTATE_OPTIONAL         CONSTANT VARCHAR2 (1) := 'O';

   MSG_MT103                 CONSTANT NUMBER := 103;
   MSG_MT202                 CONSTANT NUMBER := 202;



   MODPAR_MSGVALTRIM         CONSTANT params.par%TYPE := 'SWTMSGVT';
   MODPAR_MSGTRANSLATE       CONSTANT params.par%TYPE := 'SWTTRANS';

   MODVAL_MSGTRANSLATE_YES   CONSTANT params.val%TYPE := '1';
   MODVAL_MSGTRANSLATE_NO    CONSTANT params.val%TYPE := '0';

   BIC_GPI                   CONSTANT VARCHAR2(15):='TRCKCHZZXXX';


   g_vldList                          t_reflist;



   -----------------------------------------------------------------
   -- STR_WRAP()
   --
   --     ������� ���������� ������ �������� �� ���������
   --     ���������� �������� ���������� �����
   --
   --     ���������:
   --
   --         p_str       �������� ������
   --
   --         p_len       ����� ����� ������
   --
   FUNCTION str_wrap (p_str IN t_swmsg_tagvalue, p_len IN NUMBER)
      RETURN t_swmsg_tagvalue
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || 'strwrap';
      --
      l_value      t_swmsg_tagvalue;               /* �������������� ������ */
      l_tmp        t_swmsg_tagvalue;               /*       ��������� ����� */
      l_isfirst    BOOLEAN := TRUE;                /* ������� ������� ����� */
   --
   BEGIN
      bars_audit.trace ('%s: entry point par[0]=>%s par[1]=>%s',
                        p,
                        p_str,
                        TO_CHAR (p_len));

      IF (p_str IS NULL OR p_len IS NULL OR p_len = 0)
      THEN
         bars_audit.trace ('%s: succ end, nothing to do', p);
         RETURN p_str;
      END IF;

      l_value := NULL;
      l_tmp := p_str;

      WHILE (NVL (LENGTH (l_tmp), 0) > 0)
      LOOP
         IF (NOT l_isfirst)
         THEN
            l_value := l_value || CRLF;
         ELSE
            l_isfirst := FALSE;
         END IF;

         IF (LENGTH (l_tmp) > p_len)
         THEN
            l_value := l_value || SUBSTR (l_tmp, 1, p_len);
            l_tmp := SUBSTR (l_tmp, p_len + 1);
         ELSE
            l_value := l_value || l_tmp;
            l_tmp := NULL;
         END IF;
      END LOOP;

      bars_audit.trace ('%s: succ  end, return %s', p, l_value);
      RETURN l_value;
   END str_wrap;


   -----------------------------------------------------------------
   -- GET_PARAM_VALUE()
   --
   --     ������� ��������� �������� ����������������� ���������
   --     ���� ������ ��������� ���,  ��  �������  ����������
   --     �������� NULL
   --
   --     ���������:
   --
   --         p_parname    ��� (���) ��������� (params.par)
   --
   --
   FUNCTION get_param_value (p_parname IN params.par%TYPE)
      RETURN params.val%TYPE
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || 'getparval';
      --
      l_value      params.val%TYPE;             /* �������� ����. ��������� */
   --
   BEGIN
      bars_audit.trace ('%s: entry point par[0]=>%s', p, p_parname);

      SELECT val
        INTO l_value
        FROM params
       WHERE par = p_parname;

      bars_audit.trace ('%s: succ end, return %s', p, l_value);
      RETURN l_value;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         bars_audit.trace ('%s: succ end, parameter doesnt set', p);
         RETURN NULL;
   END get_param_value;


   -----------------------------------------------------------------
   -- GET_CHARSET_ID()
   --
   --     ������� ��������� ���� ������� �������������,
   --     ������������� ��� ���������� ����������.  ����
   --     ��� ���������� ������� ������������� ��
   --     ���������������, �� ����� ������������ �������
   --     � ����� TRANS
   --
   --     ���������:
   --
   --         p_bic        BIC-��� ���������
   --
   --
   --
   FUNCTION get_charset_id (p_bic IN sw_banks.bic%TYPE)
      RETURN sw_chrsets.setid%TYPE
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || 'getchrset';
      --
      l_charset    sw_chrsets.setid%TYPE;      /* ��� ������� ������������� */
   --
   BEGIN
      bars_audit.trace ('%s: entry point par[0]=>%s', p, p_bic);

      SELECT NVL (chrset, 'TRANS')
        INTO l_charset
        FROM sw_banks
       WHERE bic = p_bic;

      bars_audit.trace ('%s: succ end, return %s', p, l_charset);
      RETURN l_charset;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         bars_audit.trace ('%s: succ end, bank not found - return TRANS', p);
         RETURN 'TRANS';
   END get_charset_id;



   -----------------------------------------------------------------
   -- GENMSG_TRANSLATE_VALUE()
   --
   --     ������� ��������� �������������� �������� ����
   --
   --     ���������:
   --
   --         p_mt        ��� SWIFT ���������
   --
   --         p_tag       ��� SWIFT ���������
   --
   --         p_opt       ����� ���� SWIFT ���������
   --
   --         p_value     ������ ��� ��������������
   --
   --         p_transtab  ��� ������� �������������, ������� �����
   --                     �������������� ��� ��������������
   --
   --
   FUNCTION genmsg_translate_value (p_mt         IN sw_mt.mt%TYPE,
                                    p_tag        IN sw_tag.tag%TYPE,
                                    p_opt        IN sw_opt.opt%TYPE,
                                    p_value      IN sw_operw.VALUE%TYPE,
                                    p_transtab   IN sw_chrsets.setid%TYPE)
      RETURN sw_operw.VALUE%TYPE
   IS
      l_cnt     NUMBER;                     /*               ������ ������� */
      l_pos     NUMBER;                     /*      ������� �������� ������ */
      l_value   sw_operw.VALUE%TYPE := NULL; /* ������������������� �������� */
      l_tmp     sw_operw.VALUE%TYPE := NULL; /*              ��������� ����� */
   BEGIN
      bars_audit.trace ('translating value for mt=%s tag=%s opt=%s ...',
                        TO_CHAR (p_mt),
                        p_tag,
                        p_opt);

      --
      -- �������� ���� �������������� ��� ������� ����
      --
      SELECT COUNT (*)
        INTO l_cnt
        FROM sw_model
       WHERE     mt = p_mt
             AND tag = p_tag
             AND NVL (opt, '-') = NVL (p_opt, '-')
             AND trans = 'Y';

      IF (l_cnt = 0)
      THEN
         SELECT COUNT (*)
           INTO l_cnt
           FROM sw_model m, sw_model_opt o
          WHERE     m.mt = p_mt
                AND m.tag = p_tag
                AND m.mt = o.mt
                AND m.num = o.num
                AND NVL (o.opt, '-') = NVL (p_opt, '-')
                AND o.trans = 'Y';

         IF (l_cnt = 0)
         THEN
            bars_audit.trace (
               'translate flag not set for for mt=%s tag=% opt=%s.',
               TO_CHAR (p_mt),
               p_tag,
               p_opt);
            RETURN p_value;
         END IF;
      END IF;

      --
      -- ��� ���������� ������ ����� � ������ ������
      -- ����� ���� ����, ������� �� �����������������
      --
      IF (p_tag || p_opt IN ('50K',
                             '59',
                             '52D',
                             '53D',
                             '54D',
                             '55D',
                             '56D',
                             '57D',
                             '58D',
                             '53B',
                             '54B',
                             '55B',
                             '57B'))
      THEN
         bars_audit.trace ('attempt to exclude /account ...');

         IF (SUBSTR (p_value, 1, 1) = '/')
         THEN
            l_pos := INSTR (p_value, CRLF);

            IF (l_pos IS NOT NULL AND l_pos != 0)
            THEN
               l_value := SUBSTR (p_value, 1, l_pos + 1);
               l_tmp := SUBSTR (p_value, l_pos + 2);
            ELSE
               l_tmp := p_value;
            END IF;

            bars_audit.trace ('first line excluded from translating.');
         ELSE
            l_tmp := p_value;
            bars_audit.trace ('first line isnt include account, skip exlude');
         END IF;
      ELSE
         --
         -- �������� ����� ���������� � �������� �����,
         -- ������� ��������� � ������� "/"
         --
         bars_audit.trace ('looking for first /code/ ...');

         IF (SUBSTR (p_value, 1, 1) = '/')
         THEN
            -- ���� ����������� ���������
            l_pos := INSTR (SUBSTR (p_value, 2), '/');
            bars_audit.trace ('trailing symbol / is at position %s',
                              TO_CHAR (NVL (l_pos, -1)));

            --
            -- ����������� ��������� ������ ����
            -- �� ���� �� ������ � ����� ���� ��
            -- ������ ���� ��������
            --
            IF (    l_pos IS NOT NULL
                AND l_pos != 0
                AND l_pos < NVL (INSTR (SUBSTR (p_value, 2), CRLF), 99999)
                AND l_pos < NVL (INSTR (SUBSTR (p_value, 2), ' '), 99999))
            THEN
               l_value := SUBSTR (p_value, 1, l_pos);
               l_tmp := SUBSTR (p_value, l_pos + 1);

               bars_audit.trace ('code substring excluded to pos %s',
                                 TO_CHAR (l_pos));
            ELSE
               l_tmp := p_value;
               bars_audit.trace ('trailing symbol position rejected.');
            END IF;
         ELSE
            l_tmp := p_value;
            bars_audit.trace ('first symbol isnt /, skip step.');
         END IF;
      END IF;

      --
      -- ������ ��������������� ��������
      --
      l_value := l_value || bars_swift.StrToSwift (l_tmp, p_transtab);
      bars_audit.trace ('mt=%s tag=% opt=%s value translated.',
                        TO_CHAR (p_mt),
                        p_tag,
                        p_opt);

      RETURN l_value;
   END genmsg_translate_value;



   -----------------------------------------------------------------
   -- GENMSG_DOCUMENT_GETMTVLD()
   --
   --     ������� ��������� ���� ��������� �� �������� ���.
   --     ��������� ���������
   --
   --     ���������:
   --
   --         p_str    �������� ���. ��������� ���������
   --
   --
   FUNCTION genmsg_document_getmtvld (p_str IN t_docwval)
      RETURN t_swmt
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || '.gmdocgetmtvld';
      --
      l_mt         t_swmt;                       /*     ��� SWIFT ��������� */
      l_cnt        NUMBER;                       /*          ������ ������� */
   --
   BEGIN
      bars_audit.trace ('%s: entry point par[0]=>%s', p, p_str);

      -- ������ ���. �������� f: "MT XXX"
      IF (LENGTH (p_str) != 6 OR SUBSTR (p_str, 1, 3) != 'MT ')
      THEN
         bars_audit.trace ('%s: invalid req format', p);
         bars_error.raise_nerror (MODCODE, 'GENMSG_INVALID_MTFORMAT');
      END IF;

      BEGIN
         l_mt := TO_NUMBER (SUBSTR (p_str, 4, 3));
         bars_audit.trace ('%s: mt is %s', p, TO_CHAR (l_mt));
      EXCEPTION
         WHEN OTHERS
         THEN
            bars_audit.trace ('%s: invalid req format (mt value)', p);
            bars_error.raise_nerror (MODCODE, 'GENMSG_INVALID_MTFORMAT');
      END;

      -- ��������� �������� �� ����������� �����
      SELECT COUNT (*)
        INTO l_cnt
        FROM sw_mt
       WHERE mt = l_mt;

      IF (l_cnt = 0)
      THEN
         bars_audit.trace ('%s: unknown message format %s', TO_CHAR (l_mt));
         bars_error.raise_nerror (MODCODE,
                                  'GENMSG_UNKNOWN_MT',
                                  TO_CHAR (l_mt));
      END IF;

      bars_audit.trace ('%s: succ end, return %s', p, TO_CHAR (l_mt));
      RETURN l_mt;
   END genmsg_document_getmtvld;


   -----------------------------------------------------------------
   -- GENMSG_DOCUMENT_GETMT()
   --
   --     ������� ��������� ���� ���������, ������� ����-
   --     ������ ����� ������������ �� ���������� ���������.
   --     ��� ��������� ����������� �� ����������� �����
   --
   --     ���������:
   --
   --         p_ref    �������� ���������
   --
   --
   FUNCTION genmsg_document_getmt (p_ref IN t_docref)
      RETURN t_swmt
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || '.gmdocgetmt';
      --
      l_value      t_docwval;                    /* �������� ���. ��������� */
   --
   BEGIN
      bars_audit.trace ('%s: entry point par[0]=>%s', p, TO_CHAR (p_ref));

      BEGIN
         SELECT VALUE
           INTO l_value
           FROM operw
          WHERE REF = p_ref AND tag = RPAD ('f', 5, ' ');

         bars_audit.trace ('%s: document property "f" => %s', l_value);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.trace ('%s: document req "f" not found', p);
            bars_error.raise_nerror (MODCODE, 'GENMSG_REQMT_NOTFOUND');
      END;

      RETURN genmsg_document_getmtvld (l_value);
   END genmsg_document_getmt;



   -----------------------------------------------------------------
   -- GENMSG_DOCUMENT_GETMT()
   --
   --     ������� ��������� ���� ���������, ������� ����-
   --     ������ ����� ������������ �� ���������� ���������.
   --     ��� ��������� ����������� �� ����������� �����
   --
   --     ���������:
   --
   --         p_doc   ��������� � ����������� ���������
   --
   --
   FUNCTION genmsg_document_getmt (p_doc IN t_doc)
      RETURN t_swmt
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || '.gmdocgetmt';
      --
      l_value      t_docwval;                    /* �������� ���. ��������� */
   --
   BEGIN
      bars_audit.trace ('%s: entry point', p);

      BEGIN
         l_value := p_doc.doclistw ('f').VALUE;
         bars_audit.trace ('%s: property "f" => %s', p, l_value);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.trace ('%s: document property "f" not found', p);
            bars_error.raise_nerror (MODCODE, 'GENMSG_REQMT_NOTFOUND');
      END;

      bars_audit.trace ('%s: succ end, after validation', p);
      RETURN genmsg_document_getmtvld (l_value);
   END genmsg_document_getmt;



   -----------------------------------------------------------------
   -- GENMSG_DOCUMENT_GETMSGFLG()
   --
   --     ������� ��������� ������ ���������, ����������� � ���.
   --     ���������� ���������.
   --
   --     ���������:
   --
   --         p_ref    �������� ���������, �� �������� �����
   --                  ����������� ��������� ���������
   --
   --         p_tag    ��� ����� ���������
   --
   --
   FUNCTION genmsg_document_getmsgflg (p_ref   IN oper.REF%TYPE,
                                       p_tag   IN operw.tag%TYPE)
      RETURN operw.VALUE%TYPE
   IS
      l_value     sw_operw.VALUE%TYPE;
      l_docDRec   oper.d_rec%TYPE;
      l_pos       NUMBER;
   BEGIN
      bars_audit.trace ('query for document Ref=%s message flag %s',
                        TO_CHAR (p_ref),
                        p_tag);

      IF (p_tag = 'SWAHF')
      THEN
         bars_audit.trace ('message flag type selected');

         -- ���� �������� ����������� � ���� OPER.D_REC (#u)
         SELECT d_rec
           INTO l_docDRec
           FROM oper
          WHERE REF = p_ref;

         bars_audit.trace ('document field D_REC is %s', l_docDRec);

         l_pos := INSTR (l_docDRec, '#u');

         bars_audit.trace ('tag position in field is %s', TO_CHAR (l_pos));

         IF (l_docDRec IS NOT NULL AND l_pos != 0)
         THEN
            l_value :=
               SUBSTR (l_docDRec,
                       l_pos + 2,
                       INSTR (SUBSTR (l_docDRec, l_pos + 2), '#') - 1);
         END IF;
      END IF;

      bars_audit.trace ('Message flag is %s', l_value);

      RETURN l_value;
   END genmsg_document_getmsgflg;



   -----------------------------------------------------------------
   -- GENMSG_DOCUMENT_GETVALUE()
   --
   --     ������� ��������� ���. ��������� ���������. ����
   --     � ��������� ���  ����������  ���. ���������,  ��
   --     ������� ���������� �������� NULL
   --
   --     ���������:
   --
   --         p_ref    �������� ���������, �� �������� �����
   --                  ����������� ��������� ���������
   --
   --         p_tag    ��� ���. ���������
   --
   --
   FUNCTION genmsg_document_getvalue (p_ref   IN oper.REF%TYPE,
                                      p_tag   IN operw.tag%TYPE)
      RETURN operw.VALUE%TYPE
   IS
      l_retval   operw.VALUE%TYPE;     /* �������� ���. ��������� ��������� */
   BEGIN
      bars_audit.trace ('query for document req ref=%s tag=%s ...',
                        TO_CHAR (p_ref),
                        p_tag);

      SELECT VALUE
        INTO l_retval
        FROM operw
       WHERE REF = p_ref AND tag = p_tag;

      bars_audit.trace ('value for document ref=%s tag=%s is %s.',
                        TO_CHAR (p_ref),
                        p_tag,
                        l_retval);


      IF (get_param_value (MODPAR_MSGVALTRIM) = '0')
      THEN
         NULL;
      ELSE
         --
         -- ������� ���������� � ����������� ������� �
         -- ����� ����� ��������� ������� ������������ �������� ������
         --
         l_retval := LTRIM (RTRIM (l_retval));

         IF (SUBSTR (l_retval, -2, 2) = CRLF)
         THEN
            l_retval := SUBSTR (l_retval, 1, LENGTH (l_retval) - 2);
         END IF;
      END IF;


      RETURN l_retval;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         bars_audit.trace ('ref=%s tag=%s not found.',
                           TO_CHAR (p_ref),
                           p_tag);
         RETURN NULL;
   END genmsg_document_getvalue;



   -----------------------------------------------------------------
   -- GENMSG_DOCUMENT_GETVALUELIST()
   --
   --     ������� ��������� ������ �������� �� ������. �������� �
   --     ���������� ������ ������ ���� ��������� ��������� CRLF
   --
   --     ���������:
   --
   --         p_value  ������ ���������� ������ ��������,
   --                  ����������� ��������� CRLF
   --
   --

   FUNCTION genmsg_document_getvaluelist (p_value IN sw_operw.VALUE%TYPE)
      RETURN t_strlist
   IS
      l_list    t_strlist := t_strlist ();          /*      ������ �������� */
      l_value   sw_operw.VALUE%TYPE;                /*   ������ ��� ������� */
      l_tmp     sw_operw.VALUE%TYPE;                /*   ����� ��� �������� */
      l_pos     NUMBER;                             /*  ������� ����������� */
      l_cnt     NUMBER := 1;                        /*      ���-�� �������� */
   BEGIN
      bars_audit.trace ('generating list of values...');

      IF (p_value IS NOT NULL)
      THEN
         l_value := p_value;

         WHILE (l_value IS NOT NULL)
         LOOP
            l_pos := INSTR (l_value, CRLF);

            IF (l_pos != 0)
            THEN
               l_tmp := RTRIM (LTRIM (SUBSTR (l_value, 1, l_pos - 1)));
               l_value := SUBSTR (l_value, l_pos + 2);
            ELSE
               l_tmp := l_value;
               l_value := NULL;
            END IF;

            IF (l_tmp IS NOT NULL)
            THEN
               l_list.EXTEND;
               l_list (l_cnt) := l_tmp;
               l_cnt := l_cnt + 1;
            END IF;
         END LOOP;
      END IF;

      bars_audit.trace ('value list created, items count=>%s',
                        TO_CHAR (l_list.COUNT));
      RETURN l_list;
   END genmsg_document_getvaluelist;



   -----------------------------------------------------------------
   -- GENMSG_DOCUMENT_GETVALUE_EX()
   --
   --     ��������� ��������� �������� �����, ��� ������� ���������
   --     ����������� ���������. ��� ����� ����� � ������������
   --     ��������� ���������� ���� "SPEC"
   --
   --     ���������:
   --
   --         p_model   ������ ������������ ��� ������� ����
   --
   --         p_swref   �������� ������������ SWIFT ���������
   --
   --         p_ref     �������� ���������, �� �������� �����
   --                   ����������� ������������
   --
   --         p_recno   ���������� ����� ���������� ������������
   --                   ���� SWIFT ���������
   --
   --
   FUNCTION genmsg_document_getvalue_ex (
      p_model   IN     sw_model%ROWTYPE,
      p_swref   IN     sw_journal.swref%TYPE,
      p_ref     IN     oper.REF%TYPE,
      p_recno   IN     sw_operw.n%TYPE,
      p_opt     IN OUT sw_operw.opt%TYPE)
      RETURN sw_operw.VALUE%TYPE
   IS
      l_value       sw_operw.VALUE%TYPE := NULL; /* �������������� �������� ���� */
      l_amount      oper.s%TYPE;            /*      ���� 32A:         ����� */
      l_currCode    tabval.kv%TYPE;         /*      ���� 32A:    ��� ������ */
      l_docAccA     oper.nlsa%TYPE;         /*      ���� 50K:  ���� ������� */
      l_accNostro   accounts.acc%TYPE;      /*    ��� ������������ �������� */
   BEGIN
      bars_audit.trace ('special generation for tag %s...',
                        p_model.tag || p_model.opt);

      IF (    p_model.mt IN (103, 200, 202)
          AND p_model.tag = '32'
          AND p_model.opt = 'A')
      THEN
         SELECT TO_NUMBER (VALUE)
           INTO l_accNostro
           FROM operw
          WHERE REF = p_ref AND tag = 'NOS_A';

         SELECT s
           INTO l_amount
           FROM opldok
          WHERE REF = p_ref AND dk = 1 AND acc = l_accNostro;

         SELECT o.kv, TO_CHAR (o.vdat, 'yymmdd')
           INTO l_currCode, l_value
           FROM oper o, tabval t
          WHERE o.REF = p_ref AND o.kv = t.kv;

         l_value :=
               l_value
            || bars_swift.AmountToSwift (l_amount,
                                         l_currCode,
                                         TRUE,
                                         TRUE);
      ELSIF (p_model.mt = 103 AND p_model.tag = '23' AND p_model.opt = 'B')
      THEN
         l_value :=
            genmsg_document_getvalue (p_ref, p_model.tag || p_model.opt);

         IF (l_value IS NULL)
         THEN
            l_value := 'CRED';
         END IF;
      ELSIF (p_model.mt = 103 AND p_model.tag = '70' AND p_model.opt IS NULL)
      THEN
         l_value := genmsg_document_getvalue (p_ref, '70');

         IF (l_value IS NULL)
         THEN
            SELECT SUBSTR (nazn, 1, 120)
              INTO l_value
              FROM oper
             WHERE REF = p_ref;

            l_value := str_wrap (l_value, 30);
         END IF;
      ELSIF (p_model.mt = 103 AND p_model.tag = '50' AND p_model.opt = 'a')
      THEN
         l_value := genmsg_document_getvalue (p_ref, '50A');
         p_opt := 'A';

         IF (l_value IS NULL)
         THEN
            l_value := genmsg_document_getvalue (p_ref, '50K');
            p_opt := 'K';
         END IF;

         IF (l_value IS NULL)
         THEN
            l_value := genmsg_document_getvalue (p_ref, '50F');
            p_opt := 'F';
         END IF;

         -- �������� ������� �� ����� �����
         IF (l_value IS NULL)
         THEN
            -- ���� �������� �� ���, �� �������� ������
            -- ������������ ��� ���. ��������
            SELECT mfoa
              INTO l_value
              FROM oper
             WHERE REF = p_ref;

            IF (l_value != gl.aMFO)
            THEN
               RETURN NULL;
            END IF;

            -- �� ������ ����� � ���� ������ �������
            -- ������� � ��� ���������
            SELECT o.nlsa,
                   SUBSTR (c.nmkk, 1, 30) || ' ' || SUBSTR (c.adr, 1, 90)
              INTO l_docAccA, l_value
              FROM oper o,
                   accounts a,
                   cust_acc ca,
                   customer c
             WHERE     o.REF = p_ref
                   AND a.nls = o.nlsa
                   AND a.kv = o.kv
                   AND a.acc = ca.acc
                   AND c.rnk = ca.rnk;

            l_value := '/' || l_docAccA || CRLF || str_wrap (l_value, 30);
            p_opt := 'K';
         END IF;
      ELSIF (p_model.mt = 202 AND p_model.tag = '21' AND p_model.opt IS NULL)
      THEN
         l_value :=
            genmsg_document_getvalue (p_ref, p_model.tag || p_model.opt);

         IF (l_value IS NULL)
         THEN
            l_value := 'NONREF';
         END IF;
      -- elsif (    p_model.mt  = 103
      --       and p_model.tag = '33'
      --       and p_model.opt = 'B' ) then
      --
      --     l_value := genmsg_document_getvalue(p_ref, p_model.tag || p_model.opt);
      --
      --     if (l_value is null) then
      --
      --         -- ��������� ���� �� ���� 71F, 71G
      --         l_val71g := genmsg_document_getvalue(p_ref, '71G');
      --         l_val71f := genmsg_document_getvalue(p_ref, '71F');
      --
      --     end if;

      ELSE
         bars_audit.error (
               '��������������� ��� ��� ������������� ('
            || p_model.tag
            || p_model.opt
            || ')');
         raise_application_error (
            -20781,
               '\040 ���������������� ��� ��� ������������� ('
            || p_model.tag
            || p_model.opt
            || ')');
      END IF;

      bars_audit.trace ('special generated value=>%s', l_value);

      RETURN l_value;
   END genmsg_document_getvalue_ex;



   -----------------------------------------------------------------
   -- GENMSG_DOCUMENT_CHECK()
   --
   --     ��������� ��������� �������� ���������, ��
   --     ������������ �� ���� SWIFT-����������
   --
   --     ���������:
   --
   --         p_mt     ��� SWIFT ���������
   --
   --         p_ref    �������� ���������, �� �������� �����
   --                  ����������� ������������ ���������
   --
   --         p_flag   ���� ��������� ������, ���� ��������
   --                  �������� TRUE, �� � ������ ����������
   --                  �� ��������� ����� ��������� ���������
   --                  ����� ������������� ������
   --
   PROCEDURE genmsg_document_check (p_mt     IN sw_mt.mt%TYPE,
                                    p_ref    IN oper.REF%TYPE,
                                    p_flag   IN BOOLEAN)
   IS
      l_ref         oper.REF%TYPE;  /*                   �������� ��������� */
      l_mt          sw_mt.mt%TYPE;  /* ��� ��������� SWIFT ��� ������������ */
      l_accNostro   accounts.acc%TYPE; /*     ������������� ������������ ����� */
      l_cnt         NUMBER;         /*                       ������ ������� */
      l_mtfinflag   sw_mt.mt%TYPE;  /*      ���� FIN ������� ���� ��������� */
   BEGIN
      bars_audit.trace ('document checking ...');
      bars_audit.trace (
            'par[0]=>'
         || TO_CHAR (p_mt)
         || ' par[1]=>'
         || TO_CHAR (p_ref)
         || ' par[2]=> <unk>');

      --
      -- ������ ���� ��������
      --
      bars_audit.trace (
         'checking document with ref=' || TO_CHAR (p_ref) || '...');

      BEGIN
         SELECT REF
           INTO l_ref
           FROM oper
          WHERE REF = p_ref;

         bars_audit.trace ('document ref' || TO_CHAR (p_ref) || ' found.');
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.error (
                  '�������� ref='
               || TO_CHAR (p_ref)
               || ' �� ������');
            raise_application_error (
               -20781,
                  '\001 �������� �� ������ Ref='
               || TO_CHAR (p_ref));
      END;

      --
      -- ��������� ���� ������������ ���������
      --
      l_mt := genmsg_document_getmt (p_ref => p_ref);

      --
      -- ���� ������ ������������, �� ���������
      --
      bars_audit.trace ('checking message type eqv...');

      IF (p_mt IS NOT NULL)
      THEN
         IF (p_mt != l_mt)
         THEN
            bars_audit.error (
                  '��� ��������� �� ������������� ��������� ('
               || TO_CHAR (l_mt)
               || '!='
               || TO_CHAR (p_mt)
               || ')');
            raise_application_error (
               -20781,
                  '\004 ��� ��������� �� ������������� ��������� ('
               || l_mt
               || '!='
               || p_mt
               || ')');
         END IF;

         bars_audit.trace ('message type check passed.');
      ELSE
         bars_audit.trace ('skip message type check (first parameter null).');
      END IF;

      --
      -- �� ����������� ����� ��������� ��������� �������� �� ���
      -- � �������� ���� �������� ������� �������� (����������
      -- ��� ������ ����� ��� �������������� ��������� � ����
      -- ��� ����������� � ������� ��������)
      --
      bars_audit.trace ('query message type FIN flag...');

      SELECT TO_NUMBER (SUBSTR (flag, 1, 1))
        INTO l_mtfinflag
        FROM sw_mt
       WHERE mt = l_mt;

      bars_audit.trace ('message type FIN flag is %s.',
                        TO_CHAR (l_mtfinflag));

      --
      -- ��������� ������������� �� ���������
      -- ������� ���� �� ����� ���������
      --

      SELECT COUNT (*)
        INTO l_cnt
        FROM sw_oper l, sw_journal j
       WHERE l.REF = p_ref AND l.swref = j.swref AND j.mt = l_mt;

      IF (l_cnt != 0)
      THEN
         bars_audit.error (
               '�� ������� ��������� ��� ������������ ��������� (��� '
            || TO_CHAR (l_mt)
            || '). Ref='
            || TO_CHAR (p_ref));
         raise_application_error (
            -20781,
               '\005 �� ������� ��������� ��� ������������ ��������� (��� '
            || TO_CHAR (l_mt)
            || '). Ref='
            || TO_CHAR (p_ref));
      END IF;

      -- ��� ���������, ������� ������ ������ ������
      -- �������� FIN ���� ������ ���� ����� 1
      IF (l_mtfinflag = 1)
      THEN
         -- ��������� �������� �� ������ ��������
         bars_audit.trace ('looking for doc req NOS_A ...');

         l_accNostro := TO_NUMBER (genmsg_document_getvalue (p_ref, 'NOS_A'));

         bars_audit.trace ('doc req NOS_A=%s', TO_CHAR (l_accNostro));

         IF (NVL (l_accNostro, 0) = 0)
         THEN
            bars_audit.error (
                  '�� ��������� �������� ������� �������� Ref='
               || TO_CHAR (p_ref));
            raise_application_error (
               -20781,
                  '\006 �� ��������� �������� ������� �������� Ref='
               || TO_CHAR (p_ref));
         END IF;

         --
         -- �� ������ ������ �������� ������������ �����
         --
         bars_audit.trace ('checking for acc=%s ...', TO_CHAR (l_accNostro));

         BEGIN
            SELECT acc
              INTO l_accNostro
              FROM accounts
             WHERE acc = l_accNostro;

            bars_audit.trace ('account acc=%s found.', TO_CHAR (l_accNostro));
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               bars_audit.error (
                     '�� ������ ����������� �������. Acc='
                  || TO_CHAR (l_accNostro));
               raise_application_error (
                  -20781,
                     '\007 �� ������ ����������� �������. Acc='
                  || TO_CHAR (l_accNostro));
         END;

         -- ��������� ���� �� ��������� �������� �� ��������
         bars_audit.trace ('checking transaction on NOSTRO ...');

         SELECT COUNT (*)
           INTO l_cnt
           FROM opldok
          WHERE REF = p_ref AND dk = 1 AND acc = l_accNostro;

         bars_audit.trace ('transaction count=%s', TO_CHAR (l_cnt));

         IF (l_cnt != 1)
         THEN
            bars_audit.error (
                  '�� ��������� �������� �� �������� ��� ��������� ��������� ��������. Ref='
               || TO_CHAR (p_ref));
            raise_application_error (
               -20781,
                  '\008 �� ��������� �������� �� �������� ��� ��������� ��������� ��������. Ref='
               || TO_CHAR (p_ref));
         END IF;
      END IF;

      bars_audit.trace ('document check complete ref=%s', TO_CHAR (p_ref));
   END genmsg_document_check;



   -----------------------------------------------------------------
   -- GENMSG_DOCUMENT_INSTAG()
   --
   --     ��������� ������� ���� ��������� �� ���������� ��������
   --     ��� �� ���������������� ���. ��������� ���������
   --
   --
   --     ���������:
   --
   --         p_model      �������� ���� � ������������ ���������
   --
   --         p_swref      �������� ������������ SWIFT ���������
   --
   --         p_ref        �������� ���������, �� �������� �����
   --                      ������ ������������  SWIFT  ���������
   --
   --         p_recno      ����� ������ � ����������� ���������
   --
   --         p_opt        ����� ����
   --
   --         p_value      �������� ����
   --
   --         p_insflag    ���� �������  ��������,  �����������
   --                      � ��������� p_value ������ ���������
   --                      ��� �� ���. ����������
   --
   --         p_usetrans   ���� ������������� ��������������
   --
   --         p_transtable ��� ������� ��������������
   --

   PROCEDURE genmsg_document_instag (
      p_model        IN     sw_model%ROWTYPE,
      p_swref        IN     sw_journal.swref%TYPE,
      p_ref          IN     oper.REF%TYPE,
      p_recno        IN OUT sw_operw.n%TYPE,
      p_opt          IN     sw_opt.opt%TYPE,
      p_value        IN     sw_operw.VALUE%TYPE,
      p_insflag      IN     BOOLEAN,
      p_usetrans     IN     BOOLEAN DEFAULT FALSE,
      p_transtable   IN     sw_chrsets.setid%TYPE DEFAULT NULL)
   IS
      l_ins     BOOLEAN := FALSE;
      l_opt     sw_opt.opt%TYPE;
      l_value   sw_operw.VALUE%TYPE;
      l_cnt     NUMBER;
      l_list    t_strlist;
   BEGIN
      bars_audit.trace ('generating tag=%s opt=%s...',
                        p_model.tag,
                        p_model.opt);

      --
      -- ���� ���� ������� ���������
      --
      IF (p_insflag IS NOT NULL)
      THEN
         bars_audit.trace ('flag SPECVAL is set ...');

         --
         -- ���� ����� ��������� ������� (�������� FALSE)
         --
         IF (p_insflag)
         THEN
            l_ins := TRUE;
            l_value := p_value;

            bars_audit.trace ('flag SPECVAL=true, inserting ...');

            bars_audit.trace ('validating tag option ...');

            IF (LOWER (p_model.opt) = p_model.opt)
            THEN
               -- ��������� ������������ �����
               SELECT COUNT (*)
                 INTO l_cnt
                 FROM sw_model_opt
                WHERE     mt = p_model.mt
                      AND num = p_model.num
                      AND opt = NVL (p_opt, '-');

               IF (l_cnt = 0)
               THEN
                  bars_audit.error (
                        '����� '
                     || NVL (p_opt, 'NULL')
                     || ' ����������� ��� ���� '
                     || p_model.tag);
                  raise_application_error (
                     -20781,
                        '\050 ����� '
                     || p_opt
                     || ' ����������� ��� ���� '
                     || p_model.tag);
               END IF;

               l_opt := p_opt;
            ELSE
               l_opt := p_model.opt;
            END IF;

            bars_audit.trace ('option validated (opt=%s)', l_opt);
         ELSE
            bars_audit.trace ('flag SPECVAL=false, skip insert');
            RETURN;
         END IF;
      --
      -- ���� 20 ������ ��������� � ���������� � ���������
      --
      ELSIF (p_model.tag = '20' AND p_model.opt IS NULL)
      THEN
         SELECT trn
           INTO l_value
           FROM sw_journal
          WHERE swref = p_swref;

         l_opt := p_model.opt;
         l_ins := TRUE;

         bars_audit.trace ('special block for field 20 =>%s', l_value);
      ELSE
         --
         -- �������� �������� �� ���. ��������� ���������
         -- ���� ���������� �����, ��������� �����, ��
         -- ����� ����� ������ ����������� �� ����������
         -- ��� ����� ����
         --
         bars_audit.trace ('query value from document req ...');

         IF (LOWER (p_model.opt) = p_model.opt)
         THEN
            bars_audit.trace ('selecting from option list...');

            FOR o IN (  SELECT opt
                          FROM sw_model_opt
                         WHERE mt = p_model.mt AND num = p_model.num
                      ORDER BY opt)
            LOOP
               IF (o.opt = '-')
               THEN
                  l_opt := NULL;
               ELSE
                  l_opt := o.opt;
               END IF;

               l_value :=
                  genmsg_document_getvalue (p_ref, p_model.tag || l_opt);

               bars_audit.trace ('document req %s%s value=>',
                                 p_model.tag,
                                 l_opt,
                                 l_value);

               IF (l_value IS NOT NULL)
               THEN
                  l_ins := TRUE;
                  bars_audit.trace ('selected option is %s', l_opt);
                  EXIT;
               END IF;
            END LOOP;
         ELSE
            l_opt := p_model.opt;
            l_value := genmsg_document_getvalue (p_ref, p_model.tag || l_opt);

            bars_audit.trace ('value from document req =>%s', l_value);

            IF (l_value IS NULL)
            THEN
               l_ins := FALSE;
            ELSE
               l_ins := TRUE;
            END IF;
         END IF;
      END IF;

      bars_audit.trace ('inserting tag=%s opt=%s...', p_model.tag, l_opt);

      IF (l_ins)
      THEN
         -- ���� ����������, �� �������� ��������������
         IF (p_useTrans)
         THEN
            l_value :=
               genmsg_translate_value (p_model.mt,
                                       p_model.tag,
                                       l_opt,
                                       l_value,
                                       p_transTable);
         END IF;

         IF (p_model.rpblk IS NULL)
         THEN
            bars_swift.in_swoperw (p_swref,
                                   p_model.tag,
                                   p_model.seq,
                                   p_recno,
                                   l_opt,
                                   l_value);
            p_recno := p_recno + 1;
            bars_audit.trace ('tag=%s opt=%s inserted.', p_model.tag, l_opt);
         ELSIF (p_model.rpblk = 'RI')
         THEN
            l_list := genmsg_document_getvaluelist (l_value);

            FOR i IN 1 .. l_list.COUNT
            LOOP
               bars_swift.in_swoperw (p_swRef,
                                      p_model.tag,
                                      p_model.seq,
                                      p_recno,
                                      l_opt,
                                      l_list (i));
               p_recno := p_recno + 1;
               bars_audit.trace ('tag=%s opt=%s inserted.',
                                 p_model.tag,
                                 l_opt);
            END LOOP;
         ELSE
            raise_application_error (
               -20999,
               '\SWT implementation restriction - unknown repeated flag');
         END IF;
      ELSE
         bars_audit.trace ('tag=%s opt=%s skipped.', p_model.tag, l_opt);
      END IF;
   END genmsg_document_instag;



   -----------------------------------------------------------------
   -- GENMSG_DOCUMENT_ABSTRACT()
   --
   --     ��������� �������� SWIFT ��������� �� ����
   --     ������������ ��������� ������� ����
   --
   --

   PROCEDURE genmsg_document_abstract (p_ref    IN oper.REF%TYPE,
                                       p_flag   IN CHAR)
   IS
      -- ������ �� ������������ ���������
      CURSOR cursModel (p_mt IN NUMBER)
      IS
         SELECT *
           FROM sw_model
          WHERE mt = p_mt;

      l_mt               sw_mt.mt%TYPE; /*           ��� ��������� �� ��������� */
      l_mtfinflag        NUMBER (1); /* �������� ����� ����������� ��������� */
      l_currCode         tabval.kv%TYPE; /*                 ��� ������ ��������� */
      l_accNostro        accounts.acc%TYPE; /*     ������������� ������������ ����� */
      l_retCode          NUMBER;    /* ��� �������� ������� �������� �����. */
      l_recModel         sw_model%ROWTYPE; /*               ������ ������ �������� */
      l_cnt              NUMBER;    /*                       ������ ������� */

      l_sender           sw_journal.sender%TYPE; /*        ���������:    BIC ����������� */
      l_receiver         sw_journal.receiver%TYPE; /*        ���������:    BIC ����������  */
      l_currency         sw_journal.currency%TYPE; /*        ���������:         ��� ������ */
      l_amount           sw_journal.amount%TYPE; /*        ���������:    ����� ��������� */
      l_dateValue        sw_journal.vdate%TYPE; /*        ���������: ���� ������������� */

      l_useTrans         BOOLEAN;   /*     ���� ������������� ������������� */
      l_transTable       sw_chrsets.setid%TYPE; /*            ��� ������� ������������� */

      l_swRef            sw_journal.swref%TYPE; /*             �������� ��������� SWIFT */
      l_value            sw_operw.VALUE%TYPE; /*                        �������� ���� */
      l_recno            sw_operw.n%TYPE; /*              ���������� ����� ������ */
      l_opt              sw_operw.opt%TYPE; /*                    ����� ���� ������ */

      l_msgAppHdrFlags   sw_journal.app_flag%TYPE; /*                    ����� ��������� */

      l_guid             VARCHAR2 (36);
   BEGIN
      bars_audit.trace ('genmsg_abstract: entry point');
      bars_audit.trace ('par[0]=>%s par[1]=%s', TO_CHAR (p_ref), p_flag);
      bars_audit.info (
            '�������� SWIFT-��������� (�����) �� ��������� ref='
         || TO_CHAR (p_ref)
         || '...');

      -- ��������� ������������ ���������
      genmsg_document_check (p_mt => NULL,    /* ��� ��������� �� ��������� */
                                          p_ref => p_ref, p_flag => TRUE); /* ���������� ���������� ��� ������� */

      -- �������� ��� ���������
      l_mt := genmsg_document_getmt (p_ref => p_ref);

      bars_audit.trace ('document message type is %s', TO_CHAR (l_mt));

      -- �������� ������� ����������� ���������
      SELECT TO_NUMBER (SUBSTR (flag, 1, 1))
        INTO l_mtfinflag
        FROM sw_mt
       WHERE mt = l_mt;

      bars_audit.trace ('message type FIN is %s', TO_CHAR (l_mtfinflag));

      --
      -- ��������� ���� �� ������������
      --
      SELECT COUNT (*)
        INTO l_cnt
        FROM sw_model
       WHERE mt = l_mt;

      IF (l_cnt = 0)
      THEN
         bars_audit.trace ('Error! message description not found');
         raise_application_error (
            -20781,
            '\998 ��� ������������ ������� ���� ���������');
      END IF;

      --
      -- ��������� ��������� ���������
      --
      bars_audit.trace ('get message header req ...');

      l_sender := bars_swift.get_ourbank_bic;
      bars_audit.trace ('message sender => %s', l_sender);

      --
      -- ���� ��������� �� ����������, �� ����������
      -- ����� ���������� � ���. ��������� SWRCV
      --
      IF (l_mtfinflag = 0)
      THEN
         --
         -- ���������� ���������� �� ��������� SWRCV
         --

         l_receiver :=
            SUBSTR (genmsg_document_getvalue (p_ref, 'SWRCV'), 1, 11);

         IF (l_receiver IS NULL)
         THEN
            bars_audit.trace (
               'receiver BIC not found (req SWRCV), throw error...');
            bars_audit.error (
                  '�� ������ BIC ����� ���������� �� ���. ��������� SWRCV Ref='
               || TO_CHAR (p_ref));
            raise_application_error (
               -20781,
                  '\002 �� ������ BIC ����� ����������. �������� Ref='
               || TO_CHAR (p_ref));
         END IF;

         --msgvld_validate_bic(l_receiver);
         bars_audit.trace ('message receiver => %s', l_receiver);

         l_currency := NULL;
         l_amount := 0;
         l_dateValue := bankdate_g;
      ELSE
         --
         -- ���������� ���������� �� ������������ ��������
         --

         SELECT TO_NUMBER (VALUE)
           INTO l_accNostro
           FROM operw
          WHERE REF = p_ref AND tag = 'NOS_A';


         BEGIN
            SELECT bic
              INTO l_receiver
              FROM bic_acc
             WHERE acc = l_accNostro;

            bars_audit.trace ('receiver BIC=> %s', l_receiver);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               bars_audit.trace (
                  'receiver BIC not found for acc=%s, throw error...',
                  TO_CHAR (l_accNostro));
               bars_audit.error (
                     '�� ������ BIC ����� ���������� �� ������������ �������� Ref='
                  || TO_CHAR (p_ref));
               raise_application_error (
                  -20781,
                     '\002 �� ������ BIC ����� ����������. �������� Ref='
                  || TO_CHAR (p_ref));
         END;

         --
         -- ����� ���������� �� �������� �� ����������� �������
         --
         SELECT s
           INTO l_amount
           FROM opldok
          WHERE REF = p_ref AND dk = 1 AND acc = l_accNostro;

         --
         -- ���� ������������� �� �������� ���� ������������� ���������
         --
         SELECT o.kv, t.lcv, o.vdat
           INTO l_currCode, l_currency, l_dateValue
           FROM oper o, tabval t
          WHERE o.REF = p_ref AND o.kv = t.kv;
      END IF;

      --
      -- ���������� ������� �������������, ������� ����� ������������
      --
      --    ���� ��������� ��� �������������� � ������������ ��������
      --    ����� RUR6, �� � ���.��������� 20 ����� �������� "+"
      --    (?#?&@&*! ��������� - � ���� �������� ����� ������ ����?)
      --
      SELECT COUNT (*)
        INTO l_cnt
        FROM operw
       WHERE REF = p_ref AND tag = '20' AND VALUE = '+';

      bars_audit.trace ('result for looking 20=+ is %s', TO_CHAR (l_cnt));

      IF (l_cnt != 0)
      THEN
         --
         -- ������������� ���������������� �������
         --
         l_transTable := 'RUR6';
         l_useTrans := FALSE;
      ELSE
         --
         -- ���������� ����� ����������� ������������� - �� �����
         -- ���������� ��������� ���������� ������� �������������
         --
         l_transTable := get_charset_id (l_receiver);
         l_useTrans := TRUE;
      END IF;

      bars_audit.trace ('message translate table is %s', l_transTable);

      --
      -- ���������� ������ �� ����� ��������� �� ��������� SWAHF
      --
      l_msgAppHdrFlags := genmsg_document_getmsgflg (p_ref, 'SWAHF');

      bars_audit.trace ('application header flags is %s', l_msgAppHdrFlags);


      bars_audit.trace ('create message header ...');

      --
      -- ������� ��������� (��������)
      --

      l_guid := bars_swift.generate_uetr;

      bars_swift.In_SwJournalInt (
         ret_         => l_retCode,
         swref_       => l_swRef,
         mt_          => l_mt,
         mid_         => NULL,
         page_        => NULL,
         io_          => 'I',
         sender_      => l_sender,
         receiver_    => l_receiver,
         transit_     => NULL,
         payer_       => NULL,
         payee_       => NULL,
         ccy_         => l_currency,
         amount_      => l_amount,
         accd_        => NULL,
         acck_        => NULL,
         vdat_        => TO_CHAR (l_dateValue, 'MM/DD/YYYY'),
         idat_        => TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI'),
         flag_        => 'L',
         trans_       => l_transTable,
         apphdrflg_   => l_msgAppHdrFlags,
         sti_         => '001',
         uetr_        => LOWER (l_guid));

      -- ������������� ������� ��� ����������� ���������
      UPDATE sw_journal
         SET date_pay = SYSDATE
       WHERE swref = l_swRef;

      bars_audit.trace ('message header created SwRef=> %s',
                        TO_CHAR (l_swRef));

      -- ����������� ��������� � ���������
      INSERT INTO sw_oper (REF, swref)
           VALUES (p_ref, l_swRef);

      bars_audit.trace ('message linked with document.');
      bars_audit.trace ('write message details ...');

      -- ��������� ������ ���������
      OPEN cursModel (l_mt);

      l_recno := 1;

      LOOP
         FETCH cursModel INTO l_recModel;

         EXIT WHEN cursModel%NOTFOUND;

         --
         -- ��� �����, ��������� ������������� �������� �������
         --
         IF (l_recModel.spec = 'Y')
         THEN
            l_value :=
               genmsg_document_getvalue_ex (l_recModel,
                                            l_swRef,
                                            p_ref,
                                            l_recno,
                                            l_opt);

            IF (l_value IS NOT NULL)
            THEN
               genmsg_document_instag (l_recModel,
                                       l_swRef,
                                       NULL,
                                       l_recno,
                                       l_opt,
                                       l_value,
                                       TRUE,
                                       l_useTrans,
                                       l_transTable);
            END IF;
         ELSE
            genmsg_document_instag (l_recModel,
                                    l_swRef,
                                    p_ref,
                                    l_recno,
                                    NULL,
                                    NULL,
                                    NULL,
                                    l_useTrans,
                                    l_transTable);
         END IF;
      END LOOP;

      CLOSE cursModel;

      bars_audit.trace ('message generated swref=%s.', TO_CHAR (l_swRef));
      bars_audit.info (
            '������������ ��������� SwRef='
         || TO_CHAR (l_swRef));
   END genmsg_document_abstract;


   -----------------------------------------------------------------
   -- GENMSG_DOCUMENT_MT103()
   --
   --     ��������� �������� SWIFT ��������� MT103 � ���������
   --     (MT103 + MT202)
   --
   --
   --
   PROCEDURE genmsg_document_mt103 (p_ref IN oper.REF%TYPE, p_flag IN CHAR)
   IS
      -- ������ �� ������������ ���������
      CURSOR cursModel (p_mt IN NUMBER)
      IS
         SELECT *
           FROM sw_model
          WHERE mt = p_mt;

      l_mt               sw_mt.mt%TYPE := 103; /*           ��� ��������� �� ��������� */
      l_mt2              sw_mt.mt%TYPE := 202; /*               ��� ��������� �������� */

      l_currCode         tabval.kv%TYPE; /*                 ��� ������ ��������� */
      l_accNostro        accounts.acc%TYPE; /*     ������������� ������������ ����� */
      l_retCode          NUMBER;    /* ��� �������� ������� �������� �����. */
      l_recModel         sw_model%ROWTYPE; /*               ������ ������ �������� */
      l_cnt              NUMBER;    /*                       ������ ������� */

      l_sender           sw_journal.sender%TYPE; /*        ���������:    BIC ����������� */
      l_receiver         sw_journal.receiver%TYPE; /*        ���������:    BIC ����������  */
      l_currency         sw_journal.currency%TYPE; /*        ���������:         ��� ������ */
      l_amount           sw_journal.amount%TYPE; /*        ���������:    ����� ��������� */
      l_dateValue        sw_journal.vdate%TYPE; /*        ���������: ���� ������������� */

      l_useTrans         BOOLEAN;   /*     ���� ������������� ������������� */
      l_transTable       sw_chrsets.setid%TYPE; /*            ��� ������� ������������� */

      l_swRef            sw_journal.swref%TYPE; /*     �������� ��������� SWIFT (��103) */
      l_swRef2           sw_journal.swref%TYPE; /*     �������� ��������� SWIFT (��202) */

      l_value            sw_operw.VALUE%TYPE; /*                        �������� ���� */
      l_recno            sw_operw.n%TYPE; /*              ���������� ����� ������ */
      l_opt              sw_operw.opt%TYPE; /*                    ����� ���� ������ */
      l_pos              NUMBER;    /*                              ������� */

      l_msgAppHdrFlags   sw_journal.app_flag%TYPE; /*                    ����� ��������� */

      l_mt103rcv         CHAR (11); /*   BIC ��� ���������� ��������� MT103 */
      l_mt202rcv         CHAR (11); /*   BIC ��� ���������� ��������� MT202 */
      l_fld56a           sw_operw.VALUE%TYPE; /*    �������� ���� 56A ��������� ��103 */
      l_fld52a           sw_operw.VALUE%TYPE; /*    �������� ���� 52A ��������� ��103 */
      l_fld56bic         CHAR (11); /*             BIC ��� ���������� (56�) */
      l_fld57a           sw_operw.VALUE%TYPE; /*    �������� ���� 57A ��������� ��103 */
      l_fld59a           sw_operw.VALUE%TYPE; /*    �������� ���� 59A ��������� ��103 */
      l_guid             VARCHAR2 (36);
   BEGIN
      bars_audit.trace ('genmsg_mt103: entry point');
      bars_audit.trace ('par[0]=>%s par[1]=%s', TO_CHAR (p_ref), p_flag);
      bars_audit.info (
            '�������� SWIFT-��������� MT103 �� ��������� ref='
         || TO_CHAR (p_ref)
         || '...');


      l_guid := bars_swift.generate_uetr;

      -- ���������� ������� ������������� ������������ ������� (���� = '2')
      IF (p_flag IS NULL OR p_flag != '2')
      THEN
         bars_audit.error ('internal error - expected flag=2');
         raise_application_error (-20999, 'internal error - expected flag=2');
      END IF;

      -- ��������� ������������ ���������
      genmsg_document_check (p_mt => 103, p_ref => p_ref, p_flag => TRUE); /* ���������� ���������� ��� ������� */


      -- �������� ����������� ���������
      l_mt103rcv :=
         RPAD (LTRIM (RTRIM (genmsg_document_getvalue (p_ref, 'SWRCV'))),
               11,
               'X');
      bars_audit.trace ('%s: MT103 receiver is %s', l_mt103rcv);

      l_mt202rcv :=
         RPAD (LTRIM (RTRIM (genmsg_document_getvalue (p_ref, 'NOS_B'))),
               11,
               'X');
      bars_audit.trace ('%s: MT103 receiver is %s', l_mt202rcv);


      --
      -- ��������� ���� �� ������������
      --
      SELECT COUNT (*)
        INTO l_cnt
        FROM sw_model
       WHERE mt = l_mt;

      IF (l_cnt = 0)
      THEN
         bars_audit.trace ('Error! message description not found');
         raise_application_error (
            -20781,
            '\998 ��� ������������ ��������� MT103');
      END IF;

      bars_audit.trace ('message MT103 description found.');

      SELECT COUNT (*)
        INTO l_cnt
        FROM sw_model
       WHERE mt = l_mt2;

      IF (l_cnt = 0)
      THEN
         bars_audit.trace ('Error! message description not found');
         raise_application_error (
            -20781,
            '\998 ��� ������������ ��������� MT202');
      END IF;

      bars_audit.trace ('message MT202 description found.');

      --
      -- ��������� ��������� ��������� (MT103)
      --
      bars_audit.trace ('get message MT103 header req ...');

      l_sender := bars_swift.get_ourbank_bic;
      bars_audit.trace ('message sender => %s', l_sender);

      --
      -- ����� ���������� �� �������� �� ����������� �������
      --
      SELECT TO_NUMBER (VALUE)
        INTO l_accNostro
        FROM operw
       WHERE REF = p_ref AND tag = 'NOS_A';

      SELECT s
        INTO l_amount
        FROM opldok
       WHERE REF = p_ref AND dk = 1 AND acc = l_accNostro;

      bars_audit.trace ('message amount is %s', TO_CHAR (l_amount));

      --
      -- ���� ������������� �� �������� ���� ������������� ���������
      --
      SELECT o.kv, t.lcv, o.vdat
        INTO l_currCode, l_currency, l_dateValue
        FROM oper o, tabval t
       WHERE o.REF = p_ref AND o.kv = t.kv;

      --
      -- ���������� ������� �������������, ������� ����� ������������
      --
      --    ���� ��������� ��� �������������� � ������������ ��������
      --    ����� RUR6, �� � ���.��������� 20 ����� �������� "+"
      --    (?#?&@&*! ��������� - � ���� �������� ����� ������ ����?)
      --
      SELECT COUNT (*)
        INTO l_cnt
        FROM operw
       WHERE REF = p_ref AND tag = '20' AND VALUE = '+';

      bars_audit.trace ('result for looking 20=+ is %s', TO_CHAR (l_cnt));

      IF (l_cnt != 0)
      THEN
         --
         -- ������������� ���������������� �������
         --
         l_transTable := 'RUR6';
         l_useTrans := FALSE;
      ELSE
         --
         -- ���������� ����� ����������� ������������� - �� �����
         -- ���������� ��������� ���������� ������� �������������
         --
         l_transTable := get_charset_id (l_receiver);
         l_useTrans := TRUE;
      END IF;

      bars_audit.trace ('message translate table is %s', l_transTable);

      --
      -- ���������� ������ �� ����� ��������� �� ��������� SWAHF
      --
      l_msgAppHdrFlags := genmsg_document_getmsgflg (p_ref, 'SWAHF');

      bars_audit.trace ('application header flags is %s', l_msgAppHdrFlags);


      bars_audit.trace ('create message MT103 header ...');


      --
      -- ������� ��������� (��������)
      --
      bars_swift.In_SwJournalInt (
         ret_         => l_retCode,
         swref_       => l_swRef,
         mt_          => l_mt,
         mid_         => NULL,
         page_        => NULL,
         io_          => 'I',
         sender_      => l_sender,
         receiver_    => l_mt103rcv,
         transit_     => NULL,
         payer_       => NULL,
         payee_       => NULL,
         ccy_         => l_currency,
         amount_      => l_amount,
         accd_        => NULL,
         acck_        => NULL,
         vdat_        => TO_CHAR (l_dateValue, 'MM/DD/YYYY'),
         idat_        => TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI'),
         flag_        => 'L',
         trans_       => l_transTable,
         apphdrflg_   => l_msgAppHdrFlags,
         sti_         => '001',
         uetr_        => LOWER (l_guid));

      -- ������������� ������� ��� ����������� ���������
      UPDATE sw_journal
         SET date_pay = SYSDATE
       WHERE swref = l_swRef;

      bars_audit.trace ('message MT103 header created SwRef=> %s',
                        TO_CHAR (l_swRef));

      -- ����������� ��������� � ���������
      INSERT INTO sw_oper (REF, swref)
           VALUES (p_ref, l_swRef);

      bars_audit.trace ('message MT103 linked with document.');
      bars_audit.trace ('write message MT103 details ...');

      -- �������� �������� ���� 56� � �������� BIC, ���� ����� ���� ����������
      l_fld56a := genmsg_document_getvalue (p_ref, '56A');

      IF (l_fld56a IS NOT NULL)
      THEN
         -- �������� BIC-���
         IF (SUBSTR (l_fld56a, 1, 1) = '/')
         THEN
            l_fld56bic :=
               RPAD (SUBSTR (l_fld56a, INSTR (l_fld56a, CRLF) + 2), 11, 'X');
         ELSE
            l_fld56bic := RPAD (l_fld56a, 11, 'X');
         END IF;
      END IF;

      -- �������� �������� ��� 57�
      l_fld57a := genmsg_document_getvalue (p_ref, '57A');


      -- ��������� ������ ���������
      OPEN cursModel (l_mt);

      l_recno := 1;

      LOOP
         FETCH cursModel INTO l_recModel;

         EXIT WHEN cursModel%NOTFOUND;


         --
         -- �������� ��������� ���� 53a, 54a, 56a, 57a
         --
         IF (l_recModel.tag = '53' AND l_recModel.opt = 'a')
         THEN
            l_opt := 'A';
            l_value := l_mt202rcv;
            genmsg_document_instag (l_recModel,
                                    l_swRef,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         --
         ELSIF (l_recModel.tag = '54' AND l_recModel.opt = 'a')
         THEN
            IF (l_fld56a IS NOT NULL AND l_mt202rcv != l_fld56bic)
            THEN
               l_opt := 'A';
               l_value := l_fld56a;
               genmsg_document_instag (l_recModel,
                                       l_swRef,
                                       NULL,
                                       l_recno,
                                       l_opt,
                                       l_value,
                                       TRUE,
                                       l_useTrans,
                                       l_transTable);
            /* else
                         l_opt   := 'A';
                         l_value := l_fld57a;
                         genmsg_document_instag(l_recModel, l_swRef, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
             */
            END IF;
         ELSIF (    l_recModel.tag = '56'
                AND l_recModel.opt = 'a'
                AND l_fld56a IS NOT NULL)
         THEN
            -- ���� 56 �� ���������
            NULL;
         ELSIF (    l_recModel.tag = '57'
                AND l_recModel.opt = 'a'
                AND l_fld56a IS NOT NULL)
         THEN
            -- logger.info('SWIFT l_fld56a='||l_fld56a);
            -- ���� 57 ��������� c 56A
            --l_value := l_fld56a;

            --l_opt   := 'A';
            --genmsg_document_instag(l_recModel, l_swRef, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);

            NULL;
         ELSE
            --
            -- ��� �����, ��������� ������������� �������� �������
            --
            IF (l_recModel.spec = 'Y')
            THEN
               l_value :=
                  genmsg_document_getvalue_ex (l_recModel,
                                               l_swRef,
                                               p_ref,
                                               l_recno,
                                               l_opt);

               IF (l_value IS NOT NULL)
               THEN
                  genmsg_document_instag (l_recModel,
                                          l_swRef,
                                          NULL,
                                          l_recno,
                                          l_opt,
                                          l_value,
                                          TRUE,
                                          l_useTrans,
                                          l_transTable);
               END IF;
            ELSE
               IF (l_recModel.Tag = '72')
               THEN
                  NULL;
               ELSIF (l_recModel.Tag = '59')
               THEN
                  l_opt := '';
                  -- l_fld59a:=substr(genmsg_document_getvalue(p_ref, '59'), instr(genmsg_document_getvalue(p_ref, '59'), chr(10))+1);
                  l_fld59a := genmsg_document_getvalue (p_ref, '59');
                  genmsg_document_instag (l_recModel,
                                          l_swRef,
                                          NULL,
                                          l_recno,
                                          l_opt,
                                          l_fld59a,
                                          TRUE,
                                          l_useTrans,
                                          l_transTable);
               ELSIF (l_recModel.Tag = '57'             --and l_fld56a is null
                                           )
               THEN
                  NULL;
               ELSE
                  genmsg_document_instag (l_recModel,
                                          l_swRef,
                                          p_ref,
                                          l_recno,
                                          NULL,
                                          NULL,
                                          NULL,
                                          l_useTrans,
                                          l_transTable);
               END IF;
            END IF;
         END IF;
      END LOOP;

      CLOSE cursModel;

      bars_audit.trace ('message MT103 generated swref=%s.',
                        TO_CHAR (l_swRef));
      bars_audit.info (
            '������������ ��������� SwRef='
         || TO_CHAR (l_swRef));

      --
      -- ��������� ��������� ��������� (MT202)
      --
      bars_audit.trace ('create message MT202 header ...');
      --guid �� ���� ����� �� � 103
      --l_sources_guid :=sys_guid(); /* GUID*/
      --l_guid :=substr(l_sources_guid,1,8)||'-'||substr(l_sources_guid,9,4)||'-'||substr(l_sources_guid,13,4)||'-'||substr(l_sources_guid,17,4)||'-'||substr(l_sources_guid,21) ;
      --
      -- ������� ��������� (��������)
      --
      bars_swift.In_SwJournalInt (
         ret_         => l_retCode,
         swref_       => l_swRef2,
         mt_          => l_mt2,
         mid_         => NULL,
         page_        => NULL,
         io_          => 'I',
         sender_      => l_sender,
         receiver_    => l_mt202rcv,
         transit_     => NULL,
         payer_       => NULL,
         payee_       => NULL,
         ccy_         => l_currency,
         amount_      => l_amount,
         accd_        => NULL,
         acck_        => NULL,
         vdat_        => TO_CHAR (l_dateValue, 'MM/DD/YYYY'),
         idat_        => TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI'),
         flag_        => 'L',
         trans_       => l_transTable,
         apphdrflg_   => l_msgAppHdrFlags,
         --    sti_        => '001',
         --    uetr_       => lower(l_guid),
         cov_         => 'COV');

      -- ������������� ������� ��� ����������� ���������
      UPDATE sw_journal
         SET date_pay = SYSDATE
       WHERE swref = l_swRef2;

      bars_audit.trace ('message MT202 header created SwRef=> %s',
                        TO_CHAR (l_swRef2));

      -- ����������� ��������� � ���������
      INSERT INTO sw_oper (REF, swref)
           VALUES (p_ref, l_swRef2);

      bars_audit.trace ('message MT202 linked with document.');
      bars_audit.trace ('write message MT202 details ...');

      -- ��������� ������ ���������
      OPEN cursModel (l_mt2);

      l_recno := 1;

      LOOP
         FETCH cursModel INTO l_recModel;

         EXIT WHEN cursModel%NOTFOUND;

         IF (l_recModel.tag = '20' AND l_recModel.opt IS NULL)
         THEN
            genmsg_document_instag (l_recModel,
                                    l_swRef2,
                                    p_ref,
                                    l_recno,
                                    NULL,
                                    NULL,
                                    NULL,
                                    l_useTrans,
                                    l_transTable);
         ELSIF (l_recModel.tag = '21' AND l_recModel.opt IS NULL)
         THEN
            -- �������� ���. ��������� ��103
            SELECT trn
              INTO l_value
              FROM sw_journal
             WHERE swref = l_swRef;

            l_opt := l_recModel.opt;
            genmsg_document_instag (l_recModel,
                                    l_swRef2,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         ELSIF (l_recModel.tag = '32' AND l_recModel.opt = 'A')
         THEN
            -- �������� �������� ���� 32A ��������� ��103
            SELECT VALUE
              INTO l_value
              FROM sw_operw
             WHERE     swref = l_swRef
                   AND tag = l_recModel.tag
                   AND opt = l_recModel.opt;

            l_opt := l_recModel.opt;

            genmsg_document_instag (l_recModel,
                                    l_swRef2,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         /*
          � sw_model ��� 202 ������ 50 ����
          � 52D ������ 50F
         */
         --            elsif (l_recModel.tag = '52' and l_recModel.opt = 'a') then
         --
         --                select opt, value into l_opt, l_value
         --                  from sw_operw
         --                 where swref = l_swRef
         --                   and tag   = '50';
         --
         --                if (l_opt in ('K', 'F')) then l_opt := 'D';
         --                end if;
         --                genmsg_document_instag(l_recModel, l_swRef2, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
         ELSIF (l_recModel.tag = '50' AND l_recModel.opt = 'a')
         THEN
            SELECT opt, VALUE
              INTO l_opt, l_value
              FROM sw_operw
             WHERE swref = l_swRef AND tag = '50';

            IF (l_opt IN ('K', 'F'))
            THEN
               l_opt := 'F';
            END IF;

            genmsg_document_instag (l_recModel,
                                    l_swRef2,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         ELSIF (l_recModel.tag = '52' AND l_recModel.opt = 'a')
         THEN
            l_fld52a := genmsg_document_getvalue (p_ref, '52A');

            IF (l_fld52a IS NOT NULL)
            THEN
               l_opt := 'A';
               l_value := l_fld52a;
               genmsg_document_instag (l_recModel,
                                       l_swRef2,
                                       NULL,
                                       l_recno,
                                       l_opt,
                                       l_value,
                                       TRUE,
                                       l_useTrans,
                                       l_transTable);
            END IF;
         ELSIF (    l_recModel.tag = '57'
                AND l_recModel.opt = 'a'
                AND l_fld56a IS NOT NULL)
         THEN
            l_opt := 'A';
            l_value := l_fld56a;
            genmsg_document_instag (l_recModel,
                                    l_swRef2,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         -- 57A �� ���������� ��� �� � MT103 54A ���������
         --            elsif (l_recModel.tag = '57' and l_recModel.opt = 'a') then
         --
         --                -- �������� �������� ���� 54 ��������� ��103
         --                begin
         --                    select opt, value into l_opt, l_value
         --                      from sw_operw
         --                     where swref = l_swRef
         --                       and tag   = '54';
         --                exception
         --                    when NO_DATA_FOUND then l_value := null;
         --                end;
         --
         --                if (l_opt != 'A') then
         --                    bars_audit.trace('Error! message 103 has option A in field 54');
         --                    raise_application_error(-20781, '\998 ��� �������� ��� ����������� ����� '||l_opt||' ���� 54� � ���� 57 ��������� MT202');
         --                end if;
         --
         --                if (l_value is not null) then
         --                    genmsg_document_instag(l_recModel, l_swRef2, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
         --                end if;


         -- �������� ����� BIC
         ELSIF (l_recModel.tag = '58' AND l_recModel.opt = 'a')
         THEN
            --l_value:= substr(genmsg_document_getvalue(p_ref, '59'),1,instr(genmsg_document_getvalue(p_ref, '59'), chr(13)))||chr(10)||l_mt103rcv;
            l_value := l_mt103rcv;
            --
            l_opt := 'A';
            genmsg_document_instag (l_recModel,
                                    l_swRef2,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         -- 72 �����
         --            elsif (l_recModel.tag = '72') then
         --
         --                -- �������� ���. ��������� ��103
         --                select trn into l_value
         --                  from sw_journal
         --                 where swref = l_swRef;
         --
         --                l_opt := '';
         --                l_value := '/BNF/COVER OF OUR MT103' || CRLF || 'REF ' || l_value;
         --                genmsg_document_instag(l_recModel, l_swRef2, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);

         ELSIF (l_recModel.tag = '59'               --AND l_recModel.opt = 'a'
                                     )
         THEN
            -- l_value:=l_mt103rcv;
            --l_value := genmsg_document_getvalue (p_ref, '59');
            --
            --l_opt := 'A';
            --l_opt := '';
            l_value := genmsg_document_getvalue (p_ref, '59A');
            l_opt := '';

            IF (l_value IS NULL)
            THEN
               l_value := genmsg_document_getvalue (p_ref, '59K');
               l_opt := '';
            END IF;

            IF (l_value IS NULL)
            THEN
               l_value := genmsg_document_getvalue (p_ref, '59F');
               l_opt := '';
            END IF;

            IF (l_value IS NULL)
            THEN
               l_value := genmsg_document_getvalue (p_ref, '59');
               l_opt := '';
            END IF;


            genmsg_document_instag (l_recModel,
                                    l_swRef2,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         -- ������ 59A � 70 ����
         ELSIF (l_recModel.tag = '70')
         THEN
            l_value := genmsg_document_getvalue (p_ref, '70');
            l_opt := l_recModel.opt;
            genmsg_document_instag (l_recModel,
                                    l_swRef2,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         ELSIF (l_recModel.tag = '72')
         THEN
            l_value := genmsg_document_getvalue (p_ref, '72');

            IF (l_value IS NOT NULL)
            THEN
               l_opt := l_recModel.opt;
               genmsg_document_instag (l_recModel,
                                       l_swRef2,
                                       NULL,
                                       l_recno,
                                       l_opt,
                                       l_value,
                                       TRUE,
                                       l_useTrans,
                                       l_transTable);
            END IF;
         END IF;
      END LOOP;

      CLOSE cursModel;

      bars_audit.trace ('message MT202 generated swref=%s.',
                        TO_CHAR (l_swRef2));
      bars_audit.info (
            '������������ ��������� SwRef='
         || TO_CHAR (l_swRef2));
      bars_audit.info (
            '������������ ��������� MT103 SwRef='
         || TO_CHAR (l_swRef)
         || ' � ��������� SwRef='
         || TO_CHAR (l_swRef2));
   END genmsg_document_mt103;



   -----------------------------------------------------------------
   -- GENMSG_STMT_MT900()
   --
   --     ��������� �������� ��������� � ������� ���������� �
   --     �������� ������������
   --
   --
   --     ���������:
   --
   --         p_stmt     ��� ������� (900/910)
   --
   --         p_date     ���� �������������
   --
   --         p_acc      ������������� �����, �� ��������
   --                    ����������� �������
   --
   --         p_ref      �������� ���������
   --
   --
   PROCEDURE genmsg_stmt_mt900 (p_stmt   IN sw_stmt.mt%TYPE,
                                p_date   IN opldok.fdat%TYPE,
                                p_acc    IN accounts.acc%TYPE,
                                p_ref    IN oper.REF%TYPE)
   IS
      -- ������ �� ������������ ���������
      CURSOR cursModel (p_mt IN NUMBER)
      IS
         SELECT *
           FROM sw_model
          WHERE mt = p_mt;

      l_sender       sw_journal.sender%TYPE; /*        ���������:    BIC ����������� */
      l_receiver     sw_journal.receiver%TYPE; /*        ���������:    BIC ����������  */
      l_currency     sw_journal.currency%TYPE; /*        ���������:         ��� ������ */
      l_amount       sw_journal.amount%TYPE; /*        ���������:    ����� ��������� */
      l_currCode     tabval.kv%TYPE; /*                 ��� ������ ��������� */
      l_accNum       accounts.nls%TYPE; /*                          ����� ����� */
      l_recModel     sw_model%ROWTYPE; /*                  ������ ������������ */


      l_retCode      NUMBER;        /* ��� �������� ������� �������� �����. */
      l_cnt          NUMBER;        /*                       ������ ������� */
      l_useTrans     BOOLEAN;       /*     ���� ������������� ������������� */
      l_transTable   sw_chrsets.setid%TYPE; /*            ��� ������� ������������� */
      l_swRef        sw_journal.swref%TYPE; /*             �������� ��������� SWIFT */
      l_swRefSrc     sw_journal.swref%TYPE; /*  �������� ���������� ��������� SWIFT */
      l_value        sw_operw.VALUE%TYPE; /*                        �������� ���� */
      l_value2       sw_operw.VALUE%TYPE; /*                        �������� ���� */
      l_recno        sw_operw.n%TYPE; /*              ���������� ����� ������ */
      l_opt          sw_operw.opt%TYPE; /*                    ����� ���� ������ */
      l_isUse50      BOOLEAN := FALSE; /*        ������� ������������� ���� 50 */

      l_nam_a        oper.nam_a%TYPE;
      l_nlsa         oper.nlsa%TYPE;
      l_nazn         oper.nazn%TYPE;
   BEGIN
      --
      -- ��������� ��������� ���������
      --
      bars_audit.trace ('get statement message header req ...');

      l_sender := bars_swift.get_ourbank_bic;
      bars_audit.trace ('statement message sender => %s', l_sender);

      --
      -- �� ����������� ��������� ���������� ����������
      --
      BEGIN
         SELECT bic
           INTO l_receiver
           FROM bic_acc
          WHERE acc = p_acc;

         bars_audit.trace ('statement message receiver => %s', l_receiver);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.error (
                  '�� ������ ���������� �� ����������� ���������. Acc='
               || TO_CHAR (p_acc));
            raise_application_error (
               -20781,
                  '\201 �� ������ ���������� �� ����������� ���������. Acc='
               || TO_CHAR (p_acc));
      END;

      --
      -- ��� ������ ����� �� �����
      --
      SELECT a.nls, t.kv, t.lcv
        INTO l_accNum, l_currCode, l_currency
        FROM accounts a, tabval t
       WHERE a.acc = p_acc AND a.kv = t.kv;

      bars_audit.trace ('statement currency is %s', l_currency);

      --
      -- C���� ����� �� ��������
      --
      SELECT SUM (s)
        INTO l_amount
        FROM opldok
       WHERE REF = p_ref AND acc = p_acc AND fdat = p_date;

      bars_audit.trace ('statement amount is %s', TO_CHAR (l_amount));

      --
      -- ���������� ����� ����������� ������������� - �� �����
      -- ���������� ��������� ���������� ������� �������������
      --
      l_transTable := get_charset_id (l_receiver);
      l_useTrans := TRUE;

      bars_audit.trace ('message translate table is %s', l_transTable);

      bars_audit.trace ('create message header ...');

      --�������� �� � �²������ ��� ������ ���������,
      --���� ���� �� ������� �� ����� ���������
      BEGIN
         SELECT swref
           INTO l_swRefSrc
           FROM sw_oper
          WHERE REF = p_ref AND ROWNUM <= 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_swRefSrc := NULL;
      END;

      --
      -- ������� ��������� (��������)
      --
      bars_swift.In_SwJournalInt (
         ret_        => l_retCode,
         swref_      => l_swRef,
         mt_         => p_stmt,
         mid_        => CASE WHEN (l_swRefSrc IS NULL) THEN p_ref ELSE NULL END,
         page_       => NULL,
         io_         => 'I',
         sender_     => l_sender,
         receiver_   => l_receiver,
         transit_    => NULL,
         payer_      => NULL,
         payee_      => NULL,
         ccy_        => l_currency,
         amount_     => l_amount,
         accd_       => NULL,
         acck_       => NULL,
         vdat_       => TO_CHAR (p_date, 'MM/DD/YYYY'),
         idat_       => TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI'),
         flag_       => 'L',
         trans_      => l_transTable);

      bars_audit.trace ('message header created SwRef=> %s',
                        TO_CHAR (l_swRef));

      bars_audit.trace ('write statement message details ...');

      l_recno := 1;



      IF (l_swRefSrc IS NOT NULL)
      THEN
         -- 20
         SELECT trn
           INTO l_value
           FROM sw_journal
          WHERE swref = l_swRef;

         -- ��� 643 ������ �������� "+"
         /*    if (l_currCode=643) then
                 l_value:='+'||l_value;
              end if;
        */
         bars_swift.in_swoperw (l_swRef,
                                '20',
                                'A',
                                l_recno,
                                NULL,
                                l_value);
         l_recno := l_recno + 1;

         -- 21 (����� ��������)
         SELECT trn
           INTO l_value
           FROM sw_journal
          WHERE swref = l_swRefSrc;

         bars_swift.in_swoperw (l_swRef,
                                '21',
                                'A',
                                l_recno,
                                NULL,
                                l_value);
         l_recno := l_recno + 1;

         -- 25
         bars_swift.in_swoperw (l_swRef,
                                '25',
                                'A',
                                l_recno,
                                NULL,
                                l_accNum);
         l_recno := l_recno + 1;

         -- 32A
         l_value :=
               TO_CHAR (p_date, 'yymmdd')
            || bars_swift.AmountToSwift (l_amount,
                                         l_currCode,
                                         TRUE,
                                         TRUE);
         bars_swift.in_swoperw (l_swRef,
                                '32',
                                'A',
                                l_recno,
                                'A',
                                l_value);
         l_recno := l_recno + 1;


         -- 50
         IF (p_stmt = 910 AND l_currCode != 643)
         THEN
            BEGIN
               SELECT opt, VALUE
                 INTO l_opt, l_value
                 FROM sw_operw
                WHERE     swref = l_swRefSrc
                      AND tag = '50'
                      AND opt IN ('A', 'K', 'F');

               bars_swift.in_swoperw (l_swRef,
                                      '50',
                                      'A',
                                      l_recno,
                                      l_opt,
                                      l_value);


               l_recno := l_recno + 1;

               l_isUse50 := TRUE;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;
         END IF;

         IF (p_stmt = 910 AND l_currCode = 643)
         THEN
            l_isUse50 := TRUE;
         END IF;

         -- 52
         IF (NOT l_isUse50)
         THEN
            BEGIN
               SELECT opt, VALUE
                 INTO l_opt, l_value
                 FROM sw_operw
                WHERE swref = l_swRefSrc AND tag = '52' AND opt IN ('A', 'D');

               bars_swift.in_swoperw (l_swRef,
                                      '52',
                                      'A',
                                      l_recno,
                                      l_opt,
                                      l_value);


               l_recno := l_recno + 1;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;
         END IF;

         -- 52 ��� 643 �� ������ �����������(����������� ���� ����� ���� ��������� 50)
         IF (l_currCode = 643)
         THEN
            IF (p_stmt = 910)
            THEN
               BEGIN
                  SELECT opt, VALUE
                    INTO l_opt, l_value
                    FROM sw_operw
                   WHERE swref = l_swRefSrc AND tag = '50' AND opt IN ('K');

                  bars_swift.in_swoperw (l_swRef,
                                         '52',
                                         'A',
                                         l_recno,
                                         'D',
                                         l_value);


                  l_recno := l_recno + 1;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     -- ���� 52 ����� �� ��������� ���� � ����� ������� BIC �� ���� ������� �����
                     BEGIN
                        SELECT c.bic
                          INTO l_value
                          FROM sw_oper so, oper o, custbank c
                         WHERE     so.swref = l_swRefSrc
                               AND so.REF = o.REF
                               AND o.mfoa = c.mfo;

                        bars_swift.in_swoperw (l_swRef,
                                               '52',
                                               'A',
                                               l_recno,
                                               'D',
                                               l_value);


                        l_recno := l_recno + 1;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           NULL;
                     END;
               END;
            ELSE
               BEGIN
                  SELECT opt, VALUE
                    INTO l_opt, l_value
                    FROM sw_operw
                   WHERE     swref = l_swRefSrc
                         AND tag = '52'
                         AND opt IN ('A', 'D');

                  bars_swift.in_swoperw (l_swRef,
                                         '52',
                                         'A',
                                         l_recno,
                                         l_opt,
                                         l_value);


                  l_recno := l_recno + 1;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     BEGIN
                        SELECT c.bic
                          INTO l_value
                          FROM sw_oper so, oper o, custbank c
                         WHERE     so.swref = l_swRefSrc
                               AND so.REF = o.REF
                               AND o.mfoa = c.mfo;

                        bars_swift.in_swoperw (l_swRef,
                                               '52',
                                               'A',
                                               l_recno,
                                               'A',
                                               l_value);


                        l_recno := l_recno + 1;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           NULL;
                     END;
               END;
            END IF;
         END IF;



         -- 56
         IF (p_stmt = 910)
         THEN
            BEGIN
               SELECT opt, VALUE
                 INTO l_opt, l_value
                 FROM sw_operw
                WHERE swref = l_swRefSrc AND tag = '56' AND opt IN ('A', 'D');

               bars_swift.in_swoperw (l_swRef,
                                      '56',
                                      'A',
                                      l_recno,
                                      l_opt,
                                      l_value);

               l_recno := l_recno + 1;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;
         END IF;

         IF (p_stmt = 910 AND l_currCode = 643)
         THEN
            BEGIN
               SELECT VALUE
                 INTO l_value
                 FROM sw_operw
                WHERE swref = l_swRefSrc AND tag = '70' AND opt IS NULL;

               bars_swift.in_swoperw (l_swRef,
                                      '72',
                                      'A',
                                      l_recno,
                                      'D',
                                      l_value);
               l_recno := l_recno + 1;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;
         ELSE
            -- 72
            BEGIN
               SELECT VALUE
                 INTO l_value
                 FROM sw_operw
                WHERE swref = l_swRefSrc AND tag = '72' AND opt IS NULL;

               bars_swift.in_swoperw (l_swRef,
                                      '72',
                                      'A',
                                      l_recno,
                                      NULL,
                                      l_value);
               l_recno := l_recno + 1;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;
         END IF;
      ELSE               --�²������ �� ������� - ������� �� ������ ���������
         --���� 20(opt �����)
         l_value := TO_CHAR (p_ref);
         bars_swift.in_swoperw (l_swRef,
                                '20',
                                'A',
                                l_recno,
                                NULL,
                                l_value);

         -- ���� 21
         l_recno := l_recno + 1;
         l_value := 'NONREF';
         bars_swift.in_swoperw (l_swRef,
                                '21',
                                'A',
                                l_recno,
                                NULL,
                                l_value);

         --���� 32A
         l_recno := l_recno + 1;
         l_value :=
               TO_CHAR (p_date, 'yymmdd')
            || bars_swift.AmountToSwift (l_amount,
                                         l_currCode,
                                         TRUE,
                                         TRUE);
         bars_swift.in_swoperw (l_swRef,
                                '32',
                                'A',
                                l_recno,
                                'A',
                                l_value);

         --���� 52D
         BEGIN
            SELECT nam_a, nlsa
              INTO l_nam_a, l_nlsa
              FROM oper
             WHERE REF = p_ref;

            l_recno := l_recno + 1;

            l_value :=
                  '/'
               || l_nlsa
               || CHR (13)
               || CHR (10)
               || bars_swift.StrToSwift (
                     l_nam_a,
                     CASE WHEN l_currCode = 643 THEN 'RUR6' ELSE 'TRANS' END);

            bars_swift.in_swoperw (l_swRef,
                                   '52',
                                   'A',
                                   l_recno,
                                   'D',
                                   l_value);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;

         --���� 72
         BEGIN
            SELECT nazn
              INTO l_nazn
              FROM oper
             WHERE REF = p_ref;

            l_recno := l_recno + 1;

            l_nazn :=
               bars_swift.StrToSwift (
                  l_nazn,
                  CASE WHEN l_currCode = 643 THEN 'RUR6' ELSE 'TRANS' END);

            l_value :=
               REPLACE (str_wrap ('/BNF/' || l_nazn, 33),
                        CHR (13) || CHR (10),
                        CHR (13) || CHR (10) || '//');

            bars_swift.in_swoperw (l_swRef,
                                   '72',
                                   'A',
                                   l_recno,
                                   NULL,
                                   l_value);
         END;
      END IF;                                    -- end l_swRefSrc is not null

      bars_audit.trace ('statement message generated swref=%s.',
                        TO_CHAR (l_swRef));
      bars_audit.info (
            '������������ �������. ��������� SwRef='
         || TO_CHAR (l_swRef));
   END genmsg_stmt_mt900;


   -----------------------------------------------------------------
   -- DOCMSG_ENQUEUE_ERROR()
   --
   --     ��������� �������� ��������� � ������� ���������� �
   --     �������� ������������
   --
   --
   --     ���������:
   --
   --         p_ref      �������� ���������
   --
   --         p_errmsg   ����� ������
   --
   PROCEDURE docmsg_enqueue_error (p_ref      IN oper.REF%TYPE,
                                   p_errmsg   IN VARCHAR2)
   IS
   BEGIN
      bars_audit.trace ('inserting document into error queue ref=%s...',
                        TO_CHAR (p_ref));

      INSERT INTO sw_docmsg_err (REF, errmsg)
           VALUES (p_ref, p_errmsg);

      bars_audit.trace ('document in error queue ref=%s.', TO_CHAR (p_ref));
   END docmsg_enqueue_error;


   -----------------------------------------------------------------
   -- DOCMSG_DEQUEUE_ERROR()
   --
   --     ��������� �������� ��������� �� ������� ���������� �
   --     �������� ������������
   --
   --
   --     ���������:
   --
   --         p_ref      �������� ���������
   --
   --
   PROCEDURE docmsg_dequeue_error (p_ref IN oper.REF%TYPE)
   IS
   BEGIN
      bars_audit.trace ('deleting document from error queue ref=%s...',
                        TO_CHAR (p_ref));

      DELETE FROM sw_docmsg_err
            WHERE REF = p_ref;

      IF (SQL%ROWCOUNT = 0)
      THEN
         bars_audit.trace ('document not found in queue ref=%s',
                           TO_CHAR (p_ref));
         raise_application_error (
            -20781,
               '\110 �������� �� ������ � ������� Ref='
            || TO_CHAR (p_ref));
      END IF;

      bars_audit.trace ('document deleted from error queue ref=%s.',
                        TO_CHAR (p_ref));
   END docmsg_dequeue_error;



   -----------------------------------------------------------------
   -- DOCMSG_CHECKMSGFLAG()
   --
   --     ������� �������� ����� ������������ SWIFT ��������� ��
   --     ���������. ������� ���������� �������� TRUE, ���� ����
   --     ���������� �  FALSE, ���� ���� �� ������.  �������  ��
   --     ��������� �������� ������������ �������� ������� �����
   --
   --     ���������:
   --
   --         p_doc    ��������� � ����������� ���������
   --
   --
   FUNCTION docmsg_checkmsgflag (p_doc IN t_doc)
      RETURN BOOLEAN
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || '.dmchkmflg';
      --
      l_value      t_docwval;          /* �������� ���������: ��� ��������� */
      l_mt         t_swmt;             /*      �������������� ��� ��������� */
   --
   BEGIN
      bars_audit.trace ('%s: entry point', p);

      BEGIN
         l_value := p_doc.doclistw ('f').VALUE;
         bars_audit.trace ('%s: property "f" value is %s', p, l_value);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.trace ('%s: property "f" not found, returning FALSE',
                              p);
            RETURN FALSE;
      END;

      -- ��������� ������������ ���. ���������
      l_mt := genmsg_document_getmtvld (l_value);
      bars_audit.trace ('%s: property mt is %s, returning TRUE',
                        p,
                        TO_CHAR (l_mt));
      RETURN TRUE;
   END docmsg_checkmsgflag;



   -----------------------------------------------------------------
   -- DOCMSG_CHECKMSGFLAG()
   --
   --     ������� �������� ����� ������������ SWIFT ��������� ��
   --     ���������. ������� ���������� �������� TRUE, ���� ����
   --     ���������� �  FALSE, ���� ���� �� ������.  �������  ��
   --     ��������� �������� ������������ �������� ������� �����
   --
   --     ���������:
   --
   --         p_ref      �������� ���������, ��� ���������� �
   --                    �������
   --
   FUNCTION docmsg_checkmsgflag (p_ref IN oper.REF%TYPE)
      RETURN BOOLEAN
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || '.dmchkmflg';
      --
      l_ref        oper.REF%TYPE;      /*                �������� ��������� */
      l_value      operw.VALUE%TYPE;   /* �������� ���������: ��� ��������� */
      l_mt         sw_mt.mt%TYPE;      /*      �������������� ��� ��������� */
   BEGIN
      bars_audit.trace ('%s: entry point par[0]=>%s', p, TO_CHAR (p_ref));

      -- ��������� ����� �� ����������� SWIFT-���������
      bars_audit.trace ('%s: checking document req "f" ...', p);

      BEGIN
         SELECT VALUE
           INTO l_value
           FROM operw
          WHERE REF = p_ref AND tag = RPAD ('f', 5, ' ');

         bars_audit.trace ('%s: document req "f" => %s', l_value);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.trace ('%s: document req "f" not found, ', p);
            RETURN FALSE;
      END;

      -- ��������� ������������ ���. ���������
      l_mt := genmsg_document_getmtvld (l_value);
      bars_audit.trace ('%s: mt validate completed, return true', p);
      RETURN TRUE;
   END docmsg_checkmsgflag;


   -----------------------------------------------------------------
   -- DOCMSG_PROCESS_DOCUMENT()
   --
   --     ��������� �������� ��������� �� ���������
   --
   --
   --
   --
   --     ���������:
   --
   --         p_ref      �������� ���������
   --
   --         p_flag     ����� ���������
   --
   --         p_errque   ������� ���������� ���������
   --                    � ������� ���������, ��� �������������
   --                    ������ ��� ������������ ���������
   --
   --
   PROCEDURE docmsg_process_document (p_ref      IN oper.REF%TYPE,
                                      p_flag     IN CHAR,
                                      p_errque   IN BOOLEAN DEFAULT FALSE)
   IS
      l_genmsgerr   VARCHAR2 (4000);           /* ����� ��������� �� ������ */
      l_mt          NUMBER;                    /*             ��� ��������� */
   BEGIN
      --
      -- ��������� ������� ��������� � ���� ������������ ���������
      --
      -- 14/03/2006 dg �������� ������ ��� ����������, ������� �� �����
      --               ������������ ���������
      --
      IF (NOT docmsg_checkmsgflag (p_ref))
      THEN
         bars_audit.trace ('bad document, skip message creation');
         RETURN;
      -- bars_audit.trace('internal queue error - bad document in queue. document ref=%s', to_char(p_ref));
      -- raise_application_error(-20781, '\111 internal queue error - bad document in queue. document Ref=' || to_char(p_ref));
      END IF;

      BEGIN
         SAVEPOINT sp_docmsg;

         --
         -- �������� ��� ���������
         --
         l_mt := genmsg_document_getmt (p_ref => p_ref);

         IF (l_mt = 103)
         THEN
            IF (p_flag = '2')
            THEN
               --
               -- ������� ��������� MT103 � ��������� (MT202)
               --
               genmsg_document_mt103 (p_ref => p_ref, p_flag => p_flag);
            ELSE
               --
               -- ������� ��������� �� ������ ��������
               --
               genmsg_document_abstract (p_ref => p_ref, p_flag => p_flag);
            END IF;
         ELSE
            --
            -- ������� ��������� �� ������ ��������
            --
            genmsg_document_abstract (p_ref => p_ref, p_flag => p_flag);
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            l_genmsgerr := SQLERRM;

            ROLLBACK TO sp_docmsg;

            bars_audit.trace ('error creating message: %s', l_genmsgerr);

            --
            -- � ����������� �� ���������� �����, ���� ���������� ������,
            -- ���� ������ ������ �������� � ������� ���������
            --
            IF (p_errque)
            THEN
               --
               -- ������ � �������
               --
               docmsg_enqueue_error (p_ref => p_ref, p_errmsg => l_genmsgerr);
            ELSE
               RAISE;                                        -- ������� ������
            END IF;
      END;
   END docmsg_process_document;

   -----------------------------------------------------------------
   -- DOCMSG_PROCESS_DOCUMENT2()
   --
   --     ��������� �������� ��������� �� ���������
   --
   --
   --
   --
   --     ���������:
   --
   --         p_ref      �������� ���������
   --
   --         p_flag     ����� ���������
   --
   --
   PROCEDURE docmsg_process_document2 (p_ref    IN oper.REF%TYPE,
                                       p_flag   IN CHAR)
   IS
   BEGIN
      docmsg_process_document (p_ref, p_flag, FALSE);
   END docmsg_process_document2;



   -----------------------------------------------------------------
   -- DOCSTMT_PROCESS_DOCUMENT()
   --
   --     ��������� �������� ������� �� ���������
   --
   --
   --
   --
   --     ���������:
   --
   --         p_ref      �������� ���������
   --
   --         p_flag     ����� ���������
   --
   --         p_errque   ������� ���������� ���������
   --                    � ������� ���������, ��� �������������
   --                    ������ ��� ������������ �������
   --
   --
   PROCEDURE docstmt_process_document (p_stmt     IN sw_stmt.mt%TYPE,
                                       p_ref      IN oper.REF%TYPE,
                                       p_flag     IN CHAR,
                                       p_errque   IN BOOLEAN DEFAULT FALSE)
   IS
      l_genmsgerr   VARCHAR2 (4000);           /* ����� ��������� �� ������ */
      l_docSos      oper.sos%TYPE;             /*       ��������� ��������� */
      l_cnt         NUMBER;                    /*                   ������� */
   BEGIN
      --
      -- ��������� ��������� ���������
      --
      bars_audit.trace ('checking document status ref=%s...',
                        TO_CHAR (p_ref));

      SELECT sos
        INTO l_docSos
        FROM oper
       WHERE REF = p_ref;

      IF (l_docSos != 5)
      THEN
         bars_audit.error (
               '��������� ��������� �� ������������� ����������. Ref='
            || TO_CHAR (p_ref));
         raise_application_error (
            -20781,
               '\200 ��������� ��������� �� ������������� ����������. Ref='
            || TO_CHAR (p_ref));
      END IF;

      bars_audit.trace ('document ref=%s status ok.', TO_CHAR (p_ref));

      --
      -- ��������� ������������� ������������ �������
      --
      /* select count(*) into l_cnt
         from opldok o, sw_acc_sparam s, sw_oper w
        where o.ref       = p_ref
          and o.acc       = s.acc
          and s.use4mt900 = 1
          and o.ref       = w.ref;
       */
      --06-11-2014 Oleg Muzyka
      --��������� ��� �������� �²������� �����������,
      --����������� �� ������, ��� ���� ��� �����,
      --�� ����� ��������� ��������� �������� �������� �������
      SELECT COUNT (*)
        INTO l_cnt
        FROM opldok o, sw_acc_sparam s
       WHERE o.REF = p_ref AND o.acc = s.acc AND s.use4mt900 = 1;

      IF (l_cnt = 0)
      THEN
         bars_audit.trace (
            'statement 900/910 not defined for this accounts. Ref=%s',
            TO_CHAR (p_ref));
         RETURN;
      END IF;

      --
      -- ��������� ������� ��� ������� �����, ������� �������������
      -- ����������
      --
      FOR i IN (  SELECT DECODE (o.dk, 0, 900, 910) stmt, o.fdat, o.acc
                    FROM opldok o, sw_acc_sparam s
                   WHERE o.REF = p_ref AND o.acc = s.acc AND s.use4mt900 = 1
                GROUP BY DECODE (o.dk, 0, 900, 910), o.fdat, o.acc)
      LOOP
         bars_audit.trace ('generating statement for account acc=%s...',
                           TO_CHAR (i.acc));

         genmsg_stmt_mt900 (p_stmt   => i.stmt,
                            p_date   => i.fdat,
                            p_acc    => i.acc,
                            p_ref    => p_ref);

         bars_audit.trace ('statement for account acc=%s generated.',
                           TO_CHAR (i.acc));
      END LOOP;
   END docstmt_process_document;



   --**************************************************************--
   --*            Generate SWIFT message from document            *--
   --**************************************************************--

   -----------------------------------------------------------------
   -- ENQUEUE_DOCUMENT()
   --
   --     ������� ���������� � ������� ���������, �� ��������
   --     ���������� ����� ������������ SWIFT ���������.  ���
   --     ���������� � ������� � ���������  �����������  ���.
   --     �������� - ���� ������������ SWIFT ���������
   --
   --     ���������:
   --
   --         p_ref      �������� ���������, ��� ���������� �
   --                    �������
   --         p_flag     ����� ��� �������� ���������, �����-
   --                    ������ ��� ������� ���� ���������
   --
   --         p_priority ��������� ���������
   --

   PROCEDURE enqueue_document (p_ref        IN oper.REF%TYPE,
                               p_flag       IN CHAR DEFAULT NULL,
                               p_priority   IN NUMBER DEFAULT NULL)
   IS
      l_queMsgEnq    DBMS_AQ.ENQUEUE_OPTIONS_T; /*        ����� ���������� � ������� */
      l_queMsgProp   DBMS_AQ.MESSAGE_PROPERTIES_T; /*                   ����� ��������� */
      l_queMsgID     RAW (16);         /* ������������� ��������� � ������� */
   BEGIN
      --
      -- �������� ���. ��������� ���������
      --   (���� ������������ ���������)
      --
      IF (NOT docmsg_checkmsgflag (p_ref))
      THEN
         RETURN;
      END IF;

      --
      -- ������������� ��������� (���� ���������)
      --
      l_queMsgProp.priority := 1;

      --
      -- ��������� �������� � �������
      --
      DBMS_AQ.enqueue (queue_name           => 'aq_swdocmsg',
                       enqueue_options      => l_queMsgEnq,
                       message_properties   => l_queMsgProp,
                       payload              => t_swdocmsg (p_ref, p_flag),
                       msgid                => l_queMsgID);
   END enqueue_document;



   -----------------------------------------------------------------
   -- PROCESS_DOCUMENT()
   --
   --     ��������� ������������ SWIFT ���������  ��  ������
   --     ��������� �� ������� ����������.  ������ ���������
   --     ������������� ��� ����������� ��� CallBack �������
   --     ��������� ��������� �������.
   --
   --     ���������:
   --
   --
   --



   PROCEDURE process_document
   IS
   BEGIN
      raise_application_error (-20999, '\SWT implementation restriction -');
   END process_document;


   -----------------------------------------------------------------
   -- PROCESS_DOCUMENT_QUEUE()
   --
   --     ��������� ������� ������� ���������� ��� ������������
   --     SWIFT ���������.
   --
   --
   --
   --
   --
   PROCEDURE process_document_queue
   IS
      l_queMsgDeq        DBMS_AQ.DEQUEUE_OPTIONS_T; /*  ��������� ���������� ������� */
      l_queMsgProp       DBMS_AQ.MESSAGE_PROPERTIES_T; /*           ��������� ��������� */
      l_queMsgID         RAW (16);         /*       ������������� ��������� */
      l_queMsg           t_swdocmsg;       /*          ��������� �� ������� */

      l_isMsgExists      BOOLEAN := TRUE;  /*     ������� ������� ��������� */

      no_message_found   EXCEPTION;
      PRAGMA EXCEPTION_INIT (no_message_found, -25228);
   BEGIN
      --
      -- ������������� ��������� �������� ��������� �������
      --
      l_queMsgDeq.wait := DBMS_AQ.no_wait;
      l_queMsgDeq.navigation := DBMS_AQ.first_message;
      l_queMsgDeq.dequeue_mode := DBMS_AQ.locked;
      l_queMsgID := NULL;

      WHILE (l_isMsgExists)
      LOOP
         BEGIN
            --
            -- �������� ��������� �� �������
            --
            DBMS_AQ.dequeue (queue_name           => 'aq_swdocmsg',
                             dequeue_options      => l_queMsgDeq,
                             message_properties   => l_queMsgProp,
                             payload              => l_queMsg,
                             msgid                => l_queMsgID);

            --
            -- �������� ��������� ��������� ���������
            --
            BEGIN
               SAVEPOINT sp_before_procdoc;

               docmsg_process_document (p_ref      => l_queMsg.REF,
                                        p_flag     => l_queMsg.flag,
                                        p_errque   => TRUE);

               --
               -- ���� ������� ������������ ���������, ������� �� �������
               --
               l_queMsgDeq.dequeue_mode := DBMS_AQ.remove_nodata;
               l_queMsgDeq.msgid := l_queMsgID;

               DBMS_AQ.dequeue (queue_name           => 'aq_swdocmsg',
                                dequeue_options      => l_queMsgDeq,
                                message_properties   => l_queMsgProp,
                                payload              => l_queMsg,
                                msgid                => l_queMsgID);
            EXCEPTION
               WHEN OTHERS
               THEN
                  ROLLBACK TO sp_before_procdoc;
            END;

            COMMIT;

            --
            -- ������������� ��������� ����������� ��������� �������
            --
            l_queMsgDeq.wait := DBMS_AQ.no_wait;
            l_queMsgDeq.navigation := DBMS_AQ.next_message;
            l_queMsgDeq.dequeue_mode := DBMS_AQ.locked;
            l_queMsgDeq.msgid := NULL;
         EXCEPTION
            WHEN NO_MESSAGE_FOUND
            THEN
               l_isMsgExists := FALSE;
         END;
      END LOOP;

      COMMIT;
   END process_document_queue;

   --**************************************************************--
   --*           Generate SWIFT statement from document           *--
   --**************************************************************--

   --------------------------------------------------------------
   -- ENQUEUE_STMT_DOCUMENT()
   --
   --     ������� ���������� � ������� ���������, �� ��������
   --     ����������  �����  ������������  SWIFT  ������� (��
   --     ������ ������ MT900/MT910)
   --
   --
   --     ���������:
   --
   --         p_stmt     ����� �������, ��� ������������ ����-
   --                    ��� ����������� ��������
   --
   --         p_ref      �������� ���������, ��� ���������� �
   --                    �������
   --
   --         p_flag     ����� ��� �������� ���������, �����-
   --                    ������ ��� ������� ���� �������
   --
   --         p_priority ��������� ���������
   --

   PROCEDURE enqueue_stmt_document (p_stmt       IN sw_stmt.mt%TYPE,
                                    p_ref        IN oper.REF%TYPE,
                                    p_flag       IN CHAR DEFAULT NULL,
                                    p_priority   IN NUMBER DEFAULT NULL)
   IS
      l_queMsgEnq    DBMS_AQ.ENQUEUE_OPTIONS_T; /*        ����� ���������� � ������� */
      l_queMsgProp   DBMS_AQ.MESSAGE_PROPERTIES_T; /*                   ����� ��������� */
      l_queMsgID     RAW (16);         /* ������������� ��������� � ������� */
   BEGIN
      --
      -- �������� ������������ ���� �������
      -- (���������� �������� �� SW_STMT)
      --
      NULL;

      bars_audit.trace (
         'Attempt to add document Ref=%s to statement queue AQ_SWDOCSTMT...',
         TO_CHAR (p_ref));
      --
      -- ������������� ��������� (���� ���������)
      --
      l_queMsgProp.priority := 1;

      --
      -- ��������� �������� � ������� ��� �������
      --
      DBMS_AQ.enqueue (
         queue_name           => 'bars.aq_swdocstmt',
         enqueue_options      => l_queMsgEnq,
         message_properties   => l_queMsgProp,
         payload              => t_swdocstmt (p_stmt, p_ref, p_flag),
         msgid                => l_queMsgID);

      bars_audit.trace (
         'Document Ref=%s added to statement queue AQ_SWDOCSTMT.',
         TO_CHAR (p_ref));
   END enqueue_stmt_document;


   -----------------------------------------------------------------
   -- PROCESS_STMT_QUEUE()
   --
   --     ��������� ������� ������� ���������� ��� ������������
   --     ������� SWIFT.
   --
   --
   --
   --
   --
   PROCEDURE process_stmt_queue
   IS
      l_queMsgDeq        DBMS_AQ.DEQUEUE_OPTIONS_T; /*  ��������� ���������� ������� */
      l_queMsgProp       DBMS_AQ.MESSAGE_PROPERTIES_T; /*           ��������� ��������� */
      l_queMsgID         RAW (16);         /*       ������������� ��������� */
      l_queMsg           t_swdocstmt;      /*          ��������� �� ������� */
      l_docSos           oper.sos%TYPE;    /*           ��������� ��������� */

      l_isMsgExists      BOOLEAN := TRUE;  /*     ������� ������� ��������� */
      l_errmsg           VARCHAR2 (2048);  /*     ����� ��������� �� ������ */

      no_message_found   EXCEPTION;
      PRAGMA EXCEPTION_INIT (no_message_found, -25228);
   BEGIN
      bars_audit.trace ('Process statement queue AQ_SWDOCSTMT...');

      --
      -- ������������� ��������� �������� ��������� �������
      --
      l_queMsgDeq.wait := DBMS_AQ.no_wait;
      l_queMsgDeq.navigation := DBMS_AQ.first_message;
      l_queMsgDeq.dequeue_mode := DBMS_AQ.locked;
      l_queMsgID := NULL;

      WHILE (l_isMsgExists)
      LOOP
         BEGIN
            --
            -- �������� ��������� �� �������
            --
            DBMS_AQ.dequeue (queue_name           => 'bars.aq_swdocstmt',
                             dequeue_options      => l_queMsgDeq,
                             message_properties   => l_queMsgProp,
                             payload              => l_queMsg,
                             msgid                => l_queMsgID);

            bars_audit.trace (
               'Found request: stmt=%s, ref=%s, process it...',
               TO_CHAR (l_queMsg.stmt),
               TO_CHAR (l_queMsg.REF));

            --
            -- �������� ��������� ��������� ���������
            --
            BEGIN
               SAVEPOINT sp_before_procdoc;

               --
               -- ������� ��������� ������ ��� STMT=900
               -- �������� ������ ���� �� �������� 5,
               -- ���� � ��������� ������ ������ 0, ��
               -- ����� �������� ������� �� �������
               --

               IF (l_queMsg.stmt = 900)
               THEN
                  --
                  -- �������� ��������� ���������
                  --
                  BEGIN
                     SELECT sos
                       INTO l_docSos
                       FROM oper
                      WHERE REF = l_queMsg.REF;

                     bars_audit.trace ('Document Ref=%s status is %s',
                                       TO_CHAR (l_queMsg.REF),
                                       TO_CHAR (l_docSos));
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        l_docSos := -1;
                  END;

                  --
                  -- ��������� �������
                  --
                  IF (l_docSos = 5)
                  THEN
                     -- ��������� �������
                     docstmt_process_document (p_stmt     => l_queMsg.stmt,
                                               p_ref      => l_queMsg.REF,
                                               p_flag     => l_queMsg.flag,
                                               p_errque   => FALSE);
                  ELSE
                     bars_audit.trace (
                        'Document status isnt 5, skip document.');
                  END IF;

                  --
                  -- ������� �������� �� �������
                  --
                  IF (l_docSos = 5 OR l_docSos < 0)
                  THEN
                     bars_audit.trace ('Delete request from queue...');

                     l_queMsgDeq.dequeue_mode := DBMS_AQ.remove_nodata;
                     l_queMsgDeq.msgid := l_queMsgID;

                     DBMS_AQ.dequeue (queue_name           => 'bars.aq_swdocstmt',
                                      dequeue_options      => l_queMsgDeq,
                                      message_properties   => l_queMsgProp,
                                      payload              => l_queMsg,
                                      msgid                => l_queMsgID);

                     bars_audit.trace ('Request deleted from queue.');
                  END IF;
               ELSE
                  bars_audit.trace ('Statement type isnt 900, skip request.');
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_errmsg := SQLERRM;
                  bars_audit.error (
                        'SWT: ������ ��� ������������ ������� (MT900): '
                     || l_errmsg);
                  ROLLBACK TO sp_before_procdoc;
            END;

            COMMIT;

            --
            -- ������������� ��������� ����������� ��������� �������
            --
            l_queMsgDeq.wait := DBMS_AQ.no_wait;
            l_queMsgDeq.navigation := DBMS_AQ.next_message;
            l_queMsgDeq.dequeue_mode := DBMS_AQ.locked;
            l_queMsgDeq.msgid := NULL;
         EXCEPTION
            WHEN NO_MESSAGE_FOUND
            THEN
               l_isMsgExists := FALSE;
         END;
      END LOOP;

      COMMIT;
   END process_stmt_queue;



   --**************************************************************--
   --*    Validate document req                                   *--
   --**************************************************************--

   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_GETVALUE_OPT()
   --
   --     ������� ���������� �������� ��� ���������  ���������,
   --     ������� �������������  ����������  ����  ���������  �
   --     ������, ����� ��� ����� ���� �������� ���� �� �������-
   --     ��� �����. ������� �������, ����� ��� ���� �����������
   --     ������� ������������ ���. ��������� ����
   --
   --
   --
   FUNCTION docmsg_document_getvalue_opt (p_ref   IN oper.REF%TYPE,
                                          p_mt    IN sw_mt.mt%TYPE,
                                          p_tag   IN sw_tag.tag%TYPE)
      RETURN sw_operw.VALUE%TYPE
   IS
      l_value   sw_operw.VALUE%TYPE;   /* �������� ���. ��������� ��������� */
   BEGIN
      SELECT w.VALUE
        INTO l_value
        FROM operw w
       WHERE     w.REF = p_ref
             AND w.tag IN (SELECT RPAD (
                                        m.tag
                                     || DECODE (o.opt, '-', NULL, o.opt),
                                     5,
                                     ' ')
                             FROM sw_model m, sw_model_opt o
                            WHERE     m.mt = p_mt
                                  AND m.tag = p_tag
                                  AND m.mt = o.mt
                                  AND m.num = o.num);

      RETURN l_value;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN NULL;
   END docmsg_document_getvalue_opt;


   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_GETTAGOPT()
   --
   --     ������� ���������� ����� ���� ��� ��������� ���������,
   --     ������� �������������  ����������  ����  ���������  �
   --     ������, ����� ��� ����� ���� �������� ���� �� �������-
   --     ��� �����.
   --
   --
   --
   FUNCTION docmsg_document_gettagopt (p_ref   IN oper.REF%TYPE,
                                       p_mt    IN sw_mt.mt%TYPE,
                                       p_tag   IN sw_tag.tag%TYPE)
      RETURN sw_opt.opt%TYPE
   IS
      l_value   sw_opt.opt%TYPE;       /* �������� ���. ��������� ��������� */
   BEGIN
      SELECT SUBSTR (w.tag, 3, 1)
        INTO l_value
        FROM operw w
       WHERE     w.REF = p_ref
             AND w.tag IN (SELECT RPAD (
                                        m.tag
                                     || DECODE (o.opt, '-', NULL, o.opt),
                                     5,
                                     ' ')
                             FROM sw_model m, sw_model_opt o
                            WHERE     m.mt = p_mt
                                  AND m.tag = p_tag
                                  AND m.mt = o.mt
                                  AND m.num = o.num);

      RETURN l_value;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN NULL;
   END docmsg_document_gettagopt;



   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_VLDMSG103()
   --
   --     ��������� ��������� ����������� ��� ��������� ��103
   --     �������� ���������
   --
   --
   --
   --
   PROCEDURE docmsg_document_vldmsg103 (p_ref IN oper.REF%TYPE)
   IS
      TYPE t_fld23e_p IS RECORD
      (
         code1   CHAR (4),
         code2   CHAR (4)
      );

      -- ��������� ����
      TYPE t_fld23e_seq IS TABLE OF NUMBER
         INDEX BY VARCHAR2 (4);

      TYPE t_fld23e_pair IS TABLE OF t_fld23e_p
         INDEX BY BINARY_INTEGER;


      l_fld23e_seq    t_fld23e_seq; /*      ������������������ ����� � ����� 23E */
      l_fld23e_pair   t_fld23e_pair; /* ������������ ���������� ����� � ����� 23E */
      l_value         sw_operw.VALUE%TYPE; /*                             �������� ���� */
      l_list          t_strlist; /*   ������ �������� ��� �������������� ���� */


      l_fld56opt      sw_opt.opt%TYPE; /*                            ����� ���� 56a */
      l_fld57opt      sw_opt.opt%TYPE; /*                            ����� ���� 57a */


      l_fld23b        sw_operw.VALUE%TYPE; /*                         �������� ���� 23B */
      l_fld33b        sw_operw.VALUE%TYPE; /*                         �������� ���� 23E */
      l_fld71a        sw_operw.VALUE%TYPE; /*                         �������� ���� 71A */
      l_fld71f        sw_operw.VALUE%TYPE; /*                         �������� ���� 71F */
      l_fld71g        sw_operw.VALUE%TYPE; /*                         �������� ���� 71G */

      l_curr          tabval.lcv%TYPE; /*                            ISO-��� ������ */

      l_cpos          NUMBER;
      l_pos           NUMBER;
   BEGIN
      --
      -- Initializing arrays
      --
      l_fld23e_seq ('SDVA') := 1;
      l_fld23e_seq ('INTC') := 2;
      l_fld23e_seq ('REPA') := 3;
      l_fld23e_seq ('CORT') := 4;
      l_fld23e_seq ('HOLD') := 5;
      l_fld23e_seq ('CHQB') := 6;
      l_fld23e_seq ('PHOB') := 7;
      l_fld23e_seq ('TELB') := 8;
      l_fld23e_seq ('PHON') := 9;
      l_fld23e_seq ('TELE') := 10;
      l_fld23e_seq ('PHOI') := 11;
      l_fld23e_seq ('TELI') := 12;

      l_fld23e_pair (1).code1 := 'SDVA';
      l_fld23e_pair (1).code2 := 'HOLD';
      l_fld23e_pair (2).code1 := 'SDVA';
      l_fld23e_pair (2).code2 := 'CHQB';
      l_fld23e_pair (3).code1 := 'INTC';
      l_fld23e_pair (3).code2 := 'HOLD';
      l_fld23e_pair (4).code1 := 'INTC';
      l_fld23e_pair (4).code2 := 'CHQB';
      l_fld23e_pair (5).code1 := 'CORT';
      l_fld23e_pair (5).code2 := 'HOLD';
      l_fld23e_pair (6).code1 := 'CORT';
      l_fld23e_pair (6).code2 := 'CHQB';
      l_fld23e_pair (7).code1 := 'HOLD';
      l_fld23e_pair (7).code2 := 'CHQB';
      l_fld23e_pair (8).code1 := 'PHOB';
      l_fld23e_pair (8).code2 := 'TELB';
      l_fld23e_pair (9).code1 := 'PHON';
      l_fld23e_pair (9).code2 := 'TELE';
      l_fld23e_pair (10).code1 := 'PHOI';
      l_fld23e_pair (10).code2 := 'TELI';
      l_fld23e_pair (11).code1 := 'REPA';
      l_fld23e_pair (11).code2 := 'HOLD';
      l_fld23e_pair (12).code1 := 'REPA';
      l_fld23e_pair (12).code2 := 'CHQB';
      l_fld23e_pair (13).code1 := 'REPA';
      l_fld23e_pair (13).code2 := 'CORT';


      --
      -- (D98) ���� � ����� 23E ������ ���� � ����� ������������������:
      --       SVDA->INTC->REPA->CORT->HOLD->CHQB->PHOB->TELB->
      --       PHON->TELE->PHOI->TELI
      --
      l_value := genmsg_document_getvalue (p_ref, '23E');

      IF (l_value IS NOT NULL)
      THEN
         l_list := genmsg_document_getvaluelist (l_value);

         l_cpos := 0;

         FOR i IN 1 .. l_list.COUNT
         LOOP
            l_pos := l_fld23e_seq (SUBSTR (l_list (i), 1, 4));

            IF (l_pos < l_cpos)
            THEN
               raise_application_error (
                  -20782,
                  'D98: �������� ������������������ ����� � ���� 23E');
            ELSIF (l_pos = l_cpos)
            THEN
               raise_application_error (
                  -20782,
                  'E46: ������� ������������� ���� � ���� 23E');
            ELSE
               l_cpos := l_pos;
            END IF;
         END LOOP;

         -- ������� ������
         l_list.delete;
      END IF;


      --
      -- (D67) ������������ ���������� ����� � ����� 23�
      --
      --
      l_value := genmsg_document_getvalue (p_ref, '23E');

      IF (l_value IS NOT NULL)
      THEN
         l_list := genmsg_document_getvaluelist (l_value);

         FOR i IN 1 .. l_list.COUNT
         LOOP
            -- ��� ������� �� ����� ���� ������ ��� �� ������ ������������ ����������
            FOR j IN 1 .. l_fld23e_pair.COUNT
            LOOP
               IF (SUBSTR (l_list (i), 1, 4) = l_fld23e_pair (j).code1)
               THEN
                  -- ����� ����������, ��� ��������� ������� ���� (�������������)
                  FOR k IN 1 .. l_list.COUNT
                  LOOP
                     IF (l_fld23e_pair (j).code2 = SUBSTR (l_list (k), 1, 4))
                     THEN
                        raise_application_error (
                           -20782,
                              'D67: ������� ������������ ��������� ����� � ���� 23E: '
                           || SUBSTR (l_list (i), 1, 4)
                           || '<->'
                           || SUBSTR (l_list (k), 1, 4));
                     END IF;
                  END LOOP;
               END IF;
            END LOOP;
         END LOOP;

         -- ������� ������
         l_list.delete;
      END IF;

      --
      -- (TXX) ���� ���� 26T ���������, �� ������ ���� ��������� ���� 77B
      --
      IF (genmsg_document_getvalue (p_ref, '26T') IS NOT NULL)
      THEN
         IF (genmsg_document_getvalue (p_ref, '77B') IS NULL)
         THEN
            raise_application_error (
               -20782,
               'TXX: ��� ���������� ���� 26T �� ��������� ���� 77B');
         END IF;
      END IF;



      --
      -- NVR-C1: (D75) ���� ���� 33B ��������� � ��� ������ � ���� 32A �� �����
      --               ���� ������ � ���� 33B, �� ���� 36 �����������
      --
      l_fld33b := genmsg_document_getvalue (p_ref, '33B');

      IF (l_fld33b IS NOT NULL)
      THEN
         SELECT t.lcv
           INTO l_curr
           FROM oper o, tabval t
          WHERE o.REF = p_ref AND o.kv = t.kv;

         bars_audit.trace ('document currency is %s', l_curr);

         IF (SUBSTR (l_fld33b, 1, 3) != l_curr)
         THEN
            IF (genmsg_document_getvalue (p_ref, '36') IS NULL)
            THEN
               raise_application_error (
                  -20782,
                  'D75: �� ��������� ���� 36 ��� ��������� ���� ������ � ����� 33B � 32A');
            END IF;
         END IF;
      ELSE
         IF (genmsg_document_getvalue (p_ref, '36') IS NOT NULL)
         THEN
            raise_application_error (
               -20782,
               'D75: ������������� ���� 36 ��������� ��� ���� 33B');
         END IF;
      END IF;

      --
      -- NVR-C2: (D49) ���� ������ ����������� ��� ���������� ���� �� ������, �� ���� 33B
      --               �����������. ���� ������ � ���� ������ �� ������, � ���������� ��
      --               ������ ����� ������� �� �������� � ���� ���������� �� �������� ��
      --               �� ���������� �� �����, ������� �������� ����������
      --
      bars_audit.trace ('docmsg_vdldoc103: NVR-C2 skipped');

      --
      -- NVR-C3:       ���� ���� 23B ����� SPRI, �� ��� ���� 23E ��������� ������ ����.
      --               ����: SDVA, TELB, PHONB, INTC (������ E01)
      --               ���� ���� 23B ����� SSTD ��� SPAY, �� ���� 23E �� ������������
      --               (������ E02)
      --
      l_fld23b := genmsg_document_getvalue (p_ref, '23B');

      IF (l_fld23b IS NOT NULL AND l_fld23b = 'SPRI')
      THEN
         l_value := genmsg_document_getvalue (p_ref, '23E');

         IF (l_value IS NOT NULL)
         THEN
            l_list := genmsg_document_getvaluelist (l_value);


            FOR i IN 1 .. l_list.COUNT
            LOOP
               IF (l_list (i) NOT IN ('SDVA',
                                      'TELB',
                                      'PHONB',
                                      'INTC'))
               THEN
                  raise_application_error (
                     -20782,
                     'E01: ������������ ��� � ���� 23E ��� �������� SPRI � ���� 23B');
               END IF;
            END LOOP;

            -- ������� ������
            l_list.delete;
         END IF;
      ELSIF (l_fld23b IS NOT NULL AND l_fld23b IN ('SSTD', 'SPAY'))
      THEN
         IF (genmsg_document_getvalue (p_ref, '23E') IS NOT NULL)
         THEN
            raise_application_error (
               -20782,
               'E02: ������������� ���� 23E ��������� ��� �������� ���� 23B SSTD ��� SPAY');
         END IF;
      END IF;

      --
      -- NVR-C4: (E03) ���� �������� ���� 23B SPRI, SSTD ��� SPAY, �� �������������
      --               ���� 53D ���������
      --
      l_fld23b := genmsg_document_getvalue (p_ref, '23B');

      IF (l_fld23b IS NOT NULL AND l_fld23b IN ('SPRI', 'SSTD', 'SPAY'))
      THEN
         IF (genmsg_document_getvalue (p_ref, '53D') IS NOT NULL)
         THEN
            raise_application_error (
               -20782,
               'E03: ������������� ���� 53D ��������� ��� �������� ���� 23B SPRI, SSTD ��� SPAY');
         END IF;
      END IF;

      --
      -- NVR-C5: (E04) ���� �������� ���� 23B SPRI, SSTD ��� SPAY, �� ��� �������������
      --               ���� 53B ����������� ������ ���� ������ "Party Identifier"
      --
      l_fld23b := genmsg_document_getvalue (p_ref, '23B');

      IF (l_fld23b IS NOT NULL AND l_fld23b IN ('SPRI', 'SSTD', 'SPAY'))
      THEN
         l_value := genmsg_document_getvalue (p_ref, '53B');

         IF (l_value IS NOT NULL AND SUBSTR (l_value, 1, 1) != '/')
         THEN
            raise_application_error (
               -20782,
               'E04: ������������ ������������� ���� 53B ��� �������� ���� 23B SPRI, SSTD ��� SPAY');
         END IF;
      END IF;

      --
      -- NVR-C6: (E05) ���� �������� ���� 23B SPRI, SSTD ��� SPAY, �� ��� �������������
      --               ���� 54� �������� ������ ����� A
      --
      l_fld23b := genmsg_document_getvalue (p_ref, '23B');

      IF (l_fld23b IS NOT NULL AND l_fld23b IN ('SPRI', 'SSTD', 'SPAY'))
      THEN
         l_value := docmsg_document_gettagopt (p_ref, 103, '54');

         IF (l_value IS NOT NULL AND l_value != 'A')
         THEN
            raise_application_error (
               -20782,
               'E05: ������������ ����� ���� 54a ��� �������� ���� 23B SPRI, SSTD ��� SPAY');
         END IF;
      END IF;

      --
      -- NVR-C7: (E06) ���� ��������� ���� 55a, �� ������ ���� ��������� ���� 53a � 54a
      --
      IF (docmsg_document_getvalue_opt (p_ref, 103, '55') IS NOT NULL)
      THEN
         IF (   docmsg_document_getvalue_opt (p_ref, 103, '53') IS NULL
             OR docmsg_document_getvalue_opt (p_ref, 103, '54') IS NULL)
         THEN
            raise_application_error (
               -20782,
               'E06: �� ��������� ���� 53a ��� 54a ��� ����������� ���� 55a');
         END IF;
      END IF;

      --
      -- NVR-C8: (E07) ���� �������� ���� 23B SPRI, SSTD ��� SPAY, �� ��� �������������
      --               ���� 55� �������� ������ ����� A
      --
      l_fld23b := genmsg_document_getvalue (p_ref, '23B');

      IF (l_fld23b IS NOT NULL AND l_fld23b IN ('SPRI', 'SSTD', 'SPAY'))
      THEN
         l_value := docmsg_document_gettagopt (p_ref, 103, '55');

         IF (l_value IS NOT NULL AND l_value != 'A')
         THEN
            raise_application_error (
               -20782,
               'E07: ������������ ����� ���� 55a ��� �������� ���� 23B SPRI, SSTD ��� SPAY');
         END IF;
      END IF;

      --
      -- NVR-C9: (�81) ���� ��������� ���� 56a, �� ������ ���� ��������� ���� 57a
      --
      IF (docmsg_document_getvalue_opt (p_ref, 103, '56') IS NOT NULL)
      THEN
         IF (docmsg_document_getvalue_opt (p_ref, 103, '57') IS NULL)
         THEN
            raise_application_error (
               -20782,
               '�81: �� ��������� ���� 57a ��� ����������� ���� 56a');
         END IF;
      END IF;

      --
      -- NVR-C10:      ���� �������� ���� 23B SPRI, �� ���� 56a ������ ���� ��������� (������ E16)
      --               ���� �������� ���� 23B SSTD ��� SPAY, �� ���� 56a ������ �������������� �
      --               ������� A ��� C (������ E17)
      --
      l_fld23b := genmsg_document_getvalue (p_ref, '23B');

      IF (l_fld23b IS NOT NULL AND l_fld23b = 'SPRI')
      THEN
         IF (docmsg_document_getvalue_opt (p_ref, 103, '56') IS NOT NULL)
         THEN
            raise_application_error (
               -20782,
               'E16: ����������� ���� 56a ��� �������� SPRI � ���� 23B');
         END IF;
      END IF;

      IF (l_fld23b IS NOT NULL AND l_fld23b IN ('SSTD', 'SPAY'))
      THEN
         l_fld56opt := docmsg_document_gettagopt (p_ref, 103, '56');

         IF (l_fld56opt IS NOT NULL AND l_fld56opt NOT IN ('A', 'C'))
         THEN
            raise_application_error (
               -20782,
               'E17: ������������ ����� ���� 56a ��� �������� SSTD ��� SPAY � ���� 23B');
         ELSIF (l_fld56opt IS NOT NULL AND l_fld56opt = 'C')
         THEN
            IF (SUBSTR (genmsg_document_getvalue (p_ref, '56C'), 1, 2) !=
                   '//')
            THEN
               raise_application_error (
                  -20782,
                  'E17: ������������ ����� ���� 56a ��� �������� SSTD ��� SPAY � ���� 23B (C)');
            END IF;
         END IF;
      END IF;

      --
      -- NVR-C11: (E09) ���� �������� ���� 23B SPRI, SSTD ��� SPAY, �� ��� �������������
      --                ���� 57a ������ �������������� ����� A, C, D. ��� �������������
      --                ����� D ������ ���� �������� "Party Identifier"
      --
      l_fld23b := genmsg_document_getvalue (p_ref, '23B');

      IF (l_fld23b IS NOT NULL AND l_fld23b IN ('SPRI', 'SSTD', 'SPAY'))
      THEN
         l_fld57opt := docmsg_document_gettagopt (p_ref, 103, '57');

         IF (l_fld57opt IS NOT NULL AND l_fld57opt NOT IN ('A', 'C', 'D'))
         THEN
            raise_application_error (
               -20782,
               'E09: ������������ ����� ���� 57a ��� �������� SSTD ��� SPAY � ���� 23B');
         ELSIF (l_fld57opt IS NOT NULL AND l_fld57opt = 'D')
         THEN
            IF (SUBSTR (docmsg_document_getvalue_opt (p_ref, 103, '57'),
                        1,
                        1) != '/')
            THEN
               raise_application_error (
                  -20782,
                  'E09: ������������ ����� ���� 57a ��� �������� SSTD ��� SPAY � ���� 23B (D)');
            END IF;
         END IF;
      END IF;

      --
      -- NVR-C12: (E10) ���� �������� ���� 23B SPRI, SSTD ��� SPAY, �� � ���� 59a
      --                ������ �������������� ������� "����"
      --
      l_fld23b := genmsg_document_getvalue (p_ref, '23B');

      IF (l_fld23b IS NOT NULL AND l_fld23b IN ('SPRI', 'SSTD', 'SPAY'))
      THEN
         IF (SUBSTR (docmsg_document_getvalue_opt (p_ref, 103, '59'), 1, 1) !=
                '/')
         THEN
            raise_application_error (
               -20782,
               'E10: �� ��������� ������� "����" � ���� 59a ��� �������� ���� 23B SPRI, SSTD ��� SPAY');
         END IF;
      END IF;

      --
      -- NVR-C13: (E18) ���� ���� 23E �������� ��� CHQB, �� ������� "����" � ���� 59a
      --                ���������
      --
      l_value := genmsg_document_getvalue (p_ref, '23E');

      IF (l_value IS NOT NULL)
      THEN
         l_list := genmsg_document_getvaluelist (l_value);


         FOR i IN 1 .. l_list.COUNT
         LOOP
            IF (l_list (i) = 'CHQB')
            THEN
               IF (SUBSTR (docmsg_document_getvalue_opt (p_ref, 103, '59'),
                           1,
                           1) = '/')
               THEN
                  raise_application_error (
                     -20782,
                     'E18: ������������� ������� "����" � ���� 59a ��������� ��� ������� ���� CHQB � ���� 23E');
               END IF;
            END IF;
         END LOOP;

         -- ������� ������
         l_list.delete;
      END IF;

      --
      -- NVR-C14: (E12) ���� 70 � 77T �����������������
      --
      --
      IF (genmsg_document_getvalue (p_ref, '70') IS NOT NULL)
      THEN
         IF (genmsg_document_getvalue (p_ref, '77T') IS NOT NULL)
         THEN
            raise_application_error (
               -20782,
               'E12: ������������� ������������� ����� 70 � 77T ���������');
         END IF;
      END IF;

      --
      -- NVR-C15: ���� ���� 71A �������� OUR, �� ������������� ���� 71F ���������,
      --          ���� 71G ������������ (������ E13)
      --          ���� ���� 71A �������� SHA, �� ���� 71F ������������, �������������
      --          ���� 71G ��������� (������ D50)
      --          ���� ���� 71A �������� BEN, �� ���� 71F ������������, �������������
      --          ���� 71G ��������� (������ E15)
      --
      l_fld71a := genmsg_document_getvalue (p_ref, '71A');
      l_fld71f := genmsg_document_getvalue (p_ref, '71F');
      l_fld71g := genmsg_document_getvalue (p_ref, '71G');

      IF (l_fld71a = 'OUR')
      THEN
         IF (l_fld71f IS NOT NULL)
         THEN
            raise_application_error (
               -20782,
               'E13: ������������� ���� 71F ��������� ��� �������� OUR ���� 71A');
         END IF;
      ELSIF (l_fld71a = 'SHA')
      THEN
         IF (l_fld71g IS NOT NULL)
         THEN
            raise_application_error (
               -20782,
               'D50: ������������� ���� 71G ��������� ��� �������� SHA ���� 71A');
         END IF;
      ELSIF (l_fld71a = 'BEN')
      THEN
         IF (l_fld71f IS NULL)
         THEN
            raise_application_error (
               -20782,
               'E15: ���� 71F �������� ������������ ��� �������� BEN ���� 71A');
         END IF;

         IF (l_fld71g IS NOT NULL)
         THEN
            raise_application_error (
               -20782,
               'E15: ������������� ���� 71G ��������� ��� �������� BEN ���� 71A');
         END IF;
      END IF;


      --
      -- NVR-C16: (D51) ���� ������������ ���� �� ����� 71F ��� 71G, �� ���� 33B
      --                ����������� � ����������
      --
      l_fld33b := genmsg_document_getvalue (p_ref, '33B');
      l_fld71f := genmsg_document_getvalue (p_ref, '71F');
      l_fld71g := genmsg_document_getvalue (p_ref, '71G');

      IF (    (l_fld71g IS NOT NULL OR l_fld71f IS NOT NULL)
          AND l_fld33b IS NULL)
      THEN
         raise_application_error (
            -20782,
            'D51: �� ��������� ���� 33B ��� ����������� ���� 71F ��� 71G');
      END IF;


      --
      -- NVR-C17: (E44) ���� ���� 56a �����������, �� � ����� 23E �� ����� ����
      --                ����� TELI ��� PHOI
      --
      IF (docmsg_document_getvalue_opt (p_ref, 103, '56') IS NULL)
      THEN
         l_value := genmsg_document_getvalue (p_ref, '23E');

         IF (l_value IS NOT NULL)
         THEN
            l_list := genmsg_document_getvaluelist (l_value);

            FOR i IN 1 .. l_list.COUNT
            LOOP
               IF (   SUBSTR (l_list (i), 1, 4) = 'TELI'
                   OR SUBSTR (l_list (i), 1, 4) = 'PHOI')
               THEN
                  raise_application_error (
                     -20782,
                     'E44: ��� ���������� ���� 56a ����������� ������������� ����� TELI, PHOI � ����� 23E');
               END IF;
            END LOOP;

            -- ������� ������
            l_list.delete;
         END IF;
      END IF;

      --
      -- NVR-C18: (E45) ���� ���� 57a �����������, �� � ����� 23E �� ����� ����
      --                ����� TELE ��� PHON
      --
      IF (docmsg_document_getvalue_opt (p_ref, 103, '57') IS NULL)
      THEN
         l_value := genmsg_document_getvalue (p_ref, '23E');

         IF (l_value IS NOT NULL)
         THEN
            l_list := genmsg_document_getvaluelist (l_value);

            FOR i IN l_list.FIRST .. l_list.LAST
            LOOP
               IF (   SUBSTR (l_list (i), 1, 4) = 'TELE'
                   OR SUBSTR (l_list (i), 1, 4) = 'PHON')
               THEN
                  raise_application_error (
                     -20782,
                     'E45: ��� ���������� ���� 57a ����������� ������������� ����� TELE, PHON � ����� 23E');
               END IF;
            END LOOP;

            -- ������� ������
            l_list.delete;
         END IF;
      END IF;

      --
      -- NVR-C19: (C02) ��� ������ � ����� 71G � 32A ������ ���������
      --
      l_fld71g := genmsg_document_getvalue (p_ref, '71G');

      IF (l_fld71g IS NOT NULL)
      THEN
         SELECT t.lcv
           INTO l_curr
           FROM oper o, tabval t
          WHERE o.REF = p_ref AND o.kv = t.kv;

         bars_audit.trace ('document currency is %s', l_curr);

         IF (SUBSTR (l_fld71g, 1, 3) != l_curr)
         THEN
            raise_application_error (
               -20782,
               'C02: ��� ������ � ����� 71G � 32A ������ ���������');
         END IF;
      END IF;
   END docmsg_document_vldmsg103;


   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_VLDMSG202()
   --
   --     ��������� ��������� ����������� ��� ��������� ��202
   --     �������� ���������
   --
   --
   --
   --
   PROCEDURE docmsg_document_vldmsg202 (p_ref IN oper.REF%TYPE)
   IS
      l_value   sw_operw.VALUE%TYPE;
   BEGIN
      -- NVR-C1:(C81) ���� ���� ���� 56a, �� ������ ���� ���� 57a
      bars_audit.trace ('validating rule MT202-C1: for error C81...');

      IF (docmsg_document_getvalue_opt (p_ref, 202, '56') IS NOT NULL)
      THEN
         bars_audit.trace (
            'field 56a present, checking value in field 57a...');

         l_value := docmsg_document_getvalue_opt (p_ref, 202, '57');

         IF (l_value IS NULL)
         THEN
            bars_audit.error (
               'C81: ���� 57a ������ ���� ���������, ���� ��������� ���� 56a');
            raise_application_error (
               -20782,
               'C81: ���� 57a ������ ���� ���������, ���� ��������� ���� 56a');
         END IF;

         bars_audit.trace ('field 57a present, check MT202-C1 complete.');
      ELSE
         bars_audit.trace ('field 56a not present, skip check MT202-C1.');
      END IF;
   END docmsg_document_vldmsg202;



   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_GETVALUE()
   --
   --     ��������� ��������� �������� ���. ��������� ���������
   --
   --     ���������:
   --
   --         p_doc      ��������� ���������
   --
   --         p_docwtag  ��� ���.���������
   --
   --
   FUNCTION docmsg_document_getvalue (p_doc IN t_doc, p_docwtag IN t_docwtag)
      RETURN t_docwval
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || '.dmdocgetval(s)';
      --
      l_value      t_docwval;                    /* �������� ���. ��������� */
   --
   BEGIN
      bars_audit.trace ('%s: entry point par[0]=>... par[1]=>%s',
                        p,
                        p_docwtag);
      l_value := p_doc.doclistw (p_docwtag).VALUE;
      bars_audit.trace ('%s: succ end, return %s', p, l_value);
      RETURN l_value;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         bars_audit.trace (
            '%s: succ end, return null (docwtag "%s" not found)',
            p,
            p_docwtag);
         RETURN NULL;
   END docmsg_document_getvalue;



   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_GETSPECVALUE()
   --
   --     ��������� ��������� �������� ��� ���� ���������,
   --     ��� �������� ������������ ����. ���������
   --
   --     ���������:
   --
   --         p_doc        ��������� ���������
   --
   --         p_modelrec   ������ ������ ���������
   --
   --         p_opt        �����. ��������. ����� ����
   --
   --         p_docwtag    �����. ��������. ��� ���. ���������
   --
   --
   FUNCTION docmsg_document_getspecvalue (p_doc        IN     t_doc,
                                          p_modelrec   IN     t_swmodelrec,
                                          p_opt           OUT t_swmsg_tagopt,
                                          p_docwtag       OUT t_docwtag)
      RETURN t_docwval
   IS
      p    CONSTANT VARCHAR2 (100) := PKG_CODE || '.dmdocgetspval';
      --
      l_value       t_docwval;                   /* �������� ���. ��������� */
      l_docacca     oper.nlsa%TYPE;              /*     ����� ����� ������� */
      l_amount      NUMBER;
      l_accnostro   NUMBER;
   --
   BEGIN
      bars_audit.trace ('%s: entry point par[0]=>%s par[1]=>%s',
                        p,
                        p_modelrec.tag,
                        p_modelrec.opt);

      -- ���� 32A
      IF (    p_modelrec.mt IN (103, 200, 202)
          AND p_modelrec.tag = '32'
          AND p_modelrec.opt = 'A')
      THEN
         IF (p_doc.docrec.REF IS NULL)
         THEN
            l_amount := p_doc.docrec.s;
         ELSE
            BEGIN
               SELECT TO_NUMBER (VALUE)
                 INTO l_accnostro
                 FROM operw
                WHERE REF = p_doc.docrec.REF AND tag = 'NOS_A';
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  l_accnostro := 0;
            END;

            -- ���� ������� ��� �� ��������, �� �������� ��������� NOS_A=0
            -- � ����� ��������� �� ����� ���������

            IF (l_accnostro > 0)
            THEN
               SELECT s
                 INTO l_amount
                 FROM opldok
                WHERE REF = p_doc.docrec.REF AND dk = 1 AND acc = l_accNostro;
            ELSE
               l_amount := p_doc.docrec.s;
            END IF;
         END IF;

         l_value :=
               TO_CHAR (p_doc.docrec.vdat, 'yymmdd')
            || bars_swift.amounttoswift (l_amount,
                                         p_doc.docrec.kv,
                                         TRUE,
                                         TRUE);
      ELSIF (    p_modelrec.mt = 103
             AND p_modelrec.tag = '23'
             AND p_modelrec.opt = 'B')
      THEN
         -- �������� �������� ���.���������
         l_value := docmsg_document_getvalue (p_doc, TRIM (p_modelrec.dtmtag));
         bars_audit.trace ('%s: document property %s value is %s',
                           p,
                           p_modelrec.dtmtag,
                           l_value);

         -- ����������� ������������� ��������
         IF (l_value IS NULL)
         THEN
            l_value := 'CRED';
            bars_audit.trace ('%s: default value %s is set', p, l_value);
         END IF;
      ELSIF (    p_modelrec.mt = 103
             AND p_modelrec.tag = '70'
             AND p_modelrec.opt IS NULL)
      THEN
         -- �������� �������� ���.���������
         l_value := docmsg_document_getvalue (p_doc, TRIM (p_modelrec.dtmtag));
         bars_audit.trace ('%s: document property %s value is %s',
                           p,
                           p_modelrec.dtmtag,
                           l_value);

         -- ���� ���.��������� ���, ����� �� ���������� �������
         IF (l_value IS NULL)
         THEN
            l_value := str_wrap (SUBSTR (p_doc.docrec.nazn, 1, 120), 30);
            bars_audit.trace ('%s: value get from payment description %s',
                              p,
                              l_value);
         END IF;
      ELSIF (    p_modelrec.mt = 103
             AND p_modelrec.tag = '50'
             AND p_modelrec.opt = 'a')
      THEN
         -- �������� �������� �� ��������� ������
         l_value := docmsg_document_getvalue (p_doc, '50A');
         p_opt := 'A';

         IF (l_value IS NULL)
         THEN
            l_value := docmsg_document_getvalue (p_doc, '50K');
            p_opt := 'K';
         ELSE
            -- ��������� ���������� ����� K
            IF (docmsg_document_getvalue (p_doc, '50K') IS NOT NULL)
            THEN
               bars_audit.trace (
                  '%s: error detected - two or more options found',
                  p);
               bars_error.raise_nerror (MODCODE,
                                        'DOCMSG_TOOMANYOPTIONS_FOUND',
                                        p_modelrec.tag);
            END IF;
         END IF;

         IF (l_value IS NULL)
         THEN
            l_value := docmsg_document_getvalue (p_doc, '50F');
            p_opt := 'F';
         ELSE
            -- ��������� ���������� ����� F
            IF (docmsg_document_getvalue (p_doc, '50F') IS NOT NULL)
            THEN
               bars_audit.trace (
                  '%s: error detected - two or more options found',
                  p);
               bars_error.raise_nerror (MODCODE,
                                        'DOCMSG_TOOMANYOPTIONS_FOUND',
                                        p_modelrec.tag);
            END IF;
         END IF;

         -- �������� ������� �� ����� �����
         IF (l_value IS NULL)
         THEN
            -- ���� �������� �� ���, �� �������� ������
            -- ������������ ��� ���. ��������
            IF (p_doc.docrec.mfoa != gl.aMFO OR p_doc.docrec.REF IS NULL)
            THEN
               RETURN NULL;
            END IF;

            -- �� ������ ����� � ���� ������ �������
            -- ������� � ��� ���������
            SELECT o.nlsa,
                   SUBSTR (c.nmkk, 1, 30) || ' ' || SUBSTR (c.adr, 1, 90)
              INTO l_docacca, l_value
              FROM oper o,
                   accounts a,
                   cust_acc ca,
                   customer c
             WHERE     o.REF = p_doc.docrec.REF
                   AND a.nls = o.nlsa
                   AND a.kv = o.kv
                   AND a.acc = ca.acc
                   AND c.rnk = ca.rnk;

            l_value := '/' || l_docacca || CRLF || str_wrap (l_value, 30);
            p_opt := 'K';
         END IF;
      ELSIF (    p_modelrec.mt = 202
             AND p_modelrec.tag = '21'
             AND p_modelrec.opt IS NULL)
      THEN
         -- �������� �������� ���.���������
         l_value := docmsg_document_getvalue (p_doc, TRIM (p_modelrec.dtmtag));
         bars_audit.trace ('%s: document property %s value is %s',
                           p,
                           p_modelrec.dtmtag,
                           l_value);

         -- ����������� ������������� ��������
         IF (l_value IS NULL)
         THEN
            l_value := 'NONREF';
            bars_audit.trace ('%s: default value %s is set', p, l_value);
         END IF;
      ELSE
         bars_audit.trace ('%s: error detected - unknown spec tag %s opt %s',
                           p,
                           p_modelrec.tag,
                           p_modelrec.opt);
         bars_error.raise_nerror (MODCODE,
                                  'DOCMSG_UNKNOWN_SPECTAG',
                                  p_modelrec.tag || p_modelrec.opt);
      END IF;

      bars_audit.trace ('%s: succ end, return %s', p, l_value);
      RETURN l_value;
   END docmsg_document_getspecvalue;



   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_GETVALUE()
   --
   --     ��������� ��������� �������� ��� ���� ���������
   --
   --     ���������:
   --
   --         p_doc        ��������� ���������
   --
   --         p_modelrec   ������ ������ ���������
   --
   --         p_opt        �����. ��������. ����� ����
   --
   --         p_docwtag    �����. ��������. ��� ���. ���������
   --
   --
   FUNCTION docmsg_document_getvalue (p_doc        IN     t_doc,
                                      p_modelrec   IN     t_swmodelrec,
                                      p_opt           OUT t_swmsg_tagopt,
                                      p_docwtag       OUT t_docwtag)
      RETURN t_docwval
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || '.dmdocgetval';
      --
      l_existopt   BOOLEAN := FALSE; /* ������� ������� ����� (��� ������ ���������) */
      l_value      t_docwval;                    /* �������� ���. ��������� */
   --
   BEGIN
      bars_audit.trace ('%s: entry point', p);


      -- ���� ������� ����.���������, �� �������� �������
      IF (p_modelrec.spec IS NOT NULL AND p_modelrec.spec = 'Y')
      THEN
         l_value :=
            docmsg_document_getspecvalue (p_doc,
                                          p_modelrec,
                                          p_opt,
                                          p_docwtag);

         IF (   p_modelrec.opt != LOWER (p_modelrec.opt)
             OR p_modelrec.opt IS NULL)
         THEN
            p_opt := TRIM (p_modelrec.opt);
         END IF;
      ELSE
         -- ���� �������� ������ ���� �����, �� �������� ��������
         IF (   p_modelrec.opt != LOWER (p_modelrec.opt)
             OR p_modelrec.opt IS NULL)
         THEN
            l_value :=
               docmsg_document_getvalue (p_doc, TRIM (p_modelrec.dtmtag));
            p_opt := TRIM (p_modelrec.opt);
            p_docwtag := TRIM (p_modelrec.dtmtag);
            bars_audit.trace ('%s: fixed option %s, value is %s',
                              p,
                              p_opt,
                              l_value);
         ELSE
            -- ���� ����� ��������� �����, ����� �������������� � ���� ���������
            FOR c IN (SELECT DECODE (o.opt, '-', NULL, o.opt) opt
                        FROM sw_model_opt o
                       WHERE o.mt = p_modelrec.mt AND o.num = p_modelrec.num)
            LOOP
               bars_audit.trace ('%s: looking for option %s...', p, c.opt);

               BEGIN
                  l_value := p_doc.doclistw (p_modelrec.tag || c.opt).VALUE;
                  p_opt := TRIM (c.opt);
                  p_docwtag := p_modelrec.tag || c.opt; -- possible error, i use concat, but need DTMTAG
                  bars_audit.trace ('%s: found option "%s", value is %s',
                                    p,
                                    p_opt,
                                    l_value);

                  IF (l_existopt)
                  THEN
                     bars_audit.trace (
                        '%s: error detected - two or more options found',
                        p);
                     bars_error.raise_nerror (MODCODE,
                                              'DOCMSG_TOOMANYOPTIONS_FOUND',
                                              p_modelrec.tag);
                  ELSE
                     l_existopt := TRUE;
                  END IF;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     bars_audit.trace ('%s: option %s not found', p, c.opt);
               END;

               bars_audit.trace ('%s: option %s processed.', p, c.opt);
            END LOOP;
         END IF;
      END IF;

      bars_audit.trace ('%s: succ end, value %s', p, l_value);
      RETURN l_value;
   END docmsg_document_getvalue;


   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_GETVALUE()
   --
   --     ��������� ��������� �������� ��� ���� ��������� �� ����
   --     ��������� � ���� ����
   --
   --     ���������:
   --
   --         p_doc        ��������� ���������
   --
   --         p_mt         ��� ���� ���������
   --
   --         p_tag        ��� ����
   --
   --         p_opt        ����� ����
   --
   --         p_tagopt     ������������ ��������. ��������������
   --                      �����
   --
   FUNCTION docmsg_document_getvalue (p_doc      IN     t_doc,
                                      p_mt       IN     t_swmt,
                                      p_tag      IN     t_swmsg_tag,
                                      p_opt      IN     t_swmsg_tagopt,
                                      p_tagopt      OUT t_swmsg_tagopt)
      RETURN t_docwval
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || '.dmdocgetval(tagopt)';
      --
      l_modelrec   t_swmodelrec;       /*           �������� ���� ��������� */
      l_opt        t_swmsg_tagopt;     /*         �������������� ����� ���� */
      l_docwtag    t_docwtag;          /*      ��� ���. ��������� ��������� */
      l_docwval    t_docwval;          /* �������� ���. ��������� ��������� */
   --
   BEGIN
      bars_audit.trace ('%s: entry point par[0]=>%s par[1]=>%s par[2]=>%s',
                        p,
                        TO_CHAR (p_mt),
                        p_tag,
                        p_opt);

      -- �������� �������� ���� ���������
      BEGIN
         SELECT *
           INTO l_modelrec
           FROM sw_model
          WHERE     mt = p_mt
                AND tag = p_tag
                AND NVL (TRIM (opt), '-') = NVL (TRIM (p_opt), '-');
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.trace (
               '%s: error detected - tag not found for this message type',
               p);
            bars_error.raise_nerror (MODCODE,
                                     'DOCMSG_MSGMODEL_TAGNOTFOUND',
                                     TO_CHAR (p_mt),
                                     p_tag || p_opt);
         WHEN TOO_MANY_ROWS
         THEN
            bars_audit.trace (
               '%s: error detected - multiple tags found for this criteria',
               p);
            bars_error.raise_nerror (MODCODE,
                                     'DOCMSG_MSGMODEL_TAGNOTFOUND',
                                     TO_CHAR (p_mt),
                                     p_tag || p_opt);
      END;

      bars_audit.trace ('%s: model rec got', p);

      -- �������� ��������
      l_docwval :=
         docmsg_document_getvalue (p_doc,
                                   l_modelrec,
                                   p_tagopt,
                                   l_docwtag);
      bars_audit.trace ('%s: succ end, value %s tagopt %s',
                        p,
                        l_docwval,
                        p_tagopt);
      RETURN l_docwval;
   END docmsg_document_getvalue;


   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_GETVALUE()
   --
   --     ��������� ��������� �������� ��� ���� ��������� �� ����
   --     ��������� � ���� ����
   --
   --     ���������:
   --
   --         p_doc        ��������� ���������
   --
   --         p_mt         ��� ���� ���������
   --
   --         p_tag        ��� ����
   --
   --         p_opt        ����� ����
   --
   FUNCTION docmsg_document_getvalue (p_doc   IN t_doc,
                                      p_mt    IN t_swmt,
                                      p_tag   IN t_swmsg_tag,
                                      p_opt   IN t_swmsg_tagopt)
      RETURN t_docwval
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || '.dmdocgetval(tag)';
      --
      l_tagopt     t_swmsg_tagopt;     /*         �������������� ����� ���� */
      l_docwval    t_docwval;          /* �������� ���. ��������� ��������� */
   --
   BEGIN
      bars_audit.trace ('%s: entry point par[0]=>%s par[1]=>%s par[2]=>%s',
                        p,
                        TO_CHAR (p_mt),
                        p_tag,
                        p_opt);
      l_docwval :=
         docmsg_document_getvalue (p_doc,
                                   p_mt,
                                   p_tag,
                                   p_opt,
                                   l_tagopt);
      bars_audit.trace ('%s: succ end, value %s, tagopt %s',
                        p,
                        l_docwval,
                        l_tagopt);
      RETURN l_docwval;
   END docmsg_document_getvalue;



   -----------------------------------------------------------------
   -- DOCMSG_VALIDATE_FIELD()
   --
   --     ��������� �������� ������������ �������� ���� ���������
   --     (��� ����������� �� ���. ��������� ���������)
   --
   --
   --
   --
   --
   PROCEDURE docmsg_validate_field (p_tag        IN t_swmsg_tag,
                                    p_tagopt     IN t_swmsg_tagopt,
                                    p_tagrpblk   IN t_swmsg_tagrpblk,
                                    p_value      IN t_swmsg_tagvalue)
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || '.dmvldfld';
      --
      l_list       t_swmsg_tagvallist;                   /* ������ �������� */
   --
   BEGIN
      bars_audit.trace (
         '%s: entry poing par[0]=>%s par[1]=>%s par[2]=>%s par[3]=>%s',
         p,
         p_tag,
         p_tagopt,
         p_tagrpblk,
         p_value);

      IF (p_tagrpblk = 'RI')
      THEN
         -- �������� ������ �������� �� �������� ����
         l_list := genmsg_document_getvaluelist (p_value);
         bars_audit.trace ('%s: value list count is %s',
                           p,
                           TO_CHAR (l_list.COUNT));

         -- �������� �� ���� ���������
         FOR j IN l_list.FIRST .. l_list.LAST
         LOOP
            bars_swift.validate_field (p_tag,
                                       p_tagopt,
                                       l_list (j),
                                       1,
                                       0);
            bars_audit.trace ('value item %s validated.', p, TO_CHAR (j));
         END LOOP;
      ELSE
         bars_swift.validate_field (p_tag,
                                    p_tagopt,
                                    p_value,
                                    1,
                                    0);
      END IF;

      bars_audit.trace ('%s: succ end, value validated', p);
   END docmsg_validate_field;


   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_VLDMSG103()
   --
   --     ��������� ��������� ����������� ��� ��������� ��103
   --     �������� ���������
   --
   --
   --
   --
   PROCEDURE docmsg_document_vldmsg103 (p_doc IN t_doc)
   IS
      p      CONSTANT VARCHAR2 (100) := PKG_CODE || '.dmdocvldmsg103';
      --
      l_value23b      t_docwval;                       /* �������� ���� 23B */
      l_value23e      t_docwval;                       /* �������� ���� 23E */
      l_value32a      t_docwval;                       /* �������� ���� 32A */
      l_value33b      t_docwval;                       /* �������� ���� 33B */
      l_value53a      t_docwval;                       /* �������� ���� 53A */
      l_value54a      t_docwval;                       /* �������� ���� 54A */
      l_value55a      t_docwval;                       /* �������� ���� 55A */
      l_value56a      t_docwval;                       /* �������� ���� 56A */
      l_value57a      t_docwval;                       /* �������� ���� 57A */
      l_value71a      t_docwval;                       /* �������� ���� 71A */
      l_value71g      t_docwval;                       /* �������� ���� 71G */
      l_value71f      t_docwval;                       /* �������� ���� 71F */
      --
      l_list23e       t_strlist;                     /* ������ ��� ���� 23E */
      l_tagopt        t_swmsg_tagopt;                         /* ����� ���� */

      --

      TYPE t_fld23e_p IS RECORD
      (
         code1   CHAR (4),
         code2   CHAR (4)
      );

      -- ��������� ����
      TYPE t_fld23e_seq IS TABLE OF NUMBER
         INDEX BY VARCHAR2 (4);

      TYPE t_fld23e_pair IS TABLE OF t_fld23e_p
         INDEX BY BINARY_INTEGER;

      --
      l_fld23e_seq    t_fld23e_seq; /*      ������������������ ����� � ����� 23E */
      l_fld23e_pair   t_fld23e_pair; /* ������������ ���������� ����� � ����� 23E */
      l_pos           NUMBER;
      l_cpos          NUMBER;
   --
   BEGIN
      bars_audit.trace ('%s: entry point', p);

      -- Initializing arrays
      l_fld23e_seq ('SDVA') := 1;
      l_fld23e_seq ('INTC') := 2;
      l_fld23e_seq ('REPA') := 3;
      l_fld23e_seq ('CORT') := 4;
      l_fld23e_seq ('HOLD') := 5;
      l_fld23e_seq ('CHQB') := 6;
      l_fld23e_seq ('PHOB') := 7;
      l_fld23e_seq ('TELB') := 8;
      l_fld23e_seq ('PHON') := 9;
      l_fld23e_seq ('TELE') := 10;
      l_fld23e_seq ('PHOI') := 11;
      l_fld23e_seq ('TELI') := 12;

      l_fld23e_pair (1).code1 := 'SDVA';
      l_fld23e_pair (1).code2 := 'HOLD';
      l_fld23e_pair (2).code1 := 'SDVA';
      l_fld23e_pair (2).code2 := 'CHQB';
      l_fld23e_pair (3).code1 := 'INTC';
      l_fld23e_pair (3).code2 := 'HOLD';
      l_fld23e_pair (4).code1 := 'INTC';
      l_fld23e_pair (4).code2 := 'CHQB';
      l_fld23e_pair (5).code1 := 'CORT';
      l_fld23e_pair (5).code2 := 'HOLD';
      l_fld23e_pair (6).code1 := 'CORT';
      l_fld23e_pair (6).code2 := 'CHQB';
      l_fld23e_pair (7).code1 := 'HOLD';
      l_fld23e_pair (7).code2 := 'CHQB';
      l_fld23e_pair (8).code1 := 'PHOB';
      l_fld23e_pair (8).code2 := 'TELB';
      l_fld23e_pair (9).code1 := 'PHON';
      l_fld23e_pair (9).code2 := 'TELE';
      l_fld23e_pair (10).code1 := 'PHOI';
      l_fld23e_pair (10).code2 := 'TELI';
      l_fld23e_pair (11).code1 := 'REPA';
      l_fld23e_pair (11).code2 := 'HOLD';
      l_fld23e_pair (12).code1 := 'REPA';
      l_fld23e_pair (12).code2 := 'CHQB';
      l_fld23e_pair (13).code1 := 'REPA';
      l_fld23e_pair (13).code2 := 'CORT';

      --
      -- (D98) ���� � ����� 23E ������ ���� � ����� ������������������:
      --       SVDA->INTC->REPA->CORT->HOLD->CHQB->PHOB->TELB->
      --       PHON->TELE->PHOI->TELI
      --
      bars_audit.trace ('%s: validate rule D98...', p);

      l_value23e :=
         docmsg_document_getvalue (p_doc,
                                   MSG_MT103,
                                   '23',
                                   'E');
      bars_audit.trace ('%s: value for tag 23E is %s', p, l_value23e);

      IF (l_value23e IS NOT NULL)
      THEN
         l_list23e := genmsg_document_getvaluelist (l_value23e);
         bars_audit.trace ('%s: list of values created, count %s',
                           p,
                           TO_CHAR (l_list23e.COUNT));

         -- �������� �� ���� ���������
         l_cpos := 0;

         FOR i IN 1 .. l_list23e.COUNT
         LOOP
            l_pos := l_fld23e_seq (SUBSTR (l_list23e (i), 1, 4));

            IF (l_pos < l_cpos)
            THEN
               bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_D98');
            ELSIF (l_pos = l_cpos)
            THEN
               bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E46');
            ELSE
               l_cpos := l_pos;
            END IF;
         END LOOP;

         -- ������� ������
         l_list23e.delete;
      END IF;

      bars_audit.trace ('%s: rule D98 validated.', p);



      --
      -- (D67) ������������ ���������� ����� � ����� 23�
      --
      --
      bars_audit.trace ('%s: validate rule D67...', p);

      l_value23e :=
         docmsg_document_getvalue (p_doc,
                                   MSG_MT103,
                                   '23',
                                   'E');
      bars_audit.trace ('%s: value for tag 23E is %s', p, l_value23e);

      IF (l_value23e IS NOT NULL)
      THEN
         l_list23e := genmsg_document_getvaluelist (l_value23e);
         bars_audit.trace ('%s: list of values created, count %s',
                           p,
                           TO_CHAR (l_list23e.COUNT));

         -- �������� �� ���� ���������
         FOR i IN l_list23e.FIRST .. l_list23e.LAST
         LOOP
            -- ��� ������� �� ����� ��� ��� ��������� � ������ ������������ ����������
            FOR j IN 1 .. l_fld23e_pair.COUNT
            LOOP
               IF (SUBSTR (l_list23e (i), 1, 4) = l_fld23e_pair (j).code1)
               THEN
                  -- �� ������ �������� ���� 23� ��� ��������� ������� ���� (�������������)
                  FOR k IN 1 .. l_list23e.COUNT
                  LOOP
                     IF (l_fld23e_pair (j).code2 =
                            SUBSTR (l_list23e (k), 1, 4))
                     THEN
                        bars_error.raise_nerror (MODCODE,
                                                 'DOCMSG_MSGCHK_D67',
                                                 l_list23e (i),
                                                 l_list23e (k));
                     END IF;
                  END LOOP;
               END IF;
            END LOOP;
         END LOOP;

         bars_audit.trace ('%s: list of values validated.', p);

         -- ������� ������
         l_list23e.delete;
      END IF;

      bars_audit.trace ('%s: rule D67 validated.', p);


      --
      -- (TXX) ���� ���� 26T ���������, �� ������ ���� ��������� ���� 77B
      --
      bars_audit.trace ('%s: validate rule TXX...', p);

      IF (docmsg_document_getvalue (p_doc,
                                    MSG_MT103,
                                    '26',
                                    'T')
             IS NOT NULL)
      THEN
         bars_audit.trace ('%s: looking for tag 77B...', p);

         IF (docmsg_document_getvalue (p_doc,
                                       MSG_MT103,
                                       '77',
                                       'B')
                IS NULL)
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_TXX');
         ELSE
            bars_audit.trace ('%s: tag 77B present, done', p);
         END IF;
      END IF;

      bars_audit.trace ('%s: rule TXX validated.', p);

      --
      -- NVR-C1: (D75) ���� ���� 33B ��������� � ��� ������ � ���� 32A �� �����
      --               ���� ������ � ���� 33B, �� ���� 36 �����������
      --
      bars_audit.trace ('%s: validate rule MT103-C01...', p);

      l_value33b :=
         docmsg_document_getvalue (p_doc,
                                   MSG_MT103,
                                   '33',
                                   'B');
      bars_audit.trace ('%s: value for tag 33B is %s', p, l_value33b);

      IF (l_value33b IS NOT NULL)
      THEN
         bars_audit.trace ('%s: looking for tag 32A value...', p);
         l_value32a :=
            docmsg_document_getvalue (p_doc,
                                      MSG_MT103,
                                      '32',
                                      'A');
         bars_audit.trace ('%s: value for tag 32A is %s', p, l_value32a);

         IF (SUBSTR (l_value33b, 1, 3) != SUBSTR (l_value32a, 7, 3))
         THEN
            bars_audit.trace ('%s: looking for tag 36...', p);

            IF (docmsg_document_getvalue (p_doc,
                                          MSG_MT103,
                                          '36',
                                          '')
                   IS NULL)
            THEN
               bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_D75');
            ELSE
               bars_audit.trace ('%s: tag 36 present, done.', p);
            END IF;
         END IF;
      ELSE
         IF (docmsg_document_getvalue (p_doc,
                                       MSG_MT103,
                                       '36',
                                       '')
                IS NOT NULL)
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_D75');
         END IF;
      END IF;

      bars_audit.trace ('%s: rule MT103-C01 validated.', p);


      --
      -- NVR-C2: (D49) ���� ������ ����������� ��� ���������� ���� �� ������, �� ���� 33B
      --               �����������. ���� ������ � ���� ������ �� ������, � ���������� ��
      --               ������ ����� ������� �� �������� � ���� ���������� �� �������� ��
      --               �� ���������� �� �����, ������� �������� ����������
      --
      bars_audit.trace ('%s: validattion rule MT103-C2 skipped', p);


      --
      -- NVR-C3:       ���� ���� 23B ����� SPRI, �� ��� ���� 23E ��������� ������ ����.
      --               ����: SDVA, TELB, PHONB, INTC (������ E01)
      --               ���� ���� 23B ����� SSTD ��� SPAY, �� ���� 23E �� ������������
      --               (������ E02)
      --
      bars_audit.trace ('%s: validate rule MT103-C03...', p);

      l_value23b :=
         docmsg_document_getvalue (p_doc,
                                   MSG_MT103,
                                   '23',
                                   'B');
      bars_audit.trace ('%s: value for tag 23B is %s', p, l_value23b);

      IF (l_value23b IS NOT NULL AND l_value23b = 'SPRI')
      THEN
         l_value23e :=
            docmsg_document_getvalue (p_doc,
                                      MSG_MT103,
                                      '23',
                                      'E');
         bars_audit.trace ('%s: value for tag 23E is %s', p, l_value23e);

         IF (l_value23e IS NOT NULL)
         THEN
            l_list23e := genmsg_document_getvaluelist (l_value23e);
            bars_audit.trace ('%s: list of values created, count %s',
                              p,
                              TO_CHAR (l_list23e.COUNT));

            -- �������� �� ���� ���������
            FOR i IN l_list23e.FIRST .. l_list23e.LAST
            LOOP
               IF (l_list23e (i) NOT IN ('SDVA',
                                         'TELB',
                                         'PHONB',
                                         'INTC'))
               THEN
                  bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E01');
               END IF;
            END LOOP;

            bars_audit.trace ('%s: list of values validated.', p);

            -- ������� ������
            l_list23e.delete;
         END IF;
      ELSIF (l_value23b IS NOT NULL AND l_value23b IN ('SSTD', 'SPAY'))
      THEN
         IF (docmsg_document_getvalue (p_doc,
                                       MSG_MT103,
                                       '23',
                                       'E')
                IS NOT NULL)
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E02');
         END IF;
      END IF;

      bars_audit.trace ('%s: rule MT103-C03 validated.', p);


      --
      -- NVR-C4: (E03) ���� �������� ���� 23B SPRI, SSTD ��� SPAY, �� �������������
      --               ���� 53D ���������
      --
      bars_audit.trace ('%s: validate rule MT103-C04...', p);

      l_value23b :=
         docmsg_document_getvalue (p_doc,
                                   MSG_MT103,
                                   '23',
                                   'B');
      bars_audit.trace ('%s: value for tag 23B is %s', p, l_value23b);

      IF (l_value23b IS NOT NULL AND l_value23b IN ('SPRI', 'SSTD', 'SPAY'))
      THEN
         l_value53a :=
            docmsg_document_getvalue (p_doc,
                                      MSG_MT103,
                                      '53',
                                      'a',
                                      l_tagopt);
         bars_audit.trace ('%s: tag 53B  value %s', p, l_value53a);

         IF (l_value53a IS NOT NULL AND l_tagopt = 'D')
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E03');
         END IF;
      END IF;

      bars_audit.trace ('%s: rule MT103-C04 validated.', p);


      --
      -- NVR-C5: (E04) ���� �������� ���� 23B SPRI, SSTD ��� SPAY, �� ��� �������������
      --               ���� 53B ����������� ������ ���� ������ "Party Identifier"
      --
      bars_audit.trace ('%s: validate rule MT103-C05...', p);

      l_value23b :=
         docmsg_document_getvalue (p_doc,
                                   MSG_MT103,
                                   '23',
                                   'B');
      bars_audit.trace ('%s: value for tag 23B is %s', p, l_value23b);

      IF (l_value23b IS NOT NULL AND l_value23b IN ('SPRI', 'SSTD', 'SPAY'))
      THEN
         l_value53a :=
            docmsg_document_getvalue (p_doc,
                                      MSG_MT103,
                                      '53',
                                      'a',
                                      l_tagopt);
         bars_audit.trace ('%s: tag 53B  value %s', p, l_value53a);

         IF (    l_value53a IS NOT NULL
             AND l_tagopt = 'B'
             AND SUBSTR (l_value53a, 1, 1) != '/')
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E04');
         END IF;
      END IF;

      bars_audit.trace ('%s: rule MT103-C05 validated.', p);


      --
      -- NVR-C6: (E05) ���� �������� ���� 23B SPRI, SSTD ��� SPAY, �� ��� �������������
      --               ���� 54� �������� ������ ����� A
      --
      bars_audit.trace ('%s: validate rule MT103-C06...', p);

      l_value23b :=
         docmsg_document_getvalue (p_doc,
                                   MSG_MT103,
                                   '23',
                                   'B');
      bars_audit.trace ('%s: value for tag 23B is %s', p, l_value23b);

      IF (l_value23b IS NOT NULL AND l_value23b IN ('SPRI', 'SSTD', 'SPAY'))
      THEN
         l_value54a :=
            docmsg_document_getvalue (p_doc,
                                      MSG_MT103,
                                      '54',
                                      'a',
                                      l_tagopt);
         bars_audit.trace ('%s: tag 54a option %s, value %s',
                           p,
                           l_tagopt,
                           l_value54a);

         IF (l_value54a IS NOT NULL AND l_tagopt != 'A')
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E05');
         END IF;
      END IF;

      bars_audit.trace ('%s: rule MT103-C06 validated.', p);


      --
      -- NVR-C7: (E06) ���� ��������� ���� 55a, �� ������ ���� ��������� ���� 53a � 54a
      --
      bars_audit.trace ('%s: validate rule MT103-C07...', p);

      IF (docmsg_document_getvalue (p_doc,
                                    MSG_MT103,
                                    '55',
                                    'a')
             IS NOT NULL)
      THEN
         bars_audit.trace (
            '%s: tag 55a present, looking for tags 53a and 54a...',
            p);

         IF (   docmsg_document_getvalue (p_doc,
                                          MSG_MT103,
                                          '53',
                                          'a')
                   IS NULL
             OR docmsg_document_getvalue (p_doc,
                                          MSG_MT103,
                                          '54',
                                          'a')
                   IS NULL)
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E06');
         ELSE
            bars_audit.trace ('%s: tags 53a and 54a present, done.', p);
         END IF;
      END IF;

      bars_audit.trace ('%s: rule MT103-C07 validated.', p);


      --
      -- NVR-C8: (E07) ���� �������� ���� 23B SPRI, SSTD ��� SPAY, �� ��� �������������
      --               ���� 55� �������� ������ ����� A
      --
      bars_audit.trace ('%s: validate rule MT103-C08...', p);

      l_value23b :=
         docmsg_document_getvalue (p_doc,
                                   MSG_MT103,
                                   '23',
                                   'B');
      bars_audit.trace ('%s: value for tag 23B is %s', p, l_value23b);

      IF (l_value23b IS NOT NULL AND l_value23b IN ('SPRI', 'SSTD', 'SPAY'))
      THEN
         l_value55a :=
            docmsg_document_getvalue (p_doc,
                                      MSG_MT103,
                                      '55',
                                      'a',
                                      l_tagopt);
         bars_audit.trace ('%s: tag 55a option %s, value %s',
                           p,
                           l_tagopt,
                           l_value55a);

         IF (l_value55a IS NOT NULL AND l_tagopt != 'A')
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E07');
         END IF;
      END IF;

      bars_audit.trace ('%s: rule MT103-C08 validated.', p);


      --
      -- NVR-C9: (�81) ���� ��������� ���� 56a, �� ������ ���� ��������� ���� 57a
      --
      bars_audit.trace ('%s: validate rule MT103-C09...', p);

      IF (docmsg_document_getvalue (p_doc,
                                    MSG_MT103,
                                    '56',
                                    'a')
             IS NOT NULL)
      THEN
         bars_audit.trace ('%s: tag 56a present, looking for tag 57a...', p);

         IF (docmsg_document_getvalue (p_doc,
                                       MSG_MT103,
                                       '57',
                                       'a')
                IS NULL)
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_C81');
         ELSE
            bars_audit.trace ('%s: tag 57a present, done', p);
         END IF;
      END IF;

      bars_audit.trace ('%s: rule MT103-C09 validated.', p);


      --
      -- NVR-C10:      ���� �������� ���� 23B SPRI, �� ���� 56a ������ ���� ��������� (������ E16)
      --               ���� �������� ���� 23B SSTD ��� SPAY, �� ���� 56a ������ �������������� �
      --               ������� A ��� C (������ E17)
      --
      bars_audit.trace ('%s: validate rule MT103-C10...', p);

      l_value23b :=
         docmsg_document_getvalue (p_doc,
                                   MSG_MT103,
                                   '23',
                                   'B');
      bars_audit.trace ('%s: value for tag 23B is %s', p, l_value23b);

      IF (l_value23b IS NOT NULL AND l_value23b = 'SPRI')
      THEN
         IF (docmsg_document_getvalue (p_doc,
                                       MSG_MT103,
                                       '56',
                                       'a')
                IS NULL)
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E16');
         END IF;
      END IF;

      IF (l_value23b IS NOT NULL AND l_value23b IN ('SSTD', 'SPAY'))
      THEN
         l_value56a :=
            docmsg_document_getvalue (p_doc,
                                      MSG_MT103,
                                      '56',
                                      'a',
                                      l_tagopt);
         bars_audit.trace ('%s: tag 56a option %s, value %s',
                           p,
                           l_tagopt,
                           l_value56a);

         IF (l_value56a IS NOT NULL AND l_tagopt NOT IN ('A', 'C'))
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E17');
         ELSIF (l_value56a IS NOT NULL AND l_tagopt = 'C')
         THEN
            IF (SUBSTR (l_value56a, 1, 2) != '//')
            THEN
               bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E17');
            END IF;
         END IF;
      END IF;

      bars_audit.trace ('%s: rule MT103-C10 validated.', p);


      --
      -- NVR-C11: (E09) ���� �������� ���� 23B SPRI, SSTD ��� SPAY, �� ��� �������������
      --                ���� 57a ������ �������������� ����� A, C, D. ��� �������������
      --                ����� D ������ ���� �������� "Party Identifier"
      --
      bars_audit.trace ('%s: validate rule MT103-C11...', p);

      l_value23b :=
         docmsg_document_getvalue (p_doc,
                                   MSG_MT103,
                                   '23',
                                   'B');
      bars_audit.trace ('%s: value for tag 23B is %s', p, l_value23b);

      IF (l_value23b IS NOT NULL AND l_value23b IN ('SPRI', 'SSTD', 'SPAY'))
      THEN
         bars_audit.trace ('%s: looking for tag 57a...', p);
         l_value57a :=
            docmsg_document_getvalue (p_doc,
                                      MSG_MT103,
                                      '57',
                                      'a',
                                      l_tagopt);
         bars_audit.trace ('%s: tag 57a option %s, value %s',
                           p,
                           l_tagopt,
                           l_value57a);

         IF (l_value57a IS NOT NULL AND l_tagopt NOT IN ('A', 'C', 'D'))
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E09');
         ELSIF (l_value57a IS NOT NULL AND l_tagopt = 'D')
         THEN
            IF (SUBSTR (l_value57a, 1, 1) != '/')
            THEN
               bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E09');
            END IF;
         END IF;
      END IF;

      bars_audit.trace ('%s: rule MT103-C11 validated.', p);


      --
      -- NVR-C12: (E10) ���� �������� ���� 23B SPRI, SSTD ��� SPAY, �� � ���� 59a
      --                ������ �������������� ������� "����"
      --
      bars_audit.trace ('%s: validate rule MT103-C12...', p);

      l_value23b :=
         docmsg_document_getvalue (p_doc,
                                   MSG_MT103,
                                   '23',
                                   'B');
      bars_audit.trace ('%s: value for tag 23B is %s', p, l_value23b);

      IF (l_value23b IS NOT NULL AND l_value23b IN ('SPRI', 'SSTD', 'SPAY'))
      THEN
         IF (SUBSTR (docmsg_document_getvalue (p_doc,
                                               MSG_MT103,
                                               '59',
                                               'a'),
                     1,
                     1) != '/')
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E10');
         END IF;
      END IF;

      bars_audit.trace ('%s: rule MT103-C12 validated.', p);


      --
      -- NVR-C13: (E18) ���� ���� 23E �������� ��� CHQB, �� ������� "����" � ���� 59a
      --                ���������
      --
      bars_audit.trace ('%s: validate rule MT103-C13...', p);

      l_value23e :=
         docmsg_document_getvalue (p_doc,
                                   MSG_MT103,
                                   '23',
                                   'E');
      bars_audit.trace ('%s: value for tag 23E is %s', p, l_value23e);

      IF (l_value23e IS NOT NULL)
      THEN
         l_list23e := genmsg_document_getvaluelist (l_value23e);
         bars_audit.trace ('%s: list of values created, count %s',
                           p,
                           TO_CHAR (l_list23e.COUNT));

         -- �������� �� ���� ���������
         FOR i IN l_list23e.FIRST .. l_list23e.LAST
         LOOP
            IF (l_list23e (i) = 'CHQB')
            THEN
               IF (SUBSTR (docmsg_document_getvalue (p_doc,
                                                     MSG_MT103,
                                                     '59',
                                                     'a'),
                           1,
                           1) = '/')
               THEN
                  bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E18');
               END IF;
            END IF;
         END LOOP;

         bars_audit.trace ('%s: list of values validated.', p);

         -- ������� ������
         l_list23e.delete;
      END IF;

      bars_audit.trace ('%s: rule MT103-C13 validated.', p);


      --
      -- NVR-C14: (E12) ���� 70 � 77T �����������������
      --
      --
      bars_audit.trace ('%s: validate rule MT103-C14...', p);

      IF (docmsg_document_getvalue (p_doc,
                                    MSG_MT103,
                                    '70',
                                    '')
             IS NOT NULL)
      THEN
         bars_audit.trace ('%s: tag 70 present, looking for tag 77T...', p);

         IF (docmsg_document_getvalue (p_doc,
                                       MsG_MT103,
                                       '77',
                                       'T')
                IS NOT NULL)
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E12');
         ELSE
            bars_audit.trace ('%s: tag 77T not present, continue', p);
         END IF;
      END IF;

      bars_audit.trace ('%s: rule MT103-C14 validated.', p);


      --
      -- NVR-C15: ���� ���� 71A �������� OUR, �� ������������� ���� 71F ���������,
      --          ���� 71G ������������ (������ E13)
      --          ���� ���� 71A �������� SHA, �� ���� 71F ������������, �������������
      --          ���� 71G ��������� (������ D50)
      --          ���� ���� 71A �������� BEN, �� ���� 71F ������������, �������������
      --          ���� 71G ��������� (������ E15)
      --
      bars_audit.trace ('%s: validate rule MT103-C15...', p);

      l_value71a :=
         docmsg_document_getvalue (p_doc,
                                   MSG_MT103,
                                   '71',
                                   'A');
      l_value71f :=
         docmsg_document_getvalue (p_doc,
                                   MSG_MT103,
                                   '71',
                                   'F');
      l_value71g :=
         docmsg_document_getvalue (p_doc,
                                   MSG_MT103,
                                   '71',
                                   'G');
      bars_audit.trace (
         '%s: values for tag 71A is %s, tag 71F is %s, tag 71G is %s',
         p,
         l_value71a,
         l_value71f,
         l_value71g);

      IF (l_value71a = 'OUR')
      THEN
         IF (l_value71f IS NOT NULL)
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E13');
         END IF;
      ELSIF (l_value71a = 'SHA')
      THEN
         IF (l_value71g IS NOT NULL)
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_D50');
         END IF;
      ELSIF (l_value71a = 'BEN')
      THEN
         IF (l_value71f IS NULL OR l_value71g IS NOT NULL)
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E15');
         END IF;
      END IF;

      bars_audit.trace ('%s: rule MT103-C15 validated.', p);


      --
      -- NVR-C16: (D51) ���� ������������ ���� �� ����� 71F ��� 71G, �� ���� 33B
      --                ����������� � ����������
      --
      bars_audit.trace ('%s: validate rule MT103-C16...', p);

      l_value71f :=
         docmsg_document_getvalue (p_doc,
                                   MSG_MT103,
                                   '71',
                                   'F');
      l_value71g :=
         docmsg_document_getvalue (p_doc,
                                   MSG_MT103,
                                   '71',
                                   'G');
      bars_audit.trace ('%s: values for tag 71F is %s, tag 71G is %s',
                        p,
                        l_value71f,
                        l_value71g);

      IF (l_value71f IS NOT NULL OR l_value71g IS NOT NULL)
      THEN
         l_value33b :=
            docmsg_document_getvalue (p_doc,
                                      MSG_MT103,
                                      '33',
                                      'B');
         bars_audit.trace ('%s: value for tag 33B is %s', p, l_value33b);

         IF (l_value33b IS NULL)
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_D51');
         END IF;
      END IF;

      bars_audit.trace ('%s: rule MT103-C16 validated.', p);


      --
      -- NVR-C17: (E44) ���� ���� 56a �����������, �� � ����� 23E �� ����� ����
      --                ����� TELI ��� PHOI
      --
      bars_audit.trace ('%s: validate rule MT103-C17...', p);

      IF (docmsg_document_getvalue (p_doc,
                                    MSG_MT103,
                                    '56',
                                    'a')
             IS NULL)
      THEN
         -- �������� �������� ���� 23E
         l_value23e :=
            docmsg_document_getvalue (p_doc,
                                      MSG_MT103,
                                      '23',
                                      'E');
         bars_audit.trace ('%s: value for tag 23E is %s', p, l_value23e);

         IF (l_value23e IS NOT NULL)
         THEN
            l_list23e := genmsg_document_getvaluelist (l_value23e);
            bars_audit.trace ('%s: list of values created, count %s',
                              p,
                              TO_CHAR (l_list23e.COUNT));

            -- �������� �� ���� ���������
            FOR i IN l_list23e.FIRST .. l_list23e.LAST
            LOOP
               IF (SUBSTR (l_list23e (i), 1, 4) IN ('TELI', 'PHOI'))
               THEN
                  bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E44');
               END IF;
            END LOOP;

            bars_audit.trace ('%s: list of values validated.', p);

            -- ������� ������
            l_list23e.delete;
         END IF;
      END IF;

      bars_audit.trace ('%s: rule MT103-C17 validated.', p);


      --
      -- NVR-C18: (E45) ���� ���� 57a �����������, �� � ����� 23E �� ����� ����
      --                ����� TELE ��� PHON
      --
      bars_audit.trace ('%s: validate rule MT103-C18...', p);

      IF (docmsg_document_getvalue (p_doc,
                                    MSG_MT103,
                                    '57',
                                    'a')
             IS NULL)
      THEN
         -- �������� �������� ���� 23E
         l_value23e :=
            docmsg_document_getvalue (p_doc,
                                      MSG_MT103,
                                      '23',
                                      'E');
         bars_audit.trace ('%s: value for tag 23E is %s', p, l_value23e);

         IF (l_value23e IS NOT NULL)
         THEN
            l_list23e := genmsg_document_getvaluelist (l_value23e);
            bars_audit.trace ('%s: list of values created, count %s',
                              p,
                              TO_CHAR (l_list23e.COUNT));

            -- �������� �� ���� ���������
            FOR i IN l_list23e.FIRST .. l_list23e.LAST
            LOOP
               IF (SUBSTR (l_list23e (i), 1, 4) IN ('TELE', 'PHON'))
               THEN
                  bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_E45');
               END IF;
            END LOOP;

            bars_audit.trace ('%s: list of values validated.', p);

            -- ������� ������
            l_list23e.delete;
         END IF;
      END IF;

      bars_audit.trace ('%s: rule MT103-C18 validated.', p);

      --
      -- NVR-C19: (C02) ��� ������ � ����� 71G � 32A ������ ���������
      --
      bars_audit.trace ('%s: validate rule MT103-C19...', p);

      l_value71g :=
         docmsg_document_getvalue (p_doc,
                                   MSG_MT103,
                                   '71',
                                   'G');
      bars_audit.trace ('%s: value for tag 71G is %s', p, l_value71g);

      IF (l_value71g IS NOT NULL)
      THEN
         -- �������� �������� ��� ���� 32A
         l_value32a :=
            docmsg_document_getvalue (p_doc,
                                      MSG_MT103,
                                      '32',
                                      'A');
         bars_audit.trace ('%s: value for tag 32A is %s', p, l_value32a);

         -- ���������� ��� ������ � ����� 32A � 71G
         IF (SUBSTR (l_value71g, 1, 3) != SUBSTR (l_value32a, 7, 3))
         THEN
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_C02');
         END IF;
      END IF;

      bars_audit.trace ('%s: rule MT103-C19 validated.', p);


      bars_audit.trace ('%s: succ end', p);
   END docmsg_document_vldmsg103;


   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_VLDMSG202()
   --
   --     ��������� ��������� ����������� ��� ��������� ��202
   --     �������� ���������
   --
   --
   --
   --
   PROCEDURE docmsg_document_vldmsg202 (p_doc IN t_doc)
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || '.dmdocvldmsg202';
   BEGIN
      bars_audit.trace ('%s: entry point', p);

      --
      -- NVR-C1:(C81) ���� ���� ���� 56a, �� ������ ���� ���� 57a
      --
      bars_audit.trace ('%s: validate rule MT202-C1...', p);

      IF (docmsg_document_getvalue (p_doc,
                                    MSG_MT202,
                                    '56',
                                    'a')
             IS NOT NULL)
      THEN
         bars_audit.trace ('%s: tag 56a present, looking for tag 57a...', p);

         IF (docmsg_document_getvalue (p_doc,
                                       MSG_MT202,
                                       '57',
                                       'a')
                IS NULL)
         THEN
            bars_audit.trace ('%s: error detected - tag 57a not found', p);
            bars_error.raise_nerror (MODCODE, 'DOCMSG_MSGCHK_C81');
         END IF;

         bars_audit.trace ('%s: tag 57a present, check MT202-C1 completed.',
                           p);
      ELSE
         bars_audit.trace ('%s: tag 56a not present, skip check MT202-C1.',
                           p);
      END IF;

      bars_audit.trace ('%s: rule MT202-C1 validated.', p);

      bars_audit.trace ('%s: succ end', p);
   END docmsg_document_vldmsg202;



   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_VALIDATE()
   --
   --     ��������� �������� ������������ ���. ���������� ���������
   --     �� �������� ����� ������������� ��������� SWIFT
   --
   --
   --
   --
   --
   PROCEDURE docmsg_document_validate (p_doc IN t_doc)
   IS
      p     CONSTANT VARCHAR2 (100) := PKG_CODE || '.dmdocvld';
      --
      l_mt           t_swmt;                               /* ��� ��������� */

      --
      ERR   CONSTANT NUMBER := -20782;


      p_ref          NUMBER; -- ����� �� ������������, ��������� ������ ������


      -- l_mt    sw_mt.mt%type;        /* ��� ��������� */
      -- l_opt   varchar2(1);          /* ����� ���� */
      -- l_value sw_operw.value%type;  /* �������� ���� */
      -- l_list  t_strlist;            /* ������ �������� */

      l_docwtag      t_docwtag;                  /*      ��� ���. ��������� */
      l_docwval      t_docwval;                  /* �������� ���. ��������� */
      l_opt          t_swmsg_tagopt;             /*              ����� ���� */
   BEGIN
      bars_audit.trace ('%s: entry poing par[0]=>%s',
                        p,
                        TO_CHAR (p_doc.docrec.REF));

      -- �������� ���. �������� - ������� ������������ ���������
      IF (NOT docmsg_checkmsgflag (p_doc))
      THEN
         bars_audit.trace (
            '%s: swift flag not set, document ref %s not validated.',
            p,
            TO_CHAR (p_doc.docrec.REF));
         RETURN;
      END IF;

      -- �������� ��� ���������, ������� ����� ����� �����������
      l_mt := genmsg_document_getmt (p_doc);
      bars_audit.trace ('%s: document message type is %s', p, TO_CHAR (l_mt));

      --
      -- �������� ���������:
      --
      --  �������� ����������:
      --
      --    ���� 1. �������� ������� ������������ ����� � �� ������
      --    ���� 2. �������� �������� � �������������� �����
      --    ���� 3. ����������� �������� � ����������� �� ���� ���������
      --

      bars_audit.trace ('%s: document validation step 1...', p);

      -- ���� �� ������������ ������������ �����
      FOR c
         IN (SELECT *
               FROM sw_model
              WHERE     mt = l_mt
                    AND status = TAGSTATE_MANDATORY
                    AND tag || opt != '20')
      LOOP
         bars_audit.trace ('%s: processing tag=%s opt=%s...',
                           p,
                           c.tag,
                           c.opt);

         -- �������� ��������
         l_docwval :=
            docmsg_document_getvalue (p_doc,
                                      c,
                                      l_opt,
                                      l_docwtag);
         bars_audit.trace ('%s: document property %s value is %s',
                           p,
                           l_docwtag,
                           l_docwval);

         IF (l_docwval IS NULL)
         THEN
            bars_audit.trace (
               '%s: error - mandatory document property %s is NULL',
               p);
            bars_error.raise_nerror (MODCODE,
                                     'DOCMSG_MANDATORYFIELD_NOTFOUND',
                                     l_docwtag);
         END IF;

         -- ��������� �������� �������� ����
         docmsg_validate_field (c.tag,
                                l_opt,
                                c.rpblk,
                                l_docwval);
         bars_audit.trace ('%s: value for tag %s%s succesfully validated.',
                           p,
                           c.tag,
                           l_opt);
         bars_audit.trace ('%s: tag=%s opt=%s processed.',
                           p,
                           c.tag,
                           c.opt);
      END LOOP;

      bars_audit.trace ('%s: document validation step 1 completed.', p);


      bars_audit.trace ('document validation step 2...');

      -- �������� �� �������������� �����
      FOR c IN (SELECT *
                  FROM sw_model
                 WHERE mt = l_mt AND status = 'O')
      LOOP
         bars_audit.trace ('%s: processing tag=%s opt=%s...',
                           p,
                           c.tag,
                           c.opt);

         -- �������� ��������
         l_docwval :=
            docmsg_document_getvalue (p_doc,
                                      c,
                                      l_opt,
                                      l_docwtag);
         bars_audit.trace ('%s: document property %s value is %s',
                           l_docwtag,
                           l_docwval);

         IF (l_docwval IS NOT NULL)
         THEN
            -- ��������� �������� �������� ����
            docmsg_validate_field (c.tag,
                                   l_opt,
                                   c.rpblk,
                                   l_docwval);
            bars_audit.trace (
               '%s: value for tag %s%s succesfully validated.',
               p,
               c.tag,
               l_opt);
         END IF;

         bars_audit.trace ('%s: tag=%s opt=%s processed.', c.tag, c.opt);
      END LOOP;

      bars_audit.trace ('%s: document validation step 2 completed.', p);

      bars_audit.trace ('document validation step 3...');

      -- ��� ������� ���� ��������� ����� ���� ��������� ��������
      IF (l_mt = 103)
      THEN
         docmsg_document_vldmsg103 (p_doc);
      ELSIF (l_mt = 200)
      THEN
         bars_audit.trace (
            'NVR not present for message type 200, skip this step.');
      ELSIF (l_mt = 202)
      THEN
         docmsg_document_vldmsg202 (p_doc);
      ELSE
         bars_audit.trace (
               'NVR not implemented for message type '
            || TO_CHAR (l_mt)
            || ', skip this step.');
      END IF;

      bars_audit.trace ('document validation step 3 complete.');
      bars_audit.trace ('%s: succ end', p);
   END docmsg_document_validate;



   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_VALIDATE()
   --
   --     ��������� �������� ������������ ���. ���������� ���������
   --     �� �������� ����� ������������� ��������� SWIFT
   --
   --
   --
   --
   --
   PROCEDURE docmsg_document_validate (p_ref IN oper.REF%TYPE)
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || '.dmdocvld0';
      --
      l_doc        t_doc;
   --

       ERR     constant number := -20782;
       l_mt    sw_mt.mt%type;
       l_opt   varchar2(1);
       l_value sw_operw.value%type;
       l_list  t_strlist;

   BEGIN
      bars_audit.trace ('%s: entry point par[0]=>%s', p, TO_CHAR (p_ref));

      -- �������� ��������� �� ���������
      SELECT *
        INTO l_doc.docrec
        FROM oper
       WHERE REF = p_ref;

      FOR c IN (SELECT TRIM (tag) tag, VALUE
                  FROM operw
                 WHERE REF = p_ref)
      LOOP
         l_doc.doclistw (c.tag).VALUE := c.VALUE;
      END LOOP;

      -- �������� ��������� ��������
      docmsg_document_validate (l_doc);
-------


              -- �������� ���. �������� - ������� ������������ ���������
              if (not docmsg_checkmsgflag(p_ref)) then
                   bars_audit.trace('swift flag not set, document ref=%s not validated.', to_char(p_ref));
                   return;
              end if;

              -- �������� ��� ���������, ������� ����� ����� �����������
              l_mt := genmsg_document_getmt(
                          p_ref    =>      p_ref);

              bars_audit.trace('document message type is %s', to_char(l_mt));

              --
              -- �������� ���������:
              --
              --  �������� ���������:
              --
              --    ��������� ����� ���������
              --
              --  �������� ����������:
              --
              --    ���� 1. �������� ������� ������������ ����� � �� ������
              --    ���� 2. �������� �������� � �������������� �����
              --    ���� 3. ����������� �������� � ����������� �� ���� ���������
              --

              bars_audit.trace('document msg header validation...');

              -- �������� ����� ���������
              l_value := genmsg_document_getmsgflg(
                                         p_ref  => p_ref,
                                         p_tag  => 'SWAHF' );

              bars_audit.trace('application header flags (SWAHF) =>%s', l_value);

              if (l_value is not null) then
                  bars_swift.genmsg_validate_apphdrflags(l_value, l_mt);
              end if;

              bars_audit.trace('document msg header validated.');


              bars_audit.trace('document validation step 1...');


              for i in (select *
                          from sw_model
                         where mt     = l_mt
                           and status = 'M'
                           and tag || opt not in ('20', '32A'))
              loop

                  if (i.spec is not null and i.spec = 'Y') then

                      l_value := genmsg_document_getvalue_ex(
                                     p_model =>  i,
                                     p_swref => null,
                                     p_ref   => p_ref,
                                     p_recno => null,
                                     p_opt   => l_opt );

                      if (i.opt != lower(i.opt) or i.opt is null) then
                          l_opt := trim(i.opt);
                      end if;

                  else

                      if (i.opt != lower(i.opt) or i.opt is null) then

                          l_value := genmsg_document_getvalue(
                                         p_ref  => p_ref,
                                         p_tag  => i.tag || i.opt );

                          l_opt := trim(i.opt);

                      else

                          -- �������� �������������� �����
                          begin
                              select trim(substr(tag, 3, 1)) into l_opt
                                from operw w
                               where w.ref = p_ref
                                 and trim(w.tag) in (select m.tag || decode(o.opt, '-', null, o.opt)
                                                       from sw_model m, sw_model_opt o
                                                      where m.mt  = i.mt
                                                        and m.num = i.num
                                                        and m.mt  = o.mt
                                                        and m.num = o.num );

                          exception
                              when NO_DATA_FOUND then
                                  raise_application_error(ERR, '\930 ��� ������������� ���� ' || i.tag || 'a');
                              when TOO_MANY_ROWS then
                                  raise_application_error(ERR, '\931 ����������� ���� ' || i.tag || 'a');
                          end;

                          -- �������� ��������
                          l_value := genmsg_document_getvalue(
                                         p_ref  => p_ref,
                                         p_tag  => i.tag || l_opt );

                      end if;

                  end if;

                  bars_audit.trace('value for tag %s =>%s', i.tag || l_opt, l_value);

                  if (l_value is null) then
                      raise_application_error(ERR, '\930 ��� ������������� ���� ' || i.tag || l_opt);
                  end if;

                  -- ��������� �������� ����
                  docmsg_validate_field(i.tag, l_opt, i.rpblk, l_value);
                  bars_audit.trace('field %s%s succesfully validated.', i.tag, l_opt);

              end loop;

              bars_audit.trace('document validation step 1 complete.');

              bars_audit.trace('document validation step 2...');

              for i in (select *
                          from sw_model
                         where mt     = l_mt
                           and status = 'O' )
              loop

                  if (i.spec is not null and i.spec = 'Y') then

                      l_value := genmsg_document_getvalue_ex(
                                     p_model =>  i,
                                     p_swref => null,
                                     p_ref   => p_ref,
                                     p_recno => null,
                                     p_opt   => l_opt );

                      if (i.opt != lower(i.opt) or i.opt is null) then
                          l_opt := trim(i.opt);
                      end if;

                  else

                      if (i.opt != lower(i.opt) or i.opt is null) then

                          l_value := genmsg_document_getvalue(
                                         p_ref  => p_ref,
                                         p_tag  => i.tag || i.opt );

                          l_opt := trim(i.opt);

                      else

                          -- �������� �������������� �����
                          begin
                              select trim(substr(tag, 3, 1)) into l_opt
                                from operw w
                               where w.ref = p_ref
                                 and trim(w.tag) in (select m.tag || decode(o.opt, '-', null, o.opt)
                                                       from sw_model m, sw_model_opt o
                                                      where m.mt  = i.mt
                                                        and m.num = i.num
                                                        and m.mt  = o.mt
                                                        and m.num = o.num );

                          exception
                              when NO_DATA_FOUND then null;
                              when TOO_MANY_ROWS then
                                  raise_application_error(ERR, '\931 ����������� ���� ' || i.tag || 'a');
                          end;

                          -- �������� ��������
                          l_value := genmsg_document_getvalue(
                                         p_ref  => p_ref,
                                         p_tag  => i.tag || l_opt );

                      end if;

                  end if;

                  bars_audit.trace('value for tag %s =>%s', i.tag || l_opt, l_value);

                  -- ��������� �������� ����
                  if (l_value is not null) then
                      docmsg_validate_field(i.tag, l_opt, i.rpblk, l_value);
                  end if;
                  bars_audit.trace('field %s%s succesfully validated.', i.tag, l_opt);

              end loop;

              bars_audit.trace('document validation step 2 complete.');



              bars_audit.trace('document validation step 3...');

              -- ��� ������� ���� ��������� ����� ���� ��������� ��������
              if    (l_mt = 103) then
                  docmsg_document_vldmsg103(p_ref=>p_ref);
              elsif (l_mt = 200) then
                  bars_audit.trace('Network validation rules not present for message type 200, skip this step.');
              elsif (l_mt = 202) then
                  docmsg_document_vldmsg202(p_ref=>p_ref);
              else
                  bars_audit.trace('Network validation rules not implemented for message type ' || to_char(l_mt) || ', skip this step.');
              end if;

              bars_audit.trace('document validation step 3 complete.');

     ----------------

      bars_audit.trace ('%s: succ end', p);
   END docmsg_document_validate;



   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_VLDTRANS()
   --
   --     ��������� �������� ������������ ���. ���������� ���������
   --     ����� ���������� �������������� �����
   --
   --
   --
   --
   --
   PROCEDURE docmsg_document_vldtrans (p_ref IN oper.REF%TYPE)
   IS
      TYPE t_list_chrtab IS TABLE OF sw_chrsets.setid%TYPE;

      l_listChrTab   t_list_chrtab; /*         ������ ������ �������������� */
      l_mt           sw_mt.mt%TYPE; /*                        ��� ��������� */
      l_opt          VARCHAR2 (1);  /*                           ����� ���� */
      l_value        sw_operw.VALUE%TYPE; /*                        �������� ���� */
      l_transvalue   sw_operw.VALUE%TYPE; /*   �������� ���� ����� �������������� */
      l_cnt          NUMBER;        /*                              ������� */
      l_istrans      BOOLEAN;       /*          ������� �������������� ���� */
   BEGIN
      bars_audit.trace ('validating translation document ref=%s...',
                        TO_CHAR (p_ref));

      -- �������� ���. �������� - ������� ������������ ���������
      IF (NOT docmsg_checkmsgflag (p_ref))
      THEN
         bars_audit.trace (
            'swift flag not set, document ref=%s not validated.',
            TO_CHAR (p_ref));
         RETURN;
      END IF;

      -- �������� ��� ���������, ������� ����� ����� �����������
      l_mt := genmsg_document_getmt (p_ref => p_ref);

      bars_audit.trace ('document message type is %s', TO_CHAR (l_mt));

      --
      -- ���� � ��������� ���� ���.�������� 20="+", �� ������ �� ������
      --
      IF (genmsg_document_getvalue (p_ref, '20') = '+')
      THEN
         bars_audit.trace (
            'document is alredy translated, validation skipped...');
         RETURN;
      END IF;

      --
      -- �������� ������ ������ ��������������
      --
      SELECT setid
        BULK COLLECT INTO l_listChrTab
        FROM sw_chrsets;

      --
      -- ���� �� ���� �����, ������� ������� ��������������, ��������������� ��
      -- ���� ��������� �������� � ��������� ������
      --
      FOR i IN (  SELECT *
                    FROM sw_model
                   WHERE mt = l_mt
                ORDER BY num)
      LOOP
         l_value := NULL;
         l_istrans := FALSE;

         --
         -- ���� ����� ����������, �� ������ ��������� ������� ��������������
         --
         IF (i.opt IS NOT NULL AND i.opt = LOWER (i.opt))
         THEN
            SELECT COUNT (*)
              INTO l_cnt
              FROM sw_model_opt
             WHERE mt = l_mt AND num = i.num AND trans = 'Y';

            IF (l_cnt > 0)
            THEN
               l_istrans := TRUE;
            END IF;
         ELSE
            IF (i.trans = 'Y')
            THEN
               l_istrans := TRUE;
            END IF;
         END IF;

         --
         -- �������� �������� ���. ���������
         --

         IF (l_istrans)
         THEN
            IF (i.spec IS NOT NULL AND i.spec = 'Y')
            THEN
               l_value :=
                  genmsg_document_getvalue_ex (p_model   => i,
                                               p_swref   => NULL,
                                               p_ref     => p_ref,
                                               p_recno   => NULL,
                                               p_opt     => l_opt);

               IF (i.opt != LOWER (i.opt) OR i.opt IS NULL)
               THEN
                  l_opt := i.opt;
               END IF;
            ELSIF (i.opt = LOWER (i.opt))
            THEN
               BEGIN
                  SELECT SUBSTR (tag, 3, 1), VALUE
                    INTO l_opt, l_value
                    FROM operw
                   WHERE     REF = p_ref
                         AND TRIM (tag) IN (SELECT tag || opt
                                              FROM sw_model_opt
                                             WHERE mt = l_mt AND num = i.num);
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     NULL;
               END;
            ELSE
               l_value := genmsg_document_getvalue (p_ref, i.tag || i.opt);
               l_opt := i.opt;
            END IF;

            --
            -- ���� ����� ����� ���� �������� ��������� ���������� �����
            -- �� ������� ������������� ��������������
            --
            IF (i.opt = LOWER (i.opt))
            THEN
               SELECT COUNT (*)
                 INTO l_cnt
                 FROM sw_model_opt
                WHERE     mt = l_mt
                      AND num = i.num
                      AND opt = DECODE (l_opt, NULL, '-', l_opt)
                      AND trans = 'Y';

               IF (l_cnt = 0)
               THEN
                  l_value := NULL;
               END IF;
            END IF;
         END IF;


         IF (l_value IS NOT NULL)
         THEN
            bars_audit.trace ('tag=%s opt=%s doc value=%s',
                              i.tag,
                              i.opt,
                              l_value);

            FOR t IN 1 .. l_listChrTab.COUNT
            LOOP
               l_transvalue :=
                  genmsg_translate_value (l_mt,
                                          i.tag,
                                          l_opt,
                                          l_value,
                                          l_listChrTab (t));
               bars_audit.trace ('tag=%s opt=%s trans=%s value=%s',
                                 i.tag,
                                 l_opt,
                                 l_listChrTab (t),
                                 l_transvalue);

               bars_swift.validate_field (i.tag,
                                          l_opt,
                                          l_transvalue,
                                          1,
                                          0);
               bars_audit.trace (
                  'tag=%s opt=%s trans=%s validation complete');
            END LOOP;

            bars_audit.trace ('tag=%s opt=%s successfully validated.',
                              i.tag,

                              i.opt);
         END IF;
      END LOOP;
   END docmsg_document_vldtrans;


   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_TRANSLATE()
   --
   --     ��������� �������������� ���. ���������� ���������
   --
   --     ���������:
   --
   --         p_docref    ���. ���������
   --
   --
   PROCEDURE docmsg_document_translate (p_docref IN t_docref)
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || '.dmdoctransl';
      --
      l_mt         sw_mt.mt%TYPE;   /*                        ��� ��������� */
      l_kv         oper.kv%TYPE;    /*                           ��� ������ */
      l_value      operw.VALUE%TYPE; /*   �������� ���. ��������� (��������) */
      l_trans      BOOLEAN := FALSE;
      l_transrur   sw_chrsets.setid%TYPE;
   --
   BEGIN
      bars_audit.trace ('%s: entry point par[0]=>%s', p, TO_CHAR (p_docref));

      -- ��������� ������� ����� ������������ ��������� �� ���������
      IF (NOT docmsg_checkmsgflag (p_docref))
      THEN
         bars_audit.trace (
            'swift flag not set, document ref=%s not translated.',
            TO_CHAR (p_docref));
         RETURN;
      END IF;

      -- �������� ��� ���������, ������� ����� ����� �����������
      l_mt := genmsg_document_getmt (p_ref => p_docref);
      bars_audit.trace ('document message type is %s', TO_CHAR (l_mt));

      IF (genmsg_document_getvalue (p_docref, '20') = '+')
      THEN
         l_transrur := 'RUR6';
      ELSE
         l_transrur := 'TRANS';
      END IF;

      -- �������������� ������ ��� ���. ������
      SELECT kv
        INTO l_kv
        FROM oper
       WHERE REF = p_docref;

      bars_audit.trace ('document kv is %s', TO_CHAR (l_kv));

      -- ��� ���. ��������� ������ ���� �����������������
      FOR c
         IN (SELECT w.tag dtag,
                    SUBSTR (w.tag, 1, 2) tag,
                    SUBSTR (TRIM (w.tag), 3, 1) opt,
                    w.VALUE
               FROM operw w
              WHERE     REF = p_docref
                    AND w.VALUE IS NOT NULL
                    AND EXISTS
                           (SELECT 1
                              FROM sw_model
                             WHERE     mt = l_mt
                                   AND tag = SUBSTR (w.tag, 1, 2)
                                   AND NVL (
                                          DECODE (
                                             opt,
                                             'a', SUBSTR (TRIM (w.tag), 3, 1),
                                             opt),
                                          '-') =
                                          NVL (SUBSTR (TRIM (w.tag), 3, 1),
                                               '-')
                                   AND mtdtag IS NOT NULL))
      LOOP
         bars_audit.trace ('checking tag %s ...', c.dtag);

         IF (l_kv NOT IN (810, 643))
         THEN
            IF (c.VALUE != bars_swift.strverify2 (c.VALUE, 'TRANS'))
            THEN
             bars_audit.info('SWT: docref-'||p_docref||', tag-'||c.tag||', value-'||c.value);
             bars_audit.info('SWT: docref-'||p_docref||', tag-'||c.tag||', value-'||bars_swift.strverify2 (c.VALUE, 'TRANS'));
               raise_application_error (
                  -20782,
                     '\932 ������� ������������ ������� � ���� '
                  || c.tag
                  || c.opt);
            END IF;
         ELSE
            IF (c.VALUE !=
                   NVL (bars_swift.strverify2 (c.VALUE, l_transrur),
                        '<null>'))
            THEN
               bars_audit.trace ('starting translation for tag %s...',
                                 c.dtag);
               l_value :=
                  genmsg_translate_value (l_mt,
                                          c.tag,
                                          TRIM (c.opt),
                                          c.VALUE,
                                          'RUR6');
               bars_audit.trace ('tag %s after translation=>%s',
                                 c.dtag,
                                 l_value);
               l_trans := TRUE;

               UPDATE operw
                  SET VALUE = l_value
                WHERE REF = p_docref AND tag = c.dtag;

               bars_audit.trace ('document tag %s stored after translation',
                                 c.dtag);
            END IF;
         END IF;

         bars_audit.trace ('tag %s check completed.', c.dtag);
      END LOOP;

      IF (l_trans)
      THEN
         bars_audit.trace ('some tags was translated, store tag 20');

         BEGIN
            INSERT INTO operw (REF, tag, VALUE)
                 VALUES (p_docref, '20', '+');
         EXCEPTION
            WHEN DUP_VAL_ON_INDEX
            THEN
               NULL;
         END;
      ELSE
         bars_audit.trace ('tags wasnt translated, dont store tag 20');
      END IF;
   END docmsg_document_translate;



   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_VLDLISTRST()
   --
   --     ��������� ������� ������ ���������� ��� ��������
   --
   --
   --
   --
   PROCEDURE docmsg_document_vldlistrst
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || '.dmvldrst';
   BEGIN
      bars_audit.trace ('%s: entry point', p);
      g_vldlist.delete;
      bars_audit.trace ('%s: succ end', p);
   END;


   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_VLDLISTADD()
   --
   --     ��������� ���������� ��������� � ������ ���������� ���
   --     ��������
   --
   --
   --
   PROCEDURE docmsg_document_vldlistadd (p_docref IN t_docref)
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || '.dmvldadd';
      --
      l_isfound    BOOLEAN := FALSE;  /* ������� ������� ��������� � ������ */
   --
   BEGIN
      bars_audit.trace ('%s: entry point par[0]=>%s', p, TO_CHAR (p_docref));

      -- ��������� ������� ��������� � ������
      FOR i IN 1 .. g_vldlist.COUNT
      LOOP
         IF (g_vldlist (i) = p_docref)
         THEN
            l_isfound := TRUE;
         END IF;
      END LOOP;

      IF (NOT l_isfound)
      THEN
         g_vldlist.EXTEND;
         g_vldlist (g_vldlist.COUNT) := p_docref;
         bars_audit.trace ('%s: document %s added in list',
                           p,
                           TO_CHAR (p_docref));
      ELSE
         bars_audit.trace ('%s: document %s already in list',
                           p,
                           TO_CHAR (p_docref));
      END IF;

      bars_audit.trace ('%s: succ end', p);
   END docmsg_document_vldlistadd;


   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_VLDLISTPRC()
   --
   --     ��������� ���������� �������� ��� ����������� � ������
   --     ���������� ��� ��������
   --
   --
   --
   PROCEDURE docmsg_document_vldlistprc
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || '.dmvldprc';
      --
      l_cnt        NUMBER;                     /* ������� ������� ��������� */
   --
   BEGIN
      bars_audit.trace ('%s: entry point', p);

      -- �������� �� ������
      FOR i IN 1 .. g_vldlist.COUNT
      LOOP
         bars_audit.trace ('%s: processing document %s...',
                           p,
                           TO_CHAR (g_vldlist (i)));

         -- ��������� ������� ���������
         SELECT COUNT (*)
           INTO l_cnt
           FROM oper
          WHERE REF = g_vldlist (i);

         bars_audit.trace ('%s: document exists status is %s',
                           p,
                           TO_CHAR (l_cnt));

         IF (l_cnt = 0)
         THEN
            bars_audit.trace (
               '%s: document %s does not exists - nothing to check',
               p,
               TO_CHAR (g_vldlist (i)));
         ELSE
            docmsg_document_validate (g_vldlist (i));
            bars_audit.trace ('%s: document %s tags validated.',
                              p,
                              TO_CHAR (g_vldlist (i)));

            -- � ����������� �� ���������, ���� ��������� ��������, ���� ���������������
            IF (get_param_value (MODPAR_MSGTRANSLATE) =
                   MODVAL_MSGTRANSLATE_YES)
            THEN
               docmsg_document_translate (g_vldlist (i));
               bars_audit.trace ('%s: document %s tags translated',
                                 p,
                                 TO_CHAR (g_vldlist (i)));
            ELSE
               docmsg_document_vldtrans (g_vldlist (i));
               bars_audit.trace (
                  '%s: document %s tags translation validated',
                  p,
                  TO_CHAR (g_vldlist (i)));
            END IF;

            bars_audit.trace ('%s: document %s processed.',
                              p,
                              TO_CHAR (g_vldlist (i)));
         END IF;
      END LOOP;

      bars_audit.trace ('%s: succ end', p);
   END docmsg_document_vldlistprc;



   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_GET103COVHDR()
   --
   --     ��������� ������������/����������� ��103 � ��202
   --
   --     ���������:
   --
   --         p_docref        �������� ���������
   --
   --         p_senderbic     BIC-��� �����������
   --
   --         p_sendername    ������������ �����������
   --
   --         p_rcv103bic     BIC-��� ���������� ��103
   --
   --         p_rcv103name    ������������ ���������� ��103
   --
   --         p_rcv202bic     BIC-��� ���������� ��202
   --
   --         p_rcv202name    ������������ ���������� ��202
   --
   --
   PROCEDURE docmsg_document_get103covhdr (p_docref       IN     oper.REF%TYPE,
                                           p_senderbic       OUT VARCHAR2,
                                           p_sendername      OUT VARCHAR2,
                                           p_rcv103bic       OUT VARCHAR2,
                                           p_rcv103name      OUT VARCHAR2,
                                           p_rcv202bic       OUT VARCHAR2,
                                           p_rcv202name      OUT VARCHAR2)
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || '.dmdocg103hdr';
      --
      l_fld57a     operw.VALUE%TYPE;
      l_pos        NUMBER;

      --
      -- TODO: ��������� ������� � ����� BARS_SWIFT
      --
      FUNCTION get_bank_name (p_bic IN VARCHAR2)
         RETURN VARCHAR2
      IS
         l_name   VARCHAR2 (254);
      BEGIN
         SELECT SUBSTR (name, 1, 254)
           INTO l_name
           FROM sw_banks
          WHERE bic = p_bic;

         RETURN l_name;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN NULL;
      END get_bank_name;
   --
   BEGIN
      bars_audit.trace ('%s: entry point par[0]=>%s', p, TO_CHAR (p_docref));

      -- ����������� ������ ��
      p_senderbic := bars_swift.get_ourbank_bic;
      p_sendername := get_bank_name (p_senderbic);

      -- ���������� ��103 ��������� � ���� 57�
      l_fld57a := genmsg_document_getvalue (p_docref, '57A');

      -- ������� ����, ���� �� ���� � ����
      IF (SUBSTR (l_fld57a, 1, 1) = '/')
      THEN
         l_pos := INSTR (l_fld57a, CRLF);
         l_fld57a := SUBSTR (l_fld57a, l_pos + 2);
      END IF;

      p_rcv103bic := l_fld57a;
      p_rcv103name := get_bank_name (p_rcv103bic);

      -- ���������� ��202 ����, ������� �������� ���������
      SELECT VALUE
        INTO p_rcv202bic
        FROM operw
       WHERE REF = p_docref AND tag = 'NOS_B';

      p_rcv202name := get_bank_name (p_rcv202bic);
      bars_audit.trace ('%s: succ end, rcv103=% rcv202=%',
                        p,
                        p_rcv103bic,
                        p_rcv202bic);
   END docmsg_document_get103covhdr;



   -----------------------------------------------------------------
   -- DOCMSG_DOCUMENT_SET103COVHDR()
   --
   --     ��������� ����������� ��� ��������� ��103 � ��202
   --
   --     ���������:
   --
   --         p_docref        �������� ���������
   --
   --         p_rcv103bic     BIC-��� ���������� ��103
   --
   --         p_rcv202bic     BIC-��� ���������� ��202
   --
   --
   PROCEDURE docmsg_document_set103covhdr (p_docref      IN oper.REF%TYPE,
                                           p_rcv103bic   IN VARCHAR2,
                                           p_rcv202bic   IN VARCHAR2)
   IS
      p   CONSTANT VARCHAR2 (100) := PKG_CODE || '.dmdocset103hdr';
   --
   BEGIN
      bars_audit.trace ('%s: entry point: par[0]=>%s par[1]=>%s par[2]=>%s',
                        p,
                        TO_CHAR (p_docref),
                        p_rcv103bic,
                        p_rcv202bic);

      BEGIN
         INSERT INTO operw (REF, tag, VALUE)
              VALUES (p_docref, 'SWRCV', p_rcv103bic);
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX
         THEN
            UPDATE operw
               SET VALUE = p_rcv103bic
             WHERE REF = p_docref AND tag = 'SWRCV';
      END;

      bars_audit.trace ('%s: succ end', p);
   END docmsg_document_set103covhdr;

   -----------------------------------------------------------------
   -- GENMSG_MT199()
   --
   --     ��������� MT199 - ������ ����� ��������� � GPI
   --
   --     ���������:
   --
   --         p_swref        �������� ������������ ���������
   --
   --         p_statusid     �� ������� �� ����������� SW_STATUSES
   --

   PROCEDURE genmsg_mt199 (p_swref      IN sw_journal.swref%TYPE,
                           p_statusid   IN NUMBER)
   IS
      CURSOR cursModel (p_mt IN NUMBER)
      IS
         SELECT *
           FROM sw_model
          WHERE mt = p_mt;

      l_sw_journal   sw_journal%ROWTYPE;
      l_swref_new    sw_journal.swref%TYPE;
      l_ret          NUMBER;
      l_mt           sw_mt.mt%TYPE := 199;       /*           ��� ��������� */
      l_recModel     sw_model%ROWTYPE; /*               ������ ������ �������� */
      l_cnt          NUMBER;        /*                       ������ ������� */
      l_useTrans     BOOLEAN;       /*     ���� ������������� ������������� */
      l_transTable   sw_chrsets.setid%TYPE; /*            ��� ������� ������������� */
      l_20fld        sw_operw.VALUE%TYPE;
      l_71fld        sw_operw.VALUE%TYPE;
      l_71fld199     sw_operw.VALUE%TYPE;
      l_value        sw_operw.VALUE%TYPE; /*                        �������� ���� */
      l_recno        sw_operw.n%TYPE; /*              ���������� ����� ������ */
      l_opt          sw_operw.opt%TYPE; /*                    ����� ���� ������ */
      l_pos          NUMBER;        /*                              ������� */
      l_currCode     tabval.kv%TYPE; /*                 ��� ������ ��������� */
      l_status       sw_statuses.VALUE%TYPE;
      l_32a          sw_operw.VALUE%TYPE;
      l_33b          sw_operw.VALUE%TYPE;
      l_52fld        sw_operw.VALUE%TYPE;
   BEGIN
      --
      -- ��������� ���� �� ������������
      --
      SELECT COUNT (*)
        INTO l_cnt
        FROM sw_model
       WHERE mt = l_mt;

      IF (l_cnt = 0)
      THEN
         bars_audit.error ('Error! message description MT199 not found...');
         RETURN;
      END IF;

      bars_audit.info ('message MT199 description found...');

      BEGIN
         SELECT s.*
           INTO l_sw_journal
           FROM sw_journal s
          WHERE s.swref = p_swref AND s.sti = '001';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.info ('MT199: Skip swref=> ' || TO_CHAR (p_swref));
            RETURN;
      END;

      BEGIN
         SELECT t.VALUE
           INTO l_20fld
           FROM sw_operw t
          WHERE t.swref = p_swref AND t.tag = '20';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.error (
               'MT199: ��� ���� 20 ��� SwRef=>' || TO_CHAR (p_swref));
            RETURN;
      END;

      BEGIN
         SELECT t.VALUE
           INTO l_71fld
           FROM sw_operw t
          WHERE t.swref = p_swref AND t.tag = '71' and t.opt='A' AND ROWNUM = 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.info (
                  'MT199:��� ���� 71A ��� SwRef=> '
               || TO_CHAR (p_swref)
               || '.�� ���� ����������� ��� ��������!');

      END;

        --      BEGIN
        --         SELECT t.VALUE
        --           INTO l_52fld
        --           FROM sw_operw t
        --          WHERE t.swref = p_swref AND t.tag = '52' AND ROWNUM = 1;
        --      EXCEPTION
        --         WHEN NO_DATA_FOUND
        --         THEN
        --            bars_audit.info (
        --                  'MT199:��� ���� 52 ��� SwRef=> '
        --               || TO_CHAR (p_swref));
        --            l_52fld:=null;
        --
        --      END;

      BEGIN
         SELECT VALUE
           INTO l_status
           FROM sw_statuses
          WHERE id = p_statusid;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.error (
               'MT199: �� ������ ������' || TO_CHAR (p_statusid));
      END;

      BEGIN
         SELECT kv
           INTO l_currCode
           FROM tabval
          WHERE lcv = l_sw_journal.currency;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.error (
               'MT199:�� ������� ������ ' || l_sw_journal.currency);
      END;

      BEGIN
         SELECT count(*)
           INTO l_71fld199
           FROM sw_operw t
          WHERE t.swref = p_swref AND t.tag = '71' and t.opt='F' ;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.info (
                  'MT199: ��� ���� 71F ��� SwRef=> '
               || TO_CHAR (p_swref));
      END;

      BEGIN
         SELECT t.VALUE
           INTO l_32a
           FROM sw_operw t
          WHERE t.swref = p_swref AND t.tag = '32' and t.opt='A' AND ROWNUM = 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.info (
                  'MT199: ��� ���� 32A ��� SwRef=> '
               || TO_CHAR (p_swref));
      END;

      BEGIN
         SELECT t.VALUE
           INTO l_33b
           FROM sw_operw t
          WHERE t.swref = p_swref AND t.tag = '33' and t.opt='B' AND ROWNUM = 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.info (
                  'MT199: ��� ���� 33B ��� SwRef=> '
               || TO_CHAR (p_swref));
      END;


        --      BEGIN
        --         SELECT w.VALUE
        --           INTO l_71fld199
        --           FROM sw_journal s
        --                INNER JOIN sw_journal s2 ON s.uetr = s.uetr AND s2.mt = 199
        --                INNER JOIN sw_operw w ON s2.swref = w.swref AND tag = '71'
        --          WHERE     s.swref = p_swref
        --                AND s2.vdate BETWEEN s.vdate - 50 AND s.vdate + 50
        --                AND ROWNUM = 1;
        --      EXCEPTION
        --         WHEN NO_DATA_FOUND
        --         THEN
        --            l_71fld199 := NULL;
        --      END;

      --
      -- ���������� ����� ����������� ������������� - �� �����
      -- ���������� ��������� ���������� ������� �������������
      --
      l_transTable := 'TRANS';
      l_useTrans := TRUE;


      BARS_SWIFT.In_SwJournalInt (
         ret_        => l_ret,
         swref_      => l_swref_new,
         mt_         => '199',
         mid_        => NULL,
         page_       => NULL,
         io_         => 'I',
         sender_     => l_sw_journal.receiver,
         receiver_   => BIC_GPI,
         transit_    => l_sw_journal.transit,
         payer_      => NULL,
         payee_      => l_sw_journal.payee,
         ccy_        => l_sw_journal.currency,
         amount_     => l_sw_journal.amount,
         accd_       => l_sw_journal.accd,
         acck_       => NULL,
         vdat_       => NULL,
         idat_       => TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI'),
         flag_       => 'L',
         sti_        => '001',
         uetr_       => l_sw_journal.uetr);

      UPDATE sw_journal
         SET date_pay = SYSDATE, date_out = NULL
       WHERE swref = l_swref_new;

      bars_audit.info (
         'message MT199 header created SwRef=> ' || TO_CHAR (l_swref_new));

      --------------------------------------------------------------
      bars_audit.info ('write message MT199 details ...');

      -- ��������� ������ ���������
      OPEN cursModel (l_mt);

      l_recno := 1;

      LOOP
         FETCH cursModel INTO l_recModel;

         EXIT WHEN cursModel%NOTFOUND;


         --
         -- �������� ��������� ����
         --
         IF (l_recModel.tag = '20')
         THEN
            l_opt := '';

            IF LENGTH (l_20fld) < 16
            THEN
               l_value := l_20fld || 'A';
            ELSE
               l_value := SUBSTR (l_20fld, 2, 15) || 'A';
            END IF;

            genmsg_document_instag (l_recModel,
                                    l_swref_new,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         --
         ELSIF (l_recModel.tag = '21')
         THEN
            l_opt := '';
            l_value := l_20fld;
            genmsg_document_instag (l_recModel,
                                    l_swref_new,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         ELSIF (l_recModel.tag = '79')
         THEN
            l_opt := '';

            l_value :=
                  '//'
               || TO_CHAR (SYSDATE, 'YYMMDDHH24MI')
               || REPLACE (SESSIONTIMEZONE, ':', '')
               || CRLF
               || '//'
               || l_status
               || CRLF
               || '//'-- || case when l_52fld is not null then  l_sw_journal.sender|| '/' else '' end
               || l_sw_journal.receiver
               || CRLF
               || '//'
               || bars_swift.AmountToSwift (l_sw_journal.amount,
                                            l_currCode,
                                            TRUE,
                                            TRUE);


            --���� ������ ��199 �� 71 ����, � � 71 ��� ��103 SHA ��� BEN -
            --�� ��� ������� ACSC � 79 ���� �������� ����� ��� ������� �� ��� � ��199 + ���� � ����� 0,
            IF (    l_71fld199 >0
                AND l_71fld IN ('SHA', 'BEN')
                AND p_statusid = 1                                    /*ACSC*/
                                  )
            THEN
            begin
             for c in( SELECT value
                         FROM sw_operw t
                     WHERE t.swref = p_swref AND t.tag = '71' and t.opt='F' )
             loop
               l_value :=
                     l_value|| CRLF || '//:71F:' || REPLACE (c.value, CRLF, CRLF || '//:71F:');
               end loop;      
                   l_value :=
                     l_value|| CRLF || '//:71F:'     || bars_swift.AmountToSwift (0,
                                               l_currCode,
                                               TRUE,
                                               TRUE);
             end;                                  
            ELSIF(    l_71fld199 =0
                AND l_71fld IN ('SHA', 'BEN')
                AND p_statusid = 1                                    /*ACSC*/
                                  )
               THEN
                   l_value :=
                     l_value
                  || CRLF
                  || '//:71F:'
                  || bars_swift.AmountToSwift (0,
                                               l_currCode,
                                               TRUE,
                                               TRUE);
            END IF;

--            IF (l_71fld='OUR') THEN
--                IF (p_statusid=1 and l_33b is not null) then
--                  l_value :=l_value
--                  || CRLF
--                  || '//'
--                  || l_33b;
--                END IF;
--
--                IF (p_statusid!=1 and l_32a is not null) then
--                  l_value :=l_value
--                  || CRLF
--                  || '//'
--                  || substr(l_32a,7);
--                END IF;
--
--
--            END IF;


            genmsg_document_instag (l_recModel,
                                    l_swref_new,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         END IF;
      END LOOP;

      CLOSE cursModel;


    if (p_statusid=2) then
      UPDATE sw_oper_queue
         SET send_mt199 = 1, swref_199 = l_swref_new, status = p_statusid
       WHERE swref = p_swref AND status =0;

       delete from sw_oper_queue WHERE swref = p_swref AND status < 0;

     else
        UPDATE sw_oper_queue
         SET send_mt199 = 1, swref_199 = l_swref_new, status = p_statusid
       WHERE swref = p_swref AND status IN (0, -1);
     end if;

      bars_audit.info (
         'message MT199 generated swref=' || TO_CHAR (l_swref_new));
      bars_audit.info (
            '������������ ��������� SwRef='
         || TO_CHAR (l_swref_new));
   --------------------------------------------------------------

   END genmsg_mt199;

   
     -----------------------------------------------------------------
   -- GENMSG_MT299()
   --
   --     ��������� MT299 - ������ ����� ��������� � GPI
   --
   --     ���������:
   --
   --         p_swref        �������� ������������ ���������
   --

   PROCEDURE genmsg_mt299 (p_swref      IN sw_journal.swref%TYPE)
   IS
      CURSOR cursModel (p_mt IN NUMBER)
      IS
         SELECT *
           FROM sw_model
          WHERE mt = p_mt;

      l_sw_journal   sw_journal%ROWTYPE;
      l_swref_new    sw_journal.swref%TYPE;
      l_ret          NUMBER;
      l_mt           sw_mt.mt%TYPE := 299;       /*           ��� ��������� */
      l_recModel     sw_model%ROWTYPE; /*               ������ ������ �������� */
      l_cnt          NUMBER;        /*                       ������ ������� */
      l_useTrans     BOOLEAN;       /*     ���� ������������� ������������� */
      l_transTable   sw_chrsets.setid%TYPE; /*            ��� ������� ������������� */
      l_20fld        sw_operw.VALUE%TYPE;
      l_71fld        sw_operw.VALUE%TYPE;
      l_71fld199     sw_operw.VALUE%TYPE;
      l_value        sw_operw.VALUE%TYPE; /*                        �������� ���� */
      l_recno        sw_operw.n%TYPE; /*              ���������� ����� ������ */
      l_opt          sw_operw.opt%TYPE; /*                    ����� ���� ������ */
      l_pos          NUMBER;        /*                              ������� */
      l_currCode     tabval.kv%TYPE; /*                 ��� ������ ��������� */
      l_status       sw_statuses.VALUE%TYPE;
      l_32a          sw_operw.VALUE%TYPE;
      l_33b          sw_operw.VALUE%TYPE;
      l_52fld        sw_operw.VALUE%TYPE;
   BEGIN
      --
      -- ��������� ���� �� ������������
      --
      SELECT COUNT (*)
        INTO l_cnt
        FROM sw_model
       WHERE mt = l_mt;

      IF (l_cnt = 0)
      THEN
         bars_audit.error ('Error! message description MT299 not found...');
         RETURN;
      END IF;

      bars_audit.info ('message MT299 description found...');

      BEGIN
         SELECT s.*
           INTO l_sw_journal
           FROM sw_journal s
          WHERE s.swref = p_swref and cov='COV';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.info ('MT299: Skip swref=> ' || TO_CHAR (p_swref));
            RETURN;
      END;

      BEGIN
         SELECT t.VALUE
           INTO l_20fld
           FROM sw_operw t
          WHERE t.swref = p_swref AND t.tag = '20';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.error (
               'MT299: ��� ���� 20 ��� SwRef=>' || TO_CHAR (p_swref));
            RETURN;
      END;

      BEGIN
         SELECT t.VALUE
           INTO l_71fld
           FROM sw_operw t
          WHERE t.swref = p_swref AND t.tag = '71' and t.opt='A' AND ROWNUM = 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.info (
                  'MT299:��� ���� 71A ��� SwRef=> '
               || TO_CHAR (p_swref)
               || '.�� ���� ����������� ��� ��������!');

      END;


      BEGIN
         SELECT VALUE
           INTO l_status
           FROM sw_statuses
          WHERE id = 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.error (
               'MT299: �� ������ ������' || TO_CHAR (1));
      END;

      BEGIN
         SELECT kv
           INTO l_currCode
           FROM tabval
          WHERE lcv = l_sw_journal.currency;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.error (
               'MT299:�� ������� ������ ' || l_sw_journal.currency);
      END;

      BEGIN
         SELECT count(*)
           INTO l_71fld199
           FROM sw_operw t
          WHERE t.swref = p_swref AND t.tag = '71' and t.opt='F' ;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.info (
                  'MT299: ��� ���� 71F ��� SwRef=> '
               || TO_CHAR (p_swref));
      END;

      BEGIN
         SELECT t.VALUE
           INTO l_32a
           FROM sw_operw t
          WHERE t.swref = p_swref AND t.tag = '32' and t.opt='A' AND ROWNUM = 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.info (
                  'MT299: ��� ���� 32A ��� SwRef=> '
               || TO_CHAR (p_swref));
      END;

      BEGIN
         SELECT t.VALUE
           INTO l_33b
           FROM sw_operw t
          WHERE t.swref = p_swref AND t.tag = '33' and t.opt='B' AND ROWNUM = 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.info (
                  'MT299: ��� ���� 33B ��� SwRef=> '
               || TO_CHAR (p_swref));
      END;



      --
      -- ���������� ����� ����������� ������������� - �� �����
      -- ���������� ��������� ���������� ������� �������������
      --
      l_transTable := 'TRANS';
      l_useTrans := TRUE;


      BARS_SWIFT.In_SwJournalInt (
         ret_        => l_ret,
         swref_      => l_swref_new,
         mt_         => '299',
         mid_        => NULL,
         page_       => NULL,
         io_         => 'I',
         sender_     => l_sw_journal.receiver,
         receiver_   => BIC_GPI,
         transit_    => l_sw_journal.transit,
         payer_      => NULL,
         payee_      => l_sw_journal.payee,
         ccy_        => l_sw_journal.currency,
         amount_     => l_sw_journal.amount,
         accd_       => l_sw_journal.accd,
         acck_       => NULL,
         vdat_       => NULL,
         idat_       => TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI'),
         flag_       => 'L',
         sti_        => '001',
         uetr_       => l_sw_journal.uetr);

      UPDATE sw_journal
         SET date_pay = SYSDATE, date_out = NULL
       WHERE swref = l_swref_new;

      bars_audit.info (
         'message MT299 header created SwRef=> ' || TO_CHAR (l_swref_new));

      --------------------------------------------------------------
      bars_audit.info ('write message MT299 details ...');

      -- ��������� ������ ���������
      OPEN cursModel (l_mt);

      l_recno := 1;

      LOOP
         FETCH cursModel INTO l_recModel;

         EXIT WHEN cursModel%NOTFOUND;


         --
         -- �������� ��������� ����
         --
         IF (l_recModel.tag = '20')
         THEN
            l_opt := '';

            IF LENGTH (l_20fld) < 16
            THEN
               l_value := l_20fld || 'A';
            ELSE
               l_value := SUBSTR (l_20fld, 2, 15) || 'A';
            END IF;

            genmsg_document_instag (l_recModel,
                                    l_swref_new,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         --
         ELSIF (l_recModel.tag = '21')
         THEN
            l_opt := '';
            l_value := l_20fld;
            genmsg_document_instag (l_recModel,
                                    l_swref_new,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         ELSIF (l_recModel.tag = '79')
         THEN
            l_opt := '';

            l_value :=
                  '//'
               || TO_CHAR (SYSDATE, 'YYMMDDHH24MI')
               || REPLACE (SESSIONTIMEZONE, ':', '')
               || CRLF
               || '//'
               || l_status
               || CRLF
               || '//'-- || case when l_52fld is not null then  l_sw_journal.sender|| '/' else '' end
               || l_sw_journal.receiver
               || CRLF
               || '//'
               || bars_swift.AmountToSwift (l_sw_journal.amount,
                                            l_currCode,
                                            TRUE,
                                            TRUE);


            --���� ������ ��199 �� 71 ����, � � 71 ��� ��103 SHA ��� BEN -
            --�� ��� ������� ACSC � 79 ���� �������� ����� ��� ������� �� ��� � ��199 + ���� � ����� 0,
            IF (    l_71fld199 >0
                AND l_71fld IN ('SHA', 'BEN')
                                                 /*ACSC*/
                                  )
            THEN
            begin
             for c in( SELECT value
                         FROM sw_operw t
                     WHERE t.swref = p_swref AND t.tag = '71' and t.opt='F' )
             loop
               l_value :=
                     l_value|| CRLF || '//:71F:' || REPLACE (c.value, CRLF, CRLF || '//:71F:');
               end loop;      
                   l_value :=
                     l_value|| CRLF || '//:71F:'     || bars_swift.AmountToSwift (0,
                                               l_currCode,
                                               TRUE,
                                               TRUE);
             end;                                  
            ELSIF(    l_71fld199 =0
                AND l_71fld IN ('SHA', 'BEN')
                                                /*ACSC*/
                                  )
               THEN
                   l_value :=
                     l_value
                  || CRLF
                  || '//:71F:'
                  || bars_swift.AmountToSwift (0,
                                               l_currCode,
                                               TRUE,
                                               TRUE);
            END IF;

--            IF (l_71fld='OUR') THEN
--                IF (p_statusid=1 and l_33b is not null) then
--                  l_value :=l_value
--                  || CRLF
--                  || '//'
--                  || l_33b;
--                END IF;
--
--                IF (p_statusid!=1 and l_32a is not null) then
--                  l_value :=l_value
--                  || CRLF
--                  || '//'
--                  || substr(l_32a,7);
--                END IF;
--
--
--            END IF;


            genmsg_document_instag (l_recModel,
                                    l_swref_new,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         END IF;
      END LOOP;

      CLOSE cursModel;


      bars_audit.info (
         'message MT299 generated swref=' || TO_CHAR (l_swref_new));
      bars_audit.info (
            '������������ ��������� SwRef='
         || TO_CHAR (l_swref_new));
   --------------------------------------------------------------

   END genmsg_mt299;
   
   
   PROCEDURE generate_mt192 (p_uetr IN sw_journal.uetr%TYPE, p_status_code varchar2, p_indm number, p_20 varchar2)
   is 
     CURSOR cursModel (p_mt IN NUMBER)
      IS
         SELECT *
           FROM sw_model
          WHERE mt = p_mt;

      l_sw_journal   sw_journal%ROWTYPE;
      l_swref_new    sw_journal.swref%TYPE;
      l_ret          NUMBER;
      l_mt           sw_mt.mt%TYPE := 192;       /*           ��� ��������� */
      l_recModel     sw_model%ROWTYPE; /*               ������ ������ �������� */
      l_cnt          NUMBER;        /*                       ������ ������� */
      l_cnt_dict     NUMBER;
      l_useTrans     BOOLEAN;       /*     ���� ������������� ������������� */
      l_transTable   sw_chrsets.setid%TYPE; /*            ��� ������� ������������� */
      l_value        sw_operw.VALUE%TYPE; /*                        �������� ���� */
      l_recno        sw_operw.n%TYPE; /*              ���������� ����� ������ */
      l_opt          sw_operw.opt%TYPE; /*                    ����� ���� ������ */
      l_pos          NUMBER;        /*                              ������� */
      l_20fld        sw_operw.VALUE%TYPE;

     
  BEGIN
          --
      -- ��������� ���� �� ������������
      --
      SELECT COUNT (*)
        INTO l_cnt
        FROM sw_model
       WHERE mt = l_mt;

      IF (l_cnt = 0)
      THEN
         bars_audit.error ('Error! message description '|| l_mt ||' not found...');
         RETURN;
      END IF;

      bars_audit.info ('message '|| l_mt ||' description found...');

      BEGIN
         SELECT s.*
           INTO l_sw_journal
           FROM sw_journal s
          WHERE s.uetr = p_uetr and s.mt=103;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.info (l_mt ||': Skip uetr=> ' || p_uetr);
            RETURN;
      END;
      
     
        select count(*)
        into l_cnt_dict
         from sw_dictionary_status_mt192
        where id = p_status_code;
     
      
      IF (l_cnt_dict = 0)
      THEN
        raise_application_error(-20000, '������� ������ ��� ��'||l_mt);
      END IF;
      
      BEGIN
         SELECT t.VALUE
           INTO l_20fld
           FROM sw_operw t
          WHERE t.swref = l_sw_journal.swref AND t.tag = '20';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.error (
               'MT192: ��� ���� 20 ��� SwRef=>' || TO_CHAR (l_sw_journal.swref));
            RETURN;
      END;
        --
      -- ���������� ����� ����������� ������������� - �� �����
      -- ���������� ��������� ���������� ������� �������������
      --
      l_transTable := 'TRANS';
      l_useTrans := TRUE;


      BARS_SWIFT.In_SwJournalInt (
         ret_        => l_ret,
         swref_      => l_swref_new,
         mt_         => l_mt,
         mid_        => NULL,
         page_       => NULL,
         io_         => 'I',
         sender_     => 'COSBUAUKXXX',
         receiver_   => BIC_GPI,
         transit_    => l_sw_journal.transit,
         payer_      => NULL,
         payee_      => l_sw_journal.payee,
         ccy_        => l_sw_journal.currency,
         amount_     => l_sw_journal.amount,
         accd_       => l_sw_journal.accd,
         acck_       => NULL,
         vdat_       => NULL,
         idat_       => TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI'),
         flag_       => 'L',
         sti_        => '002',
         uetr_       => l_sw_journal.uetr);

      UPDATE sw_journal
         SET date_pay = SYSDATE, date_out = NULL
       WHERE swref = l_swref_new;

      bars_audit.info (
         'message '|| l_mt ||' header created SwRef=> ' || TO_CHAR (l_swref_new));

      --------------------------------------------------------------
      bars_audit.info ('write message '|| l_mt ||' details ...');

      -- ��������� ������ ���������
      OPEN cursModel (l_mt);

      l_recno := 1;

      LOOP
         FETCH cursModel INTO l_recModel;

         EXIT WHEN cursModel%NOTFOUND;


         --
         -- �������� ��������� ����
         --
         IF (l_recModel.tag = '20')
         THEN
            l_opt := '';

          l_value:=p_20;

            genmsg_document_instag (l_recModel,
                                    l_swref_new,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         --
         ELSIF (l_recModel.tag = '21')
         THEN
            l_opt := '';
            l_value := l_20fld;
            genmsg_document_instag (l_recModel,
                                    l_swref_new,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         ELSIF (l_recModel.tag = '11')
         THEN
            l_opt := 'S';
            l_value := l_sw_journal.mt||CRLF||to_char(l_sw_journal.vdate,'YYMMDD');
            genmsg_document_instag (l_recModel,
                                    l_swref_new,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         ELSIF (l_recModel.tag = '79')
         THEN
            l_opt := '';
            l_value := '/'||p_status_code||'/'||case when p_indm =1 then 'INDM' else '' end;
            genmsg_document_instag (l_recModel,
                                    l_swref_new,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);                                                        
         
         END IF;
      END LOOP;

      CLOSE cursModel;


      bars_audit.info (
         'message MT192 generated swref=' || TO_CHAR (l_swref_new));
      bars_audit.info (
            '������������ ��������� SwRef='
         || TO_CHAR (l_swref_new));
      
      
  end generate_mt192;
   
   
   PROCEDURE generate_mt196 (p_uetr IN sw_journal.uetr%TYPE, p_status_code varchar2, p_20 varchar2)
    is 
     CURSOR cursModel (p_mt IN NUMBER)
      IS
         SELECT *
           FROM sw_model
          WHERE mt = p_mt;

      l_sw_journal   sw_journal%ROWTYPE;
      l_swref_new    sw_journal.swref%TYPE;
      l_ret          NUMBER;
      l_mt           sw_mt.mt%TYPE := 196;       /*           ��� ��������� */
      l_recModel     sw_model%ROWTYPE; /*               ������ ������ �������� */
      l_cnt          NUMBER;        /*                       ������ ������� */
      l_cnt_dict     NUMBER;
      l_useTrans     BOOLEAN;       /*     ���� ������������� ������������� */
      l_transTable   sw_chrsets.setid%TYPE; /*            ��� ������� ������������� */
      l_value        sw_operw.VALUE%TYPE; /*                        �������� ���� */
      l_recno        sw_operw.n%TYPE; /*              ���������� ����� ������ */
      l_opt          sw_operw.opt%TYPE; /*                    ����� ���� ������ */
      l_pos          NUMBER;        /*                              ������� */
      l_20fld        sw_operw.VALUE%TYPE;

     
  BEGIN
          --
      -- ��������� ���� �� ������������
      --
      SELECT COUNT (*)
        INTO l_cnt
        FROM sw_model
       WHERE mt = l_mt;

      IF (l_cnt = 0)
      THEN
         bars_audit.error ('Error! message description '|| l_mt ||' not found...');
         RETURN;
      END IF;

      bars_audit.info ('message '|| l_mt ||' description found...');

      BEGIN
         SELECT s.*
           INTO l_sw_journal
           FROM sw_journal s
          WHERE s.uetr = p_uetr and s.mt=192 and rownum=1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.info (l_mt ||': Skip uetr=> ' || p_uetr);
            RETURN;
      END;
      
     
        select count(*)
        into l_cnt_dict
         from sw_dictionary_status_mt196
        where id = p_status_code;
     
      
      IF (l_cnt_dict = 0)
      THEN
        raise_application_error(-20000, '������� ������ ��� ��'||l_mt);
      END IF;
      
      BEGIN
         SELECT t.VALUE
           INTO l_20fld
           FROM sw_operw t
          WHERE t.swref = l_sw_journal.swref AND t.tag = '20';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_audit.error (
               'MT196: ��� ���� 20 ��� SwRef=>' || TO_CHAR (l_sw_journal.swref));
            RETURN;
      END;
        --
      -- ���������� ����� ����������� ������������� - �� �����
      -- ���������� ��������� ���������� ������� �������������
      --
      l_transTable := 'TRANS';
      l_useTrans := TRUE;


      BARS_SWIFT.In_SwJournalInt (
         ret_        => l_ret,
         swref_      => l_swref_new,
         mt_         => l_mt,
         mid_        => NULL,
         page_       => NULL,
         io_         => 'I',
         sender_     => l_sw_journal.sender,
         receiver_   => l_sw_journal.receiver,
         transit_    => l_sw_journal.transit,
         payer_      => NULL,
         payee_      => l_sw_journal.payee,
         ccy_        => l_sw_journal.currency,
         amount_     => l_sw_journal.amount,
         accd_       => l_sw_journal.accd,
         acck_       => NULL,
         vdat_       => NULL,
         idat_       => TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI'),
         flag_       => 'L',
         sti_        => '002',
         uetr_       => l_sw_journal.uetr);

      UPDATE sw_journal
         SET date_pay = SYSDATE, date_out = NULL
       WHERE swref = l_swref_new;

      bars_audit.info (
         'message '|| l_mt ||' header created SwRef=> ' || TO_CHAR (l_swref_new));

      --------------------------------------------------------------
      bars_audit.info ('write message '|| l_mt ||' details ...');

      -- ��������� ������ ���������
      OPEN cursModel (l_mt);

      l_recno := 1;

      LOOP
         FETCH cursModel INTO l_recModel;

         EXIT WHEN cursModel%NOTFOUND;


         --
         -- �������� ��������� ����
         --
         IF (l_recModel.tag = '20')
         THEN
            l_opt := '';

            l_value:=p_20;

            genmsg_document_instag (l_recModel,
                                    l_swref_new,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         --
         ELSIF (l_recModel.tag = '21')
         THEN
            l_opt := '';
            l_value := l_20fld;
            genmsg_document_instag (l_recModel,
                                    l_swref_new,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);
         
         ELSIF (l_recModel.tag = '76')
         THEN
            l_opt := '';
            l_value := '/'||p_status_code||'/'||CRLF||bars_swift.get_ourbank_bic;
            genmsg_document_instag (l_recModel,
                                    l_swref_new,
                                    NULL,
                                    l_recno,
                                    l_opt,
                                    l_value,
                                    TRUE,
                                    l_useTrans,
                                    l_transTable);                                                        
         
         END IF;
      END LOOP;

      CLOSE cursModel;


      bars_audit.info (
         'message MT192 generated swref=' || TO_CHAR (l_swref_new));
      bars_audit.info (
            '������������ ��������� SwRef='
         || TO_CHAR (l_swref_new));
      
      
   end generate_mt196; 


   -----------------------------------------------------
   -- ��������� �������� ������� REJECT ��� WEB-�����
   -----------------------------------------------------
   PROCEDURE generate_reject (p_uetr IN sw_journal.uetr%TYPE)
   IS
      l_swref   sw_journal.swref%TYPE;
   BEGIN
      BEGIN
         SELECT j.swref
           INTO l_swref
           FROM sw_journal j--, sw_oper o
          WHERE     j.uetr = p_uetr
--              AND o.swref = j.swref
                AND j.mt = 103
                AND ROWNUM = 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            raise_application_error (
               -20000,
               '����������� � �������� UETR �� �������� ��� ����������� �� �� ���������!');
      END;

      BEGIN
         INSERT INTO sw_oper_queue (REF, swref, status)
            SELECT REF, swref, 0
              FROM sw_oper
             WHERE swref = l_swref;

         IF SQL%ROWCOUNT = 0
         THEN
            INSERT INTO sw_oper_queue (REF, swref, status)
                 VALUES (-1, l_swref, 0);
         END IF;
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX
         THEN
            NULL;
      END;

      genmsg_mt199 (l_swref, 2);
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX
      THEN
         raise_application_error (
            -20000,
            '������ ��� ���� �������� �����!');
   END generate_reject;


   -----------------------------------------------------
   -- ��������� �������� ������� ACSC(��������) ��� WEB-�����
   -----------------------------------------------------

   PROCEDURE generate_acsc (p_uetr IN sw_journal.uetr%TYPE)
   IS
      l_swref   sw_journal.swref%TYPE;
   BEGIN
      BEGIN
         SELECT j.swref
           INTO l_swref
           FROM sw_journal j, sw_oper o
          WHERE     j.uetr = p_uetr
                AND o.swref = j.swref
                AND j.mt = 103
                AND ROWNUM = 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            raise_application_error (
               -20000,
               '����������� � �������� UETR �� �������� ��� ����������� �� �� ���������!');
      END;

      BEGIN
         INSERT INTO sw_oper_queue (REF, swref, status)
            SELECT REF, swref, 0
              FROM sw_oper
             WHERE swref = l_swref;

         IF SQL%ROWCOUNT = 0
         THEN
            INSERT INTO sw_oper_queue (REF, swref, status)
                 VALUES (-1, l_swref, 0);
         END IF;
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX
         THEN
            NULL;
      END;

      genmsg_mt199 (l_swref, 1);
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX
      THEN
         raise_application_error (
            -20000,
            '������ ��� ���� �������� �����!');
   END generate_acsc;


   PROCEDURE generate_manual_status (p_uetr IN sw_journal.uetr%TYPE, p_status_id sw_statuses.id%type)
   IS
      l_swref   sw_journal.swref%TYPE;
      l_count int;
   BEGIN
      select count(*) into l_count from sw_statuses where id = p_status_id and id>0;

      if(l_count=0) then
        raise_application_error(-20000, '�� ���������� ������!');
      end if;


      BEGIN
         SELECT j.swref
           INTO l_swref
           FROM sw_journal j, sw_oper o
          WHERE     j.uetr = p_uetr
                AND o.swref = j.swref
                AND j.mt = 103
                AND ROWNUM = 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            raise_application_error (
               -20000,
               '����������� � �������� UETR �� �������� ��� ����������� �� �� ���������!');
      END;

      BEGIN
         INSERT INTO sw_oper_queue (REF, swref, status)
            SELECT REF, swref, 0
              FROM sw_oper
             WHERE swref = l_swref;

         IF SQL%ROWCOUNT = 0
         THEN
            INSERT INTO sw_oper_queue (REF, swref, status)
                 VALUES (-1, l_swref, 0);
         END IF;
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX
         THEN
            NULL;
      END;

      genmsg_mt199 (l_swref, p_status_id);
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX
      THEN
         raise_application_error (
            -20000,
            '������ ��� ���� �������� �����!');
   END generate_manual_status;

   -----------------------------------------------------
   -- ��������� �������� �������� ���
   -- ��� ������ ����������
   -----------------------------------------------------

   PROCEDURE job_send_mt199
   IS
   BEGIN
      FOR c
         IN (SELECT DISTINCT
                    s.swref,
                    o.REF,
                    o.sos,
                    CASE c.tip
                       WHEN '902' THEN 1
                       WHEN 'NLI' THEN 1
                       WHEN 'NLJ' THEN 1
                       --  when 'NLL' then 1
                    ELSE 0
                    END
                       AS t902
               FROM sw_oper_queue s,
                    oper o,
                    opldok d,
                    accounts c,
                    sw_journal j
              WHERE     s.REF = o.REF
                    AND s.swref=j.swref
                    AND j.mt=103
                    AND o.pdat >= SYSDATE - 3
                    AND o.sos IN (5, -1, -2)
                    AND NVL (s.send_mt199, 0) != 1
                    AND o.mfob = '300465'
                    AND o.REF = d.REF
                    AND d.dk = 1
                    AND d.acc = c.acc
                    AND c.tip NOT IN ('NLL', 'NL9')
                    AND s.swref not in (select swref from sw_oper_queue where status !=0) )
      LOOP
         BEGIN
            bc.go (300465);

            IF (c.t902 = 0 AND c.sos = 5)
            THEN
               bars_swift_msg.genmsg_mt199 (c.swref, 1);
            ELSIF (c.t902 = 1 AND c.sos = 5)
            THEN
               bars_swift_msg.genmsg_mt199 (c.swref, 6);

               INSERT INTO sw_oper_queue (REF, swref, status)
                  SELECT REF, swref, 0
                    FROM sw_oper
                   WHERE swref = c.swref;
            ELSE
               bars_swift_msg.genmsg_mt199 (c.swref, 2);
            END IF;

            bc.home ();
         EXCEPTION
            WHEN OTHERS
            THEN
               bars_audit.error (
                     'job_send_mt199:'
                  || DBMS_UTILITY.format_error_stack ()
                  || CHR (10)
                  || DBMS_UTILITY.format_error_backtrace ());
               bc.home ();
         END;
      END LOOP;
   END job_send_mt199;

   -----------------------------------------------------
   -- ��������� �������� ������� ��� "ACSP/002"
   -- �������, ���� ������ �������� �� ��������
   -----------------------------------------------------

   PROCEDURE job_send_mt199_tr
   IS
   BEGIN
      FOR c
         IN (SELECT DISTINCT s.swref
               FROM sw_oper_queue s,
                    oper o,
                    opldok d,
                    accounts c,
                    nlk_ref n,
                    sw_journal j
              WHERE     s.REF = o.REF
                    AND s.swref=j.swref
                    AND j.mt=103 
                    AND o.pdat >= SYSDATE - 3
                    AND o.sos = 5
                    AND NVL (s.send_mt199, 0) != 1
                    AND o.mfob = '300465'
                    AND o.REF = d.REF
                    AND d.dk = 1
                    AND d.acc = c.acc
                    AND c.tip IN ('NLL', 'NL9')
                    AND n.ref1 = d.REF
                    AND n.ref2 IS NULL)
      LOOP
         BEGIN
            bc.go (300465);
            bars_swift_msg.genmsg_mt199 (c.swref, 5);

            INSERT INTO sw_oper_queue (REF, swref, status)
               SELECT REF, swref, 0
                 FROM sw_oper
                WHERE swref = c.swref;

            bc.home ();
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
            WHEN OTHERS
            THEN
               bc.home ();

               IF SQLCODE = -1
               THEN
                  logger.error (
                        'SWT GPI ��� swref='
                     || c.swref
                     || ' ��� ���� �������� ������ "ACSP/002"');
               ELSIF SQLCODE = -1403
               THEN
                  NULL;
               ELSE
                  bars_audit.error (
                        'job_send_mt199_tr:'
                     || DBMS_UTILITY.format_error_stack ()
                     || CHR (10)
                     || DBMS_UTILITY.format_error_backtrace ());
               END IF;
         END;
      END LOOP;
   END job_send_mt199_tr;

   -----------------------------------------------------
   -- ��������� �������� �������� ���
   -- ��� ���������� � �������� �� ���� ������� ���� �� 3720
   -----------------------------------------------------

   PROCEDURE job_send_mt199_tr2client
   IS
   BEGIN
      FOR c
         IN (SELECT DISTINCT
                    s.swref,
                    CASE c2.tip
                       WHEN '902' THEN 1
                       WHEN 'NLI' THEN 1
                       WHEN 'NLJ' THEN 1
                       ELSE 0
                    END
                       AS t902
               FROM sw_oper_queue s,
                    oper o,
                    opldok d,
                    accounts c,
                    nlk_ref n,
                    oper o2,
                    opldok d2,
                    accounts c2,
                    sw_journal j
              WHERE     s.REF = o.REF
                    AND s.swref=j.swref
                    AND j.mt=103 
                    AND o.pdat >= SYSDATE - 3
                    AND o.sos = 5
                    AND NVL (s.send_mt199, 0) != 1
                    AND NVL (s.status, 0) != -1
                    AND o.mfob = '300465'
                    AND o.REF = d.REF
                    AND d.dk = 1
                    AND d.acc = c.acc
                    AND c.tip IN ('NLL', 'NL9')
                    AND n.ref1 = d.REF
                    AND n.ref2 = o2.REF
                    AND o2.sos = 5
                    AND o2.REF = d2.REF
                    AND d2.dk = 1
                    AND d2.acc = c2.acc
                    AND c2.tip NOT IN ('NLL', 'NL9'))
      LOOP
         BEGIN
            bc.go (300465);

            IF (c.t902 = 0)
            THEN
               --���������� ����� �� ��� �� ������� �������, �������� ������ � ��� ����� �� ������
               bars_swift_msg.genmsg_mt199 (c.swref, 1);
            ELSE
               -- ������� �� ��������� ������� ������ � ������ � ����� � �������� CREATED ��� �������� ��������
               bars_swift_msg.genmsg_mt199 (c.swref, 6);

               INSERT INTO sw_oper_queue (REF, swref, status)
                  SELECT REF, swref, -1
                    FROM sw_oper
                   WHERE swref = c.swref;
            END IF;

            bc.home ();
         EXCEPTION
            WHEN OTHERS
            THEN
               bc.home ();

               IF SQLCODE = -1
               THEN
                  logger.error (
                        'SWT GPI ��� swref='
                     || c.swref
                     || ' ��� ���� �������� ������ "ACSC"');
               ELSE
                  bars_audit.error (
                        'job_send_mt199_tr2client:'
                     || DBMS_UTILITY.format_error_stack ()
                     || CHR (10)
                     || DBMS_UTILITY.format_error_backtrace ());
               END IF;
         END;
      END LOOP;
   END job_send_mt199_tr2client;

   -----------------------------------------------------
   -- ��������� �������� �������� ���
   -- ��� ���������� � �������� �� 3720 �
   -- � 3720 ����� ������� �� ���� �������
   -----------------------------------------------------

   PROCEDURE job_send_mt199_tr2tr2client
   IS
   BEGIN
      FOR c
         IN (SELECT DISTINCT s.swref
               FROM sw_oper_queue s,
                    oper o,
                    opldok d,
                    accounts c,
                    nlk_ref n,
                    oper o2,
                    opldok d2,
                    accounts c2,
                    nlk_ref n2,
                    oper o3,
                    nlk_ref n3,
                    oper o4,
                    sw_journal j
              WHERE     s.REF = o.REF
                    AND s.swref=j.swref
                    AND j.mt=103 
                    AND o.pdat >= SYSDATE - 3
                    AND o.sos = 5
                    AND NVL (s.send_mt199, 0) != 1
                    AND o.mfob = '300465'
                    AND o.REF = d.REF
                    AND d.dk = 1
                    AND d.acc = c.acc
                    AND c.tip IN ('NLL', 'NL9')
                    AND n.ref1 = d.REF
                    AND n.ref2 = o2.REF
                    AND o2.sos = 5
                    AND o2.REF = d2.REF
                    AND d2.dk = 1
                    AND d2.acc = c2.acc
                    AND o2.REF = n2.ref1
                    AND n2.ref2 = o3.REF
                    AND o3.sos = 5
                    AND o3.REF = n3.ref1
                    AND n3.ref2 = o4.REF
                    AND o4.sos = 5
                    AND o4.nlsb LIKE '2%')
      LOOP
         BEGIN
            bc.go (300465);

            --���������� ����� �� ��� �� ������� �������, �������� ������ � ��� ����� �� ������
            bars_swift_msg.genmsg_mt199 (c.swref, 1);

            bc.home ();
         EXCEPTION
            WHEN OTHERS
            THEN
               bc.home ();

               IF SQLCODE = -1
               THEN
                  logger.error (
                        'SWT GPI ��� swref='
                     || c.swref
                     || ' ��� ���� �������� ������ "ACSC"');
               ELSE

                  bars_audit.error (
                        'job_send_mt199_tr2tr2client:'
                     || DBMS_UTILITY.format_error_stack ()
                     || CHR (10)
                     || DBMS_UTILITY.format_error_backtrace ());
               END IF;
         END;
      END LOOP;
   END job_send_mt199_tr2tr2client;

      -----------------------------------------------------
   -- ��������� �������� �������� ���
   -- ��� ���������� � �������� �� 3720 �
   -- � 3720 ����� ������� �� ���� ������� ��� ������ 2909
   -----------------------------------------------------

   PROCEDURE job_mt199_tr2tr2client2
   IS
   BEGIN
      FOR c
         IN (SELECT DISTINCT s.swref
               FROM sw_oper_queue s,
                    bars.oper o,
                    bars.opldok d,
                    bars.accounts c,
                    bars.nlk_ref n,
                    bars.oper o2,
                    bars.opldok d2,
                    bars.accounts c2,
                    bars.nlk_ref n2,
                    bars.oper o3,
                    bars.sw_journal j
              WHERE     s.REF = o.REF
                    AND s.swref=j.swref
                    AND j.mt=103 
                    AND o.pdat >= SYSDATE - 3
                    AND o.sos = 5
                    AND NVL (s.send_mt199, 0) != 1
                    AND o.mfob = '300465'
                    AND o.REF = d.REF
                    AND d.dk = 1
                    AND d.acc = c.acc
                    AND c.tip IN ('NLL', 'NL9', 'NLJ', 'NLI')
                    AND n.ref1 = d.REF
                    AND n.ref2 = o2.REF
                    AND o2.sos = 5
                    AND o2.REF = d2.REF
                    AND d2.dk = 1
                    AND d2.acc = c2.acc
                    AND o2.REF = n2.ref1
                    AND n2.ref2 = o3.REF
                    AND o3.sos = 5
                    AND o3.nlsb LIKE '2%')
      LOOP
         BEGIN
            bc.go (300465);

            --���������� ����� �� ��� �� ������� �������, �������� ������ � ��� ����� �� ������
            bars_swift_msg.genmsg_mt199 (c.swref, 1);

            bc.home ();
         EXCEPTION
            WHEN OTHERS
            THEN
               bc.home ();

               IF SQLCODE = -1
               THEN
                  logger.error (
                        'SWT GPI ��� swref='
                     || c.swref
                     || ' ��� ���� �������� ������ "ACSC"');
               ELSE
                  bars_audit.error (
                        'job_send_mt199_tr2tr2client:'
                     || DBMS_UTILITY.format_error_stack ()
                     || CHR (10)
                     || DBMS_UTILITY.format_error_backtrace ());
               END IF;
         END;
      END LOOP;
   END job_mt199_tr2tr2client2;

   -----------------------------------------------------
   -- ��������� �������� �������� ��
   -- ��� ������ ����������
   -----------------------------------------------------

   PROCEDURE job_send_mt199_ru
   IS
   BEGIN
      FOR c
         IN (SELECT DISTINCT
                    s.swref,
                    o2.REF,
                    d.sos,
                    CASE c.tip
                       WHEN '902' THEN 1
                       WHEN 'NLI' THEN 1
                       WHEN 'NLJ' THEN 1
                       -- when 'NLL' then 1
                    ELSE 0
                    END
                       AS t902
               FROM sw_oper_queue s,
                    arc_rrp a,
                    oper o,
                    arc_rrp a2,
                    oper o2,
                    opldok d,
                    accounts c,
                    sw_journal j
              WHERE     s.REF = a.REF
                    AND s.swref=j.swref
                    AND j.mt=103 
                    AND NVL (s.send_mt199, 0) != 1
                    AND a.nazns = 11
                    AND o.REF = a.REF
                    AND o.mfob != '300465'
                    AND a2.ref_a = TO_NUMBER (SUBSTR (a.REF, -9))
                    AND TRUNC (a2.dat_a) >= TRUNC (SYSDATE) - 3
                    AND a2.kf = o.mfob
                    AND a2.nazns = 11
                    AND o2.REF = a2.REF
                    AND o2.REF = d.REF
                    AND o2.sos IN (5, -1, -2)
                    AND d.dk = 1
                    AND d.acc = c.acc
                    AND c.tip NOT IN ('NLL', 'NL9')
                    AND s.swref not in (select swref from sw_oper_queue where status !=0))
      LOOP
         BEGIN
            bc.go (300465);

            IF (c.t902 = 0 AND c.sos = 5)
            THEN
               bars_swift_msg.genmsg_mt199 (c.swref, 1);
            ELSIF (c.t902 = 1 AND c.sos = 5)
            THEN
               bars_swift_msg.genmsg_mt199 (c.swref, 6);

               INSERT INTO sw_oper_queue (REF, swref, status)
                  SELECT REF, swref, 0
                    FROM sw_oper
                   WHERE swref = c.swref;
            ELSE
               bars_swift_msg.genmsg_mt199 (c.swref, 2);
            END IF;

            bc.home ();
         EXCEPTION
            WHEN OTHERS
            THEN
               bc.home ();
               bars_audit.error (
                     'job_send_mt199_ru:'
                  || DBMS_UTILITY.format_error_stack ()
                  || CHR (10)
                  || DBMS_UTILITY.format_error_backtrace ());
         END;
      END LOOP;
   END job_send_mt199_ru;

   -----------------------------------------------------
   -- ��������� �������� ������� �� "ACSP/002"
   -- �������, ���� ������ �������� �� ��������
   -----------------------------------------------------
   PROCEDURE job_send_mt199_ru_tr
   IS
   BEGIN
      FOR c
         IN (SELECT DISTINCT s.swref
               FROM sw_oper_queue s,
                    arc_rrp a,
                    oper o,
                    arc_rrp a2,
                    oper o2,
                    opldok d,
                    accounts c,
                    nlk_ref n,
                    sw_journal j
              WHERE     s.REF = a.REF
                    AND s.swref=j.swref
                    AND j.mt=103 
                    AND NVL (s.send_mt199, 0) != 1
                    AND a.nazns = 11
                    AND o.REF = a.REF
                    AND o.mfob != '300465'
                    AND a2.ref_a = TO_NUMBER (SUBSTR (a.REF, -9))
                    AND TRUNC (a2.dat_a) >= TRUNC (SYSDATE) - 3
                    AND a2.kf = o.mfob
                    AND a2.nazns = 11
                    AND o2.REF = a2.REF
                    AND o2.REF = d.REF
                    AND o2.sos = 5
                    AND d.dk = 1
                    AND d.acc = c.acc
                    AND c.tip IN ('NLL', 'NL9')
                    AND n.ref1 = d.REF
                    AND n.ref2 IS NULL)
      LOOP
         BEGIN
            bc.go (300465);
            bars_swift_msg.genmsg_mt199 (c.swref, 5);

            INSERT INTO sw_oper_queue (REF, swref, status)
               SELECT REF, swref, 0
                 FROM sw_oper
                WHERE swref = c.swref;

            bc.home ();
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
            WHEN OTHERS
            THEN
               bc.home ();

               IF SQLCODE = -1
               THEN
                  logger.error (
                        'SWT GPI ��� swref='
                     || c.swref
                     || ' ��� ���� �������� ������ "ACSP/002"');
               ELSE
                  bars_audit.error (
                        'job_send_mt199_ru_tr:'
                     || DBMS_UTILITY.format_error_stack ()
                     || CHR (10)
                     || DBMS_UTILITY.format_error_backtrace ());
               END IF;
         END;
      END LOOP;
   END job_send_mt199_ru_tr;

   -----------------------------------------------------
   -- ��������� �������� �������� ��
   -- ��� ���������� � �������� �� ���� ������� ���� �� 3720
   -----------------------------------------------------
   PROCEDURE job_send_mt199_ru_tr2client
   IS
   BEGIN
      FOR c
         IN (SELECT DISTINCT
                    s.swref,
                    CASE c3.tip
                       WHEN '902' THEN 1
                       WHEN 'NLI' THEN 1
                       WHEN 'NLJ' THEN 1
                       ELSE 0
                    END
                       AS t902
               FROM sw_oper_queue s,
                    arc_rrp a,
                    oper o,
                    arc_rrp a2,
                    oper o2,
                    opldok d,
                    accounts c,
                    nlk_ref n,
                    oper o3,
                    opldok d3,
                    accounts c3,
                    sw_journal j
              WHERE     s.REF = a.REF
                    AND s.swref=j.swref
                    AND j.mt=103 
                    AND NVL (s.send_mt199, 0) != 1
                    AND NVL (s.status, 0) != -1
                    AND a.nazns = 11
                    AND o.REF = a.REF
                    AND o.mfob != '300465'
                    AND a2.ref_a = TO_NUMBER (SUBSTR (a.REF, -9))
                    AND TRUNC (a.dat_a) BETWEEN TRUNC (SYSDATE) - 3
                                            AND TRUNC (SYSDATE) + 1
                    AND TRUNC (a2.dat_a) BETWEEN TRUNC (SYSDATE) - 3
                                             AND TRUNC (SYSDATE) + 1
                    AND a2.kf = o.mfob
                    AND a2.nazns = 11
                    AND o2.REF = a2.REF
                    AND o2.REF = d.REF
                    AND o2.sos = 5
                    AND d.dk = 1
                    AND d.acc = c.acc
                    AND c.tip IN ('NLL', 'NL9')
                    AND n.ref1 = d.REF
                    AND n.ref2 = o3.REF
                    AND o3.sos = 5
                    AND o3.REF = d3.REF
                    AND d3.dk = 1
                    AND d3.acc = c3.acc
                    -- �� ������ ����������� �� �������
                    AND c3.tip NOT IN ('NLL', 'NL9')
                     AND s.swref not in (select swref from sw_oper_queue where status in(1,2)) )
      LOOP
         BEGIN
            bc.go (300465);

            IF (c.t902 = 0)
            THEN
               --���������� ����� �� ��� �� ������� �������, �������� ������ � ��� ����� �� ������
               bars_swift_msg.genmsg_mt199 (c.swref, 1);
            ELSE
               -- ������� �� ��������� ������� ������ � ������ � ����� � �������� CREATED ��� �������� ��������
               bars_swift_msg.genmsg_mt199 (c.swref, 6);

               INSERT INTO sw_oper_queue (REF, swref, status)
                  SELECT REF, swref, -1
                    FROM sw_oper
                   WHERE swref = c.swref;
            END IF;

            bc.home ();
         EXCEPTION
            WHEN OTHERS
            THEN
               bc.home ();

               IF SQLCODE = -1
               THEN
                  logger.error (
                        'SWT GPI ��� swref='
                     || c.swref
                     || ' ��� ���� �������� ������ "ACSC"');
               ELSE
                  bars_audit.error (
                        'job_send_mt199_ru_tr2client:'
                     || DBMS_UTILITY.format_error_stack ()
                     || CHR (10)
                     || DBMS_UTILITY.format_error_backtrace ());
               END IF;
         END;
      END LOOP;
   END job_send_mt199_ru_tr2client;

   -----------------------------------------------------
   -- ��������� �������� �������� ��
   -- ��� ���������� � �������� �� 3720 �
   -- � 3720 ����� ������� �� ���� �������
   -----------------------------------------------------
   PROCEDURE job_send_mt199_ru_tr2tr2client
   IS
   BEGIN
      FOR c
         IN (SELECT DISTINCT s.swref
               FROM sw_oper_queue s,
                    arc_rrp a,
                    oper o,
                    arc_rrp a2,
                    oper o2,
                    opldok d,
                    accounts c,
                    nlk_ref n,
                    oper o3,
                    opldok d3,
                    accounts c3,
                    nlk_ref n2,
                    oper o4,
                    nlk_ref n3,
                    oper o5,
                    sw_journal j
              WHERE     s.REF = a.REF
                    AND s.swref=j.swref
                    AND j.mt=103 
                    AND NVL (s.send_mt199, 0) != 1
                    AND a.nazns = 11
                    AND o.REF = a.REF
                    AND o.mfob != '300465'
                    AND TRUNC (a.dat_a) BETWEEN TRUNC (SYSDATE) - 3
                                            AND TRUNC (SYSDATE) + 1
                    AND TRUNC (a2.dat_a) BETWEEN TRUNC (SYSDATE) - 3
                                             AND TRUNC (SYSDATE) + 1
                    AND a2.ref_a = TO_NUMBER (SUBSTR (a.REF, -9))
                    AND a2.kf = o.mfob
                    AND a2.nazns = 11
                    AND o2.REF = a2.REF
                    AND o2.REF = d.REF
                    AND o2.sos = 5
                    AND d.dk = 1
                    AND d.acc = c.acc
                    AND c.tip IN ('NLL', 'NL9')
                    AND n.ref1 = d.REF
                    AND n.ref2 = o3.REF
                    AND o3.sos = 5
                    AND o3.REF = d3.REF
                    AND d3.dk = 1
                    AND d3.acc = c3.acc
                    AND o3.REF = n2.ref1
                    AND n2.ref2 = o4.REF
                    AND o4.sos = 5
                    AND o4.REF = n3.ref1
                    AND n3.ref2 = o5.REF
                    AND o5.sos = 5
                    AND o5.nlsb LIKE '2%')
      LOOP
         BEGIN
            bc.go (300465);


            --���������� ����� �� ��� �� ������� �������, �������� ������ � ��� ����� �� ������
            bars_swift_msg.genmsg_mt199 (c.swref, 1);


            bc.home ();
         EXCEPTION
            WHEN OTHERS
            THEN
               bc.home ();

               IF SQLCODE = -1
               THEN
                  logger.error (
                        'SWT GPI ��� swref='
                     || c.swref
                     || ' ��� ���� �������� ������ "ACSC"');
               ELSE
                  bars_audit.error (
                        'job_send_mt199_ru_tr2tr2client:'
                     || DBMS_UTILITY.format_error_stack ()
                     || CHR (10)
                     || DBMS_UTILITY.format_error_backtrace ());
               END IF;
         END;
      END LOOP;
   END job_send_mt199_ru_tr2tr2client;



   -----------------------------------------------------
   -- ��������� �������� �������� ��
   -- ��� ���������� � �������� �� 3720 �
   -- � 3720 ����� ������� �� ���� ������� ��� ������ 2909
   -----------------------------------------------------
   PROCEDURE job_mt199_ru_tr2tr2client2
   IS
   BEGIN
      FOR c
         IN (SELECT DISTINCT s.swref
               FROM bars.sw_oper_queue s,
                    bars.arc_rrp a,
                    bars.oper o,
                    bars.arc_rrp a2,
                    bars.oper o2,
                    bars.opldok d,
                    bars.accounts c,
                    bars.nlk_ref n,
                    bars.oper o3,
                    bars.opldok d3,
                    bars.accounts c3,
                    bars.nlk_ref n2,
                    bars.oper o4,
                    bars.sw_journal j
              WHERE     s.REF = a.REF
                    AND s.swref=j.swref
                    AND j.mt=103 
                    AND NVL (s.send_mt199, 0) != 1
                    AND a.nazns = 11
                    AND o.REF = a.REF
                    AND o.mfob != '300465'
                    AND TRUNC (a.dat_a) BETWEEN TRUNC (SYSDATE) - 3
                                            AND TRUNC (SYSDATE) + 1
                    AND TRUNC (a2.dat_a) BETWEEN TRUNC (SYSDATE) - 3
                                             AND TRUNC (SYSDATE) + 1
                    AND a2.ref_a = TO_NUMBER (SUBSTR (a.REF, -9))
                    AND a2.kf = o.mfob
                    AND a2.nazns = 11
                    AND o2.REF = a2.REF
                    AND o2.REF = d.REF
                    AND o2.sos = 5
                    AND d.dk = 1
                    AND d.acc = c.acc
                    AND c.tip IN ('NLL', 'NL9', 'NLJ', 'NLI')
                    AND n.ref1 = d.REF
                    AND n.ref2 = o3.REF
                    AND o3.sos = 5
                    AND o3.REF = d3.REF
                    AND d3.dk = 1
                    AND d3.acc = c3.acc
                    AND o3.REF = n2.ref1
                    AND n2.ref2 = o4.REF
                    AND o4.sos = 5
                    AND o4.nlsb LIKE '2%')
      LOOP
         BEGIN
            bc.go (300465);


            --���������� ����� �� ��� �� ������� �������, �������� ������ � ��� ����� �� ������
            bars_swift_msg.genmsg_mt199 (c.swref, 1);


            bc.home ();
         EXCEPTION
            WHEN OTHERS
            THEN
               bc.home ();

               IF SQLCODE = -1
               THEN
                  logger.error (
                        'SWT GPI ��� swref='
                     || c.swref
                     || ' ��� ���� �������� ������ "ACSC"');
               ELSE
                  bars_audit.error (
                        'job_send_mt199_ru_tr2tr2client:'
                     || DBMS_UTILITY.format_error_stack ()
                     || CHR (10)
                     || DBMS_UTILITY.format_error_backtrace ());
               END IF;
         END;
      END LOOP;
   END job_mt199_ru_tr2tr2client2;


   PROCEDURE job_mt199_ru_tr2tr2client3
   IS
   BEGIN
      FOR c
         IN (select
               s.swref
               from
               bars.sw_oper_queue s,
               bars.nlk_ref n,
               bars.oper o,
               bars.arc_rrp a,
               bars.arc_rrp a2,
               bars.oper o2,
               bars.nlk_ref n2,
               bars.oper o3,
               bars.sw_journal j
               where NVL (s.send_mt199, 0) != 1
               AND s.ref=n.ref1
               AND s.swref=j.swref
               AND j.mt=103 
               AND n.ref2 = o.ref
               AND o.sos=5
               AND o.ref=a.ref
               AND a.nazns=11
               AND TRUNC (a.dat_a) BETWEEN TRUNC (SYSDATE) - 3  AND TRUNC (SYSDATE) + 1
               AND TRUNC (a2.dat_a) BETWEEN TRUNC (SYSDATE) - 3  AND TRUNC (SYSDATE) + 1
               AND a2.ref_a = TO_NUMBER (SUBSTR (a.REF, -9))
               AND a2.nazns = 11
               AND a2.kf = o.mfob
               AND a2.ref=o2.ref
               AND o2.ref=n2.ref1
               AND n2.ref2=o3.ref
               AND o3.sos=5
               AND o3.nlsb like '2%')
      LOOP
         BEGIN
            bc.go (300465);


            --���������� ����� �� ��� �� ������� �������, �������� ������ � ��� ����� �� ������
            bars_swift_msg.genmsg_mt199 (c.swref, 1);


            bc.home ();
         EXCEPTION
            WHEN OTHERS
            THEN
               bc.home ();

               IF SQLCODE = -1
               THEN
                  logger.error (
                        'SWT GPI ��� swref='
                     || c.swref
                     || ' ��� ���� �������� ������ "ACSC"');
               ELSE
                  bars_audit.error (
                        'job_send_mt199_ru_tr2tr2client:'
                     || DBMS_UTILITY.format_error_stack ()
                     || CHR (10)
                     || DBMS_UTILITY.format_error_backtrace ());
               END IF;
         END;
      END LOOP;
   END job_mt199_ru_tr2tr2client3;
   -----------------------------------------------------
   -- ��������� �������� ������� 004 �� ��� � ��
   -- ���� ��� � ����
   -----------------------------------------------------
   PROCEDURE job_send_status_004
   IS
   BEGIN
      FOR c
         IN (SELECT DISTINCT j.swref, w2.VALUE
               FROM sw_journal j
                    INNER JOIN sw_operw w
                       ON w.swref = j.swref AND w.tag IN ('53', '54')
                    INNER JOIN sw_operw w2
                       ON w2.swref = j.swref AND w2.tag IN ('20')
                    INNER JOIN sw_operw w3
                       ON w3.swref = j.swref AND w3.tag = '32'
              WHERE     j.vdate >= TRUNC (SYSDATE)
                    AND j.mt = 103
                    AND w2.VALUE NOT IN (SELECT w.VALUE
                                           FROM sw_journal j
                                                INNER JOIN sw_operw w
                                                   ON     w.swref = j.swref
                                                      AND tag = '21'
                                          WHERE     j.vdate >=
                                                       TRUNC (SYSDATE)
                                                AND j.mt = 202)
                    AND j.swref NOT IN (SELECT sj.swref
                                          FROM sw_journal sj
                                               INNER JOIN sw_operw so
                                                  ON     so.swref = sj.swref
                                                     AND tag = '53'
                                         WHERE     sj.vdate >=
                                                      TRUNC (SYSDATE)
                                               AND sj.sender = 'RZBAATWWXXX'
                                               AND so.VALUE LIKE
                                                      '%00155073621%')
                    AND j.vdate = TRUNC (SYSDATE)
                    AND j.swref not in (select swref from sw_oper_queue where status in(1,2)))
      LOOP
         BEGIN
            bc.go (300465);

            INSERT INTO sw_oper_queue (REF, swref, status)
               SELECT REF, swref, 0
                 FROM sw_oper
                WHERE swref = c.swref;

            IF SQL%ROWCOUNT = 0
            THEN
               INSERT INTO sw_oper_queue (REF, swref, status)
                    VALUES (-1, c.swref, 0);
            END IF;

            genmsg_mt199 (c.swref, 7);

            bc.home ();
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
            WHEN OTHERS
            THEN
               IF SQLCODE = -1
               THEN
                  logger.error (
                        'SWT GPI ��� swref='
                     || c.swref
                     || ' ��� ���� �������� ������ "ACSP/004"');

                  DELETE FROM sw_oper_queue
                        WHERE swref = c.swref AND status = 0;
               ELSE
                  bars_audit.error (
                        'job_send_status_004:'
                     || DBMS_UTILITY.format_error_stack ()
                     || CHR (10)
                     || DBMS_UTILITY.format_error_backtrace ());
               END IF;
         END;
      END LOOP;
   END job_send_status_004;

   PROCEDURE job_send_reject
   is
   begin
        for c in(select w.value from oper o
                inner join operw w on o.ref=w.ref and w.tag ='UETR'
                where o.pdat>=trunc(sysdate)-1
                and o.nlsa='373971503'
                and substr(o.nlsb,1,4)='1500'
                and o.sos=5)
        loop
            begin
               bc.go(300465);
                generate_reject(c.value);
               bc.home();
            exception when others then
                 bars_audit.error (
                        'MT199:job_send_reject:'
                     || DBMS_UTILITY.format_error_stack ()
                     || CHR (10)
                     || DBMS_UTILITY.format_error_backtrace ());
            end;
        end loop;

   end job_send_reject;

   PROCEDURE job_mt199_claims
   IS
   BEGIN
      FOR c
         IN (SELECT DISTINCT s.swref
               FROM bars.sw_oper_queue s,
                    bars.arc_rrp a,
                    bars.oper o
              WHERE     s.REF = a.REF
                    AND a.ref=o.ref
                    AND o.tt ='C14'
                    AND NVL (s.send_mt199, 0) != 1
                    AND a.nazns in(10, 11)
                    AND a.sos in(7,9)
                    AND o.mfob in (select kf from bars.kf_ru
                        where kf not in (select kf from bars.mv_kf))
               union all 
               SELECT DISTINCT s.swref
               FROM bars.sw_oper_queue s,
                    bars.arc_rrp a,
                    bars.oper o
              WHERE     s.REF = a.REF
                    AND a.ref=o.ref
                    AND o.tt  in ('CLI','CLG')
                    AND NVL (s.send_mt199, 0) != 1
                    AND a.nazns in(10, 11)
                    AND a.sos in(7,9)
                    AND o.mfob in (select kf from bars.kf_ru))
                  --where kf not in (select kf from bars.mv_kf)))
                        
      LOOP
         BEGIN
            bc.go (300465);
               bars_swift_msg.genmsg_mt199 (c.swref, 1);

            bc.home ();
         EXCEPTION
            WHEN OTHERS
            THEN
               bars_audit.error (
                     'job_mt199_claims:'
                  || DBMS_UTILITY.format_error_stack ()
                  || CHR (10)
                  || DBMS_UTILITY.format_error_backtrace ());
               bc.home ();
         END;
      END LOOP;
   END job_mt199_claims;
   

    PROCEDURE job_mt199_send_sms
    IS
       l_msgid   NUMBER;
    BEGIN
       BEGIN
          FOR c
             IN (SELECT s2.swref,
                        s2.vdate,
                        o.nlsa,
                        o.kv,
                        o.mfoa,
                        a.send_sms,
                        p.phone,
                        a.rnk,
                        s2.currency,
                        s2.amount
                   FROM bars.sw_journal s
                        INNER JOIN bars.sw_operw w
                           ON     s.swref = w.swref
                              AND w.tag = '79'
                              AND INSTR (w.VALUE, 'ACSC') > 0
                        INNER JOIN bars.sw_journal s2
                           ON     s.uetr = s2.uetr
                              AND s2.mt = 103
                              AND s2.imported = 'N'
                              AND NVL (s2.count_send_sms, 0) = 0
                        INNER JOIN bars.sw_oper so ON so.swref = s2.swref
                        INNER JOIN bars.oper o ON o.REF = so.REF
                        INNER JOIN bars.accounts a
                           ON a.nls = o.nlsa AND a.kv = o.kv AND a.kf = o.mfoa
                        INNER JOIN bars.acc_sms_phones p ON p.acc = a.acc
                  WHERE     s.vdate = TRUNC (SYSDATE)
                        AND s.mt = 199
                        AND s.imported = 'Y'
                        AND a.send_sms = 'Y')
          LOOP
             BEGIN
                BARS_SMS.CREATE_MSG (
                   p_msgid             => l_msgid,
                   p_creation_time     => SYSDATE,
                   p_expiration_time   => SYSDATE + 1,
                   p_phone             => c.phone,
                   p_encode            => 'lat',
                   p_msg_text          =>    'Vash platizh vid '
                                          || TO_CHAR (c.vdate, 'dd-mm-yyyy')
                                          || ' v sumi '
                                          || TRIM (
                                                TO_CHAR (c.amount / 100,
                                                         '999999999D99'))
                                          || '('
                                          || c.currency
                                          || ') uspishno zarahovano beneficiaru(swift gpi).',
                   p_rnk               => c.rnk,
                   p_kf                => c.mfoa);

                UPDATE sw_journal
                   SET count_send_sms = NVL (count_send_sms, 0) + 1
                 WHERE swref = c.swref;
             END;
          END LOOP;
       END;
    END job_mt199_send_sms;

   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     ������� ���������� ������ � ������� ��������� ������
   --
   --
   --
   FUNCTION header_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN    'package header BARS_SWIFT_MSG '
             || VERSION_HEADER
             || CHR (10)
             || 'package header definition(s):'
             || CHR (10)
             || VERSION_HEADER_DEFS;
   END header_version;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     ������� ���������� ������ � ������� ���� ������
   --
   --
   --
   FUNCTION body_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN    'package body BARS_SWIFT_MSG '
             || VERSION_BODY
             || CHR (10)
             || 'package body definition(s):'
             || CHR (10)
             || VERSION_BODY_DEFS;
   END body_version;
BEGIN
   bars_audit.trace ('%s: package init entry point', PKG_CODE);

   -- �������������� ������
   g_vldlist := t_reflist ();
   bars_audit.trace ('%s: package init succ end', PKG_CODE);
END bars_swift_msg;
/