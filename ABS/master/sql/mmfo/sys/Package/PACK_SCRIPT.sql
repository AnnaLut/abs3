CREATE OR REPLACE PACKAGE SYS.PACK_SCRIPT
--authid current_user
AS


/*
declare
  p_dir         varchar2(30)  := 'AUDIT_NBU';
  l_object_name varchar2(200) := '%';
  l_object_type varchar2(200) := 'PACKAGE';


   p_filename varchar2(200);
  l_scripts clob;
  l_clob blob;
  t_fh utl_file.file_type;
  t_len pls_integer :=4000;
begin

for x in (
      select '/Sql/Bars/'||lower(object_type)||'/'||'' dir, lower(object_name)||'.sql'  file_name, object_type, object_name
        FROM ALL_OBJECTS
       where  object_name like l_object_name
         and  object_type like l_object_type
         and  object_type in ('VIEW' ,'TABLE', 'TRIGGER', 'FUNCTION', 'PACKAGE','PROCEDURE')
         and  owner = 'BARS'
         and  generated != 'Y'
        order by object_type, object_name )
LOOP
     l_scripts :=  case   when x.object_type = 'TABLE'       then  PACK_SCRIPT.SCRIPTS_TABLE_ALL(x.object_name)
                          when x.object_type = 'VIEW'        then  PACK_SCRIPT.scripts_view(x.object_name)
                          when x.object_type = 'TRIGGER'     then  PACK_SCRIPT.scripts_trigger(x.object_name)
                          when x.object_type = 'PROCEDURE'   then  PACK_SCRIPT.scripts_procedure(x.object_name)
                                                             else  PACK_SCRIPT.scripts_all(x.object_name, x.object_type)
                     end;

     dbms_application_info.set_client_info ('Формування - '||upper(x.file_name));
     dbms_lob.createtemporary( l_clob, true );
     for i in 0 .. trunc( ( dbms_lob.getlength( l_scripts ) - 1 ) / t_len )
     loop
     dbms_lob.append( l_clob , UTL_RAW.CAST_TO_RAW(dbms_lob.substr( l_scripts , t_len , i * t_len + 1  )));
     end loop;



     t_fh := utl_file.fopen( p_dir, x.file_name , 'W' );
    for i in 0 .. trunc( ( dbms_lob.getlength( l_clob ) - 1 ) / t_len )
    loop
           utl_file.put_raw( t_fh , dbms_lob.substr( l_clob , t_len , i * t_len + 1 )  );
    end loop;
     utl_file.fclose( t_fh );

    dbms_lob.freetemporary( l_clob );

END LOOP;
commit;
  utl_file.fclose_all;
end;





  -- set_transform_param     https://docs.oracle.com/cd/A91202_01/901_doc/appdev.901/a89852/d_metad8.htm

select 'DROP TABLE BARS.'||table_name||' CASCADE CONSTRAINTS;'    FROM USER_TABLES where table_name like '%SKRY%' or table_name like '%SKR_IMP%'

select 'Drop trigger '||trigger_name||';'  from USER_TRIGGERS  where table_name like '%SKRY%' or table_name like '%SKR_IMP%'

select 'Drop view '||view_name||';'  from USER_VIEWS  where view_name like '%SKRY%'

select 'Drop sequence '||sequence_name||';' from USER_SEQUENCES  where sequence_name like '%SKRY%'



Drop table tmp_Modul_SKR_Scripts


create table tmp_Modul_SKR_Scripts as
select 'E:\Ssvn\Products\Module_Structure_Example\Sql\Bars\Table\'||lower(table_name)||'.sql' file_name, PACK_SCRIPT.scripts_table(table_name) scripts, 0 loads, '@Sql\Bars\Table\'||table_name||'.sql;'  inst   FROM USER_TABLES where table_name like '%SKRY%' or table_name like '%SKR_IMP%'
union all
select 'E:\Ssvn\Products\Module_Structure_Example\Sql\Bars\constraint\'||lower(table_name)||'.sql' file_name, PACK_SCRIPT.scripts_constraint(table_name) scripts, 0 loads, '@Sql\Bars\constraint\'||table_name||'.sql;'  inst    FROM USER_TABLES where table_name like '%SKRY%' or table_name like '%SKR_IMP%'
union all
select 'E:\Ssvn\Products\Module_Structure_Example\Sql\Bars\Index\'||lower(table_name)||'.sql' file_name, PACK_SCRIPT.scripts_index(table_name) scripts, 0 loads, '@Sql\Bars\Index\'||table_name||'.sql;'  inst    FROM USER_TABLES where table_name like '%SKRY%' or table_name like '%SKR_IMP%'
union all
select 'E:\Ssvn\Products\Module_Structure_Example\Sql\Bars\Trigger\'||lower(trigger_name)||'.sql' file_name, PACK_SCRIPT.scripts_trigger(trigger_name) scripts, 0 loads, '@Sql\Bars\Trigger\'||lower(trigger_name)||'.sql;'  inst from USER_TRIGGERS  where table_name like '%SKRY%' or table_name like '%SKR_IMP%'
union all
select 'E:\Ssvn\Products\Module_Structure_Example\Sql\Bars\View\'||lower(view_name)||'.sql' file_name, PACK_SCRIPT.scripts_view(view_name) scripts, 0 loads, '@Sql\Bars\View\'||lower(view_name)||'.sql;'  inst from USER_VIEWS  where view_name like '%SKRY%' or view_name like '%SKR_IMP%'


select 'E:\Ssvn\Products\Module_Structure_Example\Sql\Bars\Sequence\'||lower(sequence_name)||'.sql' file_name, PACK_SCRIPT.scripts_sequence(sequence_name) scripts, 0 loads, '@Sql\Bars\Sequence\'||lower(sequence_name)||'.sql;'  inst from USER_SEQUENCES  where sequence_name like '%SKRY%'



select codeapp, name , 'E:\Ssvn\Products\ABSBars\Sql\SKN\Sql\Bars\Data\patch_'||codeapp||'.sql' name_file, PACK_SCRIPT.SCRIPTS_ARM(codeapp)  from applist where upper(name) like '%ДЕПОЗИТН%СЕЙ%'



 select 'E:\Ssvn\Products\ABSBars\Sql\_OLD\Modules\ZVD\Sql\Bars\'||lower(object_type)||'\'||lower(object_name)||'.sql'  file_name,
         PACK_SCRIPT.scripts_all(object_name, object_type) scripts,
         0 loads,
         '@Sql\Bars\'||lower(object_type)||'\'||object_name||'.sql;'  inst
   FROM ALL_OBJECTS
   where object_name like 'V_FIN%'
    order by object_type, object_name


*/

procedure finish_zip( p_zipped_blob in out nocopy blob );

procedure add_file
    ( p_arh in out nocopy blob
    , p_filename varchar2
    , p_file clob
    );

function load_owner_zip (  p_owner varchar2 default 'BARS', p_object_name varchar2 default '%', p_object_type varchar2 default '%')  return blob;

function load_object_zip (   l_object_name varchar2 default 'FIN%',
                             l_object_type varchar2 default 'PACKAGE')  return blob;

function load_bmd_zip (   l_object_name varchar2 default '%')   return blob;

function load_tts_zip (   l_object_name varchar2 default '%')   return blob;

function load_arm_zip (l_app_name varchar2 default '%')  return blob;

function scripts_all (p_object_name varchar2, p_object_type varchar2, p_owner varchar2 default 'BARS') return clob;

-- Створення скрипта для таблиць table,constrraint, index, grants
function scripts_table_all (p_table_name varchar2, p_owner varchar2 default 'BARS') return clob;

-- Створення скрипта для таблиць
function scripts_table (p_table_name varchar2) return clob;

-- Створення скрипта для кострейнтів по іменті таблмці
function scripts_constraintFK (p_owner varchar2, p_table_name varchar2 ) return clob;

-- Створення скрипта для індексів по іменті таблмці
function scripts_index (p_table_name varchar2) return clob;

-- Створення скрипта для trigger
function scripts_trigger (p_trigger_name varchar2, p_owner varchar2 default 'BARS') return clob;

-- Створення скрипта для view
function scripts_view (p_view_name varchar2, p_owner varchar2 default 'BARS') return clob;

-- Створення скрипта для procedure
function scripts_procedure (p_object_name varchar2, p_owner varchar2 default 'BARS') return clob;

-- Створення скрипта для sequence
function scripts_sequence (p_sequence_name varchar2, p_owner varchar2 default 'BARS') return clob;

-- Створення скрипта для грантів по імені таблиці (треба переробюить)
function scripts_grants (p_table_name varchar2, p_type number default 1, p_owner varchar2 default 'BARS') return clob;

-- Створення скрипта для АРМів в тому числі створення функцій
function scripts_arm (p_arm_code varchar2) return clob;

function scripts_err (p_mod varchar2) return clob;

Function Script_table_merge(p_table_name varchar2) return clob;

Function Script_table_insert(p_table_name varchar2, p_Select varchar2 default null, p_where_clause varchar2 default null, p_owner varchar2 default 'BARS') return clob;

function scripts_reports (p_rep_id number) return clob;

function scripts_bmd(p_table_name varchar2, p_file_name varchar2 ) return clob;

function scripts_tts(p_tt varchar2) return blob;


END PACK_SCRIPT;
/

CREATE OR REPLACE PACKAGE BODY SYS.PACK_SCRIPT
AS

function little_endian( p_big number, p_bytes pls_integer := 4 )
  return raw
  is
begin
    return utl_raw.substr( utl_raw.cast_from_binary_integer( p_big, utl_raw.little_endian ), 1, p_bytes );
end;

procedure add1file
    ( p_zipped_blob in out nocopy blob
    , p_name varchar2
    , p_content blob
    )
  is
    t_now date;
    t_blob blob;
    t_clen integer;
begin
    t_now := sysdate;
    t_blob := utl_compress.lz_compress( p_content );
    t_clen := dbms_lob.getlength( t_blob );
    if p_zipped_blob is null
    then
      dbms_lob.createtemporary( p_zipped_blob, true );
    end if;
    dbms_lob.append( p_zipped_blob
                   , utl_raw.concat( hextoraw( '504B0304' ) -- Local file header signature
                                   , hextoraw( '1400' )     -- version 2.0
                                   , hextoraw( '0000' )     -- no General purpose bits
                                   , hextoraw( '0800' )     -- deflate
                                   , little_endian( to_number( to_char( t_now, 'ss' ) ) / 2
                                                  + to_number( to_char( t_now, 'mi' ) ) * 32
                                                  + to_number( to_char( t_now, 'hh24' ) ) * 2048
                                                  , 2
                                                  ) -- File last modification time
                                   , little_endian( to_number( to_char( t_now, 'dd' ) )
                                                  + to_number( to_char( t_now, 'mm' ) ) * 32
                                                  + ( to_number( to_char( t_now, 'yyyy' ) ) - 1980 ) * 512
                                                  , 2
                                                  ) -- File last modification date
                                   , dbms_lob.substr( t_blob, 4, t_clen - 7 )         -- CRC-32
                                   , little_endian( t_clen - 18 )                     -- compressed size
                                   , little_endian( dbms_lob.getlength( p_content ) ) -- uncompressed size
                                   , little_endian( length( p_name ), 2 )             -- File name length
                                   , hextoraw( '0000' )                               -- Extra field length
                                   --, utl_raw.cast_to_raw( p_name )                    -- File name
								   ,utl_i18n.string_to_raw( p_name, 'RU8PC866' )   -- File name
                                   )
                   );
    dbms_lob.copy( p_zipped_blob, t_blob, t_clen - 18, dbms_lob.getlength( p_zipped_blob ) + 1, 11 ); -- compressed content
    dbms_lob.freetemporary( t_blob );
  end;
--
procedure finish_zip( p_zipped_blob in out nocopy blob )
  is
    t_cnt pls_integer := 0;
    t_offs integer;
    t_offs_dir_header integer;
    t_offs_end_header integer;
    t_comment raw(32767) := utl_raw.cast_to_raw( 'Zip-implementation by Unity-BARS ' );
begin
    t_offs_dir_header := dbms_lob.getlength( p_zipped_blob );
    t_offs := dbms_lob.instr( p_zipped_blob, hextoraw( '504B0304' ), 1 );
    while t_offs > 0
    loop
      t_cnt := t_cnt + 1;
      dbms_lob.append( p_zipped_blob
                     , utl_raw.concat( hextoraw( '504B0102' )      -- Central directory file header signature
                                     , hextoraw( '1400' )          -- version 2.0
                                     , dbms_lob.substr( p_zipped_blob, 26, t_offs + 4 )
                                     , hextoraw( '0000' )          -- File comment length
                                     , hextoraw( '0000' )          -- Disk number where file starts
                                     , hextoraw( '0100' )          -- Internal file attributes
                                     , hextoraw( '2000B681' )      -- External file attributes
                                     , little_endian( t_offs - 1 ) -- Relative offset of local file header
                                     , dbms_lob.substr( p_zipped_blob
                                                      , utl_raw.cast_to_binary_integer( dbms_lob.substr( p_zipped_blob, 2, t_offs + 26 ), utl_raw.little_endian )
                                                      , t_offs + 30
                                                      )            -- File name
                                     )
                     );
      t_offs := dbms_lob.instr( p_zipped_blob, hextoraw( '504B0304' ), t_offs + 32 );
    end loop;
    t_offs_end_header := dbms_lob.getlength( p_zipped_blob );
    dbms_lob.append( p_zipped_blob
                   , utl_raw.concat( hextoraw( '504B0506' )                                    -- End of central directory signature
                                   , hextoraw( '0000' )                                        -- Number of this disk
                                   , hextoraw( '0000' )                                        -- Disk where central directory starts
                                   , little_endian( t_cnt, 2 )                                 -- Number of central directory records on this disk
                                   , little_endian( t_cnt, 2 )                                 -- Total number of central directory records
                                   , little_endian( t_offs_end_header - t_offs_dir_header )    -- Size of central directory
                                   , little_endian( t_offs_dir_header )                        -- Relative offset of local file header
                                   , little_endian( nvl( utl_raw.length( t_comment ), 0 ), 2 ) -- ZIP file comment length
                                   , t_comment
                                   )
                   );
end;
procedure add_file
    ( p_arh in out nocopy blob
    , p_filename varchar2
    , p_file clob
    )
  is
    t_tmp blob;
begin
    dbms_lob.createtemporary( t_tmp, true );
    for i in 0 .. trunc( length( p_file ) / 4000 )
    loop
      dbms_lob.append( t_tmp, utl_i18n.string_to_raw( substr( p_file, i * 4000 + 1, 4000 ), 'CL8MSWIN1251' ) );
	  --dbms_lob.append( t_tmp, utl_i18n.string_to_raw( substr( p_file, i * 4000 + 1, 4000 ), 'AL32UTF8' ) );
    end loop;
    add1file( p_arh, p_filename, t_tmp );
    dbms_lob.freetemporary( t_tmp );
end;


function load_owner_zip (  p_owner varchar2 default 'BARS', p_object_name varchar2 default '%', p_object_type varchar2 default '%' )
 return blob
as
  p_filename varchar2(200);
  l_scripts clob;
  l_scripts2 blob;
  l_clob blob;
  l_clob_all blob;
  t_fh utl_file.file_type;
  t_len pls_integer :=4000;
  i int := 0;
begin
      dbms_lob.createtemporary( l_clob_all, false  );
      dbms_lob.createtemporary( l_clob, false  );

 for x in (
      select '/Sql/'||p_owner||'/'||lower(object_type)||'/'||'' dir, lower(object_name)||'.sql'  file_name, object_type, object_name, owner
        FROM ALL_OBJECTS
       where  owner =  p_owner
	    and   object_name like  p_object_name
		and   object_type like  p_object_type
        and  object_type in ('VIEW' ,'TABLE', 'TRIGGER', 'FUNCTION', 'PACKAGE','PROCEDURE','SEQUENCE','TYPE','SYNONYM','PUBLIC','SCHEDULE','JOB')
		and  generated != 'Y'
        and object_name not like '%ASVO%'
        and object_name not like '%TEST%'
        and object_name not like 'TMP%201%'
        order by object_type, object_name )
    LOOP
        begin
         l_scripts :=  case   when x.object_type = 'TABLE'       then  PACK_SCRIPT.SCRIPTS_TABLE_ALL(x.object_name,x.owner)
                              when x.object_type = 'VIEW'        then  PACK_SCRIPT.scripts_view(x.object_name,x.owner)
                              when x.object_type = 'TRIGGER'     then  PACK_SCRIPT.scripts_trigger(x.object_name,x.owner)
                              when x.object_type = 'PROCEDURE'   then  PACK_SCRIPT.scripts_procedure(x.object_name,x.owner)
                              when x.object_type = 'SEQUENCE'    then  PACK_SCRIPT.scripts_sequence(x.object_name,x.owner)
                                                                 else  PACK_SCRIPT.scripts_all(x.object_name, x.object_type, x.owner)
                         end;
           exception when others then l_scripts := null;
         END;


          CONTINUE WHEN l_scripts IS NULL;

          BEGIN

                 dbms_application_info.set_client_info (p_owner||' Формування - '||x.object_type||' : '||upper(x.file_name)||' Count='||i);
                 --dbms_lob.createtemporary( l_clob, true );
                 --dbms_output.put_line('add_file = '||x.object_type||'/'||x.file_name);
				 --show err;
                 add_file(l_clob_all, p_owner||'/'||initcap(x.object_type)||'/'||x.file_name, l_scripts );
          i := i +1;
          exception when others then NULL;
        END;


	   --  scripts_constraintFK
	    begin
         l_scripts :=  case   when x.object_type = 'TABLE'       then  PACK_SCRIPT.scripts_constraintFK(x.owner,x.object_name)
                                                                 else  null
                         end;
           exception when others then l_scripts := null;
         END;


          CONTINUE WHEN l_scripts IS NULL;

          BEGIN

                 dbms_application_info.set_client_info (p_owner||' Формування - '||'ForeignKey'||' : '||upper(x.file_name)||' Count='||i);
                 add_file(l_clob_all, p_owner||'/'||'ForeignKey'||'/'||x.file_name, l_scripts );
          i := i +1;
          exception when others then NULL;
        END;


    END LOOP;

         dbms_lob.freetemporary( l_clob );

 if p_owner = 'BARS' then

    --- meta_tables
       dbms_lob.createtemporary( l_clob, false );
    for x in (
      select tabname from bars.meta_tables where tabname = upper(tabname)  and tabname like p_object_name and 'BMD' like  p_object_type)
    LOOP
        begin
         l_scripts :=     PACK_SCRIPT.scripts_bmd(x.tabname, lower(x.tabname||'.bmd'));
           exception when others then l_scripts := null;
         END;


          CONTINUE WHEN l_scripts IS NULL;

        BEGIN

                 dbms_application_info.set_client_info (p_owner||' Формування - '||upper(lower(x.tabname||'.bmd'))||' Count='||i);
                 --dbms_lob.createtemporary( l_clob, true );
                 add_file(l_clob_all, p_owner||'/Data/bmd'||chr(47)||lower(x.tabname||'.bmd'), l_scripts );
                 i := i +1;
          exception when others then NULL;
        END;
    END LOOP;

           dbms_lob.freetemporary( l_clob );
    ---      TTS
       dbms_lob.createtemporary( l_clob, false  );
    for x in (
      select tt from bars.tts where tt like p_object_name and 'TTS' like  p_object_type)
    LOOP
        begin
         l_scripts2 :=     PACK_SCRIPT.scripts_tts(x.tt);
           exception when others then l_scripts2 := null;
         END;


          CONTINUE WHEN l_scripts2 IS NULL;

          BEGIN

                 dbms_application_info.set_client_info (p_owner||' Формування - '||upper(lower('et_'||lower(x.tt||'.sql')))||' Count='||i);
                 --dbms_lob.createtemporary( l_clob, true );
                 add1file(l_clob_all, p_owner||'/Data/tts'||'/'||'et_'||x.tt||'.sql', l_scripts2 );
         i := i +1;
          exception when others then NULL;
        END;



    END LOOP;
  --  ERR
          dbms_lob.createtemporary( l_clob, false  );
         for x in (       Select *
							from BARS.ERR_MODULES
						   where errmod_code like p_object_name
						     and 'ERR'       like p_object_type
						  )
		 loop

				         begin
						   l_scripts :=     Pack_script.scripts_err(x.errmod_code);
						   exception when others then l_scripts := null;
						 END;


						CONTINUE WHEN l_scripts IS NULL;

						BEGIN

								 dbms_application_info.set_client_info (p_owner||' Формування - '||upper(lower('mod_'||x.errmod_code||'.sql'))||' Count='||i);
							     add_file(l_clob_all, p_owner||'/Data/Error'||chr(47)||lower('mod_'||x.errmod_code||'.sql'), l_scripts );
								 i := i +1;
						  exception when others then NULL;
						END;

		end loop;
      dbms_lob.freetemporary( l_clob );

	    ---      CODEAPP
       dbms_lob.createtemporary( l_clob, false  );
    for x in (
      select codeapp from bars.applist where  codeapp like p_object_name and 'CODEAPP' like  p_object_type)
    LOOP
        begin
         l_scripts :=     PACK_SCRIPT.scripts_arm(x.codeapp);
           exception when others then l_scripts := null;
         END;


          CONTINUE WHEN l_scripts IS NULL;

          BEGIN

                 dbms_application_info.set_client_info (p_owner||' Формування - '||upper(lower('codeapp_'||lower(x.codeapp||'.sql')))||' Count='||i);
                 --dbms_lob.createtemporary( l_clob, true );
                 add_file(l_clob_all, p_owner||'/Data/Applist'||'/'||'codeapp_'||x.codeapp||'.sql', l_scripts);
         i := i +1;
          exception when others then NULL;
        END;



    END LOOP;
      dbms_lob.freetemporary( l_clob );



 end if;

     --dbms_lob.freetemporary( l_clob );

     if i = 0 then return null;
              else
                  finish_zip(l_clob_all);
                  return  l_clob_all;
     end if;

end;


function load_object_zip (   l_object_name varchar2 default 'FIN%',
                             l_object_type varchar2 default 'PACKAGE')
 return blob
as
  p_filename varchar2(200);
  l_scripts clob;
  l_clob blob;
  l_clob_all blob;
  t_fh utl_file.file_type;
  t_len pls_integer :=4000;
  i int := 0;
begin


for x in (
      select '/Sql/Bars/'||lower(object_type)||'/'||'' dir, lower(object_name)||'.sql'  file_name, object_type, object_name
        FROM ALL_OBJECTS
       where  object_name like l_object_name
         and  object_type like l_object_type
         and  object_type in ('VIEW' ,'TABLE', 'TRIGGER', 'FUNCTION', 'PACKAGE','PROCEDURE','SEQUENCE')
         and  owner = 'BARS'
         and  generated != 'Y'
        order by object_type, object_name )
LOOP
    begin
     l_scripts :=  case   when x.object_type = 'TABLE'       then  PACK_SCRIPT.SCRIPTS_TABLE_ALL(x.object_name)
                          when x.object_type = 'VIEW'        then  PACK_SCRIPT.scripts_view(x.object_name)
                          when x.object_type = 'TRIGGER'     then  PACK_SCRIPT.scripts_trigger(x.object_name)
                          when x.object_type = 'PROCEDURE'   then  PACK_SCRIPT.scripts_procedure(x.object_name)
                          when x.object_type = 'SEQUENCE'    then  PACK_SCRIPT.scripts_sequence(x.object_name)
                                                             else  PACK_SCRIPT.scripts_all(x.object_name, x.object_type)
                     end;
       exception when others then l_scripts := null;
     END;


      CONTINUE WHEN l_scripts IS NULL;

      BEGIN

             dbms_application_info.set_client_info ('Формування - '||upper(x.file_name)||' count = '||i);
             dbms_lob.createtemporary( l_clob, true );
             dbms_output.put_line('add_file = '||l_object_type||'/'||x.file_name);
             add_file(l_clob_all, l_object_type||'/'||x.file_name, l_scripts );
             i := i +1;
      exception when others then NULL;
    END;

    dbms_lob.freetemporary( l_clob );


END LOOP;
     if i = 0 then return null;
              else
                  finish_zip(l_clob_all);
                  return  l_clob_all;
     end if;

end;

function load_bmd_zip (   l_object_name varchar2 default '%')
 return blob
as
  p_filename varchar2(200);
  l_scripts clob;
  l_clob blob;
  l_clob_all blob;
  t_fh utl_file.file_type;
  t_len pls_integer :=4000;
  i int := 0;
begin


for x in (
      select tabname from bars.meta_tables where tabname like l_object_name and tabname = upper(tabname) )
LOOP
    begin
     l_scripts :=     PACK_SCRIPT.scripts_bmd(x.tabname, lower(x.tabname||'.bmd'));
       exception when others then l_scripts := null;
     END;


      CONTINUE WHEN l_scripts IS NULL;

      BEGIN

             dbms_application_info.set_client_info ('Формування - '||upper(lower(x.tabname||'.bmd')));
             dbms_lob.createtemporary( l_clob, true );
             add_file(l_clob_all, 'BMD'||'/'||lower(x.tabname||'.bmd'), l_scripts );

      exception when others then NULL;
    END;

    dbms_lob.freetemporary( l_clob );
    i := i +1;

END LOOP;
     if i = 0 then return null;
              else
                  finish_zip(l_clob_all);
                  return  l_clob_all;
     end if;

end;

function load_tts_zip (   l_object_name varchar2 default '%')
 return blob
as
  p_filename varchar2(200);
  l_scripts blob;
  l_clob blob;
  l_clob_all blob;
  t_fh utl_file.file_type;
  t_len pls_integer :=4000;
  i int := 0;
begin


for x in (
      select tt from bars.tts where tt like l_object_name)
LOOP
    begin
     l_scripts :=     PACK_SCRIPT.scripts_tts(x.tt);
       exception when others then l_scripts := null;
     END;


      CONTINUE WHEN l_scripts IS NULL;

      BEGIN

             dbms_application_info.set_client_info ('Формування - '||upper(lower('et_'||lower(x.tt||'.sql'))));
             dbms_lob.createtemporary( l_clob, true );
             add1file(l_clob_all, 'TTS'||'/'||'et_'||lower(x.tt||'.sql'), l_scripts );

      exception when others then NULL;
    END;

    dbms_lob.freetemporary( l_clob );
    i := i +1;

END LOOP;
     if i = 0 then return null;
              else
                  finish_zip(l_clob_all);
                  return  l_clob_all;
     end if;

end;


function load_arm_zip (l_app_name varchar2 default '%')
 return blob
as
  p_filename varchar2(200);
  l_scripts clob;
  l_clob blob;
  l_clob_all blob;
  t_fh utl_file.file_type;
  t_len pls_integer :=4000;
  i int := 0;
begin


for x in (
      select codeapp from bars.applist where codeapp like l_app_name)
LOOP
    begin
       l_scripts :=     PACK_SCRIPT.scripts_arm(x.codeapp);
       exception when others then l_scripts := null;
     END;


      CONTINUE WHEN l_scripts IS NULL;

      BEGIN

             dbms_application_info.set_client_info ('Формування - '||upper(lower('app_'||lower(x.codeapp||'.sql'))));
             dbms_lob.createtemporary( l_clob, true );
             add_file(l_clob_all, 'CODEAPP'||'/'||'app_'||lower(x.codeapp||'.sql'), l_scripts );

      exception when others then NULL;
    END;

    dbms_lob.freetemporary( l_clob );
    i := i +1;

END LOOP;
     if i = 0 then return null;
              else
                  finish_zip(l_clob_all);
                  return  l_clob_all;
     end if;

end;

 function scripts_all (p_object_name varchar2, p_object_type varchar2, p_owner varchar2 default 'BARS') return clob
 as
       nlchr      char(2) := chr(10);
       l_txt      varchar2(32000);

       l_clob     clob;
       p_clob_scrpt clob;
       l_text1 varchar2(4000);
 begin

  begin
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'DEFAULT', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'STORAGE',false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'TABLESPACE',true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'SEGMENT_ATTRIBUTES', true);
    --dbms_metadata.set_transform_param (dbms_metadata.session_transform,'REF_CONSTRAINTS', false);
    --dbms_metadata.set_transform_param (dbms_metadata.session_transform,'CONSTRAINTS', false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'CONSTRAINTS_AS_ALTER', true);
    dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'SQLTERMINATOR', true );
 end;
        p_clob_scrpt:= null;   l_clob:= null;
       dbms_lob.createtemporary(l_clob,  FALSE);




   -- Створення індексів
   for x in (
         SELECT   object_name, object_type,
                    DBMS_METADATA.GET_DDL(object_type     => object_type,
                                                     name            => object_name,
                                                     schema          => owner,
                                                     version         => 'COMPATIBLE',
                                                     model           => 'ORACLE',
                                                     transform       => 'DDL')    as scripts
     FROM  ALL_OBJECTS where object_type not like '%BODY' and object_name like p_object_name and object_type = p_object_type and owner = p_owner
     )
     loop
     dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
     dbms_lob.append(l_clob,          rpad('PROMPT *** Run *** ========== Scripts /Sql/'||p_owner||'/'||lower(x.object_type) ||'/'||lower(x.object_name)||'.sql'||' =========*** Run *** ',92,'=') ||nlchr);
     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);


         p_clob_scrpt:=  replace(x.scripts,'"'||p_owner||'"."'||x.object_name||'"',p_owner||'.'||x.object_name); --x.scripts ;

     dbms_lob.append(l_clob, p_clob_scrpt||nlchr);
     dbms_lob.append(l_clob, 'show err;'||nlchr);
     dbms_lob.append(l_clob, scripts_grants(x.object_name,0, p_owner)||nlchr);

    dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
    dbms_lob.append(l_clob,       rpad(   'PROMPT *** End *** ========== Scripts /Sql/'||p_owner||'/'||lower(x.object_type)||'/'||lower(x.object_name)||'.sql'||' =========*** End *** ',92,'=') ||nlchr);
    dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);

     end loop;


     return l_clob;
exception
      when others then

        -- произошли ошибки
          dbms_lob.append(l_clob,  sqlerrm || chr(10) || dbms_utility.format_call_stack());
          return l_clob;
 end;


-- Створення скрипта для таблиць table,constrraint, index, grants
function scripts_table_all (p_table_name varchar2, p_owner varchar2 default 'BARS')  return clob
 as
       nlchr2     char(2) := chr(13)||chr(10);
       nlchr      char(2) := chr(13)||chr(10);
       l_txt      varchar2(32000);

       l_clob     clob;
       p_clob_scrpt clob;
       l_text1 varchar2(4000);
 begin

  begin
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'DEFAULT', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'STORAGE',false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'TABLESPACE',true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'SEGMENT_ATTRIBUTES', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'REF_CONSTRAINTS', false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'CONSTRAINTS', false);
    dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'SQLTERMINATOR', false );
 end;
        p_clob_scrpt:= null;   l_clob:= null;
       dbms_lob.createtemporary(l_clob,  FALSE);

     dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
     dbms_lob.append(l_clob,          rpad('PROMPT *** Run *** ========== Scripts /Sql/'||p_owner||'/Table/'||p_table_name||'.sql'||' =========*** Run *** ',92,'=') ||nlchr);
     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);

    --Опис політик
  if p_owner = 'BARS' then

                dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT *** ALTER_POLICY_INFO to '||p_table_name||' ***' ||nlchr);
             for x in (
                   select policy_group,
                          nvl2(select_policy,''''''||select_policy||'''''','null') select_policy,
                          nvl2(insert_policy,''''''||insert_policy||'''''','null') insert_policy,
                          nvl2(update_policy,''''''||update_policy||'''''','null') update_policy,
                          nvl2(delete_policy,''''''||delete_policy||'''''','null') delete_policy
                          from bars.policy_table where table_name = p_table_name
                     )
               loop

                   l_text1 := l_text1|| ' bpa.alter_policy_info('''''||p_table_name||''''', '''''||x.policy_group||''''' , '||x.select_policy ||', '||x.insert_policy ||', '||x.update_policy  ||', '||x.delete_policy ||');'||nlchr||'              ';


               end loop;


                  dbms_lob.append(l_clob, nlchr||nlchr||
                   'BEGIN '||nlchr||
                --   '    if getglobaloption(''HAVETOBO'') = 2 then '||nlchr||
                   '        execute immediate  '||nlchr||
                   '          ''begin  '||nlchr||
                   '              '||l_text1||' null;'||nlchr||
                   '           end; '||nlchr||
                   '          ''; '||nlchr||
               --    '     end if; '||nlchr||
                   'END; '||nlchr||
                   '/');
    end if;



   -- Створення таблиці
    dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT *** Create  table '||p_table_name||' ***' ||nlchr);

    SELECT    replace(DBMS_METADATA.GET_DDL(        object_type     => 'TABLE',
                                                    name            => table_name,
                                                    schema          => owner,
                                                    version         => 'COMPATIBLE',
                                                    model           => 'ORACLE',
                                                    transform       => 'DDL') ,'"','')  as scripts
     into  p_clob_scrpt
     FROM ALL_TABLES where table_name like p_table_name and owner = p_owner;


       p_clob_scrpt := (replace((p_clob_scrpt), chr(39), chr(39)||chr(39)));

       p_clob_scrpt :=  replace ( p_clob_scrpt, chr(13)||chr(10), nlchr );

       p_clob_scrpt :=  'begin '||nlchr||
                        '  execute immediate '''||replace ( p_clob_scrpt, nlchr, '''||'||nlchr||'                           ''' )||''';'||nlchr||
                        'exception when others then       '||nlchr||
                        '  if sqlcode=-955 then null; else raise; end if; '||nlchr||
                        'end; '||nlchr||
                        '/'||nlchr||nlchr;

     dbms_lob.append(l_clob, p_clob_scrpt||nlchr);

   -- Приміняємо політики
    if p_owner = 'BARS' then
     dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT *** ALTER_POLICIES to '||p_table_name||' ***' ||nlchr);
     dbms_lob.append(l_clob, ' exec bpa.alter_policies('''||p_table_name||''');'||nlchr||nlchr||nlchr);
    end if;

     -- Коменнтар таблиці
     for x in (
      select 'COMMENT ON TABLE '||owner||'.'||table_name||' IS '''||comments ||''';' as scripts from ALL_TAB_COMMENTS where table_name = p_table_name AND OWNER = p_owner
              )
     LOOP
     dbms_lob.append(l_clob, x.scripts||nlchr);
     END LOOP;


     --Коменнтар полів
      for x in (
      select table_name, 'COMMENT ON COLUMN '||owner||'.'||table_name||'.'||column_name ||' IS '''||comments ||''';' as scripts   from ALL_COL_COMMENTS where table_name = p_table_name AND OWNER = p_owner
              )
     LOOP
         dbms_lob.append(l_clob, x.scripts||nlchr);
     END LOOP;

      dbms_lob.append(l_clob,  nlchr||nlchr);


  -- Створення констрейнтів
   for x in (
       select constraint_name,   replace(DBMS_METADATA.GET_DDL(   object_type     => case when constraint_type ='R' then 'REF_CONSTRAINT' else 'CONSTRAINT' end,
                                    name            => constraint_name,
                                    schema          => owner,
                                    version         => 'COMPATIBLE',
                                    model           => 'ORACLE',
                                    transform       => 'DDL') ,'"','')  as scripts

        from ALL_CONSTRAINTS where table_name = p_table_name and owner = p_owner and  constraint_type != 'R'
        )
        Loop

         dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT *** Create  constraint '||x.constraint_name||' ***' ||nlchr);

         p_clob_scrpt := (replace((x.scripts), chr(39), chr(39)||chr(39)));


         p_clob_scrpt := 'begin   '||nlchr||
                         ' execute immediate '''||replace ( p_clob_scrpt, nlchr2, '''||'||nlchr||'                           ''' )||''';'||nlchr||
                         'exception when others then'||nlchr||
                         '  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;'||nlchr||
                        ' end;'||nlchr||
                        '/'||nlchr||nlchr;
         dbms_lob.append(l_clob, p_clob_scrpt||nlchr);
        end loop;




   -- Створення індексів
   for x in (
     select  index_name,  replace(DBMS_METADATA.GET_DDL(   object_type     => 'INDEX',
                                    name            => index_name,
                                    schema          => owner,
                                    version         => 'COMPATIBLE',
                                    model           => 'ORACLE',
                                    transform       => 'DDL') ,'"','')  as scripts
     from ALL_INDEXES where table_name = p_table_name and owner = p_owner
     )
     loop
         dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT *** Create  index '||x.index_name||' ***' ||nlchr);

         p_clob_scrpt := (replace((x.scripts), chr(39), chr(39)||chr(39)));

         p_clob_scrpt :=  replace ( p_clob_scrpt, chr(13)||chr(10), nlchr );

         p_clob_scrpt := 'begin   '||nlchr||
                         ' execute immediate '''||replace ( p_clob_scrpt, nlchr2, '''||'||nlchr||'                           ''' )||''';'||nlchr||
                         'exception when others then'||nlchr||
                         '  if  sqlcode=-955  then null; else raise; end if;'||nlchr||
                        ' end;'||nlchr||
                        '/'||nlchr||nlchr;
         dbms_lob.append(l_clob, p_clob_scrpt||nlchr);
     end loop;



       dbms_lob.append(l_clob, scripts_grants(p_table_name,0,p_owner)||nlchr);



     -- SYNONYM

     for x in (
       SELECT    replace(DBMS_METADATA.GET_DDL(    object_type     => 'SYNONYM',
                                                    name            => SYNONYM_name,
                                                    schema          => owner,
                                                    version         => 'COMPATIBLE',
                                                    model           => 'ORACLE',
                                                    transform       => 'DDL') ,'"','')  as scripts
     FROM ALL_SYNONYMS
     where table_name = p_table_name and  table_owner = p_owner
              )
     LOOP
     dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT *** Create SYNONYM  to '||p_table_name||' ***' ||nlchr);
     dbms_lob.append(l_clob, x.scripts||';'||nlchr);
     END LOOP;



    dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
    dbms_lob.append(l_clob,       rpad(   'PROMPT *** End *** ========== Scripts /Sql/'||p_owner||'/Table/'||p_table_name||'.sql'||' =========*** End *** ',92,'=') ||nlchr);
    dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);

     return l_clob;
 end;


function scripts_table (p_table_name varchar2) return clob
 as
       nlchr      char(2) := chr(13)||chr(10);
       l_txt      varchar2(32000);

       l_clob     clob;
       p_clob_scrpt clob;
       l_text1 varchar2(4000);
 begin

  begin
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'DEFAULT', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'STORAGE',false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'TABLESPACE',true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'SEGMENT_ATTRIBUTES', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'REF_CONSTRAINTS', false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'CONSTRAINTS', false);
    dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'SQLTERMINATOR', false );
 end;
        p_clob_scrpt:= null;   l_clob:= null;
       dbms_lob.createtemporary(l_clob,  FALSE);

     dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
     dbms_lob.append(l_clob,          rpad('PROMPT *** Run *** ========== Scripts /Sql/Bars/Table/'||p_table_name||'.sql'||' =========*** Run *** ',92,'=') ||nlchr);
     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);

    --Опис політик
    dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT *** ALTER_POLICY_INFO to '||p_table_name||' ***' ||nlchr);
 for x in (
       select policy_group,
              nvl2(select_policy,''''''||select_policy||'''''','null') select_policy,
              nvl2(insert_policy,''''''||insert_policy||'''''','null') insert_policy,
              nvl2(update_policy,''''''||update_policy||'''''','null') update_policy,
              nvl2(delete_policy,''''''||delete_policy||'''''','null') delete_policy
              from bars.policy_table where table_name = p_table_name
         )
   loop

       l_text1 := l_text1|| ' bpa.alter_policy_info('''''||p_table_name||''''', '''''||x.policy_group||''''' , '||x.select_policy ||', '||x.insert_policy ||', '||x.update_policy  ||', '||x.delete_policy ||');'||nlchr||'              ';


   end loop;


      dbms_lob.append(l_clob, nlchr||nlchr||
       'BEGIN '||nlchr||
    --   '    if getglobaloption(''HAVETOBO'') = 2 then '||nlchr||
       '        execute immediate  '||nlchr||
       '          ''begin  '||nlchr||
       '              '||l_text1||' '||nlchr||
       '           end; '||nlchr||
       '          ''; '||nlchr||
   --    '     end if; '||nlchr||
       'END; '||nlchr||
       '/');




   -- Створення таблиці
    dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT *** Create  table '||p_table_name||' ***' ||nlchr);

    SELECT    replace(DBMS_METADATA.GET_DDL(    object_type     => 'TABLE',
                                                    name            => table_name,
                                                    schema          => 'BARS',
                                                    version         => 'COMPATIBLE',
                                                    model           => 'ORACLE',
                                                    transform       => 'DDL') ,'"','')  as scripts
     into  p_clob_scrpt
     FROM USER_TABLES where table_name like p_table_name;


       p_clob_scrpt := (replace((p_clob_scrpt), chr(39), chr(39)||chr(39)));

       p_clob_scrpt :=  replace ( p_clob_scrpt, chr(13)||chr(10), nlchr );

       p_clob_scrpt :=  'begin '||nlchr||
                        '  execute immediate '''||replace ( p_clob_scrpt, nlchr, '''||'||nlchr||'                           ''' )||''';'||nlchr||
                        'exception when others then       '||nlchr||
                        '  if sqlcode=-955 then null; else raise; end if; '||nlchr||
                        'end; '||nlchr||
                        '/'||nlchr||nlchr;

     dbms_lob.append(l_clob, p_clob_scrpt||nlchr);

   -- Приміняємо політики
     dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT *** ALTER_POLICIES to '||p_table_name||' ***' ||nlchr);
    dbms_lob.append(l_clob, ' exec bpa.alter_policies('''||p_table_name||''');'||nlchr||nlchr||nlchr);

     -- Коменнтар таблиці
     for x in (
      select 'COMMENT ON TABLE '||owner||'.'||table_name||' IS '''||comments ||''';' as scripts from ALL_TAB_COMMENTS where table_name = p_table_name
              )
     LOOP
     dbms_lob.append(l_clob, x.scripts||nlchr);
     END LOOP;


     --Коменнтар полів
      for x in (
      select table_name, 'COMMENT ON COLUMN '||owner||'.'||table_name||'.'||column_name ||' IS '''||comments ||''';' as scripts   from ALL_COL_COMMENTS where table_name = p_table_name
              )
     LOOP
         dbms_lob.append(l_clob, x.scripts||nlchr);
     END LOOP;

      dbms_lob.append(l_clob,  nlchr||nlchr);




    dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
    dbms_lob.append(l_clob,       rpad(   'PROMPT *** End *** ========== Scripts /Sql/Bars/Table/'||p_table_name||'.sql'||' =========*** End *** ',92,'=') ||nlchr);
    dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);

     return l_clob;
 end;

function scripts_constraintFK (p_owner varchar2, p_table_name varchar2 ) return clob
 as
       nlchr      char(2) := chr(13)||chr(10);
       l_txt      varchar2(32000);

       l_clob     clob;
       p_clob_scrpt clob;
       l_text1 varchar2(4000);
 begin

  begin
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'DEFAULT', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'STORAGE',false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'TABLESPACE',true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'SEGMENT_ATTRIBUTES', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'REF_CONSTRAINTS', false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'CONSTRAINTS', false);
 end;
        p_clob_scrpt:= null;   l_clob:= null;
       dbms_lob.createtemporary(l_clob,  FALSE);

     dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
     dbms_lob.append(l_clob,          rpad('PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/'||p_table_name||'.sql'||' =========*** Run *** ',92,'=') ||nlchr);
     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);


  -- Створення констрейнтів
   for x in (
       select constraint_name,   replace(DBMS_METADATA.GET_DDL(   object_type     => case when constraint_type ='R' then 'REF_CONSTRAINT' else 'CONSTRAINT' end,
                                    name            => constraint_name,
                                    schema          => 'BARS',
                                    version         => 'COMPATIBLE',
                                    model           => 'ORACLE',
                                    transform       => 'DDL') ,'"','')  as scripts
        from ALL_CONSTRAINTS where table_name like p_table_name and owner = p_owner and constraint_type = 'R'
        )
        Loop

         dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT *** Create  constraint '||x.constraint_name||' ***' ||nlchr);

         p_clob_scrpt := (replace((x.scripts), chr(39), chr(39)||chr(39)));


         p_clob_scrpt := 'begin   '||nlchr||
                         ' execute immediate '''||replace ( p_clob_scrpt, nlchr, '''||'||nlchr||'                           ''' )||''';'||nlchr||
                         'exception when others then'||nlchr||
                         '  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;'||nlchr||
                        ' end;'||nlchr||
                        '/'||nlchr||nlchr;
         dbms_lob.append(l_clob, p_clob_scrpt||nlchr);
        end loop;




    dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
    dbms_lob.append(l_clob,       rpad(   'PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/'||p_table_name||'.sql'||' =========*** End *** ',92,'=') ||nlchr);
    dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);

     return l_clob;
 end;



function scripts_index (p_table_name varchar2) return clob
 as
       nlchr      char(2) := chr(13)||chr(10);
       l_txt      varchar2(32000);

       l_clob     clob;
       p_clob_scrpt clob;
       l_text1 varchar2(4000);
 begin

  begin
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'DEFAULT', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'STORAGE',false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'TABLESPACE',true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'SEGMENT_ATTRIBUTES', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'REF_CONSTRAINTS', false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'CONSTRAINTS', false);

 end;
        p_clob_scrpt:= null;   l_clob:= null;
       dbms_lob.createtemporary(l_clob,  FALSE);

     dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
     dbms_lob.append(l_clob,          rpad('PROMPT *** Run *** ========== Scripts /Sql/Bars/index/'||p_table_name||'.sql'||' =========*** Run *** ',92,'=') ||nlchr);
     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);




   -- Створення індексів
   for x in (
     select  index_name,  replace(DBMS_METADATA.GET_DDL(   object_type     => 'INDEX',
                                    name            => index_name,
                                    schema          => 'BARS',
                                    version         => 'COMPATIBLE',
                                    model           => 'ORACLE',
                                    transform       => 'DDL') ,'"','')  as scripts
     from USER_INDEXES where table_name = p_table_name
     )
     loop
         dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT *** Create  index '||x.index_name||' ***' ||nlchr);

         p_clob_scrpt := (replace((x.scripts), chr(39), chr(39)||chr(39)));

         p_clob_scrpt :=  replace ( p_clob_scrpt, chr(13)||chr(10), nlchr );

         p_clob_scrpt := 'begin   '||nlchr||
                         ' execute immediate '''||replace ( p_clob_scrpt, nlchr, '''||'||nlchr||'                           ''' )||''';'||nlchr||
                         'exception when others then'||nlchr||
                         '  if  sqlcode=-955  then null; else raise; end if;'||nlchr||
                        ' end;'||nlchr||
                        '/'||nlchr||nlchr;
         dbms_lob.append(l_clob, p_clob_scrpt||nlchr);
     end loop;




    dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
    dbms_lob.append(l_clob,       rpad(   'PROMPT *** End *** ========== Scripts /Sql/Bars/index/'||p_table_name||'.sql'||' =========*** End *** ',92,'=') ||nlchr);
    dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);

     return l_clob;
 end;



function scripts_trigger (p_trigger_name varchar2, p_owner varchar2 default 'BARS') return clob
 as
       nlchr      char(2) := chr(13)||chr(10);
       l_txt      varchar2(32000);

       l_clob     clob;
       p_clob_scrpt clob;
       l_text1 varchar2(4000);
 begin

  begin
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'DEFAULT', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'STORAGE',false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'TABLESPACE',true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'SEGMENT_ATTRIBUTES', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'REF_CONSTRAINTS', false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'CONSTRAINTS', false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'SQLTERMINATOR', true);
 end;
        p_clob_scrpt:= null;   l_clob:= null;
       dbms_lob.createtemporary(l_clob,  FALSE);

     dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
     dbms_lob.append(l_clob,          rpad('PROMPT *** Run *** ========== Scripts /Sql/'||p_owner||'/Trigger/'||p_trigger_name||'.sql'||' =========*** Run *** ',92,'=') ||nlchr);
     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);




   -- Створення
   for x in (
     select  trigger_name,  DBMS_METADATA.GET_DDL(   object_type     => 'TRIGGER',
                                                               name            => trigger_name,
                                                               schema          => owner,
                                                               version         => 'COMPATIBLE',
                                                               model           => 'ORACLE',
                                                               transform       => 'DDL')  as scripts
     from ALL_TRIGGERS where trigger_name = p_trigger_name and owner = p_owner
     )
     loop
         dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT *** Create  trigger '||x.trigger_name||' ***' ||nlchr);

         p_clob_scrpt:=  replace(x.scripts,'"'||p_owner||'"."'||x.trigger_name||'"',p_owner||'.'||x.trigger_name); --x.scripts ;

         dbms_lob.append(l_clob, p_clob_scrpt||nlchr);
     end loop;




    dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
    dbms_lob.append(l_clob,       rpad(   'PROMPT *** End *** ========== Scripts /Sql/'||p_owner||'/Trigger/'||p_trigger_name||'.sql'||' =========*** End *** ',92,'=') ||nlchr);
    dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);

     return l_clob;
 end;




function scripts_view (p_view_name varchar2, p_owner varchar2 default 'BARS') return clob
 as
       nlchr      char(2) := chr(13)||chr(10);
       l_txt      varchar2(32000);

       l_clob     clob;
       p_clob_scrpt clob;
       l_text1 varchar2(4000);
 begin

  begin
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'DEFAULT', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'STORAGE',false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'TABLESPACE',true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'SEGMENT_ATTRIBUTES', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'REF_CONSTRAINTS', false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'CONSTRAINTS', false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'SQLTERMINATOR', true);
 end;
        p_clob_scrpt:= null;   l_clob:= null;
       dbms_lob.createtemporary(l_clob,  FALSE);

     dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
     dbms_lob.append(l_clob,          rpad('PROMPT *** Run *** ========== Scripts /Sql/'||p_owner||'/View/'||p_view_name||'.sql'||' =========*** Run *** ',92,'=') ||nlchr);
     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);




   -- Створення індексів
   for x in (
     select  view_name,  DBMS_METADATA.GET_DDL(            object_type         => 'VIEW',
                                                               name            =>  view_name,
                                                               schema          => owner,
                                                               version         => 'COMPATIBLE',
                                                               model           => 'ORACLE',
                                                               transform       => 'DDL')  as scripts
     from ALL_VIEWS where view_name = p_view_name and owner = p_owner
     )
     loop
         dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT *** Create  view '||x.view_name||' ***' ||nlchr);

         p_clob_scrpt:= replace(x.scripts,'"'||p_owner||'"."'||x.view_name||'"',p_owner||'.'||x.view_name); --x.scripts;

         dbms_lob.append(l_clob, p_clob_scrpt||nlchr);


         dbms_lob.append(l_clob, scripts_grants(x.view_name,0)||nlchr);
     end loop;







    dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
    dbms_lob.append(l_clob,       rpad(   'PROMPT *** End *** ========== Scripts /Sql/'||p_owner||'/View/'||p_view_name||'.sql'||' =========*** End *** ',92,'=') ||nlchr);
    dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);

     return l_clob;
 end;


function scripts_procedure (p_object_name varchar2, p_owner varchar2 default 'BARS') return clob
 as
       nlchr      char(2) := chr(13)||chr(10);
       l_txt      varchar2(32000);

       l_clob     clob;
       p_clob_scrpt clob;
       l_text1 varchar2(4000);
 begin

  begin

    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'DEFAULT', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'STORAGE',false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'TABLESPACE',true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'SEGMENT_ATTRIBUTES', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'REF_CONSTRAINTS', false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'CONSTRAINTS', false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'SQLTERMINATOR', true);
	--dbms_metadata.SET_REMAP_PARAM(dbms_metadata.SESSION_TRANSFORM,'REMAP_SCHEMA','BARS','');
	--DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'EMIT_SCHEMA',false);
	--DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'SEGMENT_CREATION',false);
	--dbms_metadata.set_transform_param (dbms_metadata.session_transform,'PRETTY', true);
 end;
        p_clob_scrpt:= null;   l_clob:= null;
       dbms_lob.createtemporary(l_clob,  FALSE);

     dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
     dbms_lob.append(l_clob,          rpad('PROMPT *** Run *** ========== Scripts /Sql/'||p_owner||'/Procedure/'||p_object_name||'.sql'||' =========*** Run *** ',92,'=') ||nlchr);
     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);




   -- Створення індексів
   for x in (
     select  object_name,  DBMS_METADATA.GET_DDL(          object_type     => 'PROCEDURE',
                                                               name            =>  object_name,
                                                               schema          =>  owner,
                                                               version         => 'COMPATIBLE',
                                                               model           => 'ORACLE',
                                                               transform       => 'DDL')  as scripts
     from ALL_PROCEDURES where object_name = p_object_name  and owner = p_owner
     )
     loop
         dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT *** Create  procedure '||x.object_name||' ***' ||nlchr);

         p_clob_scrpt:= replace(x.scripts,'"'||p_owner||'"."'||x.object_name||'"',p_owner||'.'||x.object_name);

         dbms_lob.append(l_clob, p_clob_scrpt||nlchr);
         dbms_lob.append(l_clob, 'show err;'||nlchr);
         dbms_lob.append(l_clob, scripts_grants(x.object_name,0)||nlchr);
     end loop;







    dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
    dbms_lob.append(l_clob,       rpad(   'PROMPT *** End *** ========== Scripts /Sql/'||p_owner||'/Procedure/'||p_object_name||'.sql'||' =========*** End *** ',92,'=') ||nlchr);
    dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);

     return l_clob;
 end;


 function scripts_sequence (p_sequence_name varchar2, p_owner varchar2 default 'BARS') return clob
 as
       nlchr      char(2) := chr(13)||chr(10);
       l_txt      varchar2(32000);

       l_clob     clob;
       p_clob_scrpt clob;
       l_text1 varchar2(4000);
 begin

  begin
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'DEFAULT', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'STORAGE',false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'TABLESPACE',true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'SEGMENT_ATTRIBUTES', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'REF_CONSTRAINTS', false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'CONSTRAINTS', false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'SQLTERMINATOR', true);
 end;
        p_clob_scrpt:= null;   l_clob:= null;
       dbms_lob.createtemporary(l_clob,  FALSE);

     dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
     dbms_lob.append(l_clob,          rpad('PROMPT *** Run *** ========== Scripts /Sql/'||p_owner||'/Sequence/'||p_sequence_name||'.sql'||' =========*** Run *** ',92,'=') ||nlchr);
     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);




   -- Створення
   for x in (
     select  sequence_name,  DBMS_METADATA.GET_DDL(         object_type     => 'SEQUENCE',
                                                               name            => sequence_name,
                                                               schema          => sequence_owner,
                                                               version         => 'COMPATIBLE',
                                                               model           => 'ORACLE',
                                                               transform       => 'DDL')  as scripts
     from ALL_SEQUENCES where sequence_name = p_sequence_name  and sequence_owner = p_owner
     )
     loop
         dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT *** Create  sequence '||x.sequence_name||' ***' ||nlchr);

         p_clob_scrpt:= replace(x.scripts,'"','');

         dbms_lob.append(l_clob, p_clob_scrpt||nlchr);
         dbms_lob.append(l_clob, scripts_grants(x.sequence_name,0)||nlchr);
     end loop;




    dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
    dbms_lob.append(l_clob,       rpad(   'PROMPT *** End *** ========== Scripts /Sql/'||p_owner||'/Sequence/'||p_sequence_name||'.sql'||' =========*** End *** ',92,'=') ||nlchr);
    dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);

     return l_clob;
 end;



function scripts_grants (p_table_name varchar2, p_type number default 1, p_owner varchar2 default 'BARS') return clob
 as
       nlchr      char(2) := chr(13)||chr(10);
       l_txt      varchar2(32000);

       l_clob     clob;
       p_clob_scrpt clob;
       l_text1 varchar2(4000);
       l_table_name USER_TAB_PRIVS_MADE.table_name%type;
 begin

  begin
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'DEFAULT', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'STORAGE',false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'TABLESPACE',true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'SEGMENT_ATTRIBUTES', true);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'REF_CONSTRAINTS', false);
    dbms_metadata.set_transform_param (dbms_metadata.session_transform,'CONSTRAINTS', false);
 end;
        p_clob_scrpt:= null;   l_clob:= null;
       dbms_lob.createtemporary(l_clob,  FALSE);
 case p_type when 1 then
     dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
     dbms_lob.append(l_clob,          rpad('PROMPT *** Run *** ========== Scripts /Sql/'||p_owner||'/grant/'||p_table_name||'.sql'||' =========*** Run *** ',92,'=') ||nlchr);
     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);
   else null;
end case;


  --dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT *** Create  grants  '||p_table_name||' ***' ||nlchr);
     for x in (
                select 'grant ' || rpad( privilege, GREATEST(length(privilege),70), ' ') || ' on ' || rpad( table_name, GREATEST(length(table_name),15), ' ')  ||
                      ' to ' || grantee ||
                      case when grantable = 'YES' then ' with grant option;'
                           else ';'
                      end as my_grant, table_name
                from (select table_name, grantee, grantable, max(privilege) privilege
                       from (
                        select table_name, grantee, grantable,
                                LISTAGG(privilege ,',') WITHIN GROUP (ORDER BY privilege)  as privilege
                           from DBA_TAB_PRIVS
                          where table_name  like p_table_name and owner = p_owner
                          group by table_name, grantee, grantable
                        order by table_name, grantee, grantable )
                      group by table_name, grantee, grantable
                       order by table_name )
               )
   loop
    case when x.table_name=l_table_name
       then null;
       else dbms_lob.append(l_clob, nlchr||'PROMPT *** Create  grants  '||x.table_name||' ***' ||nlchr);
    end case;

   dbms_lob.append(l_clob, x.my_grant||nlchr);
   l_table_name := x.table_name;
   end loop;


case p_type when 1 then
    dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
    dbms_lob.append(l_clob,       rpad(   'PROMPT *** End *** ========== Scripts /Sql/'||p_owner||'/grant/Grant/'||p_table_name||'.sql'||' =========*** End *** ',92,'=') ||nlchr);
    dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);
  else null;
end case;
     return l_clob;
 end;

function scripts_err (p_mod varchar2) return clob
 as
       nlchr      char(2) := chr(13)||chr(10);
       l_txt      varchar2(32000);

       l_clob     clob;
       p_clob_scrpt clob;
       l_text1 varchar2(4000);
       l_applist  bars.applist%rowtype;
       l_frontend varchar2(254);
	   l_i        pls_integer := 0;
	   l_err_modules BARS.ERR_MODULES%rowtype;
 begin

    p_clob_scrpt:= null;   l_clob:= null;
    dbms_lob.createtemporary(l_clob,  FALSE);

     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);
     dbms_lob.append(l_clob,          rpad('PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_'||p_mod||'.sql'||' =========*** Run *** ',92,'=') ||nlchr);
     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);


   begin
      Select *
	   into l_err_modules
	   from BARS.ERR_MODULES
	  where errmod_code = p_mod;
    exception when no_data_found then return null;
    End;

 dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT *** Create/replace ERR модуль '||p_mod||' ***' ||nlchr);
 l_txt := 'declare
  l_mod  varchar2(3) := '''||l_err_modules.errmod_code||''';
  l_rus  varchar2(3) := ''RUS'';
  l_ukr  varchar2(3) := ''UKR'';
  l_eng  varchar2(3) := ''ENG'';
  l_geo  varchar2(3) := ''GEO'';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '''||l_err_modules.errmod_name||''', 1);';

	 dbms_lob.append(l_clob, l_txt||nlchr);

    for x in (
	            select a.err_code, err_excpnum, 'l_'||lower(errlng_code) errlng_code, replace(err_msg,'''','''''') err_msg, replace(err_hlp,'''','''''') err_hlp, err_name
				  from BARS.ERR_CODES a
				  join BARS.ERR_TEXTS b on a.errmod_code = b.errmod_code and a.err_code = b.err_code
				 where a.errmod_code = l_err_modules.errmod_code
				 order by a.err_code, errlng_code
			 )
    LOOP
	if l_i != x.err_code
	      then  l_i := x.err_code ;
		        dbms_lob.append(l_clob, nlchr);
    end if;
	l_txt := '    bars_error.add_message(l_mod, '||x.err_code||', l_exc, '||x.errlng_code||', '''||x.err_msg||''', '''||x.err_hlp||''', 1, '''||x.err_name||''');';
    dbms_lob.append(l_clob, l_txt||nlchr);

	END LOOP;

l_txt := '  commit;
end;
/' ;
    dbms_lob.append(l_clob, l_txt||nlchr);

   dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);
   dbms_lob.append(l_clob,          rpad('PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_'||p_mod||'.sql'||' =========*** Run *** ',92,'=') ||nlchr);
   dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);

return  l_clob;

end;

function scripts_arm (p_arm_code varchar2) return clob
 as
       nlchr      char(2) := chr(13)||chr(10);
       l_txt      varchar2(32000);

       l_clob     clob;
       p_clob_scrpt clob;
       l_text1 varchar2(4000);
       l_applist  bars.applist%rowtype;
       l_frontend varchar2(254);
	   l_i        pls_integer := 0;
 begin

        p_clob_scrpt:= null;   l_clob:= null;
       dbms_lob.createtemporary(l_clob,  FALSE);

     --dbms_lob.append(l_clob,               'SET SERVEROUTPUT ON ' ||nlchr);
	 --dbms_lob.append(l_clob,               'SET DEFINE OFF ' ||nlchr);
     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);
     dbms_lob.append(l_clob,          rpad('PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_'||p_arm_code||'.sql'||' =========*** Run *** ',92,'=') ||nlchr);
     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);



 dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT *** Create/replace  ARM  '||p_arm_code||' ***' ||nlchr);

   select * into l_applist from bars.applist where codeapp = p_arm_code;

   case  l_applist.frontend
              when 0 then l_frontend := 'user_menu_utl.APPLICATION_TYPE_CENTURA';
              when 1 then l_frontend := 'user_menu_utl.APPLICATION_TYPE_WEB';
              when 2 then l_frontend := 'user_menu_utl.APPLICATION_TYPE_WEB';
              else        l_frontend := 'user_menu_utl.APPLICATION_TYPE_WEB';
   end case;

l_text1 :=
'  declare
    l_application_code varchar2(10 char) := '''|| l_applist.codeapp ||''';
    l_application_name varchar2(300 char) := '''||l_applist.name ||''';
    l_application_type_id integer := '|| l_frontend  ||';
    l_function_ids number_list := number_list();
    l_function_codeoper     OPERLIST.CODEOPER%type;
    l_function_deps         OPERLIST.CODEOPER%type;
    l_application_id integer;
    l_role_resource_type_id integer := resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE);
    l_arm_resource_type_id  integer := resource_utl.get_resource_type_id(user_menu_utl.get_arm_resource_type_code(l_application_type_id));
    l_func_resource_type_id integer := resource_utl.get_resource_type_id(user_menu_utl.get_func_resource_type_code(l_application_type_id));
    l integer := 0;
	d integer := 0;
begin
     DBMS_OUTPUT.PUT_LINE('' '||l_applist.codeapp||' створюємо (або оновлюємо) АРМ '||l_applist.name ||' '');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); ';


   dbms_lob.append(l_clob, l_text1||nlchr);
   l_text1 := null;


   for x in ( select * from bars.operlist where codeoper in (
                    Select codeoper from bars.operapp where codeapp = l_applist.codeapp)
                    order by funcname
            )
    loop
	 l_i := l_i + 1;
     l_text1 :=
'    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||'' ********** Створюємо функцію '|| x.name  ||' ********** '');
          --  Створюємо функцію '|| x.name  ||'
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '''||x.name ||''',
                                                  p_funcname => '''||(replace((x.funcname), chr(39), chr(39)||chr(39))) ||''',
                                                  p_rolename => '''|| x.rolename ||''' ,
                                                  p_frontend => l_application_type_id
                                                  );

';

   if l_i = 0
      then return null;
   end if;

   dbms_lob.append(l_clob, l_text1||nlchr);
   l_text1 := null;



	    for c0 in ( select distinct o.*
					 from bars.operlist_deps d, bars.operlist o
					 where id_parent = x.codeoper
					   and d.id_child = o.codeoper)
       LOOP
	    l_text1 :=
'      --  Створюємо дочірню функцію '|| c0.name  ||'
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '''||c0.name ||''',
															  p_funcname => '''||(replace((c0.funcname), chr(39), chr(39)||chr(39))) ||''',
															  p_rolename => '''|| c0.rolename ||''' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);
';
   dbms_lob.append(l_clob, l_text1||nlchr);
   l_text1 := null;

	   END LOOP;
  end loop;


    l_text1 :=
'   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||''  Прикріпляємо ресурси функцій до даного АРМу ('||l_applist.codeapp||') - '||l_applist.name ||'  '');
    l := l_function_ids.first;
    while (l is not null and l_function_ids(l)  is not null) loop
        resource_utl.set_resource_access_mode(l_arm_resource_type_id, l_application_id, l_func_resource_type_id, l_function_ids(l), 1);
        l := l_function_ids.next(l);
    end loop;


    DBMS_OUTPUT.PUT_LINE('' Bидані функції можливо потребують підтвердження - автоматично підтверджуємо їх '');
    for i in (select a.id
              from   adm_resource_activity a
              where  a.grantee_type_id = l_arm_resource_type_id and
                     a.resource_type_id = l_func_resource_type_id and
                     a.grantee_id = l_application_id and
                     a.resource_id in (select column_value from table(l_function_ids))  and
                     a.access_mode_id = 1 and
                     a.resolution_time is null) loop
        resource_utl.approve_resource_access(i.id, ''Автоматичне підтвердження прав на функції для АРМу'');
    end loop;
     DBMS_OUTPUT.PUT_LINE('' Commit;  '');
   commit;';
   dbms_lob.append(l_clob, l_text1||nlchr);
   l_text1 := null;

   for k in (   Select codeapp, coderep
				  from bars.app_rep p
				 where codeapp = l_applist.codeapp
				   and approve = 1
			 )
   loop

   l_text1 := 'umu.add_report2arm('||k.coderep||','''||k.codeapp||''');';
   dbms_lob.append(l_clob, l_text1||nlchr);
   l_text1 := null;
   end loop;

   l_text1 := 'commit;';
   dbms_lob.append(l_clob, l_text1||nlchr);
   l_text1 := null;


l_text1:= 'end;
/';


   dbms_lob.append(l_clob, l_text1||nlchr);
   l_text1 := null;

    dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
    dbms_lob.append(l_clob,       rpad(   'PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp'||p_arm_code||'.sql'||' =========*** End *** ',92,'=') ||nlchr);
    dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);

     return l_clob;
 end;

Function Script_table_merge(p_table_name varchar2) return clob
as
  cur SYS_REFCURSOR;
  curid NUMBER;
  desctab DBMS_SQL.desc_tab;
  colcnt NUMBER;
  namevar VARCHAR2(4000);
  numvar NUMBER;
  datevar DATE;
  nlchr      char(2) := chr(13)||chr(10);

  l_clob     clob;
  p_clob_scrpt clob;

  out_columns clob;
  out_values  clob;

BEGIN
        p_clob_scrpt:= null;
        l_clob:= null;
       dbms_lob.createtemporary(l_clob,  FALSE);

  FOR rec IN (SELECT table_name , owner
                FROM all_tables
               WHERE table_name LIKE p_table_name
               ORDER BY table_name)
  LOOP


       dbms_lob.append(l_clob, ''||nlchr);
    OPEN cur FOR 'SELECT * FROM '||rec.owner||'.'||rec.table_name||'  ORDER BY 1';


   out_columns  := null;
   out_values   := null;
    curid := DBMS_SQL.to_cursor_number(cur);
    DBMS_SQL.describe_columns(curid, colcnt, desctab);

     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);
     dbms_lob.append(l_clob,          rpad('PROMPT *** Run *** ========== Scripts /Sql/'||rec.owner||'/Data/patch_data_'||rec.table_name||'.sql'||' =========*** Run *** ',92,'=') ||nlchr);
     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr||nlchr);

    out_columns := l_clob||'declare'||nlchr;
    out_columns :=out_columns||'l_'||rec.table_name||'  '||rec.table_name||'%rowtype;'||nlchr||nlchr;
    out_columns :=out_columns||'procedure p_merge(p_'||rec.table_name||' '||rec.table_name||'%rowtype';
    out_columns :=out_columns||') '||nlchr||'as'||nlchr;
    out_columns :=out_columns||'Begin'||nlchr;
    out_columns :=out_columns||'   insert into '||rec.table_name||nlchr;
    out_columns :=out_columns||'      values p_'||rec.table_name||'; '||nlchr;
    out_columns :=out_columns||' exception when dup_val_on_index then  '||nlchr;
    out_columns :=out_columns||'   update '||rec.table_name||nlchr;
    out_columns :=out_columns||'      set row = p_'||rec.table_name||nlchr;

    for x in (select p.column_name, position rw, lead(nlchr)  over (ORDER BY position ) as nlchr_
                from all_constraints c, all_CONS_COLUMNS p
               where c.constraint_type='P'
                 and c.constraint_name = p.constraint_name
                 and c.table_name like rec.table_name
               order by c.table_name, position )
  LOOP
     if x.rw = 1 then out_columns :=out_columns||'    where '||x.column_name||' = p_'||rec.table_name||'.'||x.column_name||x.nlchr_;
                 else out_columns :=out_columns||'      and '||x.column_name||' = p_'||rec.table_name||'.'||x.column_name||x.nlchr_;
      end if;
  end loop;

    out_columns :=out_columns||';'||nlchr;
    out_columns :=out_columns||'End;'||nlchr;

    out_columns :=out_columns||'Begin'||nlchr||nlchr;




    FOR indx IN 1 .. colcnt LOOP
      IF desctab (indx).col_type = dbms_types.TYPECODE_NUMBER       THEN      DBMS_SQL.define_column (curid, indx, numvar);
      ELSIF desctab (indx).col_type = dbms_types.TYPECODE_DATE      THEN      DBMS_SQL.define_column (curid, indx, datevar);
                                                                    ELSE      DBMS_SQL.define_column (curid, indx, namevar, 4000);
      END IF;
    END LOOP;


    WHILE DBMS_SQL.fetch_rows (curid) > 0
    LOOP
      FOR indx IN 1 .. colcnt
      LOOP
        out_values := out_values||'l_'||rec.table_name||'.'||desctab (indx).col_name||' :=';
        IF (desctab (indx).col_type = dbms_types.TYPECODE_VARCHAR or
            desctab (indx).col_type = dbms_types.TYPECODE_VARCHAR2 or
            desctab (indx).col_type = dbms_types.TYPECODE_CHAR )     THEN
          DBMS_SQL.COLUMN_VALUE (curid, indx, namevar);
          out_values := out_values||''''||replace (replace(    namevar  ,'''','''''')  ,chr(13)||chr(10),chr(39)||'||chr(13)||chr(10)||'||chr(39) ) ||'''';
        ELSIF (desctab (indx).col_type = dbms_types.TYPECODE_NUMBER)  THEN
          DBMS_SQL.COLUMN_VALUE (curid, indx, numvar);
          out_values := out_values||nvl(to_char(numvar),'null')||'';
        ELSIF (desctab (indx).col_type = dbms_types.TYPECODE_DATE) THEN
          DBMS_SQL.COLUMN_VALUE (curid, indx, datevar);
          case
           when datevar = trunc(datevar) then  out_values := out_values||'to_date('''||to_char(datevar,'DD.MM.YYYY')||''',''DD.MM.YYYY'')';
           else  out_values := out_values||'to_date('''||to_char(datevar,'DD.MM.YYYY HH24:MI:SS')||''',''DD.MM.YYYY HH24:MI:SS'')';
          end case;
        END IF;
          out_values := out_values||';'||nlchr;
      END LOOP;
          out_values := out_values||nlchr||' p_merge( '|| 'l_'||rec.table_name||');'||nlchr||nlchr||nlchr;
  END LOOP;

   --out_columns :=out_columns||'l_'||rec.table_name||'  '

  out_columns :=out_columns||out_values;


   out_columns :=out_columns||'commit;'||nlchr;
   out_columns :=out_columns||'END;'||nlchr;
   out_columns :=out_columns||'/'||nlchr;
   l_clob := out_columns;
   --dbms_output.put_line( l_clob);
    dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
    dbms_lob.append(l_clob,       rpad(   'PROMPT *** End *** ========== Scripts /Sql/'||rec.owner||'/Data/patch_data_'||rec.table_name||'.sql'||' =========*** End *** ',92,'=') ||nlchr);
    dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);

   return l_clob;
 END LOOP;
END;


Function Script_table_insert(p_table_name varchar2, p_Select varchar2 default null, p_where_clause varchar2 default null, p_owner varchar2 default 'BARS') return clob
as
  cur SYS_REFCURSOR;
  curid NUMBER;
  desctab DBMS_SQL.desc_tab;
  colcnt NUMBER;
  namevar VARCHAR2(4000);
  numvar NUMBER;
  datevar DATE;
  nlchr      char(2) := chr(13)||chr(10);

  l_clob     clob;
  p_clob_scrpt clob;

  out_columns clob;
  out_values  clob;

BEGIN
        p_clob_scrpt:= null;
        l_clob:= null;
       dbms_lob.createtemporary(l_clob,  FALSE);

  FOR rec IN (SELECT table_name , owner
                FROM all_tables
               WHERE table_name LIKE p_table_name
			     and owner = p_owner
               ORDER BY table_name)
  LOOP


       dbms_lob.append(l_clob, ''||nlchr);
    OPEN cur FOR 'SELECT '|| nvl(p_Select,'*') || ' FROM '||rec.owner||'.'||rec.table_name||' where 1 = 1 '||p_where_clause;


   out_columns  := null;
   out_values   := null;
    curid := DBMS_SQL.to_cursor_number(cur);
    DBMS_SQL.describe_columns(curid, colcnt, desctab);

     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);
     dbms_lob.append(l_clob,          rpad('PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_'||rec.table_name||'.sql'||' =========*** Run *** ',92,'=') ||nlchr);
     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr||nlchr);

    out_columns := 'Begin'||nlchr;
    out_columns := out_columns||'   INSERT INTO '||rec.table_name||'(';


    FOR indx IN 1 .. colcnt LOOP
      out_columns := out_columns||desctab(indx).col_name||',';
      IF desctab (indx).col_type = dbms_types.TYPECODE_NUMBER       THEN      DBMS_SQL.define_column (curid, indx, numvar);
      ELSIF desctab (indx).col_type = dbms_types.TYPECODE_DATE      THEN      DBMS_SQL.define_column (curid, indx, datevar);
                                                                    ELSE      DBMS_SQL.define_column (curid, indx, namevar, 4000);
      END IF;
    END LOOP;


    out_columns := rtrim(out_columns,',')||') VALUES (';


    WHILE DBMS_SQL.fetch_rows (curid) > 0
    LOOP
      out_values := '';
      FOR indx IN 1 .. colcnt
      LOOP
        IF (desctab (indx).col_type = dbms_types.TYPECODE_VARCHAR or
            desctab (indx).col_type = dbms_types.TYPECODE_VARCHAR2 or
            desctab (indx).col_type = dbms_types.TYPECODE_CHAR )     THEN
          DBMS_SQL.COLUMN_VALUE (curid, indx, namevar);
          out_values := out_values||''''||replace(namevar,'''','''''')||''',';
        ELSIF (desctab (indx).col_type = dbms_types.TYPECODE_NUMBER)  THEN
          DBMS_SQL.COLUMN_VALUE (curid, indx, numvar);
          out_values := out_values||nvl(to_char(numvar),'null')||',';
        ELSIF (desctab (indx).col_type = dbms_types.TYPECODE_DATE) THEN
          DBMS_SQL.COLUMN_VALUE (curid, indx, datevar);
          case
           when datevar = trunc(datevar) then  out_values := out_values||'to_date('''||to_char(datevar,'DD.MM.YYYY')||''',''DD.MM.YYYY''),';
           else  out_values := out_values||'to_date('''||to_char(datevar,'DD.MM.YYYY HH24:MI:SS')||''',''DD.MM.YYYY HH24:MI:SS''),';
          end case;
        END IF;
      END LOOP;
      dbms_lob.append(l_clob, out_columns);
      dbms_lob.append(l_clob, rtrim(out_values,',')||');'||nlchr);
      --dbms_output.put_line(out_columns||rtrim(out_values,',')||');');
      dbms_lob.append(l_clob, '    exception when dup_val_on_index then null;'||nlchr);
      dbms_lob.append(l_clob, 'end;'||nlchr);
      dbms_lob.append(l_clob, '/'||nlchr);


    END LOOP;


    DBMS_SQL.close_cursor (curid);



    dbms_lob.append(l_clob, 'COMMIT;'||nlchr);
   --DBMS_OUTPUT.put_line('COMMIT;');

    dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
    dbms_lob.append(l_clob,       rpad(   'PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_'||rec.table_name||'.sql'||' =========*** End *** ',92,'=') ||nlchr);
    dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);



  END LOOP;

   return l_clob;
END;


function scripts_reports (p_rep_id number) return clob
 as
       nlchr      char(2) := chr(13)||chr(10);
       l_txt      varchar2(32000);

       l_clob     clob;
       p_clob_scrpt clob;
       l_text1 varchar2(4000);
       l_table_name USER_TAB_PRIVS_MADE.table_name%type;

       l_rep_id bars.reports.id%type;
       l_idf bars.reports.idf%type;
       l_kodz bars.zapros.kodz%type;
       l_pkey bars.zapros.pkey%type;
       l_form int;

       PRAGMA AUTONOMOUS_TRANSACTION;

 begin


        p_clob_scrpt:= null;   l_clob:= null;
       dbms_lob.createtemporary(l_clob,  FALSE);

      select rep_id, idf, kodz, pkey, to_number(substr(param,instr(param,',')+1,instr(substr(param,instr(param,',')+1,10),',')-1)) form
        into l_rep_id, l_idf, l_kodz, l_pkey, l_form
        from bars.V_CBIREP_REPPARAMS
       where rep_id = p_rep_id;

     dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
     dbms_lob.append(l_clob,          rpad('PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/'||replace(l_pkey,chr(92),'_')||'.sql'||' =========*** Run *** ',92,'=') ||nlchr);
     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);



        bars.bars_report.export_to_script(
                                      p_kodz          => l_kodz,
                                      p_repinsert     => 1,
                                      p_repfixid      => l_rep_id,
                                      p_reptype       => l_form,
                                      p_repfolder     => l_idf --,     p_clob_scrpt    => p_clob_scrpt
                                      );
     bars.bars_lob.import_clob(p_clob_scrpt);
     dbms_lob.append(l_clob, p_clob_scrpt||nlchr);
     commit;


    dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
    dbms_lob.append(l_clob,       rpad(   'PROMPT *** End *** ========== Scripts /Sql/Bars/Data/'||replace(l_pkey,chr(92),'_')||'.sql'||' =========*** End *** ',92,'=') ||nlchr);
    dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);
      return l_clob;
 end;

function scripts_bmd(p_table_name varchar2, p_file_name varchar2 ) return clob
 as
 l_clob clob;
begin

for x in ( select tabname from bars.meta_tables where tabname = p_table_name )
LOOP

  BARS_METABASE.import_bmd(x.tabname, p_file_name);
  select file_clob into l_clob from bars.imp_file where file_name = p_file_name;
  return l_clob;

END LOOP;

end;


function scripts_tts(p_tt varchar2) return blob
 as
 l_blob blob;
begin

for x in ( select tt from bars.tts where tt = p_tt )
LOOP

   bars.bars_ttsadm.SG_ExportOpers(x.tt,2047,0);
   select bars.bars_ttsadm.bl into l_blob from dual;
   return l_blob;


END LOOP;

end;


END PACK_SCRIPT;
/

GRANT EXECUTE ON SYS.PACK_SCRIPT TO BARS_ACCESS_DEFROLE;
