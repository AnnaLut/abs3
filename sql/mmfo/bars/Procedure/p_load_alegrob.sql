

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LOAD_ALEGROB.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LOAD_ALEGROB ***

  CREATE OR REPLACE PROCEDURE BARS.P_LOAD_ALEGROB 
-- version 1.3 14.07.2011
is
p     constant varchar2(100) := 'ldalegrob';
--
MODCODE          constant varchar2(3)     := 'USS';
PARAM_LOADDIR    constant params.par%type := 'ALG_DIR';     -- конф. параметр "Имя каталога для загрузки"
UPDATE_FILENAME  constant varchar2(255)   := 'alegrob.dbf';
UPDATE_TABNAME   constant varchar2(30)    := 'ALEGROB2';
--
l_filedir   params.val%type;                                -- имя каталога
--
begin
    bars_audit.trace('%s: entry point', p);

    -- Получаем имя каталога для загрузки файла
    l_filedir := upper(getglobaloption(PARAM_LOADDIR));
    bars_audit.trace('%s: load directory is %s', p, l_filedir);

    -- Пишем сообщение об ошибке, если каталог не задан
    if (l_filedir is null) then
        bars_audit.trace('%s: error detected - parameter ALG_DIR not set.', p);
        bars_error.raise_nerror(MODCODE, 'ALEGROB_DIR_NOTSET');
    end if;

    -- Загружаем файл обновлений
    bars_audit.trace('%s: loading update file ...', p);

    bars_dbf.import_dbf_srv(
          p_oradir     => l_filedir,
          p_filename   => UPDATE_FILENAME,
          p_tabname    => UPDATE_TABNAME,
          p_createmode => 2             );
    commit;
    bars_audit.trace('%s: update file succ loaded in table %s.', p, UPDATE_TABNAME);

    bars_audit.trace('%s: succ end', p);

exception
    when OTHERS then
        bars_audit.error(bars_error.get_nerror_text(MODCODE, 'ALEGROB_UNKNOWN_ERROR', sqlerrm));
        bars_audit.trace('%s: end with err, unhandled error detected', p);
                bars_audit.trace(bars_error.get_nerror_text(MODCODE, 'ALEGROB_UNKNOWN_ERROR', sqlerrm));

end p_load_alegrob;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LOAD_ALEGROB.sql =========*** En
PROMPT ===================================================================================== 
