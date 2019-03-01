PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RESULT_COMPARISON_601_REZ.sql =========*** Run *** ==
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to RESULT_COMPARISON_601_REZ ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RESULT_COMPARISON_601_REZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RESULT_COMPARISON_601_REZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RESULT_COMPARISON_601_REZ *** 
begin  
execute immediate '
create table RESULT_COMPARISON_601_REZ(
okpo VARCHAR2(14),
rnk number(38),
nd number(30),
kv varchar2(3),
sum_all_cr number(32),
sum_all_601 number(32),
difference number(32),
kf varchar2(6 char)) 
  SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to RESULT_COMPARISON_601_REZ ***
 exec bpa.alter_policies('RESULT_COMPARISON_601_REZ');

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RESULT_COMPARISON_601_REZ.sql =========*** End *** ==
PROMPT ===================================================================================== 
