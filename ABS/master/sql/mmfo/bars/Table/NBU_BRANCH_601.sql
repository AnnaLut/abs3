PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBU_BRANCH_601.sql =========*** Run *** 
PROMPT ===================================================================================== 


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBU_BRANCH_601'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBU_BRANCH_601'', ''WHOLE'' , null, null, null, null);
           end; 
	 '; 
END; 
/

PROMPT *** Create  table NBU_BRANCH_601 ***
begin 
    execute immediate
    'create table NBU_BRANCH_601
    (
    kf               VARCHAR2(6 CHAR) not null,
    branch_name      VARCHAR2(4000) not null,
    is_internal      NUMBER(1) not null,
    service_base_url VARCHAR2(4000),
    service_auth     VARCHAR2(4000),
    region_code      VARCHAR2(2 CHAR),
    is_active        NUMBER(1)
      )
    TABLESPACE BRSMDLD';
  exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

exec bpa.alter_policies('NBU_BRANCH_601');

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index UIX_NBU_BRANCH_601 on NBU_BRANCH_601 (KF)';
exception
    when name_already_used then
         null;
 end;
/


grant all on NBU_BRANCH_601 to BARS_ACCESS_DEFROLE;


PROMPT ===================================================================================== 
PROMPT *** END *** ========== Scripts /Sql/BARS/Table/NBU_BRANCH_601.sql =========*** END *** 
PROMPT ===================================================================================== 

