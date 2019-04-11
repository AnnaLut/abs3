PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Table/ACTIVITY_DEPENDENCY.sql ===== *** Run *** 
PROMPT ===================================================================================== 

BEGIN 
   execute immediate  
      'begin  
          bpa.alter_policy_info(''ACTIVITY_DEPENDENCY'', ''CENTER'' , null, null, null, null);
          bpa.alter_policy_info(''ACTIVITY_DEPENDENCY'', ''FILIAL'' , null, null, null, null);
          bpa.alter_policy_info(''ACTIVITY_DEPENDENCY'', ''WHOLE'' , null, null, null, null);
          null;
       end; 
      '; 
END; 
/

PROMPT *** Create  table ACTIVITY_DEPENDENCY ***
begin 
   execute immediate '
   CREATE TABLE ACTIVITY_DEPENDENCY  
   (
      primary_activity_id   NUMBER(38) not null,
      following_activity_id NUMBER(38) not null
   ) SEGMENT CREATION IMMEDIATE 
   PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
   NOCOMPRESS LOGGING
   TABLESPACE BRSMDLD ';
exception when others then       
   if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to ACTIVITY_DEPENDENCY ***
exec bpa.alter_policies('ACTIVITY_DEPENDENCY');

COMMENT ON TABLE  BARS.ACTIVITY_DEPENDENCY                           IS 'Залежність кроків процесу';
COMMENT ON COLUMN BARS.ACTIVITY_DEPENDENCY.PRIMARY_ACTIVITY_ID   IS 'Головний крок';
COMMENT ON COLUMN BARS.ACTIVITY_DEPENDENCY.FOLLOWING_ACTIVITY_ID IS 'Наступний крок';

PROMPT *** Create unique index UIX_ACTIVITY_DEPENDENCY ***
begin   
   execute immediate '
   create unique index UIX_ACTIVITY_DEPENDENCY on ACTIVITY_DEPENDENCY (PRIMARY_ACTIVITY_ID, FOLLOWING_ACTIVITY_ID)
   PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
   TABLESPACE BRSMDLI ';
exception when others then
   if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** Create index IDX_ACTIVITY_DEPENDENCT_FOLLOW ***
begin   
   execute immediate '
   create index IDX_ACTIVITY_DEPENDENCT_FOLLOW on ACTIVITY_DEPENDENCY (FOLLOWING_ACTIVITY_ID)
   PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
   TABLESPACE BRSMDLI ';
exception when others then
   if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** Create  grants  ACTIVITY_DEPENDENCY ***
grant SELECT, INSERT, UPDATE, DELETE on ACTIVITY_DEPENDENCY to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Table/ACTIVITY_DEPENDENCY.sql ===== *** End ***
PROMPT ===================================================================================== 
