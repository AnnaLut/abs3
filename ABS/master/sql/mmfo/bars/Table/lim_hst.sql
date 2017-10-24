

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LIM_HST.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LIM_HST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LIM_HST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''LIM_HST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''LIM_HST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LIM_HST ***
begin 
  execute immediate '
  CREATE TABLE BARS.LIM_HST 
   (	ACC NUMBER(*,0), 
	DAT DATE, 
	OSTF NUMBER(24,0), 
	LIM NUMBER(24,0), 
	LOGNAME VARCHAR2(8)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LIM_HST ***
 exec bpa.alter_policies('LIM_HST');


COMMENT ON TABLE BARS.LIM_HST IS '';
COMMENT ON COLUMN BARS.LIM_HST.ACC IS '';
COMMENT ON COLUMN BARS.LIM_HST.DAT IS '';
COMMENT ON COLUMN BARS.LIM_HST.OSTF IS '';
COMMENT ON COLUMN BARS.LIM_HST.LIM IS '';
COMMENT ON COLUMN BARS.LIM_HST.LOGNAME IS '';



PROMPT *** Create  grants  LIM_HST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on LIM_HST         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on LIM_HST         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LIM_HST.sql =========*** End *** =====
PROMPT ===================================================================================== 
