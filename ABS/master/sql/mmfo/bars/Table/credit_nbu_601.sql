PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CREDIT_NBU_601.sql =========*** Run *** ==
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to CREDIT_NBU_601 ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CREDIT_NBU_601'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CREDIT_NBU_601'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CREDIT_NBU_601 ***
begin 
execute immediate '
create table CREDIT_NBU_601(
okpo VARCHAR2(14),
rnk number(38),
nd number(30),
kv varchar2(3),
sum_all number(32),
kf varchar2(6 char)) 
  SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to CREDIT_NBU_601 ***
 exec bpa.alter_policies('CREDIT_NBU_601');

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CREDIT_NBU_601.sql =========*** End *** ==
PROMPT ===================================================================================== 
