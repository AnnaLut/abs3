

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_LOCKSALDO.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_LOCKSALDO ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_LOCKSALDO ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_LOCKSALDO 
   (	NLS VARCHAR2(25), 
	GROUP_U NUMBER(11,0), 
	I_VA NUMBER(11,0), 
	MOTIVE NUMBER(11,0), 
	DALOCK DATE, 
	DOCLOCK VARCHAR2(100), 
	DADOCLOCK DATE, 
	ISP_LOCK NUMBER(11,0), 
	DAUNLOCK DATE, 
	DOCUNLOCK VARCHAR2(100), 
	DADOCUNLOC DATE, 
	ISP_UNLOCK NUMBER(11,0), 
	DAAUTOUNLO DATE, 
	SUMLOCK NUMBER(18,2), 
	D_MODIFY DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S6_LOCKSALDO ***
 exec bpa.alter_policies('S6_S6_LOCKSALDO');


COMMENT ON TABLE BARS.S6_S6_LOCKSALDO IS '';
COMMENT ON COLUMN BARS.S6_S6_LOCKSALDO.NLS IS '';
COMMENT ON COLUMN BARS.S6_S6_LOCKSALDO.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_S6_LOCKSALDO.I_VA IS '';
COMMENT ON COLUMN BARS.S6_S6_LOCKSALDO.MOTIVE IS '';
COMMENT ON COLUMN BARS.S6_S6_LOCKSALDO.DALOCK IS '';
COMMENT ON COLUMN BARS.S6_S6_LOCKSALDO.DOCLOCK IS '';
COMMENT ON COLUMN BARS.S6_S6_LOCKSALDO.DADOCLOCK IS '';
COMMENT ON COLUMN BARS.S6_S6_LOCKSALDO.ISP_LOCK IS '';
COMMENT ON COLUMN BARS.S6_S6_LOCKSALDO.DAUNLOCK IS '';
COMMENT ON COLUMN BARS.S6_S6_LOCKSALDO.DOCUNLOCK IS '';
COMMENT ON COLUMN BARS.S6_S6_LOCKSALDO.DADOCUNLOC IS '';
COMMENT ON COLUMN BARS.S6_S6_LOCKSALDO.ISP_UNLOCK IS '';
COMMENT ON COLUMN BARS.S6_S6_LOCKSALDO.DAAUTOUNLO IS '';
COMMENT ON COLUMN BARS.S6_S6_LOCKSALDO.SUMLOCK IS '';
COMMENT ON COLUMN BARS.S6_S6_LOCKSALDO.D_MODIFY IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_LOCKSALDO.sql =========*** End *
PROMPT ===================================================================================== 
