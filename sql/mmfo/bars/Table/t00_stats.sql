prompt =====================================================================================  
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/t00_stats.sql  =========*** Run *** =======
PROMPT ===================================================================================== 


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''t00_stats'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''t00_stats'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''t00_stats'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/




begin 
  execute immediate '
       create table bars.t00_stats
       (   id            number,
           kf            varchar2(6),  
           report_date   date,
           stat_id       number,  
           amount        number,  
           ref_list      varchar2(2000)
       ) tablespace brsmdld';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

comment on table bars.t00_stats is 'Сбор статистик по транзитам РУ';


begin   
 execute immediate 'ALTER TABLE bars.t00_stats  ADD CONSTRAINT xpk_t00stats_kfdat unique (kf, report_date, stat_id)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


begin   
 execute immediate 'ALTER TABLE bars.t00_stats  ADD CONSTRAINT xpk_t00stats PRIMARY KEY (id) using index TABLESPACE BRSSMLI';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


begin   
 execute immediate 'ALTER TABLE bars.t00_stats  ADD CONSTRAINT xfk_t00stats_desc foreign KEY (stat_id)  REFERENCES BARS.t00_stats_desc (id) ENABLE NOVALIDATE'; 
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


/*
  FOR TESTCASES

delete from t00_stats where report_date  = to_date('190218','ddmmyy')

begin 
insert into t00_stats values (1, '322669' , to_date('140318','ddmmyy') ,1,  23456,  null  );
insert into t00_stats values (2, '322669' , to_date('140318','ddmmyy') ,2,  2345,   null  );
insert into t00_stats values (3, '322669' , to_date('140318','ddmmyy') ,3,  2465,   null  );
insert into t00_stats values (4, '322669' , to_date('140318','ddmmyy') ,4,  24565,  null  );
insert into t00_stats values (5, '322669' , to_date('140318','ddmmyy') ,5,  234565, null  );
insert into t00_stats values (6, '322669' , to_date('140318','ddmmyy') ,6,  134565, null  );
insert into t00_stats values (7, '322669' , to_date('140318','ddmmyy') ,7,  124565, null  );
insert into t00_stats values (8, '322669' , to_date('140318','ddmmyy') ,8,  134565, null  );
insert into t00_stats values (9, '322669' , to_date('140318','ddmmyy') ,9,  144565, null  );
insert into t00_stats values (21, '322669' , to_date('140318','ddmmyy') ,11,  45, null  );
insert into t00_stats values (22, '322669' , to_date('140318','ddmmyy') ,13,  11, null  );
insert into t00_stats values (23, '322669' , to_date('140318','ddmmyy') ,20,  1345, null  );
insert into t00_stats values (10, '322669', to_date('140318','ddmmyy') ,10, 65,     null  );
insert into t00_stats values (11, '300465', to_date('140318','ddmmyy') ,1,  8456,   null  );
insert into t00_stats values (12, '300465', to_date('140318','ddmmyy') ,2,  8345,   null  );
insert into t00_stats values (13, '300465', to_date('140318','ddmmyy') ,3,  8465,   null  );
insert into t00_stats values (14, '300465', to_date('140318','ddmmyy') ,4,  84565,  null  );
insert into t00_stats values (15, '300465', to_date('140318','ddmmyy') ,5,  834565, null  );
insert into t00_stats values (16, '300465', to_date('140318','ddmmyy') ,6,  834565, null  );
insert into t00_stats values (17, '300465', to_date('140318','ddmmyy') ,7,  824565, null  );
insert into t00_stats values (18, '300465', to_date('140318','ddmmyy') ,8,  834565, null  );
insert into t00_stats values (19, '300465', to_date('140318','ddmmyy') ,9,  844565, null  );
insert into t00_stats values (20, '300465', to_date('140318','ddmmyy') ,10, 965,    null  );
insert into t00_stats values (24, '300465', to_date('140318','ddmmyy') ,11,  834565, null  );
insert into t00_stats values (25, '300465', to_date('140318','ddmmyy') ,12,  844565, null  );
insert into t00_stats values (26, '300465', to_date('140318','ddmmyy') ,13, 465,    null  );
insert into t00_stats values (27, '300465', to_date('140318','ddmmyy') ,14, 565,    null  );
insert into t00_stats values (28, '300465', to_date('140318','ddmmyy') ,15, 665,    null  );
insert into t00_stats values (29, '300465', to_date('140318','ddmmyy') ,16, 75,    null  );
insert into t00_stats values (30, '300465', to_date('140318','ddmmyy') ,17, 965,    null  );
insert into t00_stats values (31, '300465', to_date('140318','ddmmyy') ,18, 65,    null  );
insert into t00_stats values (32, '300465', to_date('140318','ddmmyy') ,19, 965,    null  );
end;



begin 
insert into t00_stats values (21, '322669' , to_date('140318','ddmmyy') ,11,  45, null  );
insert into t00_stats values (22, '322669' , to_date('140318','ddmmyy') ,13,  11, null  );
insert into t00_stats values (23, '322669' , to_date('140318','ddmmyy') ,20,  1345, null  );
insert into t00_stats values (24, '300465', to_date('140318','ddmmyy') ,11,  834565, null  );
insert into t00_stats values (25, '300465', to_date('140318','ddmmyy') ,12,  844565, null  );
insert into t00_stats values (26, '300465', to_date('140318','ddmmyy') ,13, 465,    null  );
insert into t00_stats values (27, '300465', to_date('140318','ddmmyy') ,14, 565,    null  );
insert into t00_stats values (28, '300465', to_date('140318','ddmmyy') ,15, 665,    null  );
insert into t00_stats values (29, '300465', to_date('140318','ddmmyy') ,16, 75,    null  );
insert into t00_stats values (30, '300465', to_date('140318','ddmmyy') ,17, 965,    null  );
insert into t00_stats values (31, '300465', to_date('140318','ddmmyy') ,18, 65,    null  );
insert into t00_stats values (32, '300465', to_date('140318','ddmmyy') ,19, 965,    null  );
end;


insert into t00_stats values (11, '322669', trunc(sysdate-1),1, 15, null  );
insert into t00_stats values (12, '322669', trunc(sysdate-1),2, 25, null  );
insert into t00_stats values (13, '322669', trunc(sysdate-1),3, 35, null  );
insert into t00_stats values (14, '322669', trunc(sysdate-1),4, 45, null  );
insert into t00_stats values (15, '322669', trunc(sysdate-1),5, 55, null  );
insert into t00_stats values (16, '322669', trunc(sysdate-1),6, 65, null  );
insert into t00_stats values (17, '322669', trunc(sysdate-1),7, 655, null  );
insert into t00_stats values (18, '322669', trunc(sysdate-1),8, 75, null  );
insert into t00_stats values (19, '322669', trunc(sysdate-1),9, 865, null  );
insert into t00_stats values (20, '322669', trunc(sysdate-1),10, 965, null  );
end;

*/



