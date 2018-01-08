

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STRU3A.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STRU3A ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STRU3A'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STRU3A'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STRU3A'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STRU3A ***
begin 
  execute immediate '
  CREATE TABLE BARS.STRU3A 
   (	TYPE CHAR(7), 
	R020 CHAR(8), 
	OB22 CHAR(8), 
	TXT VARCHAR2(206)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STRU3A ***
 exec bpa.alter_policies('STRU3A');


COMMENT ON TABLE BARS.STRU3A IS '';
COMMENT ON COLUMN BARS.STRU3A.TYPE IS '';
COMMENT ON COLUMN BARS.STRU3A.R020 IS '';
COMMENT ON COLUMN BARS.STRU3A.OB22 IS '';
COMMENT ON COLUMN BARS.STRU3A.TXT IS '';



PROMPT *** Create  grants  STRU3A ***
grant SELECT                                                                 on STRU3A          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STRU3A          to BARS_DM;
grant SELECT                                                                 on STRU3A          to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on STRU3A          to STRU3A;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STRU3A          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STRU3A.sql =========*** End *** ======
PROMPT ===================================================================================== 
