

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STRU2.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STRU2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STRU2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STRU2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STRU2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STRU2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.STRU2 
   (	TYPE CHAR(8), 
	R020 CHAR(9), 
	OB22 CHAR(8), 
	TXT VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STRU2 ***
 exec bpa.alter_policies('STRU2');


COMMENT ON TABLE BARS.STRU2 IS '';
COMMENT ON COLUMN BARS.STRU2.TYPE IS '';
COMMENT ON COLUMN BARS.STRU2.R020 IS '';
COMMENT ON COLUMN BARS.STRU2.OB22 IS '';
COMMENT ON COLUMN BARS.STRU2.TXT IS '';



PROMPT *** Create  grants  STRU2 ***
grant SELECT                                                                 on STRU2           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STRU2           to BARS_DM;
grant SELECT                                                                 on STRU2           to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on STRU2           to STRU2;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STRU2           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STRU2.sql =========*** End *** =======
PROMPT ===================================================================================== 
