

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STRU2A.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STRU2A ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STRU2A'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STRU2A'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STRU2A'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STRU2A ***
begin 
  execute immediate '
  CREATE TABLE BARS.STRU2A 
   (	TYPE CHAR(9), 
	R020 CHAR(8), 
	OB22 CHAR(6), 
	TXT VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STRU2A ***
 exec bpa.alter_policies('STRU2A');


COMMENT ON TABLE BARS.STRU2A IS '';
COMMENT ON COLUMN BARS.STRU2A.TYPE IS '';
COMMENT ON COLUMN BARS.STRU2A.R020 IS '';
COMMENT ON COLUMN BARS.STRU2A.OB22 IS '';
COMMENT ON COLUMN BARS.STRU2A.TXT IS '';



PROMPT *** Create  grants  STRU2A ***
grant SELECT                                                                 on STRU2A          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STRU2A          to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on STRU2A          to STRU2A;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STRU2A          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STRU2A.sql =========*** End *** ======
PROMPT ===================================================================================== 
