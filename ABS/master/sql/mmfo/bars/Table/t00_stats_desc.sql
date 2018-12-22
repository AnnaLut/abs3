prompt ========================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/t00_stats_desc.sql  =========*** Run *** =======
PROMPT ===================================================================================== 





BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''t00_stats_desc'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''t00_stats_desc'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''t00_stats_desc'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/



begin 
  execute immediate '
       create table bars.t00_stats_desc 
       (  id                 number, 
          stat_type_id       number,
          stat_type     varchar2(15),
          stat_id_desc  varchar2(1000)
       ) tablespace brssmld';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

comment on table  bars.t00_stats_desc is 'Описание статистик по T00';



begin   
 execute immediate 'ALTER TABLE bars.t00_stats_desc  ADD CONSTRAINT xpk_t00statsdesc PRIMARY KEY (id) using index TABLESPACE BRSSMLI';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


begin   
 execute immediate 'ALTER TABLE bars.t00_stats_desc  ADD CONSTRAINT xuk_t00statsdesc unique (stat_type_id, stat_type)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/
