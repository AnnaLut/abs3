

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_PROBLEM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_PROBLEM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_PROBLEM'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CCK_PROBLEM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_PROBLEM ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_PROBLEM 
   (	CODE VARCHAR2(2), 
	PROBLEM VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_PROBLEM ***
 exec bpa.alter_policies('CCK_PROBLEM');


COMMENT ON TABLE BARS.CCK_PROBLEM IS 'Відношення кредиту до проблемного (код типу проблемної заборгованості)';
COMMENT ON COLUMN BARS.CCK_PROBLEM.CODE IS 'Код';
COMMENT ON COLUMN BARS.CCK_PROBLEM.PROBLEM IS 'Відношення кредиту до проблемного';



PROMPT *** Create  grants  CCK_PROBLEM ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_PROBLEM     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_PROBLEM     to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_PROBLEM.sql =========*** End *** =
PROMPT ===================================================================================== 
