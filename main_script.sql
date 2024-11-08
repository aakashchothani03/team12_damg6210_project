-- USER TABLE cleanup with creation 
SET SERVEROUTPUT ON;
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM USER_TABLES
    WHERE TABLE_NAME = 'USERS';
    
    IF ROWS_COUNT > 0 THEN 
        EXECUTE IMMEDIATE 'DROP TABLE USERS CASCADE CONSTRAINTS';
        dbms_output.put_line('Table "USERS" dropped.');
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE TABLE USERS (
        USER_ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        FIRSTNAME VARCHAR2(50) NOT NULL,
        LASTNAME VARCHAR2(50) NOT NULL,
        EMAIL VARCHAR2(70) UNIQUE NOT NULL,
        USERNAME VARCHAR2(50) UNIQUE NOT NULL,
        PASSWORD VARCHAR2(50) NOT NULL,
        IS_ACTIVE NUMBER(1) DEFAULT 1 CHECK (IS_ACTIVE IN (0, 1))
    )';
    dbms_output.put_line('Table "USERS" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/


-- ADDRESS TABLE cleanup with creation
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM USER_TABLES
    WHERE TABLE_NAME = 'ADDRESS';
    
    IF ROWS_COUNT > 0 THEN 
        EXECUTE IMMEDIATE 'DROP TABLE ADDRESS CASCADE CONSTRAINTS';
        dbms_output.put_line('Table "ADDRESS" dropped.');
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE TABLE ADDRESS (
        ADDRESS_ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        STREET1 VARCHAR2(100) NOT NULL,
        STREET2 VARCHAR2(100),
        CITY VARCHAR2(40) NOT NULL,
        COUNTY VARCHAR2(50),
        STATE VARCHAR2(50) NOT NULL,
        ZIPCODE VARCHAR2(50),
        COUNTRY VARCHAR2(50) NOT NULL
    )';
    dbms_output.put_line('Table "ADDRESS" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/


-- CANDIDATE table cleanup with creation
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM USER_TABLES
    WHERE TABLE_NAME = 'CANDIDATES';
    
    IF ROWS_COUNT > 0 THEN 
        EXECUTE IMMEDIATE 'DROP TABLE CANDIDATES CASCADE CONSTRAINTS';
        dbms_output.put_line('Table "CANDIDATES" dropped.');
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE TABLE CANDIDATES (
        CANDIDATE_ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        USER_ID NUMBER NOT NULL,
        ADD_ID NUMBER NOT NULL,
        PHONE VARCHAR2(15),
        AGE NUMBER(2),
        GENDER VARCHAR2(15),
        VETERAN VARCHAR2(100),
        DISABILITY VARCHAR2(100),
        DATE_OF_JOIN TIMESTAMP WITH LOCAL TIME ZONE DEFAULT SYSDATE NOT NULL,
        FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
        FOREIGN KEY (ADD_ID) REFERENCES ADDRESS(ADDRESS_ID),
        CONSTRAINT CHK_AGE CHECK (AGE > 16),
        CONSTRAINT CHK_GENDER CHECK (GENDER IN (''male'', ''female'')),
        CONSTRAINT CHK_VET_STATUS CHECK (VETERAN IN (''do not wish to disclose'', ''not a veteran'', ''I am a protected veteran'')),
        CONSTRAINT CHK_DISABILITY CHECK (DISABILITY IN (''do not wish to disclose'', ''no, i do not have a disability'', ''yes, I have a disability''))
    )';
    dbms_output.put_line('Table "CANDIDATES" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/


-- WORK EXPERIENCE cleanup with creation - Candidate's Work Experience
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM USER_TABLES
    WHERE TABLE_NAME = 'WORK_EXP';
    
    IF ROWS_COUNT > 0 THEN 
        EXECUTE IMMEDIATE 'DROP TABLE WORK_EXP CASCADE CONSTRAINTS';
        dbms_output.put_line('Table "WORK_EXP" dropped.');
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE TABLE WORK_EXP (
        WORK_EXP_ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        CANDIDATE_ID NUMBER NOT NULL,
        COMPANY_NAME VARCHAR2(100) NOT NULL,
        JOB_TITLE VARCHAR2(100) NOT NULL,
        START_DATE TIMESTAMP WITH LOCAL TIME ZONE,
        END_DATE TIMESTAMP WITH LOCAL TIME ZONE,
        DESCRIPTION VARCHAR2(2000),
        FOREIGN KEY (CANDIDATE_ID) REFERENCES CANDIDATES(CANDIDATE_ID)
    )';
    dbms_output.put_line('Table "WORK_EXP" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/


-- EDUCATION table cleanup with creation
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM USER_TABLES
    WHERE TABLE_NAME = 'EDUCATION';
     
    IF ROWS_COUNT > 0 THEN 
        EXECUTE IMMEDIATE 'DROP TABLE EDUCATION CASCADE CONSTRAINTS';
        dbms_output.put_line('Table "EDUCATION" dropped.');
    END IF;
        
    EXECUTE IMMEDIATE 'CREATE TABLE EDUCATION (
        EDUCATION_ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        CANDIDATE_ID NUMBER NOT NULL,
        UNIVERSITY_NAME VARCHAR2(150) NOT NULL,
        DEGREE VARCHAR2(50) NOT NULL,
        MAJOR VARCHAR2(100),
        START_DATE TIMESTAMP WITH LOCAL TIME ZONE,
        END_DATE TIMESTAMP WITH LOCAL TIME ZONE,
        DEGREE_COMPLETED NUMBER(1) DEFAULT 1 CHECK (DEGREE_COMPLETED IN (0,1)) ,
        FOREIGN KEY (CANDIDATE_ID) REFERENCES CANDIDATES(CANDIDATE_ID)
    )';
    dbms_output.put_line('Table "EDUCATION" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/


-- RESUME table creation
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM USER_TABLES
    WHERE TABLE_NAME = 'RESUME';
    
    IF ROWS_COUNT > 0 THEN 
        EXECUTE IMMEDIATE 'DROP TABLE RESUME CASCADE CONSTRAINTS';
        dbms_output.put_line('Table "RESUME" dropped.');
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE TABLE RESUME (
        RESUME_ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        CANDIDATE_ID NUMBER NOT NULL,
        RES_DOC BLOB NOT NULL,
        DATE_UPLOADED TIMESTAMP WITH LOCAL TIME ZONE DEFAULT SYSDATE NOT NULL,
        DESCRIPTION VARCHAR2(50),
        FOREIGN KEY (CANDIDATE_ID) REFERENCES CANDIDATES(CANDIDATE_ID)
    )';
    dbms_output.put_line('Table "RESUME" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/


-- SKILLS table creation - all the skills present on the platform
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM USER_TABLES
    WHERE TABLE_NAME = 'SKILLS';
    
    IF ROWS_COUNT > 0 THEN 
        EXECUTE IMMEDIATE 'DROP TABLE SKILLS CASCADE CONSTRAINTS';
        dbms_output.put_line('Table "SKILLS" dropped.');
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE TABLE SKILLS (
        SKILL_ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        SKILL_NAME VARCHAR2(100) UNIQUE NOT NULL
    )';
    dbms_output.put_line('Table "SKILLS" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/


-- CANDIDATE SKILLS Join Table
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM USER_TABLES
    WHERE TABLE_NAME = 'CANDIDATE_SKILLS';

    IF ROWS_COUNT > 0 THEN 
        EXECUTE IMMEDIATE 'DROP TABLE CANDIDATE_SKILLS CASCADE CONSTRAINTS';
        dbms_output.put_line('Table "CANDIDATE_SKILLS" dropped.');
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE TABLE CANDIDATE_SKILLS (
        CAN_SKILL_ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        CANDIDATE_ID NUMBER NOT NULL,
        SKILL_ID NUMBER NOT NULL,
        FOREIGN KEY (CANDIDATE_ID) REFERENCES CANDIDATES(CANDIDATE_ID),
        FOREIGN KEY (SKILL_ID) REFERENCES SKILLS(SKILL_ID),
        CONSTRAINT UN_CAN_SKILL UNIQUE(CANDIDATE_ID, SKILL_ID)
    )';
    dbms_output.put_line('Table "CANDIDATE_SKILLS" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/


-- COMPANY table cleanup with creation
DECLARE ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM USER_TABLES
    WHERE TABLE_NAME = 'COMPANIES';
    
    IF ROWS_COUNT > 0 THEN 
        EXECUTE IMMEDIATE 'DROP TABLE COMPANIES CASCADE CONSTRAINTS';
        dbms_output.put_line('Table "COMPANIES" dropped.');
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE TABLE COMPANIES (
        COMPANY_ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        ADD_ID NUMBER,
        NAME VARCHAR2(50) NOT NULL UNIQUE,
        EMAIL VARCHAR2(50) NOT NULL,
        PHONE VARCHAR2(15) NOT NULL,
        IS_ACTIVE NUMBER(1) DEFAULT 1 CHECK (IS_ACTIVE IN (0,1)),
        FOREIGN KEY (ADD_ID) REFERENCES ADDRESS(ADDRESS_ID)
    )';
    dbms_output.put_line('Table "COMPANIES" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/


-- RECRUITER table cleanup with creation
DECLARE 
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM USER_TABLES
    WHERE TABLE_NAME = 'RECRUITERS';
    
    IF ROWS_COUNT > 0  THEN 
        EXECUTE IMMEDIATE 'DROP TABLE RECRUITERS CASCADE CONSTRAINTS';
        dbms_output.put_line('Table "RECRUITERS" dropped.');
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE TABLE RECRUITERS (
        RECRUITER_ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        USER_ID NUMBER NOT NULL,
        COMPANY_ID NUMBER NOT NULL,
        FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
        FOREIGN KEY (COMPANY_ID) REFERENCES COMPANIES(COMPANY_ID),
        CONSTRAINT UN_REC_COM UNIQUE (USER_ID, COMPANY_ID)
    )';
    dbms_output.put_line('Table "RECRUITERS" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/


-- JOB REQUISITION table creation
DECLARE 
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM USER_TABLES
    WHERE TABLE_NAME = 'JOB_REQUISITION';
    
     IF ROWS_COUNT > 0 THEN 
        EXECUTE IMMEDIATE 'DROP TABLE JOB_REQUISITION CASCADE CONSTRAINTS';
        dbms_output.put_line('Table "JOB_REQUISITION" dropped.');
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE TABLE JOB_REQUISITION (
        REQ_ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        COMPANY_ID NUMBER NOT NULL,
        RECRUITER_ID NUMBER NOT NULL,
        JOB_TITLE VARCHAR2(100) NOT NULL,
        JOB_DESCRIPTION VARCHAR2(5000) NOT NULL,
        DATE_POSTED TIMESTAMP WITH LOCAL TIME ZONE DEFAULT SYSDATE NOT NULL,
        APPLICATION_DEADLINE TIMESTAMP WITH LOCAL TIME ZONE,
        EXPECTED_START_DATE TIMESTAMP WITH LOCAL TIME ZONE,
        RELOCATION_ALLOWANCE NUMBER(1) DEFAULT 1 CHECK(RELOCATION_ALLOWANCE IN (0,1)),
        STATUS VARCHAR2(20) NOT NULL,
        FOREIGN KEY (COMPANY_ID) REFERENCES COMPANIES(COMPANY_ID),
        FOREIGN KEY (RECRUITER_ID) REFERENCES RECRUITERS(RECRUITER_ID),
        CONSTRAINT CHK_JOB_REQ_STATUS CHECK (STATUS IN (''cancelled'', ''closed'', ''open''))
    )';
    dbms_output.put_line('Table "JOB_REQUISITION" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/


-- CANDIDATE APPLICATION Join Table cleanup with creation
DECLARE 
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM USER_TABLES
    WHERE TABLE_NAME = 'CANDIDATE_APPLICATION';
    
    IF ROWS_COUNT > 0 THEN 
        EXECUTE IMMEDIATE 'DROP TABLE CANDIDATE_APPLICATION CASCADE CONSTRAINTS';
        dbms_output.put_line('Table "CANDIDATE_APPLICATION" dropped.');
    END IF;
    
    EXECUTE IMMEDIATE 'CREATE TABLE CANDIDATE_APPLICATION (
        CAN_APP_ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        CANDIDATE_ID NUMBER NOT NULL,
        REQ_ID NUMBER NOT NULL,
        DATE_APPLIED TIMESTAMP WITH LOCAL TIME ZONE DEFAULT SYSDATE NOT NULL,
        STATUS VARCHAR2(30) NOT NULL,
        WILLING_TO_RELOCATE NUMBER(1) DEFAULT 1 CHECK (WILLING_TO_RELOCATE IN (0,1)),
        FOREIGN KEY (CANDIDATE_ID) REFERENCES CANDIDATES(CANDIDATE_ID),
        FOREIGN KEY (REQ_ID) REFERENCES JOB_REQUISITION(REQ_ID),
        CONSTRAINT UN_CAN_REQ UNIQUE (CANDIDATE_ID, REQ_ID),
        CONSTRAINT CHK_CAN_APP_STATUS CHECK (STATUS IN (''candidate rejected'', ''in review'', ''offer accepted'', ''offer rejected'', 
        ''requisition closed/ transfered'', ''role offered'', ''submitted'', ''withdrawn''))
    )';
    dbms_output.put_line('Table "CANDIDATE_APPLICATION" created successfully.');
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/