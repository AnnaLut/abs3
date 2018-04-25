
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/finmon_export.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.FINMON_EXPORT IS
/*************************************************************************
Наименование: FINMON_EXPORT
Назаначение:
    Пакет процедур и функций для обеспецения экспорта данных из АБС в
    задачу Финансовый Мониторинг.
Изменения:

24.09.2004 Den Создание пакета
28.10.2004 Изменение алгоритма поиска умолчательного кода области
*************************************************************************/

g_header_version  constant varchar2(64)  := 'version 1.1 28/10/2004';

-- header_version - возвращает версию заголовка пакета
function header_version return varchar2;

-- body_version - возвращает версию тела пакета
function body_version return varchar2;

-- тип заголовка входящего пакета
type t_FileMetaData is record
   ( file_name      varchar2(12),    -- имя пакета (файла)
     file_date      varchar2(8),     -- дата, когда сообщение было сформировано
     file_time      varchar2(4),     -- время, когда сообщение было сформировано
     id_key         varchar2(6),     -- идентификатор пользователя
     file_signature varchar2(128)    -- подпись
   );


-- структура входящего пакета
type t_terror is record
   ( fileMetaData t_FileMetaData,   -- заголдовок
     сListTerror  clob              -- нода содержащая list-terror
   );

--
type t_wm_usr is record
   ( M_NM1    varchar2(50),
     M_NM2    varchar2(30),
     M_NM3    varchar2(30)
   );


PROCEDURE in_gate        (ID_ VARCHAR2, cli_ CLOB);
PROCEDURE out_gate       (ID_ VARCHAR2, clo_ OUT NOCOPY CLOB);
FUNCTION GETREGIONCODE   (INCODE NUMBER)   RETURN VARCHAR2;
FUNCTION GETDOCUMENTCODE (INCODE NUMBER)   RETURN VARCHAR2;
FUNCTION GETNAME         (CUSTTYPE NUMBER, NMK VARCHAR2, NMKK VARCHAR2, NMKU VARCHAR2, NPOS NUMBER) RETURN VARCHAR2;
FUNCTION GETSTATUS       (SOS NUMBER)      RETURN VARCHAR2;
FUNCTION GETCUSTOMERTYPE (CUSTTYPE NUMBER, SED IN NUMBER) RETURN VARCHAR2;

FUNCTION GETOPROBLKOD (ref_ NUMBER, iType Integer) RETURN NUMBER;
function getCode(b_ varchar2) RETURN varchar2;
FUNCTION GETBANKCODE RETURN VARCHAR2;
--procedure importPaymentDataFromABS(xml OUT NOCOPY CLOB, sign_buff OUT NOCOPY CLOB);

procedure importXYToABS(xmlXY in out CLOB, id in out numeric);--, res_buff OUT NOCOPY CLOB

function getFmBrsBranchId return varchar2;

procedure getBlockedNls(id_ varchar2, mfo_ varchar2);

function f_replace(p_str in varchar2) return varchar2;

procedure setAccountBlkd(acc_ number, blkd number);

END FINMON_EXPORT;
/
CREATE OR REPLACE PACKAGE BODY BARS.FINMON_EXPORT IS
/*
    03.01.2012 - Сменили при импорте для Надры простановку в реестр KL_ID при смене года!!!
*/
g_body_version    constant varchar2(64)  := 'version 1.2 30/10/2015';
G_TRACE  constant varchar2(10) := 'fmxy.';

ALICENSE NUMBER := 0;
-------------------------------------------------------------------------------
-- header_version - возвращает версию заголовка пакета
function header_version return varchar2 is
begin
  return 'Package header FINMON_EXPORT ' || g_header_version;
end header_version;

-------------------------------------------------------------------------------
-- body_version - возвращает версию тела пакета
function body_version return varchar2 is
begin
  return 'Package body FINMON_EXPORT ' || g_body_version;
end body_version;


FUNCTION ISLICENSE RETURN BOOLEAN
IS
BEGIN
  IF ALICENSE = 1 THEN
     RETURN TRUE;
  ELSE
     RETURN FALSE;
  END IF;
END;

PROCEDURE IN_GATE( ID_ IN VARCHAR2, CLI_ IN CLOB )
IS
BEGIN
  IF ISLICENSE THEN
     UPDATE FINMON.FILE_OUT
        SET XML_FILE = CLI_
      WHERE ID = ID_;
  END IF;
END;

PROCEDURE OUT_GATE( ID_ IN VARCHAR2, CLO_ OUT NOCOPY CLOB )
IS
BEGIN
  IF ISLICENSE THEN
     SELECT XML_FILE
       INTO CLO_
       FROM FINMON.FILE_OUT
      WHERE ID = ID_;
  END IF;
END;

FUNCTION GETBANKCODE RETURN VARCHAR2
IS
  RETCODE  VARCHAR2(2);
  CUR_CODE NUMBER;
  DEF_REGSYMBOL VARCHAR(1);
  DEF_CODE NUMBER;
BEGIN
  SELECT VAL INTO DEF_REGSYMBOL
    FROM PARAMS
   WHERE PAR = 'AREACODE';
  BEGIN
     DEF_CODE := TO_NUMBER( DEF_REGSYMBOL );
  EXCEPTION
     WHEN OTHERS THEN
        DEF_CODE := NULL;
  END;
  IF DEF_CODE IS NULL THEN
     SELECT KO
       INTO DEF_CODE
       FROM KODOBL
      WHERE substr(ISEP, 1, 1) = DEF_REGSYMBOL;
  END IF;
  return DEF_CODE;
EXCEPTION
  WHEN OTHERS THEN
     return 26;
END;

FUNCTION GETREGIONCODE(INCODE IN NUMBER) RETURN VARCHAR2
IS
  RETCODE  VARCHAR2(2);
  CUR_CODE NUMBER;
  DEF_REGSYMBOL VARCHAR(1);
  DEF_CODE NUMBER;
BEGIN
  IF ISLICENSE THEN
     IF INCODE IS NULL THEN
        DEF_CODE := GETBANKCODE;
        CUR_CODE := DEF_CODE;
     ELSE
        CUR_CODE := INCODE;
     END IF;
     BEGIN
        SELECT FINMON_CODE
          INTO RETCODE
          FROM FINMON_REGION_MATCH
         WHERE BARS_CODE = CUR_CODE;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            BEGIN
               SELECT FINMON_CODE
                 INTO RETCODE
                 FROM FINMON_REGION_MATCH
                WHERE BARS_CODE = DEF_CODE;
             EXCEPTION
                WHEN NO_DATA_FOUND THEN
                   RETCODE := 80;
             END;
      END;
  END IF;
  RETURN RETCODE;
END;

FUNCTION GETDOCUMENTCODE(INCODE IN NUMBER) RETURN VARCHAR2
IS
  RETCODE VARCHAR2( 1 );
  CURCODE NUMBER;
BEGIN
  IF ISLICENSE THEN
     IF INCODE IS NULL THEN
        CURCODE := 1;
     ELSE
        CURCODE := INCODE;
     END IF;
     BEGIN
        SELECT FINMON_CODE
          INTO RETCODE
          FROM FINMON_DOC_MATCH
         WHERE BARS_CODE = CURCODE;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            RETCODE := 8;
      END;
  END IF;
  RETURN RETCODE;
END;

FUNCTION GETNAME( CUSTTYPE IN NUMBER, NMK IN VARCHAR2, NMKK IN VARCHAR2, NMKU IN VARCHAR2, NPOS IN NUMBER ) RETURN VARCHAR2
IS
  RETNAME VARCHAR2(256);
  TMPNAME VARCHAR2(256);
  BPOS NUMBER;
  EPOS NUMBER;
BEGIN
  IF ISLICENSE THEN
     RETNAME := '';
     IF CUSTTYPE = 3 THEN
        TMPNAME := ' ' || LTRIM( RTRIM( regexp_replace(NMK, '\s{2,}', ' ') ) ) || ' ';
        BPOS := INSTR( TMPNAME, ' ', 1, NPOS );
        EPOS := INSTR( TMPNAME, ' ', 1, NPOS + 1 );
        RETNAME := SUBSTR( TMPNAME, BPOS + 1, EPOS - ( BPOS + 1 ) );
     ELSE
        IF ( CUSTTYPE = 2 ) AND ( NMKU is not NULL ) THEN
           IF NPOS = 1 THEN
              RETNAME := LTRIM( RTRIM( NMKU ) );
            ELSIF NPOS = 2 THEN
              RETNAME := LTRIM( RTRIM( NMKK ) );
            ELSE
              RETNAME := '';
           END IF;
        ELSE
           IF NPOS = 1 THEN
              RETNAME := LTRIM( RTRIM( NMK ) );
            ELSIF NPOS = 2 THEN
              RETNAME := LTRIM( RTRIM( NMKK ) );
            ELSE
              RETNAME := '';
           END IF;
        END IF;
     END IF;
  END IF;
  RETURN RETNAME;
END;

FUNCTION GETSTATUS(SOS IN NUMBER) RETURN VARCHAR2
IS
  RETCODE VARCHAR2(1);
BEGIN
  IF ISLICENSE THEN
     IF SOS < 0 THEN
        RETCODE := '3';
     ELSIF SOS >= 5 THEN
        RETCODE := '1';
     ELSE
        RETCODE := '2';
     END IF;
  END IF;
  RETURN RETCODE;
END;

FUNCTION GETCUSTOMERTYPE( CUSTTYPE IN NUMBER, SED IN NUMBER) RETURN VARCHAR2
IS
  RETCODE VARCHAR2( 1 );
BEGIN
  IF ISLICENSE THEN
     IF CUSTTYPE = 1 THEN
        RETCODE := '4';
     ELSIF CUSTTYPE = 2 THEN
        RETCODE := '1';
     ELSIF CUSTTYPE = 3 THEN
        IF SED = 91 THEN
           RETCODE := '3';
        ELSE
           RETCODE := '2';
        END IF;
     ELSIF CUSTTYPE = 4 THEN
        RETCODE := '3';
     ELSE
        RETCODE := '1';
     END IF;
  END IF;
  RETURN RETCODE;
END;

/*procedure importPaymentDataFromABS(fileName out varchar2,
                                        xml OUT NOCOPY CLOB,
                                  sign_buff OUT NOCOPY CLOB);
begin
null;
end;
*/

-----------------------------------------------------------------
--    PARSE_HEADER
--
--    Инициализировать структуру заголовка из кллоба входящего пакета
--
--    p_packname    - имя файла
--    p_indoc       - клоб входящего пакета
--    p_hdr         - структура заголовка
--
procedure parse_FileMetaData(
               l_doc     dbms_xmldom.DOMDocument,
               p_fmd  in out t_FileMetaData)
is
   l_nd       dbms_xmldom.DOMNode;
begin
   l_nd  := dbms_xmldom.makeNode(l_doc);
   dbms_xslprocessor.valueOf(l_nd, '//file-meta-data/file-name/text()', p_fmd.file_name);
   dbms_xslprocessor.valueOf(l_nd, '//file-meta-data/file-date/text()', p_fmd.file_date);
   dbms_xslprocessor.valueOf(l_nd, '//file-meta-data/file-time/text()', p_fmd.file_time);
   dbms_xslprocessor.valueOf(l_nd, '//file-meta-data/id-key/text()', p_fmd.id_key);
   dbms_xslprocessor.valueOf(l_nd, '//file-meta-data/file-signature/text()', p_fmd.file_signature);
exception when others then
   raise;
end;


-----------------------------------------------------------------
--    PARSE_CLOB()
--
--    Парсит клоб и возвразает докумнет
--
--
function parse_clob(p_inclob clob)  return dbms_xmldom.DOMDocument
is
   l_parser     dbms_xmlparser.Parser;
   l_doc        dbms_xmldom.DOMDocument;
   l_trace      varchar2(1000):=G_TRACE||'parse_clob: ';
begin
   l_parser   := dbms_xmlparser.newParser;
   dbms_xmlparser.parseClob(l_parser, p_inclob);
   l_doc      := dbms_xmlparser.getDocument(l_parser);
   dbms_xmlparser.freeParser(l_parser);
   return l_doc;
exception when others then
    dbms_xmlparser.freeParser(l_parser);
    bars_audit.error(l_trace||'ошибка парсинга докумнета: '||sqlerrm);
    raise;
end;

-----------------------------------------------------------------
function terror_tostring(p_fmd  in out t_FileMetaData) return varchar2
is
   nwl  char(2) := chr(13)||chr(10);
begin

   return  'пакет  : '||p_fmd.file_name||nwl||
           'дата   : '||p_fmd.file_date||nwl||
           'время : '||p_fmd.file_time||nwl;
end;

-----------------------------------------------------------------
--    CONVERT_TO_DATE()
--
--    Проверяет строку на валидность формата даты
--
--
function convert_to_date(p_strdate varchar2, p_tag varchar2) return date
is
   l_datepattern   varchar2(10);
   l_date          date;
begin
   return to_date(p_strdate, 'yyyymmdd');
exception when others then
   raise;
   --bars_error.raise_error(G_MODULE, 41, p_tag);
end;

-----------------------------------------------------------------
--    CONVERT_TO_NUMBER()
--
--    Конвертит строку в число  соответсвующим exept
--
--
function convert_to_number(p_str varchar2, p_tag varchar2) return number
is
   l_nmbr    number(38,5);
begin
   return to_number(p_str);
exception when others then
   raise;
   --bars_error.raise_error(G_MODULE, 26, p_tag);
end;

-----------------------------------------------------------------
function convert_to_varchar(p_str varchar2, p_tag varchar2) return varchar2
is
   l_nmbr    number(38,5);
begin
   return convert(p_str, 'CL8MSWIN1251', 'UTF8');
exception when others then
   raise;
   --bars_error.raise_error(G_MODULE, 26, p_tag);
end;

-----------------------------------------------------------------
--    GET_DOC_ATTRIBS
--
--    Получить доп реквизиты документа из ноды документа
--
--    p_docnd     - нода док-та
--    p_path      - путь к списку доп. реквизитов
--    p_dreclst   - список доп реквизитов
--
--
procedure get_aka_lists (
               p_list            dbms_xmldom.DOMNode,
               p_path             varchar2,
               p_c1 FINMON_REFT_AKALIST.c1%type)
is
   l_ndlist    dbms_xmldom.DOMNodeList;
   l_nd        dbms_xmldom.DOMNode;
   r_fra       FINMON_REFT_AKALIST%rowtype;
   i           number;
   l_trace     varchar2(1000) := G_TRACE||'get_aka_lists: ';
   l_tmp       varchar2(1000);
begin

   l_ndlist   := dbms_xslprocessor.selectNodes(p_list, p_path);
   bars_audit.info(l_trace||'всего доп-реквизитов='||dbms_xmldom.getLength(l_ndlist));

   for i in 0..dbms_xmldom.getLength(l_ndlist) - 1  loop

        l_nd      := dbms_xmldom.item(l_ndlist, i);
        r_fra.c1 :=  p_c1;
        dbms_xslprocessor.valueOf(l_nd, 'aka-name1/text()', l_tmp );
        --r_fra.c6 := trim(dbms_xmlgen.convert(l_tmp,1));
        r_fra.c6 := convert_to_varchar(trim(dbms_xmlgen.convert(l_tmp,1)),  'aka-name1');

        dbms_xslprocessor.valueOf(l_nd, 'aka-name2/text()', l_tmp );
        --r_fra.c7 := trim(dbms_xmlgen.convert(l_tmp,1));
        r_fra.c7 := convert_to_varchar(trim(dbms_xmlgen.convert(l_tmp,1)),  'aka-name2');

        dbms_xslprocessor.valueOf(l_nd, 'aka-name3/text()', l_tmp );
        --r_fra.c8 := trim(dbms_xmlgen.convert(l_tmp,1));
        r_fra.c8 := convert_to_varchar(trim(dbms_xmlgen.convert(l_tmp,1)),  'aka-name3');

        dbms_xslprocessor.valueOf(l_nd, 'aka-name4/text()', l_tmp );
        --r_fra.c9 := trim(dbms_xmlgen.convert(l_tmp,1));
        r_fra.c9 := convert_to_varchar(trim(dbms_xmlgen.convert(l_tmp,1)),  'aka-name4');

         insert into FINMON_REFT_AKALIST values r_fra;
    end loop;
exception when others then
   bars_audit.error(l_trace||'ошибка получения аттрибутов док-та: '||sqlerrm);
   raise;
end;

-----------------------------------------------------------------
procedure set_imp_error(id numeric, c1 numeric, Error_detail varchar2)
is
            r_lte FINMON_REFT_INPERR%rowtype;
begin
    r_lte.id := id;
    r_lte.c1 := c1;
    r_lte.Error_detail := Error_detail;
    insert into FINMON_REFT_INPERR values r_lte;
end;

-----------------------------------------------------------------
-- Обработка и вставка записей в FINMON_REFT!!!
-----------------------------------------------------------------
procedure setFinmonReft(l_terror in out t_terror, id numeric)
is
    l_lt       dbms_xmldom.DOMDocument;
    l_al      dbms_xmldom.DOMNodeList;
    l_nd      dbms_xmldom.DOMNode;
    r_lt       FINMON_REFT%rowtype;
    rec_count varchar2(10);
    rec_ver varchar2(100);
    rec_date_ver date;
    rec_type varchar2(1);
    l_tmp           varchar2(4000);
begin
     l_lt := parse_clob(l_terror.сListTerror);

     l_al := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(l_lt), '/list-terror/acount-list');
     dbms_xslprocessor.valueOf(dbms_xmldom.makeNode(l_lt), '//count-record/text()', rec_count);

     -- Если rec_type = 1 то это полный список!!!всё удаляем и принимаем с нуля!!!
     dbms_xslprocessor.valueOf(dbms_xmldom.makeNode(l_lt), '//ver-list/text()', rec_ver);
	dbms_xslprocessor.valueOf(dbms_xmldom.makeNode(l_lt), '//date-ver-list/text()', l_tmp);
	rec_date_ver := convert_to_date(l_tmp, 'date-ver-list');
     dbms_xslprocessor.valueOf(dbms_xmldom.makeNode(l_lt), '//type-list/text()', rec_type);

     if(rec_type = 1)then
         delete from FINMON_REFT_AKALIST;
         delete from FINMON_REFT;
     end if;

     bars_audit.info(g_trace||' Кол-во тегов acount-list  в пакете:'||dbms_xmldom.getLength(l_al)||' кол-во указанное в заголовке list-terror:'||rec_count);
     for i in 0 .. dbms_xmldom.getLength(l_al) - 1  loop begin
         savepoint xml_al_before;
         l_nd      := dbms_xmldom.item(l_al, i);

         dbms_xslprocessor.valueOf(l_nd, 'number-entry/text()', l_tmp);
         r_lt.c1 := convert_to_number(l_tmp, 'number-entry');
         dbms_xslprocessor.valueOf(l_nd, 'date-entry/text()', l_tmp);
         r_lt.c2 := convert_to_date(l_tmp, 'date-entry');
         dbms_xslprocessor.valueOf(l_nd, 'type-record/text()', l_tmp);
         r_lt.c3 := convert_to_number(l_tmp, 'type-record');
         dbms_xslprocessor.valueOf(l_nd, 'type-entry/text()', r_lt.c4);
         dbms_xslprocessor.valueOf(l_nd, 'program-entry/text()', l_tmp);
         --r_lt.c5 := trim(dbms_xmlgen.convert(l_tmp,1));
         r_lt.c5 := convert_to_varchar(trim(dbms_xmlgen.convert(l_tmp,1)),  'program-entry');
         --  не учавсивуют из-за переноса в отдельную структуру
         r_lt.c6 := null;
         r_lt.c7 := null;
         r_lt.c8 := null;
         r_lt.c9 := null;
         r_lt.c10 := null;
         r_lt.c11 := null;
         r_lt.c12 := null;
         dbms_xslprocessor.valueOf(l_nd, 'date-of-birth-list/text()', l_tmp);
         r_lt.c13 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'place-of-birth-list/text()', l_tmp);
         r_lt.c14 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'citizenchip-list/text()', l_tmp);
         r_lt.c15 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'nationality-list/text()', l_tmp);
         r_lt.c16 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'designation-list/text()', l_tmp);
         r_lt.c17 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'working-list/text()', l_tmp);
         r_lt.c18 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'title-list/text()', l_tmp);
         r_lt.c19 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'id-number-list/text()', l_tmp);
         r_lt.c25 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'noted-on-conviction/text()', l_tmp);
         r_lt.c35 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'noted-on-prosecution/text()', l_tmp);
         r_lt.c36 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'comments/text()', l_tmp);
         r_lt.c37 := convert_to_varchar(trim(dbms_xmlgen.convert(l_tmp,1)),'comments');
         dbms_xslprocessor.valueOf(l_nd, 'comments-record/text()', l_tmp);
         r_lt.c38 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'noted-off-list/text()', l_tmp);
         r_lt.c39 := convert_to_date(l_tmp, 'noted-off-list');
         --document-list
         dbms_xslprocessor.valueOf(l_nd, 'document-list/document-id/text()', l_tmp);
         r_lt.c20 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'document-list/document-date/text()', l_tmp);
         r_lt.c21 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'document-list/document-country/text()', l_tmp);
         r_lt.c22 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'document-list/code-document-country/text()', l_tmp);
         r_lt.c23 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'document-list/document-reg/text()', l_tmp);
         r_lt.c24 := trim(dbms_xmlgen.convert(l_tmp,1));
         --address-list
         dbms_xslprocessor.valueOf(l_nd, 'address-list/country/text()', l_tmp);
         r_lt.c26 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'address-list/country-code/text()', l_tmp);
         r_lt.c27 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'address-list/postal-code/text()', l_tmp);
         r_lt.c28 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'address-list/state-province/text()', l_tmp);
         r_lt.c29 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'address-list/city/text()', l_tmp);
         r_lt.c30 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'address-list/address1/text()', l_tmp);
         r_lt.c31 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'address-list/address2/text()', l_tmp);
         r_lt.c32 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'address-list/address3/text()', l_tmp);
         r_lt.c33 := trim(dbms_xmlgen.convert(l_tmp,1));
         begin
             dbms_xslprocessor.valueOf(l_nd, 'address-list/address/text()', l_tmp);
             l_tmp := substr(l_tmp, 1, 1000);
             r_lt.c34 := trim(dbms_xmlgen.convert(l_tmp,1));
         exception  when others then
             r_lt.c34 := null;
         end;
         --bank-list
         dbms_xslprocessor.valueOf(l_nd, 'bank-list/bank-inf/text()', l_tmp);
         r_lt.c40 := trim(dbms_xmlgen.convert(l_tmp,1));
         dbms_xslprocessor.valueOf(l_nd, 'bank-list/bank-count/text()', l_tmp);
         r_lt.c41 := trim(dbms_xmlgen.convert(l_tmp,1));

         insert into FINMON_REFT values r_lt;

         -- Проимпортируем aka-list
         get_aka_lists(l_nd, 'aka-list', r_lt.c1);

         -- записывае лог приёма
         --set_imp_error(id, r_lt.c1, 'Успешно принято');
     exception  when others then
         rollback to xml_al_before;
       --get_process_error(sqlerrm,l_errcode,l_errumsg);
       --G_PACK_STATUS := G_PACK_PROCESS_STATUS_FAILED;
       set_imp_error(id, r_lt.c1, g_trace||' ошибка обработки пакета acount-list №:'||(i + 1)||' - '||sqlerrm);
       bars_audit.error(g_trace||' ошибка обработки пакета acount-list №:'||(i + 1)||' - '||sqlerrm);
     end; end loop;

	begin
         update bars.fm_params set val = rec_ver where par = 'XY_FILEVER';
        IF SQL%ROWCOUNT=0 THEN
	      insert into bars.fm_params(par, val, comm) values('XY_FILEVER', rec_ver, 'XY. Версія файлу');
        END IF;
	end;

	begin
         update bars.fm_params set val = to_char(rec_date_ver, 'YYYY-MM-DD') where par = 'XY_FILEDAT';
        IF SQL%ROWCOUNT=0 THEN
	      insert into bars.fm_params(par, val, comm) values('XY_FILEDAT', to_char(rec_date_ver, 'YYYY-MM-DD'), 'XY. Дата файлу');
        END IF;
	end;

	begin
         update bars.fm_params set val = rec_type where par = 'XY_FILETYP';
        IF SQL%ROWCOUNT=0 THEN
	      insert into bars.fm_params(par, val, comm) values('XY_FILETYP', rec_type, 'XY. Тип оновлення файлу');
        END IF;
	end;

     dbms_xmldom.freedocument(l_lt);
exception when others then
   if not dbms_xmldom.isnull(l_lt) then
      dbms_xmldom.freedocument(l_lt);
   end if;
   raise;
end;

-----------------------------------------------------------------
--    PARSE_BODY
--
--    Инициализировать клоб тега <Body>
--
--    p_indoc       - клоб входящего пакета
--    p_hdr         - структура заголовка
--
procedure parse_ListTerror(
               l_doc    dbms_xmldom.DOMDocument,
               p_cListTerror in out  clob)
is
   l_nd       dbms_xmldom.DOMNode;
   l_ndtxt    dbms_xmldom.DOMNode;
   l_trace    varchar2 (1000) := G_TRACE||'parse_body: ';
begin

   l_nd      := dbms_xmldom.makeNode(l_doc);
   l_ndtxt   := dbms_xslprocessor.selectSingleNode(l_nd, '//list-terror');

   dbms_lob.createtemporary(p_cListTerror, false);
   dbms_xmldom.writetoclob(l_ndtxt, p_cListTerror);

exception when others then
   bars_audit.error(g_trace||' ошибка Инициализации тела пакета:'||sqlerrm);
   raise;
end;

-----------------------------------------------------------------
procedure importXYToABS(xmlXY in out CLOB, id in out numeric)--, res_buff OUT NOCOPY CLOB
is
  l_indoc   clob;
  l_indoc_r clob;
  l_indoc_t clob;
  l_doc     dbms_xmldom.DOMDocument;
  l_terror  t_terror;
  i_pos     numeric(18);
  i_len     numeric(18);
begin
  bars_audit.info('старт!');

  select BARS.S_FINMON_REFT_INPERR.nextval into id from dual;

  i_pos := DBMS_LOB.INSTR(xmlXY, '<!DOCTYPE transport-file SYSTEM "tr_list10.dtd">');
  i_len := DBMS_LOB.GETLENGTH(xmlXY);
  bars_audit.info('FM старт!' || i_pos);
  bars_audit.info('FM старт!' || i_len);

  l_indoc_r := DBMS_LOB.SUBSTR(xmlXY, i_pos - 1);
  bars_audit.info('FM старт!' ||l_indoc_r);
  DBMS_LOB.CREATETEMPORARY(l_indoc_t,TRUE);
  DBMS_LOB.copy(l_indoc_t, xmlXY, i_len - (i_pos + 48), 1, i_pos + 49);
  bars_audit.info('FM старт! = ' ||DBMS_LOB.GETLENGTH(l_indoc_t));

  DBMS_LOB.APPEND(l_indoc_r, l_indoc_t);

  --l_indoc := convert(l_indoc_r,  'CL8MSWIN1251','UTF8');

  l_indoc := l_indoc_r;

  l_doc := parse_clob(l_indoc);

  -- разобрать заголовок
  parse_FileMetaData(l_doc => l_doc,
                     p_fmd => l_terror.fileMetaData);
  bars_audit.info(g_trace||'информация о заголовке: ' || terror_tostring(l_terror.fileMetaData));

  -- инициализироть клоб тела док-та <list-terror>
  parse_ListTerror(l_doc         => l_doc,
                   p_cListTerror => l_terror.сListTerror);

  setFinmonReft(l_terror, id);

  dbms_xmldom.freedocument(l_doc);
  dbms_lob.freetemporary(l_terror.сListTerror);
  if dbms_lob.istemporary(l_indoc_r) = 1 then
      dbms_lob.freetemporary(l_indoc_r);
  end if;
  if dbms_lob.istemporary(l_indoc_t) = 1 then
      dbms_lob.freetemporary(l_indoc_t);
  end if;

exception when others then
  if not dbms_xmldom.isnull(l_doc) then
     dbms_xmldom.freedocument(l_doc);
  end if;
  if dbms_lob.istemporary(l_terror.сListTerror) = 1 then
     dbms_lob.freetemporary(l_terror.сListTerror);
  end if;
  bars_audit.trace(g_trace||'Ошибка добавления тега Body в ответ:'||sqlerrm);
  raise;
end;

-----------------------------------------------------------------
function getCode(b_ varchar2) RETURN varchar2
     is
        type_branch_ NUMBER;
        bpos_ NUMBER;
        INCODE NUMBER;
     begin
                IF b_ IS NOT NULL THEN
                   type_branch_ := TO_NUMBER(SUBSTR(b_, 9, 1));

                   IF type_branch_ = 0 THEN
                      bpos_ := 4;
                   ELSIF type_branch_ = 1 THEN
                      bpos_ := 10;
                   ELSE
                      bpos_ := 15;
                   END IF;

                   -- код области
                   INCODE:=SUBSTR(b_, bpos_, 2);
                end if;

                return GETREGIONCODE(INCODE);

     end;

-----------------------------------------------------------------
FUNCTION GETOPROBLKOD (ref_ NUMBER, iType Integer) RETURN NUMBER
is
      b040_ varchar2(20);
      DEF_CODE NUMBER;
      HAVETOBO_ varchar2(20);

begin
    DEF_CODE := GETREGIONCODE(null);
    if iType = 1 then
            BEGIN
                SELECT distinct b040
                    INTO b040_
                   FROM tobo t, accounts a, oper r
                 WHERE t.tobo = a.tobo and r.ref = ref_ and a.nls = r.nlsa;

                DEF_CODE := getCode(b040_);

            EXCEPTION WHEN OTHERS THEN
                begin
                    SELECT distinct b040
                        INTO b040_
                       FROM tobo t, accounts a, oper r
                     WHERE t.tobo = a.tobo and r.ref = ref_ and a.nls = r.nlsb;

                        DEF_CODE := getCode(b040_);

                EXCEPTION WHEN OTHERS THEN
                    begin
                       SELECT b040
                          INTO b040_
                          FROM tobo t, oper o
                          WHERE t.tobo = o.tobo and o.ref = ref_;

                            DEF_CODE := getCode(b040_);

                        EXCEPTION WHEN OTHERS THEN
                            DEF_CODE := GETREGIONCODE(null);
                    END;
                END;
            end;
    else
        -- Проверим используется ли тобо
        begin
                select trim(val) into b040_ from params where par = 'HAVETOBO';
            EXCEPTION WHEN OTHERS THEN
                 HAVETOBO_ := 0;
        END;
        if HAVETOBO_ in ('1', '2') then
            begin

               SELECT b040
                  INTO b040_
                  FROM tobo t, accounts a, arc_rrp r
                  WHERE t.tobo = a.tobo and r.rec = ref_ and a.nls = r.nlsb;

                DEF_CODE := getCode(b040_);
                EXCEPTION WHEN OTHERS THEN
                     DEF_CODE := GETREGIONCODE(null);
            END;
        else -- если нет тобо
            DEF_CODE := GETREGIONCODE(null);
        end if;
    end if;

    return to_char(DEF_CODE);
end;

-----------------------------------------------------------------
function getFmBrsBranchId return varchar2
is
BRANCH_ID_ varchar2(15);
begin
    begin
        select id into BRANCH_ID_ from finmon.bank where UST_MFO = bars.gl.aMfo;
    exception when no_data_found then
        bars_audit.info('BRS_FATF import MFO = '||bars.gl.aMfo||' не знайдено!');
        BRANCH_ID_ := FINMON.GET_BRANCH_ID;
    end;
    return BRANCH_ID_;
end;



-----------------------------------------------------------------
function f_replace(p_str in varchar2) return varchar2
-- функция убирает непечатаемые символы и серии пробелов
is
  x00_x1f varchar2(32) :=
     chr(00)||chr(01)||chr(02)||chr(03)||chr(04)||chr(05)||chr(06)||chr(07)||
     chr(08)||chr(09)||chr(10)||chr(11)||chr(12)||chr(13)||chr(14)||chr(15)||
     chr(16)||chr(17)||chr(18)||chr(19)||chr(20)||chr(21)||chr(22)||chr(23)||
     chr(24)||chr(25)||chr(26)||chr(27)||chr(28)||chr(29)||chr(30)||chr(31);

begin
    return
      replace(replace(replace(replace(replace(
        translate(trim(p_str),   x00_x1f, rpad(' ',32)),
        '      ',' '),
        '     ',' '),
        '    ',' '),
        '   ',' '),
        '  ',' ');

end;

-----------------------------------------------------------------
procedure getBlockedNls(id_ varchar2, mfo_ varchar2)
is
    txt varchar2(4000);
    nls_ varchar2(100);
    pos_ number;
    acc_ number;
    is_locked_nls number(1) := 0;

    function getNlsPos(in_pos number) return number
    is
    nls_abs varchar2(100);
    nbs_ bars.ps.nbs%type;
    is_locked_ number(1) := 0;
    begin
        select REGEXP_substr(txt, '[[:space:]][[:digit:]]{5,14}[[:space:]]', in_pos), REGEXP_INSTR(txt, '[[:space:]][[:digit:]]{5,14}[[:space:]]', in_pos) into nls_, pos_ from dual;

        if length(trim(nls_)) >= 5 then begin
            -- Проверим есть ли такой балансовый
            select nbs into nbs_ from bars.ps where nbs = substr(trim(nls_), 1, 4);
            -- Найдём счет в нашем банке!!!
            acc_ := null;
            -- Проверим конрольный разряд
            if BARS.VKRZN(SUBSTR(mfo_,1,5), trim(nls_)) = trim(nls_) then
                bars.deb.trace(3, 'id = '||id_||'nls_ = '||trim(nls_), pos_);
                -- Находим все счета и блокируем!!!
                for c_nls in (select acc, nls, kv from bars.accounts where nls = trim(nls_)) loop
                    -- внесем данные в табличку финмона, что был такой счет и мы его заблокировали.
                    update finmon.decision_nls set acc = acc_ where nls = c_nls.nls and kv = c_nls.kv and IDD = id_;
                    if sql%rowcount = 0 then
                        insert into finmon.decision_nls(idd, nls, kv, acc)
                        values (id_, c_nls.nls, c_nls.kv, c_nls.acc);
                        is_locked_ := 1;
                    end if;
                    /*begin
                        setAccountBlkd(acc_, 77);
                    exception when OTHERS then null;
                    end;*/
                end loop;
            end if;
            select acc into acc_ from bars.accounts where nls = trim(nls_) and kv = 980;
        exception when no_data_found then null; end;
        end if;
        if pos_ > 0 then is_locked_ := greatest(getNlsPos(pos_ + length(nls_) - 1), is_locked_); end if;
        return is_locked_;
    end;

begin
    begin
        --bars.deb.trace(1, 'txt = ', 1);
        select ' '||f_replace(REGEXP_REPLACE(text, '[[:alpha:][:cntrl:],.+-/\\=_*()?!~`’@#$%^&:;№«»–•"'']')) into txt from finmon.decision where id = id_;
        --dbms_output.put(txt);
        is_locked_nls := getNlsPos(1);
        --теперь отправим это все по почте тем кто хотел знать о том что пришел файл!!!
        if is_locked_nls = 1 then
            for c_mail in (select * from finmon.FM_MAIL where blk = 0) loop
                if c_mail.W_MAIL is not null then
                    bars.bars_mail.to_mail(
                            p_to_addr   =>  c_mail.W_MAIL,  -- Адрес получателя e-mail
                            p_to_name   =>  c_mail.FIO,  -- Имя получателя e-mail
                            p_subject   => 'Файлы М.',  -- Тема сообщения
                            p_body  => 'Техническое сообщение о получении файла М.'       -- Тело сообщения
                        );
                end if;
                if c_mail.alt_mail is not null then
                    bars.bars_mail.to_mail(
                            p_to_addr   =>  c_mail.alt_mail,  -- Адрес получателя e-mail
                            p_to_name   =>  c_mail.FIO,  -- Имя получателя e-mail
                            p_subject   => 'Файлы М.',  -- Тема сообщения
                            p_body  => 'Техническое сообщение о получении файла М.'       -- Тело сообщения
                        );
                end if;
            end loop;
        end if;
    exception when no_data_found then null;
    end;
end;

-----------------------------------------------------------------
procedure setAccountBlkd(acc_ number, blkd number)
is
begin
    -- Заблокируем счет!
    update bars.accounts set blkd = blkd where acc = acc_;
end;

BEGIN

    ALICENSE := 1;

END FINMON_EXPORT;
/
 show err;
 
PROMPT *** Create  grants  FINMON_EXPORT ***
grant EXECUTE                                                                on FINMON_EXPORT   to FINMON;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/finmon_export.sql =========*** End *
 PROMPT ===================================================================================== 
 