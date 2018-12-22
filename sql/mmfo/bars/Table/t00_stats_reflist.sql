prompt ==================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/t00_stats_reflist.sql  =========*** Run *** =======
PROMPT ===================================================================================== 



BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''t00_stats_reflist'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''t00_stats_reflist'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''t00_stats_reflist'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/



begin 
  execute immediate '
     create table bars.t00_stats_reflist
       (   id             number, 
           ref            number,  
             CONSTRAINT xpk_t00statsreflist PRIMARY KEY (id, ref)    
       ) ORGANIZATION INDEX  tablespace brsmdld';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

comment on table bars.t00_stats is 'Расшифровка по-документно статистики по транзиту';


begin   
 execute immediate 'ALTER TABLE bars.t00_stats_reflist  ADD CONSTRAINT xfk_t00statsrefs foreign KEY (id)  REFERENCES BARS.t00_stats (id) ENABLE NOVALIDATE'; 
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


